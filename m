Return-Path: <netdev+bounces-71004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A18E8518B0
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C68AB2184C
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81053D0AF;
	Mon, 12 Feb 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RZaN/XE0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAFE3D0AD
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754194; cv=fail; b=hD2gAj9gQn2uYCiJxgmapszOlv8SXg25Wcy5ReMsMa0EUqHBTl6Dt7xknk96HQzVYfpyfki8UnViAfrBkFAEXBzNKzIdnpVa5eNBEucH+skwNRhMzRP0dDYB782qCsSy9HC08FWdf9Z9+/JR6FluHW4mQr0dCPrzXOF2baPXRCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754194; c=relaxed/simple;
	bh=MJ0uID55MgLm8C4SfwfqNwHRzhJJzLKsEgKbC0fB6W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Skw+N+mXJ2wOe+3vkjyqtrXaaiHMIf4wgUdPU0rR1uRiq4nopodaS0hfn/fvAETg2S0pPbneDxsYWO+n3rB/v9JWi+cTQ/Q+83gK0sj6wbn3rULL0wX9dqJ459eltbjRoNi6UMmDO56MK93SXiaqzYCdj2S4xp72jptMBG7+J2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RZaN/XE0; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMvc6vqwYGoQ7i9orSA/ug/7mSlj+x+e3qgPkcH9MXkvQlfMA7fp+azIx2Z0hcUEHDsJqWs0jEbi2vImY2hiAM8ZgWNcdV8+iQZ5lvhafgmmAq6gctXMGJnAJAgotjnonhMcDxRZvxgkfjWEJ1AyXiWkMSgfDlhp6CmyqJzkRT89Id8RdEEQ2LWhoc1iHJZBidWzSXjhCefVAl0prakBcjo4aEWDFQuHgq20iivnrC8VP7v/XhehUqElufiqiHYLmELywDISmEZT3WJ+ZfzrZbo/cK8A4o+nRmrCFsjG9AEGRVw1GsBXZiYmz3QUslTq7sXb92fsGRSRIRwD6LZW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxK6ooHcHMoaOKFLVisGm4UsK+FOx17+N6ZPq9t7RJw=;
 b=VcZbLscULaAyDDTeUV1fv3vEpJtXrZZcein3KNxlGwmmYVn3n6kzjTazVG3dM5L/uDpQ6Wnxj/s4A+E+HV6ZHYx+ktYc5Po4sRLCuvkDzTGmLUz8OyzkE5I6fXx0HCLpH7gG5opkjhwH4ncPBoFpVUKvy5O96RqA39XSddL3BDaXkl66Rvz/6nW6g7o2+Y0Tm+446GT+NN4sIpojYYhf5KZ/ayhlKwp0g/jEr/lspJOhvuesXKm+VDqb9EUx9ObRM1Ww4MaMHux5b+rbzUg1+vWzKQRfsguDWynFKLpMSoXqB+Jy43P8TITzrH6bQE4gNpDSD8g4SVkpDcD9s84y5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxK6ooHcHMoaOKFLVisGm4UsK+FOx17+N6ZPq9t7RJw=;
 b=RZaN/XE0bFHiIKM0H0BchZml/XoZFK3RVko9WuIR0UxpXKs4+gYmVggIhLQRxkg/b1z7rBnTfiBm9pDBMRK2gXzf+WgK21KO5alkQRW7y9RP5zuTIY0sJ9x8eZ3gAmAR+szZDzfvB/77OOZiJwOysERkp1WuMc3DXuTmYYlijyLS0fq7WNWYUP31wasHYw/aCr6kWvNbQyiOK5RM1yg3UbvY3y9qXEtn2zGHm5zNq5IA0l5cGulRbC7dR+eLXsCQhLq3r7aiz4I/sYEgUsxMqECHv+VCo5/Mvu6CAvwyuLET779sfcrVU2tNW/dft2Y6BAw2JUkZY0Pe2hXKdrkmaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 16:09:50 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d2ef:be54:ae98:9b8a]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d2ef:be54:ae98:9b8a%7]) with mapi id 15.20.7292.012; Mon, 12 Feb 2024
 16:09:50 +0000
