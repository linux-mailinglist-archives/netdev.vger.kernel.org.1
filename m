Return-Path: <netdev+bounces-242750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EFDC9488C
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 23:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A601B345F98
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2A26463A;
	Sat, 29 Nov 2025 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AkF1R5Xk"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6021770B
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764453838; cv=none; b=IaOWyw9FJcNrnkvactV2KfoAj+Int+FW9azQwtHr0Mr5wl8miEpS6otqQf/zhEkY1qR2s9UTcAHWckO3OTa01uiMlSSH4uJdb4YsmU1F0LjcVAMMEHYjyFhNl495EqxaBmRyzwJ8cAJnX6HrxvItkHrADKO9v0HEZzlVjndjL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764453838; c=relaxed/simple;
	bh=R0pMG/TeWCHtg66bm4iqDQjTOUPugG9N+yKgbqvbMMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+47pj1AE9JKves7zGpTeHueWDZp+C+SCfzD2PtxTUEA0XDZLvWgGryVSBYp8N6zqiW7HX7EUxbl6VUuxl8byqdBZzAGxanO8skOzgx60C7DS3lFYhL0uVTUgVOnTzcuykYswGx1QEUO+a6ppeHcHqW8iy4ya+ueKYcfHGTHHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AkF1R5Xk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=s6RuCxwYOgYQxD3+ZcJ/XadV0QmYbU3gdFKZEGvGigI=; b=AkF1R5Xkdp6RzXjdfut6HLvi0Y
	IkpzZOn/O06lfstJc8bGxSIGsGGyIGwFjHnxTEN8FgLTfj6FK+W+JpU4TH8gpBl1A7aMjU5S4y2hK
	OmGFvDW2fypwyH2YmET8Hqycj0cFPScn5t3wJBhNhBzxEdGRxqFLHoXRZ/RsXIFU4JK5W4eF7ArxP
	5tNHTlKq3LakAy0iXogpuGSxLvFOP92IwmlUWm7o/7YhwfjmnAHXtGNhM1n/JRHVamWs94UTodFbe
	IoLtj8DqRXAVqttUrdnUe8nN/R5GupiTLUSeIF869Ey6Wc0owIq2GKlbZsT/qL9nhwiu1kp90A2Wo
	EoihBeCQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPT2n-00000001pN6-279Z;
	Sat, 29 Nov 2025 22:03:53 +0000
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
Subject: [PATCH net-next] sfc: correct kernel-doc complaints
Date: Sat, 29 Nov 2025 14:03:51 -0800
Message-ID: <20251129220351.1980981-1-rdunlap@infradead.org>
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
Cc: Edward Cree <ecree.xilinx@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: linux-net-drivers@amd.com
---
 drivers/net/ethernet/sfc/nic.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20251128.orig/drivers/net/ethernet/sfc/nic.h
+++ linux-next-20251128/drivers/net/ethernet/sfc/nic.h
@@ -156,9 +156,10 @@ enum {
  * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
  * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
  * @pf_index: The number for this PF, or the parent PF if this is a VF
-#ifdef CONFIG_SFC_SRIOV
+ * @port_id: port id (Ethernet address) if !CONFIG_SFC_SRIOV;
+ *   for CONFIG_SFC_SRIOV, the VF port id
+ * @vf_index: Index of particular VF in the VF data structure
  * @vf: Pointer to VF data structure
-#endif
  * @vport_mac: The MAC address on the vport, only for PFs; VFs will be zero
  * @vlan_list: List of VLANs added over the interface. Serialised by vlan_lock.
  * @vlan_lock: Lock to serialize access to vlan_list.
@@ -166,6 +167,7 @@ enum {
  * @udp_tunnels_dirty: flag indicating a reboot occurred while pushing
  *	@udp_tunnels to hardware and thus the push must be re-done.
  * @udp_tunnels_lock: Serialises writes to @udp_tunnels and @udp_tunnels_dirty.
+ * @licensed_features: used to enable features if the adapter is licensed for it
  */
 struct efx_ef10_nic_data {
 	struct efx_buffer mcdi_buf;

