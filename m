Return-Path: <netdev+bounces-192733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85045AC0F4B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A67503036
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06C28D8D8;
	Thu, 22 May 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kbwz3t0l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1F28D8E7
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926124; cv=fail; b=Zcm/WnVYcfaPBtcPnB8Cu6LRB9O6fhzXTvbASuRyGyTRe2+w8VOXi5v8BxCLdW1faEUyW7pmW522LA2FcxXnVOfxR9psI6x4MN0Vy1kuaXAi/6G3V8w7Z35nMzJ371tg6OK7VrBADGSUOKZHrB2ZZ9HQk0VjH5Wnsn0OQdjzIFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926124; c=relaxed/simple;
	bh=N1W4wwUW967ngYtBe1Xg8nMjeSfIlDDpseYk8Vc3xsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=UF0w8OTSCF3Ir5wFZbK3KaG7tOpIJKFg2u1EglfGBH/7aLr76ph1JZqFLlsvdAH+81zxShY7IeUbhwowDa5POiXSzt1g6lvoLUAiz23He39JvlD3yrMTLAMsmxpvPgMvS/Axmyx2eLbpcY2tpF2crotDzIUdMC8WbPY8FaItdp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kbwz3t0l; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzSXqe+//5B3VF/Dv1buVjNtyryIW/njUCcn8rhFOXBAWukCoxLTAFHNb/xcxDvStHrP9B6jleyOEysfqPcohaW6xtRWYrQNmRYDaJ+CVMercTmcpHuJEk0Mps/ELzHTDKl3CTxkk7p/AVXd6K7aam4WMyKVROp4ytZ2YfGp3vhB7aAU6/hCnZ6ZEvfkVoK4SyF6pLl41qtFnRi8d64ZCUzss/QkwX9R6EJzNNKDROoKwRdXhX0gs3O3rEMcsgoP0nBvoP52QZ+4Wr22iFVaIC4Ex5WHslkaHQxuSYaEEkaq7zL/zTbrbb8P4eYEDiNMJj++8YwASG2E56aNDvEPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/2nIGnScGS/ag54ujSQnB2qMCARPZsy8oidULpx5oc=;
 b=NedI83E/JxLaJIzxPyJ5PfnknGXul6KAF/fMdieE0DDoYZDmaC4zxnsJnfJXtNpeitk3xU2NfuR3KrwUDUzVlf/zZR9TecmL2kf9jLkNuqwbce7jNjuThuJ71Pwc32G2CH6E3vebNRlOPHmvS67v1ZKQqBNsmxiRl+/DoG3fF0qQC8wB0iqTqvTnyplcRRCw14COpDHWCtOX/XuB2qC8kjFot5AydBKOGhEt3Xh1q+g/vSYLm7Vmj5TUt158dUDBRQatschBcDHb49uA9OCS5tBos5AmJ1VXmtAWQXHQCNeBgijRhNWrNqs8B6srkr+3Q7qX8roASTTAUBroCij1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/2nIGnScGS/ag54ujSQnB2qMCARPZsy8oidULpx5oc=;
 b=Kbwz3t0l1eba8+Vz7Ec4F+8phaOzhLun1WaVDWDgaecCl0gpvLapy4szWgNjO4YmVdjUKDkW2IzDiMq/VNiM/Epoc+HYdye8uoJ786kWEsIit8zv/O/gToq53qBHHeLDPucc+2YxPLgTM1nYOZoAo2r81odJp8TE2X7Z1nBwpdR7EW+yx7EGH1JDsME2+qHAbhU1dcqZcZP0VhoKNTWszgjTUqGbPHuMw04jaEYoBlA7Jz8PWhSfx5Cu6GvBV/Qqdpg8lBNxl2VROO45jN/5p/T4oCbhj4Plg0c35uNIJ1gMp7SuC86/X6ON8yE9Y4G6q9oYEX4F+WRaLMRB3gR/fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 15:01:57 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 15:01:57 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org, Boris
 Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
 <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
 <2537c2gzk6x.fsf@nvidia.com>
 <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
