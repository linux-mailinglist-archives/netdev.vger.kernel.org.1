Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF57F740C85
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 11:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjF1JT6 (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 05:19:58 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:6720
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232672AbjF1JDX (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 05:03:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zck9Rtr180hOQIy9GQZqggge5SzWJnwqMQmgY6rntZXxLBq76iEqiz3yrEg8OIRuLVyHj5k+TgJDOzOv+Q0aQycwBOEv25K7NSFitH54JhdcW7o0CGLVmnzcvPDCF+vVpH/EMMXZeJc1RxsRYY7FeltK7qGXoi/9aPFypqaf2llatKGh9Od/P0j2yreq+IBLXjlxwmQGZg6Bfjet/v7rov5K8rwyGq9qR+BBKIi3HRjYZXa/2bMHznP6WTtjzLzp1/XV3laMpbsEhk+/Zrk2j9EToSJ27+rNQNMeYMQaFgg6eMLQbswuX5LE9ORzaMiU0zv96gg+l4TrxqrraG6SSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOhVo1AQEQtnGgcme5lNm6a1q3RJBO8mfLvJcRot5Gc=;
 b=GnTOaokfUT485EF+RGXbOojkORFapVHYSBK7zZt/G7DY1E1GatdZmixEf5GE/Di+tS2Rr+UUeDTl2IcUActm5RUDFplN1e78kynqBxnH49TaOxd1cffmEgrRorflNzxfR6B5vh0jJoKdS+JQQqch17Pn+ugFpcR2aDLs4z2xADz7oJxZWkzThi37KHXMdOQAjffKZ0qqNZ3/67YesbEKcR2UOui1WQT8bg2So0oDRKBUWhTuL/ZetTFyipNVEZ1i1BL9dRU4k2s5BHP18pS263Yp/TDSKZjNMC+2IvHLIBHzVV5PMQ/ETcXypyZBOTSorZZH95/I/h9rh42a/EKung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOhVo1AQEQtnGgcme5lNm6a1q3RJBO8mfLvJcRot5Gc=;
 b=jELWln5rox2kZJkfI/cvDjlLVxa+bAuq+zQPLTCfD5LfQ4IqnefijUlG9N5gm5xPkAYgdOk0bSAgogSmNe/YkOjOfmbC817Q3YdrUCNEaZC1KZrbru2RklhkQlxN4iXCV1IkTPR+5Dgy32mVRZr25Nm3NPEn/+mbiM0DgYrdfdg7SAy7j+MqWQwbNZ+6k3WrE2FDjfR7C1vNo9NS4Qe3BWlueqVP9t/8tNEfs8rVhDO7OHSvU6fLtQo/UzPrY+UaXBt+coIdSxoYbHldoeW56ejzeINFbp75y4IYw1tPvyAx3kVxCEM306okT9m8/UKbFI9WkvfRY6nIaumrMXPmFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 09:03:21 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%5]) with mapi id 15.20.6500.045; Wed, 28 Jun 2023
 09:03:21 +0000
Date:   Wed, 28 Jun 2023 12:03:14 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, petrm@nvidia.com,
        jiri@resnulli.us, vadimp@nvidia.com, yuehaibing@huawei.com
Subject: Re: [PATCH net] mlxsw: minimal: fix potential memory leak in
 mlxsw_m_linecards_init
