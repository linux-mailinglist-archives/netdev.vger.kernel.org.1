Return-Path: <netdev+bounces-269126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNJ0CUvkummdcwIAu9opvQ
	(envelope-from <netdev+bounces-269126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:43:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA92C07AB
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 956B03192264
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373033F99D9;
	Wed, 18 Mar 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt1+/bFS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345736B07B;
	Wed, 18 Mar 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851905; cv=none; b=fpybxaYnXzZf8gMrClQFwh5WHqUlLzmpCc34VEiDKMXYN1N2fCwQBDBvZk3Q2JAsXXvh+tsOn8clccMRygjNZE2dNtx0FghjAQ/aAVvpl5yndIyb7CC2kHgXSgnLRb7xsKm/td6h6TNhYsF149waFkDMWtFZ27i7RKYip0vr9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851905; c=relaxed/simple;
	bh=ljysWJaHe8TEOROZCjjrq6HOXubs9dLzcABTz31qQqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knn6uLwdsP4zIABWgJj+MSWkC5ggRB+QAvRyUzEptr+lAlzsxpCWF5M06+go26pvw8NOCdCBWi4eoNLpCSa5HYyHIg6b8/JAxfL/2Lx1joOFLLejVQ5P+j4U5qEoX8i3q5qb2mjJywA13Fbv1dKsC9+E/xVXuZPRkrp0QExyEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt1+/bFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D26C2BC87;
	Wed, 18 Mar 2026 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851904;
	bh=ljysWJaHe8TEOROZCjjrq6HOXubs9dLzcABTz31qQqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pt1+/bFSyPfyR7EfakLUiHH7YcT8rL+LonjflK7Ac4b71qiNoQOTA66oNgr0FZqo3
	 MZ/M69ixXjkOTSl5t7D8g5Ag5sioFfI15HaP4lZvE/+Nz2zLWm3v89mzvtheCh85M6
	 LtR81UlxyBFXd4U49IG9NQvJa7L9gtGeZ71CA1bK8m7Sipc96Usw/ja/cI94OIJYmz
	 9W0fmQmYm8hz3Jk+KSAMw3x7JUtN/Sfxh1nGhU0Ne05eSljL1V/TZd2qia9xhkaVN1
	 UIIeQ+2z3Mz8+EKKHRcy66fDbwaI5DGFd/F0nQNGYVyuldnHF6YENI/HsLNzsHoo0e
	 cMpH2O+FzCNaQ==
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
Subject: [PATCH net-next v4 06/13] net: macb: add mpfs specific usrio configuration
Date: Wed, 18 Mar 2026 16:37:37 +0000
Message-ID: <20260318-reversal-void-f83a66086cf4@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318-surpass-puzzle-f94b46aa8808@spud>
References: <20260318-surpass-puzzle-f94b46aa8808@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2759; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=RSFyKfnVzDv/pOh5f8+B27Gurr5waqnAxeJRhx9T438=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJm7rly8U7M26a3s1VtuvrKNgdLa9laPD8oECFbtfCKn2 xzXYzmlo5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPRTmZkeHeJ+ZTnDIfnKQEH 9e2PPVj9PUDQxs7m/4uNz86KNQX+dWX4H75j9qzrx840K04uv1F99/Da5CW+KYkyGVvn+alVNDw 7xQ4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269126-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.969];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41DA92C07AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

On mpfs the driver needs to make sure the tsu clock source is not the
fabric, as this requires that the hardware is in Timer Adjust mode,
which is not compatible with the linux driver trying to control the
hardware. It is unlikely that this will be set, as the peripheral is
reset during probe, but if the resets are not provided in devicetree
it's probable that this bit is set incorrectly, as U-Boot's macb driver
has the same issue with using usrio settings for at91 platforms as the
default.

Fixes: 8aad66aa59be5 ("net: macb: add polarfire soc reset support")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 ++
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 9cd565cb87e4c..cdb9fb2218c6f 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -781,6 +781,7 @@
 #define MACB_CAPS_NO_LSO			BIT(24)
 #define MACB_CAPS_USRIO_HAS_MII			BIT(25)
 #define MACB_CAPS_USRIO_HAS_REFCLK_SOURCE	BIT(26)
+#define MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE	BIT(27)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -1214,6 +1215,7 @@ struct macb_usrio_config {
 	u32 refclk;
 	u32 clken;
 	u32 hdfctlen;
+	u32 tsu_source;
 	bool refclk_default_external;
 };
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 414a8fa3f99d9..b476bc9663ecd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4650,6 +4650,9 @@ static int macb_init(struct platform_device *pdev)
 				val |= bp->usrio->refclk;
 		}
 
+		if (bp->caps & MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE)
+			val |= bp->usrio->tsu_source;
+
 		macb_or_gem_writel(bp, USRIO, val);
 	}
 
@@ -5244,6 +5247,10 @@ static const struct macb_usrio_config at91_default_usrio = {
 	.clken = MACB_BIT(CLKEN),
 };
 
+static const struct macb_usrio_config mpfs_usrio = {
+	.tsu_source = 0,
+};
+
 static const struct macb_usrio_config sama7g5_gem_usrio = {
 	.mii = 0,
 	.rmii = 1,
@@ -5376,11 +5383,12 @@ static const struct macb_config zynq_config = {
 static const struct macb_config mpfs_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
-	.usrio = &at91_default_usrio,
+	.usrio = &mpfs_usrio,
 	.max_tx_length = 4040, /* Cadence Erratum 1686 */
 	.jumbo_max_len = 4040,
 };
-- 
2.51.0


