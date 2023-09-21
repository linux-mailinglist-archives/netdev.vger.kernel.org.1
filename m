Return-Path: <netdev+bounces-35591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 750467A9D71
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B2CB21033
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536091803A;
	Thu, 21 Sep 2023 19:37:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D017991
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:36:58 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4DB19E;
	Thu, 21 Sep 2023 12:36:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBC0BFF805;
	Thu, 21 Sep 2023 19:36:51 +0000 (UTC)
Message-ID: <8418e275-7d9a-56b7-0b3f-11f4ddcaaa7b@ovn.org>
Date: Thu, 21 Sep 2023 21:37:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
 Eelco Chaudron <echaudro@redhat.com>
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
References: <20230921190429.1970766-1-i.maximets@ovn.org>
 <CANn89iJeAFBKF=5=VjO4pZWT0-o5GrTZhZvDD4OGBt5U27P+LA@mail.gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH net-next] openvswitch: reduce stack usage in
 do_execute_actions
In-Reply-To: <CANn89iJeAFBKF=5=VjO4pZWT0-o5GrTZhZvDD4OGBt5U27P+LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 21:08, Eric Dumazet wrote:
> On Thu, Sep 21, 2023 at 9:03 PM Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> do_execute_actions() function can be called recursively multiple
>> times while executing actions that require pipeline forking or
>> recirculations.  It may also be re-entered multiple times if the packet
>> leaves openvswitch module and re-enters it through a different port.
>>
>> Currently, there is a 256-byte array allocated on stack in this
>> function that is supposed to hold NSH header.  Compilers tend to
>> pre-allocate that space right at the beginning of the function:
>>
>>      a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp
>>
>> NSH is not a very common protocol, but the space is allocated on every
>> recursive call or re-entry multiplying the wasted stack space.
>>
>> Move the stack allocation to push_nsh() function that is only used
>> if NSH actions are actually present.  push_nsh() is also a simple
>> function without a possibility for re-entry, so the stack is returned
>> right away.
>>
>> With this change the preallocated space is reduced by 256 B per call:
>>
>>      b18:       48 81 ec b0 00 00 00    sub    $0xb0,%rsp
>>
>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>> ---
>>  net/openvswitch/actions.c | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 5f8094acd056..80cc5c512d7b 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -312,10 +312,16 @@ static int push_eth(struct sk_buff *skb, struct sw_flow_key *key,
>>  }
>>
>>  static int push_nsh(struct sk_buff *skb, struct sw_flow_key *key,
>> -                   const struct nshhdr *nh)
>> +                   const struct nlattr *a)
> 
> Presumably this function should be inlined. (one caller only)
> 
> I would add noinline_for_stack to make sure the compiler will not play
> games with this attempt.

Yeah, good point!  I didn't see it being inlined in my testing, but it's
better to be sure.  I'll post v2 with a flag.

> 
>>  {
>> +       u8 buffer[NSH_HDR_MAX_LEN];
>> +       struct nshhdr *nh = (struct nshhdr *)buffer;
>>         int err;
>>
>> +       err = nsh_hdr_from_nlattr(a, nh, NSH_HDR_MAX_LEN);
>> +       if (err)
>> +               return err;
>> +
>>         err = nsh_push(skb, nh);
>>         if (err)
>>                 return err;
>> @@ -1439,17 +1445,9 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>                         err = pop_eth(skb, key);
>>                         break;
>>
>> -               case OVS_ACTION_ATTR_PUSH_NSH: {
>> -                       u8 buffer[NSH_HDR_MAX_LEN];
>> -                       struct nshhdr *nh = (struct nshhdr *)buffer;
>> -
>> -                       err = nsh_hdr_from_nlattr(nla_data(a), nh,
>> -                                                 NSH_HDR_MAX_LEN);
>> -                       if (unlikely(err))
>> -                               break;
>> -                       err = push_nsh(skb, key, nh);
>> +               case OVS_ACTION_ATTR_PUSH_NSH:
>> +                       err = push_nsh(skb, key, nla_data(a));
>>                         break;
>> -               }
>>
>>                 case OVS_ACTION_ATTR_POP_NSH:
>>                         err = pop_nsh(skb, key);
>> --
>> 2.41.0
>>


