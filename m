Return-Path: <netdev+bounces-249388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D204ED17EA2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E6D30BBDF0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E27D38A724;
	Tue, 13 Jan 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mn3xaSJ6"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76F3806C1;
	Tue, 13 Jan 2026 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298977; cv=fail; b=KQDyzkAWwFMJgZps6BWBiVgOUn+WDRdo+uBL8tRfVTmErkbPpWyFAy+W+qoviORtJimwASH/Irv4DUq3J3Ig4sWp3w8Sn8DixeDxMxQQmgWHgunfGOkjkrKpQ+zHk7pdmM9EB56OzpWXEZqO4jDmsLQQoQQVjXVLWX8Dkl3Etx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298977; c=relaxed/simple;
	bh=xg5pRAdG1cuUJYrDTDaJ5j5ECHHiDN7b5FVJ7ITC4vQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CU6eKHzD4suN8cgE4VuvBg079StkoLOYxamK2wC50EaFe4pfsRWfpCTRSGVvQ9cSwcTcNU1/Yf+8lfSb44fSlt3f8F1/HT+F7GWAJOAZ6TFCt5ETnoUM5uWYYvXqIQ33ZHVaWPjhZFJp6yBNqKifD6nuYU8pbdeJEdNaVJ0Rm0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mn3xaSJ6; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfF8GIAUF6xOm9A6WMnMdxOQoSO/iFL8DQnY5QgRgjY5vCAn8ZV0JJNCKnqXMJUAjzL+T3oI/n+6qBt+4YrLHujTcU8JflykXFn5eN6m9lbkO9IgAmNRBzt7zg6urnz5SWbN2EfXFyWDdxmPEPcxXVXdAbnjAjrSWwmTqXSEeUIo6nBNHlGWbk/sTHotkUfxoiP1ubr3KwFSokYMtBRIWh3iO5VjiJzgVdVGhwo6UK2qRVFisUbagYcQsSMLQZe0PYnbeqw2kHVqX5vlWgSSWi2SER18qev+dBdrDyLwckI4T5yex00DfVWtHt5VTrBKnBwg9O0bEOs18WBo6ywjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRtBSDH12tEMNnwB2CrjRgVTq8OUaB43Ub8hSl9pWBU=;
 b=w1gmcKVKXW3gP5fOWZ0eYNT/Ef3gpohkilBUbpWwepP01/7bqE1XDC6GefFUkRm9QotMuGTEpJhe10qQ89WWPNQSjyJkfjfStoPys6k0K7mQcWrsh91OoFlznr9AW6rty4JzmwPd4CLULu9+02BD3UzoKGV/mt2Xh74jMBRC301uQ8mJB8VvaYvMQM3EoJqIrJy9z71s1xzgGzj2IbNBv7uN1paKIJFaxvJ2c5sDh03pYgjagiCUNSN2RRNpdFFMXxlr0bmckwvnBQhCbyV2xq+u68w64EhC4bGCUahYmENWuBJ7NCKbrhcY2Ikswq/9xfvhlfPCgIkrJSU33V5BJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRtBSDH12tEMNnwB2CrjRgVTq8OUaB43Ub8hSl9pWBU=;
 b=Mn3xaSJ6eWvPgMSHusQJVkiTMLsmDeJzZTwiaySHYzRQXw4uBrC//LlU7fwTaa88OoZ8irSXQaqn2nCZyHDMib6IfzxRppz7oMrHdaMwdvzJg37C8bhwIy3kT+Rc7D2BnpqGYabV/hC9D8Yd7ACSUkwhAEerGUcXCIbZsQwxgpvWQfUdm3VzzO2oMA71exXLGJTDWKlhCyGlc/D70yeGrtmvSRSYe9MgSIe5i0eMMOaQdk33oMoF1mW51YEbTZImD1HGRsTVyY/L6OB0IvQKE0nUshUpwL6cOuy4QxTOdNBxGFV8tcz79ZTFfwZ6Vr2syndPr+kZqQMXPPdaRDFf6A==
