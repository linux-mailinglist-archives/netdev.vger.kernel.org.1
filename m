Return-Path: <netdev+bounces-202668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC962AEE906
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB2D3E1159
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765B286D7C;
	Mon, 30 Jun 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMtLSb8N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393F245033
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317261; cv=none; b=mkLPASgw/SyPKNyBDHOqqkxqcoGp3pBCVRbxNDFvNw/bgc1TJIC9rl/TVP8JWtrHPT48cao9V46XzdPdVb+fbcEb4Jxvh/k4ZkJ7t+OPl7znVtWcOGpW8Ya9+FO4mnRBjzwHIeKdEXFLQ89nOAtSE1lKQUh2Bqx9r7yfeNpFIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317261; c=relaxed/simple;
	bh=Ab7yTKIzrBN0fZnVJDvddG5RIrRLRPP64to8BpX/EeM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DKPGf+WD1leB6KuKdKe7dHkQK8TS1gxLKecp2g4iaGnsdqReZV2u9CosuYk0YKxnb8jMl4iFkrUfyQz8uue6sgnoSffXkQ3GKG0b/4JyacRmh8v6FHuHAKB+GgDc4dHqYNFVvNFjy09grIWxlsTOmS1Y8LcgwLyDE25LcSI3VE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMtLSb8N; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e73e9e18556so4934650276.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751317258; x=1751922058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDipabjZNafCLqmhk3OVuhgwuJ+Tt0Hv+/phlQSVc1s=;
        b=hMtLSb8Nb5OXz+FTEqJldJfZU1dQ/iossAPHgpip0m+4Ezvlzx1VblBRsKnIzDAubl
         4Q4dAvRFTdoNyBBldCAjZ3pOMVxdVq61i9gBv/Ead6uMwp2sdI8oR10gsfJY9dxrUDPE
         LYcX9aW3uG8BJtvKSb54tWVm31A7T2BEscgf9wkOknnfZ+TcQmu6n4ipyNwieLTeJy3C
         MHvAcDP8yQVNso8u9IHUiMozqQeBkamoALlVJaAfdpg9vT4j5Qfi5vvfzsEI83hVP6o6
         Sry7cfx7bxxRQb/VzVIaEu1R/BwPs3R5qCJBxCFeKhnnF9eVwer5TOCTl1aDGZgY160v
         MDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751317258; x=1751922058;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZDipabjZNafCLqmhk3OVuhgwuJ+Tt0Hv+/phlQSVc1s=;
        b=aD0ih+VOQzLs3YKoeBrDhpXzqmnqNLhiSZBTrQgbbM0fU6D5IVnWlnrczs9hGAbgly
         zYVDq+m0/4U9/uhaTBb5USNtxcDwgp64vKefnARUpG8/yDXXcHNynjqk9p8T0p/D5B1n
         2dkgDUR42EpjrYdJi7Wi+5YQs7IrYcKZh012XWASOX4ojMEB1qm2gy2Ybq/4C2qmFgrs
         8nHdlrwRS63BK2fJO2S2lRRIy6/eVvOs+55pzMEo6jbJHjB39kIMgeneIu+0sNhe6aiv
         0faq+syEINfr9SmwbnKstmdZnqxU3Q0kCmwQwi0bZcPjejsrONODKyQohCni4+WGDU8k
         YsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoj9fLiELM+h55iZQx9JH2LD5F2ECsv8J/aPLWf1LY4Uc1mUWgxpC3gRQB5FQtuQu0/SAX7D8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7B1CQ5YBqmw/xZ8lMvdaxAHPKRS6c1J/7ODFtw7qqpBWbD4MM
	LsBVUIFOhgy859NdAI6r5D9kJlORDPI7IXWYf+tC6FX6mWonvEqCTtIn
