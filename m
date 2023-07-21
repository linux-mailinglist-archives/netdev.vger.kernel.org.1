Return-Path: <netdev+bounces-19836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DAC75C8A6
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8FA1C216AE
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2C1EA80;
	Fri, 21 Jul 2023 13:56:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF941ED22
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:56:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10713C0F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xxkrf63tt+fiJ+uX1Jb2J1c9dZQey+S2LIrjrkCC/qryFqQ5o8/RcZCK/q16Ts46K5T5iWfkTEKFhUvp/zr0ikGsO/PWmqh+Wq4/nblLT124g1/vV0YhI0VaqdHvJxnbflv3rJxPd2l7zb7goCpk8WUQuwMl8tZo4GcMRmU9Lx0Uujx1Re1B+RfFa4A3fX10VbQiYIGCyAdK84oLS4zavLDIH8jXgrkb9rm+OLsoKTDVnHvgTSVWUua5dE2T7cuX6xLJEY/Wqgb8lFprAB+DIv1uzY/EhqxeLgCDaCZ8tgVuf2SaR+jB3ZWmIEuOsFg8CNBIR6FW9zeEvjUA9fALug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UyJa2aD8FgA3mVFjzcxIsQM5bcs/Jv9r3K2Nlvia+s=;
 b=jc0sVXaJFmOxgP7sFfCNHEiQ1hjGCJxgf+NztCkU4BKPtw4UtacYvaDHGMJbrdgfZiX6DJ+hg+hMFvR9r+VgKOAGXqpirnPmjGCxyp42VoSVJcY+4Rk2P9eii19EqAD8/uV09Pgj2jb6e/5N9GSnJ7CrylFH/RAVeL87uxzZKbrTAGOsRgL4l6BJX9DTzHoa4p+XHFIvPZvaT2xowyO355cTeDwKIQtHUxQPZgfv3yIwQQbf/y52zb58sg+rh5eZqQmkgQgopNs3On9Fx42oZ5phBsoJSSNvTzPEAJ7VsXmTGIvyJ/e5ScAQ+FEt4+/o3WB1etIqGqnVdCStRNx/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UyJa2aD8FgA3mVFjzcxIsQM5bcs/Jv9r3K2Nlvia+s=;
 b=uWtUxyd1JGrGCzcM+gcbxpm6DSXX8VxNP5Y6FaLlf3vOiaouKeVhgHdz5jZwF/RuzQRoaL10Dui1C10R92+6vlKXjnv0rfgH3CEXuS1djYH3arLUwAJ98IAioJ+Fr1LRzBa11slI83cilvsb2GqWW9/p3jsoyKm/WCn2eLzml3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5674.namprd13.prod.outlook.com (2603:10b6:a03:401::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 13:55:13 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 13:55:13 +0000
Date: Fri, 21 Jul 2023 14:55:05 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: Chris Snook <chris.snook@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] ethernet: atheros: fix return value check in
 atl1c_tso_csum()
