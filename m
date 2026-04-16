Return-Path: <netdev+bounces-278952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJhLKXuQ4GmsjwAAu9opvQ
	(envelope-from <netdev+bounces-278952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:32:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C340B10B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3D3B31789A0
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF76138A712;
	Thu, 16 Apr 2026 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3ZXGZj0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32238AC70
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324477; cv=none; b=S74DbXwB6m4oc4b/AB8oMqgJYmKhupORMQ76ME+JHrPiJH/PtA8BzfrYnVueeD9EXajrGKgEBEaVSkJ73qacWRUJmxWTlytCu67FEPkzcyxmruCa6Ck75pQhnRf8+JtRAJdMsD8gpRF5BAqMHDPSESQjnQb3H2UnjLpxoCz7QVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324477; c=relaxed/simple;
	bh=1RyKXEg9w7ciA1MUXVCuKlalb/RGHXZGMtXCmpwPV5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=murlsHmQEXuufc8HmLiq81TtQWyjqe9TUd21YOPSeztc36Zn9LQxUOuU1YHEFe7r3fYXq6VLEIYojruWZl7LbWvGYkkcDTIbO8MGt3EdJU1N21jolSGvvhwaa4fGid4dmNsct9I9NER/Ce97dVXDJFQcZP9bwDJyfO5oIMqtdOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3ZXGZj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206C4C2BCB8;
	Thu, 16 Apr 2026 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776324477;
	bh=1RyKXEg9w7ciA1MUXVCuKlalb/RGHXZGMtXCmpwPV5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d3ZXGZj0peE+uz8kz7teFb70pJG5LKSZIOqwTPYFraq9qwcA8WNw0yYvyP9JjZuC+
	 Cx9osbM7qzALaIrpuwZ/Z9RfWNq0JFM1OR5OcPszOAPvlTMQ7THeZZEvd6nWp103JX
	 wEt9fGdimjaO0nwTXWhDaO0vNOfaUbN1HL2cKSoFKVd3WcVfzEbxgA5nPOe2CQdpl/
	 9jPgGoP4QdpExjCUgl4AuNTcIqPQYYjYWr3Zree0F7NBmQ8YTI1lZWcH2O6KGQNBeE
	 kEAB2jcxYbdatNBN/yjSsvwcfhBr25QVsJoyljreehQmU4eXZuithSByrAxc/Mjzx4
	 fRtOuids4Dd9A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Apr 2026 09:27:40 +0200
Subject: [PATCH net v3 2/3] net: airoha: Move entries to queue head in case
 of DMA mapping failure in airoha_dev_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-2-2b69f5788580@kernel.org>
References: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org>
In-Reply-To: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F8C340B10B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to respect the original descriptor order and avoid any
potential IOMMU fault or memory corruption, move pending queue entries
to the head of hw queue tx_list if the DMA mapping of current inflight
packet fails in airoha_dev_xmit routine.

Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order DMA tx descriptors")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 690bfaf8d7d9..dfe8a0bd2abd 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2053,7 +2053,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
 		e->dma_addr = 0;
-		list_move_tail(&e->list, &q->tx_list);
+		list_move(&e->list, &q->tx_list);
 	}
 
 	spin_unlock_bh(&q->lock);

-- 
2.53.0


