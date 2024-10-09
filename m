Return-Path: <netdev+bounces-133722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF871996CBE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E6FB222EA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8319924D;
	Wed,  9 Oct 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAPck7UI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52DE192D6E
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481944; cv=fail; b=SHtYA6ShJ4T6HDoTK3tqKaM5lBumIlR5N6JJ0ToI8iD6PtpPy9K+Y6gK/gO1ORpgLzk0Hz9lJudZ0Bo8CziRqroZZxc3wPJM+OhfwLMLwm0CZWYhQIKouyx02sJB6lLwnXmMFHA0HQcmBrMhLPUfN1fbjX1kuxFhVikKYsY1O4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481944; c=relaxed/simple;
	bh=50unyniaVRRdVMfKfZEBthN7fkUDtWrpUWd7PEaHHwA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HZd+etToDjCXB/5SwO9J1SfdXVJb+GQG5ebl6jSaxGY9BVjfPYueystqSo6ZQfVhMI3ilXHLdXjrzgy1grh8p+xhWm+KjqEr86/Sd7D9Xyzi1TfxG1V4o/YbawRUfw3T8C1u8YUxl8RGIV4f/IvEk3QZhJcq4llq2GVXiLUGR30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAPck7UI; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728481943; x=1760017943;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=50unyniaVRRdVMfKfZEBthN7fkUDtWrpUWd7PEaHHwA=;
  b=XAPck7UIxI0mQPjP/w72vfmFV+WGMTNbdJDwaOVEJy0H/jSC6xrPFsan
   IcG3rx/8TkvJtoxv5f5n2HNBflTSAjxVuau2+QKKb5GK3nzwqaIMltmZk
   9pH+8bE3x7ylzEb0rPR1IVB4NohCUQgd5CHrzclhXkZ6KUayOkpQj2oQy
   DMPoN25Llc91OnZBErzcLVE7zlqzFAqgIgiJroG/l67eVdJH3yLm7C/EC
   yB43guKGwwBlRFriUHdCF8wW7zn5JLj7VoaRakHuT/8GHkpHkiuA2y5+P
   JP/K2Lti5w4B1+I3IrW7ziNpiwJQkoqe1qR8OJ9ANYL93+qYABl4XY91S
   w==;
X-CSE-ConnectionGUID: LPmabRo2TlSyn0gT66227Q==
X-CSE-MsgGUID: rJ09VyYzSTCgl4IutZ5/3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31677043"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31677043"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 06:52:22 -0700
X-CSE-ConnectionGUID: 3F6Sg2neRFmsWaWvG41+4g==
X-CSE-MsgGUID: GLsdCPbTTfy8QMhnru1zBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="81058511"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 06:52:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 06:52:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 06:52:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 06:52:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 06:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEH+hX9LOjSi3KiW9ARDL/l4dIvd1le6seLVlvYaSq+wjqmsAoIbqtK0XCxatiHxrZhxrvDH8RtCqjmj+1Fc5LzoAS0SVY6nsQx8pBp7g7cvWU4sNupfnyjqo923ex527aajWvFWstKY6xGuYJvYW3bku9ldcITQS9UzNxc6rQj1GDeQ1JOueavhIC0z35bu6kwvYMwxVpI6RpJtOrYcSYOuk0NuurVleiNIgO9nGHwx19sUBWIjzXzTM2YjdU1r8Lp+RzgXCfl+zHqFUFSmWZTAHGpAp90qCNDsuG4IEg5bHEosMzD7FB3FjcxvCPqmcQvfiSB88Mc5IjimMBNb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1lCRJazeHpfaRCaOueIz/fz7TzE81r7MtWGEecOFc0=;
 b=x234v2vbh4z/iFZ3VtRKQ+M3K8iYhShgYsk2jfa7zsWIba4w+kuw2eMpXyCSefZm5RcNwnZHlRaJhl/JUsv+QDRaPYAMWZ46IQZlkIcp/ICjWy5SHaynXxWcNTj+Y9W/6ViXSmWdsh8YCjnrvAiPS3FDtG6EwCQAbc+QMW/rYrjWyoSq2EbkLEjfjKx8pzeR6/ilQTk1kothN3sM8wvy7nk52gWBVl9fpUeWxuw6G9vId8tUhATZV43qklk1OQwITHqSl0BMmH7S84zD5J//oyOhkrdwihWPfoV+s5theEOhYW+R9HB+ogvc+rVOuLl3pBXZ0uu2AU0GOJPA9AZ+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 13:52:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 13:52:15 +0000
