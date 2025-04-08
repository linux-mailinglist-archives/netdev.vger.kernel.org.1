Return-Path: <netdev+bounces-180483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD0A8175B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A5A1BA5D42
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDD7241CA3;
	Tue,  8 Apr 2025 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOWZeI5O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3EC23C8D3
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744146148; cv=fail; b=bOyazel4X3z0FNHVSRb4WIym10Zl/fMAovFOKNkw4biB5etqEKeEGgIIWM+9MyoPzcGsHdMFrekyoPLg1ory1hUKK8WNprmYCMUSixpcpH4NvVkwzqdX+VpiWNciPcEClgL+J5HOjA8s7By3iuPaTbETGcpts+ihVIORR6hijgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744146148; c=relaxed/simple;
	bh=Vz5i9bVgPtxBEQIHxYBlTPDLztOV0cmOD2N83g+WnIM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rOfzpZNoIYKBYhNFV6nclVyUg00fTB5TKbZyPjDwkF5S539GmLdUaJiExyyQoU2Wdv2zaZ4keDCBLkzM5GyCW96Vr/83G6Ntr7HhIsphuSuguZ9NN7ZtkMm2hhMMpcYQOPflkVviX2fQ0qm1nAqvnWEiki98lB/jg05UJl6eE2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOWZeI5O; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744146146; x=1775682146;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vz5i9bVgPtxBEQIHxYBlTPDLztOV0cmOD2N83g+WnIM=;
  b=bOWZeI5O+l7IXxypJXRt1UpZA/Cp9KqxtuH+iYByJyHSFBbRQk7UXJOg
   pxtwTErqM8wfjAYLk0kVvH9MwF0J33TYUOOP65F/y++Rt+jm4/LvUzAMI
   RRfqxiXFY/ZaQcG1d9dYS6LoLSNgEGhfGa4cFsNbzuG9DN85qCNq46RP+
   A3jOOwwx0tklgVJftubV1EYzb/ThczbFNudDwHLCQyH5YaKqI1xkUq+B7
   W15DfLkpsnZ9Rr7XXnPuqJMwi7WcJ+Xk9C07pjR4wp/t6/AierLGL5cAA
   ruabQM7s9c1MNlo6r26Nj1NBpXu40QjlTAw6iWHqPehiXFjyHbbquq/Kt
   Q==;
X-CSE-ConnectionGUID: VnLWAilwQNaVkArPDwUN9Q==
X-CSE-MsgGUID: 72zBh13pTZKZMlOrGnXIcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="55785070"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="55785070"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 14:02:26 -0700
X-CSE-ConnectionGUID: V4uYgQ+yQK+HHt9Boy2cAg==
X-CSE-MsgGUID: YgVhpIHfSuSNk+EH6dL2pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="129220885"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 14:02:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 8 Apr 2025 14:02:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 14:02:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 14:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9XH3LrhWGGsYMv01BV5LWtFBvCKUHlLSfW2Xyjn6zJnBCalzM1+qJQJFwpb1oRekm0UBn3ifbZGSROxeIxkZ1el9wTHBFQpqMndWOpwAI3o24RLkQne5Zewwk4AYXsmZdbkpW6dIdgyL7Z9WB5oW7BwG/XPSluyL3nG/F3746Nw4OG88TQjaJtTakw5Yc9EtaGXSjOZB/urtTIdiqIp6eYmiXJVmPAJoyKVn2b9g8eOYgo6vNyjA8pKt4fssAdL2CGFzH1nSXOXr2aJw1A1VruGFvMfXJx606wsnsX3nRAm1lQLSEdPSDS2PO6LwIpfUpD9aa6uBkyiUEVkbfywhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCQx5eZjjgQe2TroqvidcqvWbOya9lrKhEzwCS7XzZo=;
 b=Y6lWg9tohkGYvFt5083y34hK9yqYw8ehEk0B96WG/1TTxjIoTVohaxi5L2L/UaBoWc8vMbzDymi4IomVV5+uhsmTTACm7Fifnc2pGI/qrA2Pw7DhW0dWBRVrNVIjfzMP4RSD9irS5M3mUD9r5/AjGqHhGwRK7Ht4q2Wgo8yd6NU3OkM0Prg8o1UJF5VYpB9YnGOzF9Gm82K+Hv+3ziYFGrW28SAGshJ0ml+Mhh/14KORSKvSVvZJU6vr1YVSHFXv1GIzfszbPBPmUSKBEfYFVVq0Ocp5K/y8yOz57vkC7udo7LFz/APeya39VEZg5XbD5AfWkHn3wI+b8YYoMJynIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 21:02:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 21:02:22 +0000
