Return-Path: <netdev+bounces-99095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7948D3B9E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C93A287BAB
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA73F13DB9F;
	Wed, 29 May 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JMQ7KXVg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE318410A
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998470; cv=fail; b=nuJf6BoW5LcTMBmL0c87wyaXVQjD/pS3ok11Dap0xGdXcWXQwGg7elgH6rNAN338Pxu8pFlBs9bbsaDdqpbFXpgAUGX5nZgxPRkubkZ6lDm92+JYaNjynaAWk0bWspNQ8lm+cGq5IRKeSqEGMv1vu6kGmljPK4QDfuKZX9GftIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998470; c=relaxed/simple;
	bh=9nN9FBbFPdaxZ+J45cmyefojxcGRst2pOrnop1goGBE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aVMaUSyBrW+tEFIlOmk4WbQ7b7H3YS7ohZzLMPO8eOFlnhAQSeKAHqzfgFp03UrWrXOBl3zPPC0ezYhrdlowFBBaWUO8wpMSQmnFqWiPifThO34GakxJhpS80Z3C4n3PSgJHeNlBCs/R+IR51cXcbCCsJm/pCb/XRGD6FgiV2a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JMQ7KXVg; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoMWGJEoZmx23kSxVdESxTpco3twCY2N2fqbnD1fdriBLGqbGSulFCs4VIUipD79+wlQvW4jHhyunxghIvVgYCOgsrh+LFF5jEXHp8LrcOuKgq/laD5xKIEkR1hZwdPcrGgL1vaFmSxeEUxDzLjE1J5wQHUfdohSz4ik7gtSXPjDrtZZUo96R7iXnNFCuFl924h6YWyXiIAGYRZYVXgVoYO6xBwfQKtX56pjBW/PnNFK4MRi3TdZxJtj8WOOJR4VP+35hWsq2LpqxhPeZrdKYOyiT2owvzyhZhrLXPbxoYotFzKF8F2cFbALu4QI8EyPCTg9Ho/K2c5riQrYcgFX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91xCzxe3pfFQl3dsSHAHpc4BuFOnixgwohEmhpedtBc=;
 b=nDrvGFs/JLPE+zuic6XgJaP3ddptCgSK3oEv/vmS2F91Er6vud/xBLHjno7DB0XDfrfbnAuTxKhMbcMf8a79pwZEennKZiaNv1IPE/qOHiAvTgjsxuXsst8jJIIsn1SHaL8LQxpVXgMwGpSv+GoX42jLsM2xFmZ0BmSg92oH/Q4fjD25sAUCRKsBa1VGbeVBmysGJ/nEWVw3WiOjjpM+EunP//w0YrIVcC710dZNl3TZ5NSTREnlteU70yBn8dIhwLFA3JB0AI/sDmUb6zuX3vRIr2+TC8u5TbU8PLFkX4fCWa8wcooBkQPXyhgQDBTv7J0jd//hkm4iIQ4Wn+7pOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91xCzxe3pfFQl3dsSHAHpc4BuFOnixgwohEmhpedtBc=;
 b=JMQ7KXVgy34ywiF9xbE7tnt5C5Rqx93xa08C0KKlF55e5otbpbLBQ8N9PRnZkOXKJjXKtXy0AaAb650Kmkk66FWywEsA7/ocI+LB7A4iZXxrKrOlrmA4er//yb8pHCM5VDH7J04glfZGhLfyq7zL8nQ68FtAzcMhuSwTlOxbHz3GewCYRhmNC/YN6C1qB1eAOdSwWn/Tn+7SPlNPs87ePHZYqwN33NTXnQ8sBeZZytgQCWJfSepJesof1IjgwJ5iRfsNTzvch9EpFGc7ked1mtXgA1Cv7HNoFkylE0jC9k9lDLjxKv+B3usQ7BH0x9/CSsrwf79JvgY7J4TYAEn+gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 16:01:04 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:01:04 +0000
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
Subject: [PATCH v25 01/20] net: Introduce direct data placement tcp offload
Date: Wed, 29 May 2024 16:00:34 +0000
Message-Id: <20240529160053.111531-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3a3b98-b029-438c-11ab-08dc7ff88afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9YBRcU0TqmLZCjf+w4NXBhsc+g0ZyqqBImpjHRjoEMZIvvBKsPBFyVwTU7Xf?=
 =?us-ascii?Q?FoypeXRdfkx4KREFpefC4LgIE6nQx+6NiUw/2V0Io5AIqyT+DwGqoEKmWLAj?=
 =?us-ascii?Q?2vtY/3xsaJZd5RlT6zzrsp0xQTQo618soPAuO9IhqcJzt+ZUxz6Cbl3jaKKw?=
 =?us-ascii?Q?Sp7cT9DF5qCsfwwqOoSVNk9SlTpzuv6ZizdM94mBfrHedGVyfwdZaLBu5Kor?=
 =?us-ascii?Q?ITjPTyskR0kYoYJF0Xu4NFkwDyzCzf+TtyB4RB7n72PPJrlh1zgHMkMQLVEv?=
 =?us-ascii?Q?RFISqhu68C5iN70m532ZMWYwVd3o5ax6pzeMdapjNq/TdvWblR6h6G4uVSlr?=
 =?us-ascii?Q?W4UvLlNM7LSlLm32qLQSnzb43TJw1tBVIp4wY2h6sPzSeTFz3+/5IZBTjura?=
 =?us-ascii?Q?fBP/tIqf3qXZYtrlax8PEvevFKiRSaGSbSMM+vk8LFVx/fjBCya1I7gf5KKg?=
 =?us-ascii?Q?NZWbgRI3409vZhD8lcsu7Ja0TKktcoEf76wlco4jkckYKDX0xvkd21Yi43jZ?=
 =?us-ascii?Q?YQnA2cbS8ivUJn2stwCveOlBB6h5ki6aQUmf2XfJPC3lMVPykM+YAA+76q8k?=
 =?us-ascii?Q?FYlvbiUeCSeQsT75jgeWUrtdkvRzc2iDKB8y9VKChrs0QEpUZ6v8jWBGn0vx?=
 =?us-ascii?Q?/gq1PFPk8QYIKn+/H69wElvP4ASzv5A7aaECJpMgcnoB13ePpjPMYIzhh/8Z?=
 =?us-ascii?Q?F3hB8gSJfHru/hEP8a8TSdwxItwYSWLtHGdFGp1CLCaEKpNlQe1AcETls+5J?=
 =?us-ascii?Q?uk4t/1I/bKcJHietmlcwlvS81iRop3xeSWbLfZyTjsYWtCKpqq6if21ZQBR+?=
 =?us-ascii?Q?ZS/bQjI3gvVU3Y/gBXRpLr3zz4bNXS5AUR+vf9gLuWC9dtmPxte2szCf5vAL?=
 =?us-ascii?Q?DOtprlu7fD5t8oYpv2KccIWfRVamxZjV/KwmapQT/+CYfXP+GQh6ykEYKeaJ?=
 =?us-ascii?Q?AYwNxwcB1LptNo2x4juAOawdatSB/oKTJ+l7vkOTakUnwXmZ2nNSwF8B5hd1?=
 =?us-ascii?Q?WmB01J6gSTnk0qOjThZnw5JSNodpn60mYNNz7hqNtd4y79UXo3GKiowkoR/u?=
 =?us-ascii?Q?etFBMN4oM/ZBu5txK+BPtyn2EwHxVdysmb7ZaV2nqvol7wsZetIzVDHUL+RE?=
 =?us-ascii?Q?gqdFxV0QJwvEdwKBekETJC7ug/MX5eSOdyiRn/GGLN6BGwmqyp6yvQeMgOBJ?=
 =?us-ascii?Q?kXxo6U/zwfmALc8P6hTJURR31ARZTU9Yv4Ow1GVMCzR8Ool8dyNxNWMSVVuI?=
 =?us-ascii?Q?+sL1bEUbs+LTfSrcEPquFvzp7IQDHsa0evGisiURwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKbWXve8VlP10K78QjD6tKtqI8+C5IGH4u7G4NbyO4XippvPodfBd+oYaMda?=
 =?us-ascii?Q?EN9wzuFrqUWrvbG/dwm85XFDEIBTQwqbQe06VNpqkIyHNWHvG9cC4XXII73D?=
 =?us-ascii?Q?yctzRDVxfE2qfR5L07LI4ptPVeNFxLvJlS0qAB2Q4joACFkDizHcr6hZ1w6u?=
 =?us-ascii?Q?sMv+jLCR2Qyx1VjFjP2XlSwrM2HNNpN8snP+HDBZpjaIdHS7HCkqUDLqYlkJ?=
 =?us-ascii?Q?k/zHxVYKVbwIiZzObpw8btW28sFFM61DZReotZ7UtXRonQHGE3cO0lhq9jf5?=
 =?us-ascii?Q?rQHy1i2GB6RJjozudp9DIi3nG4x4VJSpWGtlPHAczXhoYOkgZoZoCCr5J8P9?=
 =?us-ascii?Q?QQSm9WLH6bFCe5z4w5nrS/CjLR8YSyfQ9vjdI4yHUUpVuoDA3S6wD343KIve?=
 =?us-ascii?Q?q4DO4zx7ms5032s33KTqnHNO6XcnBRhiXZUPh2bSQsy15oaGe0w0/+12cQeg?=
 =?us-ascii?Q?8tmI9Uu1Oh0eENjc8rxEj3HYSck9I6y/79BxGmogrM4ykFyN9+x2W7jAoNuv?=
 =?us-ascii?Q?5zea1znglP4w4O+pbKGYN9fvTPo+1w/+cNkDuWWWAAvXkxlQ2KqX7Msf943v?=
 =?us-ascii?Q?1cEaaTzf5qcH1Z554/+O9czgj9zL/QtyicbAf8OFOVMh9sKr7Xi2LJB4FXpx?=
 =?us-ascii?Q?JMNeMDvhw2gO1eSdSa9vrR1/wYYhCLy3uvrUBxXhLmLnpil4L6gqoQpfYOO9?=
 =?us-ascii?Q?Y3Xd/1CvQdBFTWvY+dKor7NtY1nRMgaYhDXCEhlt7+fRS71/XqmiH4NJ4+3A?=
 =?us-ascii?Q?ZalJiUgQrkbX+Zqe+BJVb+V9RqBnMyotJ9XuAaT+pqOXIxPkOCiaPY68tMp5?=
 =?us-ascii?Q?ttlvMxdzbiw3Y+nXz8Zy1Mz+3DxnJVOFpRujsPtybNTESmgp+Cc/0adQzHQA?=
 =?us-ascii?Q?zFqKnIAZQv7zf63Hx79iy3j8qjU6K266JYZGdmq3rufXzcP0I/0sfC/+SPnf?=
 =?us-ascii?Q?H9L+bTrqpTlROOBqvv1mqF8AYJHP11Q3LRWiXHx605qCiP5qy3PVMP0T8FX/?=
 =?us-ascii?Q?PzBHYguOVJXO4NgImH7vJHIpMJUmHZqLBjt6qGg6ivPkli4bG2REjky0Vrqs?=
 =?us-ascii?Q?a7xc73hHXZJSUwOvaiY1VeHOTCBtNICSFqBnAZFawHQjfUdR+oSkk1t1eLqB?=
 =?us-ascii?Q?Y2U0icuJVMCyNrOledAmnxbTV80FgeCoNVxY6jURku4MMbFHbQbl4W89S5dz?=
 =?us-ascii?Q?LS/AWlVfOoAypiTQ/QT5qMr/yBExbpbjBBNs17VygKH3UO9zjj3Rd8Zwdo6B?=
 =?us-ascii?Q?22U2q1+Mo6ZpFVwGs1PW6MhLrU+5djNj05AtPykIqj5u1z5nH41ZjF74PsrM?=
 =?us-ascii?Q?W3hWrvBy/S5zI8evVmjWtCmPrN0PX5cpkw6NBGT+p26sLSys9RvoewheTNL9?=
 =?us-ascii?Q?iGijPR8leUre68IwEmSXYaPkgDEnlyGnI6KoO/bVI3z95ub8cuTCRe2IqrK6?=
 =?us-ascii?Q?Unf29zck3iF+/DakDKFcLfMJXeKaYL+sLp1YK3+XHsJ93oWTf4+hppba1/8E?=
 =?us-ascii?Q?Y+E+s6xzW4rXGjn+FWofN6fygxbMjeeLOP7PxMjtqfkgxdC1YBF3bUesDgLK?=
 =?us-ascii?Q?rFT9vQ0U6ij2JzQXIv7SVDPLzCflZaVdZiZDqkkb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3a3b98-b029-438c-11ab-08dc7ff88afa
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:01:04.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttVF4wmrKt5nBg4yKc2X5UCIIs2LMooqUhaTxn5dwbVb/iDPNSrLOG1AJJUUg6c6Zdc4cHHiHeYspWzZ+DLo/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement (DDP) offload for TCP.

