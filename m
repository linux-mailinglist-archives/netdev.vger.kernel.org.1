Return-Path: <netdev+bounces-207121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A101B05D13
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363D13B549F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0C2E6D06;
	Tue, 15 Jul 2025 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O1E0P2Z7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EC2E6D0F
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586180; cv=fail; b=E6A+4Gd2bhVqCjF+9uF72QC54isjwwT4Est71+rffs0kdpGeilcbVqITV9jYn+CiNhbeK7sOaNapSU2GMY63t0fKL2pO326a9EIweLBUs0IymW6TTkt7TDn2j7iBuolY2VKqN4fGTF4qJlXvapIOP1UfOQMXK4yhGX1h02Wg/do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586180; c=relaxed/simple;
	bh=YZXQP/8qs4AHgq0LVEreRzEEMW3lr52272iHKRaZk+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s9BSnyx5EuaUVy7q0lT/YNHF5E004ePREcnte+bnyh8G/NkYYSu1O/WSFgNK042jAoA0MJmJdl6NjlCUkQY4QbNEXtjFVerh066vgMX1+dcuFTWRJA3h61eBk/jK+8jgTx2lQdcgXwHUuGtPVKAPBYT3r/hjOgtrQJrvbx44zn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O1E0P2Z7; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmOFDSVl1t1AuolZk3D3InnBXRsUm/FVUgjYwN/sRgtmJcVBu+kXrT3K1EtyvqlOa9fSyHTOFO0hQ3v6oLe6dt9wPdDr+ZeCJw8Nn8JFBuQjUyC0JauxWWCCt94ym1hMlRLrQRD3lTJWGs/wAfTEVap8Hv0zKP+XTo3xfTarbLBGqDiMXEZwFU4PQIEFH+JdcykjGp3+r8mnCcLfOvDR+4CGo/zp1GBrJjK+xcGYo9q+NBXyKriw7ni+wUj9axhJw5Ry7ZvaG7f/kkAUhXJD2pDm2xraAbWEwdfrtzdwLJ3Qp6XEvE9GD2uAc2M/Sd8zfj9ucZo22a2cbbh3QkJpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWyjuESRIh1LiKwGCAPJrIFonjm+MKnAK02ghDKM5Xk=;
 b=co/84wdXPKg4AOU/aql9qPLnMt7GcpXTjcBKDYbaX8FwELXH5WQnXT1lJ1yX0ML9hvJwoqME0TiE3iGBzIYjWQ0bBPFvnufCVseR51okoIPMdDUmDYqHBnkVJb+geP4eMESsRwlCELzVXaHO5vd2RgUirN91MuXnaT+e9jcL7sSqTwzeB3dBKJxmhT46TlSspaDqKWjCo8FKVHgfttIdTTVJUa4Rfb6NgjoIPsSrIjX0M5rVCRZ9a/ssSCGzv/vae6Vprx8PKJF4+kYrC80DMLcPRaseNnarjfJS0T8nlS9GHXTzwvrDi0ZxbQFhfAuXIJsLUTfcDzB0g4e9EbAoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWyjuESRIh1LiKwGCAPJrIFonjm+MKnAK02ghDKM5Xk=;
 b=O1E0P2Z7IdM6S6J9EeYnVpXUGkrQaYzt+oz0aDBOM/yZIamHeRvblNg9DXcaxtZKneq1w237GCU+FABADSFKpsYdKrd0cyEez0gLvgQjmDh1P+5B9x/JdNiiF9TDBKqsCtEH6qwxfL5empE4NEG/99urhwVi3e7tuCcaLCKsGILTNdDL95JPnmuQ7LdS9chZkDLxVNsh1UqTdmZReaJ/AaHd9C0qZOJ+WVOZdn7BBE9+uz49vE+XfKdSXTLQhUPwhqTgGBHV+Lr1KaiLmUYcDIKKDLCGVKlbl5VrBqMu5wmPT/1gJKCKGy9iZGQELkDGn4MkyDA9rCv7VwG78FKTxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:29:35 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:29:35 +0000
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
Subject: [PATCH v30 17/20] net/mlx5e: NVMEoTCP, ddp setup and resync
Date: Tue, 15 Jul 2025 13:27:46 +0000
Message-Id: <20250715132750.9619-18-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e1d8bb-9c8b-4aa1-0b0b-08ddc3a3a401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mGqxWDksVR4GhnPBGQXySmApYQh2/AfHWUEFQLH8ywxkO+SAlCUkMF7g5wYN?=
 =?us-ascii?Q?CpCYo0ruZyFoZWzAnCvYcgMtGpRxMsrF/pE8ij48II8rj7IU0PA7eM8WkzNl?=
 =?us-ascii?Q?Y6S1dOnJGCnnMWlQTFz0AiE8V2l5a49DqIuqmCsjPcwyQA261VepZe5GjM56?=
 =?us-ascii?Q?R2h90rESfaowpPL680lwZgW+lLvcCii6bAQl8vZy7+HIYg87pplY57nsfpVc?=
 =?us-ascii?Q?/NmsHzkUz7w40wW3jFo01JKXx+kE9Wk+CvA1d3WX/EcG1XBGg2sHWyc5ExOy?=
 =?us-ascii?Q?h+5Tsw3V5HZ8+YtJL/5ArQaSFvcWoB+DX3WA0VoFZ41sttSRaBCsCXs8x8O7?=
 =?us-ascii?Q?hSY29RPDBVsgdfBRdtVI9fwjZcuUPAeYeVKktej88NJro64MQgy9G7C9H6K7?=
 =?us-ascii?Q?TdO/wBa78fTdFAE0Bd/9SQetPMLZoZ/Rb4sw1MNoI6kn0s3sJzVcvORE3uQw?=
 =?us-ascii?Q?+swNrt9Z3K2Lb2/FbekzDtLBtcy+fKtz9Wh5izOb9UZ5eINOJjC+OiH8DrgP?=
 =?us-ascii?Q?QwPy5DvO0N+JqJlpUjm1uxyEv7nu9VBTNd0hxwq9BCOxUFzOUAQQ8MuEdeR6?=
 =?us-ascii?Q?TJmLrJAfKh8PMocldP2ZNz+EZ+Lsq3ZOFGWPTaht52xwbPmv74OeX3Gv88tp?=
 =?us-ascii?Q?y81ni8//XN3CgRW6BS9IFiSKgIj7pqYD1UTazUxbgnfjoka/4sSJ+diIXzm6?=
 =?us-ascii?Q?kjEnH4wpb4RxGmhfDgdyD1MxjjqwjDo14RyszuwFWNx+A3udXdIlNafG2R3R?=
 =?us-ascii?Q?sSzwGnu7MdmtvveCAwihWgkfzE6MEG1O2yB5YISXoaOFP7oWyQdHbvHMMOVK?=
 =?us-ascii?Q?A5yTzmlMxJUB88R4XK9c9Bzt9E4EvS2jNkjHgg4DdpQDtrVLFKdHfPpH4QOg?=
 =?us-ascii?Q?tXkosNwL/xsmaIHjLEfgAunQEM5gvngMOcMNB8SvWFebTSMNvJbgUom+3A8x?=
 =?us-ascii?Q?1r6TZiA1EQdpW8srchVJANOyOubLdW44Zj8TEgHygkBQEnQpU2odYqLPqV3X?=
 =?us-ascii?Q?/LkpWWEYhFyF+07ris6/Gc8ZXiEE3hiiNEqLYEpg/i1viFOU3P2JVXLuh076?=
 =?us-ascii?Q?kjJIFWH77XpVJfYC9KmoLcX8hPfmYuTVUUJNWqzLNv3LRLW3Gl9cxvBSYB6X?=
 =?us-ascii?Q?itkz46LZ/KsGRLmd1sWEpdb+zwxY7ri5LqbTapBht6/WLNcusfOs6wUm8uJa?=
 =?us-ascii?Q?XcKu2sdkdlA+9jpvg94fh4NIcQGTUARi35Mo2BvdeVmHGJqPaLd6rKYz3C2V?=
 =?us-ascii?Q?AAJBynqpTrKldRSyBqVbhof+WzLrEDqUCSMzG4eEgBfjTnbx+WjiYrvYDy2P?=
 =?us-ascii?Q?mPf32wAVZ+xW7loXT//gLFQTaFHUGuRmghgdNxG/NSwZEOZKPts83gSYH7Gq?=
 =?us-ascii?Q?Mocm41fty03/3+AU+slaxBAFi9IDbzIhWaxnhv5JDGUXiiwRMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rh5TmkXRDNdQ/4oaIyffBVOhHUgU30UBmwU8YZ4OETkUZWxirpAyWy6wlzCZ?=
 =?us-ascii?Q?YX55F9KoEOpJ8TvrHoL63PYaLGkj9Mg2wK32/A/vTA1o6YiEF7jo5FkxRtwu?=
 =?us-ascii?Q?OPx6PwNdEe8rm99/3DrktUAF2ZCyj3EAVe80wHkBfl1+EoOLBuc/dd8YhGnG?=
 =?us-ascii?Q?IUkzC+FXEsAb7kRX6CGlHjBft5H2Q2xhhl0gxnT+fZCQzewj9htALJ6PxXuk?=
 =?us-ascii?Q?t1B5FiWsjx/NkhVfrlZCDT/aKcKaCOm5hDi/aJIEphcTDSq6iVOv0DLYLckb?=
 =?us-ascii?Q?7++1yF1CaVFG7UiaD00u4dpR1Xgdw2vpyhBgjkVrQI0JjmxSZcP+XjT53hly?=
 =?us-ascii?Q?j0wyd17UgWf+jFRk3JpRy1fKp6kIE8Efw57JaMzT6kr/0qJ8DfETt6EUqSH9?=
 =?us-ascii?Q?cERJPG6MUKgsXjS+luUwkMTuTP+sACCMs8Z6jn02egw1H/TrlWLg3U5+WPzp?=
 =?us-ascii?Q?9drI/SUNxovu+b56HlPJefoZXsd/tD9sC7f/bo4n5RcKj85P73mUp97SNTWi?=
 =?us-ascii?Q?nTLeeXNOHz12OdSI2emOKqmBMeK4XuJ9coQz+1oPf8OzXOMtBSmZlOIL9ikA?=
 =?us-ascii?Q?gEj+T5jXyvJ0yi+1U/Bx34hrmfA4EHYLVCJn5ZHJz4D5eIbai1OjLjrNNQCm?=
 =?us-ascii?Q?qEZYY8r9mPB4MUSEOGfL2cJebtuGq9JnxOyAjJdijSNwVxyqTvONP005x9iy?=
 =?us-ascii?Q?Jz9E2xTZcDCV3BCOG54KV/QtA+AVxMsY3qRtC2h7Ef7FzPLqlxBCdFIUJlFb?=
 =?us-ascii?Q?X82DbAJNMweZ5xhWefsiTv1ciO2kHj5n+CxfLQF0PVKDSnN3NmZJk68X2MAA?=
 =?us-ascii?Q?QIwt1Byh5IcoVtnjRN5hOfMDNPXdtJjWR/hHko39WvsAu9ZpsSjWWNxZcX7U?=
 =?us-ascii?Q?3vxDCUMZQo+X2Y1psOF+ZGhCIbYtSJAdQGqVrn5u849c0zXyD652JfJ5nvB4?=
 =?us-ascii?Q?xNlzcdQqZeQ2v+u6WOeeF2ahnVsJ43eQ4kgDSuWVwch9iHXxA1qSkDLMSuJQ?=
 =?us-ascii?Q?cwAn9rbaLx/LB518jyPOUkZqw9KWBHuqHDuTM3rDVi3f9/6ASf7Y8qkbgvXp?=
 =?us-ascii?Q?wpyAxmVcvRs30QANXDlGj03/8D8+DZfiy+RdD1aN1mtu8hA/LeRTufeLxmww?=
 =?us-ascii?Q?rTN7R5SVbWoO4mO0rfyIyxJcIi5nVfKXFL2Ot82IY3tUqqeGgSb2qS8aVKat?=
 =?us-ascii?Q?mLycWEJIoMlIKEz/xmfJjDAgVA3ikw7kRoa7qYWPNMaFBJFdWx72hFo2MKK4?=
 =?us-ascii?Q?DN1gZl7Iy6bBhMmpn+kaGizzrNSPl4hFPa2LO5dokYs9QDwdWB/9DiQacugV?=
 =?us-ascii?Q?txQ3KU0MF/nTFFX2jg2qe6zChW/jsVAzC+zBAXpFeVtUsO69NEWdRCdsjegd?=
 =?us-ascii?Q?MbVvIktVkvgQMumk8wnJRv1meFQyD1HaI/EQuV8yHBBGBsDtXtpRZ4O2EmbX?=
 =?us-ascii?Q?5/Wo1ONFTdVJ6GL5tz9SP0GBVn7hat0RqLJ7smV3xhCCt+dM37lt6xH7lIom?=
 =?us-ascii?Q?Fr52/cqcT1EQfkv1nxDFX5LE+YxEFSb5rl9Fws+HkeifIl85b/8Zjxpz/WHx?=
 =?us-ascii?Q?G93SXo61bLdTEwLuXenALasU8tlE/4gVNytqAG+d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e1d8bb-9c8b-4aa1-0b0b-08ddc3a3a401
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:29:35.6862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Vz3IGDMjtOz71zfOns6Aa70eJ+AoovPzNrxNJwikCGzeT4ogZgN3eNvYzlK5FuhJmEHuaQ09W/5y4Fb+vJcOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

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


