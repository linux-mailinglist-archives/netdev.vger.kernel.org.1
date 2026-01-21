Return-Path: <netdev+bounces-251852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLeMLnK9cGkRZgAAu9opvQ
	(envelope-from <netdev+bounces-251852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:50:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018E5645F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0CFD389DFC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78B32E03E4;
	Wed, 21 Jan 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DgxkBBjk"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973953EDAB2;
	Wed, 21 Jan 2026 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996048; cv=fail; b=mSfn/DvImC3B8wWH8gRP2OGlD6L+JNMYI48LHsFsagsnxz5HBcI4bYCWYyPpoUwDD+TVA0Td9838650DO8xBmZIAJgBD2sUSw58ISXZ8nvbM9CkjrkPcAXc3YyAsf0cyx+6ccRGNHHiXQBj1s90E9GiNlAWwSW5NCF7gB+y03p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996048; c=relaxed/simple;
	bh=run/CdoW3uu4L3DzoK4U5TH6OCy8FhDv1wou/8+pGho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=smj36M4JTOZqMrE45lMTjBGliyfVeJFubBUrfSIFiV3iH4yGqhVho+g31dS4mXJT10qCiH4EDUosHe9DXjr2HbIh3LVcY0t9cz6ximd3sXWvw18EQPSYvJWBw4PMa44mUj9lSWTYNgRUBQYId+jxFOr4l89kM/L4C1a0gIRFDdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DgxkBBjk; arc=fail smtp.client-ip=52.101.61.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dO3qQVAlG4JPK14/CJ/QBSP7jU+FcB8FARFoNY2nmzBq5V2x+FpgMs0V7NJWA9VwOMtiuWS5cL9CNdcfSIGGRZrtO3/ktZqhfUDk5ArXr1UqPOAFtvKMKhiIgU2kjYEpUjqaEcZlOl0gZRxn01avz2PtbxV8F8Jjv8MYFMJEHXQuD2zc3lT+yMKAddbn3/rQZkW7dYih9HdqSqSkY339Zo/vJ+1KYaROGOU+o57kos53ACsdtlcTcOplg6q8JFrhh9Un/doHygr2mOQN6yls6aU+JXDfjczNOxfxvalHhFNn5KgF+sV5EzQCd5AjMLvRS3S9SbOyWiG0xtPdQjJfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdpRSsISAWoQDihRJ5dUnCE3jkBqDYcvPp+msaroLRQ=;
 b=EJI6Ex3SgUfs2q+YydT3GZsIjGmq3s9/wd5qGAAP4gTge2+Gn4q9wdIcds0Ncy1FQChG65k9P06KkADqUGbZtDYhmunhD+zWJgZI0MZCjr0RIHFd/FuqcSXti3R87ZlrjFyO1tLi8FVan344dLAT1oq1EAZI96EOOqAh0jEh1TF0YucppJSDpC74iD0vw0yrObkJdVjKUnzLSsx/x/bEm+6yQxB5ob9q0lmgOcfFL3RmSIokd8zPbDylYGSvGce35c4cpPLe9nmR44tdFHOGvXakEn7bts7xA1XNQkJ0WkTki4N4LvEXdBkXEsRNA9J2TtONl7xcjTUlEEoZRFhEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdpRSsISAWoQDihRJ5dUnCE3jkBqDYcvPp+msaroLRQ=;
 b=DgxkBBjkEyVInPMtYPVTU06V2VsfIegK4iK19jkS7qscKg5J0fUKew8wc+jYHYKlVRxZdxcom1wgeA4BQ2Iuk5iBKWcmtB275PWe8Wu3iU+vhzjRNqGHIM9bScVbvAojs5y8qshisdvOcyJyRayiuGhh5/6zdhSiuocdrld1+O2nKreHIpf1Nf/7zaSVFZi2d+yPRvkY4CCM/Y0zXDroFiNU8IaYsk7z68EKoT6vXuzsvd2dr9khCzywSUB36ageuvXgCCcypR3FenFD4wYwsPXBSow85iShSixtUM2Zbu+ctJv+njs8bx1R6dvmJNKzBjUjpLor9CO9f/hy2TTpKw==
Received: from CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::10)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:47:15 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::60) by CH0P221CA0002.outlook.office365.com
 (2603:10b6:610:11c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 11:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 11:47:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 03:47:03 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 03:46:59 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <idosch@nvidia.com>, <mlxsw@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2] selftests: net: Add kernel selftest for RFC 4884