Received: from MN0P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::9)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 10:09:32 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::59) by MN0P221CA0023.outlook.office365.com
 (2603:10b6:208:52a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 10:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 10:09:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 02:09:12 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 02:09:11 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 13
 Jan 2026 02:09:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Bagas Sanjaya
	<bagasdotme@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, Shahar Shitrit
	<shshitrit@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2] docs: tls: Enhance TLS resync async process documentation
Date: Tue, 13 Jan 2026 12:08:03 +0200
Message-ID: <1768298883-1602599-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 7673cd11-e0b4-424f-60a5-08de528bd83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DB84NpIVbu66kWKNhmpVSkR66UCMlzUpdWYmAUETIajACPxQAOldv7GhhcBn?=
 =?us-ascii?Q?rM+r6kzabI9zaNfu3P1p/N39bh03O0VgbFnc8xpkkIIvXtLIsdTyOsvix9bq?=
 =?us-ascii?Q?jI9UkoO290gigT1SKYZClW9giFu+jV9OnHxBH6IPv0wzkeHzMXRg+/RXfsX1?=
 =?us-ascii?Q?LD0mL23TOaYh1KicLNChCV2zhwLaaCYYGpsTshD7gEQjCdDKza83gqw+7wpQ?=
 =?us-ascii?Q?A2BVBoCl8u/SF0y5JB7INykYXllcMYGVF7lSoyvwySVem+C3dZboNl1zpo46?=
 =?us-ascii?Q?bVQ8cb7njuriE4htc0R3V2kIRB9DuCIGgfEZucQDHL9uYJ4Wokt4L2E7UT5E?=
 =?us-ascii?Q?NRQwQNjHoIHbUMTnySmuBYMnZ7b827zrGrSueJIyE4EEhve6iZ51E21He+RM?=
 =?us-ascii?Q?an76KRLc1HkrJzD85kDOndVLl7GL5xcmbOQ76Om7vpJ6gEY04Rw6xmLsOV2S?=
 =?us-ascii?Q?dZ8UEKgH+vWkYBaeXP9l1cur7JfQGToWJR8DY89euIzdosuBB7njGyo7s0z+?=
 =?us-ascii?Q?DBNhYqlFJ6JSCbGMiKqfmEzbqnYsHhLhIX5n2VcbfKVPTJ4m/M4vAzvr60Zq?=
 =?us-ascii?Q?F83FTEEgveXXFbDa42Mec+uAy0MV3NEjIJqAHf791msu5t8tQw2AvbFkXBxE?=
 =?us-ascii?Q?M6Q1G/U/KCdXpwHoO3UdAko7NOAfOXmc/LoJi8TNIoWRat9h0oADa4NpiJhx?=
 =?us-ascii?Q?7zbu/zJXfDvDG6IVVTPYXREMjPlgrn3+KlcZDd32oErjoLiAb4hm6VXEnnrf?=
 =?us-ascii?Q?npbmtkJOB5hhDzkoL+ORL3rrgsV5JDYsrHa0zVKoSGzwwpJSl22cq2gcTd1u?=
 =?us-ascii?Q?HZMQb9GY4vkQ0yZjWetrIAj1s4rgfi9F0QaFI++E7trR4vWUzNiutJditbrY?=
 =?us-ascii?Q?GqQM/u5X2eiAN8k2Ozbn+x+Uw5MlyGVdH/iXDFIRxV71TK6r5fVZXW/Aokm/?=
 =?us-ascii?Q?9Q3G3/LHxOrbR1eGF0Hf5ziJODHZ0E6D36DnjnaWV/Kb1QCv6auj21vAuxgG?=
 =?us-ascii?Q?kcserhPgTVgUbxtaqBMu/yMVWul6e/8LCrNJKSbVv51M/EnILJzRtNuFwYEz?=
 =?us-ascii?Q?1b8weKpXB4uIKL0ZgVC7xBjHCfHIfa8p6oou5q7WVqKgfvdLccMqaFq4P2G+?=
 =?us-ascii?Q?0dSHmv3ZY5Hk5+ax8AqsVtXGY11fTJBZQw4U7bHKJfx8DXGZXHzrd0LD3fPQ?=
 =?us-ascii?Q?ktf4j6CddGL6moIOZp0jtaaPQWSxj/XmrCyly0o9KPVxzYek8wOmZ+lQKyB0?=
 =?us-ascii?Q?dbAYqIbTEZ6obRQrwH0JeO7dV+DJ6xhM8j1IjF0Ht3CHHXJaOwGCV5niKLBo?=
 =?us-ascii?Q?PK4oUvcdqP1b2PAlXogBR1RFs4FZwzecPeG93aEQXAZBVbgpwvH18FrvdE4S?=
 =?us-ascii?Q?b8JlihGUTiZlejdABx+P2yWuZFgt3/RJ78erjguu/7D7CF8VQpMDd+VMt1On?=
 =?us-ascii?Q?M/jO9NUPUKvNBPacNYyeRmv3hVknXLQg7xBWUQifrOO77vQRdJev4HLWLklQ?=
 =?us-ascii?Q?HQ5tgxHPUTIAO6SJKUB8VPJaHZNh/MU9teUgBEP4yDFOlCVBTPi4A4f1EDpT?=
 =?us-ascii?Q?4s3xBVWn0g+obpdDuSg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:09:31.3034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7673cd11-e0b4-424f-60a5-08de528bd83d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

