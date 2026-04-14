Return-Path: <netdev+bounces-278586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJHMC4jJ3mmVIQAAu9opvQ
	(envelope-from <netdev+bounces-278586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:11:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2608D3FEF67
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFB2F3026927
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A383B0ACB;
	Tue, 14 Apr 2026 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc6Czc27"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3576396B63
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776208239; cv=none; b=Dhk+KygtPzviarfB/CFJ1dhfQGQoiMzGegJwsRR67w7Fp/JRhiCQKF+/dArPMMffyRkUCgVefPQ8dXFBbs7EmGiJpcD/aY8IBYVG5LRtHu3jO18GNO4yt7n5maqVLCBNccPDW86B4PgMIgWQoLFln67iM/bOdkM+ruw5I5klEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776208239; c=relaxed/simple;
	bh=4wvu9qOxTFhgIplgheLqN3J/RpDztRSNXawiCm/1EEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmFya5LumVVrg83BDgTiuOzzia5n0MO1Jg0L08OLW4YA/0NK08T6DfoZ6izq3ESKqkypJCmW1jEs+SSyTUi4zhMYvR7dIhoZxe0EoDtu8Jcs30hWAcxSNL6cFHB2i4Oy6J/VATUvHevFlI1BI4MWwo93yBRM9QMG1AAdTeQF+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc6Czc27; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so2996564a34.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776208237; x=1776813037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDVYRZIW5YXcg0u/WJDBbjUu/JAxIWnmG1clJ8HBE1s=;
        b=Gc6Czc27SL1h3ZRnor3x3uz+omYxrklNuNXZq8LHkd6MD6WYYB5mzSupIXPJ2vDwoY
         oGDcAIsOwmBCJmz9o/X6HT/MEQIW6LLZjxAlRx1bOxAziCK0W6QC4RNORTD28LCcwPij
         RDCmjgFqlJrJiPRPOAiZ1Izj/9xWvDG8hCsSk8OnkEsv/RJjFKLWlIj0egRkmFHRjtoQ
         0WAXyX7Qn6C8INf9LTAZz0Mkv7YjG0ISxwvbxwLZlXn6slHEjkvz21LU0/OZepiXVvM+
         0pAw6nOjtHeIyB0NyKR/vI2gbDmZMarX5ggbNMt+LeyONfSK+iTD9AyMz0wItq9awFUn
         GWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776208237; x=1776813037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDVYRZIW5YXcg0u/WJDBbjUu/JAxIWnmG1clJ8HBE1s=;
        b=gCoF3kmPQi6cVolZRFk8i9HFJB5BeZpoTaAe4WBd2SV9cVChMeuIJ18XpdRba0/Dm7
         Ed6bmG6GVxI6pC/cEmLVmygjWxB0GHygJKjUCmVEcATwy7UjuMp8leDed5bysNjFwsCs
         BwgheJl2Kz+caoxS0bjULTnTav/fVFggXEwVFJo4+3q1ghcpqS4MY/N0QQkKNywP5k4T
         OtdfbNbGf7cur78hxz/+FNGj/S3T7wH+ImMjPIbIzfGUfxwegQYxLGF/6Rydfxzi1xec
         qaUNSnLw5iSZjx8N8imNdV7WoiYj76dV8GkVmRdlfjj34B7i3/ij5wZJezogvR8GN7xN
         xYbQ==
X-Gm-Message-State: AOJu0YwPjNAKsEDtr0/not1toPR7CLlcmfrDINlNpwX+YPp7IjmAnX4U
	Uo/3eA7EWiy3shEvfu7dHw9Lz0gM89dU6WtEBz0AJqlF65Oof91ePduYEz02AzVG
X-Gm-Gg: AeBDietY6k+S5gjbg0wmXNnkQ7ohfT2LENMX34i0t5DK8bkSiAphzbGfG1KofROrnJ7
	5NXa49+JWkD+dyLNdeq7LgHFYtmBYXGQzPRukSFHdbArFbBUY+0zPju3kOBRPj7er5uSo4HQcEH
	v2ExP2SSu1G+mCqbIbFDFGT/vHjnrG/wFbPB2LRM7RxN0Ewj6Pzm39t0BQNA8dSn9R5uMAQP3gd
	pp/JQ5BbC4qV2GDRTIZXQTD0i6dzOgUhCZmhEbwjWZBTmL5ycanZ7F+Fdz2hr4lMnbIBZao25Yp
	+FgbMUGBi9uv7KZy1BcAjWXXyBdIDsNGBvcLJru26qaE2IWxYd1sfzqijY5NOW1c8i5RroA5COS
	lFHZY8iOn8fkYJryWJPB8r/B8n/EJmG+N6B87kOGDccdJZPFMG1NjZzrF6IIiDOWsRS0VLK88Kd
	o/FYf0Oq8LT1FjSKRe
X-Received: by 2002:a05:6830:4490:b0:7d9:b10c:c85b with SMTP id 46e09a7af769-7dc27cbe979mr10971694a34.11.1776208236772;
        Tue, 14 Apr 2026 16:10:36 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc76a51845sm106310a34.12.2026.04.14.16.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:10:36 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net] net: dsa: remove redundant netdev_lock_ops() from conduit ethtool ops
