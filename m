Return-Path: <netdev+bounces-79898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2486787BF5A
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E66FB22656
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B471732;
	Thu, 14 Mar 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gHd1X5ka"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E971727
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428175; cv=fail; b=COYPRaRWQkk3gtNwUgspbzQMIbDVEBhQn/nuz++d4x9jHIPM6cp2IrmgZFxmBNuncsAkRaGY4nQHwDlvbyfDS0P9/tPX4KfvCh+Lf1jUPm0IvbF72T3MhYqqWiJMtsk8B7gDaUfG2987gUAFUtRuXSelR2X+EBSmv5yS+hQ5Sqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428175; c=relaxed/simple;
	bh=i/NO8W1DG737OOZDLdoOOtwGo9lD6Joe9FUWRpbtQ8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHKlrWj8NGrwS7xm4FDuNnDS3PvvkhGvIOKJvt8VTz3votKKepA9Js8wcJKTgtbKmDDF0IKUds2kn/xW+xS/Eaw1N0AaNTHn1e7kvVxB+YdUlGitRKXe6wb4fq9Is56AiEE8wK6Q6j2siMegNSldKxDg7ISrd+DUs15TUWeoKO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gHd1X5ka; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFkindI8d8P1o81jGqovGLZgqOpr3Wz38uQRjx5bDEffLZmEgaYKpURU2/RBFisgSnoMJtXAeEDP6KUW19pDSiHMRFHKnwzJZxxuKCMSl4B2YsyHbNN12HgzOs/1q4EuH4skT1SXVOjhx+yRRckXk8LSkjfNUnp/zwoIqeimP3gd9LmmR/h8+9EY77SP6nrgFRCN4sUVj7+tQmZOGxV/6m4CyFGsu+sBTQy6GfWrWaDByF+39pxZMsQFPb/sfGo/qktEp5Z74FpYyY5McXg5piHleYlr2r9OFjsG/znqGlaAzMnf8ibXx2gq45e6LAgXzGob5vnAyf+WSduOUfnwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJa0/2F37+kKdHvMNj19xbSetUARlU678Vf2mPRywZs=;
 b=EqBqYx5+VpNdBggRm7cBvzkQRrKjCeXR31YTQETrTDGiOYIk8au9YqWRU4LC2gqTIUhWMGvhggt14X4KjMdruIDsYe/fvlCRBgTnoSFMSygQ5BsqSXiM/p2Ilqoo4LFEa4Dh+7leTAxqr6lifwknucmK06yGVxSObHwK0Mk8OeQ8ilkrk2cuCojlhL82GXFpuFngMYqSZE/PHjXARd01vlQZjd7wiYeCeKzdfo/0xEEKzCjcatk51sC+ds5UU6XHPjjGTatP2PPio3KXmJ0HXHH/D8EDhh+Wctp64AY//uQ6ny6Z0LHbHcB3cYM5AqFsfUZAjOKdMD9Qac2NBX8MCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJa0/2F37+kKdHvMNj19xbSetUARlU678Vf2mPRywZs=;
 b=gHd1X5ka/jjwB6fI4F1gPh2DfiaAIkWhQ1byrLlFMHfMUHvPQUNoTEswuhLN5vsNPmA+HIjROZQyiqAGeBWM0kEp8C3M0NTPVk5IJ+/ATCQQGtdJXeLbHyjnUhi6uWBBU8PSKg2Roes7io8CwTRqzskwD3WqVF1R9V49g5/Onwr8WJE9t/OQWv06zQnRIJozn/09aBbduW0sO5kHfZbEUZ45KSfjEEboZh12qHJHC0q19J/9rDDDWZLO8qq+b45DEgGQrupe/toeeUTtVSCGlLQlCQsofojn+WpAyh1+J1jGq+hZrv6jKSZ1YH6qpNapZkMdpw2qatNqeTr4jTZVIQ==
