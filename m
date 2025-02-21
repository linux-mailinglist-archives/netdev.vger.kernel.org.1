Return-Path: <netdev+bounces-168443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1EA3F0FE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C376617D892
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1791FBEA8;
	Fri, 21 Feb 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sjRmgePf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D471DFDB9
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131594; cv=fail; b=JNX1W8WwMfyd1S148Lh95pucUc6q+DLpHq2/DPiPPJJMBKFy+COfkwqIlbXm+tyiyBeU0Row6477RalJSShtqjDuPNS2SQGMz5kTGL4XrxmrhiMztH7O8Z18eK8+/FKMDoqkNyOD2ll1+tMEbiiICSZ8oW2bXyvWgjFQZ1EgZ48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131594; c=relaxed/simple;
	bh=G5u2tXLyAgvUYzd1qj6Er1NiTQK/jQccWR7zLV/eTKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TI8GRtyISG3jn+rGLVA5I7MEHCnLussgaIZ65d3ssuaBAjjfj/m4muvJEDlCyFYOpQ74zFuG36pLfhMz3HY8tmJpEKQpj4K2LpNaR+OIGqWNjEjP0e9NRwALewK8Z0nC2MK0cdx0PKp5kHJjVLsLqtvxx6VqXc8f9YbVspEAZzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sjRmgePf; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je0JUuo1xqJfQr70uQRJbDMJF2cb7Yw0qeRhziaF9rc8idGGXTs07tgTtowyFWXBS91P/PESVnJ45eH6mvZ+SYV7CZhkICxVhFLqsKssNW7wg1MYFF9C8bN7nRF/J2tEg2s6CtX14EIENZMziDsV+UOYIr3SNnzpEcn/dHJKTXiYK72Gr38V8Dv0c708WxSjCOucop/qLnbKwWkRaV94eHj1UoN4S/WIQ5SVTjZjjQAdiVWBeynQ26LoS8xRKRc4G+YQaughn4ze2cMFk1Ql6FbzzAS7+ZID3f9G5Qv1Kk+XQqaclb0WvTTz65p8rND9eVIJp6vCvsmGjWBEElVW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWvZjJe7s7SHm7hHuIno/EHw9Z2bS4CVQOwSd4NbLyI=;
 b=H/8CrHbshtQDHe6ErniCoRmt3nX3Hp0OE5Zalqie/qe2tq9g83XfH9w/Of4l3XtUKciiZxOMzBD2mPbtTDHs6n68gqn180+/XH+aysfEkOjcs7cmYrr5aAQuveQucvjxXSbngUqIgm024fVXAFuSW/kHESacFms3JBvJ/Mr8l+K1yHK3JNZNkDhaPEDg5yBM10hhW9sjAOW6WR7yeliyxqo7HzmuuVFUalYJllXLamt6naKcVdmbjf72bmqxQYvZ2SY5qTEQCuXug26dG8mDtiKpKV6Qja689OTg6BhPhLSB1bjjFopekUUtnJUR8FYxvYbQUZjkkcaoihYMhEc52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWvZjJe7s7SHm7hHuIno/EHw9Z2bS4CVQOwSd4NbLyI=;
 b=sjRmgePfRVi3z0Ao2Nr+2JMK0JKcCeMhiwVAkN0NS3D7a6G3AGmlNP0GYxyhYnmpmhwLhgMTvL7SvTvqxUSx9iTmhYEcoNBUPuaoireOTAmWNWDhRxFv2Cpi8GQPAXqJWooWUx3WBE2/FhmjgTlpxWh3sRwMHaVhsdwZWHlCQEjbxLn/dzm+16OSIFb5kFdYi0vASZjH301DlSrP1pbuQxegrf0kwWh+jqb6fdS0g0UDfofYwxcylvgBczG/tFDMAbrV432h90MJikIPL+ctIc5DoIFtZn53vcvuZCHiaLs1+NGHmOcuzTwnIIJ5Knx2no4BXSD8tw01Pwl8VWVK7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:10 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:10 +0000
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	brauner@kernel.org
Subject: [PATCH v26 05/20] nvme-tcp: Add DDP offload control path
Date: Fri, 21 Feb 2025 09:52:10 +0000
Message-Id: <20250221095225.2159-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::7) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f78f0c-9c11-49cb-e1f0-08dd525d8c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SVqWa/EEWoN62d2bOGF7d4tUtU/eZTbrUZ4MLsy05pqZopaSSGrpvx1X9jx8?=
 =?us-ascii?Q?uss72drsK4ifVMgAcxN6IJqtb9kJv+NpsCQJSXPz6/qrUTlHN/Ee8Fvo1Nj2?=
 =?us-ascii?Q?/lifS4Lk4VvB6k1wJtaZAGkmL5tJawnGQW71GK8DqVEzCiRgu9tvwWTwl+EP?=
 =?us-ascii?Q?n8pbVW6DRHbAyhdx0itLsgny4mBihJjz8S3HK6vyIt7hpGsEN2/d2eX9KLIZ?=
 =?us-ascii?Q?EPUvY4+Sax7oP08ooTUwvKACGovWH0vau4DJtq4SdDh3KNAT2Ziyay3zyqrP?=
 =?us-ascii?Q?hJG8/y0Yd1fHSxtksphO3e9lrqFwhctr2u8MoqoG2amVN49FmmjPJXH/hXUs?=
 =?us-ascii?Q?MLBFK4Xz2Xy48WI1xsEzkW8AhJmYVnJZs9ax8dwk8GdSRzqE2f4LMIxoHzpw?=
 =?us-ascii?Q?GqjnJopC/O296K28iixNWb5kmxpxxExL/9OUk4qIMQedSsYb7zv6oEytmnI6?=
 =?us-ascii?Q?TxLdPkGCbc9AxwiO2+cYRUP3xEszY6IC/OHyd6rTtfKO3v4BxSsENamKreUH?=
 =?us-ascii?Q?TqpN2sQbPyPnJJTYyUN8Iwyu0qO9JAsrq5tukFMBuxjw5XQJ9D6ULTERH+80?=
 =?us-ascii?Q?DOAIY2R1iIyA+XnAgc1PrreMqFuSJpcs38tLChw7/eu2Fvv2NMjZMYuHrGwg?=
 =?us-ascii?Q?f00CzIG97gaagHjKzfUUlqhuqSKJCcemrrUAeO8V/9N0b3n4cEyt0O80UKWT?=
 =?us-ascii?Q?PdZ6d3jk/vyvHyqQs7eIvUKuWjAGuiZSIj/6PrHXFtc+STcs2IWXdrqKii0B?=
 =?us-ascii?Q?MwcbR4H2PCPXxc6c4O7mVkA7R75hTVNLpzh5tx5WVjIFdXehwB9DKZC5+ak8?=
 =?us-ascii?Q?tmQG+dzSWTlP1kGzoH2A3WWe3elLTMOtylhAO3lKckvFqA97cT2kmjjftQTa?=
 =?us-ascii?Q?6pM5bbeKe360LvyhOwJIj9t8IVjDXY1SRjoQ+JhhP6Zu+RJxu+UnyY2kFBzS?=
 =?us-ascii?Q?r5XLZ+GKheRds/jC7ddfJv50qfHn6qB1YYNfW8JBiY2r/6fwIvom3G5qIi2v?=
 =?us-ascii?Q?mgYds75WTXGS7DCF+2xwg3qgzUtHVQejea+Hoxf+pZge/JGm1pfrRS1BNTaG?=
 =?us-ascii?Q?V0yGKJK9dXEhiYFdwuUJIYpBJuk416DWfVx68jqnd4cSzppj2DRcFrEypiNS?=
 =?us-ascii?Q?D7CuNQxS6B77Ar5DSq0YTUtstN8ldTWR998H2JG4fq1eK8yQdyFBD4natX69?=
 =?us-ascii?Q?E9EYgXJTU/j9swOdNaBHvE1Dr+WaDsPyyljGKQ4cgL5fBEPPjZ3pFxuiWEqh?=
 =?us-ascii?Q?B2mEtGgU8+cdhIOquXE8tEhMYo6tul8nTCTW0ALiDS9kh4wA45xCxLSkizrg?=
 =?us-ascii?Q?qTVa8V5g+nxwjZnlqQF78FUDzyl5vtv73hHV+iKKvyLYbXHy//zW/Xt5vvAJ?=
 =?us-ascii?Q?GQz+V86B0kz4VSAMxRumCZWdqo+L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sECEnOVwrsdA3IAIkCAglE962eZmzSDR36Rx3HN+xOm7Pofmt1CTTXBBOZje?=
 =?us-ascii?Q?OlNB3p/g1gtE/LwUdsrNPFU38W+UBB8KdY5dy47KlcI5GSzKZp71S5AnkdhT?=
 =?us-ascii?Q?jVyFmeKL3+5WFAJ6nQS0DJUwRDsMwGsa/3vcZbqo35aaNcVQWe4vsUQ2BvMB?=
 =?us-ascii?Q?QB+VpixgJjRnjbZOa7viSekZVhKWSYzNOeRCrMMr1rJeSlPfu8uw3tUERNJ3?=
 =?us-ascii?Q?gTiBtyc7X7WGZH5cnphglQCziv+aiHBlMKLJKln+wY6b/N5MXeGCForv1OYd?=
 =?us-ascii?Q?ircCwUyaoHTHvgFj7+vHmtsCSDfh4CVnuc0VQo5zuNylmcsw7Wc04QqOIL49?=
 =?us-ascii?Q?IvZdd4viYcVO2+Rg4ZaYZ0hG9ALqHAbPk9UuJvkZf3NLb18+qWrKQDwMMmQE?=
 =?us-ascii?Q?H9jh/AF4ll/8cZP/+idqovYzvIG9STHpOlAKvclXkzxrJuj4wSX+i3+cKfT7?=
 =?us-ascii?Q?xmiQQlMYztAd5EkD9FpKxiPsAjAJenhkXjcSPUaCMp5AT4jAZxuze3EYI1zh?=
 =?us-ascii?Q?pOo78+Gz4Povv3qmzjxaLT7Z+s7CP6TvFAcyxk1yvrdp1b/P83VYoXZ2Ewt5?=
 =?us-ascii?Q?fCFpuBJx7TpgfM1gIw75h80i6Rw5wR+5SsgkiGW/v/BFURpE/zrLyTLd7vQm?=
 =?us-ascii?Q?Is0TxNIz7QctzMEsZoQqy186bkjXjs0L0+JKCeY7PlRxT89/Ij8ojvlsuUjZ?=
 =?us-ascii?Q?WSeXaqH4syC92U+ZyBzR4FtelIzA7cQ26h26le8b2NtDHsXvTieH0x8PUxsj?=
 =?us-ascii?Q?vx9ozww5ikgRmv1fxE2dBjmyU01ySV/fEtV9DVyT0nYosR+uYOXZYF13ujMw?=
 =?us-ascii?Q?7RHU0K6bEQPKTXLrfvIrcGGrueSa7qUk7XpMiV/2kop+7uAGY1vqWAfcSJbY?=
 =?us-ascii?Q?0igYoPxkY4hLvpin9Mdu4Gzy7i+6v6OrV5C3UYdqfmf0OPutEJ1hAQLEq5B9?=
 =?us-ascii?Q?YXyib2VUmTE7P7cI/DrXXsu8V2ixRkzXcPLUN0h9spy3jTLZe2W8AQA62ytX?=
 =?us-ascii?Q?L8BPxl/OuTpptCNbMnW6C0jYwO9WhOJsb1SnW0bFoeetqRIPNqAKCt0DLYWG?=
 =?us-ascii?Q?CZjOd4MkltPpKoJaFvSt+BXC7Pn4jBwZacUJ4DsdDf1R0rWhfHkIk7CicRRL?=
 =?us-ascii?Q?sKS0sEawMhT+PsdV7ll3cA/ZPpWgfD61yiAIixfcagrcofoFCjJcmlnu2G7F?=
 =?us-ascii?Q?TWt4N0lUzC9OBkJtmCgap4dWAaRvSKK2C+CCQW/faxKwFjmUDk+fJivodesv?=
 =?us-ascii?Q?kNOzr4UFvxosgedLMQtjGz4SrzjFb8L6duSeasubydqZGZxuFWhCYanbyigZ?=
 =?us-ascii?Q?vdSaoQOtpBFMD82JCYRQwlzPxFlFQjgdV8aajFngvz2kj5J+YgVi6jKvkxcR?=
 =?us-ascii?Q?FRBD4oAcxgTNZKir4+FlppqFTFoRPrCaQOY9/D1qdijft6imrT0zPH98fR5S?=
 =?us-ascii?Q?TlaykStfbMgdUMQKP6NnbN4Vu8T6HfDTF4cmEm6dE+B9UdCjCuLYk1OI0DVO?=
 =?us-ascii?Q?2tNfvEwda84B63BTHOQlUY7h7Qm/4aKiRwtO7UpYIpj9heJmgJZcTAvf0zt7?=
 =?us-ascii?Q?ODfUNMJP++YqUTnzVPbQjsCHcBykpSvLWvnJrJws?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f78f0c-9c11-49cb-e1f0-08dd525d8c6f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:10.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV4uZ4rZL5yVYgFBJS6fD72LRxrf79rE+OAQlccsA5QvWBB7yETSUbX+fbnK/QcLGzCTu1JmlrMkL+q+DQ+2og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (resync), which will update the HW, and resume offload
