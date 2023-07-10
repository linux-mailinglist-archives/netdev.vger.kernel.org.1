Return-Path: <netdev+bounces-16535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5FA74DB7C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E8C1C20B1B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4A134A2;
	Mon, 10 Jul 2023 16:50:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F1125CA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:50:38 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBEBE3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:50:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E78AA40008;
	Mon, 10 Jul 2023 16:50:32 +0000 (UTC)
Message-ID: <096871e8-3c0b-d5d7-8e68-833ba26b3882@ovn.org>
Date: Mon, 10 Jul 2023 18:51:19 +0200
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
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop action
In-Reply-To: <20230707150610.4e6e1a4d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/8/23 00:06, Jakub Kicinski wrote:
> On Fri, 7 Jul 2023 18:04:36 +0200 Ilya Maximets wrote:
>>>> That already exists, right? Johannes added it in the last release for WiFi.  
>>>
>>> I'm not sure.  The SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE behaves similarly
>>> to that on a surface.  However, looking closer, any value that can be passed
>>> into ieee80211_rx_handlers_result() and ends up in the kfree_skb_reason() is
>>> kind of defined in net/mac80211/drop.h, unless I'm missing something (very
>>> possible, because I don't really know wifi code).
>>>
>>> The difference, I guess, is that for openvswitch values will be provided by
>>> the userpsace application via netlink interface.  It'll be just a number not
>>> defined anywhere in the kernel.  Only the subsystem itself will be defined
>>> in order to occupy the range.  Garbage in, same garbage out, from the kernel's
>>> perspective.  
>>
>> To be clear, I think, not defining them in this particular case is better.
>> Definition of every reason that userspace can come up with will add extra
>> uAPI maintenance cost/issues with no practical benefits.  Values are not
>> going to be used for anything outside reporting a drop reason and subsystem
>> offset is not part of uAPI anyway.
> 
> Ah, I see. No, please don't stuff user space defined values into 
> the drop reason. The reasons are for debugging the kernel stack 
> itself. IOW it'd be abuse not reuse.

Makes sense.  I wasn't sure that's a good solution from a kernel perspective
either.  It's better than defining all these reasons, IMO, but it's not good
enough to be considered acceptable, I agree.

How about we define just 2 reasons, e.g. OVS_DROP_REASON_EXPLICIT_ACTION and
OVS_DROP_REASON_EXPLICIT_ACTION_WITH_ERROR (exact names can be different) ?
One for an explicit drop action with a zero argument and one for an explicit
drop with non-zero argument.

The exact reason for the error can be retrieved by other means, i.e by looking
at the datapath flow dump or OVS logs/traces.

This way we can give a user who is catching packet drop traces a signal that
there was something wrong with an OVS flow and they can look up exact details
from the userspace / flow dump.

The point being, most of the flows will have a zero as a drop action argument,
i.e. a regular explicit packet drop.  It will be hard to figure out which flow
exactly we're hitting without looking at the full flow dump.  And if the value
is non-zero, then it should be immediately obvious which flow is to blame from
the dump, as we should not have a lot of such flows.

This would still allow us to avoid a maintenance burden of defining every case,
which are fairly meaningless for the kernel itself, while having 99% of the
information we may need.

Jakub, do you think this will be acceptable?

Eric, Adrian, Aaron, do you see any problems with such implementation?

P.S. There is a plan to add more drop reasons for other places in openvswitch
     module to catch more regular types of drops like memory issues or upcall
     failures.  So, the drop reason subsystem can be extended later.
     The explicit drop action is a bit of an odd case here.

Best regards, Ilya Maximets.

