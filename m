Return-Path: <netdev+bounces-176914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D826A6CAFA
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E411B621F5
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604E7237717;
	Sat, 22 Mar 2025 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="MJDcy2en"
X-Original-To: netdev@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5D233126;
	Sat, 22 Mar 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654650; cv=none; b=Qq5w41/vAyUryJlwBDrO7kwNz2uX1xjc0lmJFXGuHrPCcAX1OdEEPwjZ/+MjVg4rwAGnppC0wHJQVF6lV9w394yoWQO3SRNfhLNdR1OslSmChhJ6zv6uv1lq1TL24MeR53TIvjSdi7kx1Y8sdHcdXazmmOzVHCDEzQ8SWwbWc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654650; c=relaxed/simple;
	bh=9LtT+6N1+1cMtuc1/pd0tD80jds+9/Fx8B3p47bd91A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I66GjNScXQJ9isCr5dY2NVlHdYlDsHvBSCLgojqKwrfJ2iL9ewmXrduklJyIhfykGxZd15ceRRCGTpBC16MrYFckSqQmCO0RUJf+6Z6IB7b1W4t4yYrlwULmaqfqJMeX+kK1a+dN2LbV7rgts/zQFYZeMklQPuMspuHMZNaMUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=MJDcy2en; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:8741:0:640:b274:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 7B3FE60907;
	Sat, 22 Mar 2025 17:44:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4iNJhiULZKo0-NQfB0Ffs;
	Sat, 22 Mar 2025 17:44:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654646; bh=u8xGwZJIEXhTcWp469K0svpI/KFhs5oEiT5TCDjjbCs=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=MJDcy2enu0mSTDP29tOlMwZI5R75QZt8NuX5p56Q3h7NI9gkFntORhJtsoGVKEeMB
	 iSLqaow7MZzz5Wq+L0ZjzUDwECRDIxLSblrSjBbDd87l4bJc5sEkQcOApZhOTxrBt1
	 Bhs0RrLe0EF51Fp2gGnUVywZrqipKVDinV/NG48g=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 50/51] cfg80211: Call dev_change_net_namespace() under nd_lock
Date: Sat, 22 Mar 2025 17:44:04 +0300
Message-ID: <174265464459.356712.3761967966551081034.stgit@pro.pro>
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
 net/wireless/core.c    |    2 ++
 net/wireless/nl80211.c |    1 +
 2 files changed, 3 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 8ba0ada86678..c661bba9fc7b 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1605,10 +1605,12 @@ static void __net_exit cfg80211_pernet_exit(struct net *net)
 	struct cfg80211_registered_device *rdev;
 
 	rtnl_lock();
+	mutex_lock(&fallback_nd_lock.mutex);
 	for_each_rdev(rdev) {
 		if (net_eq(wiphy_net(&rdev->wiphy), net))
 			WARN_ON(cfg80211_switch_netns(rdev, &init_net));
 	}
+	mutex_unlock(&fallback_nd_lock.mutex);
 	rtnl_unlock();
 }
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0fd66f75eace..f8bd7c72bd3e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17136,6 +17136,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_wiphy_netns,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY |
+					 NL80211_FLAG_NEED_FALLBACK_ND_LOCK |
 					 NL80211_FLAG_NEED_RTNL |
 					 NL80211_FLAG_NO_WIPHY_MTX),
 	},


