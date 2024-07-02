Return-Path: <netdev+bounces-108344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B435E91EFB4
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F08828528C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 07:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE0412DDAF;
	Tue,  2 Jul 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHrhoyTu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32494CB23
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903908; cv=none; b=OUbS5srnMsupi84WFJ9QZ4txOEbetM3PVFRdlCKmnTSB32wTjKPDJfTxuJN/dawYHM7pfMTmssvYzmaeBWeF/SK3F6bIOluxO8WZakGCtE3MZyeQi9I7SRH9+NP/bqcw7WdMC8ITdkgzOtbDFbu0dV5y1KiW0ZStn7Kj/railtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903908; c=relaxed/simple;
	bh=EoPCih5mKGxCOt1Z9cTsXeh4cFNKaiOFSxgeD//FC2M=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIWIjeFBvxASG3xXIOA0viBqZDYMbHaBsb6oEvGnFBVUwGa4UpHbTJuV7NOflDeBeQ3THQX4PXQXDpM5EkTvupltWiFJCPi+PkqJAgJB0s7orzWm2D+XFkMRdNAG0ATLVO1QHS3FRuZLxDzvQfANWQh07PHqWwLlHdADikixWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHrhoyTu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719903905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efzutW9HnuNZcBmVDI1TMkeEGqVEdgVo01H+ILWp7Ac=;
	b=QHrhoyTugk1robWo2zRCUOSJkLFoVCK3TkLZqQVT3SgOefx21+3Fw4Gj/0lrj1COeLpTs+
	TtiOnBzdQsV5vrXk0tZEahZMqqpZTWhHpmsb3I243d0h5zrvKGyX6VfLswj4QU8aKhz8iu
	eV0PpRJFegRGJajmVRj2X4SkTDGg+jk=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-E2nz3eWOM5mfMfSfpV2ScQ-1; Tue, 02 Jul 2024 03:05:04 -0400
X-MC-Unique: E2nz3eWOM5mfMfSfpV2ScQ-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-80fe50c2b28so802796241.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 00:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903904; x=1720508704;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efzutW9HnuNZcBmVDI1TMkeEGqVEdgVo01H+ILWp7Ac=;
        b=KVxfJg6HAx4H81778mQmggsCd7lkS+6nlxUWdmrgMr+KZT+HtdZfWuObdQfwvU3C3k
         PEWpTb6S6SNTMgnQIm9fljxMXAaSEaXNg44QOPt3B1r3LJmWo6Ce4H4jE7EfVKuwmD9t
         89B5AI3B/WLv6LLxj+fqTWkd31h/t29vTiPgusfSHFHW/CdlFagEy/+9A9SjZ+pJ3omr
         cCgglay4Rs+XhVB1oLI1VP3GpQmBxGMJD4R0PWJIqKrsZM+CfAaNQsytVexjAGlXZ4un
         mRVsdr1Lee+VjN3/LHis0dGB60/lUbEB3Q2FzI6tKDgUYTXc/x4dfIKqXH3XgiI/uvue
         mxjg==
X-Gm-Message-State: AOJu0YzsdiT6qeh5tT+9Pvwcsu9cwmWiCkBUGGMP3f0HjcCTbbDfVb0M
	t6ZW6oU6IwRgGnRTC7Yd3w38Xmu+WlPJoLGqutzWGT50vR2LVxM45ylVyThEZXN1aXRmJmva/cl
	kL1TEFtSdeWIGNV3XqXWiscMQ2HOqIfh+ezjKsIOaPO67KjYPYKHz1a47iZOf2EV0M4DP7ySuce
	kcbL6WzW1gJ/PTP3vaGhsu5UADS9AI
X-Received: by 2002:a67:fd52:0:b0:48f:8e07:1c45 with SMTP id ada2fe7eead31-48faf07d163mr8037988137.1.1719903903592;
        Tue, 02 Jul 2024 00:05:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMQUlw0aoLNQC1idWkR5Ffvb5E602EnWUcDvF/217QkaIVFxOqVK0cek7uFLD5Ir5RwGMJUeZGmztECgxI93M=
X-Received: by 2002:a67:fd52:0:b0:48f:8e07:1c45 with SMTP id
 ada2fe7eead31-48faf07d163mr8037962137.1.1719903903133; Tue, 02 Jul 2024
 00:05:03 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 03:05:02 -0400
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com> <20240630195740.1469727-6-amorenoz@redhat.com>
 <f7to77hvunj.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7to77hvunj.fsf@redhat.com>
