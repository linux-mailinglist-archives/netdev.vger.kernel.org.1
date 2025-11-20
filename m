Return-Path: <netdev+bounces-240474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C739BC75624
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6047B4E9914
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B3136C0D5;
	Thu, 20 Nov 2025 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1U8Lsrs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDE3644D9;
	Thu, 20 Nov 2025 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656018; cv=none; b=h1PbA/tF7sLasudcYtQRq1uPzWuFf6i7q0DsXcdCSM/HgTgBD3qZfoyladhcooc4/yZSkfzh7lAR0ffqiCh7e2d9kFyRHGN29v6WnshIjsOCDylOuqKMNwfbWBoeDqoPO505yBTwKwdc/eIcKjnHFYTxmqBWpkW+bLtF5vwo4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656018; c=relaxed/simple;
	bh=vyKf7oAe73jG7REVIeUhuNZDGGytb/NVXkzSMRKd0IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JATx9W9GBrzzg9wlk//syyEUNRpvg7LDtPxEZjoSmM3d1Q4XSMML7iJzl8rTsBK5PtysO5EexRcYceJLlDewnMlRsWHQSwtuFDAYp1BJ6U4Ig8UclrQsjDQwu5jZ9km31noEp1BQcq9K2RwAjTGNXBrsZ8GCSu6+r2CpTzO4qAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1U8Lsrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E521C4CEF1;
	Thu, 20 Nov 2025 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656018;
	bh=vyKf7oAe73jG7REVIeUhuNZDGGytb/NVXkzSMRKd0IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1U8Lsrs/SxWVweihN4p0v2fQXX5uuo5KT1E0ATmGO7U44Cg1lZoRLt2akgeKu5Eu
	 PhVO5/ACbGAAMWNLo37apEbqD/B6pt5iXzcQylc8Fuo+KwWMVAxs9vKh9KtKHRsp3I
	 BF5MyxkA8z+Z2FakraOKNu8wzeBjd7VQYsEIMEin7CXevE6XJnzIziNcuzcLF7/ooQ
	 eGum4pIH22+TM8VL8dzK5EgnpvgL5JEavG3gjOb13fdaJenmDJpMu5GUCa9u8rTIzq
	 xeZSeTNSzZ0LdFZveCpuaO/nQXKN/TKwcEVRD8upoH5VE0V/ScIylChZgSZIKbOeP7
	 234s5P0on+iKQ==
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
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>
Subject: [RFC net-next v1 6/7] net: macb: afaict, the driver doesn't support tsu timer adjust mode
Date: Thu, 20 Nov 2025 16:26:08 +0000
Message-ID: <20251120-grudging-gargle-690dad0a5c5f@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
References: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=QT0eIvEE2MWf5tzLxJfFcb6I4liyojXQm/8lvAoxpqw=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnyjtKnJH/Lxxx509ptxp515eBnJpeuOYL35+0MqxUql ki+Fzito5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNpqmX4X3H0yh7VtcUdBfyq VSytl5j+zt/+vuHQnrgJbv8E8wXX2jEytFx9vHXprXMbp3Nyhx7ercrvwSgSGSN/LqVpzmqBPZ0 nmAE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The ptp portion of this driver controls the tsu's timer, which is not
compatible with the hardware trying to control it via the
gem_tsu_inc_ctrl and gem_tsu_ms inputs afaict. Abort probe if someone
tries to use it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 21045575f19c..4ad1409dab63 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5531,6 +5531,12 @@ static int macb_probe(struct platform_device *pdev)
 
 	bp->usrio = macb_config->usrio;
 
+	if (of_property_read_bool(bp->pdev->dev.of_node, "cdns,timer-adjust") &&
+			IS_ENABLED(CONFIG_MACB_USE_HWSTAMP)) {
+		dev_err(&pdev->dev, "Timer adjust mode is not supported\n");
+		goto err_out_free_netdev;
+	}
+
 	/* By default we set to partial store and forward mode for zynqmp.
 	 * Disable if not set in devicetree.
 	 */
-- 
2.51.0


