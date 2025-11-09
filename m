Return-Path: <netdev+bounces-237098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B413C44856
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D39C03463FF
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B870261573;
	Sun,  9 Nov 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFhMkdl8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqmFCrZ9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C82264612
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724497; cv=none; b=pcbRcFJD+bYl2HHKwMhsRB2MFm2VAth6qDDbWUlFtldxXOUOzWygNOPI4qPxmtjmeVTnP7FoKmdBae+ejH/SIuLlmEwf1MwBYcUcZuWDuvAEsabIbx6mE0gNpDmVolbDN47AcY17lwVqm5b5e45LuvGcId9LeeCoMvLuozl3/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724497; c=relaxed/simple;
	bh=MOXxoILwQbdykOXtyBXgWf/d9Fx289+axW8lU9Jrt4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkpy6x1K4scrOOxdSwvOJkH+i2dZS9WREOkxmIrAnLF1YoCJmTzFutk77qKVLz+DXytzpXMzOuWWdVG9iOd1+1kx4nPyPcE1jmPDPy9DUdXlrfY7rbf4FVBm9rihDmNKlLI2JMU+EXcJLzKDzff4h2pcSyhR+SXwtgb1U2HgPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFhMkdl8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqmFCrZ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ou3QgqFqB6sfyJ3NXy+JTUo8mN1dmsPv5vKTpn4Fnxk=;
	b=IFhMkdl85RnGW/RT3eTGJZHlorwkHaR5bP4YOncXOLfSdRldid3EdKm4CBvKDMeyluRoVY
	akGBzOfwmiEtyN4UVs4gtFdbmMDHqceIPO8j/TZrngr9hmMbJcdJF+rRxP79Ebjkb9xQ1c
	mUAZAEov+y7CbYFcLjjNQKaKHwFtvoM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-pnet1lgNNQKtzXRXV3tO8A-1; Sun, 09 Nov 2025 16:41:32 -0500
X-MC-Unique: pnet1lgNNQKtzXRXV3tO8A-1
X-Mimecast-MFC-AGG-ID: pnet1lgNNQKtzXRXV3tO8A_1762724491
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47106720618so15799135e9.1
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 13:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762724491; x=1763329291; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ou3QgqFqB6sfyJ3NXy+JTUo8mN1dmsPv5vKTpn4Fnxk=;
        b=DqmFCrZ96mVBbOD3wsH5FqpU+D4s6qtZQasg/Wosc+GSrps/74HD60w6jznrlxPYFa
         bAI7wJ35/3kd9/ZL2Hvw3O2Wo7Cur0ssAP2f0Ajzbrq/QMw/ZLui6Wn7aVyuOdHwz2Pf
         p6kZgm+BWvEqP7ocB6tAjzB9ATeI2dnPUcksqHLIHxtIDwlnS/JpWGXXnMOUiLQbl0XC
         zYrk8+NGzNVkTxicXksKfX5ZZH2WZqSUXJZD5HICRNsTBqGfybAyCEt8ygRY3E+0HaUJ
         mw3+CSTGUGPUlulCYt1a3Ln/mCLlPI+kJa+m3rxnv64j5MPMEz01OnEmWJe1Q+csAM3X
         asKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724491; x=1763329291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou3QgqFqB6sfyJ3NXy+JTUo8mN1dmsPv5vKTpn4Fnxk=;
        b=sK1om/Mjg3GlLF+otieYaZVXn+97NZSu+kD8+Se0rQJq+NR3WpfettjTb+NZJDw/LV
         b+FOe8lgwedErEpMmr9GdKGRW5sICiMYXysd2aQLWj74el3ehdaHvfFLHZMFYc3SgEUu
         1l6zhPOOrObHLnxRxUplsOGM2OJeYwBwfIRcuDtCMqBiIBOjAv5LrbmnL3/aV0xQ7XbE
         E0Jy9UpjuP28Uzisbv2LpwijjdD6Aoo8+rB2S+PKR3txM00kzI9meHWFJnHcsPQg7aTk
         xG8xDvWHgxvXvc9TtW8yXgE34Ew97yCBNi3NCCq5Ai2yQbQisVWviz5hwvzBxIbLH3Fz
         6C9A==
