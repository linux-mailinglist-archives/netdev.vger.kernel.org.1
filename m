Return-Path: <netdev+bounces-202578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D878AEE4DB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D036B3ABF49
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811C290BCC;
	Mon, 30 Jun 2025 16:42:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4299D28FFFB
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301754; cv=none; b=kspC4ViadL/ahb9QlMaphQSGmFmq9dhZREb45NmadJ6oRSt3ac7strmXQynZRaOeboNrDgqXIdklEFGrEZaolRToA04DtE12MhonXLsnIm1WQWyM6hgaGlZom8D5xPy00bb4gE2/e+rSoBeeI4U+Q2FTYiWDl8jEcMlCx8yGn5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301754; c=relaxed/simple;
	bh=w4neRsTsxWg/8Sb5mjCj3+0zyi9ygd/+u7pUYi/AHRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUfPpLIrpl8hiidw8QaT+ER3Y53qNElTMlYrRSDKai8NTSZ1L302BMtG37kuGT6RST7J+2UoXraJpv8eSbQNAhqCYFH7Ms8EzoDKaMo7uq5TSXclZCVdYoArWj9TpfDOD9XXRwBnQVxLOY5tQh2ZIQsy2YlIDxlKIMODppuq88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so5322767b3a.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301752; x=1751906552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5792hYviz3Yk2ulwxJcj52awHK4wre+iGUwkPhpNz3A=;
        b=Yq5OaJjq3muy0mZYOUkA2WFZskfFQF5s0HPui9AJJUdxectCU2jYkSgk92kyEHyE1L
         PpKEOxy4PTPaFmiQ91P6H5wSy+k94PJSepWQyBRh/LjE8pfjF479hBo811rRk/B34hLP
         1fGsxstlkUu3zT991nUZGMzYcQpy4TAnwnHlqe7iZUFT+jyyNVhCVB9VNK/BTBJxefOa
         Mn4bvX2i9YYlwfukFoeGxYu7ixOoB42D1CHOm/VV1Etr+6A9t9Fgu0KXbirPlKSwuv9O
         5/1MaKutzVOTHRA3ZZ+y9ei3unQ5oas5bGokdpMoZJjBcellPkKy//RTBrLRKqqaHcfm
         lP7w==
X-Gm-Message-State: AOJu0YxuWUz+LDM4pk15dNrcw+S0zvHVBJP9i9xBYE9eMsvv1Z9IW8aT
	YkJeidrVKN1NCOEsgQSSpbQ+OzjN2EYpOeoNS0hgbEwnpnCP13ur2fRH4iY2
X-Gm-Gg: ASbGnctp2f8vYL9bbUsxcl8Ttp47KAfVFt/W4C2T1lIrhGAeGcfcN0HJkp/YLw9627v
	kLu5MJlmgaQr0LOmJ5eJ1dU6VoY2n3MCBJ7B813vjeMaIQVdg7B74CC/arBVKxRIqu1HYXobEK6
	8jAvNXdidX4LwJxmJbz1gbA+0BYEjtffQHgtApfBIo4uX+kuzvoJ+xzGDaz6lHPfVbEEAySiwCg
	KG9Cbs6N8XrzDOcucaJiqG+UJFjZeFutJhoNRLSaljtlzgItrtA8H3Ych4URAzsGbo6c7csQH8G
	75OyJuOlG7LXIZWwvtkwFuCyz2jUnpfL830dHztBoEKZip3CaIVsnEz4oaUzk7nO/am072CuFCm
	WE6cgQC1aG8pniXOeioCv1CYa3wsveHwGvQ==
X-Google-Smtp-Source: AGHT+IHJX+SNJ6hwKg4A8r14qHLOdMEy0quEPZzDjhuQkjVzV7lLhkUmqaGilwRFjS47yPSJptPz1g==
X-Received: by 2002:a05:6a00:3d55:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-74af6fd703bmr17649658b3a.21.1751301752090;
        Mon, 30 Jun 2025 09:42:32 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af540b3d9sm9308844b3a.2.2025.06.30.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:42:31 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 5/8] net: s/__dev_set_mtu/__netif_set_mtu/
Date: Mon, 30 Jun 2025 09:42:19 -0700
Message-ID: <20250630164222.712558-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630164222.712558-1-sdf@fomichev.me>
References: <20250630164222.712558-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc34acd577f1 ("docs: net: document new locking reality")
introduced netif_ vs dev_ function semantics: the former expects locked
netdev, the latter takes care of the locking. We don't strictly
follow this semantics on either side, but there are more dev_xxx handlers
now that don't fit. Rename them to netif_xxx where appropriate.

__netif_set_mtu is used only by bond, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c | 2 +-
 include/linux/netdevice.h       | 2 +-
 net/core/dev.c                  | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 805e50eee979..d9788677b42a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2654,7 +2654,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	if (unregister) {
 		netdev_lock_ops(slave_dev);
-		__dev_set_mtu(slave_dev, slave->original_mtu);
+		__netif_set_mtu(slave_dev, slave->original_mtu);
 		netdev_unlock_ops(slave_dev);
 	} else {
 		dev_set_mtu(slave_dev, slave->original_mtu);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 85c0dec0177e..454cf4bb513b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4210,7 +4210,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       struct netlink_ext_ack *extack);
 int dev_change_net_namespace(struct net_device *dev, struct net *net,
 			     const char *pat);
-int __dev_set_mtu(struct net_device *, int);
+int __netif_set_mtu(struct net_device *dev, int new_mtu);
 int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
diff --git a/net/core/dev.c b/net/core/dev.c
index fc3720d11267..250b64810733 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9566,7 +9566,7 @@ int netif_change_flags(struct net_device *dev, unsigned int flags,
 	return ret;
 }
 
-int __dev_set_mtu(struct net_device *dev, int new_mtu)
+int __netif_set_mtu(struct net_device *dev, int new_mtu)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 
@@ -9577,7 +9577,7 @@ int __dev_set_mtu(struct net_device *dev, int new_mtu)
 	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
-EXPORT_SYMBOL(__dev_set_mtu);
+EXPORT_SYMBOL_NS_GPL(__netif_set_mtu, "NETDEV_INTERNAL");
 
 int dev_validate_mtu(struct net_device *dev, int new_mtu,
 		     struct netlink_ext_ack *extack)
@@ -9624,7 +9624,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 		return err;
 
 	orig_mtu = dev->mtu;
-	err = __dev_set_mtu(dev, new_mtu);
+	err = __netif_set_mtu(dev, new_mtu);
 
 	if (!err) {
 		err = call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
@@ -9634,7 +9634,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 			/* setting mtu back and notifying everyone again,
 			 * so that they have a chance to revert changes.
 			 */
-			__dev_set_mtu(dev, orig_mtu);
+			__netif_set_mtu(dev, orig_mtu);
 			call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
 						     new_mtu);
 		}
-- 
2.49.0