Date: Thu, 22 May 2025 18:01:52 +0300
Message-ID: <2531psgzo2n.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: e10e0b8f-1b15-40e9-e65c-08dd99419863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z7X9xTH9gWhiMKjBb8Ddw2QQylE/kOEdITHRrmXQM3kunf/Odmm6DcT8lUs9?=
 =?us-ascii?Q?tSWhpbALeicoJ5+M58Te+rHjUUVHDiKe0dSMMvHwZfYcTeHIHTWO+9bVYNL2?=
 =?us-ascii?Q?nXZMjzvCdz8lbb6DQhPqgNUwVVoB6Vs+4PIWDw5PcIFUDY+HhS0CGx+L/kLr?=
 =?us-ascii?Q?uS2vbJkrekLjhe66SfYLephUDIra2ZJuaieEFmXC8bV9OUQj1qXr7Mte2m3W?=
 =?us-ascii?Q?GynBOSWh/GSSPuZqy00rLbFlQP+L5d8CSivniDVC/IuU7lvZrAF7YEo7lOjk?=
 =?us-ascii?Q?HBnd1kKYlKBLG4HLUbOftm5s/BrIZQt2ZG2A5IJG5tWn0qB3WTs7FptdpcXZ?=
 =?us-ascii?Q?Z4XNjMHdrXzwMQ9XJzhDn7Xo3u2wM7di9/tZRFk7EUc0r1wv6XccixupoVfm?=
 =?us-ascii?Q?FV3UEnPGSA1ICLxzXmIPxZU+WXkpOze6szKEZZhjzDxS+s1NVPxdR5iK/672?=
 =?us-ascii?Q?jWOChOXq9c5uqmoR0C6Cvycojsac3UoEhMUt38QxxPiXbrJCBF4WIus+zL1J?=
 =?us-ascii?Q?rAv3+/s/2iB+Bl5nrReEQM6b5tatOe3zXhxVurrRG1MQyNvn8q+wp+7BWCcf?=
 =?us-ascii?Q?/wAuE9URUVtV+FA9k2uOch41A1z/+9B2eOlHV+i8aRW6DCVMeLet9fQzwze8?=
 =?us-ascii?Q?zeGwSKm586i8WF/78sDY7jzzgEMlqO+gK69zOzWRwl3xoGnmjPs/soExQM5c?=
 =?us-ascii?Q?XDHyGdskO0LXhMnhO/CysQHec78VO0Gie/ttWjdPwCKm8TmW141WFbPEsIvY?=
 =?us-ascii?Q?l5SB+PBMj5DxW4LHtCPmn4tQ3z2/K5jCaSk4INBQq5nABr4zLrvTJb3ZoZUT?=
 =?us-ascii?Q?EAKrZnP6EzBvHXQDi9ZItO6dxjZX9wMFQMOqYnbguPSBWc/almNIJaa8dPZz?=
 =?us-ascii?Q?h4gm65CBiK3SKGsVeltzFGjLQ3QRtKKsbkooP+s+osilkf/hSzwYGEWFhqNH?=
 =?us-ascii?Q?qzb+o5MbhI6e4TmrjgTPeFyGAj+2BRMe00V95ZPsN0qPflYNfJoPnKlGgLVB?=
 =?us-ascii?Q?8S07zEya2qhz04lDSFkRROjcSOVLwjLkPXJS6JlYkQ/JEh8prc7VH1rWCNPh?=
 =?us-ascii?Q?sLgO+3gFoVe759OP/jN8+EKVsYbgz/IqrQHO7jf8n6smdWeDnmWYNhqthrG4?=
 =?us-ascii?Q?byq953oWfrVIRCOdkURZGVCUWnMPrfWVYcdcSP7SNGbbUTNpSClawqkLxuIk?=
 =?us-ascii?Q?qcihXI75W3LsX5jL19Fx2//+z1LBBAqtJUzz2eXmaDmtZ1+naOu3tIDl8JjK?=
 =?us-ascii?Q?vzNSS1yk3ffxIzeXdg1L1aE1MmjVUZC7d+Wb7py6I+eMiHPeLdR7thCMNh5J?=
 =?us-ascii?Q?q6IvtzIjawF9Lp1vU+WV33jUxP0D71GdqGyjV30zkGLRTzSbYXMRe9HP1P37?=
 =?us-ascii?Q?NR6Rq3Y55GCDu89gNeoNyuS/X+aIaRjMoP1V0Jmbaulg/ewr6tQcZLWn4fXH?=
 =?us-ascii?Q?Z2b/OmMRlzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLd+9zm3qxN6Wi0XyS0wwDjOkm0ZsIX5Td+dpXemIet3qStAZaJ/7dQp9Euf?=
 =?us-ascii?Q?nc7BkXgMAvMkqhxrVA7LtCgqOdWHaP1yWgnfQkvan33Efj/bEivpAa96/983?=
 =?us-ascii?Q?aF71bcB8YOrE/7H8r9wv07MXP2TdtF4aAUnWLbYTvr/iilZ7k43TWsX++Y9T?=
 =?us-ascii?Q?pUM1HgntyU12oXsyKo/E1UInpxyyvGy4NG/pkhm2SUanarU7ZFz9jhHaQMCW?=
 =?us-ascii?Q?9zjO19XYi7Ac2lJ2fQmbyk8PVkvHAPgfQ++FdJNG3KWNwizzDxVsMDF7i+fl?=
 =?us-ascii?Q?Om5t7OYvdsj6WLSVftXHuvh5pfI/frpInU9NGNWEClwXMyBuo1aWBDcpNJqx?=
 =?us-ascii?Q?VwCbpYKZ7RMHen7B68Bbe1pcdkW6rnuOe7MO5cpW3/e4dE9cuO/DEqKgUzaM?=
 =?us-ascii?Q?S/yInw2VIDRG00j2F3bl8FW2AdzyqWhTUnc7CduaIWLKcu0SDBf4jtcWqNqs?=
 =?us-ascii?Q?6FK+WDAGN5dYIZGl+BXnvE/DWfb/L7bMFGYb/CtqhXzvfqZQ4Og2zGPAPaKg?=
 =?us-ascii?Q?c8nMXSaqFSdIbSsFOeGR0daH5kvtSDribItXEs+TqyEJMRr0bh5jrEwbuiTD?=
 =?us-ascii?Q?RQ3PCPRK4ZvXaiOo8YaVD9I/cVqK5WLRVRg6QuZbWyohZUUCcUMT9Q7hnK4s?=
 =?us-ascii?Q?NYhKFf7LKZy2seqzJ04usJZLELFQuncIRkbDSEnFW1i5tOqZe/8Mell/5P8h?=
 =?us-ascii?Q?x+EoqxovvqiguNat6etzGaDrbXG0eLpFWXpe4ayv+JVqzJiKVTHsXGzYq/hf?=
 =?us-ascii?Q?DK0B4DqqvIKeRhdIzNp+HxFPfXRad5Dm1ty1K0EdTnQJ2Ir7Tp+kLE2GR1by?=
 =?us-ascii?Q?axnhSPki0agrj4IzDIfiS6oXpnOn2LA2mA6lum6a5DKBBxbPuFHcIe++eptT?=
 =?us-ascii?Q?W03dk8uieIzsWsDYxLgmk2HU/+o5/b0dVNsMg3WDQLgVIdr6rx8xK9gLOqIP?=
 =?us-ascii?Q?rr53NP7Quyze5lXxrbRBXusED0oq4akWSymCoDtmrGd4Fkgyxd/gQG45h08r?=
 =?us-ascii?Q?IHdZ6F/DBE1QIXhcl9xBS7MxMmQow5VdYh+joNb8XDkF83ZYaGbJnzx7uORC?=
 =?us-ascii?Q?kgPma40lMGj9cC3+Fj1vM/o0hNcStU+EWVdsUR90TYOaeg5W8CTPoTyNja7x?=
 =?us-ascii?Q?/wlnZf9A6fD0ziV3fq7YjQJvzXhLPZXjebJxNBOzEkhKg+G6owy7Z6KXjorG?=
 =?us-ascii?Q?6XxAVc4HRX7mu71NcenrP2738UyWwia+D6hxIj85ti4Rh0V7vYkw7SpK/k5D?=
 =?us-ascii?Q?k3YmFFTdZDWZAN4Ca8NZJhhd4qdn0xbNREj2v8W1nmzxo6JsRvkz54iWiLxk?=
 =?us-ascii?Q?W017rAOe4DNnrnUsG4AgUVZTsLQy57vB58Yc+Zhcd9ebsnKQ7e71UQBdOOYv?=
 =?us-ascii?Q?ig4Y+hHRN8EDcFnbO+IovW1MoJo39BmF/ygE4w0R3XQ7yfmVBn40CTI6cWxF?=
 =?us-ascii?Q?R7VhlQXZg/v2nCHXqCvI+F7jFs/SpdFpzxM0FkEoOpgN1/nXDc2rWViF9BnA?=
 =?us-ascii?Q?/eF2MnO/7pqfmkJZndsbHQ6vU87QP/ceCMKvn9DLsJ09PD/dnbLPYwEQXHpa?=
 =?us-ascii?Q?xJAwlF1lhy1hdxJPpaVCoSU7e277BqvGTuj21Cuy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10e0b8f-1b15-40e9-e65c-08dd99419863
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 15:01:56.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnfY3KTABE5ov/hwelC4DzbcJSHd7tp0ntv+4lYxCOdogJx5wIY9NsodHYWjXiBA78p7Y9vwGDw+MNXB/HRJrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474

