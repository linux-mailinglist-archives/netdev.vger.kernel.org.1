Return-Path: <netdev+bounces-254956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBikIHj8e2kuJwIAu9opvQ
	(envelope-from <netdev+bounces-254956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:34:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCDFB5F1E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73B6B3005592
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5911A284693;
	Fri, 30 Jan 2026 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVXnD8yt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EA256C8D
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769733238; cv=fail; b=m29xJGI/qLFdf+J5L8WAeg6qm1ZgrlHar5fg90PlvQpNzg6rEjhT7+Hj6WadrEfezThiZIbxdp0mrfAXSCBkrBwXh/a3pce5KrQtVHXTZ4lgF7VsCqplXduFR1if0By6bAXdYR9mDb0KHQBjfZJ/gul+dvIWAaWoO3+9Oa0kOdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769733238; c=relaxed/simple;
	bh=vmHowTO33Ico8ZCBwuYQU6ubFElHN1pMd+2QQKzunco=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jjJvbxp9YcDgaRswbB/bgqyNB0/zSokKMRXHT6ClUDv//pkm57CBCwSaJbqCMYJ4tOU1IQfCyIb68vL3e0Ty98g7kIrtpUpusqHJuOArDDrkxrIwXuGBU3wJV2akiduWJ+QiSDsbJVW6zGdAvEho3hMp4/Vk6+Bzg8R8jdN6sJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVXnD8yt; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769733236; x=1801269236;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vmHowTO33Ico8ZCBwuYQU6ubFElHN1pMd+2QQKzunco=;
  b=TVXnD8ytP3gpjoWdtfcLNZrpT8j7ZuuftMm6xvWri+1FalFnryDNcJci
   Y6AwD+r6Drw1JC08rI82WDRhS2IwpD5VhbOulJjiXv7/O7gIruAziT15I
   +R9YCmZ10GuRhVNdnePeeC/Eyk6hY/LUnkeInr30W84Ep93yyr4beyKKW
   psFOHRzuCjPQkVU52Fd92VGfBU2a3h8zRIWwVQwCdbztx756nqcqZ0Jzp
   f3Q2OcUysPwzpkO401UlTxnbdmMinzjIqxX8p6RvSOD1yTF9W+H2QNDkD
   +WKJF2Z58trvLjBHEmb39rJc5YRmQhjs5M9/8jOKTQhXJpK6hSOGu6BrM
   g==;
X-CSE-ConnectionGUID: aw3LcVWXQT6lMFnAGKJJmg==
X-CSE-MsgGUID: 981lHVHuSpCNon/6WbTnPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70002084"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70002084"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 16:33:55 -0800
X-CSE-ConnectionGUID: YjT58eR9R/q8yee8nTcJgw==
X-CSE-MsgGUID: n5j5qqKmSJ2dPSyI2AMF9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208728064"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 16:33:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 16:33:53 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 16:33:53 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.47)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 16:33:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiLfmztOBH41e7kzdtKutidV47X1AH4UjQk7Yb2bTnvmaEjozVQ1GqfcwZ/Qe7lfgEp+HCKhOWI4+bXN2La2RjErEovKqogsQT5CXJgb+aCuAfQ72aI//Go2FMWiKqsOg2Mis9NeUrKRgVFGj0igRQcK9xEjA/LXv5ocY9GGLDvTdFCEIqANUnpQhZNj/5dJAo18sQd675ZBL005Ah96Dkq6q/wkFbVFBAKz6TiTZZF+M2iXaMx3WytErRbtopJeVGa7ekqJj2ksCk0W/fudWfex/HT5CBfwDFyo7ZECRiE6fLcJm1kQhOUevWb5rgwdVAh9SZ6wtAe3KNWyHU97hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIwcBvwXUe7WeDBBOdcsvH2gl9ew1BPRBdiia9wZ3LY=;
 b=fGT5J7cDfm+g8QXq7khiyGx5U8A9RpW0SPlBj+9UEJPfWgAcwQCVb/En4Fdll2KlCvBLuR9egMK7XTdK85HSAz/SF/7FnE/I9G8ooPU0yaJ/FbXYXIT0LQCYJo4aVK3kc6ya02zHhmCL4j3oq1Oj3D0FHXQJbu4a2ml2b+74PtbjzISyHFwQMnUU3Y12+l0O45rAs0oBRDhQyx4Wphos9EdfFoQIaA1cn0WcldXP9u/hYf3up2RL5dHs0BbR1ClaYd+xpbPI+C2xSknQ8t63eHuiIZdLiatfIBBl8wgEnzQvqlt3pLcV4ewenkQ8RblYpGDk9mgsPjy95qGbf0+N6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS4PPF75D68BA1B.namprd11.prod.outlook.com (2603:10b6:f:fc02::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 00:33:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 00:33:50 +0000
Message-ID: <18a7b477-9b4b-42ad-8738-05c3c4b497b5@intel.com>
Date: Thu, 29 Jan 2026 16:33:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: only timestamp PTP event
 packets
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<przemyslaw.korba@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20260129-jk-i40e-limit-timestamping-v1-1-0495e6e7d318@intel.com>
 <e5751b33-4650-4b9f-8b9d-7f9297b1e67d@molgen.mpg.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <e5751b33-4650-4b9f-8b9d-7f9297b1e67d@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS4PPF75D68BA1B:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2ba59e-9409-495b-d448-08de5f973d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDZXWnNUZm8zMnludFZDL2pmdzhYanFNeHNyMzVVMmtZOEhYMWZ4RFlXOG4w?=
 =?utf-8?B?eHFHMDN0M3JnaWpHQmRhNHArZVB0eE5SWmwwRzZsRUd5Z1A5dVR1dDQwb1gr?=
 =?utf-8?B?UnZ2dFV2NkZ5MDE1Q0Y3ZWoyL1JYb0ZRaTJWU25JanFYVnhvY2xIaVBMREVn?=
 =?utf-8?B?VmVzQ0lONUJhWGJBdTNKL2laMGp2MWsvdVB2bngvRDhwTmZxZ2htYmoreUlZ?=
 =?utf-8?B?K2dpUmZWek0xWmsyTVJoQnQzLzYyUVdtSEt2VGJ3Y05qSWZLZ0REZ0c1a0ZR?=
 =?utf-8?B?VUJ6Qk9QSTlOcVJqdTZEYkErYXNpcUFEcVh3dnpCN00xRWxBMElUUTlWL1l6?=
 =?utf-8?B?SjdoZmFNMlAxVm1PbjRwc1NsdkJEcUE1cDBKOTA2V0c2bDhrRjVQcWhzTU1j?=
 =?utf-8?B?ODZ1RTNsdi9BcCtRMEJJYjRWaFFqOW5UcDVOT1laeElhbW1pcUF4ZnNHQjh5?=
 =?utf-8?B?WFdJWW5vRHQwSEpaT1ExbzBMdWRmNEpTSnhteUpyOE1aalJyUmZoY1FSTms2?=
 =?utf-8?B?R2hpeGtHMjNsN0VDWkhCdkM4VUUvaW1HcUpUTG8xTFl4MFd0VXJpMm5Vckdx?=
 =?utf-8?B?dTlYNml6OWdiSTVhQkhBYmM2citFTnFVYlZRM2xpNlc4NHhQdFA5b1hKdEo5?=
 =?utf-8?B?bDJnOG8zeUkzYTVHenhhUGlVNmZ4YXpFTlBnMHI1MGFqRDh5aW9WcU9jTjU0?=
 =?utf-8?B?UWMwRFJiOFlrSm5WOXdxN3htakZSSnFuR0wzUHluNk5XdWhwT1VqSHN6NFNH?=
 =?utf-8?B?dnZCekFzLzRqTzczTWJsdlVoTjRCRmlVS0ZHZE4wNTliQ1VDL2E0Y3E3LzJJ?=
 =?utf-8?B?VGRxc1owYVpCUzEzaTd4UEFpcE1aR2xkK3ZTNGNPNkFjR2tmREhPSXAxU0h4?=
 =?utf-8?B?Mm16TjhkR2grV0p3SW9jTHBEcTErZ2FEbzl5eVUvYitjYU1SaWw2VWlyN0t6?=
 =?utf-8?B?MStONmE4UGptekthKzIvREd2RHQveCt3enUyeHlqczQ2NFBzTGZyWXFkOXZt?=
 =?utf-8?B?dnpGRklQdHpmQ2Z5RjQ1REhJMTNTOTlKUUtoWmpLSThBcmtiVnU1U2ZaTlVC?=
 =?utf-8?B?OE8vWnM2eEkrUnM0ZWhVVW1UWDdqL3ZmUmdVYnYydlhHYTB0dWVDaGhGeUs4?=
 =?utf-8?B?NVc3Q08vTE1mNml0WVhGaC96V2RaV2g1eXVvbXl5OGk5MkVqaythemgxalhl?=
 =?utf-8?B?d2FkN3I3dUd4ODBteVdjOVBjVjN3MkhlTUN2MXhhalhidkVwRG4vZnBGTkJW?=
 =?utf-8?B?VkZDOXloa3VKbkNNYjF6VlhzVVc2WWZHRFVWLzVWcUNmdGMrZnl5aHJDSGZJ?=
 =?utf-8?B?WnVIN2tjclN2NlZybHgzVXAyR21KZzE5MmpVNE15eGkvVnh6elBNWVBDKzRU?=
 =?utf-8?B?L0pqQUYyZno5TGdqejlmWXZheWFFR3BkY2ZwUzNiR3FsNkRSWmRqOVhqQ3dZ?=
 =?utf-8?B?WlovL3dXTWpObnY3Q2JQTnBMaVZaMExndXdXMy9lTDVvWkhvOXZRV3FPOGpZ?=
 =?utf-8?B?MDdiT0U2cnpTaytIQkdTeWpQa21ncXlBYU1ubXNFQjAvTFpPTjVuWXNWdTBO?=
 =?utf-8?B?QTBRVWxtTnhZT2ZsRTJkTzlVTSt3Rk9OdzFOcmxzMjIyNHYxdEhOMWdoV3pI?=
 =?utf-8?B?TEhTQ1JkdDBuUThYOVVYTFRDV1BobmRYRTloTFdnUWdGNzhyK2tVdWN2bGZZ?=
 =?utf-8?B?M0hQdW9mV2pTdS91UzU4cVRyRThIRE11UEk5Y0xJWmdpLzlyZ0tEVkg0amxP?=
 =?utf-8?B?blozbW55V25ISmNzeUlnR1hVVFFFQTEzdXIweHNtT3Y0NVlUSUVvNHgxTTRO?=
 =?utf-8?B?SmV3b0NJL01FbU9lV3Zrcys3eU5aRWpxZFFranZLYlhXQnp2K2xGdzR2T2pB?=
 =?utf-8?B?VTNhYjV1eWNxTVdwZHZKL1FaM1BrUkZjcWdBQ3NjVUdtNVpEV3NaVjJjVFRE?=
 =?utf-8?B?SUh6Y3RZV2FYRm5TQ2VIV3N2ZkFCQkpxWlpIZmNvT0ZsbTVMQitaenZxQjQy?=
 =?utf-8?B?VjEvWGtLRzE5d1h4YldkWjBrUVRqbjdiU3RONlhaUmxzL0tPN1g5OStwam1W?=
 =?utf-8?B?RmVoZXhPN1BISXU2ZWduRnRyMUUvWWo5dk4wcnVRczdsVWZzSDlJYmpUYVNr?=
 =?utf-8?Q?k6UyqL3Ly9tGKRgXY4AqvzuLb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9wck5kaEJNZVkwUDg2cnQ3VUFjaVB5UWI4bDQ3L1VsSkVGczBjajErYlRm?=
 =?utf-8?B?aVNqZS9lblpZb29GVjN3VFVEOGFXM2FVRXk1blg3WCtueTlLT0dPWTEzY2tk?=
 =?utf-8?B?WWkxV3liODBiNFdleS9YN0gvcDRsZUgyR0k2UjdueUpzcEdibWVuOG9sRWFD?=
 =?utf-8?B?K0Y1N0lWZjZSWGhDSzk0dUhWdWRIMGxndnE1T1dwOTFCZ1BHdnVDR0ZDZXdO?=
 =?utf-8?B?OElSVzlUenRLcHhZUWxXSFhGZ3JJNWRnOTJ1OTlRSkpIdllmRzRnS0xFKzNP?=
 =?utf-8?B?bFFZaFNmUDVXV0pkYzRvZFhGbXdUaklsT0d6N0xmbmFxajUzd1hESU84QmJU?=
 =?utf-8?B?cUlrKy9XMHBFdkRicXJoUm94VDMxUm0zeWFjNlc5d2VOS2xGZzUwRWk2dytL?=
 =?utf-8?B?Z3ZwNUs3Z2NsSElhaDBHU0hwSmIxa3VmQjUrT2kweG42b3l2UzF0ZGhjeUov?=
 =?utf-8?B?ZHMwZHJCWlNLRlJNbEdKZkw3TDU5ZlFCMCt0N1c0a1l1SlBrYXdQZzJYR3pE?=
 =?utf-8?B?QnJ5NEJrclUxb2FhTktDTUZ6NjMxUkJXVEptQWVmZk1RY3ZaN3lQNXlWd2JZ?=
 =?utf-8?B?d1QrMEF4RmFFeGhHOHMwMzRaUjJaTmNmOWllYkZjMlVWQk0xM2xDNmF1M0Vy?=
 =?utf-8?B?WkJLNmFZZ0t2SVJaQ0RYd3pxZWFnemVORlVRVktpTmtVdnBjNEtDb2xZNGJM?=
 =?utf-8?B?WHdEWDdnazUwQTVkNGZ4RWZYZTFUNzRHd3FDdDZYM1pVZnNqSWorOTJtbmlX?=
 =?utf-8?B?dXo2UjlWMDVXbDlLZXNIMnhFblRyYnJwWVJ0TWk1OEpPK0NjVDFjWlBNOHpJ?=
 =?utf-8?B?OFhHbkxCdXkwL3J1Z0JuQnJmQUJWa0g3Ly83S3E5cENTN2RzTk1nMzQ3dDA1?=
 =?utf-8?B?VnJ1bFIyS0F1NUZaR3dNa25tM2xZQjNKdXpnRFkxaFlaSElpMndtSG1DMlpE?=
 =?utf-8?B?TkxGRmFhMFpTSU5KSE1RZXNOQURyVmpZRkJMdENFK1lQclFFUXhzalI3N3JL?=
 =?utf-8?B?WktMKzBkRlllcE5OdGNjbEtOMzUvc2VVeEE5U3JaOWVWR3JRUG9VaVp1ZVVW?=
 =?utf-8?B?UWZONTkzWFFyNXdlTzA1SVpucVFnNGtYZVQrVXhnT2I1bGpuL3QyTFhQRVN0?=
 =?utf-8?B?MzF6MGZQNEIvQXB3Q0FpRzRiYTdFNHdpUURVamZKTWN5bUErcjRhNXhZWjZL?=
 =?utf-8?B?N3VNZ29VU0hJS1lQNDlBemlzSWF3UHhudGdyTEx3UnN3WlNnbU9NUk1pTTBo?=
 =?utf-8?B?V1dWZS9sQitTbVJSMGtoZzB1MWY2aExqM2VpOC83clBXOU90enJ3T2NFUkha?=
 =?utf-8?B?eFNKTGRSQ2dlRkh5MDFzM3FjeGpFY3pyT2lHTkE1ekdVVXEzN09Seko2dUFt?=
 =?utf-8?B?QVpQZlRoNWNnNkFnZlZ0ckhXZzdSUVFuU1pIT1p5MUdlNWdycStRTjJjcUo4?=
 =?utf-8?B?YzlFeTM2SWlvWTF6bUhtOHZTT0prckRWMXFFS1FpS09KbGF6empSTGZhNTJF?=
 =?utf-8?B?WCtnbWUwazJ3aUl4c01NZTE2dUdiOFlybngzSjN3am4wSFJaaXo2UWNrRktu?=
 =?utf-8?B?OEcvZlBPSnc2cytrUTZQdXlCd1Jva210Z3plYVZWMTl3amtVdXdNOTdsN0M0?=
 =?utf-8?B?S0huaEt4NUxGYkhqaGlXZzF5SWRYTEhUcm5MVkh2S1pRUnRHQ0h4TzBSUlFT?=
 =?utf-8?B?RFdVc2JVWTFoR25YTmRPaFU3NkdjTlFVK0l2eXlsS3VEZWI2ZFhRSCtQOTRG?=
 =?utf-8?B?aHVsVXdTQ2lRZHFsVnNqSGVPbEZMY0laZk5kUEhBa1pNWUxNUjcvTkpMNHlT?=
 =?utf-8?B?RndiYUkxYVZ2QmRCTUtlTkY2elF6NmhEWHYvREhDN0k0ZlhmL2h4NE5jMFov?=
 =?utf-8?B?bVpHbXRzUlVRV3Fha3BLVkppdmJPbm1pS3RPbXROM1pEaWdhYWtyZk5BNkxj?=
 =?utf-8?B?M256NXVPOC9ucllUR1RhZERJNmVmbHE3bll1N3hLMXlqNjNXS3FSVzE5cTlj?=
 =?utf-8?B?ZkVqMkdLZ2svWVRhOFpOc2F0dlJRRzZzTWI3NUVZaWxxOGY4M3hCaEFabHhG?=
 =?utf-8?B?bTR3KzFjMlBqNVFTUE1oSFFqZTNUUW9jNXV4ektIUTROUDlTZHdyNUlndHp1?=
 =?utf-8?B?MUg3MDlCMG5EclhDSGN4cEZFV3VPamVKT0xUU25nNkFnMTdFNVBUQjNXOTUr?=
 =?utf-8?B?UGQ3N29XeGovODdyVGo3aEVvTHk3ektKZXlPaXc5V3hEZzdhOWtkZytPbmV4?=
 =?utf-8?B?dHpFREphTmVTblB3SlFUUHdsSGtvK0VQYm9yS2ladXQ2TkVOOE1DZDcyd0FH?=
 =?utf-8?B?cVFGQVlOSG5qMFFScEVyMUZLME04NzBHaWY4eUQ5TTVDOTluQ2tEUEFMRTgz?=
 =?utf-8?Q?zWmhfE0kQaF2MpxI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2ba59e-9409-495b-d448-08de5f973d06
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 00:33:50.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N605NQl1GEDoEO8tQ8A8EibjKtM9rsa1J9xVwIQNH+mpyawSTCb8OlN7ygpvTCKyNida4X3a+zfHknTPzpjku8cQQ9fs5gQWq2mQ/e6BFk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF75D68BA1B
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1FCDFB5F1E
X-Rspamd-Action: no action



On 1/29/2026 3:45 PM, Paul Menzel wrote:
> Dear Jacob,
> 
> 
> Thank you for the patch.
> 
> Am 29.01.26 um 22:52 schrieb Jacob Keller:
>> The i40e_ptp_set_timestamp_mode() function is responsible for configuring
>> hardware timestamping. When programming receive timestamping, the logic
>> must determine how to configure the PRTTSYN_CTL1 register for receive
>> timestamping.
>>
>> The i40e hardware does not support timestamping all frames. Instead,
>> timestamps are captured into one of the four PRTTSYN_RXTIME registers.
>>
>> Currently, the driver configures hardware to timestamp all V2 packets on
>> ports 319 and 320, including all message types. This timestamps
>> significantly more packets than is actually requested by the
>> HWTSTAMP_FILTER_PTP_V2_EVENT filter type.
>>
>> The documentation for HWTSTAMP_FILTER_PTP_V2_EVENT indicates that it 
>> should
>> timestamp PTP v2 messages on any layer, including any kind of event
>> packets.
>>
>> Timestamping other packets is acceptable, but not required by the filter.
>> Doing so wastes valuable slots in the Rx timestamp registers. For most
>> applications this doesn't cause a problem. However, for extremely high
>> rates of messages, it becomes possible that one of the critical event
>> packets is not timestamped.
>>
>> The PTP protocol only requires timestamps for event messages on port 319,
>> but hardware is timestamping on both 319 and 320, and timestamping 
>> message
>> types which do not need a timestamp value.
>>
>> The i40e hardware actually has a more strict filtering option. First, 
>> only
>> timestamp layer 4 messages on port 319 instead of both 319 and 320. 
>> Second,
>> note that hardware has a specific mode to timestamp only event packets
>> (those with message type < 8).
>>
>> Update the configuration to use this mode, so that timestamps are 
>> captured
>> for only event messages. This replaces the use of the 'wildcard' 
>> option of
>> the V2MESSTYPE field which caused timestamping of all message types
>> regardless of whether it was an event message.
>>
>> This avoids wasting the valuable Rx timestamp register slots on non-event
>> frames, and may reduce faults when operating under high event rates.
> 
> Do you have a test case to reproduce this?
> 

If a remote PTP client has a high sync rate (for example ptp4l with 
--logSyncInterval -4 or -5) it can potentially fail to get receive 
timestamps due to missing slots. This may happen because we're wasting 
some slots timestamping follow up messages even though these are not 
Event frames according to the standard. I originally developed this 
patch while trying to solve a particular missed timestamp bug but we 
ultimately root caused that issue to a different problem, and this 
change was only an insufficient stop gap, as we still had the other 
issue. See:

https://lore.kernel.org/intel-wired-lan/20251120120750.400715-2-przemyslaw.korba@intel.com/

This change would potentially allow an even higher message rate without 
issues, but we tested the specific deployment that was using -4 for 16 
sync per second and it was not necessary.

> Can the other mode be enabled somehow for people needing port 320 and 
> timestamps on every message?
> 
No. The existing uAPI does not have a way of expressing that, and 
applications should not rely on device-specific quirks like this.

Here's the complete list of existing filters:

> /* possible values for hwtstamp_config->rx_filter */
> enum hwtstamp_rx_filters {
>         /* time stamp no incoming packet at all */
>         HWTSTAMP_FILTER_NONE,
> 
>         /* time stamp any incoming packet */
>         HWTSTAMP_FILTER_ALL,
> 
>         /* return value: time stamp all packets requested plus some others */
>         HWTSTAMP_FILTER_SOME,
> 
>         /* PTP v1, UDP, any kind of event packet */
>         HWTSTAMP_FILTER_PTP_V1_L4_EVENT,
>         /* PTP v1, UDP, Sync packet */
>         HWTSTAMP_FILTER_PTP_V1_L4_SYNC,
>         /* PTP v1, UDP, Delay_req packet */
>         HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ,
>         /* PTP v2, UDP, any kind of event packet */
>         HWTSTAMP_FILTER_PTP_V2_L4_EVENT,
>         /* PTP v2, UDP, Sync packet */
>         HWTSTAMP_FILTER_PTP_V2_L4_SYNC,
>         /* PTP v2, UDP, Delay_req packet */
>         HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ,
> 
>         /* 802.AS1, Ethernet, any kind of event packet */
>         HWTSTAMP_FILTER_PTP_V2_L2_EVENT,
>         /* 802.AS1, Ethernet, Sync packet */
>         HWTSTAMP_FILTER_PTP_V2_L2_SYNC,
>         /* 802.AS1, Ethernet, Delay_req packet */
>         HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ,
> 
>         /* PTP v2/802.AS1, any layer, any kind of event packet */
>         HWTSTAMP_FILTER_PTP_V2_EVENT,
>         /* PTP v2/802.AS1, any layer, Sync packet */
>         HWTSTAMP_FILTER_PTP_V2_SYNC,
>         /* PTP v2/802.AS1, any layer, Delay_req packet */
>         HWTSTAMP_FILTER_PTP_V2_DELAY_REQ,
> 
>         /* NTP, UDP, all versions and packet modes */
>         HWTSTAMP_FILTER_NTP_ALL,
> 
>         /* add new constants above here */
>         __HWTSTAMP_FILTER_CNT
> };

There is also some documentation available at 
Documentation/networking/timestamping.rst

In particular, HWTSATAMP_FILTER_PTP_V2_EVENT must timestamp event packets.

None of the modes (even the _UDP_ ones) have supported setting the 
specific UDP port.

The current uAPI requires that you must timestamp at least what the 
filter indicates, but may timestamp more. However, there is no guarantee 
what "more" is and it is device specific behavior, each device is likely 
to implement this differently.

We could extend the uAPI to better reflect what this device is capable 
of.. but I don't think that is worthwhile. The PTP standards do not 
require those modes and I doubt any application actually wants these 
timestamps, or if they do, they actually want HWTSTAMP_FILTER_ALL (which 
the X700 series hardware does not support).

The existing code for i40e timestamps additional frames, but only PTP 
messages, and only on port 319 and port 320. It does not allow arbitrary 
timestamping, and it is not useful for PTP applications following the 
standard to timestamp the packets on port 320 nor to timestamp non-event 
messages.

Since the uAPI does not allow specifying such a case, an application 
shouldn't rely on device-specific quirk that it does timestamp those 
packets. It is not cross-device compatible. The interface explicitly 
says "event" frames and doesn't list a port or a way to select a port. 
Event messages only go on port 319 by the standard, so packets on port 
320 will not need a timestamp.

I felt it makes sense to align with what the actual uAPI requests 
instead of over-provisioning and timestamping many packets that are not 
required by the requested filter.

