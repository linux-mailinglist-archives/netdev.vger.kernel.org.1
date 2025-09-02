Return-Path: <netdev+bounces-219002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC09B3F5A4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D6E485857
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 06:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539CE2E4278;
	Tue,  2 Sep 2025 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vt3xR57n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE322E2EEF
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794975; cv=none; b=naQdAqk747XzUqco/6WsW/EeXTsQ/gD3tOtUTigrswNScxAAhc6YG8hDz2bRXijENM2COFFoQ82cQ30Le420S3y3jqmxuNJHU9ZlUHSXZ/609M8/aRp9rNWHIB/nQmky6KZZvUkFVie8A+nY/s8zlvyIMzUj24Xz3zzRqqJZhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794975; c=relaxed/simple;
	bh=6o1HYNN/dUuD+wcTmY+l3ujIlcfH+7+khCxsWHpS13w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QRw5A6dMCUjsjKLOlijdgp6r49wLKMlZnATx/KBz9AiSeNkUQNcaHa/mk6FD440f1gb7yJmwwqjkBsq8oXHguadOJ+69AzpgywhRdqoBuyDpvLInpdGXieOWgMqzaWb4aBKGKBaqiyAfVN0pXbLQ7ftwKx5NSKFca/gyRNsy+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vt3xR57n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b9853e630so2941665e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756794972; x=1757399772; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svG16miHK9ueNH/Jqb88BPzrj03vi8MH4xbUoVyAJ8c=;
        b=Vt3xR57nlKQHoteDwMtZF7eZj6ggB+a4zFFxQ2UZTTAU8cJ5sySmkcjA7wIPxFWZnc
         XcnuGFferDIEhbAFRyAnJfs3yxVVyrAYTcWaVHPwhUvA8CKDLx7pS6xUy6aeyD65qrDf
         beLkZzpvELIlo2YEevA/AoJ6+6IzlIsD0f/7v/s4uxyPXKHyepBEjnXfVLBw/7vR+11B
         SHD4TCXgCZ4+egQ7psSbYSxX/oROH5WEzt1eXwRrJ1VrCHBdQ+96gMBgpvsrJq6/6MZG
         Av6CSJ99i693H6CREER2dmwkGYfayVZDUpljhHX0r8w/PL3qULWOGabPSiXcf6lpJmCN
         MUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794972; x=1757399772;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svG16miHK9ueNH/Jqb88BPzrj03vi8MH4xbUoVyAJ8c=;
        b=FO+bjgE2HGnAHn9EPdrYdzwNKDBCN9ufU4HhuMsUPDS0wzj8XzQ7oiGDEPMzpEhbJF
         2ScTZcukk3NMV2sVBF3SBisMU7Xa/IVUlTFfCZeNGGamfj1YoMSRxgmN2jjoNI8ZMVkf
         vpMaKt/NdYObBE4ms1wt2Ac2l7cqF8Rv3IS8Eth4TzHbvCX+APKJ1Qr9RUqZbOUUF7x/
         Ws/KbYz0AdK1ceGnT/sG07O2fsvD4aNOAKaKqXMskIXIV+CXiPGf+viG+3BrhRPZz+cj
         ORY709uo5+igmG9S4iL0GP7dQ9DWUDbDa03KcO5Tw6G4RGtsvGJI4IllpQq7/NqtjuHV
         vqFg==
X-Forwarded-Encrypted: i=1; AJvYcCUkUoHZQlf6Hyw/LwIOM91zGSDZ1JI51JzWWn/wbEAVU5goPUTMBmcPYU41aLLhr4HPc0mB90w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwn/TvbB7x2hJrYZ6OX++BMh1UP+09omzJao4kQO+ZatZEvZss
	+8+IXFPScmL69PhFL3T0QjjuM1AO+Npx7ANes0UqKtp+cZ4IJ2Oo0+CPYrEHE1pmCSk=
X-Gm-Gg: ASbGncs19/m8cSvVOXi1vZ0rifGBE2Gg/Gg7eQ7LxhjgvkXMnQLUttNZrZmwjV+QQ1y
	yuOsNirQ8TMVodMZFtUROAP3sSBp1U0XYpP+0zk7A+qWFZAX6eO6xGvzvez+AG1hF8JafaC+uVU
	suF2yyvgeVYc7kgdYdabLJEsBqlUb+/wirtxOqraEel+lmuM46LNMpcsLZGSO1bBvDHsfzdzB0w
	zSLPH/9U903tR9Q8EptbVaVt553vuN4gtFUraQ2NCifHDlVeqOceatM5QlpZwGPUGzNdiC3X8Dd
	+kZ6jxYDt2u6gO82oKxJb1+qzr3bOJ0ZLlaO0JooNa9oWe+vEz5s7WSDnKAP/elX3Chkq+tbEBd
	6D/GYlXxSkiGI8vi8E3VCeME2PL4=
X-Google-Smtp-Source: AGHT+IFb9K51S0e+oVxQPokUpc6sM1fljdvNP8zGuh2xzGHBl93SOWb5C24qmpOhtsg6GVrvALfX2Q==
X-Received: by 2002:a05:600c:4515:b0:45b:7bee:db8f with SMTP id 5b1f17b1804b1-45b855b32b1mr81893475e9.25.1756794971816;
        Mon, 01 Sep 2025 23:36:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf34494776sm18103336f8f.61.2025.09.01.23.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:36:11 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:36:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] ipv4: Fix NULL vs error pointer check in
 inet_blackhole_dev_init()
Message-ID: <aLaQWL9NguWmeM1i@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The inetdev_init() function never returns NULL.  Check for error
pointers instead.

Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/ipv4/devinet.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c47d3828d4f6..942a887bf089 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -340,14 +340,13 @@ static void inetdev_destroy(struct in_device *in_dev)
 
 static int __init inet_blackhole_dev_init(void)
 {
-	int err = 0;
+	struct in_device *in_dev;
 
 	rtnl_lock();
-	if (!inetdev_init(blackhole_netdev))
-		err = -ENOMEM;
+	in_dev = inetdev_init(blackhole_netdev);
 	rtnl_unlock();
 
-	return err;
+	return PTR_ERR_OR_ZERO(in_dev);
 }
 late_initcall(inet_blackhole_dev_init);
 
-- 
2.47.2