Date: Tue, 2 Jul 2024 03:05:02 -0400
Message-ID: <CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, echaudro@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 01, 2024 at 02:23:12PM GMT, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > Add support for a new action: psample.
> >
> > This action accepts a u32 group id and a variable-length cookie and uses
> > the psample multicast group to make the packet available for
> > observability.
> >
> > The maximum length of the user-defined cookie is set to 16, same as
> > tc_cookie, to discourage using cookies that will not be offloadable.
> >
> > Acked-by: Eelco Chaudron <echaudro@redhat.com>
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
>
> Hi Adrian,
>
> Just some nits below.
>
> >  Documentation/netlink/specs/ovs_flow.yaml | 17 ++++++++
> >  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
> >  net/openvswitch/Kconfig                   |  1 +
> >  net/openvswitch/actions.c                 | 47 +++++++++++++++++++++++
> >  net/openvswitch/flow_netlink.c            | 32 ++++++++++++++-
> >  5 files changed, 124 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> > index 4fdfc6b5cae9..46f5d1cd8a5f 100644
> > --- a/Documentation/netlink/specs/ovs_flow.yaml
> > +++ b/Documentation/netlink/specs/ovs_flow.yaml
> > @@ -727,6 +727,12 @@ attribute-sets:
> >          name: dec-ttl
> >          type: nest
> >          nested-attributes: dec-ttl-attrs
> > +      -
> > +        name: psample
> > +        type: nest
> > +        nested-attributes: psample-attrs
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
> > +    name: psample-attrs
> > +    enum-name: ovs-psample-attr
> > +    name-prefix: ovs-psample-attr-
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
> > diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> > index efc82c318fa2..3dd653748725 100644
> > --- a/include/uapi/linux/openvswitch.h
> > +++ b/include/uapi/linux/openvswitch.h
> > @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
> >  };
> >  #endif
> >
> > +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
> > +/**
> > + * enum ovs_psample_attr - Attributes for %OVS_ACTION_ATTR_PSAMPLE
> > + * action.
> > + *
> > + * @OVS_PSAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
> > + * sample.
> > + * @OVS_PSAMPLE_ATTR_COOKIE: An optional variable-length binary cookie that
> > + * contains user-defined metadata. The maximum length is
> > + * OVS_PSAMPLE_COOKIE_MAX_SIZE bytes.
> > + *
> > + * Sends the packet to the psample multicast group with the specified group and
> > + * cookie. It is possible to combine this action with the
> > + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the sample.
> > + */
> > +enum ovs_psample_attr {
> > +	OVS_PSAMPLE_ATTR_GROUP = 1,	/* u32 number. */
> > +	OVS_PSAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> > +
> > +	/* private: */
> > +	__OVS_PSAMPLE_ATTR_MAX
> > +};
> > +
> > +#define OVS_PSAMPLE_ATTR_MAX (__OVS_PSAMPLE_ATTR_MAX - 1)
> > +
> >  /**
> >   * enum ovs_action_attr - Action types.
> >   *
> > @@ -966,6 +991,8 @@ struct check_pkt_len_arg {
> >   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
> >   * argument.
> >   * @OVS_ACTION_ATTR_DROP: Explicit drop action.
> > + * @OVS_ACTION_ATTR_PSAMPLE: Send a sample of the packet to external observers
> > + * via psample.
> >   *
> >   * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.  Not all
> >   * fields within a header are modifiable, e.g. the IPv4 protocol and fragment
> > @@ -1004,6 +1031,7 @@ enum ovs_action_attr {
> >  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
> >  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
> >  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> > +	OVS_ACTION_ATTR_PSAMPLE,      /* Nested OVS_PSAMPLE_ATTR_*. */
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
> > index 964225580824..a035b7e677dd 100644
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
> > @@ -1299,6 +1304,39 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
> >  	return 0;
> >  }
> >
> > +#if IS_ENABLED(CONFIG_PSAMPLE)
> > +static void execute_psample(struct datapath *dp, struct sk_buff *skb,
> > +			    const struct nlattr *attr)
> > +{
> > +	struct psample_group psample_group = {};
> > +	struct psample_metadata md = {};
> > +	const struct nlattr *a;
> > +	int rem;
> > +
> > +	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
> > +		switch (nla_type(a)) {
> > +		case OVS_PSAMPLE_ATTR_GROUP:
> > +			psample_group.group_num = nla_get_u32(a);
> > +			break;
> > +
> > +		case OVS_PSAMPLE_ATTR_COOKIE:
> > +			md.user_cookie = nla_data(a);
> > +			md.user_cookie_len = nla_len(a);
> > +			break;
> > +		}
> > +	}
> > +
> > +	psample_group.net = ovs_dp_get_net(dp);
> > +	md.in_ifindex = OVS_CB(skb)->input_vport->dev->ifindex;
> > +	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
> > +
> > +	psample_sample_packet(&psample_group, skb, 0, &md);
> > +}
> > +#else
> > +static inline void execute_psample(struct datapath *dp, struct sk_buff *skb,
> > +				   const struct nlattr *attr) {}
>
> I noticed that this got flagged in patchwork since it is 'static inline'
> while being part of a complete translation unit - but I also see some
> other places where that has been done.  I guess it should be just
> 'static' though.  I don't feel very strongly about it.
>

