Return-Path: <netdev+bounces-107061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668391991D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 22:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF841F220CC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 20:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A90192B8C;
	Wed, 26 Jun 2024 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCKy9iKT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266D15B10D
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434067; cv=none; b=GpN0AHJfXCbsWQaATiWHS4uYA3U7UWAhQ5LSpxhxBIUVlaTmdhIG6Aplo04q5CBJwlnITpwXUOPbXeCgQFDi4IFjsygGWS9YU+8po4zuFtwW1wX8lkPdTffFT5oGaAZDLPGc8DQ8dxuaHX0USeR366KLKGjq6KumSTB1xK2qE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434067; c=relaxed/simple;
	bh=z0kCSeRR0p3nOuvv5gP2SSz8SB43IqRVLTJRpFxYXTo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOv02/CywU6a5kquQzBlhKSBdxQMfQ0e16j22eiu4IJBpROq6OpN0iNt+CQf+wx7Ing2ZZOj9HkjyrcsCMSb3F5Rxil2bopE8PH01aS2aRJ3f7r3cEtZWNZhpv2bv7G+d13AiTgarxFwIFMvkY2BClANnA17PvNYT+gRCEnVL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCKy9iKT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719434063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7i4p4ud7SxLK7RGKky3kABn0F6ibvKtet+/PcBrLHA=;
	b=QCKy9iKTPln/6E/hQZSu4QOXHpOJJRZjiVtcAX+sFDTC69I3dTLtv2TQPnCduWwWcUleiY
	3WnWhRLkgt7K0wyw/srLVtj7Xr0dsm6fIh3/bHNiw+PAlPbSgZcQZdPB9/MizD4fWtaGO/
	LoN7oNltKmtFsh4UQqk8ejtORql8qVs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-fpD7v-wSOz635dVt5KYhAw-1; Wed, 26 Jun 2024 16:34:22 -0400
X-MC-Unique: fpD7v-wSOz635dVt5KYhAw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b4f87eb2e1so108703666d6.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 13:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434061; x=1720038861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7i4p4ud7SxLK7RGKky3kABn0F6ibvKtet+/PcBrLHA=;
        b=HcjcmSQf7lan5xDxCYip3F90JULMIqMcdWrofq+KLDsiDEn30x8e2J8HdyBiBoFoOT
         AFbtWfnyW9bgrWBfY8CepYsjVEQY3qSeBxTErt10GTYzX9TCwttW0KxtCzo5qRaQcWJj
         4W24wxoBXaAPI1RoFyI2GNQbgprzJokPENUuBYLTKQHSgltKrNuXMR8lOcrtkZraFYBU
         KKnVMRaXizxcd3lzybp9bs6PFOme5K2GrVIV4Rhko8+UlgWuNpnsaCjjBIS+FgfKED+D
         3YAufr51977O7tPL1nFcnfxM6oQNKVjWBTzLsJ3zmDZ32a741QnDdWVNQDBV54kigUJV
         4NJQ==
X-Gm-Message-State: AOJu0YxN2YuW4GjVuBB34IfYyDT/ONJmSPMuuIq+kPWfaEn+IwMfEFK7
	qrMETl06BQ4pD0zYzFvbrhd/QvSYGVfroqqoOYcO2T5C9WMkWO2jFsc9iUK4gV2dN2edKCnRC2n
	ZgYIX/CJT8+yymun9dF5jAmYWtZP4CkWa31PO76ADWvRHG9yw3oijjo8DmahNZlUIrO6+WQuk0i
	/LOn8AWFOyvyldNnqph8MQaWJ6A78ZFd6Qv3n9
X-Received: by 2002:ad4:5c8c:0:b0:6b5:435e:565b with SMTP id 6a1803df08f44-6b5435e57a9mr172476736d6.46.1719434061461;
        Wed, 26 Jun 2024 13:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGChcakuE9eN1J54VW5aTG85djSWvZDgyT55ZxwpDZ/12ruMEFFllk5vlzXYkXd8kgDHa7aNbxPQgPS8WvEInI=
X-Received: by 2002:ad4:5c8c:0:b0:6b5:435e:565b with SMTP id
 6a1803df08f44-6b5435e57a9mr172476486d6.46.1719434061034; Wed, 26 Jun 2024
 13:34:21 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Jun 2024 20:34:20 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com> <20240625205204.3199050-6-amorenoz@redhat.com>
 <EBFCD83F-D2AA-4D0E-A144-AC0975D22315@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <EBFCD83F-D2AA-4D0E-A144-AC0975D22315@redhat.com>