The motivation is saving compute resources/cycles that are spent
to copy data from SKBs to the block layer buffers and CRC
calculation/verification for received PDUs (Protocol Data Units).

The DDP capability is accompanied by new net_device operations that
configure hardware contexts.

There is a context per socket, and a context per DDP operation.
Additionally, a resynchronization routine is used to assist
hardware handle TCP OOO, and continue the offload. Furthermore,
we let the offloading driver advertise what is the max hw
sectors/segments.

The interface includes the following net-device ddp operations:

 1. sk_add - add offload for the queue represented by socket+config pair
 2. sk_del - remove the offload for the socket/queue
 3. ddp_setup - request copy offload for buffers associated with an IO
 4. ddp_teardown - release offload resources for that IO
 5. limits - query NIC driver for quirks and limitations (e.g.
             max number of scatter gather entries per IO)
 6. set_caps - request ULP DDP capabilities enablement
 7. get_caps - request current ULP DDP capabilities
 8. get_stats - query NIC driver for ULP DDP stats

Using this interface, the NIC hardware will scatter TCP payload
directly to the BIO pages according to the command_id.

To maintain the correctness of the network stack, the driver is
expected to construct SKBs that point to the BIO pages.

The SKB passed to the network stack from the driver represents
data as it is on the wire, while it is pointing directly to data
in destination buffers.

