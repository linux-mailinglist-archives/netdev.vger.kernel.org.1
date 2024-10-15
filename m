Return-Path: <netdev+bounces-135562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8F99E3F9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F08328238C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B67C1F12E2;
	Tue, 15 Oct 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="a55IT0nX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFC41EF0A2
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988234; cv=fail; b=KHDwmPOKLWXHZcKa03gZtkJ85KEMEXlwtk8/mpQ1+4cdqBJG+n3wr7Lu4wp0Aw0nr5DBVS65ZgRrMg0o68+thuW0efIjT+jFgwGPcnQDvlQvlL7L5jbt6DTgClyVzO0u6XckDz4zxZUk79JFzvWjQCRpahRx3njUHmkBfIQSgZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988234; c=relaxed/simple;
	bh=pUaHhC59Cj4Z0dvaLCB5XW/N+Y4wfCBDFoLnGSC8I1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUBrb81TMJRbkMF14YcOkk1x3qvJoQrYO3oGgRcpe/SeGlB4AC6ZFmO7KWQw6toSbNARVTkmaN5WZHhslqU9lJ6CSCpJLqOa4TqOSP/lJdTq0w2xPi3JMdndpVLuCw8ZQx2JeP82gEXKx4mNEdgEKPK2foakDRWq5S+WFWOXLfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=a55IT0nX; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAMHAu3rcgq5NzHeY8rrhv/GYVJBkeg81yS2nFZ5RhSyG5Z65PE5xkZYfqJLIod0lZPMan2EAx0bi7ZXJhFpwht1DzjbXHuEzd7HZEfXIK5suvKUKVf03yNgvGzXhaKwyROZTZPMQZjiJEEatLOr2B6VLi8OZM4flep7HT6C99T6ptr7PqmG0yUUnmoegFIZUmD5nPKB9mrYRxqE521jGNxkNsepUTxa/3CfroFClTBRh9OXYDVPRMTvgNhR0iuegqYf3mF2ED399pKd1EZRFVMPRCq4j1+Rgh25uN+wFZUz81SFJ2IQEWopgsBa4Fd5JghwdvKJWj8vxrHiF8cTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDNh7T6Ap1f/pvurbbNlCmXyYPjaNfCvCL6bLAYthcs=;
 b=qk2tqRL8gL1V13RhLfXEKuYgA7LZUjoLit9y0+yvEREOxX8TGKla29W1MeVZOMj0JustxBKM+OHVVYioYcg5Yd9vHjImtiy9F0XFEDf6trLSHOjJqMxvM1Y0fqXo9i1zdYN/B/5DDI/ybLx1cIUOsydDSX1abyhl/Hd9Fcwo8s0vzet9rrF4fACmieKIJLn1X+t38QahB03PARK7N7aNuZX1qfsIe9UkH4FfmR6skEPv/XRaeAfakR/F9PuSLe9kYR2Bv/ueAKe5YIZfmnjvc239aCTqhMg+lW2sXKs2T/Jh1guzR5/L6rjhQxD2WBiCApSs/IfR85VT72SQoH3HzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDNh7T6Ap1f/pvurbbNlCmXyYPjaNfCvCL6bLAYthcs=;
 b=a55IT0nXVYxRVixe9Lu3gzH1B4xOPr2z/Z+IB1wRUhR6ao+UtBQuC1O2crFscCNEjyEB4FUkSw7+Ci+CCOArO1aQpXi1Ql9TYzqbxRWmRmEBnSk2RwIlj/CdZ6ybAIWut8YXYp9ERYj874aAXxgXGEsH8YD/BkmM0c+3FnLffAsSYF0cU4b00VH/DB08Na1KIH9SRZcIk/Odw9UnIQj+wXiMdhBRa5efT9bjrNkChEwZUw9lXA+GK5MUfPSuW9rtDFlFddGqV+q+79V2+lYbiyTh3p5uuCIYHoiYhwxg8YWWI49ZTnhVJxLVq1v3i7x6gHDn40ST/p484rO7crEGTA==
Received: from DU2PR04CA0292.eurprd04.prod.outlook.com (2603:10a6:10:28c::27)
 by DB9PR07MB9391.eurprd07.prod.outlook.com (2603:10a6:10:461::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:28 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::3c) by DU2PR04CA0292.outlook.office365.com
 (2603:10a6:10:28c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnV029578;
	Tue, 15 Oct 2024 10:30:27 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 27/44] tcp: accecn: try to fit AccECN option with SACK
