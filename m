Return-Path: <netdev+bounces-34124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05277A2386
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F414B1C209A3
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB74C11CBB;
	Fri, 15 Sep 2023 16:23:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25A11CB1
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 16:23:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B0ABB
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694795032; x=1726331032;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=E3RxWRFx6fhGhyYsljsKQm+ZWSgSLaED6Bg9kg5Ixb8=;
  b=alvBEoabOZxT1EJkY1rnqD5CNBKdN7jxeLguHAmCixxTnu1do6vvgwL8
   yafua0/trmrTMG+2mQPrM3af7BhA6yV1UKOUd5hFlIowhG7dhYdfIMq/R
   lgVZgJAB1U1Ywuv5Rn90DRQVzToqiIL+JG3Ofc6g2JzHDQ8H+ZBhzV5Uf
   vAZ3SmwNV5A8mAuG3EIGWB3tknBW397ySBQTTrOFjYaReuRsTjVjbjSze
   OK5E4Bw7bsEJXPUf4WhK0FryORpcGOrWRIwiK9LKWsSOpSe04MICBEmcE
   ct2A6MJfrrthnQH+ouYd+kZEEpkTuiEXmkKbT5bXLjXWGzqJCs+jX5TgB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="445747385"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="445747385"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="1075846945"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="1075846945"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 09:12:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:12:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 09:12:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 09:12:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5KYmBMAKcEkM4uf1o2qlvbnnTEln3dy80tdVgO3S8z1Z0UWPCd2BS8+aVklP1piOiAIa7QP0eIkzV2mfiNq/3d4KnEB7E5DAFBsSU7K7mMfCldgItPjH0CWp9eq5WiRuV6O0m+usgSZTCSqB+GKSgdjGOT8MjnVz8Z1Zq9eR6aaC0Gd7sRSyRJY0G2TsEM8lo4yjFb0KIpPgGAgPV5dWqEwNVAs3h5BCKf0zky+BLJrZdX0CQWmcSDVOyl72wLGo86S5XNj6QYdBH9zFF3fSgsUezrnUAsD19GgeieJu9DjUs4qsxvWRVqK2IomH/tJIJ3ldtPSPwy7JIS1KcWxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gv7rTfoXDHPwf7YMLVE860hQsKITg0FPvM2UjiKURMY=;
 b=VfS1bEIFt2VAAJP88yc6JkKUwUJtvwr6Dhq+jcDOjruPEzKvPgRmusQhHBE9NgEeG4AXzoYSMajeHE8FU7KyRIh75yq357J5kAi1+csRreFjASn5eirme0b8phyF2e/lHzF5rN2WNF/axpv8zn9hYlAO+fo68fUW71X1x+SbOqXMWvUcDpOeKnc/Q58B+ju/83Z9IqBne2JfcZX+Ee65e8frDFlEF+ZPq72ZNLT2UZEDn7UNPHNlPFOwh74fhPf0svEgzfnEBFvKccWmTowo6XeqL6PbYzw2KNncqwACM79DH827To6jzpRr1iGh5OKofpeGXgSpHt9z/brmq289+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 16:12:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.036; Fri, 15 Sep 2023
 16:12:38 +0000
