Return-Path: <netdev+bounces-171152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F345A4BB40
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD2516DED8
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8521F1524;
	Mon,  3 Mar 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ATJVrG95"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3A1F1510;
	Mon,  3 Mar 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995644; cv=fail; b=ad7IGq3EUQp32GuCo/rMfNXq/BtnRI0Vh/J40nPEJtHCF9xpYpjx+LeYh3SCW/RwZ1E5mXpUdRSwkEc2NKWRKEZurWk6e456RMgnMo2Ql3IO2+gxxEWiDOrEe46zA7q+0S9qJTJGjcYJnXAvELoQsTxXAVuVy33mab9ZgtUifIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995644; c=relaxed/simple;
	bh=hehafDcOufx+tKb9tEGwGU5H+ocEMvfH4lwR5xWbEeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f0bdrQsMi3B1ovLHRHv7hI7QjPW0X0FLJWp1f55BLFb30dfpFXDEcHEDjEVtKq0jB6zqOuFMk84PCf8nZUAgdiENAGWenBty4giWSPuu0N5CDGd6kYFVCXtHTlxgTHaE/c0idKgCo+DgJsWUatn1bptv6uw+16ghwFutbwzaVFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATJVrG95; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQgE1KTCy2AKExiVM+0bDNfwOpZoeyNNUdVEwzAxYNtql7LpthsXiV5EvLuWpKy1YxqYBl4kS2hCwBDDdBfpqCHV4h1HvVGKJq/PqBkFR/1tEZ5Hnc3NSsNgd6ZV3ML5FwJiYzKYZMs3Xi4fkzQCmbNpcQQCegVnZ2wov6jN6NYuaBONQSTiKr+/IBruE6g97b2z3O8cEYUQnNAtrcLoki2XQ5zBY3wAxBBk5GbvRwtTKtzUE1RpK2FHYxMd4ujPNaFEJQebVijGeinMvHmVyP/GhiQe50ZYYIpyJqK7zKoHuhJJR5GNvzHTz8nOxvQHJ9hOIWLkLgmVkp6pCW9QEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atInrDItTF9UEF8XhZLiw78c7qgjsrj7iIPSzieMvJc=;
 b=IS8KS0h7hQh7dVpvzgXo/A2X8c9wih6mRpADoaRQ7Q+VvjJsrxZOGajTUDEJgmG7uJ5XSFS+OyKWv2GMjktRmWTuEp2pfq+gVf1yCXPaeuddg39tDX/LNSFow32lpTsUssPUZRvGLxlSdnaGuemzH1SVD/dyhKMNnwfykd7M2c7RZsJ0aWDhhWw5MGRhVTrVDB/6pr1RB/1oVamvsHmm884gV1MZ5R1wh7jm/jlgMk8fkrlLwNg8tz3sOI5EYFyU9j1Oq0A67ylG1yZFsM6HZlTF1CmXevZz4wRrVmETqL2c1KZXzT7wpYygAhAnlwdrn56Mv2i4ne4bFYhwZLiWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atInrDItTF9UEF8XhZLiw78c7qgjsrj7iIPSzieMvJc=;
 b=ATJVrG9507IswhGbdvKSDAXKXkisjk0oiThEJtyVbfQQ9+JuoQaGUSYJB7C2Er2XG7COaxLJ0rR0ywOXD0BGY2Mjqy1u0TEs4NoPVlDJI+NovBaGbrOQZQyseCVwb+Ft1/9BKUkF+tckZk630PFFP/Q3nzIKwXHQ0OJfRRgtYVrEU3+AsGrJOuxPMv8n7MRimIA2HMC73uvI8dv/PEfQ542/i2TC+CAuALELMkM965UV3iJ+GbKQ7G0ZAhZ4C+0oS+txt7qZCFsXdiHeWKSAEDI7Ns5Dt2ug9YH6Y3VZxbGmbDAjbSPJRJk47JUWVDGnordPYYJH58mWJoHrTHcpTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:59 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:53:59 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	linux-doc@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	corbet@lwn.net
