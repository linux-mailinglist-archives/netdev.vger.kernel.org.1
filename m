Return-Path: <netdev+bounces-176923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A9A6CAEA
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1963F7B0C38
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561622E3E8;
	Sat, 22 Mar 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="ZNg4ze2M"
X-Original-To: netdev@vger.kernel.org
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CB1519BA;
	Sat, 22 Mar 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654893; cv=none; b=t+Sld/IKOMZqTwVcalvdbdSVMilcbTmdgohXNRM0tgmXbq4sLXGJBlhiUiimuzVygP/EWhevYOHzfF99eY+AuDzllx2cuC+BFiqAGQQWMeHQW56UZOe8Jd8fd9V/rzC4J7dx4suv63meJ1OCA8Immry5VOspGKr6+65pO7Be5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654893; c=relaxed/simple;
	bh=VG2iEtd4V9p1E2Z/Q5Eclp8o60Ydnqps4f9Tipu1oj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzRVgFi7V30dWLyjlcHzljAE2h3QzE8hZlG7844QBFUd0cmuZhX8nDuEDaRVQEM5oc1v/vLvEjLdRjnX97NdtCTsIiIzikIZ3Ug2XxykmU8ADfGCNuu1nZm4f0Yts4p3LN/gDiZc+y1CTUCXl1NN8PAKpeqZ/hZWhk+ahkUTLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=ZNg4ze2M; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id D03C566F1F;
	Sat, 22 Mar 2025 17:39:50 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:4795:0:640:c576:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 5FF6E60E36;
	Sat, 22 Mar 2025 17:39:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id edNkVHXLhOs0-sabvNgh0;
	Sat, 22 Mar 2025 17:39:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654382; bh=Oc8r2hssxacReulH5yhtKG83ou2zbu7s2waFi2r9j/Q=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=ZNg4ze2MOvHdyPVMpSgp6g9NiPtmpp5NQX79syiuaF6H0en6288dfpH3VFevkiJBi
	 QIg37NgJr1ZbU48fmJBbrw6NAkMyPq05iLGP+2QVwYWlXZ3y6Cjgzm1VbA5vbJdinp
	 4gKqlpeTKOCu5ujI8fCZ7N5XCPeMGfvwWPBIKKAg=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 14/51] vxcan: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:39:40 +0300
Message-ID: <174265438009.356712.10057372565412350209.stgit@pro.pro>
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
 drivers/net/can/vxcan.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 9e1b7d41005f..6c44472af609 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -221,10 +221,12 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 	if (ifmp && dev->ifindex)
 		peer->ifindex = ifmp->ifi_index;
 
-	err = register_netdevice(peer);
+	attach_nd_lock(peer, rcu_dereference_protected(dev->nd_lock, true));
+	err = __register_netdevice(peer);
 	put_net(peer_net);
 	peer_net = NULL;
 	if (err < 0) {
+		detach_nd_lock(peer);
 		free_netdev(peer);
 		return err;
 	}
@@ -241,7 +243,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 	else
 		snprintf(dev->name, IFNAMSIZ, DRV_NAME "%%d");
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		goto unregister_network_device;
 
@@ -257,7 +259,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 	return 0;
 
 unregister_network_device:
-	unregister_netdevice(peer);
+	__unregister_netdevice(peer);
 	return err;
 }
 