Date: Mon, 12 Feb 2024 18:09:46 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 1/2] vlan: use xarray iterator to implement
 /proc/net/vlan/config
Message-ID: <ZcpCyrOkSTPxcDub@shredder>
References: <20240211214404.1882191-1-edumazet@google.com>
 <20240211214404.1882191-2-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211214404.1882191-2-edumazet@google.com>
X-ClientProxiedBy: LO4P123CA0340.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::21) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5499ea-7a59-4ce1-b020-08dc2be50a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MWXb6KTu20IJ6QsofhVF3mEz/olNLz70uhaPdVep+pC9hRDvfGbRTR8U0Q/uBqJOqFrOl2ytw2PsvW+AB2tAezrZnPvLPmObOdM8LKs32m2khj2rI35P7bRGOhSOvgLFbtGJqe8GZj18bosJLJliakol9LosFiQxFZI7buRYvx6+uGaNgeRr2VzxMFLDeeVfHKdjRKgKl0ezW80UnqQjeCk/XcmQhdoQIboiATBgBEAnhswXtXizjZ3l4Z/9xaayD2skreyrVebSj9OyGe22aRg+V2QQoCUotH6aKqeDex+bH9e6W9jt01qtLM9IamXK5FRzROFTsd0OFxJgMMPutBQQ5h6ZN0Pe8sJmblYlBZ71Fi54prgxM8S9dNbdLUbJvPF4l5Kfwz3y1770Ss+jKhCQ8D4WOMW/z+EcNppdpe8/TCcjb4e6d8YG/IcAGdhve0wWDNeIWWWqNS57Hch8++OacdgMzG4FHweaK4qS6mqanxl+mRLgymors4YLi8q03f7nIpz9OF1aoDSuP6CnCm7CtXF6g4hsoeXh5S7epIzGYvpL7iyiKXVJ6umgdj+z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(33716001)(86362001)(5660300002)(6916009)(66476007)(66946007)(66556008)(8676002)(8936002)(4326008)(4744005)(478600001)(6512007)(6486002)(6506007)(2906002)(26005)(41300700001)(38100700002)(6666004)(316002)(9686003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eaf7EasK8fIVmfP4M8u0rBCig7nBnwojPnmzR7MqUeZOWXbCfZtmuHvvr3X/?=
 =?us-ascii?Q?ZP7IleXe3A6wi0a/Al9zItgN8jJz2yMzlRykwJvdDf9h5dVUwbR7hC7m2vsz?=
 =?us-ascii?Q?cTjrOnn+NQ4PM7GIF6Y483nBjMH0WmiZBkMlS1yz4Do23ZU4wM0vziZai22M?=
 =?us-ascii?Q?9/RDVuLHQ/NhnuaG4C1aqwYwtaTXVD+avviBJ2/vkOBh6vLtkCguqC/jg9aC?=
 =?us-ascii?Q?1PStJ1iSOotKFH6GtuFzZ1ToDiQE9ASIWOCAck0Te/d3vTqB3X/QqK8bKbbx?=
 =?us-ascii?Q?Jnq3H5vb0rvi6Id+XtwGRzL668yNuPKhsrn/5SPO5TzJZefJR4xwAg4hatNC?=
 =?us-ascii?Q?F7KDlUGfYHqTlHxBHJxBB2/F6MZ34wAz5fwK0Gr9/hCrS9/NdAhidvuoM6/K?=
 =?us-ascii?Q?5OXxuKFlO/pojNNyFU1Mc+BW+r0qWhhbjoDfIoZQZvY++KWN4dMqw1lZ04Ps?=
 =?us-ascii?Q?0RhesEJbu8Kko6Fdd7P0dPhBniDZIVwyczR5YvAPsRDwiSCcaAc3KWmK5KtT?=
 =?us-ascii?Q?NxU8qVh3V9/qgypCgd3DAel8R+xl2LQARf5ck6ljEsCfrehT5G4FMmSDqxRX?=
 =?us-ascii?Q?gMs7wPVE8lnWqA2+YIHMQZbuwfK31Yr+w3vFr/tzZa/zA1pUS686FD2nUt0r?=
 =?us-ascii?Q?b/vfNzxAH8nRx8+qlnYPNtE1q+A+sk3ZNjADNFIzrNIbXjY8pnUjwIxbVpY1?=
 =?us-ascii?Q?YTvRrET9nqqXxqTw7McRKOgEbhCuyOYcvPd/m5VThlHXrkmf51R4KVXyYd0n?=
 =?us-ascii?Q?Fw9iJ1S2S5HVOv+WdXIA7rgfBVbDgSUdaOsJFHsYSVzGQm1mYHBIXrdjnN3r?=
 =?us-ascii?Q?Wn6BiAIvzdfY5T4hA409iFmOhXaKAXFuD40GwoMxX0EtzVSO3+tCWonl/Waa?=
 =?us-ascii?Q?9xTborQwMykwYaGfALFgp9KfLblwW1JQnMWM2NwcwM/lNmychvFbqe2J237s?=
 =?us-ascii?Q?rWK5vMN5UgWi9z5HxjizPpZlLwcUlYX9+6+bCTPH5DbuHdV542pPwVuRmkZX?=
 =?us-ascii?Q?0Zi+WN1APh9MJWSs37fsKWQQyRD+W4Va1brlFU7Rb7l0JuciH8kPtnUHmW3v?=
 =?us-ascii?Q?D/53lq4WArK64r3neE1BTtcWMBTqbJgbZe234j5rBdJnlFWMppKeOwZcJCHf?=
 =?us-ascii?Q?630TuQPOnex5LzsE8v/+OP6zEwhiF/KgqEU7UXdSKfuTEcEYOHDI4D2l311x?=
 =?us-ascii?Q?4t7QE29WmF3P7Ne02j4G8yM3ocJSRc/F1TbZexootQdZ5xVrUONvBshJedTe?=
 =?us-ascii?Q?aRHkybpvGHLswqQd8HJTCb8E4YTeR/y7m4H+UfRY6qLk/WXPH5FdKymgtniT?=
 =?us-ascii?Q?YcJQAIHAcxNhBTYR3ODNJsNAJeB0Icq0OGG/E7EhKmHsuelklq1PVfqrVUig?=
 =?us-ascii?Q?qRAt35GCQtci4n2aqJ4Fd31fzfq/ClVQnJ2DTTdrUBhHZiVquvWNZmzqB0zi?=
 =?us-ascii?Q?cpkj9IfhhFynTgAaULOo1oTiEzBvd432rL0tZY80ioYdJ3nKETB1Ma0qkHHG?=
 =?us-ascii?Q?kte4oakF2/dhXpKp/ZnMDet4CSXU6krtSXaIFjvA3LY8pNA4uBjW/Plz/Cyh?=
 =?us-ascii?Q?3AsuNjvobc2/AQf4x+bVGOnVY5AVrSNT0gT3xDKU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5499ea-7a59-4ce1-b020-08dc2be50a51
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:09:50.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7z+tFXJ2Afr8Lyy/3cuzg93ScW/eKYxQddEU+GuZl5X7BBmcc2d3xaaLCc2ctrE1WkHnsnUobrIzEshFY0XWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654

On Sun, Feb 11, 2024 at 09:44:03PM +0000, Eric Dumazet wrote:
> Adopt net->dev_by_index as I did in commit 0e0939c0adf9
> ("net-procfs: use xarray iterator to implement /proc/net/dev")
> 
> Not only this removes quadratic behavior, it also makes sure
> an existing vlan device is always visible in the dump,
> regardless of concurrent net->dev_base_head changes.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