Hi,

The mlx5 driver allocates linear and non-linear SKBs depending on
certain condition, MTU size being one of them. The choice is a trade-off
based on many parameters and performances.

Your suggested change affects the non-linear code path.  If we increase
the MTU size and use non-linear SKB, we don't even require your change
at the moment as the tailroom is already too small to be condensed.

The problematic part is the linear SKB code path. With a default MTU
size of 1500, the driver allocates a linear SKB. We receive the CQE from
the NIC and we allocate a linear SKB in mlx5e_build_linear_skb().

static inline                                                 
struct sk_buff *mlx5e_build_linear_skb(struct mlx5e_rq *rq, void *va,
                                       u32 frag_size, u16 headroom,
                                       u32 cqe_bcnt, u32 metasize)
{
	struct sk_buff *skb = napi_build_skb(va, frag_size);
	...
	skb_reserve(skb, headroom);
	skb_put(skb, cqe_bcnt);
        ...
}

The CQE might hold multiple NVME PDUs. It is not just a single NVME pdu
with offloaded data. After the data, there can be the CRC, and other
complete or incomplete NVME pdus.

Later the mlx5 offload code, we have
mlx5e_nvmeotcp_rebuild_rx_skb_linear() which will rearrange the SKB to
use the previously registered buffers the NVME-TCP layer gave us.

