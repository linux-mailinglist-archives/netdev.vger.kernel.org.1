Return-Path: <netdev+bounces-176891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B0DA6CAC5
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D703C4A03C1
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA022DFB1;
	Sat, 22 Mar 2025 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="us/STQWC"
X-Original-To: netdev@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81F22DFA7;
	Sat, 22 Mar 2025 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654481; cv=none; b=N3Yz6/KeodzxIaAo6InQSIIXrF1LctW4s+TIC98UfhsqO8H9kYiPAstyiJPfX65yelBAj5gmsRlRGiJIY0T/hym4jIdTLyTECk22Ix9FVKo9WIC+hTJa0FzWAxLdpz7zCQv3prm3GdEusn5eNz3+NCfWVKSlb5iu7p5zoVXRo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654481; c=relaxed/simple;
	bh=cUH4m0E9VYIdrHtq+5/rgL6Jvb27PmBVrhsY2I+txe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGM2x/U0MQ9ZbDP1HPa11zN+CgWTFfNjYJvdot5c1Eh98oxyK2lpdO3pDVCgPPg4Zn88FQnOk90ed0fbMB/YqviHBH7EqBWXFf0N3S42SUwoTcQMSK3j5jdZHPjqZZvNMqDfrBnmssE07Sc69UQwkC3LApZY23dge7Ytm0AEpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=us/STQWC; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bca8:0:640:45be:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id C9C3B471E3;
	Sat, 22 Mar 2025 17:41:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FfNf4WKLgGk0-QORfZy24;
	Sat, 22 Mar 2025 17:41:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654477; bh=XDIjSdTy3oyjIvSB4Y5LkfpIYsqqqqTCYHMcrrprAc8=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=us/STQWC0SFNavEKNWWf39HivM9d4WM6Mlz/IDYU4ZqCXuP17FzTMxegsGXhW8IEB
	 SFMPrsyKKZnANkjkmYXHA01/7lxu5FU2QE2CQCNnAVF2MJLYn41EpuuGwpqP1FN9zn
	 zPDGSK/l7H8pYbr5+qeJLoZO9tTeQ8kEjCWDuitM=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 27/51] vlan: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:41:15 +0300
Message-ID: <174265447583.356712.9463037666035942909.stgit@pro.pro>
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
 net/8021q/vlan.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index e45187b88220..ca3ba251a145 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -176,7 +176,7 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
 	if (err < 0)
 		goto out_uninit_mvrp;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		goto out_uninit_mvrp;
 
@@ -196,7 +196,7 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
 	return 0;
 
 out_unregister_netdev:
-	unregister_netdevice(dev);
+	__unregister_netdevice(dev);
 out_uninit_mvrp:
 	if (grp->nr_vlan_devs == 0)
 		vlan_mvrp_uninit_applicant(real_dev);
@@ -217,6 +217,7 @@ static int register_vlan_device(struct net_device *real_dev, u16 vlan_id)
 	struct vlan_dev_priv *vlan;
 	struct net *net = dev_net(real_dev);
 	struct vlan_net *vn = net_generic(net, vlan_net_id);
+	struct nd_lock *nd_lock;
 	char name[IFNAMSIZ];
 	int err;
 
@@ -274,7 +275,13 @@ static int register_vlan_device(struct net_device *real_dev, u16 vlan_id)
 	vlan->flags = VLAN_FLAG_REORDER_HDR;
 
 	new_dev->rtnl_link_ops = &vlan_link_ops;
+
+	lock_netdev(real_dev, &nd_lock);
+	attach_nd_lock(new_dev, nd_lock);
 	err = register_vlan_dev(new_dev, NULL);
+	if (err)
+		detach_nd_lock(new_dev);
+	unlock_netdev(nd_lock);
 	if (err < 0)
 		goto out_free_newdev;
 


