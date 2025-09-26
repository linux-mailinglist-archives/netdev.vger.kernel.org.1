Return-Path: <netdev+bounces-226590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB59BA2692
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6725C1C00AF3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80038DD8;
	Fri, 26 Sep 2025 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S30dCAhc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81617597
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862391; cv=none; b=cdRwZ4Lo7ZUtkxsZBvC62517JRdkSvxIttb+qia/FB+CM3M4Fyj+v5Znf/pdSX07ZHMSSZtA7yXsB3wRFt/RjkMQnEAV/WsRmdwBhqeL32Cw8BJSx9JbbZQho/Nj04cFXGw3iV6FdKzRzbqrXEiadeq/yr6V7cfsGfKbmTxq/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862391; c=relaxed/simple;
	bh=p8OgjDKlqKgiMFaRAqKJY1gzN6Syy48c4mCc9sh9pMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5FrEmw+ZkzGRjobk4yeYYqJOAeyJ706QSSpwfTwS2cqxQhG+buBkKpWP34Kv/fln3oMVsFWGe9lxDWjkT2Bk0AfnrziQDBV90F4V2LMk6jepz608NQbwThSUdc+WbQJbE7RLdfOiiFwvgYMW1n/K3FukaFOq8poAQDF3e7kix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S30dCAhc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758862388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipe76653qksNE5m5Tu3UwejDA9Jg2eMeIFFu07Sa/Jc=;
	b=S30dCAhcTw0eARnP6fBYyJ6N/VlkpUPr+ho71oyJBAkrCBbjzZS6rZdn6zQ4Oe6b20drv+
	lLbuGg77oNJIob9624C/vZleKJkg2bkDBmsm/aBHnotiXFcW8KB9MQfpw5007L6AeUo2h1
	fXf26R51XgK/AL1swXNVzX6joU4/dE0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-KDswheg5O0ygMHR4U9ybRA-1; Fri, 26 Sep 2025 00:53:06 -0400
X-MC-Unique: KDswheg5O0ygMHR4U9ybRA-1
X-Mimecast-MFC-AGG-ID: KDswheg5O0ygMHR4U9ybRA_1758862386
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so857514a91.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758862385; x=1759467185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipe76653qksNE5m5Tu3UwejDA9Jg2eMeIFFu07Sa/Jc=;
        b=NYVi7U6AOTW9nlWZls4zuVAljKMjS+xZLuHG6QSCXbqO1Dg+Q9c+AzJHgldpxjfWRp
         jVEOGIHisw0uEPg10H5bvwc6RQB+yKZmj4kJB5CxKcU3qHHDfOSPM5n68QwC8T7zowyD
         7IR42JZjf7V9cu1PHONTAtm1R6uammIdOH/KadEU5jZimK6wfzqp5VJ3R2k2S4ulsS9A
         zxze6Q9pv7MG9WHnHQk84RTvxRMxKddnPE5qsvPWfGHyyc2m8JLML4sIy+kaU/CZMVSO
         fiUh0fHHpUIVrVY06mUkcE+WfbhWr89ALWOnxpIyS6goupzhP3+B2ge/RSeBVixM4kPp
         yRkA==
X-Gm-Message-State: AOJu0YybaB/tzS4lAyaj9yE6oc7yoDZuCIaVXc4PtYA56y6AVlFgRYty
	jO/cd4BznVdGfhgomj+/38dnorwR5ict5F1IHB9CJ+DCGs7crHlpqTO1qU6g6x4eP4ze53DMdgm
	5WJKcWdpdAMa31nR2ex7NbQNQl3LLmmvC6lcRPX/1m3DVf3qnUaOWoEAlaSr4+apOTwA8DZwsTr
	8x3lz79aX7y4JUGHdZoHnq/8ODFi14eBPB
X-Gm-Gg: ASbGncseLwWe5zC5ksBVqS+2Im7H0NaoohDWnUldVrKMgEOwEXOoAsgB9QO+U6tgwnC
	r86bR4ZGrGap0ZdXVf5HoLN/XVlOI5+QN+2Tinx1YkQfP+9P8GcEGcSKcmzCV0sFtJBCa57VtgQ
	xnnc7XvU5C0oDmCz2d+w==
X-Received: by 2002:a17:90b:1809:b0:32e:6fae:ba53 with SMTP id 98e67ed59e1d1-3342a20bdd9mr6808877a91.8.1758862385449;
        Thu, 25 Sep 2025 21:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMmqyM/PNWn17h5S70mcJ3JavjErS0o+QP6dUU2G2gn6USvpy9B+txWp6jCVExFFYakNfKlYlxhtgvqCrCW+8=
X-Received: by 2002:a17:90b:1809:b0:32e:6fae:ba53 with SMTP id
 98e67ed59e1d1-3342a20bdd9mr6808854a91.8.1758862384931; Thu, 25 Sep 2025
 21:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com> <20250925022537.91774-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20250925022537.91774-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 12:52:53 +0800
X-Gm-Features: AS18NWDrdikWUMcD611GxFljDjGpRIrPar_0b_HsS3n9y_SZqw9yGNHwwZQvhiI
Message-ID: <CACGkMEvhABOtHTCVW9sX7p0wo1QCMXMvOAD+u4pzBueoU=MCpg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:25=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
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
>
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gues=
t feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..4273420a9ff9 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -217,20 +217,25 @@ static inline int virtio_net_hdr_from_skb(const str=
uct sk_buff *skb,
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> +               u16 hdr_len;
>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
> +               hdr_len =3D skb_transport_offset(skb);
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
> -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> +                       hdr_len +=3D tcp_hdrlen(skb);
> +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +                       hdr_len +=3D tcp_hdrlen(skb);
> +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> -               else

I think we need to deal with the GSO tunnel as well?

"""
    If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit =
or
    VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts fo=
r
    all the headers up to and including the inner transport.
"""

> +                       hdr_len +=3D sizeof(struct udphdr);
> +               } else {
>                         return -EINVAL;
> +               }
> +
> +               hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len=
);

Should we at least check against the feature of VIRTIO_NET_F_GUEST_HDRLEN?

>                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>         } else
> --
> 2.32.0.3.g01195cf9f
>