Date: Wed, 21 Jan 2026 13:46:44 +0200
Message-ID: <20260121114644.2863640-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: c20b7e14-032b-4e58-55d5-08de58e2d2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y5H7NAL3XI6a7JnVFNrsd7vprIGdl88fsB/Zzry8b53iMANDOZ7w1EtkB1i+?=
 =?us-ascii?Q?IO3bi7ZuE+U4PxCEw3ilX3oRjeFNzFvxHlCFaAu6tQ3WWVt+RMJOzXYbyKMF?=
 =?us-ascii?Q?+DZPYpWmAimrlblG6540Ya3RQ83oeBwzt8cjxIGUdw0HM5QCDliEa3EOirEF?=
 =?us-ascii?Q?ZAgJ9mU2uFS6mrxotz25YIRywZ709vAkvv+ztj1Hvf9rEql5OV07aazCNq9e?=
 =?us-ascii?Q?/uwhHzKJZJw/Yvc3r1OfYBNq9Vp+HBfkFMRbAvUx83TJi4GDHLJ41jAe67dQ?=
 =?us-ascii?Q?lbIJ6mRcgDNv2I78/oLk23dLVZGoLguzwix4pHmijV4vQpM95hKz2EC//l4f?=
 =?us-ascii?Q?pdOSM1wyz3ZSHomrIa7dBna24r1hygptYXWOUV3yiVuTQNByXUiUsFqSxnOE?=
 =?us-ascii?Q?iAq3scDz/Zxd4w8FVRYOW2YWJRt4WK6U4ADGo0dD49EDTNzbkHsGC8i4GKWP?=
 =?us-ascii?Q?67tQ8y3xXf2xFBGxKfWYU9SAqeED+jwfAVPkZiqpTTCjBcfYm9DaVhMkW5Rw?=
 =?us-ascii?Q?nz4TG9oxl3GdYFwia8+irx6I4egNSsxFH7ymvzv6V359diu8oHu1YjikTMfy?=
 =?us-ascii?Q?meErinK9C178GAI9VEZ8ds/I6PEbzOeVLm6uBR+PKmvDxRUOyjNKXEtqPQ0t?=
 =?us-ascii?Q?spGWxlnv8yvRdyYPfJ+e2mKPhe1lahdO0O7YvPlxZALUSV8BB+9f8OdNqEz8?=
 =?us-ascii?Q?dBPx6V7O9B4tSUjgtBHK2qcAzspbnTwATdFT06/UnLum6yePXKomx/2eSVjY?=
 =?us-ascii?Q?53rBxM1gmKlfRm0s7ZVIhTr/uFQ41tezb0bqQ+vBfwS3u/89B553QBBV0HRz?=
 =?us-ascii?Q?7kxbYNyQoisePh1CdL5ndgvt2u7OSu349HO3TO2u87MHp4Nd7NQBwOEUXuCL?=
 =?us-ascii?Q?fjFvlWlaZcyiJxelJ/ZVfV+2OlNIlS+EXHlBllg68qydJLFziGjHjtIB3eL9?=
 =?us-ascii?Q?31Jo9zQ7T4lpjU1DNdYHOi7BNGUvWzDog528iarQevfK6kBBo5O6Mcc/JyVm?=
 =?us-ascii?Q?WRTEFGwJKPbtpPkpaFw28CKWDLvte48wNzarOEbjg1r20Pswk/nrc6ivBU5y?=
 =?us-ascii?Q?iU07GkT0GKxmx3ZWiKZbkjFQfQ2SkLBNZlJ87BaMyStJYJC6qiSEjqksRpZ2?=
 =?us-ascii?Q?clJEejA4t3bpKiqGMumDAeKIZIh0ZEUylOhDr96NPaGxU2DfXemXLef36d10?=
 =?us-ascii?Q?myO/8j6M8LXpBIHz73yrU9/v5MIYySW6nqEGZiWac+d3Wz3zKhZ09+HACky6?=
 =?us-ascii?Q?gZcY27QiOmEhvjBB9/Xyoev+aZrnC2XgzKeos2XxnrFmvNIcjgLI53F2ShVG?=
 =?us-ascii?Q?hznM8BiVRQNIrCAVWmRV/hlo+wY2NUnCE2kh1IRmVDSsmgccYrf95qxt5Oso?=
 =?us-ascii?Q?hWgIdz8/4do1cseunHg/oFpsQdBGoxOm+iO7jBsvHaPNp6PtlSe2dU5f6955?=
 =?us-ascii?Q?5k66VE16YRFKR+oK0zrUIimeCbRc3xbok0Pc54Aw42Ks05zbtATnMSnbYWkK?=
 =?us-ascii?Q?UtimYmX+vRz5ocBlg1aXLYfXsHte6OEaPRITkscnIlZqtbt4GQbhIcGb9UoK?=
 =?us-ascii?Q?yEwKQFkXO4LYaD8jVmKmuB7lT5P51Rwk6slVIM4lJn4ziZM77uHQvntNDyfP?=
 =?us-ascii?Q?V8dDYie7XIofI7uBqXpk0ZTXRQzYJSEW+ZwWTJdZWl/4JK1rACCoBn+tKzQo?=
 =?us-ascii?Q?bb5gMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:47:15.3016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c20b7e14-032b-4e58-55d5-08de58e2d2b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251852-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8018E5645F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 4884 extended certain ICMP messages with a length attribute that