Message-ID: <ZLqOOX4hSZHSR7g5@corigine.com>
References: <20230720144208.39170-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720144208.39170-1-ruc_gongyuanjun@163.com>
X-ClientProxiedBy: LO4P123CA0671.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd26cc8-53b3-4737-5ab1-08db89f21af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	buxWJYVCNivcX4uaJoeX0JITEKN/l5wreInDIJaJYkTmISzaIzcI1sH80EEHolB4UYXh8n/0DXftoA61Rr0dkvZd7C1s4Ds+4idukkwjWlY8sym6ct6N1umWZHXyCMT/S1Q02skBX+cHMr78qeBgTcqHebbaDssX0fPr6qRz64uaDXlDM1PKa/8tc7tZXsdpEPCsjCcs3No1Urux+3+mFzeAZmM6s0xiRAdgfvs62/jVWx2uAn4QaJEu7PXjGUEH/3PHqPdQtZG4DpbQhfIsR/F6Qw66pwcZEX20apzzp5MVuLMl8jxJdIX0l+PJ0AdKU27A60L53QFGnjtTj09WUQrcml7CnB63f1pJIW0qD+DogBBVwOzTPAQSW846c0mtg4yy9veAYh4R08ipwZpmR+9QmiyLkM0iSWIqGNIuK2OEpoE8eQKFuiHyktRTtfc4BnIFElEpuY/Q0mI2dhwZSz4vLGpIzY0PxBoMfHSrH6OdSFTsi1bgwuhs+ibRwiY86wUBVUitaRuORPAOmvffNVbMXqzYMN1qR4KMLzQwmgpHbQoAJUnUPnn0cmIRvXrEgBCLGX2XRz4dvXjiAs56phGDMvJGt74BTQ2IwGeQyKU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(346002)(136003)(396003)(451199021)(66476007)(36756003)(86362001)(6486002)(6666004)(54906003)(66946007)(478600001)(66556008)(6916009)(4326008)(26005)(6506007)(55236004)(6512007)(8936002)(4744005)(2906002)(41300700001)(8676002)(44832011)(5660300002)(316002)(38100700002)(2616005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?isXnW2uM8wPEB01kyyMzNsbkbZ3mcovkn3TkN0mdl7xC0PbW0PUxUZwCOInZ?=
 =?us-ascii?Q?CJNdm1r1WKnotiKzfrnQw8CSLZsbMXniJpPCl3BoMGr8vAHG5y0NYCbfMnKj?=
 =?us-ascii?Q?mRcNrFyW4GjNjSC4nFP+6f3fgssK0EdCzWgHhmUhtSLcwN89bXSvAAGc5Cjh?=
 =?us-ascii?Q?il/LiQAKr65PFykIVtWmADI5iLZG0O0iVzCH3dXZ9vKDDlq04/gHsm+pPFUr?=
 =?us-ascii?Q?Evjx8LymgW1yu9yg+UVVsjSFMk3Hkccun/WxmUhDZEMxj4dzKoerCqrPzLLV?=
 =?us-ascii?Q?TDdCu0aJnh7dU2Y7aznw86MMrHP8BAyiGkM3EjuePqUJl9W7X60dvVOIOqmE?=
 =?us-ascii?Q?aW6WFwN03KvVRihoQK3rTVCVMnmOmOUeUn+r2k1Q9ZhMwfoqdnRiNyZ51fRN?=
 =?us-ascii?Q?ApTQ1+0cHjzl61UbbR9mvVZ3cEa+zEfKpLfckj3XuT17Xb744J/VLNx1++uq?=
 =?us-ascii?Q?vwosloXIMzo4kdMlKRHGezmGQo+BEbnz89/sXE7v4lomHehSbu5NOPxYBHPn?=
 =?us-ascii?Q?rX/z8Yg6SWImxgE4Ye388Eafmrdd5AkSPf1L20BZQ+LOzov5iOzY4Ya2kJqi?=
 =?us-ascii?Q?/XptBtcypqc6uFpL2Ge0spIilIV2Y9uRnnynEgrWdPwQwsG3xgaTbVVy1Do1?=
 =?us-ascii?Q?1WpQhGBL5zUWq0E/qnsyD9XL51WKi8+/qvlnRTpKlMCREGe92aTHqG/8TPe7?=
 =?us-ascii?Q?p7SVIY2xiKrkPWxhQg/C/uyq0vCUpmzh1U9FqftPeEU7n3rC/Z4kp5Ah/Uh8?=
 =?us-ascii?Q?udSeaDchuEUVZxYTsUVJesIM7PtomePJqtlM2LnDXNsaoBqAnYVTqhW0dJas?=
 =?us-ascii?Q?BTXt5W7bbnyFSLSpEmvj+nZFSUFfZi29bHPQz703xpgKaqIRNZH+EWouy8BV?=
 =?us-ascii?Q?RlWDPxwdilkxmkRu78crczbuh4lnUJCQK/Yqo1gdi9ObZKxfVLiV1S5lPdwT?=
 =?us-ascii?Q?0s02SQ9ZJGYop7c7cTTj+gfh9LVUvMqfqKOxuctp+6fP+DW6EC/r4uWXpvdR?=
 =?us-ascii?Q?knZojdUi/5lDzw0HUq+t703aKzJiwD6Gcgm62QnHblOiEBzK4oFUpaxM1YvX?=
 =?us-ascii?Q?KzPd1DM6D9fDp24SdjZijaolMvxxx9nP4iheUWufDsj7MgT4z516uOpztUcX?=
 =?us-ascii?Q?9mYERH1wsaxfalgZQVegDB4NqGniVaofjyMJRacaDUz1yNMsrYPaWsiH4bbR?=
 =?us-ascii?Q?lcYNIr2TwxLnI1VrNIV50kP+piQE1sMsn2n1MFwNP/T61/FmPKHk8P7fHoxC?=
 =?us-ascii?Q?vT4+12RbrIU5CgywgJrQXyLTx5DXxuefMYf5xLEmhqK5m+KQ2W8A595AuWQ1?=
 =?us-ascii?Q?UpWZ72glmA3V/FwGCwj1gX1wgpWIF8jgsIt+cqzHVxQdgsjReqW08px4llGZ?=
 =?us-ascii?Q?zlR8+xFwU2LYd5fPGjXhNTiuZGBVXwUS2onrWxB63nIZEyFJZdE7x5VQDZFN?=
 =?us-ascii?Q?oaqzE7oYCSIYqzC5u20AFzN2+4+oH5kXLg5wu7WTx/TI6t8tzPcCbxQUsnDF?=
 =?us-ascii?Q?PVtFOOl/UpIzpw9j5+AkSw4xJCM9YFrq6/Rmwelep9BKmY4wG8QAgpuSWgg2?=
 =?us-ascii?Q?V0xB8NYPFbm7cqqHOW+irFlcbo7rrYyd0I6KP/4B2MXgLJf5TMqNmNK2aNf1?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd26cc8-53b3-4737-5ab1-08db89f21af4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:55:13.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3a4wP4oJ1emjLeOFg532uEz2bsgm2ouWsPK7nf6ojl0S8008f6dj2Gwwsj4g9sBdCAxeZNNRf2DkpoL043PMs/JpclNxu92/yXxGk0yK4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5674
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:42:08PM +0800, Yuanjun Gong wrote:
> in atl1c_tso_csum, it should check the return value of pskb_trim(),
> and return an error code if an unexpected value is returned
> by pskb_trim().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


