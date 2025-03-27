Return-Path: <netdev+bounces-177960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A613A733AE
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E950189CEFE
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1530215F6E;
	Thu, 27 Mar 2025 13:57:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260EF215F56
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083831; cv=none; b=SoEHNVouji9wZNOIXmr0qyjAnv8ZIgC/A3wKF5Qk/c6T/dOalSIT1mhHtURPEGNPBc3BWSbbhKXLn+lFFZrkt1Nno+0aFA5tRw+H74Wxj8p5NPewXaEWK+mfjInNVUvyfB3gtw2Q/Q2vJdo8PalEx3pQ7LQOBvCeLcFyTExo8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083831; c=relaxed/simple;
	bh=2Y4VDEvLrJrpUhn3IQbN6tNLk+RPoWOZNBq3c0J6REQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz/7I3WR/w+fkEXBqblpQbvhWFkDKOFGnqUxqAlH2S6oeAktJ8bTC1hcq1UqYI5WuuwCZHSGqlRaH3o7aoYKiGo/LQrYD+ENQ1Sq97pnYv/RJAwluN1S+0miNazvecOpMCPjKPNux3zqPN92WibglgC50nwuungqQYMnuhxADAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-227b828de00so18194915ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083829; x=1743688629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFWCB/uYzwGS8vFF1zUzuiF948URPxY9n2dU+3UkGgA=;
        b=KXVVYPC9GX1IF8r57bQhyEYtyC6PnD2pSq6dXeJdhz8tCNujH5UASkK2scjawIzLUB
         Ez7sdwev72AZ8aH9N8MVFgOKUJNfaI2y2BkR9YTlBVeO27ZCHhL+hrIlG8DSVopyshze
         3Nniik3X3KCI+cH7bUqE7qKyVJ4PJkpuimBZ8Kgq4zv/zQb+S9vZnUo7wgkFjznw8ZTk
         sXWbcCCNzd14QZ4Mmuyr1NmnaGXz4nJ9KOFajxxFd+ymMmFSSY+VUGNj8g+HVaNo6lKV
         FwoNLN0IyzxJUkN3sgmi08/ZBapmNLIB/ils3HfI5gtnE8BTXoxdDgNw8Spz2xeFwB4Q
         X8mQ==
X-Gm-Message-State: AOJu0Ywsf9C+UltNSNG95YBNPg9mkzUr+R5yP/NtU1VEnQTUQTHOBsg+
	VBji8vJxmzI0CEa7IgAy19/pZNitU5rhTmN5m5bwtne/qEFU5nuAE1gAy/NgPA==
X-Gm-Gg: ASbGnctZkuI+73qQI+h7XCOTqJQ7/SRHfa5FeYziI+HCHy0U+Qs73BMckpoHKa3juFq
	A9+Cmac52Lgf+4lxLdls5GQWEmp5MULnZaalIJHxnDi5gcWxLI0y4FKN0+hTEv6oxEGZxDCIxcT
	TcWEIWuOB4wVS3J//sJWirL8195mxgVX+K1BszY1EYm6xuWu+1B6G3CeEVZ/THrkCMgM+YLjera
	ZuRVFpR7UORiG+WnnsLyDjxb1XRLcp42go8kuCaUM8na7BQU1bj7Z7xc3ZmaB9ZDxrY/y5QwcrH
	hk8UzaH8kdOuqsftHwfVjudQsFimzlVDiSpv8EVngnHmFK/ePPx6MfU=
X-Google-Smtp-Source: AGHT+IF/eRAw1z1ob6fpH6jusap991A0tUQr8p80+IeiFRFomCYm8/dvFfUgoja9z7CHT6zDRJstOA==
X-Received: by 2002:a05:6a20:3d12:b0:1f5:9961:c40 with SMTP id adf61e73a8af0-1fea2d37505mr6956785637.8.1743083829000;
        Thu, 27 Mar 2025 06:57:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2803dd2sm12865129a12.19.2025.03.27.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:08 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2 06/11] netdevsim: add dummy device notifiers
Date: Thu, 27 Mar 2025 06:56:54 -0700
Message-ID: <20250327135659.2057487-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to exercise and verify notifiers' locking assumptions,
register dummy notifiers and assert that netdev is ops locked
for REGISTER/UNREGISTER/UP.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/netdev.c    | 58 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  3 ++
 2 files changed, 61 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b67af4651185..fdf10dd3df0b 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -926,6 +926,24 @@ static void nsim_queue_uninit(struct netdevsim *ns)
 	ns->rq = NULL;
 }
 
+static int nsim_net_event(struct notifier_block *this, unsigned long event,
+			  void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	switch (event) {
+	case NETDEV_REGISTER:
+	case NETDEV_UNREGISTER:
+	case NETDEV_UP:
+		netdev_ops_assert_locked(dev);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int nsim_init_netdevsim(struct netdevsim *ns)
 {
 	struct mock_phc *phc;
@@ -939,6 +957,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
+	netdev_lockdep_set_classes(ns->netdev);
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
 	if (err)
@@ -959,7 +978,13 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	err = register_netdevice(ns->netdev);
 	if (err)
 		goto err_ipsec_teardown;
+
 	rtnl_unlock();
+
+	ns->nb.notifier_call = nsim_net_event;
+	if (register_netdevice_notifier_dev_net(ns->netdev, &ns->nb, &ns->nn))
+		ns->nb.notifier_call = NULL;
+
 	return 0;
 
 err_ipsec_teardown:
@@ -1043,6 +1068,10 @@ void nsim_destroy(struct netdevsim *ns)
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
 
+	if (ns->nb.notifier_call)
+		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
+						      &ns->nn);
+
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);
 	if (peer)
@@ -1086,6 +1115,28 @@ static struct rtnl_link_ops nsim_link_ops __read_mostly = {
 	.validate	= nsim_validate,
 };
 
+static int nsim_device_event(struct notifier_block *this, unsigned long event,
+			     void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	switch (event) {
+	case NETDEV_REGISTER:
+	case NETDEV_UNREGISTER:
+	case NETDEV_UP:
+		netdev_ops_assert_locked(dev);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block nsim_notifier = {
+	.notifier_call = nsim_device_event,
+};
+
 static int __init nsim_module_init(void)
 {
 	int err;
@@ -1102,8 +1153,14 @@ static int __init nsim_module_init(void)
 	if (err)
 		goto err_bus_exit;
 
+	err = register_netdevice_notifier(&nsim_notifier);
+	if (err)
+		goto err_notifier_exit;
+
 	return 0;
 
+err_notifier_exit:
+	rtnl_link_unregister(&nsim_link_ops);
 err_bus_exit:
 	nsim_bus_exit();
 err_dev_exit:
@@ -1113,6 +1170,7 @@ static int __init nsim_module_init(void)
 
 static void __exit nsim_module_exit(void)
 {
+	unregister_netdevice_notifier(&nsim_notifier);
 	rtnl_link_unregister(&nsim_link_ops);
 	nsim_bus_exit();
 	nsim_dev_exit();
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 665020d18f29..d04401f0bdf7 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -144,6 +144,9 @@ struct netdevsim {
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
+
+	struct notifier_block nb;
+	struct netdev_net_notifier nn;
 };
 
 struct netdevsim *
-- 
2.48.1


