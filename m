Return-Path: <netdev+bounces-135573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1365899E405
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FD91C21E56
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50141F893F;
	Tue, 15 Oct 2024 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="huShFYTF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B51F12E7
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988240; cv=fail; b=XrFnUWNTZq1JyqiVFuvu0C/gD3XdHrqovKIvpaTIdmGZhPAVyaWGpMCM6v/jqGNUV/qHYJLPNlUx7Cq5LX5YTc3iQo03czh9/RpziHlWEwd9L9rFSWMbr95p6ARnQ4B8osVv/Vn73N8BuHPy8oQ+itNIumZSyltcNn31vdDYJcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988240; c=relaxed/simple;
	bh=We7Z9smTSdx1vJcaPNglBQEnEgR7dNLn6tuVy1PV6B8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iivsJmBUsEuSCKRNamQJAy92+r+LykyI2ZWi38ELVgaUC4yJE8v7kS19W1fReewEiLvTegUqcY3fLyPxWc9GaUHsjrc6jhzpjUDwS0x+YEpBFYACN3ZKaV0pg3Vixt9nLd8PBYwkJXmjHofnMZWym1P1AxF7MlfGejsd5lt+pZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=huShFYTF; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDX7FqWxdQFq4kDDxsbsYpOcKXaEhdxcfZgL6aVx7rtLlAkkd2KYbthwjVXMqmWHjr0KIepTsdHO8dGVUBAw5LH2gpj34JQE3X9pPj9/LQEeWFqh2kBmt6b7wyyRC8IrqoX4aKr4PvE67LtmUdJm5Vd3ov/1QFMCBkQDb+YrZN2+BlG4bITXVu4+tYZtNoGYknIBhF4W44IVfOGmbg6ZzmXriST/TphMC4A8ZPnGjVL84Pv6lEKl1XN/iKoXO6BR9vceVH9Scp8OhsZycoujkmlPsd9c4n+CXOEvC2mt0At0efFSRU45/T/7TnCr5kLFSwt9Dz87HfihqSfFyD3pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWeaYAHRG+xoj26YH3Qs6BpOVG4jj2hs6/dEnRbnAwY=;
 b=gDs9Tgyhwdx7G3BQdRSVX6uRHqut0QnJpeWlbKpTIaC0a1FR3V3mUapqVrJuTOSNcVq+FZeG3sN1/ojO2tfEUMZ3eBRpfW4xrXK3NLKMgddyJW5WFli8s+aEAFl8IbmDYg6kMje6wMwN7tDEW5mOnY8hWlOOv8kSL9qS9cyHRtIik/V1WC4iSrrG+W+qlhWG7ZJWqiM69NHV7V1PEgEOEbRi4UGGA6Yzar1kqBcvNNrEnckaomqZw9AhrltaJK7xFgX032QatV8lbAfHv6+eBF7vT+AGksg2re8neMSCWheqyuzRszswZ2vMZqBSstUYhlLoX6RWO66/RmEguUtTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWeaYAHRG+xoj26YH3Qs6BpOVG4jj2hs6/dEnRbnAwY=;
 b=huShFYTFnc+TXwMhf01YvZcw2TilOtMEMuVy3L5QNLAAriX8FMqTDlPS6uXKsiZ4mdrQrp0i/ZftXOaS6joPKVaGhYhpbxR/OrD8zjWfe1pIoVc5Q6YHvkbcgCgWRIVJ5kkYo80mSgnq2rsWGgi1dUMrz3Q1/94M+9Q8iSvDxlLAbozdlUppSmnNI3+hIwKvMpwjHU+sHL40nW3hIxNzgCecSuugWVkv1lM35NAWi5AJq6uCdShH3yTcokSR/x0koFY79OOeCKmJafYb+S3As29fBJVwOKJT1DU/n8OiEp7I7QHOxB/3PP1rIpE/HgmvQQlna16bJCMfXtRcXLQ1Lg==
Received: from AS4P195CA0047.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::24)
 by AM7PR07MB6801.eurprd07.prod.outlook.com (2603:10a6:20b:1b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:34 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::29) by AS4P195CA0047.outlook.office365.com
 (2603:10a6:20b:65a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtng029578;
	Tue, 15 Oct 2024 10:30:33 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 38/44] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Tue, 15 Oct 2024 12:29:34 +0200
