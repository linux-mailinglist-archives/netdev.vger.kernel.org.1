Return-Path: <netdev+bounces-176919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7727A6CB05
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD371B8183B
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51693233144;
	Sat, 22 Mar 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="JBrOzYYn"
X-Original-To: netdev@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5121A43C;
	Sat, 22 Mar 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654761; cv=none; b=XRhXMeFz8rhisPPMu9+xRW+0w/CXLx6RGmHi4bE1Z4vK4AwCHmi1IZHswew65A/+ErXZwk3WZCW2Le2DhdDaWZOthOSyoTBx9wr78r7RVVYLob9VJa66JXZnRrXbN5H4Hlhxa6L1gWUkPS8D6zQ5N4+zzXpCWdWMAZlNIABki4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654761; c=relaxed/simple;
	bh=OVEvy/nd3HpBvSpRFjKu5YD1urAvdfRskjLBsnNE1qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jn1k+8u0LCZzcEsQfMENinYbLYmSvPIy7zyexcxD0WDZStFxAInYaBR1I0Cmi3/wWzFEwJD6F2iib5a2sTsLQ3UlLwuZZdHtkTJ5lEQZQvKF/MSN6+ZCK6r2w0Ok8ZXS7Ljahbx4eNSwAIf5kjGG3OBRwzdrYR7CMlV4iuKaFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=JBrOzYYn; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id DD55064628;
	Sat, 22 Mar 2025 17:40:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:36c1:0:640:ebf1:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id A13F260AA3;
	Sat, 22 Mar 2025 17:39:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tdNdDJXLi0U0-8nqtfSq0;
	Sat, 22 Mar 2025 17:39:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654397; bh=brgsRbR54QJglAcnkEEgSrX364WQZEHuaJXYkN6xaB0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=JBrOzYYnQIZn704A5BTnY6DZ4wjy18YOKuFNvvJA8DyU0J8J4mseQhhEAalYAOPD5
	 TcZa/7QEqq6GoWb7QnFE6oxpAiMY7xaDQav/g0x6vXvrv3ogRhQgD2HaiQ+MXGoWxu
	 mQf2XHh0dutBgHEHI5aEoHqbcMbZfeH0QZAPW9SE=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 16/51] geneve: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:39:55 +0300
Message-ID: <174265439526.356712.16198592761679126897.stgit@pro.pro>
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

The objective is to conform .newlink with its callers,
which already assign nd_lock (and matches master nd_lock
if there is one).

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/geneve.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 838e85ddec67..f74f92753063 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1380,7 +1380,7 @@ static int geneve_configure(struct net *net, struct net_device *dev,
 		dev->flags = IFF_POINTOPOINT | IFF_NOARP;
 	}
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err)
 		return err;
 
@@ -1830,6 +1830,7 @@ struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
 					u8 name_assign_type, u16 dst_port)
 {
 	struct nlattr *tb[IFLA_MAX + 1];
+	struct nd_lock *nd_lock;
 	struct net_device *dev;
 	LIST_HEAD(list_kill);
 	int err;
@@ -1846,12 +1847,21 @@ struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
 	if (IS_ERR(dev))
 		return dev;
 
+	if (!attach_new_nd_lock(dev)) {
+		free_netdev(dev);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	init_tnl_info(&cfg.info, dst_port);
+	lock_netdev(dev, &nd_lock);
 	err = geneve_configure(net, dev, NULL, &cfg);
 	if (err) {
+		detach_nd_lock(dev);
+		unlock_netdev(nd_lock);
 		free_netdev(dev);
 		return ERR_PTR(err);
 	}
+	unlock_netdev(nd_lock);
 
 	/* openvswitch users expect packet sizes to be unrestricted,
 	 * so set the largest MTU we can.


