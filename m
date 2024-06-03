Return-Path: <netdev+bounces-100170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7FA8D8055
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B317B24DD7
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693F583CAA;
	Mon,  3 Jun 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tgp9DeHW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A73FBA7;
	Mon,  3 Jun 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411974; cv=fail; b=Bp9lQNpPFHqYSTm29I2utLm22Zsh3gxRjQ/i/LaCzSTg980qE0F1Wsj0cCf7vW42catHP2ZB906wZiFL2goCeMGP+20PDs3i4sbKnzdPoX7StB5n/zVydxs0q0S8nlBJjc2YgXTr1CBCCA1sn9BMuSZwe+1NtWvPKEJjRgr+ap0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411974; c=relaxed/simple;
	bh=Iea2wI3rYCF0fB0eERcTDeYNbUa2cPR2v0rSOxfcK9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u9ZVx8/QmONI9HpUmKd2cQjow2UtpGnLHorGoQLlB5vt0kQf8dwRV5uvxdsy3R1vpCnLGTLU+zCHdzFiEyWh1sGsJHBvVqExmtkWmlgtcyQPevaY71CAHKaFwfV8HUnmloDQBMkEmakxr0UPMg05okfP+rYCJas3jUTHa0OeDO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tgp9DeHW; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS6bnpdSyGzHZ9/ia0NgvK/ozskyb0jAHtrQoV6BClqt3JaYT6GfpKD70ZjVbOwDtyZhyS9h9s9i4Ldn6XV38jtHKGPKe028AFuATvxfo352AQlzWeWS2RovYBBqQIE8i3DjVrlY52r/OJpN7o3mVckU5YkonW5b84swlzZ6LE+cDXVF5LoddsO4fjitmvdMpmGA90c5fzE+SFH6pIqrp4o1RhWW9UbFNFHgutHJTdzHa68VAWOtYmv2/wUc8vFOf0mv8kuhxyYdXc1sAW4aPUbTEdmaZvkmb1LcHbXhXPD98xth4xt2NIcDbty6NKoskfy8jIm+k63UsVWdRrmIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bxnjB3fGCB3+7uqgihJB0J1NC6APF5mH6vGXV1HKec=;
 b=nhfxZjIcONLnAoHCpfoa8d3jY/cIpmpO25aQ4dAPerU+tbhDQI4K019MlC0gyFt1kXAqq+Yy4PzBtGZN1xRJcHP/Ctoo2U9vmaI4Ot3W6PDCGBnW51YmHxA4y8HCtjW1KdFZNYv9ZTTATLOQgAY4z15Knnv4fKZ2go9EOAGouy9nIog74FZ9D7qXmKsuLKv5LfX1FXhlurNjAC10AzZXPG+k74CydkzTOUHAaaqNEzC+SqWkF2Cw0LHbkMjrPgKj4lG33U93mtFAArPY3jrWlvdpG0BfvD737mmnySzQX38TiO9Gh1NrYK/0/aKwZ49Nqjb0a3cQA2Apf24d7OXjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bxnjB3fGCB3+7uqgihJB0J1NC6APF5mH6vGXV1HKec=;
 b=tgp9DeHWh9k6n5LniJcgOGC38xZbwC9xNHhlT/VB49/9gi1CfQ13PduGNOpYZggqU0dhr3p0daYt87pFRMvUh3hFQwaQdkiPr7KtEYmdZcDa5Gfxg/rxSv4eLbfmcIcJI5mqqBJ8OM6zouAqZsVGg+5r9qefjT5C0kOjxkSoP7WVuWTrCkj22Bf32g3nXxzRaNKs0Hn3ur2Oh8bIgHe6uK/nphXfA0q1RWf9J+X+RSkVlZUkkqx6LgOZD6NdoQ6YwBtoHQBzNabid/YshxATW9iPq5I+x2B8tl1RO3p+0b+R6cD7VM/AIVIjfFRXFdVp1WV2qEBj3PvS0C9/GPCewg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 10:52:38 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%3]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 10:52:38 +0000
Date: Mon, 3 Jun 2024 13:52:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: petrm@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2 net-next] devlink: Constify the 'table_ops' parameter
 of devl_dpipe_table_register()
