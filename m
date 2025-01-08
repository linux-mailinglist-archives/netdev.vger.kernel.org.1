Return-Path: <netdev+bounces-156113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A76A04FE9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C341657B4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD7C13CF9C;
	Wed,  8 Jan 2025 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVf17tE8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713E2AF04;
	Wed,  8 Jan 2025 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736301391; cv=fail; b=lMNedBrGfXpb1Dy+F9+xc5d1CfR4yvfOhG7I8KxlUf8ietuNvSUea1pLzjldydkSv3d5/eqPxFZtVSBCKlbDqIyKaN43xbXXe2COuIioNdQDrnq2WJQeg5o90SQ++bNTF3ap8S9w0G5MyjTaC/MWZ+u6Fi4Fwy99Zkv/bYU14dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736301391; c=relaxed/simple;
	bh=Vj089OlnmJ2j0aRUlQkH3RiGrFRvlq3YIKIjpyy7jy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZuefQSMBZJ7gBRIegOOweBb+tcmmnsedE+O/qirmNOJjcB6d9ZDsNkm/Qjkyn0jfEWSHiWn8JF4VKtwnSv0y4OjMcK7E9uvPLmDiTAc3I9eHzunz4ZFYPs7/2h9lY7ta1a1DMduYws6qrH5ARi8sm7WlamaqoTxnH/F9EBouTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVf17tE8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736301389; x=1767837389;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vj089OlnmJ2j0aRUlQkH3RiGrFRvlq3YIKIjpyy7jy4=;
  b=ZVf17tE8LFKceiBh24G0sveRigFj83UkCdJB4cDSWUc81dE3NoOoyghf
   iT3/gVltLLD3FHejEJVtOxSeXmBsd7qbS8wgevK0DuVdfYQWi/gIJq1WD
   S0zsd+oGtdkZwPWGD6wtXwR/K5/Af9AMn8Ql+sim8H/knN3nx1ilnrGXi
   WLxDFPpwXz49f1s7kQuWmsCZkXjRaJBbvYI+XDMW7Nv+WP76nUayZoDI8
   1MKN5Ie0IrURNsyJfYfhyqvPEq+P7dQNpf7dcqxZ3g/jGGsdeSQaMEPHj
   kHNE4wnVq5ak3Q4SI4krojHBmUm/hz0WhgaA5Bf85vziA0AnibWnbfxeh
   w==;
