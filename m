Return-Path: <netdev+bounces-168751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EBBA40755
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 11:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3383B6287
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168541FA16B;
	Sat, 22 Feb 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ED2fioaG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2059.outbound.protection.outlook.com [40.107.241.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBBB13C3F2
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740219446; cv=fail; b=qncKhMHbU6dQeIX37/FuEK5U2rAQTqvcmzkxo+O5R1S8vZSPSmCKqtKrP4Est9P+/HUCcb4KojqF8YcVUY5oVRl4UM2laJO24hCyUL99lyguoqlnrw4F/D8wmdnNL4ULm0hhQaLQvLqezK51t7dLaPUM9RF4ddDFLiqjzKaRQZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740219446; c=relaxed/simple;
	bh=PusU5jAabor+qQNfQ0FyhLS5/4GD5Hg1xZ7xVGI0zmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OAv1mn4K58BCVzffL0VjnIGfBGrwCERilPWqnGw7n3nyYALS6SU64NJuCXFVOts+0/odeLJ/GQXCN2LXT4HAJE4j/cJVtukW2orJMQcKtG/GI6kDmuRw4DoU19OuDmkcgoCw8IyY8UA8UivbOKKZ9HBryklL7+HKSthOBy3ZN2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ED2fioaG; arc=fail smtp.client-ip=40.107.241.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QunSd1jvpEqKUcN5hO7cciqFD90xKDqx2Fs6WugeXTz6tyQ1tDhob1YGbyihwCmwI5WZTj396UW51URl6GOC4e9/kFBkBA/s1F09l/4wVKDT7zCxNWBC9Rpinl9Sx7QnoZtNO3QHQEGPNEZ/VPlmmFTL6fCulqYZBQPKT1qGtus6gx2LmP04ANohPl/UAx1PyRv/1Xk9HazdDZIyKPSFUGh3ZPzSYkxeIaRKMXLFViTKhRQc34qHoBLuLyM25huMbsZZPm/hc1g9PVbKLPxQJ7YYOlcQS/Cgn9EwV5AbYaINRzsI8exezlYAbvne5/DF2f1Cjg3zjx3+3C1gACH1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YGfFIXPhD9DPknhEc9WEIchm1WDESwF1a6+zrn6CT8=;
 b=pLTyxUr7ajUyazv6JxM1Xh8BXMKfMzgJFyuNY/yW4fVCEPSMp/p9syyjoBKrr7j7DJPQ0CMNUjILOPxsAo5pUaDhfZW3ZPZphpa5FCk1uxLJh7PuVypWkkk69tS9sVauIB3u+VQKDAqV4KaHWkn3ms/CJcpYJDymoBBdpkWE3I5bgcn/7aYVEffGxnHBs9ePSw7majYSbBxk3pG24b+yBSQOeIB/TW0nNH/JkeieePlLOFOaKq9kUlhHYgQqgOaNBER2j+Sq8KNuEQM/TibYvVqwNxLl3wq6lXF4kY8JakaEgKZDqQ/VkwG6N0jP0MG7CvogPCz/QUDj9yXA2E/HOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YGfFIXPhD9DPknhEc9WEIchm1WDESwF1a6+zrn6CT8=;
 b=ED2fioaG8Nz5Sx0FWlj9c6qyjuo1DyaIp/7Ht8Hy4OrYApFS+iCcXwztyX+dn3HB3GaHzNHh+kGZMFIdB+r9kA8LtLBJ289jZObXu9x2CvFagKCV8qdF200WC1zpXlEeqDj+t+H2sLJ6WKdzJCNx7a96kKCeCyze5bWm+L+aVr1nBGDji8/QiWzt4uimaoXxiaAiquIpWVEQSSN56vFmv8FAGtQ5Sl/3L4lWX/ozCMThMyrH1Gc/AHecykJDSPfAnCZfGDQYuACnFPsBdqybc4UzApRdaa32dnnumNyeuLWYAU4qtkVxXzsyZitcsro7DJnYkzGsnm6TmxPIWwRjTQ==
Received: from PR1P264CA0201.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::12)
 by PR3PR07MB6668.eurprd07.prod.outlook.com (2603:10a6:102:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 10:17:21 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:102:34d:cafe::a) by PR1P264CA0201.outlook.office365.com
 (2603:10a6:102:34d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Sat,
 22 Feb 2025 10:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 10:17:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 51MAHEnM009925;
	Sat, 22 Feb 2025 10:17:20 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 iproute2-next 0/1] DualPI2 iproute2 patch
