Return-Path: <netdev+bounces-241599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D14C8659D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5943B0B05
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0032B987;
	Tue, 25 Nov 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5bQgufv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBtcRsbk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6DD32AAC9
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093479; cv=none; b=HSv3Kntpof3I3miKvJUBDvecyQ9r7gXWrfJgZp0It81UV3pjDuZGqEE2SFHZWZ+Hz111Q8Rur/KqbC1P8D3ejAIFysg6Sxf6IXIku+b2XbYWnzrxiGfEDcQ0ro70KhVmLBXKNi985/j+GlNcrxiJnyLyZmfew66xiI3cqd7ikIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093479; c=relaxed/simple;
	bh=Fs83rTTPnZoefNeB88lzRj2Zrxjcng2SgqTDnxbSr4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=XY+oeAf6CBjapfpdWGo9ftv4HmCTTUukgoUBU6Nyw6OnuUYiNOsJFz1HipdRip2GDzjFileDeUNiUe+6Y7p3Tm71dhLJXQ2CaTjJMAqjOdi98yRPDqJAn9KXxQxfEEMi1Q3ClUwudjlDDM1xt2jxYt1xzYoffZTdRW4JYLK8/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5bQgufv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBtcRsbk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764093475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBBNljc5iFCuzwl9ZqmN5RW/+AydF/L+sgiYuUnYeUI=;
	b=Y5bQgufvfS1kc6EJ0PM0Kf+bFHTfgvbivCiAiUYI1dvjYs9grAwQD+XXKnN+RmQ6LIN1jY
	tHxgklH4NzDkrU1o4K29o7HgYzuERa0njo2SRjQhik6xGIyTDn4bUDrT5i8N69qZ7XYnuq
	NqFL5ThMH3EkAAUzaYaghBwRJkciDYQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-0hq-P_jtN7ejntN8p3x1cg-1; Tue, 25 Nov 2025 12:57:53 -0500
X-MC-Unique: 0hq-P_jtN7ejntN8p3x1cg-1
X-Mimecast-MFC-AGG-ID: 0hq-P_jtN7ejntN8p3x1cg_1764093471
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b570776a3so3707622f8f.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764093471; x=1764698271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBBNljc5iFCuzwl9ZqmN5RW/+AydF/L+sgiYuUnYeUI=;
        b=EBtcRsbkSkCfEefAfNxcybFPpk8rYU7rLgqPv/9EbVWn4U4BgpU1G4F83/5fdJoVsT
         fGs/+MjFpjroLPBHJcluoAACC0MXzz8/20H3cXlklrATi4M3f32Feb9Ccwea7qZx7j15
         x9AgkukFjIvJEvDns4i0v1ydGqwph7VspRUuOm1VVsaj6TMSfI7z33rk2LDT+lRrMmyP
         hYfmTEAwNY6N69kGDZBaC80ZFGzFaGOFYMqWq8RhT3yls1VBo3b28m8AFeB4OJNJOGKn
         NYaWoqyvKW4RsLOuoNJyZYB9Kf6wJh87kQxTbVpwSX/eitIv6kPCnzEbYrhomxVDljMd
         m/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764093471; x=1764698271;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBBNljc5iFCuzwl9ZqmN5RW/+AydF/L+sgiYuUnYeUI=;
        b=mtdZEuyjVPZcVjmqREUcJcpBuvcmFHcyRg7nWW/i+kP4qVFYRO25TYTteb2VR7Shir
         f5HUkqSdVIpXyack1xUI+9NZ5RE5RCHValNEhdRcC1T15MlMlpBVUk5Iii0U+qe5qlW1
         h+Oqq+ieqSgnSwQhdUtl+cxwzAElJdYoEY8WEymc9EYcXhWJo4c5xyVUdUMiDrshTJpa
         1TqQMCtSNzalHDbk22vsrHR4D1KauMTZMdR8FLnHN67ihce04mpT2xAFMeh8aqQGyQgu
         qemr3nbCwZeBmo4WC84vfBUHefkIHp31Ux5O7vK9wSsf7az2UOQq5XkjRpbxmgoD7Oyf
         hQxw==
X-Gm-Message-State: AOJu0YzP61CV/eBVfg8RjBBsLksCgno/+i564jlzhBKAB49nbw1T2X2g
	2dyX4EaRpF1LUnnhmk7P0OIBz5LJmzGOYEa+NyBobhm5JIec2EoScAdpK1o2hIk92NxAk1wDrzI
	1//J+hW1JAMwSlRCBgiX7nZNUa+xLqS7zGuijSPTYz3WjS1Mn8mrh7FBp3A==
X-Gm-Gg: ASbGnctSFUnjtn8Fbny5YzB9E2k2SIOnUPXpeskEpP1XSYmi0FyTp9TiEDIEEL6sRq/
	tdy5Y69kbeJ4T3bz8qGYOe8tKcJb/rFuDI1vYpsr6zBEHZZmMFWR06VRxZ8GOSjpxPW6BqcMsIa
	LAP71fZwLmbsVzPgBTItX03gOeN6wWCzdca3xLemRC527RBOB3KFXBDfRit7U2ZX4LgfPmY9Rtb
	kik7DuZzTyOgp8fQcfF5zxsr5XK1oXKmxkurBKCweOheW2qxr+vO23FFUKmJd5ppcY2uIvM3RfK
	flF344Eihhi2Kg/lkdsDtCmdPcXb9DSiWfZ6afS8llQ9aTmTU81nPO6hhP/LEgrRYuZo4TDi+wl
	Fj5Y+zPwcGrmi2g==
X-Received: by 2002:a05:6000:430a:b0:42b:3246:1681 with SMTP id ffacd0b85a97d-42cc1accdd6mr17107053f8f.18.1764093470977;
        Tue, 25 Nov 2025 09:57:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo3snX1o9Z22+ePohjUgGpFTEU10kI9WW/GDIDglDYteMzSXiD2riD2Rl+m2cCB65iYkPtyg==
X-Received: by 2002:a05:6000:430a:b0:42b:3246:1681 with SMTP id ffacd0b85a97d-42cc1accdd6mr17107029f8f.18.1764093470584;
        Tue, 25 Nov 2025 09:57:50 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a76sm35703266f8f.24.2025.11.25.09.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:57:50 -0800 (PST)
Message-ID: <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
Date: Tue, 25 Nov 2025 18:57:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
To: Jon Kohler <jon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251125175117.995179-1-jon@nutanix.com>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251125175117.995179-1-jon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CC netdev

On 11/25/25 6:51 PM, Jon Kohler wrote:
> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") inadvertently altered checksum offload behavior
> for guests not using UDP GSO tunneling.
> 
> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> has_data_valid = true to virtio_net_hdr_from_skb.
> 
> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> which passes has_data_valid = false into both call sites.
> 
> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
> for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
> guests are forced to recalculate checksums unnecessarily.
> 
> Restore the previous behavior by ensuring has_data_valid = true is
> passed in the !tnl_gso_type case.
> 
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  include/linux/virtio_net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b673c31569f3..570c6dd1666d 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -394,7 +394,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>  	if (!tnl_gso_type)
> -		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> +		return virtio_net_hdr_from_skb(skb, hdr, little_endian, true,
>  					       vlan_hlen);
>  
>  	/* Tunnel support not negotiated but skb ask for it. */

virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.

I think you need to add another argument to
virtio_net_hdr_tnl_from_skb(), or possibly implement a separate helper
to take care of csum offload - the symmetric of
virtio_net_handle_csum_offload().

Also you need to CC netdev, otherwise the patch will not be processed by
patchwork.

/P


