Return-Path: <netdev+bounces-269132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EmbJRXYumlacgIAu9opvQ
	(envelope-from <netdev+bounces-269132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:51:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 823872BFA5F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DB42300B5A9
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D03FB7E4;
	Wed, 18 Mar 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3jcQyin"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7BD3FB7D2;
	Wed, 18 Mar 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851939; cv=none; b=i/MQd+ujB0v5p0MtcmIdyfku0fPvfPPsMNvHDszMDemZm1GrV0gn5y5MgL9SL2MSYfvHrYhJ8oGUmymrzjOec3sasXNVQDckoBlvVrF1p6k+Z/O1rumQPveuYqGFLabOrnHyEqmHM/MkCI+DSUNLDRLZ+eGuRvusgRaOjrHM69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851939; c=relaxed/simple;
	bh=8dYY/An492/r9LNR1y5PaEYTe8NEViY49aooNEVBQSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWbrL8KUBaouH1JMFJALi3/9qxW7VqGS5GU7g3hMjpqiIyzXQ03jk/JbAk5hmilpWrxXiwLHnI7NbaOLNezjTOzfdQrVprMrltHuQ2dQ3rde8YIosyZGvrQfdKSP80j3ke+oXP28t2WCmFZRnDitSZEJqgdc68LbSOL0/zN3r4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3jcQyin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A381FC2BC87;
	Wed, 18 Mar 2026 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851939;
	bh=8dYY/An492/r9LNR1y5PaEYTe8NEViY49aooNEVBQSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3jcQyinjnnUVd8oODV26S6DW4s+A8TA+VHAhbeYtk6kGxpnNDsPeHfxlgbKugSPf
	 bvtKhcExITElvWVPNc5nJfGgfzK6hw3jDqCIB+u+4bFBm7HpzKq6A/7Iq2HgH0FBOK
	 AVTKnvTYzFEtIxwfltPGpmY0ijhrJUKmw12XuiPd8JM6puem5zTU25t2jOr48i8vxD
	 wxmvhTHXwVYW54R/kcxQ8E6fuyXzYrqH2dPuQ4TsdXB2QhbNLl2buuyQfzeHYYglLV
	 HFthY33mIIZ8bNiwif6Dla27rHBr4k+iJ47wWNXZ196Phj4ZGTezDp2wrjra7HTghL
	 qRDD9Qz6AouLg==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com
Subject: [PATCH net-next v4 12/13] net: macb: set MACB_CAPS_USRIO_DISABLED if no usrio config is provided
Date: Wed, 18 Mar 2026 16:37:43 +0000
Message-ID: <20260318-argue-pouring-3405e33e7600@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318-surpass-puzzle-f94b46aa8808@spud>
References: <20260318-surpass-puzzle-f94b46aa8808@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=qqeBZ/4pnx5PRuyO5kmFQgJF981C+Tje2OakbZeONrc=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJm7rlz+LnBCtc0thu3divRVNRb7J2xnZREPubHcJ+2Th 2aAbqdyRykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZybjfD/3rLzy+vJF5ovuCt kLbBNcB2X9u9Q6cPzWfeOevvXRvZ1w8YGZ7ri/Kv8dApUWldf/P4V4fqbJMtt60FJ72Ye+rTVKk dXtwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269132-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 823872BFA5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Théo Lebrun <theo.lebrun@bootlin.com>

bp->usrio is copied directly from dt_conf->usrio in macb_probe().

If dt_conf->usrio is NULL, we do not want to land in USRIO write
codepaths which dereference bp->usrio. Inherit automatically
MACB_CAPS_USRIO_DISABLED to avoid those.

This means a macb_config that wants to disable usrio can simply drop
its .usrio field, rather than add the disabled capability explicitly.

Nit: drop the dt_conf NULL check because the pointer is always valid.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b11ef703575b0..1a6cdc223625f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4319,8 +4319,10 @@ static void macb_configure_caps(struct macb *bp,
 {
 	u32 dcfg;
 
-	if (dt_conf)
-		bp->caps = dt_conf->caps;
+	bp->caps = dt_conf->caps;
+
+	if (!dt_conf->usrio)
+		bp->caps |= MACB_CAPS_USRIO_DISABLED;
 
 	if (hw_is_gem(bp->regs, bp->native_io)) {
 		bp->caps |= MACB_CAPS_MACB_IS_GEM;
-- 
2.51.0


