Return-Path: <netdev+bounces-166851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A6A378E0
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C483B0DA9
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC71ACECD;
	Sun, 16 Feb 2025 23:33:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56BC1AAE13
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739748781; cv=none; b=AIM56L0/r7fmeLsOPsantCTL6ZCjG5AEZU+vmXaAIGNIrX/C7Lx6wb2aeoTqxAOppglZcTYQYLzDIGWBjw/J7MVQHF4BCZAu7Gm3C0M7stB2mzOx21mXDfM9B6KnCcvjbqzizXxSPh2i8UfPcfFsTB8Tz8F+Ufnoen7p60RdjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739748781; c=relaxed/simple;
	bh=zjCK2cXzzxcMHewPBE9HEF+T7UmI47/IESYFI+AOgyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRLgbuhN03xJeSZEgr7Ugwt3rEKldN2afp3+fQVu0/rQuCgLV0Kv4qrVj46uDcdjb0oGwEJY8P/qWsyalZdFZB5IxQFdY26YF9y7UQ8Ol13FR3Da7MnxVDoZsR/stMsOMbVzJmaa48b8xJSR/1e30T3BnAvd9Ki8+bAxIhdb6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso95297395ad.0
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 15:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739748779; x=1740353579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4DJHIvZmKzbr8ZgUcTfwFNDka3rp+ps6EhmcP6rJc4=;
        b=A8F8KMZM6OyJrwyA6Y8uKakIGYDesDCkJTgpMA5sljKG547IBT2UeAqfaGZWMyJClj
         S4iFbH9QdZVDM4SbJLQH5cSDmr7i1AYbaFgNQM/4sEgiFUYtzQ/qj32r1gDVa/QNA0Op
         s1Zpgk94CPgt3Il7bilygTN6HSaMJOSxehdewhnnKCRFUxd2Xn09IIPxcuyaR6DgjTab
         WwGQ3EFyv+HGrcC3qMCx/bMX+rO7nTfHwJqxl5VlRipqDDt3BuisCunfWUn1WE66FAYS
         oGr/ayFqKf1em0K95FiBhlieoLWSkhMaxuXv1dPhX7nUxFaAawOAW4W9yeoWBDfEJFyu
         LYnw==
X-Gm-Message-State: AOJu0YyQZKoJYXOTjoK1egaZpmZfF3UUXnH/1aVex4cqex1U63On+/Na
	xd1h1zCsLwOcvP9Qd6Gvp0ru2qskwVF+pQGrHJsu8G6HmMPMfcTL3aTt
X-Gm-Gg: ASbGncuXmUJalBk6+2RRcHmd2THtDj6OYvYZGxmJbqhTx/ZF9ovqq5uR8JE7MqVrxJw
	9ZBrUXIG0qCySySmdMBeX9U5SsvKmg7BtyjvLEkEi31X+TXmgYknT+T7/iIfBNLaaaYjqklNc2X
	kCjXFvEO64sGvoTJUAvn06ayujqve3sfC74ElIHxXFfXAj64uBbrz3pvKcCt2hGw21NHEtJstst
	se21QslBPp1xEPRGaMNbnAUeZSLK8h+6PaoCMfoaYGhWk/yZw2JYUAdRNzZCLn1ATnMFW+4jsSD
	kBttuuW5uPN3qm0=
X-Google-Smtp-Source: AGHT+IG4Vny/HLImQr9cNkNj/JV4WOBQ9Iz6wpPUSQ5bHpFkwTAW9LHNqDFsWprL9zJ6uEZa2ZEpNA==
X-Received: by 2002:a17:902:e801:b0:216:4064:53ad with SMTP id d9443c01a7336-221040bf829mr130907775ad.48.1739748778831;
        Sun, 16 Feb 2025 15:32:58 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d046sm60525335ad.114.2025.02.16.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 15:32:58 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v3 10/12] net: dummy: add dummy shaper API
Date: Sun, 16 Feb 2025 15:32:43 -0800
Message-ID: <20250216233245.3122700-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216233245.3122700-1-sdf@fomichev.me>
References: <20250216233245.3122700-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A lot of selftests are using dummy module, convert it to netdev
instance lock to expand the test coverage.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/Kconfig |  1 +
 drivers/net/dummy.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1fd5acdc73c6..ba8ac1ce6fd5 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -59,6 +59,7 @@ config BONDING
 
 config DUMMY
 	tristate "Dummy net driver support"
+	select NET_SHAPER
 	help
 	  This is essentially a bit-bucket device (i.e. traffic you send to
 	  this device is consigned into oblivion) with a configurable IP
diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index 005d79975f3b..52d68246dc11 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -38,6 +38,7 @@
 #include <linux/moduleparam.h>
 #include <linux/rtnetlink.h>
 #include <linux/net_tstamp.h>
+#include <net/net_shaper.h>
 #include <net/rtnetlink.h>
 #include <linux/u64_stats_sync.h>
 
@@ -82,6 +83,41 @@ static int dummy_change_carrier(struct net_device *dev, bool new_carrier)
 	return 0;
 }
 
+static int dummy_shaper_set(struct net_shaper_binding *binding,
+			    const struct net_shaper *shaper,
+			    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int dummy_shaper_del(struct net_shaper_binding *binding,
+			    const struct net_shaper_handle *handle,
+			    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int dummy_shaper_group(struct net_shaper_binding *binding,
+			      int leaves_count, const struct net_shaper *leaves,
+			      const struct net_shaper *root,
+			      struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void dummy_shaper_cap(struct net_shaper_binding *binding,
+			     enum net_shaper_scope scope, unsigned long *flags)
+{
+	*flags = ULONG_MAX;
+}
+
+static const struct net_shaper_ops dummy_shaper_ops = {
+	.set			= dummy_shaper_set,
+	.delete			= dummy_shaper_del,
+	.group			= dummy_shaper_group,
+	.capabilities		= dummy_shaper_cap,
+};
+
 static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
@@ -90,6 +126,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
+	.net_shaper_ops		= &dummy_shaper_ops,
 };
 
 static const struct ethtool_ops dummy_ethtool_ops = {
-- 
2.48.1