Date: Wed, 9 Oct 2024 21:52:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gilad Naaman <gnaaman@drivenets.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Gilad
 Naaman" <gnaaman@drivenets.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH net-next v2 1/2] Convert neighbour-table to use hlist
Message-ID: <202410091622.3d66a78c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241006064747.201773-2-gnaaman@drivenets.com>
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: f80a0ff0-9a2f-439a-d1fb-08dce869956c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P1wOJIBAPsQNAlCwT9m6oWW5VjAhC9rdlR3UThAvfgTOHwAwb9nTb2bW6ceW?=
 =?us-ascii?Q?gzKClweDrVzQv101+Wpr1d64Vvm9EKu4dCePhPDFDG8oH2dwvbosLAbHh+c+?=
 =?us-ascii?Q?ZWa1tHvFyEE+ToI8PGn/IsIC03f1d8F5wYBevn94ExIH1hcChYWb70gB9ZoH?=
 =?us-ascii?Q?GJZ6kNf/TbdfIGN6AqOWW1eeSgVYwLFd2AIInyRwV/49elygSGSNojVIt42x?=
 =?us-ascii?Q?Bm94JiZGFCOtptkolXjoLU87Yznk3cb1OdsZD1s/YQfFE2jRLU4xgChBzHAK?=
 =?us-ascii?Q?IGeRXq0C3jTaMgAdwes91rYBDHzvuAS9qf8bdUFzuz7dX/+rkl70MZjRufR/?=
 =?us-ascii?Q?S6mpRymlwK8EMfMgFti1yilsfz9Ww8boDTRLlrAymcG4Txr586NZfmR1XkB2?=
 =?us-ascii?Q?8C4vHCmbtFULtveH4tyM8RGFGX7u/ezaJ9/NPzpLRSzhfZODOr2SXjcX4utu?=
 =?us-ascii?Q?Oa/HRFE5Mik9NMUdJh2gY9LYcd3YOgcWTCsv5obpPdLvZdh4uV7wFhAlOLjb?=
 =?us-ascii?Q?rOva3CBVXyhravZgEbV9XrwYkQInkBZ2+363zPYywbNoUxTieN+cWSaXPRiA?=
 =?us-ascii?Q?kpFng/55m/Z4pIG4zdCISJ3LsRG7podIwAvXpC56ODH4jqoj9lqdtKU3+oVZ?=
 =?us-ascii?Q?2vDaIL9y6Qmz+6JvQSx9hDomRJGLQpAyqt0sra5F3uRaTEST6nOt075/vLcu?=
 =?us-ascii?Q?D6b6urIuMmKZGCYMbdpW6RgpnAO2BbqzVs9xB2UcJ28ow5M4mVaq5BwOBmR1?=
 =?us-ascii?Q?BVDPub0pcWAm0l+a94NJUZeHb2gITj8PWZU4LOCt7D0SKnysUs1jYnNxcmwL?=
 =?us-ascii?Q?BNv8GhUd7ikDqXqOP2OAqTzFefgQ6CN+YHNHoQy2QJFymSHAOQh2BSnRrrXP?=
 =?us-ascii?Q?l3LZW3zhX/4X0X+79tsZNmxvd5oQfyMR7kFvh6uktUMz01hbKzrHhEm43gcs?=
 =?us-ascii?Q?sWImGq16+c5lG3SJ+waUuq0XCAAgUkn/uYud9HRsaURc38MjAQocmFC1vvGd?=
 =?us-ascii?Q?TrNMVX5xiBCw+G/Mlqkl5B90aua0xux+6s+/eOTQXWJXqjqF6f+4XqKY1rty?=
 =?us-ascii?Q?q+HMz02bV/UaqbBezLQSpomzFhBYvAZL1wPH3l8eHc2ANtolRA4c7nhZj7am?=
 =?us-ascii?Q?g8hYoMAfIPyBept2LkofgRzTTuQWeNBo3Pxb1oNQwYGK5IBAoukxi0fwvUeV?=
 =?us-ascii?Q?7SLbiu+gRnWP79K2PCkDl5TBKe/AYPsVZaz8zjvNEI+L9QKSsP9v3lE+KtA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?631xWOuy1KtQRoCUgkX0m4bQULTdMSTM9w4+62ToeJSVh2bjmyEC++I/K/QK?=
 =?us-ascii?Q?zqifYlFlmxZfuTEXFFx9czoIfV5n8qEGDWDSscnrCyeTtOELyvp0m9vOEHf5?=
 =?us-ascii?Q?4jjw3tmTzPZMiVg2w2HIH6PuQ6eC2rpXrZDyMeuiYzLiA6OoeRI/7u6FFSK8?=
 =?us-ascii?Q?l9EQlGSn+kCmqL0lt14mWA+NKdih/kk8ZvjzRKzJPvFDqO2MdxKZODb8dXhg?=
 =?us-ascii?Q?Tex7z6nVmHR6xKnGQmyk4pLnKrQ2TnmFWp+ZCWVpsJ4SyLPc+pfYRwesoTdw?=
 =?us-ascii?Q?gZHHO73mLZ5P/uI9vVOV3uLNlwWdF83avi8SjJHrxPqCqOx8RLRbU/Kg3SUd?=
 =?us-ascii?Q?5V4E1p00IqrUfnkUEx/u4ewKrvgzGHnqhVrYRwHiFv0TBcfA0oAnJyT8WSog?=
 =?us-ascii?Q?63gBu9jfWz9FShTAKqzPs54ijE72B6T/692VxQ4u9+5uzH+t/xSTamYhaI2q?=
 =?us-ascii?Q?u+P4+sXfhgnzeOn6Doou/mYe2uWd/tnbQPNrmwMR+RDhd9524PDOCmq2YJwQ?=
 =?us-ascii?Q?vJ4xNT5gFNpi5mtguCQ7jbUUnwzTSb4fJR5TRvhML4pmHKqYI1EtnovT3K+q?=
 =?us-ascii?Q?0zSzj400oNlSdjmNisU422hMvYoYJyu4vxU3/fRfPdqgsgPn/AxJlP2IYi35?=
 =?us-ascii?Q?RoHWr1LHSAaow0xSmCcah28wJxSfVw2DHizXhOnGf9GYHMj1Z2hhdhGD2Iaa?=
 =?us-ascii?Q?fBuOiV6koVfH1FsJeTeFgaxeUeUahMSdS9HwJc6zh1RsraC2D1TNo1X0+r+3?=
 =?us-ascii?Q?dVGRa0qdW2L7lPIk3YRhejTCsRDnDH5P6zrsH8sQtB1TBFtLUdbmy/jd9FH9?=
 =?us-ascii?Q?LrF01MXCVdyaAJlil0duK6Z6G3T5MU1QsqENEkE0d/dP58A17YMKFwq44+5I?=
 =?us-ascii?Q?J77RuJ930xPf6AlAhECNiKc10I1uVZCx9X3UKB0HFASCFF0xZ7TrwRiSM7/6?=
 =?us-ascii?Q?NPFFhe6iHUKgK9ST/AQI9bDya5XTXz35DC4nyu4d2STEcDb3lh38EXWI/hmr?=
 =?us-ascii?Q?iunvU7LwyM9w65teyd7p83bSwjGkZWzLh4NGYh2nr/lZkLAqPy6ePUt7Jo49?=
 =?us-ascii?Q?kCYTS/YzXGAKExCoyYsmhC8KaQplDBLjXYP0J/aD29hLw4F75ug/RL52xt8u?=
 =?us-ascii?Q?NtopIRq4vrzjylpus6FmZHycbjVSRBOl3qo/E19gkt69yyy6lMVzsG2Hlmpn?=
 =?us-ascii?Q?OBnZ1l3gKBYUQLBrlGxFnnnCf0tRZlF99/dYuww6aWXplR8PX5lXEUC3jxEc?=
 =?us-ascii?Q?+oanm5mggmtWuzQnZnPNn0fAfqxWIfidf0d03vFV8KqK97faxmhOn8h8KDKz?=
 =?us-ascii?Q?RE4vLhhJQ6mHyeE3V+fliD//zK5ImAMT4ZdoFL4dBuBuraf889zCPwjJHGM+?=
 =?us-ascii?Q?F5720E4WYcoxH87dhK1DQagoJZBwoFQrQGAV6PXid+YNuoZtDRWWMc7JiF4Q?=
 =?us-ascii?Q?p+HGXsGJkgzMgOv8EsiPxZodlmlTDWtQXjnBoz2DOBui4ytWxoQb+JioTQjH?=
 =?us-ascii?Q?FsahUVAJ59C4OAuYEt+WUsXrJT8Af7hd66eqiGO3Tyt+DaUqjGRdknrv+x0i?=
 =?us-ascii?Q?it/1H0rsG9bf3137x1SzcBZwXHphDoJ5vJ836eNCxAP4WOBdVY7saMx8TJK2?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f80a0ff0-9a2f-439a-d1fb-08dce869956c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 13:52:15.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKfId6tM32fzzvmjudcoDXri5CXqZwY1tYqzgFqlANw9Oat5iQO11thBDJNQzYZ5uUeawuOoDhqyMkIYB2l7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: febd2a80c498e3be8afdfe826ca49966bd9aca9a ("[PATCH net-next v2 1/2] Convert neighbour-table to use hlist")
