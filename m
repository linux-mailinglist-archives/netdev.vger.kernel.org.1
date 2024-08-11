Return-Path: <netdev+bounces-117538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB7094E3AF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 00:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6182C282023
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 22:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5015C139;
	Sun, 11 Aug 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="vCDr6Fnr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2138.outbound.protection.outlook.com [40.107.247.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EA18E06
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723415502; cv=fail; b=qTdGsj7dyOAvsqbxw1gn5F8YishS+ACaZmOl2eoervFZhXF//ABAu4gVMfdCwpXPEnY5SSCdrTl4KreeNxulZr+Alb25uhTTTdZT3tHBHP7VnGu0BSmKnnqLBN8SFd+n2jjM82aoBzLpskyg4kusR2x7o2AzGWn2Fne7hkC8XCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723415502; c=relaxed/simple;
	bh=ZGoIOvvCAaKY12YWMasPOLYbCNWsmMAtC3qoxM47+e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGe9nup9IX39SB8rfeBjL9FL1e8tFAFuddboZ2CKl8Ns+h8lYfEO947uN2ofXhuFmtZykQqxNKbVCsr0E30vMnX9j4pQQbr26vQD/hEmMnFaOWrB0TkFM3Th3u7wl7Nq0kHv29JA43tX45+ds4Nv3bC4ocVwMgGEjDgoYYLi8To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=vCDr6Fnr; arc=fail smtp.client-ip=40.107.247.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOVqegovH+h/936qdYfU35QI2FfJlqC7d8E22XHYmamh9YZWr53b5P0vQ2DNgea9BqaDW/cRxyhOiD1VHi4gHaCyJVNKcm+sP0efocdILZIEoiW36sC+4sSiNThuJk2zd6Nh9nBWbyYxdRrhJHqrZT32sXxt5B2UoPBbcQ+3s3L41WIAViZG5bXhZ8PSFSToW7Gq4jrlPFBbfrKe+gn2S4/PG5W0s5h5dWxftw4BY33psNz9JkRI3NniK1F+2tqXfw0EBVAnpFF+/hieQnqcFEnnW50ZHhN150hgvyvx8pdDSklxLc/yexoDgv5KlMqFX2XlXqYa8uQ9p4ApxF6rsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVvb1tU1LuMEtRcVouoxWmHbYZ5TlXNeoLghZblzkj8=;
 b=jSPTYfoVMMMzSR6lY6qKoVTZWhq3TJZIT5PgC40N5wxYl55CdOmRMRXRy5RzwToOkAd+uORjvFeky9g9xLrnuQ2x39t6BNPrZrg3jK7tKcpdJ9TX/vXbc1JMLgrQuqiCiKlGsdGC9/vTx+a4syEFNiyytYyY8wgPsv825wNH0geslv3d8CjrZfz9pkQ+Nw7mBfLU8F/KtYpmD9VwFlLsx4A1CvU7p+5GphthIWoKsJALaqJF8mfIahfZy6o4VaFL/Q666fJXVrTnFQMQqtd1d73nszBRgv27D589PHUMKGfLIoHD7uU3MDvnbnN29QZXOxluD7STf80/SeLir+KfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVvb1tU1LuMEtRcVouoxWmHbYZ5TlXNeoLghZblzkj8=;
 b=vCDr6FnrTFgkb7/r1/DjiYnpRJlymtyob+zNfssAv7tILBSEvLnGoQwCnV0pUYdusof/upVYyUl+CyST7QIvBl12YE66XaBs5OgDvDnBucRpCfkOPPbzWm/p7/4oJ0ytG0Yy5QoGaR80QSvINvhdiMoGdbyBu5mA12TbjXgf+5g=
Received: from AS4P251CA0027.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::13)
 by DB9PR03MB7756.eurprd03.prod.outlook.com (2603:10a6:10:2cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Sun, 11 Aug
 2024 22:31:36 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::55) by AS4P251CA0027.outlook.office365.com
 (2603:10a6:20b:5d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Sun, 11 Aug 2024 22:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server id 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 22:31:36
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id E78637C16C8;
	Mon, 12 Aug 2024 00:31:35 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id D50182E47F7; Mon, 12 Aug 2024 00:31:35 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH 1/2] configure: provide surrogates for possibly missing libbpf_version.h
