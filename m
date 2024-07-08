Return-Path: <netdev+bounces-109809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2D2929F7A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B274FB267F3
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAF6F30B;
	Mon,  8 Jul 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ogNstJCG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A841C69
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432006; cv=fail; b=NCAa8QkYHwl2XgNdcy9uBkNNvyNjow9TnQZGCL6YSPKtBo7e7I5cMVymlTUMW16owIvOWzkATFYKU6hvjES0fMRpaZem8a6IWOSLoORHRIypOlvQ7veMRgEAm5XT28HYQpHagLCiXtBy6SlwL91mnXSTOXEMrDVt86AdnlBRA2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432006; c=relaxed/simple;
	bh=3J4np28vitavJZXEZ6SA6WpaTT2HK/U++Cb+hjP1hUU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N+v4kVZ/Z+ghjH+aEAhMmQxiKcQS/1jAohfsteXsVtf7VLOpuw+mtbL/Rn+xy54tEAlaNF5dV1C/dP3Tn8qIeC1HnrmcqHeUAbiA0WtKAFY97nCx/Z1/QjHJliPZl0bFysHHHkN+ohJh/E8a7+Aqpypzqx47HpiLX5tthU4iTz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ogNstJCG; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEGC9cqZoGipXC0k2DbgsmmXz2AqjsTCa1VqqhDm+5YsZ45b6AAIUZDmwD3LAL52370Qbcug7PDzmOij3l3K0BAFbSaaTwXpjB1V6ULdSeNC3d4GFHoYYz8sjfheNb05P2K+qkBuw/3dcZo2eah+qoZL++9nNpC08sKhG4nRrNXqjdVusUNVP+ORpf1UoQ5g13ABAy0cXxP4/IacqP+d+RGfdNuz+55ddAJz/eVzVCVZLpE2FQwKWTU6e2BxjLxQDCAtDWg9ClnkGSOQCbcJ+NiXyXKbAptfTgtkkRFqYIaS6oZZVA1tLA+672BU7CsPDvktTIJ1poR9maMVMhL50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEQDuAcDrjIQ/jbzo9yj6hR9EPDrnODTMWV4yIqnOSk=;
 b=P8OddNSD1z026QGA7Rf0PyNetW+KssqEXm7x9857vI4M7uud1tQyJsPruYI75AUNxPjW/5fZFD/iqG/eDRIVf8Q+3t27AXx9nDSh8Ce7BwkST/Lr0lcqcoU4QKRSL6/5rN4ZPFi5AwzWQYQHzN791R2sRjJzRPFvkkJbaR4gafe/GbfnHpZ1qsGZ3JADLUhDNVIS1bfSMORLt149Y5Q5h13c++jg09Ztb2g4C19Q9c1Bc+SYlb/Sk0l8Tk183bbZf9x46ObGeRLXw8eZcA6PUzF+k2DIUtj4eA+eCPxb1dhUAXiXk62NaHzoXcAfuJ0Vcc4V62xnrxsdsl/UE49vVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEQDuAcDrjIQ/jbzo9yj6hR9EPDrnODTMWV4yIqnOSk=;
 b=ogNstJCGgZvQFcQZCP1l/deox1lOnRlaUvSYxouqbAmVefFkbUxKTx8XGHABVOyW1rVEKSAkqTd+2CLX9hhnK24LxoFooHEEtq55KeZz3x2/KPnMr00xCG8Ge4nluBSssUHMPBDOzEzf409IbVHoA2k7c+1HUyKRuq9iOw/KaEQw8CHSzKi5x1//rb1x02Ng3IXn3JIvMSh+BaJ9MVdfGMHuCpgqG+PMgVBuMbiDafHNuHG5tWcPurBrGOSSg9H4JE+2QbNYB5uVKiA4Cc+fvox+580kzZArRuOnT0kjC+WBGcWkjJrK6a36+vGaZNmxH47mKCEh54lj7sm420pyAQ==
