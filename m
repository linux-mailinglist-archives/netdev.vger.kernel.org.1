Return-Path: <netdev+bounces-21901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC0A765307
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2621C21602
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E11641B;
	Thu, 27 Jul 2023 11:59:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0CBA4B
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:59:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF42272A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDpGGf3XDWlr1AUCe0EYOPHPaXNZ4FogdJWul37sgnhaS9tgjeiygasjG/Qz6K1sAbhoK/1wAJJP3AvjZ98KkYrv3rz1b0itBwZNGe/88EM6skd1eOyP2VrZElnxEqWIxzHmGLxLUayXSxlWcTQuN+bcFdCpMlkSfWC7n0tITgsO6r9IhflsqJTB9CeXAmgs24fItCPD2ysWKG6ObxVm04fW8p1t4M8Dg+uiU2Xmx1C16Uq1Yu89gXnADC+ikrTjKlfSjEWK3a3g7oFRj7VnuWsUp+bJl5F3WRiO/sinHjOs66BxpJfuH1DRfas1L8NlGa07eFmpYiGt7ZBiKFk/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA0ztFhZBxDUCGU9YVSDiDz+mMx9ETbNNDpf6nnU+Vo=;
 b=N4DFQoYwqo2oki0ZiG+MBsiHI8ABS57oyrdcLFl/h8Z5DhdmE7mE6QdSxDE6XVLBc8Ze8gS3pkzppmccVT8oaa98RZJJegqZfJxgBzBUHIUChvA4PDWwLDvJJC6J4w6KJhv9nEDrKefxdeNyKQARPPavrLxrgAA15GMRUkfCJ2hkWOY+8BxbWd8DzWP0TCmYfurWcVmDVDjaDPcH3ju3t1vFlG4zixO22K5y7Oswujo/Y1/u58vj8CtWcKz722inCSOpcbR5FBRxh5hNIA/PdEMbosSigmDJZ516XtET06lnrAslKeiDUBgTw5cGmRxXFCYiflO0RZtXvkmEFj9Elg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA0ztFhZBxDUCGU9YVSDiDz+mMx9ETbNNDpf6nnU+Vo=;
 b=rH0SiXwMAl6+bYH+BzbBm0pKtoGx+R698A2wK+yrL1NoROt5WfC3vLauu3dY3lAovRbwPZNXWFlXI948gh3bC+gOPRly76rGH4HuUFt9qLDSfLAI4gWRq9Sli6/ME7qAg9EI2N83kBm9JK/nWjXr0Mhi35oUN90NfYW0zCGaa70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DS7PR13MB4734.namprd13.prod.outlook.com (2603:10b6:5:3a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:59:15 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:59:15 +0000
Date: Thu, 27 Jul 2023 13:59:10 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	David Miller <davem@davemloft.net>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/1] qed: Fix scheduling in a tasklet while getting stats
Message-ID: <ZMJcDvPrz1pEBPft@corigine.com>
References: <20230726171930.1632710-1-khorenko@virtuozzo.com>
 <20230726171930.1632710-2-khorenko@virtuozzo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726171930.1632710-2-khorenko@virtuozzo.com>