Subject: [PATCH v27 09/20] Documentation: add ULP DDP offload documentation
Date: Mon,  3 Mar 2025 09:52:53 +0000
Message-Id: <20250303095304.1534-10-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: a579d079-f501-4b50-996f-08dd5a3951e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B7ubsb4WJvi4mbnNJseh30YqH45vocQe9gDBXSPa8O8tVhTyP+qKyzsNPDNd?=
 =?us-ascii?Q?RxzHl7DJpquMBZIdTLHBN29Z/9KnDlOEcba1o3/VTEcmwgTrWJ1gEnoRyMqG?=
 =?us-ascii?Q?TgzstXW6FUeSIMZb4rSZyXqAxgSbwy5Rh7Zx564oOFQfTlMuong4HAs0DZV4?=
 =?us-ascii?Q?2jpr57vzWd80U4UkZEQs5cbbZIYL7hb7fTRqihQW/5Yhr2nqMV8SyIq9Elzw?=
 =?us-ascii?Q?5kWn2HXN8qT5SD0faTM4wVY7wJ2CHLmCgW77itfOR3awlSGPQ/9Z23u2Rfnl?=
 =?us-ascii?Q?3tmNOTwwp2gvzQMppJ9RBveK2y5Oh7z6sctnnUraRndWe9iJXgSBM0MAflTt?=
 =?us-ascii?Q?sO6+amuZTVITZLMJAiIURg8qXqRF/5SHHwAfcquiWHm9ieBGZgGhRnYnEn65?=
 =?us-ascii?Q?MS5jEod1LsSneh+F9YJZ4O3LYU2rzi1jfacNi7DqwsVvIaOWVkxd594/7QYz?=
 =?us-ascii?Q?gGPZmCftGCY5uqBG/tlI945d1Q9Pl4DQwARo2JfzG2jQo4QRaCpbA7AKJx9E?=
 =?us-ascii?Q?hW8cjWFr3gN9CB2mjxHHlHAK2sX2bJcSge6isdo6WJnd27vmgLRxpHo/QjJS?=
 =?us-ascii?Q?ICGO9EYYz6LN5J2W20B+B1nRj9BvGu+Xv3qjQ2DOiMcIlg/NVe4T2zK1yvDv?=
 =?us-ascii?Q?wh7IIBNysysIiuYYQPwJhtzdQGX6kDtYqJUCpASXFAB4cVjpN/UwftUh9gZn?=
 =?us-ascii?Q?yn0QIOYPqgQnSjJ3mLIdYDdxELU3Q0vk7dcnBwrN8gyUfHF1HUeXvhOu5xfs?=
 =?us-ascii?Q?+R13852YtUg6uuVvRK0ls6lh4YzXuLKrKPKYppQNO77BHkXv2YS8p7HG62xE?=
 =?us-ascii?Q?H/r/Er948KmJjdV+/yW0mjol/JcBVT6WeB0kLdNusC3H0EA0DJ8cNxjg+re+?=
 =?us-ascii?Q?5dzYnqNUmQTCMiFZ/B8xkOhBWFWgIN6KPVL6WjS314xuqGp7is4Iic32sUHt?=
 =?us-ascii?Q?a4uEqa2Tw175rxou4o7F68/vdgG6Ft7chGP1nC5qCf0sOJGg7tnpqa9Q8u+C?=
 =?us-ascii?Q?pFrdak6e2P0PHw9sz/eyE4H9W15Wf1+UCIMSM35M3RCBkhrXTEBv9/pw5xv/?=
 =?us-ascii?Q?ys6yMvgdYK5M1bU3vu1sD2h4l5dhO0bqeKy8+GAbGA6AeBfB8gIqJSIk8bVL?=
 =?us-ascii?Q?RwS4OZgeb2ELLTN9XtKGi2Pn7ywrOwUU0e5900ijC6Gh9mjorglo7BTjsAsq?=
 =?us-ascii?Q?qF+1RXgUlsHbqEzFN3l+molWqoaKWw9s486a/Q2b/nfOIOgcIehW7+osVgZd?=
 =?us-ascii?Q?ymzm7qvpN2Bep1OYtltq+ZqSu6QtQlknGHasZ1k5ShhiU/QP9gCpMaCX/nbz?=
 =?us-ascii?Q?cIYjVH8x1v6lB5jlx+3uVDzyHMTzxPqt4cBaG/4k2L5lMwH6QvmfTlrsr5Nm?=
 =?us-ascii?Q?ABfM38qI47AdTFwloZuLfEya0Ngo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yIgT5qISViSyFNGp8wfZrCC4u6dfauOCFMXxiq9U++JCJ9FxZFb+m+rFZ2iS?=
 =?us-ascii?Q?QSZxL6td5wrQENtpkBoeCvUwkv9pKerX4oLl8+Vysk+3A7T/K0MlKU8tIXEJ?=
 =?us-ascii?Q?hBSXzRLxxsws2rPv4MavvQWOLLJwkZkEn1XLcu/CLfp3Xx9oToinjSKH1nDm?=
 =?us-ascii?Q?t6V3O4mGWPyv0TiFoTK0ruU8/k280HhqQTotGU/cgBRn6K6OccKLBoqtkqdV?=
 =?us-ascii?Q?TM4d1Ep1+7wTMCpSfYwpbxf23zZXQGp7/z+6ImROh+96w557CvX9/URxzVe7?=
 =?us-ascii?Q?wfOPrxm5dfJqR4VcxlM7dHBJLJ7NoiWy61XN4oHID5PTLWwlRyKpX7EYs2RB?=
 =?us-ascii?Q?4dS47mPXWn+AMyI9zljTiAVnjlhBrbNgblHxvlqFgIsSouwMZfUnoKJahrt6?=
 =?us-ascii?Q?4hpNPBRCy2eLddVVBhYil7JOWhf2JxxqztjsxfHBA9XpwO0pCHF/dDy5Q+4K?=
 =?us-ascii?Q?QAyUApDkRTU0feRnC7HlLlOZEyzMwuZ7zd2+V8J7JKPbonRZg+0kdobueNos?=
 =?us-ascii?Q?8xgn8CbSHEWfqQLTeoEVH+HYsGhS3AyMOCGZG9DmG96ySFb026Gmiq0CN0dk?=
 =?us-ascii?Q?rzVfPRlr6EiWiFrS+FE6FR00kFjrETmqRYBfdryCCkKxJshcROWr3rnwqVGa?=
 =?us-ascii?Q?Wn7mtVdTg8mUvi0gODSOtrjU6yHtn+LidJxZOAaMiW1Wss24n0chZVeIK1Hc?=
 =?us-ascii?Q?/EG4mndnyi5veuyAS8fFO3giXGsKFvj59A2XgWYp/rs4JFgokCSBApjouNWk?=
 =?us-ascii?Q?folr8zGA1eDOOHrGTYzEHhK4kjt+GQv6ySZ+gZXSOatZfPJJkWytP24FHOnA?=
 =?us-ascii?Q?c7JrZVLFzFCA6kN/f9xk2yTAeFJPcfGUsFlXP6Sm3v5HB8y7krmoT/OUgXbn?=
 =?us-ascii?Q?ob+1oqeYDCSJO9OKZ1T5gNc6e/+Pc14oqqD+zi3+Gx0nbdt15GM4r2PsVQUd?=
 =?us-ascii?Q?/PVS8w01bugN/k7sRUvz9U9Lkj9xWdd6odAm3BPLE7q/6N7KmRc/azly4sFH?=
 =?us-ascii?Q?Lx6aINCtZram4FVx/Y9UePKYoVBosTQTPN3uZQiJRl3u/qj0TsbJ3h0cWO6P?=
 =?us-ascii?Q?3bSNyDTmdHsSCY0+R9RO90a1Y9otw8zKMx0ECQM3i3Uas1rjBUph1MORA17E?=
 =?us-ascii?Q?FcRnn4hgus1i+nDLt4HlWT7BZgSLqWHmukNQmHu7YrOhc+Vs4iRXdEsVrx3P?=
 =?us-ascii?Q?SLnyxUbK38bfPLhoxj143JkKZ+5LFF4aUvVGmZP2+Fz35yMA+iNmxfjMgUeN?=
 =?us-ascii?Q?CKpnoM+Noumo7BF2YwFuR/6o6XV+BE8gc4FOdgqEcecG7Woik5a2+fZBKMvH?=
 =?us-ascii?Q?dPthG3Tp+bfLg0MHovu1We/Oougdsa9G0KyyPSAphY1ShDHENgH4NvPoDO9S?=
 =?us-ascii?Q?C9bC9VjheRQaUskW0JYq8d7KlX7F86qYj1WKeitF3b1pcXxqfDWQE7ZdiXO8?=
 =?us-ascii?Q?Ypi2xEAHClmOqJ1V35FBCU2Fme5zheMqUNSoXSnkGqsRJsFWAXZl2G8ivv+z?=
 =?us-ascii?Q?LrWRO6AW9K649HgSoM1jVMlRbW2pppnbUSsD5FBJaagv91bKoGdHCXp6nUBf?=
 =?us-ascii?Q?EITlDxDZb4oAMOoPQGLSKtiYzwBZZ3LhJS+moSvI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a579d079-f501-4b50-996f-08dd5a3951e4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:59.1646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXCzZNVLXBgZQEuGw75k+02fIi1djGrN17o18LuqRhF1ktZxGtnplXSE2yy31eoZt6uckgWKwhKMKR2b4ixTDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Yoray Zack <yorayz@nvidia.com>

