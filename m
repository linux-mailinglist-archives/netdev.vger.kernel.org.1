Return-Path: <netdev+bounces-134648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8660499AB12
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E8A1F22AAB
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8D1CCB3B;
	Fri, 11 Oct 2024 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz73zBM9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7291C244B;
	Fri, 11 Oct 2024 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671786; cv=none; b=PqbSpU0RJSdEzqUGgQO1GYTrTt20cMjtbSgroqSCWEVMOzxWrP2qRbAlKUBJolUdpBiFwMZYFYEDY9oIHkyS2Fj5y3+Rp70uhK60HxRIZbAGoueKaQo6dDs+kxQP90Bee45Q6u32E1rUXy7Y1EinRjNIXmElfU9lB25I+RABiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671786; c=relaxed/simple;
	bh=JrF8Zr7us2ct+2L2k4U1kz7UYT/O4VO681fDrN/5LeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPQ0+ai+16gTtG0lBH+SbYoxOk7raC7MyYNLFv4c/wlr/4OhrMLIScRj9pUtr6h+zjHBhb3OH+xR0E3bUaHpz8bh40iLBjS0aokgEvDMmcefV92O2Q/TiQPJGZL1q3Zfu61MVoB+qfWpV47sQuPlwobz1DWAFA64/IF+VeFKMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz73zBM9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6de14e0f050so20129187b3.0;
        Fri, 11 Oct 2024 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728671784; x=1729276584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2whrxblOrdDrylyUOw7dZMpo5t5TWeQsqPQJzAREmOw=;
        b=Hz73zBM9yDseKIwXP2veavPGia1qbW7VygS6OPjojX8tFspC5XA3M+mgVDrZzZZkCO
         flJj0Pf2XlRD20kMtgLDdBS8wtn1+AH9TPHpTU+0UZI1ndPoJ7O2KcfXDC9ArWMSGgSX
         PWDubzk7maaTDtuO5/krvBeyIOBv7jDJbazMgcYvL5A9KDuX6QlKMD9iK2AagWvc+Zdm
         2BYTfm9iO7Y9py8uklx+19/OuUiPaJbbDCBMTCOaX+onOKIS1Pm2+/ZkOoCH/feE47fJ
         sMBnjDgxzB+duXrxTyzyU5/5jF9X2rJ9ehq74UIPzpp0VQLCfhfTE02C3GHSjZtlUOEw
         /Kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671784; x=1729276584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2whrxblOrdDrylyUOw7dZMpo5t5TWeQsqPQJzAREmOw=;
        b=tby2bFlQmFlZIwM6O+8jUrOE1mA3OqN8Zv+ChV4+mUho6rKkDFVCFAaRbI6KCNGjCn
         Df0I0ofKu2E3VIn50pLAuPSN1A+5hBqTLw9AKTmNDhl3WoI2Jpcl+z7rGnVskVduBNvj
         8F3jKR9wCr5/oaSSQ3eBgSOro1NBjsFnsC6P304CbU/0K3eueCHrYdLSGgwPpd9Z3ZUn
         4Ysdspk5deO9EyA7iOm77hMNh3oUMLIpaVumpy1VcrjK9QYkCY7HXfOtLMrs8iXhIKTb
         DDU+QDum6C1k/7FRmLKKCdssIbiy853chHLr5msU7MHqMabbGNkZS+w0rYnL6pvjHnCN
         sNKA==
X-Forwarded-Encrypted: i=1; AJvYcCXxOIUMEWv7zHRiftloJ0TC7w0o2p9O1nu7XHZkfghVTqRabybmcgeL4zoWMbs5q/QmmU5SLwiTPWY4IHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4t6kdTIWEBd+8NwBKKHhlZ5MIcipxLsTt0GQKZ0u7Ale8KE9C
	I3vdOicsYXgF1j8eFrVFbUfoQchoV4nGDl7ADtRY6Q/taZcyg0tv
