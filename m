Return-Path: <netdev+bounces-266601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP7VDTREsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:30:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B9726231D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5476130B606D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4F3CA4A2;
	Wed, 11 Mar 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTEosz+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690023C945D;
	Wed, 11 Mar 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224292; cv=none; b=oLNxq8gk46bFTIFKQ4aCt6qWyxG2A42qagS94cCmgCm8iB8ffG/PvzvkgQNSak92Ga3W3/CiebByyV5DY3nRFOMHLwGWXYp+XdLUxyJydyZpvs5isbrTHUBeusyfSgJTJdmfNON6ZT08XbrCesvlloCf/CepVywQLm+8Fpl3UNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224292; c=relaxed/simple;
	bh=KLueA/c6Dz81/C8ynUU6RVHQqxMTLTUtghgfet0J2Ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jGNhWESRnfZK7Ytu9tmLYf1CI4QYDOOCg1RVOfkArOFIDOfS21SxAU6jodUHaz/BEhe/X0DrfiE2rCumtnJEcNxn44XfgE9iAi9My7bLYRiJcHBcfmX/QTIsHlKjts1W60iFaiCMxz9IoWQWeiOhCsxpB3MxpIGw3Hvl8san1yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTEosz+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36134C2BCB0;
	Wed, 11 Mar 2026 10:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773224292;
	bh=KLueA/c6Dz81/C8ynUU6RVHQqxMTLTUtghgfet0J2Ow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mTEosz+porOROi16F15hqrBFVAoMVHypgQ2OATZOFvrYnrW1r8vvqO/jqyt3kjRgn
	 AIq+KhWUTCwu1jw6S1/z+QqLz0pA38LPPAmjAKHbfd2Xww1NH5XA38rHFcRg6TnKkJ
	 u0D7bO+uOvSTXcUzWJ0dIef+FQLCPm8w7EEz25tKRujR+RluMab4IV7t+liEqa60j8
	 5950+NvpVaGxzTVejsH8oAXZ9yhJ202L/Cmx9IU+z4w2e4SQrAnzOu5P29kTsE5w9I
	 NSxQSMmH/FUDs5Hc5raKm6zMHspBPO0UMy022Ai74hvNkm7kSe5/QnvLiibvj0NQA6
	 08Ch1D352MrYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281271049527;
	Wed, 11 Mar 2026 10:18:12 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 11 Mar 2026 11:17:59 +0100
Subject: [PATCH v10 2/5] net: stmmac: platform: read channels irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-dwmac_multi_irq-v10-2-7ab1669759b5@oss.nxp.com>
References: <20260311-dwmac_multi_irq-v10-0-7ab1669759b5@oss.nxp.com>
In-Reply-To: <20260311-dwmac_multi_irq-v10-0-7ab1669759b5@oss.nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, rmk+kernel@armlinux.org.uk, 
 vladimir.oltean@nxp.com, boon.khai.ng@altera.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224290; l=2726;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=/ncF81mYqriMzIkXDHCjmpdMkczIZjJbkswTEDIvT3Y=;
 b=bm5gtvhweXyuMN7zIx3xAqcxJZj6Ixg3v6ty41EZIAlSzdOUny2h+SMlwnULvokzSuV17til/
 CFDKd5xFoz1D2CGNgGGAuQ+LwKs62AnUhVTnLZI2FF4M/OYyg8quuEb
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Rspamd-Queue-Id: 33B9726231D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266601-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:replyto,oss.nxp.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,suse.com:email]
X-Rspamd-Action: no action

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Read IRQ resources for all rx/tx channels, to allow Multi-IRQ mode
for platform glue drivers.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 57 +++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5c9fd91a1db9..7c299e47ff14 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -697,9 +697,47 @@ struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
 
+/**
+ * stmmac_pltfr_get_irq_array - Read per-channel IRQs from platform device
+ * @pdev: platform device
+ * @fmt: IRQ name format string (e.g., "tx-queue-%d")
+ * @irqs: array to store IRQ numbers
+ * @num: maximum number of IRQs to read
+ *
+ * Return: 0 on success, -EPROBE_DEFER if IRQ is deferred, -EINVAL on error.
+ * Missing IRQs are set to 0 and iteration stops at first missing IRQ.
+ */
+static int stmmac_pltfr_get_irq_array(struct platform_device *pdev,
+				      const char *fmt, int *irqs, size_t num)
+{
+	char name[16];
+	int i;
+
+	STMMAC_FOREACH_MTL_QUEUE(i, num) {
+		if (snprintf(name, sizeof(name), fmt, i) >= sizeof(name))
+			return -EINVAL;
+
+		irqs[i] = platform_get_irq_byname_optional(pdev, name);
+		if (irqs[i] == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		if (irqs[i] <= 0) {
+			dev_dbg(&pdev->dev, "IRQ %s not found\n", name);
+
+			/* Stop on first unset irq */
+			irqs[i] = 0;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
+	int ret;
+
 	memset(stmmac_res, 0, sizeof(*stmmac_res));
 
 	/* Get IRQ information early to have an ability to ask for deferred
@@ -735,7 +773,24 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
-	return PTR_ERR_OR_ZERO(stmmac_res->addr);
+	if (IS_ERR(stmmac_res->addr))
+		return PTR_ERR(stmmac_res->addr);
+
+	/* TX channels irq */
+	ret = stmmac_pltfr_get_irq_array(pdev, "tx-queue-%d",
+					 stmmac_res->tx_irq,
+					 MTL_MAX_TX_QUEUES);
+	if (ret)
+		return ret;
+
+	/* RX channels irq */
+	ret = stmmac_pltfr_get_irq_array(pdev, "rx-queue-%d",
+					 stmmac_res->rx_irq,
+					 MTL_MAX_RX_QUEUES);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(stmmac_get_platform_resources);
 

-- 
2.47.0



