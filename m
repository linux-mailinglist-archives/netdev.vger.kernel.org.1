Return-Path: <netdev+bounces-290688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFicDS4BEGqLSQYAu9opvQ
	(envelope-from <netdev+bounces-290688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:09:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D177E5AFD4F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 076AB3014157
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19050360EE2;
	Fri, 22 May 2026 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMKl7SxS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CE3438A2;
	Fri, 22 May 2026 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433771; cv=none; b=cCZeFf5TBsIcKKsKdWg/WgcsuenO4UyvLhWE3pQJO2pY5/291elT+9o1ranqXdLLAyuHk66U4GKPhWHkmMn9kPxBm2PqfB2Guo/0sEftG2qC/1LTQD8nDgD5qRKn8WNq8UfDY/2ljZiY3q4owHO5V/8yGAaojYMUOsMiCqZGFhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433771; c=relaxed/simple;
	bh=80mcAzKT7KUOX54cAxYT9sDC70vp0A2zMTxwr1FmLH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CnKFqlT3E72dflIXJkctmFZ9jVJebnyeGu7jW1M3XDGh7aNotUWlranV/oIZBBayaMQ0U86ruacMKxrl0PrMnUpRD4fuZ2R4xjpq/SAlnHCwl3iFavh4NQG4UYfvvjhc+yDzbWuWKg+5EVgfBUMYSJW/5GbaLdrmTY1T9gHZXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMKl7SxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65710C2BCB3;
	Fri, 22 May 2026 07:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779433770;
	bh=80mcAzKT7KUOX54cAxYT9sDC70vp0A2zMTxwr1FmLH8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sMKl7SxS2Vk+cDojK4O5Lml29VnBNPY/z5CJgfEe/Io12YNbfNezWyctuvYoohECU
	 okawJjSENLD0dzfwNeuUbfFn+j7RIw9gFMGZGUKp5CZfBe5PH7ABgpQokXJ8QKy74Y
	 rYZifadcbgZ1klbnyqKmvFb/1Fmh8MpZicwT+jhnoyzFlWl9dPpBZQeYJciU1D5oJi
	 yheZYSrc+Aw7yPRrDYzYXN48deGBeCOtBam2as0zGoF/I/uuJVefSZeAFdENFge4DR
	 b1NXQUAHCwGz1WCPQXGkFve4Dppwh//FCVpwLA1P0xAAW+Nvtni1LZLyCxTe6V1SCn
	 DMWdg7oMO2RfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD41CD5BB3;
	Fri, 22 May 2026 07:09:30 +0000 (UTC)
From: Abid Ali via B4 Relay <devnull+dev.taqnialabs.gmail.com@kernel.org>
Date: Fri, 22 May 2026 07:09:27 +0000
Subject: [PATCH v2] net: stmmac: fix RX DMA leak on TX alloc failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-stmmac-rx-desc-cleanup-v2-1-76e78eb471e1@gmail.com>
X-B4-Tracking: v=1; b=H4sIACYBEGoC/4WNQQqDMBBFryKz7pQ4jK3tynsUFyGOOmBUEisW8
 e5NvUD5q/fhv79DlKAS4ZntEGTVqNOYgC4ZuN6OnaA2iYEM3QxTgXHx3joMGzYSHbpB7Piekdm
 0pii54AdBGs9BWt1O8atO3GtcpvA5f9b81/5Vrjmm2Ly0d8OOiarOWx2ubvJQH8fxBRZJ+qW8A
 AAA
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779433768; l=1102;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=EIgrw7dXm9oPWp3zniVVX0HGvfR5iqNaEldPBGWkDIg=;
 b=hdVWBxzASNSfqv2s2Nbdsqb2HKzuMkf5yETC5Qk0aOAbyTz2fCbXgQSNPGOm5QD6odXNFnEhV
 SQbDhBYjaBMCsywRVUjkT/8JlHiG/CY7a+CIU++RSilyke3vIhGeR7s
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290688-lists,netdev=lfdr.de,dev.taqnialabs.gmail.com];
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
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D177E5AFD4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Abid Ali <dev.taqnialabs@gmail.com>

Free RX DMA resources when alloc_dma_tx_desc_resources() fails in
alloc_dma_desc_resources().

Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>
---
Changes in v2:
- Restructured return path based on feedback.
- Link to v1: https://lore.kernel.org/r/20260425-stmmac-rx-desc-cleanup-v1-1-1a18a704c422@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 13d3cac05..240453daa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2370,6 +2370,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
 		return ret;
 
 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
+	if (ret)
+		free_dma_rx_desc_resources(priv, dma_conf);
 
 	return ret;
 }

---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260425-stmmac-rx-desc-cleanup-440f05845492

Best regards,
-- 
Abid Ali <dev.taqnialabs@gmail.com>