Message-Id: <20241015102940.26157-39-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|AM7PR07MB6801:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d251bae-4db9-4147-f9b1-08dced046712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lpa5LQ/QSzRmYkapxigNSmkCg+Ned3ikfTIXeX6vxEBd+6QiY56oR74D6++5?=
 =?us-ascii?Q?xX1CERivqJTLk7DOmaySSrPe+PwgYkOtFtEiVn0fyQBtkr5i3w77SJQEvxnS?=
 =?us-ascii?Q?931Xv/+HOdpKXgaB5WBTMeqv1yIi0EXbO07YY5RNzEm3qmDBpK1bVaZTN8Qe?=
 =?us-ascii?Q?V7++mng7edF/bpiLj9LcK16KNjbSWatsq5S7HIBRBXAd9dEB2zEaoqr7Pcdb?=
 =?us-ascii?Q?oIT7ReWr9OnsbmYroqyPDRJ4lWuCcLNItRZWMttIZ1S1Uye4rW3ouHe401qG?=
 =?us-ascii?Q?CPmKj/8H8xDroSHybdV8PolWARmYBxUfAX2/qfy4F9yBwabNdUKPw4jJRqiO?=
 =?us-ascii?Q?OSf9RJSs1hDHgy7cELZS5qCe4tewZ5cpD5+k0czb1gmPdsOWR1vkrGw/tCkr?=
 =?us-ascii?Q?sTQxEmmIn8vhydwJAKT/CJMB6l4B4BaBZRg+6GVURrL6ZxO2n8GMhOTfWPMz?=
 =?us-ascii?Q?CZNpJ7r6kk0YhInAB8b2YN6kM/JgbwcPpMI6Woq9BGt0g74M9mZhVbvvUrCE?=
 =?us-ascii?Q?3Qx8CNMcRmailf+MPgxRAODxy99X/Kcmu7l2JQUZZK6nPQ9znktwD/eMGjHh?=
 =?us-ascii?Q?vZoFtNuv2leCwErCiyOLxbpo4QtErBhcM0p4Y0rjZ30+C25FdbTpRBvG5Tru?=
 =?us-ascii?Q?wywRk9AXc1bTKuLDJkdHdu5wIYBOOFUVO1PqmkSzNJVilovVVec9ENdDupJ9?=
 =?us-ascii?Q?xmLGufvtXlblc6MTq7+Jy02bk212zNnE69hPZr3u1jq5qeV26gQpbuUTSYfV?=
 =?us-ascii?Q?nVZlCdMkSkh2jfuzWQH6UMxOEa3eNxvkC5dosBCoPNhrQcXm1he0gLsp4TNV?=
 =?us-ascii?Q?TKZT2S4xE9NyJcNxpq9L0Gxi2dXCiw/nKVxXYfIIozkoePbTVCCOqjKQBfAS?=
 =?us-ascii?Q?moooJMdbz2OUTOphFR+wxKRw/a8FOlaaj168VoZfv+TNvVq9FxlU0auDV9bq?=
 =?us-ascii?Q?SmWATAukl+WPxcPJjBMbpQNx7fLJcAoBZ14awyT8S1mlzjiZZ9voTfp/cCFV?=
 =?us-ascii?Q?JFqLUTnzbXd1N4sItYmvxgHhCDjROdZk+sspNdwUMi5zpBoi5iOLIYYPqwA0?=
 =?us-ascii?Q?00AjrZDp808MYg6fMu67FdMAVudqS2XbkKRQGiWq+25wOsnbe0eD0oqvwHjV?=
 =?us-ascii?Q?rkNqBR6PlFShTTP6M7ufzD1MK7Eve2svnxhgUCCQBGeTdwIwAu5y2u/CzIEN?=
 =?us-ascii?Q?ug2RwPbYN2YvAEzsDtk1GC9DXDOLn0R5dnusfL1EefBXj53hmMexfAKN8RGz?=
 =?us-ascii?Q?1epKehNhfJYuI0uEOtPXOyeTE5TCOLGVjOygDGr66edpZsZWlMFKYUnJK2G3?=
 =?us-ascii?Q?nJNL6UxA605DcveJL8qkUWhCJJcHef8V/cIbjADqFstLUthE88q4ggUBALEN?=
 =?us-ascii?Q?ZtyU8Yz0kmI9RmhlzL9KwK2KfRsqTu27APl43mM99KQLf0vOSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:34.3622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d251bae-4db9-4147-f9b1-08dced046712
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6801

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

3.2.2.1. ACE Field on the ACK of the SYN/ACK - If the Server is in
AccECN mode and in SYN-RCVD state, and if it receives a value of zero
on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_minisocks.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 301606ff1708..ba7a3300ab9e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -458,7 +458,10 @@ void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 
 	switch (ace) {
 	case 0x0:
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked) {
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
+		}
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