Date: Tue, 15 Oct 2024 12:29:23 +0200
Message-Id: <20241015102940.26157-28-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B92:EE_|DB9PR07MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3738c9-f5f9-4cd7-c429-08dced046379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmpid1FQNUtpZDB1QlozMDc2M3JvZXh0UU9iM2NQTTJneGx5YW1iRndpbzBD?=
 =?utf-8?B?eDhzaEJJbEhwVDBNWTh6UnZKbzUrZHcyb1VuclEvbHhMdzVydmFibWdEdTNQ?=
 =?utf-8?B?Nm9uamg1UVhJaUJpN3JnVFpXbUZTRVY0Y3NTM1JzTGZlOTZHd09CcFUyZEh6?=
 =?utf-8?B?WjRjMkVOUHlGbU5teWcxUFFTRnZaQk40SUtnTDlCRGphU3F5Y09ueWovMjlz?=
 =?utf-8?B?ditCY3JJUlNVcEVaOHV0bG1EUHh2Z09xU1g2NWxYOVhxVythaWpmNWpiWXBC?=
 =?utf-8?B?TXBBWXB5cW53RmN3Q0xpdy9sYlUvaWhBdlIyM3g4QTZlWGlnQU5ZamhqaUhM?=
 =?utf-8?B?ZkJpVVo1R2Y1em05OVlxU0p3MTd2UW9XZ2xLeGc0cERUWk9SQ3JRalo5R3Va?=
 =?utf-8?B?MG41NTlnVmg4TWZNN09BVW1hTExQR1hQeXliUERVTVpoK0gyN0hGNTJKc3hF?=
 =?utf-8?B?QkZSdDA4NEh0Y21KdkpzTEEyNytEdWhLZ3N1QkZ1cVRiVFUwczJSNkxZYXVj?=
 =?utf-8?B?eVR5MkNwbC9tNVVRZVdGSTBrZlRSWVB3SjcrN3VHVVl3SzFnZlJhT1E0V0NT?=
 =?utf-8?B?akJXMEFrT2g3Q3NCc0RNY3VGWE5uellzdFZoMlp2SnB6cnVVc3djQmw0NmJ4?=
 =?utf-8?B?eUcrVjRyUlU3ZmxNMEtBdVE3azdkMTlESUtrSmlHemRTeG14NmpMUFJQeUsy?=
 =?utf-8?B?QnBGSXFSVmV2eU1wdy8rNmNWOW51YjR4T3Fxd1VJUGNHdkVBQkRtck4wUjRv?=
 =?utf-8?B?bndQc2dLa0hvZktwekxZTGlSMWRjUkphVUVtN2Z6VkdnOW5OTlQvRUpmTmRV?=
 =?utf-8?B?K21RNHVZVmNVUW0yS3JmMmdURU0rNHZUL1lOQldkR0FLUXZIbGlxa2E1bXpn?=
 =?utf-8?B?dmh4S1phNW9tdDViZ3oyYllrVEJvbXdhZnZZM2lraVRwblhNeTVUSW9iK05R?=
 =?utf-8?B?ampiSEhkanBjUVNHaDZSVElJYytURjNVS3ZNc0ozRStoV0l1cXR4cmdtQk1a?=
 =?utf-8?B?bkNSQnlQUTFZb1JhU05kdnBqNGFFMyt0OXlXTWhMcmlSNTRqd2xWQVQyOGRH?=
 =?utf-8?B?UDVEZmhONzc0N29uNEpxVjhoYjZDTU1DKzAwcWtrdjNZK2trMFd4bHczM24z?=
 =?utf-8?B?MG9pYWwyZzNBc3ZaRTNvdThPbXJpSmtJKzdwQ1NvMmxxSHZaMEFNdU1GejRS?=
 =?utf-8?B?dVcxTHpldlNkeFNFY1JrcUQ4bWZzYldCdXV1Rk1qVVNvdjNXQ0xXam5JT0tT?=
 =?utf-8?B?Mm9tUWt2YVcwa25OZWRPVlJvMjREc0NLclhHbEdYRWFVaysvMVRweU1iWmd0?=
 =?utf-8?B?cGM3VHJyOUNKUi9ZakswOHdnQ2NaWmhmS3dwVnhEQitzclJQd3FONHhDSlVT?=
 =?utf-8?B?Smk0ZXJrVklKZ2oxRWlKblN5QjJkemc5a1NYVGlEM0FPcnBzWkZIR3VvQXBJ?=
 =?utf-8?B?dE93eEV0VHFrOEJMMXJZMUVDSzQyZ3lNazc4UDl3SFllSEovQlUzS0VmM0sr?=
 =?utf-8?B?VnhhQkd2L1Y4Rk9NZkIzcUZwcGwzQ25NY2pycXRwangyM2hyTVBSY3gyaTN3?=
 =?utf-8?B?ckRQcThoM0Jrd0sxdzBLbHN5RGZvKzBjbUxlVjNYWGNqSEliUzY4cUdmQ1Yx?=
 =?utf-8?B?N052MTdWbmFZTHFTNnBEeEJVSUsyL25XYmhsb2I1ZGN0bDRTQitoeDE4TjBk?=
 =?utf-8?B?a1ZKUStZVlUySHN0NHpyVFJMMG9hNDV6ZWRiRnRpazhNQVk1UVhubCtDem5o?=
 =?utf-8?B?OE84NWRuVFlKSzlMdW5KY3VSc0wyd0hkd1R1NEp4VFpIRTFIdjlMUS8xY3ZT?=
 =?utf-8?B?bU1xMTU2b2h3ZU5CQ1lXNEV6Q2tJTWxDMko4WXBoU2pROUNZNjVXUVRCcXFK?=
 =?utf-8?Q?FqlDczyYGKwRT?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:28.2625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3738c9-f5f9-4cd7-c429-08dced046379
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9391

From: Ilpo Järvinen <ij@kernel.org>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and try to fit AccECN option there
by reduction the number of SACK blocks. But never go below
two SACK blocks because of AccECN option.

As AccECN option is often not put to every ACK, the space
hijack is usually only temporary.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ee23b08bd750..663cdea1b87b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -968,8 +968,20 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
-	if (opts->num_accecn_fields < required)
+	if (opts->num_accecn_fields < required) {
+		if (opts->num_sack_blocks > 2) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			size = tcp_options_fit_accecn(opts, required,
+						      remaining + TCPOLEN_SACK_PERBLOCK,
+						      max_combine_saving);
+			if (opts->options & OPTION_ACCECN)
+				return size - TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_sack_blocks++;
+		}
 		return 0;
+	}
 
 	opts->options |= OPTION_ACCECN;
 	return size;
-- 
2.34.1


