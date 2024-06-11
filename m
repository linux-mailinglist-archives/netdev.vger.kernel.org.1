Return-Path: <netdev+bounces-102594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEB903E05
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770ADB22B28
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFED17D88B;
	Tue, 11 Jun 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdFO+RcV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562917D378
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114103; cv=none; b=FhE/ZxMhIKn/J6BG1AhUn4KmUSV1fWJICZPkOAmjtvSYz0wI+6S6oeI13VRU0oGXaAAT5mi9MHFA+FF7IKn8PnncNlhm5nbaD5XVYxJd6lbfHxOg3mATz7uztv1U/aF56S+U48rCrjFvuixBaDNOswO/pY8sBYOjWhPkiIn/Yb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114103; c=relaxed/simple;
	bh=cMqdASuvq7taGcHLyGGMO6AYw1stbMb0fCPS7BseeCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oMZNfJnta9WbiZCEeK1SJycOQ/o0dHk4P7FRuXSXiy2RjI/0RQAESmdokwaSG8rAmvtbEJQHlJZv4YFYgsBegsqoS/iKJo2odvEkqGwDCcjI7eD9JLkzZcmdE59T6FKHl4xzWR+JVuPYUEbs+Suoo/dd0RO79qGmUoJFI/1UcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdFO+RcV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718114100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgDJV98qTPRbI5Yaf+y0LTvwQGIq1DlpYB6heZDrzgo=;
	b=fdFO+RcVeH+tgZHrXqjLRbuPi2TiUtUrEdzU0bexXH00MV7CSAnOgdgUWteZSUSY1D5/fk
	ZXHRpiMaYlhSsKd6GPmYDiPQ0J0AwY4ACXevkDsEMUn2QwviX72vUd3MhbmCelU2gWTgBR
	/UNXqLv39HJZAsUEhk1bK4ULHGFoVEY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-QxLHf9FXMd6PKFxD4YvgHg-1; Tue,
 11 Jun 2024 09:54:55 -0400
X-MC-Unique: QxLHf9FXMd6PKFxD4YvgHg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB3C919560A7;
	Tue, 11 Jun 2024 13:54:52 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0A9519560AB;
	Tue, 11 Jun 2024 13:54:50 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  Paolo Abeni
 <pabeni@redhat.com>,  Donald Hunter <donald.hunter@gmail.com>,
  linux-kernel@vger.kernel.org,  i.maximets@ovn.org,  Eric Dumazet
 <edumazet@google.com>,  horms@kernel.org,  Jakub Kicinski
 <kuba@kernel.org>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v2 5/9] net: openvswitch: add
 emit_sample action
