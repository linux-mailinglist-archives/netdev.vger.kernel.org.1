Return-Path: <netdev+bounces-240051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6424AC6FB83
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E404387023
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC582DE718;
	Wed, 19 Nov 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emjC9/al";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PknmgSOO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D012D9EF3
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566557; cv=none; b=DmRnNIVysGNZeXiM/ixHkl1RyRunaP4lEo3KrHtuduprEe66TmBKc+3ovX24X1SJlFkUR7X2zp8Fu70yGlfmTS3y5s+tkCXy4A0+hiRH14fn5Te/tdSf/gBxAOeyFg86IxURD0KX1xkhySzW2FikHIzdk1y0UbQ3QxFHdMm1jCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566557; c=relaxed/simple;
	bh=8xQWC2OGmtfjHYhYxSYa01NZETYq9M+SyMw53U93t6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADBuzuizFbYIOMnlAR56KcAa0Z1rdq7vx3x1qBpRqtmzGy8hEcifgyWAR3VHp6PVOYJVMxTCGFvlDSnF6lDK4j6bPFWItkU1pgRNTsCc60wF4WmhMM75ltsFKIf5A6iAXV7JYljWMLVn+HGleOkN+hDTZk5lGhhOdvBcTVmMl2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emjC9/al; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PknmgSOO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763566554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B5rXBayezD4fGmnwc7W8pDkjBIEGyWaeCx/RLJ47OIA=;
	b=emjC9/alu/wdC4o49rLdIoeVBBPriZRJR2cEMMJPiljjpm9+ip9TdQpiy5286E52b7hrDY
	8Jq+L+LBdtlyNqz5eC1CQR/LBfd9GB4DHJaqyGkvK2jIZtc7XwjydLADejaxzp6+Vp9ZmZ
	9HCYrF33DBK7WYjs9Zf7/zHIjJlkFiI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-IM2unokkOkq6CLy8cAb77A-1; Wed, 19 Nov 2025 10:35:53 -0500
X-MC-Unique: IM2unokkOkq6CLy8cAb77A-1
X-Mimecast-MFC-AGG-ID: IM2unokkOkq6CLy8cAb77A_1763566552
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b366a76ffso3585545f8f.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763566551; x=1764171351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5rXBayezD4fGmnwc7W8pDkjBIEGyWaeCx/RLJ47OIA=;
        b=PknmgSOOK1OgAnnLggb8yEpD1m/+g6YD/DofUSurnLQv9VpuEdvfnwHprwkptYskSj
         18vD7A8qGOiZDvFX6kWHjk3M53mpPlq8m2JhP6AOCDt62qU1pgdbUzQP+tRfD9H/HgjZ
         n1QVhFCIjKvI0RSd7/pUKzyGGFGes0x3ma+M2Fd2U8P110W6ltSt+wOKbAfnvaPXG4Rl
         lzCvq15jqq7DdwzpxRNpDIZwlI/WQQ3JiJTiCyovzxvXaiY/DJbRnVmrPuqn8J9x7Hye
         2STh9WLkU4xWkmam0XPrArlxsibteeygeI4/UIzLoEljCmgQeEdO2UoBzoJaKAywIKO2
         jHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566551; x=1764171351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5rXBayezD4fGmnwc7W8pDkjBIEGyWaeCx/RLJ47OIA=;
        b=GolBYqW7xiHu3c/5O2clWCj4FxX2k7qyEIIcC2EqEAqD16lZOKdfujmQXXl8xvI/Vg
         lPhTjdAlMGhssAdvfEe6/zRjCexhfKNCEAMav3OnDtCt/R0SPWU0Rdl6RgKHoncO/qvt
         jQjWvvNBIyNQmav+MhqtpSoosNN8+kXCxcSA/FVx2Dy1TIsXR7BVlIKPrURiIVxPHTTJ
         SUFr9yYGWhAAyDbwTooHWhjdMkRfpNYbDD/9ndSX6QMKWhdRbToWvSEQvGRtXXPbijXp
         pPr6A2iDYeqvJXyAjx9f/YXOplXp8QQlEbg64X03WsvedeSPl1WuVPTqrfkdePg+o5/K
         iIng==
