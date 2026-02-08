Return-Path: <netdev+bounces-257867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBuaIq4UiWko2QQAu9opvQ
	(envelope-from <netdev+bounces-257867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 23:56:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDAB10A89B
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 23:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D42903016EEA
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBDA385503;
	Sun,  8 Feb 2026 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="mz/VMTpO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75FD38171E
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770591368; cv=none; b=CQcb4OU9r1dEFvNgJ9tmR2beRgi7DsvtQbU3Qi9DB4KiPrqP4DQ8JniOSiOI0laKJBB1DPn5nXPhFGXTECvZsYKqnSDPPdCJyoE361Ds8lq+OkbLor7mnfuNkCIlNL5lolqyFAy69mPUH/rx1evBOKx/xDPDYveU2dTXP+DfTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770591368; c=relaxed/simple;
	bh=YooQjcRgRjok2wwi3LDCK/dPDX0sm1zbY3S8Sb0XBvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZUpbH+Jc5fW4SubXaaKtsdFC3W93m+Dp9AMspvdG/Wij3shuflqPSUdMGficUa9rYka3HsLdPX4cqIf5eRPSjCpFpZ/E6P6iHuWpjgbGDq52DcVZg/mM1CNzKbwaEbs3xbJTwdVVGr8Yo4DV3vF+AyshppaqMLfB4f9nQHJp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=mz/VMTpO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c5386f1c9fso350865085a.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 14:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770591368; x=1771196168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+1eFZR72lSiF0+tCPVl7Il+zloaNZIJ9PmkYReDnuE=;
        b=mz/VMTpOuqGu+Pcqo9z5OTOVLWf+rLC/CdtFOaoCAvQuRlPRDUD3/0KM3aVdu19Izk
         u4wuVeaHFTqJkPLK4kaXymWaWNddPJYjor6R9wE4aCXhugFhAdWfrv2mbaT27u/EtTV4
         HsEad3yN0WNOSwR5wCbeKbid/iDLpGdmp2CiV+gcepY9qfVnCQEQvGUps59CYNoYG9ek
         XakLRuwYNU9CAjDe6LxHaCvCmAwGBjBxyOr44EuCKMMZONPQ1XNZecPxyt+U/cerqia5
         jCdro40/XvLcEZw+CTQTxedaD/8IFnVQibkijntTGVzvgWT7es/sbYVi1NMENOtDqrdJ
         Iqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770591368; x=1771196168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+1eFZR72lSiF0+tCPVl7Il+zloaNZIJ9PmkYReDnuE=;
        b=Fre4ZNTAylg3SULouAfFyRKvk6i507hhPhejx0ukG1tVDxaAlk2Gx6uYg+dWY4809J
         59+7R+j1xvoUYpGcvRVgt8WYCkpFMWfvroyFfjjg/2dtmb8EvfrB2DE5GhqLM/5YAU6y
         tNbOrgVkZOu+h2pnRK8Olf2+BASJzh1U3KC//wMquEzrsloGfkjxR3oMhrh41B/6FVCx
         TOHpHkCwOYU0KzQif4O+Lt1BbOTdTsw1QoJttLGOIDoV/cUXOGWQN2Bw3THAcaJRMhKa
         qx4ccB3UZDnsbHdgv3f/ZiM+0zwqCfcRsE8yhDj/ACiRT4DY3f7Y+i5Wa8gSLrbYON8z
         wEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzOkL2pEyHy1xH/xc/zv1EDlq7PjPH3aYTsmrLc0gXLwplBOpCrmmMJPkZ3X/+sNfGvuJ+RC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4wceVzWoNUqwPVXQRhxncOLdtBj8WSfilOcv6ESgxkNlPYE6
	K1W7WbKwxCTAB67XMZ1FjEs2CP29aSIZNjubOBcU9nueTLKqn2Z94gfv0Iscc7wxwkw=
X-Gm-Gg: AZuq6aJ0Tq4URaZg235CYPUTkTzoopGvEAHhphuxVVwKvN1cNetVeli8FIMD1hnsoJ2
	gHvmJYvWefknxbLy90WpGkYX+tuFlgJZkL8L9Qdja79tfO94x5nuzTmAjagDvy5NwNq4JX9jTZg
	DzVgYIht6lkbGwAxEx9hpMRfS42ahBU7bSeZmnZ3u/Dq+QG/qf4aEeFfdU+ZgJSwYm09Ty1jjsU
	I23JFWJKhpAaUCcg64RL359cHaCFYJ0xCmDVjjprIL6ArbDnQ5C+K6ORrIsqEUwbzx5KAneKG8N
	3Voz5YfbV4WJ+O4R6uSsQLc/8xCJQchCXC/8ynSjAaoGvM851tUeAgNWaZ8cR3FdFyXaLvSi9nC
	30903kE8XNu03f8Msdu8mY7ZA0Cd/FGyXSEjUn5WHGQgT+CLkbR3gbcMubkVokS0XuoL3brFLR9
	FPnttXD0bOuVhQy+U0pYGcw0I52LBwWqEAAdOPU3D1DnzQ1kL1ZHgDDXazffBSIY3Ae5C3HGiBu
	uTeNkfLgi+0U6IAvVOi9D5H5Dpv6b4=
X-Received: by 2002:a05:620a:3704:b0:8c9:fb26:dc6e with SMTP id af79cd13be357-8caefcca4f2mr1261218385a.38.1770591367729;
        Sun, 08 Feb 2026 14:56:07 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9efasm679622485a.43.2026.02.08.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 14:56:07 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH v3 1/3] net: mscc: ocelot: extract ocelot_xmit_timestamp() helper