In-Reply-To: <CAG=2xmPqTLLWMq3GtG95Td=T6hjoV6TOcKdH6fyY0KGGAUMK9g@mail.gmail.com>
	(=?utf-8?Q?=22Adri=C3=A1n?= Moreno"'s message of "Tue, 11 Jun 2024 08:39:10
 +0000")
References: <20240603185647.2310748-1-amorenoz@redhat.com>
	<20240603185647.2310748-6-amorenoz@redhat.com>
	<f7ted94rebd.fsf@redhat.com>
	<CAG=2xmPqTLLWMq3GtG95Td=T6hjoV6TOcKdH6fyY0KGGAUMK9g@mail.gmail.com>
Date: Tue, 11 Jun 2024 09:54:49 -0400
Message-ID: <f7ta5jrr3di.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Adri=C3=A1n Moreno <amorenoz@redhat.com> writes:

> On Mon, Jun 10, 2024 at 11:46:14AM GMT, Aaron Conole wrote:
>> Adrian Moreno <amorenoz@redhat.com> writes:
>>
>> > Add support for a new action: emit_sample.
>> >
>> > This action accepts a u32 group id and a variable-length cookie and us=
es
>> > the psample multicast group to make the packet available for
>> > observability.
>> >
>> > The maximum length of the user-defined cookie is set to 16, same as
>> > tc_cookie, to discourage using cookies that will not be offloadable.
>> >
>> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> > ---
>>
>> I saw some of the nits Simon raised - I'll add one more below.
>>
>> I haven't gone through the series thoroughly enough to make a detailed
>> review.
>>
>> >  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
>> >  include/uapi/linux/openvswitch.h          | 25 ++++++++++++
>> >  net/openvswitch/actions.c                 | 50 +++++++++++++++++++++++
>> >  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++-
>> >  4 files changed, 124 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation=
/netlink/specs/ovs_flow.yaml
>> > index 4fdfc6b5cae9..a7ab5593a24f 100644
>> > --- a/Documentation/netlink/specs/ovs_flow.yaml
>> > +++ b/Documentation/netlink/specs/ovs_flow.yaml
>> > @@ -727,6 +727,12 @@ attribute-sets:
>> >          name: dec-ttl
>> >          type: nest
>> >          nested-attributes: dec-ttl-attrs
>> > +      -
>> > +        name: emit-sample
>> > +        type: nest
>> > +        nested-attributes: emit-sample-attrs
>> > +        doc: |
>> > +          Sends a packet sample to psample for external observation.
>> >    -
>> >      name: tunnel-key-attrs
>> >      enum-name: ovs-tunnel-key-attr
>> > @@ -938,6 +944,17 @@ attribute-sets:
>> >        -
>> >          name: gbp
>> >          type: u32
>> > +  -
>> > +    name: emit-sample-attrs
>> > +    enum-name: ovs-emit-sample-attr
>> > +    name-prefix: ovs-emit-sample-attr-
>> > +    attributes:
>> > +      -
>> > +        name: group
>> > +        type: u32
>> > +      -
>> > +        name: cookie
>> > +        type: binary
>> >
>> >  operations:
>> >    name-prefix: ovs-flow-cmd-
>> > diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/ope=
nvswitch.h
>> > index efc82c318fa2..a0e9dde0584a 100644
>> > --- a/include/uapi/linux/openvswitch.h
>> > +++ b/include/uapi/linux/openvswitch.h
>> > @@ -914,6 +914,30 @@ struct check_pkt_len_arg {
>> >  };
>> >  #endif
>> >
>> > +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
>> > +/**
>> > + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_S=
AMPLE
>> > + * action.
>> > + *
>> > + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source =
of the
>> > + * sample.
>> > + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that=
 contains
>> > + * user-defined metadata. The maximum length is 16 bytes.
>> > + *
>> > + * Sends the packet to the psample multicast group with the specified=
 group and
>> > + * cookie. It is possible to combine this action with the
>> > + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet bein=
g emitted.
>> > + */
>> > +enum ovs_emit_sample_attr {
>> > +	OVS_EMIT_SAMPLE_ATTR_UNPSEC,
>> > +	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
>> > +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
>> > +	__OVS_EMIT_SAMPLE_ATTR_MAX
>> > +};
>> > +
>> > +#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
>> > +
>> > +
>> >  /**
>> >   * enum ovs_action_attr - Action types.
>> >   *
>> > @@ -1004,6 +1028,7 @@ enum ovs_action_attr {
>> >  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
>> >  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
>> >  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
>> > +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
>> >
>> >  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>> >  				       * from userspace. */
>> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> > index 964225580824..3b4dba0ded59 100644
>> > --- a/net/openvswitch/actions.c
>> > +++ b/net/openvswitch/actions.c
>> > @@ -24,6 +24,11 @@
>> >  #include <net/checksum.h>
>> >  #include <net/dsfield.h>
>> >  #include <net/mpls.h>
>> > +
>> > +#if IS_ENABLED(CONFIG_PSAMPLE)
>> > +#include <net/psample.h>
>> > +#endif
>> > +
>> >  #include <net/sctp/checksum.h>
>> >
>> >  #include "datapath.h"
>> > @@ -1299,6 +1304,46 @@ static int execute_dec_ttl(struct sk_buff *skb,=
 struct sw_flow_key *key)
>> >  	return 0;
>> >  }
>> >
>> > +static int execute_emit_sample(struct datapath *dp, struct sk_buff *s=
kb,
>> > +			       const struct sw_flow_key *key,
>> > +			       const struct nlattr *attr)
>> > +{
>> > +#if IS_ENABLED(CONFIG_PSAMPLE)
>> > +	struct psample_group psample_group =3D {};
>> > +	struct psample_metadata md =3D {};
>> > +	struct vport *input_vport;
>> > +	const struct nlattr *a;
>> > +	int rem;
>> > +
>> > +	for (a =3D nla_data(attr), rem =3D nla_len(attr); rem > 0;
>> > +	     a =3D nla_next(a, &rem)) {
>> > +		switch (nla_type(a)) {
>> > +		case OVS_EMIT_SAMPLE_ATTR_GROUP:
>> > +			psample_group.group_num =3D nla_get_u32(a);
>> > +			break;
>> > +
>> > +		case OVS_EMIT_SAMPLE_ATTR_COOKIE:
>> > +			md.user_cookie =3D nla_data(a);
>> > +			md.user_cookie_len =3D nla_len(a);
>> > +			break;
>> > +		}
>> > +	}
>> > +
>> > +	psample_group.net =3D ovs_dp_get_net(dp);
>> > +
>> > +	input_vport =3D ovs_vport_rcu(dp, key->phy.in_port);
>> > +	if (!input_vport)
>> > +		input_vport =3D ovs_vport_rcu(dp, OVSP_LOCAL);
>> > +
>> > +	md.in_ifindex =3D input_vport->dev->ifindex;
>> > +	md.trunc_size =3D skb->len - OVS_CB(skb)->cutlen;
>> > +
>> > +	psample_sample_packet(&psample_group, skb, 0, &md);
>> > +#endif
>> > +
>> > +	return 0;
>>
>> Why this return here?  Doesn't seem used anywhere else.
>>
>
> It is being used in "do_execute_actions", right?
> All non-skb-consuming actions set the value of "err" and break from the
> switch-case so that the the packet is dropped with OVS_DROP_ACTION_ERROR =
reason.
>
> Am i missing something?

I think so.  For example, it isn't used when the function cannot
possibly error.

see the following cases:

OVS_ACTION_ATTR_HASH
OVS_ACTION_ATTR_TRUNC

As you note, these can consume SKB so also don't bother setting err,
because they will need to return anyway:

OVS_ACTION_ATTR_USERSPACE
OVS_ACTION_ATTR_OUTPUT
OVS_ACTION_ATTR_DROP

And even the following does a weird thing:

OVS_ACTION_ATTR_CT

because sometimes it will consume, and sometimes not.

I think if there isn't a possibility of error being generated (and I
guess from the code I see there isn't), then it shouldn't return a
useless code, since err will be 0 on each iteration of the loop.

>> > +}
>> > +
>> >  /* Execute a list of actions against 'skb'. */
>> >  static int do_execute_actions(struct datapath *dp, struct sk_buff *sk=
b,
>> >  			      struct sw_flow_key *key,
>> > @@ -1502,6 +1547,11 @@ static int do_execute_actions(struct datapath *=
dp, struct sk_buff *skb,
>> >  			ovs_kfree_skb_reason(skb, reason);
>> >  			return 0;
>> >  		}
>> > +
>> > +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
>> > +			err =3D execute_emit_sample(dp, skb, key, a);
>> > +			OVS_CB(skb)->cutlen =3D 0;
>> > +			break;
>> >  		}
>> >
>> >  		if (unlikely(err)) {
>> > diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_net=
link.c
>> > index f224d9bcea5e..eb59ff9c8154 100644
>> > --- a/net/openvswitch/flow_netlink.c
>> > +++ b/net/openvswitch/flow_netlink.c
>> > @@ -64,6 +64,7 @@ static bool actions_may_change_flow(const struct nla=
ttr *actions)
>> >  		case OVS_ACTION_ATTR_TRUNC:
>> >  		case OVS_ACTION_ATTR_USERSPACE:
>> >  		case OVS_ACTION_ATTR_DROP:
>> > +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
>> >  			break;
>> >
>> >  		case OVS_ACTION_ATTR_CT:
>> > @@ -2409,7 +2410,7 @@ static void ovs_nla_free_nested_actions(const st=
ruct nlattr *actions, int len)
>> >  	/* Whenever new actions are added, the need to update this
>> >  	 * function should be considered.
>> >  	 */
>> > -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 24);
>> > +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 25);
>> >
>> >  	if (!actions)
>> >  		return;
>> > @@ -3157,6 +3158,29 @@ static int validate_and_copy_check_pkt_len(stru=
ct net *net,
>> >  	return 0;
>> >  }
>> >
>> > +static int validate_emit_sample(const struct nlattr *attr)
>> > +{
>> > +	static const struct nla_policy policy[OVS_EMIT_SAMPLE_ATTR_MAX + 1] =
=3D {
>> > +		[OVS_EMIT_SAMPLE_ATTR_GROUP] =3D { .type =3D NLA_U32 },
>> > +		[OVS_EMIT_SAMPLE_ATTR_COOKIE] =3D {
>> > +			.type =3D NLA_BINARY,
>> > +			.len =3D OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE
>> > +		},
>> > +	};
>> > +	struct nlattr *a[OVS_EMIT_SAMPLE_ATTR_MAX  + 1];
>> > +	int err;
>> > +
>> > +	if (!IS_ENABLED(CONFIG_PSAMPLE))
>> > +		return -EOPNOTSUPP;
>> > +
>> > +	err =3D nla_parse_nested(a, OVS_EMIT_SAMPLE_ATTR_MAX, attr, policy,
>> > +			       NULL);
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	return a[OVS_EMIT_SAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
>> > +}
>> > +
>> >  static int copy_action(const struct nlattr *from,
>> >  		       struct sw_flow_actions **sfa, bool log)
>> >  {
>> > @@ -3212,6 +3236,7 @@ static int __ovs_nla_copy_actions(struct net *ne=
t, const struct nlattr *attr,
>> >  			[OVS_ACTION_ATTR_ADD_MPLS] =3D sizeof(struct ovs_action_add_mpls),
>> >  			[OVS_ACTION_ATTR_DEC_TTL] =3D (u32)-1,
>> >  			[OVS_ACTION_ATTR_DROP] =3D sizeof(u32),
>> > +			[OVS_ACTION_ATTR_EMIT_SAMPLE] =3D (u32)-1,
>> >  		};
>> >  		const struct ovs_action_push_vlan *vlan;
>> >  		int type =3D nla_type(a);
>> > @@ -3490,6 +3515,12 @@ static int __ovs_nla_copy_actions(struct net *n=
et, const struct nlattr *attr,
>> >  				return -EINVAL;
>> >  			break;
>> >
>> > +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
>> > +			err =3D validate_emit_sample(a);
>> > +			if (err)
>> > +				return err;
>> > +			break;
>> > +
>> >  		default:
>> >  			OVS_NLERR(log, "Unknown Action type %d", type);
>> >  			return -EINVAL;
>>
>
> _______________________________________________
> dev mailing list
> dev@openvswitch.org
> https://mail.openvswitch.org/mailman/listinfo/ovs-dev


