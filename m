Return-Path: <netdev+bounces-171877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE7A4F300
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005A9188CFB7
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C282C60;
	Wed,  5 Mar 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFoh1rMK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C45D8F0;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136049; cv=none; b=EUAJUngWd2UBCx0ALwC+Wuv4uJRc5ZRtSNor+cf1+LTOWdi9whICjeqsPA23ruwTHGGcmju9eZbsGMjkE9oJz6HfOBF5RMScekdvGR/i1M2dfiose7LB+XGE9G6XXsiteX3YsadWiIxEOpVu5ZQ5xTYG7n7DZhB1RxyQeisqZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136049; c=relaxed/simple;
	bh=6xDLulu1Sw0fKbSpusNVkwccNOkA1alkCpoDdZkwvOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEPFl428IJWHFViEA+QEKtmoEZi0NC40fWG+Wsw8IKweyasksruLiUac6rU1XMhdo7SqJnsMTRZTqbqd/8WypY41deLn0xOG96aocJbG+DT2LURzS7FTSgynOqKsION+5aUeUPC5fifMD1BT3/WMuF0zjY6rt5CSj0CVcmeFn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFoh1rMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8364FC4CEEA;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741136048;
	bh=6xDLulu1Sw0fKbSpusNVkwccNOkA1alkCpoDdZkwvOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WFoh1rMKFcYXMHfpqTrPY2OCw62vAMQUVAdsIue5J+e8GSdgnAzd9JiUDpl5+cw24
	 Q2j+KMxWNo4cTYEKh1dtyoNPDn75yIWc7nkfyGdG2dZIcbOkBUqv05IsTF+ZTUQCUa
	 aiuK8Qs5ILod8K7SeTaaiLdaBjOEvhdUOw64XydYE4BJwvxEAM/ONrdMzy6zVthwob
	 K43ZJhBM3bs2fsoNvQWlJ0UVEtI/uUvv9KYoQ/Yn/G/ltC7mmKwaJkCHlD1qaUVX7p
	 60pwrRnGnKYW6s/GX6MbZ6MSVhmn30v3162DCq46lSKYJeF/AS7e6E10x0FDw++A5E
	 1ExJ51SHu4JiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7272BC282D3;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Tue, 04 Mar 2025 19:56:37 -0500
Subject: [PATCH net-next v2 1/8] enic: Move function from header file to c
 file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-enic_cleanup_and_ext_cq-v2-1-85804263dad8@cisco.com>
References: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
In-Reply-To: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741136202; l=7789;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=7kzRarx8eC77ZjdPIWBRrZ2WXck83vihC3q9QHlbccE=;
 b=4LMlkq2UMCgQ2PiFaF8r485VP4RiYjTmzh+WmpJhPZdxhbnZgftKBMTUxOrHZpi1ssZ3+teAT
 NDUgyI1/AJsBJ1iXKyRDz5CaqzLhRGNkni2h07xOX8TWyS0wiKYCfT1
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Moves cq_enet_rq_desc_dec from cq_enet_desc.h to enic_rq.c.
This is in preparation for enic extended completion queue
enabling.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/cq_enet_desc.h | 81 -------------------------
 drivers/net/ethernet/cisco/enic/enic_rq.c      | 84 ++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
