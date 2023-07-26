Return-Path: <netdev+bounces-21376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F317636FC
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AEA281EAC
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C910C148;
	Wed, 26 Jul 2023 13:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48502BE58
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:00:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2104.outbound.protection.outlook.com [40.107.92.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F72D43;
	Wed, 26 Jul 2023 06:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jK9gRugKJ1QPQZau4GeLyfmCJZk4jH8FpCk8c98FKCVUozdrAz3PLRD8Vry/k5N94WR0tFfBwBebhWKA4N9At3qr111l7iWXkIvF+iua5lL+qhF7as0PVPeaI1q9WoqRh6NxzrVdk0V+yn9UZxrGq943hlqu8jsF9PoAEyNWr0d34monWWR6K51TAy1ZTHzpvmAvJYCnALTRJvW1v0780AqKGZ6cBi6iTPPntS6IEORWlf99KCVcX4ysQA9bKFPpARDUzbaUKm+WLnz6vSuBcBtst2BF/K5ZR9LZm3IuP442YvcLL+n/BhRpte2t1LwBU9AyLUoebW8exOUWZ2g5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Voptjx7lRQbMWYmTnsum7Q2VgTuv4H4D06PJIBykhRY=;
 b=DHqiQDyEXRppFqbjxmxqQBoQjqAi1B4GazwNE4afSZUtYbLlIj26hx09yunFh+RPginoeezpk7KIZRsm7ugsdlonML9qKh7oHj15NQ/9cruDZLEUUrtbRzXeJIaVPTlVn3l9YvAAIeVcR9u5mqWM1frl3FoZU4+S5ojzi+973F6siXpxEyaGNB+Zz7iNPGYdBZ5Kbdlxz/OzWaDKpJsORGcF1oSL/+5JMGIY4KcbssKEWs/krDu+Mm4G22e1KN1kLESHBVw2lyLCepGfiEzzWwo4vVjAcOMZs9cv+BJTlzw0hGZIbyeQN5kNwauA2Qzf4Ptp+kbtflcXYK4kq04raQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Voptjx7lRQbMWYmTnsum7Q2VgTuv4H4D06PJIBykhRY=;
 b=KbRHknFpxncFXBJbXMyhgjcSemmg8EjYps9S58sW4cKGlqzlDdQl3smx++D8Rnjr3tYaM4S7M6GFN1XJzcK4RbdDgSODo8zYfzpTbm1xNq6T1Xr2nW/YHsohf8ghGq2140Yesxh83dGBKObeHj9UgVvNTNhlJJnup02eB4Mxh8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5427.namprd13.prod.outlook.com (2603:10b6:a03:425::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 26 Jul
 2023 13:00:43 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 13:00:43 +0000
Date: Wed, 26 Jul 2023 15:00:37 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	dccp@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] dccp: Allocate enough data in
 ccid_get_builtin_ccids()
Message-ID: <ZMEY9aPRSpiy+qie@corigine.com>
References: <35ed2523-49ee-4e2b-b50d-38508f74f93f@moroto.mountain>
 <ZMEX4VOYzz8IvRUQ@corigine.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMEX4VOYzz8IvRUQ@corigine.com>
X-ClientProxiedBy: AM0PR02CA0129.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::26) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: aac934da-6c40-4f06-ea1d-08db8dd851e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+2WjdRQrHx1cBHohE1JSJk86A9qpnAJ1bc+o39sWywvTGAoyVoGB3ZHwznXjSof4jeRBbn0h/bX/6TpvfB0LJLBbfZRaZs4rFQPlBz5bSEYIOUjlI8dutfCAZCiGSUY/w0sKbPDVgSELR6xanHPhwWjsHyQ5tLqKQQah9U3V1k77QZqHnr5OsCF3eOQOsZXTnk1SIWoaI2ZIrzhuSvf65NPjhuTs5q/VqAU9KHDSQ4LpE4PTb91YzdqIw/BCSUleRVrumTOXz61bD9OQlTED5KLDayZkn/seQMEppSXUJpzikkTp7tno8rS3WTEmsVB4kJKdNb3Xb7bG4Cn91oVHEax5DttE2ngNPGNd9D57Mdk0+ybvWdztk9k1cGZsG27abmm9GT+ijoh3ShEbqiTa/cxkVzXSH5S7L9y0kWbJvsXKSqvIeSqxFKUMS7tcbVyka0tfQ9coSa3XgxIbG7xi7Ctd9CfmO8+aFOJGmZ7aeRCq0pTpFalRgFtYk6r0goJbBN2qfzDrYtNNcg6AMWtarxKoHS0x102LvKR3pLgKt1DGHXwqBFFHYdskxlb4R7+IRXIHXnaA1UcjY8gUGBzGV0wIm9b4b4+B5/o/XIupvAY3WtYj6r3/UFNsLkbSnSH6c5jihcLZ7AoFG6SE63g+Jg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39850400004)(366004)(376002)(451199021)(478600001)(6486002)(6512007)(54906003)(6666004)(6506007)(86362001)(83380400001)(2906002)(44832011)(36756003)(2616005)(186003)(66556008)(38100700002)(66476007)(8936002)(5660300002)(41300700001)(66946007)(8676002)(4326008)(6916009)(316002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aZCuoll8gPEfvm3OnwP7QAZtAjhr+tqOCNwzRciJ212PKTB6wljKZYPx5ZY5?=
 =?us-ascii?Q?Rj8AM6vGNPTk8LZgnJpK9R9SIWHM6zDiGTR5t4rsbGtyZL7p/91KNKFMGXH4?=
 =?us-ascii?Q?d6ffQndVe6zIb227cgXZKlxH3nkCxX/p6F6FmfIyTZm7lz2//eOAH/2bGLMB?=
 =?us-ascii?Q?8uMkx2VyB1nUTcIY8s9xOD6itIIwPmMV3ZHazlHF0k/GhgXr2eJw9eOHHOil?=
 =?us-ascii?Q?q+i7lVni30+Ym3WqAvchfj4LAz4tepgblYzoVuF3gXRV9h9p35jsOjG/9kPq?=
 =?us-ascii?Q?egcnTsNpcYT7N4zb+TppisHTIN7u81h6cGKfcnQx2JWHq6SUVcfnETnOfcit?=
 =?us-ascii?Q?WlWm4Vjod2I7Kw6a6swPdGarFoLNpKuG1AexEL6TTE0ELYdR1/iZqVyYQE/X?=
 =?us-ascii?Q?wDe5tNYNQx05K8gkjbWdhb9sqXGQup4iYYkzDtI+/rnuSumcY9z/0/8UMS2X?=
 =?us-ascii?Q?nRL7hlK/Uw1R75Y6M7R1drlmW5xW3Dq+5yRP/H+qN1ONNhSb3F8tHKjKBgPB?=
 =?us-ascii?Q?xMtgrcBIX2zlNLZN4o7FpGZdek6FhyCviOCeQYD/MGua+vW/jmInm17zH3Fy?=
 =?us-ascii?Q?BuShGNZfrjen2U9U94NmGi66W4EN7xS3bItsHFU5C/psL7Xfbu35cL5n3BPj?=
 =?us-ascii?Q?4wQiI6x7yhghwlzqvzShNen4WJa6BJmDtEX63A272JVGpovhdUsImC2o+CKv?=
 =?us-ascii?Q?o/P+e3mCgsb+hM4bqrFFN6WSHtx72/P/p84WV3scRUS3UIt604aBEo+CzLXM?=
 =?us-ascii?Q?j+p9/u1Heg0pjlA7XH0ZLW8lxXpY8Gvw6kcxDp79GmB9v0jkDlCfoM2yb+r5?=
 =?us-ascii?Q?7v1aK1B9OATOs9MIl36t+15IfvQOjGDpVjomrpBPqHjlGX9ClNJnktq1SpD4?=
 =?us-ascii?Q?VwClwmHU6/XHurZGv+ekOhVCHVjeiuPjIVy52VEl6rShJ729yfJqCxMsDjrY?=
 =?us-ascii?Q?uR4bm1D24DPmolpPwLY/ucK25suVF3XymxbMoUPnja6bttaFhgpNd3Ilw29u?=
 =?us-ascii?Q?QPUMFJn1tLN0m3zsSlmWpt1d/fL8xt3kfHwl6EZKBd4JYn5nAJyDbWLn8PdQ?=
 =?us-ascii?Q?rQRZfWyirHCwX/IfksHiaY9ix5qTAFV0NwbIPc5o7MF3je/HOM2iS5eKzAxy?=
 =?us-ascii?Q?vkczdCgcJQpsn4/jM1xB6qy7+O6a6DXOw5/zdM/F4ESQBkvW/VcA7mNKBjcL?=
 =?us-ascii?Q?IF1aR0hPIG7ZYuuUnqLiCL1wRxxyDGkHWZ3+Iq8oiN14SGwCQIJnweH/62WJ?=
 =?us-ascii?Q?pyp4TkzBiBt5E5lsJYBjevP/JCvB4/PvPMe1e6VIzcTUqfv+QSjJic4blfRW?=
 =?us-ascii?Q?R7UbVrBpdpLZ+rdI+MhI6fepYqXEh3sB5aFMu+1om6D8DJuhwbf9Z35gmGa3?=
 =?us-ascii?Q?lfmHBkPpq9Bn0rdwdND3vlYe5tltVQ4NFaBJlZxAlru6aRjhyPaurGfl1zgP?=
 =?us-ascii?Q?9fo188bSWMZ5oBuwjQZMY7tUyD7HdlxCODsFE92cT9LkBVf6UGovA3nhIHUg?=
 =?us-ascii?Q?hVFG+c5rypM0mrWwiAP+BvdxKaEwBjwT9mfL2OEUm1PUaFhfcsH2ko25dVgr?=
 =?us-ascii?Q?4RiSvF4rm1dA/HqRt8lL+3hgm83KTYzevUcJAKT+lOsxxAw1EIh18TcZFY0b?=
 =?us-ascii?Q?QTeBClN3EmA+zsGsxZf7EKEHEMB/Dv7fiHL6M6W8qRJEUND6rN5AE8WP3GFW?=
 =?us-ascii?Q?QiLFTg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac934da-6c40-4f06-ea1d-08db8dd851e2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:00:43.0479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3fdKyr4JhoobELWRKszZ3gxoY23zNdWCEVHL+dTQTGpfwiCuSHu9hWSoj4IFMDT5YOYr/LZL4wzE7djfUL2UH/ffetAjB4iaiht8m4XNkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5427
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 02:56:01PM +0200, Simon Horman wrote:
> On Wed, Jul 26, 2023 at 01:47:02PM +0300, Dan Carpenter wrote:
> > This is allocating the ARRAY_SIZE() instead of the number of bytes.  The
> > array size is 1 or 2 depending on the .config and it should allocate
> > 8 or 16 bytes instead.
> > 
> > Fixes: ddebc973c56b ("dccp: Lockless integration of CCID congestion-control plugins")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Sorry, I was a bit hasty there.

> > --- a/net/dccp/ccid.c
> > +++ b/net/dccp/ccid.c
> > @@ -48,7 +48,8 @@ bool ccid_support_check(u8 const *ccid_array, u8 array_len)
> >   */
> >  int ccid_get_builtin_ccids(u8 **ccid_array, u8 *array_len)
> >  {
> > -       *ccid_array = kmalloc(ARRAY_SIZE(ccids), gfp_any());
> > +       *ccid_array = kmalloc_array(ARRAY_SIZE(ccids), sizeof(*ccid_array),
> > +                                   gfp_any());

The type of *ccid_array is u8.
But shouldn't this be something more like sizeof(struct ccid_operations)
or sizeof(ccids[0]) ?

> >         if (*ccid_array == NULL)
> >                 return -ENOBUFS;