Date: Wed, 26 Jun 2024 20:34:20 +0000
Message-ID: <CAG=2xmOnDZP3QtBbShoAqptY0uSywhFCGAwUYO+UuXfLkMXE7A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample action
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 04:28:17PM GMT, Eelco Chaudron wrote:
>
>
> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
>
> > Add support for a new action: emit_sample.
> >
> > This action accepts a u32 group id and a variable-length cookie and use=
s
> > the psample multicast group to make the packet available for
> > observability.
> >
> > The maximum length of the user-defined cookie is set to 16, same as
> > tc_cookie, to discourage using cookies that will not be offloadable.
>
> I=E2=80=99ll add the same comment as I had in the user space part, and th=
at
> is that I feel from an OVS perspective this action should be called
> emit_local() instead of emit_sample() to make it Datapath independent.
> Or quoting the earlier comment:
>
>
> =E2=80=9CI=E2=80=99ll start the discussion again on the naming. The name =
"emit_sample()"
> does not seem appropriate. This function's primary role is to copy the
> packet and send it to a local collector, which varies depending on the
> datapath. For the kernel datapath, this collector is psample, while for
> userspace, it will likely be some kind of probe. This action is distinct
> from the sample() action by design; it is a standalone action that can
> be combined with others.
>
> Furthermore, the action itself does not involve taking a sample; it
> consistently pushes the packet to the local collector. Therefore, I
> suggest renaming "emit_sample()" to "emit_local()". This same goes for
> all the derivative ATTR naming.=E2=80=9D
>

This is a blurry semantic area.
IMO, "sample" is the act of extracting (potentially a piece of)
someting, in this case, a packet. It is common to only take some packets
as samples, so this action usually comes with some kind of "rate", but
even if the rate is 1, it's still sampling in this context.

OTOH, OVS kernel design tries to be super-modular and define small
combinable actions, so the rate or probability generation is done with
another action which is (IMHO unfortunately) named "sample".

With that interpretation of the term it would actually make more sense
to rename "sample" to something like "random" (of course I'm not
suggestion we do it). "sample" without any nested action that actually
sends the packet somewhere is not sampling, it's just doing something or
not based on a probability. Where as "emit_sample" is sampling even if
it's not nested inside a "sample".

Having said that, I don't have a super strong favor for "emit_sample". I'm
OK with "emit_local" or "emit_packet" or even just "emit".
I don't think any term will fully satisfy everyone so I hope we can find
a reasonable compromise.


> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  Documentation/netlink/specs/ovs_flow.yaml | 17 +++++++++
> >  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
> >  net/openvswitch/Kconfig                   |  1 +
> >  net/openvswitch/actions.c                 | 45 +++++++++++++++++++++++
> >  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++++-
> >  5 files changed, 123 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/=
netlink/specs/ovs_flow.yaml
> > index 4fdfc6b5cae9..a7ab5593a24f 100644
> > --- a/Documentation/netlink/specs/ovs_flow.yaml
> > +++ b/Documentation/netlink/specs/ovs_flow.yaml
> > @@ -727,6 +727,12 @@ attribute-sets:
> >          name: dec-ttl
> >          type: nest
> >          nested-attributes: dec-ttl-attrs
> > +      -
> > +        name: emit-sample
> > +        type: nest
> > +        nested-attributes: emit-sample-attrs
> > +        doc: |
> > +          Sends a packet sample to psample for external observation.
> >    -
> >      name: tunnel-key-attrs
> >      enum-name: ovs-tunnel-key-attr
> > @@ -938,6 +944,17 @@ attribute-sets:
> >        -
> >          name: gbp
> >          type: u32
> > +  -
> > +    name: emit-sample-attrs
> > +    enum-name: ovs-emit-sample-attr
> > +    name-prefix: ovs-emit-sample-attr-
> > +    attributes:
> > +      -
> > +        name: group
> > +        type: u32
> > +      -
> > +        name: cookie
> > +        type: binary
> >
> >  operations:
> >    name-prefix: ovs-flow-cmd-
> > diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/open=
vswitch.h
> > index efc82c318fa2..8cfa1b3f6b06 100644
> > --- a/include/uapi/linux/openvswitch.h
> > +++ b/include/uapi/linux/openvswitch.h
> > @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
> >  };
> >  #endif
> >
> > +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
> > +/**
> > + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_SA=
MPLE
> > + * action.
> > + *
> > + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source o=
f the
> > + * sample.
> > + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that =
contains
> > + * user-defined metadata. The maximum length is OVS_EMIT_SAMPLE_COOKIE=
_MAX_SIZE
> > + * bytes.
> > + *
> > + * Sends the packet to the psample multicast group with the specified =
group and
> > + * cookie. It is possible to combine this action with the
> > + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet being=
 emitted.
>
> Although this include file is kernel-related, it will probably be re-used=
 for
> other datapaths, so should we be more general here?
>

The uAPI header documentation will be used for other datapaths? How so?
At some point we should document what the action does from the kernel
pov, right? Where should we do that if not here?

> > + */
> > +enum ovs_emit_sample_attr {
> > +	OVS_EMIT_SAMPLE_ATTR_GROUP =3D 1,	/* u32 number. */
> > +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
>
> As we start a new set of attributes maybe it would be good starting it of=
f in
> alphabetical order?
>

Having an optional attribute before a mandatory one seems strange to me,
wouldn't you agree?

> > +
> > +	/* private: */
> > +	__OVS_EMIT_SAMPLE_ATTR_MAX
> > +};
> > +
> > +#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
> > +
> >  /**
> >   * enum ovs_action_attr - Action types.
> >   *
> > @@ -966,6 +991,8 @@ struct check_pkt_len_arg {
> >   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPL=
S
> >   * argument.
> >   * @OVS_ACTION_ATTR_DROP: Explicit drop action.
> > + * @OVS_ACTION_ATTR_EMIT_SAMPLE: Send a sample of the packet to extern=
al
> > + * observers via psample.
> >   *
> >   * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.=
  Not all
> >   * fields within a header are modifiable, e.g. the IPv4 protocol and f=
ragment
> > @@ -1004,6 +1031,7 @@ enum ovs_action_attr {
> >  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
> >  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
> >  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> > +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
> >
> >  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
> >  				       * from userspace. */
> > diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
> > index 29a7081858cd..2535f3f9f462 100644
> > --- a/net/openvswitch/Kconfig
> > +++ b/net/openvswitch/Kconfig
> > @@ -10,6 +10,7 @@ config OPENVSWITCH
> >  		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
> >  				     (!NF_NAT || NF_NAT) && \
> >  				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
> > +	depends on PSAMPLE || !PSAMPLE
> >  	select LIBCRC32C
> >  	select MPLS
> >  	select NET_MPLS_GSO
> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > index 964225580824..1f555cbba312 100644
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -24,6 +24,11 @@
> >  #include <net/checksum.h>
> >  #include <net/dsfield.h>
> >  #include <net/mpls.h>
> > +
> > +#if IS_ENABLED(CONFIG_PSAMPLE)
> > +#include <net/psample.h>
> > +#endif
> > +
> >  #include <net/sctp/checksum.h>
> >
> >  #include "datapath.h"
> > @@ -1299,6 +1304,37 @@ static int execute_dec_ttl(struct sk_buff *skb, =
struct sw_flow_key *key)
> >  	return 0;
> >  }
> >
> > +static void execute_emit_sample(struct datapath *dp, struct sk_buff *s=
kb,
> > +				const struct sw_flow_key *key,
> > +				const struct nlattr *attr)
> > +{
> > +#if IS_ENABLED(CONFIG_PSAMPLE)
>
> Same comment as Ilya on key and IS_ENABLED() over function.
>
> > +	struct psample_group psample_group =3D {};
> > +	struct psample_metadata md =3D {};
> > +	const struct nlattr *a;
> > +	int rem;
> > +
> > +	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
> > +		switch (nla_type(a)) {
> > +		case OVS_EMIT_SAMPLE_ATTR_GROUP:
> > +			psample_group.group_num =3D nla_get_u32(a);
> > +			break;
> > +
> > +		case OVS_EMIT_SAMPLE_ATTR_COOKIE:
> > +			md.user_cookie =3D nla_data(a);
> > +			md.user_cookie_len =3D nla_len(a);
>
> Do we need to check for any max cookie length?
>

I don't think so. validate_emit_sample() makes sure the attribute's
length within bounds and checking it in the fast path just in case
some other memory-corrupting bug has changed it seems an overkill.


> > +			break;
> > +		}
> > +	}
> > +
> > +	psample_group.net =3D ovs_dp_get_net(dp);
> > +	md.in_ifindex =3D OVS_CB(skb)->input_vport->dev->ifindex;
> > +	md.trunc_size =3D skb->len - OVS_CB(skb)->cutlen;
> > +
> > +	psample_sample_packet(&psample_group, skb, 0, &md);
> > +#endif
> > +}
> > +
> >  /* Execute a list of actions against 'skb'. */
> >  static int do_execute_actions(struct datapath *dp, struct sk_buff *skb=
,
> >  			      struct sw_flow_key *key,
> > @@ -1502,6 +1538,15 @@ static int do_execute_actions(struct datapath *d=
p, struct sk_buff *skb,
> >  			ovs_kfree_skb_reason(skb, reason);
> >  			return 0;
> >  		}
> > +
> > +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> > +			execute_emit_sample(dp, skb, key, a);
> > +			OVS_CB(skb)->cutlen =3D 0;
> > +			if (nla_is_last(a, rem)) {
> > +				consume_skb(skb);
> > +				return 0;
> > +			}
> > +			break;
> >  		}
> >
> >  		if (unlikely(err)) {
> > diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netl=
ink.c
> > index f224d9bcea5e..29c8cdc44433 100644
> > --- a/net/openvswitch/flow_netlink.c
> > +++ b/net/openvswitch/flow_netlink.c
> > @@ -64,6 +64,7 @@ static bool actions_may_change_flow(const struct nlat=
tr *actions)
> >  		case OVS_ACTION_ATTR_TRUNC:
> >  		case OVS_ACTION_ATTR_USERSPACE:
> >  		case OVS_ACTION_ATTR_DROP:
> > +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> >  			break;
> >
> >  		case OVS_ACTION_ATTR_CT:
> > @@ -2409,7 +2410,7 @@ static void ovs_nla_free_nested_actions(const str=
uct nlattr *actions, int len)
> >  	/* Whenever new actions are added, the need to update this
> >  	 * function should be considered.
> >  	 */
> > -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 24);
> > +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 25);
> >
> >  	if (!actions)
> >  		return;
> > @@ -3157,6 +3158,29 @@ static int validate_and_copy_check_pkt_len(struc=
t net *net,
> >  	return 0;
> >  }
> >
> > +static int validate_emit_sample(const struct nlattr *attr)
> > +{
> > +	static const struct nla_policy policy[OVS_EMIT_SAMPLE_ATTR_MAX + 1] =
=3D {
> > +		[OVS_EMIT_SAMPLE_ATTR_GROUP] =3D { .type =3D NLA_U32 },
> > +		[OVS_EMIT_SAMPLE_ATTR_COOKIE] =3D {
> > +			.type =3D NLA_BINARY,
> > +			.len =3D OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE,
> > +		},
> > +	};
> > +	struct nlattr *a[OVS_EMIT_SAMPLE_ATTR_MAX + 1];
> > +	int err;
> > +
> > +	if (!IS_ENABLED(CONFIG_PSAMPLE))
> > +		return -EOPNOTSUPP;
> > +
> > +	err =3D nla_parse_nested(a, OVS_EMIT_SAMPLE_ATTR_MAX, attr, policy,
> > +			       NULL);
> > +	if (err)
> > +		return err;
> > +
> > +	return a[OVS_EMIT_SAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
>
> So we are ok with not having a cookie? Did you inform Cookie Monster ;)
> Also, update the include help text to reflect this.
>

You mean the uapi header? The enum is defined as:

enum ovs_emit_sample_attr {
	OVS_EMIT_SAMPLE_ATTR_GROUP =3D 1,	/* u32 number. */
	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */

Isn't that clear enough?

> > +}
> > +
> >  static int copy_action(const struct nlattr *from,
> >  		       struct sw_flow_actions **sfa, bool log)
> >  {
> > @@ -3212,6 +3236,7 @@ static int __ovs_nla_copy_actions(struct net *net=
, const struct nlattr *attr,
> >  			[OVS_ACTION_ATTR_ADD_MPLS] =3D sizeof(struct ovs_action_add_mpls),
> >  			[OVS_ACTION_ATTR_DEC_TTL] =3D (u32)-1,
> >  			[OVS_ACTION_ATTR_DROP] =3D sizeof(u32),
> > +			[OVS_ACTION_ATTR_EMIT_SAMPLE] =3D (u32)-1,
> >  		};
> >  		const struct ovs_action_push_vlan *vlan;
> >  		int type =3D nla_type(a);
> > @@ -3490,6 +3515,12 @@ static int __ovs_nla_copy_actions(struct net *ne=
t, const struct nlattr *attr,
> >  				return -EINVAL;
> >  			break;
> >
> > +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> > +			err =3D validate_emit_sample(a);
> > +			if (err)
> > +				return err;
> > +			break;
> > +
> >  		default:
> >  			OVS_NLERR(log, "Unknown Action type %d", type);
> >  			return -EINVAL;
> > --
> > 2.45.1
>


