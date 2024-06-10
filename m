Return-Path: <netdev+bounces-102160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B6901B54
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D44528109D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 06:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9F1802E;
	Mon, 10 Jun 2024 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qMYzugBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C13F8F1
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001213; cv=none; b=Se34di0gbXPl8VssnBHespJVn8Nzcm59f7r8/BzSZgFPN0FG3IZ+vfIHZe5SjLK9UjJiTMeVG4xMX1bEx9q2o5mtphW37c8F5bmX05bVtT+YY8mUOZwmQdQpM+gapqZpdDwP6JH5ufGU//vDD9hqxvYK4BqGuouAnTeSOjAItNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001213; c=relaxed/simple;
	bh=nZcau39wRPlGTZvSrqWINvzj1+jKedLRGl17kSi+Luc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3JrXL01b8eEicVWDNyrMnjWKOsB0Ni5nx+MvjvybghMmUKSewA0WCeW48+Np27wYkTHihhvpa+uMup9DVGRbHP+zu9oi/DUl4WIM7xzjnAbVqe8aoCSq9F2Yv5vOVTNtDrtrkZhKvj830CC0N9ZLD0cA96WwF+uEfOMcMkBsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qMYzugBo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1dc4ab9aso910191f8f.3
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 23:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718001209; x=1718606009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQNEcr7aYEFzd/ODLG26xzFqGQuBilUqHjLParrpuPA=;
        b=qMYzugBoIFbM2BPp4Dih8WdkeGC3xzNQ08Vg3TrS+0/v2DA1IslaF0FLGUCANQ9tlk
         s93pkZ/zwuRdbjh8ks9FhmbTVESYM4UuTb2k8/HyWYCzz7llFc29pgphr77DQfEEw1kf
         79LMk9J56o57fiZfeD85l6ohL0fJpi0BO/hikBgsKIiIHBoBuB7FgCR1kEOXwkNvmijD
         9G+aO4/0t3LthhnVEZ8o2HzOc81O46bXiP0mwtrspTNGKde5oth8eAxjW9cD23006AXJ
         VLKc4OvDNEriHOi/LMzzgV39ASGdaMZmKA7s5p85+fIXTpSaUdJqpeiui2SLns/NWY3H
         plJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718001209; x=1718606009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQNEcr7aYEFzd/ODLG26xzFqGQuBilUqHjLParrpuPA=;
        b=eLDYOxz5uuZlaDqlZC+n4exbyeHPSr9F9Z/Ti34zlGQDYXuRXF7I/hEIdithf3AYLL
         olCLW1Thgu8J6BGrldMoK6TTdXckuS/ZPXPA39YiISwPPxEplRRILUxvXBN+0jWPYLk9
         JPcUybLTN/i161JvDSoiJEqw91R0HL2tcFxJua7/i69DryqP0dSRjywLpXbbfzJaI2wU
         7flwaH62BZF3e/JWUElNiull/+E8D96PpddGdUJnCB9ZpIULhGiCHoR2YXxpH7izyobK
         skjG7oKUbwJNnzMva494AtwufSHRR6RrNb5OUlHr8SvafWVDm4LZPqYURzeKvUzZKIon
         2BPA==
X-Forwarded-Encrypted: i=1; AJvYcCU804FvExjJxjRDKs5j9nsszSwY/d6R7zLKtYd5+0vDenYiIGByyN7peIdTMPvrypvvQdbufwoA9cJCePy3tHMk0bDW3zQq
X-Gm-Message-State: AOJu0YwRk6M3gCJR3Xg79sA/GHFtYvbm8E/3KxYRmR6OEjug/dcthXEf
	kXZmJ0C1BzUV6NGmpaIayhsUqHB1RFO9/B0D38t3M1W3irUbqK2KALrfLjedYRQ=
X-Google-Smtp-Source: AGHT+IGV/owdDyjVo3f/ECptzRnxUUL+WHlr8h3hjAIH9EqyW/9FPsVqcCwdzF86NFnF0EeUsZ3hGA==
X-Received: by 2002:a5d:58ca:0:b0:35f:1caa:e8ea with SMTP id ffacd0b85a97d-35f1caaeccemr2471531f8f.20.1718001208924;
        Sun, 09 Jun 2024 23:33:28 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0c8f5373sm6989383f8f.6.2024.06.09.23.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 23:33:28 -0700 (PDT)
Date: Mon, 10 Jun 2024 08:33:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, leitao@debian.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: dqs: introduce NETIF_F_NO_BQL device
 feature
Message-ID: <ZmaeNfHr-D5jTsq9@nanopsycho.orion>
References: <20240609131732.73156-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609131732.73156-1-kerneljasonxing@gmail.com>

