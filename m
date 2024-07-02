Return-Path: <netdev+bounces-108351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE3091F026
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E742BB25881
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1FD13D248;
	Tue,  2 Jul 2024 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdffy3qC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A96A342
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905395; cv=none; b=AR3LRxs5DPeQzypkRuocJl1m27JsI2RrTv3qoSQ/7lQC0wVcAe+vrI2U3A4U8bZjNIcNCGby9vYUEu04s6DtXptEq4larphQSQaxhl/nlpKpxCB8efJv/io/IZCtLVpqM/f39U/fVwx0pa321cRcjSUwyhxItOpaYhfJ4G85C24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905395; c=relaxed/simple;
	bh=bfVnS6NKMBAojAFWG2JYnGEFUttsjPkYDcfSFCx5Vl8=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKmCO+WF9mMMp6bNE3xCOz0Y1mXw3ZzLQ7OHMdnD9nD7YURV02z27GN6N6aOIp710n3gaAuO/2TSE6ciu4aFRZ65e3JNTLPz9tv66H+k44FfgF769PdflFAVtc2KCoObTkNNwpVFhVjR/X94wtNfzypsrC2jFY2b49e5vO88zLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mdffy3qC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719905392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1t1VX1FPPf7M5kvC0Ub3lR8q6GwtqOCWGoEzUAt3iZM=;
	b=Mdffy3qCWUAyJCEYniitILpuhP6owUFi97N90EgtGOp+ixk1Gu/qNPAAQwgXzq/fn+KusN
	01Nye6xI2xzJE8wUTKcilsNDgzsstyw84mpe+sPx7lHou1xkDPdf0LdQzJSAKsGKBgWgUw
	e8g9vsZlcywnFvxcYv3Khl3TzXCyOOI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496--HKtxV6rOqS0oc8GOmyU0w-1; Tue, 02 Jul 2024 03:29:50 -0400
X-MC-Unique: -HKtxV6rOqS0oc8GOmyU0w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4465957b905so41041071cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 00:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719905389; x=1720510189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1t1VX1FPPf7M5kvC0Ub3lR8q6GwtqOCWGoEzUAt3iZM=;
        b=uX4AXVWYonUVe4ruM4/Qdg7Mpd53BSs3BkpW6oi/n/ECLNW1V++aQ0DyRsCUZw021N
         gVi5/LTorbgaoS+zRkJzCe7Kpja8V1eiWBHrwQUZ0JN4nsebzw4fRmbG08X0P5Xs9BJU
         5v8aJPG2mARxFiGPWavMedUMtfJyj7lBSWK2w1IVoCv/ggaJrC3HQnWuNxKiNeX9c/Hf
         PMhcQEanpyCggf+ujYHYSOcA8ocH59SeP0RZdvdeMGreAQqGD+07n1co/dGOWY3Rkz5P
         FcSX+twPZ9p4+zYOvvK74KuUBxCbU5jOmXZBWCuruX5kb1AwbcKa8Tw+grCCyZkpgkf+
         vSXg==
X-Gm-Message-State: AOJu0YziUKDcjov7spRGIveig7nkEK1iwlAjRjy9ONX5108in7UfLIyt
	qtGi6NjnhRLjAWBlGJfccRdnctRSGjUWIMAembQWU6wOY4FeK2B0XPRizMRzbHqAeCW8yLN8Xmc
	Bs+/YbYIT4ckuHtNrx79Ero1uk41OfTii4NzZy2nOEBsZIEBAftjEqv99Lqqzblx1xqqGldlzTO
	9gArHuZQM2a47ZNZfuoypLpPtVLgYS
X-Received: by 2002:a05:6214:2b09:b0:6b0:6cd1:cffd with SMTP id 6a1803df08f44-6b5b70f8ba9mr85204656d6.26.1719905389438;
        Tue, 02 Jul 2024 00:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnJqjY6fXUozq5TE9pquHwVgfxdCNEjiMY5YQJ95AhmsTFoOzF7Q+F4oOaGioVTOZE/hal5LFlVmFuoTDOL8c=
X-Received: by 2002:a05:6214:2b09:b0:6b0:6cd1:cffd with SMTP id
 6a1803df08f44-6b5b70f8ba9mr85204486d6.26.1719905389093; Tue, 02 Jul 2024
 00:29:49 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 03:29:48 -0400
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com> <20240630195740.1469727-6-amorenoz@redhat.com>
 <f7to77hvunj.fsf@redhat.com> <CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
