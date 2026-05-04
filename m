Return-Path: <netdev+bounces-283862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AuaGfmr+GnHxgIAu9opvQ
	(envelope-from <netdev+bounces-283862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:23:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00E84BF474
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D59403017EC9
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261C03DE43C;
	Mon,  4 May 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZivXVeQ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0F29E116
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904441; cv=none; b=iakVEXvh2a4wFzE+zv9VfT78dYeIzGzDa1HybfzwvO45E1viHzxuKFk1JzCII/5OrgqNQ6QVf8nBdJX+xFmO0byy46Mx26YVcdOrZ20Eu1Ztk24FrVMzd17njFLYTUPXfh1MLK0RN3hsrdx6La9rTUWcZwpkvIwvGtaKwqrGcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904441; c=relaxed/simple;
	bh=9OUajsvoVYdXpMybKSG/0NvwqxgowwKsta8AaAO2Zbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHo/5Clp3oXHbXJbqrP0sy4oOutmXDxuQNDVyMj6maRSfei71RIPWiRVZMEe4jQeUEc38W4cs0hd5Ul/T10To3fpS52xOx8pti4naiiBsuBa/xf99ZWgu+iKpRWDH99dLdz3cR9Z7tbVT+wz855KoUyANP3FYxkxYDiISZxils8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZivXVeQ7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so33561225e9.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777904437; x=1778509237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eIwRzJNBGP4qpF839RJR539plQuxlG2HBX9ojRw93ys=;
        b=ZivXVeQ7xHjY61ZT0O3MqC9DMtIwIJCZ3EomDi92DIULRjSmrQtxWK4e2n7Yx2GHpT
         dpDBs3vl7Rqq4M/ni7hOtzvbAftM2+e2OlnwsC/xlmTAADqOFt/6FFxJlFjf6g2djanR
         AHafBW7xteLU9bLLHUda9MqUBLwP0xS1oEb/V47aWySlt69HOOPmqbe0TO7iDHYF9xEo
         liBsGhfB7eLSmE2C20dlmpnWASWLs8+uGaINk4iHnUkt9ltixQnfsOgd5fvrshHF871z
         ZF70NyL/f4v2NAL4Gc1bYly5M1Pbx9jSNaURRfKlbJErJIQyveU/mdDDfrVnrh9ow040
         elYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904437; x=1778509237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIwRzJNBGP4qpF839RJR539plQuxlG2HBX9ojRw93ys=;
        b=s8BPCucRy+jx5qbQl8awV80DmPOLrKsPNQ/lNk9JN/dUxghO6GoWArRSN9woFA/8V/
         VC+m5+H7Kps+enTlU/NspDG8sgjUOYCcxdRwkM1TYeF8OiYT2/nh6qwy9slKm+ODz11c
         CNmytOlk9K1UbE2OUKYl0ngQ1ufAmjpkJ3PdrDJExdXfCwu59TAE5poXajSBRF/LafXq
         qpwXRs7BbDbpW2hULv1c4kP6koRQS7lrdsnlNdmK1rZaYy1FnSXwiWTPqsBcpnDfr8Hz
         4zWe3hP3VMcfc2BrgTTH0T/yQsUFzj+/A56G7u6IZjM/0N+Ue/JfXUKEgV8zGH6rBudG
         RVWA==
X-Gm-Message-State: AOJu0YyzXxHqNedHCUTanNCfSjUnEGShGozXQPWRh4kV0BMVe0s6ZcA1
	v7IRbkGv/jwnrRkvAKwqNJiQcT9Eze92AXekXciO9pGaF1JjZvUEKuxQ9RcFK2J2bO9SwgIhhDX
	uLpZvus3Gy2q2V1YHixrSpSpjN5bfFg+X1GoncTuMaHnFznmVnCGvl2ZTA3xfzAD6hgU=
X-Gm-Gg: AeBDietwSt9tI0mnz15M+jMgeDRHFSjsBMWJwbAqg2XGijIFEay0LJueVSspq9He9aj
	vDU/jMIDf2cZKmrpQs9dCmsTNpofGqYchGUNm3Coo3CiFQric+VWnVo2jWf7PiVWIPu6D9ROh7i
	IwtZ2DcOf7ryTto0qA6xO1NDvDxV7iD/zzXeCtXfzKJxFqzT+8CudxvSMW5gAF6paRORSkw4xZX
	DEV4ZpTUqMANkQON7NZuErJf5AVAFJgOd+8SwHkZ6l1myviThORR8YrH6TWwZaa52gZh7kDXP1y
	3pA0lS6mT49sY80L4vt8gwyxFGG5VUTxDU6DbCGyf6tAdyW03vn0rdngVxMKlFgfI88CMfKBzMH
	3Mp65xRYyrL16TMrjuiC9D78J7EVQLcY7iujGU7kyPxt3llVBjkCHGmNxKtTF3HGxN1k2dgnI8A
	2+n/Y1R+2X5tuApfeCDCzslKybxjouUwP+sNcpPYow9w1m/Lc=
X-Received: by 2002:a05:600d:f:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-48a9866a9a3mr130488175e9.22.1777904437271;
        Mon, 04 May 2026 07:20:37 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:4b13:4164:f406:ce59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb2fa5sm237782595e9.12.2026.05.04.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:20:36 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ralf@mandelbit.com,
	Antonio Quartulli <antonio@openvpn.net>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [RFC net] ovpn: fix race between deleting interface and adding new peer
Date: Mon,  4 May 2026 16:20:33 +0200
Message-ID: <20260504142033.2327646-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F00E84BF474
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mandelbit.com,openvpn.net,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-283862-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,queasysnail.net:email,openvpn.net:email,openvpn.net:dkim,openvpn.net:mid]