url: https://github.com/intel-lab-lkp/linux/commits/Gilad-Naaman/Convert-neighbour-table-to-use-hlist/20241006-145017
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 8f602276d3902642fdc3429b548d73c745446601
patch link: https://lore.kernel.org/all/20241006064747.201773-2-gnaaman@drivenets.com/
patch subject: [PATCH net-next v2 1/2] Convert neighbour-table to use hlist

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------+------------+------------+
|                                                              | 8f602276d3 | febd2a80c4 |
+--------------------------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address                  | 0          | 100        |
| Oops                                                         | 0          | 100        |
| RIP:___neigh_lookup_noref                                    | 0          | 100        |
+--------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410091622.3d66a78c-lkp@intel.com


[   42.953184][   T23] BUG: unable to handle page fault for address: ffffffffdeaf2215
[   42.954660][   T23] #PF: supervisor read access in kernel mode
[   42.955397][   T23] #PF: error_code(0x0000) - not-present page
[   42.956085][   T23] PGD 3441067 P4D 3441067 PUD 3443067 PMD 0
[   42.956877][   T23] Oops: Oops: 0000 [#1] PREEMPT SMP
[   42.957461][   T23] CPU: 1 UID: 0 PID: 23 Comm: kworker/1:0 Tainted: G                T  6.12.0-rc1-00350-gfebd2a80c498 #1 b68071eb3c38aea083990c8ab76066a73681badf
[   42.959169][   T23] Tainted: [T]=RANDSTRUCT
[   42.959657][   T23] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   42.960816][   T23] Workqueue: mld mld_ifc_work
[ 42.968090][ T23] RIP: 0010:___neigh_lookup_noref (include/net/neighbour.h:310) 
[ 42.969009][ T23] Code: 00 00 48 c7 c2 de e1 0a 83 48 c7 c7 fc 39 1f 83 e8 b0 ea 08 ff 48 85 db 0f 84 85 00 00 00 48 8d bb 28 03 00 00 e8 31 18 1a ff <4c> 3b ab 28 03 00 00 75 0f 4c 89 e6 48 89 df e8 59 f8 ff ff 84 c0
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	48 c7 c2 de e1 0a 83 	mov    $0xffffffff830ae1de,%rdx
   9:	48 c7 c7 fc 39 1f 83 	mov    $0xffffffff831f39fc,%rdi
  10:	e8 b0 ea 08 ff       	call   0xffffffffff08eac5
  15:	48 85 db             	test   %rbx,%rbx
  18:	0f 84 85 00 00 00    	je     0xa3
  1e:	48 8d bb 28 03 00 00 	lea    0x328(%rbx),%rdi
  25:	e8 31 18 1a ff       	call   0xffffffffff1a185b
  2a:*	4c 3b ab 28 03 00 00 	cmp    0x328(%rbx),%r13		<-- trapping instruction
  31:	75 0f                	jne    0x42
  33:	4c 89 e6             	mov    %r12,%rsi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	e8 59 f8 ff ff       	call   0xfffffffffffff897
  3e:	84 c0                	test   %al,%al

