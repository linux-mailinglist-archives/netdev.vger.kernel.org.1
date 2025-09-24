Return-Path: <netdev+bounces-225755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B8B97FA5
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1405019C6BA7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D91F1306;
	Wed, 24 Sep 2025 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJrgGNt7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408A1DB95E
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676332; cv=none; b=K9bWxVli2OxFujqIhNKeyakW6ZhSkZGM8Qv+3ETm/OsBK8L4RrUvCUYAD1ZDyEmWB2POIwWTbU92w089IugsSuV0AmPwAsf1LV6wdqAIwy1fO3nX1+NtudRyg1aj4/n7eeGLQd/r5BHUqlFUeD5x0dvGiKaC92ZnMzkNagSF+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676332; c=relaxed/simple;
	bh=DKLy9xSYdH2s+P4CanyQdvSo0zsUWoF7Fj9I7KFYkj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HB5BzCsHgzyIpjxX+2lNLa49n41btepGLbkktdCGJV4ZMbOxa1b0JA3ey0nzL2pXcbTZJPJGkz9pfKlyKsrqugTMrGmtY0hihn4Fg4ZpOJzYOvG6Mie3a7RCLfSTvrlejkR1PkVYcj5f/VCd5gvFAAaGjN3QbGQKF6tEbi97Z14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJrgGNt7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758676330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/Z9ru3yZuHgFLEyjMuFL1AU8zZki8asTUSFf8CWbuM=;
	b=KJrgGNt7iMR7CHV28FnI+x1eFg4VgMaV9UTe435v5esqCu3PoF6ET5UP4Xx60JGXGG295i
	pwYbu3Dii+tP5WFsr7tDFdU0eBVN/6C+1GKogt/xoa3UZpBrQ7G6kameKYHSBWtg7hrwvA
	Jd16bFmlRbS5KaE80q3Mmi7iGg8c22I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-ol5sZbTIOgKI37lQO8RQxA-1; Tue, 23 Sep 2025 21:12:08 -0400
X-MC-Unique: ol5sZbTIOgKI37lQO8RQxA-1
X-Mimecast-MFC-AGG-ID: ol5sZbTIOgKI37lQO8RQxA_1758676326
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso8417225a91.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 18:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676326; x=1759281126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Z9ru3yZuHgFLEyjMuFL1AU8zZki8asTUSFf8CWbuM=;
        b=SV9x1/0NzhUZfj4edt2h7luAY0yewtc3QJA3W9xE67xIYLpmLsreNK7EUOkX7zk95d
         NIA2Whw8CeRo8Sd/4iyrLN3EKQ+w8nkYXqD5J700omZ+XzYNjPzcM3DB7IcKsOr44p55
         Wqmtx2udFm7DzqQgw5BcJ0y+nZ/YM0GBqYQ+mSwu26SUgRgM3btNjMC9SSnaHcVJ2PX8
         YL5ckk1xlYVXTy1Adh2aOSHS+pB0SneLDgj74c1F5/QLVVPSIAn76Ty8iXCmMaDzCLE9
         3/JXVAiRWKOr7C0O4wdQV9la7JoPcGoq1409wvc8a2IKy3n4BwH0oxPvtdaGmsz3h4vT
         pHSg==
X-Gm-Message-State: AOJu0Ywi/IJSF7SQtf9jgmRuq35utcKuVGnw7JHIwIB6s8SB/kfMqlYJ
	ILK+KbJ7uBZzHBDDmlbb8EiomJMOt+Nk2wObZ6a/hfw4ZVapox6cwdi1htZfXKBvkRSI6GKgfEd
	kJMBZT4SQJdfHa1F41VbaAgfqUIokmrJnYnu4E0KwbJPQ+8KN+E5Bs035H8sH6jk0rYTA3Hfz9M
	V4bLS8wxIlnVMIPeBkWzoMFK8r6R39TOhW
X-Gm-Gg: ASbGncsks1630DC+Jg2SeBULySJUfsxnPc/V9nw8/makxie/4oa0RP6BJ9dkub3fr0m
	to0zvLM3LVZjvz0gr1KhJy5uaS8Md1hjvGM/HNwb9smYYLFv0Ybb72J1mXNSdZ/eLuFF1yoCcOA
	7O3XciiaJjktE1l1O1og==