While deleting an existing ovpn interface, there is a very
narrow window where adding a new peer via netlink may cause
the netdevice to hang and prevent its unregistration.

It may happen during ovpn_dellink(), when all existing peers are
freed and the device is queued for deregistration, but a
CMD_PEER_NEW message comes in adding a new peer that takes again
a reference to the netdev.

At this point there is no way to release the device because we are
under the assumption that all peers were already released.

Fix the race condition by releasing all peers in ndo_uninit(),
when the netdevice has already been removed from the netdev
list.

Also ovpn_peer_add() has now an extra check that forces the
function to bail out if the device reg_state is not REGISTERED.
This way any incoming CMD_PEER_NEW racing with the interface
deletion routine will simply stop before adding the peer.

Note that the above check happens while holding the netdev_lock
to prevent racing netdev state changes.

ovpn_dellink() is now empty and can be removed.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/netdev/aaVgJ16edTfQkYbx@v4bel/
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Fixes: 80747caef33d ("ovpn: introduce the ovpn_peer object")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---

This patch is sent as RFC to give the AI a chance to review it once
again, since it was able to spot a new race condition in its
previous version.


 drivers/net/ovpn/main.c | 12 ++----------
 drivers/net/ovpn/peer.c | 21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..9993c1dfe471 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -92,6 +92,8 @@ static void ovpn_net_uninit(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 
+	disable_delayed_work_sync(&ovpn->keepalive_work);
+	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 	gro_cells_destroy(&ovpn->gro_cells);
 }
 
@@ -208,15 +210,6 @@ static int ovpn_newlink(struct net_device *dev,
 	return register_netdevice(dev);
 }
 
-static void ovpn_dellink(struct net_device *dev, struct list_head *head)
-{
-	struct ovpn_priv *ovpn = netdev_priv(dev);
-
-	cancel_delayed_work_sync(&ovpn->keepalive_work);
-	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
-	unregister_netdevice_queue(dev, head);
-}
-
 static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
@@ -235,7 +228,6 @@ static struct rtnl_link_ops ovpn_link_ops = {
 	.policy = ovpn_policy,
 	.maxtype = IFLA_OVPN_MAX,
 	.newlink = ovpn_newlink,
-	.dellink = ovpn_dellink,
 	.fill_info = ovpn_fill_info,
 };
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..7bf912e40ee2 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1034,14 +1034,29 @@ static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
  */
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 {
+	int ret = -ENODEV;
+
+	/* Prevent adding new peers while destroying the ovpn interface.
+	 * Failing to do so would end up holding the device reference
+	 * endlessly hostage of the new peer object with no chance of
+	 * release..
+	 */
+	netdev_lock(ovpn->dev);
+	if (ovpn->dev->reg_state != NETREG_REGISTERED)
+		goto out;
+
 	switch (ovpn->mode) {
 	case OVPN_MODE_MP:
-		return ovpn_peer_add_mp(ovpn, peer);
+		ret = ovpn_peer_add_mp(ovpn, peer);
+		break;
 	case OVPN_MODE_P2P:
-		return ovpn_peer_add_p2p(ovpn, peer);
+		ret = ovpn_peer_add_p2p(ovpn, peer);
+		break;
 	}
+out:
+	netdev_unlock(ovpn->dev);
 
-	return -EOPNOTSUPP;
+	return ret;
 }
 
 /**
-- 
2.53.0


