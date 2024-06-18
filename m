Return-Path: <netdev+bounces-104440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B21690C867
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F61C2226C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1409E204F0F;
	Tue, 18 Jun 2024 09:47:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB27204F0C;
	Tue, 18 Jun 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704067; cv=none; b=aVwkaOEZSr8CjZ1/grMPTd1AXDPESKaDZVsB0L9v2xM59uHi8AAtebZBZ1rs4IaM5RXbS3zb5QSLiysx2wegGwI+HWoSZClKssJn3JlJsNWyaQDfHviBNWVc77HGozkPAP3pbBSrbr6KG37qZDyDtf7qSEywHEC3ylKA55TruRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704067; c=relaxed/simple;
	bh=w8SHkAhQ2KYa9gX5f0d9nDfNJAt76UIQ3b09bZQbNLM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XRsawjmzQlB9eepcsq/OGnWB1CW+/5elfJp3g2m0KbLOoLZ0RrduUgw1+2+u5NaKb8PTHNAFcFOPwfcwVAWTZwoDMCFbMdLAWa3VYDvMUfPH7yRRrWzMgquL6rTN/1x8WAZtzx/lPyw1x7+PlDhrVMTO+vVhT8EFFSeVZ41vBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F40E240003;
	Tue, 18 Jun 2024 09:47:36 +0000 (UTC)
Message-ID: <ec135d28-5642-4393-a175-439c13c4d4f8@ovn.org>
Date: Tue, 18 Jun 2024 11:47:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, aconole@redhat.com,
 echaudro@redhat.com, horms@kernel.org, dev@openvswitch.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
Content-Language: en-US
To: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-6-amorenoz@redhat.com>
 <4f89a9b9-999c-4d1f-8831-48045e6a74f6@ovn.org>
 <CAG=2xmPHcyLbuMCVR6ysKigboWg1E_xCHFMxEKUceerioO-OFg@mail.gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAG=2xmPHcyLbuMCVR6ysKigboWg1E_xCHFMxEKUceerioO-OFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org

