Return-Path: <netdev+bounces-126805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862D97294C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6705C1F21FF4
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6A16F265;
	Tue, 10 Sep 2024 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWf9FeBJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926324205
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948754; cv=none; b=QvgTLw7igp4rQOHFPgHnqQi3akp5OGTbko0PXmzQdpMbbptGQWqjAoB9jUvHo8mU5hPQ7Hc3ydQoakQTn57VwEFAQuhh/mDYPPpRgcMB7Pa5J2pRwprACkGLbZ8Ih/6bB/66DMgksbW1jRokWuxKsvm6ZDOg0UTJDA4FQUS8k3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948754; c=relaxed/simple;
	bh=KBK4L/Svs+SSSpRYgQ+SdhJybVIfGkMRnwWz/7TOsag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccWFP0wTrgeObtTytf/YUzGKhnXe+dDqKcjVxtWhVg6gtA42lThlGA1NHhkmqBXmwbybXwgI7DdWfS/0UyBGKQykUakpcVBIE+bXSLKO58ypHlnju3bNDC5jaRXXV5XvorOEeVW7QiQBSk8bWk3uE/8egp+I6qAxwDr7fPRTKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWf9FeBJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725948751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLRmJNCG3oc9HHYM4SM+SbDTwZxDhWCFqUUuzaavTuQ=;
	b=AWf9FeBJoMpgVq0fIWTvtZCqTvJtZAyB3VswYnX7d4s0p3D/CsLy3/XhsQp3CmYEGKZ5Oi
	i6JjnDky/u+Bor1ScmVYDdi4PJFo1d7ycFcNeKPDrz192UXLpHvXTXFBHP7Uu8YbkjKf9h
	tfrKyemTgDQ7j4hOxiVZc+/1o+xKhBc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-oFYy0toIPgK4m8Tqh61RJQ-1; Tue, 10 Sep 2024 02:12:30 -0400
X-MC-Unique: oFYy0toIPgK4m8Tqh61RJQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2070e327014so4100025ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 23:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725948749; x=1726553549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLRmJNCG3oc9HHYM4SM+SbDTwZxDhWCFqUUuzaavTuQ=;
        b=m5T0xDR0XLTjl/tyyEkJVB209NOkdcUFJWe22w8ZeLEDN9tzTIrFNHftQsBvF/3cSs
         wHrI35APfkaX22s590hAfhYpM3IqhiyYQ230052bOUEA9Uq9Hn0inn4QYgrZP50XLvC4
         0jJdTrDhrOxKSODBxM1jNQTEmhT/LRPNw5nSnSnrOjhAZVgBz/P0fKDNZwJi0lhHhO8u
         uyC+8ZTU6H+aLPeIjR2FcICeK01tjn1nzo+toFs0bObNN7FivPgD58at14XnqsFoZlXn
         gXkiuZDnmibnqtP6SzM0Prt5HCmmqaMh/BobnabvleGxYzR+6GWCVa0rbzrG8X8DZAVw
         FeEg==
X-Gm-Message-State: AOJu0YwIQ5jlEU+pZJHvo9Tbwclkf9mqyQUTCwDJPiVMjdWKh647Ka/l
	R/Ztqgr3t+WXJNEPW/HFnWWeFw+YOi/mlEkXm7bZBDAdUfIp9QSnZiFNZYip/O2EO+d4BzvtzEA
	kno2tDjFqXWolWkr1j9lU4OGcMODMDskGEeeDWK8buh5Jvfom63B4n12ChI1iS99j/Dvn3ov+4M
	SMujAGPLrJ6cE0uOJaCGnG1gxqwRZX
X-Received: by 2002:a17:903:22c4:b0:201:f1eb:bf98 with SMTP id d9443c01a7336-206f06242bfmr144283295ad.54.1725948749216;
        Mon, 09 Sep 2024 23:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl+BiaiPeOGgofe6xERlFpVXbjr7TyIBQ07MZxsXja5EigdLjujvtFMy8RjnNFUh4NnpA+tYEXbWa61qRuq68=
X-Received: by 2002:a17:903:22c4:b0:201:f1eb:bf98 with SMTP id
 d9443c01a7336-206f06242bfmr144282885ad.54.1725948748730; Mon, 09 Sep 2024
 23:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Sep 2024 14:12:17 +0800
Message-ID: <CACGkMEsnPmbo8t6PbD8YsgKrZWHXG=Rz8ZwTDBJkSbmyzkNGSA@mail.gmail.com>
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in virtio_net_hdr
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org, 
	nsz@port70.net, mst@redhat.com, yury.khrustalev@arm.com, broonie@kernel.org, 
	sudeep.holla@arm.com, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:40=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> The referenced commit drops bad input, but has false positives.
> Tighten the check to avoid these.
>
> The check detects illegal checksum offload requests, which produce
> csum_start/csum_off beyond end of packet after segmentation.
>
> But it is based on two incorrect assumptions:
>
> 1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GSO.
> True in callers that inject into the tx path, such as tap.
> But false in callers that inject into rx, like virtio-net.
> Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
> CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.
>
> 2. TSO requires checksum offload, i.e., ip_summed =3D=3D CHECKSUM_PARTIAL=
.
> False, as tcp[46]_gso_segment will fix up csum_start and offset for
> all other ip_summed by calling __tcp_v4_send_check.
>
> Because of 2, we can limit the scope of the fix to virtio_net_hdr
> that do try to set these fields, with a bogus value.
>
> Link: https://lore.kernel.org/netdev/20240909094527.GA3048202@port70.net/
> Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_n=
et_hdr")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Cc: <stable@vger.kernel.net>
>
> ---
>
> Verified that the syzbot repro is still caught.
>
> An equivalent alternative would be to move the check for csum_offset
> to where the csum_start check is in segmentation:
>
> -    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header(skb))=
)
> +    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header(skb) =
||
> +                 skb->csum_offset !=3D offsetof(struct tcphdr, check)))
>
> Cleaner, but messier stable backport.
>
> We'll need an equivalent patch to this for VIRTIO_NET_HDR_GSO_UDP_L4.
> But that csum_offset test was in a different commit, so different

Not for this patch, but I see this in UDP_L4:

                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
                               return -EINVAL;

This seems to forbid VIRTIO_NET_HDR_F_DATA_VALID. I wonder what's the
reason for doing this.

> Fixes tag.
> ---
>  include/linux/virtio_net.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 6c395a2600e8d..276ca543ef44d 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -173,7 +173,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buf=
f *skb,
>                         break;
>                 case SKB_GSO_TCPV4:
>                 case SKB_GSO_TCPV6:
> -                       if (skb->csum_offset !=3D offsetof(struct tcphdr,=
 check))
> +                       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> +                           skb->csum_offset !=3D offsetof(struct tcphdr,=
 check))
>                                 return -EINVAL;
>                         break;
>                 }
> --
> 2.46.0.598.g6f2099f65c-goog
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


