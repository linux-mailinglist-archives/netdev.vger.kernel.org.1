Return-Path: <netdev+bounces-18078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67D8754853
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90587281F0F
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 10:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1F1865;
	Sat, 15 Jul 2023 10:57:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8D185B
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 10:57:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2115.outbound.protection.outlook.com [40.107.243.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5D1BD
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3ouOfc98KyWQZ2wDyIs/c679YzCBUd7xT9MlyndV0raep7edvyI6iRwrzSe/MUMpcvvXer+AX7qBrifpXYRsnHU1SJBF84v6kxtrxAcIuDj5+mnqdp5dhPTiqITrY46OsD/hW/Cu+xW/4VwjM13/1iF5mvAODQ5txrPCT4fcb+I4rxA3TzJGHGm1RF0bVR3nFFe2AOjNo+y6K/XYMpmT7jyXL2GKXzZSvovOYpJiOlsMQYniG5BGd8f1pNSWwDx/4o3nkxZFrY9I5rsN1qLEL8VxEuCQ3NwbosePxgLl1+0p46ugXjhLrhamzg/LewiJbNyKVm6s5O64D4Jf2NyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvzORRQwpwicKl9HmXKJEvnzJYj7s5veXGXebGMCWzg=;
 b=BNeK/AooYSEllcfruC/5OdjaTBRI8o1U6rwKZee/LfJg1JsYJkiErFaUApNL1P3hWBBXCIu9loE9W1U4jiLCK8myxTcIuQWcH+8nF0/A6j89aS2vSQ4cbMfYqdkdKDevVyp5jefmlsBpuPh8Yhm80gZvhPWZRPifqkohTkHbb1WbFTjXbW5+NAVcM9IAXbtCFWYpJfXq0Z+wt5MWysjSql2fbQW5eCHjLe2qr1MVCCGQZHN4/oM1wXGwcCez8SN6W5Y4/ra3BZqxHJiUsMZP1yGv4PxhlDG190qkTSaX1JdsupgSQZL8ziCiByhQOEc0jtonzE6rdISUVOqcd4TRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvzORRQwpwicKl9HmXKJEvnzJYj7s5veXGXebGMCWzg=;
 b=AWuRuhuNpFYW/cnLTDfzn3kFwC0Zc5O9iCycB2Lh2/SSHTs86SvGeZQmjDzN2K1k6tR+l6JwOOE/TdkUy4oZSOXXloDgf/2CBA+ie5EDnNu0I44pFf/s6xj0U/G1sTkzJf6Bw8CIQsNvQrS+i+KjQaVDCg64l4CHEwayV33mcOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB4681.namprd13.prod.outlook.com (2603:10b6:610:df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 10:57:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 10:57:49 +0000
Date: Sat, 15 Jul 2023 11:57:43 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Paolo Abeni' <pabeni@redhat.com>, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3] net: txgbe: change LAN reset mode
Message-ID: <ZLJ7p3qri5Qj1nsz@corigine.com>
References: <20230711062623.3058-1-jiawenwu@trustnetic.com>
 <520aeaeae454ed7e044e147be4b4edd9495d480b.camel@redhat.com>
 <001101d9b5f7$df93df60$9ebb9e20$@trustnetic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001101d9b5f7$df93df60$9ebb9e20$@trustnetic.com>
X-ClientProxiedBy: LO4P265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: e7875665-6689-4941-9191-08db8522542c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aqbGTH3TzNnVvREVQ23Hih2WRCF6LC6Wz5Jy/aMhnSOFquKndi0OrTh9UL2u8BMbF5HqOfjA4VJqNEv8jrMC9W5mGgfA3Ba4Te1zAUpxqDikww65d2DKHB44DMxs9ZKgyX6YYTS3qPZWdoXA6erQbcjvrCcvoANJ/VqA/66t8bOtoN55knr2TpYkqd6wfebBJhz9wZAoQhpdeZL1IY7b6/G+Lw8JysOvXkqxc4+sGChHA9jcQl419uRi83lsY+sC8ybyAW/Fk/LFJPUrFG4FCtajhzmyj65GcpK4uC+i0VFjM6xN8bc13gh1HGK5MmI6eAhN+/L4hlBCZA3Vv4Q17nVtFBROAT0V3JTk1jHYWvL/h68FoZwUao63lBZKevhWqonySsb0EEh/6H1jimWtDX8zanQbzhrks7sEY4UJsd1baVa2HbSlOP5dnhGM+R/aYgBKvuwFOBr7fVSGpwdW9gNCJAZVtY6sxsVUKzwxZrqTYqzq8699eF3n8RXUtv1xhJuSJLSH84VgDmhBTqhwY0TTl4NQwAk8U6V9z6H2F9p05QcYbs+6DqfeRauQK71ZgBBwLzL3Scj1B6yv0ADqopE6q1d/FRV85FxA1IrSD38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(346002)(136003)(366004)(396003)(451199021)(8676002)(5660300002)(8936002)(316002)(41300700001)(6916009)(4326008)(44832011)(2906002)(478600001)(6666004)(6486002)(6512007)(66946007)(26005)(6506007)(53546011)(186003)(66556008)(66476007)(83380400001)(2616005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YTHRrGjJ9Wbu8k7uFeG+ZjIHjDP5DdqxloGaIXPKI9sAqsdpPA8YMrgH6TL2?=
 =?us-ascii?Q?qVIbE9TfYLVKVen7VrOg9/UncvAJGBq+gAKspt/XDkkTKQsaOPoHI7MMAlPK?=
 =?us-ascii?Q?plssfSipmsHC0Y/cao1RnlPLSnjUnCKKwZyjdx7yMOV681y5VfqDtqonV9iO?=
 =?us-ascii?Q?x0R6b2oN7BaZLRRX+9o+FfeNEK0ladYmLWOlFMdCCZ2ommBWlVHESHet21aB?=
 =?us-ascii?Q?2orXz4Xn5HFMNHyCKl35UKjo+rEPc+YfXWVBua9te/FaAuyTEewbVgeBtFAb?=
 =?us-ascii?Q?ExxrlG0QXPIHGeY789w6ZK1whKeY/82i4PunmyFwEJQu5vmwUMYmvV4RCMV9?=
 =?us-ascii?Q?XC2fOps/SEkgX0wSkv4RdkYc05xkNow8m6rRmZlpxffrtOTGVhohBblKuBj2?=
 =?us-ascii?Q?0gA6oK82vJHtrVnoTtnwP8qSsMd0BBgSWOnxOiLOG2g5j6zTTUqXdEW7nL/P?=
 =?us-ascii?Q?fVs8qj/XzuI8RdgZxsKT1OfKeIjAjszSyDWaGBY/1scKQOzex4APyQMdaZJt?=
 =?us-ascii?Q?as3lqa+lTWYXLVPGmj4pT+sPFExWo6jdVDF/CS1jzzptDu2nz8wgOn9LMrx5?=
 =?us-ascii?Q?mJ2VIbCZfJla0zh3yymrgxKkqFrTuI/QzbJdg/xlx0Pwedk0PXZNzFwGCRBL?=
 =?us-ascii?Q?jYH1kP49Go2ObMqGLtcAGdhd+bJIys7ZKqa9sozpsKrIqQ0OzUnpNfLNDO/N?=
 =?us-ascii?Q?0zy4vCI232GySPkRV3fkFyHh5ZIIjUSOVzQNOYfwzj9EvjgijHwwvA0JuEt+?=
 =?us-ascii?Q?Y0fV2vHFQQFIVz8Hi9vLYqJmjtmhGQ16ccBVftoTSa1UBEH+Iam74xEcb8hu?=
 =?us-ascii?Q?FJNy+koMFmCbiqZSyzB3zGgrvkZ8qbpsHiNIsFF/8eJIk2fGJ1Vmn6/8Fqhz?=
 =?us-ascii?Q?skxSr77K0xh5d6kf4tOz8c9db3fhoWCQzI95HppB316KjbceTUdnKRrJyJX9?=
 =?us-ascii?Q?BqOdsstyoGBU7MjuyuK35eOTprMqAGybMwOnG5UnscYE1B9SAo8fMXMwjYo2?=
 =?us-ascii?Q?Nk8RpXdaPf+Hl7Evq4jtP283Cd1Qs8EyRgHv3PmoaxjgMzBOOVy4v4jWFIBU?=
 =?us-ascii?Q?pPIGKPmFG5T+awND53MuvR7uvFVHrpwaIlpqyXMyiA5NNiS4udXp6Kxw7RsO?=
 =?us-ascii?Q?O8Bj7KnTMBEF0T0moaFi+bsT+9Xt/6m8IhQegEzfxNTOblc7XkzJJt4q7ksV?=
 =?us-ascii?Q?JC4+vz8zOUQqAKDYbODwVEF1rAiPBJOEYYJ33WZnwlxl2oBuxut8Bx4p6YFE?=
 =?us-ascii?Q?Gxphqd70RqbpYG8jVBPdzDHLOSqNPcXBIurMrLo69CeJ57FwDrGhZiR4nT0l?=
 =?us-ascii?Q?uzkivTEXm1F08hO9uIYDwYwomvKcnylL6q3d9zC+7EG049WyYZXURKnH5HYK?=
 =?us-ascii?Q?bQfziIRXAj0byizTjAicLEkvDq44Oy7r8DAszBybXz1dMtI4mILlVZXzxE7I?=
 =?us-ascii?Q?Tk22UF62fhlxzNV+pSTlSQpQu8YfA5pIWtPMZdAN3eE7MWR83O1sHsnxGm0j?=
 =?us-ascii?Q?+AmE8TcYJbhlXLiEJWgaOYWLAtXq8vAh0awS/K4h+OyoiUHm1fyzCGph5B6Q?=
 =?us-ascii?Q?Zaula5/P373bD8l5FcE6h8PXvgci9T0kUeEc4RJovwNXug87fzRNEPVQxmGh?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7875665-6689-4941-9191-08db8522542c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 10:57:49.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo79ehMrcwJa+/P24JVqq4vTV2TVwOouxN/ds0jk8XcYfT7cQEtFTyjl5XoQc3YZLlzNnKLaNumqNAJ33Iglgep1uQci63hUwLD3Cno4HFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4681
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 10:06:59AM +0800, Jiawen Wu wrote:
> On Thursday, July 13, 2023 8:49 PM, Paolo Abeni wrote:
> > Hi,
> > 
> > On Tue, 2023-07-11 at 14:26 +0800, Jiawen Wu wrote:
> > > The old way to do LAN reset is sending reset command to firmware. Once
> > > firmware performs reset, it reconfigures what it needs.
> > >
> > > In the new firmware versions, veto bit is introduced for NCSI/LLDP to
> > > block PHY domain in LAN reset. At this point, writing register of LAN
> > > reset directly makes the same effect as the old way. And it does not
> > > reset MNG domain, so that veto bit does not change.
> > >
> > > And this change is compatible with old firmware versions, since veto
> > > bit was never used.
> > 
> > As the current commit message wording still raises questions, could you
> > please explicitly the level of compatibility of both the old and new
> > firmware pre/after this change?
> 
> The old firmware is compatible with the driver before and after this
> change. The new firmware needs to use with the driver after this change if
> it wants to implement the new feature, otherwise it is the same as the old
> firmware.
> 
> Does this explain make sense?

Yes, that makes sense to me.

