Return-Path: <netdev+bounces-94651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC5C8C00E0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DC3288FA0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAC126F39;
	Wed,  8 May 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+B8hZpH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10791126F1D
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181931; cv=none; b=u6oYQ5dSt7uHpZ9LhN1O7VGF4DOWmeTDM9EG6N+qROUCFdZYHD+8xRRGyvmHc+VfsRSmg42dRy0avTZ5yx4SFktJnmsFwmw26OASye5kULXe+51usRpLd7zhZxudTHORoptSrIc37HiYs9FKzbtc+BZqiWpGhQIC5feBpVurWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181931; c=relaxed/simple;
	bh=EyL4VrWY/K+oGTqb0c3hNwhWg9MxjGZQoD5vwscHNlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6qcbxuUIvURU2oaB5apTGDlbBiw0cWTKa1BSqAp75uhAmhRBJl7QvioIODmf1mVxoKOCNpHK2YZjGfOJj/sliy6pqxX2rHQNCf4LZxSq4be1QKySE8dr7/jzC0vyfhVAxfhOB/Xl3tDMfUZt+K7+0XQyaL01LjBP0qJwGKdIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+B8hZpH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715181928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDr2wPE7/NFajc+3cTv9ojHqpip22eN9JXTXBM1mTbk=;
	b=F+B8hZpHuW49HIfpcnNnLA9zygAjQ7tEUYUfPFFRc26y240WTdL/Updg8dIjloccphAcFo
	FRWkKen6+E7P48SyqknL/uvaiWDXc1Po1FOlSpIDSPVTVuAH7gn3Vm75ZzlsubAGKTaA0U
	NkSfrV+RWRAnQXYooFLJFZ75OMt7D5Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-nEVb_V9wMHaqwHJtzeD-kA-1; Wed,
 08 May 2024 11:25:24 -0400
X-MC-Unique: nEVb_V9wMHaqwHJtzeD-kA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3678B29ABA18;
	Wed,  8 May 2024 15:25:24 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 40160491020;
	Wed,  8 May 2024 15:25:23 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>,  netdev@vger.kernel.org,
  horms@kernel.org,  i.maximets@ovn.org,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Pravin B
 Shelar <pshelar@ovn.org>,  Donald Hunter <donald.hunter@gmail.com>,
  linux-kernel@vger.kernel.org,  dev@openvswitch.org
