Return-Path: <netdev+bounces-97900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DCE8CDC3D
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 23:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B601F21171
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 21:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F73127E04;
	Thu, 23 May 2024 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciDnuLhL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4B101E2;
	Thu, 23 May 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500544; cv=fail; b=LwDrY1x3qfaNe1zNh9YWC/Tm595f3uTU0ZIdDXX2NAxOgOSyso9Ewj9VrDDg5dUIWhe8iaL7kyEHJgMdeezs2g2kyVtMpP6Pbkm75M3QJlPOsZzkBw9txjc5uv8wQgNpOhCxYV29lN7eQfLUSQF03oBjih/NPlhq2AWKIc4ChSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500544; c=relaxed/simple;
	bh=uWtmboQH7FPubZoqXRkvIp2b1Qh8XIBiJxX81JLqF5U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kmZUYFW8Zq2+QVf1itBgdP7JKLoF4fV5eIssUkd6WijTA7aduPFTp4bpQgU4wCjKKHe2w0WNkdSw2ZBbSgzt8iTpQrNAm6rtQcu5UxvmWn66CO2kNc2qCYvao2eiBoPiNyPzn8hvqwxdTRl3tIO2LWSdKaI9Rkd4UnufdrtKqTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciDnuLhL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716500541; x=1748036541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uWtmboQH7FPubZoqXRkvIp2b1Qh8XIBiJxX81JLqF5U=;
  b=ciDnuLhLlMMS/T7vatu/v9GcX7014A2roW8nPgzEoC+RDo0oYOgLBzpS
   A5RFE+qazzq6qAUR3Dpd+sYl17CxiPEEo+7GTvBVCqVmsWqqA9gD5YmMY
   U01cwMdbR22b+qDYE/v0tkGpFAD2/SgFW8GKk6oVfC6YM+bVkzkLP8yXt
   9hAbsOpdIqx/CkVpNsCEZM2GgQWJuUNCCuaef8vDwlt+jPq2wvw57Ub10
   H93JOWupw2PuinKhyGJVfpKB8Q3ShXxO8AIVt6BeC5Hwe/KF/e3giKQBg
   zejSHm79Jdnf/DZhBIFfGGu0U7hJ6E+lDxFEJaRncIhlge+LmeCb5hLFE
   w==;
X-CSE-ConnectionGUID: 3Qhj8L8kRXST0wXgIVPp5Q==
X-CSE-MsgGUID: DLt5TfvQQhiIdZmviqU24A==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35370149"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="35370149"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 14:42:21 -0700
X-CSE-ConnectionGUID: TxN2bYWsRP+kTiEk63ETWA==
X-CSE-MsgGUID: 63qFl8sQTGe1dMoubF44KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33888666"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 14:42:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 14:42:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 14:42:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 14:42:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 14:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzI76Pktg5HqpVLipFIrolDG2k8yDtnWlfVx/ZBPpYupUuFIm5RmKQZ63F2WY0fa98fSRsIIUcJlk3SSOSnkIcgDYJtPNjav+jw8lMXmEExHH6RsfL4AXm9pCY7NeI5xriI4bDC/H2v8kXgmuXJeR2Bgn3/hnSfNmvpm/I7v8a8G34ghjPTQJ49ESwiYI3F6mZU4o8cc3haOzHtKy0cw2YvPK7mRSTxjJdcAHigSd+grly4JhDJOmCgdWGTjdMuE8YVkgZJofGPGU1gcTx02K0cvenBLgdg2f37Vf4Jj1jJXWHC7nmyzrKDy/8Ot8zTVkEvBrz3rg+qEjmniTqBbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbL1Fb7HiGIFYO0irvblKcmowvPDcmD+4dZnj1xo/Lo=;
 b=P5UfOoThU7BlB6gR7wMp6BVVm3K9RqwWgWKpB+DqNDOKjFTCS6buYMzkKM1MCVAZp0GZTX1t1gFx9DVBgIUnB7iWid3qxNzmCHHO/OCCctJ31es3uA6uqzgi2OKCbFQ9PGor6PmOY2WsGhwIxypJSnswTWnN+kvTeZVDR4F0bsCGF38VX2p4wbBstzpfT3tPwDStihLKuW//6clC+7F+CUo1emnIOC++hTxJk/HBk319CMfSisjM5fCvdwUVA7nOp2U4Cln9Z90xwg2MOMyRsKL1d5fAdEITHQD1/PWWIj6UqB1ZPbgDBqdHszToRfxWhS9dB/NCogNnURbFNH9Xkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Thu, 23 May
 2024 21:42:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 21:42:17 +0000
