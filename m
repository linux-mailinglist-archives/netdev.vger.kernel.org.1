Return-Path: <netdev+bounces-164884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E8A2F87D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B57188AB10
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BBC2586DD;
	Mon, 10 Feb 2025 19:20:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA9257AF6
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215258; cv=none; b=LmLV9bLZSRXOAWzXNfo9sSEu2hRT/9mMTUPoESoei1Bavz+uI6bnCUBmiysJRp7A9BBtmMf4MlCm9eTMrcpCrU3hoaKEEw68135LpMzNE7pEsSeE+c7qWCKjR7fYza5liZKKjwyLRiVRWMt871RpQf2H07Wdl79kgfrjUylHQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215258; c=relaxed/simple;
	bh=/veKoEaCxwBZPNJ2Wddph7Z/1mLRHSBAsogvnsP/Ybk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQiSicFGKRc2mBNg4GI9scBYLDrwFXc8xEAnLy6FatbNfaoERsJbYAtE0pDMrQlhj09iC99IA1C0cO/LTKuz62847cvX+vdSURKrXrSBn8yz23kHYMX8Jhbor98d6rz5rng82fJiGH8ZXH5fKwcVkxa/0wqfYxqBOa7qvS588As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f49bd087cso62133475ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215256; x=1739820056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeD8MMR2crFUh+XJ3i1X7z3iplh2rMIlfEvrb+5d8Gs=;
        b=MR6FYphun1nxlg0MWJ90tI+PAwpft9fZzjvQlHGGCY9LRx0qI4JszTRTNppJPL26AO
         Lhel2Vt8OLO7faRfW9wx3dswRYJLaXxxJKia1Ydn6Fc7RS9vxB+Ax2SOYiLK2SXfdyhr
         O0woJ4wzPjtNu4qJnVLROcOpQCAUGkoHhlX4urUDRLdLfYJm4kjplfyeg6CoNAQ2FDsr
         OaFCeCqDAUj0CNBGc9YkbCi4r3tnNbBLL96xC2W4+kC8MLlZfM9E5NuLVdR7L5WhMt/G
         Et0gUUmKRX4CS13X/04m8QzqM5Q6dbG1HFYCOlJU6R5OoSdO9y/ozXhTpFTKiG7rIKCo
         SQRQ==
X-Gm-Message-State: AOJu0YxuEgOXXfk8E10kZsejcuKPvL7nrMrbZCJlKIPAJ/OS9/5GhQZ/
	25yRGGtHbBALyAEuEcZ36SJFdz9XNlumYcxQZm32p/SuPTqdFFUONcQl
X-Gm-Gg: ASbGncvtxkeWLQ/bKwmCjJkBqq2rgaK+1eauU92pvWPau2RsNFM4qGGDf+GikqbwwLZ
	uYHpJRpf6NisL0Xl9MEZVXATHGzKdSrLHBsYwSD/qLDoDEpfwAiNBjOsPQoyCCViS+4qmJT7zKO
	1ARtdCw8KjyYf1UogVm+D/yuITOOE24zwu2/dewsgC56hN3FI+bsoyGNB9nGVId8gw1aiF95Ga9
	/FAhTMWmMmvniJp11hk4R60JevAuhqC7zRHQDKGJw4+4y8oHUaia5gR7peCUKqBVWF7zeBur+Hz
	szhMQqOG9ohbR5A=
X-Google-Smtp-Source: AGHT+IEk+UPLKetDvsOpNVyYRI4O4j0knZPGeYk5aFpbP8jm5s0tFkvHuk4hwVB6ClDU2vc/bfbr6g==
X-Received: by 2002:a05:6a00:399c:b0:730:9334:18f3 with SMTP id d2e1a72fcca58-73093341cebmr6968357b3a.19.1739215255752;
        Mon, 10 Feb 2025 11:20:55 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73078f81e75sm4475589b3a.139.2025.02.10.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:20:55 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next 09/11] net: dummy: add dummy shaper API
Date: Mon, 10 Feb 2025 11:20:41 -0800
Message-ID: <20250210192043.439074-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210192043.439074-1-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
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
 drivers/net/dummy.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

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


