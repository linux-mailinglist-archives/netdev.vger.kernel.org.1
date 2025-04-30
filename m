Return-Path: <netdev+bounces-186984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA38AA462C
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BC046222D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD3D21C163;
	Wed, 30 Apr 2025 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gKOQLS0W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150921B9DB
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003562; cv=fail; b=MoP1ptDeL8dwkqhBGbD2baF3sUrLA4mzED/FwiedUbIaNxTXiiPywPCu4GBlal36QyuhY07sVIU1eLDDhkSPW+OdyZfI0FA6TcMRGDp2RgkuBWUEhg7H2rs3LN6vyG1KDDlPFVWz42Ee+UWdFNmP+vCJTytEPtvonw8+2Fe/0jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003562; c=relaxed/simple;
	bh=YZXQP/8qs4AHgq0LVEreRzEEMW3lr52272iHKRaZk+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sBxM0m7Umah5FLbH+1+hNO4PkIFXDaEmiWZrpt7fUbr8lq2tcUFqzlQn5t4NZE35GRfCjPHsrigRTQnII5a1R7+Y7EMJLckt2POiiQf3o6XhOKeh8ne98p/9EhNiiU1nrCnThN3+jSP32hauxJoTC8QHBsYRbm1OLIDbor2Maww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gKOQLS0W; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXCG8VQR3N30FTpE7V4xwyIf2xIoP/u1ugkZtMPyLjZ/62CMWtY2OxzzF/Jn0Z8S9g6oE2KSh1rODRmzN+nk1J1sRBBnCfREL83ki/m903e8OJdJREddOGlw8j4pbkoAJ5rQf+prG0ghcvihkj0lGlgoTKyr83Glr/hKQxRejX/rM+ThevdYfOI6g+tEfPLeqit5dAkrq1GW49hwtB2JSTJosA+2MBw6tSsffrrBtjsM5Z8RTooVkvRcQ27qcLZoa1fcmKDiuQZPlbCCamA+wUCiEAOxL/1aEfLcsIqm2KDU5gnSivVl1nIR9WHDpxmZtiQ0g8QeInbi7ft6DyMMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWyjuESRIh1LiKwGCAPJrIFonjm+MKnAK02ghDKM5Xk=;
 b=St6uC7yWWrKTKfGwzqGoaX7RLKVt/gD1rY41Cu6Q3zse+bYlzJlUHpA6tkVkHC8rQYkDyFJh/7llLfrDTY6YwFIv/Z+M6rwooAavvv88sOecY/yYX04f8//gQWJo269ml5GQ/YrFqY5t7k/tv5JSfNxJ3f6LctJFj3IUAOTqwRL1C3cp2e+a7pxk5//pKtU+sOslbnA/U4ojoUp6NenQIdcsr9fCvgltCFLbCwqryXgv2UHO4+lcrlqMBpliwr8AhkOKUtj1+B4wACfuTsivq5dqX+n4PfCQrZGftnZNYJzSczQqAYt9kJZplHv5keKivduMJG4lwUGW2bYH4sn4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWyjuESRIh1LiKwGCAPJrIFonjm+MKnAK02ghDKM5Xk=;
 b=gKOQLS0WeGASlqbQwJ300YslGnaj5ftx47l+GdpIpSfapAqxqnMqAd9mD1urjKJ1eVON897Fu0FC+dk1/b10Qrb5rKY29+K9ODYyN+hPtChHfjAy33YoVWQph981hiv5MYaGY7fWosfELXphRjZ1YxweLeD63sH3d2b+Qpv58UaVRoyE+mq5+sy1w2mrq4qmsdomvjHQYiArp5UYMxsVQOebW4G2ITp5NK5xPnp8VO6gYOey4H99wmGkBrF6Diid8KNbRn+z6IXOHly7jV+wi1861an008v14dH0BzSqTMYg8gZlxiqp75HeayOug26+BXYHB1AAftqaqLO7sS/YGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:59:14 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:59:14 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v28 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Wed, 30 Apr 2025 08:57:38 +0000