So mlx5e_nvmeotcp_rebuild_rx_skb_linear() takes a SKB like this:

    skb
    head   data                                            tail   end
    |       |                                               |      |
    v       v  <----------- cqe_bcnt -------------------->  v      v
    +-------+----hdr-----+-offloaded-data-+-next-nvme-pdu---+------+
                                          ^
                                         rest
       frag_list = n/a (linear)

And turns it to this:   

    skb
    head   data         tail                                      end
    |       |            |                                         |
    v       v            v                                         v
    +-------+----hdr-----+-offloaded-data-+-next-nvme-pdu----------+
                                          ^
                                         rest
       frag_list[0] = nvme-tcp buffer
       frag_list[1] = rest

And then passes the skb up the network stack. In the big picture the
complete length of the skb does not change.

If this skb is then condensed, it is going to put back the frag_list at
end the tail which we don't want.

We could do what you suggested (adapted to linear), move skb->data
forward by increasing the headroom resulting in a smaller tailroom, but
we need at least cqe_bcnt bytes, but having that much also allows
condensing, which we *don't* want.

struct sk_buff *mlx5e_build_linear_skb(struct mlx5e_rq *rq, void *va,
                                       u32 frag_size, u16 headroom,
                                       u32 cqe_bcnt, u32 metasize)
{
 	struct sk_buff *skb = napi_build_skb(va, frag_size);
 	...
+	if (is_ddp) {
+		headroom = skb_tailroom(skb) - cqe_bcnt;
+	}

 	skb_reserve(skb, headroom);
 	skb_put(skb, cqe_bcnt);
        ...
}

If we leave an even smaller tailroom, then we lose the data after the PDU.

So we are stuck, this is why we need the condense bit.

Thanks