X-Google-Smtp-Source: AGHT+IHCDNcCTyov+kFKcENxUDR/OEh5HFEcijllc6MNGfxEbHrHrgz64N7J/Um5XOHOAa3GS5zDlA==
X-Received: by 2002:a05:690c:9a8b:b0:6e3:13c6:7fc3 with SMTP id 00721157ae682-6e3644c0efcmr5631067b3.28.1728671783656;
        Fri, 11 Oct 2024 11:36:23 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332c27d94sm6949017b3.86.2024.10.11.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:36:23 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] ethtool: rss: prevent rss ctx deletion when in use
Date: Fri, 11 Oct 2024 11:35:47 -0700
Message-ID: <20241011183549.1581021-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241011183549.1581021-1-daniel.zahka@gmail.com>
References: <20241011183549.1581021-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntuple filters can specify an rss context to use for packet hashing
and queue selection. When a filter is referencing an rss context, it
should be invalid for that context to be deleted. A list of active
ntuple filters and their associated rss contexts can be compiled by
querying a device's ethtool_ops.get_rxnfc. This patch checks to see if
any ntuple filters are referencing an rss context during context
deletion, and prevents the deletion if the requested context is still
in use.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/ethtool/common.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 net/ethtool/common.h |  1 +
 net/ethtool/ioctl.c  |  7 +++++++
 3 files changed, 56 insertions(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index dd345efa114b..0d62363dbd9d 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -684,6 +684,54 @@ int ethtool_check_max_channel(struct net_device *dev,
 	return 0;
 }
 
+int ethtool_check_rss_ctx_busy(struct net_device *dev, u32 rss_context)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc *info;
+	int rc, i, rule_cnt;
+
+	if (!ops->get_rxnfc)
+		return 0;
+
+	rule_cnt = ethtool_get_rxnfc_rule_count(dev);
+	if (!rule_cnt)
+		return 0;
+
+	if (rule_cnt < 0)
+		return -EINVAL;
+
+	info = kvzalloc(struct_size(info, rule_locs, rule_cnt), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->cmd = ETHTOOL_GRXCLSRLALL;
+	info->rule_cnt = rule_cnt;
+	rc = ops->get_rxnfc(dev, info, info->rule_locs);
+	if (rc)
+		goto out_free;
+
+	for (i = 0; i < rule_cnt; i++) {
+		struct ethtool_rxnfc rule_info = {
+			.cmd = ETHTOOL_GRXCLSRULE,
+			.fs.location = info->rule_locs[i],
+		};
+
+		rc = ops->get_rxnfc(dev, &rule_info, NULL);
+		if (rc)
+			goto out_free;
+
+		if (rule_info.fs.flow_type & FLOW_RSS &&
+		    rule_info.rss_context == rss_context) {
+			rc = -EBUSY;
+			goto out_free;
+		}
+	}
+
+out_free:
+	kvfree(info);
+	return rc;
+}
+
 int ethtool_check_ops(const struct ethtool_ops *ops)
 {
 	if (WARN_ON(ops->set_coalesce && !ops->supported_coalesce_params))
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index d55d5201b085..4a2de3ce7354 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -47,6 +47,7 @@ bool convert_legacy_settings_to_link_ksettings(
 int ethtool_check_max_channel(struct net_device *dev,
 			      struct ethtool_channels channels,
 			      struct genl_info *info);
+int ethtool_check_rss_ctx_busy(struct net_device *dev, u32 rss_context);
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
 
 extern const struct ethtool_phy_ops *ethtool_phy_ops;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 04b34dc6b369..5cc131cdb1bc 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1462,6 +1462,13 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		mutex_lock(&dev->ethtool->rss_lock);
 		locked = true;
 	}
+
+	if (rxfh.rss_context && rxfh_dev.rss_delete) {
+		ret = ethtool_check_rss_ctx_busy(dev, rxfh.rss_context);
+		if (ret)
+			goto out;
+	}
+
 	if (create) {
 		if (rxfh_dev.rss_delete) {
 			ret = -EINVAL;
-- 
2.43.5


