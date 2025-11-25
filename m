Return-Path: <netdev+bounces-241416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C1C839A2
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BE1834703A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61598277C9D;
	Tue, 25 Nov 2025 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dS1PMIN0"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E0523A;
	Tue, 25 Nov 2025 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764054083; cv=fail; b=WmSe7tUkDnTcRHbrsfjjyaShEzzw2DVAUDctg3a2WIPBACf1CKafCHkYrq3amgJ/YRJk27T5KKs7i0eQpW72qLtwJ8zY5jz6jPicCoqezYNX20IYb3Eeh+/LMlA+dX9ojnIAVG7wDxxc/rtcwqcHteZKPNm6jJ5rmwGDhbtzOnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764054083; c=relaxed/simple;
	bh=ifxKXpa/OMdfSIcA/mDu1KRAbedyR73igMKRiskzZWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mP9pbVUOr8CvWFdKcbmgIyA8gWpuSIMB1/rSjS1DccATpNZKjT9u31S+wDw573xf2huBPXAmptYHZF/oRLdkP0VLqvJ6NsefTlYJXSGUjNwczrJrtLl1rdeByLvJuDFDAaTxN68115xiP7psVIJRVpY+MCFoydzZXYbSkIFir90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dS1PMIN0; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbhhIW74UN75rFD5iluj1EBWTMK8DwLw+fEwV4EjZyX82B35zBTiApjgy8D5HhPdJMfjzm0T1e5+npein+mwoJHJiwIMGekuRMmxULE0QJ/vLQV6ZBmgoqqahY7gu0OhZZcW2XY80nFMfMZbrKJjqX/Ac3U/XejgPVB7uV2cy1ZKp7h/7RC2k3yBLmvlFbP/9THHiOGuzDoTR8roLwGauHCRgdtnEVbWOPDtvQKjrfA6SQpwrKXZER15HAX1K7z54adNYWINT/Pu6igVEro9VawsCOnCzan0wYxhedhuFX0HeXWXHCGw/2P1cj45jAcbrLKoI6+AEcycF2NFpiFrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x05dfVfJPGCwJXyMl6by4kWH08mp9vvUhAW5xagjldA=;
 b=PO7o80kcrEebfb5OlTBbyrx3LuXyz+2thP69CONceTahmIMjnb7W7pUG2hla2BZ90anBr6+9Cqt+WOBx4UHbIHtDP1itZqZG/lW4gA5BZ4NOCT/9RpQk/aB4aBwRPxliCHKQ4y8gBnbzNd65dTpGFWI8EagNY4lN1NZyjyvowh9pc/Ij5s/jj4QbDo+4z7RUzlsJimFtU441gS70DJ8YTq3WwHz8NXJik0wIiG3O4uHcFWlhhg8Gw0FDrsIlrwjQ4JEPIGcvEK2mQXv7am7giX7wXiLkXjA9STTGt/Kl7sm2RErd+2/WyG0y/6JO4zV75aQisswzGAbJIMynUxG7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x05dfVfJPGCwJXyMl6by4kWH08mp9vvUhAW5xagjldA=;
 b=dS1PMIN0yJKVneEsc6jymQXLxqbm2bnGPbkC8q59DeyF0TovQrGLxG2bcUdsPsF1BtQwE8I1JsTF0qJ12kVgdKOJWTdB4S7jMtJhQ7pBeWqNSmL6iU5IQa3Xy4/NxIOjZgeu3GIG52yYOSe3YUdjXvaq6FM2NMKElz1lr47sQvApym3BDfIBzBhifThExTHuBbW//uuG/sWZ/8C6GrAhW+u1YIZfOy5FUnkrAnvLOcxjlyrfYqgb1A6CR8kT8ePCkNroM6TRb19bVC5PKaIGNv0NZaY14/BVi1AGnePqtPxUszg5hZp8SDBI+HBMgTmtBl3kpAYabGdQDQShMQgQgQ==
Received: from SJ0PR03CA0382.namprd03.prod.outlook.com (2603:10b6:a03:3a1::27)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 07:01:19 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::fc) by SJ0PR03CA0382.outlook.office365.com
 (2603:10b6:a03:3a1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 07:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 07:01:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:01:03 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:01:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 24
 Nov 2025 23:00:59 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Sabrina Dubroca
	<sd@queasysnail.net>, Shahar Shitrit <shshitrit@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next] docs: tls: Enhance TLS resync async process documentation