Date: Mon, 12 Aug 2024 00:31:34 +0200
Message-Id: <20240811223135.1173783-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240811223135.1173783-1-stefan.maetje@esd.eu>
References: <20240811223135.1173783-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A66:EE_|DB9PR03MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cbfbef-90bb-43bb-6b25-08dcba555c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGtGY21RVEIwRWtoM2tOK3ZYOFpBOVl2RC90eC9hdjloVCtoOVJrZ2NzQnZE?=
 =?utf-8?B?ZmtUTGUyS1M3cjVXZG04V1preExjZXc0OGxTMks2NkhzWmZXcEk4Rzh3QjVx?=
 =?utf-8?B?UHpmdHlPUUcyVFdzL1ZnU0xrell6QXhPQklkc2JhVC9KU0xkM1pySXRmdmZC?=
 =?utf-8?B?Ykl5U3pxMEFGQ3ovYUJtREN5cTFkbDlvamlTdW1Jb0Q1RnkwbXF4WEl4ZmRo?=
 =?utf-8?B?bm1HdXM0cy9VeklTakRyZXhyZEJkNkoyenhNdmNycUEyOEdqZGpUeGRmbEVV?=
 =?utf-8?B?SlZsVkRZa1A1VW9sOUQzTFdubWVMTzZxelFwYlhyWGNJRzBZOEc5NFd4L3Jk?=
 =?utf-8?B?TDFhWXJYVVFKanlXeXFKVVlQeHBScWY2emJEK1gySjVObXYxSGh6RzkvU1pH?=
 =?utf-8?B?cnEwS3VQTHRvS3IyWkFxRjI4QzNOSHdYVjB5SS9uLzl3UWFmQzdNMDY5SFR4?=
 =?utf-8?B?NlM1Q2NMU2tLQnl2YlFYOEprenFjT09ERTllWXRGWHhScmFXa0J1dGVYeHl2?=
 =?utf-8?B?bERlc3N6VUoxOG9SVVlsQU1Hb2hXMTA0K2Y4cTFnQzFWb25nK1JYVGpHWGpX?=
 =?utf-8?B?VGZpSmoxWXpucGNZVEo1Y1ExYjljZUN6L0p0RXNuL2IyMy9tSVdRSVFmTU4w?=
 =?utf-8?B?b1hUd3dvMjJQVkEyMEV6aGNJN05zdElJeSt1bkhvTDBuczNWcnhhbUx1NkFK?=
 =?utf-8?B?SmZKRHladXRqZ1BWRXRFMmFORFpNTkVzMjZEREhGQW14NHFiM0NKckowWTJo?=
 =?utf-8?B?REZVTjlZM1FMNmtXWGxSYjQ5aDlqbndxL0JrUkd4K1JhT05zMFBKbnlaYUhm?=
 =?utf-8?B?TE5tbG5SU2VQTzdHSWgrdy9INVdYYlk1RTZ6eWtkbHZjZGwzNVg0VFNRRklX?=
 =?utf-8?B?cmlyaUxxczlKS2s2OW81ZGMwRDRTdE8wTHRURWJUQW9FNmwvZVZwVmVPemZi?=
 =?utf-8?B?YUt2YTNpUzVmZUlZS2U3SVlMZjJnZ0Q3YUFYZlN5UE9kaFhoZUIxN1o1bjFQ?=
 =?utf-8?B?S3lyaEZLNEU4Y0VoY0Zid0ZXZ0NSTHJaZkhhTWtNRkdQQkhTSy9LZlNvS3dH?=
 =?utf-8?B?TUxKcXlIOGtrNmp6VHV1WWxYZHBCTDV0MW9WS2xrODVCbUZ2MzY2YzRrZ2c5?=
 =?utf-8?B?QXphZ0lBajZmdUpRUTVqMTdFK2VVMzQyQTM5eUU0eURMcVhFM0ZCL1BvWlM4?=
 =?utf-8?B?SFVqV2czUmF5cDI4S0grZ29kOE9vL3hqMzdrVEtXSnJLODVLdEFySjNCTk9m?=
 =?utf-8?B?UDIwbWdObDJNOVRMNEVvWVRGb2FXdjFlcWNSMjByVmQwNGZLZFFwOWN4UytB?=
 =?utf-8?B?cXlBZ0ZnRzJNblFESXhPSG9pSThhU3pvblpwT3AvV2lVaGZLbWttajV2OFJW?=
 =?utf-8?B?b1pwSW43aGtUT0FQdTM3Y1JjRXR0MFB3SUlMNDMrUmZCVFFLSlh2bnQ5aTRa?=
 =?utf-8?B?T3E2QVVUdWNOREN6V2E0T1YrWUlkb3BxcEZjeTJuR2h5bkdRaE11OWs1VEUy?=
 =?utf-8?B?d3k3MkFYeUNJSXRXVy9GKy9jL3hLN1JZRDExQ0dwQlFMY3g4RlBhbnRVV2wz?=
 =?utf-8?B?VHhleFBKeWR2SDJmSTVTMEJuaVE1SzNCOGhvRi9LS0drYnlFVlJ0VmRWeU15?=
 =?utf-8?B?UkxWL1VVUFpFZEp4Zk5PY01hTkdtN2sybm1PcGg1ZGdoRlNZbU8zbjRMNVpw?=
 =?utf-8?B?eElndVlGclJyUmVNNW9sNjRoR0Q4WGh1S3BuTzNQek5hRml3eXpoVytEdFAx?=
 =?utf-8?B?ZE8yMnRGUnBsVjFreXhpaVNQdmhTUXEySUpCQVBRRTcwNEw5OHdRNkNqU1lP?=
 =?utf-8?B?L1ZxcFA5azdaZXNYdXdRcnhVVjM3OFltSzUyNWh3YU1pdmFoYXlMdjB1VDN0?=
 =?utf-8?B?dysrNFFEcVFCVUhRSlNZNGZBajBiYUg2MnZVRjF5cFJibDJPeVFPSVkyWnZS?=
 =?utf-8?Q?zLWCkA/sTeHNMGKugflqxyMlCo91nK0v?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 22:31:36.1371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cbfbef-90bb-43bb-6b25-08dcba555c3b
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7756

