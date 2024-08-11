Return-Path: <netdev+bounces-117539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89C494E3B0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 00:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C812820A0
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 22:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B5F15FCE7;
	Sun, 11 Aug 2024 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="OGT/KI/c"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021078.outbound.protection.outlook.com [52.101.65.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FBC158536
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723415503; cv=fail; b=QjIveGkKldg1gqvTjPFmPp8B+ABPGHcIOU8hAlOlDq437k91ocD/wSp8SNKK9dkz9AYgnoC7ykS/5M8C0XlHzLyrDh0pU5RIMsInO6o8GmUm4Egsn2nT7z6jmbnlhHD8cwsBo4vOo/pxsrY0ZMjTWyTaWK7ZjkpBk087EwGlD10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723415503; c=relaxed/simple;
	bh=CAqaagleox9GJWiWznnRpigLliCyiPubw4iNEPgAJ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JjfpoKJvX6yzTr43IB5Y/hafK8eOe+AEIdIdku3fhiEX8PkquLaudZIAaeX1mKa2A/F6ePxMxFtULgDUR+uA4G/HF7oFAZtFeHMzJr5Qy892q17ILjTqWQtwHiTPotbuVnl7qtJJ0aQMKYBRKpudof9lfCvHmY4yiloGn7IMtMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=OGT/KI/c; arc=fail smtp.client-ip=52.101.65.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XePjIVEk4Bwi8s4W9Gw0lFQsDhxIAXTrWpHM5RAaCsDdisSBN1GXytyvlWnpWm/HZ3+Hc7d1ZhRxNVmDZxcEAZNyN2J+cPHpoifQzAt7UEpa/1kn+VZVKWWjgKb9A3pzt9U1TBVd58otNMCeZuDSWm7IO3BcNLxqa1MfcKPD6GKCO32QS+NLqOkI6TAT1auSq1dAWZ0Hs/jnY2ry/w4tPPAm2xoaMYMLY9+jYlOahTk0brx3wbMbD/3FBvE8WaVjEr5UHU57lEC1Zum2kxmXoWqykhWwE3LBrkKzs+/p+QkZA1/eA0qfhBOz7w45MNggpBsY/W8FyDurR8k2b9IeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIfK9MuJYjYCtpbTPwJI18VFKgiafj1xKorEn+ufoeA=;
 b=v49MMWN/O+9Nlv2jKnKf53vHC8Xfn7jBgOZDm5wwbJIRAZm5Nmbdpv9ThW2BjUiQv19TfEW1m4Xb2N12HMwa0cztDf+QjSxkyDAcC5pqLLIGQL5o282SWTd8qfAK7cAW9gswpkrpdh67Dv0fQsVNkp/UjIKlVwRoT5z+YKfXu18RBJJyR6THx5D2xUNJRQOeYyUOOsM7ghm0LzGEESqa4xTUpLMlMtDrjYEr567Yp6E76pY/QfxiO/l8FOfWbieMSueY6EixEbn2lm8DkWPKAAqOnm2c+Ilsj9/fmkBYnaSE7kpAfLu3rb2LHQsBcv35iB9RsQmTOK8CCiXypbFBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIfK9MuJYjYCtpbTPwJI18VFKgiafj1xKorEn+ufoeA=;
 b=OGT/KI/czLQvgv2NShMB7abTDPcEcJeGLACC9pr/O1Rs2A7AMdQqaAgz/2qkVbSq/R6OBz1xSwiyaON96h/MdpumC3YszmmpfeTAOHzxasv3F10RfIsHfd4tf27IpjIMsExnVyH+8gs+vTXa9RyV9XZg3Eu7/IKv3MUzJVads+o=
Received: from DB3PR06CA0015.eurprd06.prod.outlook.com (2603:10a6:8:1::28) by
 AM9PR03MB7427.eurprd03.prod.outlook.com (2603:10a6:20b:267::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Sun, 11 Aug
 2024 22:31:36 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::bd) by DB3PR06CA0015.outlook.office365.com
 (2603:10a6:8:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Sun, 11 Aug 2024 22:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server id 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 22:31:36
 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id E6C157C1278;
	Mon, 12 Aug 2024 00:31:35 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id D2B2E2E479A; Mon, 12 Aug 2024 00:31:35 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH 0/2] iproute2: ss: clarify build warnings when building with libbpf 0.5.0
Date: Mon, 12 Aug 2024 00:31:33 +0200
Message-Id: <20240811223135.1173783-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039234:EE_|AM9PR03MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddc079e-8442-4ba4-9f3b-08dcba555c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm85WE5aa001UlpPc09jV2ZtM0JPK0t3d05hQVVXQ201aUtpTHNlZUU3YUZO?=
 =?utf-8?B?cHVnbFZ6RGZCU0RkUkw2bi9nd1g0OFFtK002b3ZqV291NlgrNjVxNnVMZlV6?=
 =?utf-8?B?dTlSRXJLNERRV09VUm8rSEtvRkZZWVVjeHh4aEpNK1BHOWFwbjdZaXFVbzdC?=
 =?utf-8?B?QmpLNDlVWXovRkkyRzQrekpNb2dvaWdhRm14b25yOGw1bGs0T01UYTlvUFJV?=
 =?utf-8?B?SDFxenlRcGF6WVBCVExodEJkcURBNC9yZzNVSVZIY0phd1JXazh5Q0hxQ3lX?=
 =?utf-8?B?VmFMM1dWRVcvQU1xdVZNS2hmY1lqSmc3bzVRRUpsY29zVERlYmR0NXhHbVFS?=
 =?utf-8?B?bW9jazlEcGtXWnZabGpXb0ZTVXJiZ0NzeUw0ZmdURmIvL2FiQ3l5UGRKVjRr?=
 =?utf-8?B?T0U3ZndyalM3QmU5VVpTUnQ4UUFYYjM3TklaTzBvTTBRZ0VJY0UvZllSR3dV?=
 =?utf-8?B?VGNUQUk4RHhSNkNwRFJqaGVCakdCWllrVTRucHpka0g2TDVIbjNzZzY4KzhN?=
 =?utf-8?B?SHFvOVJzNXJ5dGhNdk90OUhYeTUrRjU2aW93YzJEeVorUE1Db0FJdDM3d21U?=
 =?utf-8?B?Y3dPQTJCMzRnRUNHdDEyMlo3K0pKN2hyZC9uYnR6OUlXcHg0cUFDWlN6OXdY?=
 =?utf-8?B?dXhUZG9MY1dxUktzQ1NsWDJJd2RCSmRGSnlUUjlJZ3NYN1dETG1lR09ML2ly?=
 =?utf-8?B?YVViU1NDaEw3ZXhyYlZ5NGYreTM4L2M5YXFKd2JSMzM2NytQT0tzQWpwQnFG?=
 =?utf-8?B?SFBVY05qeG94eXlMaVhCYlk3Qy96TDNacndGdDFtU0Z2bUdRbE9aSVNlWGp4?=
 =?utf-8?B?enc0aUhaYXFJNFBPUzd1aEI3S0lYOUlBcTlCUWtqK2trK1ZFUW1KQkFIYnNH?=
 =?utf-8?B?cFI4T0N4SHl6Y2tyaU5wOU1KNWFDYWR4dmFNbjRESWsxemx3bmxuekJSR21B?=
 =?utf-8?B?eU5NTkdDcVB4RFg3cDU2ZXBvL1dnNXFqdzhtR29hNHI0QW1jWWsrazMzMTAz?=
 =?utf-8?B?aWlVWGQrV0x2QzZmUFFRbVRhWDV3cU5UTUFMTVBRTWM3b004bWtjdDFjcVJa?=
 =?utf-8?B?bXg3c2d2dCtlVWFOR3lYckhoOS8xOGgxQXJMc2RXOFh2VE91YVoyUFR5dDQz?=
 =?utf-8?B?ajNOdzFkc1VLR1NaK21RbmVwVGxDNWZyQ3p5NU4xeEdxT1dYQWlYRTAyWkEy?=
 =?utf-8?B?OUhEK2l1eHNyZlI0SzB6NkNCMGNpRU5iMjlIQTJ2WS9WK2p2aDV0K0xzWUR2?=
 =?utf-8?B?NllwR1U1TUpYTGZraHNhY0pZbHV2ejA5ck5uVjhOTko2K2VQWEtLTEZ1VVND?=
 =?utf-8?B?QkE4eSswTVVJS3B5cGNERTBIMWlqTnFIbTMvWnp1UkFmeWMwREZpZzNIZHl4?=
 =?utf-8?B?Z3JjR292QlY1bXg1aHBHSWZUeHVjdXA5RXJPcUlzMDR4eG0wdjNpVENsaFo4?=
 =?utf-8?B?eTRCSXdTb1Z1NWFialFvcEJIS3ppZlh2b0w5akVpMmlSTm9ic1pFY2ZJQXUy?=
 =?utf-8?B?UGk4ODlaZWJ5RjhZbUNqOWVpQ2JBS0JSaFNyY0RNRDJ1bGhINWZDYkhoNUth?=
 =?utf-8?B?WlZiRkNDOStsSnRXSkFCZG9iL05vYWlSaUd3blROR1hqbGFzZUgyOUZLM296?=
 =?utf-8?B?ZU90MExwMTVsc0VWc0Fxa3JGalhwYXhjbmtGcysyc1NtYVJIdkNLS0IzbzNn?=
 =?utf-8?B?c0hNRWE1cFliUjdVb01wbERWVHRSS1BuTHRSSUhtVFloT0VlQXN3cmsyNnFt?=
 =?utf-8?B?UXUwYVgrV05xbmxiVktqSXg3R0Z2S1RvNko4aVRPd0gxeWZCNVVEM2FraW9P?=
 =?utf-8?B?L3VQK1cwa3Q3S3daYVkrU0l3U0xnSDgwSU9YbUl5Yml5SFBYNWpEbWNpREpm?=
 =?utf-8?B?dHRjU0V2MU1JRDBkdUdtZnp3clYwcVA2RHJOT1M0ZXlUTFllMXZMcU5aZ2Qr?=
 =?utf-8?Q?sK7T9AJSwG2Oge9bw0rvrlhCBozNEcfo?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 22:31:36.2251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddc079e-8442-4ba4-9f3b-08dcba555c4d
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7427

Hi,
when building current iproute2 source on Ubuntu 22.04 with libbpf0
0.5.0 installed, I stumbled over the warning "libbpf version 0.5 or 
later is required, ...". This prompted me to look closer having the
version 0.5.0 installed which should suppress this warning.
The warning lured me into the impression that building without
warning should be possible using libbpf 0.5.0.

I found out that this warning came from ss.c where a conditional
compile path depends on LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION.
Newer libbpf versions define these in libbpf_version.h but the library
version 0.5.0 and earlier on Ubuntu and Debian don't package this header.
The version 0.7.0 on Debian packages the header libbpf_version.h.

Therefore these defines were undefined during the build and prompted
the output of the warning message. I derived these version defines
from the library version in the configure script and provided them
via CFLAGS. This is the first patch.

Now building ss.c against the libbpf 0.5.0 with ENABLE_BPF_SKSTORAGE_SUPPORT
enabled, triggered compilation errors. The function btf_dump__new is
used there with a calling convention that was introduced with libbpf
version 0.6.0. Therefore ENABLE_BPF_SKSTORAGE_SUPPORT shall only be
enabled for libbpf versions >= 0.6.0.

Best regards,
    Stefan Mätje

Stefan Mätje (2):
  configure: provide surrogates for possibly missing libbpf_version.h
  ss: fix libbpf version check for ENABLE_BPF_SKSTORAGE_SUPPORT

 configure | 6 ++++++
 misc/ss.c | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)


base-commit: 354d8a36885172b6e27ca65ff85c2c51e740fda0
-- 
2.34.1


