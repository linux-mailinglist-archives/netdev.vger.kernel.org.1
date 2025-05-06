Return-Path: <netdev+bounces-188230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC0FAAB9DE
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B111C40F86
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BC2882D9;
	Tue,  6 May 2025 04:06:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4270360316;
	Tue,  6 May 2025 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746501814; cv=none; b=L3sBrzBoTbgBPhljqgEQ1xSg0tr5TTExwOtcoooTgEMwruxjmF1OBMCHoIxuQ+LqPs9ATIqwHAJNIwZBXf/KaThc0rVyV3CwO8SHV5wCTY8Nv00HhHhzyAp/5i4+IXzOHnAklb4B2Yj9f4Lehx95N11NLYJqboWr1VbIUxUqh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746501814; c=relaxed/simple;
	bh=88/cW2eOCSmZmQKw2Hc+K8hXwwfz2tenLj7EWsMESxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHHz4eRAWcF2RZTS80EbJucbjTr+naKx2pyJq6DP0S8M4LnWADVHKxjvAzjnbXeB22hwILeZfcJ6jbi509OXGQkmWCPxtQkV+ReCE7bYny0r+DdQ2jjdx+hiiFXd+u5iVy8JTLbQ/xCGIfsdgiQn0ZjCuvJ3jPduJBRyZinzzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22928d629faso47825925ad.3;
        Mon, 05 May 2025 20:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746501810; x=1747106610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iJCv4ET+7o0nSYXxo+hq86hijhA7Bxxnf2OGc3/g6A=;
        b=fbt5DzKkG3Na1+j+k3GyGNKqPjfekgg0Adw9IxIZNXAf1tSk6w3qrJ4aCySs32QD0c
         5v2X1Sl9Gvyd0D6Hga3HQpppfPNlF+g79qA9vJqyY0djIMVz3Uc0bZt07r5iFyds+/sS
         Yf1dKWI7uYW5kA43b7I1t7TWHLdrR1CRetcZDaweEchTefvjUoAYB/Qmfev8qg/yrNSl
         kuq5PuZIHQXA92QR/or9U7SeCzozrhdScp0sIwl2ldpMZbAg7O2vQ9bAITu+AdRDUd0t
         XdkBZvYoxTj4N6vvTJc3dAIOM7byIDn9EFLeldlFc8Anbjzm/MtmSYgZPjpOEgJlH5Ky
         7Ltg==
X-Forwarded-Encrypted: i=1; AJvYcCUxJ795ND00FQ9p+y1/QJnKqkzki5/GRVLcIRihUV4ttwZwEx85tjKk5ngw54IGuJ8H/gj5LZ5/uAi/GcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuwuN6Xc65ti3KZnZyDqqJz7/iHDU5pwTOooKcXFHlqyEim2Xs
	ucggKKTCv9hYFpqSW7WK9HFfqXma4tcluM+coU5vnGHF4kGXfI+N9AJx
X-Gm-Gg: ASbGncvu5m4ecphz9HxTKKrtK3Vun04X790ook69D93K88hCTPWTFM/9atWIRVC30Ks
	772wIuS8H7Z927Ko5t4ZIUsnLymN6Xvc3Pvtu5SwOfuZ6i+a00yg0HCaZzK5qyyvXZ5UgbIhMy2
	xeayv8n2vS9qLgp1EHqP7iYURr9C6TbFRsieLB/cZXvxHBqqVw+cgHqU++M3HQjU/VKdgfilB/K
	23lEPQjkCJvv2jVxu7B1qtdaZ2UKdOfXKcUaXv12BHsBnzAi4t9xHIOO9SjSEsnyv316V2Pw1fA
	0wyEZEIanmlGXR7bU3sFgdSZTSPJX/jcs5UWb6c0PEUzHDuCXTx7lmx16i82dbRiobBTzHqU2vL
	hcoN2gn6yUQ==
X-Google-Smtp-Source: AGHT+IFKx8KWehus5QYFoZ/lKddPGSEpHeHA4FUKPZqVery3LPVL90LujiH1Yud4hG2m1QCGox0yKQ==
X-Received: by 2002:a17:902:e5c2:b0:22e:1697:5bf6 with SMTP id d9443c01a7336-22e1ea7f298mr144003745ad.41.1746501810171;
        Mon, 05 May 2025 20:23:30 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e1521fbedsm62998905ad.124.2025.05.05.20.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 20:23:29 -0700 (PDT)
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
Date: Mon,  5 May 2025 20:23:28 -0700
Message-ID: <20250506032328.3003050-1-sdf@fomichev.me>
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