Old libbpf library versions (< 0.7.x) may not have the libbpf_version.h
header packaged. This header would provide LIBBPF_MAJOR_VERSION and
LIBBPF_MINOR_VERSION which are then missing to control conditional
compilation in some source files.

Provide surrogates for these defines via CFLAGS that are derived from
the LIBBPF_VERSION determined with $(${PKG_CONFIG} libbpf --modversion).

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 configure | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure b/configure
index 928048b3..7437db4f 100755
--- a/configure
+++ b/configure
@@ -315,6 +315,12 @@ check_libbpf()
         echo "HAVE_LIBBPF:=y" >> $CONFIG
         echo 'CFLAGS += -DHAVE_LIBBPF ' $LIBBPF_CFLAGS >> $CONFIG
         echo "CFLAGS += -DLIBBPF_VERSION=\\\"$LIBBPF_VERSION\\\"" >> $CONFIG
+	LIBBPF_MAJOR=$(IFS="."; set $LIBBPF_VERSION; echo $1)
+	LIBBPF_MINOR=$(IFS="."; set $LIBBPF_VERSION; echo $2)
+	if [ "$LIBBPF_MAJOR" -eq 0 -a "$LIBBPF_MINOR" -lt 7 ]; then
+	    # Newer libbpf versions provide these defines in the bpf/libbpf_version.h header.
+            echo "CFLAGS += -DLIBBPF_MAJOR_VERSION=$LIBBPF_MAJOR -DLIBBPF_MINOR_VERSION=$LIBBPF_MINOR" >> $CONFIG
+	fi
         echo 'LDLIBS += ' $LIBBPF_LDLIBS >> $CONFIG
 
         if [ -z "$LIBBPF_DIR" ]; then
-- 
2.34.1