index d25426470a293989ff472863cc85718e3b1d81d2..6abc134d07032a737c8b3d2987e3c7a4b8191991 100644
--- a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
+++ b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
@@ -88,85 +88,4 @@ struct cq_enet_rq_desc {
 #define CQ_ENET_RQ_DESC_FLAGS_IPV4_FRAGMENT         (0x1 << 6)
 #define CQ_ENET_RQ_DESC_FLAGS_FCS_OK                (0x1 << 7)
 
-static inline void cq_enet_rq_desc_dec(struct cq_enet_rq_desc *desc,
-	u8 *type, u8 *color, u16 *q_number, u16 *completed_index,
-	u8 *ingress_port, u8 *fcoe, u8 *eop, u8 *sop, u8 *rss_type,
-	u8 *csum_not_calc, u32 *rss_hash, u16 *bytes_written, u8 *packet_error,
-	u8 *vlan_stripped, u16 *vlan_tci, u16 *checksum, u8 *fcoe_sof,
-	u8 *fcoe_fc_crc_ok, u8 *fcoe_enc_error, u8 *fcoe_eof,
-	u8 *tcp_udp_csum_ok, u8 *udp, u8 *tcp, u8 *ipv4_csum_ok,
-	u8 *ipv6, u8 *ipv4, u8 *ipv4_fragment, u8 *fcs_ok)
-{
-	u16 completed_index_flags;
-	u16 q_number_rss_type_flags;
-	u16 bytes_written_flags;
-
-	cq_desc_dec((struct cq_desc *)desc, type,
-		color, q_number, completed_index);
-
-	completed_index_flags = le16_to_cpu(desc->completed_index_flags);
-	q_number_rss_type_flags =
-		le16_to_cpu(desc->q_number_rss_type_flags);
-	bytes_written_flags = le16_to_cpu(desc->bytes_written_flags);
-
-	*ingress_port = (completed_index_flags &
-		CQ_ENET_RQ_DESC_FLAGS_INGRESS_PORT) ? 1 : 0;
-	*fcoe = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_FCOE) ?
-		1 : 0;
-	*eop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_EOP) ?
-		1 : 0;
-	*sop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_SOP) ?
-		1 : 0;
-
-	*rss_type = (u8)((q_number_rss_type_flags >> CQ_DESC_Q_NUM_BITS) &
-		CQ_ENET_RQ_DESC_RSS_TYPE_MASK);
-	*csum_not_calc = (q_number_rss_type_flags &
-		CQ_ENET_RQ_DESC_FLAGS_CSUM_NOT_CALC) ? 1 : 0;
-
-	*rss_hash = le32_to_cpu(desc->rss_hash);
-
-	*bytes_written = bytes_written_flags &
-		CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
-	*packet_error = (bytes_written_flags &
-		CQ_ENET_RQ_DESC_FLAGS_TRUNCATED) ? 1 : 0;
-	*vlan_stripped = (bytes_written_flags &
-		CQ_ENET_RQ_DESC_FLAGS_VLAN_STRIPPED) ? 1 : 0;
-
-	/*
-	 * Tag Control Information(16) = user_priority(3) + cfi(1) + vlan(12)
-	 */
-	*vlan_tci = le16_to_cpu(desc->vlan);
-
-	if (*fcoe) {
-		*fcoe_sof = (u8)(le16_to_cpu(desc->checksum_fcoe) &
-			CQ_ENET_RQ_DESC_FCOE_SOF_MASK);
-		*fcoe_fc_crc_ok = (desc->flags &
-			CQ_ENET_RQ_DESC_FCOE_FC_CRC_OK) ? 1 : 0;
-		*fcoe_enc_error = (desc->flags &
-			CQ_ENET_RQ_DESC_FCOE_ENC_ERROR) ? 1 : 0;
-		*fcoe_eof = (u8)((le16_to_cpu(desc->checksum_fcoe) >>
-			CQ_ENET_RQ_DESC_FCOE_EOF_SHIFT) &
-			CQ_ENET_RQ_DESC_FCOE_EOF_MASK);
-		*checksum = 0;
-	} else {
-		*fcoe_sof = 0;
-		*fcoe_fc_crc_ok = 0;
-		*fcoe_enc_error = 0;
-		*fcoe_eof = 0;
-		*checksum = le16_to_cpu(desc->checksum_fcoe);
-	}
-
-	*tcp_udp_csum_ok =
-		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP_UDP_CSUM_OK) ? 1 : 0;
-	*udp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_UDP) ? 1 : 0;
-	*tcp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP) ? 1 : 0;
-	*ipv4_csum_ok =
-		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_CSUM_OK) ? 1 : 0;
-	*ipv6 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV6) ? 1 : 0;
-	*ipv4 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4) ? 1 : 0;
-	*ipv4_fragment =
-		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_FRAGMENT) ? 1 : 0;
-	*fcs_ok = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_FCS_OK) ? 1 : 0;
-}
-
 #endif /* _CQ_ENET_DESC_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index e3228ef7988a1ef78e9051d9b1aa67df5191e2ac..7360799326e8bd8ac8f102c3e3b3b4814f66b97f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -101,6 +101,90 @@ static void enic_rq_set_skb_flags(struct vnic_rq *vrq, u8 type, u32 rss_hash,
 	}
 }
 
