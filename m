Return-Path: <netdev+bounces-271652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBHKFMQRxGnuvwQAu9opvQ
	(envelope-from <netdev+bounces-271652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:48:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029AE3295BD
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 971F331AE187
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E74014AF;
	Wed, 25 Mar 2026 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPc/4aTD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C63FFABA;
	Wed, 25 Mar 2026 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456196; cv=none; b=Jl7Q5sfAPJ30fkJYo+3M3kFIHevozb2ch2nHBRb4aW751chOqttPFYMA2JXuG8IdCXNGnJT/lFNnJWAXsTEVNg4Adlg0j+vgRAD3pmLOc0gF4ot2/134n+ODAkQbRqD3TLxiM/aoOhVXddwrAS3DQiPTfgS5f5S9zzHx1mldb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456196; c=relaxed/simple;
	bh=DVwy/SiED1aUxG3GP52kN89RSs8GgqpP4611q2+C8S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYbGHlfoOfR+16MV/tmKOOHRr517Y+lRAc3KeFAjJ5139cBu4m4Pd2bXyuc0rUlMKZpxfidl8jBX0ZPp21u9ZcdwPLtXiWmyqe7Ib1baY33YWpUp40aWGXXsilVLBO3g1sOloAy00alWojxzOV5VXmo0/jVG6dhctXYJx4Mp7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPc/4aTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D603C19423;
	Wed, 25 Mar 2026 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456194;
	bh=DVwy/SiED1aUxG3GP52kN89RSs8GgqpP4611q2+C8S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPc/4aTDLITG0PNefDLdDWiTkQObOQxOwedpjrYDouUexkm1Ukh3SegG+qh8xfFRw
	 yZHIBiq6eb/HqmBnTRyFqULAmHI/B66dr14N1tBbFqUG3d3/u9T4aGaVKQ5raLiBcq
	 CVpmBI3U7iIudADuyAgU54pSqfX1VyPLjM2q5AzKRc7ANVOdao/qIkrFcZ/J0g0lOF
	 5GRDW7mCXodlVAFx9e35PV+gcz0DCR2YRMC+m8slG/dqZwhyQy/wy67lenV+nVY7jm
	 N/BS//AXLAmDEuTyfVml6nwqRrqslBxOCbkrI0B00pQiPYySdgcPb3kFy4iWbWYciS
	 Tacf5F0sMHIfQ==
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
Subject: [PATCH net-next v5 11/14] net: macb: timer adjust mode is not supported
Date: Wed, 25 Mar 2026 16:28:15 +0000
Message-ID: <20260325-facebook-chop-cf792c53f1da@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=im8X4CvHY/qWpTRXmAP5CqBJbYe51EIu9ctXDYbqxgw=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeM1rp67OPT7jieVu+R6hYxpTKkoEJZ69f57+ZdW5+ bO/lVTu6yhlYRDjYpAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEjuox/NP+FhPBefNM3PrF Tikl3z893qFcU6OSfPFw65IYxtUyFRsYGR4FTWJbo3DPROyB8otIRxPPG4Emp4/73zzvoFOV++D 8BQYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271652-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 029AE3295BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

The ptp portion of this driver controls the tsu's timer using the
controls for "increment mode", which is not compatible with the hardware
trying to control it via the gem_tsu_inc_ctrl and gem_tsu_ms inputs in
"timer adjust mode". Abort probe if the property signalling that the
relevant signals have been wired up is present.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b28fb771e03ba..58d89b9e2f08e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5838,6 +5838,13 @@ static int macb_probe(struct platform_device *pdev)
 
 	bp->usrio = macb_config->usrio;
 
+	if (of_property_read_bool(bp->pdev->dev.of_node, "cdns,timer-adjust") &&
+			IS_ENABLED(CONFIG_MACB_USE_HWSTAMP)) {
+		dev_err(&pdev->dev, "Timer adjust mode is not supported\n");
+		err = -EINVAL;
+		goto err_out_free_netdev;
+	}
+
 	/* By default we set to partial store and forward mode for zynqmp.
 	 * Disable if not set in devicetree.
 	 */
-- 
2.53.0