X-CSE-ConnectionGUID: eLh66uakQour9uNHhonP9g==
X-CSE-MsgGUID: QnFct9TCQ9O5zTmnb64DcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35803939"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="35803939"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 17:56:25 -0800
X-CSE-ConnectionGUID: xFOdqOvRRPKY/Wpyl7nANg==
X-CSE-MsgGUID: qyaQr2JSSAemlQJ/LsntvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126238079"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 17:56:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 17:56:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 17:56:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 17:56:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcbYtShMKNKXWPLGb0dQyTvVUYgIJjVwQAWnEHRT6VlRondRqVzaBWEQVZpw66SlKIQDsf6/2XTg+N8hC2TznRAxbj2Tg5lhaVTzwcNGOJ96uWLWQioLgSr98K5/uLD6W66IdUNv9wj42hwowKBvre0O4maBt9uMqIfwFIZ70Jt7BfdM5DSQlRiivxvo/PiuOsJpkJ2/dIt5PzLkMufvZS4ujei5XmD3j4ljDltC+lrxgnQujJa6wXo2/65ZSR0OGY3UqEyicQfdbBgdUNbkh4ShXDopQ5+ZP3vnHxLJ655e9q+JyyGjMKJ15V6NyOyljiIVEBf9H0P6Gvwo5GyRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsGvLHZjgKIu3t8Pzzys9LRG+IscuX55lb1z3HXdFA8=;
 b=W1TmZ8kU+vfvdc1+yl/7xiDGJWF59/yGC4gceq9eoUndrxabSynJ2oy9aUFkpxEaUUZBbTcJ7Hri45XPYwkh9tCvANJce1ouqdvi0j1XCpxztd9MhcrMADqAKJGNKqcpIzIxgT8kYlmsBtrbEIzroZKp/EaIdFUJ5itb3j4J9FtNLmB1myyPaTrIWFO5B9CA3IQzPNMs09zfBdN++w51W+i69vmWQyVldXsG3KTeKnupAAl+KogBPWZ4CDL0g4BFjihFdoXrWmJPrkKa7ujhJF8btVUfkZlFk+br7M6KKQt0c82IjqP85jIY3l0K7D0xnQc1HkcS6GPJKCJBy7RzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4578.namprd11.prod.outlook.com (2603:10b6:5:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 01:56:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:56:21 +0000
Date: Tue, 7 Jan 2025 17:56:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 02/27] sfc: add cxl support using new CXL API
Message-ID: <677ddb432dafe_2aff429488@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241216161042.42108-3-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: ad74f2ea-2c56-434a-0fa4-08dd2f87a682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X+X56cBAIPPj7uXFDNTxk4WQBQW3HqxC8OKh/xbt2hdcRT+0kPX8O6X7pt7w?=
 =?us-ascii?Q?HVOt2Vd/p+DJ0VxiTjy8U0Jiuv/VgnB4bWkqWzmVUBwR4mQ7xjqgJkx6hjyQ?=
 =?us-ascii?Q?iMVa09HXZcW2L8Gg1bsel2oqrvqee8bblXRLKJO9oPpdDec4m9MDbqotzdHz?=
 =?us-ascii?Q?8uzp8cWujTVDRExzpfXgFQEabiMAug2XKzJjoGWXf0ajOHKzt2WfIxBQI0bX?=
 =?us-ascii?Q?qo4sgRVDU6T0u60xFLj02GobSRyjyWJ1heTrtx/omU0GtwVzaWkDF9MJdUDE?=
 =?us-ascii?Q?d4DSypUp3kK2n++1qVqYH2vl6dxf1QTDDWL8kQOLg/vOwmd0zhYRkns/Ksml?=
 =?us-ascii?Q?v7P9xPDh9G7NfyVkXVCdN5p4JG3ghdcE2+f74ZCiLkpeQgcVPMkFCcCshDYK?=
 =?us-ascii?Q?tdwyuLiAMKHub6KPq8JNhgKVvERA/uyY5hX0gdHUbNLQgUen9k9/5yEpB11w?=
 =?us-ascii?Q?ZeBg050Y29zKB5X4ynTjVl8VBI/WmLYTaga4VJ73cKf84QTtD0sEqli2XH2O?=
 =?us-ascii?Q?pTvv12C8aBr7SXgLB/1gpFp4hTZgGDsFnXr7ED3LUdNVIiHsIzwAYebKwbB1?=
 =?us-ascii?Q?n8g3/aROVkHIkPzYyRo9skF9iU0FFe7Xga+SOjqpuUdv3x2a5ma4uVz4xgsf?=
 =?us-ascii?Q?S4LIMwhf6qAsvL9+JakSvlql8q9H4vXVKV52aXrX7s1fm2jDNkh5IqdBD6kD?=
 =?us-ascii?Q?tpYJfY3rIDZ7bCcamzSTMQ4K13DbiEChmwpH7dCN9WTy+JAaIlquOJkTl7ms?=
 =?us-ascii?Q?adQN0kfIcv+PoBEBfP3pbdldtQ5tJtOZzB67seGeTMsLWp8QB29kASuGxaFX?=
 =?us-ascii?Q?5+5YynACmkg1JvFXYuKWhlBGSH6c1kzfvwja8AqOChO5crtqaYLI/bz3JHed?=
 =?us-ascii?Q?p+FWl/6smlLvJqv+rdUpyz3KmOJ3Ujg9VqQ9pg4NB2PjqGHivBS1ziBcGB7X?=
 =?us-ascii?Q?1e10k68ZRMzPPuwHISG4sMJhZhmQcxIN7DpdLo/w8R96phm0wm0xHVo8FBmK?=
 =?us-ascii?Q?UXcXX6E5xGmY0LgE0ue+JuWH2su5IsFCR8BO8ARTIJ9bHquRpdllPof7/QzH?=
 =?us-ascii?Q?onUQLuPZ+NkBkT08Vtss9Ki2hkEhTMxbmUbtJ5jPGo2dW7mq3ZJZyyuVN235?=
 =?us-ascii?Q?+xcSd/1tYyeT6DnaLKT34w3+dPFCkj0kiqYFOuyHYEFJKZb2zpp7w7NZ67dU?=
 =?us-ascii?Q?4hals+wgx8TxcQUJp1by9GPzx6DSYnbLaalOKlyTjVPCD3qYt/1u/06O3dQJ?=
 =?us-ascii?Q?lgZkYMH38b9p7gVaSxOpJ+bdcxMGaylZrtWjRehYB0H/jXvxr6EDRykGJgrb?=
 =?us-ascii?Q?kVhLkCxAGChvN+grfsQj7minvi81CSwYsX+QTDrLpycUG44XDzAH5ZrpKqEa?=
 =?us-ascii?Q?vZmxwsvbI1M/0FXWlu746ixim1Rbk8wIsOrQX+oKtPHpyIgSSTCdR3ifp9Rt?=
 =?us-ascii?Q?nXL3tXhxo7o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dkrm5k5s3UBWT5T1YEgCeSDsg+il608l78eB92VCaFGZsKl96YsLl4GuFksz?=
 =?us-ascii?Q?8zZuS1pZfxegl3GMzv84zQzsmwDL0xjf4ObF4wZLmTNgcELfgZVv+apChsOJ?=
 =?us-ascii?Q?vkZpktiX6UypDEyG6lNy8sAi3Pz8qQbaLQYCNiC4pt7gZt9QJMQqcrk/0Em7?=
 =?us-ascii?Q?EMI0i+WWFoZ/UTFuN6YnaC5vOiIW3ErKRVmOTyWe6R1pfIAxRy9obS7gZAAH?=
 =?us-ascii?Q?HXRqjz+q2J58AEVPP66PbmppbDFOfNJpXykMG7eIALeVwYkrmFTHhAXDXmUL?=
 =?us-ascii?Q?Lmg+eVPvGVaTrsua322R4gBz//aNEofCbnTZpF42gT568UoA9pF7X6696fAX?=
 =?us-ascii?Q?QWKmlIfu/QYb5s+VRIqABIrqrMIkunCHpXkHnahdY1iegKYm1mZG6HxM7l4U?=
 =?us-ascii?Q?/gKnA+jcriyUKrlY7PKiKe82RPvfCc0H4amwW0mhoHzaiXarAUWcsHfCaRMT?=
 =?us-ascii?Q?Ux88nYfg7Hk0WisWsQO8jYXUsGPLncdeqY0690KAIU2WYaBmc66HjRcDT+sU?=
 =?us-ascii?Q?bzQ0fYolFK+4KKYIyxADEGGqYeLJUocaNodSk59CEMdapaKqEeU9mEt+ugkc?=
 =?us-ascii?Q?5PpKeIsBIKwNuXEgQF7+9J/+ov12ndgITo7Bmlge001i4UKryDVw6yGJySsX?=
 =?us-ascii?Q?gmUg+62PTsn6XPd64S1uutvIiWgLjMTjGnt2T+veNIVQEkpQBHfJPQeObtvm?=
 =?us-ascii?Q?LydqjEV7o4t8jAkSNLBVUshw4Qh5m4Pgxh5cblzkjWA8T83DyL67xoH9NRb4?=
 =?us-ascii?Q?4jG4xjruzdvP4OMHiyiN7MkbRANEwlobYSxtryI29ZS9ho6Ays0TWk5du+rT?=
 =?us-ascii?Q?2A1P1FdkQ2mzfrkRxeyWb0ce+jwerJG2ap/6NngtjOaR9N5ISQmKWmORCFAd?=
 =?us-ascii?Q?4qMK/cNSvzoxeNNOZkih0Kwxf80U0jqv8BGAPircVbKfT23l3ga+QiMVqQT6?=
 =?us-ascii?Q?DR/QAg5Hh4PMKAIg2AXPwqP0xIAbPJJ4hkLTsnVFqLCKIlRUmin+iRdy2sVF?=
 =?us-ascii?Q?ApefbsYgfU/HX2wFFSvyrHRlBGwdjGq/flu1L/o1OVeMUKjR65SypLS8Y4LQ?=
 =?us-ascii?Q?GBC/Aw+6Nj2y6Ru81sj/nGrk9HVu+R7C0kC+KiHoQ/0ffVzXzbEkJZRFDXpF?=
 =?us-ascii?Q?nrzNkHsz/nPTUn86TMc9sIDiUxWHFqjcUHOd4brdZ02S+gfo2ctlpvFW3SNz?=
 =?us-ascii?Q?E6vpa3gIm1TahKsVutxyjQV4Y9hhlAOvpHyE7tPcnDErsCRxNKxqH6Aq4SEp?=
 =?us-ascii?Q?2u6mkdbM48ZmFVq/KR4rtbYOcMzZVWW6CnP3bGch3yKqu2svws6+LPn4SmDd?=
 =?us-ascii?Q?LxWIXlcv7uSZjuQtzm6963+aypZwecpYvXExDWzyPs/XGgYfl8oABPNXi3Iu?=
 =?us-ascii?Q?M3qWYRRckaiMauS+VaHHt4TOiEoLZ4SACbuNgMdBc2meqwKbtBuKc/EYJuKd?=
 =?us-ascii?Q?yl2PhW/uM0s/WH3yLTmVMCucLCMoqL2skwia/03Ik9oDoTZnJcxHBT8VD6b6?=
 =?us-ascii?Q?0vZ5gEf1jCrfnPcPxRdtcyK9MXFv7y1daWzyhNEp7k40yeBOypR2HR0VZT1r?=
 =?us-ascii?Q?1Ixwc8v8iPVvyouHtcmMOY9T1RBetA7SzkoIFGN3oNctsPJeTC3deTSARGQn?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad74f2ea-2c56-434a-0fa4-08dd2f87a682
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 01:56:21.8082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhNUvKORHfVueUAw/nCcICc8tKPoQDBcyQzehbJswAgFP1LU9wQmc7WF34RxniVb7ofd519sw1Bb0B5/FeucHfvB0IoZd8sfGgXNy4Q2h1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  7 +++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 23 ++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 87 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 +++
>  6 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 3eb55dcfa8a6..a8bc777baa95 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -65,6 +65,13 @@ config SFC_MCDI_LOGGING
>  	  Driver-Interface) commands and responses, allowing debugging of
>  	  driver/firmware interaction.  The tracing is actually enabled by
>  	  a sysfs file 'mcdi_logging' under the PCI device.
> +config SFC_CXL
> +	bool "Solarflare SFC9100-family CXL support"
> +	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
> +	default y