From: Johnathan Mantey <johnathanx.mantey@intel.com>
To: <netdev@vger.kernel.org>
Subject: [PATCH] ncsi: Propagate carrier gain/loss events to the NCSI controller
Date: Fri, 15 Sep 2023 09:12:35 -0700
Message-ID: <20230915161235.682328-1-johnathanx.mantey@intel.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:303:b4::30) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|IA1PR11MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: a93b8da5-ee8c-46c3-60c1-08dbb60694d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nD1t3sUfd3axsojVUgieJjujQVUu73pEHvEaGHwyoTeo8bijOiBo+9y+bYkeRlqRBO/+qlTGndILbulcC2ndu+gJ3Q4rA5ekTERkjiVSxOp4scG4tOICH2HGAm3S2ugIjzfTopkHJh+2AhNsUML97FOzRwu1WeRzncCX3TOfGigwvOTqgVAvw4kAKLiVR5OnRaw5L+x7M0a8Z4xq1t1xF6qol3UqM0538Ec+YPU64rRLvtT2iuGuqjCosvlYVn3vEdZtvy6s8CuU99AuXtpS/+W26nRmOyq1z45ntUNRZTHC7RdftQhyfLbKTWf1secOpLL4KjLmhwhsmMwMxJT1uy2KVCD/PR7kGCjx/QHEZ4GM5coCdGzaUWxqnH2uZJycwwTYG+WIIB7Z9gUiQojrMJGszxSxJjJ95Tjk8VBNpU922nXX7FXH4nVzzX134MAs412ATNJZlMRSarv+lQRXS7gJhwy5kaDgTcu6PHG4W57MhsgSgwYNOtkAxgMQ6jep8buOhU42jAXHzXZDeVkgcaK2E8X5g4+bzYoPeb9+v3HYnvlWao+lp/KfkC5h6Lko
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199024)(1800799009)(186009)(82960400001)(2906002)(316002)(8936002)(38100700002)(36756003)(4744005)(6916009)(66556008)(66476007)(41300700001)(6506007)(478600001)(8676002)(5660300002)(26005)(2616005)(66946007)(6666004)(1076003)(6512007)(86362001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IAG0DDF79HaA1GtljBA2wezBZ7JLRyLb9go1dLfrnqkHzasjxwXOeCl/PMnE?=
 =?us-ascii?Q?/30KGZhCn0qVITCelBkRfMwSSudgM6sLxS1ApkYpxmCRwGNRBP+kqnqurnPd?=
 =?us-ascii?Q?gkj4v5Rpng/FXL4xcMiYAEwtjGGKbO9aCpqQfpeSyLvBv3agRuqj4cr0ZHJp?=
 =?us-ascii?Q?dOELUONqyJUGwUKAFCm5uM7jBRe9bO1MFsZP1OcyPJNgkidQLmRYUnCLFx4k?=
 =?us-ascii?Q?y3q1eUCx9k5tbaYOec71VkxRxlyNLxmzM/uWGlBSnCc1hNtWY1/WXcmdWF4c?=
 =?us-ascii?Q?y8Axfq01r9oUyFq4RhiMVa7u7XWU9xkJ4T1JWKv7Bg6xAYVM0xMru6/eXaLp?=
 =?us-ascii?Q?ePTC0YfpM/T+wa8L/r8lPkrtKrwzRXLteBJZR6bk2Vlp2fdCDLK0i5S7P95p?=
 =?us-ascii?Q?1eHAf26lEBHBz8JTlA0eA1fj6BAiqbUsTCZiQuccL5qizPWzCRefsK36oySt?=
 =?us-ascii?Q?RtVOP/9reoDdlUKHL1ssC5L3xMnBfYqSHQxIAH4a8sYqyvy55SvdTk6iiWWH?=
 =?us-ascii?Q?tILEdemDD4OZVkHUVtwwE5sDIMP/qt7VVdoTUR/4gD3alneZxqPc21QbX8No?=
 =?us-ascii?Q?b8BC4JfDwKu7j0FOUZuN4ElP04LpcPWBjKkCUDVlcZ+1hTKk9tsFQO3eQbFN?=
 =?us-ascii?Q?jeq9DYsqhQLDwIPRSCT5lJq0iCaFH5M1X83qPW8ZiUS1SQvTnd/4wtg/vjeF?=
 =?us-ascii?Q?6FxfJZh/0kokWSbPRXjzT9TMnHrimJJEszIdF/TItIEZsXHhWgNjb+/lqguO?=
 =?us-ascii?Q?MzVk7lcVX0LsOqJnYiuMF3Qn4JQwpMTUbkXQtZdAGoOMBBkbUmzJYMpECD6H?=
 =?us-ascii?Q?U+be/Ps1C9KGUgsCxRQu5rYDVO3Pv04b3hN5IpPg0YDmIioqxHSn4V3xFv0o?=
 =?us-ascii?Q?nuKzlKYeZespoj9cR7hEw1jUHulStazb5OB9CqccgBd6aEhDcovlb0LbEUMj?=
 =?us-ascii?Q?2JVspkXEyHOI2s6UNAhI7seEbL4fWGI0ngp6nehRpmT7ptJ1pDjq/yILSAUX?=
 =?us-ascii?Q?hLi/TiFk79C2sc83Z6uk8LMi4L95ulHvm+UOFoA2jzJF3mii+LYja8UayuqX?=
 =?us-ascii?Q?UW8ZE1zNXO7tvbVy2/bVsnpaO4RmeVy4B8Zb1TB/KYHoixKDSgaFnFMlIQcG?=
 =?us-ascii?Q?MPq5inXZR+JRs9LF5Iba0rPMEd3cMxETDDGPXWUQWPh/CUy6qMAErVyXvVkn?=
 =?us-ascii?Q?hppgjcYu2w3H3vEXXthaAYvai6OI/sZXSviamPnNYg85faHaT6uSDEFyvVGz?=
 =?us-ascii?Q?hf0okmVkP1+UaSCuX/2QH8+qso2YVJgBuiO42wKA2zKZDE5sEQD8O4enIZjm?=
 =?us-ascii?Q?rYB+UWSBmk6kTGOrLDCJd3sR6EdXAnmVj23R0FyTXmKBWL6xzgAkSjS098l5?=
 =?us-ascii?Q?hGuTUnEESx6tAVH6FoZCZwSgwROO6xI+/JhR0Hs3B3cg55i/ck44xjwoC91E?=
 =?us-ascii?Q?MQ+DjYsQzjHCShqorQLOY7qlB9jlPI6rlIxIY/stIGZM5DqE1/m8NSYZVqh8?=
 =?us-ascii?Q?l1i2zL60FFABx8aD2TZqWlcahhlS43Dv2XyI2V88ZL2Q4yB9gyYQstbgjQwc?=
 =?us-ascii?Q?wioW9JcNE9QLk41q0CFn1AzcCnIOgeCd5Nh4JyBHTDw3WS/x6DSbUKFQJS++?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a93b8da5-ee8c-46c3-60c1-08dbb60694d7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:12:38.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zhy+8mPZY4QdAvEfn2umk3PlF/KWgp1B400huhBoMPCqIM/x1ME64/ZZiI++rdoAy6zeO1ZCoC0CdH0a+oOEjrFBN2RDtSWK/xcdXbXwIrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Report the carrier/no-carrier state for the network interface
shared between the BMC and the passthrough channel. Without this
functionality the BMC is unable to reconfigure the NIC in the event
of a re-cabling to a different subnet.

Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>
---
 net/ncsi/ncsi-aen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 62fb1031763d..f8854bff286c 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,6 +89,11 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
+	if (had_link)
+		netif_carrier_off(ndp->ndev.dev);
+	else
+		netif_carrier_on(ndp->ndev.dev);
+
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
-- 
2.41.0