X-ClientProxiedBy: AS4P190CA0031.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DS7PR13MB4734:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a78748-6943-4e60-4178-08db8e98e62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iYuTDOzf/oo0xnjHFxjjbORhPHdPk8wnzaqPUw3Y8Dy8Fq4/8TnyIWvgmIB6fxLac84xU4ehqPlEKm9sttQIzf5RxUYWO12lcIxGzJ11ro4nak2Hq1YYDrWi8RID0kL+e42hEIdsOo2YHbucCJNUOiI5aBt3iXGwURSXHd64Cq7o3AAQPNzP83I6fbMJOBTmrukMLZ4xAU6iDbbWnu7KoPsDKu3+uus3xfngQ3WOkjdmsU1+FQIOSTNT2MXjT3EFtJ/SCfH5Y5oO5gyPiqVcHKAB1ObDOsZu0bsfLR/u5XrxbjGGOOm+LKObW8LotIIbZxn9fmLa6c74whGk7fLBSTZnJccSntwD+JlOvx5QgNGnVsa1rPCZ8e8yomXq6UDQQPCj8pCFvHHm1fmyMoNI5DjmfdXRzjOiiwMBhTFAl3jDdxq5R64FLlHyMU325dP3UpAqZ5AofqDEjP3EmJsyPRg5tHsLVchyfntdUG3dHZZ3y5TURgJiKQ3j8l37CpwjC9HeOzRxs2ZvQevKYATlvS+aKO2Bvjm/2KefGJyV/yBJfxW4hqPxb2mKT5tWHRVjzjJ6xEsH8sgcOvSxML1E4cey0djtoTyKsvUt6qPS9R8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(346002)(396003)(136003)(376002)(451199021)(2906002)(41300700001)(44832011)(316002)(8676002)(8936002)(5660300002)(36756003)(86362001)(6512007)(6506007)(6486002)(478600001)(6666004)(83380400001)(186003)(2616005)(38100700002)(66476007)(66556008)(66946007)(4326008)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MD/K/GJFn7eLH88070P0ljJSxqAcovsdKaSumJFHmGDbjnV4f7FvQE6trH9h?=
 =?us-ascii?Q?dqDsHo7BtYxMa8dA3tfwX/THDexsQfS6eMykaNrRM80huIsdcroCZcDnxg1E?=
 =?us-ascii?Q?WFx3oNnJxrMvFnLHAvHmlbSQmfu+MSrMcp7y0gB5yPNCEvX57XsRzfTxRzvx?=
 =?us-ascii?Q?b0yfPr35D5oD4AcBHiCrurasGY0x4Aakyie+Hyd9F1Sv/C4jcPGbrH2bQQ0H?=
 =?us-ascii?Q?uMHxrIUC93ZMtz1ah2DwAeAZ5t/VwK7nFsuxN+o+QRyaQ6nf0Gq5NinMQqqa?=
 =?us-ascii?Q?X14bi4RSupiYkTxIK0qB5nmwUT+a0N1VTwoFCHGEIargW203XH/0ppQGxBtL?=
 =?us-ascii?Q?GsrVC1wJKoEfNGE45tvzgxmLRWM0tXSO4a1BCjppRVykvUZ5Dgy4SyMVuGbW?=
 =?us-ascii?Q?3t9wvMBB1EjrQQ38Wh7juDqXVl9ZUtM13ZtF1aq16WwSJa9Ll6lUsdIFro8Y?=
 =?us-ascii?Q?yWojllytQxB9RTmGfGo2Rmg3ZKACmlga8D64ixAyRxz5LahvyeLjyfTa2M1E?=
 =?us-ascii?Q?T3fy79UvOrAFT/CC0olx/YC1CICrS85yDCfdC0SiZ6LgQYqa7THArUFlPPCe?=
 =?us-ascii?Q?+DJZpZOverf1A/m+WAWeAXDBjIsSxraSc3tRXwJuEmEuxv46ZzCNYoQf260w?=
 =?us-ascii?Q?uPF5POG5q9uOw5VILNXFHx6LTb/WaPUuDwirpQ5T64b3ZlzepYbXDCif8PMw?=
 =?us-ascii?Q?sxgnDVbvXNdNFsOTAI9hn3+gBuYXDlYVe2G8OSfOiZ0OII9uhbFwfhZoFQJp?=
 =?us-ascii?Q?U2eS4SxTRQTaOTbBUlmOZLmTrKHveSws73tn3hR8a/hmrip0fgrwd3Glcb7N?=
 =?us-ascii?Q?NNnkGgWnEZWBWNanjXaK/jTs4ZVYrejHH/E1tayWH6TJonJnzpAZinySp87d?=
 =?us-ascii?Q?o6ThJEIJf4Bjt1ScZcflrzyx6osQT3CUIIzcuswDC4G+HzvDRZ8IOg2kGECj?=
 =?us-ascii?Q?MEcZuN9aTpV7vq0YccCd9ZRFHrozvgJXTe/OVS5xjP2uq2Z2bC1qohbJVm5c?=
 =?us-ascii?Q?oGKMaUDgpH0fwbZdn01WSw523M/IlhRl1sQLnJvCl0m33yY4am3qYRAsYtut?=
 =?us-ascii?Q?MrTxzE19e4S03nhoAZftYA7pJe6h7w0/Rvqz3TMMto6C2DiAKHZxXKxXwn5d?=
 =?us-ascii?Q?MNZMw2Pp5QVbHasOTT5i0KuCwM5p8rA8xMb4j3Vb6edVtigSH0Z82nigRRFG?=
 =?us-ascii?Q?xhN3mQ6+CEsswraJNgAErpEAT1jSlxc75ZDdjBRf8nBVsUuN+/kM6oiD8lO9?=
 =?us-ascii?Q?OmGWbmeLaac95Olrn8v4bCCPvENK5CRIuXo3c9M8RtR+l6aCR+EfE+T2H00B?=
 =?us-ascii?Q?3Cpu3H3ebhd+arbqWRDdgSWBHK7Af+5yuA+RAaRwlAXxCHUUHFDGX1qgN7Wt?=
 =?us-ascii?Q?cf0CTbnqEA8oQFUf6KXsZ34bPUN3MKyYhYK2Gkr5t/cpkvduowsCpu3tuCot?=
 =?us-ascii?Q?buh8GgXAGrIIlMWT7u6sIbALk8mP88Wn815eHa8VNCW739SbtQNoXZ2OdWBr?=
 =?us-ascii?Q?5RAZnjc0tlr1G3tMXvPd5uuJuzsZ092S2rvgkrGG1tzOvIgVwfUgKlrP4F77?=
 =?us-ascii?Q?F5Y1bCl2xMq0bPHy26ml0dOEP95LlZGIVtZ4QuhoY77atDbzE0lk6LDUEPyR?=
 =?us-ascii?Q?XTro7s6mMEn0TNmyLMSTrZG0I6DdY36dWVuUPeOZUiVHQUOaoP2aCcXnroeD?=
 =?us-ascii?Q?445n5A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a78748-6943-4e60-4178-08db8e98e62e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:59:15.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XclNGAL3sQOnfuXe34m5UGT4nhdN0amLXfWvww7eshiWpf4EFmzA8hvtD+Kgo/8+2MpIb4hs7SA9r+0LtwMzrkh2C6Tk04dprrLvppeCho8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4734
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 08:19:30PM +0300, Konstantin Khorenko wrote:

