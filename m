Return-Path: <netdev+bounces-176877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E2BA6CAA7
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837028845B9
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C722B8BF;
	Sat, 22 Mar 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="XyQqVEma"
X-Original-To: netdev@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2478A22D781;
	Sat, 22 Mar 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654349; cv=none; b=giYOH/9j+hwtysiTn6IKSK6tIl8Eqsclw0LL/xFn5ey7fW921T6XOeitZOyvpygXKWhEaz6+tDJF/CgTA9xtyIkEeojDgrhHsGHvWCTXExSyE4f01jmylENVe44rfX5G2dl/1KlenfztEvMdUB6Fh3q/iSy07Pf9obdWXvv/+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654349; c=relaxed/simple;
	bh=0kZG/Wd1sWxDChI9+bRz0jhQKxDjuqEhYZM4V5cSw6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIhMJi8botQgPxPFaMOv20k9R5lClLXshDJTxDVE1bc6ayszbjX/qjbsOPLVxZ3etN/NMrcN2Tn8QeA0CaCZUt8T0UEPjcq/88LA/OSKwl35do8K8obSChl5JKNKnrdpnsKbqABLD6pAHnOWuWGgaOSWNDJT+xMo2CjHvEvmWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=XyQqVEma; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:6e4b:0:640:32c7:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 62B2B60AA7;
	Sat, 22 Mar 2025 17:39:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3dNvGxWLd0U0-Zu4kVMu7;
	Sat, 22 Mar 2025 17:39:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654345; bh=w4WofyfWfVkrkiMBgU50VTNHeyWA5FJWhVH3j/Tl91M=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=XyQqVEma6yf9Koc7aECvJnLbK6z3AY5fw74o7pVFriEvg/Jqf57VLzzneuf7axJf2
	 aqTK7nihxsGTlh2CVG5Azl9raH6/jbvAVkEefsb3X03yKTxQgKd57sU5l79c/xl/Ml
	 uLFNpeznbl2kfCcZGf2dfmWiRXtbOBpc2kX/B9Z0=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 09/51] net: Use register_netdevice() in loopback()
Date: Sat, 22 Mar 2025 17:39:02 +0300
Message-ID: <174265434292.356712.4877195753873111223.stgit@pro.pro>
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

loopback is simple interface without logical links to other devices.
Make it using register_netdevice() to allocate unique nd_lock
for it.

loopback is converted, so 50% work of removing rtnl_lock in kernel
is done.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/loopback.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 2b486e7c749c..c911ee7e6c68 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -214,7 +214,11 @@ static __net_init int loopback_net_init(struct net *net)
 		goto out;
 
 	dev_net_set(dev, net);
-	err = register_netdev(dev);
+	err = -EINTR;
+	if (rtnl_lock_killable())
+		goto out_free_netdev;
+	err = register_netdevice(dev);
+	rtnl_unlock();
 	if (err)
 		goto out_free_netdev;
 


