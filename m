Return-Path: <netdev+bounces-272437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCoXOzRAxmm7HgUAu9opvQ
	(envelope-from <netdev+bounces-272437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:30:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D6D340FDD
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A098B304661D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD553DA7D8;
	Fri, 27 Mar 2026 08:28:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C433CB2EE;
	Fri, 27 Mar 2026 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600094; cv=none; b=KoyVs0CnuTjHK7YlcZHLWkYkB64/FDrtSi7Y0zM8Nnj8wpYXYW6NBxOjv+oK3YEMKCx3aUWyYpn6LEdLk36xt33JI0QtLMySW9qM8+vcx4nYBPmXTGmVf/hvKOsNpvuSxtR1bwSeY2WKjNBfJgJ9eu8YAnXj5d0kjnSC5ZJBHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600094; c=relaxed/simple;
	bh=be72gMXAAPLEEl16TU8jP7s7AtiEA7bNqEE8ajTJQZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpXL7RXKWDt/zxYznkzvBaCWnSpPNKotdf7lrwIn/inwWjifDKpsimX2XYxKyfV5hPwb16ecQfejWsItcpmtE7hcA4HAV8PuXLk+y6fbOOZ67upjKryZE+Zc6ZfiBn4EMg7YnzUppJN03QUYf1EcFfgFk4uUn8iToMNqtIrhXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: kqSCgAC7TBqKs74VBQ1aRA==
X-CSE-MsgGUID: taTg3altTzqPIq5Mzn8/SA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Mar 2026 17:28:10 +0900
Received: from [127.0.1.1] (unknown [10.226.78.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CCD844012274;
	Fri, 27 Mar 2026 17:28:07 +0900 (JST)
From: Michael Dege <michael.dege@renesas.com>
Date: Fri, 27 Mar 2026 09:27:38 +0100
Subject: [PATCH net-next v2 08/13] net: renesas: rswitch: add basic vlan
 init to rswitch_fwd_init
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-rswitch_add_vlans-v2-8-d7f4358ca57a@renesas.com>
References: <20260327-rswitch_add_vlans-v2-0-d7f4358ca57a@renesas.com>
In-Reply-To: <20260327-rswitch_add_vlans-v2-0-d7f4358ca57a@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774600062; l=1893;
 i=michael.dege@renesas.com; s=20251023; h=from:subject:message-id;
 bh=be72gMXAAPLEEl16TU8jP7s7AtiEA7bNqEE8ajTJQZE=;
 b=eHGHcgAYBQRZu+iliQQ9aaNfhmtGEnxcd870EQR+p2yHJ856a9jo/de4w7LzlC3UdZS13QVwO
 FnMPpMFuFcvAlV/EoqfA6hJBIv/qapnjrXO5iFGFspvOW3yKwSdQq6/
X-Developer-Key: i=michael.dege@renesas.com; a=ed25519;
 pk=gu1rwIcCrAxNMv2I8fIfiQvt51xzZwnQy4Ua/DscQt8=
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272437-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.dege@renesas.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email,renesas.com:mid]
X-Rspamd-Queue-Id: F3D6D340FDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add basic vlan related register initialization.

Signed-off-by: Michael Dege <michael.dege@renesas.com>
---
 drivers/net/ethernet/renesas/rswitch_main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index b16f7aca4a69..ac87175b918e 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -120,6 +120,7 @@ static int rswitch_fwd_init(struct rswitch_private *priv)
 	u32 all_ports_mask = GENMASK(RSWITCH_NUM_AGENTS - 1, 0);
 	unsigned int i;
 	u32 reg_val;
+	int ret;
 
 	/* Start with empty configuration */
 	for (i = 0; i < RSWITCH_NUM_AGENTS; i++) {
@@ -154,17 +155,27 @@ static int rswitch_fwd_init(struct rswitch_private *priv)
 	}
 
 	/* For GWCA port, allow direct descriptor forwarding */
-	rswitch_modify(priv->addr, FWPC1(priv->gwca.index), FWPC1_DDE, FWPC1_DDE);
+	rswitch_modify(priv->addr, FWPC1(priv->gwca.index), 0, FWPC1_DDE);
 
 	/* Initialize hardware L2 forwarding table */
 
-	/* Allow entire table to be used for "unsecure" entries */
+	/* Allow entire table to be used for "un-secure" entries */
 	rswitch_modify(priv->addr, FWMACHEC, 0, FWMACHEC_MACHMUE_MASK);
 
 	/* Initialize MAC hash table */
 	iowrite32(FWMACTIM_MACTIOG, priv->addr + FWMACTIM);
 
-	return rswitch_reg_wait(priv->addr, FWMACTIM, FWMACTIM_MACTIOG, 0);
+	ret = rswitch_reg_wait(priv->addr, FWMACTIM, FWMACTIM_MACTIOG, 0);
+	if (ret)
+		return ret;
+
+	/* Allow entire VLAN table to be used for "un-secure" entries */
+	iowrite32(VLANTMUE, priv->addr + FWVLANTEC);
+
+	/* Initialize VLAN table */
+	iowrite32(VLANTIOG, priv->addr + FWVLANTIM);
+
+	return rswitch_reg_wait(priv->addr, FWVLANTIM, VLANTIOG, 0);
 }
 
 /* Gateway CPU agent block (GWCA) */

-- 
2.43.0


