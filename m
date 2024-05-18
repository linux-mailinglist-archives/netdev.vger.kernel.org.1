Return-Path: <netdev+bounces-97114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541818C9238
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 22:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10386281DAA
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 20:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCF954917;
	Sat, 18 May 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCOotVOl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4DBA29
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716063903; cv=none; b=ilVzEVbMtfdocoY3pQmG1NyIoz1ki1W7Cs4P2G8LCBKj3z4aj7bYsOhWCC+jwEA3Xk2HjrzrhbEA+P+LSBRMhWu4kjANbGZnHcA8phwt4rBQ7w/i3KIRsZUhNX6iAfcTEr9WpCi2yfH5SpjNNkKUZ/DO/l0DynakqTrsj5MwJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716063903; c=relaxed/simple;
	bh=EqbqVPgaCDHPrBfiwoucADSzgQAgzBriUz68zPJpF0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZiHgTpaL5+kXeicffia71Bp11D4SXL0NJaPXVUjQ512J1SAqjcOjJlR0a9EDIP03e8Mg0rqdyj+S8hnzUUdMl0DcjNK8397by8V2LzvNevX+BVeSyaksenCRAsALfeN7ulntQ3/jIz3atTuYMKAhuxHEt2jpigugs0EkzKkeYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCOotVOl; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so2431436a12.1
        for <netdev@vger.kernel.org>; Sat, 18 May 2024 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716063900; x=1716668700; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kde2T4tOYT5RpAyyKKTezqvTbCUDs5ucfquZ+B4ig0w=;
        b=lCOotVOlrgM5oeCWCQ9nEWOG+73e8bX7OA/9/mIiOe6IgGuH2X9sTLTqKZvMt4SL0C
         T5TR8AmyKcSDnvpFAwxxByXHs7E5ytxEg4tHxXjnewMyyA8HddyGAULj9nrZ3twXYLgM
         99w0UZpi2SJHH9sO50cIyDdboL2r8rsHYuu+eRvdqf8wUvrtoXMkM2pHskSndCWCtsrf
         ew8PSGiTIbo8I2gxVPzVLU9Mc7gHX125tCOw5nAC5k+fjMDZQZcO8A7gcMb4QW6MyRCf
         6svKgtuRVLiqBSLM1swDKYOn6GwbZq+8E7ZaCnEXp8h9k9ji9rEx/j3euV3W/iDig2IZ
         wbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716063900; x=1716668700;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kde2T4tOYT5RpAyyKKTezqvTbCUDs5ucfquZ+B4ig0w=;
        b=G5L7m3kxq9QoAzN4C11lnEDSF9j6EzML6+PyqJOBrk3U2D4NB7joUpLwHOmwNFtuuH
         zR1T80rbGZu0Xwhfk28Fh2TWngfyfkJ8D2PS7thsq+MPFfkWDKXEWtIritAlSXBnVbpQ
         fHgPhbm5kR/spAs29BwTyt4wte0L8Ct/q0bWoIut/mcwp170XktpIF2F/OKBQP3CLAEY
         gyU2xHyGpPCq3Oq5v9ol0e4FUEoiSCWzFw3IP0rgAZPVLe7Eelc7q5n5u5ZdLTzDA8/f
         YAgN2BccFtruKlC/Ize18eOBb5w28e4bQFcMUiFaRtpxvMLSmx3XMVrBEIIOypIF8qX0
         SMeA==
X-Gm-Message-State: AOJu0YwPATzhcwrraaS0kHaugt71c01JxRcKfpN3C964qwsU3h10ThoO
	q4iWYn6+WQkJSnMFK0AacU2uI9ErddjoQQqwQz7GUnwyYDLU9b0=
X-Google-Smtp-Source: AGHT+IHliKyM92jfYHmJXlYgKSqKNJlGHB+NeXDGwPZAPkjDkmPF/eBIsgECUXhlSWLcv+QRpE6H2A==
X-Received: by 2002:a17:906:560a:b0:a59:df1d:f5ae with SMTP id a640c23a62f3a-a5a2d5c9dc7mr1594873366b.31.1716063900096;
        Sat, 18 May 2024 13:25:00 -0700 (PDT)
Received: from p183 ([46.53.253.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cdeacb2casm403005566b.67.2024.05.18.13.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:24:59 -0700 (PDT)
Date: Sat, 18 May 2024 23:24:57 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH] net: set struct net_device::name earlier
Message-ID: <d116cbdb-4dc5-484a-b53b-fec50f8ef2bf@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I've tried debugging networking allocations with bpftrace and doing

	$dev = (struct net_device*)arg0;
	printf("dev %s\n", $dev->name);

doesn't print anything useful in functions called right after netdevice
allocation. The reason is very simple: dev->name has not been set yet.

Make name copying much earlier for smoother debugging experience.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10952,6 +10952,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev = PTR_ALIGN(p, NETDEV_ALIGN);
 	dev->padded = (char *)dev - (char *)p;
 
+	strcpy(dev->name, name);
 	ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	dev->pcpu_refcnt = alloc_percpu(int);
@@ -11015,7 +11016,6 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	if (netif_alloc_rx_queues(dev))
 		goto free_all;
 
-	strcpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
 	dev->group = INIT_NETDEV_GROUP;
 	if (!dev->ethtool_ops)