Message-ID: <aa6a5450-7e66-4da7-b396-1ce48837cd7e@intel.com>
Date: Thu, 23 May 2024 14:42:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v11] ice: Add get/set hw address for VFs using
 devlink commands
To: Karthik Sundaravel <ksundara@redhat.com>, <jesse.brandeburg@intel.com>,
	<wojciech.drewek@intel.com>, <sumang@marvell.com>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <horms@kernel.org>
CC: <pmenzel@molgen.mpg.de>, <jiri@resnulli.us>,
	<michal.swiatkowski@linux.intel.com>, <bcreeley@amd.com>,
	<rjarry@redhat.com>, <aharivel@redhat.com>, <vchundur@redhat.com>,
	<cfontain@redhat.com>
References: <20240520102040.54745-1-ksundara@redhat.com>
 <20240520102040.54745-2-ksundara@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240520102040.54745-2-ksundara@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: ae48fe96-2fa1-4286-0fcf-08dc7b713763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlhDeGZmdVg4eEd6MUlPVHJsMWI5MkZRS25uRWc1MS9OdXBEUVZrREJBanln?=
 =?utf-8?B?K0dzVEtOV2tBYUdmMGxuRFV0Q0NLZFBjK2ViSFJVYlpTQUI2UVR5Q1FQYTN2?=
 =?utf-8?B?RS9jMUFXOFlPSE5NOXF1L28xMkhDTm1iLzlKYWVmSnpDaWRrMGpxTEthKytT?=
 =?utf-8?B?aHRoVHN6NC96aTNENnhuWGJtWDhaaTdWZFY0MkV3Vi9JYlBCQnd0VUVMKytY?=
 =?utf-8?B?M1ZDampWMzR0UXR2b2NhTTRING5tVEtDbkVUWkdheUtYOGQrVU1DZ21xcHVU?=
 =?utf-8?B?RzNiRWhkVjdiV29MeWVFbnVLdkxmQlV0bXZjNWFaVlp1WWg1bitYejYrZ3FC?=
 =?utf-8?B?YUNiRUxFWXJVcFhBNjJ3RXJxWjBPN3NpQTF6aUk2cytIYW95cjVHSjg4TWhT?=
 =?utf-8?B?OTE0ZnBxQWpBU2luMjJrSUtobkhUZTVGSE5DSU5RWjZPbERXT1RXWDlHTW5Y?=
 =?utf-8?B?dkRWY25MdzQ5ejRobzBzcFBOaWM4QlIxUy8vSUdKa1lselBZN2g0R2M3MWJv?=
 =?utf-8?B?RXUrcmJ5aGFxSlZzbUkvb2NKcTl5SGRTSDV6WGovdXZHdnV6MHEwczJQbU5H?=
 =?utf-8?B?SEc1SW1tbWF0d29wWnMyWnVVVHEzaFZWT3d6bXR6NW1vUmF6QnRYWVVVeEhj?=
 =?utf-8?B?YTdWSGxrSFNQMDErR1ZZRHR5TE9DQS9zc1gvK2Zsd21IK2RNdDdpZnNPL1Vw?=
 =?utf-8?B?S0xIRHVOaHlwWEs5c2RvQ0NOa0ZqaEFsRDkxZnFWNmF0cDVJeHRCdmpqWWdo?=
 =?utf-8?B?a3dZZkNSb3hjeUxpM1RzbjM4YlBrNFJSRytnT2wrSStHakNONkxuWm44dFh5?=
 =?utf-8?B?TktVMDVMd1RpUWM4azUreWVZNlpXdi9Vcng0cFJZQzI1d2V3UjFOVXdTWUtz?=
 =?utf-8?B?QXkrNXhLMlhHYTYycGIvQ0Y1d1Z0TVRlcXpCOHdPWHVRczdJTVJmK3dodXpT?=
 =?utf-8?B?RWZDaDFST2Y1WCtnREwvcDkrSTVSTjBWTUZ4aWNtTm4yTDVIUEJ0cnlBYzNQ?=
 =?utf-8?B?RVBnYzN5Tmg2OXlkbmNaZTFpeDhIRHEwL3dzQksrZ01JNFdndjBUVGNxWW9o?=
 =?utf-8?B?ZUFaVXZVOVRLWkVxQUU4Z0c1WjBZOWwvR3dMWGNDbWlCak9NRVEwSWxyM1RB?=
 =?utf-8?B?OG16UWowWjkzVDdIZ1B2MUg2Q293dDRUcVVJbnBBS3lZYjdTblBFdGdIaHhx?=
 =?utf-8?B?TDF2ZnVQRlJwbGc0MDRhMHpPZmRXL1Y3SHhKSVUzTjAyY09MUEpqVjl2VWps?=
 =?utf-8?B?dVpEZ2JENFA2TTJqN3YyclIwV0JZcWMzaXdtckxXNUl3VisxNVdZVUdlVnRi?=
 =?utf-8?B?S2h3SjlNMkgrT0R2WmdUL3VGMTErL2lTTWV0a0NUNmljUVFBU0Ntdzk3T3l3?=
 =?utf-8?B?cWg3L2orZmx5eDZCVVpPenp0eVdhRmdiM2xQWFFLRndRQTAxdmx4bHJJeHBh?=
 =?utf-8?B?L0NxVmlQdFNjcTBCTGJzbkU0UXZpN2xRWmZCamVTRC9lYUFwbkcweHRhYVZm?=
 =?utf-8?B?bEswZUJEZUZGSUpBZWVDZndUQVFSTFNyeE9TT1pDbWRQbUc3YWI2eGEvdm9U?=
 =?utf-8?B?cUY4VUg3R2NiMkMrdjEzQ203OTBvK2JEeHlwYStMMVBIQUs3bHdveThjeUVh?=
 =?utf-8?B?RTlZUW5GR0h0d2VmaG9CZGlod0c4NDVFTVhQNWlQR3EvcEJzSmZHVjYyQlVV?=
 =?utf-8?B?bEt6R2NHYmY0Q0VGZHEvaEN0QVg3aTE4N0xVTVo4d1AvK3JMdnVOVGt5NjlY?=
 =?utf-8?Q?YAbQVFgicx8IjTjZLhNIVW3PLnUr9nJnswaKpIo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnY0cnE1OTFrSHBXZTVXV2FINGE5cndCTmdMQndPc3JDNUZDQVZLem9xS0x1?=
 =?utf-8?B?TkliaTlUMTFtTFQ5aHhuSzJOcW9SM0pXbk1xWDEzK2pUK3VFb0thWmZIbjBD?=
 =?utf-8?B?V1RNbmNiaWxBQXFlc1ZFalhmUmlFc2V5OVVSZkhPVnlKaWx2SGFqRlU5aEtK?=
 =?utf-8?B?NXZXWDFiRWxxdFpqdzRaZVF6dmNMQW5CQnhHbFNQanRnQWFkQmRBUC8wUFRU?=
 =?utf-8?B?VW03aXJwKzJzMFFOcEpBMmtwK3ZtMWpaZSs5SnR5b2RWMHdpMnJPblZZU0lN?=
 =?utf-8?B?ZzB6R1l1ZkVUWlQyNTZmdFpNcDUwOTdQY3lQdHJlTlhoRTEvTEczOC9halJY?=
 =?utf-8?B?L3FJZnZMRkF6ZENtQ09XOUtyYkM5UWttVGhmTnJHM3FxcHFqbUR0QTBSWGRr?=
 =?utf-8?B?TTk4dm1QNmhqdjdJaFJVMitEcW1oN0oxMmU0UmZBdm1lS3czemorKzlDODND?=
 =?utf-8?B?a2YrU3hhN3hISXN2QnVnT0pBdEFma25IZEFoVDF5M2dTekMrY3ZibW9JMkxs?=
 =?utf-8?B?TVJpSnFUQVpiaG1nTzh1WE9rWWNVUDlkOXQwMGRZYSs5MFN6bVVubW5FR1c4?=
 =?utf-8?B?VTBTR1dXWTNDQ05zbFlqK0IrOUZ6Y2RlQTRKWFNjOElQM09PelZQUU4xVFkz?=
 =?utf-8?B?N3dBTjl4NTBWbE1PRWhSUEcwNkdsQkt0MjU0cTBuK24yVHZObGxKK21CNCsw?=
 =?utf-8?B?SktIeGtncXlZMEFuUE5jOHdNTmNGc1pJdlVxQ2ZLUUw5QnA0dFErbVhWNVg1?=
 =?utf-8?B?b2MrOU15OGRBblFrakVFR0szOE5lUDNSWEY0WVZvUVA2TTNJM2xBMjNQZmww?=
 =?utf-8?B?d092ei9tRHMwMUJmeXp5TncyL2M5M3ZNeW5JSTk1UTE2V1JValN2a0RFVHZE?=
 =?utf-8?B?OFU4STMrNzM1dFF1VUhDWGxMMHVwTnowMXhyVHlpampmRGtDU2ZyMHhBS0JR?=
 =?utf-8?B?OVBhdU9FcG1LK2FkbmV4WGZDaDRMaUJ2YisyYTZIb0kwZTJCaFFzODNGMjRT?=
 =?utf-8?B?bm5Nb1pNSkpRR0Z4WmhPMjVpdU1SNlFoV2dNQ2lFUENlOEQ3K0RlTmhHRmRh?=
 =?utf-8?B?SWJyMTFtdGoyZ3Y4ZG1nazVSclJ0ZGkyend1QmZoUVdxNXZaaCtxRU4rRHdt?=
 =?utf-8?B?VGREVll1bW4xZHJJc085ZFlUcTlSbkdaZW8wQjN1Uy9oT0gySS9XZ01kZnJm?=
 =?utf-8?B?T1dUSU9QMFd2cUMrTFBoOEtZSUI0V09GVFBpNXBCQXBOK2JBZFBuMWdYbWJ1?=
 =?utf-8?B?NTZRUGN5QkNFMkdtSEloK0lTekFlb3V6S1VpeXgwR002eVJYVFA3SHpDdTR1?=
 =?utf-8?B?VDI1SFI5UUNucnA5UGVNZzhYdmFrZVBKai9zTXNNaThONjhIc0ovQUVMdm1C?=
 =?utf-8?B?SVZNeGRyeXhuMG5BaVVSczJJVGtoWTFUUEFTY0ZvR3RQVW9xTStFREF2Y2hy?=
 =?utf-8?B?OGRtQ21pVm0zWTdBQldZb0JTMUZ3QlNoYkFqOTN2ckdHZEErWkFsS0xPVEQ0?=
 =?utf-8?B?WXBucHNYcXRPSWZqZEg5ZmVDTHhURGpVd3RITzE3OWxjd01rSzNlWU5yWHEr?=
 =?utf-8?B?YUI5RUEzWGFvNTRGVkpEN3RZRHZKZExVb1ZzcWZzeDBOUHYwdXFKZVBjRzZV?=
 =?utf-8?B?QVppQkUyTnh4b0J2SzNDV3dIY3BuUWNDTWo4Z3cxTHQzc1lsR2lRVUNYT1Ra?=
 =?utf-8?B?MGFKZGQxMThHSHRaTU5GZVB0bEdrdktLWHR2YWZXN0NQd2N4SDgrdWJsRyt4?=
 =?utf-8?B?Y1BSNTlKSkdHb0VKaGUyZVhTdmF2bnFwK1NneUk0K3lZWWpHV2FGcDVwbTdJ?=
 =?utf-8?B?dkpYSm9aMlZMbGRUbUxUWjF2WTZiUHVnN1JSUW5iZFV1bnVQYjVzbTV5cUlq?=
 =?utf-8?B?amh3aDV1aG9VVFJqOStvakFFeTBZV1lmeVV6ZXhVa2VPWDlhSEordWZCQ0ZN?=
 =?utf-8?B?c1h3eXF0SVpjUzhQbEwvdUhBRGVvcVBDaDNWRkxVdmFYUkpTUmNEa3IzRzNP?=
 =?utf-8?B?eHZtV05rak91akZZeDFseHd4b2dLSmRlSEZUWmpZZCtrS2dmNDJUMjRkT3o3?=
 =?utf-8?B?Q1REYjIxQzhkQjJTWXp0UDlrc1JwT2FtUVc1akVZMWtDS1RHakpZWmsvajAw?=
 =?utf-8?B?THhzS1l3LzFncHZBTkxCU0NvQnhTQVNrMzEyemw3dVA4aHhSdnZQd2wvV3Ft?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae48fe96-2fa1-4286-0fcf-08dc7b713763
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 21:42:17.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrUd5J+zLShPQ5hQKmjYrGdrMPyp9D8v5OXiknwnjwZ4lAFTj5Sz1GnMpl6Xsw/CvxcfjJO/5woZdvilBC5ifmX+X91Nc1WagYOtdSpmmo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6527
X-OriginatorOrg: intel.com



