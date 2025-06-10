Return-Path: <netdev+bounces-196250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31938AD405D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2F6161A59
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7532459C7;
	Tue, 10 Jun 2025 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7zVn+uE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F36245028;
	Tue, 10 Jun 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576151; cv=fail; b=WAk21CnvtvCxKyj2SLT1jOBpODXOvYKdV1W/DLrNWUfoKrH6X6dYXgBO1hobNnd5MaOA80mXiKYOnf6tfOO1MTYpkvs3BzhSjr7+ZdTZFHt9ei+T5WNCaCRkf7UC95ZAz5aU1CXzkPj6pE7WTGKiExPStKtcXkE9+eokZaNGs0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576151; c=relaxed/simple;
	bh=6Ikm+HL2gyVzHMINuUz4+2kIgNrXKmVsTsOR7ZLB5Ss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M2B3Z4pOpz5+Es1fpwowXGZ9uVTKud/+aUZBvYiXrrYU28q0OLrLjy8I6rGSGWVDrM6ubivQuSZ0xP3aYag8glcKl86h9wZ3yudasXvHeJdzTx8ixKJs8hTr+sY8I8+MMaATmTw2AyIE1hC0f9lhOZn5Q/5OK4eoa7WyebWSpyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7zVn+uE; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohUcC7e+zikm6Jv4hQZN918PCDA9ATnGjE4Ou4JBLiiwtoAoxqs0oWXsYK1WjJO3kZ4GFEDGNbpX7K9OFbQpzEqdsVwivYbefe557f44tH70GqPJy90JrAJreDU+7BC3LnqZ4Xzq6Lxqx/yRBhFN45AlbxH/VY0eEy6/bYIEXvb+kf7jouo4sWyIqoQpS9JDKOBsMwZtG8Co3KiwM64ABqgYLIkuD5SB1qqyMuFL9nF3sFcFQpZnK5aw+9gTzfHT3SGCczlnOLmynkjCTzc5RHQEM+cDmns8evtTre0ndPwGijydms7DeSICpytGSh6rpUDxELh3OKpE6NV8y0dQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pSnbgjd5a8brq8B8XrCoV3HCGh+q+X6ZD2GrGZuZXg=;
 b=zSS4ZB9q2KB6AVg13MODd6dSUYRM96kiqv1XktZGJOOzEt5ifBUw2bOhLFfUSIKi9+fK3rU43KgX9ywJs+luumotrQUAogO3Q1FAcJmBNihAdRyJI06pFkoji073wRGhZ7jSmNvm2x2Gr8P4AmoH9rcLwSDmaPFkUIwU+Q8iHWwZa2Wb9cQqI0saRC9FcVAn9EWglU9fd/JNzC9Myfo6gsMb+FRI32frlG7gKDim8GGJwp3VholwrUnbZUGmO0GjOXr/olY9TMlWVRlV9s1UK+Dw9ccRlgRUwYDHX4qTjOpLOD+QqRChGDQ6OusN9Gsz1eBObAid5dLIcsmLsdpGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pSnbgjd5a8brq8B8XrCoV3HCGh+q+X6ZD2GrGZuZXg=;
 b=T7zVn+uEC7OslMFaz4L8JqbOFN5j4RGJb7mYlmb7Q1+w0gE1goJzwx8hTlV0mNiZS0TZmw+pzjARyk1lqza1IaFcXFcTRNkhiki6O7hXbrryhVoGS3f+UF+dsK3MwCHXc24oEatvzBfEL2b7wlB7sbvuUDn8W9mlBKqqVhUMhCgo06Zb/UOik0NbVzCO9vxn9kDKWpDR5V2AFlRN+s9odPrpCXel5/OCZg6ieiAJB4OH0oxJPxaJhgSpFLA4sZPGK1dFJv9mHKXCtUAtrmDdC3ESHlHSfK2tYkq2oajUDVwkh6QGgvHDwAMvEzl8kkU1iVqBDT+HrItM83JZAvhyoA==
