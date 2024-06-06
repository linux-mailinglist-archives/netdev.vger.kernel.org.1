Return-Path: <netdev+bounces-101302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F08FE152
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9AE1F22AB0
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BDA13C8F0;
	Thu,  6 Jun 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgEcxUnq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA3282FE
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663329; cv=none; b=EYnp3P5E71zoBGfYG94NGsGLr6kkiH9w3vBmXwwbdAu0XJgFgVqUtCbrWuyEyodur5UDKKl3KELIJbx5xg8kPy3cioR9609Ij9Ltnr5wQhkoYxa5giCk2S10W4vRP/zVUv0Ro68BfgFKj9VJhl0kkvhfj9HK8Nb2kurMm+cKv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663329; c=relaxed/simple;
	bh=mAb+0Iv6Exl25GZ+qLNucVvBGjl2AXfSSYAlWqDLImc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwuG9Q189Nw4XTqJe1NHBhvQS9ai24j75FaJ552r23HQ3rrp627R4E8ZvC2BR7nfADKPrZraLlTDZDbnktq1jcAzQjH9haPp28vvtBZM3WNyboxIRZsJN4MMGIW7Ix0uJJJaRlYNn0VMxd68jctQtJAZfeGurP4qM9ihRwwdWWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgEcxUnq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717663326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3DTzxzZ6ElccSXzynyCH2s3XyyNG1vvqASU4bmMnRVo=;
	b=hgEcxUnqtE78ulE25XoYy89BEJjra+xQQXO7j0RYWHcBDPC3DAlfxugKZUnEZvAAjAk3aw
	XxZ02KbYe6i1+AJMl8otq3VVWsYr+6ZkFSXYRiRzsV+2qQQyskLqrJA+TABzzLnTR1JL22
	sf4HVpMgy1HmnhAZmz9QBF3jK9OR1fw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-qXBmucbkMPujzuAuuNGUng-1; Thu, 06 Jun 2024 04:42:05 -0400
X-MC-Unique: qXBmucbkMPujzuAuuNGUng-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ae259a01ffso9703386d6.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663325; x=1718268125;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DTzxzZ6ElccSXzynyCH2s3XyyNG1vvqASU4bmMnRVo=;
        b=wD6hcQV36NbvrFswoftPsPsdT5J3+8/jgXg4ybXsf3/VdZiILC0QHI+/kJCgLow4gC
         qwh+/D5lnxGajm1KCw9uVsVn//1FcqsWfneGkvZc879XPc9lsvaQeI+N7rgTrmhmTciw
         W1Xzyd1Q/u2ntc7iaetya5HDUpxsoNxtHgknSW0TDT1NkV/ZfnexouvbHQ5HEFrwvJbe
         yeyNwzgJl1SZqdx1pyXBoYkPUpY03Mby4Taf64KCn5TznGG5VnIjED/rDXQgiQ1XcnIe
         MoyKTKiD1E/93yRC1hVQPS8b7qOR98hrCioPh+gJlNqHIcBEseX+de3DYs7Gc2dRIrKa
         UQEg==
X-Gm-Message-State: AOJu0YyjxqJ2DCE3RREzHts0mnZmTwpEHZhiQR9u24mFVGcaiHYh4CSf
	CNXq57U3ZbjnvUrx/k1U/JF1wn7N0SkfIQ5Gaj4RaREYYG3twelx4ksn/eAKeAcWMYR/PpjllGR
	UkQ96/iFRWAsOrsE9V2N0ruwZWOicrmvqvuGyfE+sbDsAtUM8TKjNmodUqxdjSQMDw2PE6dm+27
	9EXck187losXqJzDydJbxhCY/QKlfH
X-Received: by 2002:a05:6214:5989:b0:6af:2342:e15b with SMTP id 6a1803df08f44-6b02bf15cf4mr65772206d6.14.1717663324852;
        Thu, 06 Jun 2024 01:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnOAjXFejTbHf91B2AwD+zLjnOZXa/PeDCbknCOrG22l3HyZQ2rnnA1enJhnGJLoAEXVr6f0JTK6qz9JRxYxg=
X-Received: by 2002:a05:6214:5989:b0:6af:2342:e15b with SMTP id
 6a1803df08f44-6b02bf15cf4mr65772016d6.14.1717663324427; Thu, 06 Jun 2024
 01:42:04 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 08:42:03 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-6-amorenoz@redhat.com>
 <20240605195117.GY791188@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240605195117.GY791188@kernel.org>
Date: Thu, 6 Jun 2024 08:42:03 +0000
Message-ID: <CAG=2xmML3MusD-ro6advb389ctYwaObZE+PBEh14TcXP5AbZJA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 05, 2024 at 08:51:17PM GMT, Simon Horman wrote:
> On Mon, Jun 03, 2024 at 08:56:39PM +0200, Adrian Moreno wrote:
> > Add support for a new action: emit_sample.
> >
> > This action accepts a u32 group id and a variable-length cookie and uses
> > the psample multicast group to make the packet available for
> > observability.
> >
> > The maximum length of the user-defined cookie is set to 16, same as
> > tc_cookie, to discourage using cookies that will not be offloadable.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>
> Hi Adrian,
>
> Some minor nits from my side.
>
> ...
>
> > diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> > index efc82c318fa2..a0e9dde0584a 100644
> > --- a/include/uapi/linux/openvswitch.h
> > +++ b/include/uapi/linux/openvswitch.h
> > @@ -914,6 +914,30 @@ struct check_pkt_len_arg {
> >  };
> >  #endif
> >
> > +#define OVS_EMIT_SAMPLE_COOKIE_MAX_SIZE 16
> > +/**
> > + * enum ovs_emit_sample_attr - Attributes for %OVS_ACTION_ATTR_EMIT_SAMPLE
> > + * action.
> > + *
> > + * @OVS_EMIT_SAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
> > + * sample.
> > + * @OVS_EMIT_SAMPLE_ATTR_COOKIE: A variable-length binary cookie that contains
> > + * user-defined metadata. The maximum length is 16 bytes.
> > + *
> > + * Sends the packet to the psample multicast group with the specified group and
> > + * cookie. It is possible to combine this action with the
> > + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the packet being emitted.
> > + */
> > +enum ovs_emit_sample_attr {
> > +	OVS_EMIT_SAMPLE_ATTR_UNPSEC,
> > +	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
> > +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> > +	__OVS_EMIT_SAMPLE_ATTR_MAX
> > +};
> > +
> > +#define OVS_EMIT_SAMPLE_ATTR_MAX (__OVS_EMIT_SAMPLE_ATTR_MAX - 1)
> > +
> > +
>
> nit: One blank line is enough.
>

Ack.

>      Flagged by checkpatch.pl
>
> >  /**
> >   * enum ovs_action_attr - Action types.
> >   *
> > @@ -1004,6 +1028,7 @@ enum ovs_action_attr {
> >  	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
> >  	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
> >  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
> > +	OVS_ACTION_ATTR_EMIT_SAMPLE,  /* Nested OVS_EMIT_SAMPLE_ATTR_*. */
>
> nit: Please add OVS_ACTION_ATTR_EMIT_SAMPLE to the Kenrel doc
>      for this structure.
>

Thanks for spotting this. Will do.


> >
> >  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
> >  				       * from userspace. */
>
> ...
>


