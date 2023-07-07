Return-Path: <netdev+bounces-16007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C0674AEBC
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 12:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CDD1C20E38
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64458BE77;
	Fri,  7 Jul 2023 10:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B37BA2F
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 10:29:56 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013B5128
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 03:29:53 -0700 (PDT)
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 718F660004;
	Fri,  7 Jul 2023 10:29:50 +0000 (UTC)
Message-ID: <6060b37e-579a-76cb-b853-023cb1a25861@ovn.org>
Date: Fri, 7 Jul 2023 12:30:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Adrian Moreno
 <amorenoz@redhat.com>, Eelco Chaudron <echaudro@redhat.com>
Content-Language: en-US
To: Eric Garver <eric@garver.life>, Aaron Conole <aconole@redhat.com>,
 netdev@vger.kernel.org, dev@openvswitch.org
References: <20230629203005.2137107-1-eric@garver.life>
 <20230629203005.2137107-3-eric@garver.life> <f7tr0plgpzb.fsf@redhat.com>
 <ZKbITj-FWGqRkwtr@egarver-thinkpadt14sgen1.remote.csb>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop action
In-Reply-To: <ZKbITj-FWGqRkwtr@egarver-thinkpadt14sgen1.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/6/23 15:57, Eric Garver wrote:
> On Thu, Jul 06, 2023 at 08:54:16AM -0400, Aaron Conole wrote:
>> Eric Garver <eric@garver.life> writes:
>>
>>> This adds an explicit drop action. This is used by OVS to drop packets
>>> for which it cannot determine what to do. An explicit action in the
>>> kernel allows passing the reason _why_ the packet is being dropped. We
>>> can then use perf tracing to match on the drop reason.
>>>
>>> e.g. trace all OVS dropped skbs
>>>
>>>  # perf trace -e skb:kfree_skb --filter="reason >= 0x30000"
>>>  [..]
>>>  106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
>>>   location:0xffffffffc0d9b462, protocol: 2048, reason: 196610)
>>>
>>> reason: 196610 --> 0x30002 (OVS_XLATE_RECURSION_TOO_DEEP)
>>>
>>> Signed-off-by: Eric Garver <eric@garver.life>
>>> ---
>>>  include/uapi/linux/openvswitch.h                    |  2 ++
>>>  net/openvswitch/actions.c                           | 13 +++++++++++++
>>>  net/openvswitch/flow_netlink.c                      | 12 +++++++++++-
>>>  .../testing/selftests/net/openvswitch/ovs-dpctl.py  |  3 +++
>>>  4 files changed, 29 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
>>> index e94870e77ee9..a967dbca3574 100644
>>> --- a/include/uapi/linux/openvswitch.h
>>> +++ b/include/uapi/linux/openvswitch.h
>>> @@ -965,6 +965,7 @@ struct check_pkt_len_arg {
>>>   * start of the packet or at the start of the l3 header depending on the value
>>>   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
>>>   * argument.
>>> + * @OVS_ACTION_ATTR_DROP: Explicit drop action.
>>>   *
>>>   * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.  Not all
>>>   * fields within a header are modifiable, e.g. the IPv4 protocol and fragment
>>> @@ -1002,6 +1003,7 @@ enum ovs_action_attr {
>>>  	OVS_ACTION_ATTR_CHECK_PKT_LEN, /* Nested OVS_CHECK_PKT_LEN_ATTR_*. */
>>>  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
>>>  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
>>> +	OVS_ACTION_ATTR_DROP,         /* u32 xlate_error. */
>>>  
>>>  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>>>  				       * from userspace. */
>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>> index cab1e02b63e0..4ad9a45dc042 100644
>>> --- a/net/openvswitch/actions.c
>>> +++ b/net/openvswitch/actions.c
>>> @@ -32,6 +32,7 @@
>>>  #include "vport.h"
>>>  #include "flow_netlink.h"
>>>  #include "openvswitch_trace.h"
>>> +#include "drop.h"
>>>  
>>>  struct deferred_action {
>>>  	struct sk_buff *skb;
>>> @@ -1477,6 +1478,18 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>>  				return dec_ttl_exception_handler(dp, skb,
>>>  								 key, a);
>>>  			break;
>>> +
>>> +		case OVS_ACTION_ATTR_DROP:
>>> +			u32 reason = nla_get_u32(a);
>>> +
>>> +			reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
>>> +					SKB_DROP_REASON_SUBSYS_SHIFT;
>>> +
>>> +			if (reason == OVS_XLATE_OK)
>>> +				break;
>>> +
>>> +			kfree_skb_reason(skb, reason);
>>> +			return 0;
>>>  		}
>>>  
>>>  		if (unlikely(err)) {
>>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
>>> index 41116361433d..23d39eae9a0d 100644
>>> --- a/net/openvswitch/flow_netlink.c
>>> +++ b/net/openvswitch/flow_netlink.c
>>> @@ -39,6 +39,7 @@
>>>  #include <net/erspan.h>
>>>  
>>>  #include "flow_netlink.h"
>>> +#include "drop.h"
>>>  
>>>  struct ovs_len_tbl {
>>>  	int len;
>>> @@ -61,6 +62,7 @@ static bool actions_may_change_flow(const struct nlattr *actions)
>>>  		case OVS_ACTION_ATTR_RECIRC:
>>>  		case OVS_ACTION_ATTR_TRUNC:
>>>  		case OVS_ACTION_ATTR_USERSPACE:
>>> +		case OVS_ACTION_ATTR_DROP:
>>>  			break;
>>>  
>>>  		case OVS_ACTION_ATTR_CT:
>>> @@ -2394,7 +2396,7 @@ static void ovs_nla_free_nested_actions(const struct nlattr *actions, int len)
>>>  	/* Whenever new actions are added, the need to update this
>>>  	 * function should be considered.
>>>  	 */
>>> -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 23);
>>> +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 24);
>>>  
>>>  	if (!actions)
>>>  		return;
>>> @@ -3182,6 +3184,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>>>  			[OVS_ACTION_ATTR_CHECK_PKT_LEN] = (u32)-1,
>>>  			[OVS_ACTION_ATTR_ADD_MPLS] = sizeof(struct ovs_action_add_mpls),
>>>  			[OVS_ACTION_ATTR_DEC_TTL] = (u32)-1,
>>> +			[OVS_ACTION_ATTR_DROP] = sizeof(u32),
>>>  		};
>>>  		const struct ovs_action_push_vlan *vlan;
>>>  		int type = nla_type(a);
>>> @@ -3453,6 +3456,13 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>>>  			skip_copy = true;
>>>  			break;
>>>  
>>> +		case OVS_ACTION_ATTR_DROP:
>>> +			if (nla_get_u32(a) >=
>>> +			    u32_get_bits(OVS_XLATE_MAX,
>>> +					 ~SKB_DROP_REASON_SUBSYS_MASK))
>>> +				return -EINVAL;
>>> +			break;
>>> +
>>
>> If there's a case where the userspace sends a drop reason that isn't
>> known to the kernel, we will reject the flow, and the only "close" drop
>> will be OVS_XLATE_OK, which would be wrong.  Is there a reason to do
>> this?  For example, userspace might get new support for some kind of
>> flows and during that time might have a new xlate drop reason.  Maybe we
>> can have a reason code that OVS knows will exist, so that if this fails,
>> it can at least fall back to that?
> 
> You're correct. It will reject the flow.
> 
> Maybe we clamp the value to OVS_XLATE_MAX if it's unknown. That makes
> the skb drop reason less helpful, but no less helpful than today ;). At
> least we won't reject the flow.
> 
> We could alias OVS_XLATE_MAX to OVS_XLATE_UNKNOWN. I prefer an explicit
> value for OVS_XLATE_UNKNOWN, e.g. (u16)-1.

A wild idea:  How about we do not define actual reasons?  i.e. define a
subsystem and just call kfree_skb_reason(skb, SUBSYSTEM | value), where
'value' is whatever userspace gives as long as it is within a subsystem
range?

The point is: drop reasons are not part of the uAPI, but by defining drop
reasons for openvswitch we're making this subset of drop reasons part of
the uAPI.  And that seems a bit shady.  Users can't really rely on
actual values of drop reasons anyway, because the subsystem offset will
not be part of the uAPI.  And it doesn't matter if they need to get them
from the kernel binary or from the userspace OVS binary.

So, it might be cleaner to not define them in the first place.  Thoughts?

CC: kernel maintainers

Best regards, Ilya Maximets.

