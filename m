Return-Path: <netdev+bounces-278467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM0nMclL3mmwqAkAu9opvQ
	(envelope-from <netdev+bounces-278467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:14:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5551A3FAF53
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD493064948
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F193E717A;
	Tue, 14 Apr 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1EaK8ua"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6E3DBD59
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175744; cv=none; b=gMFqHMfaSxcXx5i0K2nPx36Qy9r/hjLR6A2CxAdOTewrCTp1EsfmaSda3+M66wTxsEXTNEvOALuFEDeywX2MBfs82nzv3lp4HSmfqo6oV/XwzdhbzCOl3B0WdZUr9d9hoQY5qkuD/eJ9CSjsxabKRoJmouVVbckRilFq69WlveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175744; c=relaxed/simple;
	bh=ZxZWJI8qqfzCDhQbBvHw11oPHk45TsukiZ+I1BwbZBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HWkDT40ZLKNxjtziTu5nphX2OvpqIMUXSRh2boZGSlNNAnmOsWAnu32DbhlVdnjo1At3whZXPVM6Yy7byboPj/gEamuSm55n9pVZSd8+U0CbNZGNYNSM23HBvI78KiMNt+pJqip2kjmvIBq9EP9I+o41yZunk1htRyzgJ4Azlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1EaK8ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD7DC19425;
	Tue, 14 Apr 2026 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776175744;
	bh=ZxZWJI8qqfzCDhQbBvHw11oPHk45TsukiZ+I1BwbZBo=;
	h=From:Date:Subject:To:Cc:From;
	b=U1EaK8uaOIEaRDvFnhCDxrClEYZPnNEOObNFPqWT38CCV6LpArpBW27pHOhjs8xpY
	 9lXg5oT+/wGbyZpZw80tVHLODI0PsOqoGSqcR0evklDSv5shC+hy09rAu6+VZ0T4sg
	 AZtMq3d2k+CgLkNFqyUydTu8MI5vYw35ntTgQHFoH5TdQSprjx7NoN4f9gmLDEyXyC
	 HulQcpKv3bliqEowIIOs83KiyOPtgKbm5oUih1CfvkTn6DHpiSioU9psb7q6RZow0G
	 7Pgq8z5T6EtGI9NmKq6gvbAI5LgKuYQJyPFoxBSGhp2ld0E6vjQa+QGR86icTsJqCi
	 li+nRO3EMBnyA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 14 Apr 2026 16:08:52 +0200
Subject: [PATCH net v2] net: airoha: Wait for NPU PPE configuration to
 complete in airoha_ppe_offload_setup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-airoha-wait-for-npu-config-offload-setup-v2-1-5a9bf6d43aee@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBBFr0Jm7RjagFFX3sOwmNApTCQd0hbUE
 O5uww1cvv/z/9sgcRROcK82iLxKEg0F7KmCfqQwMIorDLa2l7oxFkmijoRvkoxeI4Z5wV6DlwH
 V+0nJYeK8zGhurm5aa8vIQbmbI3v5HKonBM7QlXCUlDV+D/1qjup/02rQoG+4JrLUumv7eHEMP
 J01DtDt+/4DwctuKuYAAAA=
X-Change-ID: 20260412-airoha-wait-for-npu-config-offload-setup-19d04522412d
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
	TAGGED_FROM(0.00)[bounces-278467-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5551A3FAF53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to properly enable flowtable hw offloading, poll
REG_PPE_FLOW_CFG register in airoha_ppe_offload_setup routine and
wait for NPU PPE configuration triggered by ppe_init callback to complete
before running airoha_ppe_hw_init().

Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Check for both REG_PPE_PPE_FLOW_CFG(0) and REG_PPE_PPE_FLOW_CFG(1) to
  complete.
- Link to v1: https://lore.kernel.org/r/20260412-airoha-wait-for-npu-config-offload-setup-v1-1-f4e0aa2a5d85@kernel.org
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 62cfffb4f0e5..684c8ae9576f 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1335,6 +1335,29 @@ static struct airoha_npu *airoha_ppe_npu_get(struct airoha_eth *eth)
 	return npu;
 }
 
+static int airoha_ppe_wait_for_npu_init(struct airoha_eth *eth)
+{
+	int err;
+	u32 val;
+
+	/* PPE_FLOW_CFG default register value is 0. Since we reset FE
+	 * during the device probe we can just check the configured value
+	 * is not 0 here.
+	 */
+	err = read_poll_timeout(airoha_fe_rr, val, val, USEC_PER_MSEC,
+				100 * USEC_PER_MSEC, false, eth,
+				REG_PPE_PPE_FLOW_CFG(0));
+	if (err)
+		return err;
+
+	if (airoha_ppe_is_enabled(eth, 1))
+		err = read_poll_timeout(airoha_fe_rr, val, val, USEC_PER_MSEC,
+					100 * USEC_PER_MSEC, false, eth,
+					REG_PPE_PPE_FLOW_CFG(1));
+
+	return err;
+}
+
 static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 {
 	struct airoha_npu *npu = airoha_ppe_npu_get(eth);
@@ -1348,6 +1371,11 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	if (err)
 		goto error_npu_put;
 
+	/* Wait for NPU PPE configuration to complete */
+	err = airoha_ppe_wait_for_npu_init(eth);
+	if (err)
+		goto error_npu_put;
+
 	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
 	if (ppe_num_stats_entries > 0) {
 		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,

---
base-commit: b9d8b856689d2b968495d79fe653d87fcb8ad98c
change-id: 20260412-airoha-wait-for-npu-config-offload-setup-19d04522412d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


