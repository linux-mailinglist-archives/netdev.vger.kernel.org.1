Return-Path: <netdev+bounces-237862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DB4C50F83
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D3F3A987D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840AD2DC348;
	Wed, 12 Nov 2025 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q+brhiHo"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24E2D9797;
	Wed, 12 Nov 2025 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932965; cv=fail; b=JXd9YUrsGNwOk8BdJmItQ+c9obi4an8hQnrDGvUDSb/kFjw+EaPCP2WB9bXzTtxNXx779gHkbWlRUPnc/gBi0uAyq5X8X7NYfUPTwbPw1N9cuA0GVQl4PMVzR959sX9VnQeaZHwbvBVMi2c9ZwsC+wqxcaO4iuwq2q/bD2exN0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932965; c=relaxed/simple;
	bh=BEexXEbNxl1DLaC4CH7VtCU3QVUg7GFfIy0SuU7vLgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iayP3FhWXeuARPH9dvq5LH/wUKoSPSIlEieJve9lBzOB0b4jV5/2xOYYn0uUK3z7H6C5Zw9Q7kjqd4iWtkzAtSiqqVQwCbCqsIw/6FbeNJjXCORcgKBQ2WoV9THIJTp/GUNoIpm9nwpc3PqZ6NEL6QwdriI6A6yPvwzayS4iHFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q+brhiHo; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5PJLfJ8qkBkdhNWs1cpJ0aNNX0fR0WVZFF+SmeCCsK8aSUlpotvUfdYpU9pnOPA+4OE7IxpxxDR2nNhr1O2nA/Jc5Q3YKxP1RGKGP407GTwbqOmmfEa9W8L3dkOAXRXEP/6454+99CNUGcU1nCAWczVyMzyf8qwCux1TXLO56QcQqO4UaFYUs0zz791DwILQc9UakRGkyLfKEs44S4mw1/U56I7dnG2O3j1QFHMckcaz41qjk8L2bh9HC68+lq4rjwbHDg8fioyN2jNyPRa2vut6361DaMmMUSAGUmr6GJzh+lrWnhvPop3+SYKUlNNlNNSESyavegyPtYfaOpWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDGu2tojwPneZu16bKFCc8jEd32FU/WaAJVxQ0X9uHk=;
 b=IcP0fz8qAsv3UXdXUM9v8cQdY2+5A34jMQ+3JszT3nPgBOsmewB/pWrMBI94QlSptnXMFe8lAR86q58js68zczGssYwljmK0ZhJ+6HBokmom30yNuPpWDYafcuLIHl4ZEWGlpMT/4RmwpbyHj94JSLIVC+j8Taig7zoShXAHDxHORTRpp2H8kvYNz2rxfC0JK14n77+bKTnX1Ff98bUv66328QtjD4nBQMW1wg/xdLaw61DBOCqm6lb9X4SNOQmtCLLCS5H1QoE86BcjdSa4yvWo2PH8QULFFbbzhZazS5c4WuRt2O6vcofu4ysOk2k+32fVcQTMEs51+hNc7xaLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDGu2tojwPneZu16bKFCc8jEd32FU/WaAJVxQ0X9uHk=;
 b=q+brhiHovyiQ7TdIVcPN6KtI1c3t9EsZNtv3+28WsbOeqjF6vxdJGV0B1QTb8QaKQ5aj+eu2/Vj+40VnKrzI1f6VyY+lgbMfTX3PobNS0Ue9DbSstcIHX/rsS216KVIZM3Z+It1FiQPtJwwNpc4d083T+sq+usH2l/jBmkERXHUImQjVXNiC0y7oelG1kos2AAaxCjZFKkOVSDpu+qt1+K7uJ2O7e892bl8nAqb9k1SIcm6l7Y/ISnkeRSn5j4PdqUMJeJ3UdrbJ1LqiIKiVssFqNesAeMdNOBRPQj0w007K0q+wNXZnlQrjfVkO/CU2EIQXD1neeWQiHTQH9oufig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:35:57 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:35:57 +0000
Date: Wed, 12 Nov 2025 09:35:47 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: petrm@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] mlxsw: spectrum: Fix memory leak in
 mlxsw_sp_flower_stats()