Document the new ULP DDP API and add it under "networking".
Use NVMe-TCP implementation as an example.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/ulp-ddp-offload.rst | 372 +++++++++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 058193ed2eeb..07afdcdae457 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -120,6 +120,7 @@ Contents:
    tc-queue-filters
    tcp_ao
    tcp-thin
+   ulp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/ulp-ddp-offload.rst b/Documentation/networking/ulp-ddp-offload.rst
new file mode 100644
index 000000000000..4133e5094ff5
--- /dev/null
+++ b/Documentation/networking/ulp-ddp-offload.rst
@@ -0,0 +1,372 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=================================
+ULP direct data placement offload
+=================================
+
+Overview
+========
+
+The Linux kernel ULP direct data placement (DDP) offload infrastructure
+provides tagged request-response protocols, such as NVMe-TCP, the ability to
+place response data directly in pre-registered buffers according to header
+tags. DDP is particularly useful for data-intensive pipelined protocols whose
+responses may be reordered.
+
+For example, in NVMe-TCP numerous read requests are sent together and each
+request is tagged using the PDU header CID field. Receiving servers process
+requests as fast as possible and sometimes responses for smaller requests
+bypasses responses to larger requests, e.g., 4KB reads bypass 1GB reads.
+Thereafter, clients correlate responses to requests using PDU header CID tags.
+The processing of each response requires copying data from SKBs to read
+request destination buffers; The offload avoids this copy. The offload is
+oblivious to destination buffers which can reside either in userspace
+(O_DIRECT) or in kernel pagecache.
+
+Request TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+-------+---------------+-------+---------------+-------+
+ | PDU hdr CID=1 | Req 1 | PDU hdr CID=2 | Req 2 | PDU hdr CID=3 | Req 3 |
+ +---------------+-------+---------------+-------+---------------+-------+
+
+Response TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+--------+---------------+--------+---------------+--------+
+ | PDU hdr CID=2 | Resp 2 | PDU hdr CID=3 | Resp 3 | PDU hdr CID=1 | Resp 1 |
+ +---------------+--------+---------------+--------+---------------+--------+
+
+The driver builds SKB page fragments that point to destination buffers.
+Consequently, SKBs represent the original data on the wire, which enables
+*transparent* inter-operation with the network stack. To avoid copies between
+SKBs and destination buffers, the layer-5 protocol (L5P) will check
+``if (src == dst)`` for SKB page fragments, success indicates that data is
+already placed there by NIC hardware and copy should be skipped.
+
+In addition, L5P might have DDGST which ensures data integrity over
+the network.  If not offloaded, ULP DDP might not be efficient as L5P
+will need to go over the data and calculate it by itself, cancelling
+out the benefits of the DDP copy skip.  ULP DDP has support for Rx/Tx
+DDGST offload. On the received side the NIC will verify DDGST for
+received PDUs and update SKB->ulp_ddp and SKB->ulp_crc bits.  If all the SKBs
+making up a L5P PDU have crc on, L5P will skip on calculating and
+verifying the DDGST for the corresponding PDU. On the Tx side, the NIC
+will be responsible for calculating and filling the DDGST fields in
+the sent PDUs.
+
+Offloading does require NIC hardware to track L5P protocol framing, similarly
+to RX TLS offload (see Documentation/networking/tls-offload.rst).  NIC hardware
+will parse PDU headers, extract fields such as operation type, length, tag
+identifier, etc. and only offload segments that correspond to tags registered
+with the NIC, see the :ref:`buf_reg` section.
+
+Device configuration
+====================
+
+During driver initialization the driver sets the ULP DDP operations
+for the :c:type:`struct net_device <net_device>` via
+`netdev->netdev_ops->ulp_ddp_ops`.
+
+The :c:member:`get_caps` operation returns the ULP DDP capabilities
+enabled and/or supported by the device to the caller. The current list
+of capabilities is represented as a bitset:
+
+.. code-block:: c
+
+  enum ulp_ddp_cap {
+	ULP_DDP_CAP_NVME_TCP,
+	ULP_DDP_CAP_NVME_TCP_DDGST,
+  };
+
+The enablement of capabilities can be controlled via the
+:c:member:`set_caps` operation. This operation is exposed to userspace
+via netlink. See Documentation/netlink/specs/ulp_ddp.yaml for more
+details.
+
+Later, after the L5P completes its handshake, the L5P queries the
+driver for its runtime limitations via the :c:member:`limits` operation:
+
+.. code-block:: c
+
+ int (*limits)(struct net_device *netdev,
+	       struct ulp_ddp_limits *lim);
+
+
+All L5P share a common set of limits and parameters (:c:type:`struct ulp_ddp_limits <ulp_ddp_limits>`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+  * protocol limits.
+  * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+  *
+  * @type:		type of this limits struct
+  * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+  * @io_threshold:	minimum payload size required to offload
+  * @tls:		support for ULP over TLS
+  * @nvmeotcp:		NVMe-TCP specific limits
+  */
+ struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		/* ... protocol-specific limits ... */
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+ };
+
+But each L5P can also add protocol-specific limits e.g.:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+  *
+  * @full_ccid_range:	true if the driver supports the full CID range
+  */
+ struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+ };
+
+Once the L5P has made sure the device is supported the offload
+operations are installed on the socket.
+
+If offload installation fails, then the connection is handled by software as if
+offload was not attempted.
+
+To request offload for a socket `sk`, the L5P calls :c:member:`sk_add`:
+
+.. code-block:: c
+
+ int (*sk_add)(struct net_device *netdev,
+	       struct sock *sk,
+	       struct ulp_ddp_config *config);
+
+The function return 0 for success. In case of failure, L5P software should
+fallback to normal non-offloaded operations.  The `config` parameter indicates
+the L5P type and any metadata relevant for that protocol. For example, in
+NVMe-TCP the following config is used:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+  *
+  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
+  * @cpda:       controller pdu data alignment (dwords, 0's based)
+  * @dgst:       digest types enabled.
+  *              The netdev will offload crc if L5P data digest is supported.
+  * @queue_size: number of nvme-tcp IO queue elements
+  */
+ struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+ };
+
+When offload is not needed anymore, e.g. when the socket is being released, the L5P
+calls :c:member:`sk_del` to release device contexts:
+
+.. code-block:: c
+
+ void (*sk_del)(struct net_device *netdev,
+	        struct sock *sk);
+
+Normal operation
+================
+
+At the very least, the device maintains the following state for each connection:
+
+ * 5-tuple
+ * expected TCP sequence number
+ * mapping between tags and corresponding buffers
+ * current offset within PDU, PDU length, current PDU tag
+
+NICs should not assume any correlation between PDUs and TCP packets.
+If TCP packets arrive in-order, offload will place PDU payloads
+directly inside corresponding registered buffers. NIC offload should
+not delay packets. If offload is not possible, than the packet is
+passed as-is to software. To perform offload on incoming packets
+without buffering packets in the NIC, the NIC stores some inter-packet
+state, such as partial PDU headers.
+
+RX data-path
+------------
+
+After the device validates TCP checksums, it can perform DDP offload.  The
+packet is steered to the DDP offload context according to the 5-tuple.
+Thereafter, the expected TCP sequence number is checked against the packet
+TCP sequence number. If there is a match, offload is performed: the PDU payload
+is DMA written to the corresponding destination buffer according to the PDU header
+tag.  The data should be DMAed only once, and the NIC receive ring will only
+store the remaining TCP and PDU headers.
+
+We remark that a single TCP packet may have numerous PDUs embedded inside. NICs
+can choose to offload one or more of these PDUs according to various
+trade-offs. Possibly, offloading such small PDUs is of little value, and it is
+better to leave it to software.
+
+Upon receiving a DDP offloaded packet, the driver reconstructs the original SKB
+using page frags, while pointing to the destination buffers whenever possible.
+This method enables seamless integration with the network stack, which can
+inspect and modify packet fields transparently to the offload.
+
+.. _buf_reg:
+
+Destination buffer registration
+-------------------------------
+
+To register the mapping between tags and destination buffers for a socket
+`sk`, the L5P calls :c:member:`setup` of :c:type:`struct ulp_ddp_dev_ops
+<ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ int (*setup)(struct net_device *netdev,
+	      struct sock *sk,
+	      struct ulp_ddp_io *io);
+
+
+The `io` provides the buffer via scatter-gather list (`sg_table`) and
+corresponding tag (`command_id`):
+
+.. code-block:: c
+
+ /**
+  * struct ulp_ddp_io - tcp ddp configuration for an IO request.
+  *
+  * @command_id:  identifier on the wire associated with these buffers
+  * @nents:       number of entries in the sg_table
+  * @sg_table:    describing the buffers for this IO request
+  * @first_sgl:   first SGL in sg_table
+  */
+ struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+ };
+
+After the buffers have been consumed by the L5P, to release the NIC mapping of
+buffers the L5P calls :c:member:`teardown` of :c:type:`struct
+ulp_ddp_dev_ops <ulp_ddp_dev_ops>`:
+
+.. code-block:: c
+
+ void (*teardown)(struct net_device *netdev,
+		  struct sock *sk,
+		  struct ulp_ddp_io *io,
+		  void *ddp_ctx);
+
+`teardown` receives the same `io` context and an additional opaque
+`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_release`
+section.
+
+.. _async_release:
+
+Asynchronous teardown
+---------------------
+
+To teardown the association between tags and buffers and allow tag reuse NIC HW
+is called by the NIC driver during `teardown`. This operation may be
+performed either synchronously or asynchronously. In asynchronous teardown,
+`teardown` returns immediately without unmapping NIC HW buffers. Later,
+when the unmapping completes by NIC HW, the NIC driver will call up to L5P
+using :c:member:`ddp_teardown_done` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+ void (*ddp_teardown_done)(void *ddp_ctx);
+
+The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
+in `teardown` and it is used to carry some context about the buffers
+and tags that are released.
+
+Resync handling
+===============
+
+RX
+--
+In presence of packet drops or network packet reordering, the device may lose
+synchronization between the TCP stream and the L5P framing, and require a
+resync with the kernel's TCP stack. When the device is out of sync, no offload
+takes place, and packets are passed as-is to software. Resync is very similar
+to TLS offload (see documentation at Documentation/networking/tls-offload.rst)
+
+If only packets with L5P data are lost or reordered, then resynchronization may
+be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
+are reordered, then resynchronization is necessary.
+
+To resynchronize hardware during traffic, we use a handshake between hardware
+and software. The NIC HW searches for a sequence of bytes that identifies L5P
+headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
+type can be used for this purpose.  Using the PDU header length field, the NIC
+HW will continue to find and match magic patterns in subsequent PDU headers. If
+the pattern is missing in an expected position, then searching for the pattern
+starts anew.
+
+The NIC will not resume offload when the magic pattern is first identified.
+Instead, it will request L5P software to confirm that indeed this is a PDU
+header. To request confirmation the NIC driver calls up to L5P using
+:c:member:`resync_request` of :c:type:`struct ulp_ddp_ulp_ops <ulp_ddp_ulp_ops>`:
+
+.. code-block:: c
+
+  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+
+The `seq` parameter contains the TCP sequence of the last byte in the PDU header.
+The `flags` parameter contains a flag (`ULP_DDP_RESYNC_PENDING`) indicating whether
+a request is pending or not.
+L5P software will respond to this request after observing the packet containing
+TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
+software calls the NIC driver using the :c:member:`resync` function of
+the :c:type:`struct ulp_ddp_dev_ops <ulp_ddp_ops>` inside the :c:type:`struct
+net_device <net_device>` while passing the same `seq` to confirm it is a PDU
+header.
+
+.. code-block:: c
+
+ void (*resync)(struct net_device *netdev,
+		struct sock *sk, u32 seq);
+
+Statistics
+==========
+
+Per L5P protocol, the NIC driver must report statistics for the above
+netdevice operations and packets processed by offload.
+These statistics are per-device and can be retrieved from userspace
+via netlink (see Documentation/netlink/specs/ulp_ddp.yaml).
+
+For example, NVMe-TCP offload reports:
+
+ * ``rx_nvme_tcp_sk_add`` - number of NVMe-TCP Rx offload contexts created.
+ * ``rx_nvme_tcp_sk_add_fail`` - number of NVMe-TCP Rx offload context creation
+   failures.
+ * ``rx_nvme_tcp_sk_del`` - number of NVMe-TCP Rx offload contexts destroyed.
+ * ``rx_nvme_tcp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvme_tcp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvme_tcp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvme_tcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvme_tcp_resync`` - number of packets with resync requests.
+ * ``rx_nvme_tcp_packets`` - number of packets that used offload.
+ * ``rx_nvme_tcp_bytes`` - number of bytes placed in DDP buffers.
+
+NIC requirements
+================
+
+NIC hardware should meet the following requirements to provide this offload:
+
+ * Offload must never buffer TCP packets.
+ * Offload must never modify TCP packet headers.
+ * Offload must never reorder TCP packets within a flow.
+ * Offload must never drop TCP packets.
+ * Offload must not depend on any TCP fields beyond the
+   5-tuple and TCP sequence number.
-- 
2.34.1