Received: from DM6PR02CA0074.namprd02.prod.outlook.com (2603:10b6:5:1f4::15)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 14:56:11 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::70) by DM6PR02CA0074.outlook.office365.com
 (2603:10b6:5:1f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22 via Frontend
 Transport; Thu, 14 Mar 2024 14:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 14:56:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Mar
 2024 07:55:56 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 14 Mar
 2024 07:55:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH iproute2-next v2 1/4] libnetlink: Add rta_getattr_uint()
Date: Thu, 14 Mar 2024 15:52:12 +0100
Message-ID: <e48770c7fbf45e14b2bac182d4083f56e02b7805.1710427655.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1710427655.git.petrm@nvidia.com>
References: <cover.1710427655.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 42485a29-ecdf-41f2-c946-08dc4436e395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApTYIO/RndL/QDuiVSnm5Ehs/5yYCwqskZJ1m1lmG0/65QCNweGvTNdAedNNJfg5VbKJh0Uw8GJagpMTXW3RfaS/507XpGYEfefhxupoBt9Okb4hFGBbgDKb3AUeAY4HVuDS20eM/qqknCpnP483v7Oj2UzFY1mXZWaNOCG+EELJZqJTWNtbNKj5prwVDHASZTMxKkfoDt3XE6qs7wsn2L4omgE4uLb4R9xav/wdcfL/20DWGt8a6+Y5lOAvvmkwua+GCK6g3CmFy6n3EI55PlA3R3YA09X6NveSXYxFhWSKMIPFzn5nrEiAptjzkf7pbhvY0aBgnetyOhOmbx1ZPGDodgkv7yilLXMvwFV+ZiPp0mv3MmoHSPwXiiwLVTCIQRPOvl04dxqHREsvKYdp4ZXtkfayKLEZ20RVPpd44cR9yxiOeTpiQM+04edM7IXt2CJoDBumR93pmAmulmsLx3qodhqugrkI2AyfcugiZCoS22jQQxbxpX6aKmOYehsdhYPR0xKt0BlMpbOoAingE9SwFZOU3rR6Ci6TM4MmNUb0RKfg7hXBkpjku9AWX8Ov4oGsrYkEwHLsXECtzZOM7qA+EP0h/A6SL3k77cDiC1rspcWTEAwAjkGYbAVuNjDeWUVpjTHfDadOhIzf30F+H6rkhT21Ki66XE6Q6LaX5T/P8mU8+w9BwlzBnAsd8YBguLGguviILbGrCN5PLUA9pRkRLNFh+alxBvs59APrqGXJQbttC0MdzN4yDXi4AV3p
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 14:56:11.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42485a29-ecdf-41f2-c946-08dc4436e395
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708

NLA_UINT attributes have a 4-byte payload if possible, and an 8-byte one if
necessary. Add a function to extract these. Since we need to dispatch on
length anyway, make the getter truly universal by supporting also u8 and
u16.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - have rta_getattr_uint() support 8- and 16-bit quantities as well

 include/libnetlink.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index ad7e7127..35a9bb57 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -260,6 +260,20 @@ static inline __u64 rta_getattr_u64(const struct rtattr *rta)
 	memcpy(&tmp, RTA_DATA(rta), sizeof(__u64));
 	return tmp;
 }
+static inline __u64 rta_getattr_uint(const struct rtattr *rta)
+{
+	switch (RTA_PAYLOAD(rta)) {
+	case sizeof(__u8):
+		return rta_getattr_u8(rta);
+	case sizeof(__u16):
+		return rta_getattr_u16(rta);
+	case sizeof(__u32):
+		return rta_getattr_u32(rta);
+	case sizeof(__u64):
+		return rta_getattr_u64(rta);
+	}
+	return -1ULL;
+}
 static inline __s32 rta_getattr_s32(const struct rtattr *rta)
 {
 	return *(__s32 *)RTA_DATA(rta);
-- 
2.43.0


