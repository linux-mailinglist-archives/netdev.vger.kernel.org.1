Return-Path: <netdev+bounces-84905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F096C8989AD
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46263B24DBC
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6FF129A75;
	Thu,  4 Apr 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="pgmFneWN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2104.outbound.protection.outlook.com [40.107.237.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7591CD03
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240092; cv=fail; b=bDxjmbY3V0i5V4nvrFy1DklHh02imUvxEyPDdGeMvi/qm7hA5+Li8HC+DGAwOQxHbPDfPivFC1s07JxBhZXN4DB9GqCC6KhuldEB0OaZpDD+/1fvw9UkhmCH+C7D3O56CAftVn67KIxt3hAOHXdeQk3+BivvUXg14WNPKxMt7KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240092; c=relaxed/simple;
	bh=2jlPDLOEQpXzVWAKzwBoq3cOq9MAWWd8w6YEM84YSrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UHT2UzV/JGCxCJPRKP/diIBp53RerJwH1iX9uQcwKFRlcU2dX6fLlq0WRR1cHJDSbTQlRsICJbyrYpT/2gbZooGlj5UMm5GPtf5bjRafOStlVteh2286Vpx9sFuzeDiCI7esb0sD8xAdz0hFkDFcOHkUUz/CEr/+P/MydsXFtC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=pgmFneWN; arc=fail smtp.client-ip=40.107.237.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFGxBccc5TN2SYpAYLaChBM7DOF6ON5+VNaC2IVCBPPM04vUfPEgeROhkUdZ+XL4zUtEoUVsLzxOPE7p46Zd413ZZqJ3b3ksd9s6NfHSPVMInuyw+SuIIOyrHhTD4dWhglOCXk5d5nMcUgi1J/KYZ4X3Ps1UQLGmE3MhLfH/mcb9TO1uGAeGj7fospnK7wv5O8opiJ/cAScVW2j6+ulkxMf5e74i/Um47ihrwnILnjwPdMV6+s1HizJuGLrYbKSXwjjq9hmVy4d0CAViOnRnuocyADT+u8EzoV+GndRyPh/4BEBAp4OlHcNuVGoKN3pv1bXKVA8KUi3CohdqVsgBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmOEGu0+XY1E1Des+rkJh8laucDrbJ5PujY7O/Y7r6w=;
 b=S4mWLWIVVQDuIpYdA4Zc5QPqn1cu51lI7D3rTqyCaVpcRwSsTLMcDrlCWb2mK5qiGNOQxfS/qDcGuyZDxNQEFbD2qaRXOTAn81+0ljOaqk2cOn+VxnHBIrkEi8U0c6AXmLdiaMkKjXG8kQXC3Z1tqeqikQ2I34ZFB4wv0TaU3kL3zTPXlxgyQJdeD65zaliuOROv5i9jiLS0EmEK8g0P1kCjZshp9x/4677lTU1+jHBW5Xj15FKldssaVXtPg/UMfxlTcHc8p2LYNRFD2R0FAYWqxrKkoTIP0u7ISkoSvs46BruUXTx6GtiKZ7azn6/cqzhHRszCGMUJg8bbYCxqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmOEGu0+XY1E1Des+rkJh8laucDrbJ5PujY7O/Y7r6w=;
 b=pgmFneWN4x+d2Q168EgM4zelkxPvdcBt5GjBOjyV+WmXs8gI+s/+ahdO3EK9YJgGTVfarBdP7BObCMgIyLHhAb/BSwFdacBDL5Q7wowZ/X5KVwbqFpfjmHPTqjAWUdKuFyp5jA3X0QWGf2tjmzh5LuKwc5ZQNOIO4BDXR16YWmM=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by LV3PR13MB6357.namprd13.prod.outlook.com (2603:10b6:408:1a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 14:14:45 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 14:14:44 +0000
Date: Thu, 4 Apr 2024 16:13:42 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v3 1/4] devlink: add a new info version tag
Message-ID: <Zg61lgMUzVWvXEVM@LouisNoVo>
References: <20240403145700.26881-1-louis.peens@corigine.com>
 <20240403145700.26881-2-louis.peens@corigine.com>
 <20240403184252.7df774d0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403184252.7df774d0@kernel.org>