Message-ID: <50b4f1ef-154d-40a2-8e0d-26e156d81e42@intel.com>
Date: Tue, 8 Apr 2025 14:02:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v10 iwl-next 02/11] idpf: add initial
 PTP support
To: Milena Olech <milena.olech@intel.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
References: <20250408103240.30287-2-milena.olech@intel.com>
 <20250408103240.30287-7-milena.olech@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250408103240.30287-7-milena.olech@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:303:b9::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: d12b9626-d930-4637-5cc0-08dd76e0a826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnVUWmVmTnBNSkx1TWxsaWx0Qjh2NDFTanRpbGQ2ZGlOQ1hTZ2d3bmt1QXVt?=
 =?utf-8?B?QzNYMTBlSktUdklDWjMyc2thb2ZrUUtTZFVyTXFUR0JDbHI4RzZxaUV4MHFE?=
 =?utf-8?B?R3JlYThMemhOZE1VRlo1YUw1WGMzKzhmV1A1ZGFsUGcrVUFRREpwK3RjSTEv?=
 =?utf-8?B?bENUQjdxdzBzZUZuVGN5a2w1REZ6RitkNkpQay9xVTAxMHZjKzZnUGFzRTFt?=
 =?utf-8?B?R002MWtNeGpPNnFiT0c3N1dSOVlRK2Z5RWVlcTZtOTZIMlV4VWx4QXZsZndN?=
 =?utf-8?B?S0xaaGNoTk5xYlB1RFB4Y2ZJQm5Ka3BCZEJ4cC93RkRiTVQ3VVlzdVJrc1J0?=
 =?utf-8?B?bFZTbkRGWTZYdEpCNk50TFhWNW12T09OL2VLR1RHYjlNUGljaUsxSDJ2UDRK?=
 =?utf-8?B?SmgwVGxjMW13WDBtQmhhMXpvdVd1R1grS1dvNmxUZXlUVXhibjFCelAxY2k2?=
 =?utf-8?B?THJMZlZRQmo0YUo0VC9yZTJIQmgxOGk3bitweTAyNHhIYkFVUTVpbWd0TE9s?=
 =?utf-8?B?M3U1WFJBL0cyL0VlUTMrMnFueW9QeW1ma2NmQzVkelJDeFA1ZmJZU2E0MTVt?=
 =?utf-8?B?Skc5Y3V5bnIzYkpFMFlXcDdvblBZRUVibnFQckFDd2d0Y1NlVVVOeEJ4Ny9G?=
 =?utf-8?B?YUVYUkhlNlZtNkhqVFJyM1NiWWpnQWRPMlRYWU1Yekp4aUJac3Azc0VwcXRl?=
 =?utf-8?B?Qlh3LzdRdnBMbVU2dG9LVnFGRlFEM1JCcERoQ2FxT3p3RGw1Q05NWnZmQ0hS?=
 =?utf-8?B?L1lHK0U3OCtiZzg5Y2xGTDVyZHJteHlqenp6eVVhRVh5UWNYTVQ5dE1JRzZa?=
 =?utf-8?B?ZWd1cDZNbFVaY01GeUhkb2NIUTBXTnY2T3ZuUjhtYVV3ZVRaczF4TTZJb1FL?=
 =?utf-8?B?VHRvUGdZaUpPREJoaDNmTE9tbzFzNU9tSVpzc2ZnQkFhanl2TTFSOFVtMUkw?=
 =?utf-8?B?RTdneGpQRUNyZ1Ywb3RCRHF6b3ZuWElSaWx2d0cxdVRUZU43S3lNVG5GMVpt?=
 =?utf-8?B?VkVvVGNCUnlNU2VnSGZFSzhEU3p4Ri81RTJBcG5IV09Rb3ZrclZqVzc1a2dO?=
 =?utf-8?B?dnV1QkJCb3cwdTFjQXYrbk5oclZ1RllHNUJybExFUUVwYmJpZUM1ZjZoTkRX?=
 =?utf-8?B?Mm84VUtmY0NESjlySFdsTm50Ynh0NE4zVW1VRFh5N3RuWjlpMnZtZCtNa3Vw?=
 =?utf-8?B?QXZHa1g5U0VDSi82ZUllVGxQM01MdGk3OWdzcWRIYWZOSDl0UUtlVFd1SVRp?=
 =?utf-8?B?bmd4M1dTYUJnOFRhZnB5WG04QlphUzFZdk5kUjlIeDFDVGJ6cW4veE5vRzAy?=
 =?utf-8?B?dnA0ajRTTnBJZlUyMmt3dDR4Rm1ZT3ZSbGl1dE0vK0dwV2F5SnRrVkxPTTZj?=
 =?utf-8?B?RUZXZUM3YTEwR3VtUFZkNE9ndlZ2WklIL0ppdDRVaFA1VDVZL1ZDTi9BN1JM?=
 =?utf-8?B?ZFNiTllWSW15bW9ST2RvdUNNZ3QrS3dqSklTMGh2NlhYcVRFdzZCV3Q0ZFVt?=
 =?utf-8?B?SmNtVGpyeGpwSlROR2p6VURpd1RwengwQzBBVlpHNVM1TVJobjVSWjVuaUNj?=
 =?utf-8?B?c3E5MUR2ZVM4b0I3ZjJzVlFKOWxmVk9kZS9PNWtBaHpoQytnLythTGtFQTJk?=
 =?utf-8?B?bFplb05xYjliYXcvU3MraEdKYXRPUlZrbi9WUWZ1ZlFReHcwMVBVS0Vma1lJ?=
 =?utf-8?B?Q2VSdUllQ1BPN1JiaUdRT0t1K2hYcFlla295WkhYZ0VGNW1qUU1JY2x4bks2?=
 =?utf-8?B?azNJUTNqbHdHNDN5RDZHMTlrNlhaY3k5bTZvV1k0VWI0VlFsRFF1YlhkTjhY?=
 =?utf-8?B?TnkyTGFhUy9EZSttOVRvSWxrVzdEbkJQSm5Mb29FZjZ2alpzWjkzdkpzR3h2?=
 =?utf-8?Q?Po4R4U6COZ8ai?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWQzRVlnRUV1MXdPTE42Y0hiN3ZacU5od2J3ZThJd2htcE5YcFhzQVFvZVRV?=
 =?utf-8?B?SSs5MjVnUVVFRHRybHhwaHJGdWFnT3hiL2NZZmUwLzlaczF5K2pGanR1RFY0?=
 =?utf-8?B?ZlpxL3AxUFZ4dFVuR2lycERCKzFLclk1RGhZcllGSHNkSWdVTERyT0Nsc2pG?=
 =?utf-8?B?NWYrdE4yMnNKeGkxRUJ5OUNGNUF3TVlMd0UzUjcvV0tlUEJWclo5QmZWc0FW?=
 =?utf-8?B?UTlIZFZJMk96cHFPdks0b1lmcFlsRVoySnRJMzdGR25BSkFUL2dxY3lRY0Ro?=
 =?utf-8?B?blBvZjFvWmkveklmZFpaM3hZSklsM0N2TGpESUorK0NHN2FTS09mVkNrbkdh?=
 =?utf-8?B?V3FDRUZCMXZZdUlab1ZEVUx6Qi85SnVSSFRsZkZXSTFtYnkxRnZTRWNPcW53?=
 =?utf-8?B?ZVFycTZoSSs4eTA5QithMFlCbVpFOW9EUWhoUTk1U21ZYWs0OEFKUmtjK1Nk?=
 =?utf-8?B?SG1CMDZDbjg2L3pFcWVMc0I1UGhvYTE5T3ZFMGVBd1lkQkcreFpSQlJxQlhV?=
 =?utf-8?B?TGcrMjd3N3FYRnVOYlVqTnI1dXVRSWF6dStSOEZIbkl0ekViOXI4cVI2S0Vl?=
 =?utf-8?B?cGxmNC85QmNkWGYzMVFVMGFMSFFURy9NbEI0RWh6c2RxME12d2szVnV1S0Rl?=
 =?utf-8?B?ZjgxdWdtNUVCcHdLMEI3OE1LdFRwTUNmSWpOYXZFYmUyTHpyOWJuNDVRTnZL?=
 =?utf-8?B?RVlvMjQzOG5lbGVkT2VSd3dYbDJibzN4ZXJUUmhxT0hiaVNFY09sRXBQaEwy?=
 =?utf-8?B?TllyaUlNWU5tckVLS3MvZ0k4UjdpcWJvTHlkYTZ5UnMxcGRvV3hodEJwQlk3?=
 =?utf-8?B?U01Idk9Cbk9VRjlqaCtMNUhYSDUvMzNUckl6ckIvdXZLTmpISGxRQzNKOWlJ?=
 =?utf-8?B?ejErTk5yTkxXdHR5dCtLNjY0b1RXV3Rwd2FKOTlLajBBd3JJdjRjRGVGWjgx?=
 =?utf-8?B?QnFuRHh0SjRWck1HdzVtVHFtRjNVNmdSMU1aNmN2VUJ0c3FFNUJqd1YrNG1B?=
 =?utf-8?B?V3FyT0RuNldHS1VLY2Y0WUFlZ3gzMmlMbEZDTVMvWFJ2L1MvaHRLeVV4OFk1?=
 =?utf-8?B?NGxqY0FaS3ZsNHlRVFBPV0JTeThMZ2ZLSlluQVdBNVFqd3d5azBqc0w5cFlF?=
 =?utf-8?B?a0ZyK25ZYU9JSEZqSFMvZFpISUhFRnQ4cHA0K3BIRUlnRE10YVVqRytzdHVW?=
 =?utf-8?B?dUdRQVV1c0E4R1pad0NicWxmRnJIM2U5UnBkRnI0dVB4U3I4ZGliLzFpaEdE?=
 =?utf-8?B?MVpSSWd5RHl5a1lDUGtxYmtsVnVyZ2Zsb0MwdXZqNmdOanJBNER2ZmVHeVN3?=
 =?utf-8?B?cGMweXp0UzVXOWJnbnU4d3dBemRCUENvUk9KTkVsQmRsSkY2QStTcTRkMWcr?=
 =?utf-8?B?aXlFRTZkZ2MzUDdHUk9DMlY2NTlWNjdUWUNpM25JdjNCaHJ6V09HRjRXSDRW?=
 =?utf-8?B?TjFuem1ETENEQlNKK3pqbXAxNlpueDNGNE5WdEsyMTdJLzU2anpUSFZKYzgv?=
 =?utf-8?B?NXN1cTZFeGs2YnZVcHB1L1BybklIbXJSbWpoK3d6blg4dU5JNFREbkk3aWYz?=
 =?utf-8?B?S3V1L3RKc2dkNUxERk5kT3FwblJZbmx0cnk0S1U2c1JLNFJGbVplbzFPTU5K?=
 =?utf-8?B?ZEJzOU9PKzBSSm5aYnZELzhkUXFtMGJVOE5mZ2xhbVl4ZHBjUmFvemtxV21t?=
 =?utf-8?B?bzl3QWsxNVVmbzJwRWY1YmlKRnpvL0hYN0kxVmFnZWIyTWF1dlpWcnZoWjVW?=
 =?utf-8?B?Q3VSdHBhcjZIc1p5M3BEUmRsT1NnU3N0UmVWVCtjS1BzL0VtbWZFU2d0M3FL?=
 =?utf-8?B?ektaWEpZOENqS2VYMkdIUGd4VDNWWU4vWHFSWWlKRWhTOUhiSU1NZXJXNUIx?=
 =?utf-8?B?Nkl2TlpYNkZFTnkrdlp5d2dyditRVExnRWhUbytaRmtNTFEzYmFLSFlZUGMv?=
 =?utf-8?B?eDQ4bXdiclY0dzE1cEhObExDV1BTNEs3Slg5Z09XeTErK25VakxnSy9Rd3BQ?=
 =?utf-8?B?RGRLYW5Hc3l6WWhHajFYWWVaeituSFBac2RqMXBXWDRoTjVuUEhDNnE5VGhj?=
 =?utf-8?B?b1gxS0dQTlp0T0pCcXhQendUQk10TlZ2c1pmdDE0eGtqL3lZazFWeVdZZ0VO?=
 =?utf-8?B?WXp5M1VUWjljbmRUZzRXd29EVTRBb1Z2c093MjhKVERUK3AvaVh6QzhnQzkw?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d12b9626-d930-4637-5cc0-08dd76e0a826
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 21:02:22.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYLkkVbVIifPOrKnkAnYtExVbFXr1EmXnELBXqikuPljsqmMi5pWlyrFzmzwt9qx3mjkopM3q2Uk7go9XWR/mTZT99l0SJ7NNuEcaG02rw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
X-OriginatorOrg: intel.com



On 4/8/2025 3:30 AM, Milena Olech wrote:
> PTP feature is supported if the VIRTCHNL2_CAP_PTP is negotiated during the
> capabilities recognition. Initial PTP support includes PTP initialization
> and registration of the clock.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Tested-by: Mina Almasry <almasrymina@google.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