encodes the length of the "original datagram" field. This is needed so
that new information could be appended to these messages without
applications thinking that it is part of the "original datagram" field.

In version 5.9, the kernel was extended with two new socket options
(SOL_IP/IP_RECVERR_4884 and SOL_IPV6/IPV6_RECVERR_RFC4884) that allow
user space to retrieve this length which is basically the offset to the
ICMP Extension Structure at the end of the ICMP message. This is
required by user space applications that need to parse the information
contained in the ICMP Extension Structure. For example, the RFC 5837
extension for tracepath.

Add a selftest that verifies correct handling of the RFC 4884 length
field for both IPv4 and IPv6, with and without extension structures,
and validates that malformed extensions are correctly reported as invalid.

For each address family, the test creates:
  - a raw socket used to send locally crafted ICMP error packets to the
    loopback address, and
  - a datagram socket used to receive the encapsulated original datagram
    and associated error metadata from the kernel error queue.

ICMP packets are constructed entirely in user space rather than relying
on kernel-generated errors. This allows the test to exercise invalid
scenarios (such as corrupted checksums and incorrect length fields) and
verify that the SO_EE_RFC4884_FLAG_INVALID flag is set as expected.

Output Example:

$ ./icmp_rfc4884
Starting 18 tests from 18 test cases.
  RUN           rfc4884.ipv4_ext_small_payload.rfc4884 ...
            OK  rfc4884.ipv4_ext_small_payload.rfc4884
ok 1 rfc4884.ipv4_ext_small_payload.rfc4884
  RUN           rfc4884.ipv4_ext.rfc4884 ...
            OK  rfc4884.ipv4_ext.rfc4884
ok 2 rfc4884.ipv4_ext.rfc4884
  RUN           rfc4884.ipv4_ext_large_payload.rfc4884 ...
            OK  rfc4884.ipv4_ext_large_payload.rfc4884
ok 3 rfc4884.ipv4_ext_large_payload.rfc4884
  RUN           rfc4884.ipv4_no_ext_small_payload.rfc4884 ...
            OK  rfc4884.ipv4_no_ext_small_payload.rfc4884
ok 4 rfc4884.ipv4_no_ext_small_payload.rfc4884
  RUN           rfc4884.ipv4_no_ext_min_payload.rfc4884 ...
            OK  rfc4884.ipv4_no_ext_min_payload.rfc4884
ok 5 rfc4884.ipv4_no_ext_min_payload.rfc4884
  RUN           rfc4884.ipv4_no_ext_large_payload.rfc4884 ...
            OK  rfc4884.ipv4_no_ext_large_payload.rfc4884
ok 6 rfc4884.ipv4_no_ext_large_payload.rfc4884
  RUN           rfc4884.ipv4_invalid_ext_checksum.rfc4884 ...
            OK  rfc4884.ipv4_invalid_ext_checksum.rfc4884
ok 7 rfc4884.ipv4_invalid_ext_checksum.rfc4884
  RUN           rfc4884.ipv4_invalid_ext_length_small.rfc4884 ...
            OK  rfc4884.ipv4_invalid_ext_length_small.rfc4884
ok 8 rfc4884.ipv4_invalid_ext_length_small.rfc4884
  RUN           rfc4884.ipv4_invalid_ext_length_large.rfc4884 ...
            OK  rfc4884.ipv4_invalid_ext_length_large.rfc4884
ok 9 rfc4884.ipv4_invalid_ext_length_large.rfc4884
  RUN           rfc4884.ipv6_ext_small_payload.rfc4884 ...
            OK  rfc4884.ipv6_ext_small_payload.rfc4884
