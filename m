Return-Path: <netdev+bounces-288109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCy6CQlYBmqhiwIAu9opvQ
	(envelope-from <netdev+bounces-288109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:17:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0DD547B7F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F330302A6B6
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A609253359;
	Thu, 14 May 2026 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="g+1Yp61J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED9145A1F
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778800556; cv=none; b=FZ5rhVMkHmvnn7utzAq5f5ybYo9wo9Ulr2fXbjSpRIUIgOdi2AtQlqkr8b8hVajcje9vPv86+h4cweMvMebGMyGKbKmhI1LEkGwIReJS4o4gLdkNtOwFT7iZn9ECuzZOQS2yMILibrSgId/zHYDvU7UiaoxC3HkLb8kjMIbYElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778800556; c=relaxed/simple;
	bh=Vi4cxLb7caefEZG+G3zh9D2UBsoU43fXTOEJLkg/oaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmX0Pbnyq7XiLHG0/iparq+NqJ4WPae9BG9vJNzTpInUmUMhkDcbsK4VYAhGJWEyOrhrJpUby39JqFB6k3Dhy5K0Icnt/Eh54hyfcPd2qNvqHY0aT0vX6PTqJ9V4nI2onwovxKd4XoFwlin5t5OS3yGOkiQZCY9V5qm/xjMgCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=g+1Yp61J; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso57814415e9.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778800552; x=1779405352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98DwDLGQew9/5L61wTmgA0uy5B3DFdWj6RaH0oz/MkA=;
        b=g+1Yp61JZ6dLlQYGi1JUY3lFQhhb9bLMei4ObDVdSIn0F3dEpV9DPQxmD7XrwyMMjT
         DVmGGyqshW4G/dtHjAzAUrG2wSMFhHs/UaQIS/63a0jwROofltnDRnH11JcfVTSHXUsS
         fMVmWv2hfDp6yJmiGevN9jpaKxRmf5VOygpv/jOpjJcnJxL2hp8ibPkQtfCtWTYO6Km/
         ihi0LkZKyika17bcHOTayfst+nl2NB21SyvozeOmij5KixNyWMPc8EUwtZOhLJsJ1mKx
         XHowjIsPHPZNwco7n+yl5/Db5413GrFwb0mOqegAMY16k1HeKv8SayYu+4IC8n7jFNck
         kh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778800552; x=1779405352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98DwDLGQew9/5L61wTmgA0uy5B3DFdWj6RaH0oz/MkA=;
        b=MbWVNxetJBHhoWfVfMltQYDDVqQQPN/H4Hrx0Y+kj51p1M3R9eIFZjPjG9p1Pz1YKA
         +1BbZQLoxkPhHGOGejN2DWnWnwpaJZtNziu3eFXjdnV9UHimpGfXCgNlrPXiuQAwquD/
         O5LQxiDyFwyNt9OEwGj5MyaOJgC3y42+6r+2VOk/AP0tZLgNhC4kZUAfNqG517INY/hM
         xFQ9DB+jKKffpxLVnVPSgf5TE3SkKJtRKdkHDtob183sj95uLhmssL6XplTVJyQws5f+
         JcIqjR3i6ABYe6WyVO9q3eTLy6Tyg0a1TqANc1+/ZU2FGpQBuioPFkiH7cFwOXgRwlQW
         7atw==
X-Gm-Message-State: AOJu0YyNkdUwQpu35e7uDtpV6i8mEfyFsqiQ1eKrA3aa827Hlh16JUEs
	nhAO2d1ebB9g+v2K/Bc9fyJ+BTwoCpJXBYD4eS8apcbc50RaFwxZ5jR/hI9HtCmIHAs6JbXed5k
	qFF8I7NBCKkp1FupI+TFnjh/OqyjGJv3PrU437YYhlHIbfBPJS+pErjBDdAvX2hsKH60=
X-Gm-Gg: Acq92OHi1Yoikgg5jJv2jK97CBPhMzmFuuX/gIOVQ5CmhI6dD4Vvr42/L59k0QUuCX1
	O7JFAwjVZFHnHQEIm+p10RHiSZUYmjPp93IEe99SM96IGjPOsqY3PXlgaAfQNrJesG8/p4Eg1T5
	EQc3T5owiUTVW5Hd7SrIICcD5GOMtXz5TvBNx+jF8MC69H2QnzyYM0qg/tM4gMjIjkovRLv13lg
	h/mkHtl3+RR3dtENE4E7BS1V7UkTIwNcCR9B42KZCW/rnk3rvAwkImizhydWXWBl7Jt7ofrHDIy
	neagf5TAB7agkj3+6sG7lbJxKwRbVownRySeSMeNDuHwIOh0y6hJLTEK0qIFmIg7EV71xLUJaz9
	rRDQNOdrCxi4jNvDzweRJmPO+Wxz5XbbdNEMHALBVsGrRKZKXU0NVmwiMKtcOzTlErcXqu98fOo
	BFLVdq13a39Fj9jmkQa5LGsTVSr5sCUZo1dOv4IhOGqnwl5A==
X-Received: by 2002:a05:600c:691:b0:48f:eb8b:997a with SMTP id 5b1f17b1804b1-48feb8b99ffmr743065e9.31.1778800551891;
        Thu, 14 May 2026 16:15:51 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:a628:d33e:601:ebb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm39155855e9.1.2026.05.14.16.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 16:15:51 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH net 4/5] ovpn: fix race between deleting interface and adding new peer
Date: Fri, 15 May 2026 01:15:43 +0200
Message-ID: <20260514231544.795993-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514231544.795993-1-antonio@openvpn.net>
References: <20260514231544.795993-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E0DD547B7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[queasysnail.net,kernel.org,redhat.com,davemloft.net,google.com,lunn.ch,mandelbit.com,openvpn.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288109-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,openvpn.net:email,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Action: no action

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
index fb10d1fea940..a09d61296425 100644
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


