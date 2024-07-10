Return-Path: <netdev+bounces-110577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F192D386
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D5628365A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03319345A;
	Wed, 10 Jul 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0WDjwl1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20519308C
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619706; cv=none; b=WnlZiw9A0JumUFynlSjIF7fbKdyryvC58Cf9KU7CvERoUml2Y/BKxLw1U1eukx2hGc1kVSRbPdNEJRTCqKoJHV5f8mQKiIu6YhdFB/gKO64Y0Z2iKEaIT9dBZBF+a3sRLA8k2BOyMiRw07HJclwBtervekEoAy17yAcH+pCSDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619706; c=relaxed/simple;
	bh=/vQS+m3I+WShBYkdmYNWSEzCgnso6cWRLNTBr3f5YXk=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfRVmjEXKS3UIBRBuQoS24l8xmYBubvywUNoT4+8McYMNNW3WQlxChOFzFR8Ry9ZPwNbinagNxJt6it6l5ccRmJb4ieYxz7qTagm7mxAnmW28VDkzIYc9bP4gIfNKVTWqeKFLTNl3cCMSL+f0NRVqvHDYBIlHLolK7SDHYGOnyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0WDjwl1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720619701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ULzzkEfMVprFYmlUPwuf4Dn35V0ZDb9YXHeutLKiZQ=;
	b=R0WDjwl1SCWZpweN5TVsECmHYLxEY/3QkLwhi7Pz2atupw4zQLbR3Hy+xy+AZzUmRKauAV
	kV8qk7cu6brbqLuYpHuvPBQuh0Xg5yPkIfoUWTVcrTunEcQFGyiaYNxP6goqJtInDj/P5D
	yua17gfGo/kCcTtVpSipv/mKNNPvO9g=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-SAukwJyjPOy9phpCYt0YxQ-1; Wed, 10 Jul 2024 09:55:00 -0400
X-MC-Unique: SAukwJyjPOy9phpCYt0YxQ-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4f353d2d086so542596e0c.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 06:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619700; x=1721224500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ULzzkEfMVprFYmlUPwuf4Dn35V0ZDb9YXHeutLKiZQ=;
        b=RtX6KYooUUyeq6hKoLQxuISRcEnBpItdJZ3A4+Oxq9OnQVCDGe3pPtuHITvbgkPDot
         jOyYVlcIkqdCz+vlz+pk2Q9tSH7tXUiXfiUNs1T38BaOF+uJ6+CtBkLjv13G4+iMnzF1
         +mM/Ur08yrp4FVlQA5JyoFKajWW57NLUIjSsseR9g+O7lTnVOF5hx5XDe1zommrWL8pB
         rp7XAdO7U9EP9FqdJ7cFZ+LlKx1Gll1mRa1NfoW2tA3KSHHFqydoOYid3mdCvtM5MdOd
         i8SZ6R3MOJ3d9rJhwIfZuh3R3PQUPi93ZdiqBl1WMtztpcX+VdJMjDZFBLduStnUr4IC
         +Tcw==
X-Gm-Message-State: AOJu0YxMzTJAfcORtrSj0KA1rycN6zWkm7BxH66YXwNJ7/zqCEDh4b2K
	ow/XAU/e4iZH1+ERw/aD1Nm9L9+biq/x11h3AeH/nabHLarORwhyM6yDKQzX9rDNgMocKbm40W4
	TRf0FguIlz6wxLqzPNz2N2Do8w3DcqJf+TiLUIdxqXIyjETTocQ3BIi35zjTTSNd9j40Rz8kkAg
	PtP3jGDcpb3syFh/JZi5ML7p0wclf5
X-Received: by 2002:a05:6122:2a53:b0:4ef:27dc:7a9 with SMTP id 71dfb90a1353d-4f33f015c84mr6760429e0c.0.1720619699485;
        Wed, 10 Jul 2024 06:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFldYL92EKxMspg7c4mNvh7EAGarCSrJr328WWTXoMqSyo72JAq3CnjwFFbA0fEw9fqrVxQ/O1OuQeOmV1FBx4=
