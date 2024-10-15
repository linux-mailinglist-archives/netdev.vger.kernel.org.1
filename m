Return-Path: <netdev+bounces-135571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE699E403
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265F61C22437
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1B1F8917;
	Tue, 15 Oct 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="TqIIBV3v"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE11F708F
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988239; cv=fail; b=uCxVAu0WqOhbbhBQUyCaYDRXq1M7ulJHGqTogAKOW4tfvEEDOfafUIPXxFrgAaNeZASjjJFGZQXoFqCDUQ3L4u8qriXIiYjDQtCrzTysGh/iFYPrKw6YBYOniC39uYCFfAdzxPIXEIW7Hd9i87NXiKpxxP+UOQ4DItjjcMDp89c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988239; c=relaxed/simple;
	bh=QqchbgJKOdLLbysZJkLh71WhIhritRN6xchguCDMavU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPefatMjUS3GygFdnVL0RTHmGfIBnRg9v0Q1nKv3ppzEsaVkQs2k5Pm3/3AVuhIMDVyCCG4c5ifahKSOqjvvO0FRchyzTHRVv6+0QRYvhMbNgMNrZ51QNzh//9DEUqmXtVpwEoMreFEBGDZYF0nNe1xDxbw4ZzyVvfinl0MSgk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=TqIIBV3v; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWQsbj01y5a0T9UrNMc6phzgR7DgO6YnSDFYPLfpDum5fBOK3l3tILW/+CoiR5ywHNzlMAYKbwtArLB6g1WRzpY1SpIopcfRpDfxJWeiv/4SEXs+Y+Cw9m5rpvMllZveEtYBWmaRQWY11iexT1LbicmvVJCRYjcH4mTLLkzekLIEyDLW1FfdWIHIz87Iu8g4pKoR8JMJpjg2g8LfDl592VJWFOR+pKruiNCgROlPpSx1dkSSQc3vErvcqfYCgsbZXggg6EBakoV7pOq9nbLB0nrFEFTzdglE5GdAS2HIU6UsRmk5OYOQnLsXS4Es1JRfVNa4zs8W0gRVtXu01MlUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10P/xB9g1lfQexhCGa5YSy2I5M8uKzsS1Cekb6A7BVc=;
 b=Z1VDoRIziC5VbDcNSXrXzCBcx6KzLQmtgbxNz0gPX0wd2k8SdNY1/3qvRwonXezTLxkXCfera1hgUoIRloQ2dBW9uYldCCBLaLqT4HfyOYPVJrWQH/fnHpnldeAU8qJu+aSfWAj2LrOYSo7jZL/qT1cGRyHo4xshqrYeE8r1hqFy8YgD0+sfmUdtaG5378RfX7uG/Co0PrECglOQ34Jo6F4hnOXlW2WVBPw2cFEUA1BQbbx9kl8EXDPumip+8cO1NRJJI+ttXotYXlek5SjHAswjqpkH2lFKxXEoujtOXweC1PQiiml/Ydo4FzviPEwUec6Su4JsQmHo0Nk8YNHRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10P/xB9g1lfQexhCGa5YSy2I5M8uKzsS1Cekb6A7BVc=;
 b=TqIIBV3vgTgY3I9YeqdXKkGcJ6lehIE6AM5UX2X3qEvvON6NU5/bBuPFF9oEfpSo0ffEkqToG9fqJM84X8YScutjrxThIJPhJXQ4vetzPHlTOPWuByTOcStopHnSAGh8KXlmjZBg3NTt2yvhogXyYT/ysscyiWHtj20LbWjOWmsGX2poCr3eb1Y/mcByUF899IeMY6VUXoHCwrJXTKBk4LXDK+tBYJPgZ41JrbOhUdC0YfdBtRsE6IyjQ6Kqv//koxRtNqTXBFqodDYUMCZBBWpdCI/am7HsO+bBuLeROAhGFCKj9N6a+SOLhNizWRXjp42faGOG4clToaL81fGHuw==
Received: from AS9PR06CA0092.eurprd06.prod.outlook.com (2603:10a6:20b:465::10)
 by DU0PR07MB9063.eurprd07.prod.outlook.com (2603:10a6:10:408::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:32 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:465:cafe::cb) by AS9PR06CA0092.outlook.office365.com
 (2603:10a6:20b:465::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnd029578;
	Tue, 15 Oct 2024 10:30:31 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 35/44] tcp: move increment of num_retrans
