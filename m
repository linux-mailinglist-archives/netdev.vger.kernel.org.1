Return-Path: <netdev+bounces-244641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5430CBBF5F
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 20:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 557D230062E8
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A488621FF5B;
	Sun, 14 Dec 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vugZST15"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63C1E3DED
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765739779; cv=none; b=s+ivfV7wGQsL3EcD5ZssHzwVRS5B9ziM2RsSOEMHPeQfJutdkpPZsAR58/Yhli/JJ/P8X7xWGIagqWJVyHo1j4nTsEO6Dcvb5VevgcQF5uWSzIky8rEfaLrz4XGftDs+3kUZ61i9kF0lvbCU0KBXuqhp9X0hyFlVSGde5Q44xQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765739779; c=relaxed/simple;
	bh=PBhRqov8WcpNgomByS9/bLTVhuXoOnD0vik8aZsYifM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r00YkL1+D5Xow25E05qdnHn5Q0m5yTOUNnw1LskohyW3398d5nbop3qGsw9gsUBU4psFAgpYWgEnKi6BJMwF3dZ0htMtwiIBB4uZWxMZEnTg6mI0kl2Fsfo0JVqsrUcOjOZC83Lv3o2hSK2cm2rMVaZR60TNg5PxsUGIgZxMiGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vugZST15; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2esFxNF/G+bly78HBFugaZHRtZWDt8nPHUj9ExoPCzM=; b=vugZST159+pGlSCMWze8dnRqvw
	Jc7qmVav5mHPW094YL3fTyuKkxm+8JDFYKl8O3rSwkHdMwMxA/nyy6tP5/fAXaJRMdK33Q9DAjUa9
	UutBsCgdqIJuA6FwOkIAGZTj0zPMOxfwK4HmSyHgtNgny5H+NaAdyhN+7n8KgFP8K0kKq1J0eTBrn
	MZtnIT4gAiQn3vVZhBqRYxz18S2HnvRg9ZEEXBowKmUBPF9M/9Wdv3CPhm4WSwa5KwtI2bLr+wLv6
	CqIBJczWTiwbDk+ioo4chkc6ZMDCKF0g7oKhU73ZUQvV45lJBrODmTtRZNoAgoMGwvq+sdO3/r/Nm
	yqRyKAeg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUrZh-00000002gFi-14QX;
	Sun, 14 Dec 2025 19:16:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-net-drivers@amd.com
Subject: [PATCH v2 net-next] sfc: correct kernel-doc complaints
Date: Sun, 14 Dec 2025 11:16:03 -0800
Message-ID: <20251214191603.2169432-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings by adding 3 missing struct member descriptions
in struct efx_ef10_nic_data and removing preprocessor directives (which
are not handled by kernel-doc).

Fixes these 5 warnings:
Warning: drivers/net/ethernet/sfc/nic.h:158 bad line: #ifdef CONFIG_SFC_SRIOV
Warning: drivers/net/ethernet/sfc/nic.h:160 bad line: #endif
Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'port_id'
 not described in 'efx_ef10_nic_data'
Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'vf_index'
 not described in 'efx_ef10_nic_data'
Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'licensed_features'
 not described in 'efx_ef10_nic_data'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: update struct member descriptions based on Edward's comments

NOTE: gmail usually blocks my email to Edward's gmail address;
  gmail identifies it as spam.

Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: linux-net-drivers@amd.com
---
 drivers/net/ethernet/sfc/nic.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-next-20251208.orig/drivers/net/ethernet/sfc/nic.h
+++ linux-next-20251208/drivers/net/ethernet/sfc/nic.h
@@ -156,9 +156,9 @@ enum {
  * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
  * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
  * @pf_index: The number for this PF, or the parent PF if this is a VF
-#ifdef CONFIG_SFC_SRIOV
- * @vf: Pointer to VF data structure
-#endif
+ * @port_id: Ethernet address of owning PF, used for phys_port_id
+ * @vf_index: The number for this VF, or 0xFFFF if this is a VF
+ * @vf: for a PF, array of VF data structures indexed by VF's @vf_index
  * @vport_mac: The MAC address on the vport, only for PFs; VFs will be zero
  * @vlan_list: List of VLANs added over the interface. Serialised by vlan_lock.
  * @vlan_lock: Lock to serialize access to vlan_list.
@@ -166,6 +166,7 @@ enum {
  * @udp_tunnels_dirty: flag indicating a reboot occurred while pushing
  *	@udp_tunnels to hardware and thus the push must be re-done.
  * @udp_tunnels_lock: Serialises writes to @udp_tunnels and @udp_tunnels_dirty.
+ * @licensed_features: Flags for licensed firmware features.
  */
 struct efx_ef10_nic_data {
 	struct efx_buffer mcdi_buf;

