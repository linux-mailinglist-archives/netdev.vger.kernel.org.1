Return-Path: <netdev+bounces-276679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBYhNjai1mlUGwgAu9opvQ
	(envelope-from <netdev+bounces-276679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:45:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8091C3C16E2
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D146730849C8
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAE3ACF13;
	Wed,  8 Apr 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq9e0skW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CFA3537EF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672852; cv=none; b=It94EtQh9mXcuRCObQFUZy7X+l7xLrTIic7MIcIdP8Of7/QYIsnE16s6CFRfiGKEkESR8lKHdC9uxmjcDwwEzzGFMftgvDUhBw9qo+JQRx430R5OMjybXS5jtJQoOuGzmt/IpvNDMZckmt2wzx8QFN+zfYE3d6P6BxTqLwI603s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672852; c=relaxed/simple;
	bh=CfAlUusSjZ0wcqcNUqCtpQrYzlAuAjxX2Y/xcgidRyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cdwn/BE/ikWhLMmYhEoga6CUi6KkOgpsQXVVwWnSEDFoIlN9vq6ksIXhQenguY/vPyLPyxkS4X8DqZJYo1kDuU9aTv92xjqJg7mAzE2b0joXTS2MHMNOHUEJD+bANhu+6AJF/Zd4EbqBawJ1+zh+yH5dooycbxgrsqvpHY6BhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq9e0skW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB8DC19421;
	Wed,  8 Apr 2026 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775672852;
	bh=CfAlUusSjZ0wcqcNUqCtpQrYzlAuAjxX2Y/xcgidRyc=;
	h=From:Date:Subject:To:Cc:From;
	b=eq9e0skW6NWZp/g+XSib6ls+XMic5D9Gzda3j+pyy8ZN7zOzZp8Z4HWcO5Dn0FW03
	 BSDJAsxmR42QFzQDypqbudDg7SWNjJ/tbJ5+R81I6F0/x4pgJjHkBy2pRG1wo3Ec2h
	 CXVlXiyP1OR1CLdc44F+osZgzmWhKk4H+SoYfJxqLfv8uoJOe9WTY/sXfeaojQozJm
	 EXY9GcToa1JEQC5fNSNho0Rw8pXh7h7m4IXminNsYR1XQv9HTJNRW1rFOkZ7eYxynP
	 k70K4sQhnC9LSROeRTv7uRAbVL0JgAqpM/op3qpV2EvGk2qT1P68JD1MMMrQWjorUw
	 NAo/Nr7xWREAw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 08 Apr 2026 20:26:56 +0200
Subject: [PATCH net] net: airoha: Add missing RX_CPU_IDX() configuration in
 airoha_qdma_cleanup_rx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-airoha-cpu-idx-airoha_qdma_cleanup_rx_queue-v1-1-8efa64844308@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3NWwrDIBCF4a2Eea6QG+llKyXIRE+agdYYrUUI2
 Xul9PHjh3N2igiCSLdqp4CPRFldQXOqyCzsHlBii6mt26HuukaxhHVhZXwqJf+pN/tibZ5gl7w
 OWW8JCQqzxRU9T+fLQGXRB8ySf293cnjTeBxfT2KBToIAAAA=
X-Change-ID: 20260331-airoha-cpu-idx-airoha_qdma_cleanup_rx_queue-efde9e4ab786
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276679-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8091C3C16E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the descriptor index written in REG_RX_CPU_IDX() is equal to the one
stored in REG_RX_DMA_IDX(), the hw will stop since the QDMA RX ring is
empty.
Add missing REG_RX_CPU_IDX() configuration in airoha_qdma_cleanup_rx_queue
routine during QDMA RX ring cleanup.

Fixes: 514aac359987 ("net: airoha: Add missing cleanup bits in airoha_qdma_cleanup_rx_queue()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 91cb63a32d99..919b7009cbe5 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -819,6 +819,11 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 	}
 
 	q->head = q->tail;
+	/* Set RX_DMA_IDX to RX_CPU_IDX to notify the hw the QDMA RX ring is
+	 * empty.
+	 */
+	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
+			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->tail));
 }

---
base-commit: f821664dde29302e8450aa0597bf1e4c7c5b0a22
change-id: 20260331-airoha-cpu-idx-airoha_qdma_cleanup_rx_queue-efde9e4ab786

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