Received: from SJ0PR03CA0382.namprd03.prod.outlook.com (2603:10b6:a03:3a1::27)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 09:46:40 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a8) by SJ0PR03CA0382.outlook.office365.com
 (2603:10b6:a03:3a1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 09:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 09:46:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 02:46:24 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 02:46:18 -0700
References: <cover.1719849427.git.petrm@nvidia.com>
 <eeccc1f38f905a39687e8b4afd8655faa18fffba.1719849427.git.petrm@nvidia.com>
 <7ab9435f-e43d-4580-b7d3-18a69f231252@intel.com>
 <ZoVGqJVBWUVNtsrc@shredder.lan>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] mlxsw: Warn about invalid accesses to
 array fields
Date: Mon, 8 Jul 2024 11:45:03 +0200
In-Reply-To: <ZoVGqJVBWUVNtsrc@shredder.lan>
Message-ID: <87le2ctdwb.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a58b544-cabe-46b7-a0d6-08dc9f32de20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2bXNlLyPZQ21XTevIqIcBbTc5RvfE3jO4p5AWbk1qFqD6j8YFGaJI3Gp0H8r?=
 =?us-ascii?Q?qeVpLGpyO3gM4EUIB++pJmw1PKUENkX5qx1m3Ai5v8x0Jm9OEdCV8VvY3/JM?=
 =?us-ascii?Q?rrVsJSjOj94zd96csl+m7QSySG+qA4A13RIJRDBMLsRN6TKx+EhMgkgi9n07?=
 =?us-ascii?Q?6PmQJiyK1QnRbb6+BjvHlf5sBBdpkec5q5Juf5kPrEfjbYO/cHWh19KOmL3E?=
 =?us-ascii?Q?Hf3hCk8T5K+QUMIDbsMqGB4hBh0emIiKALYBVFQLJsr0uNXKFfG2gZ3ZFQ9A?=
 =?us-ascii?Q?+AnDdDFWPh9oNhPU8Sd9VqvNU/PDnjoDrOasfV2xZ1lemHpC0jA6ed4WPpPt?=
 =?us-ascii?Q?PXCTHNzubaxJFLiFrmFJpGABz+ocWbEBz1npGJy879jNyr9ffrDP3EHTxP1x?=
 =?us-ascii?Q?OD+Atn6CV4SktMeyEOcCXwrtzlvslO6ohRxYFU2BeHvNzdpCxBh0yN3crTgH?=
 =?us-ascii?Q?w6LHgv/qUVhKA+hTqrIKyFu+ZJo2mnQFEZr+ZFmfcF2/6iIX4sf5lFhtbThJ?=
 =?us-ascii?Q?fiVoBQNUpoK5Hqvrho5HuCTRHJYQjt+qFlv9yUokGXfz/0wGNOWjw8HKE5e+?=
 =?us-ascii?Q?KgfIbBG7wbmvjs40UpdFMWuOEnDBAw98hzvOfAT2/rR1dYLPwB20+LznXY0A?=
 =?us-ascii?Q?fgOSNmY1I6vOgiMYeD5EmufFqyjjnIDkg9nktRwyc5FYegy4psjgxLhZVeg7?=
 =?us-ascii?Q?tQXZ+VY3Ipbjf93qG1VF7U2voKbPs0XKJjAslid65IGiGwXNCpwR6I9nad3Y?=
 =?us-ascii?Q?YIcEeMyNrqEdNBLp1uVQ9uw3pOX1XI5jImFJIcJffymmcKhUgGJuyIKWWsMf?=
 =?us-ascii?Q?byHtX1Omxlqi7gP4UN9f10KuC6iMXGaYui8iE4H8SjBgz1E9hVAWEG1caele?=
 =?us-ascii?Q?WuIXvWpXoiB/fSlc1cWTIKq62z7a0xrS7fYFB2Jc/6+odpk6fK7dN7qZMn/R?=
 =?us-ascii?Q?Mujq5WinA9+Zrc++wJasWeVBaDobyYwKoa6No4NPL5svObuT7jwt628VDTAD?=
 =?us-ascii?Q?AcM6ZVHA+1Y6dFUBjA5Y9n+vAbQe4uYSimZ7ZYcFe3zIJFgAtOazmpV8NUoo?=
 =?us-ascii?Q?ZFhKg776PPev2Sk+UeSvJUDU8C1hhjNwXj19ZWLAqKf6/N3YArpcONUpIeQ1?=
 =?us-ascii?Q?5d6sGtOkjvKfozW2/nvhvjTW2gC42n+HlmkQt2HQGQHlwSVG1TGNeHIZhDam?=
 =?us-ascii?Q?1kppklTR5auEKyC6cu/qnfM3EVsn6Do2tnc2gQvJcgteCGUsffZ+jBPbxiDn?=
 =?us-ascii?Q?Xt80bfjLaiAXk39hGCp+0zn3sO8hbP9YbTXYO4lTBY/EYlLsPE36fgrumkY1?=
 =?us-ascii?Q?1vdlLRZxklMQSje9DnZwuDoYWaJewVRYb/dx5sn9e4NyjN4JQRzoEtgTD9N6?=
 =?us-ascii?Q?d4nQ9mdc+4ENcxXQ0rVx/M1SE6NAH9o8eIyOl2Achh821xwWKeG+3QVvLpbo?=
 =?us-ascii?Q?8N/7c2TnBCwLtDrZ0Bwz0SQ9RajwscZ7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:46:40.2691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a58b544-cabe-46b7-a0d6-08dc9f32de20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235


