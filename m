Return-Path: <netdev+bounces-281115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mpuXHda17GmYbwAAu9opvQ
	(envelope-from <netdev+bounces-281115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 14:38:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A524663A7
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 14:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AD28300351A
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CF35BDC9;
	Sat, 25 Apr 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM7gWoJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73540DFD5;
	Sat, 25 Apr 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777120723; cv=none; b=WhLqIPjAheA/2/4VgrLd5k+lK3Y/xaP9VbH9yrp9tu5lip7WgBAfQTH67Y7iDZCCRDpudH6N+Z/najczhN4IOYgxIaVSytEdI1QKxQ4vzisB2tWNIhexF6gBdGPkwyLmRuONJCXHlkROXD21bNRgmEZd6/gjb8Rdi8ymmZKkFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777120723; c=relaxed/simple;
	bh=Ind4ewbTlV0VMaMhRBhUOAJ51ivGX/THmUva9v/9gmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V3ieoTl9976kdPZEMiAJHLv/72PTAzuTebFBLLyCsWsNcPsQ5LNDgzQE5nfbdhSwmjz+Xl0vMwoNSDvU+evyxAxe9ykHOIsKJRk2QqIYLzzh3DE3b2b4qIA2CANOgDktuzircrjct97l38D+zIYkTZcEohLuOpi0cwo0L42CRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM7gWoJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C958C2BCB0;
	Sat, 25 Apr 2026 12:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777120723;
	bh=Ind4ewbTlV0VMaMhRBhUOAJ51ivGX/THmUva9v/9gmM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kM7gWoJApE75qJV/GMLkMtKlPQti+IbS5dir8eZXg8vc4a+WDzunSPTzQMNkZaVWy
	 r89J97mlPj1uXpgaHQJVe9TGctiAFPTEuSvFV/i2YMDQI0nHz2Xy6JhSnI0wxR1Us5
	 nX+fDiKU3i1YUfd3ZxCLScAY4smiTuWHHcHCF2DgZNB1Nv/6nMAV1+bpMRLx4HuX3A
	 P8Q+P+tbNMgxbvKMAPADDdGfMB0jIl59/3MmsdWzXGfjFKTZH91fwU80RjSDBvPdU0
	 dwobEhpul06D58KHXahHPqjsVF6BANWvHaQUJsm/E+lNJr9WRpZVMgE22aW9VPe5Pf
	 Vli0FxDwA3KIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124F3FF8861;
	Sat, 25 Apr 2026 12:38:43 +0000 (UTC)
From: Abid Ali via B4 Relay <devnull+dev.taqnialabs.gmail.com@kernel.org>
Date: Sat, 25 Apr 2026 12:38:34 +0000
Subject: [PATCH] net: stmmac: fix RX DMA leak on TX alloc failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-stmmac-rx-desc-cleanup-v1-1-1a18a704c422@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMm17GkC/x3MQQqEMAxA0atI1gZqScXxKoOLUqMGtCPNKELx7
 haXb/F/BuUkrNBXGRKfovKLBU1dQVh8nBllLAZrbGvIOtT/tvmA6cKRNWBY2cdjRyIzGdeRo4+
 FEu+JJ7ne8Xe47we0+LlFaAAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777120721; l=998;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=6KNXYVuQw7qzkBuKkHzTHDqB5iOSzE7NC8yleiDYCcg=;
 b=EahVl7YbST7PFQZTcka11Q36pigH8utz9YqMXE8P+DU+sn23jzKVHG85DfrDfWEzR+sWFhWOw
 /h/aEKBo3ucCFAMZBnSU4000q8fFB8aF7BvvRihgWI7wK5bi7GsKhhe
X-Developer-Key: i=dev.taqnialabs@gmail.com; a=ed25519;
 pk=4Syx51HH/MOySSUpi79M2ToLOdwt1yiNb338eKZBJNk=
X-Endpoint-Received: by B4 Relay for dev.taqnialabs@gmail.com/20260425 with
 auth_id=752
X-Original-From: Abid Ali <dev.taqnialabs@gmail.com>
Reply-To: dev.taqnialabs@gmail.com
X-Rspamd-Queue-Id: C5A524663A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281115-lists,netdev=lfdr.de,dev.taqnialabs.gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Abid Ali <dev.taqnialabs@gmail.com>

Free RX DMA resources when alloc_dma_tx_desc_resources() fails in
alloc_dma_desc_resources().

Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 13d3cac05..8bb843b55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2370,8 +2370,12 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
 		return ret;
 
 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
+	if (ret) {
+		free_dma_rx_desc_resources(priv, dma_conf);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 /**

---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260425-stmmac-rx-desc-cleanup-440f05845492

Best regards,
-- 
Abid Ali <dev.taqnialabs@gmail.com>



