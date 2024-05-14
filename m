Return-Path: <netdev+bounces-96328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C28C515B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D101C2135E
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F16135A45;
	Tue, 14 May 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFl1MJ1F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035EC13540C
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684357; cv=fail; b=Y8on4fbASLyhNd4RyhydYg0diwjMCPBRghg/46Hq8J32huRfUoqRay/UorFi4aTOIMIMXPNZvpbFSGB1MURYZCOHUcTX3UOUGDs0gbzZzj/R/sM39wg50QbKfGXOdr7XifTepM5cC2Rc5ZfkFpst6+KIbT1iDixxaVvfyzXU/wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684357; c=relaxed/simple;
	bh=FOxBrMAifOhBRQVfVQAR+zIyMTApMA1URQko3sksSew=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UROz/7Efq80V21iCty0ZZqry1u/HAh/d7fx1VnmSyknXO5H0NRckpAMzNNaf0vT4oOEp3eLKxzKD0FxgH5xRy6kC6leDASZdrChSSNjhxOeNnNdb0MJVRGh9ywpOux1AajyzZT7kjcckmL/wFCUIylgzYOCd8Vt/h58oZQafAnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFl1MJ1F; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715684356; x=1747220356;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FOxBrMAifOhBRQVfVQAR+zIyMTApMA1URQko3sksSew=;
  b=NFl1MJ1Fe1wSEKKszg2f8vcUfG6ORc+3b7BaQzx9f1t3dpGIGujW3KPF
   L54dL2asTWRv+taTarCBwr9wi81Xzq0jqf2aPzdFvyKslpHANmoj+7CUP
   rlEUrrFi5SovuEuXlURMLs2Koo/dOTpwq2VD5k3Vl8p13vHx26UWPm4r/
   PQ/uvukvKQFscEuyhK8FfiNMN0Bmz7+B9uoaixYQU6aMGs8rI062sXDv1
   Xke1jq4CKRBHFd+BvnAPdcjqSqC+sltQmNToQRPxxPj4XuUcitQWvCcxn
   5ccbYS6CUCWITnhgLTL3T3jTZZvpAaa9zfUiKKLmhPX8XirNTduwpZkcC
   w==;
X-CSE-ConnectionGUID: r0To6603Qde3/1ZgnpAI6A==
X-CSE-MsgGUID: +nKSijvyR72YgQj0Vw0n1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="23061805"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="23061805"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 03:59:15 -0700
X-CSE-ConnectionGUID: 67KLJS8yQky7HinYifJNtQ==
X-CSE-MsgGUID: x+zsQNcsRN+xtfscaEKoQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30776591"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 03:59:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 03:59:14 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 03:59:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 03:59:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 03:59:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGLPZoQH/dpuZhjsJF/SYikm/cPODwIlvE3tmpXqhBc/dJAM32cefWcB+PdugibZkK/2/gwgG506YYJQnhh+f3MaWj8bjowq7dgODTMArpogiPDS5wQgYUNDdB88xDg83gkiCLjUrgehIJrzCbAJerItLhQ/bhNciKjzm6UdOoNwbPUJue9+cMN971TXMImE7DbCoQaxqa68UXYBduELTqn2tk3lFbgxl/30QC6fnND8h2PH8KKio2AFo+5lyBswhAnGc4zcJhkjavkv3UdLYJWZfFaafI/trYNlVVg74LWuJfQP/w67zIM9Mxmk6zvhcwEc/qdJ603TliwT/5P4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NELVv/0+RqDAKgnOBAwXDkyuR+OaSu3QZLO7fysw4Ek=;
 b=Y9a6CTz0VmK78DVhBffpiahyWDHvZvgCVVObYTuweH6PcrgKhtqG81oo6cHHCeSv1N9Ts7EWRHe9bsg5Q91qP8WrRPN3u8ZqXXOLqcNusTV6kIbFanSak3k3tXXkJqGLjmYRz+0jXCkbSeyJ8Zp0evX//Wkbk1J45+jun6RQxx3L3aQnUcWdeiWDoZNik5k76SuUV6k6hBtoiajb/T8fEgtcv1LYXrc24SEtI+0nWF8d4EnPWq7pJrwe0IsjyhUCxZFSg/Cfrclt6t316Z7hlqsTzyA/k8/nhcgfTVJCemaq09Hv0di9v/0f6++UNIDlGr5b1UaUkHhxvbS7kNe0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB5874.namprd11.prod.outlook.com (2603:10b6:806:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 10:59:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 10:59:12 +0000
Message-ID: <0555b297-5f8c-42a1-b651-e3119b1851ba@intel.com>
Date: Tue, 14 May 2024 12:58:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next:main 13/66] include/linux/compiler_types.h:460:45:
 error: call to '__compiletime_assert_654' declared with attribute error:
 BUILD_BUG_ON failed: !IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed),
 sizeof(u32))
