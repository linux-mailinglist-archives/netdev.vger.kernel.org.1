Return-Path: <netdev+bounces-245916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA7CDAB8F
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 22:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B890730198C7
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6D3128C4;
	Tue, 23 Dec 2025 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4QZGC50"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687E266B72
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766527030; cv=none; b=nFyWfGT0qVQDAHF17H/OphaahixgB6DRfkH6Npymhb2DfwfXtBrjaZoloFrjBmqNpKOwHcWBtdpFn3L0zmSQWXgAeZ4w75gIUcYtYqKyrUrKJLmfDaCrAu/xzez/4DSsfZl9EvRIWsfNPom4xZ+UEjL/PWWIIt1Xhhy2iaCq+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766527030; c=relaxed/simple;
	bh=68ngR6r337s4Uq5yOPMzXnBFuiUfzKPli0oTxvM83W0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YPsircVvbdRJHp22G2IMYGpuJ9BtqZfaxKbTSMz4LeRqQDzJGAHeReEjjdWcXZj17S/KjsZBuZqyanW7576XYsVbsPkYcLAOg8CXkh5SnWcN/Y5DVI1frIV1477Pk00vpO6KNIKUxdfUqlscjtdbrnyqmFDIC2jSjwtnpKmbPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4QZGC50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7E2C113D0;
	Tue, 23 Dec 2025 21:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766527030;
	bh=68ngR6r337s4Uq5yOPMzXnBFuiUfzKPli0oTxvM83W0=;
	h=From:Date:Subject:To:Cc:From;
	b=b4QZGC50KfAQ7gYvxY+MWAp22RzTzyQs67qxPcvyZINmf/y593JrBMcKIr9mwpFp4
	 kq5jHqDCVY1ljeblsmZgMHxcaZW6qY/p/Se9ySRO4uMUB6VWwKj/yWKbhKzS+7OgPZ
	 AzTvcFMkCoCGAMci9KltNav+y6hcOkjg/YBr9gxo8xjjV70WWSRtZb1KlK+o8qiXJD
	 s/fLIFy5sXSiPomYSW5iWGczGPYdLGfxSzOafAQU+DxxvOGVEmsWyNMv3cHJF/mfeR
	 YsLP7AaS3x02oqd0VT96zSTd9OR1ktQNoNpDLkhHUJwfjEnqy98b8OfadfRKbKKgxP
	 rPf8psNWtTkWA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 23 Dec 2025 22:56:44 +0100
Subject: [PATCH net] net: airoha: Fix schedule while atomic in
 airoha_ppe_deinit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-airoha-fw-ethtool-v1-1-1dbd1568c585@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBvQKaG6SrSwGnMgMjQqiO6et
 HyL/x9IHIUTdMUDkU9JErYMXRYwebstjDJnAykymqhCKzF4i+5CPvwRwoqknalHRVPbjJC7PbK
 T+3/2w/t+3r/+5mMAAAA=
X-Change-ID: 20251223-airoha-fw-ethtool-21f54b02c98b
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Rely on rcu_replace_pointer in airoha_ppe_deinit routine in order to fix
schedule while atomic issue.

Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 0caabb0c3aa06948e46ad087c50eba5babc81994..2221bafaf7c9fed73dcf8d30ff3b1c5eecc463d4 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1547,13 +1547,16 @@ void airoha_ppe_deinit(struct airoha_eth *eth)
 {
 	struct airoha_npu *npu;
 
-	rcu_read_lock();
-	npu = rcu_dereference(eth->npu);
+	mutex_lock(&flow_offload_mutex);
+
+	npu = rcu_replace_pointer(eth->npu, NULL,
+				  lockdep_is_held(&flow_offload_mutex));
 	if (npu) {
 		npu->ops.ppe_deinit(npu);
 		airoha_npu_put(npu);
 	}
-	rcu_read_unlock();
+
+	mutex_unlock(&flow_offload_mutex);
 
 	rhashtable_destroy(&eth->ppe->l2_flows);
 	rhashtable_destroy(&eth->flow_table);

---
base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131
change-id: 20251223-airoha-fw-ethtool-21f54b02c98b

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


