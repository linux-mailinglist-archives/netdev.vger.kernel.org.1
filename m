Return-Path: <netdev+bounces-307589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ULsPBzWfVmrv/AAAu9opvQ
	(envelope-from <netdev+bounces-307589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:42:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC46758C76
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:42:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="nTZhp+r/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307589-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307589-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55373304CC12
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB142BC28;
	Tue, 14 Jul 2026 20:42:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2D42BC24
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 20:42:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061727; cv=fail; b=a9xt0FfzZIj2AIT1pEcCD4dm/cS+NUzhtcCHaxFw4Ab1aQqLZ6EAvcqswodvHvtFCb3kgx4gurcR0bO9V09l8X5pBhgEWMnqhHRr3cGaDVyXTI4zUJAak/ALZi0aNDw3WiC4hweBoCMacLbiFPIQiSeHx7xg6cBAcpNfbOjZOBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061727; c=relaxed/simple;
	bh=MJYyHmz0mGB2uoUfUhAU8+3zWgQR2n1e5MTvL2OloPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K8KCLpWkvsqu0ni9ikiHyBWXzSN2xEZsmB/hnoY5zelw7ucZlfzGIYAqyJuz7g+xWzWACXxbCPDMpSa5r2DI/ehGTVacfaqINzf/g1TBa432YYGeke792lGgeCeOIGcN8B//m8mfDJ5csXNjHWtmSgSzCdtqng5gqwfbBd0dZwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nTZhp+r/; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNAlsSk7iQMVm9Ymut3eyB2sKmbAyxH7xsZhfvkbIhES7fF7LnWl7wimXQ95/MqprFos78iiBStyPO8xKCTZrjglAwqx/pOU8StANupDw5D/biE53K4QP1cjOP5Wt7XswNfXbmsKASki4ExcB95lktY79471UffwmFP3Ies658nDWCL+9MfsZmAIxGYWbkOyPT8HjAKh0x1o8LvT2Y1UjGUsPSqAuOJE93rAjqyC6TxkiuTOlOxCBl9wDlJM5GCAbbYngMaaTxUeIL6XND3dxmPYAY7h1+bgVvcgssgooTfo3qZU+EMM4CNXPjMge7QZgfIzPSwxK/Vjlcix5ehSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z63E494NSgZ6W72Mgb0FJhmdwK+SVUJYVXcfBqpM+hc=;
 b=NltSWaGHWQUyQ0OemOlBUjd/HiOEkOTtrDxwo/lJ0GicTqTJx64+/DFgW1zA9PxJ47jmJY4FonubKTPMnJwJts5g+hyJ8M/hak7wTbftrlrM6GvRKn2quQFoT06jXkcmvndiOkQIbAjnKVhKfSNL+etbMq4rAjV1A7/kh/tzVh4TsyAxO1scAEmrKbxs6LpqIJZsf3NevFJhN3RViBHRCsHDTkhxd6/SOoDid4NZk8j42PQHKYOwtYuHgoVZhr1d8HKBP+v+acIj/vt0uf+6oS1Z3n/OZM8E9VcislEZehJf1R3bULV4VsuMdbn+KNigUeNTtRoxvYeivlSivdVg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z63E494NSgZ6W72Mgb0FJhmdwK+SVUJYVXcfBqpM+hc=;
 b=nTZhp+r/sDllLMKOvzH6280bRwPsaedn1wElN1K8X/koQlnlKB3bKAPcDM4K2HLlxBshGGRpvZgBXNIiXdmdcHxLYd4TTTmBfkUHSynZgcmskRiLZhynAXE5fgt6mEE+kpDoKq0BDnXSATP3tAX6AMFjjvgXCoSKOtWSajQm1yM=
Received: from CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::18)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 20:42:01 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::3a) by CH5P223CA0007.outlook.office365.com
 (2603:10b6:610:1f3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 20:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:42:00 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 15:41:59 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: order completion reads after the ownership check
Date: Tue, 14 Jul 2026 20:41:45 +0000
Message-ID: <20260714204145.1782390-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d357e3c-6240-4f3f-bb06-08dee1e85ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	EqUB9I9Z68PVmVbehz9zv2jShb69wZG4s64HIfSMoYLq0tS0CzXr1u2lu+GcSalOlGL9dwG9fE8QWdbMPruNtGIZSEsRvgTsZuC/UlHqiOPgmMvmr4e8Q7z9KEHv0MqIkTtYkBnpJDQOlYvBEIE6FDyWvypWFaMdAxN5R0PBOAnYc/uF8ExnkyH/Gjji4Cr5Sd55Cq66+iV+vdYtKW3Xh6aof+biUT9ddUGGz0gBrK5i4S+w0ZDDstGTNgjbR2Pz7rXOw5hDg+jgkCX4sPWU3b8tEnLF7Ako7eeD4y7X+X4rRfWt1XCqNaQnMC/jlnO6LD4DDwRFZaXguPeVXGjRSfof+zW2rOzmMJW2pwrMBYTuaf59DN9cB4gwLcvRLA66+aHQ9iMb+7KE79604Dnam7y7o7P9tpNuT82gRPDgiwaZh1GgbK447Bd+18siMFY5RoKlhKfurqHufPUm4N7uEIMOzBeplmfRQIc/Kac5fAmX0t5Yg/5OO4pRhlMzJw86RChVkJrpRgGEPMlDkN73lqhA6gvYiblYYgWjLhepzZOdtX85E/+SQSCmswri4KUnHlVns+DY1fkkeJxq5E9OMMyWyDH5+ih+TGlNQtbsJ2KX+2XUrcRta/S/nncekF+/ys83zsGlen6+MyfX85qbvA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/Ztg9m45fLUt57xVi0aPRWqN8QR4Y7D16TwvKA1SYEVwfsHgWUT6a/3Jz/sgDpLiL58ClJ0oKfvvQhKYm5gLOL2AhUV7dXRrHGhVunQJxfD7TSBuyLUJU7cNDPqEMgi2BrENz/dZSMewQsz6QaBqUFRKYnteM9PVFyWxT8qZybDaqHjgZMFtcT3tY3NpD84yRaWwxuFLEpxLCrPFmAH60anWtO69YQYwRMXyc9LEkBPVADUDGTs5TFuV3mgXgfheg4ckPLFHgxCaRW+di52PUyF23kCBqYWD65jnGhlUJlZURJ069FWyilGA+qgCSZf23WZVAYOO/wCOHFJjwNmBx5gPrZtlc4febH31ABNlIXxPa577Xf/bgd+nYE/WBVF0W35b32VtFFMKuvTTZWG87RFOIHnUkPPm3VIVu7SOteU//qbLtYEhSsxYcKhqZINA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:42:00.4990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d357e3c-6240-4f3f-bb06-08dee1e85ad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307589-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BC46758C76

pdsc_process_adminq() and pdsc_process_notifyq() decide a completion is
valid from its ownership field - the color bit for the adminq, the event
id for the notifyq - then read the rest of the descriptor, with no
barrier in between.

On a weakly ordered architecture the CPU may read the payload first. Add
dma_rmb() between the ownership read and the payload reads.

Fixes: 7e82a8745b95 ("pds_core: Prevent race issues involving the adminq")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 097bb092bdb8..eadb4b604fbe 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -18,7 +18,13 @@ static int pdsc_process_notifyq(struct pdsc_qcq *qcq)
 	comp = cq_info->comp;
 	eid = le64_to_cpu(comp->event.eid);
 	while (eid > pdsc->last_eid) {
-		u16 ecode = le16_to_cpu(comp->event.ecode);
+		u16 ecode;
+
+		/* Order the payload read after the event id, the field the
+		 * driver uses to detect a new completion.
+		 */
+		dma_rmb();
+		ecode = le16_to_cpu(comp->event.ecode);
 
 		switch (ecode) {
 		case PDS_EVENT_LINK_CHANGE:
@@ -101,6 +107,10 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 	spin_lock_irqsave(&pdsc->adminq_lock, irqflags);
 	comp = cq->info[cq->tail_idx].comp;
 	while (pdsc_color_match(comp->color, cq->done_color)) {
+		/* Order the payload reads after the color bit, the field the
+		 * driver uses to detect a new completion.
+		 */
+		dma_rmb();
 		q_info = &q->info[q->tail_idx];
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 
-- 
2.43.0