+static void cq_enet_rq_desc_dec(struct cq_enet_rq_desc *desc, u8 *type,
+				u8 *color, u16 *q_number, u16 *completed_index,
+				u8 *ingress_port, u8 *fcoe, u8 *eop, u8 *sop,
+				u8 *rss_type, u8 *csum_not_calc, u32 *rss_hash,
+				u16 *bytes_written, u8 *packet_error,
+				u8 *vlan_stripped, u16 *vlan_tci,
+				u16 *checksum, u8 *fcoe_sof,
+				u8 *fcoe_fc_crc_ok, u8 *fcoe_enc_error,
+				u8 *fcoe_eof, u8 *tcp_udp_csum_ok, u8 *udp,
+				u8 *tcp, u8 *ipv4_csum_ok, u8 *ipv6, u8 *ipv4,
+				u8 *ipv4_fragment, u8 *fcs_ok)
+{
+	u16 completed_index_flags;
+	u16 q_number_rss_type_flags;
+	u16 bytes_written_flags;
+
+	cq_desc_dec((struct cq_desc *)desc, type,
+		    color, q_number, completed_index);
+
+	completed_index_flags = le16_to_cpu(desc->completed_index_flags);
+	q_number_rss_type_flags =
+		le16_to_cpu(desc->q_number_rss_type_flags);
+	bytes_written_flags = le16_to_cpu(desc->bytes_written_flags);
+
+	*ingress_port = (completed_index_flags &
+		CQ_ENET_RQ_DESC_FLAGS_INGRESS_PORT) ? 1 : 0;
+	*fcoe = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_FCOE) ?
+		1 : 0;
+	*eop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_EOP) ?
+		1 : 0;
+	*sop = (completed_index_flags & CQ_ENET_RQ_DESC_FLAGS_SOP) ?
+		1 : 0;
+
+	*rss_type = (u8)((q_number_rss_type_flags >> CQ_DESC_Q_NUM_BITS) &
+		CQ_ENET_RQ_DESC_RSS_TYPE_MASK);
+	*csum_not_calc = (q_number_rss_type_flags &
+		CQ_ENET_RQ_DESC_FLAGS_CSUM_NOT_CALC) ? 1 : 0;
+
+	*rss_hash = le32_to_cpu(desc->rss_hash);
+
+	*bytes_written = bytes_written_flags &
+		CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
+	*packet_error = (bytes_written_flags &
+		CQ_ENET_RQ_DESC_FLAGS_TRUNCATED) ? 1 : 0;
+	*vlan_stripped = (bytes_written_flags &
+		CQ_ENET_RQ_DESC_FLAGS_VLAN_STRIPPED) ? 1 : 0;
+
+	/*
+	 * Tag Control Information(16) = user_priority(3) + cfi(1) + vlan(12)
+	 */
+	*vlan_tci = le16_to_cpu(desc->vlan);
+
+	if (*fcoe) {
+		*fcoe_sof = (u8)(le16_to_cpu(desc->checksum_fcoe) &
+			CQ_ENET_RQ_DESC_FCOE_SOF_MASK);
+		*fcoe_fc_crc_ok = (desc->flags &
+			CQ_ENET_RQ_DESC_FCOE_FC_CRC_OK) ? 1 : 0;
+		*fcoe_enc_error = (desc->flags &
+			CQ_ENET_RQ_DESC_FCOE_ENC_ERROR) ? 1 : 0;
+		*fcoe_eof = (u8)((le16_to_cpu(desc->checksum_fcoe) >>
+			CQ_ENET_RQ_DESC_FCOE_EOF_SHIFT) &
+			CQ_ENET_RQ_DESC_FCOE_EOF_MASK);
+		*checksum = 0;
+	} else {
+		*fcoe_sof = 0;
+		*fcoe_fc_crc_ok = 0;
+		*fcoe_enc_error = 0;
+		*fcoe_eof = 0;
+		*checksum = le16_to_cpu(desc->checksum_fcoe);
+	}
+
+	*tcp_udp_csum_ok =
+		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP_UDP_CSUM_OK) ? 1 : 0;
+	*udp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_UDP) ? 1 : 0;
+	*tcp = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_TCP) ? 1 : 0;
+	*ipv4_csum_ok =
+		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_CSUM_OK) ? 1 : 0;
+	*ipv6 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV6) ? 1 : 0;
+	*ipv4 = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4) ? 1 : 0;
+	*ipv4_fragment =
+		(desc->flags & CQ_ENET_RQ_DESC_FLAGS_IPV4_FRAGMENT) ? 1 : 0;
+	*fcs_ok = (desc->flags & CQ_ENET_RQ_DESC_FLAGS_FCS_OK) ? 1 : 0;
+}
+
 static bool enic_rq_pkt_error(struct vnic_rq *vrq, u8 packet_error, u8 fcs_ok,
 			      u16 bytes_written)
 {

-- 
2.48.1



