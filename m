Return-Path: <netdev+bounces-16569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B0274DD78
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBE7280DDF
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF0134D4;
	Mon, 10 Jul 2023 18:38:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8814A92
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:38:30 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268DDAB
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 11:38:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51C16E0003;
	Mon, 10 Jul 2023 18:38:25 +0000 (UTC)
Message-ID: <a2df3e56-ca0c-a1ff-dd79-6e6b12568da9@ovn.org>
Date: Mon, 10 Jul 2023 20:39:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, Eric Garver <eric@garver.life>,
 Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Adrian Moreno <amorenoz@redhat.com>, Eelco Chaudron <echaudro@redhat.com>
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
References: <20230629203005.2137107-1-eric@garver.life>
 <20230629203005.2137107-3-eric@garver.life> <f7tr0plgpzb.fsf@redhat.com>
 <ZKbITj-FWGqRkwtr@egarver-thinkpadt14sgen1.remote.csb>
 <6060b37e-579a-76cb-b853-023cb1a25861@ovn.org>
 <20230707080025.7739e499@kernel.org>
 <eb01326d-5b30-2d58-f814-45cd436c581a@ovn.org>
 <dec509a4-3e36-e256-b8c0-74b7eed48345@ovn.org>
 <20230707150610.4e6e1a4d@kernel.org>
 <096871e8-3c0b-d5d7-8e68-833ba26b3882@ovn.org>
 <20230710100110.52ce3d4c@kernel.org>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop action
In-Reply-To: <20230710100110.52ce3d4c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/10/23 19:01, Jakub Kicinski wrote:
> On Mon, 10 Jul 2023 18:51:19 +0200 Ilya Maximets wrote:
>> Makes sense.  I wasn't sure that's a good solution from a kernel perspective
>> either.  It's better than defining all these reasons, IMO, but it's not good
>> enough to be considered acceptable, I agree.
>>
>> How about we define just 2 reasons, e.g. OVS_DROP_REASON_EXPLICIT_ACTION and
>> OVS_DROP_REASON_EXPLICIT_ACTION_WITH_ERROR (exact names can be different) ?
>> One for an explicit drop action with a zero argument and one for an explicit
>> drop with non-zero argument.
>>
>> The exact reason for the error can be retrieved by other means, i.e by looking
>> at the datapath flow dump or OVS logs/traces.
>>
>> This way we can give a user who is catching packet drop traces a signal that
>> there was something wrong with an OVS flow and they can look up exact details
>> from the userspace / flow dump.
>>
>> The point being, most of the flows will have a zero as a drop action argument,
>> i.e. a regular explicit packet drop.  It will be hard to figure out which flow
>> exactly we're hitting without looking at the full flow dump.  And if the value
>> is non-zero, then it should be immediately obvious which flow is to blame from
>> the dump, as we should not have a lot of such flows.
>>
>> This would still allow us to avoid a maintenance burden of defining every case,
>> which are fairly meaningless for the kernel itself, while having 99% of the
>> information we may need.
>>
>> Jakub, do you think this will be acceptable?
> 
> As far as I understand what you're proposing, yes :)

OK.  Just to spell it all out:

Userspace will install a flow with an OVS_FLOW_CMD_NEW:

  match:ip,tcp,... actions:something,something,drop(0)
  match:ip,udp,... actions:something,something,drop(42)

drop() here represents the OVS_ACTION_ATTR_DROP.

Then, in net/openvswitch/actions.c:do_execute_actions(), while executing
these actions:

  case OVS_ACTION_ATTR_DROP:
      kfree_skb_reason(skb, nla_get_u32(a) ? OVS_DROP_ACTION_WITH_ERROR
                                           : OVS_DROP_ACTION);

Users can enable traces and catch the OVS_DROP_ACTION_WITH_ERROR.
Later they can dump flows with OVS_FLOW_CMD_GET and see that the
error value was 42.

> 
>> Eric, Adrian, Aaron, do you see any problems with such implementation?
>>
>> P.S. There is a plan to add more drop reasons for other places in openvswitch
>>      module to catch more regular types of drops like memory issues or upcall
>>      failures.  So, the drop reason subsystem can be extended later.
>>      The explicit drop action is a bit of an odd case here.
> 
> If you have more than ~4 OvS specific reasons, I wonder if it still
> makes sense to create a reason group/subsystem for OvS (a'la WiFi)?

I believe, we will easily have more than 4 OVS-specific reasons.  A few
from the top of my head:
  - upcall failure (failed to send a packet to userspace)
  - reached the limit for deferred actions
  - reached the recursion limit

So, creation of a reason group/subsystem seems reasonable to me.

Best regards, Ilya Maximets.