X-Gm-Gg: ASbGnctd8aVYfjtJPfHoiWKOjfcHUj87G8UwZlOeyaYjg7/eQPd/LFo4Cg7pYcfPnvK
	d0QrMyipENPicKwA6X4vk2BlcyK5se9bbBTPZODiTxCRWFkI01xGmNoFU6GZ9HNe/fLnXjWE0Zg
	bRsnqpLLXdUf9kjaieoPifWsXQ+ZZ20HXkYCersLtcDnTyRJMSqMVTU/irvVZSyxng8oYo6I8By
	dftn9DXRRKb2IaGjYl97m9lRCEhslhH0UQAZIUPX9VFyeZWy97ZA+y2bzBNv/2iVnY2/cLV+xNh
	piuQAu8RyT5x+Xr2MbvgaAwJcw0Cz+juUMSAxo5ZYsxMQ1I3kfJFhCgvCnZsP2FG2XmgoYxyh3k
	tUwuRBTV7NouEUxAABvYe37HXaObTh+UPesmXSDg=
X-Google-Smtp-Source: AGHT+IHPo0Y2nNrDZIuoGXDdfDELUtTjCGvyC/vHwd+xJxIcKs/tzI3UA2xfLAjtSDpuRZ/IbXBiKA==
X-Received: by 2002:a05:6902:909:b0:e84:76d5:cd84 with SMTP id 3f1490d57ef6-e896ee6e848mr1614060276.5.1751317258262;
        Mon, 30 Jun 2025 14:00:58 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e87a6be5a6esm2562512276.46.2025.06.30.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:00:57 -0700 (PDT)
Date: Mon, 30 Jun 2025 17:00:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Message-ID: <6862fb095090_183f832945b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250630164222.712558-4-sdf@fomichev.me>
References: <20250630164222.712558-1-sdf@fomichev.me>
 <20250630164222.712558-4-sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 3/8] net:
 s/dev_get_mac_address/netif_get_mac_address/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> Commit cc34acd577f1 ("docs: net: document new locking reality")
> introduced netif_ vs dev_ function semantics: the former expects locked
> netdev, the latter takes care of the locking. We don't strictly
> follow this semantics on either side, but there are more dev_xxx handlers
> now that don't fit. Rename them to netif_xxx where appropriate.
> 
> netif_get_mac_address is used only by tun/tap, so move it into
> NETDEV_INTERNAL namespace.
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/tap.c         | 6 ++++--
>  drivers/net/tun.c         | 4 +++-
>  include/linux/netdevice.h | 2 +-
>  net/core/dev.c            | 4 ++--
>  net/core/dev_ioctl.c      | 3 ++-
>  net/core/net-sysfs.c      | 2 +-
>  6 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index bdf0788d8e66..4c85770c809b 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -28,6 +28,8 @@
>  
>  #include "tun_vnet.h"
>  
> +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> +
>  #define TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE)
>  
>  static struct proto tap_proto = {
> @@ -1000,8 +1002,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>  			return -ENOLINK;
>  		}
>  		ret = 0;
> -		dev_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
> -				    tap->dev->name);
> +		netif_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
> +				      tap->dev->name);
>  		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
>  		    copy_to_user(&ifr->ifr_hwaddr, &ss, sizeof(ifr->ifr_hwaddr)))
>  			ret = -EFAULT;
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index f8c5e2fd04df..4509ae68decf 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -85,6 +85,8 @@
>  
>  #include "tun_vnet.h"
>  
> +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> +

Thanks for giving this a go. Now that you've implemented it, does the
risk (of overlooking callers, mainly) indeed seem acceptable?

Documentation/core-api/symbol-namespaces.rst says

  It is advisable to add the MODULE_IMPORT_NS() statement close to other module
  metadata definitions like MODULE_AUTHOR() or MODULE_LICENSE().

No need to respin just for this from me. Something to consider,
especially if anything else comes up.

Just curious, did you use the modpost and make nsdeps, or was it
sufficient to find the callers with tools like cscope and grep?