Message-Id: <20250430085741.5108-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 1082a32d-4a70-43cc-a804-08dd87c54838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8P4Mls9MZE/9ONBBmeHUBsddBhn9FYkjm6qQqUExM6rSB1Qb40nGc5zmeSr9?=
 =?us-ascii?Q?FkLL7RlUwNf9s7+eVITrt6c3smaSuVZrBEM0SHmBZqoMtYsSkZQbSQj8i0wD?=
 =?us-ascii?Q?WlSRT7bUHEcp4RbUm0PkNa+I7p+/jcuTy1FrcYZOB/ec97IauK+qkq2PpQYJ?=
 =?us-ascii?Q?/VdM65Qrq3N1nH9yu+iYMUETupmwF9FkEpOvHJOsqQTLguMRXXTjOUvdg5GQ?=
 =?us-ascii?Q?DczJRwB3i6bVvyaf4FOZ7tkp1I2CFHFKWH2O5IvTokPpPGdM2oKz570CPv3g?=
 =?us-ascii?Q?tI97tAuVoWnYrjhzxMnIjemEsY+9DsMXbtjzJQJBy7ep4kNvtrN0niv5cggt?=
 =?us-ascii?Q?KmCswQVdkNjBXPAMVPv5w/vptDSsnfyeyPQaPVTZ6NtPhV4FkeSznhkkTL0o?=
 =?us-ascii?Q?qHx0/m8T3wOzhbQXR1a0UIhcMH4RNBu6va36lmxAtlkbrnJOBeC0hchvQAkS?=
 =?us-ascii?Q?1cBuKbRkTLvHfIqTU6s8bak1Ad/tl2WY47yx6OLjTZ96yCCOCbBVvr7stMSU?=
 =?us-ascii?Q?CKjVuA+BZTJouvHkaxoXlMh9QAvoaC+Jaie/r/2z5Z5OZyBQ1/Fx0fczFADs?=
 =?us-ascii?Q?2yER19CamHTtinBm/CYUzLm8T23Z/zjh3IW8E8f0+Xe+I+u2V16EF6rj3g3t?=
 =?us-ascii?Q?uc6GcjDe0prvU1aUTrsyXbVQQM2URFDmzGC2h2OvSpSQmBZJHE5OLFndhTut?=
 =?us-ascii?Q?wpkN1qQ9jSS5sBsZ9A0ylZgtB2yBPKNAn/TmeERhzf5i+FuYiYuTSLKdYRXs?=
 =?us-ascii?Q?jH5ZCC2f06on1j71iYzpVnSdMid2kchdZTb3XJENBkdYcUQvO5a23Gewf7dn?=
 =?us-ascii?Q?9fFARex6u+zwmmRhafNtqPsEylEE3iKTVfLmmEnH97DOS96d4ijB2TWs1JXa?=
 =?us-ascii?Q?lWpwvPJ2F3ygyrwcM10DZEEY2vxgNe8azFUhcJiulZnu0jfQtPwuRptOF/wm?=
 =?us-ascii?Q?I5aqD9S1ZogH8158A9txOAgV56bIMxXz3MvUbu1tsimEh2yLEZjXhz087oEc?=
 =?us-ascii?Q?K/0mILE9Xtjkk83DI8xqIoP4tAf+1b/X2F2bxejXr0kLWYXF5V7gMefC+uzN?=
 =?us-ascii?Q?/WvOrrdBhJHasd/MLlvCRUrIUIx3h2P9rNL3Mk+LzOSLLDHSK51wsaja3CKb?=
 =?us-ascii?Q?Dccp8VfqveQ4MsXfl+iHZc1XR0ts8ODWiKiDCuZu2ZuMtGFH1nUC1yut1WHR?=
 =?us-ascii?Q?3UqxoxWllHosC5a8vd9OramX9gfiidv4T354DMRaHyLM87ptUQTgJ7+8KLDK?=
 =?us-ascii?Q?2Ub8ZyjzP1mSsAIV2J/5uqxCMDvgRShbSWjaElHx2qM59VUYCb9fBLaGIbSX?=
 =?us-ascii?Q?plFAv5iRG9cyrwstUsBr3EjsHsuscqEWhSAN65q7MJl/nzO4LFhwB4/CCCnU?=
 =?us-ascii?Q?yM/BHcKQeE1dOa2PMUZcbs6FoFYxQfg5n6pJKceAzRH6534UDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/UTJaWe/UE2v2IK1rrIzzR8iXq6YSGtpfel/P4YglG4DU/6mjamx6jlHX3j?=
 =?us-ascii?Q?MXe2Vl4NxF0AuufMrwqs4E1+dl7ByAmTyqf9gLFvN8tAVoRMNvPIGgerplFy?=
 =?us-ascii?Q?gS1X+jx/J9HnbIPKwlsY2cI7zHRkykrNJ4stEoHjmN85HVbJYEy7F/pMWaLh?=
 =?us-ascii?Q?fYkwZe2+AsNPIPoOyLzWsN5RSYeyYqjbB2j26Uso2B1Xe7k8xBAiu5qXjqf7?=
 =?us-ascii?Q?3inpe4cX+Wavary2IfgKIXqZKNl7RawwSbg2A1DvHGMq57tZLeilXbOJmit2?=
 =?us-ascii?Q?KFuUxFb9nE2s+XFOtGe4LkQ+Oq4/w0UNMXylm7nXchgqLRFXYCHB9L4nPr9R?=
 =?us-ascii?Q?3fDpUyQnFMz4y+eiwEs3260+YEeRL5OrtGDTzb2tIHtaPQNOFHQvo8j9FMz6?=
 =?us-ascii?Q?HFnPp8cdNt+0957nCXqTNN0sjPkQ0vysLUVisthH0O+CM98bAM2W9MDR+6Vp?=
 =?us-ascii?Q?UNek3VcpnOT2qZ++QfMxnpdE3j0CQDtycqPWhlLN5I4t4gm0h9RGpNYfF2Hs?=
 =?us-ascii?Q?3+jRatqMj5QywOjXj+bRUv3xQuBgMnH7sSjQhK1S7hwvWR3Y6MjluPOHo+p2?=
 =?us-ascii?Q?wsBUNWu13n+UZ20Y8urtSbAa7X/YuWk0Wgj77RGEN/ZJ8R8WLBAUhfFfuF+e?=
 =?us-ascii?Q?GWl2Oxm1/f0+xe/wlCVwhLZ6EgZ/BEMaMbiMEFrchQrK1xxac3BwAOZZ/l6M?=
 =?us-ascii?Q?6VNbbbxuelJEwCR8wQbSd/rkyrrwYeTS2307v+lQKJ19mQfj7FrWI3tipFLG?=
 =?us-ascii?Q?EOsJDKy1aCbEbJVPn2elfqn/c6N4qTv+WaqYJ1llCGovjRWwPE6bhzoYUbNI?=
 =?us-ascii?Q?ciXqvGhUamJ6WQon+YQ4jqXdMTrUZNzhDaZPSx3CtBxNh3C4A06yhRZuzvFW?=
 =?us-ascii?Q?IVPddzVpPbF+x0a9ywPSiQD21ukeSCeD2I6uMThJgUXNzNrlo/B48JH/ttOG?=
 =?us-ascii?Q?UxV3Y+qkj23c4vPs5IBnVqwWOgueVIMcHySsIenQStFUs3V3KiCe5VZjC6Ej?=
 =?us-ascii?Q?LkxI29vhZtXLwQv+K0u1EMxqNjyGuOqRy0WyUN+jKrbTiSDCjrf+juoaoQHY?=
 =?us-ascii?Q?l3knzuWfYg0EhuGqItVTirkVjwCT/teKeZyV6iTGjx/50sRjrHlxv3YiWcql?=
 =?us-ascii?Q?nLzFvRNrJ6nX3yA585hatwR3gazdGejzz74eqx6Kz3zU0pL/+qbdfvzC3caA?=
 =?us-ascii?Q?Py+IJqUgNtQi1Z7ps0WEquGU4yURbtnTz3AZ8Lqt/NSapCHI2aONyvMVDwte?=
 =?us-ascii?Q?/O2Hc6okU7+UrqZiPJ3xDujjE41BRB7EETXVYLjF1L6NhPja6XLS6cVfdOky?=
 =?us-ascii?Q?GIcKaMorom06HktWnCpPgi6F6Cyi9hlKOKV2O5OCXdlzWW6OFMbCKCJsqzRO?=
 =?us-ascii?Q?Kd2hNBaG27RcAoMQIUH0L3FnLLrTxJSIURPDfs2BfimaYFUTES0s2zfl7mwN?=
 =?us-ascii?Q?i1jIQtJl3fvX+5xSYCMkFBZKLegQdHXWqpzLJT+P2NzgP+rz4s5TZGgPzU1G?=
 =?us-ascii?Q?f4Yss5JGHMNrdtuTMwQnJNQd7H5qXLvyO6dKPK3KmME7ZahshvY4UlIZ9NFN?=
 =?us-ascii?Q?2E9VtwwGF/LZEpBcZBBVnW1Ph1wiY9m+eB/l910G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1082a32d-4a70-43cc-a804-08dd87c54838
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:59:14.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xu1CjKZiNRU5lOQpYCB98KnU0cC0g5fWQzopwPTjBVeOPDYn12XbZavPV0JRw/rajNP7rjE75lU3L8VYbJZlCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to perform
direct data placement. This is achieved by creating a NIC HW mapping
between the CCID (command capsule ID) to the set of buffers that compose
the request. The registration is implemented via MKEY for which we do
fast/async mapping using KLM UMR WQE.