X-Received: by 2002:a05:6122:2a53:b0:4ef:27dc:7a9 with SMTP id
 71dfb90a1353d-4f33f015c84mr6760408e0c.0.1720619699115; Wed, 10 Jul 2024
 06:54:59 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 13:54:58 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240710090742.1657606-1-amorenoz@redhat.com> <172061821475.5582.9226948763101271068@kwain.local>
 <CAG=2xmNR8Uw2Ecw=NS5BoRGoWWp7hJgd4zxKTRbSrq+VVKq5Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=2xmNR8Uw2Ecw=NS5BoRGoWWp7hJgd4zxKTRbSrq+VVKq5Uw@mail.gmail.com>
Date: Wed, 10 Jul 2024 13:54:58 +0000
Message-ID: <CAG=2xmPQuaOEdktezoe-ghr-Lnax_h19Ho3-e8pEBhwH_t=kCg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: psample: fix flag being set in wrong skb
To: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, Yotam Gigi <yotam.gi@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 01:51:59PM GMT, Adri=C3=A1n Moreno wrote:
> On Wed, Jul 10, 2024 at 03:30:14PM GMT, Antoine Tenart wrote:
> > Hi Adri=C3=A1n,
> >
> > Quoting Adrian Moreno (2024-07-10 11:07:42)
> > > A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wr=
ong
> > > sk_buff.
> > >
> > > Fix the error and make the input sk_buff pointer "const" so that it
> > > doesn't happen again.
> > >
> > > Also modify OVS psample test to verify the flag is properly emitted.
> >
> > I don't see that part; although it can be sent as a follow-up and not
> > part of the fix.
>
> Yep. Sorry I was planning to add it to the fix but thought it was better
> off as a follow-up. I should have removed this comment.
>

I'll resend the series without that comment.

> >
> > Thanks,
> > Antoine
> >
> > > Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> > > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > > ---
> > >  include/net/psample.h | 8 +++++---
> > >  net/psample/psample.c | 7 ++++---
> > >  2 files changed, 9 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/net/psample.h b/include/net/psample.h
> > > index c52e9ebd88dd..5071b5fc2b59 100644
> > > --- a/include/net/psample.h
> > > +++ b/include/net/psample.h
> > > @@ -38,13 +38,15 @@ struct sk_buff;
> > >
> > >  #if IS_ENABLED(CONFIG_PSAMPLE)
> > >
> > > -void psample_sample_packet(struct psample_group *group, struct sk_bu=
ff *skb,
> > > -                          u32 sample_rate, const struct psample_meta=
data *md);
> > > +void psample_sample_packet(struct psample_group *group,
> > > +                          const struct sk_buff *skb, u32 sample_rate=
,
> > > +                          const struct psample_metadata *md);
> > >
> > >  #else
> > >
> > >  static inline void psample_sample_packet(struct psample_group *group=
,
> > > -                                        struct sk_buff *skb, u32 sam=
ple_rate,
> > > +                                        const struct sk_buff *skb,
> > > +                                        u32 sample_rate,
> > >                                          const struct psample_metadat=
a *md)
> > >  {
> > >  }
> > > diff --git a/net/psample/psample.c b/net/psample/psample.c
> > > index f48b5b9cd409..a0ddae8a65f9 100644
> > > --- a/net/psample/psample.c
> > > +++ b/net/psample/psample.c
> > > @@ -360,8 +360,9 @@ static int psample_tunnel_meta_len(struct ip_tunn=
el_info *tun_info)
> > >  }
> > >  #endif
> > >
> > > -void psample_sample_packet(struct psample_group *group, struct sk_bu=
ff *skb,
> > > -                          u32 sample_rate, const struct psample_meta=
data *md)
> > > +void psample_sample_packet(struct psample_group *group,
> > > +                          const struct sk_buff *skb, u32 sample_rate=
,
> > > +                          const struct psample_metadata *md)
> > >  {
> > >         ktime_t tstamp =3D ktime_get_real();
> > >         int out_ifindex =3D md->out_ifindex;
> > > @@ -498,7 +499,7 @@ void psample_sample_packet(struct psample_group *=
group, struct sk_buff *skb,
> > >                 goto error;
> > >
> > >         if (md->rate_as_probability)
> > > -               nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> > > +               nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY)=
;
> > >
> > >         genlmsg_end(nl_skb, data);
> > >         genlmsg_multicast_netns(&psample_nl_family, group->net, nl_sk=
b, 0,
> > > --
> > > 2.45.2
> > >
> > >
> >


