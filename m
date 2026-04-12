Return-Path: <netdev+bounces-277753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id f98LD+hV22nkAQkAu9opvQ
	(envelope-from <netdev+bounces-277753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 10:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6293E3152
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD3F93011C69
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0461E1A17;
	Sun, 12 Apr 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji7HQV7w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6F1A6824
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775982050; cv=none; b=ZIRniYH2z7LVAXnPPTieXgUqa9DYyQdMjxK6MaiS3Ih/wG1Pd35oNEBlnSijEYdSMs7LchANYfgtGuAU+twWELvsYHEHvzh/OQ6Mk9E1yBFPILp15OKDCOlLNrnXFFKDMA99GjDylXFwUgaKlzTIHikN0K4N6fSkSbOTgmQgao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775982050; c=relaxed/simple;
	bh=xKqI+P1KWypfWU+RDHzu5Y0I3ZlpFtGyeLcvopY078M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WC7Bfs0EwTeL05OyVsbc/1xsXxx0j9VaQmTQ3BDOvpr0F6F2dCPnY6JAY6bO6fAbnUGAoJzIfKufBKZxOMo3TKiuG6VfrtWyFUCaA7MAratiJcfFp1UxYXm792LSMPWiCWG2OkGLNRhOpq2sEJmaY1LAgB2EemRsbLAYd2XNptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji7HQV7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23F7C19424;
	Sun, 12 Apr 2026 08:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775982050;
	bh=xKqI+P1KWypfWU+RDHzu5Y0I3ZlpFtGyeLcvopY078M=;
	h=From:Date:Subject:To:Cc:From;
	b=Ji7HQV7wLSHLqUrLUzL1+khHMwXGT4URcxRT0FBdqPaKR0vd5EQoJ6AUyFPTZGJs0
	 PVh/K4BQDRl941ayzkF1iePDiMGgRNOHkA8Eb6B7eSscy77ZWfnloHtVwGqSD5lhw3
	 5868NX8YKMPIdfIvp6iFYSiZQTo3K9l2H8UcAbYWtwFr2Nz8KhrraEELuE2Rpf2tn+
	 9wsH5ncsllRsijOQQ6pYDk8DLSlFzHa8UqH2dPAdknn5lS/OnvH++H/DPOV3kIoSM2
	 lbrSnv6jCd7pT30IlUkvU4GNROE5EanlRGtC17HYRig4gJoVP6ubd4lt3SEDlNrxJh
	 M82wB4R9Jw7cQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 12 Apr 2026 10:20:25 +0200
Subject: [PATCH net] net: airoha: Wait for NPU PPE configuration to
 complete in airoha_ppe_offload_setup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-airoha-wait-for-npu-config-offload-setup-v1-1-f4e0aa2a5d85@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQrDMAzAvlJ8niEJ7WD7ytghNE5rGHZw0nVQ+
 veFHnWQdEAlY6rwHA4w+nJllQ7+NsC8RlkIOXWG4MLdjT5gZNM14h65YVZDKRvOKpkX1Jw/GhN
 WaltB/0hunELoUoKeK0aZf9fqBUIN3uf5B/Jyqfd/AAAA
X-Change-ID: 20260412-airoha-wait-for-npu-config-offload-setup-19d04522412d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277753-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5E6293E3152
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to properly enable flowtable hw offloading, poll
REG_PPE_PPE_FLOW_CFG register in airoha_ppe_offload_setup routine and
wait for NPU PPE configuration triggered by ppe_init callback to complete
before running airoha_ppe_hw_init().

Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index c2c32b6833df..52199f6b39f9 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1332,6 +1332,7 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	struct airoha_npu *npu = airoha_ppe_npu_get(eth);
 	struct airoha_ppe *ppe = eth->ppe;
 	int err, ppe_num_stats_entries;
+	u32 val;
 
 	if (IS_ERR(npu))
 		return PTR_ERR(npu);
@@ -1340,6 +1341,13 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	if (err)
 		goto error_npu_put;
 
+	/* Wait for NPU PPE configuration to complete */
+	err = read_poll_timeout(airoha_fe_rr, val, val, USEC_PER_MSEC,
+				100 * USEC_PER_MSEC, false, eth,
+				REG_PPE_PPE_FLOW_CFG(0));
+	if (err)
+		goto error_npu_put;
+
 	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
 	if (ppe_num_stats_entries > 0) {
 		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,

---
base-commit: 02f72964395911e7a09bb2ea2fe6f79eda4ea2c2
change-id: 20260412-airoha-wait-for-npu-config-offload-setup-19d04522412d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