On 6/18/24 09:33, Adrián Moreno wrote:
> On Mon, Jun 17, 2024 at 12:44:45PM GMT, Ilya Maximets wrote:
>> On 6/3/24 20:56, Adrian Moreno wrote:
>>> Add support for a new action: emit_sample.
>>>
>>> This action accepts a u32 group id and a variable-length cookie and uses
>>> the psample multicast group to make the packet available for
>>> observability.
>>>
>>> The maximum length of the user-defined cookie is set to 16, same as
>>> tc_cookie, to discourage using cookies that will not be offloadable.
>>>
>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>> ---
>>>  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
>>>  include/uapi/linux/openvswitch.h          | 25 ++++++++++++
>>>  net/openvswitch/actions.c                 | 50 +++++++++++++++++++++++
>>>  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++-
>>>  4 files changed, 124 insertions(+), 1 deletion(-)
>>
>> Some nits below, beside ones already mentioned.
>>
> 
> Thanks, Ilya.
> 
>>>
>>> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
>>> index 4fdfc6b5cae9..a7ab5593a24f 100644
>>> --- a/Documentation/netlink/specs/ovs_flow.yaml
>>> +++ b/Documentation/netlink/specs/ovs_flow.yaml
>>> @@ -727,6 +727,12 @@ attribute-sets:
>>>          name: dec-ttl
>>>          type: nest
>>>          nested-attributes: dec-ttl-attrs
>>> +      -
>>> +        name: emit-sample
>>> +        type: nest
>>> +        nested-attributes: emit-sample-attrs
>>> +        doc: |
>>> +          Sends a packet sample to psample for external observation.
>>>    -
>>>      name: tunnel-key-attrs
>>>      enum-name: ovs-tunnel-key-attr
>>> @@ -938,6 +944,17 @@ attribute-sets:
>>>        -
>>>          name: gbp
>>>          type: u32
>>> +  -
>>> +    name: emit-sample-attrs
>>> +    enum-name: ovs-emit-sample-attr
>>> +    name-prefix: ovs-emit-sample-attr-
>>> +    attributes:
>>> +      -
>>> +        name: group
>>> +        type: u32
>>> +      -
>>> +        name: cookie
>>> +        type: binary
>>>
>>>  operations:
>>>    name-prefix: ovs-flow-cmd-
>>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
>>> index efc82c318fa2..a0e9dde0584a 100644
>>> --- a/include/uapi/linux/openvswitch.h
>>> +++ b/include/uapi/linux/openvswitch.h
>>> @@ -914,6 +914,30 @@ struct check_pkt_len_arg {
>>>  };
>>>  #endif
>>>
>>> +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
>>> +/**
>>> + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_SAMPLE
>>> + * action.
>>> + *
>>> + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
>>> + * sample.
>>> + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that contains
>>> + * user-defined metadata. The maximum length is 16 bytes.
>>
>> s/16/OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE/
>>
>>> + *
>>> + * Sends the packet to the psample multicast group with the specified group and
>>> + * cookie. It is possible to combine this action with the
>>> + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet being emitted.
>>> + */
>>> +enum ovs_emit_sample_attr {
>>> +	OVS_EMIT_SAMPLE_ATTR_UNPSEC,
>>> +	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
>>> +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
>>> +	__OVS_EMIT_SAMPLE_ATTR_MAX
>>> +};
>>> +
>>> +#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
>>> +
>>> +
>>>  /**
>>>   * enum ovs_action_attr - Action types.
>>>   *
>>> @@ -1004,6 +1028,7 @@ enum ovs_action_attr {
>>>  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
>>>  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
>>>  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
>>> +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
>>>
>>>  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>>>  				       * from userspace. */
>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>> index 964225580824..3b4dba0ded59 100644
>>> --- a/net/openvswitch/actions.c
>>> +++ b/net/openvswitch/actions.c
>>> @@ -24,6 +24,11 @@
>>>  #include <net/checksum.h>
>>>  #include <net/dsfield.h>
>>>  #include <net/mpls.h>
>>> +
>>> +#if IS_ENABLED(CONFIG_PSAMPLE)
>>> +#include <net/psample.h>
>>> +#endif
>>> +
>>>  #include <net/sctp/checksum.h>
>>>
>>>  #include "datapath.h"
>>> @@ -1299,6 +1304,46 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
>>>  	return 0;
>>>  }
>>>
>>> +static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
>>> +			       const struct sw_flow_key *key,
>>> +			       const struct nlattr *attr)
>>> +{
>>> +#if IS_ENABLED(CONFIG_PSAMPLE)
>>> +	struct psample_group psample_group = {};
>>> +	struct psample_metadata md = {};
>>> +	struct vport *input_vport;
>>> +	const struct nlattr *a;
>>> +	int rem;
>>> +
>>> +	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
>>> +	     a = nla_next(a, &rem)) {
>>
>> Since the action is strictly validated, can use use nla_for_each_attr()
>> or nla_for_each_nested() ?
>>
> 
> Probably, yes.
> 
>>> +		switch (nla_type(a)) {
>>> +		case OVS_EMIT_SAMPLE_ATTR_GROUP:
>>> +			psample_group.group_num = nla_get_u32(a);
>>> +			break;
>>> +
>>> +		case OVS_EMIT_SAMPLE_ATTR_COOKIE:
>>> +			md.user_cookie = nla_data(a);
>>> +			md.user_cookie_len = nla_len(a);
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	psample_group.net = ovs_dp_get_net(dp);
>>> +
>>> +	input_vport = ovs_vport_rcu(dp, key->phy.in_port);
>>> +	if (!input_vport)
>>> +		input_vport = ovs_vport_rcu(dp, OVSP_LOCAL);
>>
>> We may need to check that we actually found the local port.
>>
> 
> Sure. What can cause the local port not to exist?

I would assume that since we're only protected by RCU here, there can be
a race with datapath destruction that will remove the local port.

Best regards, Ilya Maximets.