We had a bit of discussion about this with Ilya. It seems "static
inline" is a common pattern around the kernel. The coding style
documentation says:
"Generally, inline functions are preferable to macros resembling functions."

So I think this "inline" is correct but I might be missing something.

> > +#endif
> > +
> >  /* Execute a list of actions against 'skb'. */
> >  static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
> >  			      struct sw_flow_key *key,
> > @@ -1502,6 +1540,15 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
> >  			ovs_kfree_skb_reason(skb, reason);
> >  			return 0;
> >  		}
> > +
> > +		case OVS_ACTION_ATTR_PSAMPLE:
> > +			execute_psample(dp, skb, a);
> > +			OVS_CB(skb)->cutlen = 0;
>
> We may want to document that trunc is also impacted by psample calls.
> Right now, it is only mentioned for a single OUTPUT action.
> Alternatively, we could either ignore trunc, or not reset here.

The uAPI header says:

"
Sends the packet to the psample multicast group with the specified group and
cookie. It is possible to combine this action with the
%OVS_ACTION_ATTR_TRUNC action to limit the size of the sample.
"

Isn't this enough? What else would you add to make it even more clear?

>
> > +			if (nla_is_last(a, rem)) {
> > +				consume_skb(skb);
> > +				return 0;
> > +			}
> > +			break;
> >  		}
> >
> >  		if (unlikely(err)) {
> > diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> > index f224d9bcea5e..c92bdc4dfe19 100644
> > --- a/net/openvswitch/flow_netlink.c
> > +++ b/net/openvswitch/flow_netlink.c
> > @@ -64,6 +64,7 @@ static bool actions_may_change_flow(const struct nlattr *actions)
> >  		case OVS_ACTION_ATTR_TRUNC:
> >  		case OVS_ACTION_ATTR_USERSPACE:
> >  		case OVS_ACTION_ATTR_DROP:
> > +		case OVS_ACTION_ATTR_PSAMPLE:
> >  			break;
> >
> >  		case OVS_ACTION_ATTR_CT:
> > @@ -2409,7 +2410,7 @@ static void ovs_nla_free_nested_actions(const struct nlattr *actions, int len)
> >  	/* Whenever new actions are added, the need to update this
> >  	 * function should be considered.
> >  	 */
> > -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 24);
> > +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 25);
> >
> >  	if (!actions)
> >  		return;
> > @@ -3157,6 +3158,28 @@ static int validate_and_copy_check_pkt_len(struct net *net,
> >  	return 0;
> >  }
> >
> > +static int validate_psample(const struct nlattr *attr)
> > +{
> > +	static const struct nla_policy policy[OVS_PSAMPLE_ATTR_MAX + 1] = {
> > +		[OVS_PSAMPLE_ATTR_GROUP] = { .type = NLA_U32 },
> > +		[OVS_PSAMPLE_ATTR_COOKIE] = {
> > +			.type = NLA_BINARY,
> > +			.len = OVS_PSAMPLE_COOKIE_MAX_SIZE,
> > +		},
> > +	};
> > +	struct nlattr *a[OVS_PSAMPLE_ATTR_MAX + 1];
> > +	int err;
> > +
> > +	if (!IS_ENABLED(CONFIG_PSAMPLE))
> > +		return -EOPNOTSUPP;
> > +
> > +	err = nla_parse_nested(a, OVS_PSAMPLE_ATTR_MAX, attr, policy, NULL);
> > +	if (err)
> > +		return err;
> > +
> > +	return a[OVS_PSAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
> > +}
> > +
> >  static int copy_action(const struct nlattr *from,
> >  		       struct sw_flow_actions **sfa, bool log)
> >  {
> > @@ -3212,6 +3235,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
> >  			[OVS_ACTION_ATTR_ADD_MPLS] = sizeof(struct ovs_action_add_mpls),
> >  			[OVS_ACTION_ATTR_DEC_TTL] = (u32)-1,
> >  			[OVS_ACTION_ATTR_DROP] = sizeof(u32),
> > +			[OVS_ACTION_ATTR_PSAMPLE] = (u32)-1,
> >  		};
> >  		const struct ovs_action_push_vlan *vlan;
> >  		int type = nla_type(a);
> > @@ -3490,6 +3514,12 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
> >  				return -EINVAL;
> >  			break;
> >
> > +		case OVS_ACTION_ATTR_PSAMPLE:
> > +			err = validate_psample(a);
> > +			if (err)
> > +				return err;
> > +			break;
> > +
> >  		default:
> >  			OVS_NLERR(log, "Unknown Action type %d", type);
> >  			return -EINVAL;
>


