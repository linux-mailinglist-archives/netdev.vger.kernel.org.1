Return-Path: <netdev+bounces-194715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42796ACC1AF
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677C1188FC27
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153B280032;
	Tue,  3 Jun 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="V/XGBVhI"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B27280026;
	Tue,  3 Jun 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748937985; cv=fail; b=MF/ogUCWs+GYNib1KpxXogYnlUlMTGgYbMZ2N1cymS2+j+GMi8Og+PaGEtA4d8tmA4xL+VptFZFRxTCUbpFgRcMKroLcxZD+3jAIW/tyZmG3OccWrb8dBhCXdBB5/Nqaz1PDS1lylR45W1oSIkDk801ggyPRLlv4NCtT3PtQuxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748937985; c=relaxed/simple;
	bh=3GLSlHT3JIT0QedShjch37FFJYYfyBbRShRJecDl+hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKUOlk1tatPghHLyfjaM32AodhPHreIb+9iYAKOAIslYu5b+dkxfxYXEpw62btBmn9OVHfgeV6yR57et2DKg3AEb9nha/oLazt0fsWWRSTtAly605VxaHy2d0Zmlu8Hnuz1I9VzqTDJmRdnAFfcd/cvaYY/Hc7V0+hMRcGcvFiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=V/XGBVhI; arc=fail smtp.client-ip=40.107.20.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnPm70GoOozlPqbiecYsX+CiWaMG10boUeL6p8sj322aqEoRv3BXhjtRtzX4a0y5dWILLkcRi3lKCYzVjQyENRnlv4SrDhrjPorsL7Ld7ziigjPxsKI9bitEF+1b8IowVCixunceZUjAnuh/igZ9OYEn9cg1wTNSqasB+r4g1DGOlv4qnx43nZ5a0jsr3yMiGSbCuQaFYJ6WD96LnScYm4apkJEO8FDY3vvy6m0Dfdkox3oLmDMrI3car7caQloeSSqIdJlZ+rfaF1OIZKjMTyrlsw12kndSDpmN14DHZ0+QIk5saWGN/WKXEzI1x4F7/2TDAkkMCtR5BPicBsLcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LR48PESnHB9W9EkFIA2R5uuwgfcF0hQ8w+j+RrJ+Kk=;
 b=nNAVVwmUCNca+IGx5PISwQ+nYq3ZB4GLyiu71CeILvpBFFgC+Kduwv5kguOPQ6itnb2nFH1IiOkqWujElAaZQny8Ncxb4478RelZ0Kev5T6Pg6eh+eHKVF7nkawo+u6yK8slGK05xXhhpUmWtEqPmOEl+yhhkINd9VxQJFQQqlIAiWCFkFFR974p/laLlv/ptEVhkUWkildDo4Rw5ZzvbOWJ2BHt/aJj7Ggmn9CHNS2dPSbjPRNSzw59fZuRhkHwqx/7zHM4dO3HOc1Xvuf3V8UeQN6IBmFoyBljJpBj78yrMuiChqqudYMdVdbk44FAxPqRDeThxuJPWBqBp6Kg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LR48PESnHB9W9EkFIA2R5uuwgfcF0hQ8w+j+RrJ+Kk=;
 b=V/XGBVhIF0Kx4hxkncO1dA4kjFruoDRvUt372PaCJ0mjTyy1jI0ALFaK0gBSQEJJtrPkjlsqUExnNy1bfJp3LIvSE1oCA1wdPe22sadE1rdx237gn2K0TgF+lj68/YQwjhjAB9PHeyVtb65jExLcynhYFKfAHjImnuRsi5tHrNE=