Date: Sun,  8 Feb 2026 22:56:00 +0000
Message-Id: <20260208225602.1339325-2-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
References: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-257867-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[northwestern.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u-northwestern-edu.20230601.gappssmtp.com:dkim,u.northwestern.edu:mid]
X-Rspamd-Queue-Id: EBDAB10A89B
X-Rspamd-Action: no action

Extract the PTP timestamp handling logic from ocelot_port_xmit() into a
separate ocelot_xmit_timestamp() helper function. This is a pure
refactor with no behavioral change.

The helper returns false if the skb was consumed (freed) due to a
timestamp request failure, and true if the caller should continue with
frame injection. The rew_op value is returned via pointer.

This prepares for splitting ocelot_port_xmit() into separate FDMA and
register injection paths in a subsequent patch.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/ethernet/mscc/ocelot_net.c | 36 ++++++++++++++++----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 469784d3a1a6..ef4a6c768de9 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -551,33 +551,41 @@ static int ocelot_port_stop(struct net_device *dev)
 	return 0;
 }
 
-static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
+static bool ocelot_xmit_timestamp(struct ocelot *ocelot, int port,
+				  struct sk_buff *skb, u32 *rew_op)
 {
-	struct ocelot_port_private *priv = netdev_priv(dev);
-	struct ocelot_port *ocelot_port = &priv->port;
-	struct ocelot *ocelot = ocelot_port->ocelot;
-	int port = priv->port.index;
-	u32 rew_op = 0;
-
-	if (!static_branch_unlikely(&ocelot_fdma_enabled) &&
-	    !ocelot_can_inject(ocelot, 0))
-		return NETDEV_TX_BUSY;
-
-	/* Check if timestamping is needed */
 	if (ocelot->ptp && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct sk_buff *clone = NULL;
 
 		if (ocelot_port_txtstamp_request(ocelot, port, skb, &clone)) {
 			kfree_skb(skb);
-			return NETDEV_TX_OK;
+			return false;
 		}
 
 		if (clone)
 			OCELOT_SKB_CB(skb)->clone = clone;
 
-		rew_op = ocelot_ptp_rew_op(skb);
+		*rew_op = ocelot_ptp_rew_op(skb);
 	}
 
+	return true;
+}
+
+static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot_port *ocelot_port = &priv->port;
+	struct ocelot *ocelot = ocelot_port->ocelot;
+	int port = priv->port.index;
+	u32 rew_op = 0;
+
+	if (!static_branch_unlikely(&ocelot_fdma_enabled) &&
+	    !ocelot_can_inject(ocelot, 0))
+		return NETDEV_TX_BUSY;
+
+	if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op))
+		return NETDEV_TX_OK;
+
 	if (static_branch_unlikely(&ocelot_fdma_enabled)) {
 		ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
 	} else {
-- 
2.34.1


