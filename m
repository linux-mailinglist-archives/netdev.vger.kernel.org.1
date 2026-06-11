Return-Path: <netdev+bounces-298008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZpezLCl0KmpHpgMAu9opvQ
	(envelope-from <netdev+bounces-298008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:39:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696766FEF9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:39:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=EsZXIgWS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298008-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298008-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC48B3163FCD
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2A33CEB5;
	Thu, 11 Jun 2026 08:34:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39D21CC58;
	Thu, 11 Jun 2026 08:34:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166852; cv=none; b=r7b4UfWqJ8ASXumL1p5Opur6OqVGQt3VD6Jf5vKJETzbqkobtYBaZpiRXf6TVUVP6q5jH+FgxIO7iJWyAyrvT1AWb3XNcGqwcaEVS9mgkybgjqy63U5N3Ze56bLb8+V6eHlh3HpR0oL1YrQ37Rzy9u1oHSE0IxJLz91DuK96keM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166852; c=relaxed/simple;
	bh=edhuUNaG+tdrlxa0kC2QRQQlesO8JRpy6NWNui2VonY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JvuqZWxNnRTSIdrsXTINlzo5U6v+zETK0Y6GPoA4wV73Y+K/84mQvJSK3bH5OIwY6EVeZqGbl9lpmq8/52Ep+xJL+ETdAVA7eoTAKo24BqHfYQoZ5iQqVlzb9z7ROcGjamJlbTDSgfDKXqdaejNzvbcWp35RM8crBMHe+bESGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EsZXIgWS; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B0QvSK728211;
	Thu, 11 Jun 2026 01:33:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5X4w7vZzQ1OEwA3nZSIpsIV
	ilcOgUTnhJLfwv4rQKV8=; b=EsZXIgWSimnucR7KqeDgwiB7cDNpOyISgu7mSJ/
	DyUwtBLBKuvBmL4lzO9UBJF/gHyulCqZzfEvAqq2/MSzQC6q9QrntljktHs5Ir3Q
	MxkNYY7gr5VUw3WKz+qBmgNIFWiOTlrWJ8TebRFbFhx7ArlmOloMYlQnuGfekRLA
	npE/2OBULKgI1pY6buqmufk0u7LMmC3ODDd0bPvcKRbxgE2370fQfTl5D4kbL7B1
	YDUw+s0zaoBmOTDvWBv5V0czJx/f4wE5qgPdkZFWju3ZCrzN9lymlkMvbxfxhtLN
	A0pOVc/g4PLOIIcL72hEWn+mlorxQyu/EN8T8cKaBWfVBsQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r2531-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 01:33:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 01:33:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 01:33:47 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B7FE83F704D;
	Thu, 11 Jun 2026 01:33:44 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <rkannoth@marvell.com>, <sumang@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: [PATCH net] octeontx2-af: fix NPC mailbox codes in mbox.h
Date: Thu, 11 Jun 2026 14:03:30 +0530
Message-ID: <20260611083330.1652181-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA4MyBTYWx0ZWRfX3QsPv9D8fjNC
 yvJ8H356gg7scBzn8wVE8kQOLN4NbolWwAzc4BfQhL2lay8jmBB8dYhL9Etw3eA1ALY2FMQcWAo
 yzgFL3oIVAs9srZ+Njqa/QTAb6hy2yw=
X-Authority-Analysis: v=2.4 cv=O6gJeh9W c=1 sm=1 tr=0 ts=6a2a72ed cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=t_NWcBXyxL0RXa8AyJkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: h0sQHfnCp0wXkF_Wy4iwOpdDYcdfucrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA4MyBTYWx0ZWRfXxk6X6mlcHHBT
 g9Pfw+bBZ/O16k+hg5vEdoNMnjcxuCfetqbvGZkW9nGCEt1phFcWavQw1cvMeK0/wuNCeIl0MCv
 dEWfjqDjHB8G4FAXXIcTF0trMptNcbuoG9XXZCQY9GhzuDiyXqDrDdmvPClxCpRGevGCbVTWEBg
 1SxOjri5IvBJluMeLRbRwxQedZqYfRIPC9RlEwydcGcQ1g5GZIJ+EdvWNXBLkGTblhwgLFcxVVP
 2mQZwVhCnyXIjRcx5Mg8XablWl4jX4+q0cxWcrmuEokeHr4EcZqSzNCNGNkeZRvLh5bm8B4lJjd
 sbT/ecA/z966R81xD4tUr+gZA6OfhFl4hBVvbq1ULsMmAtv+xaolgeeKjkUJKaXIdMiAs/frsJU
 UqQ5eB1e/eOplDbvLR4VmxlDuS52bF6LsV9XRG9uztBtXIi+24+oNF1UxZjuAnDjhBJAjznagrP
 xG3ExFDXyT08tY43G3A==
X-Proofpoint-ORIG-GUID: h0sQHfnCp0wXkF_Wy4iwOpdDYcdfucrh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298008-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:rkannoth@marvell.com,m:sumang@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0696766FEF9

Several NPC mailbox command IDs in the 0x601x range were assigned out of
order. Renumber and reorder the M() definitions so each opcode matches
the stable contract expected by userspace tools and applications.

Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
Cc: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index dc42c81c0942..44fdd6ba7307 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -283,31 +283,30 @@ M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,
 M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                     \
 				   npc_get_field_status_req,              \
 				   npc_get_field_status_rsp)              \
