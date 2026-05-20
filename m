Return-Path: <netdev+bounces-289977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JdDGP3IDWr93AUAu9opvQ
	(envelope-from <netdev+bounces-289977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:45:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1F158FF41
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8166302413A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1003E9588;
	Wed, 20 May 2026 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSTivjF3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88A2571A9;
	Wed, 20 May 2026 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287115; cv=none; b=JDc9wwT/szZrQX5nnbYBNOjuNzbsW4eFfyHX2VDfYd5BupPMLX9kw/BQYpDYtTFnwsztQtiRaSppf1hFF4nb9W39cvkLLIaaXRhOMRfLwtQL2zLfPdlTF1MhVVLLEF6NELvXYsANIQIec8EMgsVu4ALBencWFT/NLxYmrGKlEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287115; c=relaxed/simple;
	bh=BnMsVWcwl4AFbezmgy6BVdcgEuOZPKK25nQ5D6YYan8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QRwD0tVBlQuGJ+e0Cl/9nYrXKB/w0gl/fABweN6np3ye+pYLiQnMb+6c4WnuLOFZLrPtO3Sf3Z4M/wwkYpP/rDdVg0M6/4UFrwEnKnA1QjD6L4iwDR647r7lsUsLYWTlqaUbsbxdLCASfpTe20iWFpBZbg9RSKpdlg/WldWOAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSTivjF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC46CC2BCB0;
	Wed, 20 May 2026 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779287114;
	bh=BnMsVWcwl4AFbezmgy6BVdcgEuOZPKK25nQ5D6YYan8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=FSTivjF3qnEkoR4a1VMkETSnoNUlSeaOa7nZBdulljcMl8yjnG8G0K2kLzisnfyHI
	 kz0DjDQQ7ekIvdzVztIWZ865sGO70Tru8z4GZPtd0sx1EYXQZWY8KUEiZemX8xUarX
	 7iy9iNrepnMR53XQh4D5ygqb31zp/nNQRHh4AUk2p5zU0cRRn8Zo7l4iEE6KfctLvW
	 CfkAaLFIjzYVriCClpQPwssIwcPGu1YbcbLyEBXo7Uyx2yt0Tcbyyw9BybNfXMq4lZ
	 DRWZXEXpPkjfqQadgn5Wepak5Ew7LtZfzMHGhdQttgmD1TTGCiOfWWjXJ9vq8ig3w2
	 9l6bDmCOSWY3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD48CD4F54;
	Wed, 20 May 2026 14:25:14 +0000 (UTC)
From: Abid Ali via B4 Relay <devnull+dev.taqnialabs.gmail.com@kernel.org>
Date: Wed, 20 May 2026 14:25:12 +0000
Subject: [PATCH] net: stmmac: mmc: Remove duplicate mmc_rx crc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-xgmac-mmc_rx_crc-cleanup-v1-1-7133f529859f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEfEDWoC/x3MQQqEMAxA0atI1gY6BUXmKjJIJqYamFZJcSiId
 7e4fIv/T8hiKhnezQkmf826pYpX2wCvlBZBnavBO9+7zjssSyTGGHmyMrEx8k8oHTtSYKE+EA3
 0hZrvJkHLsx4/13UDz9N5oWoAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779287113; l=1169;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=utjrD6shew6tFykTsrj0bAnoJoit1s0RWNNHVzKqLU8=;
 b=NXVGghpu3DrYDgU1IEKAByx2WJBLoEnBEgQZdMPa5C1VCDN5XDktpigly5SEq3LSFM1EXKlCn
 ZO/KUbnUElnAF4ecknXrNJjeTn+7H0lnAzl2cm4akf7MlUABjM4th4k
X-Developer-Key: i=dev.taqnialabs@gmail.com; a=ed25519;
 pk=4Syx51HH/MOySSUpi79M2ToLOdwt1yiNb338eKZBJNk=
X-Endpoint-Received: by B4 Relay for dev.taqnialabs@gmail.com/20260425 with
 auth_id=752
X-Original-From: Abid Ali <dev.taqnialabs@gmail.com>
Reply-To: dev.taqnialabs@gmail.com
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289977-lists,netdev=lfdr.de,dev.taqnialabs.gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_REPLYTO(0.00)[dev.taqnialabs@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0A1F158FF41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Abid Ali <dev.taqnialabs@gmail.com>

Double read of mmc_rx_crc_error in XGMAC is removed.

Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index 1b3b114e7..d81581dfa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -479,8 +479,6 @@ static void dwxgmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 			     &mmc->mmc_rx_multicastframe_g);
 	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_CRC_ERR,
 			     &mmc->mmc_rx_crc_error);
-	dwxgmac_read_mmc_reg(mmcaddr, MMC_XGMAC_RX_CRC_ERR,
-			     &mmc->mmc_rx_crc_error);
 	mmc->mmc_rx_run_error += readl(mmcaddr + MMC_XGMAC_RX_RUNT_ERR);
 	mmc->mmc_rx_jabber_error += readl(mmcaddr + MMC_XGMAC_RX_JABBER_ERR);
 	mmc->mmc_rx_undersize_g += readl(mmcaddr + MMC_XGMAC_RX_UNDER);

---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260520-xgmac-mmc_rx_crc-cleanup-afcea6faa8ab

Best regards,
-- 
Abid Ali <dev.taqnialabs@gmail.com>



