Return-Path: <netdev+bounces-166023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20FA33F5C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225A4165F07
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B6722173C;
	Thu, 13 Feb 2025 12:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D3221563;
	Thu, 13 Feb 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450580; cv=none; b=CtF96sEGRsklbprijfMTq2ij+9Kv9D+2yNxL7HkCo+/A5XU4z5gFwD1ey0xe2GD7ilTkDIQTRgRM6b/6yMJgeGRiGomYiK/FlHiOuuLUNJQoYu9NhVCIe0Vr4xP1huIClyRdwsLoYS4Gpk9bM4vvwj6mXEOfQe+tWAsGESRQ6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450580; c=relaxed/simple;
	bh=MmbA9RrF7ALqtyzx75FFFXiMMC/TpZ7raLFPGdfQnCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxjNuakQM1W1s9g4stXVF9p50uOCb+f2jVc1++6RXMEvJTq+L2wnrvwLCllj8efsrOUhWwIwO0MmvRYAzwWc8rf22jX1l8mgc/wdcGNMMo6unQBb/qgnEqz2sopQPR30UwuR7E8bGsZakTGozN2ahGS7iAr9+jRropjUfnYOYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso111679466b.3;
        Thu, 13 Feb 2025 04:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450577; x=1740055377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMrRvHw0eAyx1Hypckg8ufA/Zs7rqsQxI4OgyHPlExw=;
        b=Oa2lm2/lUKBrPQsF28abm2fA2fzCu/SA2110+2wFpGaaNU1+/JBPh/uqYJWddS2NkW
         iNoZx5l3kIwWwrUdxEpI2NmJK5T0i12ZiUy5u4R78jiISv7ejoK7MeHQhFeGNMHIcP7o
         ulYrKhpbkpMgwjY64Rz+B02gCP9rqXjiQzxcqrBGH24M8TcXpwZ4b77tpCZPmrVicapQ
         cXo0woL7NHwcpTyMrxwGRwzA0FOEDJFTa99h0jpgKC16KhrbdjgGp84hePhreFT+iITf
         Gziw0fwQeYbCv+SMf111c4vLihxAT/QezNgWb03uZ/uti+6p7u/DRk577TWyy03ETQOI
         eAhw==
X-Forwarded-Encrypted: i=1; AJvYcCUzxGfFNa7JPuJnk4EBOTJx76zPI4/nNI8e73UDP3kJHa5ZYv4kBj11aij4omAy/RgpkLaLQYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI94V1gwJuG4AF4f1gCkkOihn5GNEqbGlLEOHiY6j9HEhSo52g
	UWYNvJDNWfgLoOv8YPtdkWFv8HNaQWiP1avfwnNHk8dW+K+Hk2vQ
X-Gm-Gg: ASbGncvUrdSBLaEUwvLUMu1ow9LEzp0hHmk/lowBZCsE6MJ89MqLnpzuy5+9aHRJtP5
	9ms0Z4Ese5VUfgxRgelvDdUKAYKfGT+P0W89/yDGRPVFxSMKLk7sZIkOKvechgsRsLxqYCWETEL
	YMYwhdGZrnQdCM0QqF84WSPwhwq/nvhbSCnv4w6HLk9hvDlBLaId8w/+imkQr8C/eN2PKb/3H51
	MVYfWjVCUlhBkvd3/ETlZ8rZCD3gHGKKmoalzkAfJTExYphgs6tEGaJYlP5TNj0j9+SfjyiqOy7
	wFvEfg==
X-Google-Smtp-Source: AGHT+IGy4Vt/l1Zp8icoIijih8k9HhLkFklQs2rWghGvTUW2p6IFEeSxox0E5iZGEa+EooH3HMQ7Zg==
X-Received: by 2002:a17:907:d113:b0:ab7:e8d8:854b with SMTP id a640c23a62f3a-ab7f347ebabmr621097266b.36.1739450576772;
        Thu, 13 Feb 2025 04:42:56 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339d9cfsm124844166b.139.2025.02.13.04.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:42:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 13 Feb 2025 04:42:37 -0800
