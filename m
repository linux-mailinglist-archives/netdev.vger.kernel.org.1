Return-Path: <netdev+bounces-281726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ1KF1J48GmiTwEAu9opvQ
	(envelope-from <netdev+bounces-281726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:05:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B775D480DFF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA60303C000
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976CA3D412C;
	Tue, 28 Apr 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhefmOqF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8F392C56
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365912; cv=none; b=bDSBEwgUV0jIkCJS2AA7VQyaw6ATw2onzZzQ/sYQoKd567RuWYsfTq1W+qup1ra++WLgBx875LhiYfiVsZR2veAGZ6ezPLxsV6R7mca6MOpQ6B3L623QPobqZpL2+cJCCLmg/8M4mb991bsSL+QrX0x+W3LnrFwRIIu+HfHb/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365912; c=relaxed/simple;
	bh=7fk0VA5+cNoW7sx+mkYAgp0ak+eEVYN/A1DKtFhUDzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vFYyAiKIKFt+YxbSrw5kPnScPeOAavnbdAZ6ZiP6qO74zORaeU8+dtl37yQdTw6p5bI4R0HFZqqkc+nWV/lYKHqs27J2U3X/WAfZsMRdU+3cn+HGgj13+shrlojxv3d2PPR59iPWsHObjFpYLuccHYPz4aq0Ly9+G0ChO5LKf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhefmOqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE61DC2BCB5;
	Tue, 28 Apr 2026 08:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777365912;
	bh=7fk0VA5+cNoW7sx+mkYAgp0ak+eEVYN/A1DKtFhUDzQ=;
	h=From:Date:Subject:To:Cc:From;
	b=hhefmOqFMk/lzYcUZloW9IrHT1yZMBQfu/PqbsK7uGhhhWUhYzurKYnCzOsjzwNmP
	 YGmkzWeBflNEs83iQV5a0GgmCShd2HykxBSieNCQ1ihXsAciKJZbcWEVHsKQeYXO6T
	 /2ajj69aF1bVnq1IEO522qEb/exjULeLeot6AY3AT/DyubuUzBR7YxkYY1hWqAki5s
	 iFkRMsnXd/O8gY95usOUtxuUCCk3JLT7pjo48BgmhyTyxVwqpNuXGXQclq8MCIzVo1
	 dTnGwpeOCMnvUhwOXT6wvDMHXDhfGLqKIlCmaNUvevpITkiLFuuem2y0FLDKMJJ6le
	 HoXR8pIfVFD9Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 28 Apr 2026 10:44:21 +0200
Subject: [PATCH net] net: airoha: Move entries to queue head in case of DMA
 mapping failure in airoha_dev_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-airoha-xmit-unmap-error-path-v1-1-aec44c6765c1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MOw6DMAwA0Ksgz7UE5iPaq1QMpjXEA0nkBISEu
 Hujjm95FyQxlQSv6gKTQ5MGX9A8Kvg49qugfouBahrqjkZkteAYz00z7n7jiGIWDCNnh2NDff/
 sZJmphVJEk0XPf/8GLxmm+/4BL6nh0nMAAAA=
X-Change-ID: 20260428-airoha-xmit-unmap-error-path-8125594efb23
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: B775D480DFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-281726-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

In order to respect the original descriptor order and avoid any
potential IOMMU fault or memory corruption, move pending queue entries
to the head of hw queue tx_list if the DMA mapping of current inflight
packet fails in airoha_dev_xmit routine.

Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order DMA tx descriptors")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5effb4a4ae84..82018a085e46 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2123,14 +2123,14 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 error_unmap:
-	while (!list_empty(&tx_list)) {
+	list_for_each_entry(e, &tx_list, list) {
 		e = list_first_entry(&tx_list, struct airoha_queue_entry,
 				     list);
 		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
 		e->dma_addr = 0;
-		list_move_tail(&e->list, &q->tx_list);
 	}
+	list_splice(&tx_list, &q->tx_list);
 
 	spin_unlock_bh(&q->lock);
 error:

---
base-commit: 3bc179bc7146c26c9dff75d2943d10528274e301
change-id: 20260428-airoha-xmit-unmap-error-path-8125594efb23

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


