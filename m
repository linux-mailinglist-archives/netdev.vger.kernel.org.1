Return-Path: <netdev+bounces-167183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0CA390B8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877A77A3978
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E319DF9A;
	Tue, 18 Feb 2025 02:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4AE1494CF
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844608; cv=none; b=GfuJbJU8qZvkpYVSSfsg3E07gUP3NgVSjgtqzkMDcQF3y78c5R+GZfagjftHmwlhSi9NYysFlZ5kgxf+EJLBcjcGO7mhw/pp1xK3QTQnPrjHL1Loqa8OcsHbGesIP8Ll7/OicOHT9UFs9HOM+DSMAahC+Ks+23/d/ngz03WI35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844608; c=relaxed/simple;
	bh=zjCK2cXzzxcMHewPBE9HEF+T7UmI47/IESYFI+AOgyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZK076DmqyLxgfdK+HyqL6aaO4XNUqeNNOXDPfd/DIRk6yNG6SnjUFkiZOlyJ81PkQ2CZ6uFhfGFnoifmptkp5vUje+/d4XplkQktu0qjsXOYfUEVufkFwNjkMbUv6wJaql37QlceyU2Mj2kOFzG3kam94aANpmMF1g8GhqZk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220bfdfb3f4so100695985ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739844605; x=1740449405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4DJHIvZmKzbr8ZgUcTfwFNDka3rp+ps6EhmcP6rJc4=;
        b=RTMkiEViar1fpb4/uweIyKSCBwYQYanXyP5hazxWq590LQoFeCvBiN3wL0iP5jga7k
         POhXhmJ2r1KwJ4vXEcs10KO0YZ6k7hoQyrHFUbepfhPo+yFObfLXcmAl4e/vIREH5ow8
         9LKjukajnbUHXy9yF7IdKlGYwuXXSrklA7FwqIiHDzAuX5FuEGXGoX4uv8kOgvOM02B9
         4C8pMy9XewbbT+rartOtd5s6WMnW9cJ6D0D7zQL2frhhqC+rFW9FRB8Cruxa83PGERu5
         1A72bFPj/y2xxCKm2kD9aJZPUKkFKC443icnyNQmxXpejzhksuvQnEalsCWmm61uRwQa
         pXSQ==
X-Gm-Message-State: AOJu0Yy/hZ4negxq6nOi9QpboQi0GsUqjdTV5zlQqhk5ZUNglNPE1Uh6
	3aEclwZlMtObyJjVoU+WfOpm3/T2KpT6V5EpqGVSV/DEfl7mKLiX3Y2e
X-Gm-Gg: ASbGnct5/JqWkTQXvM6FQB7t455Co8jIRLQdsM+JpWc9DtuiSxyoh5y/P6lg96hSYbm
	5Dgb1/ri7+NAVRcQhCZcA6A6K9TSGu9AGTCtCgGeUnAxWJI/jM/JgXJRodNusLjSVZewi2o3mtg
	pvx474b3WV9NujhjNrYf9zv4mmLwvcBNuJ6+KiwgEEXvbIk6NZI4vPB3YpruVZT1dhCKn8EO7oj
	geyvpvndjgMfnH6pBF8bCsCsbx1/vt6pb/GImwWQq0nv66vq051MFlBF5XQPbZngYYdj26h9au1
	oEWGJb88/EJgxXw=
X-Google-Smtp-Source: AGHT+IGVtTQWz/MQsdUlznj+fGUJIFbIvjGtK/FU2wdhlu+Vo12UOK0zLEXalHAy1cOgndiigLbpSg==
X-Received: by 2002:a17:902:e841:b0:220:c178:b3e with SMTP id d9443c01a7336-22104025759mr193721805ad.16.1739844605609;
        Mon, 17 Feb 2025 18:10:05 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adc9ff10056sm6544069a12.72.2025.02.17.18.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:10:05 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v4 10/12] net: dummy: add dummy shaper API
Date: Mon, 17 Feb 2025 18:09:46 -0800
Message-ID: <20250218020948.160643-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218020948.160643-1-sdf@fomichev.me>
References: <20250218020948.160643-1-sdf@fomichev.me>
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