Ido Schimmel <idosch@nvidia.com> writes:

> On Tue, Jul 02, 2024 at 09:08:17AM +0200, Przemek Kitszel wrote:
>> On 7/1/24 18:41, Petr Machata wrote:
>> > 
>> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
>> > Signed-off-by: Petr Machata <petrm@nvidia.com>
>> > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>> > ---
>> >   drivers/net/ethernet/mellanox/mlxsw/item.h | 2 ++
>> >   1 file changed, 2 insertions(+)
>> > 
>> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/item.h b/drivers/net/ethernet/mellanox/mlxsw/item.h
>> > index cfafbeb42586..9f7133735760 100644
>> > --- a/drivers/net/ethernet/mellanox/mlxsw/item.h
>> > +++ b/drivers/net/ethernet/mellanox/mlxsw/item.h
>> > @@ -218,6 +218,8 @@ __mlxsw_item_bit_array_offset(const struct mlxsw_item *item,
>> >   	}
>> >   	max_index = (item->size.bytes << 3) / item->element_size - 1;
>> > +	if (WARN_ON(index > max_index))
>> > +		index = 0;
>> 
>> you have BUG*() calls just above those lines :(
>> anyway, WARN_ON_ONCE(), and perhaps you need to print some additional
>> data to finally fix this?
>
> The trace should be enough, but more info can be added:
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/item.h b/drivers/net/ethernet/mellanox/mlxsw/item.h
> index 9f7133735760..a619a0736bd1 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/item.h
> +++ b/drivers/net/ethernet/mellanox/mlxsw/item.h
> @@ -218,7 +218,9 @@ __mlxsw_item_bit_array_offset(const struct mlxsw_item *item,
>         }
>  
>         max_index = (item->size.bytes << 3) / item->element_size - 1;
> -       if (WARN_ON(index > max_index))
> +       if (WARN_ONCE(index > max_index,
> +                     "name=%s,index=%u,max_index=%u\n", item->name, index,
> +                     max_index))
>                 index = 0;
>         be_index = max_index - index;
>         offset = be_index * item->element_size >> 3;
>
> Will leave it to Petr to decide what he wants to include there.

Thanks, I'll send a v2.

