Return-Path: <netdev+bounces-176913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC58A6CAFC
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7595B8857CF
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D142376ED;
	Sat, 22 Mar 2025 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="Yw5dXDR3"
X-Original-To: netdev@vger.kernel.org
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD9237703;
	Sat, 22 Mar 2025 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654642; cv=none; b=j1qqTp9BG08Pl1stQdQw0B0b9mONYWbh6BMzbBrvM8hVVEFHOiqJicFx/CC9v8UGGfkEGj8IurrSwyII4Q5uA4kFZs4+AuwDFFmaI/YWPtu7CvPPHBvuyndt7fWjrK3Uvl0alSqDcpRhSqr4POtoHex0nQpED/k/lcCl/0iqqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654642; c=relaxed/simple;
	bh=PF5S4meRQeDnxUAw07451ieCmJhIyzrz8u0iU5QthbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUNYNlwaKR5YAG4C1gkjEmpyvA60AU/kMMonhssTXF8tL9M5twRslsChGBwlgMEozs/TxPuEvXB/p4SF2VtEVqGZ0GGYlQAczDI3Gs/eclE07+sFx1ny94dhMEfNnECmsr7OyB3Hca4CCwtEhMbz7P5LDQdRCpe6zbbg0vjrFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=Yw5dXDR3; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:921:0:640:b194:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 7F4406001D;
	Sat, 22 Mar 2025 17:43:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vhNpu6VLhqM0-8vcbIH3C;
	Sat, 22 Mar 2025 17:43:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654639; bh=n5K61gXO6A3ZzdTxrHscRz8e3pA0EcGDT1Odof3vGE8=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=Yw5dXDR3z0zN6OIbYZyOPkR6O4C+Dz+V0fLP/YddwVi7gc3o9mRP5cYI+U/e9R0LK
	 Z250rdamdzMcDpu82JRbwejSMxBVf1R79alCAoz/DHxlrYax8ULljKlP88F+BSQVjx
	 jTooJ9WVC6apsUWDUi5KTZYfyfowzGM3Wlc6vQoY=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 49/51] ieee802154: Call dev_change_net_namespace() under nd_lock
Date: Sat, 22 Mar 2025 17:43:57 +0300
Message-ID: <174265463731.356712.9731171337027251381.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

We want to provide "nd_lock is locked" context during
NETDEV_REGISTER (and later for NETDEV_UNREGISTER)
events. When calling from __register_netdevice(),
notifiers are already in that context, and we do the
same for dev_change_net_namespace() here.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/ieee802154/core.c     |    2 ++
 net/ieee802154/nl802154.c |    1 +
 2 files changed, 3 insertions(+)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 60e8fff1347e..8a85a57bf042 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -349,10 +349,12 @@ static void __net_exit cfg802154_pernet_exit(struct net *net)
 	struct cfg802154_registered_device *rdev;
 
 	rtnl_lock();
+	mutex_lock(&fallback_nd_lock.mutex);
 	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
 		if (net_eq(wpan_phy_net(&rdev->wpan_phy), net))
 			WARN_ON(cfg802154_switch_netns(rdev, &init_net));
 	}
+	mutex_unlock(&fallback_nd_lock.mutex);
 	rtnl_unlock();
 }
 
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index a512f2a647e8..e8f21de679b7 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -2855,6 +2855,7 @@ static const struct genl_ops nl802154_ops[] = {
 		.doit = nl802154_wpan_phy_netns,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_FALLBACK_ND_LOCK |
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{