Date: Tue, 14 Apr 2026 16:10:35 -0700
Message-ID: <20260414231035.1917035-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278586-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,bootlin.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Queue-Id: 2608D3FEF67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DSA replaces the conduit (master) device's ethtool_ops with its own
wrappers that aggregate stats from both the conduit and DSA switch
ports. Taking the lock again inside the DSA wrappers causes a deadlock.

Stumbled upon this when booting qemu with fbnic and CONFIG_NET_DSA_LOOP=y
(which looks like some kind of testing device that auto-populates the ports
of eth0). `ethtool -i` is enough to deadlock. This means we have basically zero
coverage for DSA stuff with real ops locked devs.

Remove the redundant netdev_lock_ops()/netdev_unlock_ops() calls from
the DSA conduit ethtool wrappers.

Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Fixes: 2bcf4772e45a ("net: ethtool: try to protect all callback with netdev instance lock")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
(cherry picked from commit 1538c00ab3212273240112bd53692d54d95f2dd5)
---
 net/dsa/conduit.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
index a1b044467bd6..8398d72d7e4d 100644
--- a/net/dsa/conduit.c
+++ b/net/dsa/conduit.c
@@ -27,9 +27,7 @@ static int dsa_conduit_get_regs_len(struct net_device *dev)
 	int len;
 
 	if (ops && ops->get_regs_len) {
-		netdev_lock_ops(dev);
 		len = ops->get_regs_len(dev);
-		netdev_unlock_ops(dev);
 		if (len < 0)
 			return len;
 		ret += len;
@@ -60,15 +58,11 @@ static void dsa_conduit_get_regs(struct net_device *dev,
 	int len;
 
 	if (ops && ops->get_regs_len && ops->get_regs) {
-		netdev_lock_ops(dev);
 		len = ops->get_regs_len(dev);
-		if (len < 0) {
-			netdev_unlock_ops(dev);
+		if (len < 0)
 			return;
-		}
 		regs->len = len;
 		ops->get_regs(dev, regs, data);
-		netdev_unlock_ops(dev);
 		data += regs->len;
 	}
 
@@ -115,10 +109,8 @@ static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 	int count, mcount = 0;
 
 	if (ops && ops->get_sset_count && ops->get_ethtool_stats) {
-		netdev_lock_ops(dev);
 		mcount = ops->get_sset_count(dev, ETH_SS_STATS);
 		ops->get_ethtool_stats(dev, stats, data);
-		netdev_unlock_ops(dev);
 	}
 
 	list_for_each_entry(dp, &dst->ports, list) {
@@ -149,10 +141,8 @@ static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
 		if (count >= 0)
 			phy_ethtool_get_stats(dev->phydev, stats, data);
 	} else if (ops && ops->get_sset_count && ops->get_ethtool_phy_stats) {
-		netdev_lock_ops(dev);
 		count = ops->get_sset_count(dev, ETH_SS_PHY_STATS);
 		ops->get_ethtool_phy_stats(dev, stats, data);
-		netdev_unlock_ops(dev);
 	}
 
 	if (count < 0)
@@ -176,13 +166,11 @@ static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 	struct dsa_switch_tree *dst = cpu_dp->dst;
 	int count = 0;
 
-	netdev_lock_ops(dev);
 	if (sset == ETH_SS_PHY_STATS && dev->phydev &&
 	    (!ops || !ops->get_ethtool_phy_stats))
 		count = phy_ethtool_get_sset_count(dev->phydev);
 	else if (ops && ops->get_sset_count)
 		count = ops->get_sset_count(dev, sset);
-	netdev_unlock_ops(dev);
 
 	if (count < 0)
 		count = 0;
@@ -239,7 +227,6 @@ static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
 	struct dsa_switch_tree *dst = cpu_dp->dst;
 	int count, mcount = 0;
 
-	netdev_lock_ops(dev);
 	if (stringset == ETH_SS_PHY_STATS && dev->phydev &&
 	    !ops->get_ethtool_phy_stats) {
 		mcount = phy_ethtool_get_sset_count(dev->phydev);
@@ -253,7 +240,6 @@ static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
 			mcount = 0;
 		ops->get_strings(dev, stringset, data);
 	}
-	netdev_unlock_ops(dev);
 
 	list_for_each_entry(dp, &dst->ports, list) {
 		if (!dsa_port_is_dsa(dp) && !dsa_port_is_cpu(dp))
-- 
2.52.0