As a result, data from page frags should not be copied out to
the linear part. To avoid needless copies, such as when using
skb_condense, we mark the skb->no_condense bit.
In addition, the skb->ulp_crc will be used by the upper layers to
determine if CRC re-calculation is required. The two separated skb
indications are needed to avoid false positives GRO flushing events.

Follow-up patches will use this interface for DDP in NVMe-TCP.

Capability bits stored in net_device allow drivers to report which
ULP DDP capabilities a device supports. Control over these
capabilities will be exposed to userspace in later patches.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 include/linux/netdevice.h          |   5 +
 include/linux/skbuff.h             |  41 +++-
 include/net/inet_connection_sock.h |   6 +
 include/net/ulp_ddp.h              | 320 +++++++++++++++++++++++++++++
 net/Kconfig                        |  20 ++
 net/core/Makefile                  |   1 +
 net/core/skbuff.c                  |   3 +-
 net/core/ulp_ddp.c                 |  51 +++++
 net/ipv4/tcp_input.c               |   7 +
 net/ipv4/tcp_ipv4.c                |   1 +
 net/ipv4/tcp_offload.c             |   1 +
 11 files changed, 454 insertions(+), 2 deletions(-)
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d20c6c99eb88..11954df382de 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1351,6 +1351,8 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ * struct ulp_ddp_dev_ops *ulp_ddp_ops;
+ *	ULP DDP operations (see include/net/ulp_ddp.h)
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1596,6 +1598,9 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+#if IS_ENABLED(CONFIG_ULP_DDP)
+	const struct ulp_ddp_dev_ops	*ulp_ddp_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fe7d8dbef77e..7373efbd8a22 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -832,6 +832,8 @@ enum skb_tstamp_type {
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time clock base of skb->tstamp.
+ *	@no_condense: When set, don't condense fragments (DDP offloaded)
+ *	@ulp_crc: CRC offloaded
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -1008,7 +1010,10 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
-
+#ifdef CONFIG_ULP_DDP
+	__u8                    no_condense:1;
+	__u8			ulp_crc:1;
+#endif
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5119,5 +5124,39 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+static inline bool skb_is_no_condense(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->no_condense;
+#else
+	return 0;
+#endif
+}
+
+static inline bool skb_is_ulp_crc(const struct sk_buff *skb)
+{
+#ifdef CONFIG_ULP_DDP
+	return skb->ulp_crc;
+#else
+	return 0;
+#endif
+}
+
+static inline void skb_copy_no_condense(struct sk_buff *to,
+					const struct sk_buff *from)
+{
+#ifdef CONFIG_ULP_DDP
+	to->no_condense = from->no_condense;
+#endif
+}
+
+static inline void skb_copy_ulp_crc(struct sk_buff *to,
+				    const struct sk_buff *from)
+{
+#ifdef CONFIG_ULP_DDP
+	to->ulp_crc = from->ulp_crc;
+#endif
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 7d6b1254c92d..b6d704cb9979 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -67,6 +67,8 @@ struct inet_connection_sock_af_ops {
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
  * @icsk_clean_acked	   Clean acked data hook
+ * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
+ * @icsk_ulp_ddp_data	   ULP direct data placement private data
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -97,6 +99,10 @@ struct inet_connection_sock {
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
 	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
+#ifdef CONFIG_ULP_DDP
+	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
+	void __rcu		  *icsk_ulp_ddp_data;
+#endif
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
new file mode 100644
index 000000000000..9f2d14998cb3
--- /dev/null
+++ b/include/net/ulp_ddp.h
@@ -0,0 +1,320 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ulp_ddp.h
+ *   Author:	Boris Pismenny <borisp@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+#ifndef _ULP_DDP_H
+#define _ULP_DDP_H
+
+#include <linux/netdevice.h>
+#include <net/inet_connection_sock.h>
+#include <net/sock.h>
+
+enum ulp_ddp_type {
+	ULP_DDP_NVME = 1,
+};
+
+/**
+ * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
+ *
+ * @full_ccid_range:	true if the driver supports the full CID range
+ */
+struct nvme_tcp_ddp_limits {
+	bool			full_ccid_range;
+};
+
+/**
+ * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
+ * protocol limits.
+ * Add new instances of ulp_ddp_limits in the union below (nvme-tcp, etc.).
+ *
+ * @type:		type of this limits struct
+ * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
+ * @io_threshold:	minimum payload size required to offload
+ * @tls:		support for ULP over TLS
+ * @nvmeotcp:		NVMe-TCP specific limits
+ */
+struct ulp_ddp_limits {
+	enum ulp_ddp_type	type;
+	int			max_ddp_sgl_len;
+	int			io_threshold;
+	bool			tls:1;
+	union {
+		struct nvme_tcp_ddp_limits nvmeotcp;
+	};
+};
+
+/**
+ * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+ *
+ * @pfv:	pdu version (e.g., NVME_TCP_PFV_1_0)
+ * @cpda:	controller pdu data alignment (dwords, 0's based)
+ * @dgst:	digest types enabled (header or data, see
+ *		enum nvme_tcp_digest_option).
+ *		The netdev will offload crc if it is supported.
+ * @queue_size: number of nvme-tcp IO queue elements
+ */
+struct nvme_tcp_ddp_config {
+	u16			pfv;
+	u8			cpda;
+	u8			dgst;
+	int			queue_size;
+};
+
+/**
+ * struct ulp_ddp_config - Generic ulp ddp configuration
+ * Add new instances of ulp_ddp_config in the union below (nvme-tcp, etc.).
+ *
+ * @type:	type of this config struct
+ * @nvmeotcp:	NVMe-TCP specific config
+ * @affinity_hint:	cpu core running the IO thread for this socket
+ */
+struct ulp_ddp_config {
+	enum ulp_ddp_type    type;
+	int		     affinity_hint;
+	union {
+		struct nvme_tcp_ddp_config nvmeotcp;
+	};
+};
+
+/**
+ * struct ulp_ddp_io - ulp ddp configuration for an IO request.
+ *
+ * @command_id: identifier on the wire associated with these buffers
+ * @nents:	number of entries in the sg_table
+ * @sg_table:	describing the buffers for this IO request
+ * @first_sgl:	first SGL in sg_table
+ */
+struct ulp_ddp_io {
+	u32			command_id;
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
+/**
+ * struct ulp_ddp_stats - ULP DDP offload statistics
+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
+ *                           for offloading.
+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
+ *                         Direct Data Placement.
+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
+ * @rx_nvmeotcp_drop: number of PDUs dropped.
+ * @rx_nvmeotcp_resync: number of resync.
+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
+ */
+struct ulp_ddp_stats {
+	u64 rx_nvmeotcp_sk_add;
+	u64 rx_nvmeotcp_sk_add_fail;
+	u64 rx_nvmeotcp_sk_del;
+	u64 rx_nvmeotcp_ddp_setup;
+	u64 rx_nvmeotcp_ddp_setup_fail;
+	u64 rx_nvmeotcp_ddp_teardown;
+	u64 rx_nvmeotcp_drop;
+	u64 rx_nvmeotcp_resync;
+	u64 rx_nvmeotcp_packets;
+	u64 rx_nvmeotcp_bytes;
+
+	/*
+	 * add new stats at the end and keep in sync with
+	 * Documentation/netlink/specs/ulp_ddp.yaml
+	 */
+};
+
+#define ULP_DDP_CAP_COUNT 1
+
+struct ulp_ddp_dev_caps {
+	DECLARE_BITMAP(active, ULP_DDP_CAP_COUNT);
+	DECLARE_BITMAP(hw, ULP_DDP_CAP_COUNT);
+};
+
+struct netlink_ext_ack;
+
+/**
+ * struct ulp_ddp_dev_ops - operations used by an upper layer protocol
+ *                          to configure ddp offload
+ *
+ * @limits:    query ulp driver limitations and quirks.
+ * @sk_add:    add offload for the queue represented by socket+config
+ *             pair. this function is used to configure either copy, crc
+ *             or both offloads.
+ * @sk_del:    remove offload from the socket, and release any device
+ *             related resources.
+ * @setup:     request copy offload for buffers associated with a
+ *             command_id in ulp_ddp_io.
+ * @teardown:  release offload resources association between buffers
+ *             and command_id in ulp_ddp_io.
+ * @resync:    respond to the driver's resync_request. Called only if
+ *             resync is successful.
+ * @set_caps:  set device ULP DDP capabilities.
+ *	       returns a negative error code or zero.
+ * @get_caps:  get device ULP DDP capabilities.
+ * @get_stats: query ULP DDP statistics.
+ */
+struct ulp_ddp_dev_ops {
+	int (*limits)(struct net_device *netdev,
+		      struct ulp_ddp_limits *limits);
+	int (*sk_add)(struct net_device *netdev,
+		      struct sock *sk,
+		      struct ulp_ddp_config *config);
+	void (*sk_del)(struct net_device *netdev,
+		       struct sock *sk);
+	int (*setup)(struct net_device *netdev,
+		     struct sock *sk,
+		     struct ulp_ddp_io *io);
+	void (*teardown)(struct net_device *netdev,
+			 struct sock *sk,
+			 struct ulp_ddp_io *io,
+			 void *ddp_ctx);
+	void (*resync)(struct net_device *netdev,
+		       struct sock *sk, u32 seq);
+	int (*set_caps)(struct net_device *dev, unsigned long *bits,
+			struct netlink_ext_ack *extack);
+	void (*get_caps)(struct net_device *dev,
+			 struct ulp_ddp_dev_caps *caps);
+	int (*get_stats)(struct net_device *dev,
+			 struct ulp_ddp_stats *stats);
+};
+
+#define ULP_DDP_RESYNC_PENDING BIT(0)
+
+/**
+ * struct ulp_ddp_ulp_ops - Interface to register upper layer
+ *                          Direct Data Placement (DDP) TCP offload.
+ * @resync_request:         NIC requests ulp to indicate if @seq is the start
+ *                          of a message.
+ * @ddp_teardown_done:      NIC driver informs the ulp that teardown is done,
+ *                          used for async completions.
+ */
+struct ulp_ddp_ulp_ops {
+	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+	void (*ddp_teardown_done)(void *ddp_ctx);
+};
+
+/**
+ * struct ulp_ddp_ctx - Generic ulp ddp context
+ *
+ * @type:	type of this context struct
+ * @buf:	protocol-specific context struct
+ */
+struct ulp_ddp_ctx {
+	enum ulp_ddp_type	type;
+	unsigned char		buf[];
+};
+
+static inline struct ulp_ddp_ctx *ulp_ddp_get_ctx(struct sock *sk)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return (__force struct ulp_ddp_ctx *)icsk->icsk_ulp_ddp_data;
+#else
+	return NULL;
+#endif
+}
+
+static inline void ulp_ddp_set_ctx(struct sock *sk, void *ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	rcu_assign_pointer(icsk->icsk_ulp_ddp_data, ctx);
+#endif
+}
+
+static inline int ulp_ddp_setup(struct net_device *netdev,
+				struct sock *sk,
+				struct ulp_ddp_io *io)
+{
+#ifdef CONFIG_ULP_DDP
+	return netdev->netdev_ops->ulp_ddp_ops->setup(netdev, sk, io);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline void ulp_ddp_teardown(struct net_device *netdev,
+				    struct sock *sk,
+				    struct ulp_ddp_io *io,
+				    void *ddp_ctx)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->teardown(netdev, sk, io, ddp_ctx);
+#endif
+}
+
+static inline void ulp_ddp_resync(struct net_device *netdev,
+				  struct sock *sk,
+				  u32 seq)
+{
+#ifdef CONFIG_ULP_DDP
+	netdev->netdev_ops->ulp_ddp_ops->resync(netdev, sk, seq);
+#endif
+}
+
+static inline int ulp_ddp_get_limits(struct net_device *netdev,
+				     struct ulp_ddp_limits *limits,
+				     enum ulp_ddp_type type)
+{
+#ifdef CONFIG_ULP_DDP
+	limits->type = type;
+	return netdev->netdev_ops->ulp_ddp_ops->limits(netdev, limits);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static inline bool ulp_ddp_cap_turned_on(unsigned long *old,
+					 unsigned long *new,
+					 int bit_nr)
+{
+	return !test_bit(bit_nr, old) && test_bit(bit_nr, new);
+}
+
+static inline bool ulp_ddp_cap_turned_off(unsigned long *old,
+					  unsigned long *new,
+					  int bit_nr)
+{
+	return test_bit(bit_nr, old) && !test_bit(bit_nr, new);
+}
+
+#ifdef CONFIG_ULP_DDP
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr);
+
+#else
+
+static inline int ulp_ddp_sk_add(struct net_device *netdev,
+				 struct sock *sk,
+				 struct ulp_ddp_config *config,
+				 const struct ulp_ddp_ulp_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ulp_ddp_sk_del(struct net_device *netdev,
+				  struct sock *sk)
+{}
+
+static inline bool ulp_ddp_is_cap_active(struct net_device *netdev,
+					 int cap_bit_nr)
+{
+	return false;
+}
+
+#endif
+
+#endif	/* _ULP_DDP_H */
diff --git a/net/Kconfig b/net/Kconfig
index f0a8692496ff..499791f86dbb 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -522,4 +522,24 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config ULP_DDP
+	bool "ULP direct data placement offload"
+	help
+	  This feature provides a generic infrastructure for Direct
+	  Data Placement (DDP) offload for Upper Layer Protocols (ULP,
+	  such as NVMe-TCP).
+
+	  If the ULP and NIC driver supports it, the ULP code can
+	  request the NIC to place ULP response data directly
+	  into application memory, avoiding a costly copy.
+
+	  This infrastructure also allows for offloading the ULP data
+	  integrity checks (e.g. data digest) that would otherwise
+	  require another costly pass on the data we managed to avoid
+	  copying.
+
+	  For more information, see
+	  <file:Documentation/networking/ulp-ddp-offload.rst>.
+
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index 62be9aef2528..35345684939c 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
 obj-y += hotdata.o
+obj-$(CONFIG_ULP_DDP) += ulp_ddp.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e..e768487085dc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -78,6 +78,7 @@
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
 #include <net/dropreason.h>
+#include <net/ulp_ddp.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -6779,7 +6780,7 @@ void skb_condense(struct sk_buff *skb)
 {
 	if (skb->data_len) {
 		if (skb->data_len > skb->end - skb->tail ||
-		    skb_cloned(skb))
+		    skb_cloned(skb) || skb_is_no_condense(skb))
 			return;
 
 		/* Nice, we can free page frag(s) right now */
diff --git a/net/core/ulp_ddp.c b/net/core/ulp_ddp.c
new file mode 100644
index 000000000000..d97c530b4f19
--- /dev/null
+++ b/net/core/ulp_ddp.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * ulp_ddp.c
+ *   Author:	Aurelien Aptel <aaptel@nvidia.com>
+ *   Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <net/ulp_ddp.h>
+
+int ulp_ddp_sk_add(struct net_device *netdev,
+		   struct sock *sk,
+		   struct ulp_ddp_config *config,
+		   const struct ulp_ddp_ulp_ops *ops)
+{
+	int ret;
+
+	/* put in ulp_ddp_sk_del() */
+	dev_hold(netdev);
+
+	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
+	if (ret) {
+		dev_put(netdev);
+		return ret;
+	}
+
+	inet_csk(sk)->icsk_ulp_ddp_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_add);
+
+void ulp_ddp_sk_del(struct net_device *netdev,
+		    struct sock *sk)
+{
+	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, sk);
+	inet_csk(sk)->icsk_ulp_ddp_ops = NULL;
+	dev_put(netdev);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_sk_del);
+
+bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
+{
+	struct ulp_ddp_dev_caps caps;
+
+	if (!netdev->netdev_ops->ulp_ddp_ops)
+		return false;
+	netdev->netdev_ops->ulp_ddp_ops->get_caps(netdev, &caps);
+	return test_bit(cap_bit_nr, caps.active);
+}
+EXPORT_SYMBOL_GPL(ulp_ddp_is_cap_active);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c04a9c8be9d..a7f2ec963bc0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4809,6 +4809,9 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (skb_cmp_decrypted(from, to))
 		return false;
 
+	if (skb_is_ulp_crc(from) != skb_is_ulp_crc(to))
+		return false;
+
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
 
@@ -5387,6 +5390,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 		skb_copy_decrypted(nskb, skb);
+		skb_copy_no_condense(nskb, skb);
+		skb_copy_ulp_crc(nskb, skb);
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
 			__skb_queue_before(list, skb, nskb);
@@ -5418,6 +5423,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 					goto end;
 				if (skb_cmp_decrypted(skb, nskb))
 					goto end;
+				if (skb_is_ulp_crc(skb) != skb_is_ulp_crc(nskb))
+					goto end;
 			}
 		}
 	}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8f70b8d1d1e5..c0aced7821e8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2056,6 +2056,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR)) ||
 	    !mptcp_skb_can_collapse(tail, skb) ||
 	    skb_cmp_decrypted(tail, skb) ||
+	    skb_is_ulp_crc(tail) != skb_is_ulp_crc(skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 4b791e74529e..edf4da921ac3 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -337,6 +337,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 
 	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
 	flush |= skb_cmp_decrypted(p, skb);
+	flush |= skb_is_ulp_crc(p) != skb_is_ulp_crc(skb);
 
 	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
 		flush |= (__force int)(flags ^ tcp_flag_word(th2));
-- 
2.34.1