Message-ID: <ZJv3Uis/ePiRKIfc@shredder>
References: <20230628005410.1524682-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628005410.1524682-1-shaozhengchao@huawei.com>
X-ClientProxiedBy: VI1P195CA0096.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::49) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5b5e3a-812e-43dd-5878-08db77b685e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNx+RmOhh8NZEDf1PelysPU9iLkhgNxkD+E3IPD8KC5xTt1QATp1uT8/hlyYzfrNH3BNkR/eISenRm7o3/BDTHB4jx8T8koI4M0iIAlFUiAWb1nP2rUvKozpok0Kzy1fCsM0R9L26ScrKDRVsN61CpjIa+UTdST7n2Jn/dgvhnDPh7GP2FIC9yrIKfyLrHOCw/iadyHrb6v/LcT9MFK+beai1DhwMQdA3TzeJoq05vjnnfjVCDItAeq2GX7ziPe7gkqNM5ZCO1qYWTt2x1GqTmNbibRJKbRHpIMtLDvLSMzYwLhjG9L2qm2HkfC1rR3vmo+m1s6ZwIUz/Wj3jKhF421fpf+bdqbkpdMfklTR5fxTpqntjq/ZXZCxhmrFBCbphp8kQAd3M6P+VZ8gqaoFwfo1Tl+NdX8YU7xmPGFKlg7gnhfnfkbcW0s8cHYg3DobGzA5lCDrtjiWzHnCtXnAwrwhYOo3G5MP+LJEdHPQ8kgJpEaxol5XUTOdZ26zhWuq97i/0a6CPgyrorN4nFfXVKRU27HwaTVljIW6zrsIAIB6qfWxofwLMaVKH1JhmR3l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(6512007)(26005)(86362001)(33716001)(41300700001)(6916009)(66556008)(4326008)(66946007)(66476007)(8936002)(316002)(38100700002)(8676002)(5660300002)(6506007)(6486002)(9686003)(186003)(83380400001)(6666004)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4/ibIJzhBIfUiSeWBi/UX7gj91QuJYfZrpN3P+gC3QYVN14YmlHB1JxfVpQa?=
 =?us-ascii?Q?6U2Pa9qGH5d/tJi8S1ZQGpO07IXvcYTdOsVNQcL7WvVgpyFguquHa1z/SeKw?=
 =?us-ascii?Q?4jTECvHX+SAGH6FFOmB79cJ0pjJHwTwiXaN1efulWxuEJgVSKYfR0xi/M0EL?=
 =?us-ascii?Q?blLBF66uINR0FHC/Opsy5OkQ9vECf4d0yfTdipJpX6CSj0Lyks0aJ6QzaQT0?=
 =?us-ascii?Q?A4eu/C7Kd/C5WPfqDkws6ZzOUjRnvuxycPCKR2ui7HwzLvX3Z87EhiNPe/k/?=
 =?us-ascii?Q?uG1h12blKUqOgnR6/Ux+Sk2k/ye4IPmezr9Easkr4s78QreNOSYMMtrFriaa?=
 =?us-ascii?Q?cUcjM93Iab6sLRVi2TrFcNcsB+/6rlki9We9Nq8x4lQVPfRL7BcRReVfxazt?=
 =?us-ascii?Q?BGaVEl1NoiuBAK/Xkm8opPrRR+hCnegOLOx0HPPIX0g4dxb0MQw3uRwKVtyR?=
 =?us-ascii?Q?7EoEKUcs78cJqe36n+S+tpt4qUSva7nJmMWW2FRsNPDuGG1BrkO7pxbIy3F5?=
 =?us-ascii?Q?chOGJgSp/00pmrH+Uq8dV8Rj2wqHfEHuLcA1nDZMq439pGko84GgxW8pP6EY?=
 =?us-ascii?Q?Ux0RCeyI0MpzaPdT3DJFq/bGo9BtS9CX1L3OFUaBt5Na8DLswiZQ69NnCNvb?=
 =?us-ascii?Q?FAS6KRKIOson4IJuCiRVpaeFNYohYAHHenHyb0RNI1SToKNpvTy+VG8m3dD5?=
 =?us-ascii?Q?p4ogbqfm80ax0wfU9HsSz3K3tidfepZCWdH6uulWXmYMmqmFXHPNE+xZuXRH?=
 =?us-ascii?Q?xfzy0xsmCFuaQKmiXl5a67Q+JM37kmkfXglPVf9kFp+OUF1n2AfR9jaHseIm?=
 =?us-ascii?Q?x+RynE8CvmUHU9N2wMhSpbZni8ToaFFa6lV0cc2xJvJonHbEHoROpn5zVOXh?=
 =?us-ascii?Q?96aIBtkbQ1pUIf2n8mbOFJcDgSxmDrblw1NV6K90T1Lh9aSfD+DAe2fchnj8?=
 =?us-ascii?Q?VZv3LIS7of4D3gorMJbzZ7DcEMajNAUwCj16s4uVf9ZTl21r3CGxZxvzsUAn?=
 =?us-ascii?Q?hSKIB6Ty1R8c7pGOOjfrXERc6xnLJwubxETLTSZVX10tkCKNkZtVD23qViKA?=
 =?us-ascii?Q?QuCvq1p0VRqz4tBKC25uJwWkLfH5Mt0XqPNHQ2+58eWdSTH15gTmi0Tql+c8?=
 =?us-ascii?Q?ct71AS4DTU33dvEyAfj7IExgI6QzWGYA2idWn4L/f7rwhWHUd4Yj3LAjXmAU?=
 =?us-ascii?Q?FXjTU9ws5KMQbujIJAAhUCv5U5FYavHCA6A54ZFdWrulfmN8/Ur1XJHLHN1f?=
 =?us-ascii?Q?2aIo39ix20DE/WVRqoH8HVQI+euxy0BbXxDLSieCKx6X/o7jqT85GRCyxRR7?=
 =?us-ascii?Q?Ns566z163zEO+2gSB/TWZUN0nlUVu8p82t2K+QyySFG3qB+FRnS8LN8tsyVV?=
 =?us-ascii?Q?V6pyXzoYGVqCMHfG/ljSHuotEnTHP2BtnRl1wmcpeaexA4+BOoQcfgkukKLN?=
 =?us-ascii?Q?azZ7s13W4OM71ME3zlspS38SFH+XtQOqpgKhXv42/N63oEiV9n1mudp7HEf0?=
 =?us-ascii?Q?V1uFcugQxJTuIQYLLh/xLWWPtstEPHVREER23wQC+K4sx6S4Ke8wGjoQzQfh?=
 =?us-ascii?Q?9UGP8Y5Zilc0cSnF8H8SKPu6X4HmCyxO6CVgZt2c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5b5e3a-812e-43dd-5878-08db77b685e4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:03:21.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31QPOFmVWLLTTXEYPqZaMaEVZgYFuGBicSrzd8752tlvcYHQoOkSGJi1lnLc8QFHmciKb3gSJ8VLniuCz/5J+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, Jun 28, 2023 at 08:54:10AM +0800, Zhengchao Shao wrote:
> when allocating mlxsw_m->line_cards[] failed in mlxsw_m_linecards_init,

s/when/When/
s/allocating/the allocation of/
s/failed/fails/

> the memory pointed by mlxsw_m->line_cards is not released, which will
> cause memory leak. Memory release processing is added to the incorrect
> path.

Last sentence should be reworded to imperative mood.

Personally, I would reword the commit message to something like:

"
The line cards array is not freed in the error path of
mlxsw_m_linecards_init(), which can lead to a memory leak. Fix by
freeing the array in the error path, thereby making the error path
identical to mlxsw_m_linecards_fini().
"

Thanks

> 
> Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/minimal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/minimal.c b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
> index 6b56eadd736e..6b98c3287b49 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/minimal.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
> @@ -417,6 +417,7 @@ static int mlxsw_m_linecards_init(struct mlxsw_m *mlxsw_m)
>  err_kmalloc_array:
>  	for (i--; i >= 0; i--)
>  		kfree(mlxsw_m->line_cards[i]);
> +	kfree(mlxsw_m->line_cards);
>  err_kcalloc:
>  	kfree(mlxsw_m->ports);
>  	return err;
> -- 
> 2.34.1
> 