when all is successful.

Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
for queue of size N) where the linux nvme driver uses part of the 16
bit CCID for generation counter. To address that, we use the existing
quirk in the nvme layer when the HW driver advertises if the device is
not supports the full 16 bit CCID range.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via ulp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Socket operations need a netdev reference. This reference is
dropped on NETDEV_GOING_DOWN events to allow the device to go down in
a follow-up patch.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 264 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 253 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..656dc4b6c6d7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -21,6 +21,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -56,6 +60,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ddp_offload;
+module_param(ddp_offload, bool, 0644);
+MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -130,6 +144,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_OFF_DDP	= 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -157,6 +172,18 @@ struct nvme_tcp_queue {
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
 
+#ifdef CONFIG_ULP_DDP
+	/*
+	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
+	 * an additional flag in the lower 32 bits) that the HW send to
+	 * the SW, for the SW to verify.
+	 * - The 32 high bits store the seq number
+	 * - The 32 low bits are used as a flag to know if a request
+	 *   is pending (ULP_DDP_RESYNC_PENDING).
+	 */
+	atomic64_t		resync_tcp_seq;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -198,6 +225,13 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*ddp_netdev;
+	netdevice_tracker	netdev_tracker;
+	u32			ddp_threshold;
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -323,6 +357,174 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	struct net_device *netdev;
+	int ret;
+
+	if (!ddp_offload)
+		return NULL;
+
+	rtnl_lock();
+	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
+	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk, &ctrl->netdev_tracker, GFP_KERNEL);
+	rtnl_unlock();
+	if (!netdev) {
+		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
+		return NULL;
+	}
+
+	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
+		goto err;
+
+	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
+	if (ret)
+		goto err;
+
+	if (nvme_tcp_tls_configured(&ctrl->ctrl) && !ctrl->ddp_limits.tls)
+		goto err;
+
+	return netdev;
+err:
+	netdev_put(netdev, &ctrl->netdev_tracker);
+	return NULL;
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	int ret;
+
+	config.affinity_hint = queue->io_cpu == WORK_CPU_UNBOUND ?
+		queue->sock->sk->sk_incoming_cpu : queue->io_cpu;
+	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
+	config.nvmeotcp.cpda = 0;
+	config.nvmeotcp.dgst =
+		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.nvmeotcp.dgst |=
+		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
+
+	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
+			     queue->sock->sk,
+			     &config,
+			     &nvme_tcp_ddp_ulp_ops);
+	if (ret)
+		return ret;
+
+	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
+	ctrl->ctrl.max_hw_sectors =
+		ctrl->ddp_limits.max_ddp_sgl_len << (NVME_CTRL_PAGE_SHIFT - SECTOR_SHIFT);
+	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
+
+	/* offloading HW doesn't support full ccid range, apply the quirk */
+	ctrl->ctrl.quirks |=
+		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
+}
+
+/* In presence of packet drops or network packet reordering, the device may lose
+ * synchronization between the TCP stream and the L5P framing, and require a
+ * resync with the kernel's TCP stack.
+ *
+ * - NIC HW identifies a PDU header at some TCP sequence number,
+ *   and asks NVMe-TCP to confirm it.
+ * - When NVMe-TCP observes the requested TCP sequence, it will compare
+ *   it with the PDU header TCP sequence, and report the result to the
+ *   NIC driver
+ */
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_tcp_seq);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
+		return;
+
+	/*
+	 * Obtain and check requested sequence number: is this PDU header
+	 * before the request?
+	 */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	/*
+	 * The atomic operation guarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_tcp_seq, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
+			     atomic64_read(&queue->resync_tcp_seq))
+		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	/*
+	 * "seq" (TCP seq number) is what the HW assumes is the
+	 * beginning of a PDU.  The nvme-tcp layer needs to store the
+	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
+	 * indicate that a request is pending.
+	 */
+	atomic64_set(&queue->resync_tcp_seq, (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	return NULL;
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{}
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -771,6 +973,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1870,6 +2075,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1891,6 +2098,20 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+
+	nvme_tcp_stop_queue(nctrl, 0);
+
+	/*
+	 * We are called twice by nvme_tcp_teardown_admin_queue()
+	 * Set ddp_netdev to NULL to avoid putting it twice
+	 */
+	netdev_put(ctrl->ddp_netdev, &ctrl->netdev_tracker);
+	ctrl->ddp_netdev = NULL;
+}
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -1920,17 +2141,35 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	if (idx) {
 		nvme_tcp_set_queue_io_cpu(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	} else
+		if (ret)
+			goto err;
+
+		if (ctrl->ddp_netdev) {
+			ret = nvme_tcp_offload_socket(queue);
+			if (ret) {
+				dev_info(nctrl->device,
+					 "failed to setup offload on queue %d ret=%d\n",
+					 idx, ret);
+			}
+		}
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		if (ret)
+			goto err;
+
+		ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
+		if (ctrl->ddp_netdev)
+			nvme_tcp_ddp_apply_limits(ctrl);
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+
+	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	return 0;
+err:
+	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	dev_err(nctrl->device,
+		"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
 }
 
@@ -2170,7 +2409,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -2185,7 +2424,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove) {
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2493,7 +2732,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (nvme_tcp_admin_queue(req->queue))
+		nvme_tcp_stop_admin_queue(ctrl);
+	else
+		nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.34.1


