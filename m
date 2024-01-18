Return-Path: <netdev+bounces-64267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADA5831F86
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE674284F74
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB972E40E;
	Thu, 18 Jan 2024 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NrhntCjW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D02E40D
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605525; cv=fail; b=L9lBgU+3TiuHxQfJIWq0hqQddj5HYgkRehJ8jR9f/A0atpB9Ym2LrD4a38v2UvsDMrTky1/8eP4mg9S2GX2akeO80zqM1NogqVwugq4diNV7P0/Ix+qETCwjymDcIdQo/Vbelrm4j0D5klfPiHfSOu2MlBONzwG3eB15mnpy208=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605525; c=relaxed/simple;
	bh=sbZK+10HLnViG01IEqGloBJFLr/dVXqA/1QewAl7JbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0NC8XTD5k1ZCbBLsp0GKxXxTx1PldVJG1iHwtJME6TSDhiOVJwde9kps8XwZo5y/qpRsYA4ZiWg2ecLWEaDMYUd9YD1zJAUASngTsN3tzklHcgoEqb+SoZ/n06h9eiYbufVpAYs7QkbK7UXUI7r5/T8qmSX4EgfJwLjdzRTAMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NrhntCjW; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZUKxmyysvbKXb82cf7AgpWSY47uumWgzEorFv3f8iHG+nzIfBoLrfK1hAneV6+z6eL8bBqU5zMScaINfJ4ckxsHH6YsXSwGiKXMFvUDapg7Eddq9VLWOUal7VBnoEYtU+IzCXp4xTdt5PSZjk0kHJ/WVzD2w/zg91+zWIdIQqM3IP5c0W6nQxuQFmlx80uVT4qgVQaa4dUfl6LsfAIUkegJUZBISIaXIL70E6/pO1s/9lsri2REcrOeDPc+LOoK8xOL+RYQbyRlNQrWcXLthQQc2IhoMSejXRfhuGjDhp2N3XewHyuO1CAyQChw9FgtRovsyPs6EFLwmMCngKyzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5J9vVxE49KrGBBoPsItQp/X1RngVezkppwsWnJwbr0=;
 b=mrcKMIJEWk644BIciol6y6CDqqrRLDOgG3BhOlSuc311egUcUuIQ9EwpkwDxYhzqsrTcW6WJgbrSgQMSczSrJFK0r1b70NW4mKBGdNvpC+xWFMUFT1JavWt56ombQy/Wgr8HNah/tQRA7M08dkKl6CG6V3Q8JDzcDpOLGxpYSMr6kG2QcRrvhd6ycZ7SFPKE86R5L+CRGVUjkEwr3nOTXZkmFP1hOb+98x9k1NwUem9Nkla6BrbUr4OMEvPqFOKyVXOIEjrhJHL2MC0sUWyvKHt06W3GzyovXFKQeD3tfshk9unctFIcYhPEkz5X+yyjdbeftqURrLlWoBb5d6ogfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5J9vVxE49KrGBBoPsItQp/X1RngVezkppwsWnJwbr0=;
 b=NrhntCjWyLwD6YlciLB3K96fWu04GmoHcW5cy8SF2V98TUe4LQ5dDWiEgPwZNafWNFreIj3FO7QCvRfLgYOeNQpfIfQPhgkmV7LQaeNVcneN5mw71iwXwrgwbP9a7HthvFb7b8474dJRUOvx6H2/bE8HbO8chmwyw3bJNGU9bY/9b27ceuewjIAcxZOsdfu8nazTInyTjvvwiHLs96UIVqqHhgCQR1rvUgxY4o+CzrSXdfX61NQeS5Fazp50jQDeSb698bM+AWsI6xoe860QOKbyav+LGQfuKKX3jto36pNPX8/W1PM6UE72r8IWeAuC9Mi21eK7XXfZmpBD7SOzRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.24; Thu, 18 Jan
 2024 19:18:40 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 19:18:40 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net v2 2/2] net: macsec: Only require headroom/tailroom from offload implementer if .mdo_insert_tx_tag is implemented
