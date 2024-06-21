Return-Path: <netdev+bounces-105657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8D79122AB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F1C283B96
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B5D172763;
	Fri, 21 Jun 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iz2wBMMj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EDE172BA2
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966510; cv=fail; b=lrgpP22wKrxgRKMCvBlYbC2kLLXqtp8de4NWi6Dz2MjPhmER6VRuSryv0uVR31tP3sv59Tn/qy09wKxGUzoA2nsorBhR6Xbt+ITwmiDlebqIytAA2CjY4McRyROACHSAGmU5oldLkJSQCLtBQSfkdhz8IQZjv2sfIGVPQLaXy6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966510; c=relaxed/simple;
	bh=nQxWm59CpMwo9YNkPTYyaM/m//w6bEtJ9lNjhYIRazE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f3jUb+yReJVa/Mz1fdkAwhTbefNf+P4MpSZuX13ZLptJyTIuyDePiX0jOoffd66AgHWmZEkllJMPCzpRBAWCmJBYZ72QK4YI/3cgpCyV0zrC7GAI6IS+q0mAYeDL4N5DIlDIeUJls0tlgmc8YvVCGVz28fi8e0kTLgspqRACj18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz2wBMMj; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718966509; x=1750502509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nQxWm59CpMwo9YNkPTYyaM/m//w6bEtJ9lNjhYIRazE=;
  b=Iz2wBMMjrnR26P8A2K/lQTAbHZooX58gBfTjQTxeYlEuXeNkV0mZUDoj
   bUyE1hndZziF/1P7VJi+ISSKF+AVWiC+BcEsmxf4e8K1tSt0v3Mj1n3YM
   rgeSMr1p4c2L7vmONpt9f/D8mVYDeSUB4vn0agICQbAfEtQqXt6QEaYsy
   Jhwz4bXB8KgYOJj7JOPON6gdNvzwbRhYwK1T3XmMsuoJtIx+flfqpOTdd
   wvltXUmyTEuk9AB5zSnzl2AzJQ9WzvYirVInvWN0Ya/3CXh3vndqKdWFB
   qz81P5Nhx9RxvLSwXGGzLoiG92brx1Qry2uv+XAW4uZMZmRHcDjesxmzQ
   Q==;