Received: from BL1PR13CA0330.namprd13.prod.outlook.com (2603:10b6:208:2c1::35)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 10 Jun
 2025 17:22:27 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::bd) by BL1PR13CA0330.outlook.office365.com
 (2603:10b6:208:2c1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Tue,
 10 Jun 2025 17:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 17:22:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 10:22:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 10 Jun 2025 10:22:04 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 10 Jun 2025 10:22:00 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Bar
 Shapira" <bshapira@nvidia.com>, Maciek Machnikowski <maciejm@nvidia.com>,
	Wojtek Wasko <wwasko@nvidia.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mahesh Bandewar <maheshb@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: [RFC PATCH] ptp: extend offset ioctls to expose raw free-running cycles
Date: Tue, 10 Jun 2025 20:19:05 +0300
Message-ID: <20250610171905.4042496-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: 41656c01-6c3f-400a-28ff-08dda8435f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEdvMTdmTUVxZFF0RElGbUtVMjJwKzladEhZVXdUMTFBWmYyd1NwRzdEYTIy?=
 =?utf-8?B?WHRXb0tkUkR0WDBZTzA1RmdKQTJVR0FDdS85TktYVXBXSDV4SkxzaWUrQTJG?=
 =?utf-8?B?N0NmWFJCais3RGpCVnE4YVFweUVTUkh1NndpZnNqTGNPZER3RmRSamlUZlU3?=
 =?utf-8?B?cFdQTklkcUtUaUU3NEIyVUt4UllkZzBRZ1BVUVhZTk95dGF1SVFkL3Z4azZ2?=
 =?utf-8?B?UEFiVS8wQzFkUTRPSDB4YUVETDBzdmpIZEJxL0hEdURDU3h6YlFNOVRUNGtN?=
 =?utf-8?B?R0IyNWZDc0tPNkQ5ZnJ6WUlhcG5EMEdQYWJRNDJpbWhTRnhTbGhNNmJLVDBm?=
 =?utf-8?B?U2ZSb1JVZ3ZTRG5FRUxqMTJhcFdKdlhGVk9PQzdZZnZweVI2L3NRNWcrS3hj?=
 =?utf-8?B?d0REd2NHUXMvd3phZ0ZNdStMZFF0bFBCS2ZSanFmTGRMOHdJUzhQQ2x0VGwr?=
 =?utf-8?B?aUo0UUZIY1kxVHlycnd2Uko5cmt3S0ZDaHZJbWJGSmU4d1pRdG1QOXYzMEJr?=
 =?utf-8?B?MzNwbXJqMU1DNU96ZnBURlVnOGdoc3ZaaXl1eDNudHo3YlhuaWVYNjdxNkJU?=
 =?utf-8?B?NSt5cDJSVGk1SzEvdVE3UU5XOVVrVXdZdjVNN2paWGlpdjRoTzJUWXh2NHBE?=
 =?utf-8?B?MXN4YzBoazQ0OFpmQTlxcjg1cFZJUHBOSWZicXllNVpYMjAxb0kzMXBPQjJD?=
 =?utf-8?B?NUhVSmxsTHlrYVllS0pobTRmeVluTlBXMXk3QzFaOWtLazRDZWQxNXhaUEF4?=
 =?utf-8?B?YWk0enFqLzRzVlZrT0RITzFFSENHeDV3bzk1L2pNcTkveWV6OE95VCsvcENE?=
 =?utf-8?B?MWJ5bVNIWFY2VExacHFwNXpBVmQ0VnE3elFNRzliZ0lobmhmK05CeVYwNi9o?=
 =?utf-8?B?MXJIbVJYbEdwY1NXMjFKK2xvaTNwYXBhK1NQUDJvbFFKMXBJS2ZtZGx4eHJt?=
 =?utf-8?B?ZmkxaUlQNVFnOEh6WXBKWnN0Z01kVUZ6ZzRmS2pqUTlmNlplN2twQmFsR0FI?=
 =?utf-8?B?VFQyS1N2Y1J6ZjhUczVxQko3a3U5cUpOMytkV0gxNXVKcG9iUWQ0UUdKN1Vv?=
 =?utf-8?B?SmZ0dHJXNTc1TFhHbnVhLzZDdkZjMHdWamUzRlorQytmT2FldlVxd295T1FF?=
 =?utf-8?B?VVNuSjVmOWxqVFRJWHRORnBMTE9tVEh0UmJIVDVrZlMzZllyTEQvamw1NUhT?=
 =?utf-8?B?U2N2RTBhRGJIUVdQbWI3UDhocXNnSDdSQytNWm82d0liU1BGM1BnZTdqUXJ0?=
 =?utf-8?B?Si90SjBhUjFHZmQ3cDVVTE9YajZrUG1MdFNaRVhJVktRMFptVnNIaHlWSU81?=
 =?utf-8?B?WC9LbFdWMnA5VkdBYzRwRUxnbVZ1STVKcWMva0tGVVU0NlBPSjZKOHgybE1l?=
 =?utf-8?B?VEZPNnZMMktPNVJlcGRhTW5BcXNTb1g0d0k5cVc1OEMyZWRzVmFKRXF0eUdv?=
 =?utf-8?B?OWRJajJMRGVlazRQWDBvYURNbkdmVXUveVlRYWFSS2VISjdzMkp3VnRSSDBH?=
 =?utf-8?B?UVhLSjJsRUNBRmlEZldBUjVMQkRWb20ybHEzYW5kU3Y5OUZFOGJjUHJTQU5p?=
 =?utf-8?B?OXFQT3VmNUd1MldrSDFDdFZGVUk1dXJzSFcxZjF5S2hxMnUzcjJYbnlTMHIv?=
 =?utf-8?B?aG9BdGRzT3VLVWRuVFdRVEJ2RGJQVFBjbS9FL2tOVkY1UkdkYVhBWnZpV0FO?=
 =?utf-8?B?cHpLZFdXMUZia0YzeW5UbjV1RUFFa2Y5d2hndUVIeXk4TlBwYUdEVXRLNWpn?=
 =?utf-8?B?N1VSVVdyMnlKSnFpaW9GVXlrTC92bXpoOXJZblF2RFhXSmErM1pISnU5bElQ?=
 =?utf-8?B?OHZqYXgxb3NiMnAwVGtPZlBRVEZkbE03a3RGMFdqY2lMRDByRUl0RTZodnhQ?=
 =?utf-8?B?K3YweVdTZWc4U2o2eVNvUk1sM0o2dEVEK241Y2Q0Z2lkMUUzWWljTXlDRjJE?=
 =?utf-8?B?WFZyZjlUNTdnWEJOWU1mZXZkL0w1ck41Z2pZcG8wd09FZm15eDlrTGc0Q29i?=
 =?utf-8?B?Z05HNmNvNCswUVhUZ0FMcnJoTVJiSklYLzFUSXBHLzZzSjFqUXFiQ1V1NE43?=
 =?utf-8?Q?JFssE6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 17:22:27.0325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41656c01-6c3f-400a-28ff-08dda8435f58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0

Some telemetry and low-level event logging applications use hardware
timestamps reported in raw cycle counter units. There is currently no
generic way in user space to correlate such raw cycle values with
system time.

This patch adds support for returning the raw free-running counter
value from the device, alongside system timestamps. It introduces a new
flag, PTP_OFFSET_CYCLES, which can be set in PTP_SYS_OFFSET_EXTENDED2
or PTP_SYS_OFFSET_PRECISE2 ioctl calls.

When this flag is set, the driver is expected to return a raw cycle counter
value rather than a nanosecond timestamp. This is useful for offline
correlation and debugging.

This can also be useful in XDP. Some drivers already insert timestamps
into XDP metadata. If we allow them to insert the raw cycle counter
instead of converting it to nanoseconds, this could reduce overhead in
the fast path. The raw value can then be translated in user space using
this ioctl when needed.

While reviewing the current usage of getcyclesx64(), I noticed that
ptp_vclock expects it to return a timestamp as a timespec64 that
represents a nanosecond-based value. This is then passed through
timespec64_to_ns() before being used with timecounter_cyc2time().
However, in the Intel igc driver (igc_ptp_getcyclesx64()), the
timestamp is read directly from hardware registers into tv_sec and
tv_nsec.

Is this value already formatted as a proper nanosecond-based timestamp,
or is it a raw hardware format? Just wondering if this is expected
behavior, or if it might be a bug?

We’ll appreciate any feedback.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/ptp/ptp_chardev.c      | 41 +++++++++++++++++++++++++++++-----
 include/uapi/linux/ptp_clock.h | 41 +++++++++++++++++++++++++++++-----
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 4bf421765d03..c810b694de11 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -176,6 +176,7 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	struct ptp_pin_desc pd;
 	struct timespec64 ts;
 	int enable, err = 0;
+	bool cycles;
 
 	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
 		arg = (unsigned long)compat_ptr(arg);
@@ -354,11 +355,30 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_SYS_OFFSET_PRECISE:
 	case PTP_SYS_OFFSET_PRECISE2:
-		if (!ptp->info->getcrosststamp) {
+		if (!ptp->info->getcrosststamp || !ptp->info->getcrosscycles) {
 			err = -EOPNOTSUPP;
 			break;
 		}
-		err = ptp->info->getcrosststamp(ptp->info, &xtstamp);
+		if (copy_from_user(&precise_offset, (void __user *)arg,
+				   sizeof(precise_offset))) {
+			err = -EFAULT;
+			break;
+		}
+
+		if ((cmd == PTP_SYS_OFFSET_PRECISE2 &&
+		    (precise_offset.rsv[0] & ~PTP_OFFSET_PRECISE_VALID_FLAGS)) ||
+		    (cmd == PTP_SYS_OFFSET_PRECISE &&
+		    (precise_offset.rsv[0] & ~PTP_OFFSET_PRECISE_V1_VALID_FLAGS)) ||
+		    precise_offset.rsv[1]) {
+			err = -EINVAL;
+			break;
+		}
+
+		cycles = !!(precise_offset.rsv[0] & PTP_OFFSET_CYCLES);
+		if (cycles)
+			err = ptp->info->getcrosscycles(ptp->info, &xtstamp);
+		else
+			err = ptp->info->getcrosststamp(ptp->info, &xtstamp);
 		if (err)
 			break;
 
@@ -379,7 +399,7 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_SYS_OFFSET_EXTENDED:
 	case PTP_SYS_OFFSET_EXTENDED2:
-		if (!ptp->info->gettimex64) {
+		if (!ptp->info->gettimex64 || !ptp->info->getcyclesx64) {
 			err = -EOPNOTSUPP;
 			break;
 		}
@@ -389,8 +409,13 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 			extoff = NULL;
 			break;
 		}
+
 		if (extoff->n_samples > PTP_MAX_SAMPLES ||
-		    extoff->rsv[0] || extoff->rsv[1] ||
+		    (cmd == PTP_SYS_OFFSET_EXTENDED2 &&
+		     (extoff->rsv[0] & ~PTP_OFFSET_EXTENDED_VALID_FLAGS)) ||
+		    (cmd == PTP_SYS_OFFSET_EXTENDED &&
+		     (extoff->rsv[0] & ~PTP_OFFSET_EXTENDED_V1_VALID_FLAGS)) ||
+		    extoff->rsv[1] ||
 		    (extoff->clockid != CLOCK_REALTIME &&
 		     extoff->clockid != CLOCK_MONOTONIC &&
 		     extoff->clockid != CLOCK_MONOTONIC_RAW)) {
@@ -398,8 +423,14 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 			break;
 		}
 		sts.clockid = extoff->clockid;
+		cycles = !!(extoff->rsv[0] & PTP_OFFSET_CYCLES);
 		for (i = 0; i < extoff->n_samples; i++) {
-			err = ptp->info->gettimex64(ptp->info, &ts, &sts);
+			if (cycles)
+				err = ptp->info->getcyclesx64(ptp->info, &ts,
+							      &sts);
+			else
+				err = ptp->info->gettimex64(ptp->info, &ts,
+							    &sts);
 			if (err)
 				goto out;
 			extoff->ts[i][0].sec = sts.pre_ts.tv_sec;
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 18eefa6d93d6..eaf58e17fdb4 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -25,6 +25,31 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/*
+ * Bits of the ptp_sys_offset.flags field:
+ */
+#define PTP_OFFSET_CYCLES  (1<<0)  /* Use cycles instead of timestamps */
+
+/*
+ * flag fields valid for the PTP_SYS_OFFSET_EXTENDED2 ioctl.
+ */
+#define PTP_OFFSET_EXTENDED_VALID_FLAGS	(PTP_OFFSET_CYCLES)
+
+/*
+ * No flags are valid for the original PTP_SYS_OFFSET_EXTENDED ioctl
+ */
+#define PTP_OFFSET_EXTENDED_V1_VALID_FLAGS	(0)
+
+/*
+ * flag fields valid for the PTP_SYS_OFFSET_PRECISE2 ioctl.
+ */
+#define PTP_OFFSET_PRECISE_VALID_FLAGS	(PTP_OFFSET_CYCLES)
+
+/*
+ * No flags are valid for the original PTP_SYS_OFFSET_PRECISE ioctl
+ */
+#define PTP_OFFSET_PRECISE_V1_VALID_FLAGS	(0)
+
 /*
  * Bits of the ptp_extts_request.flags field:
  */
@@ -86,9 +111,15 @@
  *
  */
 struct ptp_clock_time {
-	__s64 sec;  /* seconds */
-	__u32 nsec; /* nanoseconds */
-	__u32 reserved;
+	union {
+		struct {
+			__s64 sec;  /* seconds */
+			__u32 nsec; /* nanoseconds */
+			__u32 reserved;
+		};
+		__u64 cycles;
+	};
+
 };
 
 struct ptp_clock_caps {
@@ -173,7 +204,7 @@ struct ptp_sys_offset {
 struct ptp_sys_offset_extended {
 	unsigned int n_samples;
 	__kernel_clockid_t clockid;
-	unsigned int rsv[2];
+	unsigned int rsv[2];    /* rsv[0] is used for PTP_OFFSET_FLAG_CYCLES */
 	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
 };
 
@@ -181,7 +212,7 @@ struct ptp_sys_offset_precise {
 	struct ptp_clock_time device;
 	struct ptp_clock_time sys_realtime;
 	struct ptp_clock_time sys_monoraw;
-	unsigned int rsv[4];    /* Reserved for future use. */
+	unsigned int rsv[4];    /* rsv[0] is used for PTP_OFFSET_FLAG_CYCLES */
 };
 
 enum ptp_pin_function {
-- 
2.38.1


