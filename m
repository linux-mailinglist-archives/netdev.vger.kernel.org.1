Return-Path: <netdev+bounces-280404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGooOdzA6Gm9PwIAu9opvQ
	(envelope-from <netdev+bounces-280404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:36:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3726D44608B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C55463025A51
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1FB3D411F;
	Wed, 22 Apr 2026 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Yw3HgHD1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC23D3D0B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861186; cv=none; b=LyugnaE++QPEb/DwtTDCMNqD2vxSlYg746uwQ+6BIuPXdpkZEMR/6hmx4iwk/3edBMtafptElj0Q9fdRK7UK24THj47D1MsKOgUePVAmUPEVqq2OJ8PwJfch61JTEG+nwV4c9z0X0T37Z4xYmB11x+NA42JvqvltqvRugUjFwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861186; c=relaxed/simple;
	bh=5AQUuZuBcRvVORnEep4ySfzS6iUsjezi8qJg+VqkZVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcMBctV5voP67R2lKRUtK9/vbPoAuH7LPEBe9/m0i4/l6FO/Dn4SzmLQ7KjDwb1FLcDCy1TNG5TSSZ4WiVrRmAjUPIhxO9xrYWmmDhyyc+aENwd5Ziicg4/D/9nbsc4G1rSyMUf+OuZG5o2d/NF8vxFiWXenwVew4eVkTry1Ig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Yw3HgHD1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso73755995e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776861183; x=1777465983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JeqNan0xNNQ2mjbH1UZqMzC5N5p/zVRqy2TyVfTMYk=;
        b=Yw3HgHD1tQqwp1ICfv/TCGwYtSh/gyl4ivNFAGz5sVOHHeI0Qb2spxu7yBbbJ3g4fU
         2Tzhj1zf33TTZAbYarH9H4ue2Kw4pVZzAfCbquln8oW1STK/hXbGXmnB21lpwqRBGlhB
         Hs2FSrmsuAfdMXtV4I7SkY1KNJheXWJftTRQtaVeoUIA9E8yRRftQsV2+0XDYntmJXjU
         1R7OnGAZZRh0lFW6fYQQLwNfgVpaQbi299b/rlHH+pgkDR8ZUFTDTP3RRJ1QPztsRFrs
         b8wlmgcqtYP2VQL4ozTRZgxwevLzfh3NUPix45GdgISwhN1/er8ODvvQ7tMmKDpegIq+
         Owug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776861183; x=1777465983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4JeqNan0xNNQ2mjbH1UZqMzC5N5p/zVRqy2TyVfTMYk=;
        b=QmsvekRNIsp6oHiJ/srPVOgFG1PVUam+zgSd0XAcwwkKi0vIp7pBn4AOJ1VRxLu8Z0
         qzdFnSEfVUYSuBs91yMlcPSwo+T1AKdqGgeQONvhssjJgkQUjLqak1b8lFmU+PfkIlvT
         tDnsLnyHWqL4YUKXyB28TTNjbzqsX5LFZ53tGfHgxxlHNuXJFeK+LUugOl+hkvePVlGb
         71D5GdmCpMZYZLFUp0FwWKQRDX6RKIHSCHsUSnZGnIhcGYWvShTYsuHf18TBbcWb0EZP
         ABG2ZYlNlJlW4BTTJSeCbVQGHJr2vFK1AHgzqWd6QowjaCeDU+nJAf8DXhyzsWJBYA6M
         9shA==
X-Gm-Message-State: AOJu0Yz15PqGdzvs6IGZ+vv45LfGAO4cp/WBOP+aNEJrIOi8d7lthXz+
	xYZstMj48z5etHN020ly/dYSJFGmmTK4Omz61V7Vk3ZRrUPsgqUAP1aEf+fk30i695t2GBoSQam
	ooS2ZvJWSh3JnBRcu//McrAysKaqIYdAVwn9n9P3QmL/D+hMxKokA9ySKUGuhlPkb
X-Gm-Gg: AeBDieuiaJKriNmxSON7ZAvkdWQSoUgEnkCYdG0+o9ckDE2y+J9LdeDJ3SOg+uOY9J6
	XhpDneHAa0EhcIVkYC4Z31u1yqKGr8fOcvvpPumeq+F88ZXnxlOLNwOzyFbhygj+q3BnI+6K9mz
	yd1SrD7RRDOit20O3Mv0jea/E6I2eut5s+aRG2vj+72mbXeBIEt7AA5g4yFkwUnEZ95BtNxcnmS
	i1eezcjnX0JaUEIXASIGNg5mL2e/VaMlm7djeG6W2uN3ga30FlA/d3CJyPykMYCxF34PCJM3LT0
	r/yZ/G1QKzDXBoQQSSPC36NiKzlhnU0yz8Cr6iXigN/8KDgVlXh49jD+3KxBzoSTVbIgxlb+zHi
	vWP7gMvdySimjz+PTjSVNN12vgxYdHgAx9kl/7rRQjLI67usWhSfVGpFlXj4dW0LMEpa7EgR+dp
	lqtIqDQIyQR1tBVCJDEnprrOa2eQy3DJLRfDEeygMhE8gAtYY=
X-Received: by 2002:a05:600d:8408:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-488fb773f0cmr241989455e9.24.1776861182162;
        Wed, 22 Apr 2026 05:33:02 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9c05:1850:4a76:783e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c68asm139657135e9.3.2026.04.22.05.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:33:01 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH net 1/1] ovpn: fix race between deleting interface and adding new peer
Date: Wed, 22 Apr 2026 14:32:42 +0200
Message-ID: <20260422123242.530882-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422123242.530882-1-antonio@openvpn.net>
References: <20260422123242.530882-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[openvpn.net,queasysnail.net,mandelbit.com,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280404-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3726D44608B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
list. Also ovpn_peer_add() has now an extra check that
forces the function to bail out if the device reg_state is
UNREGISTERING (or later state).

This way any incoming CMD_PEER_NEW racing with the interface
deletion routine will simply stop before adding the peer.

At this point ovpn_dellink() becomes empty and can just be
removed.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/netdev/aaVgJ16edTfQkYbx@v4bel/
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Fixes: 80747caef33d ("ovpn: introduce the ovpn_peer object")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 12 ++----------
 drivers/net/ovpn/peer.c |  8 ++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..0eab305780c7 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -92,6 +92,8 @@ static void ovpn_net_uninit(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 
+	cancel_delayed_work_sync(&ovpn->keepalive_work);
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
index c02dfab51a6e..8ef485a8c851 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1034,6 +1034,14 @@ static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
  */
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 {
+	/* Prevent adding new peers while destroying the ovpn interface.
+	 * Failing to do so would end up holding the device reference
+	 * endlessly hostage of the new peer object with no chance of
+	 * release..
+	 */
+	if (ovpn->dev->reg_state >= NETREG_UNREGISTERING)
+		return -ENODEV;
+
 	switch (ovpn->mode) {
 	case OVPN_MODE_MP:
 		return ovpn_peer_add_mp(ovpn, peer);
-- 
2.53.0