Code starting with the faulting instruction
===========================================
   0:	4c 3b ab 28 03 00 00 	cmp    0x328(%rbx),%r13
   7:	75 0f                	jne    0x18
   9:	4c 89 e6             	mov    %r12,%rsi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	e8 59 f8 ff ff       	call   0xfffffffffffff86d
  14:	84 c0                	test   %al,%al
[   42.971354][   T23] RSP: 0018:ffffc900000cbb88 EFLAGS: 00210246
[   42.972125][   T23] RAX: 0000000000000000 RBX: ffffffffdeaf1eed RCX: 0000000000000000
[   42.973071][   T23] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   42.974124][   T23] RBP: ffff88811af34b40 R08: 0000000000000000 R09: 0000000000000000
[   42.975040][   T23] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88811c6fa028
[   42.975974][   T23] R13: ffff88811bc7a000 R14: 000000000000001d R15: 0000607bd0004020
[   42.976897][   T23] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[   42.977854][   T23] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.978590][   T23] CR2: ffffffffdeaf2215 CR3: 000000000343f000 CR4: 00000000000406b0
[   42.979442][   T23] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   42.980369][   T23] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   42.981266][   T23] Call Trace:
[   42.981636][   T23]  <TASK>
[ 42.981988][ T23] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 42.982475][ T23] ? page_fault_oops (arch/x86/mm/fault.c:715) 
[ 42.983091][ T23] ? exc_page_fault (arch/x86/mm/fault.c:1479 arch/x86/mm/fault.c:1539) 
[ 42.983677][ T23] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[ 42.984326][ T23] ? ___neigh_lookup_noref (include/net/neighbour.h:310) 
[ 42.985102][ T23] ? ___neigh_lookup_noref (include/net/neighbour.h:310) 
[ 42.985789][ T23] ip6_finish_output2 (include/net/ndisc.h:368 net/ipv6/ip6_output.c:128) 
[ 42.986377][ T23] ip6_output (net/ipv6/ip6_output.c:251) 
[ 42.986913][ T23] dst_output+0x59/0x64 
[ 42.987506][ T23] mld_sendpack (net/ipv6/mcast.c:1823) 
[ 42.988064][ T23] mld_send_cr (net/ipv6/mcast.c:2121) 
[ 42.988539][ T23] mld_ifc_work (net/ipv6/mcast.c:2653) 
[ 42.989034][ T23] ? process_one_work (kernel/workqueue.c:3205) 
[ 42.989680][ T23] process_one_work (kernel/workqueue.c:3234) 
[ 42.990204][ T23] ? process_one_work (kernel/workqueue.c:3205) 
[ 42.990790][ T23] process_scheduled_works (kernel/workqueue.c:3310) 
[ 42.991361][ T23] worker_thread (include/linux/list.h:373 kernel/workqueue.c:946 kernel/workqueue.c:3392) 
[ 42.991863][ T23] ? drain_dead_softirq_workfn (kernel/workqueue.c:3337) 
[ 42.992581][ T23] kthread (kernel/kthread.c:391) 
[ 42.993075][ T23] ? kthread (kernel/kthread.c:374) 
[ 42.993578][ T23] ? list_del_init (include/linux/lockdep.h:249) 
[ 42.994107][ T23] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 42.994606][ T23] ? list_del_init (include/linux/lockdep.h:249) 
[ 42.995189][ T23] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
[   42.995794][   T23]  </TASK>
[   42.996192][   T23] Modules linked in:
[   42.996717][   T23] CR2: ffffffffdeaf2215
[   42.997192][   T23] ---[ end trace 0000000000000000 ]---
[ 42.997790][ T23] RIP: 0010:___neigh_lookup_noref (include/net/neighbour.h:310) 
[ 42.998628][ T23] Code: 00 00 48 c7 c2 de e1 0a 83 48 c7 c7 fc 39 1f 83 e8 b0 ea 08 ff 48 85 db 0f 84 85 00 00 00 48 8d bb 28 03 00 00 e8 31 18 1a ff <4c> 3b ab 28 03 00 00 75 0f 4c 89 e6 48 89 df e8 59 f8 ff ff 84 c0
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	48 c7 c2 de e1 0a 83 	mov    $0xffffffff830ae1de,%rdx
   9:	48 c7 c7 fc 39 1f 83 	mov    $0xffffffff831f39fc,%rdi
  10:	e8 b0 ea 08 ff       	call   0xffffffffff08eac5
  15:	48 85 db             	test   %rbx,%rbx
  18:	0f 84 85 00 00 00    	je     0xa3
  1e:	48 8d bb 28 03 00 00 	lea    0x328(%rbx),%rdi
  25:	e8 31 18 1a ff       	call   0xffffffffff1a185b
  2a:*	4c 3b ab 28 03 00 00 	cmp    0x328(%rbx),%r13		<-- trapping instruction
  31:	75 0f                	jne    0x42
  33:	4c 89 e6             	mov    %r12,%rsi
  36:	48 89 df             	mov    %rbx,%rdi
  39:	e8 59 f8 ff ff       	call   0xfffffffffffff897
  3e:	84 c0                	test   %al,%al

Code starting with the faulting instruction
===========================================
   0:	4c 3b ab 28 03 00 00 	cmp    0x328(%rbx),%r13
   7:	75 0f                	jne    0x18
   9:	4c 89 e6             	mov    %r12,%rsi
   c:	48 89 df             	mov    %rbx,%rdi
   f:	e8 59 f8 ff ff       	call   0xfffffffffffff86d
  14:	84 c0                	test   %al,%al


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241009/202410091622.3d66a78c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


