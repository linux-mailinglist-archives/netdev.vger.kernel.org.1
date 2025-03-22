Return-Path: <netdev+bounces-176909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4189EA6CAEB
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5850D1B85A4C
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A166F236A68;
	Sat, 22 Mar 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="FMTweVLP"
X-Original-To: netdev@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47CA22DFAC;
	Sat, 22 Mar 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654612; cv=none; b=s5YVOvqGho95ALRcCEz1TLPplIuqp34i3FisQDZnYiNCe4UWjlD3bXsNq8+pXWnm4eUQJP+FNTkaUVmgkIioPPwD94ADYL5TiXfWeWnzsbnIZj39dAa7RXXmki9h9kRVkn3zG5JKXzD7nT4CAdjaXLpSxjoLT8fZAxJu3KzJmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654612; c=relaxed/simple;
	bh=fRmxLISM24PcDa9GcPt6sly/axM70hSMai3hQhRmypM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXzjmpA9YzpIlBZ2nid7P6ZpVsH/sCTPoDZal7+6SI55JzNby6aW6fkmMJYe/wSV8FABSr2o4xL5QFlk9w/BZ0OYecDFGHRmtpCUC14hBpHwgv/6Hq0SETbBlul9C9rcgZtct1lRFzxJtPJrBsHNjFOh8gxRRTISR3PelOd1TbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=FMTweVLP; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:3b11:0:640:80c7:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id E88F4608DE;
	Sat, 22 Mar 2025 17:43:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QhNwM4XLdSw0-wekjyk61;
	Sat, 22 Mar 2025 17:43:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654608; bh=Dn7PDLsQkLFwaE45fe0ztE0W7Abo6nChVxtHG051Jj4=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=FMTweVLPvarkami1BZp7bCgl7E/11az6JRMIeCnp6F8ZB5fsT0735eViAv4okMHgg
	 idx05umuAuVz2rm5gD8Q5Ou2myXn+MR3wcuLldsb3asNFRA9A8fbJHK9dCPkUxwnAR
	 x63XC5pi4wzWpTtTd9qhrc8cUzz/0+ft7bS2dG2U=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 45/51] t7xx: Use __unregister_netdevice()
Date: Sat, 22 Mar 2025 17:43:26 +0300
Message-ID: <174265460641.356712.12475969887740228690.stgit@pro.pro>
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

->dellink is going to be called with nd_lock is held

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/wwan/t7xx/t7xx_netdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index 3bde38147930..d3da299a59ff 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -324,7 +324,7 @@ static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct l
 	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
 		return;
 
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 }
 
 static const struct wwan_ops ccmni_wwan_ops = {


