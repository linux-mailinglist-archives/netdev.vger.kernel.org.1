Return-Path: <netdev+bounces-17541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A997751F34
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22978281DA5
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109CA6124;
	Thu, 13 Jul 2023 10:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB7EDB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:46:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2118.outbound.protection.outlook.com [40.107.101.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A31FDE
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+s4jt+ImcLtNKo/tHb+IizFJhExAD0RQQqNkSCYD4SqmXpumJZzlpoFf/hESbGWeLXiD+mz89QLAApKYIZu90wrMHXoeZ1owBKzZEF+dtdhbCN2Vgk8TT3IF6T8XpVGzKE3+E/e1KsAVvMB0Kf5NNlDMaCcYjWJqhfSIL9Hx+RiYlOIRQS2RIikI3ZDMmwrgZxdPOhRvoILyG2o4+RIsVa87r7K+ZCatcpmM7ho8DcKuPNGkyB7yGcDXMQHMmdgCqliDZMGqeYHvZAoG+zEoTmoBeIOkem/LLdHM+Sg/do6PeGC2kZhQgYBtMu8h7UEfk3Bz8p9Lu0oMnhmBjGDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9J8hEMI05AHJ94NwKse2Qkcu+ckcH7zyRLYH2Z3bnU=;
 b=HOdks00YQ0xFduUzpg4WHtkn7nN/AalB0xOLr0Epj4N6GEYkxr8Dq4c4k4IPvgmRwyqHNUO1gcWJjomSnLuCBnRwnPm3dPrN7OEK1HDY0RbNeKKPpcgSBndeZSxem5LLFPRptfS0545QpoD3ywG5YKT1ArX5i+kFxolV6fdxXB2VbW3jiyXsYglGVLU3qOvkQ6PzLdZODWRMr4qHuTg8RYeyhwmwzUdygX2LAadhuWA+BB37mtDiIq7Fl1FNNhNd/Bk4X917GpyoQO0lV/U2DYEOT4T1NW9144+xhTAHtaB60bjFikaHBTCWfnu2KzuqGRu9r74pJK1tvQ35G6LrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9J8hEMI05AHJ94NwKse2Qkcu+ckcH7zyRLYH2Z3bnU=;
 b=r0Inwk84ySg9PS8x6fe8IK2CmWn/LkMj/98QRzm5TGprL2xQMiMM6ooaLo5exz/yocoapI6/pw6RkXTTRxCvEA1ZZKNKpG/ifP16NBc8yoXxc1myh6olVqLd725j9eIZJ+qefBlXJSFrwyqBksW1xTURFfgZUGkpwQzYTgGTPkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB4924.namprd13.prod.outlook.com (2603:10b6:510:75::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:46:06 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:46:06 +0000
Date: Thu, 13 Jul 2023 11:45:59 +0100
From: Simon Horman <simon.horman@corigine.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, kabel@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell10g: fix 88x3310 power up
Message-ID: <ZK/V57+pl36NhknG@corigine.com>
References: <20230712062634.21288-1-jiawenwu@trustnetic.com>
 <ZK/RYFBjI5OypfTB@corigine.com>
 <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/TWbG/SkXtbMkV@shell.armlinux.org.uk>
X-ClientProxiedBy: LO2P123CA0042.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::30)
 To PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: 94856d0a-7f34-4310-86bb-08db838e5c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Ocx+pAu37tjQizrJinSHTp/Ru9UFHCNq1hJgal/cmw43mjixBJb5v6NvU+FvQp6GjvdcNDUKFZPCFWZa5AVw02uu4DDG0UEmBBWpR0lH7XXMtDOirexG6nueWLeaQDNZsaPhi0JTEKQYfc89/LsnCn1L9L4VfBXble9sCKSNAp3SktoPFeyDoPMngnL9VKIqDgsBlFd9Ygg+32cz+CMcg4/he90G/H/jLk+/P51yIFIkOtNTrL9XoYih1j/w+vSR2x3ZJGjGAQAahePIowU2hi71tkQJmwj11+TRePGN79nzUsnZqD1QqhHpp2VPlpzlmWrgBfbgE4gjy/OTVwky1SDurTjEGwoxX92rl+DgxSWvgaB1kZxL6Z59+uuRjfEt8rk6UzaMWib9EEjD9LQFnLjZrsJINvyEJGvrSSVI7OfNN5FKKLk2HPjvDVczVBIO63QQzKBQ9iiKAj5YdJrQ1FesIRqRKJV9/+d1DqYukEJL2nbVCU2a0OppKq9zZLMg6Qx8rM+MqrfUhVexvlBHZFP2jX3+hTcV7qUxYo0/EVH1SmBwPy6SgnJ8dQdCPZLjr7wJ/iteiDFuhVr/fTreqkeFCiKIs4fuxffHtPapXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(136003)(396003)(376002)(346002)(451199021)(36756003)(38100700002)(86362001)(478600001)(6666004)(6486002)(6512007)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(66946007)(66476007)(2906002)(4326008)(66556008)(6916009)(41300700001)(83380400001)(2616005)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LrriHViMsD48nKX8XVffNYlBLuPOTXZSelNzR05mcwkeZdas2mPl58r8+fkV?=
 =?us-ascii?Q?VamnsRLwdNRpaYKh4dSZRNcvz1vGjpAMXFpW4HPLu9jm5PkCo6U/7buaAHUq?=
 =?us-ascii?Q?cBSZUxBuQ2aUxmgjIfwp6MXpTj8wCCh0gTEua5QtcPuxHxcNIUutPpSTQ7OT?=
 =?us-ascii?Q?ex9nhTht0OMbD0qXoxsgWSfRsQ97vg2aSUUOnn5mynpImS42TyRBIfJpa6WV?=
 =?us-ascii?Q?c1621qjTdm9MB5rXe3VYHJKPtaXNal8HDMgFLJ+eu+Dkho5cZjhK8SI+FFpv?=
 =?us-ascii?Q?cfC3PL7KZEnWCDlIBRrhYQ6ouxJn/lqY0N1o8oKp8NUxlr5+TV0Xa64YkWJ2?=
 =?us-ascii?Q?JMVaJCLkf8484iSadoZyxJfdglUNS+muN1za+SuxwAGJgboYscRqpbKErDzo?=
 =?us-ascii?Q?hZDTJ8rcdY/k4rAeRZOeCyStlgyTcuOpdV1ue91GiouIxE17ZCBCK9SfUxcE?=
 =?us-ascii?Q?dqHZ2eI3ZUrMWhoXFcUQpWHp5MbuulK19IG+IlPUHVxTuES/FhX3BBTQOT3s?=
 =?us-ascii?Q?rj6V45TEkpulvbU9qcSGE0KcjBZY7l9diQ7tMHAHGHPwX/QJx2qVMqvM8uvL?=
 =?us-ascii?Q?jJ9h5tFJy+hqCo/G1UWlFYPXHKtbZCKJjE3JKBpoS0RAEB+FD1mVQN2tIb1Y?=
 =?us-ascii?Q?/9dh7Xc7nk6byRwFvETCKEWh2khEpG5PNoqkNYdbBzoMzQNrIT43tbWjk71b?=
 =?us-ascii?Q?+3+YKEssxwcrBs/2yW33j+4qmjiHFrwwd0odmGpdiF+KhmkR1ujWDIkwVefh?=
 =?us-ascii?Q?f13wiP8K6QjD3jhkGRxTNP3DWAD/C7flLC8Vur/BRBd/eCf6i0LttKZsARN3?=
 =?us-ascii?Q?e0T5Sw3aDSv7X5EnHRhXY7aQyrYUT3CCfZlB+BCLvn+OOaxmkya2pcDP8IfV?=
 =?us-ascii?Q?ItPsFtRJnZcJSMEV0aWnx+lnGUdE9e9/zHgOOUxidtPlc5fsDm8pKEfU+Cxo?=
 =?us-ascii?Q?m/AyIcUaqKqwPoXjfPz1sv2DItdLnWW+JJSZj45orRXfK5eEX8Xbka3ukH36?=
 =?us-ascii?Q?FNxKtDKIh3CDUcL2MZpfEO+eWzcdfUNGuyGemj7xVTeshRb77LC+lv8S15In?=
 =?us-ascii?Q?YQVW/AA2KOdC+n5sQF828R+ID+nmJeJ0GUocD4uM+NZa6bTKgN9TaNCCQfJC?=
 =?us-ascii?Q?lQL2AxGbK1dnV/RliGiiN6gsljgk5l6dTdaA8lCsw6zwk6CuLdB5rk7f1ydt?=
 =?us-ascii?Q?U4RRsWekYWUY8/prWN+tjG1OCOxcM4qKhvGd1uv29iS9gvJRsdX9QVyTiXak?=
 =?us-ascii?Q?qQq7I0LM05q7k4U4YX4p3gJ/cImcpn7dKNy8kW2VGrWNDUadIbqZl0X+40XS?=
 =?us-ascii?Q?b/gphz0aHVjAzH2Jzhrrq29uoYOe7h4U2tU0VAthPlGd++ggrUQZh1bUgmND?=
 =?us-ascii?Q?g59/Vn9iUu+KME+gVCafsLIuAToQtdiKPX6peRweM1uk8Di5JUhnO7JTsshn?=
 =?us-ascii?Q?R3Rmeu5z/XGJxtnwFMZRZmNHBceGUQU+fnlAK77CIlaPTnSznTY2xNg5/FCn?=
 =?us-ascii?Q?x/Grj5bMQsrqxTiTwiD7q16P5ANLIpgVQCdsROxx2/0qqdv07/HijThzgL0Y?=
 =?us-ascii?Q?LoWChN5z3Pp/k2efn/mqSIHeFA67ADtC9wlaPbDoAWojCs5qnkxh+2GerdX5?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94856d0a-7f34-4310-86bb-08db838e5c73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:46:06.4048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtkL1EWAKlhPI44ZW5h2DsR8GSnRW7roaNn8lYmDsFsZebg1Kofsdf9TbYzfPCZe0iCVWHuWgy0RpwkEac/T3uV/EorCXdRW8vpyfQtXzTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4924
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 11:35:05AM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 13, 2023 at 11:26:40AM +0100, Simon Horman wrote:
> > On Wed, Jul 12, 2023 at 02:26:34PM +0800, Jiawen Wu wrote:
> > > Clear MV_V2_PORT_CTRL_PWRDOWN bit to set power up for 88x3310 PHY,
> > > it sometimes does not take effect immediately. This will cause
> > > mv3310_reset() to time out, which will fail the config initialization.
> > > So add to poll PHY power up.
> > > 
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > 
> > Hi Jiawen Wu,
> > 
> > should this have the following?
> > 
> > Fixes: 0a5550b1165c ("bpftool: Use "fallthrough;" keyword instead of comments")
> 
> What is that commit? It doesn't appear to be in Linus' tree, it doesn't
> appear to be in the net tree, nor the net-next tree.

Hi Russell,

Sorry, it is bogus. Some sort of cut and paste error on my side
that pulled in the local commit of an unrelated patch.

What I should have said is:

Fixes: 8f48c2ac85ed ("net: marvell10g: soft-reset the PHY when coming out of low power")

