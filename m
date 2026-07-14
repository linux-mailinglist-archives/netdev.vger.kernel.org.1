Return-Path: <netdev+bounces-307565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 75KgJ5aKVmqY8gAAu9opvQ
	(envelope-from <netdev+bounces-307565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:14:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1101375822A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:14:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QEsNjjNY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307565-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307565-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB4E2304950E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48931ED8B;
	Tue, 14 Jul 2026 19:14:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353B2641EE
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:14:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056465; cv=none; b=G+ZMRrlvLRkWd/DaMczErz4B9Piotq8gQ/cUBZKOKQO1jptP1B4kHe1UcsWz7Q6PNxdEH3zpRuSzE3xwu8SZz82ztnwpb0BE4Zllyxk1OUiFagvBTRqx9fglFelL21XI2AVkNFIJYsMiGjlUzEyDlVS3oaR+prPDCLnCVV0awE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056465; c=relaxed/simple;
	bh=nHcX1V/5DxL0obHwJZnlQ0lcWaVMSqhQmwVlvf66epw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOAqFZ1apIlUZbTa5ecEc1k13DPRaxF4EAwASOKCpqaUAvQ6wTjhhhBMNaaKVeqv29oVcrhrZTYcgs+mS8CHjaC3W71WAkC/1df01SCy3GcfhAfYAMeHKygwcY+YcKGXMV7FIZio8Fu/91NV/99dQ3WcnUPCe1YQLnbx47LGyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEsNjjNY; arc=none smtp.client-ip=74.125.227.130
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2cad83a0aaeso20234135ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056463; x=1784661263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoOE61isMDDd8GP85+DE7oVM8lZchbPwwJGNjzXuY8g=;
        b=QEsNjjNYbWNnl4pK5NLmeDqaFFbwr7Fo/IUyc30X/aa2xyzZQlMNafoC8KuUY2SBnh
         oSpUOLI7drzD96cofUK5qOzhgzk6yAFZMXwzKv/cPWnzs+f1CUe+vtqU5RBj15EvDbvN
         01v+VcWhc3a0UtjmX9gfirusMYQKMi5/diii2CEpMv70BmR2Sca8tNwhlWu3pUEiPpcX
         RhKwLFp8XG82G+p2nwqPmDzjaPHSj4aQ4kWIJhSUSJ71XyIjlsf1D1Gif25dfFqE1wcV
         rElwPMEzXLWpn32q1XcXSZ13/c812IJiqhLo5sa8Ba4E/0oUd3tcK1ywW6bDfeJgg5A6
         DE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056463; x=1784661263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aoOE61isMDDd8GP85+DE7oVM8lZchbPwwJGNjzXuY8g=;
        b=SGYOun16RopOKJkLu3uQPqENbdcvTHlz33kt7J9OcJQ4JfRel4VgrB9e0DDZ3TCbVM
         JvM+2peDMj6v9H8KNKyv4d/fC0xbfwvTg+D2bSRGPZNRc6sMMMAEV2G4fmNrs5De4uLe
         zCjNR6fU2rP5MwRd3nAlMSkchADh2lLZC+xzLfhmMSXvMamX/WMI3m4g3hLiw06MT3MW
         jLOriHooMeszUdsuDgJG/hRqGJ6R0ysN1fe44higNddjg55RoPfLYr4JPuuyZYzCISyO
         Ok1skQOx5xtvB8Kk1ak/aoOiLDq7tpSHZ4KR6aVoc84Exxbe4N4+W5jArI7fDyOUtlwA
         HlPw==
X-Gm-Message-State: AOJu0YyhbHtIRRD9Pa+zrsHs8kickLjAZSLlCfjH4MFHwiC2sbT0agXY
	YzUn9MEegZmQVPjKYtZaZuSVA0rHTdb/iGjkXp96Kg3VJnhzRGgP/h+jUNn/eaBS7BcNsA==
X-Gm-Gg: AfdE7clG6PbjAH2wI0VIJfuJDH/glCjVLJQ0LpihMMK7lfwa0MHaJycy8JqhiFjkZgH
	rDbSnUYbn/iLMyHujSH3jfRzYdLBCKQIWj4uSevKGNUostCjgFS5dJRgEaaxqOoACHhZw3lx+sx
	6QqoebLKtHp1Qz2gZCwk0U4AzAt1NwtOmYE3USdpnLLlfLumUytJqPFkjv3gZDeawz+jvkBeOge
	50o/l1ZwXKZMOXAPptt9f0M1sovhBx1PQq4LAPzsjJFy4d4to1t/tnvqjpWfH15Bxzn5cdgdT0z
	M2P9h9uTD1MGbqvpY2wh4eVk3i9zTpkK50A9awAGR0yyhLvjdW8Wu6LITOL+QVgH9+jfOFna4WY
	SugFTg02MPRfaZo3Z9yb/fyknOoiAjXGp8bsFXl31Bc5+KBegbiV/MeBnDIX51aQcdJl76w5z8z
	boBAlHFdaTjFM=
X-Received: by 2002:a17:902:da81:b0:2ca:cee0:e172 with SMTP id d9443c01a7336-2cef12fc5a6mr38647055ad.30.1784056463494;
        Tue, 14 Jul 2026 12:14:23 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm120763245ad.65.2026.07.14.12.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:14:22 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [RFC PATCH 06/10] net: pcs: xpcs: improve SGMII AN state handling for Rockchip RK3568
Date: Wed, 15 Jul 2026 03:08:34 +0800
Message-ID: <20260714191341.690906-7-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714191341.690906-1-coiaprant@gmail.com>
References: <20260714191341.690906-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307565-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:coiaprant@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1101375822A

Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
added support for reading CL37_ANCMPLT_INTR and then reading BMCR for
speed/duplex.  This may work on Wangxun hardware but not on RK3568.

On RK3568, reading BMCR returns a fixed value (HW Reset Value or Write
Manual) instead of the negotiated result, so the correct speed/duplex
must be read from CL37_ANSGM_STS.  Also, when the link is down,
CL37_ANCMPLT_INTR stays set and the PCS does not restart AN automatically
when the PHY link returns, so an explicit AN restart via BMCR_ANRESTART
is needed.

Modify xpcs_get_state_c37_sgmii() to check CL37_ANSGM_STS for link
status first.  If the link is up, report the state.  If AN is complete
(CL37_ANCMPLT_INTR set), clear the interrupt and restart AN for
non-Wangxun platforms.  The original Wangxun-specific path is kept
unchanged unless we confirm it's a bug not a feature.

Also clear CL37 AN complete status in xpcs_config_aneg_c37_sgmii()
before starting AN to ensure a clean initial state.

Fixes: 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8d..cf370ba247cac 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -816,6 +816,11 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	/* Clear CL37 AN complete status */
+	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+	if (ret < 0)
+		return ret;
+
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
 				 mdio_ctrl | BMCR_ANENABLE);