Received: from DU2PR04CA0066.eurprd04.prod.outlook.com (2603:10a6:10:232::11)
 by DU0PR08MB7882.eurprd08.prod.outlook.com (2603:10a6:10:3b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Tue, 3 Jun
 2025 08:06:20 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::70) by DU2PR04CA0066.outlook.office365.com
 (2603:10a6:10:232::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Tue,
 3 Jun 2025 08:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server id 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 08:06:19
 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id 8DBB0400EB;
	Tue,  3 Jun 2025 10:06:19 +0200 (CEST)
From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
To:
Cc: carlos.fernandez@technica-engineering.de,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] macsec: MACsec SCI assignment for ES = 0
Date: Tue,  3 Jun 2025 10:06:13 +0200
Message-ID: <20250603080618.1727268-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529124455.2761783-1-carlos.fernandez@technica-engineering.de>
References: <20250529124455.2761783-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|DU0PR08MB7882:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dc3294fe-5ab7-47e3-0bd7-08dda275860f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kflxdrGbpH3hMWpz82+yrs4tSRz2iNnG+MfXOFrIQKLjgQwY9B0loyH04j/9?=
 =?us-ascii?Q?b+bNGoSrd/+d5w6lTUGnLPLKmqMAlmoqPES86haEYek/beUz4nnqTnQMShZi?=
 =?us-ascii?Q?0e+TR3WX0ZYAPveaJ6ioRRyoqZjdbHDtRVbJt4YUMiTKrGGUlbmCWU+yEN22?=
 =?us-ascii?Q?q8hGGNdk8bWcit3psnMawqALmOQsA9IHsTn1rjXWTdL80IAeI24kGwSLxVpb?=
 =?us-ascii?Q?p8DZCWWgGlKYd7v2E3cwWSi9jz42xFtz5c7ZtGZvVDhyyKrsvcna1NkXj4Rv?=
 =?us-ascii?Q?2t1gG3A0GBFu8J727UWDpWku1YWrdgfrEBnMh6OWVk34wvhPb1Co+7AdAYj0?=
 =?us-ascii?Q?A0AkH/9xubBdcYWstz14IE5Kb/OYTtKAD+5OKtIxjcmYNa+4hWwfnCyXX6Kb?=
 =?us-ascii?Q?CAWt2NAMPtB/HEiTqZntsuRSHh0U9e85WmEEnzp7C9/uOAfIxKjeAe0TZU3/?=
 =?us-ascii?Q?vofYCXysXQx1c5Xs68VKnHx/0EzC0HaxxRuF752bZNn3+a39ev37NRc623S/?=
 =?us-ascii?Q?oVS6cfLOetSvaK+bizdDZLPsz8yHbH0hQA/bSsy8Nz1mGQscMFWu8J3urv6X?=
 =?us-ascii?Q?S0Qt/Tti3EhgXR9M2iiDoa4ob5Vis//vCZdvX0zl5uP57YLVXhveJCQ+RAJX?=
 =?us-ascii?Q?mKspaE3KLTQtQ9SMYh97mI9JHmg9CTBZb68SQOJwBU6cQ42qe4lNRBs5d1/M?=
 =?us-ascii?Q?jM/Nz8Y0UcwEY9eb0iCCUKghMhwt49g/Ec6A6VFY7HqHEE9SgbVATmbuHJos?=
 =?us-ascii?Q?r4hOzZRHuhAIGlPBC3nq9C7JTB4Isxp7CfMTJJa7c/RJ+mHXLzE6wNkmMSQW?=
 =?us-ascii?Q?OtZC9o42RHtA+L2gOMwIRvN2BNNHCN9WVwvHi95hDodPoVBUMCLpxlg7FZQJ?=
 =?us-ascii?Q?HTpWc0lwslW/fsdE3+AsphxF1EC6YB3d3ZGoRo2ocJRLX9ihapJ5aR0mUr3a?=
 =?us-ascii?Q?EjPPZQXC0g1V8zFf6aKk1hcU6i4KaW63PFw/KtDW6ndHKQIVx/xsn4WM6u/z?=
 =?us-ascii?Q?cuiVdcOfDT+s4aQH/Oh1qfdLd33QTC8IKESdKqgpYn5lU53D+YWsnUSmrKMZ?=
 =?us-ascii?Q?SAps4dMSJ3LSSIWhpfoszQ5rqlLGWtB0rBR7uf8RHLtp6V0yD+BD9Dc19ht4?=
 =?us-ascii?Q?M7ZAcThhPzy+rLUlrEO0/Gim/VKlB9DrdoWKGzvBOVOBxYezqlPWco/rL9cj?=
 =?us-ascii?Q?QXwPGEyrZ8PP/b5nVH62bV8Y1iFO0kIkxGfgL3uUpZ1W9nskn08WfUWWSkLf?=
 =?us-ascii?Q?VY15noUTC36t6JhFFq/tX3ARisbXVbZp8arODdp2HuyevL6ktvldik5PS42j?=
 =?us-ascii?Q?2L0HaJLF+vUaqlOuIw3A+D5fO80ZLkjAuIgszTe61XnU2ltIsLpfyyFb1FTP?=
 =?us-ascii?Q?x4rBuh+Uax7ruO7W/+RItTcCP1jhnnXpYWD394pU7d9c8VU3130xA6wL1vhd?=
 =?us-ascii?Q?C50034PWy3cpurZ2vsDiRTz9ovTfNxSiUnePPh7ljmEr7NHiBSRpqdteoYKL?=
 =?us-ascii?Q?NunlUM/pSksCxfxfmGGqghWvbwXSCS4Ca1h0?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 08:06:19.9213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3294fe-5ab7-47e3-0bd7-08dda275860f
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7882

Hi, 

I'll ammend the patch and send it to net-next instead.

Thanks, 
Carlos

