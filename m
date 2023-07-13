Return-Path: <netdev+bounces-17495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB7751CFF
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7874281149
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6772F9F6;
	Thu, 13 Jul 2023 09:17:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C420CDDCD
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:17:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2135.outbound.protection.outlook.com [40.107.94.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F401FC9
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsWx+eM1i/f8SjXb6LRkxgNIb6WAtEqmwqkzMoKg2+igatymlcMaPC9NbQU6O849v4N0YJtqyEpq8qJjA+L/jTZn9/g8gykUiH/DOs2D/4PSjEwSIQ5yluizdIDYBLLNPBPN0C/1HqxjnprEgc5ytiz64q27SypI0W+TWkBqVJjRzf9/9FK5lucTk8jabs3HQlvMd4fK7Zkpb73N8JTmlxy182M8XRTqyQ6fvwzVG9HrmVT5ApCHkGKtJ562aABFhdzYnnOQ9qar/5etkiFl9swiahfYgBNUSMJsZZEKg0Go56ZIiktuCKi2PjIwU7zEwKobIemCwmSwpCUt2+8H0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A28Uo9dGC9HyGy65D2/oFFK86THmF+iTdfV7l1uj+v4=;
 b=YhqMkTvJkAzGR61XdRz/APgMMerev/520WC2Lt1Zk14s0CaVm8tBFFasrWJPSos24iyByqrvSe83JtAy1fp55u1JVJuMIpLjv8fAeXGtVMBjLOLXocTIez+RB98OI1koUC7GshKYXd2zEN4LrjDLg84BfV1bMTICKDS+1leo8Wf7XoOgCLxiJWPWI5kvo8ASfwNRxGAkN3O5btG/OhjftaJxtHRx3OPn9x6JDvW48uPv61yvzlwMPSb1gpTeDtJorDWLcLpwbtJjWk2562GfZ/UQa4+t++Gh/D2lf+D4TDtLCfCz71upphKq9feA2n61liNWn8Qn1LKbc6WVYkKJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A28Uo9dGC9HyGy65D2/oFFK86THmF+iTdfV7l1uj+v4=;
 b=JiozK+/q+hWc7ZihZ7tfhBLZofpvlRscP+yh4r2v3MqOGU/imKFL43+SpEBV+yWwskNWacJs/rDHkjtzI1t+TFlJkTHIinv1MSI+NLSyIduqk+jYNsFg4f4gmBFmXnBAbM9lhAU1/Feji9xRkFOdPFRjo63xX3QzlzrBw+gYw1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6323.namprd13.prod.outlook.com (2603:10b6:806:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 09:17:08 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:17:08 +0000
Date: Thu, 13 Jul 2023 10:17:00 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 1/5] net: sched: cls_matchall: Undo
 tcf_bind_filter in case of failure after mall_set_parms
Message-ID: <ZK/BDPPM+6BOXEfR@corigine.com>
References: <20230712211313.545268-1-victor@mojatatu.com>
 <20230712211313.545268-2-victor@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211313.545268-2-victor@mojatatu.com>
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d113e3-2eb7-47a3-d4c4-08db8381ee95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DY8mpbZ1/aM78JU9RlSeuHMM2jdAV0kwPqHZm9SmqtDlz6XpcK80+enHPTMWbZW+OED8QT0NokDucqqmxqBLYLM0owlfmpv/pHeqTp96PrsjeqBD2Oecqw/6xSA7OmClfEuLRU5u/ZQpOlla1MKHSvJOXRAhJcIz09QY8lyflCX/aAbdSTiQzBxaY05T9sWPJQripBvwHYscxLYwzNEO5lbYIVPIb2ous/PQ4GOIlaCtCKnvl4CLh+oD0XWhpDl7FUk2P5npSWhevXQntv8+lsgagM/yb2wiGEo7lJwTLhfhVjJ9Nns4FT1tQ9mOy0jCsfLdviorkiUChS5miMivFkGkAZ5mrqk6s/P6fvKtrbWwIGGOzJhqa9b63WbvGs5ZdMzFJJD7gJ0HSl3CfOfWBnnr+THPLfM9BhiMzOXNM614ZlJRv+BhMwEvjAqRm4dELVtxszjW2l+MHOf4zMrUGXMsGMUAp890CnoM8ZcWhCs73oXR8dRDa4D4YjUsduhjrjcG31QGC7M0Bh2JdXvg3++rQ3W30rcnLNrtRLWgS1SV/gdkJbIM6ux2JrN1cqUS4VFx5V7OkR9EkvNV0IP3hIeGN6nCCZAcmA0LQ8Xl9HI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39840400004)(396003)(451199021)(478600001)(6666004)(6486002)(6506007)(186003)(26005)(6512007)(2906002)(41300700001)(66946007)(66476007)(66556008)(6916009)(316002)(5660300002)(8936002)(44832011)(7416002)(4326008)(38100700002)(8676002)(4744005)(86362001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JDohUF8MH1RlACHe8nLmLrODJtJl5Co9Uq16oK8wWBw/maiu5jl0MJsoQe+b?=
 =?us-ascii?Q?zfFSDMzzUR/m0GV7RRWoqyXUR206gaETziXHA6JF0I+yR3aU/0uI3F6Ci/th?=
 =?us-ascii?Q?SWnwdbz+EI+qKWPlSORG86hkQVbDeESLjgZGRmw/pZGpzcV5szSblwYXqlyK?=
 =?us-ascii?Q?pcI2IJzrc89ATs5BYlT+4Jn4m4b3TZXSg3uzDKzhgFiIPfzlsixa3wBe1TpO?=
 =?us-ascii?Q?ejCw4KdRdywwXQrQJlEBDYxRLSQvFB2IKGdu/ljaRvcBiYHp1aiREot1517m?=
 =?us-ascii?Q?1HDcqZnnC9XwcnkLDECVBtcq5TeKUVvrSB+F8nbGZfq3R0/iFBsP0aPukM9f?=
 =?us-ascii?Q?vIHbsc2hojAp67/JaFZL82/8AafgxwRsQlaI9vzOyLvIfBrjk9+LOBVn2OXI?=
 =?us-ascii?Q?fB/oF67ED9tLE4i5yue4KkUxST9cWpcdoM70uAGfXg0dRIV8RVxj2GMbeQck?=
 =?us-ascii?Q?MTdAi2gx8xp7HrxpZo2mKRPzBu1L4Y8e00+dSpacPS3ZRgP5XlDT3ynNMMO6?=
 =?us-ascii?Q?fBEBpBc18fURK3iMMBpoLmea0IzDkFeKe/f9QWLrnluB229sYTRWzkcvKDZn?=
 =?us-ascii?Q?IKDaJfrEGiCYQvBWEgj50N1qZgmaCsXT0lwJmwl8rFyoqrHwkTnCXKkuASA4?=
 =?us-ascii?Q?zd6x9wYFAfZg76xzVexkipQE2AeABwlESMrQYbkVppI8ILiV1AVX8/PunXT4?=
 =?us-ascii?Q?Ak5gh5FygkGgurjqRZDO686tlWu2SWTgRS08fz889g5TAD2oJf5QLmtBImky?=
 =?us-ascii?Q?gGABPq3Z3sx92Yv9NqoYD6YDscO3Fqc4wjAQHPR352vLXt0+aXN2GfL2Rk4t?=
 =?us-ascii?Q?rpdiyPkouirZi/Lv4JoshWbnWSLEdlySIOSYGVAiZKRSNi9kz3O4VDSUWL3K?=
 =?us-ascii?Q?2Dbf7p970+s6NFUKxsYEbxhBnurZ1iKrqK2ylMXdJe0RVt7PLHVoEEZN9JHs?=
 =?us-ascii?Q?8aNn/VV1QnBoga0SIc8GekDH93gmPTrtqlEM+TIz8yGEDMmhbTWL8IDVOwb8?=
 =?us-ascii?Q?9wpkJnYobCMGBJwE4xj3ZzXlDIhvk0sXCh9Cqbdot4355872VRcC55QiFnoN?=
 =?us-ascii?Q?/hlTW/wQL3wgia79Z2ExcuBpFOLjJ5EEkAb2tUFb4Ci26UPK1g0iW+xMY6CO?=
 =?us-ascii?Q?h+z4tW4ojpPhlw56bIho4ydjPkCpXJc8MT5fbNcNasen+5qetkQlnk4z1jes?=
 =?us-ascii?Q?W2RyKhAmdRFU0Cvm7XQHzzTs0NEkIrMdi57XBgMcb3y7l3WFTIQ8nDVWSlFP?=
 =?us-ascii?Q?6iwr8JD3ojS1lAbGvrunoURRqbBpTjTdraABY+U21QuGc70mJww2Usf9IE8M?=
 =?us-ascii?Q?VdnrXUzaz3LFHJgSKWbowSJ6qk08wqzswdfUSPwOO0kxkrLDn1qGMZ9HeDVX?=
 =?us-ascii?Q?O5bcYJhnkjKqVvSP49OosYm3SFDtV9FWvBAlt1o+FOK0doShq6NE1vLoByMj?=
 =?us-ascii?Q?yH8W5sJ6W8o4/yM8lGM60iEmqNV2eFB+rUYLlENvjNhVp4wjcQ2xvgLKK02h?=
 =?us-ascii?Q?BK9JQJp6Rdhbwy7MN/D3F//FdXLJI25Ma49ODYWVX6GtjKmGPpmIaaIht89O?=
 =?us-ascii?Q?QSrIbuV44/XGevKptHXNlz5aPGgVpxG6iM5WAWKcZ0x/Ol7HXrTto66wwaeL?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d113e3-2eb7-47a3-d4c4-08db8381ee95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:17:08.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKaywXH7uRxmWqiyBE3dAwjiPVa6owUKL0Noi1V2npmmNffGZYhuL+xUSCvusIxLAg4Pf+nUQUXxAUJRzJOtIRRvmWFZTY+9cqcy/ZnX8ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 06:13:09PM -0300, Victor Nogueira wrote:
> In case an error occurred after mall_set_parms executed successfully, we
> must undo the tcf_bind_filter call it issues.
> 
> Fix that by calling tcf_unbind_filter in err_replace_hw_filter label.
> 
> Fixes: ec2507d2a306 ("net/sched: cls_matchall: Fix error path")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


