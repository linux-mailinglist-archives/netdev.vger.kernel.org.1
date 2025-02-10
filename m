Return-Path: <netdev+bounces-164624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F0A2E7E7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB4B188A0C2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD91DC996;
	Mon, 10 Feb 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ME2EaJAx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794F1D47A2
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180061; cv=fail; b=HRPoPxftLvrAd1IdOlF9lH+LmOUUsxmXLehmhUxUtCy0usPTK+ooRlqd0jgZCfRYTcxgW/5ioOdKZDwrAiWZsTqzZ0x012nkfoA0XbHnNybRbnb/qE22vKadffikTpEbkc4Y1yLgG+YHCaEvuMFCnWKfwRVEGKd8+w8TvAGHnCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180061; c=relaxed/simple;
	bh=8NW+4vAFO2RmdX9YOUBs1R1zjBrxSH+29vCnxfTKgnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2gcEHmIu+a5+93GaFtWWPF+TZiBxublNLPhGIvge6YGhz7zu5NiHSmf+xodQpDUW4mcq/I2+0NZHQCUl3sxsDpJQUnq74C3JHE6t9Jpy+QTUOR+aNPEu6RO9NS3G2XxAUoLcwkQcRjZzQZH8ibjvDNNN9hownNwvaHo5IrZLVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ME2EaJAx; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmJQB9qPr7/EMgmDMI5oNOb9WvllnFYe4z37lHjXNaDCfh/P9smaSJt59y7pl+Rl2etfB0ExfXIKm7Q35+yI7WOMQOqMl+k1ROg3Nt56oSa1vfSVhEOU+8t/6+vSYBifvx603R1f9hFzt93wzGt+rGqZ0qjBq3uAQLxO26n0XmizqbWNdwfMVP27FTDZ2fUd+1XvbFUwuAuVDKq7tR8Dex+4bNMoP6ikQj9dhwK0cFDQPN4ZxmLFoNHZP3/l0iO/7KwlWn3R5SDTb+GfC//NaO8Y9nGFhU2Pq7bkvgB/2SU3zp7wFAwSgzNT40sZunpyZBIki2+AgwltdFprAoVqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flgMndbzxB8GfLOcVd2mlqIAu8B3Wr9IpcHOK4+B9NM=;
 b=A2aBRexN///FEEt78SNCaryu4qAhMhyzF4B2zc3EEvfjn+QBY0T7boE1cBq8XwpzkDMhetDqOV+qYI4cQ/406+iBlU1/v2qfbHRsaJG6LAQODdaVnTCsZpg/j0pncwSec46wOfiaDN8MfnXHisTy4/efI2QTR4Utj9Sct6gVhcDwta4YPAPs0A4qfhx2n++/YRQ4fPjMhFIjcT3GpRWnMuYuFb8Bd49VkQA/1aSwuc0qW5Ueg5xnsJpkpVzqwRRy4e0ZB46KAwleqlAhIsGNYVqIhEp6YAgWL6RUs4wIU1iv65hbBhu1r/4jnQ9L1Z9a4qtM2MVet3QI2+kzKH0h7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flgMndbzxB8GfLOcVd2mlqIAu8B3Wr9IpcHOK4+B9NM=;
 b=ME2EaJAxyr6JL/bz8+voc6qajq1MHTPgKOYzuAdedVdmj4xMZH12Kuv0kvo95hF9mXuPLw5AkaObXAI+fnLjXf/ntKFoLbngr0uALtQkNF2itT2LmAjG+JkRDqLsXpJRAIk3AKMhgc5rbK15rNJgLU6KhrbS4obEIyipOoYDDhk/2UJFIBWqIyX58/Dv2jEmw8Wak4mbs1tWV2Kwcld0icQ8gwTSlcLzMKQ3IU1QEytXJaWI4s0c9nAYSG8Di+CnE6sqD3OQ9NZHNI1TDYBy1ficBBIjX5vRDlpZwg3BQK9QLAylJCeIpgMUdSBr98AU4W4kgvf3T6IVNbGaL0x7Qg==
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:34:15 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::1c) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:34:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:34:01 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:59 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 13/16] sfpdiag: Add JSON output handling to --module-info in SFF8472 modules
Date: Mon, 10 Feb 2025 11:33:13 +0200
Message-ID: <20250210093316.1580715-14-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6b5348-0a39-4e6b-852b-08dd49b615be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LHDTd4FzPOgqx0uz5F5/yElX680cKU/1t6SjI2L6Uqqas80vsjYzklJNlJDL?=
 =?us-ascii?Q?BbGAMbQTlqH1MRnodSoxjWbx2BnJzUUp69q96Nk09Mfnqk8aV4sOY/OcGlg8?=
 =?us-ascii?Q?fncEoS9qh291QSBc2Uhp0fSbut2VfsUOIuPmU2oz/cEtZ/XXkTOi+o/M+JXE?=
 =?us-ascii?Q?JII3Smfsvp5q+Holv5jIFboz4cBzYc0x8PnH/eAIwd/I9+fRAunBpkTrrgbw?=
 =?us-ascii?Q?Fk5ITznBHtf755AeA4OpyYF5GwTwKp8rh91WJ6PUzYgfMOQzg7+IHzWSE9Dp?=
 =?us-ascii?Q?Hm9qM18bKGkxZBoT3QdpnoFaxbqHksIvd0DRKphZ/khSrxfwpKVb2C9O4uYn?=
 =?us-ascii?Q?mRXeeWPF8Tm15kSLg3em339EuR1ydDAK4iNnb23d93rTfTExJ23SLEAW8c9y?=
 =?us-ascii?Q?tvZhAsYrY3TCBp9oLQ5BrQ5rbt8jfv/f+GcJahR5UjIFilXWDC0cwMXe7JwJ?=
 =?us-ascii?Q?eDPwPXY4MDiFEU3PN21UlTUa/bdZ6Q2uG5RfWCwUWDN7gTMCaWzc08xr06JR?=
 =?us-ascii?Q?ck3AbRvILQEqs5ILMY+gCJv+RRW0OL37u4XAbjazu4b/sFnt9BN/gvDq46oA?=
 =?us-ascii?Q?mWkgy0/A/tF9YHH6Qtf1pbb3vf95teNnb46WKk+dAczhOHmConbx3j+l0X8C?=
 =?us-ascii?Q?3kU8lUcSq6WFeaPIx3kW1lxsQQYyjCg1uHjAObKf3IQNRjka5cFVQt0N6JTF?=
 =?us-ascii?Q?uEtsp6a+EAlOUi5ThXzRLKFXK8+or3pttOrUUztror5JXdVMb4EJeRWoWinA?=
 =?us-ascii?Q?SiW04qWh3RIWEqLvpYszc0y7xFhCmfQqN9/E8J4l4pdnAfMzUUXbelCt9Dxe?=
 =?us-ascii?Q?DS0yqSoxzMx8qAPRGncgkGQX7XK5fTL3Y5+l1uF+Cw58NNLGkYfrnb70rT2U?=
 =?us-ascii?Q?iRfAyHAIeTNkScGAffAjEUecFRW5IxqLEgLSl4U1+ucisaglB+H2MGxLXle8?=
 =?us-ascii?Q?mv6M8WRkikQTzl0aPDib1XaPz5W8L6mu2Kh36aXFYQurRAYGvWdluUUL8m80?=
 =?us-ascii?Q?fCvI3xIKK0xybNW4+gYEwYbGNkrT9dMfOaedsjZOYc6IWiMNsnptV/VZBlXE?=
 =?us-ascii?Q?EJysbOGVxM6VNfytY/+idQGzEOtwrhijdmWz8nClBT01g7rO8jjR4Zl/t6bi?=
 =?us-ascii?Q?YtKFAmRKgVodSULwFSYRgrW/phpJoJ5wyR3QOgK119o5IxGlE+jwDmIuq38A?=
 =?us-ascii?Q?4soWAG3huyOvhJG9Gd/6Cyy4NQH12Q3MatvuftmD3YkkNdvk7OIvlVfDszIZ?=
 =?us-ascii?Q?OWg4aeRk97a9dSKG30QG3QVKx+/cFC8Rr0xVxH9dUkyCGaPg5o3HGuyWY2RF?=
 =?us-ascii?Q?GYBjp6zusXy5VnCGrgMGqOextszYfjluto94N/JwIfh4h22L00tqiyt/qWMi?=
 =?us-ascii?Q?QGAYeIiH+gAZMe4+GejkEidWNXd2d0GZXV6XVODCuVaE6VPKxSvxQ/6Rp/lG?=
 =?us-ascii?Q?Rd5IZRV+ZBIfWhGI2zKTuoG8pAHmjlPa8Czw8GIpRsZVnBD9q313Q7UdN1yS?=
 =?us-ascii?Q?WQFAUPPbV+A8N6A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:34:15.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6b5348-0a39-4e6b-852b-08dd49b615be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428