X-Gm-Message-State: AOJu0Yw2P3LAIUf0rbqMirTxsZsJWdEHLlE/+W7E3CWW7ox5DuznVd8r
	iMNELXaWim8C6H4fRJFB84m/3ELPdI1+xfpJtaI/DZvtn+cZY30ZPDyxosMr7rSDrLr6pix8woV
	I503mg2xyBaT2Kjsx+nfIhv52rQN8m9q4IDVjLFynSX+nMxoUGbbg0wW8Xg==
X-Gm-Gg: ASbGncuUfR5lNmWWltBDU9W1X4knzJ48kP0KLJikTtvZEnxMOeuvFBJo9oSLtt6hVkZ
	SWmQc/k7pDVT4kmlTpkC37jKhtEdIkRF+V6dpcCZlSfne9Dws4MHyUn9eoQjLIN2wBsdwxO0ySw
	in5KJvT7kagGiqLvtgMi7bxlLWaN2baMe/ZMZXKKpNkvB+OagPBQi2GGonz63CsEL4WmiF91HVn
	UBtJowKNL96E6YNj9cuO5ea5CXAa7wwp/COKec3gXkbDHA0gi0j9h/GHB8s1wKZxK9hbRCYuGCo
	OzzesFwlyCg5vYmZlgpeb0VtRr4scML+Km9YWWpnbMUN/dC0/Hg1x8wgivubkUgHao7My/kCS6L
	bO9EYExhgxvWQMX1Ro7H/LrkDFtWw3g==
X-Received: by 2002:a05:6000:1a8e:b0:42b:3e0a:64b8 with SMTP id ffacd0b85a97d-42b593505bamr19333066f8f.24.1763566551402;
        Wed, 19 Nov 2025 07:35:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsu6XSFNDBciSWl2Js2B1sAVjUG1swL73vKYbAUIAe5E9Q/RDA00H3GxNi9yzFc+Jd1MBR4w==
X-Received: by 2002:a05:6000:1a8e:b0:42b:3e0a:64b8 with SMTP id ffacd0b85a97d-42b593505bamr19333019f8f.24.1763566550923;
        Wed, 19 Nov 2025 07:35:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38718586f8f.0.2025.11.19.07.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:35:50 -0800 (PST)
Date: Wed, 19 Nov 2025 10:35:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v6 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
Message-ID: <20251119102753-mutt-send-email-mst@kernel.org>
References: <20251119055522.617-1-xuanzhuo@linux.alibaba.com>
 <20251119055522.617-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119055522.617-3-xuanzhuo@linux.alibaba.com>

On Wed, Nov 19, 2025 at 01:55:22PM +0800, Xuan Zhuo wrote:
> The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> virtio-net.
> 
> The virtio spec says:
> 
>     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
>     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
>     all the headers up to and including the inner transport.
> 
> The commit did not update the hdr_len to include the inner transport.
> 
> I observed that the "hdr_len" is 116 for this packet:
>     17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
>         192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
>     fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
>         192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796
> 
> 116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)
> 
> Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index ee960ec9a35e..ee8231eb759b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -215,12 +215,22 @@ static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
>  	u16 hdr_len;
>  
>  	if (guest_hdrlen) {
> -		hdr_len = skb_transport_offset(skb);
> -
> -		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> -			hdr_len += sizeof(struct udphdr);
> -		else
> -			hdr_len += tcp_hdrlen(skb);
> +		if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +				       SKB_GSO_UDP_TUNNEL_CSUM)) {
> +			hdr_len = skb_inner_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += inner_tcp_hdrlen(skb);
> +		} else {
> +			hdr_len = skb_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += tcp_hdrlen(skb);
> +		}
>  	} else {
>  		/* This is a hint as to how much should be linear. */
>  		hdr_len = skb_headlen(skb);

BTW  I noticed that include/linux/virtio_net.h really should include
linux/tcp.h for tcp_hdrlen and uapi/linux/udp.h for struct udphdr


Not a new issue so you do not have to resolve it in this patchset,
though.



> @@ -441,11 +451,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>          vhdr->hash_hdr.hash_report = 0;
>          vhdr->hash_hdr.padding = 0;
>  
> -	/* Let the basic parsing deal with plain GSO features. */
> -	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>  	ret = __virtio_net_hdr_from_skb(skb, hdr, true, false,
>  					guest_hdrlen, vlan_hlen);
> -	skb_shinfo(skb)->gso_type |= tnl_gso_type;
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.32.0.3.g01195cf9f


