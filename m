Return-Path: <netdev+bounces-107138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BC191A0E2
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8959F284151
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177A73176;
	Thu, 27 Jun 2024 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEAZrhqU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010F7C097
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474776; cv=none; b=fZtG3mub86TCpaHZkwJhW0sK0O9qKr9P+0muVNnbLBQHdimlrYILSjmnhYm14tnpHDI7nNgpK4z/gMuGdO/v/yhcQqDQebAq8Q9DG7zh4KkSpa2g5LhvI3bgBJOZ+RG9HIzbyHMP9uNvtVVYsBuScrYvCeDgpWRppHGnQLxH1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474776; c=relaxed/simple;
	bh=Ip0K2m//LKarD3jKTVhaK0j0LrQvLDRG2Lb0Z4CwWZE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyoRGg0LyxUynTISm3qOGiM/08vDQzJadeV7olFI4GHJy7NkFEqi0HN6b2ePIJtO6KBv+nMJ9WRqI6XObaa2WzDTL7hkxXKPsdR8YxmpSCNN4BR4NnjTWRYVwXlrUT6p6UQbusniwsBwOKTJer8z0BO5jfnyd4/y1scRBcfeXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEAZrhqU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719474773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhBVXTcYeyRNgmGpPOYjJTk7affIs9ZiSt8yfTtEiDM=;
	b=BEAZrhqUvTYu4jEv0fY3wHusEQ1RPbk5SVqQ6tjP0uh4aEBOLPibG9vtbH+sARnMJJGuz1
	2K88jYSbcCylh4bYDgugXt3/7TTSFBK4CLGsB6+YdqQl6OONJVBVPfuaRo+imrgV6sEBgn
	JmksF0D/gA1bHd8GSD2w2TsFeDvxnrM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Eoh_9xAvNkydN4JgfPl2tg-1; Thu, 27 Jun 2024 03:52:51 -0400
X-MC-Unique: Eoh_9xAvNkydN4JgfPl2tg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c716d15884so9706310a91.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 00:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474770; x=1720079570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QhBVXTcYeyRNgmGpPOYjJTk7affIs9ZiSt8yfTtEiDM=;
        b=UPI5rYGOuB+Q4htGmvjbasBqcorr+XleobF2hFBe00L2+FQxq+T6gSDZHOlJGH55J5
         ox8Ls5oQ2fgplVcsVGPXAiHexB2E087i29KfC76q7xvy2HgPXkZCo0KTx4IsviteT3Dh
         SoVrbMsjXGaJmGmeGCbkXdEoALxA/5rJdD3J7d2GvnbaG8dtRwUMadkj++CRolDZEVay
         SpyIzxUVmGZLrNhhV57lbv9gXT9/Zg6VV89b1tyVs6ybEi/7At14jrDZLQjQiz3l8WKl
         T9SR10x9mvtcpxRKPDVXMiPPcMyOiAwzdlN1QZadVGPUsSWeBkYZeXvTiEpkmOFEvOAz
         gB7g==
X-Gm-Message-State: AOJu0YzcP3iSJO5P3KXDPONbjx1E4dCgXceS7ZlVRBt20P2XU5iGffQz
	Uoqn/m2iNDl2vTmeXR2MVyVn94U+HKMaMyZoobvofc+lQFx/6OHiIfHz2ToQg3ltCIN4sTnFliy
	zTQi/eXGA1wq7KDHD2r/fRi/VY/emzMw1hdYVuXEwDQi5ZtypaoWJs/4eWTiUPIGb1UAK1GTEmG
	vLNZ7R3ZlHiThtFItGJeh7f/1jKFPb
X-Received: by 2002:a17:90a:398f:b0:2c7:c703:ef26 with SMTP id 98e67ed59e1d1-2c8613d5b2emr10555307a91.24.1719474770007;
        Thu, 27 Jun 2024 00:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNKll7hfzXYcqbj7Jm70pAk3MExj+8kRcfaUWC5e5hhfCzG9TN2vI1ecvMcxTsEu0TSfdweMduHCflYtVaZGM=
X-Received: by 2002:a17:90a:398f:b0:2c7:c703:ef26 with SMTP id
 98e67ed59e1d1-2c8613d5b2emr10555285a91.24.1719474769544; Thu, 27 Jun 2024
 00:52:49 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Jun 2024 00:52:47 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com> <20240625205204.3199050-6-amorenoz@redhat.com>
 <EBFCD83F-D2AA-4D0E-A144-AC0975D22315@redhat.com> <CAG=2xmOnDZP3QtBbShoAqptY0uSywhFCGAwUYO+UuXfLkMXE7A@mail.gmail.com>
 <04D55CAD-0BFC-4B62-9827-C3D1A9B7792A@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <04D55CAD-0BFC-4B62-9827-C3D1A9B7792A@redhat.com>