X-ClientProxiedBy: JNXP275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::16)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|LV3PR13MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nEXxpeYFXAO2mJgeSBgsdz+I2adYcOAgD0lTHcLgxZGWz6Gg8ru/aY8VjLTvH3yJ6lbQKrSCQZEFFtJ8igrtUWcmQcXmDYJ6J8JoNLgQq5hk6f0Lv849oiTeHzlDsc8FQOeXkvrTEanKBtJ1keH9ryOPl5O5IiovPWX5bELGySrzHP6WkNRii3pxBPOFpXO3HeYcX4lB5NywYr9S0xjALZa/2exThJb5/7qQpoar5qWtRX+yiDrEuEvKXpX5ioD+0dvBZ6Jf5q75UkQuqnWtwCZMqlyfvrFSTi85vD8rvTGb+Z0Ev8CR6gPINx5PLLsOdKxg0Udm3qM1jBR0ECte77KeVn+m9hF8+oALlc+6lyCYO7Mj+hO48Dm9irKD0+xIOho2YFEpFy9vwIgc8dmnBkLWSGDz01cQKUw52j7Jspidy1EFPKK/ipSpOfh07m5Kw0LtXPnoU/83HY5P3RWY1w/I5IYcKy2/aeWZiYGtIhkezdoCoFtZeiw/PYqO5oIgxZr9lxF8fg5dhNoJUm9Mp3lkpZpwHQ13UgJRt9GnixOvgtleI8HYAiGKvwuFgbEXPc4jFnklDTxLmJYodBWrENzPIBQFrGnfJ7t26qVxltNWO3GzvwgZC8z+Yy1A/xPqkwJG5T94wrR/b5uhmLVxBzEP6FFt5Npm1qkBCB9wVjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qTR9LWZQ/WOUmejMcs7z8zkWzUClKvecRnaQfdwDlVpDlq0KZnO25xMFidEk?=
 =?us-ascii?Q?jWMLmlvbobxOM3GBPJBkTG2Hak9nC1bg4/PLpOyzL1k+G8EuK8Wb9b0+Nljp?=
 =?us-ascii?Q?EI8FIN10KGb3wChqRe1QtG63glmWPg79rQ9ZUkAWSxD9Ssm9PFLqRIF9etG5?=
 =?us-ascii?Q?H5BtEUmQWkQs+u+BINiXXheie7dsXB2bJoopDaPhJv8HjyD1VtPAB6yFg8D0?=
 =?us-ascii?Q?OGfmtsyOk1FNpywteRjfTfafdICnq6anJ9cv3wRxaM6thxHxp3kha4RbR8jp?=
 =?us-ascii?Q?hfYvJyKlOJ+w7ugCmhnjFgOpxJ/rZo7MgCkAZoCHGP7jmRV29vZCzqx5MuJR?=
 =?us-ascii?Q?/qv8U1h2frSSFvje2wYo76GiuvOhAVUehexSlNS/GUtpBecw4r+grerXxnWn?=
 =?us-ascii?Q?Qae5W6Ss3yVQlwtD4UyCqZloN60r5wOMiPmZpskUv7xCMIHr2hH1wn+WqslP?=
 =?us-ascii?Q?oc0T/ybXz82uwUcoODiWkYV23bAml+PiYNNkYni32HOjJ5ZaAZgJqkMC1WA+?=
 =?us-ascii?Q?yqhMvJVNun+TP0o9+yoAZx2yrITgQR5dkIYdmGmuvjyzbB+E/VMB9HC6kA4T?=
 =?us-ascii?Q?hoR6kpjMqAPJpY9iBabxpwK927gt5INVGIF8CBQ+XSeZv8l2P0u5H7shDgPM?=
 =?us-ascii?Q?U9hCWydEjDLUqHUXxSRaZecfX8paE8Cf/MHqeOm0dHUSuCnHto8GElq1MLTk?=
 =?us-ascii?Q?nS+impUt1+BQn/Y0jXIPlxoluN8bqPX1FD3MZs3gl/DnDvvYguCBmXd+GbMR?=
 =?us-ascii?Q?3fxSaq5vqI8ymxVZZHgksbYXrbpogrYzkaBa4pWBWQTvecSHEYWLjn86s+Bt?=
 =?us-ascii?Q?Ssrvrc2QftbClWpq8oGnoBN+htVyXFp+uleIvQS1FYAjXKyPp1YKysEspLAe?=
 =?us-ascii?Q?m3DOaS8URgpZoF/jqaqkrkm66kkNAwD4tD8MqRT+ysmo+Rghl6L9OYut6E8L?=
 =?us-ascii?Q?+uhdDQY99+0IYw8VxS4U+RMrfuQ8RLP1nvJgUwoWycEVEA8I1um6x4x3GUl3?=
 =?us-ascii?Q?+IAnWOr8IVF7gyNjrm2MkZYGVR1BhuNDbLPReZx17EBjqaHLHpgiNfiMt+HH?=
 =?us-ascii?Q?nlQP/ZpmgYEm/dj1VcA+Ewl4VuVfOjed1JF2Co8Oug8jjhfgRHDGEB7sOkLB?=
 =?us-ascii?Q?vzwICUa5uiU2boQiahw/bQgpJ8WhYJhsseYAWgyZsvmiJItfoaMdFgpR0vVK?=
 =?us-ascii?Q?3u8Jdrgzj/DQ8MtrUIlzVyl05r74Tra3bhOX2e6hFEKapI7a07PG7LLOBLEz?=
 =?us-ascii?Q?R/PLaQnbvAZ8BchXFSQgEg2LFb8ehmTtP6DE5XhnUYRpzvxTakbgyPACPjuG?=
 =?us-ascii?Q?IwXVsLbTTgLcF5ZhD24vn6+5ohRUNivcdcYRAIndu+SGXB1SDkbXon3gLIY/?=
 =?us-ascii?Q?mcm4T0sLJ9I/7T3VW6yqC8hUU67SVTpYwH06ysH7wAWbbOs7YrZJzD1qjvU9?=
 =?us-ascii?Q?2OCMBWUlL1io+9qIDmtPYZrsyxbOgwwPnmnQMm87bj1yN2JhojMBb8hnawhu?=
 =?us-ascii?Q?tleLDaqc7PkBSlmiSKnZrdBB5DnRjtq6nOe1RJP/UN1z2tJcIvatTsEmhbZf?=
 =?us-ascii?Q?NC8gKHELaSPwy5cpckzFxbH2F7hapcb6oP9NQTnLa7dwqHawnAATChl2ONLT?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac6932b-3b5b-4f0d-54da-08dc54b193c4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 14:14:44.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dTxsKh1dVTxj+L0XRStLGN0bilciHZYzPSKKuMhSTLYYQ05mc9O5jZFCdJZ5Fwey3fNKGqXhCw8NWtRk8dRS2BLw1Vse3QiYo2cjT+RYDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6357

On Wed, Apr 03, 2024 at 06:42:52PM -0700, Jakub Kicinski wrote:
> On Wed,  3 Apr 2024 16:56:57 +0200 Louis Peens wrote:
> > +board.part_number
> > +-----------
> 
> make htmldocs says:
> 
> board.part_number
> -----------
> 
> Documentation/networking/devlink/devlink-info.rst:150: WARNING: Title underline too short.
> -- 
Whoops, thanks - will check what we're missing for this to have escaped
internal detection.
> pw-bot: cr
> 

