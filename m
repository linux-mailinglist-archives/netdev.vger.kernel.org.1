Return-Path: <netdev+bounces-46714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656597E606F
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 23:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279F01C208D2
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7EA374EE;
	Wed,  8 Nov 2023 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISt/AY9C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7500199A6
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 22:29:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B75EA
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699482589; x=1731018589;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=zNrYrJtiFOXp7+8CCLE4o7IE6YY1xkD6Kbqo9ej1Tsg=;
  b=ISt/AY9Cr572BwhRP+4iEzvXLNfd3IuBUapo4JIm4AZN7QVVZ/STMAGb
   JBLKZxOtBn6lcZ3pHIRDkoqXwFX2Zx3UDCCB+8DKWP7C5S2BeFFTMwUs7
   qHEjAo/bqz6gFt02hS7rdRkQKs6ic+/EYzOQk01/MRS5O8Kp0IuZep8xn
   MA8tlr18yzWJ1AW1KlDq0Bs+bhv4Lh1glnG5FxSApPGfk/cHmkMzVoLqZ
   PaWk4KNhJHtd3jO1jOHnpPD6mnGmyhAHl+0yVnYLSCfXv5X2A+KrrwZKk
   XSnB/4zvX1ms6yAwBsqET0X2iPxtXgocX6LqR/9N+u1Rfyz+I9sGCe5fy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="454171817"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="454171817"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 14:29:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="798151867"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="798151867"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 14:29:48 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 14:29:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 14:29:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 14:29:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLISHc1igTOZpLSA9lCTBGmvdIJKCy2BaXyrk8Pbtb3oQQJgT7bGg2Tsz9yaInTfTCoK1Mffn2QCuAjiDuGhCJVQbhmTxRbMvblWUpj8IFD1PfZBWFmE0+vEg/OX4KPi6v6FHgieN9TP+gjAlVKEeVYPZApIikmATCNu5ztzxlDEsmd6vkYOhwvI+kFzSGLTdKeTphlelkHyTyUU60Lon12DYlWDyNlakfGE6+TnjeR++XxAbTJbvf8+Cj8B6iFbB7E6k2eH0wbsOLBSInBt4MJ8K8AiNA31+U1bHebkLHpm5dx9YGCuxg+3TQGJ7C89LYTTaRsMdCTDgq8UL29LCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTnNWb6NrWzn9SkvGxFUmgOjxZ6lJdOekcXWvdGBqEA=;
 b=EBZKqDCM0eyTDDwnr+CTQgSGRtrYO7IuCYXWD2pdSQ0mhbXiVouScYAMIHPsp7AZb9jF2Mr7Gb7jV7J/9Yj7zkznI8AWNE3SKqn4Bqs2PNEgsamuKXOqdxprHodbumB+Co+M8qbwJaCL5PzV2EI2pwqWeOhMgjLvzJMVATHyPrgjS4KhJLKapCFTXx2hNhx2UEx7Aotd9dm+H5io92Dd2MXUCqNXLiGfBQ/3ll4c2vjUtqfLU0QWZPbajO9JzuhujFUrZ+yZGZi8Ijoyeo/SJw6sAWJmPtv+hsZhL7dfaipNsbZpr94kWNb3Gge7HbqvO8SGlwLEA3XR8BJvLvMeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 22:29:45 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.021; Wed, 8 Nov 2023
 22:29:45 +0000
