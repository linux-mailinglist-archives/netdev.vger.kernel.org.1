Return-Path: <netdev+bounces-67503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6F843B4A
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74EC1C21860
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765EA69944;
	Wed, 31 Jan 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="lfjABV3I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2104.outbound.protection.outlook.com [40.107.102.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1A168A3
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694031; cv=fail; b=Ac4+wo4Eoxh2lUJgW+Y4B41QAObVJ+Vg8Sd8QPqpSg0dl0kBdPRlkgv1UjYtib2DOrPDpbPXGRxss8LraK2NgfnzPVaw4cMFj872ULi8TiVbcbYqCaAeYAYlZo+t45wS0bDP1nJbT7lOc9aGXGhEjGu8hmb4ifAv59UmOGQLs04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694031; c=relaxed/simple;
	bh=HU/kkqpX4cEqIBA6tqvXu9Yo76PX5jGIHW3cPYVb2qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ct+RIB67chUWaFJk9mZkC+BlrjxDDbxJwt2cbzDhEFN71IQk62aV+AXIL2Fa9W3fh1kUUPny40oJVQG0SLtGGyVByI2Bxt5rO1AEDoazuLTUUincPAQSq+iQhtBtjGfx59TCpjSZ6QOqcDt0k8/+ps+PRzc8kyNYadt3aFM8PDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=lfjABV3I; arc=fail smtp.client-ip=40.107.102.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX+7u/zrD08XA972bMdBSgiArxrU1aXmAYz9c1vNe1yNBspsavYOO1F8SaP27vJ0GL6OuVTTsP5ywZvAXUWhG/Et0Z7qCzUWNZnxCFNKYK4kT9CYRPCi+sgJdcvUDAiI1KL5xqGoy8GihMwkAgMjoF+dxsvak42JHd8znNA1Y98nIHmubsGIaLnpTryxu4dPLOyHQ9fB5CnWObUDIZ5jANsrRjl9Okr1WgaQKjvigdCYd2v2aoG/cs7rD9/kxyv856L3xm99r5m7A/JZV9cbZm6e869+UVdoBTZCpco+LLyTki9fuV/tPnvg8KKdXvLcla+s2vi1SHiMeHAQI42BgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQLR0T0peQm4SlfAczKinYBxbzNjAkY31oiLvSmY5Ew=;
 b=IlzyVzlPgjNUZTHlTqqpA0GZANqR0hgfMFiF1OBeQjQ0nTXG4IbFo1Zb8nUJZs5oy/mZkwblyxwWYONLOsqrJm70DnH7+MbKTQM/cG7mhb70jTtmwpSflQnnfQKRDzY/bS3aZZ37UZVtuLQ9judbYtG1m4IRfVmEWMsYl3XLSNF/ekQEdDQXsWM6LQEJK7RywDicVDHDIe7TfAgwfTUZdmH5Tb4HHCD2uQviKoYgoiI3lAThH6Yz5zXQfXdhiyer2onzQwyqWgAcqyFARXU4Ia/5bPwtp5r9LvrcoVFTRAHqygkPsCTqArLl5O0gWzdl2nAd5kzh2XfCuQNSiP8MBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQLR0T0peQm4SlfAczKinYBxbzNjAkY31oiLvSmY5Ew=;
 b=lfjABV3Id3Q8LWeQD5YkOq86tv/hlhDQq8iZYetSc6h5pqnFeBez0sGpV4KdHrrQkoTLsXcHwdIJBQeUWQWZ/BMtiDMU48ygYgkoxhk4C04nY6jl7jyt91cBn5v4CiQzPLRZLl3UXUNb4hxTShXpL4Nw+HvhsJuh+UP/WDdxbq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by SA1PR13MB4958.namprd13.prod.outlook.com (2603:10b6:806:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 09:40:26 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 09:40:26 +0000
Date: Wed, 31 Jan 2024 11:40:16 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next 1/2] nfp: update devlink device info output
Message-ID: <ZboVgL2crEK4StEc@LouisNoVo>
References: <20240131085426.45374-1-louis.peens@corigine.com>
 <20240131085426.45374-2-louis.peens@corigine.com>
 <ZboThy4CrJRAITED@nanopsycho>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZboThy4CrJRAITED@nanopsycho>
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|SA1PR13MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 917d402e-2f5c-49d4-bbd9-08dc2240a78b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yh0QgylvnyX2VU2vsIzGW6+be+LKSCqFMhG5xgJcjiW10g1z8jOhJUVQnLbjvGQkQhis/vhfyEtbAVmjy+1seyAl6dgCKjBYLzrFXovu2KFtBV9CL0v9R6/3i68VfE5y9Z+buctYVMBKxGDkf1owAw3S3UpjUk6yMy6Ool92TJ2v9n8w7rnHWayz2143v4JLL0vzmwC+6Pez3X55goNZoCPkdqqh9E9GI8V7JRzI/32NyTT20/H323inCxJkU/BoWlRmZ+87QWBJOJ3tAe5qIZZfYaXurTUBCLEKpHmBrq+Z1G/2xlIkRlwg9ovkVj8mQ2DD9V1QSih+wxktODqZoiUKfVIPmKYVyOjcqrQjk5EgWFSUxNZcy844GCPfNu+sDGTHQN35zSlSOX9PpY3qYoaI6EKsS7jpsGmgTbRMzQziIfPWo2pllPTJJxUnfd08EsNnrbG/DtCpjYBNd0xMIwznoEhde3ORyVbvIY9EX7MlXMzZhK4I5NKiuRWXBu0uzH7f7ohV5Dtx40yNhDFbqB7JDNdo8iiPaGUWSU3naqxy19ffOHqAHlaanyx/oErS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39840400004)(136003)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(44832011)(5660300002)(6486002)(38100700002)(86362001)(478600001)(41300700001)(6506007)(107886003)(33716001)(6512007)(9686003)(26005)(6666004)(316002)(8936002)(8676002)(4326008)(66946007)(6916009)(54906003)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FRV37W9Y6a1hTA01w0x0cZRh4YA+qpjZeF3KcyVuuzzQRo4PtulHUX0DrFeo?=
 =?us-ascii?Q?y3bi+eYJ7WL72XsQV6geLc2DWemW2Yy1lx1NI2H7geaAq8waQLY8y1MhgEoA?=
 =?us-ascii?Q?oup6aVy3/CDIAov8idlFZWTQUKiyHRSV/fqtwoDYVBboCXbZpImL6JpT+ReN?=
 =?us-ascii?Q?b71UWK6WyKffWCvv9ejdvKjnBCOHe3l+Cr00hUutb8coA6WZNwjNF+W578dS?=
 =?us-ascii?Q?LRQTf6G9Hchh25t294DlxdgTH87UHVkDuMcHR8xFST1Npy8QWePup3860FwX?=
 =?us-ascii?Q?/WIpB+FQmcAclut7z1UlIaHjHdh1KBYQ2imgwYTL64tGHWuSU5j59L+9DJ67?=
 =?us-ascii?Q?O5nuWI+EKw2psySq+BeI+PR/zCKDICCQR7S6B1N8u+7zpr9QvDnpGvPDu5eb?=
 =?us-ascii?Q?IrEir5zpByyqppd569NGdntTTxZiYQiCe3YgnOiVUzpHfTpNqtWu8iOefK2v?=
 =?us-ascii?Q?5n0MZGQ+osSb5/VEZ2r2KlBqe4QKHlzil9zsKBVhn8zj4UpeOQcmcpYVT2ch?=
 =?us-ascii?Q?teDt2eRl8w9KNGUqGgdtWSHjWMvDqIC9OE9/jF/Ehg8m/6FS8r8Zfvd0qYJo?=
 =?us-ascii?Q?FdZwlV/9H4G5SyYGR0V5aC/LbbotqgzpFlmbP8sqP/zhf56QD2GSOSnJYOBe?=
 =?us-ascii?Q?3HwwPCnWwvTDTWjUQfT2qAXbKWjq1kW0rZF1q+BZG7eSi91w1rRW+vxLlpSb?=
 =?us-ascii?Q?rcrFFWgr7hBItIi/MdUkrWrol/5NA3Rk2GG0t9vO+vFPDNy5JGKs0FjFFGE3?=
 =?us-ascii?Q?iKDPpeE1SGI/dqyzQk1SeiySyKUSxGBVBGXw/eiPkxmYC3DD0ysZgxTxXs1T?=
 =?us-ascii?Q?//rvhUVPZmclHShIvZCWe+vqFFQ87sJhwtg2+pLArL8WqI1RP3j79birJ5KN?=
 =?us-ascii?Q?tRBRdDlcYHrQ5OLTLgE1LvH8qDVnVaepGK7fCjNXoQRIHJV6TwHqEYPCUVTx?=
 =?us-ascii?Q?08o33hppagiQ/g12NVfgEugvec7piCnaeD/kOxU4/Vb+T9nTEiMXx7jUnXsb?=
 =?us-ascii?Q?0EuePAR15YNxDg8rwtgGflwXvebF5gJiA+UIVXf5SdW4608iVqaGpTGcZIT0?=
 =?us-ascii?Q?Zoosj/RAONmZkNuz9GzKZH4sR29O9MWDXcUE3mki2KdAMoKuwBz3G5POtx6c?=
 =?us-ascii?Q?pbGk/3nHwZX6jevJsubHcCVs0TEIljYIL3nsf46GCliYDt4+3l9jxKX6dM8V?=
 =?us-ascii?Q?XVmmdvnqCvMNsl6af3WdFgiEAf8zLwT+hB7U6fCoZtH0WPS4DYIoEBd/tl6F?=
 =?us-ascii?Q?MUYaWgdNYrhVlClBpTD/jX2RORy5S7/8inLAf7sAWhs5gSYMw5zb4/BaJjXg?=
 =?us-ascii?Q?VleqhYUZ6Raw1+0K/mHA9cHoBWWWdhGMQrh8OUVedzy7zenJQxLydamIQGFE?=
 =?us-ascii?Q?U8PgJLatpeMBeNJQ+92PzJb2VNQH9tPLVLzAEm0jbFMhIh1wRCh2l/1dcWVZ?=
 =?us-ascii?Q?x3AZUxBF5OjJEJzlAtqv5dplzkInZTiv0axzKwKAIKf2ZKWbB510bnVG6bf0?=
 =?us-ascii?Q?gd80m8I3ogNUI5/DCEx21gPRubnR+/56jw7huV1TYfhP6zNHMJsun8i6TAxJ?=
 =?us-ascii?Q?n5EPvAbxiPjsIENXzwmHVhId6EXzIWNp/WrwT3vFnl2gKhaHS9hdIf7BNGr1?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917d402e-2f5c-49d4-bbd9-08dc2240a78b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:40:26.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyss1T6XG7HzEWhHv4jVdas7ciSXTDAeK0dmAPbrfaK6SAPTtc2bWJPYAN/xAZ6MczqcFXN927du2vitpBLa35Ueh0sad19dy+DTzKpkBqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4958

On Wed, Jan 31, 2024 at 10:31:51AM +0100, Jiri Pirko wrote:
> Wed, Jan 31, 2024 at 09:54:25AM CET, louis.peens@corigine.com wrote:
> >From: Fei Qin <fei.qin@corigine.com>
> >
> >Newer NIC will introduce a new part number field, add it to devlink
> >device info.
> >
> >Signed-off-by: Fei Qin <fei.qin@corigine.com>
> >Signed-off-by: Louis Peens <louis.peens@corigine.com>
> >---
> > drivers/net/ethernet/netronome/nfp/nfp_devlink.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
> >index 635d33c0d6d3..91563b705639 100644
> >--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
> >+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
> >@@ -160,6 +160,7 @@ static const struct nfp_devlink_versions_simple {
> > 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,	"assembly.revision", },
> > 	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE, "assembly.vendor", },
> > 	{ "board.model", /* code name */		"assembly.model", },
> >+	{ "board.pn",					"pn", },
> 
> This looks quite generic. Could you please introduce:
> DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL
> DEVLINK_INFO_VERSION_GENERIC_BOARD_PN
> and use those while you are at it?
We will do so, thanks.
> 
> Thanks!
> 
> pw-bot: cr

