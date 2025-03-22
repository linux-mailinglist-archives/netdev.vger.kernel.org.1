Return-Path: <netdev+bounces-176886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F888A6CABE
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD9A1B811ED
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF9233152;
	Sat, 22 Mar 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="MuqzYvNu"
X-Original-To: netdev@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904D22F3BD;
	Sat, 22 Mar 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654438; cv=none; b=AGuNae9FTyZ9JItduu8KbWXR6LUGIMkjofjFVW1u8aUSrblARFdPtaFFnFe24GC2cAr8eN1KGh0vtXEYb4pc0fQi4VDpbwe5QWWiTOiRBnvQtNZdUEfbNnNb2PYd1JLNpKZaHseScrIgWgtvQL7pFmrrijiWvStJWJUegjzBZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654438; c=relaxed/simple;
	bh=1JAKVhC2/dgWoNGKbvRbxzscFcKZeKD8PshBhJA/V7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqgPPblk4psFsIQk2Wymb8eelAhCINK7UC/XnBez/gGU3Nf8hHSBfHRVDta8jQy4IvtVFc7kY63Di5E3/ktcZKx0T40C0SIgAv3OY1OZ7RDsq0tNc2RsfQEDHrINrzAdRDgLFSQTVhe3Fkq6rlklZu/+Oi1JnPYGak1gubFS3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=MuqzYvNu; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:2f04:0:640:303a:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 6A59360AFB;
	Sat, 22 Mar 2025 17:40:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WeN9JgULe8c0-XDovRmO3;
	Sat, 22 Mar 2025 17:40:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654434; bh=22v+fB8YIwTLC/56HYEhnJJXVWUSKXSrmHhOiSQ3Qjc=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=MuqzYvNuRKhnTfX4fK1XBKLwL0JB7k6j9KFQ6UlY0P5cgsJ6scdM9IRSFXQf/tJjh
	 oDZEC/KK/YchVARhQFSkYiXXI6KDQut76aojdPoEvmZ4kQA4mlfNR1bX9C3NWH8IsE
	 +848HlXjla1aEGS+T6Ad89NOst4HgzSMhg4/bvpw=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 21/51] veth: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:40:32 +0300
Message-ID: <174265443211.356712.15428609220770550870.stgit@pro.pro>
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
 drivers/net/veth.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 34499b91a8bd..7a502dbed5b9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1827,7 +1827,9 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 
 	netif_inherit_tso_max(peer, dev);
 
-	err = register_netdevice(peer);
+	attach_nd_lock(peer, rcu_dereference_protected(dev->nd_lock, true));
+
+	err = __register_netdevice(peer);
 	put_net(net);
 	net = NULL;
 	if (err < 0)
@@ -1858,7 +1860,7 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 	else
 		snprintf(dev->name, IFNAMSIZ, DRV_NAME "%%d");
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		goto err_register_dev;
 
@@ -1888,14 +1890,15 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 	return 0;
 
 err_queues:
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 err_register_dev:
 	/* nothing to do */
 err_configure_peer:
-	unregister_netdevice(peer);
+	__unregister_netdevice(peer);
 	return err;
 
 err_register_peer:
+	detach_nd_lock(peer);
 	free_netdev(peer);
 	return err;
 }


