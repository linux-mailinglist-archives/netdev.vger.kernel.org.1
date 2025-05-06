Return-Path: <netdev+bounces-188209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F3AAB923
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6873B3419
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E351290DAD;
	Tue,  6 May 2025 03:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A262BD909;
	Tue,  6 May 2025 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494365; cv=none; b=glgcd8CKVRD4XAImqLSGA8CkUD4NwxGOjGuJRuZzQ+6IbXLyREP+qAHzozyzM2t+CsW21Ege4JQ58saEslXg6eN9APufwaGVOuD9rPJEXdv2wxNKSSQFBG18F1wLJ+ajy/d9cRsHT5JIZedMV2O5Ki/OgR1SD31rwck5TjYK4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494365; c=relaxed/simple;
	bh=88/cW2eOCSmZmQKw2Hc+K8hXwwfz2tenLj7EWsMESxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgzDGoN3gnr0cva26Gv69vguN7egwL30r0JcraKMkVzsV9zqZC6svOqvXRC332TeLJNmMiMlpiUKbnPHd2dhjWNxexDIJMVxjww05L1Fh5ru3WN9JdnFomafj/Yd+/NrADftNLWX+OjFH5drvLSDWZZQKDrENWdq4SHvk6+d080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so76076a91.3;
        Mon, 05 May 2025 18:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746494361; x=1747099161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iJCv4ET+7o0nSYXxo+hq86hijhA7Bxxnf2OGc3/g6A=;
        b=C4MTIxxxxz/MfAEgKSJ1KMg5YJFsQU9MLQqtIC660buJf3Tnt2v3cpz5QpDAzSRv6Q
         cVhjxbLu1xR1jsoEtzAnxfE2LEXaJny2AM8UFoG6nTpnFElBgnZGu7Qb/1gjtriBxB+X
         CLQ/0FfojfltLjm9y76L/k1UESmQSO7zP35+SUQKtYxtdJCuPtOKt/tcNrXj0vFHLgwe
         mX4sMqM0mKtGfhk3gHR40Wl02aOQ1OykaawBy78ZUWqFmZEvtHRSPKnMGyc5L2fN3eG4
         4alUmCz+HiVC+iifMIUWiiNH9n6zktR5aA4pUPzd2e0RF03Fbd/Az+1/pdjWpTALaBAg
         YMow==
X-Forwarded-Encrypted: i=1; AJvYcCU9u1i+Uh3DCQdVNaFNl7ujPsPhauDbM8Iur8+FPOYwp/4SwBNYSrZK+gqL87wbx8dDayehm2iruKUI9R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmC07mm14o6Q8xiVOpj4TH6Ts2qH3vakDLAx8+vxeNDJ6FcIq1
	5c9qv6AsWXBn+mVdDxIGJpknD0tlJl6J0eUpSiDJldNRQ17lc8y6BV2G
X-Gm-Gg: ASbGncsL4gJ82C89LqE08kchxk2XrK1Ne27z2fFZWknGygGMFcr/RkEKiWrV7RlfjBN
	KZbCHLzld4u39m/52PhHJwfZaWIOvNmcapGIzzl8X09euFr8tH0kgqGq4OlJ2S7kfka6sVbCrVl
	oWpIStEiEvSqJuW9RUA1Qi3gOewenmXH6jOc9RHsp7YlJ8UOfiAmt/vHu0Nye29xCS1+ucV63if
	sJyVZc6NKzYgvqDtrY9/cg1PtX+0lAltd2lCSIsPduPdny8V3706DCeyTEtgOoMVOqfckJOJQDz
	5h+dD0/A6ClQzabN0sExM/BZDmeQyp3Hdo0Tk0lShIJUI7orrQAmuiSsG40LKterBFkYZUD06Sw
	=
X-Google-Smtp-Source: AGHT+IFRP1Y359t6TAO+NTVK5mKLUP6YcaDfDORBRsKZ6N8rIaHdYWSLKTvj4J0JfuYYuD2HW3tb9A==
X-Received: by 2002:a17:90b:2641:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-30a61a50827mr14709083a91.28.1746494361331;
        Mon, 05 May 2025 18:19:21 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30a8087f302sm420815a91.5.2025.05.05.18.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 18:19:20 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: add missing instance lock to dev_set_promiscuity
Date: Mon,  5 May 2025 18:19:19 -0700
Message-ID: <20250506011919.2882313-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accidentally spotted while trying to understand what else needs
to be renamed to netif_ prefix. Most of the calls to dev_set_promiscuity
are adjacent to dev_set_allmulti or dev_disable_lro so it should
be safe to add the lock. Note that new netif_set_promiscuity is
currently unused, the locked paths call __dev_set_promiscuity directly.

Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 14 +-------------
 net/core/dev_api.c        | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2d11d013cabe..7ea022750e4e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4972,6 +4972,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
 
 /* Functions used for secondary unicast and multicast support */
 void dev_set_rx_mode(struct net_device *dev);
+int netif_set_promiscuity(struct net_device *dev, int inc);
 int dev_set_promiscuity(struct net_device *dev, int inc);
 int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
 int dev_set_allmulti(struct net_device *dev, int inc);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1be7cb73a602..3b8d1e1a7e71 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9193,18 +9193,7 @@ static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 	return 0;
 }
 
-/**
- *	dev_set_promiscuity	- update promiscuity count on a device
- *	@dev: device
- *	@inc: modifier
- *
- *	Add or remove promiscuity from a device. While the count in the device
- *	remains above zero the interface remains promiscuous. Once it hits zero
- *	the device reverts back to normal filtering operation. A negative inc
- *	value is used to drop promiscuity on the device.
- *	Return 0 if successful or a negative errno code on error.
- */
-int dev_set_promiscuity(struct net_device *dev, int inc)
+int netif_set_promiscuity(struct net_device *dev, int inc)
 {
 	unsigned int old_flags = dev->flags;
 	int err;
@@ -9216,7 +9205,6 @@ int dev_set_promiscuity(struct net_device *dev, int inc)
 		dev_set_rx_mode(dev);
 	return err;
 }
-EXPORT_SYMBOL(dev_set_promiscuity);
 
 int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 {
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 90898cd540ce..f9a160ab596f 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -267,6 +267,29 @@ void dev_disable_lro(struct net_device *dev)
 }
 EXPORT_SYMBOL(dev_disable_lro);
 
+/**
+ * dev_set_promiscuity() - update promiscuity count on a device
+ * @dev: device
+ * @inc: modifier
+ *
+ * Add or remove promiscuity from a device. While the count in the device
+ * remains above zero the interface remains promiscuous. Once it hits zero
+ * the device reverts back to normal filtering operation. A negative inc
+ * value is used to drop promiscuity on the device.
+ * Return 0 if successful or a negative errno code on error.
+ */
+int dev_set_promiscuity(struct net_device *dev, int inc)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_set_promiscuity(dev, inc);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_set_promiscuity);
+
 /**
  * dev_set_allmulti() - update allmulti count on a device
  * @dev: device
-- 
2.49.0