From: Shahar Shitrit <shshitrit@nvidia.com>

Expand the tls-offload.rst documentation to provide a more detailed
explanation of the asynchronous resync process, including the role
of struct tls_offload_resync_async in managing resync requests on
the kernel side.

Also, add documentation for helper functions
tls_offload_rx_resync_async_request_start/ _end/ _cancel.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/tls-offload.rst | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

V2:
- Fix style issues.

diff --git a/Documentation/networking/tls-offload.rst b/Documentation/networking/tls-offload.rst
index 7354d48cdf92..42800d86d269 100644
--- a/Documentation/networking/tls-offload.rst
+++ b/Documentation/networking/tls-offload.rst
@@ -318,6 +318,36 @@ is restarted.
 When the header is matched the device sends a confirmation request
 to the kernel, asking if the guessed location is correct (if a TLS record
 really starts there), and which record sequence number the given header had.
+
+The asynchronous resync process is coordinated on the kernel side using
+struct tls_offload_resync_async, which tracks and manages the resync request.
+
+Helper functions to manage struct tls_offload_resync_async:
+
+``tls_offload_rx_resync_async_request_start()``
+Initializes an asynchronous resync attempt by specifying the sequence range to
+monitor and resetting internal state in the struct.
+
+``tls_offload_rx_resync_async_request_end()``
+Retains the device's guessed TCP sequence number for comparison with current or
+future logged ones. It also clears the RESYNC_REQ_ASYNC flag from the resync
+request, indicating that the device has submitted its guessed sequence number.
+
+``tls_offload_rx_resync_async_request_cancel()``
+Cancels any in-progress resync attempt, clearing the request state.
+
+When the kernel processes an RX segment that begins a new TLS record, it
+examines the current status of the asynchronous resynchronization request.
+
+If the device is still waiting to provide its guessed TCP sequence number
+(the async state), the kernel records the sequence number of this segment so
+that it can later be compared once the device's guess becomes available.
+
+If the device has already submitted its guessed sequence number (the non-async
+state), the kernel now tries to match that guess against the sequence numbers of
+all TLS record headers that have been logged since the resync request
+started.
+
 The kernel confirms the guessed location was correct and tells the device
 the record sequence number. Meanwhile, the device had been parsing
 and counting all records since the just-confirmed one, it adds the number

base-commit: cbe8e6bef6a3b4b895b47ea56f5952f1936aacb6
-- 
2.31.1