X-Forwarded-Encrypted: i=1; AJvYcCVWQNboPVR5NGhdfJGyt1JBXc1KwDW3V6Y1YJkLkdS2fU+/E7mIL9Cxo1FLGmYM3YfJ0AuEMpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSWYM7SESaRJ4+T38xWMMU6q4X+VWewtGQf6cejW1rO2peNAq
	spoNJ5L+iuNAP+xhTm43rZqgPXjrKIa8UR0L1gw+1x5lQhyhBxfCXEVxQI7Z5Vqu1kJfKzGWFFy
	vwmxC1It0NmlMkgurFG6+E0ZAmwI0SHs6VaBD/gOBVvTT3KF6X9QAc4YNjA==
X-Gm-Gg: ASbGncswq9mFlLYjJzSYTxgtnrEMOVbYaRrrlxQY7n2nPAnmW8dyd/arvES6gOM4PFo
	7kU2hCBWXVJxMDBlzqdtCHBlB27WgJx4FEj7186O+zcq/xgVy9mWI13RkTlk1MhDs37jlRJUucx
	pzSOM7n3Zc9Hg8JhrKIK1hX8F5qaQlFE5Uk7FgELz5RrZBjjMODsC0gpwLlYsGtoymcNONLILdL
	GP/Y0w2Od9BqD3SQMeLt0COo3Tj0nlOL7fsp9tI2Xv2IXgrvajHhamr7Lf6oLEcHcxlZA1nXxT/
	RjnueLeO/X3zTIuLPKxcyzgR9OmDEF+7NayLAdBvXX784kSv88q3IExWzi/XJw4yrms=
X-Received: by 2002:a05:600c:5490:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-4777323eca9mr53344955e9.18.1762724491176;
        Sun, 09 Nov 2025 13:41:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Eoz8suLN8Yuo5spcVXTWIg7FsaQrpGd7DV8hop1FnHX8vSDgZC19+T9HKTUAvIcP7b/r3A==
X-Received: by 2002:a05:600c:5490:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-4777323eca9mr53344775e9.18.1762724490668;
        Sun, 09 Nov 2025 13:41:30 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776d39c8f8sm159375465e9.3.2025.11.09.13.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:41:30 -0800 (PST)
Date: Sun, 9 Nov 2025 16:41:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251109163911-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>

On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> On Wed, Oct 29, 2025 at 11:09 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> >
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> >
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> 
> I still think it would be more safe to check the feature

which feature VIRTIO_NET_F_GUEST_HDRLEN ?


> and switch to
> the new behaviour if it is set. This seems to be more safe.
> 
> But I'm fine if it's agreed that this could be the way to go.
> 
> >
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/linux/virtio_net.h | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 710ae0d2d336..6ef0b737d548 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -217,25 +217,35 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> >
> >         if (skb_is_gso(skb)) {
> >                 struct skb_shared_info *sinfo = skb_shinfo(skb);
> > +               u16 hdr_len = 0;
> >
> >                 /* In certain code paths (such as the af_packet.c receive path),
> >                  * this function may be called without a transport header.
> >                  * In this case, we do not need to set the hdr_len.
> >                  */
> >                 if (skb_transport_header_was_set(skb))
> > -                       hdr->hdr_len = __cpu_to_virtio16(little_endian,
> > -                                                        skb_headlen(skb));
> > +                       hdr_len = skb_transport_offset(skb);
> >
> >                 hdr->gso_size = __cpu_to_virtio16(little_endian,
> >                                                   sinfo->gso_size);
> > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> >                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > +                       if (hdr_len)
> > +                               hdr_len += tcp_hdrlen(skb);
> > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> >                         hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > +                       if (hdr_len)
> > +                               hdr_len += tcp_hdrlen(skb);
> > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> >                         hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
> > -               else
> > +                       if (hdr_len)
> > +                               hdr_len += sizeof(struct udphdr);
> > +               } else {
> >                         return -EINVAL;
> > +               }
> > +
> > +               hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
> > +
> >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> >                         hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
> >         } else
> > --
> > 2.32.0.3.g01195cf9f
> >
> 
> Thanks