The buffer registration takes place when the ULP calls the ddp_setup op
which is done before they send their corresponding request to the other
side (e.g nvmf target). We don't wait for the completion of the
registration before returning back to the ulp. The reason being that
the HW mapping should be in place fast enough vs the RTT it would take
for the request to be responded. If this doesn't happen, some IO may not
be ddp-offloaded, but that doesn't stop the overall offloading session.

When the offloading HW gets out of sync with the protocol session, a
hardware/software handshake takes place to resync. The ddp_resync op is the
part of the handshake where the SW confirms to the HW that a indeed they
identified correctly a PDU header at a certain TCP sequence number. This
allows the HW to resume the offload.

The 1st part of the handshake is when the HW identifies such sequence
number in an arriving packet. A special mark is made on the completion
(cqe) and then the mlx5 driver invokes the ddp resync_request callback
advertised by the ULP in the ddp context - this is in downstream patch.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 150 +++++++++++++++++-
 1 file changed, 148 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 91865d1450a9..48dd242af2bb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -742,19 +742,159 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	mlx5e_nvmeotcp_put_queue(queue);
 }
 
+static bool
+mlx5e_nvmeotcp_validate_small_sgl_suffix(struct scatterlist *sg, int sg_len,
+					 int mtu)
+{
+	int i, hole_size, hole_len, chunk_size = 0;
+
+	for (i = 1; i < sg_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size - 1;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (sg_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_big_sgl_suffix(struct scatterlist *sg, int sg_len,
+				       int mtu)
+{
+	int i, j, last_elem, window_idx, window_size = MAX_SKB_FRAGS - 1;
+	int chunk_size = 0;
+
+	last_elem = sg_len - window_size;
+	window_idx = window_size;
+
+	for (j = 1; j < window_size; j++)
+		chunk_size += sg_dma_len(&sg[j]);
+
+	for (i = 1; i <= last_elem; i++, window_idx++) {
+		chunk_size += sg_dma_len(&sg[window_idx]);
+		if (chunk_size < mtu - 1)
+			return false;
+
+		chunk_size -= sg_dma_len(&sg[i]);
+	}
+
+	return true;
+}
+
+/* This function makes sure that the middle/suffix of a PDU SGL meets the
+ * restriction of MAX_SKB_FRAGS. There are two cases here:
+ * 1. sg_len < MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from the first SG element + the rest of the SGL and the remaining
+ * space of the packet will be scattered to the WQE and will be pointed by
+ * SKB frags.
+ * 2. sg_len => MAX_SKB_FRAGS - the extreme case here is a packet that consists
+ * of one byte from middle SG element + 15 continuous SG elements + one byte
+ * from a sequential SG element or the rest of the packet.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl_suffix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int ret;
+
+	if (sg_len < MAX_SKB_FRAGS)
+		ret = mlx5e_nvmeotcp_validate_small_sgl_suffix(sg, sg_len, mtu);
+	else
+		ret = mlx5e_nvmeotcp_validate_big_sgl_suffix(sg, sg_len, mtu);
+
+	return ret;
+}
+
+static bool
+mlx5e_nvmeotcp_validate_sgl_prefix(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int i, hole_size, hole_len, tmp_len, chunk_size = 0;
+
+	tmp_len = min_t(int, sg_len, MAX_SKB_FRAGS);
+
+	for (i = 0; i < tmp_len; i++)
+		chunk_size += sg_dma_len(&sg[i]);
+
+	if (chunk_size >= mtu)
+		return true;
+
+	hole_size = mtu - chunk_size;
+	hole_len = DIV_ROUND_UP(hole_size, PAGE_SIZE);
+
+	if (tmp_len + hole_len > MAX_SKB_FRAGS)
+		return false;
+
+	return true;
+}
+
+/* This function is responsible to ensure that a PDU could be offloaded.
+ * PDU is offloaded by building a non-linear SKB such that each SGL element is
+ * placed in frag, thus this function should ensure that all packets that
+ * represent part of the PDU won't exaggerate from MAX_SKB_FRAGS SGL.
+ * In addition NVMEoTCP offload has one PDU offload for packet restriction.
+ * Packet could start with a new PDU and then we should check that the prefix
+ * of the PDU meets the requirement or a packet can start in the middle of SG
+ * element and then we should check that the suffix of PDU meets the
+ * requirement.
+ */
+static bool
+mlx5e_nvmeotcp_validate_sgl(struct scatterlist *sg, int sg_len, int mtu)
+{
+	int max_hole_frags;
+
+	max_hole_frags = DIV_ROUND_UP(mtu, PAGE_SIZE);
+	if (sg_len + max_hole_frags <= MAX_SKB_FRAGS)
+		return true;
+
+	if (!mlx5e_nvmeotcp_validate_sgl_prefix(sg, sg_len, mtu) ||
+	    !mlx5e_nvmeotcp_validate_sgl_suffix(sg, sg_len, mtu))
+		return false;
+
+	return true;
+}
+
 static int
 mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
 
-	/* Placeholder - map_sg and initializing the count */
+	if (count <= 0)
+		return -EINVAL;
+
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < count; i++)
+		size += sg_dma_len(&sg[i]);
+
+	nvqt = &queue->ccid_table[ddp->command_id];
+	nvqt->size = size;
+	nvqt->ddp = ddp;
+	nvqt->sgl = sg;
+	nvqt->ccid_gen++;
+	nvqt->sgl_length = count;
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
 
-	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
@@ -777,6 +917,12 @@ static void
 mlx5e_nvmeotcp_ddp_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue,
+			     ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 struct mlx5e_nvmeotcp_queue *
-- 
2.34.1