Date: Thu, 18 Jan 2024 11:18:07 -0800
Message-ID: <20240118191811.50271-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118191811.50271-1-rrameshbabu@nvidia.com>
References: <20240118191811.50271-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 40688c23-59d4-49a7-da3a-08dc185a4744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2G4WCmrVu0b/tQK7WF13R+aE/pyCDBPLafwHC7nNjWRMy7G5Gm8L3tFRI+3SbbcDZYQaKIOkaUECl5Cob35dA3HtgxKnOOIdU0UzyMvekiHdUBt4yQ/LQs1+HQVaDzRqw9Ol/IsnKKM29OB1hZ8PRnykpyTkLb1w0EL5Sr1u6YtNVQ0GHrP2T/q5hXBojbYeueoxSeTVgaGbVSIIrwjLmiJAWxR8xNaJj5qjutgD6O0tGut03tBtlS1YUu/jujw0B3ImR+2OhP2pJIsGX3I2NbYpnVZJer+ZT0P3lMTsy2hVsbz4UEJgM52hV21NuRdyqKB+rYPmCHsQrebsHP8Ri21E1V3eeDH1LWVAqilR2QCAyF+vOSEzB2nMyaCUbjHEwKsGhT0PYAjmBLeO1NRbhnbJBRB1JF8LCu2nbC00nbICvoyC1kDJr8AGT9atxi97ITNoOt4growizk5CJBw5BNVxUxglEijh6JdqRNhR1E459CIw+BbTq7/465XNUANl37pn0Q9K7dHfTGjIoDQGvdKsOKOLBWXrL5NS6v2MdSf3OKx/zV3waYP9e/Z1GzX873Pkv56xEDnMGzrb+RTqIsEBznpRVgpXsyFI8RQq+FDFLw1CO73enGS7MaVF+TW1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(2906002)(8676002)(4326008)(8936002)(6512007)(36756003)(86362001)(6506007)(66556008)(26005)(6486002)(478600001)(38100700002)(6666004)(66946007)(83380400001)(54906003)(41300700001)(66476007)(6916009)(2616005)(1076003)(316002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NNA8RkAqf0JUbF+v0BcW1XzgBWKU37oHdtWDt2QWaFRJgBDOmL3VCad/pbox?=
 =?us-ascii?Q?duNuvmXhAujsgvXt2KmSZ9r9WLwyMjK2gW6duI4yppW95HgU7JbgbLoXuUTK?=
 =?us-ascii?Q?r/aWCmWSSdxl6URQMjt8baLmUEqIVatfvpqsMFb59nDfLptIjyxA1bQldDS/?=
 =?us-ascii?Q?LbGlIonpY//4jbUfTzCLd1bVRzNcMBEr9ALD/JdSfPFvcM93Tc00B7xzyg7F?=
 =?us-ascii?Q?q4P/qLpeKe6lkvFjiii+6KWbC2DpoQIAZNyyOW9e0GX5nLr/N2MAX8GUzO9P?=
 =?us-ascii?Q?IbNHGEIT2H859nFkVlqdLVfjjJ8/SDJ9TNutPuZCxurXconXP8CKfFU6GYsd?=
 =?us-ascii?Q?TYD+uaf7RQWzU0a7Onup+uaw7n9InKkzFrZ05pIlB0CEesOO2uJ3mKA4Fnxe?=
 =?us-ascii?Q?yCp4/NV1Fto8Fs1Zm/xTzv+KX6MSmBwQNOp2Kes3X8jTl8lHz3T6aMjCDtKv?=
 =?us-ascii?Q?ZSQ1YWpm7wc5TjTfud7nQ4cEhhY+1qLSzdnKaoyhunB1t6FNFtf2nL0/o4oi?=
 =?us-ascii?Q?GjGsjExEAUYAX492ZZgQPBAXZeYIs3Sg833nI4W695S4w2mZPzo4P9qu8ptw?=
 =?us-ascii?Q?gopoVp6hwyuXlQ+0+Zii8rPD5T8ixbnHsi4YVVkH4mrFw7x9+oK0TZCZvU26?=
 =?us-ascii?Q?hSzgyCdiYckMzBZxnuDVvUVqlr4Yky2007cxlv6dU2DjbNqogpy3IfKe6WtY?=
 =?us-ascii?Q?qlfiHIMR/mZpMXo5z9p0xezOYd1xKe1bj0ndrV8HKfSDlOIZJMU2KCBqG6fT?=
 =?us-ascii?Q?jOeJ2EqVNY84rqa8YnWH1AnZtmwUN0fP030uIH/XQPXhluZJ9ItjeuyWS7R5?=
 =?us-ascii?Q?LZ/WnXdp9IP6VejopgCnSD7Our7JtrjbYcIf5rDfrMP6LBaxP+f2Fxc0h7o2?=
 =?us-ascii?Q?ZJ4Sw2xLtTRKu40oQIk8+uBbk1XxKxtzETKErsrpFRXvlkazWNzWbbBAyGqX?=
 =?us-ascii?Q?aFT8sNhudED1AqDLQziB0qSDNMoRPBp/ZzvfQJAV3ze+BllbHVV9ho5XGP0p?=
 =?us-ascii?Q?rBu/o1tQHNC0ozM8LTZPrJPf5yqgX46bCMY7PRWl0uz14qwOS1Lc4z3TGexK?=
 =?us-ascii?Q?U5HvItKk/AmwxkhVyI4go/H2aasGcyDGNKd6xnL5IWc32y1plVBIRfeUjTOz?=
 =?us-ascii?Q?bjOjwoZ1cdK4VYMa9qBdo/rbcGP85TBAXTBGK5m+UY/8peEwUQsAcKInvcNk?=
 =?us-ascii?Q?pRsThnS+9wajhz+kp/qXd+RKzQAsg4MEsu6Ao76ilr1PiTGMLJTAdqbswzCB?=
 =?us-ascii?Q?wSU8eVSComrzwI401nyVThITgUeOxwDbcAUCR4SGpEQgnmS1rCBU2aXBRKk+?=
 =?us-ascii?Q?5sb5A9fM3A19Ry337vzvkv5RU5d2EPr9AjppgtlhA+FQx0PkHoPNJF8cDUhL?=
 =?us-ascii?Q?4oifFlRBeEKPQA2r9JC26uvnau837SM9cdR+DVw6W/LzBfk4StuzLs3O+Nqi?=
 =?us-ascii?Q?u0kK+8MVbpHfbwt+HR4M0Ll1bwN6RC7tik8oEgzZjtti7Ep8KTBx8czvDTbK?=
 =?us-ascii?Q?afkQ6mv95nVABjrNgjbMHJgv6L78HbJX+WZuCwOCb5/u6rB4pVR6v2ELJrlV?=
 =?us-ascii?Q?OO1mEkyAIF4XW4qZWdALkNbqiAkxCTkSOVvanNtnYQ201vWEPDiF5+p5aqEy?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40688c23-59d4-49a7-da3a-08dc185a4744
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:18:40.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/seVbo+2+akjKFUM6QKU7ArhaWgItvBoLyn/GBTXoNIYvxoZqHcqjxwOvVpWb6vD6TwfwyDuuaYCjwB4fVcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001

A number of MACsec offload implementers do not implement
.mdo_insert_tx_tag. These implementers also do not specify the needed
headroom/tailroom and depend on the default in the core MACsec stack.

Fixes: a73d8779d61a ("net: macsec: introduce mdo_insert_tx_tag")
Cc: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        * Introduce new commit
        * Fix headroom/tailroom calculation when MACsec offload implementer
          does not implement .mdo_insert_tx_tag

 drivers/net/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7f5426285c61..907c15f0fb14 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2601,7 +2601,7 @@ static void macsec_set_head_tail_room(struct net_device *dev)
 	const struct macsec_ops *ops;
 
 	ops = macsec_get_ops(macsec, NULL);
-	if (ops) {
+	if (ops && ops->mdo_insert_tx_tag) {
 		needed_headroom = ops->needed_headroom;
 		needed_tailroom = ops->needed_tailroom;
 	} else {
-- 
2.42.0