Date: Thu, 27 Jun 2024 00:52:47 -0700
Message-ID: <CAG=2xmMThQvNaS30PRCFMjt1atODZQdyZ9jyVuWbeeXThs5UCg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample action
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Pravin B Shelar <pshelar@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 09:06:46AM GMT, Eelco Chaudron wrote:
>
>
> On 26 Jun 2024, at 22:34, Adri=C3=A1n Moreno wrote:
>
> > On Wed, Jun 26, 2024 at 04:28:17PM GMT, Eelco Chaudron wrote:
> >>
> >>
> >> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
> >>
> >>> Add support for a new action: emit_sample.
> >>>
> >>> This action accepts a u32 group id and a variable-length cookie and u=
ses
> >>> the psample multicast group to make the packet available for
> >>> observability.
> >>>
> >>> The maximum length of the user-defined cookie is set to 16, same as
> >>> tc_cookie, to discourage using cookies that will not be offloadable.
> >>
> >> I=E2=80=99ll add the same comment as I had in the user space part, and=
 that
> >> is that I feel from an OVS perspective this action should be called
> >> emit_local() instead of emit_sample() to make it Datapath independent.
> >> Or quoting the earlier comment:
> >>
> >>
> >> =E2=80=9CI=E2=80=99ll start the discussion again on the naming. The na=
me "emit_sample()"
> >> does not seem appropriate. This function's primary role is to copy the
> >> packet and send it to a local collector, which varies depending on the
> >> datapath. For the kernel datapath, this collector is psample, while fo=
r
> >> userspace, it will likely be some kind of probe. This action is distin=
ct
> >> from the sample() action by design; it is a standalone action that can
> >> be combined with others.
> >>
> >> Furthermore, the action itself does not involve taking a sample; it
> >> consistently pushes the packet to the local collector. Therefore, I
> >> suggest renaming "emit_sample()" to "emit_local()". This same goes for
> >> all the derivative ATTR naming.=E2=80=9D
> >>
> >
> > This is a blurry semantic area.
> > IMO, "sample" is the act of extracting (potentially a piece of)
> > someting, in this case, a packet. It is common to only take some packet=
s
> > as samples, so this action usually comes with some kind of "rate", but
> > even if the rate is 1, it's still sampling in this context.
> >
> > OTOH, OVS kernel design tries to be super-modular and define small
> > combinable actions, so the rate or probability generation is done with
> > another action which is (IMHO unfortunately) named "sample".
> >
> > With that interpretation of the term it would actually make more sense
> > to rename "sample" to something like "random" (of course I'm not
> > suggestion we do it). "sample" without any nested action that actually
> > sends the packet somewhere is not sampling, it's just doing something o=
r
> > not based on a probability. Where as "emit_sample" is sampling even if
> > it's not nested inside a "sample".
>
> You're assuming we are extracting a packet for sampling, but this functio=
n
> can be used for various other purposes. For instance, it could handle the
> packet outside of the OVS pipeline through an eBPF program (so we are not
> taking a sample, but continue packet processing outside of the OVS
> pipeline). Calling it emit_sampling() in such cases could be very
> confusing.
>

Well, I guess that would be clearly abusing the action. You could say
that of anything really. You could hook into skb_consume and continue
processing the skb but that doesn't change the intended behavior of the
drop action.

The intended behavior of the action is sampling, as is the intended
behavior of "psample".

> > Having said that, I don't have a super strong favor for "emit_sample". =
I'm
> > OK with "emit_local" or "emit_packet" or even just "emit".
> > I don't think any term will fully satisfy everyone so I hope we can fin=
d
> > a reasonable compromise.
>
> My preference would be emit_local() as we hand it off to some local
> datapath entity.
>

I'm OK removing the controversial term. Let's see what others think.