Date: Tue, 15 Oct 2024 12:29:31 +0200
Message-Id: <20241015102940.26157-36-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|DU0PR07MB9063:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9d46a8b4-a22f-432f-c235-08dced04661d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8oL4O09OTL5rpCelOSvLarBfAHKQLsqHvg5LEczclE7kqGX4Wsd3/fbPOmPW?=
 =?us-ascii?Q?d/+D39r1/dJKTHyDJmuqT8AuASlUtYZMWtAFzq78GZnbRHegWCz7+1T+fJh7?=
 =?us-ascii?Q?L+dO1QXCbjLb7Bb4mUxU0AUt5cZLmpEGzLvYD/gw8UVQP7VgZZJHdx7MqIgB?=
 =?us-ascii?Q?f+LMY0lVNNnmMjNHaUoEM/wRZZnymrYQ0/Wmq8NTDFWlXMg2yIgummVMCh7O?=
 =?us-ascii?Q?S1FbhDGxzZlVhOkVuDbTGqtcMFVX5su1L3AOReC8UoJ76lt/idDbQAb6wkD8?=
 =?us-ascii?Q?8oVX/qrOwKGXV2fvaqE/Oa5BXtYqprAfOQbx3zwj3iHbLDjreJsvI9JuZSmK?=
 =?us-ascii?Q?WWIFtCc6NuSnz9nA2wPwLdHKH+w7EcC9rZvSL0xwwTOTjkyg9FdeZP8Aw+I0?=
 =?us-ascii?Q?EZv6Wksw5yY3lZpBRsaZSqrp7X8x6WO9/TSGypdoisBtNY3t6L4e+X4GY5HK?=
 =?us-ascii?Q?hupOGT+ha3vn/ZZeZKGleqQR7E9bVPkn4apGG8YEdbp/0zqSwQgtCtgIMJIm?=
 =?us-ascii?Q?33cp0+/zjnWzAyOE7zjzD3Xt66VRR//MDqAsc99qqPPWj9sDPYExMFy63tIC?=
 =?us-ascii?Q?YKF2gDgba7CWVO5609zsFku90wDU2depuGxCqwr7nY2ZfZISXGxvInnawn7J?=
 =?us-ascii?Q?vU8/07Po8Qyq6v4ycYOr8z7T82Ng3IU88Po6El8wnvV5AUwkd84Yw/UwWMbX?=
 =?us-ascii?Q?fnq6sjkEDgUdda1MxIiTjWT73pwKLK1ycZI6zKVF0MOnwEFl3aA6yyIVfP6G?=
 =?us-ascii?Q?MrSY8NDYQVQ85jaLnRTrtRyXo0MpQHT6BPPrsnOVureAqYsMEktzORBGuV1W?=
 =?us-ascii?Q?wVhcVRXqHkH750Qa6Vwip6b/pYcOHm+8NMGQF4GTN/mL/C5g7/xzhpXoDgbA?=
 =?us-ascii?Q?Itqqpk0XdgWvPKMionwS2S249HGB1N7cKqZ2+4Y7XenQ2ilzKejdKhCHVtuz?=
 =?us-ascii?Q?MINcwcCm0feUkTqT1jzZIQbO4NDmzpW184ecYcotgJg535VCpiqC6M8NS+tn?=
 =?us-ascii?Q?RLfr8eR3BKBeGCTu7XrdBUb58G4veYGYitj9GdQhAK4Z8JfZmyxdEUIiFRbk?=
 =?us-ascii?Q?YFhR39PBb2AwEhejO6wSDma3HA0PIBUFQde0ana+jJJNpaHjvQYqhvxKsqZy?=
 =?us-ascii?Q?yWs8tAzWCCgkdeQZjb189Tpfc7fsckDmaaEzEhxcRE015PJCKdB28AaUr0bW?=
 =?us-ascii?Q?80SXVRhYn89VTKIlMtDfGkxSEJ16vdLrymwMwRDDPc0FGdKbyYZm30cKNmIK?=
 =?us-ascii?Q?jvH0q5dUK10FfXOk7RtfXm8R3eD4y6sHSI0wMwvkq3shSnimU/Gri7lZ3nDM?=
 =?us-ascii?Q?4WhJXzsmb/Esk7DrObydED65Sh+6RS5cRattfkk24xOW3hvb/G4PN4uDCy04?=
 =?us-ascii?Q?0BzQhKGceQhCPoVWIfX+x8tp8Ddi?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:32.7552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d46a8b4-a22f-432f-c235-08dced04661d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9063

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, num_retrans = 0 for the first SYN/ACK and the first
retransmitted SYN/ACK; however, an upcoming change will need to
differentiate between those two conditions. This patch moves the
increment of num_tranns before rtx_syn_ack() so we can distinguish
between these two cases when making SYN/ACK.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/inet_connection_sock.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 12e975ed4910..cf9491253ca3 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -906,10 +906,12 @@ static void syn_ack_recalc(struct request_sock *req,
 
 int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req)
 {
-	int err = req->rsk_ops->rtx_syn_ack(parent, req);
+	int err;
 
-	if (!err)
-		req->num_retrans++;
+	req->num_retrans++;
+	err = req->rsk_ops->rtx_syn_ack(parent, req);
+	if (err)
+		req->num_retrans--;
 	return err;
 }
 EXPORT_SYMBOL(inet_rtx_syn_ack);
-- 
2.34.1