Sun, Jun 09, 2024 at 03:17:32PM CEST, kerneljasonxing@gmail.com wrote:
>From: Jason Xing <kernelxing@tencent.com>
>
>Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
>BQL device") limits the non-BQL driver not creating byte_queue_limits
>directory, I found there is one exception, namely, virtio-net driver,
>which should also be limited in netdev_uses_bql().
>
>I decided to introduce a NO_BQL bit in device feature because
>1) it can help us limit virtio-net driver for now.
>2) if we found another non-BQL driver, we can take it into account.
>3) we can replace all the driver meeting those two statements in
>netdev_uses_bql() in future.
>
>For now, I would like to make the first step to use this new bit for dqs
>use instead of replacing/applying all the non-BQL drivers.
>
>After this patch, 1) there is no byte_queue_limits directory in virtio-net
>driver. 2) running ethtool -k eth1 shows "no-bql: on [fixed]".

Wait, you introduce this flag only for the sake of virtio_net driver,
don't you. Since there is currently an attempt to implement bql in
virtio_net, wouldn't it make this flag obsolete? Can't you wait?


>
>Signed-off-by: Jason Xing <kernelxing@tencent.com>
>---
> drivers/net/virtio_net.c        | 2 +-
> include/linux/netdev_features.h | 3 ++-
> net/core/net-sysfs.c            | 2 +-
> net/ethtool/common.c            | 1 +
> 4 files changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 61a57d134544..619908fed14b 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -5634,7 +5634,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> 			   IFF_TX_SKB_NO_LINEAR;
> 	dev->netdev_ops = &virtnet_netdev;
> 	dev->stat_ops = &virtnet_stat_ops;
>-	dev->features = NETIF_F_HIGHDMA;
>+	dev->features = NETIF_F_HIGHDMA | NETIF_F_NO_BQL;
> 
> 	dev->ethtool_ops = &virtnet_ethtool_ops;
> 	SET_NETDEV_DEV(dev, &vdev->dev);
>diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
>index 7c2d77d75a88..9bc603bb4227 100644
>--- a/include/linux/netdev_features.h
>+++ b/include/linux/netdev_features.h
>@@ -14,7 +14,6 @@ typedef u64 netdev_features_t;
> enum {
> 	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
> 	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
>-	__UNUSED_NETIF_F_1,
> 	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
> 	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
> 	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
>@@ -91,6 +90,7 @@ enum {
> 	NETIF_F_HW_HSR_FWD_BIT,		/* Offload HSR forwarding */
> 	NETIF_F_HW_HSR_DUP_BIT,		/* Offload HSR duplication */
> 
>+	NETIF_F_NO_BQL_BIT,		/* non-BQL driver */
> 	/*
> 	 * Add your fresh new feature above and remember to update
> 	 * netdev_features_strings[] in net/ethtool/common.c and maybe
>@@ -168,6 +168,7 @@ enum {
> #define NETIF_F_HW_HSR_TAG_RM	__NETIF_F(HW_HSR_TAG_RM)
> #define NETIF_F_HW_HSR_FWD	__NETIF_F(HW_HSR_FWD)
> #define NETIF_F_HW_HSR_DUP	__NETIF_F(HW_HSR_DUP)
>+#define NETIF_F_NO_BQL		__NETIF_F(NO_BQL)
> 
> /* Finds the next feature with the highest number of the range of start-1 till 0.
>  */
>diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>index 4c27a360c294..ff397a76f1fe 100644
>--- a/net/core/net-sysfs.c
>+++ b/net/core/net-sysfs.c
>@@ -1764,7 +1764,7 @@ static const struct kobj_type netdev_queue_ktype = {
> 
> static bool netdev_uses_bql(const struct net_device *dev)
> {
>-	if (dev->features & NETIF_F_LLTX ||
>+	if (dev->features & (NETIF_F_LLTX | NETIF_F_NO_BQL) ||
> 	    dev->priv_flags & IFF_NO_QUEUE)
> 		return false;
> 
>diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>index 6b2a360dcdf0..efa7ac4158ce 100644
>--- a/net/ethtool/common.c
>+++ b/net/ethtool/common.c
>@@ -74,6 +74,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
> 	[NETIF_F_HW_HSR_TAG_RM_BIT] =	 "hsr-tag-rm-offload",
> 	[NETIF_F_HW_HSR_FWD_BIT] =	 "hsr-fwd-offload",
> 	[NETIF_F_HW_HSR_DUP_BIT] =	 "hsr-dup-offload",
>+	[NETIF_F_NO_BQL_BIT] =		 "no-bql",
> };
> 
> const char
>-- 
>2.37.3
>
>