This looks a bit messy, how about:

depends on SFC
depends on CXL_BUS >= SFC
default SFC

...where the "depends on SFC" line could be deleted if this other
"depends on SFC" options in this file are all moved under an "if SFC"
section.

...where the "CXL_BUS >= SFC" is the canonical way to represent the
"only build me if my core library is built-in or I am also a dynamic
module".

...and where "default SFC" is a bit clearer that this is a "non-optional
functionality of the SFC driver", not "non-optional functionality of the
wider kernel".

Noted that all of the above is inconsistent with the existing style in
this file, I still think it's a worthwhile cleanup.


> +	help
> +	  This enables CXL support by the driver relying on kernel support
> +	  and hardware support.

That feels like an "information free" help text. Given this
capability auto-enables shouldn't the help text be giving some direction
about when someone would want to turn it off? Or maybe reconsider making
it "default y" if this is really functionality that someone should
conciously opt-in to?

Otherwise if it auto-enables and you do not expect anyone to turn it
off, just disable the prompt for this by removing the help text and
making it purely and automatic parameter.

>  source "drivers/net/ethernet/sfc/falcon/Kconfig"
>  source "drivers/net/ethernet/sfc/siena/Kconfig"
> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
> index 8f446b9bd5ee..e909cafd5908 100644
> --- a/drivers/net/ethernet/sfc/Makefile
> +++ b/drivers/net/ethernet/sfc/Makefile
> @@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>                             mae.o tc.o tc_bindings.o tc_counters.o \
>                             tc_encap_actions.o tc_conntrack.o
>  
> +sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
>  obj-$(CONFIG_SFC)	+= sfc.o
>  
>  obj-$(CONFIG_SFC_FALCON) += falcon/
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 650136dfc642..ef9bae88df6a 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -34,6 +34,9 @@
>  #include "selftest.h"
>  #include "sriov.h"
>  #include "efx_devlink.h"
> +#ifdef CONFIG_SFC_CXL
> +#include "efx_cxl.h"
> +#endif

