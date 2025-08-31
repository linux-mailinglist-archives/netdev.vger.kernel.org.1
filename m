Return-Path: <netdev+bounces-218555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A5FB3D248
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 12:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3E017E4B8
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8EC254AFF;
	Sun, 31 Aug 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QSg+JfOd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FB190685;
	Sun, 31 Aug 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637637; cv=fail; b=HksnL8Pl0cl6KZ01jCNTy0KK0uhdvvohm9MOvpwUc5BqmxgXYVQCz8woqPsFs2xnwCSXh0SclCNjVkYYiEVYCX6b/52tgTGrML3aHUTcMntM+CnUJWRYT18T0R5dZZRkkJtP63d5Cnx81qa7s++SIAUBCgCmKG9T2Zi46sxIC9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637637; c=relaxed/simple;
	bh=atQ3+uhUlD3+A+r33gG6NcmOuzgUeFRgmR0D3FlQs1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EBD5qlJwaKUt9QAT6tX8G+dmvfevn6iA/QxG/ImiEZwcTpJbzzqB1G0C6vbCFRu7E1d39nqUzzj9gmvY8KK4SfQdXcIWQIjTu27G5mEL1Njbx1O+NrowTa4OLD8xlzp5MhlkNRa4kC50A6ttrmag7PZTaVwxGblbMSpkVyLvCf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QSg+JfOd; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrA/QH+vKIpd79T+6i36bFoWhTwoa5Co3ZK+QBKa2tW81j/6Y42MX30jIIHHpfEUAdNpSUR+th815cmOmiTFlLdaCqoy8I8jHlG1A4EHeC5moINNEcG8vJz3A4Bizs77G2oMIR3ezorq+Gv42/tk4xoSHTGiKjanIje29hxfJuYpK8OIN/THSmKbfO0/QF+3lNKAFzXzaFNeOzi/UAytejMLMIWYdSGSiMHtwR6O9DGWZQfU2amqWV1kE2eCup1U0D0EItG0jjvOIa9nkX7mFXBZ639aA5qvV6/zWTePA9QnpYGf1IU0dyi/V2Gaa78ajTKHg8lGurgz9Pt1K8/2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuzFlr6zuFkBHV+EDo126vMTKuuHOUyg0zLkX3hK7mI=;
 b=fkJryhjmLSCJWNRxdOnCgVpVy1GTMXKrkPhpDVXRu4pddq6OC3QVX2PodtalU+kcttPHkJ6Z23QIqiV5q4NkM41elq2nPSnnh2Scp5+rwfNMPbHOca45FEBaXlctgFYW0v7FOx/PgkkMk3UxQygcwoBxxjLVI6ZSDhACavnwvZeLDzziO0X3kQgIpB49E8Rx79onOzXxOwpIsMW8Cpm7A7QzT3NPQndg/c5r86r3QEFn6rorkCZRAXiQJ3t8onSCj4/U1JSYCm6nlKRCVdE50cs3E7DakbdqBIs9PFHkmIGf/xpEnJWtj8ijKqhO+82nJX1zmVhuigkxfqqSdTBRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuzFlr6zuFkBHV+EDo126vMTKuuHOUyg0zLkX3hK7mI=;
 b=QSg+JfOdYc5pEXSChBCtKjdxL9yphXeBL5OCIlsUVf0MW7AGRiJeiwQJu0qunTt5b8jocsV0PxHa6YsDm8w096lgA4nwvo6gUQSBfV4mOG1Ebp43Xxv2lWF2go5ui4ofsgAieCSygvprweHNNnjU4sfCJ5ryIPugrRDt4cCXulM+bGYKFzd4URePiYuPDMNXk6NGhuxNhPNuC7G1C3fhMJFrLi9ajj+DOf8lTY55HYvfjbRUCvonZ/tUZDMscd1Cfb5In3rp74szkh5btYzQC5BrRD+1f3zdGXo45Vyk84W54XySMLtzFczQk40ue1CDTOP5ZDynb0dYIi/bdRevIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Sun, 31 Aug
 2025 10:53:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 10:53:51 +0000
Date: Sun, 31 Aug 2025 13:53:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Pasternak <vadimp@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: core_env: Fix stack info leak in
 mlxsw_env_linecard_modules_power_mode_apply