ok 10 rfc4884.ipv6_ext_small_payload.rfc4884
  RUN           rfc4884.ipv6_ext.rfc4884 ...
            OK  rfc4884.ipv6_ext.rfc4884
ok 11 rfc4884.ipv6_ext.rfc4884
  RUN           rfc4884.ipv6_ext_large_payload.rfc4884 ...
            OK  rfc4884.ipv6_ext_large_payload.rfc4884
ok 12 rfc4884.ipv6_ext_large_payload.rfc4884
  RUN           rfc4884.ipv6_no_ext_small_payload.rfc4884 ...
            OK  rfc4884.ipv6_no_ext_small_payload.rfc4884
ok 13 rfc4884.ipv6_no_ext_small_payload.rfc4884
  RUN           rfc4884.ipv6_no_ext_min_payload.rfc4884 ...
            OK  rfc4884.ipv6_no_ext_min_payload.rfc4884
ok 14 rfc4884.ipv6_no_ext_min_payload.rfc4884
  RUN           rfc4884.ipv6_no_ext_large_payload.rfc4884 ...
            OK  rfc4884.ipv6_no_ext_large_payload.rfc4884
ok 15 rfc4884.ipv6_no_ext_large_payload.rfc4884
  RUN           rfc4884.ipv6_invalid_ext_checksum.rfc4884 ...
            OK  rfc4884.ipv6_invalid_ext_checksum.rfc4884
ok 16 rfc4884.ipv6_invalid_ext_checksum.rfc4884
  RUN           rfc4884.ipv6_invalid_ext_length_small.rfc4884 ...
            OK  rfc4884.ipv6_invalid_ext_length_small.rfc4884
ok 17 rfc4884.ipv6_invalid_ext_length_small.rfc4884
  RUN           rfc4884.ipv6_invalid_ext_length_large.rfc4884 ...
            OK  rfc4884.ipv6_invalid_ext_length_large.rfc4884
ok 18 rfc4884.ipv6_invalid_ext_length_large.rfc4884
 PASSED: 18 / 18 tests passed.
 Totals: pass:18 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    	* Alphabetical ordering includes.
    	* Typed (const) variables over macros.
    	* s/bind_to_loopback/bind_and_setsockopt/
    	* Add poll() before recvmsg().
    	* Add a log for when unrelated cmsgs are encountered.

 tools/testing/selftests/net/.gitignore     |   1 +
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/icmp_rfc4884.c | 679 +++++++++++++++++++++
 3 files changed, 681 insertions(+)
 create mode 100644 tools/testing/selftests/net/icmp_rfc4884.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 6930fe926c58..97ad4d551d44 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -7,6 +7,7 @@ cmsg_sender
 epoll_busy_poll
 fin_ack_lat
 hwtstamp_config
+icmp_rfc4884
 io_uring_zerocopy_tx
 ioam6_parser
 ip_defrag
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..fe7937dc5f45 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -166,6 +166,7 @@ TEST_GEN_PROGS := \
 	bind_timewait \
 	bind_wildcard \
 	epoll_busy_poll \
+	icmp_rfc4884 \
 	ipv6_fragmentation \
 	proc_net_pktgen \
 	reuseaddr_conflict \
