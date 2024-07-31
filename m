Return-Path: <netdev+bounces-114613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BEE9431C2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 16:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361A5284243
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2EA1B372E;
	Wed, 31 Jul 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4s3NZml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DF16D4CB;
	Wed, 31 Jul 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435139; cv=none; b=PH2PrCATXKaflyBPFhT+5O/rfjeX7oIskVRyl9EGP4WHkeM7fm+AY88rQ9X9O0F27vRtc1UHD/WRjeMjBXlk425iqKzk6MW73TWRzzE5PdEEBOQDPqPqPG+Vqs1RA5bZSWBRgHeFUEs/cVIy4FnDWpAO3ThbcuaB2W6J5y2cndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435139; c=relaxed/simple;
	bh=qg6tbCM603pKIl6ex6aZn+8/1RFcZtNjy8ZF1q0qAcc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IQHzzb/jIT4mTIP2g4g0x3uFqCrB9lmvFqzn4rczLiQH1HUhVEkBl6dUAuCBct/tXO4R6+aAuyzKA+25VLnptQDtFgySFiylwnX+GCUiJxFTH+rzIJnzictHmh6bZkDax51WOK4kubedRabtRoLZ1Ywvtzd4zx2m3NlZG2JrBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4s3NZml; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so32035776d6.1;
        Wed, 31 Jul 2024 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722435136; x=1723039936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtrFwP4YBskKGvaa39EM8j7npXHQl9OMFtlElqqRPIE=;
        b=A4s3NZmlUAAIS5yRVKwOHoR4gNxV3Gmf207/jxvphF40ATPlBoPBsHcbUVHReydxnB
         1s8eHZ/mov6vNbcnJUSocYiDtLSeY3VtmCC39nRZkZh4Fkr7GU8ayjwmWwILWG8Inh4I
         1H46cJepnesJCxSgpysPltWWMh/EeGUo39SJ4uSLVIepeskW+1QuH1UeqC0QBS2pXsGI
         CKEjN2rLOmghdJ0jlHq1tqtPpsiMKuwgqblulhEw6nTQ1hitV1MKabPFy49jv3QpiPCU
         iCw0NbM3Eo+r3YSiWaLvheEXndWHHR7kIYua6gwATM854hDDgSou+xea63KN9gnoJYmS
         jfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435136; x=1723039936;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DtrFwP4YBskKGvaa39EM8j7npXHQl9OMFtlElqqRPIE=;
        b=jJEXZi8dht5HKVGjcixdBaOJ7lE+5J/j+c0ob4w0qt0c9O4cbvWbYUDS+ye3Fi7SyY
         P6lkrgZunZp7Mx0F0PvlMnG0VEE1ofuA9afvi+YypldIWLviUFU2EXcIlWRV/SupLAJB
         f1aCWHEbw/fFntpGI0xKY8iHS6qEdQtR2DXg1VATPr6U/RqErvquixwlrd38WwGpRAql
         Oz6Ir5y0d8y/mHFI3u2NCSGB5GILJK3bwSqh3MliJ8yYCciaip1bwC3iB6YMQ32s3CgM
         ExxhRFEUNPOEf8wMY5/Ne+7EaIeqGgAZY3i2/bokoHp9DKd8lAYQhsLBjxwL3drqYuhe
         kWog==
X-Forwarded-Encrypted: i=1; AJvYcCWC/AKHXZbCY0TQlnNA9fpeifJCr/gtPck5IppO01pg+BYaQ5EI7UDbKBqLd0lMow2ULzSuRGhO+gLeAff/bRV7syEWidl4ivzI+PYO0r0iaM0q67gu8s9yT1JDLXcGTCAIKZrg
X-Gm-Message-State: AOJu0YxpAvhgzxcZzcyz3Y6/bFfYrZQ81H1bza5Zjo1A+nDwuQr1uF3L
	lJev0tYUqbeO54LH5WMADWpTD9q9SI2Xjs/Xc4UzCYjbKM5CsA93
X-Google-Smtp-Source: AGHT+IE7d3WnrSysqBvvhYPRx4PE924CxpUJ3JXOeM/hbNryFShECa0EMfanfNTyb0eQsogUuZ81Ug==
X-Received: by 2002:a05:6214:413:b0:6b0:7a5c:e12c with SMTP id 6a1803df08f44-6bb55a0cb39mr190984426d6.29.1722435136449;
        Wed, 31 Jul 2024 07:12:16 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb0c4dfsm73490266d6.140.2024.07.31.07.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:12:15 -0700 (PDT)
Date: Wed, 31 Jul 2024 10:12:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Randy Li <ayaka@soulik.info>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org, 
 Randy Li <ayaka@soulik.info>
Message-ID: <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731111940.8383-1-ayaka@soulik.info>
References: <20240731111940.8383-1-ayaka@soulik.info>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Randy Li wrote:
> We need the queue index in qdisc mapping rule. There is no way to
> fetch that.

In which command exactly?

> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  drivers/net/tap.c           | 9 +++++++++
>  drivers/net/tun.c           | 4 ++++
>  include/uapi/linux/if_tun.h | 1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 77574f7a3bd4..6099f27a0a1f 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1120,6 +1120,15 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>  		rtnl_unlock();
>  		return ret;
>  
> +	case TUNGETQUEUEINDEX:
> +		rtnl_lock();
> +		if (!q->enabled)
> +			ret = -EINVAL;
> +

Below will just overwrite the above ret

> +		ret = put_user(q->queue_index, up);
> +		rtnl_unlock();
> +		return ret;
> +
>  	case SIOCGIFHWADDR:
>  		rtnl_lock();
>  		tap = tap_get_tap_dev(q);
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 1d06c560c5e6..5473a0fca2e1 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3115,6 +3115,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>  			return -EPERM;
>  		return open_related_ns(&net->ns, get_net_ns);
> +	} else if (cmd == TUNGETQUEUEINDEX) {
> +		if (tfile->detached)
> +			return -EINVAL;
> +		return put_user(tfile->queue_index, (unsigned int __user*)argp);

Unless you're certain that these fields can be read without RTNL, move
below rtnl_lock() statement.

>  	}
>  
>  	rtnl_lock();
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 287cdc81c939..2668ca3b06a5 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -61,6 +61,7 @@
>  #define TUNSETFILTEREBPF _IOR('T', 225, int)
>  #define TUNSETCARRIER _IOW('T', 226, int)
>  #define TUNGETDEVNETNS _IO('T', 227)
> +#define TUNGETQUEUEINDEX _IOR('T', 228, unsigned int)
>  
>  /* TUNSETIFF ifr flags */
>  #define IFF_TUN		0x0001
> -- 
> 2.45.2
> 