X-CSE-ConnectionGUID: 09UaQHuuSBSp61lR7whZpQ==
X-CSE-MsgGUID: Zear5Ef4SPy3zyj8EuqoOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16225045"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="16225045"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 03:41:48 -0700
X-CSE-ConnectionGUID: Y/3ySnLfQUCBXbrcQ/txfQ==
X-CSE-MsgGUID: SkaiEASzQaqL06revxThnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="42646859"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 03:41:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 03:41:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 03:41:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 03:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3ukk+Vc6R/y37ebmnQetBTeqY5cJ9acVaGCbWFz8bs2vlhj+HMXXOOOEGKnLYYiiqGuOTI4K7aBhzJocDe7BUIm537SlUAjH7xtU1rZVZQk5p1rIQuhb6zvkn7SyLdwJ4yRzkINmrC1vvrb5mzmfBrAdV8yKzZ9GrbJrCYiBcH7WQpfV18nB0IusMRo7sZRMpyQZlp5e60B52Wk35qIVOvxQbY0b23c56SctXHCs+lAxzTZhzonvWfXeRGy0MXD95rkRf1QBPXRksk7jI8k6GB95R5CSLOaDFtTlS+1hQeoeX/JBaiyc8PLGovyA1q2vfEpdQPthifzLJFXiHlYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtDMeYPf80nkr5niPUk9srNjKPsBkPqEVyUZGt+sDQo=;
 b=k+xodlSsBMVONzi3CGlxuE5mhkHRWrrPBtz6BO/awmYncfMz8TMGtEit/nr47BOwE+zgs8JvT3DQqKnSWl1jd74fjYhP+RII2U/u96yELFX7e5IKPnd7ul4IVfazH49vNcLCNkhIcoM/N67J+i8vIloH1lOUjc4p2W+yDqrGZoJ0wArg/Vjy3jqGoDFksYtExg+6p0CXjxp7FzEWYW54FiBEJJvHcVwF+IT7h5M4Cz9hJnCW72SATJitTD3XOFc2G36hGTRx45jFR185jYiB5A8SmtlNwMGw069oYixR3sxP6m2NASoAKFizqhRER4one9fAM5356TCKuWKBm9oiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7532.namprd11.prod.outlook.com (2603:10b6:8:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.23; Fri, 21 Jun
 2024 10:41:43 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 10:41:43 +0000
Message-ID: <76a0974f-9f49-4b80-ba7c-0ec00b237592@intel.com>
Date: Fri, 21 Jun 2024 12:41:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] igc: Add MQPRIO offload support
To: Kurt Kanzenbach <kurt@linutronix.de>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"shenjian (K)" <shenjian15@huawei.com>, Simon Horman <horms@kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20240212-igc_mqprio-v3-1-261f5bb99a2a@linutronix.de>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240212-igc_mqprio-v3-1-261f5bb99a2a@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::20) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 2980b8fc-61c3-427e-994f-08dc91debe04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWEwVFRKYk9qQktadmFab0puTEhoN2QrK1VuanFFVjZvRXJsa1l1dWFER3Ax?=
 =?utf-8?B?c2NFTXpJRnFPNUR5ZkNmZ0NTVkt6cWM1WHdrdWJ4THM0QmV5Mnpnem55UzY1?=
 =?utf-8?B?cjF2UmpWa0tvalQyNEJVZndVM3pTR3pNK0ZNVHVXNVNLNkM4ckU5eGhtcm5N?=
 =?utf-8?B?bGVhV2tZaHNOaFVqZjMrQ0xYbm9JUldicHdMTy9nWDlSQzFRQzFhNlh5ZnRJ?=
 =?utf-8?B?K1l1MytVU2JHenhzSnBZdmlsVWFMYlg3WU9DcVN3b0JWd2xndVQyZmNwU2hK?=
 =?utf-8?B?YU5iMmtOVGRjRDhoMG1ENmxWZG1tdXRqajdrbGllSFlSQ2MxeHlndlhxVUVo?=
 =?utf-8?B?WkJSS3VrUFBVQmdQWkpwaEdQWjVKb1dYUkl5Z1pDTnFDaGtaZDJxT3lLVUtv?=
 =?utf-8?B?OWNlUlhyQWhHRys1aklobHRxNis5T2VPcG1tQjJFbTFlUzg5aXhUeDQrdTJh?=
 =?utf-8?B?dG9iRS81d2V4T21nZnhqaTVTTUgvL2thZys4MVhReHFJYmJITkxDNWdwZlpq?=
 =?utf-8?B?TmcwRjhsRlNXdEN1R0ZJL3hVcWZRdkhvT1h1RU1oK0ozSFRNcXVkbHZUdlRV?=
 =?utf-8?B?M0trU2k4Vzk5a01wdlhQK3Q5QVptUHdIeDZRcUppSW1jV0RJS3duRjRsM1Rj?=
 =?utf-8?B?ZGJXbEdQOVZXRzdpdHAwSG1UVWIxdXhSaFFTTXMvWFF3L0JzMmhGN3FRRGJK?=
 =?utf-8?B?QjFCbmNWcW9qMnhtZWdwQ1RTRkwrOWd2c0cxeHdjV3h2Q005azdvRFZuSEZC?=
 =?utf-8?B?RTI1MUsxZldmREF3ZWpOakJTS3BJUVQ3a2NHRDZNdXhUbnkzTmJFc2JEeXRw?=
 =?utf-8?B?SzJESDhUNmt6Tk5RRGx3Qk15UVZQRVFJQk13OGdxbGlYcllVZDhnVWtQT2Z5?=
 =?utf-8?B?VVpqeXV1R3dwOE80R2ViRm02MEt1R0hzblZMVWJ3STBTUkJBbHlBWFBETUtM?=
 =?utf-8?B?YU5xTkp5RGVvYVJ6YitsdFRqZWVEY2tJT2RhdHE1clBjWkVoWFVSY240dGUy?=
 =?utf-8?B?WUN0OUJpSTlHOU5zMWVjRDI2ZVdQd3FSTDhtU3JpY1pRZ295bm9uNjk2THJ2?=
 =?utf-8?B?c2JTSEpYakdYd2gzY1Q3NTBzNXhQZWxwYU53aWovQ09PMFlNSVBuRE1qRUxZ?=
 =?utf-8?B?U0pPSGJaVUlCQWpHQW9DVkhwRGlvYjNBN2dJc1VPQ0VMeUl3SG5FR3Ztd0hO?=
 =?utf-8?B?NW43dzJnbURuYmV0MDNOMjlPblMyaW9Nblk3ZStVMU5xZmZCejF3TXVDTHBh?=
 =?utf-8?B?cGEva2U1RGM5czRLM3FUcm5FZFFYckhmdG9Vb0F2THBjWTFFUFZoM0hNcU9T?=
 =?utf-8?B?MWI2Tk1qcU9sWnhHdnU5ZHRNdk0zc0V0R3QvZWk4a1RQc1BsWVZIaEErazMy?=
 =?utf-8?B?TnVUNHBvcHNEdXdCL2lRYkhOMTBWRytkWmtXM1pzMVAzSG1PcWg3dzZDd2cv?=
 =?utf-8?B?OEc4SlB4dGlTVjRzUWZjNS9kMjBIU2hQT1o5TEpySGdFbnhLUGtDSUZXZE05?=
 =?utf-8?B?U1BMdDVRMEgzRDVvRTlFekxCcG1DVVlPd0YreFNLL1U5NElVV2VxVmpFTk1m?=
 =?utf-8?B?ZHEwNitXc3FkQXZoRXdWNUw0Q2F6TVo4TVNoSm5WWjdqSEJISnJGQzY5MlZM?=
 =?utf-8?B?UEZNQ2lZT1VlcSs3ZHZYU0xIMVFaQWtSTFp1TjBPbmkrY3NhNnp6RHkxMm4r?=
 =?utf-8?B?ME5idWdDV3R3NU1PdkFkZVNQNTYrbCtDaDR2VlhDMUM1bUNRWjNRSEFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnlDb2tMYVh3SEdLMitHTFJWUVBDWndhYi9MdG9NbEVJaHFyZlJPT05zL1hh?=
 =?utf-8?B?WGcxbUFwUWtiUmFJVWR1SE94c250UFdLVWtmaytFSVo2MHpBTlV3Y2xEMXo2?=
 =?utf-8?B?bG1XK0ppbFhRdUFUbHRSdUNURWZYbWp1bkRSVzRvK01SK3gxS2xpWFAyNVJH?=
 =?utf-8?B?RHRucHhOZTgwK3Nub2I1akNIUWtMT3lvdVZKMnVoSktrb2dnUHNRNTV4NnRO?=
 =?utf-8?B?amVmeURGOG5NZ3F1cGw0OVY2M2VtM3Rrb1RycExZMTZJVCttcmJka01kWldP?=
 =?utf-8?B?ayt3OHlybWFOWlAyMVN5ZTlHS0ZsK0dCZ1VqN0JocENjR1dUaCs2OWtDQnRI?=
 =?utf-8?B?UkpBR3B5YkV6RTgvdTB0MFplOFlvcDJRZ3BOZUY1aW9LOS9ickpUbk55MWVV?=
 =?utf-8?B?WER4a3I2QUVmRWNMa2JGUWpsRUd0bFVUdFhjY2pFbXdKWFU0alh3bklYbkRx?=
 =?utf-8?B?a0Y1UHJpWmR5RE9VWkkvWDJ2VnFxMlhWZmZtWG4vaGtqY2M3VHZWTTk3RXZw?=
 =?utf-8?B?M1RBVVVaQUp0ZDVpbFlIQTNPMjIzUTE0elBSS3FKNXZkNmlWaCtka1A1UWxN?=
 =?utf-8?B?djgxaTB0T1c0TityNFpUcDNRZDhZbGNYN1I0eW9Nam5hNEl0eXpkdlFTT1c5?=
 =?utf-8?B?UlFCQ1pjYnRjQmdEWnNuY05xaUpPYW5TWXpLSHE5THFGV0VOSFlsMmNIZFh4?=
 =?utf-8?B?K1hyTFZsQXQ5UFFaQVkyYkRoV0w0U0tiQlhJTlMzeG5OMTJTZzkwOHZ4b0h5?=
 =?utf-8?B?TFZ1MmpmaUVoQk9yRlo0TVVvMVBJdit3aWI0cE9TbGhBcEM0dkJpOFd4YWFT?=
 =?utf-8?B?S3lJa3Jub3NYVkxsV3BSSG56akEvcE9USExoMWdxUnBFTVNFYmRyekRkNlZJ?=
 =?utf-8?B?MTZjUUp6MVZmblo5bVFkZUF3WCtXc1lvcmlmekFOVmlhbUNxeXVueVZyejVx?=
 =?utf-8?B?czduNVI5UlpTQlByL2hkTmdKOUZwaEt0blJzS3d2enJSSmxuYS82Nno5ajNY?=
 =?utf-8?B?bStFaFNqTVUvdTAvajdyWXZYZlovc2hsazJnMUdtSTZwZkZYYk1QQ001R0ZP?=
 =?utf-8?B?NVVxbXdqd1E3WEJXMXRPVTQ5U3p2d3MwQXhlMWU2aHc2SUNrcnpVZ0lVOHNa?=
 =?utf-8?B?MFE2Sk5EQU1DUllVbC8rL1AxTXhpbWRMSTFjUnMyVE9TZ2lmSDJGZW9tbER0?=
 =?utf-8?B?RHE1S1BRZDQveU5xQkN2ZXRLUkEyb1grTWM3R2xURnJYbEgzRjVXT0VSSTAw?=
 =?utf-8?B?Q0JwYndiczEyY0JlOWhtWDlhQ1JmYW1NWWNUQnR2R3g4RTdSVEJHek05Qkda?=
 =?utf-8?B?SkJhZDJoN0I3S0F4MjFmc0QvUlh2dEV4dVg4R3RjMFpPZ1lQQ09WSlY1WEU2?=
 =?utf-8?B?VGxCaEorUTJUMzRnOTFPUU9scDlwQTd1ZlloaENOVDRJOVJjMlVMQmVWaG5Q?=
 =?utf-8?B?SEZCUTNDbnBwM1ZlcWtHRnFaTEpVMnJhVUZETVZjRWxTc2pRL25rYkVGYnpE?=
 =?utf-8?B?N2lnaUxtdnF4QXNBRStYRGtrdjlXUk82Q2Nod3lVUDgycTY4R0IyejdCdXEx?=
 =?utf-8?B?cFlENi9OazN0b3JmZmJpWHlMRGhPWjVjV3prUlpJaFBHWEg2QUQ3U0ZUbEtt?=
 =?utf-8?B?Y0RlR2lnK1R3YVE5R0x0VFhFOVlCWDFIb1QvYUFpLzkyYmUzb0s1Q0JmaDZk?=
 =?utf-8?B?N1JXYkZsdzRYUXllTnpJUDB2eThzZWd2VTFrRDJSNStXenhwWnRJMjlHWnNL?=
 =?utf-8?B?UHB1RzNzZUdzZFRLWGt6VFZoekE5K0hrTUlwSFE0S3VXMHg0anBzVWhBR3JY?=
 =?utf-8?B?dURnL2dWQUtseUlRMEVaVnA0TzlUeXVCR3B2RklucGgzWG1QYnZVNTFubXBw?=
 =?utf-8?B?dmpkcTZ0ampwQkJucXpkRW9TL1BuT05lWGFOU1RTK3NoUmNlTERoVDFCU2d2?=
 =?utf-8?B?MDl5STFsenh6TlkxeVZjdHhyTkxxSVNYejFZN2lMR2JQQSttU1BoR0t5WlIx?=
 =?utf-8?B?Y296WHZNY3Q3b3Flcm5pemVoRHE5ZHZGNTUyV05Bd0dDOXdvRGU5L0U4ZGxD?=
 =?utf-8?B?aU1SUmdLaTQvNm00eHJlbXhhbkY0OGJtcHJuZ1Z3Mm9JR3dySEhpc2FrbUQ3?=
 =?utf-8?B?NlhuVDJMc3kwOHJhdU1pcDhiTXBkMXhvUUhxVGhoR1ZDZ0lhWTZXaCtzdThk?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2980b8fc-61c3-427e-994f-08dc91debe04
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:41:43.8876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0yAqMF8/mr8TV4faHdup7u6eyzjauedYDteUWCe+Uz2BBqCmh9EFa6646QfB3AnFPKcZrPPQ7cdpPp/Tt4FRNaPrkKAb+znuEHGWvNpZqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7532
X-OriginatorOrg: intel.com