> >>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> >>> ---
> >>>  Documentation/netlink/specs/ovs_flow.yaml | 17 +++++++++
> >>>  include/uapi/linux/openvswitch.h          | 28 ++++++++++++++
> >>>  net/openvswitch/Kconfig                   |  1 +
> >>>  net/openvswitch/actions.c                 | 45 +++++++++++++++++++++=
++
> >>>  net/openvswitch/flow_netlink.c            | 33 ++++++++++++++++-
> >>>  5 files changed, 123 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentatio=
n/netlink/specs/ovs_flow.yaml
> >>> index 4fdfc6b5cae9..a7ab5593a24f 100644
> >>> --- a/Documentation/netlink/specs/ovs_flow.yaml
> >>> +++ b/Documentation/netlink/specs/ovs_flow.yaml
> >>> @@ -727,6 +727,12 @@ attribute-sets:
> >>>          name: dec-ttl
> >>>          type: nest
> >>>          nested-attributes: dec-ttl-attrs
> >>> +      -
> >>> +        name: emit-sample
> >>> +        type: nest
> >>> +        nested-attributes: emit-sample-attrs
> >>> +        doc: |
> >>> +          Sends a packet sample to psample for external observation.
> >>>    -
> >>>      name: tunnel-key-attrs
> >>>      enum-name: ovs-tunnel-key-attr
> >>> @@ -938,6 +944,17 @@ attribute-sets:
> >>>        -
> >>>          name: gbp
> >>>          type: u32
> >>> +  -
> >>> +    name: emit-sample-attrs
> >>> +    enum-name: ovs-emit-sample-attr
> >>> +    name-prefix: ovs-emit-sample-attr-
> >>> +    attributes:
> >>> +      -
> >>> +        name: group
> >>> +        type: u32
> >>> +      -
> >>> +        name: cookie
> >>> +        type: binary
> >>>
> >>>  operations:
> >>>    name-prefix: ovs-flow-cmd-
> >>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/op=
envswitch.h
> >>> index efc82c318fa2..8cfa1b3f6b06 100644
> >>> --- a/include/uapi/linux/openvswitch.h
> >>> +++ b/include/uapi/linux/openvswitch.h
> >>> @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
> >>>  };
> >>>  #endif
> >>>
> >>> +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
> >>> +/**
> >>> + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_=
SAMPLE
> >>> + * action.
> >>> + *
> >>> + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source=
 of the
> >>> + * sample.
> >>> + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie tha=
t contains
> >>> + * user-defined metadata. The maximum length is OVS_EMIT_SAMPLE_COOK=
IE_MAX_SIZE
> >>> + * bytes.
> >>> + *
> >>> + * Sends the packet to the psample multicast group with the specifie=
d group and
> >>> + * cookie. It is possible to combine this action with the
> >>> + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet bei=
ng emitted.
> >>
> >> Although this include file is kernel-related, it will probably be re-u=
sed for
> >> other datapaths, so should we be more general here?
> >>
> >
> > The uAPI header documentation will be used for other datapaths? How so?
> > At some point we should document what the action does from the kernel
> > pov, right? Where should we do that if not here?
>
> Well you know how OVS works, all the data paths use the same netlink mess=
ages. Not sure how to solve this, but we could change the text a bit to be =
more general?
>
>  * For the Linux kernel it sends the packet to the psample multicast grou=
p
>  * with the specified group and cookie. It is possible to combine this
>  * action with the %OVS_ACTION_ATTR_TRUNC action to limit the size of the
>  * packet being emitted.
>

I know we reuse the kernel attributes I don't think the uAPI
documentation should be less expressive just because some userspace
application decides to reuse parts of it.

There are many kernel-specific terms all over the uAPI ("netdev",
"netlink pid", "skb", even the action "userspace") that do not make
sense in a non-kernel datapath.

Maybe we can add such a comment in the copy of the header we store in
the ovs tree?


> >>> + */
> >>> +enum ovs_emit_sample_attr {
> >>> +	OVS_EMIT_SAMPLE_ATTR_GROUP =3D 1,	/* u32 number. */
> >>> +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> >>
> >> As we start a new set of attributes maybe it would be good starting it=
 off in
> >> alphabetical order?
> >>
> >
> > Having an optional attribute before a mandatory one seems strange to me=
,
> > wouldn't you agree?
>
> I don't mind, but I don't have a strong opinion on it. If others don't mi=
nd,
> I would leave it as is.
>

I think I prefer to put mandatory attributes first.

> >>> +
> >>> +	/* private: */
> >>> +	__OVS_EMIT_SAMPLE_ATTR_MAX
> >>> +};
> >>> +
> >>> +#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
> >>> +
> >>>  /**
> >>>   * enum ovs_action_attr - Action types.
> >>>   *
> >>> @@ -966,6 +991,8 @@ struct check_pkt_len_arg {
> >>>   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_M=
PLS
> >>>   * argument.
> >>>   * @OVS_ACTION_ATTR_DROP: Explicit drop action.
> >>> + * @OVS_ACTION_ATTR_EMIT_SAMPLE: Send a sample of the packet to exte=
rnal
> >>> + * observers via psample.
>
> * @OVS_ACTION_ATTR_EMIT_SAMPLE: Send a sample of the packet to a data pat=
h
> * local observer.
>
> >>>   *
> >>>   * Only a single header can be set with a single %OVS_ACTION_ATTR_SE=
T.  Not all
> >>>   * fields within a header are modifiable, e.g. the IPv4 protocol and=
 fragment
> >>> @@ -1004,6 +1031,7 @@ enum ovs_action_attr {
> >>>  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
> >>>  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
> >>>  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> >>> +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
> >>>
> >>>  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
> >>>  				       * from userspace. */
> >>> diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
> >>> index 29a7081858cd..2535f3f9f462 100644
> >>> --- a/net/openvswitch/Kconfig
> >>> +++ b/net/openvswitch/Kconfig
> >>> @@ -10,6 +10,7 @@ config OPENVSWITCH
> >>>  		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
> >>>  				     (!NF_NAT || NF_NAT) && \
> >>>  				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
> >>> +	depends on PSAMPLE || !PSAMPLE
> >>>  	select LIBCRC32C
> >>>  	select MPLS
> >>>  	select NET_MPLS_GSO
> >>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> >>> index 964225580824..1f555cbba312 100644
> >>> --- a/net/openvswitch/actions.c
> >>> +++ b/net/openvswitch/actions.c
> >>> @@ -24,6 +24,11 @@
> >>>  #include <net/checksum.h>
> >>>  #include <net/dsfield.h>
> >>>  #include <net/mpls.h>
> >>> +
> >>> +#if IS_ENABLED(CONFIG_PSAMPLE)
> >>> +#include <net/psample.h>
> >>> +#endif
> >>> +
> >>>  #include <net/sctp/checksum.h>
> >>>
> >>>  #include "datapath.h"
> >>> @@ -1299,6 +1304,37 @@ static int execute_dec_ttl(struct sk_buff *skb=
, struct sw_flow_key *key)
> >>>  	return 0;
> >>>  }
> >>>
> >>> +static void execute_emit_sample(struct datapath *dp, struct sk_buff =
*skb,
> >>> +				const struct sw_flow_key *key,
> >>> +				const struct nlattr *attr)
> >>> +{
> >>> +#if IS_ENABLED(CONFIG_PSAMPLE)
> >>
> >> Same comment as Ilya on key and IS_ENABLED() over function.
> >>
> >>> +	struct psample_group psample_group =3D {};
> >>> +	struct psample_metadata md =3D {};
> >>> +	const struct nlattr *a;
> >>> +	int rem;
> >>> +
> >>> +	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
> >>> +		switch (nla_type(a)) {
> >>> +		case OVS_EMIT_SAMPLE_ATTR_GROUP:
> >>> +			psample_group.group_num =3D nla_get_u32(a);
> >>> +			break;
> >>> +
> >>> +		case OVS_EMIT_SAMPLE_ATTR_COOKIE:
> >>> +			md.user_cookie =3D nla_data(a);
> >>> +			md.user_cookie_len =3D nla_len(a);
> >>
> >> Do we need to check for any max cookie length?
> >>
> >
> > I don't think so. validate_emit_sample() makes sure the attribute's
> > length within bounds and checking it in the fast path just in case
> > some other memory-corrupting bug has changed it seems an overkill.
>
> ACK
>
> >>> +			break;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	psample_group.net =3D ovs_dp_get_net(dp);
> >>> +	md.in_ifindex =3D OVS_CB(skb)->input_vport->dev->ifindex;
> >>> +	md.trunc_size =3D skb->len - OVS_CB(skb)->cutlen;
> >>> +
> >>> +	psample_sample_packet(&psample_group, skb, 0, &md);
> >>> +#endif
> >>> +}
> >>> +
> >>>  /* Execute a list of actions against 'skb'. */
> >>>  static int do_execute_actions(struct datapath *dp, struct sk_buff *s=
kb,
> >>>  			      struct sw_flow_key *key,
> >>> @@ -1502,6 +1538,15 @@ static int do_execute_actions(struct datapath =
*dp, struct sk_buff *skb,
> >>>  			ovs_kfree_skb_reason(skb, reason);
> >>>  			return 0;
> >>>  		}
> >>> +
> >>> +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> >>> +			execute_emit_sample(dp, skb, key, a);
> >>> +			OVS_CB(skb)->cutlen =3D 0;
> >>> +			if (nla_is_last(a, rem)) {
> >>> +				consume_skb(skb);
> >>> +				return 0;
> >>> +			}
> >>> +			break;
> >>>  		}
> >>>
> >>>  		if (unlikely(err)) {
> >>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_ne=
tlink.c
> >>> index f224d9bcea5e..29c8cdc44433 100644
> >>> --- a/net/openvswitch/flow_netlink.c
> >>> +++ b/net/openvswitch/flow_netlink.c
> >>> @@ -64,6 +64,7 @@ static bool actions_may_change_flow(const struct nl=
attr *actions)
> >>>  		case OVS_ACTION_ATTR_TRUNC:
> >>>  		case OVS_ACTION_ATTR_USERSPACE:
> >>>  		case OVS_ACTION_ATTR_DROP:
> >>> +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> >>>  			break;
> >>>
> >>>  		case OVS_ACTION_ATTR_CT:
> >>> @@ -2409,7 +2410,7 @@ static void ovs_nla_free_nested_actions(const s=
truct nlattr *actions, int len)
> >>>  	/* Whenever new actions are added, the need to update this
> >>>  	 * function should be considered.
> >>>  	 */
> >>> -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 24);
> >>> +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX !=3D 25);
> >>>
> >>>  	if (!actions)
> >>>  		return;
> >>> @@ -3157,6 +3158,29 @@ static int validate_and_copy_check_pkt_len(str=
uct net *net,
> >>>  	return 0;
> >>>  }
> >>>
> >>> +static int validate_emit_sample(const struct nlattr *attr)
> >>> +{
> >>> +	static const struct nla_policy policy[OVS_EMIT_SAMPLE_ATTR_MAX + 1]=
 =3D {
> >>> +		[OVS_EMIT_SAMPLE_ATTR_GROUP] =3D { .type =3D NLA_U32 },
> >>> +		[OVS_EMIT_SAMPLE_ATTR_COOKIE] =3D {
> >>> +			.type =3D NLA_BINARY,
> >>> +			.len =3D OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE,
> >>> +		},
> >>> +	};
> >>> +	struct nlattr *a[OVS_EMIT_SAMPLE_ATTR_MAX + 1];
> >>> +	int err;
> >>> +
> >>> +	if (!IS_ENABLED(CONFIG_PSAMPLE))
> >>> +		return -EOPNOTSUPP;
> >>> +
> >>> +	err =3D nla_parse_nested(a, OVS_EMIT_SAMPLE_ATTR_MAX, attr, policy,
> >>> +			       NULL);
> >>> +	if (err)
> >>> +		return err;
> >>> +
> >>> +	return a[OVS_EMIT_SAMPLE_ATTR_GROUP] ? 0 : -EINVAL;
> >>
> >> So we are ok with not having a cookie? Did you inform Cookie Monster ;=
)
> >> Also, update the include help text to reflect this.
> >>
> >
> > You mean the uapi header? The enum is defined as:
> >
> > enum ovs_emit_sample_attr {
> > 	OVS_EMIT_SAMPLE_ATTR_GROUP =3D 1,	/* u32 number. */
> > 	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> >
> > Isn't that clear enough?
>
> Missed it as I was looking for it here:
>
> * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that cont=
ains
> * user-defined metadata. The maximum length is OVS_EMIT_SAMPLE_COOKIE_MAX=
_SIZE
> * bytes.
>
> Maybe change it here too by adding option, =E2=80=9CAn optional variable-=
length binary cookie=E2=80=9D?
>

Sure.

> >>> +}
> >>> +
> >>>  static int copy_action(const struct nlattr *from,
> >>>  		       struct sw_flow_actions **sfa, bool log)
> >>>  {
> >>> @@ -3212,6 +3236,7 @@ static int __ovs_nla_copy_actions(struct net *n=
et, const struct nlattr *attr,
> >>>  			[OVS_ACTION_ATTR_ADD_MPLS] =3D sizeof(struct ovs_action_add_mpls)=
,
> >>>  			[OVS_ACTION_ATTR_DEC_TTL] =3D (u32)-1,
> >>>  			[OVS_ACTION_ATTR_DROP] =3D sizeof(u32),
> >>> +			[OVS_ACTION_ATTR_EMIT_SAMPLE] =3D (u32)-1,
> >>>  		};
> >>>  		const struct ovs_action_push_vlan *vlan;
> >>>  		int type =3D nla_type(a);
> >>> @@ -3490,6 +3515,12 @@ static int __ovs_nla_copy_actions(struct net *=
net, const struct nlattr *attr,
> >>>  				return -EINVAL;
> >>>  			break;
> >>>
> >>> +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> >>> +			err =3D validate_emit_sample(a);
> >>> +			if (err)
> >>> +				return err;
> >>> +			break;
> >>> +
> >>>  		default:
> >>>  			OVS_NLERR(log, "Unknown Action type %d", type);
> >>>  			return -EINVAL;
> >>> --
> >>> 2.45.1
> >>
>