On 5/20/2024 3:20 AM, Karthik Sundaravel wrote:
> Changing the MAC address of the VFs is currently unsupported via devlink.
> Add the function handlers to set and get the HW address for the VFs.
> 
> Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
> ---
>  .../ethernet/intel/ice/devlink/devlink_port.c | 59 ++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_sriov.c    | 32 +++++++---
>  drivers/net/ethernet/intel/ice/ice_sriov.h    |  8 +++
>  3 files changed, 89 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> index c9fbeebf7fb9..00fed5a61d62 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> @@ -372,6 +372,62 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>  	devl_port_unregister(&pf->devlink_port);
>  }
>  
> +/**
> + * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_get operation
> + * Return: zero on success or an error code on failure.
> + */
> +static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
> +					  u8 *hw_addr, int *hw_addr_len,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct ice_vf *vf = container_of(port, struct ice_vf, devlink_port);
> +
> +	ether_addr_copy(hw_addr, vf->dev_lan_addr);
> +	*hw_addr_len = ETH_ALEN;
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_set operation
> + * Return: zero on success or an error code on failure.
> + */
> +static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
> +					  const u8 *hw_addr,
> +					  int hw_addr_len,
> +					  struct netlink_ext_ack *extack)
> +
> +{
> +	struct devlink_port_attrs *attrs = &port->attrs;
> +	struct devlink_port_pci_vf_attrs *pci_vf;
> +	struct devlink *devlink = port->devlink;
> +	struct ice_pf *pf;
> +	u16 vf_id;
> +
> +	pf = devlink_priv(devlink);
> +	pci_vf = &attrs->pci_vf;
> +	vf_id = pci_vf->vf;
> +
> +	return __ice_set_vf_mac(pf, vf_id, hw_addr);
> +}
> +
> +static const struct devlink_port_ops ice_devlink_vf_port_ops = {
> +	.port_fn_hw_addr_get = ice_devlink_port_get_vf_fn_mac,
> +	.port_fn_hw_addr_set = ice_devlink_port_set_vf_fn_mac,
> +};
> +
>  /**
>   * ice_devlink_create_vf_port - Create a devlink port for this VF
>   * @vf: the VF to create a port for
> @@ -407,7 +463,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>  	devlink_port_attrs_set(devlink_port, &attrs);
>  	devlink = priv_to_devlink(pf);
>  
> -	err = devl_port_register(devlink, devlink_port, vsi->idx);
> +	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
> +					  &ice_devlink_vf_port_ops);
>  	if (err) {
>  		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
>  			vf->vf_id, err);
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 067712f4923f..dd1583b0fd90 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1416,21 +1416,22 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
>  }
>  
>  /**
> - * ice_set_vf_mac
> - * @netdev: network interface device structure
> + * __ice_set_vf_mac
> + * @pf: PF to be configure
>   * @vf_id: VF identifier
>   * @mac: MAC address
>   *
>   * program VF MAC address
>   */
> -int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
> +int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac)
>  {

This has a couple of new kdoc warnings:


>  * __ice_set_vf_mac
> drivers/net/ethernet/intel/ice/ice_sriov.c:1427: warning: No description found for return value of '__ice_set_vf_mac'
> drivers/net/ethernet/intel/ice/ice_sriov.c:1481: warning: missing initial short description on line:

These aren't the fault of this patch, but merely new due to renaming.
Since these are not fundamentally new issues, I am going to apply this
as-is.

For this alone, I do not think a v12 is necessary. However, if you need
to do a v12 for another reason, I would request that you fix the kdoc
warnings. Otherwise, the patch will fail our initial automated checks.

Thanks,
Jake

> -	struct ice_pf *pf = ice_netdev_to_pf(netdev);
> +	struct device *dev;
>  	struct ice_vf *vf;
>  	int ret;
>  
> +	dev = ice_pf_to_dev(pf);
>  	if (is_multicast_ether_addr(mac)) {
> -		netdev_err(netdev, "%pM not a valid unicast address\n", mac);
> +		dev_err(dev, "%pM not a valid unicast address\n", mac);
>  		return -EINVAL;
>  	}
>  
> @@ -1459,13 +1460,13 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>  	if (is_zero_ether_addr(mac)) {
>  		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
>  		vf->pf_set_mac = false;
> -		netdev_info(netdev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
> -			    vf->vf_id);
> +		dev_info(dev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
> +			 vf->vf_id);
>  	} else {
>  		/* PF will add MAC rule for the VF */
>  		vf->pf_set_mac = true;
> -		netdev_info(netdev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
> -			    mac, vf_id);
> +		dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
> +			 mac, vf_id);
>  	}
>  
>  	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> @@ -1476,6 +1477,19 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>  	return ret;
>  }
>  
> +/**
> + * ice_set_vf_mac
> + * @netdev: network interface device structure
> + * @vf_id: VF identifier
> + * @mac: MAC address
> + *
> + * program VF MAC address
> + */
> +int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
> +{
> +	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
> +}
> +
>  /**
>   * ice_set_vf_trust
>   * @netdev: network interface device structure
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
> index 8f22313474d6..96549ca5c52c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.h
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
> @@ -28,6 +28,7 @@
>  #ifdef CONFIG_PCI_IOV
>  void ice_process_vflr_event(struct ice_pf *pf);
>  int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
> +int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac);
>  int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
>  int
>  ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
> @@ -80,6 +81,13 @@ ice_sriov_configure(struct pci_dev __always_unused *pdev,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int
> +__ice_set_vf_mac(struct ice_pf __always_unused *pf,
> +		 u16 __always_unused vf_id, const u8 __always_unused *mac)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int
>  ice_set_vf_mac(struct net_device __always_unused *netdev,
>  	       int __always_unused vf_id, u8 __always_unused *mac)

