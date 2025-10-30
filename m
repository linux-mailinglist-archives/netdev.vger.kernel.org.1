Return-Path: <netdev+bounces-234256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36585C1E2A3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA67D3AA638
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6269B32C31E;
	Thu, 30 Oct 2025 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5y1Xe7T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DB221D9E
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792802; cv=none; b=WG+w6245NluY/HCMQvA/y5j0C7Jms63tedinlBI73A7/86TxIVOYZZmceP3IovyK+bEpVq0KzB0TGfWECanqDVHEGs8PF5Jmou8E02B6mRBpAVvoPIEO4hSE7dFbcfbYRa79QBCidW+qWmlRLJtwNQdxqY9A1n2g6z7xpQcFY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792802; c=relaxed/simple;
	bh=jzwxuky7qyY30SUTGdO0z8vz+l1kh9dfHf1H3lxmMHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5qVH7bnrWIjCY095P2Wx17zKW8EE7hTSMr5BRKg//Ux9FoUkFkvxGtYTnQUXYsshtR2Dd7olXoVG3Iw6Jbq5EZmeB/qr+h7dTCYoO/On1b90HjHWRIBaDrGvY+KPz43Dj9LeaAi+5A5aBpu5DmTd5HW406kNGm3Bj0hhp02C5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5y1Xe7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761792799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjsYQYRNMIhNAf7/U8NqV3RSAWE80f2s4DbWVuj2fGY=;
	b=G5y1Xe7Tll67y9r/YZ1gYjHKB7pTtK2RbDKu+vy1o2OMzw917nucoFKHC7o4cfaRwN+oEq
	orXchljM+B2k/Ckt5q/FslfOS/DF4WC794am3B1nMmGAPEZG9Vmg2cPe+dqeEDprYpqFXT
	Y8afFk8kiEsH1LK6sgDz5AApk1v1LVA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-5VLV8zLqPAmJ_ORwqUmpcA-1; Wed, 29 Oct 2025 22:53:17 -0400
X-MC-Unique: 5VLV8zLqPAmJ_ORwqUmpcA-1
X-Mimecast-MFC-AGG-ID: 5VLV8zLqPAmJ_ORwqUmpcA_1761792796
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-798920399a6so1520833b3a.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792796; x=1762397596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjsYQYRNMIhNAf7/U8NqV3RSAWE80f2s4DbWVuj2fGY=;
        b=Ewb/XZ1tWibE4Bciakflf0/0hhHlFin1nf6dQreKq3iDYM8icQXTLQ7Sme1fCnklfK
         pCaCzabVgGt0AeQC3TIpzKV7pyLQwgOIRZdgStypQ6bsgOLTaKeGr9mOXyDmVC9zbHuP
         PKkA6aVGBezNolyu0zmGb3n3BNiEW+0ws6AzWQfr1+dWuIaOD59ymYmhzGDrImtsCGgA
         PuBXgdMSvMCC/5j1+k1hObk1WKdSJ+BctSToYcD0BsV1Rgvax4QgLJy5t5DtZNg0HQ1n
         BwT1DR0jZuFYAUlin0bgZPNI7m+VCmr+GykwQ3ugHOEWseWDmmNT3zjWxx6atI5OOnph
         /tAw==
X-Gm-Message-State: AOJu0YzvdeK84cR3JwfBWUwSGNHM1+GwrV3ZVsTVU20Yb34iSJJ7O7JO
	hcwvuZBg6l1UqHQ96+fpRHVpOWlDWBWtrpvmQCahivRhVQU2NR4XQQtSDx98Z90goTHMeYDJ9sV
	eFCC6GVEfr54PRfxz+zg23RvQ4xQea2ylwC+HnuZZVwH8+FzR2WTrTDnanWsvCzubyPzORb10zA
	Tb2bTp5PJPPo7nkAUsz2RacYXflfu1FeiV
X-Gm-Gg: ASbGnctuccDQMBaykTDHNoNmC/ZHnIhl2Q6lxrGWdnzWL3n9ch8+gkEAuY+O85ohpfD
	O+gR2J5qHKiy0Cc8JqgqBqW5qIF7Ik7czSQPZMr2KfDERT3rP8BUrDFmv3IEZtWI9qQTLaw++CA
	xuIDfKB/mw3WmMDZSoGzDAPip5QhAwDxqXqONlgYew3wvVo8x7lckZI3Y9
X-Received: by 2002:a05:6a20:2451:b0:2ab:a456:9b09 with SMTP id adf61e73a8af0-3477bbe375bmr2392920637.15.1761792796509;
        Wed, 29 Oct 2025 19:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELMHFStV21waj0bP6q/2p08rAPkLlE4mfBjZ3827b23FGQXmJIODmUgsABbPjVg2nksbo5B6+Hm9pb7WvgNkw=
X-Received: by 2002:a05:6a20:2451:b0:2ab:a456:9b09 with SMTP id
 adf61e73a8af0-3477bbe375bmr2392894637.15.1761792796097; Wed, 29 Oct 2025
 19:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com> <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Oct 2025 10:53:01 +0800
X-Gm-Features: AWmQ_bll86rnWy9pG9gq4GCIiPauN6NE6YO3ljaSX-NQc3zI_7ME6G9qYDKXXCw
Message-ID: <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
>
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
>
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.

I still think it would be more safe to check the feature and switch to
the new behaviour if it is set. This seems to be more safe.

But I'm fine if it's agreed that this could be the way to go.

>
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gues=
t feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 710ae0d2d336..6ef0b737d548 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -217,25 +217,35 @@ static inline int virtio_net_hdr_from_skb(const str=
uct sk_buff *skb,
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> +               u16 hdr_len =3D 0;
>
>                 /* In certain code paths (such as the af_packet.c receive=
 path),
>                  * this function may be called without a transport header=
.
>                  * In this case, we do not need to set the hdr_len.
>                  */
>                 if (skb_transport_header_was_set(skb))
> -                       hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                        skb_headlen(skb)=
);
> +                       hdr_len =3D skb_transport_offset(skb);
>
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
> -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> +                       if (hdr_len)
> +                               hdr_len +=3D tcp_hdrlen(skb);
> +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +                       if (hdr_len)
> +                               hdr_len +=3D tcp_hdrlen(skb);
> +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> -               else
> +                       if (hdr_len)
> +                               hdr_len +=3D sizeof(struct udphdr);
> +               } else {
>                         return -EINVAL;
> +               }
> +
> +               hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len=
);
> +
>                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>         } else
> --
> 2.32.0.3.g01195cf9f
>

Thanks


