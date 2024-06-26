Return-Path: <netdev+bounces-107055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E250D9198B5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 22:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9645F283841
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 20:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D211B1922CF;
	Wed, 26 Jun 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqhUhchD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAE13C833
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432427; cv=none; b=g2yF+6Dr+eaUTN3ZwHdFQECdpePniPW6dBb/xvI80D+Gz274sHS6cUlGBdyeKXNG9pcZYLH6xjQ2eg1jQnKHDQS26NCzcXmBLtxQKt6KpFF4RAFvkbi4vEEEOFnpVD9YYUrVyImLEW/BFNz+EB2xohOF7RMui9GmikGp14fsNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432427; c=relaxed/simple;
	bh=tG3svqnmdOmcyo8n1dlR11fYZkpwvs9C3BMK4ENLMdY=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqjqEwv+6Fkracp+HFwONOwxvI0BC08OGBgNav+gtyf08KYGPUtQn1BOpDrQH+QpYRjHH1ydpZdjx+eeV1DS3kpWe/wNL9tZhnE1xCSe6JTKgzsVDmSZp9Nx0iMZVAveX/291UzJcgu+vpA+wErH3YQlMKb+mc0HEoRSe2tgucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqhUhchD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719432424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cn57lmSl8y8vx7nhEOY1O6exPQxSYfQbNqISLWbJZLo=;
	b=QqhUhchDAB/nAgRabZp1tA/cSSMnN29KksSKgo3vbjTIasziAlUuJeuxHgPwtDKbjFeOE3
	ZABL50ICyYSBOCCq9Er3g+WmIl4oMwkcQcr+ZqAa7O5Q+X2UFG/CSqWLbyXlpFzsvio24c
	HNlZCOYNC/0Y9VBi1K7jRqSZ7RxYQxQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-BOQJLpJQM4WvZG3EY6kZ9w-1; Wed, 26 Jun 2024 16:07:03 -0400
X-MC-Unique: BOQJLpJQM4WvZG3EY6kZ9w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c8066074b5so864656a91.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 13:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719432422; x=1720037222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cn57lmSl8y8vx7nhEOY1O6exPQxSYfQbNqISLWbJZLo=;
        b=gJ4fId3I3UmaCPO7kLJIIfFP+igNlAtLM9/GHoXeGqDKZv+KVJ2r5NolTlah42FWRC
         UvR4m++sHD1PVYvbzgor5vUnntj9P6Uj/pNneh8KxNycIGd1uXoE02eiLk5uONFOJtbq
         2fPRUOocb5XRofiuXzJxs++FQ8TwrB1ZrNOVVeI034cDOKok7pF4Mp+StHWmstZcKHrX
         ryTpQTPxB8xFxT7F/3QZdIwmq5MmbJWSsZ7gJzIMuGFyvSms2er/Qx1H8XMLKHyGQH0I
         xvVFmVD4u0/17I1QebyRrpqc5ScuAn9qycwbiumea1B8oeCRW0bak6D8XVd0gF6Wqbon
         e8Gg==
X-Gm-Message-State: AOJu0Yzmsk/d/uSyYkTeOXfjdC8v/KnNudSB+kww4iIdYo+Z08XTXrVs
	9LZ01wE21L5SkPvjMSTPWTGU1nBfamjmg4fYLj+xmTheuMtgFzRcCMlUPJ4B9eQiit6nc2lgylq
	5Md1IOXBVVYRcseQsDQikBBCnMpRr1yZnZ02wGlE0STpj/6WQJK4dkjCkQbHuArZwuSKJB3htVk
	VpWyCrfoUlL7Y+3ZHIA9aFmm4OCLpf
X-Received: by 2002:a17:90a:4302:b0:2c8:dc37:625f with SMTP id 98e67ed59e1d1-2c8dc37663bmr3101836a91.42.1719432422481;
        Wed, 26 Jun 2024 13:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGczBgKpNm9/aDX33RLL/hNAeoiUaVQEeme4d42qMaodTIv+oJEYweKOa2rDLz9XP7S6/uvjPA4hupPac/63ZQ=
X-Received: by 2002:a17:90a:4302:b0:2c8:dc37:625f with SMTP id
 98e67ed59e1d1-2c8dc37663bmr3101805a91.42.1719432422105; Wed, 26 Jun 2024
 13:07:02 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Jun 2024 15:07:00 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com> <20240625205204.3199050-6-amorenoz@redhat.com>
 <f4e9f3db-d9bf-49a9-aa2d-db40b472c82f@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f4e9f3db-d9bf-49a9-aa2d-db40b472c82f@ovn.org>
Date: Wed, 26 Jun 2024 15:07:00 -0500
Message-ID: <CAG=2xmPcLgTFK+o-A9HL4sPcLFqD_DS=H+T2woVLTvoAzU8ajQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 05/10] net: openvswitch: add emit_sample action
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:51:19PM GMT, Ilya Maximets wrote:
> On 6/25/24 22:51, Adrian Moreno wrote:
> > Add support for a new action: emit_sample.
> >
> > This action accepts a u32 group id and a variable-length cookie and use=
s
> > the psample multicast group to make the packet available for
> > observability.
> >
> > The maximum length of the user-defined cookie is set to 16, same as
> > tc_cookie, to discourage using cookies that will not be offloadable.
> >
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
> > + */
> > +enum ovs_emit_sample_attr {
> > +	OVS_EMIT_SAMPLE_ATTR_GROUP =3D 1,	/* u32 number. */
> > +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
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
>
> The 'key' is not used in the function.
>
> > +				const struct nlattr *attr)
> > +{
> > +#if IS_ENABLED(CONFIG_PSAMPLE)
>
> IIUC, the general coding style guideline is to compile out the whole
> function, instead of only the parts.  i.e. something like:
>
> #if IS_ENABLED(CONFIG_PSAMPLE)
> static void execute_emit_sample(...) {
>     <body>
> }
> #else
> #define execute_emit_sample(dp, skb, attr)
> #endif
>
>
> Otherwise, we'll also need to mark the arguments with __maybe_unused.

Thanks for the suggestion, will submit another version with this fix.

Adri=C3=A1n

>
> The rest of the patch looks good to me.
>
> Best regards, Ilya Maximets.
>