...

> diff --git a/drivers/net/ethernet/qlogic/qed/qed_iscsi.h b/drivers/net/ethernet/qlogic/qed/qed_iscsi.h
> index dec2b00259d4..7d8d6ad7faa9 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_iscsi.h
> +++ b/drivers/net/ethernet/qlogic/qed/qed_iscsi.h
> @@ -43,7 +43,8 @@ void qed_iscsi_free(struct qed_hwfn *p_hwfn);
>   * Return: Void.
>   */
>  void qed_get_protocol_stats_iscsi(struct qed_dev *cdev,
> -				  struct qed_mcp_iscsi_stats *stats);
> +				  struct qed_mcp_iscsi_stats *stats,
> +				  bool is_atomic);

Hi Konstantin,

Please add is_atomic to the kernel doc for qed_get_protocol_stats_iscsi,
which is immediately above this function declaration.

>  #else /* IS_ENABLED(CONFIG_QED_ISCSI) */
>  static inline int qed_iscsi_alloc(struct qed_hwfn *p_hwfn)
>  {
> @@ -56,7 +57,8 @@ static inline void qed_iscsi_free(struct qed_hwfn *p_hwfn) {}
>  
>  static inline void
>  qed_get_protocol_stats_iscsi(struct qed_dev *cdev,
> -			     struct qed_mcp_iscsi_stats *stats) {}
> +			     struct qed_mcp_iscsi_stats *stats,
> +			     bool is_atomic) {}
>  #endif /* IS_ENABLED(CONFIG_QED_ISCSI) */
>  
>  #endif

-- 
pw-bot: changes-requested