X-Received: by 2002:a17:90b:4b8a:b0:32e:ca03:3d6 with SMTP id 98e67ed59e1d1-332a9a02e13mr4771505a91.36.1758676325633;
        Tue, 23 Sep 2025 18:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzxYjJRjaWhGevKoPRjS74qdeEP5KEee76nkTOV7sNOGR794WkZrfNsw1UREBYwZf/IPytkduQWK66MGn7H/M=
X-Received: by 2002:a17:90b:4b8a:b0:32e:ca03:3d6 with SMTP id
 98e67ed59e1d1-332a9a02e13mr4771481a91.36.1758676325193; Tue, 23 Sep 2025
 18:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923202258.2738717-1-kshankar@marvell.com>
 <20250923202258.2738717-2-kshankar@marvell.com> <CACGkMEvUMq7xgOndvWUYU=BZL=ZZD1q_LRy=5YFL7k80cYBRRg@mail.gmail.com>
In-Reply-To: <CACGkMEvUMq7xgOndvWUYU=BZL=ZZD1q_LRy=5YFL7k80cYBRRg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 09:11:53 +0800
X-Gm-Features: AS18NWAFTXygnvQR_4lKDl_YKIGpGbmtcj7ZwTo_3ajzvVYk4XQXOBLzbMHHLNU
Message-ID: <CACGkMEskxO4JKXZZiDSi6GgrTg1bRSteaYAAJe1wJ6=Lp5byeQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/3] net: implement virtio helper to handle
 outer nw offset
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	jerinj@marvell.com, ndabilpuram@marvell.com, sburla@marvell.com, 
	schalla@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:51=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Sep 24, 2025 at 4:23=E2=80=AFAM Kommula Shiva Shankar
> <kshankar@marvell.com> wrote:
> >
> > virtio specification introduced support for outer network
> > header offset broadcast.
> >
> > This patch implements the needed defines and virtio header
> > parsing capabilities.
> >
> > Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> > ---
> >  include/linux/virtio_net.h      | 40 +++++++++++++++++++++++++++++++++
> >  include/uapi/linux/virtio_net.h |  8 +++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 20e0584db1dd..e6153e9106d3 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -374,6 +374,46 @@ static inline int virtio_net_handle_csum_offload(s=
truct sk_buff *skb,
> >         return 0;
> >  }
> >
> > +static inline int
> > +virtio_net_out_net_header_to_skb(struct sk_buff *skb,
> > +                                struct virtio_net_hdr_v1_hash_tunnel_o=
ut_net_hdr *vhdr,
> > +                                bool out_net_hdr_negotiated,
> > +                                bool little_endian)
> > +{
> > +       unsigned int out_net_hdr_off;
> > +
> > +       if (!out_net_hdr_negotiated)
> > +               return 0;
> > +
> > +       if (vhdr->outer_nh_offset) {
> > +               out_net_hdr_off =3D __virtio16_to_cpu(little_endian, vh=
dr->outer_nh_offset);
> > +               skb_set_network_header(skb, out_net_hdr_off);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static inline int
> > +virtio_net_out_net_header_from_skb(const struct sk_buff *skb,
> > +                                  struct virtio_net_hdr_v1_hash_tunnel=
_out_net_hdr *vhdr,
> > +                                  bool out_net_hdr_negotiated,
> > +                                  bool little_endian)
> > +{
> > +       unsigned int out_net_hdr_off;
> > +
> > +       if (!out_net_hdr_negotiated) {
> > +               vhdr->outer_nh_offset =3D 0;
> > +               return 0;
> > +       }
> > +
> > +       out_net_hdr_off =3D skb_network_offset(skb);
> > +       if (out_net_hdr_off && skb->protocol =3D=3D htons(ETH_P_IP))
> > +               vhdr->outer_nh_offset =3D __cpu_to_virtio16(little_endi=
an,
> > +                                                         out_net_hdr_o=
ff);
>
> I'd expect this to work for IPV6 as well.

Or why it only works for IP/IPV6.

>
> Thanks

Thanks