Message-ID: <Zl2gZETsnbh1dS7P@shredder>
References: <cover.1717337525.git.christophe.jaillet@wanadoo.fr>
 <3d1deee6bb5a31ee1a41645223fa8b4df1eef7ba.1717337525.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1deee6bb5a31ee1a41645223fa8b4df1eef7ba.1717337525.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: a7da6913-3a0d-403c-13d6-08dc83bb48f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqUuCTXTcl1l7ICOyEZPEeiVybHvM71ZlF7V/s4YpDZNqryjIU5hy8YztS6W?=
 =?us-ascii?Q?DMHcDKx7Efj3+7JgyDrqxZHpK8Y3cuj1z7DnGL50iicAqdKQcU05OJUz/15z?=
 =?us-ascii?Q?qaKtpMZVCErJiwoIiTUSKrOVNkI36lfR7QIiFkVohXXSNpT74ZLRcr8umAno?=
 =?us-ascii?Q?ezRJYuqYzRwHZ/V9s8jJyK4o5xTmi5GlS33U32g/8LKtfc4k1tmpztvP9Lj+?=
 =?us-ascii?Q?8qnHhlN1xfwHVSE81dQaXWUGP6efFw+Td8u7qisSNXALtFTZcFf47AqAn8l+?=
 =?us-ascii?Q?cu7Ut7mdBrxXj2qUhh2JQ1U/k0Ja6anQbQuN651uau4hRoftsyKRPAutnmvu?=
 =?us-ascii?Q?Mvy15nODk4h1kTLA4Il/5JDyw0YpHyROjguzHI/QVqVVNWxHQhIr2IlUd01x?=
 =?us-ascii?Q?d2qIrDcjeSmq9AMNBCXWCeAIQvdSv9Q/gNRyjBz8kAR8MYA2xqWxgxE2dAPP?=
 =?us-ascii?Q?svRk0nQYbcQhdhmS/VEz0LrtKaUVLCDZV695pe5FLKC/DgP15GfABqdTGQiY?=
 =?us-ascii?Q?jsLQMCb8WVmB779GbyrYGSbbKbhnSxzNsncaoVAaaoU6zaeXtR8rr2qQ2u+y?=
 =?us-ascii?Q?71Gc3zy03YIMROh+HgwANZUpv7TfIcNPphRIN30T7E/Xv2COGekNMhL9X3LJ?=
 =?us-ascii?Q?qxynlVlLHBgj6/M7evmO2PRm5FE2MGijRglo3v1ys8kOov5Uf8vuycjjNtrW?=
 =?us-ascii?Q?wZbKY5WBNT0vVcNiGhZi8DubteVQwSSn2L9d6dVsPrRcKMKdO9/eLAJTpX7B?=
 =?us-ascii?Q?7NXcLFVZfjc/3jBi4GeC22jtp5/P8ZJ8Fiye55ERgVjF6k+d4Zaf/6vlqPrv?=
 =?us-ascii?Q?HZZVVoDt2pyzpsM55OaVTjEWGI4JPJdfLkqofaaD3QqbT2qULqCjBYOevCAv?=
 =?us-ascii?Q?wb0DWQ8RvGDl0FwHwg0v1HkxDbe5lpUjDc4zGXGaQNU6CTM9Nmtasy8JQoyz?=
 =?us-ascii?Q?ciExv40F4ObFWTULEdPLsMesQJrUrNAwSeG8QIibgthCe1kQriF3hRb445im?=
 =?us-ascii?Q?GEWbyQwasGJT026k6Sp/ZwooG76difhwX6gksijeeugDgZ8m3svQM4JkZdxa?=
 =?us-ascii?Q?kFNF5+1H+FvUChKkyquZQ/RnbqhJ6XTsp75U72C7qgCmZD0wmJJ5hKnr6bF4?=
 =?us-ascii?Q?6vxTUZED6y8bdZuleEtpAQWjAICbqr7YcmcrhfID9WqUPIwovHBjwohgFby2?=
 =?us-ascii?Q?5dawPDDgBDpSP0Y7kPTOEvURrMckGrZ5RLwxXd1pxXXjA/Bxp7FzgB+qWoeN?=
 =?us-ascii?Q?McPoH2mmmxEaKK0wgB8G5sV9dHmzRZ10JKQlrs7tzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0JoZhR/TQrGERb1y9H5Z+iATj85knhWbE93tv0YVF5Odv6JalND2mpRAsucC?=
 =?us-ascii?Q?H9daecSHSJMJ7pFzCP0Ea18zBanCdK5RoQIPqmMkiJCazvF3rlarLqQL2D5A?=
 =?us-ascii?Q?LhyzUhSJk7wfcb6Ik4XBWRlu6gW7CVqfVlTMCxtRjIX4Lni6RCcsAJ/ZrLU0?=
 =?us-ascii?Q?edJjjSlTczn2sx2IgberLUqik4WKDnWTZfMHiYUbJfTL5cpcMpPtAB9n2HqA?=
 =?us-ascii?Q?Y6pJQN47lQSOEV3wR+HHGJLJ1+AzxLrNbwQneKePvI3RnN4sTh+4uZKWO89w?=
 =?us-ascii?Q?2zVyOQiZp0hGfQ5ojVxeUklaRq1aGZSG6PqRkO3MfHX+YLC4nEJOjzNRgLlc?=
 =?us-ascii?Q?6yjgsSMFVMaNtZWyMS0VYBJJSpBnUHz9gLo50E/z8EDZQSfaR52B7KCCXFkG?=
 =?us-ascii?Q?yS7aKjzgHUhs8vO3puMt7AnqjuGDgoefyhGwb5aQHtmaNKjr5QNhVmogBVux?=
 =?us-ascii?Q?i5g5DkPoBC/zrr0Ds8/797EXs4ULh5lEdtM16KiUYx83fbwG66VBCpRv4xRI?=
 =?us-ascii?Q?Au7/sjavubTM8GCgbkLQgsGDeXFIsf3XwQK998TeyBWb2qtaWpYVjbkY2OPz?=
 =?us-ascii?Q?sKw6Toufw0DnS1pJFeIjXA0disWe1PPyHDJwOs9MXNm6yZWQLzuDmTpdsmZl?=
 =?us-ascii?Q?HFc28uH1/DNiDBaQ9MZYaq7tjPg+BgQNkfKchMYBlWddBZZta1CJtx6VbCw9?=
 =?us-ascii?Q?HHw++BmN1OWGi5oRJLo/GNkRaGQCZawF7gxBJiXs9A/f0dc+7dy95IuSmlrZ?=
 =?us-ascii?Q?vrO/oMceOnNjnOxLjepoUMAbzh/EsBk/qbJDAFEGVLWkUpFTGK7o0MTZl+/N?=
 =?us-ascii?Q?XMbCWhdP/saHRc8zXT2fZXCkJUlW7OeVpPO4O2WDA7uuW9UF7OtKu7WSkWlr?=
 =?us-ascii?Q?1Nmhhg9nCfDC78siQiWCD+ePRgTmhWRYhpKkFCxtfE6/Xp+RVgJdMXe8fenQ?=
 =?us-ascii?Q?7PbKbyckbhTcOIwiJOw5RdO+ePEzAOAYlc8bkv1kC/OJTQW551P4MmtlU975?=
 =?us-ascii?Q?qey7cLOaj5ATBuOEtPaVP4GjUbcPTr3hjaIygPzxOFZXu40MbDuXfJz0puUF?=
 =?us-ascii?Q?QUHP2MtQAVxgCGc55PAiK9iWKBz/ctTr3+2hbcd2CIZGhOPIyL68Zmt23GVt?=
 =?us-ascii?Q?uZymw3TEr5L/nOYt/LzSyu01RwIzlbpXepRFFkAtlj1P+Cu8gqk1+kWF+ncs?=
 =?us-ascii?Q?PGODGv6T3TLc5KTZtP1A3LYZ/LlyLVTA/HuyHe/ZLjPsFTv5Ls+ua6PGkfOD?=
 =?us-ascii?Q?AZn522gASAx/HJmSctBj6RJ9RaMcue2lTEXleoM8fnTbzgWeXw4GlgblEvrR?=
 =?us-ascii?Q?lWOh9jJ5H2e21Q+AwYfbdwdCdR5TJ/SWmUxnHUIXmktc90EBjDtk+2fJrstk?=
 =?us-ascii?Q?yGQu1V6nzCAgviIFUUMBpfy2z/5+0yiQmgjPfT6THVjSlfksKOOrUahBDvRs?=
 =?us-ascii?Q?ReGzA6QOLcLEyfQPDGc7muVIwPr8LWEsVxnYScnxvaCo5dQM9TAW0YB3kdA9?=
 =?us-ascii?Q?wRJB1BDVcsN3jpU3/Ui0lFhIJjvMhKiv8AnzVCG4jWtv2QSiZJooZ1pf385O?=
 =?us-ascii?Q?TTmklzvJCOCpwc7l1y7jg/bIjqVK5GhVHTgrZOhY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7da6913-3a0d-403c-13d6-08dc83bb48f3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 10:52:38.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tO3JlnLAw9COE9O9jOwwdYRLoRiDLQ4sVtzr7ipwYQjgggUY65kecfdVpb9hGcVA5vr1En7W8kAiNv3GJG3jjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294

On Sun, Jun 02, 2024 at 04:18:52PM +0200, Christophe JAILLET wrote:
> "struct devlink_dpipe_table_ops" only contains some function pointers.
> 
> Update "struct devlink_dpipe_table" and the 'table_ops' parameter of
> devl_dpipe_table_register() so that structures in drivers can be
> constified.
> 
> Constifying these structures will move some data to a read-only section, so
> increase overall security.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

