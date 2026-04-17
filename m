Return-Path: <netdev+bounces-279267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIz1CFzz4Wmv0AAAu9opvQ
	(envelope-from <netdev+bounces-279267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:46:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7E1418E20
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 449EC301A142
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44E3AE6E7;
	Fri, 17 Apr 2026 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3Ro8H85"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506575809
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415255; cv=none; b=HgjLR7naukiWsizKAS/DuA2cv9bug/3Z5wNimYvV4kGeB2DVmo63zOE135B9sSc2pOYScaLR074gsm5slfOrIrHVkHD0trxp5HbYh/j15I9wzc1Q8Mbp1z8uS9fZpKy00QGM/4pMweQoFX2RDQ0D53iHQc5lavmT1qrpLWD+LNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415255; c=relaxed/simple;
	bh=/bR7VjWpqFgfa6L8lgi5/ItZRSv3tGrpAuLfLnEUdNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxcQkWUGfEpk/EsT+s7oqEXB7jP+cYOTHCLyEPcKp1wKL+58wjgdtb6X4Bv3hh9Y8p3lI5v/kpqBKsYPGojgz72tETTcMpWIBgXhoijdYnRhqk9S5ek1mfhbzr6chogzgjY1Qmb9acKAmBbZ03rdGYTL1bvlIkdZNoBIqxjevng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3Ro8H85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1568C2BCB4;
	Fri, 17 Apr 2026 08:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776415255;
	bh=/bR7VjWpqFgfa6L8lgi5/ItZRSv3tGrpAuLfLnEUdNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X3Ro8H85p1t8j3dSdfqT0dwKe92lMtz5f3Xhr9c8g3bmjt4my8QxJyQFIKrbasIsf
	 Q7eMv2avzwVW9KubiZCB3WR74Pie1xfoTIULmPgfSEaYVHK1KV3KSdlY1fEN24XPJi
	 ghcPuPoR4knU/Tt5JJGHLuQmOhaQOEGmWcDZTO3/+BL8Y5WCA9Yktn233g4yjPou6J
	 dPDQK7QF3myHqFSH2RjQNnRHIjeAGUIUqBzVBnFYmfjaa1IfL+KreD3OBf/6ITpfCj
	 TsFyYwKBB9gudFdUL/UhR7hhfQhD23CcyF4pRV8Ip3CsjqfWQU04CfusvQMHMi+Wpr
	 JSATGwM/LNweQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Apr 2026 10:40:37 +0200
Subject: [PATCH net 2/2] net: airoha: Add size check for TX NAPIs in
 airoha_qdma_cleanup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-airoha_qdma_init_rx_queue-fix-v1-2-db9fa5e468e5@kernel.org>
References: <20260417-airoha_qdma_init_rx_queue-fix-v1-0-db9fa5e468e5@kernel.org>
In-Reply-To: <20260417-airoha_qdma_init_rx_queue-fix-v1-0-db9fa5e468e5@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279267-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F7E1418E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If airoha_qdma_init routine fails before airoha_qdma_tx_irq_init() runs
successfully for all TX NAPIs, airoha_qdma_cleanup() will
unconditionally runs netif_napi_del() on TX NAPIs, triggering a NULL
pointer dereference. Fix the issue relying on q_tx_irq size value to
check if the TX NAPIs is properly initialized in airoha_qdma_cleanup().

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index a6f8b231583d..1ca4087e675d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1398,8 +1398,12 @@ static void airoha_qdma_cleanup(struct airoha_qdma *qdma)
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
+		if (!qdma->q_tx_irq[i].size)
+			continue;
+
 		netif_napi_del(&qdma->q_tx_irq[i].napi);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
 		if (!qdma->q_tx[i].ndesc)

-- 
2.53.0