To: Richard Gobert <richardbgobert@gmail.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn
	<willemb@google.com>
References: <202405141504.J6WdljEp-lkp@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <202405141504.J6WdljEp-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d47ea3-b13c-416a-8d69-08dc7404e33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkprZ0FTRjQrcnlIeXJQNkd4UWF1Z2gwVHA4RitUeitoUjR2MEJnWmp3Yks1?=
 =?utf-8?B?Y0RVdGdGdE1zcENQVVVSOXpYSnFXdUt2Qzd6ZXMxdXlqdW0xRUVtWmZhNTJQ?=
 =?utf-8?B?SWdvdStrS1RnNmNyeSs4cUFNMFRjRHBzaTNTZjlROW1JSCttZm1WZEovOGFx?=
 =?utf-8?B?LzUzRExLTVlQVk9mZXNKdzlUbWE0Vy95K0IvQW14cDlzbmorUkJUZzBtWUVI?=
 =?utf-8?B?OWQ2bTYyN2pTTlVWUk9sQ3E4TU1FaTREV1lsWk9JY3VMTGF0VUhrTW5uMW5I?=
 =?utf-8?B?eEl4bkxSYWpuU2F3ZFRVQUlOaEpCZFdaN0RsYlZyTEJPNzNRaHNkZzJmWVQ2?=
 =?utf-8?B?NXF3cWhWa2pVdDgxK3YrclBtTmx1VUczd0xTWUNqb2JXdllvZWZIMGpSS0FS?=
 =?utf-8?B?Yit6WWJQb3NtRHBwK1FjdnlMdFJmL1NST0JjWDdWZEJ5WEFvNTFydWplZk9Q?=
 =?utf-8?B?TUEyNWlFRTFPWldzT2F0dW9iSCthOGJGcWs5K2V0K016VWs1anM5V1B2MDFj?=
 =?utf-8?B?K2FkMFlBLzljRDA5cWhIckVuRmsvVzBWUjJXWXJuNndiY2pLYkJvRWN0SjFE?=
 =?utf-8?B?V2ZyS1NsVzIvb2tHcmhES0RxSHphV1ZTMXBYNmxzYkpLdDRENnhOZHR2NjU4?=
 =?utf-8?B?YVg2T01YNGswdytsTXR1TnRNWXFoZWxvdllKWGUyUHZtYkRHNy9TNHJ3TUlH?=
 =?utf-8?B?ZTNXNzlOZDlHa3VxL0dYZmx3aXIrNlRQOUIwbjU2bHlySlBpbndMQnJlUkpi?=
 =?utf-8?B?V2I4MTBXRkNDZ2VwUEh1KzZaYTJKR3pRTUFUQ3RTdjhRb0t5MnI5OTNlRWdR?=
 =?utf-8?B?U3hnamoyaWJ3eEx1WjJYYm8wcENmRXJBbkZrQlVYUHE0OUdMSDA4YjZiQnph?=
 =?utf-8?B?ZDd0ajFKSHJIZ2pKTjZJdjAzK3ZrbVVYTmRuK0QzL204VHV6SkNNeDRocXJ1?=
 =?utf-8?B?eDkwc0ZQcXZIdi9Jc2JSdlNkTlBoZmZvckNYVEdibFR4RThXSDFucGNZN1NS?=
 =?utf-8?B?dmRrdktOU3pkWG4vU0drOEQrNlQ3SnRiOTZsdTZzZnpiREFCaEV6UEhhSXNj?=
 =?utf-8?B?SWMrMlduZ0xGUXpqZlBUUUNuZ0NpTjRORmlkdEVNb2RlekVyOS9PZHd1cFpw?=
 =?utf-8?B?aUdROVE5cVErQWhZanJ4K3k5dWhkUXdJZXprU1I4Vk1WemlTcXI4eVBRamVk?=
 =?utf-8?B?VVVwL3pmMGZzbmVSV2R4WFA4bG9Yd2hudUZqZ3NWdjl4RGQ1Wmt4aE9FdDI5?=
 =?utf-8?B?USt0QlY4TVo1R0VxUk1iUTJ6MzV1cjlYaktuVzZBNVJ6UitIL21RZlpBOW5X?=
 =?utf-8?B?S2poQVAzd3BYTSt0TERsOFpNMVR4UXlsZXJXMVVwa1lJc2h2RmZicnZhQUNk?=
 =?utf-8?B?MStVelVJM2xWb2pSMy94K3FHaDJ1WGdUN08yNXJkTkJoWkI3blYrZU9FZFZ6?=
 =?utf-8?B?NEVkRXpaREcwajRVMGU5Z3JLSFY2OStiUWtwWDNNY25rK3hZMlRscmpuY0lW?=
 =?utf-8?B?RktEWnFpMWtyVTFPcE1pMXkxeDBZSHpxV05mN2JhdnZHcW9YcUlrdjVBR1VU?=
 =?utf-8?B?dW94SjZnTFV4YXQ0WkltVjFLN1EzM2pGNFBzb3BLKzczdUZycGdFUlA5V3J6?=
 =?utf-8?Q?DOQSvOkSOWv7Ie3i167uruLc/G2tVaQVe7Fc335c9dag=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUROdkFyaDRCRXZSM1BJa1loSnFVYjlkODR4ZkRYZm9mZ1c2c2F5RkhBdHB2?=
 =?utf-8?B?Ti9BTHBUbUFKY2JCajk1RzFlMXRPanVFMlMxNUdXSHZFTTZNVVdOa3VUTkQr?=
 =?utf-8?B?enNhWkpYZU8vUUNkTmhBRVB5RU92aFJXay95MW1tUnFYeEROTktwN3Y1V1o0?=
 =?utf-8?B?aGF1LzlLZW9GRFBZYStKa2wvb2M2OEsxMFVhZm9RYnVwcXVpeUFQaUYrTGJk?=
 =?utf-8?B?T2xYU0VzZjlYT0ZtSTJtUEtNNDFpQVdiamNLZ01MemZTRkhSU3owVnZNcTFG?=
 =?utf-8?B?NmVOVVNTNWRQT1Fwd09ac1VYUTU3WFpTUng0ZThodXd1TmYwL3dvdyt2SHlv?=
 =?utf-8?B?VjA3RnpBZk1wWWZYT3llY0ZpcStIcFkwUkplTkxSalp2OGpNd01yaUs5Wlhw?=
 =?utf-8?B?eEhvSmJpcTgxVGY3U3JEQS84c002aEpSS09EMmplbFBvTUNkam9sdTVkeVNM?=
 =?utf-8?B?NWFVNElYSENwYmpDM0syZ0YyTUJTcjRUcUpmYXZZa3lOS3VhQVRqQXc3cU9q?=
 =?utf-8?B?OVFrc2VNa3lSR1l3ZkZwMFRJZnQ1ZXJDdzZjUE5MTmlrNDIxREM3SmtiTUFB?=
 =?utf-8?B?MUlMM2lKTGdPR1JFMGQ4WnU5ekxvb2ZITVUzTmswZ2FSb3p5RkxqU0xReTBh?=
 =?utf-8?B?SXR3ZkxCWXZVT1dCQkR3alNVdkVIeGRhWCtQSU9hNmRGaXRGZGFMeVh5ZjRi?=
 =?utf-8?B?b1UzWU5GSFFuemx6YXp6aUZ5NzBBV0JIRlROTUltVXRHSzVUUzhIR2ZEaEJK?=
 =?utf-8?B?N3dPMy9uWkQyYVBnZWpUY2FZd1g0TXNpTHJlZFVzTnpUYjc4MHkycjFPTExv?=
 =?utf-8?B?dVFFMHJ1VFB3WFhkN0lITXlQRkh0ZmozTDRPZVJHSXhyaGgzL0NCOGVJbklr?=
 =?utf-8?B?VzNhSk9ZdUxhSjNzaTlTR0RNcXRQdVdDZXRuMzdBc0NLNnJMM2NpVVZBenVp?=
 =?utf-8?B?TS9SSmo5bjNWdnp5TnRPZmltb2FNbWw3b2tXbFdLUVFYZWF4Wnl1RTBnZkY5?=
 =?utf-8?B?MzZnOTR5SFFpRjFoeWJkL1JEVmZNNkc4VGhmMkVsaVhKL1lrL2VzbzBJbndM?=
 =?utf-8?B?ZHFzZU9uQjkwWDZJeEM4cndTQkJlUGY5UENLTjZrRmRXNkJRdlVRcDNicUpv?=
 =?utf-8?B?NDJCNzhkZXY3cDlybC9TRjlMYndIcS9xeUl1V0NIRTd3UUMvbWo2V0ZXUVZ5?=
 =?utf-8?B?SXNZbllBTFJtWFZrVVJHbkNlekJJZnRmcUR0ZHEyYXRFZzdNeE9xVU13UUJ0?=
 =?utf-8?B?TVN2Vnd1S2Y1cndPZXIwNnJ0aUxWMXh0NFlzZlZyT0hKaUhOMlp6eHYyd0V6?=
 =?utf-8?B?YzdjTXJPcVNkVHdOWmRzWDZBSEEzODhJUmc3U2pPU1hBUGdKSCtMM2dWRG1p?=
 =?utf-8?B?bGZSNjdmQTlSc1FHN1BKTkIrbVlaSktkcHVTSEFEeTZRODY2REpTblhWNlpj?=
 =?utf-8?B?VWRzNmlYb3RDY0tXV3luUEF0Nmg5OStNc0F3T29rTWgvM2x0Y1BCNitVK0pw?=
 =?utf-8?B?d003Nlh3dUsrSmwxNCtJT3BYaUZZVnRCakM2NktqZEpPbVpwOFg4cUxoWDFE?=
 =?utf-8?B?dGxuR0JJa2FaYkJMeENmR2RMbG9ZRFYzWkIyTWFDeEtTNWhINGZFWUc1SFBX?=
 =?utf-8?B?RzhaVkJUT0FCWHBFaHNrM1plSEJZaE05SERSYW8wbGdFTzloMS9xSjFqZmRX?=
 =?utf-8?B?N1Y2cXJyaldHbFN3ZGxpdGRONlpIZG5CSnZyMmVSMVozc1llUHc0d2RpUTE2?=
 =?utf-8?B?aXV1cUxTMCs0UUFlV2c3Ym1jcmU5ME43OTQzTkRnMlQzMEJwdHR5WW1vM3B5?=
 =?utf-8?B?OUhkL0JjbzBwK0w2eC9QblZRQmlMbURNcGFSVWNKRmdDVGZFSEVrVGNtRlNj?=
 =?utf-8?B?aGk4WTF5Smk5bzN3OXBMT1hlMnZ0Ym92ZmNTMWg0SHQ3QWNFc3B6YmdzU2p3?=
 =?utf-8?B?bUY1eUJVV0lWdEFuaFRDV3RycnlISDdSb3Nybzh6UXlYZ1c5TEMxNndnZjJL?=
 =?utf-8?B?RUlwRlhHZEtLK1pRU2lJUGUwUUxQMXh5bEQwWHFmeXhsZXJpZlB3QVhteHBo?=
 =?utf-8?B?T01DUlM4ZU5FTzQ2RUVjVkl1THlFWnBGa2kzc29icGovNVBHRFFtdUlqUkUw?=
 =?utf-8?B?SEI0c3VHSG9UWjQvbk1pVzRGRWpTdHhmUzBiMWZIdU5DZHpsZjZJUGNrcDFy?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d47ea3-b13c-416a-8d69-08dc7404e33c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 10:59:12.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXcOBtxCAcRU6ulfRwtIKjlzdbZBZuIGero84vVwQDGpPVUJkIgVRmAA9KrBvbw8gbY9PfsbfxRghhNhdcbUHFNROdki1E9JUvQv5XTwjdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5874
