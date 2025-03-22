Return-Path: <netdev+bounces-176905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6EA6CAE1
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1911B83FBC
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CEE233D65;
	Sat, 22 Mar 2025 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="iZZvTtu/"
X-Original-To: netdev@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFE22D79A;
	Sat, 22 Mar 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654582; cv=none; b=GaU/etuFaiU7Bu9vRw8A8DDaXudguxmI5/u4GNcXmJyCSiUOB5vk8DPlbJG86jsCl6I01DeHaJd9A8xYk/d8gmjQlgnYvjOLj76sUzwUc2pdjVQpvsHNjl1ZBAaOeydNiWuP/eLI9rsuG4zh7dWOJ/OjJisMOIPOp45H5Rh0PD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654582; c=relaxed/simple;
	bh=DTyy/EkJk7s6RM1Zh4gxVsw+FdRer2c0IgobS5KUzZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/u68wljRpKljsqwLgovOONHs+twbsr37vp64KSNxSQDu9B7bBWyyZhukDQFt3gU6YRHUAS6CRD5semybXLWFPJrIdCk2tA+FldOpM4808VRVXx0bUUAH69HgCnyMQJJ1/pjKL7vTrt/RyA1jggGtzIQq8sWxHINCbuqXoFuW+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=iZZvTtu/; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3b21:0:640:4c47:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 720A260059;
	Sat, 22 Mar 2025 17:42:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vgNctaKLn0U0-j44C4MMd;
	Sat, 22 Mar 2025 17:42:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654579; bh=R7ByC6BDquv0XMDgpVwr9on4PJMtAcICq4ZeKvuR7Ro=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=iZZvTtu/cZZr1pnKLqRaEzXvGLBAQ++MlwXWSk8gXnvHdYQqJrqo8fXv5CsRLry91
	 OfEVXmN16Aamem1n36B6qsnZBdbegFhgICxJWvnRuQhEtxWxlvKP5TpCQ0GdpRpmnX
	 NDxtTjidjf5c/FD213eSwP+Prl1NqfqlmFXRH1gk=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 41/51] bridge: Make port to have the same nd_lock as bridge
Date: Sat, 22 Mar 2025 17:42:57 +0300
Message-ID: <174265457731.356712.7862799948363989386.stgit@pro.pro>
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

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/bridge/br_ioctl.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index f213ed108361..b4b0cc6ac08b 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -85,6 +85,7 @@ static int get_fdb_entries(struct net_bridge *br, void __user *userbuf,
 static int add_del_if(struct net_bridge *br, int ifindex, int isadd)
 {
 	struct net *net = dev_net(br->dev);
+	struct nd_lock *nd_lock, *nd_lock2;
 	struct net_device *dev;
 	int ret;
 
@@ -95,9 +96,12 @@ static int add_del_if(struct net_bridge *br, int ifindex, int isadd)
 	if (dev == NULL)
 		return -EINVAL;
 
-	if (isadd)
+	if (isadd) {
+		double_lock_netdev(br->dev, &nd_lock, dev, &nd_lock2);
+		nd_lock_transfer_devices(&nd_lock, &nd_lock2);
 		ret = br_add_if(br, dev, NULL);
-	else
+		double_unlock_netdev(nd_lock, nd_lock2);
+	} else
 		ret = br_del_if(br, dev);
 
 	return ret;