Message-ID: <aLQps4-Fq21R7N4c@shredder>
References: <20250830081123.31033-1-linmq006@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830081123.31033-1-linmq006@gmail.com>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff2aa49-fd9c-480b-443a-08dde87cabbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?96VDg2oTvoDin0lCOAPjzLTbwMdDsoiNLXsNBp3whbx8+1aVo2gvm6l1ptjs?=
 =?us-ascii?Q?b/82pBGyYlKdcJzx5+I+Q9sd3Oendx0tonnA1rL/xFQ2nff564qTYNNy7ESw?=
 =?us-ascii?Q?v2KWQ9pV02kIqydT+66BCZbjreYnCoB4JNKj2QBD9Gwu7BFfYdHQ6dlInXG7?=
 =?us-ascii?Q?uZoC5CvqUapxymWAGe0gAWZfvCBem6UaFQqjezGWP5lAVK1hVg2hFumpIPZH?=
 =?us-ascii?Q?8z+IIGNlxzabTBPsG3KgrLk/ld4ygFcduVFQukFW6WWSva0533jWg6sx8AKU?=
 =?us-ascii?Q?OOmErFRSD6OCBH4jvBL6RGFBOVZU6z8cTEwggXXFhG1hG3Z+Uwt/iNndioDX?=
 =?us-ascii?Q?uX6hnrJ5KpwIZEW/27kpdnQfiD0G7KuMRwqynmUTzZLW4xXJDBroCN9VIJ8k?=
 =?us-ascii?Q?naxooJTmmQOIO+GR66f0pLl/JrBqjeMQX81B/eu7q68KRUucHpPDh9XOiEJl?=
 =?us-ascii?Q?/+GOrOOuntBR6Qs2aNJq9N9QPy777mBMB8jdO4hnPz5cwHnIEJgQXbE43j3i?=
 =?us-ascii?Q?DukRcbc2Pp5XUth6EWQ4npbfF3/IzL2fkG0ZzQTvaK2WPrl9/xeFrelwqTub?=
 =?us-ascii?Q?g/DoYzAMhmXjt+h4czRv4pFDRC61/28neHKs3AOUT4diX/sAkprluYn0V/pd?=
 =?us-ascii?Q?+l3AX1digQLrDltg9Zc+CYN9eVIuYYZYCb1qnUWvU5G7Z7IMVbTxzqHweipk?=
 =?us-ascii?Q?bSw7FRz1IsFqnWW6HsXvkNFve9wR8IvF4k0Wwbu2AEZJlikQpD36Spc7ElFE?=
 =?us-ascii?Q?psQrMPdiekHZALqDvs664RuxKwIYGXrazgau746lvJYfithhCqI8HG6V373A?=
 =?us-ascii?Q?hPdaqFIhcdd68WE5d9iUUst9bK3h3cijiiqpDkray5fAx862eRxoPITsgPtx?=
 =?us-ascii?Q?KZg5/Fk7jNoJyrUm+c1/WwLi5RPuHEeSRvYwddEelYSjs3STsjFjSjN5km99?=
 =?us-ascii?Q?KhylgMpJ+IRkgSg9fj+/NyilE0+VuVp4zMwcHfvSWqf9vFcYBLjvvlSZe1ff?=
 =?us-ascii?Q?rxZb3fwhNmmHJCRiCKcI8RBH4XjUfZCd/GG9U5AYzg1oNVeBiZt1OFGxi2AC?=
 =?us-ascii?Q?sUAqS2dUQ49aYRB1M95MBnd+QDwqJkoFQ36ALhlSh4vd8xc/ilHQfFK2AKl/?=
 =?us-ascii?Q?v52qm9N8mqRkOCWMYhg+ywfJCQ5GlYyvmt3f4qujYAbt3S5W/vHwZeyTPS3T?=
 =?us-ascii?Q?USYsrrtKMP/cGb7fCeFwlJPn2lwsgTK+3II6yT7eFT5dbSAnP/3wsp/JpNJz?=
 =?us-ascii?Q?z/Dz8EvCOP5XCw8AK9awXpHmQPjnNirL7e15nvbDP1n7rX2MvD16RxmsRevh?=
 =?us-ascii?Q?m4+wTfAYEpdKSq3RDAyCcc09OeZHPmU22x9XxqsbbMNKUAV9YGTDsnYA7MhQ?=
 =?us-ascii?Q?k2J4XJ4/72dKIZdcKSPaCVJUk/s+5K2EDxmuBhJWtfowmnv9DnuPaYPCIjah?=
 =?us-ascii?Q?n14FvFOCtI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NY4dTJbzAZnr9+kRwqeoIrgFiMmGPLuK5PP0OHULBhtqyhuRGA5TKhtbdwe1?=
 =?us-ascii?Q?K/l/KD3FFSEoK31VlC7pL6MpzwfZpq+3ZV1xg8kXLoRJRbbKGZxX1C9fH98b?=
 =?us-ascii?Q?dIsqE8QeMnPxcBxAjDy+JcgFgg0zEXjM49frP7xn/hUaktfSSDsrk/v0Sut2?=
 =?us-ascii?Q?dm2XLe6VqjymXYGkdBsDuh37MyiCbUWPpjouEqHStoGiG9MxtdntkVcIoIPU?=
 =?us-ascii?Q?gnS8/cN39Jzjg3EhwTEY8VdFu6w52PVJiElnDAyq8HSlFOyrC4C8RGP32htc?=
 =?us-ascii?Q?fKo07skoC8qdUpzvoIYqbr/eEy3jINxAoyXqlCCtYsGRwdi6n+omTAN4kB4I?=
 =?us-ascii?Q?ZjDYkMcHnn6B9zrcs7IkTOZ9ecsX5z/zgnd7ZEdoTX3MwEHrdJJozn+O7Uut?=
 =?us-ascii?Q?NP8AycN3OQZrIaMvqCGgm7DrAMKg1pCkIFabkqtkpI40vhFbCLuInVEge5HJ?=
 =?us-ascii?Q?F/jzO9yvbvbZFrjeHXqhtIURiMwft3LubPZ9K2zunrdxQpX5azsp9XgaqdpF?=
 =?us-ascii?Q?3VdoDhmP1mCwxfBhU960Dqzu7ipMffSKxY0GhslU/biIAqSV89FxhN4zV7Yu?=
 =?us-ascii?Q?346TKxnE6jypGZxmgccuZO/OF8YDZhMDt0W7okqdqldkyXUN2A2Ek24kFMg9?=
 =?us-ascii?Q?SjhzTUlnKXtPlGywRT6yxeuIstS3aYgbQtypHHnUC8qJwMVns50xPoNdb8oP?=
 =?us-ascii?Q?tOqj77b/7xF4H+9D9uT4n+8XJS/nXfNKff31kFRtzNdUJE0YAqnmkEyf+ilC?=
 =?us-ascii?Q?dytOZeiKGHqZpfGqYcOQ4NzbVFDJgpvUfS0k4OmrqFO65oRwiKC8QqaB7pbj?=
 =?us-ascii?Q?JeKgX4XCMR0EpKxPDgC7k4zUwLp+gx7Noin+HHer3hHKJgCBrbRR/2pO2ijn?=
 =?us-ascii?Q?AiTaGwfG7c7uoBKN5RNIQWS0oc3+p6SS5YRyS45GZ7EvYss+iiNGaGFRj4s7?=
 =?us-ascii?Q?hFRZqlsjLJfMsz4TQnFlh6vlsZlUFRcjhUpdSKvMZ1UWSXlQJdWdtgB+hNfo?=
 =?us-ascii?Q?2teQio4IROL1Vl4mZT6lCa/BkTcgN2J/k0sgEGjzRhI8iqYaFLFC5S1ScCwR?=
 =?us-ascii?Q?rKTHcEExsOrDoWgxXSeW9sQMjJNh9izqic0S1caR/61rTJSYagVOyxeTVxp8?=
 =?us-ascii?Q?6Yehhb4gaasSVwb2TVJMy1WRzY+ldcOL8JYBlQcIyClgKU1Kv0sIMMhmMBSw?=
 =?us-ascii?Q?iPBrpsn4mOrNqoa/Gwz1lVD1khyKa/v5AsejoUXZOXA0ok2oZ30L7AF4aCq7?=
 =?us-ascii?Q?emEgoVK2oXD1c3R4GPrABvvjEmsFq+sE05I8+E3u5wTz1M2I02IE3iy2aptJ?=
 =?us-ascii?Q?QtiQ0eCTyWQDIQZH5hTk7NCE1hEUxusn59PWvdmQ4CEm+4OEdSKBfEO8ynZu?=
 =?us-ascii?Q?sAN/POidhYDRk5IZmmt96ZcZD6gjwWpL2IM0pxUTAAolMKH7eToXGVP0ixrb?=
 =?us-ascii?Q?cPUPMwweZgWFpKYrj7qjKUMggaHpLG8qraV3mHyc8bo9kotzWUxgdUP18UAv?=
 =?us-ascii?Q?83rlCGYEqvS2GAOBPiZkFuosjaJTCwsxY2p3es/nqnQwAX0PS8kj6RgVpkEJ?=
 =?us-ascii?Q?MmZEMB70ntoZE/dDlFRDfjH1LcHu8/2MUI5Jqk7N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff2aa49-fd9c-480b-443a-08dde87cabbc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 10:53:51.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTx7tw3KEyLwl9RddLz1jji03csOyGMoGoCuuQqtQSU8n/tQBSBtU0aERRIcB2aUvjTMOCmIsfOQdMVmux8Ifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650

On Sat, Aug 30, 2025 at 04:11:22PM +0800, Miaoqian Lin wrote:
> The extack was declared on the stack without initialization.
> If mlxsw_env_set_module_power_mode_apply() fails to set extack,
> accessing extack._msg could leak information.

Unless I'm missing something, I don't see a case where
mlxsw_env_set_module_power_mode_apply() returns an error without setting
extack. IOW, I don't see how this info leak can happen with existing
code.

> 
> Fixes: 06a0fc43bb10 ("mlxsw: core_env: Add interfaces for line card initialization and de-initialization")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/core_env.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
> index 294e758f1067..38941c1c35d3 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
> @@ -1332,7 +1332,7 @@ mlxsw_env_linecard_modules_power_mode_apply(struct mlxsw_core *mlxsw_core,
>  	for (i = 0; i < env->line_cards[slot_index]->module_count; i++) {
>  		enum ethtool_module_power_mode_policy policy;
>  		struct mlxsw_env_module_info *module_info;
> -		struct netlink_ext_ack extack;
> +		struct netlink_ext_ack extack = {};
>  		int err;
>  
>  		module_info = &env->line_cards[slot_index]->module_info[i];
> -- 
> 2.39.5 (Apple Git-154)
> 