X-OriginatorOrg: intel.com

From: Kernel Test Robot <lkp@intel.com>
Date: Tue, 14 May 2024 15:53:43 +0800

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
> head:   5c1672705a1a2389f5ad78e0fea6f08ed32d6f18
> commit: 4b0ebbca3e1679765c06d5c466ee7f3228d4b156 [13/66] net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
> config: m68k-mvme16x_defconfig (https://download.01.org/0day-ci/archive/20240514/202405141504.J6WdljEp-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405141504.J6WdljEp-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405141504.J6WdljEp-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
>    net/core/gro.c: In function 'dev_gro_receive':
>>> include/linux/compiler_types.h:460:45: error: call to '__compiletime_assert_654' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed), sizeof(u32))

Hi Richard,

In the mentioned commit, you moved some fields placed before
napi_gro_cb::zeroed and seems like on some architectures this misplaced
napi_gro_cb::zeroed and it's not aligned to 4 bytes there anymore.
Since ::zeroed is used as one u32 to quickly zero the hot fields,
it must be aligned to 4 to avoid slow unaligned accesses.
Which means you need to move some more fields around a bit, so that its
offset would again be aligned to 4.

>      460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:441:25: note: in definition of macro '__compiletime_assert'
>      441 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:460:9: note: in expansion of macro '_compiletime_assert'
>      460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    net/core/gro.c:496:9: note: in expansion of macro 'BUILD_BUG_ON'
>      496 |         BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed),
>          |         ^~~~~~~~~~~~
> 
> 
> vim +/__compiletime_assert_654 +460 include/linux/compiler_types.h
> 
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  446  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  447  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  448  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  449  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  450  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  451   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  452   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  453   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  454   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  455   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  456   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  457   * compiler has support to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  458   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  459  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @460  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  461  
> 
> :::::: The code at line 460 was first introduced by commit
> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
> 
> :::::: TO: Will Deacon <will@kernel.org>
> :::::: CC: Will Deacon <will@kernel.org>

Thanks,
Olek