@@ -884,7 +889,7 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
 		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
-				 mdio_ctrl | BMCR_ANENABLE);
+				 mdio_ctrl | BMCR_ANENABLE | BMCR_ANRESTART);
 		if (ret < 0)
 			return ret;
 	}
@@ -1058,6 +1063,7 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 
 	/* Reset link_state */
 	state->link = false;
+	state->an_complete = false;
 	state->speed = SPEED_UNKNOWN;
 	state->duplex = DUPLEX_UNKNOWN;
 	state->pause = 0;
@@ -1069,6 +1075,8 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	state->an_complete = ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
+
 	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
 		int speed_value;
 
@@ -1086,7 +1094,24 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 			state->duplex = DUPLEX_FULL;
 		else
 			state->duplex = DUPLEX_HALF;
-	} else if (ret == DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
+
+		return 0;
+	}
+
+	/* Clear AN complete status or interrupt */
+	if (state->an_complete)
+		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+
+	if (xpcs->info.pma != WX_TXGBE_XPCS_PMA_10G_ID) {
+		/* If the link down, restart Auto-Negotiation */
+		if (state->an_complete)
+			xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
+				    BMCR_ANRESTART);
+
+		return 0;
+	}
+
+	if (ret == DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
 		int speed, duplex;
 
 		state->link = true;
@@ -1112,7 +1137,7 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 		else if (duplex & ADVERTISE_1000XHALF)
 			state->duplex = DUPLEX_HALF;
 
-		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+		return 0;
 	}
 
 	return 0;
-- 
2.47.3