Date: Tue, 2 Jul 2024 03:29:48 -0400
Message-ID: <CAG=2xmNG7GLQs1Yu3aNPF_mEs0r8AEt27=2mQxQ8uDhg=V4Uyg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, echaudro@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 03:05:02AM GMT, Adri=C3=A1n Moreno wrote:
> On Mon, Jul 01, 2024 at 02:23:12PM GMT, Aaron Conole wrote:
> > Adrian Moreno <amorenoz@redhat.com> writes:
> >
> > > Add support for a new action: psample.
> > >
> > > This action accepts a u32 group id and a variable-length cookie and u=
ses
> > > the psample multicast group to make the packet available for
> > > observability.
> > >
> > > The maximum length of the user-defined cookie is set to 16, same as
> > > tc_cookie, to discourage using cookies that will not be offloadable.
> > >
> > > Acked-by: Eelco Chaudron <echaudro@redhat.com>
> > > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > > ---
> >
> > Hi Adrian,
> >
> > Just some nits below.
> >
> > >  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
> > >  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
> > >  net/openvswitch/Kconfig                   |  1 +
> > >  net/openvswitch/actions.c                 | 47 +++++++++++++++++++++=
++
> > >  net/openvswitch/flow_netlink.c            | 32 ++++++++++++++-
> > >  5 files changed, 124 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentatio=
n/netlink/specs/ovs_flow.yaml
> > > index 4fdfc6b5cae9..46f5d1cd8a5f 100644
> > > --- a/Documentation/netlink/specs/ovs_flow.yaml
> > > +++ b/Documentation/netlink/specs/ovs_flow.yaml
> > > @@ -727,6 +727,12 @@ attribute-sets:
> > >          name: dec-ttl
> > >          type: nest
> > >          nested-attributes: dec-ttl-attrs
> > > +      -
> > > +        name: psample
> > > +        type: nest
> > > +        nested-attributes: psample-attrs
> > > +        doc: |
> > > +          Sends a packet sample to psample for external observation.
> > >    -
> > >      name: tunnel-key-attrs
> > >      enum-name: ovs-tunnel-key-attr
> > > @@ -938,6 +944,17 @@ attribute-sets:
> > >        -
> > >          name: gbp
> > >          type: u32
> > > +  -
> > > +    name: psample-attrs
> > > +    enum-name: ovs-psample-attr
> > > +    name-prefix: ovs-psample-attr-
> > > +    attributes:
> > > +      -
> > > +        name: group
> > > +        type: u32
> > > +      -
> > > +        name: cookie
> > > +        type: binary
> > >
> > >  operations:
> > >    name-prefix: ovs-flow-cmd-
> > > diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/op=
envswitch.h
> > > index efc82c318fa2..3dd653748725 100644
> > > --- a/include/uapi/linux/openvswitch.h
> > > +++ b/include/uapi/linux/openvswitch.h
> > > @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
> > >  };
> > >  #endif
> > >
> > > +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
> > > +/**
> > > + * enum ovs_psample_attr - Attributes for %OVS_ACTION_ATTR_PSAMPLE
> > > + * action.
> > > + *
> > > + * @OVS_PSAMPLE_ATTR_GROUP: 32-bit number to identify the source of =
the
> > > + * sample.
> > > + * @OVS_PSAMPLE_ATTR_COOKIE: An optional variable-length binary cook=
ie that
> > > + * contains user-defined metadata. The maximum length is
> > > + * OVS_PSAMPLE_COOKIE_MAX_SIZE bytes.
> > > + *
> > > + * Sends the packet to the psample multicast group with the specifie=
d group and
> > > + * cookie. It is possible to combine this action with the
> > > + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the sample.
> > > + */
> > > +enum ovs_psample_attr {
> > > +	OVS_PSAMPLE_ATTR_GROUP =3D 1,	/* u32 number. */
> > > +	OVS_PSAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> > > +
> > > +	/* private: */
> > > +	__OVS_PSAMPLE_ATTR_MAX
> > > +};
> > > +
> > > +#define OVS_PSAMPLE_ATTR_MAX (__OVS_PSAMPLE_ATTR_MAX - 1)
> > > +
> > >  /**
> > >   * enum ovs_action_attr - Action types.
> > >   *
> > > @@ -966,6 +991,8 @@ struct check_pkt_len_arg {
> > >   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_M=
PLS
> > >   * argument.
> > >   * @OVS_ACTION_ATTR_DROP: Explicit drop action.
> > > + * @OVS_ACTION_ATTR_PSAMPLE: Send a sample of the packet to external=
 observers
> > > + * via psample.
> > >   *
> > >   * Only a single header can be set with a single %OVS_ACTION_ATTR_SE=
T.  Not all
> > >   * fields within a header are modifiable, e.g. the IPv4 protocol and=
 fragment
> > > @@ -1004,6 +1031,7 @@ enum ovs_action_attr {
> > >  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
> > >  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
> > >  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> > > +	OVS_ACTION_ATTR_PSAMPLE,      /* Nested OVS_PSAMPLE_ATTR_*. */
> > >
> > >  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
> > >  				       * from userspace. */
> > > diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
> > > index 29a7081858cd..2535f3f9f462 100644
> > > --- a/net/openvswitch/Kconfig
> > > +++ b/net/openvswitch/Kconfig
> > > @@ -10,6 +10,7 @@ config OPENVSWITCH
> > >  		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
> > >  				     (!NF_NAT || NF_NAT) && \
> > >  				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
> > > +	depends on PSAMPLE || !PSAMPLE
> > >  	select LIBCRC32C
> > >  	select MPLS
> > >  	select NET_MPLS_GSO
> > > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > > index 964225580824..a035b7e677dd 100644
> > > --- a/net/openvswitch/actions.c
> > > +++ b/net/openvswitch/actions.c
> > > @@ -24,6 +24,11 @@
> > >  #include <net/checksum.h>
> > >  #include <net/dsfield.h>
> > >  #include <net/mpls.h>
> > > +
> > > +#if IS_ENABLED(CONFIG_PSAMPLE)
> > > +#include <net/psample.h>
> > > +#endif
> > > +
> > >  #include <net/sctp/checksum.h>
> > >
> > >  #include "datapath.h"
> > > @@ -1299,6 +1304,39 @@ static int execute_dec_ttl(struct sk_buff *skb=
, struct sw_flow_key *key)
> > >  	return 0;
> > >  }
> > >
> > > +#if IS_ENABLED(CONFIG_PSAMPLE)
> > > +static void execute_psample(struct datapath *dp, struct sk_buff *skb=
,
> > > +			    const struct nlattr *attr)
> > > +{
> > > +	struct psample_group psample_group =3D {};
> > > +	struct psample_metadata md =3D {};
> > > +	const struct nlattr *a;
> > > +	int rem;
> > > +
> > > +	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
> > > +		switch (nla_type(a)) {
> > > +		case OVS_PSAMPLE_ATTR_GROUP:
> > > +			psample_group.group_num =3D nla_get_u32(a);
> > > +			break;
> > > +
> > > +		case OVS_PSAMPLE_ATTR_COOKIE:
> > > +			md.user_cookie =3D nla_data(a);
> > > +			md.user_cookie_len =3D nla_len(a);
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	psample_group.net =3D ovs_dp_get_net(dp);
> > > +	md.in_ifindex =3D OVS_CB(skb)->input_vport->dev->ifindex;
> > > +	md.trunc_size =3D skb->len - OVS_CB(skb)->cutlen;
> > > +
> > > +	psample_sample_packet(&psample_group, skb, 0, &md);
> > > +}
> > > +#else
> > > +static inline void execute_psample(struct datapath *dp, struct sk_bu=
ff *skb,
> > > +				   const struct nlattr *attr) {}
> >
> > I noticed that this got flagged in patchwork since it is 'static inline=
'
> > while being part of a complete translation unit - but I also see some
> > other places where that has been done.  I guess it should be just
> > 'static' though.  I don't feel very strongly about it.
> >
>
> We had a bit of discussion about this with Ilya. It seems "static
> inline" is a common pattern around the kernel. The coding style
> documentation says:
> "Generally, inline functions are preferable to macros resembling function=
s."
>
> So I think this "inline" is correct but I might be missing something.
>
> > > +#endif
> > > +
> > >  /* Execute a list of actions against 'skb'. */
> > >  static int do_execute_actions(struct datapath *dp, struct sk_buff *s=
kb,
> > >  			      struct sw_flow_key *key,
> > > @@ -1502,6 +1540,15 @@ static int do_execute_actions(struct datapath =
*dp, struct sk_buff *skb,
> > >  			ovs_kfree_skb_reason(skb, reason);
> > >  			return 0;
> > >  		}
> > > +
> > > +		case OVS_ACTION_ATTR_PSAMPLE:
> > > +			execute_psample(dp, skb, a);
> > > +			OVS_CB(skb)->cutlen =3D 0;
> >
> > We may want to document that trunc is also impacted by psample calls.
> > Right now, it is only mentioned for a single OUTPUT action.
> > Alternatively, we could either ignore trunc, or not reset here.
>
> The uAPI header says:
>
> "
> Sends the packet to the psample multicast group with the specified group =
and
> cookie. It is possible to combine this action with the
> %OVS_ACTION_ATTR_TRUNC action to limit the size of the sample.
> "
>
> Isn't this enough? What else would you add to make it even more clear?
>

BTW trunc also affects userspace and it's not explicitly documented.

> >
> > > +			if (nla_is_last(a, rem)) {
> > > +				consume_skb(skb);
> > > +				return 0;
> > > +			}
> > > +			break;
> > >  		}
> > >
> > >  		if (unlikely(err)) {
> > > diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_ne=
tlink.c
> > > index f224d9bcea5e..c92bdc4dfe19 100644
> > > --- a/net/openvswitch/flow_netlink.c
> > > +++ b/net/openvswitch/flow_netlink.c
> > > @@ -64,6 +64,7 @@ static bool actions_may_change_flow(const struct nl=
attr *actions)
> > >  		case OVS_ACTION_ATTR_TRUNC:
> > >  		case OVS_ACTION_ATTR_USERSPACE:
> > >  		case OVS_ACTION_ATTR_DROP:
> > > +		case OVS_ACTION_ATTR_PSAMPLE:
> > >  			break;
> > >
> > >  		case OVS_ACTION_ATTR_CT:
> > > @@ -2409,7 +2410,7 @@ static void ovs_nla_free_nested_actions(const s=
truct nlattr *actions, int len)
> > >  	/* Whenever new actions are added, the need to update this
> > >  	 * function should be considered.
> > >  	 */
> > > -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 24);
> > > +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 25);
> > >
> > >  	if (!actions)
> > >  		return;
> > > @@ -3157,6 +3158,28 @@ static int validate_and_copy_check_pkt_len(str=
uct net *net,
> > >  	return 0;
> > >  }
> > >
> > > +static int validate_psample(const struct nlattr *attr)
> > > +{
> > > +	static const struct nla_policy policy[OVS_PSAMPLE_ATTR_MAX + 1] =3D=
 {
> > > +		[OVS_PSAMPLE_ATTR_GROUP] =3D { .type =3D NLA_U32 },
> > > +		[OVS_PSAMPLE_ATTR_COOKIE] =3D {
> > > +			.type =3D NLA_BINARY,
> > > +			.len =3D OVS_PSAMPLE_COOKIE_MAX_SIZE,
> > > +		},
> > > +	};
> > > +	struct nlattr *a[OVS_PSAMPLE_ATTR_MAX + 1];
> > > +	int err;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_PSAMPLE))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	err =3D nla_parse_nested(a, OVS_PSAMPLE_ATTR_MAX, attr, policy, NUL=
L);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return a[OVS_PSAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
> > > +}
> > > +
> > >  static int copy_action(const struct nlattr *from,
> > >  		       struct sw_flow_actions **sfa, bool log)
> > >  {
> > > @@ -3212,6 +3235,7 @@ static int __ovs_nla_copy_actions(struct net *n=
et, const struct nlattr *attr,
> > >  			[OVS_ACTION_ATTR_ADD_MPLS] =3D sizeof(struct ovs_action_add_mpls)=
,
> > >  			[OVS_ACTION_ATTR_DEC_TTL] =3D (u32)-1,
> > >  			[OVS_ACTION_ATTR_DROP] =3D sizeof(u32),
> > > +			[OVS_ACTION_ATTR_PSAMPLE] =3D (u32)-1,
> > >  		};
> > >  		const struct ovs_action_push_vlan *vlan;
> > >  		int type =3D nla_type(a);
> > > @@ -3490,6 +3514,12 @@ static int __ovs_nla_copy_actions(struct net *=
net, const struct nlattr *attr,
> > >  				return -EINVAL;
> > >  			break;
> > >
> > > +		case OVS_ACTION_ATTR_PSAMPLE:
> > > +			err =3D validate_psample(a);
> > > +			if (err)
> > > +				return err;
> > > +			break;
> > > +
> > >  		default:
> > >  			OVS_NLERR(log, "Unknown Action type %d", type);
> > >  			return -EINVAL;
> >