-M(NPC_CN20K_MCAM_GET_FREE_COUNT, 0x6015, npc_cn20k_get_fcnt,		\
-				 msg_req, npc_cn20k_get_fcnt_rsp)	\
-M(NPC_CN20K_GET_KEX_CFG, 0x6016, npc_cn20k_get_kex_cfg,			\
+M(NPC_MCAM_DEFRAG,	 0x6016,	npc_defrag,			\
+					msg_req,			\
+					msg_rsp)		\
+M(NPC_CN20K_GET_KEX_CFG, 0x6017, npc_cn20k_get_kex_cfg,			\
 				   msg_req, npc_cn20k_get_kex_cfg_rsp)	\
-M(NPC_CN20K_MCAM_WRITE_ENTRY,	0x6017, npc_cn20k_mcam_write_entry,	\
-				 npc_cn20k_mcam_write_entry_req, msg_rsp)  \
-M(NPC_CN20K_MCAM_ALLOC_AND_WRITE_ENTRY, 0x6018,				   \
-npc_cn20k_mcam_alloc_and_write_entry,					   \
+M(NPC_CN20K_MCAM_GET_FREE_COUNT, 0x6018, npc_cn20k_get_fcnt,			\
+				 msg_req, npc_cn20k_get_fcnt_rsp)	\
+M(NPC_CN20K_MCAM_WRITE_ENTRY,	0x6019, npc_cn20k_mcam_write_entry,			\
+				 npc_cn20k_mcam_write_entry_req, msg_rsp)	\
+M(NPC_CN20K_MCAM_ALLOC_AND_WRITE_ENTRY, 0x601a, npc_cn20k_mcam_alloc_and_write_entry,	\
 				npc_cn20k_mcam_alloc_and_write_entry_req,  \
 				npc_mcam_alloc_and_write_entry_rsp)  \
-M(NPC_CN20K_MCAM_READ_ENTRY,	0x6019, npc_cn20k_mcam_read_entry,	\
+M(NPC_CN20K_MCAM_READ_ENTRY,	0x601b, npc_cn20k_mcam_read_entry,	\
 				  npc_mcam_read_entry_req,		\
 				  npc_cn20k_mcam_read_entry_rsp)	\
-M(NPC_CN20K_MCAM_READ_BASE_RULE, 0x601a, npc_cn20k_read_base_steer_rule,       \
-				   msg_req, npc_cn20k_mcam_read_base_rule_rsp) \
-M(NPC_MCAM_DEFRAG,	     0x601b,	npc_defrag,			\
-					msg_req,			\
-					msg_rsp)			\
-M(NPC_MCAM_GET_NUM_KWS, 0x601c, npc_get_num_kws,		\
+M(NPC_CN20K_MCAM_READ_BASE_RULE, 0x601c, npc_cn20k_read_base_steer_rule,            \
+				   msg_req, npc_cn20k_mcam_read_base_rule_rsp)  \
+M(NPC_MCAM_GET_NUM_KWS, 0x601d, npc_get_num_kws,		\
 				npc_get_num_kws_req,		\
 				npc_get_num_kws_rsp)		\
-M(NPC_MCAM_GET_DFT_RL_IDXS, 0x601d, npc_get_dft_rl_idxs,	\
+M(NPC_MCAM_GET_DFT_RL_IDXS, 0x601e, npc_get_dft_rl_idxs,	\
 					msg_req,		\
 					npc_get_dft_rl_idxs_rsp)\
-M(NPC_MCAM_GET_NPC_PFL_INFO, 0x601e, npc_get_pfl_info,		\
+M(NPC_MCAM_GET_NPC_PFL_INFO, 0x601f, npc_get_pfl_info,		\
 					msg_req,		\
 					npc_get_pfl_info_rsp)	\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
-- 
2.43.0