Subject: Re: [PATCH net-next 6/8] net:openvswitch: add psample support
In-Reply-To: <5f516a72-d406-49bf-98a0-0f1ade8a0d50@redhat.com> (Adrian
	Moreno's message of "Tue, 7 May 2024 16:18:02 +0200")
References: <20240424135109.3524355-1-amorenoz@redhat.com>
	<20240424135109.3524355-7-amorenoz@redhat.com>
	<72F692D6-621D-4E02-AAE2-AC63CC99FEBE@redhat.com>
	<5f516a72-d406-49bf-98a0-0f1ade8a0d50@redhat.com>
Date: Wed, 08 May 2024 11:25:23 -0400
Message-ID: <f7tjzk48gws.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Adrian Moreno <amorenoz@redhat.com> writes:

> On 5/3/24 11:43 AM, Eelco Chaudron wrote:
>> On 24 Apr 2024, at 15:50, Adrian Moreno wrote:
>>=20
>>> Add support for psample sampling via two new attributes to the
>>> OVS_ACTION_ATTR_SAMPLE action.
>>>
>>> OVS_SAMPLE_ATTR_PSAMPLE_GROUP used to pass an integer psample group_id.
>>> OVS_SAMPLE_ATTR_PSAMPLE_COOKIE used to pass a variable-length binary
>>> cookie that will be forwared to psample.
>>>
>>> The maximum length of the user-defined cookie is set to 16, same as
>>> tc_cookie, to discourage using cookies that will not be offloadable.
>>>
>>> In order to simplify the internal processing of the action and given the
>>> maximum size of the cookie is relatively small, add both fields to the
>>> internal-only struct sample_arg.
>>>
>>> The presence of a group_id mandates that the action shall called the
>>> psample module to multicast the packet with such group_id and the
>>> user-provided cookie if present. This behavior is orthonogal to
>>> also executing the nested actions if present.
>>>
>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> This is not a full review yet. Just some comments, as I=E2=80=99m lookin=
g at
>> the user-space patch first and added similar comments.
>> I=E2=80=99ll do a proper review of this series once I=E2=80=99m done wit=
h user-space
>> part.
>> //Eelco
>>=20
>>> ---
>>>   Documentation/netlink/specs/ovs_flow.yaml |  6 ++
>>>   include/uapi/linux/openvswitch.h          | 49 ++++++++++----
>>>   net/openvswitch/actions.c                 | 51 +++++++++++++--
>>>   net/openvswitch/flow_netlink.c            | 80 ++++++++++++++++++-----
>>>   4 files changed, 153 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/=
netlink/specs/ovs_flow.yaml
>>> index 4fdfc6b5cae9..5543c2937225 100644
>>> --- a/Documentation/netlink/specs/ovs_flow.yaml
>>> +++ b/Documentation/netlink/specs/ovs_flow.yaml
>>> @@ -825,6 +825,12 @@ attribute-sets:
>>>           name: actions
>>>           type: nest
>>>           nested-attributes: action-attrs
>>> +      -
>>> +        name: psample_group
>>> +        type: u32
>>> +      -
>>> +        name: psample_cookie
>>> +        type: binary
>>>     -
>>>       name: userspace-attrs
>>>       enum-name: ovs-userspace-attr
>>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/open=
vswitch.h
>>> index efc82c318fa2..e9cd6f3a952d 100644
>>> --- a/include/uapi/linux/openvswitch.h
>>> +++ b/include/uapi/linux/openvswitch.h
>>> @@ -639,6 +639,7 @@ enum ovs_flow_attr {
>>>   #define OVS_UFID_F_OMIT_MASK     (1 << 1)
>>>   #define OVS_UFID_F_OMIT_ACTIONS  (1 << 2)
>>>
>>> +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
>>>   /**
>>>    * enum ovs_sample_attr - Attributes for %OVS_ACTION_ATTR_SAMPLE acti=
on.
>>>    * @OVS_SAMPLE_ATTR_PROBABILITY: 32-bit fraction of packets to sample=
 with
>>> @@ -646,15 +647,27 @@ enum ovs_flow_attr {
>>>    * %UINT32_MAX samples all packets and intermediate values sample int=
ermediate
>>>    * fractions of packets.
>>>    * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling ev=
ent.
>>> - * Actions are passed as nested attributes.
>>> + * Actions are passed as nested attributes. Optional if
>>> + * OVS_SAMPLE_ATTR_PSAMPLE_GROUP is set.
>>> + * @OVS_SAMPLE_ATTR_PSAMPLE_GROUP: A 32-bit number to be used as psamp=
le group.
>>> + * Optional if OVS_SAMPLE_ATTR_ACTIONS is set.
>>> + * @OVS_SAMPLE_ATTR_PSAMPLE_COOKIE: A variable-length binary cookie th=
at, if
>>> + * provided, will be copied to the psample cookie.
>> As there is a limit of to the cookie should we mention it here?
>>=20
>
> I thought OVS_PSAMPLE_COOKIE_MAX_SIZE was expressive enough but sure,
> we can also mention it here.
>
>>>    *
>>> - * Executes the specified actions with the given probability on a per-=
packet
>>> - * basis.
>>> + * Either OVS_SAMPLE_ATTR_PSAMPLE_GROUP or OVS_SAMPLE_ATTR_ACTIONS mus=
t be
>>> + * specified.
>>> + *
>>> + * Executes the specified actions and/or sends the packet to psample
>>> + * with the given probability on a per-packet basis.
>>>    */
>>>   enum ovs_sample_attr {
>>>   	OVS_SAMPLE_ATTR_UNSPEC,
>>> -	OVS_SAMPLE_ATTR_PROBABILITY, /* u32 number */
>>> -	OVS_SAMPLE_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. =
*/
>>> +	OVS_SAMPLE_ATTR_PROBABILITY,	/* u32 number */
>>> +	OVS_SAMPLE_ATTR_ACTIONS,	/* Nested OVS_ACTION_ATTR_
>> Missing * after OVS_ACTION_ATTR_
>
> As a matter of fact, adding an * makes checkpatch generate a warning
> IIRC. That's why I initially removed it. I can look at fixing
> checkpatch instead.

I think we can ignore the warning.  Alternatively, consider not changing
the comment spacing for the existing comments.

>>=20
>>> +					 * attributes.
>>> +					 */
>>> +	OVS_SAMPLE_ATTR_PSAMPLE_GROUP,	/* u32 number */
>>> +	OVS_SAMPLE_ATTR_PSAMPLE_COOKIE,	/* binary */
>> As these are general sample options, I would not add the PSAMPLE
>> reference. Other data paths could use a different implementation. So
>> I guess OVS_SAMPLE_ATTR_GROUP_ID and OVS_SAMPLE_ATTR_COOKIE would be
>> enough.
>>=20
>
> OK. But isn't the API already psample-ish? I mean that the group_id is
> something specific to psample that might not be present in other
> datapath implementation.
>
>
>>>   	__OVS_SAMPLE_ATTR_MAX,
>>>
>>>   #ifdef __KERNEL__
>>> @@ -665,13 +678,27 @@ enum ovs_sample_attr {
>>>   #define OVS_SAMPLE_ATTR_MAX (__OVS_SAMPLE_ATTR_MAX - 1)
>>>
>>>   #ifdef __KERNEL__
>>> +
>>> +/* Definition for flags in struct sample_arg. */
>>> +enum {
>>> +	/* When set, actions in sample will not change the flows. */
>>> +	OVS_SAMPLE_ARG_FLAG_EXEC =3D 1 << 0,
>>> +	/* When set, the packet will be sent to psample. */
>>> +	OVS_SAMPLE_ARG_FLAG_PSAMPLE =3D 1 << 1,
>>> +};
>>> +
>>>   struct sample_arg {
>>> -	bool exec;                   /* When true, actions in sample will not
>>> -				      * change flow keys. False otherwise.
>>> -				      */
>>> -	u32  probability;            /* Same value as
>>> -				      * 'OVS_SAMPLE_ATTR_PROBABILITY'.
>>> -				      */
>> Not sure if you can actually do this, you are changing a structure
>> that is part of the UAPI. This change breaks backwards
>> compatibility.
>>=20
>
> Hmmm... this the internal argument structure protected by #ifdef
> __KERNEL__. It is used in several actions to optimize the internal
> action handling (i.e: using a compact struct instead of a list of
> netlink attributes). I guess the reason for having it in this file is
> because the attribute enum is being reused, but I wouldn't think of
> this struct as part of the uAPI.
>
> If the (#ifdef __KERNEL__) does not exclude this struct from the uAPI
> I think we should move it (all of them actually) to some internal
> file.
>
>>=20
>>> +	u16 flags;		/* Flags that modify the behavior of the
>>> +				 * action. See SAMPLE_ARG_FLAG_*.
>>> +				 */
>>> +	u32  probability;       /* Same value as
>>> +				 * 'OVS_SAMPLE_ATTR_PROBABILITY'.
>>> +				 */
>>> +	u32  group_id;		/* Same value as
>>> +				 * 'OVS_SAMPLE_ATTR_PSAMPLE_GROUP'.
>>> +				 */
>>> +	u8  cookie_len;		/* Length of psample cookie. */
>>> +	char cookie[OVS_PSAMPLE_COOKIE_MAX_SIZE]; /* psample cookie data. */
>> Would it make sense for the cookie also to be u8?
>>=20
>
> Yes, probably.
>
>>>   };
>>>   #endif
>>>
>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>>> index 6fcd7e2ca81f..eb3166986fd2 100644
>>> --- a/net/openvswitch/actions.c
>>> +++ b/net/openvswitch/actions.c
>>> @@ -24,6 +24,7 @@
>>>   #include <net/checksum.h>
>>>   #include <net/dsfield.h>
>>>   #include <net/mpls.h>
>>> +#include <net/psample.h>
>>>   #include <net/sctp/checksum.h>
>>>
>>>   #include "datapath.h"
>>> @@ -1025,6 +1026,34 @@ static int dec_ttl_exception_handler(struct data=
path *dp, struct sk_buff *skb,
>>>   	return 0;
>>>   }
>>>
>>> +static int ovs_psample_packet(struct datapath *dp, struct sw_flow_key =
*key,
>>> +			      const struct sample_arg *arg,
>>> +			      struct sk_buff *skb)
>>> +{
>>> +	struct psample_group psample_group =3D {};
>>> +	struct psample_metadata md =3D {};
>>> +	struct vport *input_vport;
>>> +	u32 rate;
>>> +
>>> +	psample_group.group_num =3D arg->group_id;
>>> +	psample_group.net =3D ovs_dp_get_net(dp);
>>> +
>>> +	input_vport =3D ovs_vport_rcu(dp, key->phy.in_port);
>>> +	if (!input_vport)
>>> +		input_vport =3D ovs_vport_rcu(dp, OVSP_LOCAL);
>>> +
>>> +	md.in_ifindex =3D input_vport->dev->ifindex;
>>> +	md.user_cookie =3D arg->cookie_len ? &arg->cookie[0] : NULL;
>>> +	md.user_cookie_len =3D arg->cookie_len;
>>> +	md.trunc_size =3D skb->len;
>>> +
>>> +	rate =3D arg->probability ? U32_MAX / arg->probability : 0;
>>> +
>>> +	psample_sample_packet(&psample_group, skb, rate, &md);
>> Does this mean now the ovs module, now is dependent on the presence
>> of psample? I think we should only support sampling to psample if
>> the module exists, else we should return an error. There might be
>> distributions not including psample by default.
>
> Agree. I'll add some compile-time checks the same way we do with nf_nat.
>
>>=20
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   /* When 'last' is true, sample() should always consume the 'skb'.
>>>    * Otherwise, sample() should keep 'skb' intact regardless what
>>>    * actions are executed within sample().
>>> @@ -1033,11 +1062,12 @@ static int sample(struct datapath *dp, struct s=
k_buff *skb,
>>>   		  struct sw_flow_key *key, const struct nlattr *attr,
>>>   		  bool last)
>>>   {
>>> -	struct nlattr *actions;
>>> +	const struct sample_arg *arg;
>>>   	struct nlattr *sample_arg;
>>>   	int rem =3D nla_len(attr);
>>> -	const struct sample_arg *arg;
>>> +	struct nlattr *actions;
>>>   	bool clone_flow_key;
>>> +	int ret;
>>>
>>>   	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
>>>   	sample_arg =3D nla_data(attr);
>>> @@ -1051,9 +1081,20 @@ static int sample(struct datapath *dp, struct sk=
_buff *skb,
>>>   		return 0;
>>>   	}
>>>
>>> -	clone_flow_key =3D !arg->exec;
>>> -	return clone_execute(dp, skb, key, 0, actions, rem, last,
>>> -			     clone_flow_key);
>>> +	if (arg->flags & OVS_SAMPLE_ARG_FLAG_PSAMPLE) {
>>> +		ret =3D ovs_psample_packet(dp, key, arg, skb);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	if (nla_ok(actions, rem)) {
>>> +		clone_flow_key =3D !(arg->flags & OVS_SAMPLE_ARG_FLAG_EXEC);
>>> +		ret =3D clone_execute(dp, skb, key, 0, actions, rem, last,
>>> +				    clone_flow_key);
>>> +	} else if (last) {
>>> +		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
>>> +	}
>>> +	return ret;
>>>   }
>>>
>>>   /* When 'last' is true, clone() should always consume the 'skb'.
>>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netl=
ink.c
>>> index f224d9bcea5e..1a348d3905fc 100644
>>> --- a/net/openvswitch/flow_netlink.c
>>> +++ b/net/openvswitch/flow_netlink.c
>>> @@ -2561,6 +2561,9 @@ static int __ovs_nla_copy_actions(struct net *net=
, const struct nlattr *attr,
>>>   				  u32 mpls_label_count, bool log,
>>>   				  u32 depth);
>>>
>>> +static int copy_action(const struct nlattr *from,
>>> +		       struct sw_flow_actions **sfa, bool log);
>>> +
>>>   static int validate_and_copy_sample(struct net *net, const struct nla=
ttr *attr,
>>>   				    const struct sw_flow_key *key,
>>>   				    struct sw_flow_actions **sfa,
>>> @@ -2569,10 +2572,10 @@ static int validate_and_copy_sample(struct net =
*net, const struct nlattr *attr,
>>>   				    u32 depth)
>>>   {
>>>   	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
>>> -	const struct nlattr *probability, *actions;
>>> +	const struct nlattr *probability, *actions, *group, *cookie;
>>> +	struct sample_arg arg =3D {};
>>>   	const struct nlattr *a;
>>>   	int rem, start, err;
>>> -	struct sample_arg arg;
>>>
>>>   	memset(attrs, 0, sizeof(attrs));
>>>   	nla_for_each_nested(a, attr, rem) {
>>> @@ -2589,7 +2592,19 @@ static int validate_and_copy_sample(struct net *=
net, const struct nlattr *attr,
>>>   		return -EINVAL;
>>>
>>>   	actions =3D attrs[OVS_SAMPLE_ATTR_ACTIONS];
>>> -	if (!actions || (nla_len(actions) && nla_len(actions) < NLA_HDRLEN))
>>> +	if (actions && (!nla_len(actions) || nla_len(actions) < NLA_HDRLEN))
>>> +		return -EINVAL;
>>> +
>>> +	group =3D attrs[OVS_SAMPLE_ATTR_PSAMPLE_GROUP];
>>> +	if (group && nla_len(group) !=3D sizeof(u32))
>>> +		return -EINVAL;
>>> +
>>> +	cookie =3D attrs[OVS_SAMPLE_ATTR_PSAMPLE_COOKIE];
>>> +	if (cookie &&
>>> +	    (!group || nla_len(cookie) > OVS_PSAMPLE_COOKIE_MAX_SIZE))
>>> +		return -EINVAL;
>>> +
>>> +	if (!group && !actions)
>>>   		return -EINVAL;
>>>
>>>   	/* validation done, copy sample action. */
>>> @@ -2608,7 +2623,19 @@ static int validate_and_copy_sample(struct net *=
net, const struct nlattr *attr,
>>>   	 * If the sample is the last action, it can always be excuted
>>>   	 * rather than deferred.
>>>   	 */
>>> -	arg.exec =3D last || !actions_may_change_flow(actions);
>>> +	if (actions && (last || !actions_may_change_flow(actions)))
>>> +		arg.flags |=3D OVS_SAMPLE_ARG_FLAG_EXEC;
>>> +
>>> +	if (group) {
>>> +		arg.flags |=3D OVS_SAMPLE_ARG_FLAG_PSAMPLE;
>>> +		arg.group_id =3D nla_get_u32(group);
>>> +	}
>>> +
>>> +	if (cookie) {
>>> +		memcpy(&arg.cookie[0], nla_data(cookie), nla_len(cookie));
>>> +		arg.cookie_len =3D nla_len(cookie);
>>> +	}
>>> +
>>>   	arg.probability =3D nla_get_u32(probability);
>>>
>>>   	err =3D ovs_nla_add_action(sfa, OVS_SAMPLE_ATTR_ARG, &arg, sizeof(ar=
g),
>>> @@ -2616,12 +2643,13 @@ static int validate_and_copy_sample(struct net =
*net, const struct nlattr *attr,
>>>   	if (err)
>>>   		return err;
>>>
>>> -	err =3D __ovs_nla_copy_actions(net, actions, key, sfa,
>>> -				     eth_type, vlan_tci, mpls_label_count, log,
>>> -				     depth + 1);
>>> -
>>> -	if (err)
>>> -		return err;
>>> +	if (actions) {
>>> +		err =3D __ovs_nla_copy_actions(net, actions, key, sfa,
>>> +					     eth_type, vlan_tci,
>>> +					     mpls_label_count, log, depth + 1);
>>> +		if (err)
>>> +			return err;
>>> +	}
>>>
>>>   	add_nested_action_end(*sfa, start);
>>>
>>> @@ -3553,20 +3581,38 @@ static int sample_action_to_attr(const struct n=
lattr *attr,
>>>   		goto out;
>>>   	}
>>>
>>> -	ac_start =3D nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
>>> -	if (!ac_start) {
>>> -		err =3D -EMSGSIZE;
>>> -		goto out;
>>> +	if (arg->flags & OVS_SAMPLE_ARG_FLAG_PSAMPLE) {
>>> +		if (nla_put_u32(skb, OVS_SAMPLE_ATTR_PSAMPLE_GROUP,
>>> +				arg->group_id)) {
>>> +			err =3D -EMSGSIZE;
>>> +			goto out;
>>> +		}
>>> +
>>> +		if (arg->cookie_len &&
>>> +		    nla_put(skb, OVS_SAMPLE_ATTR_PSAMPLE_COOKIE,
>>> +			    arg->cookie_len, &arg->cookie[0])) {
>>> +			err =3D -EMSGSIZE;
>>> +			goto out;
>>> +		}
>>>   	}
>>>
>>> -	err =3D ovs_nla_put_actions(actions, rem, skb);
>>> +	if (nla_ok(actions, rem)) {
>>> +		ac_start =3D nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
>>> +		if (!ac_start) {
>>> +			err =3D -EMSGSIZE;
>>> +			goto out;
>>> +		}
>>> +		err =3D ovs_nla_put_actions(actions, rem, skb);
>>> +	}
>>>
>>>   out:
>>>   	if (err) {
>>> -		nla_nest_cancel(skb, ac_start);
>>> +		if (ac_start)
>>> +			nla_nest_cancel(skb, ac_start);
>>>   		nla_nest_cancel(skb, start);
>>>   	} else {
>>> -		nla_nest_end(skb, ac_start);
>>> +		if (ac_start)
>>> +			nla_nest_end(skb, ac_start);
>>>   		nla_nest_end(skb, start);
>>>   	}
>>>
>>> -- 2.44.0
>>=20


