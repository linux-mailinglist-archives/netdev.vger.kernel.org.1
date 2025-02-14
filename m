Return-Path: <netdev+bounces-166478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AFBA361E5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4E31704F9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9278C267700;
	Fri, 14 Feb 2025 15:34:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19235266F10
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547295; cv=none; b=V383rqANt9mK9dWgALt3gtG2KpaxIIqU9xYO1leVvp163nSbzAJ726njrKEW3mG9bYozsafeyUCRPpCLEzHe74JmmslJPy3K2EL39+qzFkGg9WmWkdGsLZ42xJWJ8CEEh2ynf52yxXhOR3WIirsNW22PBV6pQSi2uqiFTc1rEjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547295; c=relaxed/simple;
	bh=zjCK2cXzzxcMHewPBE9HEF+T7UmI47/IESYFI+AOgyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/T32y3mO8UkvTONOvOgyCeVHynrEv1JR2NAdjU5qJQAi/0phwms994T4ZGWTc5Kq2RSACFPZ2xzozu/tOBUOoynqOjjTdyQUoCQpDkZH7vqDaHb4Fcz3KsApoe18ABvK5F3/ke9gWUT1br3ZKdzkRkvldy5PVnrjF2z/cgx3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220ec47991aso14849845ad.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 07:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547293; x=1740152093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4DJHIvZmKzbr8ZgUcTfwFNDka3rp+ps6EhmcP6rJc4=;
        b=Y4N9IXAyMfLzMDT9AS88pgwg2lR1Gds0x4MGAxC4QpgT3kahjxHkh6FhoW2a2p+keu
         C+gJi8sO9v+c3gzv29/edDvHe7EiYwjhXlfyI1ahqIUb/qMACs69ZoCo/fuyc6mMd3No
         oX6PSIq43p0WHhB3MAhEXcojBCy8cFhHQEUBkrDWeBpAvjMrt1kFPT9RHAalKOMXwG+j
         4TdClNX+xNoJ326OKReT/+YSPBXlYbZAkn8shQcMisMS9AdwEY6jmaSgcr7abJ36J/op
         88wlH/2I/hoCfwyv9gSMP6JSRR2zZrk89sOHQvzt1cJTql2/iunVhWIIywPBevUMUw3s
         XNzA==
X-Gm-Message-State: AOJu0Yw9p0Kwzx1koIkPC2HNRjBV4R/OjjLvhkVuBluhbgKvvV83w3Cz
	SqYY/ciM8qD6IU764IMku+R39aX7bbf0PlbpaJ+N1rtv8vNrJUG3tzuo
X-Gm-Gg: ASbGncuUsJ8GSXiW2MTnpgUWwqunOMviegZTLAIjWfGAlGHC2rsFBi8+ZEAJfTFohYw
	6Af6WdwoSoTbFt8lIFeO0YTUn89e+6fhgC1mTpz/jrMbrH2Bk+ONZY2rjQe/sJfJFoXtFAjmuHf
	8MZi8wIT/Ba+0iSmjsyIUlHq+bKxyYPY/MKGO0JlhyjPrDYYEBJ14maeMHQ4YjGlRbzzwkgyerq
	bNOwZtUHd0NfeWN4Xb4B0/lq5XkARFDbgPdnVpF5Fh47BQGNVnEmv1CpScWuj21iEesmI2SXLS1
	2uE7gmMe/6+990k=
X-Google-Smtp-Source: AGHT+IFXSh0JeLR1IiFspq8ookquqYSY9TF8RS9XWp6yx8rBS3SDRVDcZXhFPR/y7DrDslosjcBRHg==
X-Received: by 2002:a05:6a21:2e81:b0:1ee:5cf2:9c04 with SMTP id adf61e73a8af0-1ee5cf29e98mr15571114637.8.1739547292922;
        Fri, 14 Feb 2025 07:34:52 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-add3f326b31sm569768a12.64.2025.02.14.07.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:34:52 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v2 09/11] net: dummy: add dummy shaper API
Date: Fri, 14 Feb 2025 07:34:38 -0800
Message-ID: <20250214153440.1994910-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214153440.1994910-1-sdf@fomichev.me>
References: <20250214153440.1994910-1-sdf@fomichev.me>
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


