Return-Path: <netdev+bounces-230733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDADBEE599
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54AE3AC850
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8552E7BBC;
	Sun, 19 Oct 2025 12:47:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3811221726;
	Sun, 19 Oct 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760878024; cv=none; b=FlHkhNdfumBBqbE/BrvU0GTPOy5QddlL/1w7p7A39O64dimUK3T/K80+y9LthNHGJf3jDuwSFAHNyv7GLudSEOrlfWwK2Q2uSk1nnx0qi9R0VUJWOmPB9zi+zKilbhhLSD2a+NS1IC8onaDo49+sACK+tVQcbt+lfAACKJoucsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760878024; c=relaxed/simple;
	bh=dGLHpnOfSrFGVk1o2I1ecKIPDlTcUNmVZyhAjpteRe8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWidKDHv7Jt17ahDK3+NfEHqSIcLLC9pW9DvZEKZuwRfG61Mm8QJ0oMtgKJRHBHa0+e05yqjzW5WLCvwrcoh8BAYXIaQV2jPAOHVB0TSORMsGMsNo8YBbpGgs0DTyKeIPL9H/27vxy47Oso0QiIna10koWW9vN7/+KuwvWJiU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vASoK-000000006pd-3Vdd;
	Sun, 19 Oct 2025 12:46:56 +0000
Date: Sun, 19 Oct 2025 13:46:54 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/7] net: dsa: lantiq_gswip: clarify GSWIP 2.2
 VLAN mode in comment
Message-ID: <58f05c68362388083cda32805a31bc6b0fcb4bd0.1760877626.git.daniel@makrotopia.org>
References: <cover.1760877626.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760877626.git.daniel@makrotopia.org>

The comment above writing the default PVID incorrectly states that
"GSWIP 2.2 (GRX300) and later program here the VID directly."
The truth is that even GSWIP 2.2 and newer maintain the behavior of
GSWIP 2.1 unless the VLANMD bit in PCE Global Control Register 1 is
set ("GSWIP2.2 VLAN Mode").
Fix the misleading comment accordingly.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 25f6b46957a0..86b410a40d32 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -588,7 +588,11 @@ static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
 			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr),
 			  GSWIP_PCE_VCTRL(port));
 
-	/* GSWIP 2.2 (GRX300) and later program here the VID directly. */
+	/* Note that in GSWIP 2.2 VLAN mode the VID needs to be programmed
+	 * directly instead of referencing the index in the Active VLAN Tablet.
+	 * However, without the VLANMD bit (9) in PCE_GCTRL_1 (0x457) even
+	 * GSWIP 2.2 and newer hardware maintain the GSWIP 2.1 behavior.
+	 */
 	gswip_switch_w(priv, idx, GSWIP_PCE_DEFPVID(port));
 }
 
-- 
2.51.1.dirty