Date: Tue, 25 Nov 2025 09:00:37 +0200
Message-ID: <1764054037-1307522-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 948b2d4a-8050-4482-a78a-08de2bf06f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RGb0UoKeNZSp13IH16qjtDRkUVKBjycCOVZakJXI/LUsM9phbs9GzLc7BJQj?=
 =?us-ascii?Q?gVgM7HxWIMzwveM8IXx+JpcBQdyK3p2Hnhae/W94QzliZeeabs/Gz6Q8noPy?=
 =?us-ascii?Q?aZJ6HflIPiv9eZPWmDepObotRCp8Bofviz1Rvqldztf9LogFLfVHP/1zL3bV?=
 =?us-ascii?Q?mxNyokQmm9mY2nETKMID/XGw/lIX43bhT7UxjMDCUW9RXkGqW4yLhEvRlbVS?=
 =?us-ascii?Q?G9XGDTtL0gmdCrOCO48K8nvQgnkqR0xOfiETUa8vLT3vRA7GXmb++4vfKX6m?=
 =?us-ascii?Q?SSE/iXFz1j0IlRdnDqR2yH2AJ1lppjy2aR3iFgL6hutmWWpYYjUBPmzQVON7?=
 =?us-ascii?Q?Z/73G6GLiG6EeTsMQ9cgHWK3OFm4o/tn//JDG8EYpn4rT2+ZrmfOEoD6DhXx?=
 =?us-ascii?Q?evQNRRy8MMM+lW0v7ICNX3mtPFPg+FFi/UXzyyjol0XnEKhmvAaNDJiIgJp3?=
 =?us-ascii?Q?sA6fMxIYVIYyyx84F00v8UpTkK/JjPAV34L48J467dP5zZxlqbUZtPzK006u?=
 =?us-ascii?Q?b3j4dvqvnz9jQJWc2KSMyrk7p9Q+hmpzYkgZvsa/47QhxWjNXEjSSpmAhYcN?=
 =?us-ascii?Q?YwEoO8sFrilwRG4W/KdZOvebLGfE7kXZ9mmkHPDk2ydp8aXUbXO7iIqzFr9G?=
 =?us-ascii?Q?LcQFT+Pi2g+HtBr0zh9mmyAtZB/rgQUZNdc0lvomO/nFBvLV5OAr5rwHDg0/?=
 =?us-ascii?Q?jvmHmKwekEicLxqISrwUveQqdlIkBc/bqZeXUjX/FVajkdeiCqQ1F0/urEwL?=
 =?us-ascii?Q?IrinNtGCDloc5zVwfrQT1VbDGjg+E1To4ryrrL+7Pyen4yiQoAxUGtDIfyH8?=
 =?us-ascii?Q?6KzybG9uAhHosRmy+IG2140lyB/r6MQFviaFxyAYgmlxdxEJ3YeEIk46/tJU?=
 =?us-ascii?Q?jNmcj4l5FGWsn88egrcoMriXyJhQQg12WS0kur++NjvgoOz94e1AqVjiYmSR?=
 =?us-ascii?Q?pQKwNNCnuKWrjQsDvol5al1NGD/8dZTB1e4/m6DCexbcxwYXFkF+ZruQVlB4?=
 =?us-ascii?Q?zeM1eLsAYwbvdqF7hgPM73CqMvF+sBIDUWViIkuTYrrSWtozkI5wvkmS6hGe?=
 =?us-ascii?Q?6659J4JiASPVBA5Y8+/X/oHDQel7B0d8gL3C0Ans352+iFFGHMAWVmB9bEBP?=
 =?us-ascii?Q?cLFBf7GaJu0q0mxkNPt8TujieVwNY/V+6HqccJRV7x5jdZRfs5r24xtNj4HF?=
 =?us-ascii?Q?2Gtmb6ok2y6Zow3H5WZm2hib18CWYs6FuYllREwVZwBo3CvgBuqw3j1iAAJH?=
 =?us-ascii?Q?+Q95lpdqnlQdvM5Uf0UWOvldNd6YGhJ4epe/BcN5s12Vc1hX1eQjgv7WbjKF?=
 =?us-ascii?Q?89VPHnA3HizvbxvRX1y2YZDEeSvI8ua3YGH7RxsUZrxtvkfzx6RxPGeCf01u?=
 =?us-ascii?Q?+pgjzNX0um2kGQlZYJuPriC+x9EP68jjUhvzp6Bwe9KQySrEydwFHBKWxMIk?=
 =?us-ascii?Q?NohA3aNQPHKLZdekvsL+L+1v9irymmgsNW68JHBi+hdAMG8Bxwx38E7lMNMm?=
 =?us-ascii?Q?AjN6y7ZlqLPmnmsH94RZHUfe4MO3CZ52va1G2+BH/ehFJYvsIlrys4CsyIWp?=
 =?us-ascii?Q?mvbj04J+RwSFlQ00mG0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:01:18.9144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948b2d4a-8050-4482-a78a-08de2bf06f1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

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
 Documentation/networking/tls-offload.rst | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/networking/tls-offload.rst b/Documentation/networking/tls-offload.rst
index 7354d48cdf92..6d2769316699 100644
--- a/Documentation/networking/tls-offload.rst
+++ b/Documentation/networking/tls-offload.rst
@@ -318,6 +318,34 @@ is restarted.
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
+- If the device is still waiting to provide its guessed TCP sequence number
+  (the async state), the kernel records the sequence number of this segment
+  so that it can later be compared once the device's guess becomes available.
+- If the device has already submitted its guessed sequence number (the non-async
+  state), the kernel now tries to match that guess against the sequence numbers
+  of all TLS record headers that have been logged since the resync request
+  started.
+
 The kernel confirms the guessed location was correct and tells the device
 the record sequence number. Meanwhile, the device had been parsing
 and counting all records since the just-confirmed one, it adds the number

base-commit: e05021a829b834fecbd42b173e55382416571b2c
-- 
2.31.1


