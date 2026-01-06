Return-Path: <netdev+bounces-247419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD2CF9C05
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 18:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF812300D838
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BFD2D23A6;
	Tue,  6 Jan 2026 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YojZqzSl"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9692BE7B2
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720750; cv=none; b=IZ0tpBgMIQ+7Y84H2ZCTbpQabg8rkdeNDNJtIQKy3gDKXVwnOaIYGR83a4ndIU4Zci1kL1xMJKTWHc5ik+fGzGXyLtS7PEQeZ03Kw42SivAZmV5SRtojeeQbdFJnVFWIeLy0ia6X4Qdjx9L+OhCj35p/BVSkmXg4QlCKuOh8M9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720750; c=relaxed/simple;
	bh=dXbJQ480Ex7dHR/TXtplwSfA26VcQYxTj83EgCd/iNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pa9SniwiA93ttyMX5lo92y4lv8Fg8WO6CO151S/u9uM9iZMvXcBRcyUII3l5UdgMvQyGGQVKIpc76PVot5udAp389Engv2nFoxLG6PVZdYdLs2BBS0cdfQ+4QpYaweBhiyRMwB6CiaYnLQnhFIIJmkX8cVf3hZcOrlrbfJBHNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YojZqzSl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UHId1Qxew/NssO1EEyaTdJ+wVXIuj2+vEjvBcEYjIJ4=; b=YojZqzSljUiPlnnPTIRtBrAbVL
	OkuNKRKecPWAKJyNQnHwU5XIiRTq78/Bu7g88BvbJd+nKFolQnJtEkO3rC2bs6zg9GCwcIYG5QaLV
	AWV/7RF5LxAKLKOTbqDoSQEj0TRZL7VHL21/N0mAv8qm4dQ3K/f53Qp+TOT0W3yfboGpvdvuGhjtu
	QRY378Rcj4OTmyIxYSj+0t9dAbzwsXIU56RALZRO2mxAd6UhKc5GgkWyGkjxGE15/4psoMMCjcGDv
	/LE1rL0PZy4UzJshJGkTY+UPtVAjEpBv3PBYkOnaXluTTSeEnLjjCKM2IgJm4Ha8PG2ydyh8XPG7G
	yZoOenqA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdAuv-0000000DZhC-12Gz;
	Tue, 06 Jan 2026 17:32:25 +0000
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
Subject: [PATCH v3 net-next] sfc: correct kernel-doc complaints
Date: Tue,  6 Jan 2026 09:32:24 -0800
Message-ID: <20260106173224.2010703-1-rdunlap@infradead.org>
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
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
---
v2: update struct member descriptions based on Edward's comments.
v3: no change, just resend after net-next is open.

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

--- linux-next-20260105.orig/drivers/net/ethernet/sfc/nic.h
+++ linux-next-20260105/drivers/net/ethernet/sfc/nic.h
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

