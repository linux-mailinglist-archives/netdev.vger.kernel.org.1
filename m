Return-Path: <netdev+bounces-252821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHYWEtNfc2ngvAAAu9opvQ
	(envelope-from <netdev+bounces-252821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:47:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D050875591
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A888C3057490
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0315366079;
	Fri, 23 Jan 2026 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VNLVX/0J"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D33502BC;
	Fri, 23 Jan 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168372; cv=fail; b=oV8gAlE8pZL/ZXIPQ+U24cn6zrtjH7nADvNrQ2qWWsbLuP0OKBKdDDPcZ9lU91Gp9s4dHNWtvOy9mILsPGCx+jIC+CQPdE5sxfaTy1DHMx2RCkfYAV1yX64EHrQcq5uL7l576t9g+0OIvk5R5W0M34VQk1FJYeL+hfS2ac0N8EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168372; c=relaxed/simple;
	bh=Wue2EF8754bWuVPR+BEPYvsamEEEVQCbwORFcFaILpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZaITRe8Ajp1L/FFgvxtHB3EPDc2mqF/SO5Ye49mXz0aAaqzbaBbDxBGnxMIX86NFgjf/sDczaZI5n4ZKnHHMC7DegzgpO5NYpZhCimFA9pqCXIfB0K8hnbnuQzhe5t+2A2n1mz2sYJ6Ir1MzyAD88/+DVh3C3ASa09bvKg7YUdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VNLVX/0J; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcksqD5oh3aDL4yE+Eang7vANMwGbHuRxSvgEnkxKsX7jLDPu0L9/wO8Fte0RIjjnB5/1RPOepe5H0eJbZ3ULKD8T2yaS1r4yGQoY+RGGccscfxjpdpPIneFp8S5EvsHHz74RYre70glGUqr+ZuxWIAdrrTjVnVKMwSONvFNjZGSIKWfleWgSMRJr9+fxJS92Ew+RklS0W6NNyrTXYf1mS2Rq8+3+s2u6Og8FXkknTls0j3O9FewDyMq7lq8Hy0FsaBqqa3SwqGu40NFkDCAQWzP9JKXz77PzcAXRiKh3C6n6wx5ccYM50j66t6a/T8trjYU8XXaoXQgKL6EuGUlvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpmpr2mmDbczGuE2lKHIphhv136zGQV32KkecDDCxzM=;
 b=nJKx6BTBgqf+Uo0MqYd5HrA5dncKRb7yEo+12mImGfnS5VhoHY3oGlf/Y6XXicl6b520p7fxmVaYg9n7TYLSxE6gy9zoj/vK/abn3BoQfJFjKat1TaIFQKuCawDSMIexsNf9LaPEb4uMKyaI2a//E8gbkHFfcOmnFAFTMgVn0QPwA8h6El+BgjS03X628NDxA7bZV4vQimcZJyOZjuJQlhXpltR3759HJE3HyZS25T8nuBJ1mPyfaYHIjjwsKLg0CTlMbPBYCmNiKI7lFm70ymVKOvRRmq1Dgi9+fuYgVSfrr4GayHxO1UEkAYE4htQLtAQsp7bwKQnHB1DLIpVNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpmpr2mmDbczGuE2lKHIphhv136zGQV32KkecDDCxzM=;
 b=VNLVX/0J26cw80SkgBQReL/L+jAQIjiGOtnUvSCYp7GI5FfbXZLdNQg6+H4R+Nclvl5UviTiQszEzm4fuRubD4tbplv/3/tamN5oxD/jlUjZwYqFG33e3+tJpmIEk505fLjhnt3sS/DV8+sazqaljqpENSJyjB66mnsqH5Bb0y2zDQEzKVAVM7AP1BIL8XeNMGS5GV8lm4j6ay7rJhlfSwVzAzRx/HUxjX4pH+L9titcBXkY3QOStXc+quSukvLjQgDn6up9p8Tr01mdQ47UdaQMUXyeD4T3tHKNN7P2KiB6yUW4th9ZGGfao9yQEmwxT+M6A991e4FEtgNNrUD/tw==
Received: from AS4P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::23)
 by AMBPR07MB11396.eurprd07.prod.outlook.com (2603:10a6:20b:735::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 11:39:19 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::a0) by AS4P191CA0051.outlook.office365.com
 (2603:10a6:20b:657::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 11:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 11:39:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id CC62F201DC;
	Fri, 23 Jan 2026 13:39:17 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	donald.hunter@gmail.com,
	xandfury@gmail.com,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v1 iproute2-next 0/1] AccECN iproute2 patch