Message-ID: <aRQ408dXG888TKQo@shredder>
References: <20251112052114.1591695-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112052114.1591695-1-zilin@seu.edu.cn>
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b1fc5b-03d4-4e39-4c48-08de21be1e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y3Ny0quEA66WC0Wykuxv1L5GsLXnhlTq/i+eP0Zz5KG5NrOxoNzW1Y7eBFvj?=
 =?us-ascii?Q?V54hsJj35CQENob08RVXKdF4tRwWMXeLxYEiZ/Cmm+h+MPkIhoZYLs9f+bJO?=
 =?us-ascii?Q?OO3ZYoEVQf7EIsQUtBkoS/uNoMb2NO6RyLyMLrvK4r6v7AfSMnRWLGO6TWJp?=
 =?us-ascii?Q?lu/4C0gZZkzFk7UOwLiLMZkHhFX5KCONug5r+yeHX/X9L9UN8F24C1kvfIh6?=
 =?us-ascii?Q?QQFFwaxgft4u2YEMQZ2D2PWETZk8u6E8Qwv7NnrYM0qz0SNqNZC1RxWRj8Af?=
 =?us-ascii?Q?pax+eBg4KgQCefuk74LPe22sl1qm8yznaro74EObcO0SjvyjUYdtLLdkA0vt?=
 =?us-ascii?Q?YDsYRKlrBnj3LIKxB0cpkLpgRgpFGeXJC+7n1Z/AfCumt3/qfHX7n8Stuh69?=
 =?us-ascii?Q?N2r96aq8VDFaHwOFim+x2bV9sT0jga2No4hPb90Q0YWo+ENo+67kwEb7mIL2?=
 =?us-ascii?Q?hleAaQAix8TmB9BJLrVFw062iu6txZllF8XKwJ83VZ9r+M6Rmv0uX6pBQi4H?=
 =?us-ascii?Q?0TRmkj7S+RxxaxKhxp8ItvxnrKkbdhLFuw063mHEGXgg9G7m2T97EkIW/5zi?=
 =?us-ascii?Q?gC83JqrkpHHP0J8M47oih7Z6Sx1sbl00vQ8sJB7cQG7445O1yqwTx/YLAxR/?=
 =?us-ascii?Q?Bjx9nSs86qjOLCOIpt0KEeTry2CoLgJnFWZNu9uNFlwT/yrT33o0FHNrhtTw?=
 =?us-ascii?Q?QbafdxktjofhTajSSN+TQFShcGO3gyzEViWvPjGjXJP2uYbMI9c6QqGYvmqq?=
 =?us-ascii?Q?eucaaCRIMWFIrE0hYhVZRXFg/W5m7EOUIE7IJG/4hv79hrgiKPchqqPkPLge?=
 =?us-ascii?Q?o29Vcab3Upa0XBRlbg7Hw6nLT47uEc5SDSDoxN7sHprw+8WnhGH5IZjgqyjB?=
 =?us-ascii?Q?N1Lra8KlcgPA7yAXSq3lI744MPOCnwLAJRScUI1U0hU+pAOkBcer9KOdG2rE?=
 =?us-ascii?Q?RMJix4dygxBtd2luBYvThLj+5wAwkS+UjcBJhdw1lgKxlIkEtj+YSOiNtGhW?=
 =?us-ascii?Q?JWav1pOTW9Bse1aE8V5P8TJCZdbru/qdyktE7Fr2oygVzWTIQzh1jHkILhjv?=
 =?us-ascii?Q?ZhMt2y/xllR7872zH8cccxzSsk+ZSH8CL5vRca+SvHK4WtC0WpYotlIydTVC?=
 =?us-ascii?Q?r7OtsBMROdMuaLFSyBQHhUdiK73NpY3i0uz9Teaek+mvpiMUp1a1eYR3pUOK?=
 =?us-ascii?Q?oq8hau1DoHKkiNwDOroFY9GsXjqG+2OuZzAK8unvOkq6mXpmnt6hDzOgnB2n?=
 =?us-ascii?Q?Q21j86JBnntohfFlHQ2xqi3lIRCg+53MRM7IDTLsQ5PXPTj8iOz60NBWpC6k?=
 =?us-ascii?Q?FxmQGZbOye9n4c45lbKIQeBsJYS3BZICStIvoVvVXJJslFG3amyDNI62cgiS?=
 =?us-ascii?Q?uJ+BGJUyiW/mo/qwXlzCWQxmxy2q6r2FL7lzEIsxWEQvq9J8Q9uYsT9xqADr?=
 =?us-ascii?Q?SM0zaoyuTUzgzqti38Kn4hyKi34xSe8mZ/+iM6KaIHN4uPYx+uJ6nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YpkevpOYB/v1UdZlbDvt+2kOfrdtEbZ3JLcyv6qWKpGox9Pvc0EvQfN38Th2?=
 =?us-ascii?Q?DdnxqmfpBEK6ZJftRR7PNd0vmXU+NYDb3eF+WA2dhu5nHzKf/97FgnfdM6J6?=
 =?us-ascii?Q?0yvttkkx9cu1OFUvLYQe9i1SagXhfUiUy7UXKSRUZak1KTCf3aoiM5coxfSX?=
 =?us-ascii?Q?8UNwYx9v4T1xKpqwSBdioRkvacS6033DUZGp9+0Yf+DtATmyoxcBaB7UWlMs?=
 =?us-ascii?Q?qHS63lF4zAUwp5KeK8P205TpRSF7ekuX8jwjAPYlD2XuvsP4pqaZLIZmsxfb?=
 =?us-ascii?Q?Qd0NsvX1gdCqSAJrTf4Ja0Ol85O90d8ieNP0/B3Oais1s//Q23Mv35Md28Og?=
 =?us-ascii?Q?D4NJYRxECoU/rpbZVPtXTQi9gn6CGRJQpLQLYqSx40ln8VqIScVXAWUObnrV?=
 =?us-ascii?Q?zlI0iyHdjxt2tu2FFRagsxGrxH3z4ZkrHI3aIy1oXd+mvbSs9fOJhsCwyXej?=
 =?us-ascii?Q?DA8vXOIv6VCGiapxWXv1iYFvBGsGh4dq/3jNZReTOPvw6GDFNK3xTWRvzijc?=
 =?us-ascii?Q?AYmsf4iqYsMtNZb3UggVXi2YhmwYSCZLre2jQRvRlJg/nukBsH7/H1Kgq/P5?=
 =?us-ascii?Q?JO7Y4M1LV3WJaZNBjTT8F9ymo+1GJRcfZxBzmivZaW7xAj2o+kckLMwDceBk?=
 =?us-ascii?Q?2+oyJnWucdS4ZArChwfD4vG46xYhOA/OuABlJBDzo+I4UzTVdA2JtI+YjrrQ?=
 =?us-ascii?Q?mMdqN9TRnegCEfVt/yRb7yLvsbwwP5ccJzUhtfn2c8ksTf7v7+w9yO3TcUpg?=
 =?us-ascii?Q?/wghgTs9u5tRFfEAwjB9UiAl7YjBb9iqkQJkqd7ROeB62B6qL3DuLzxHrMsU?=
 =?us-ascii?Q?DrkbO2KCvC/mi6Ey3ARMur0lpUmcuxPfWkIlo31KdPsFBIZiAlx56D1iq4nT?=
 =?us-ascii?Q?1kSqDeAE2P96WG0tpmXQ2a+P6GSwAGhfxeIqO92H0yFlBaHEwTCmb3vxa34A?=
 =?us-ascii?Q?WsuqRNfAX0mY80kbBr+iSS54KijkzS1YH4en+3lvRjyzT0lTh+Ys10w6ljVF?=
 =?us-ascii?Q?INRZinSu7/DkrOXHo07SXQnjoKLEqZwOS4w408AqxXp144Da0MilXBmjJRe6?=
 =?us-ascii?Q?Yl4+0Gk9pEC4GBpOUulrNyfVl7GH1HNWWW0+JKKUMl+Tpkle5UxOMlAS6SW7?=
 =?us-ascii?Q?h5WPQRqdTASgFhBgiV4+t1nrGyHI+QffM+H5pq4JH54X6YV6he69W7YdnDtj?=
 =?us-ascii?Q?0oYrKM2tOZxUsP37LwCVIwk8CXfyXfUNVu2Zhc+C3uOvrntMoBoKTfR2Nq02?=
 =?us-ascii?Q?/baVCLCA0/YVhYdzydzpv+V3Hz5Aqn+sxbZKNyjW5/C88fxVPDiyTwcH6Rcs?=
 =?us-ascii?Q?C28UJvPzCiiOo/B3L4N0WSFzwvsLAmjDon7y9lqoXnAN3Gr8WXHBkitLxY7M?=
 =?us-ascii?Q?G40ciMJN8wY3KHv49Oh8s0N1yquABKYenAywB+/DJNvSjztMggyfsYsaiWHu?=
 =?us-ascii?Q?vI5/Xzh7Zn69euufe/zQqLZ/YxnWJE1AgbNeUwRwJ1WCiNcc5Cf/XVil60J+?=
 =?us-ascii?Q?UWAR/4cNl2eWeWz22zQQp7amqjZ2xqExi3fHEXJe33ff8UxahnAZtPpQYpu8?=
 =?us-ascii?Q?MT0TRchOq26UIQe0apPI8AUSD7XSIVhdq++Beshj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b1fc5b-03d4-4e39-4c48-08de21be1e06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:35:57.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9w0AiYJNDrYqhSH/r/tuQCQCSw0jwcwfQf6ZbZWQJr025raGwsmePkGzj/pb5HQhV8srT7IdNyy/+KbLlhRdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D

On Wed, Nov 12, 2025 at 05:21:14AM +0000, Zilin Guan wrote:
> The function mlxsw_sp_flower_stats() calls mlxsw_sp_acl_ruleset_get() to
> obtain a ruleset reference. If the subsequent call to
> mlxsw_sp_acl_rule_lookup() fails to find a rule, the function returns
> an error without releasing the ruleset reference, causing a memory leak.
> 
> Fix this by using a goto to the existing error handling label, which
> calls mlxsw_sp_acl_ruleset_put() to properly release the reference.
> 
> Fixes: 7c1b8eb175b69 ("mlxsw: spectrum: Add support for TC flower offload statistics")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Subject prefix should be "[PATCH net]". See [1] for next time.

Thanks

[1] https://docs.kernel.org/process/maintainer-netdev.html