Date: Sat, 22 Feb 2025 11:17:01 +0100
Message-Id: <20250222101702.27909-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|PR3PR07MB6668:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d03a9bc-e6a4-4aee-4b4d-08dd532a17a4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?88HqUY2VQ1TUhIWt5/mHZeLgROTygTtrQoQDqqWrg/aMnRJH0QOLFqNnYD3K?=
 =?us-ascii?Q?Z19GEJkE09FJX9X70HfH7Qhp3KfDHlEJM61+ZHdVBETm4MOqZkW6LsEGzuxX?=
 =?us-ascii?Q?HZtPFT//5zxkshqao1T+zcn0U3ljqxDQ2AbLr8fpqSWsjQrg6Dlpd9bgL3pN?=
 =?us-ascii?Q?OTx/pSTYki2MK1hpQ/8APetFfxNabvUbi+YOJKKoPrpcxh6Bp+xieUHdSAiU?=
 =?us-ascii?Q?Lv7Ij2kdO/OMJTInkEe8wv8oep5g+TyxwwvSChnhs85iOfor9kNxYDXazvc4?=
 =?us-ascii?Q?BvfHwlY2vw+4ZpnUv2LA8V2UYpSch5gNkQh2XBw1Kn+zh3vOANSBMX0wx0SN?=
 =?us-ascii?Q?p0AAwB6y8/QOPaPsBJ6bhCAmfPNitZ7DXoFFXlJvEtAVf2mwYwaiiuHMJJzq?=
 =?us-ascii?Q?qNO16Be8gdsUPaqri+oc56OuA77dMFxGHUHZOa64q/BtiqZ9pYbV36ui9ksj?=
 =?us-ascii?Q?/3en+HvHEej4TK/ZId6YRapEq9agcHZccBYWE1c4HKA265ngzwIZ+sbne2zS?=
 =?us-ascii?Q?BsmLyWI0sAUY8Mq56ogF+tKwuKivCSshxIFp5v03GUFacDhOgyGg5a4rJ3iX?=
 =?us-ascii?Q?mDpUIhWpGrYDTKNCajFUAWbDMzVXwcduonncAE1gZfxlaGKJqQ9is/Eq7uB7?=
 =?us-ascii?Q?Hi3RoV+ffg9mtq+PCG0CvQ7UQr1MbcvhrTO9bWPRXNN4YIr5cZV32kt9jofd?=
 =?us-ascii?Q?qPGtXic4cniIiAnjbakvKBM3gczm70z/J703u6ISqcvI2wUpOC9gtVU29upH?=
 =?us-ascii?Q?maF+P4POusAkuzf9IOShLcXcar8eqsoC805xDN4RoK8klxxL8hspmnPFJ0ZJ?=
 =?us-ascii?Q?qzWmiCQLmau17Ti0PUiRJ6J6CP9f4mnCdWUptCvb1ujcO93inhCjOuSnlnsV?=
 =?us-ascii?Q?tKVue+Y/Tp+aKPxBpvwpXW5ujSLKJkfnXw8gY0X3KC19n529rvXOlcGa/IYo?=
 =?us-ascii?Q?q+pAtEaAvMtMwFEoKpWh6okpieTVbpnVDwS47j3r0mmn+xnN+CiXAPzvwTmi?=
 =?us-ascii?Q?GdrluIxz4QrQBOigFhkkKxqQ814aju2gFEhuB86bTT22MO0O3qpgYe6sMlGj?=
 =?us-ascii?Q?dsvxu9TM8/s0OvI02S3QMD+zGB4hDq4wKciDWCHo/zC+GCESc3K0HQazoM/K?=
 =?us-ascii?Q?Wa1ebzlOSKk6w6P3TRCJDpm5yBv4E3GhJKmGKnndvq+ruBerbeRBJEoyA3iy?=
 =?us-ascii?Q?aF9ePB15cWUFCmEpsa6Vxjqq/IrRe7lbD5jwx+5HdoJqcA/SXj4U2IfVGBlE?=
 =?us-ascii?Q?pXjVU+1PDI6OS7VxeKSxeP+c2fVD3eWurKkwGq9uXkPJ/8cWLSCNBPbmFM/Y?=
 =?us-ascii?Q?OQxzQSLqwztLJ08N3WEF8uO/LsYRsjlvdznoWHxpLPiCPkSXP1FAqyuurzF5?=
 =?us-ascii?Q?jEmdxuhqRknz3wu8d9wQ+f4RyABf/d41HTiWesVzGLMloCgEkNvFlXB1/BBZ?=
 =?us-ascii?Q?wJpj5pOOctcg51sR2LY5VAKWn+CAyl2F?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 10:17:20.4978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d03a9bc-e6a4-4aee-4b4d-08dd532a17a4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6668

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 iproute2 patch v3.

v3
- Add memlimit in dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update manual to align latest implementation and clarify the queue naming and default unit
- Use common "get_scaled_alpha_beta" and clean print_opt for Dualpi2

v2
- Rename get_float in dualpi2 to get_float_min_max in utils.c
- Move get_float from iplink_can.c in utils.c (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 (Stephen Hemminger <stephen@networkplumber.org>)

For more details of DualPI2, plesae refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).

--
Chia-Yu

Olga Albisser (1):
  tc: add dualpi2 scheduler module

 bash-completion/tc             |   9 +-
 include/uapi/linux/pkt_sched.h |  38 +++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 240 ++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 494 +++++++++++++++++++++++++++++++++
 8 files changed, 813 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