Just unconditionally include this...

>  
>  #include "mcdi_port_common.h"
>  #include "mcdi_pcol.h"
> @@ -1004,12 +1007,17 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_pci_remove_main(efx);
>  
>  	efx_fini_io(efx);
> +
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +#ifdef CONFIG_SFC_CXL
> +	efx_cxl_exit(probe_data);
> +#endif

...and add a section in efx_cxl.h that does:

#ifdef CONFIG_SFC_CXL
void efx_cxl_exit(struct efx_probe_data *probe_data);
#else /* CONFIG_SFC_CXL */
static inline void efx_cxl_exit(struct efx_probe_data *probe_data) { }
#endif

...to meet the "no ifdef in C files" coding style guidance.


> +
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
>  	efx_fini_devlink_and_unlock(efx);
>  	efx_fini_struct(efx);
>  	free_netdev(efx->net_dev);
> -	probe_data = container_of(efx, struct efx_probe_data, efx);
>  	kfree(probe_data);
>  };
>  
> @@ -1214,6 +1222,16 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
>  
> +#ifdef CONFIG_SFC_CXL
> +	/* A successful cxl initialization implies a CXL region created to be
> +	 * used for PIO buffers. If there is no CXL support, or initialization
> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
> +	 * defined at specific PCI BAR regions will be used.
> +	 */
> +	rc = efx_cxl_init(probe_data);
> +	if (rc)
> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> +#endif
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
>  		/* On failure, retry once immediately.
> @@ -1485,3 +1503,6 @@ MODULE_AUTHOR("Solarflare Communications and "
>  MODULE_DESCRIPTION("Solarflare network driver");
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, efx_pci_table);
> +#ifdef CONFIG_SFC_CXL
> +MODULE_SOFTDEP("pre: cxl_core cxl_port cxl_acpi cxl-mem");

No, endpoint drivers should not need softdep for cxl core modules.
Primarily because this does nothing to ensure platform CXL
capability-enumeration relative to PCI driver loading, and because half
of those softdeps in that statement are redundant or broken.

- cxl_core is already a dependency due to link time dependencies
- cxl_port merely being loaded does nothing to enforce that port probing
  is complete by the time the driver loads. Instead the driver needs to
  use EPROBE_DEFER to wait for CXL enumeration, or it needs to use the
  scheme that cxl_pci uses which is register a memdev and teach userspace
  to wait for that memdev attaching to its driver event as the "CXL memory
  is now available" event.
- cxl_acpi is a platform specific implementation detail. When / if a
  non-ACPI platform ever adds CXL support it would be broken if every
  endpoint softdep line needed to then be updated
- cxl-mem is misspelled cxl_mem and likely is not having any effect.

In short, if you delete this line and something breaks then it needs to
be fixed in code and not module dependencies.

