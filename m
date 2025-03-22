Return-Path: <netdev+bounces-176885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E95A6CABD
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C9688649C
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9354D23237F;
	Sat, 22 Mar 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="lTMuiEw4"
X-Original-To: netdev@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7322B8BF;
	Sat, 22 Mar 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654430; cv=none; b=fP2QBLuUv5X4PWcx5Ods6TvabRgcCeQGxcEpvZEFrTXpTfXBVS4RE/ICqyYlmaFUC9oSxNKWisk0TFfFppK1rJlkafrezC7yMzhVI76Q9eEc/gOTO1tiuouKZ6cu8+ISIhyj6F8piV9iG5lr5YwIOKw3634FZh3x4ySis7J/tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654430; c=relaxed/simple;
	bh=UfruNF5FwUbGBei/+sHU4w+skEWvZIm+WkpciT1iF+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bU0sFJcY+UffvbjRi4mK0ZXAzLsl7bOPH6+njt7VJ0Q1pmgmsvRLXv9shGYydAkTkhiaYxwMxYp0bB87iPoDWmyIhFMfc8oEO3lKH2Uh4YUc0HlzyT7j2hXoPqRAj7RxGFEK+/kZe70qGQuAv3QpKlg8iMdVj9mCHNVxuOHr/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=lTMuiEw4; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:7da2:0:640:6456:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id F3E6260B61;
	Sat, 22 Mar 2025 17:40:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PeNn0TXLcqM0-LQ5ejRF8;
	Sat, 22 Mar 2025 17:40:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654426; bh=vDTcIXqH3zbQY4VtgV7ekd33VsvdjbJpOFHuSveAfF4=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=lTMuiEw4gEAX040YAayGfEHwHSGwPTLAe2kpdQLpl33/DVFOKmCmx8x1oDEgBriAu
	 OZq5maOsprfklqu5oXYfR44ioCdj5JFtNnSASLjYqNYExfkaUubps9wdHchB4RtEMP
	 gyE84p2raqkf7C/8cGVvcz+ZSkFJQZL/6pBf8jOI=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 20/51] ppp: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:40:24 +0300
Message-ID: <174265442494.356712.9873938655056545587.stgit@pro.pro>
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
 drivers/net/ppp/ppp_generic.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index eb9acfcaeb09..c094bc5e6d8f 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1216,7 +1216,7 @@ static int ppp_unit_register(struct ppp *ppp, int unit, bool ifname_is_set)
 
 	mutex_unlock(&pn->all_ppp_mutex);
 
-	ret = register_netdevice(ppp->dev);
+	ret = __register_netdevice(ppp->dev);
 	if (ret < 0)
 		goto err_unit;
 
@@ -3331,6 +3331,7 @@ static int ppp_create_interface(struct net *net, struct file *file, int *unit)
 		.unit = *unit,
 		.ifname_is_set = false,
 	};
+	struct nd_lock *nd_lock;
 	struct net_device *dev;
 	struct ppp *ppp;
 	int err;
@@ -3343,7 +3344,13 @@ static int ppp_create_interface(struct net *net, struct file *file, int *unit)
 	dev_net_set(dev, net);
 	dev->rtnl_link_ops = &ppp_link_ops;
 
+	if (!attach_new_nd_lock(dev)) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+
 	rtnl_lock();
+	lock_netdev(dev, &nd_lock);
 
 	err = ppp_dev_configure(net, dev, &conf);
 	if (err < 0)
@@ -3351,12 +3358,16 @@ static int ppp_create_interface(struct net *net, struct file *file, int *unit)
 	ppp = netdev_priv(dev);
 	*unit = ppp->file.index;
 
+	unlock_netdev(nd_lock);
 	rtnl_unlock();
 
 	return 0;
 
 err_dev:
+	detach_nd_lock(dev);
+	unlock_netdev(nd_lock);
 	rtnl_unlock();
+err_free:
 	free_netdev(dev);
 err:
 	return err;


