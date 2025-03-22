Return-Path: <netdev+bounces-176897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20423A6CAD6
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1014A4853A6
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ADE23315B;
	Sat, 22 Mar 2025 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="A6oqW8O9"
X-Original-To: netdev@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B43233157;
	Sat, 22 Mar 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654525; cv=none; b=iYODZs+s51mLfkhR30Fe5JlHYnYkPWsmPKmx9un/0vHM7GlbhJJWMavpi2SFNj4fUUkDNaX1OYlk4TjMLTkQiSFT9VqwI9984DmeJIrIE1Bb5YCw/hmkFgUmDNxzFWFMkac3I5loDaKVzxMrtPw2RTmWqagzoZYxlf8VeZx9I8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654525; c=relaxed/simple;
	bh=rmOtyDBd0UOXVKRHkwzud9diZTqM+K9uv76wGfJo3xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kD4NXuoOLkkVcKM8T5uxFvzwMlT49TGqByfTx7SyUx8QZjj9uJCbChCWOuMJKHhSs0NplOtRUAfCofZnyx45l+K7HNaJZZeLkSKUS1VkSPHVfOAbv5genG9mvvBJ0CR/c6jHM0KUA8FV1vqesqBJCp3/O+GAYV6vU6HhiYpEPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=A6oqW8O9; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net [IPv6:2a02:6b8:c16:123:0:640:744c:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id E6EF4608DE;
	Sat, 22 Mar 2025 17:42:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xfNZ04XLbSw0-WGnOrAsG;
	Sat, 22 Mar 2025 17:42:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654521; bh=xNA8lGC8DbYQCSWm3CaR4RaypNTZ991Ww8phCUJxD2g=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=A6oqW8O9OxYt7ifjC164cHbAQJJv/lIwaJQF0JiCGizFf0iPNJgcSSVLf0OXiIsHz
	 mMrA7ajUoVf8BAzg6K7yK33vx1LKuERSyB7Nj57p4i6lXK7JUiVXmfq82q/QntbyJm
	 v9DTfyeQl+XuqiPUQNK2mzBpurjsOVGFW3Vjpewo=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 33/51] net: Now check nobody calls register_netdevice() with nd_lock attached
Date: Sat, 22 Mar 2025 17:41:59 +0300
Message-ID: <174265451966.356712.5458994002489802674.stgit@pro.pro>
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

At this moment after .newlink and .changelink are switched
to __register_netdevice(), there must not be calls of
register_netdevice() with lock attached.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/dev.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 63ece39c9286..e6809a80644e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10847,25 +10847,14 @@ int register_netdevice(struct net_device *dev)
 	struct nd_lock *nd_lock;
 	int err;
 
-	/* XXX: This "if" is to start one by one convertation
-	 * to use __register_netdevice() in devices, that
-	 * want to attach nd_lock themself (e.g., having newlink).
-	 * After all of them are converted, we remove this.
-	 */
-	if (rcu_access_pointer(dev->nd_lock))
-		return __register_netdevice(dev);
+	if (WARN_ON(rcu_access_pointer(dev->nd_lock)))
+		return -EINVAL;
 
 	nd_lock = alloc_nd_lock();
 	if (!nd_lock)
 		return -ENOMEM;
 
-	/* This may be called from netdevice notifier, which is not converted
-	 * yet. The context is unknown: either some nd_lock is locked or not.
-	 * Sometimes here is nested mutex and sometimes is not. We use trylock
-	 * to silence lockdep assert about that.
-	 * It will be replaced by mutex_lock(), see next patches.
-	 */
-	BUG_ON(!mutex_trylock(&nd_lock->mutex));
+	mutex_lock(&nd_lock->mutex);
 	attach_nd_lock(dev, nd_lock);
 	err = __register_netdevice(dev);
 	if (err)


