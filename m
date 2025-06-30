Return-Path: <netdev+bounces-202467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF701AEE035
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F4C3B873F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB128BA95;
	Mon, 30 Jun 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jJFcywHv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5828BAB3
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292565; cv=fail; b=msZGMwmG+Tcd7Tz78yTuS/pHXlNTjVwvB0Iv+gugiEi0PKLwpBWK1PzwCZx+pnlleFegUU6yl6Or1BB4yyjtWIpglafBVyg6qifKDwbacdGMoLMV6hwDaPzkqNFqQLSV+3G0+Icl5Vqi5Q5c2ZP92z1CVSkoDvB/NVuTgQgl46c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292565; c=relaxed/simple;
	bh=YZXQP/8qs4AHgq0LVEreRzEEMW3lr52272iHKRaZk+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IsvM3+P9e62IpA/RvPqZziGg591h+Zj6DcSrSyRlGgROTbrRvjyBKOCbGKZwNSGh1g8u5MCAl9rGeg7UCH73M5NNgsfat3Wt52ZU7sYpP/POWTDQ9Hz3ULVxzR2/+Jw518mB1kMd8Cv9FeTCo5yD3Bh0DfqSOtgHYa4uVmTsF0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jJFcywHv; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5QdN8wyYrN8jZAgBwPcvbBWd/gmi2lPyNLOqmQ726QyiPWvD5jGUp0PuuxmGNhZu6+4RAXvmzv5l5g80RYrMNYM3xjbV+L7k9dIYAjPoFg0v1VFBbyM+Jd9ZR6pUrd360X9RfgX20MbfTW/Z69SUjqIfNlHy7Z9e4jf8+iP1YVQsLSPtizu246iy6RLInurQ23BNpL4j/gGKTUglrG1lGoIEi+wFRIXEdslrvdRiDC6HHbWbkyIoOPaVDzaLvL/38CcUxO1dWCPldCJ97ca/230cTBDASDSVKedDlec3lXKTInVjUfF7hbHFhen6Fr3eln3d0/MVKU9STvefAPCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWyjuESRIh1LiKwGCAPJrIFonjm+MKnAK02ghDKM5Xk=;
 b=y1wvVdAj+VBv4ldUz1JMiQRCrY6qyCvggEFDrDAwhWS8GhEkY78gMaXAiWErmn6jojJNxDMVuk7SWQodC7HE4FZWRkIsMq9Yd3d+ur+r7r+bE34f/lfnMBlhS+2Z58+NzPKLboq7R/kTnr/+XmGb/F7ZqDsrnlADBgIZrhCnxPwfKqDpSsviyBocZecpRfNKJKDRvixM5hzKyKPSXh3SeempNcFkDWUlur5OjPAW8oisu2wp7x6kDmMvtc6LtYf8U+eLtz6HfqPZhv6PN+oYygnwXC8Um6zu11LrgGDFSOnTQ+7VJshkzlpT2z/p5GIzukSyRLUFRjsF0kapUxhPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWyjuESRIh1LiKwGCAPJrIFonjm+MKnAK02ghDKM5Xk=;
 b=jJFcywHvHnnwXyuwKuC+WlbraRZSW1Sw/7UPTRUKyEU3v4Gq08wEFK2EjZCuem3mJLTfFj/KPK6kGoy9xHsWyIvFiy/vd/c104ArPCgrQnDmfl1OURUopmXOAnK5N/uj7t3FO+9yqkS2vJM/Js/HE2f33RA3xycdnaUHSSlgMgRvOhN5JI7bLgXpNlCv93Nerf0jil9Cf/NtK/01RtIDnfzNyFKwDeAtFYlnxTqB5gNyJI5YhMT6mWa1vQZUItFpwKJRNdyu5uxvqEWSO9Dt5z+01yIzNisnMauCHd7vYio5kWGsxTy+V7QVi3RzF237HsTw3Y/crlofcLVs/2tNrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 14:09:10 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:09:10 +0000
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
Subject: [PATCH v29 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Mon, 30 Jun 2025 14:07:34 +0000
Message-Id: <20250630140737.28662-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8045c7-64e9-41e9-e584-08ddb7dfaf4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g44qyVJ599CQJmrUJqI6Ha+GckmP6UrLZCCFh0/91pU+aEgwJ6GmnVYDFebH?=
 =?us-ascii?Q?UnUUZCIEXbpfPztHt7d1+AmmhUwijr89hPmQ6YHOMmmHwrOjkSaL0kSMUXHD?=
 =?us-ascii?Q?3YoftTVqvY2BaQ/OHXf8w7vVXg2Zx6Gy3sKLoxAylXgAfyUirce/USIpBo96?=
 =?us-ascii?Q?+8wKbgEebmQyLQ9fW6/JSnS0GNxODOMttxq8+yNmtXC7sB6aM8Ln58Qe+bo8?=
 =?us-ascii?Q?NYn0dQb1JGWgc3+ipY5Mbx8zByuonVT76pxWdSRxbMRcltZ0QTz78zu/hpbJ?=
 =?us-ascii?Q?yICiDqTH+4AjexyGxbtAaNA6WbvBaC3m4/pYlEHJ2RzbOUVuiJz68pUCmVjM?=
 =?us-ascii?Q?KwIJRVZN6eRn1kKoSxhUO0iXdQWhKQRp377xn64kGO2ACbMewPYNchG59uuW?=
 =?us-ascii?Q?2KEIy84iHT4l4bbJ6cVGFJKuLOhP8+fjqrjDZnYPwalZ1gdY3EM407iWc1jA?=
 =?us-ascii?Q?vn389NLfT6PGV2VWY/QaIivE3EcqEipaYygh4/cdQvbnnpFVixPrKh3q2rE/?=
 =?us-ascii?Q?226nE2Bop3kovdoq2XUTFQme3uvatYuFt+jx59hjp/uGuatDvpIuBcHwAur6?=
 =?us-ascii?Q?WsGqLrhhldEtHNwGoK+JTVyKYsE6Po4Fojdju1RtX4fQnRDBD2s1GMo7BWt8?=
 =?us-ascii?Q?E0R1UHODdxyFZI6ek4drTqqodQeUfb0deWr38CxmXIw2wKftBBA6UrPRDA73?=
 =?us-ascii?Q?prTfjIbiYQy0cJ+yNVv9+gtUV+OG1w9+1w/+O8vJFrxDsYD1PGRQArN/c1Fg?=
 =?us-ascii?Q?ZLYKFmJxZuYr5NXZuj6m3mB8RNsDgIW5vop08EN8FD7X1nhmCup+kqlsg1bC?=
 =?us-ascii?Q?DlexUcBp7Dp3pDCYuLiSy24XvFc/COFu7N2w70bqWynXoRR3S/mqJvsetIRk?=
 =?us-ascii?Q?An7uw4M/Ym9b6VFsdHRQoNfb07r5dcgb8xPivY0VhBQoMFPQBfzGRtLiu08j?=
 =?us-ascii?Q?VWf3D3VbhfML0PPg24C+vQITm/hTRddzJUtWVFzuJGPPAUWL4LauQ3YQ0SY4?=
 =?us-ascii?Q?PkP+pZAjnAw7MMjT99HbzKxijou8c3ydpFgdTyu3zSTO+XUvab5aL+XOY6Q1?=
 =?us-ascii?Q?OQNVk7o/OLC0MfFcY6aUt4h1JQ0CqKZieRtx5ytG8Zu+z9EfDYAIKbkmVYfK?=
 =?us-ascii?Q?QovzrBY7EYvrW0dqe63hpAECmcO23XCvQHmQW3qDeJtySi1xwlA09uIs3vBv?=
 =?us-ascii?Q?2iWr8Gj5bIog1gJi7UgvG3T/tHiJpv2fXZKYHSPJX3q83F23eb53CAbCY1Vr?=
 =?us-ascii?Q?cjPR+j7c5QHVZOgqToa1cMHg06t2W+bLZWiFMJZQ4MvwjKlid+VluxOzUh8d?=
 =?us-ascii?Q?0y9EZPs7zpzGRbjH8um3g+K5nb4u8tPwF4S8YIfuBElRauNOWeDpXkmaGbOw?=
 =?us-ascii?Q?IwAT9cmFQO9zMizqNUFQA3L7tfAjHJupVlFDpIznsrX1zoiIEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B214okoT/+fgHyLlP7gq7pfWoH3We6X1TYG0h1OBkueKUfBi7LEeCcBbWgL6?=
 =?us-ascii?Q?F/HEPdu8L4CUAwWKCV4fu36FFOF1/tRCLuH8nMj/0KHLlXY89iFzSBmgxtTg?=
 =?us-ascii?Q?1W6AN/EGjKNdgbi94iHYhitgk5k3mDSOdmc0IPUVEPo0ovvUyqL1LQwfgDkL?=
 =?us-ascii?Q?zwsMueAhza41axGyrz7ZBT2uGNcfqI9eoBtO48OxLVJcZ1mTCcnMzfORUXUD?=
 =?us-ascii?Q?0V09JO0iGgjMEgGV5Dk6TolQVtEuPVfTIR6waTa40AI2Vas9JYgx9AsDGrTT?=
 =?us-ascii?Q?aifcZBrO1jLYYBScSa7dDhidD1pCktU0NUpoTYD1YGXc7NCV8jK4/nzEIT0t?=
 =?us-ascii?Q?iP1YIDhRLJQyIQOSw5f7RMia66MBXIYWLrE3Ui0w7TH+/NQe4s4Nj6uFiwzI?=
 =?us-ascii?Q?xP5SEX2bCHVGgldXIxnqx4hoahpS0nygXQOwtqSBfP0rRr0wv/Y6koRKfz09?=
 =?us-ascii?Q?8E0/c71Do8UJ5MMknxB8DjqJqsmYbgovjfIbhB6L6w3Ow1+bxpBlcw3lFrgj?=
 =?us-ascii?Q?wNV+epykMAYnTVWtrJRqeezjpnsVj0tqoYTdjA/J990YsPHimazr5XRTQWe+?=
 =?us-ascii?Q?yCK4kztTR+patJl0on1DoLMtx9vIOJv6P78EdSfjdqizL9ekvqY2nSK/nm5P?=
 =?us-ascii?Q?rLD6rJP2/Xr7BEf33Z1az9bcGkAMx1nm7vLpk+axeuMDBXNj2PEMyYFJZ6ju?=
 =?us-ascii?Q?P+DdMGVmnbYLbPLVcYOHaQEQVa3+4aMSf8lyO7AczeTiTb4IhB7Kida565UB?=
 =?us-ascii?Q?onzmwW9IxoFh/K0sIqwcAyQCyZZuZ+Rg19wMFm7Ask0hrjCUdnFgn/Fbs3rX?=
 =?us-ascii?Q?6u+lECY3jN0j/RkChn4wxUOde0OK8UzrWGWcIls2MxAKgT1Gl2rIcoNNxLms?=
 =?us-ascii?Q?Pse1gyKSGgiAPKzoxHJvp4b0WCiGhVbgGfQB6yfjktwUP94KdrnU0YU00SxM?=
 =?us-ascii?Q?hx3peUL6rE0gBBAJ2DoXKEkD4ciQeGB1lRc45NjagaaICDO40xFUUWWSt8lA?=
 =?us-ascii?Q?xmbJlg7tc1gOp1bslVeuXdKCT8WwJ/4Y/+ex97Hon7ymZYisW8/Y19+kA9gc?=
 =?us-ascii?Q?29JDpP0vY4ALGPdME+aaBLZL6mV0kAdh3WtWmaXs9gZoudvHZeAHEJ5JyFEi?=
 =?us-ascii?Q?YW1gDAaPoqnDsteP3nk5gINfT4q/TBqlSSBk3k7aOXLtUtkO75AoSJte8UD+?=
 =?us-ascii?Q?YYcMAxucJNaEVAFQzix0+A+XXUi/DEIjkLO3LnBrfOEOsNWcfLbJL+iE5fFU?=
 =?us-ascii?Q?TW1fYFwf/Z+UQyGIYqUTJRmy6kKYvCbvPCxbwIpEhFwjLoAWCOmoZx0AkzGm?=
 =?us-ascii?Q?MS41Ca1tendIKahNwMS8NZ+xNK397Pum9vthJaIqB1m9IuzNHUIseG6tlf/f?=
 =?us-ascii?Q?DtqI5bk1h9dTM85BT6eCJS4Dx+OZMjUGEnzLFi4YoCQS+Zz80vdSBqll8qLp?=
 =?us-ascii?Q?gylZCjgU2zY2yqtrIQGKdi1LQXhImzmTbzUPG+wk7nWGbx5NlqZjmy4R/wTE?=
 =?us-ascii?Q?LMw/ZuXUzrpRw98uhJN4Zkcs8n+i5rT6nTarV64Jl9tpn0eg5n0GxEO0MFes?=
 =?us-ascii?Q?H6ejrobSiwYTRmPlQmdlDUZfQxLl1eLR56U2vzRK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8045c7-64e9-41e9-e584-08ddb7dfaf4c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:09:10.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPdZGBWQLSVJrwwe9oiRfq8NrCGwoGl5Z602/pzBdNTSowHfGLYQrPgmWKORnPkJsWrsf4IOFPqrelmVqsky7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365

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