Subject: [PATCH net v4 1/2] net: Add non-RCU dev_getbyhwaddr() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-arm_fix_selftest-v4-1-26714529a6cf@debian.org>
References: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
In-Reply-To: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, Breno Leitao <leitao@debian.org>, 
 kuniyu@amazon.co.jp, ushankar@purestorage.com, kuniyu@amazon.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3614; i=leitao@debian.org;
 h=from:subject:message-id; bh=MmbA9RrF7ALqtyzx75FFFXiMMC/TpZ7raLFPGdfQnCk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnrejNsqQQiBtzU4jnlqPf9nJzjjlns9sRI31N9
 roN3Rv6B2WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ63ozQAKCRA1o5Of/Hh3
 bZbUD/9fjxPH1vTr+OV5YXtWrTqRSmjlSLznwoVsm3SglvucgtaW6AMbC4zeBPuV3II5lto/AHY
 MflPqKd1IvqS3cSpDhNXsUzW+U5n2X55pHt7eIXHW7Unuxhamp44VVaplfPvW01+zfz++MBLLdK
 kEYByD3UVUGBbfwyTxckQK1d7VfH30zSSlurwGVOQYRPmamIjRk+k79IHb39wQiUhscuiXMrHIF
 GsCU3MkcADvEbPoRJ1hClT6kB8fFqh62iHs5kNQj9HJqX5QG5z8CGTNHRF2Th+U/qVclFckmhJL
 rYkkdUjMaO0h2iikW8uadljGRVslFpi7m3c7hWIf3ZY6Q9O4OLz9SnFSd/5gKDgsUV/OEyYght7
 3PhaTYJ+vhPN0PqGNuVf6YnafhRnjKR22NR4Rcuc94v18u392SMEInHIZL4536EmKdzwg/fE+Lx
 DT80bhv7zNhMD44WbPFFxmBNNni+1gttk4Ja2l1EZHUC0u/LpZYOE1dk5QJl1UEjf0K1b3gQ4as
 hkyJgu7Z21LVYB2tvVb7itFQIU25wMNV8k25ycGm6WqHa/EDjJ7/R7ANIhfuK0O2QW6EbURfR0/
 KAO8wpmzjnAA4fsaO1xQj8GkwFkyIQD+oTbbZL31eQjcxlp+bTEp+bzY1L+vxByCm1Bc4weVSFV
 fXLIS5L8E6CUtIQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add dedicated helper for finding devices by hardware address when
holding rtnl_lock, similar to existing dev_getbyhwaddr_rcu(). This prevents
PROVE_LOCKING warnings when rtnl_lock is held but RCU read lock is not.

Extract common address comparison logic into dev_comp_addr().

The context about this change could be found in the following
discussion:

Link: https://lore.kernel.org/all/20250206-scarlet-ermine-of-improvement-1fcac5@leitao/

Cc: kuniyu@amazon.com
Cc: ushankar@purestorage.com
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 365f0e2098d13f40ce6d8865962678b052b39a16..ab550a89b9bfaa5682e65f1dcc7f5f99ce90eb94 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3275,6 +3275,8 @@ static inline struct net_device *first_net_device_rcu(struct net *net)
 }
 
 int netdev_boot_setup_check(struct net_device *dev);
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *hwaddr);
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 				       const char *hwaddr);
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type);
diff --git a/net/core/dev.c b/net/core/dev.c
index 55e356a68db667982e7e62d09d07feecc14deebe..6d5bb4a5511dc6ad0cd2a0feddb9c1c689ed7ab8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1121,6 +1121,12 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 	return ret;
 }
 
+static bool dev_comp_addr(struct net_device *dev, unsigned short type,
+			  const char *ha)
+{
+	return dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len);
+}
+
 /**
  *	dev_getbyhwaddr_rcu - find a device by its hardware address
  *	@net: the applicable net namespace
@@ -1129,7 +1135,7 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *
  *	Search for an interface by MAC address. Returns NULL if the device
  *	is not found or a pointer to the device.
- *	The caller must hold RCU or RTNL.
+ *	The caller must hold RCU.
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
@@ -1141,14 +1147,39 @@ struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 	struct net_device *dev;
 
 	for_each_netdev_rcu(net, dev)
-		if (dev->type == type &&
-		    !memcmp(dev->dev_addr, ha, dev->addr_len))
+		if (dev_comp_addr(dev, type, ha))
 			return dev;
 
 	return NULL;
 }
 EXPORT_SYMBOL(dev_getbyhwaddr_rcu);
 
+/**
+ * dev_getbyhwaddr - find a device by its hardware address
+ * @net: the applicable net namespace
+ * @type: media type of device
+ * @ha: hardware address
+ *
+ * Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
+ * rtnl_lock.
+ *
+ * Context: rtnl_lock() must be held.
+ * Return: pointer to the net_device, or NULL if not found
+ */
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *ha)
+{
+	struct net_device *dev;
+
+	ASSERT_RTNL();
+	for_each_netdev(net, dev)
+		if (dev_comp_addr(dev, type, ha))
+			return dev;
+
+	return NULL;
+}
+EXPORT_SYMBOL(dev_getbyhwaddr);
+
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 {
 	struct net_device *dev, *ret = NULL;

-- 
2.43.5