Date: Fri, 23 Jan 2026 12:39:15 +0100
Message-Id: <20260123113916.43227-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|AMBPR07MB11396:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 86095552-c31f-40ac-fda2-08de5a740bea
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ASNEm7vBRJgvQFzjmOyRgV+2FyJB01Kxr/LqNi2WvOTQE4U7nV/rpvhQTZJR?=
 =?us-ascii?Q?9mkAaVqLchHruRLWYT5HT7Mg0BXNS+CG1+wnVj8Fonp2J9vVwOeRpV2FMduw?=
 =?us-ascii?Q?HLxgBAuGyGyzHQINn7bvTaouFdo9KuuL5FNhds+uP1zWbM60JBoDe20bjfKa?=
 =?us-ascii?Q?3MJp9pEH7xsURac2jeoaMKny55hzOP2ajdQ1A7Y4vLEFoYOEBvAjuhzMSxVK?=
 =?us-ascii?Q?g/Ckiw2yfLeblvGpSEeWAJgvzd8pTP9BTAQigmAlIK7cMYCz8Lh5g9clGdQV?=
 =?us-ascii?Q?NS9lwVn3tUQ4fc3kr0+0Hs1KfgCUOa6hHIvVMlAxOiDW0MiCxhNCwvu4wAJR?=
 =?us-ascii?Q?8esmK8KWj6N4ZsCsrh0XUPGhQ+KZVKsoD2mS4S9YK39Lmh83yFORyma9jB6f?=
 =?us-ascii?Q?fDB9FXC3EuWxojAvjOzhZLOFyr/4A0bLsEIOFBRF04pqLXlxp1kkS1wRhMsP?=
 =?us-ascii?Q?POYhEB6atzV16Uiv+NugVklVwF1iKN5ae1SQa6U2zOc6S4v61ZQLM8uOwStt?=
 =?us-ascii?Q?Q7DfFsPuqIPgTGMDva+84RxYsi1LshQNGbGqpUKMVm9G4sN7oDJn6XwK0w7c?=
 =?us-ascii?Q?levXzZFhPUL1VzRdo0PbZyhCVzvYG0U+lx6pPMqvVaJyiNuPgGHZhR3K87LT?=
 =?us-ascii?Q?AeGx4VTk1N7OPG+h8it99rKxVg5eeWiJb1GaDQcrHxbllUOXSsw6DT1s1ZQt?=
 =?us-ascii?Q?QVmWTiOtWgvVytopRSjUOQw4AIUzchHIA5ZKGu/Ly/Zev2AVdb6n7RkOUUqi?=
 =?us-ascii?Q?kBBcv4quA12rlSDVyc1+oVP+Dnb7jM9Qx/NVX2Jx+aP4CVfEYVb3SsbC48Fl?=
 =?us-ascii?Q?MUcrjl425KshjVZ66MAZD6YMCSCmX/R8MggKRZtb5skiRw+qKQOFEDcvAKXW?=
 =?us-ascii?Q?BbtV+a62nK3dF43Sik7mfmbAhEJC/mcyIDCNMErUpmlL6WYgS7XMHMTnfw13?=
 =?us-ascii?Q?2OaKnsoy2VKBnw0LTTtwRJ6jPijo9k+ZY+CmcTK65CpjAar/UAVUQzsUVTCd?=
 =?us-ascii?Q?pJM7dxsJCdcmpoWOID5LpL6B1Gu6Yu8Yyi56MZrUiCVFVdBPVN8oaiNsfhLj?=
 =?us-ascii?Q?uRMDL0ukXf1cDP7MVzOXPgAEd12Gd9qzKd4tRf//xTnl3Usxb4yuGKSsvQU4?=
 =?us-ascii?Q?VgFa1B1Z8ny4Grtc4iuIO3PdGyunx7cQnatnQB+1hEAMYbBfflK7z5mCsnsV?=
 =?us-ascii?Q?FCBz4/KUm++Dx4iZ4tKlQ9A4HxF7tnjhq04/fDF7oZcmXqcX0UkpBENdsiqI?=
 =?us-ascii?Q?Ii2oLINEWp6BkNhrNN4+Empf0kZQJhaqxx9GOjENKHFsccccjSsUsqajb3Ge?=
 =?us-ascii?Q?MZrsQ40IBSAMxrTWsyN4TeKGbK/EDqMsZNobUs7V4lD4zJjldIi2y/5bzYkh?=
 =?us-ascii?Q?SkciUeGjJ5ZIwniCW/bsYGJg3a8cHgMvykQnRgNIdazDptFdYmsL7NUE3RmY?=
 =?us-ascii?Q?Q8LQClui+36Yj0dGPI0qunEVA4EuFlszCrlf9J7xxaQy4/oF6/LsD8ybhEWr?=
 =?us-ascii?Q?Low+WuoUTQUhoXnOaCQh3oXLyzWRYIUXj5pcGOcVvN23ExLaz3XZKzTRN9iL?=
 =?us-ascii?Q?xKQph3AHsv8sN2or4lhh9fJX3Pwhie3bkVMZKdDkGYMWa1YOOd8G/tx3wWLY?=
 =?us-ascii?Q?BT/I3cEZkZoRghP0uXePa+JEX4fufoEOdiz4djdoGXUNxmdnOEjaL5qAj+dl?=
 =?us-ascii?Q?GJN7OZysGadAU26CsyPyWcyr66M=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:39:19.4895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86095552-c31f-40ac-fda2-08de5a740bea
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11396
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252821-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,gmail.com,vger.kernel.org,redhat.com,mojatatu.com,kernel.org,networkplumber.org,resnulli.us,davemloft.net,google.com,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D050875591
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find AccECN iproute2 patch v1, it aligns with the updated
tcp_info in linux kernel.

Best regards,
Chia-Yu

Chia-Yu Chang (1):
  tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info

 include/uapi/linux/tcp.h | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

-- 
2.34.1