From: Johnathan Mantey <johnathanx.mantey@intel.com>
To: <netdev@vger.kernel.org>
Subject: [PATCH][ncsi] Revert NCSI link loss/gain commit
Date: Wed, 8 Nov 2023 14:29:43 -0800
Message-ID: <20231108222943.4098887-1-johnathanx.mantey@intel.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH0PR11MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 49628330-31e7-4179-8508-08dbe0aa359c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihykd/hZdgQmwlaivY/QH0l/3hm6PN55dVUxXSpghFJQtbrxT2sw6S7ulRKcwatP3sBJIz8VOPDnsdKPL9R50jDMgMQNjRvt8Kc96EEDxQM5SqrRYnD6Dy9a0YSpby1qdt4488GEIK6FJqdVqVqDp6KoM0f3CGfus5XVEtUNCaqZAV+QP5WFH0YVtFSgENxM2nL5V6ZPhOWzXPwG8E8w71oTrt/s0eTq1szntKWXrj67y9oLvp4l5opijMmlSauGQaQRiijMRxhZqfUVs5QfyC7ruc17SiI8pl9HHg81fgKkSMLx10h3B1zWwX7KiVsErSawqYXn2uKNRd6qmC3FMJJdTSYF7E55vUq56NG5pdwpI9nIwBMTl2ngTjEooEXQnLwGpuc0jlUCm39xuyHP0yk6ymVWF5JZyKqOZq26tU8XSopkKcJNOIi+F33QE3L5rSg8GcJVj/cgU3dVueb3ImXd4E9CoKoxHQq/UkpXwy+e2/K9LNNVYnTvHNcFpppLPjwDejLunqGCUwNJIqPFAQ1S6uhCxUEhYeOhaDGU16Waa4C5zCO1GiAMYD6ixPOO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(82960400001)(83380400001)(478600001)(6506007)(66476007)(6486002)(66946007)(26005)(66556008)(6916009)(2616005)(6512007)(1076003)(316002)(5660300002)(8676002)(86362001)(36756003)(8936002)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eS+jEM3pReQznLxzJguuXcz2QD4cLalrILPr1dsG/Np9UIAqDIT237Wg2eGZ?=
 =?us-ascii?Q?2B0W/HEvDdeVOoP81BZkVFcAXk6KdhyuGkcb6tBL4R197ODZUJDsqafg786P?=
 =?us-ascii?Q?d6k79pH6lpprV3NDQtrdjiibNu13JGupcwrf3QgewAjCTTTUlW6C8/jgebd2?=
 =?us-ascii?Q?PasXuClvmLSEJ+1mxca+5IehZKpTp9m3JZ4ekf3a2dj8xl2py7HVbKHZPyiy?=
 =?us-ascii?Q?vNiR4y3Zx3gocsuYMesuu06f5D8L6CUEOS90CSxrCakepTUx9nW7hfkcyVdR?=
 =?us-ascii?Q?RledtqXUDungv09qLNIFh7SWn89SO9Dbh/+TBpG9QoOSbWBZBGEpG9mfVFKO?=
 =?us-ascii?Q?JbxbxHQwtzuKcH41ECKwz5fBgxtKNFc96bzaKSHxH0sHlROilTxjoy7ylHZL?=
 =?us-ascii?Q?rJp9YEaS43FwhbJxf/wRXAwFhSOuBmIbzDagc1WAOkHKEGKY5sisml/g6IMJ?=
 =?us-ascii?Q?9FoNnmrU9lvi44rTEjlxjzGBAXz86biHksceVFpmRauhcrwCdc0hk8B+mYmI?=
 =?us-ascii?Q?qcKO4MPIVlBYS0gnqpMr1+roBsk7JMU8jHowjf2JmBAYLZQx+CPvwqaFWoWy?=
 =?us-ascii?Q?W5m2uxTlV2iXgawfvGgxeewUlEmYcbQHDxDYesqQDBf378mHZF/lB2hVEDZp?=
 =?us-ascii?Q?xvsW7dQBOA3Eb5U08W4qItR7S2Ws9hhKQ1D/hfoeoS07zhIAetJC1MZ07sWV?=
 =?us-ascii?Q?hluRbqGDtVsEtoFyh9gfzkMI7tj6R1G1Pj9KhGWbjqvDecRQmCfnzRjqtJ8h?=
 =?us-ascii?Q?h1GS4fYN/YCywv03mWcWlk+VTIrX2hR38SZlgNWGUzaIF0kx3mRRtv855tUL?=
 =?us-ascii?Q?OMDe9lsxdN5f/O//92WtZOn/6cug9Fj1oJMQx7oqWCu7/l0z+C/Ezjg1dERN?=
 =?us-ascii?Q?6GyqbAx1lkrPb7YgMfuHowR5WSNK2d4YnD5Ez2UKAe+IVvTRythVUIrdxUJq?=
 =?us-ascii?Q?Q2ToQveqnXu1QawMLNh1h4zJrCyuWQvjMLOhJY6otA788xyuXe7BsIsXjbgu?=
 =?us-ascii?Q?MoC1pfAqOWFIjv2028TbDVVv0A6KPSrk8oIm6E4nUjg6tqb1ANGdQAIEMqCV?=
 =?us-ascii?Q?cTCVGbeGkg60XjHVk6PJuk8KrdnDh2W/PaZa70u48xbmVa/HKzMmjjgXyt7V?=
 =?us-ascii?Q?ye0CaMGyJF4t5PDPvryVKH0Qd4vYy//0VtKrveNdP0wnF5JuDI24M3xf3Aj4?=
 =?us-ascii?Q?r3wm6BRVA5t4PpxkryjHIRkkOEIgobbTss3j5kSeYlS4b6RTpVcyqPTXvF99?=
 =?us-ascii?Q?HzCoolxt3HqZIAfje8x4KaS5e/Dv0TUz17J5OmFI0Zck/ylbaLuzqF+BqNwW?=
 =?us-ascii?Q?zTC1UQSwQHppwhFdq6JaAb2+0nrXtaAFHZrKY3YmypePLDytBYbwZa62CNAK?=
 =?us-ascii?Q?8OI3LENNPmfonDbK5H0dlcXh5L/6iYN/pRPsdEdxRimHNazLvaJchWkHmuT8?=
 =?us-ascii?Q?dhIELCPrbdCg/4CAwJrF0fpnViRXcaDAFe7CcjTuS8phWL1HGiosy3uaR0F2?=
 =?us-ascii?Q?3f6AGHA23n7GxtZO3hFtT+Acn++uPl3fs0w/jOMcsLH+DmAeIj3MiskAK2qN?=
 =?us-ascii?Q?1ymsNVSkWww+7zAfC1mM2pvamUSQolms8tPMxTLiaIgFcr/g7votljdpKiNs?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49628330-31e7-4179-8508-08dbe0aa359c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 22:29:45.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iJgtv7G9tCCNVl9tO9zchCnxGvlrtLyijNGhf7bqti4ZnCUmEw0RQRH/uAKetejPOjTDg3r6J9yC51FKSWy6HRo8/LuC+Ju/dnNq4stbAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com

The NCSI commit
ncsi: Propagate carrier gain/loss events to the NCSI controller
introduced unwanted behavior.

The intent for the commit was to be able to detect carrier loss/gain
for just the NIC connected to the BMC. The unwanted effect is a
carrier loss for auxiliary paths also causes the BMC to lose
carrier. The BMC never regains carrier despite the secondary NIC
regaining a link.

This change, when merged, needs to be backported to stable kernels.

Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>
---
 net/ncsi/ncsi-aen.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index f8854bff286c..62fb1031763d 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,11 +89,6 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
-	if (had_link)
-		netif_carrier_off(ndp->ndev.dev);
-	else
-		netif_carrier_on(ndp->ndev.dev);
-
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
-- 
2.41.0


