Return-Path: <netdev+bounces-176883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA026A6CAB8
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9FA1B8088C
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2193C22DFA7;
	Sat, 22 Mar 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="nmzdLh/J"
X-Original-To: netdev@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588122B8BF;
	Sat, 22 Mar 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654409; cv=none; b=KnDWljA/aDoiURZRP2GMDQsVQN1I6qzUP1gZCVUgjNpLm5zefee2mAS2qStyZyAnrvrcTWnEudMRnayjNEHTDhsi+LCBDphkd5lThouQknw9uTCHWnY7Wak1h8ZTxcgkFUVG+3QbO/USUE/eTXDPBNJBtfRMW4IL4P6CScI7CUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654409; c=relaxed/simple;
	bh=rcFdBvHQdODI7Ka+aifa+wl76gdgw/jWWQkbK+5Mqms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uz8IABZTbbnv43/Tcg1L35mx5W1/58NvVZtpfA2aeV6g/mXnhqZT2ASge0OOf5yL4KxGXsRgW+5oVyC0+rskptpeM51AjKBlf5Gl99iN6QdDC27t4xjgbB569QbqXReiVvt0/NCc0GBIPK9EsJ9frG5nUqWfCMg/ydKx/3prrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=nmzdLh/J; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2129:0:640:f8ac:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id EFCAC60D25;
	Sat, 22 Mar 2025 17:40:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2eNucmWLi4Y0-0x6YI3od;
	Sat, 22 Mar 2025 17:40:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654404; bh=S1ADOccywVtKNspOiZLVnA99O6uPxWvy/u60nouYnPw=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=nmzdLh/J3rcWB8Ca5+dkZajRcor2DYczrlHjFwbAatrqWHQC55yv4a8ISRXXRe0Ly
	 6iebMsLYmYFpigM0VpDQYYoCabOIAwAEN0AB2RJdZ3FByP4DAfXdhEyoUoTRMynfpd
	 u2qjA4aLilBVBm/b9j71CLDR0COdBCUj6c0oBtEs=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 17/51] netkit: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:40:02 +0300
Message-ID: <174265440272.356712.1688795357000779096.stgit@pro.pro>
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

Also, use __unregister_netdevice() since we know
there is held lock in that path.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/netkit.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 16789cd446e9..da8d806b8249 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -408,7 +408,8 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	nk->mode = mode;
 	bpf_mprog_bundle_init(&nk->bundle);
 
-	err = register_netdevice(peer);
+	attach_nd_lock(peer, rcu_dereference_protected(dev->nd_lock, true));
+	err = __register_netdevice(peer);
 	put_net(net);
 	if (err < 0)
 		goto err_register_peer;
@@ -433,7 +434,7 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	nk->mode = mode;
 	bpf_mprog_bundle_init(&nk->bundle);
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		goto err_configure_peer;
 	netif_carrier_off(dev);
@@ -444,9 +445,10 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	rcu_assign_pointer(netkit_priv(peer)->peer, dev);
 	return 0;
 err_configure_peer:
-	unregister_netdevice(peer);
+	__unregister_netdevice(peer);
 	return err;
 err_register_peer:
+	detach_nd_lock(peer);
 	free_netdev(peer);
 	return err;
 }