On 21.06.2024 09:25, Kurt Kanzenbach wrote:
> Add support for offloading MQPRIO. The hardware has four priorities as well
> as four queues. Each queue must be a assigned with a unique priority.
> 
> However, the priorities are only considered in TSN Tx mode. There are two
> TSN Tx modes. In case of MQPRIO the Qbv capability is not required.
> Therefore, use the legacy TSN Tx mode, which performs strict priority
> arbitration.
> 
> Example for mqprio with hardware offload:
> 
> |tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 4 \
> |   map 0 0 0 0 0 1 2 3 0 0 0 0 0 0 0 0 \
> |   queues 1@0 1@1 1@2 1@3 \
> |   hw 1
> 
> The mqprio Qdisc also allows to configure the `preemptible_tcs'. However,
> frame preemption is not supported yet.
> 
> Tested on Intel i225 and implemented by following data sheet section 7.5.2,
> Transmit Scheduling.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---

Thank you!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> Changes in v3:
> - Use FIELD_PREP for Tx ARB (Simon)
> - Add helper for Tx ARB configuration (Simon)
> - Limit ethtool_set_channels when mqprio is enabled (Jian)
> - Link to v2: https://lore.kernel.org/r/20240212-igc_mqprio-v2-1-587924e6b18c@linutronix.de
> 
> Changes in v2:
> - Improve changelog (Paul Menzel)
> - Link to v1: https://lore.kernel.org/r/20240212-igc_mqprio-v1-1-7aed95b736db@linutronix.de
> ---
>  drivers/net/ethernet/intel/igc/igc.h         | 10 +++-
>  drivers/net/ethernet/intel/igc/igc_defines.h | 11 +++++
>  drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 ++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 69 +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  2 +
>  drivers/net/ethernet/intel/igc/igc_tsn.c     | 70 +++++++++++++++++++++++++++-
>  6 files changed, 163 insertions(+), 3 deletions(-)
> 

<...>