diff --git a/tools/testing/selftests/net/icmp_rfc4884.c b/tools/testing/selftests/net/icmp_rfc4884.c
new file mode 100644
index 000000000000..cd826b913557
--- /dev/null
+++ b/tools/testing/selftests/net/icmp_rfc4884.c
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <arpa/inet.h>
+#include <error.h>
+#include <linux/errqueue.h>
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <netinet/in.h>
+#include <netinet/udp.h>
+#include <poll.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+
+#include "../kselftest_harness.h"
+
+static const unsigned short src_port = 44444;
+static const unsigned short dst_port = 55555;
+static const int min_orig_dgram_len = 128;
+static const int min_payload_len_v4 =
+	min_orig_dgram_len - sizeof(struct iphdr) - sizeof(struct udphdr);
+static const int min_payload_len_v6 =
+	min_orig_dgram_len - sizeof(struct ipv6hdr) - sizeof(struct udphdr);
+static const uint8_t orig_payload_byte =  0xAA;
+
+struct sockaddr_inet {
+	union {
+		struct sockaddr_in6 v6;
+		struct sockaddr_in v4;
+		struct sockaddr sa;
+	};
+	socklen_t len;
+};
+
+struct ip_case_info {
+	int	domain;
+	int	level;
+	int	opt1;
+	int	opt2;
+	int	proto;
+	int	(*build_func)(uint8_t *buf, ssize_t buflen, bool with_ext,
+			      int payload_len, bool bad_csum, bool bad_len,
+			      bool smaller_len);
+	int	min_payload;
+};
+
+static int bringup_loopback(void)
+{
+	struct ifreq ifr = {
+		.ifr_name = "lo"
+	};
+	int fd;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -1;
+
+	if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0)
+		goto err;
+
+	ifr.ifr_flags = ifr.ifr_flags | IFF_UP;
+
+	if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0)
+		goto err;
+
+	close(fd);
+	return 0;
+
+err:
+	close(fd);
+	return -1;
+}
+
+static uint16_t csum(const void *buf, size_t len)
+{
+	const uint8_t *data = buf;
+	uint32_t sum = 0;
+
+	while (len > 1) {
+		sum += (data[0] << 8) | data[1];
+		data += 2;
+		len -= 2;
+	}
+
+	if (len == 1)
+		sum += data[0] << 8;
+
+	while (sum >> 16)
+		sum = (sum & 0xFFFF) + (sum >> 16);
+
+	return ~sum & 0xFFFF;
+}
+
+static int poll_err(int fd)
+{
+	struct pollfd pfd;
+
+	memset(&pfd, 0, sizeof(pfd));
+	pfd.fd = fd;
+
+	if (poll(&pfd, 1, 5000) != 1 || pfd.revents != POLLERR)
+		return -1;
+
+	return 0;
+}
+
+static void set_addr(struct sockaddr_inet *addr, int domain,
+		     unsigned short port)
+{
+	memset(addr, 0, sizeof(*addr));
+
+	switch (domain) {
+	case AF_INET:
+		addr->v4.sin_family = AF_INET;
+		addr->v4.sin_port = htons(port);
+		addr->v4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+		addr->len = sizeof(addr->v4);
+		break;
+	case AF_INET6:
+		addr->v6.sin6_family = AF_INET6;
+		addr->v6.sin6_port = htons(port);
+		addr->v6.sin6_addr = in6addr_loopback;
+		addr->len = sizeof(addr->v6);
+		break;
+	}
+}
+
+static int bind_and_setsockopt(int fd, const struct ip_case_info *info)
+{
+	struct sockaddr_inet addr;
+	int opt = 1;
+
+	set_addr(&addr, info->domain, src_port);
+
+	if (setsockopt(fd, info->level, info->opt1, &opt, sizeof(opt)) < 0)
+		return -1;
+
+	if (setsockopt(fd, info->level, info->opt2, &opt, sizeof(opt)) < 0)
+		return -1;
+
+	return bind(fd, &addr.sa, addr.len);
+}
+
+static int build_rfc4884_ext(uint8_t *buf, size_t buflen, bool bad_csum,
+			     bool bad_len, bool smaller_len)
+{
+	struct icmp_extobj_hdr *objh;
+	struct icmp_ext_hdr *exthdr;
+	size_t obj_len, ext_len;
+	uint16_t sum;
+
+	/* Use an object payload of 4 bytes */
+	obj_len = sizeof(*objh) + sizeof(uint32_t);
+	ext_len = sizeof(*exthdr) + obj_len;
+
+	if (ext_len > buflen)
+		return -EINVAL;
+
+	exthdr = (struct icmp_ext_hdr *)buf;
+	objh = (struct icmp_extobj_hdr *)(buf + sizeof(*exthdr));
+
+	exthdr->version = 2;
+	/* When encoding a bad object length, either encode a length too small
+	 * to fit the object header or too big to fit in the packet.
+	 */
+	if (bad_len)
+		obj_len = smaller_len ? sizeof(*objh) - 1 : obj_len * 2;
+	objh->length = htons(obj_len);
+
+	sum = csum(buf, ext_len);
+	exthdr->checksum = htons(bad_csum ? sum - 1 : sum);
+
+	return ext_len;
+}
+
+static int build_orig_dgram_v4(uint8_t *buf, ssize_t buflen, int payload_len)
+{
+	struct udphdr *udph;
+	struct iphdr *iph;
+	size_t len = 0;
+
+	len = sizeof(*iph) + sizeof(*udph) + payload_len;
+	if (len > buflen)
+		return -EINVAL;
+
+	iph = (struct iphdr *)buf;
+	udph = (struct udphdr *)(buf + sizeof(*iph));
+
+	iph->version = 4;
+	iph->ihl = 5;
+	iph->protocol = IPPROTO_UDP;
+	iph->saddr = htonl(INADDR_LOOPBACK);
+	iph->daddr = htonl(INADDR_LOOPBACK);
+	iph->tot_len = htons(len);
+	iph->check = htons(csum(iph, sizeof(*iph)));
+
+	udph->source = htons(src_port);
+	udph->dest = htons(dst_port);
+	udph->len = htons(sizeof(*udph) + payload_len);
+
+	memset(buf + sizeof(*iph) + sizeof(*udph), orig_payload_byte,
+	       payload_len);
+
+	return len;
+}
+
+static int build_orig_dgram_v6(uint8_t *buf, ssize_t buflen, int payload_len)
+{
+	struct udphdr *udph;
+	struct ipv6hdr *iph;
+	size_t len = 0;
+
+	len = sizeof(*iph) + sizeof(*udph) + payload_len;
+	if (len > buflen)
+		return -EINVAL;
+
+	iph = (struct ipv6hdr *)buf;
+	udph = (struct udphdr *)(buf + sizeof(*iph));
+
+	iph->version = 6;
+	iph->payload_len = htons(sizeof(*udph) + payload_len);
+	iph->nexthdr = IPPROTO_UDP;
+	iph->saddr = in6addr_loopback;
+	iph->daddr = in6addr_loopback;
+
+	udph->source = htons(src_port);
+	udph->dest = htons(dst_port);
+	udph->len = htons(sizeof(*udph) + payload_len);
+
+	memset(buf + sizeof(*iph) + sizeof(*udph), orig_payload_byte,
+	       payload_len);
+
+	return len;
+}
+
+static int build_icmpv4_pkt(uint8_t *buf, ssize_t buflen, bool with_ext,
+			    int payload_len, bool bad_csum, bool bad_len,
+			    bool smaller_len)
+{
+	struct icmphdr *icmph;
+	int len, ret;
+
+	len = sizeof(*icmph);
+	memset(buf, 0, buflen);
+
+	icmph = (struct icmphdr *)buf;
+	icmph->type = ICMP_DEST_UNREACH;
+	icmph->code = ICMP_PORT_UNREACH;
+	icmph->checksum = 0;
+
+	ret = build_orig_dgram_v4(buf + len, buflen - len, payload_len);
+	if (ret < 0)
+		return ret;
+
+	len += ret;
+
+	icmph->un.reserved[1] = (len - sizeof(*icmph)) / sizeof(uint32_t);
+
+	if (with_ext) {
+		ret = build_rfc4884_ext(buf + len, buflen - len,
+					bad_csum, bad_len, smaller_len);
+		if (ret < 0)
+			return ret;
+
+		len += ret;
+	}
+
+	icmph->checksum = htons(csum(icmph, len));
+	return len;
+}
+
+static int build_icmpv6_pkt(uint8_t *buf, ssize_t buflen, bool with_ext,
+			    int payload_len, bool bad_csum, bool bad_len,
+			    bool smaller_len)
+{
+	struct icmp6hdr *icmph;
+	int len, ret;
+
+	len = sizeof(*icmph);
+	memset(buf, 0, buflen);
+
+	icmph = (struct icmp6hdr *)buf;
+	icmph->icmp6_type = ICMPV6_DEST_UNREACH;
+	icmph->icmp6_code = ICMPV6_PORT_UNREACH;
+	icmph->icmp6_cksum = 0;
+
+	ret = build_orig_dgram_v6(buf + len, buflen - len, payload_len);
+	if (ret < 0)
+		return ret;
+
+	len += ret;
+
+	icmph->icmp6_datagram_len = (len - sizeof(*icmph)) / sizeof(uint64_t);
+
+	if (with_ext) {
+		ret = build_rfc4884_ext(buf + len, buflen - len,
+					bad_csum, bad_len, smaller_len);
+		if (ret < 0)
+			return ret;
+
+		len += ret;
+	}
+
+	icmph->icmp6_cksum = htons(csum(icmph, len));
+	return len;
+}
+
+FIXTURE(rfc4884) {};
+
+FIXTURE_SETUP(rfc4884)
+{
+	int ret;
+
+	ret = unshare(CLONE_NEWNET);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("unshare(CLONE_NEWNET) failed: %s", strerror(errno));
+	}
+
+	ret = bringup_loopback();
+	ASSERT_EQ(ret, 0) TH_LOG("Failed to bring up loopback interface");
+}
+
+FIXTURE_TEARDOWN(rfc4884)
+{
+}
+
+const struct ip_case_info ipv4_info = {
+	.domain		= AF_INET,
+	.level		= SOL_IP,
+	.opt1		= IP_RECVERR,
+	.opt2		= IP_RECVERR_RFC4884,
+	.proto		= IPPROTO_ICMP,
+	.build_func	= build_icmpv4_pkt,
+	.min_payload	= min_payload_len_v4,
+};
+
+const struct ip_case_info ipv6_info = {
+	.domain		= AF_INET6,
+	.level		= SOL_IPV6,
+	.opt1		= IPV6_RECVERR,
+	.opt2		= IPV6_RECVERR_RFC4884,
+	.proto		= IPPROTO_ICMPV6,
+	.build_func	= build_icmpv6_pkt,
+	.min_payload	= min_payload_len_v6,
+};
+
+FIXTURE_VARIANT(rfc4884) {
+	/* IPv4/v6 related information */
+	struct ip_case_info	info;
+	/* Whether to append an ICMP extension or not */
+	bool			with_ext;
+	/* UDP payload length */
+	int			payload_len;
+	/* Whether to generate a bad checksum in the ICMP extension structure */
+	bool			bad_csum;
+	/* Whether to generate a bad length in the ICMP object header */
+	bool			bad_len;
+	/* Whether it is too small to fit the object header or too big to fit
+	 * in the packet
+	 */
+	bool			smaller_len;
+};
+
+/* Tests that a valid ICMPv4 error message with extension and the original
+ * datagram is smaller than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_ext_small_payload) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= 64,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message with extension and 128 bytes original
+ * datagram, generates an error with the expected offset, and does not raise the
+ * SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_ext) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= min_payload_len_v4,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message with extension and the original
+ * datagram is larger than 128 bytes, generates an error with the expected
+ * offset, and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_ext_large_payload) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= 256,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message without extension and the original
+ * datagram is smaller than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_no_ext_small_payload) {
+	.info		= ipv4_info,
+	.with_ext	= false,
+	.payload_len	= 64,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message without extension and 128 bytes
+ * original datagram, generates an error with zero offset, and does not raise
+ * the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_no_ext_min_payload) {
+	.info		= ipv4_info,
+	.with_ext	= false,
+	.payload_len	= min_payload_len_v4,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv4 error message without extension and the original
+ * datagram is larger than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_no_ext_large_payload) {
+	.info		= ipv4_info,
+	.with_ext	= false,
+	.payload_len	= 256,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that an ICMPv4 error message with extension and an invalid checksum,
+ * generates an error with the expected offset, and raises the
+ * SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_invalid_ext_checksum) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= min_payload_len_v4,
+	.bad_csum	= true,
+	.bad_len	= false,
+};
+
+/* Tests that an ICMPv4 error message with extension and an object length
+ * smaller than the object header, generates an error with the expected offset,
+ * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_invalid_ext_length_small) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= min_payload_len_v4,
+	.bad_csum	= false,
+	.bad_len	= true,
+	.smaller_len	= true,
+};
+
+/* Tests that an ICMPv4 error message with extension and an object length that
+ * is too big to fit in the packet, generates an error with the expected offset,
+ * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv4_invalid_ext_length_large) {
+	.info		= ipv4_info,
+	.with_ext	= true,
+	.payload_len	= min_payload_len_v4,
+	.bad_csum	= false,
+	.bad_len	= true,
+	.smaller_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message with extension and the original
+ * datagram is smaller than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_ext_small_payload) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= 64,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message with extension and 128 bytes original
+ * datagram, generates an error with the expected offset, and does not raise the
+ * SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_ext) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= min_payload_len_v6,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message with extension and the original
+ * datagram is larger than 128 bytes, generates an error with the expected
+ * offset, and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_ext_large_payload) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= 256,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+/* Tests that a valid ICMPv6 error message without extension and the original
+ * datagram is smaller than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_no_ext_small_payload) {
+	.info		= ipv6_info,
+	.with_ext	= false,
+	.payload_len	= 64,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message without extension and 128 bytes
+ * original datagram, generates an error with zero offset, and does not
+ * raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_no_ext_min_payload) {
+	.info		= ipv6_info,
+	.with_ext	= false,
+	.payload_len	= min_payload_len_v6,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that a valid ICMPv6 error message without extension and the original
+ * datagram is larger than 128 bytes, generates an error with zero offset,
+ * and does not raise the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_no_ext_large_payload) {
+	.info		= ipv6_info,
+	.with_ext	= false,
+	.payload_len	= 256,
+	.bad_csum	= false,
+	.bad_len	= false,
+};
+
+/* Tests that an ICMPv6 error message with extension and an invalid checksum,
+ * generates an error with the expected offset, and raises the
+ * SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_invalid_ext_checksum) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= min_payload_len_v6,
+	.bad_csum	= true,
+	.bad_len	= false,
+};
+
+/* Tests that an ICMPv6 error message with extension and an object length
+ * smaller than the object header, generates an error with the expected offset,
+ * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_invalid_ext_length_small) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= min_payload_len_v6,
+	.bad_csum	= false,
+	.bad_len	= true,
+	.smaller_len	= true,
+};
+
+/* Tests that an ICMPv6 error message with extension and an object length that
+ * is too big to fit in the packet, generates an error with the expected offset,
+ * and raises the SO_EE_RFC4884_FLAG_INVALID flag.
+ */
+FIXTURE_VARIANT_ADD(rfc4884, ipv6_invalid_ext_length_large) {
+	.info		= ipv6_info,
+	.with_ext	= true,
+	.payload_len	= min_payload_len_v6,
+	.bad_csum	= false,
+	.bad_len	= true,
+	.smaller_len	= false,
+};
+
+static void
+check_rfc4884_offset(struct __test_metadata *_metadata, int sock,
+		     const FIXTURE_VARIANT(rfc4884) *v)
+{
+	char rxbuf[1024];
+	char ctrl[1024];
+	struct iovec iov = {
+		.iov_base = rxbuf,
+		.iov_len = sizeof(rxbuf)
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = ctrl,
+		.msg_controllen = sizeof(ctrl),
+	};
+	struct cmsghdr *cmsg;
+	int recv;
+
+	ASSERT_EQ(poll_err(sock), 0);
+
+	recv = recvmsg(sock, &msg, MSG_ERRQUEUE);
+	ASSERT_GE(recv, 0) TH_LOG("recvmsg(MSG_ERRQUEUE) failed");
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		bool is_invalid, expected_invalid;
+		struct sock_extended_err *ee;
+		int expected_off;
+		uint16_t off;
+
+		if (cmsg->cmsg_level != v->info.level ||
+		    cmsg->cmsg_type != v->info.opt1) {
+			TH_LOG("Unrelated cmsgs were encountered in recvmsg()");
+			continue;
+		}
+
+		ee = (struct sock_extended_err *)CMSG_DATA(cmsg);
+		off = ee->ee_rfc4884.len;
+		is_invalid = ee->ee_rfc4884.flags & SO_EE_RFC4884_FLAG_INVALID;
+
+		expected_invalid = v->bad_csum || v->bad_len;
+		ASSERT_EQ(is_invalid, expected_invalid) {
+			TH_LOG("Expected invalidity flag to be %d, but got %d",
+			       expected_invalid, is_invalid);
+		}
+
+		expected_off =
+			(v->with_ext && v->payload_len >= v->info.min_payload) ?
+			v->payload_len : 0;
+		ASSERT_EQ(off, expected_off) {
+			TH_LOG("Expected RFC4884 offset %u, got %u",
+			       expected_off, off);
+		}
+		break;
+	}
+}
+
+TEST_F(rfc4884, rfc4884)
+{
+	const typeof(variant) v = variant;
+	struct sockaddr_inet addr;
+	uint8_t pkt[1024];
+	int dgram, raw;
+	int len, sent;
+	int err;
+
+	dgram = socket(v->info.domain, SOCK_DGRAM, 0);
+	ASSERT_GE(dgram, 0) TH_LOG("Opening datagram socket failed");
+
+	err = bind_and_setsockopt(dgram, &v->info);
+	ASSERT_EQ(err, 0) TH_LOG("Bind failed");
+
+	raw = socket(v->info.domain, SOCK_RAW, v->info.proto);
+	ASSERT_GE(raw, 0) TH_LOG("Opening raw socket failed");
+
+	len = v->info.build_func(pkt, sizeof(pkt), v->with_ext, v->payload_len,
+				 v->bad_csum, v->bad_len, v->smaller_len);
+	ASSERT_GT(len, 0) TH_LOG("Building packet failed");
+
+	set_addr(&addr, v->info.domain, 0);
+	sent = sendto(raw, pkt, len, 0, &addr.sa, addr.len);
+	ASSERT_EQ(len, sent) TH_LOG("Sending packet failed");
+
+	check_rfc4884_offset(_metadata, dgram, v);
+
+	close(dgram);
+	close(raw);
+}
+
+TEST_HARNESS_MAIN
-- 
2.51.0


