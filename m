Return-Path: <netdev+bounces-271655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPjCC+4RxGkXwAQAu9opvQ
	(envelope-from <netdev+bounces-271655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:48:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5833295DD
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADF9631CC4F9
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC123402BBC;
	Wed, 25 Mar 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0Enm9LU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662E3F788E;
	Wed, 25 Mar 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456213; cv=none; b=eTizVROjuwlwNO/xIzRoQkWHLF2AveaAqyP4ihUBsiQSVUn9+zqa5zFZCZTXcch+IA9yfOCf+IGKSNDzVxAo+eYtWZeLjzq5XSDory/OJy1PzYzdtsfBngNzljyptOQe+gJ+TYDYU0XtEwHLTTebVln67USEDRG3UT3BIPnNARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456213; c=relaxed/simple;
	bh=oW12N519I0kw0CyJPWIc3UJsn8XZap0iK40b96AjYO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImHAtk43PRLHr6RUcMoprlbhOAxk4utv8B344LYBwQQlLbEq3Xs/1sdAn93cSuUEQk/zY0wlOS0IjEp42nNwbWShvWYF/s0Y4h7TDNWLCA7XXQWek3usSIIhQ3p/YNRo6aWgKGcd3JW8LB/3Nkq3HmLQbwYPLoFw7tTCtmj9p5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0Enm9LU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD29C2BCB1;
	Wed, 25 Mar 2026 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456212;
	bh=oW12N519I0kw0CyJPWIc3UJsn8XZap0iK40b96AjYO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0Enm9LUCor7mkbEYMlAspxh+4ssXfuyMAB4T80S4vBA79yXJ4uDnxdcipaQX5fow
	 inH6fah38iAnVXp8C8Sy2EZ2UEr7zA9EyHQrLwJ/5LX2dG2T1sqRJvlB6vz6QcomrH
	 oWurYSCQjYWWSoJYIpLnKRAARXhcu+YcYCNMirusBEbK6giYgwxKvG0wc/MEzCnebH
	 D17xoDPb0sCPzruPSixZDfIKDD+BsAtg52WZWzVDWKvsjQQhORapqPvP2uYesv91EF
	 AiFt6hrRsNg3jh4EYgd4cVjO1ijyXAUCKH4SYCDn+1E5ZjeJHUuazrNY3Sj538kY6j
	 gpYLygGCVp+ug==
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
	Ryan.Wanner@microchip.com,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v5 14/14] net: macb: drop usrio pointer on EyeQ5 config
Date: Wed, 25 Mar 2026 16:28:18 +0000
Message-ID: <20260325-stillness-undertake-d83054057b8d@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=YLNmb5rNBu+3WxSgWsYJIDPAPqu1Vv3xiiURVvdAoto=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeC3Emjm1Hs1pF9lfnDEt3PIeQ2dw5PYA5RmzL/zZG u0+/0hlRykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACayfinDP2v+biUjYfY1PmJy zbJhEQtW7Xa3+ih6rmvpvanvMuYK/GH4K/hl5+ErJ09ZMseIRMbffJGtN/egWL3BcmOj3eKiswO /sAEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271655-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 9C5833295DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Théo Lebrun <theo.lebrun@bootlin.com>

USRIO is disabled on this platform, drop its inherited usrio config.
We will end up with MACB_CAPS_USRIO_DISABLED on this platform:
 - We have no config->usrio so macb_configure_caps() deduces that the
   feature is disabled.
 - Anecdotally, we would also land in the runtime detection codepath
   that reads DCFG1.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9befb268ed79e..12e2b2f4aaf88 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5695,7 +5695,6 @@ static const struct macb_config eyeq5_config = {
 	.dma_burst_length = 16,
 	.init = eyeq5_init,
 	.jumbo_max_len = 10240,
-	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config raspberrypi_rp1_config = {
-- 
2.53.0