Add JSON output handling for 'ethtool -m' / --module-info, following
the guideline below:

1. Fields with description, will have a separate description field.
2. Units will be documented in a separate module-info.json file.
3. ASCII fields will be presented as strings.
4. On/Off is rendered as true/false.
5. Yes/no is rendered as true/false.
6. Per-channel fields will be presented as array, when each element
   represents a channel.
7. Fields that hold version, will be split to major and minor sub fields.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---

Notes:
    v3:
    	* Remove unit fields.
    	* Reword commit message.
    
    v2:
    	* In rx_power JSON field, add a type field to let the user know
    	  what type is printed in "value".

 sfpdiag.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/sfpdiag.c b/sfpdiag.c
index bbca91e..a32f72c 100644
--- a/sfpdiag.c
+++ b/sfpdiag.c
@@ -241,40 +241,55 @@ static void sff8472_parse_eeprom(const __u8 *id, struct sff_diags *sd)
 
 void sff8472_show_all(const __u8 *id)
 {
+	char *rx_power_type_string = NULL;
 	struct sff_diags sd = {0};
-	char *rx_power_string = NULL;
 	int i;
 
 	sff8472_parse_eeprom(id, &sd);
 
-	if (!sd.supports_dom) {
-		printf("\t%-41s : No\n", "Optical diagnostics support");
+	module_print_any_bool("Optical diagnostics support",
+			      "optical_diagnostics_support",
+			      sd.supports_dom, YESNO(sd.supports_dom));
+
+	if (!sd.supports_dom)
 		return;
-	}
-	printf("\t%-41s : Yes\n", "Optical diagnostics support");
 
-	PRINT_BIAS("Laser bias current", sd.bias_cur[MCURR]);
-	PRINT_xX_PWR("Laser output power", sd.tx_power[MCURR]);
+	PRINT_BIAS_ALL("Laser bias current", "laser_bias_current",
+		       sd.bias_cur[MCURR]);
+	PRINT_xX_PWR_ALL("Laser output power", "laser_output_power",
+			 sd.tx_power[MCURR]);
 
 	if (!sd.rx_power_type)
-		rx_power_string = "Receiver signal OMA";
+		rx_power_type_string = "Receiver signal OMA";
 	else
-		rx_power_string = "Receiver signal average optical power";
+		rx_power_type_string = "Receiver signal average optical power";
 
-	PRINT_xX_PWR(rx_power_string, sd.rx_power[MCURR]);
+	open_json_object("rx_power");
+	PRINT_xX_PWR_ALL(rx_power_type_string, "value", sd.rx_power[MCURR]);
+	if (is_json_context())
+		module_print_any_string("type", rx_power_type_string);
+	close_json_object();
 
 	module_show_dom_mod_lvl_monitors(&sd);
 
-	printf("\t%-41s : %s\n", "Alarm/warning flags implemented",
-	       (sd.supports_alarms ? "Yes" : "No"));
+	module_print_any_bool("Alarm/warning flags implemented",
+			      "alarm/warning_flags_implemented",
+			      sd.supports_alarms, YESNO(sd.supports_alarms));
+
 	if (sd.supports_alarms) {
 
 		for (i = 0; sff8472_aw_flags[i].str; ++i) {
-			printf("\t%-41s : %s\n", sff8472_aw_flags[i].str,
-			       id[SFF_A2_BASE + sff8472_aw_flags[i].offset]
-			       & sff8472_aw_flags[i].value ? "On" : "Off");
+			bool value;
+
+			value = id[SFF_A2_BASE + sff8472_aw_flags[i].offset] &
+				sff8472_aw_flags[i].value;
+			module_print_any_bool(sff8472_aw_flags[i].str, NULL,
+					      value, ONOFF(value));
 		}
-		sff_show_thresholds(sd);
+		if (is_json_context())
+			sff_show_thresholds_json(sd);
+		else
+			sff_show_thresholds(sd);
 	}
 }
 
-- 
2.47.0


