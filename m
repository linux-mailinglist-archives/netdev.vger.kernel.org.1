Return-Path: <netdev+bounces-90835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D0F8B05F2
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA451B22E58
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B934158D83;
	Wed, 24 Apr 2024 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASQ48Eaa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9A1E4A9
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950657; cv=fail; b=vAECG6iNzOWS7zrXEBoX6XaotAk5zOiUhQ0UEBtFj0M+ryFeoPqK9M76a8c9sv44o14xInl6mEOVKNtNK8039swcGcZBgz67dKp7oew0VB5fFso3YxFclV/JJ97hoqrt9UkdyZg0K6jcbvv6bJ9O5d4b4Ff/oFlG2gRTgjh8Fgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950657; c=relaxed/simple;
	bh=/Xqrz2ANYsGk3kNdq4L+pvgqYESzh6m3+1imrpMUVpU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CP13B7VliZ/ktERyPsJ0u4yuUUJpLq9AhufUQsSjOTJZa3Gl+0yBiZrlEfQWx3teRLVJNbEBC2CYNPtArUQR8pzF5jWB4r9mZOLusNbBRvW1PnZivyIFy1FAcG0uKwHnbCijYGXH5Cj1sh+A8nOdx/5r/q+bZgTlYazSoJvGGZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASQ48Eaa; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713950656; x=1745486656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Xqrz2ANYsGk3kNdq4L+pvgqYESzh6m3+1imrpMUVpU=;
  b=ASQ48EaaS8RE9Xkga862lrRsIsDmSxPQKBeeoeCGeS+Ee4lsrn+0iwz3
   +d5pOL86hjX/cDKCVvd//msIOoXWruq1Fk3TKuESNNIsCmzHMTuf/HoiL
   S6Nz9N6l0aG00Tb7IHXxVQi253Uk2hLiZwmj4tfDNLvJQ0sbfYMxeVhxm
   xLanl0bGBhISJKINWQhmyjteXsR4gpCe9s6NuD1JEC97nfkRJ6dMpbHnj
   AvaAZiRVTJSkdmi1ZwD5lylMGhSoU+Vtsb8ldaL0C5TRfuC/ZL/dzew7P
   HQhkGDWes0rBJ5bmB0MfVOCmwf9wOaDDX/kyN49OcDqajewB34Mvad6j2
   g==;
X-CSE-ConnectionGUID: q80JWY67RdmTI3pXYKTJDA==
X-CSE-MsgGUID: tGfX9k13Tt+aHwxISEsQwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13405199"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="13405199"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 02:24:11 -0700
X-CSE-ConnectionGUID: CrXtU4zmQBKVVPrpFap+8Q==
X-CSE-MsgGUID: NbMucWdURhSAiRNvaTL02A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="55611477"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 02:24:11 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 02:24:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 02:24:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 02:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd0E70jYzHJeUEvTb4XzIKhfS+aRT0dAJukNur6pgMB2iZLGjs9nj5q/RwBVt5zbXIEyaJsiPNRWXKcCzMyPS7xF3PZTafSznJF9CknH950AvndBmGo+5ghJDcbZitrMKAnsCFeb+1hdmtCyRWLzU4ddzRsmKtStrh8PrHL6KbKNJXuBQtv28ZbukS74joDtk2F4PRaevy5KxVB4V9M9hr6qp2C5++YQYKxCr7qZgK0pg1qFpKRMsIuOvW3Vktunt39C1jLBfvguk7EecSyqzsox1lo02527/T+Jwsp4p2A8AujHKcHKusfHGITRs1BHlcRWLwgT+dZFQHJqXGG7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UumoBSbTrWcfearnm0x8BP5A+4gd3twh6pTbFCmMpaU=;
 b=SC/3A95SOiquvMm+QQnCIkheQM888MjWuA5qgQFIFZHnQiOv9UlpL1nH+w86XeYSarZO+9m0y1K7eiDYy2KbeMeczFeg7S+UB+CuJ7+XAnhYkwLFNAvmIAVZ7mPfSpLlp8WGFzpNtjqgZaDtrHYp5OFdJa+03W9sd2KxL0ufYkCJU2jv5VGrbuw3t7NOjb7th2E6rmWNOPFRUlKoZfDF3YUIirEtstCaWr/9+gZ+C7Cig+j4hr9Dmv6L2IL5K3dTDLnbpHYnPPMyM2RjwLKKbR4JGO53pu5iN1upuPScF/zIdWISJ2SmnNZum7FuYvgbIHvFBD0mUdCFeeifVVaiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 09:24:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 09:24:08 +0000
Message-ID: <fc3c9135-ad5e-4f32-b852-c08cfb096492@intel.com>
Date: Wed, 24 Apr 2024 11:24:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] devlink: extend devlink_param *set pointer
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Jiri Pirko <jiri@nvidia.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
 <20240422203913.225151-2-anthony.l.nguyen@intel.com>
 <cdd3d9d7-1b21-4dc2-be21-ef137682b1ea@intel.com>
 <fa6e7d19-e18a-4146-983b-63642c2bf8c0@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <fa6e7d19-e18a-4146-983b-63642c2bf8c0@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab234b7-298c-4694-66a4-08dc64404b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXVuUUtsRnEwQ05iZG5XOEc3QnVOdjVpQktObEpvNnVNUjFjM2taVkF4MWd3?=
 =?utf-8?B?Z1p1RXRweHl3L2tqZlV0UU1SU2UrUTEzY2dlMUJvTGNKeVZJTVkrTWhkei8w?=
 =?utf-8?B?MG9aeHZCVTNKMUQ2bWkxTkR5SGFQUXcrMmVIZm8xbmdvdENjVE1OeTc0bmpM?=
 =?utf-8?B?QTBueXFwc1NFRDlDN0FwV3lFNWhjaXFuZHEzOFNJVU9GUytXdnQ5eUtxWXdW?=
 =?utf-8?B?VVdBMW5oNHozM0NodUx1ZjlsQ1pIaHM0ekF6M2lWWGRQZDFKRmFVckZDeVJP?=
 =?utf-8?B?V0lsYVUzN242a1pvV2EycTFDUnRGU0VRR1h2QU9nSVM0OFdwM004ZFBxa2Q2?=
 =?utf-8?B?UkczMkRMbnRFbGxrUU4rbEdkKzVCOGFZSXFTUEdlNWNrWHp6dXdaUzRMeWVl?=
 =?utf-8?B?UFBrREVDNkRaNDQ0Ym9OQUlsU1JPQ3llWWhhV2tCOUROOUFQOG9FSUVkN2Rm?=
 =?utf-8?B?cXg4K3h5WHdDWUhuVmpKTnVPNCs0cEtId0hTVnAweTV5akhUUXVSeFdNWFJi?=
 =?utf-8?B?UndZTFl1VjJJWmtSUW9pY1F0blpCS2FhbzZYdWV6bUx3VXlVdllUeStoRXda?=
 =?utf-8?B?R3JobWVTYVVkRDlOVWtoVTJaZVk0NlVQcEM5QzNMeEl4RDl4R28vaG44aXdI?=
 =?utf-8?B?RDBOVXA4SklEWnBnZEFmZU5jMEFmQlY0R2JuTzB4UkVFK0hHYjAybWNEaEo0?=
 =?utf-8?B?TGdla09xV1h6ZnozTXM2ZmJaQkgxMmVNTTJ0Rk4xUzNXZGxOMkdueEFSN2hV?=
 =?utf-8?B?TEcwVW91MTNXN3V2YXhUR3ErbzlQWUgwMUJiVEZLb1lUenQ5Q3I0RmJaZTBX?=
 =?utf-8?B?bisvNHlaMXlkTTI4eTZHbm5tN2gvL212QlNhZjNjSWdHak5BZ3pWN2Q4Q0Ru?=
 =?utf-8?B?aWxUNDVCTXdweWxPdG9HN0loQis0dW5PZ0lCSE5pYnJDc053OGNjUVRJNy8r?=
 =?utf-8?B?Q3UveE84bXZ2TW1ZVmdJQkJHVWRFdTA1c3RVUmRacDdUdmg1OFMwaVVNRWZu?=
 =?utf-8?B?Slk5a29sUk9CQzdTbVFBTjQ5N1E4dm1LUkdEZkRKaWFRMisyS2dJWlA4aENC?=
 =?utf-8?B?SXQrd1BTQ202VmtNVHdReG5xNmU1WC83UW5aYUdqQ0M1MjVHOEpQbUZjYmJx?=
 =?utf-8?B?RGE5eTl6enErbVVFVitVTTZzc0FTTWlHTnpBRldYY0E1ejVhdk5MSVErNmZu?=
 =?utf-8?B?NUlXWDJIdnlncHk3cXk1UU5lM2g1M1hwQVN6RHNDdFo3eVEwN0VNUWpZQk9l?=
 =?utf-8?B?UUdERHNCK0NrTGEzTHJHQTRicnBwanFXa2N4ekdybzZKZmRCOUNNaHVVWng3?=
 =?utf-8?B?a3JNZzV6V0llUnVlZTlKQ3YzeFlYZHFQZlJXb29kUUxGNmsyNkkycWY3aWlF?=
 =?utf-8?B?YXhKUERDU0tLc3MrcDRKM0psVXQ4NjFNbWZKdWFJcnZpNmR6cjBycEJTbDhn?=
 =?utf-8?B?d0dXTHZVSUZaZDNrcUp4cUtBS0ZPVDNlV1NxOVBSOUFNODN0TW1EYWYvRGF1?=
 =?utf-8?B?VFRpeEVYK0NMaWJTYlBFNlhmSlVIQXA2L1drS2RQS3VtRVE2TGpLQkdIeTB4?=
 =?utf-8?B?V2lHZkUxRkd4ZWtla091ZlRPS0FTY2pXTVl2b0RoOWdOV1VlTGpRbGU2K0dh?=
 =?utf-8?B?N0J4SWhjS09lT1BBOVRzY25iTFQrVzVPTUxlYzloeG5BdTNzK2I3aEUrWEVD?=
 =?utf-8?B?VlpDSGJpK3BPT0Y0MVNvV1FDeGpXOUFPdDJxWUxRc2UvR3RFZm5wYXRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FYT2Q4eHNPRWhGMng4dENhd1BEWllkUU5YUVpTYWlHelpMREh2VjAyREdw?=
 =?utf-8?B?SGdrNk9CVXE1Q2dGSDlWaTluRk4vK2U2T2hFd0JnUmhYKzZ0bGxIOHZSSzRC?=
 =?utf-8?B?SlFEUjhicDduaURVMW9IOURBUjFqbmJ5NlpiTU5BaEFwOWY4dEt1bFA1MFlJ?=
 =?utf-8?B?cnlyQjZoVzNyZC94c29TOVcwTFdYSm5JWnJXd1lzb010bXZGdXNIMGxVVDNW?=
 =?utf-8?B?c05JWDc5bytKSmJQeUJyTmdRZUE3NG91Ry9ITWR6RG9WYTZBdlRnMHJFKzBP?=
 =?utf-8?B?VkxNTThxKzVUS0k5TklFRFF2ZnN1RDNaL1kzZmJyOU9kQlNWSWhvZkxTM0hx?=
 =?utf-8?B?cXpzaFY5VkJkaUR6Z1doeGVIV1NQZExJQldZTXo3NElRMWFTaXNRbzMwcDdF?=
 =?utf-8?B?TFNzTHF6Y2YwNFhmd3E0MGhjb0g2Q245b2k0ZlUzUmE5SHdLZkhpNHJqK0wz?=
 =?utf-8?B?eFRtMStUQmpic0czakhUelFlZWhnUWZzVGN3eE13VkN4T3VmK1lBVDdIQmpT?=
 =?utf-8?B?MkZEamUxUmNUZUkvMmc3Nkc5a2dVcmMvNWkyeHFSc1pYaXpIU1owZkk1eTNt?=
 =?utf-8?B?Ulc3OWV1dktJcDVGdzFXTmRtRjRMejY2eURUV3lwbmlJZk94bk9WaGNZWlhr?=
 =?utf-8?B?TjlGOTlEUVh2N2gwcEJlTmcvTmoyay9iY3p3RUFtSWo5emVrS3ptekdLM2tW?=
 =?utf-8?B?Q3hqcmZjaHg4Lyt3dEszdllQd0FrYmRXTHBhaG9sOVdLL1hBOUVUQjNtSlNJ?=
 =?utf-8?B?Zndma1lTT3p1VmJqNFlXVW9nU2h4M0l0RzN0S1d0d3Z2cUhGTmtuSlZNdWIw?=
 =?utf-8?B?N1JTdVFpTWxlSzdSRENMNTBXRkpyd0RqU0txZmRVR3FScEtOU3FUTGZ6b3No?=
 =?utf-8?B?L0hrOHRYR0ViM3J1MDE1Vm45YXdiYVltQUJrSHpqcnpSakswM0FaSnkvM3U5?=
 =?utf-8?B?bjg2eXJ5T0JRUmNvejBaUXZqL0VPakF5QzdPazErNzVxYnNUR0V2eVY1bWg1?=
 =?utf-8?B?bkFjaVd5cGM2YjB6dXNwR2JVeDYxNTFndmZlNDlhaldjcVNLS1FmNnJqa1p6?=
 =?utf-8?B?VURiQmpWUW5HY2hVcjNCK0Jmc3BaNko3VTVwYmlkMStNZkxNNGdaNWQ3UWlC?=
 =?utf-8?B?STMvcVVBWmxFdkpUSTR1bXVMbFhFVHVlakJFdTRWcGZFSzc5MVJodTdsbHF3?=
 =?utf-8?B?alhtZXR2akNuRDdFNS9UMUNpY05PSmhMSFF3bnFQMEtKU1BXdjdCQmNTbVVX?=
 =?utf-8?B?WVdybEhwc0hSUUJycWNpMXhRS0lKb09KcXdlTklpTlEvMTJuTGhiTWdIUjBL?=
 =?utf-8?B?SzF6Qmg1ampxUnNZYXlYNXM2NWkwOXpGM2NZeFZBYWNxd1hxNzEvZEVQc1Bj?=
 =?utf-8?B?YWxUSGhTZkkzb2tiVk9PSXdhWDByd1dnd3N1QS9rN2FadHZpRDRydUwramph?=
 =?utf-8?B?VEFFdWZIdGlnbi9GU3M0RS9jZjgrK0lqSzI3RitoQThSVDZCTnZIb3J4VGY5?=
 =?utf-8?B?V0w2Zk1ZVDExeG81TFZnem1tM2VKeE1pRWxDc1JXMWx3VXJlVzdSMDJ1T1l4?=
 =?utf-8?B?cVArTW9WU0thNXhWODNDR20xK09jb21kNi9Fdm1iMlk0aG9INHdPdEN0S0Nr?=
 =?utf-8?B?NkcrTDRXQk9YSjJqVWNUWjVWeWxNdStibEwzVXNWZHNWQmZLOWlBYjFhV2Fm?=
 =?utf-8?B?VkFCK0VzUFdSdy9ZSTNMblZNKzVRUjFYeTNnWGZxYTE5VnVObG1MMXJpMDRI?=
 =?utf-8?B?bkxyRUx3RzRMcC9sRXR3SlNRMXR5RHhaWXlpNjkxYXJOU0pzKzgzUnRRdU9G?=
 =?utf-8?B?SHNQUERGS3h6WnhZUWVlMGU5SnhlcGlqb1dOTmgyS1JzV2lZZzFUSlFBaytt?=
 =?utf-8?B?SXdGKzdZSFdPalNLQ1hNQ1pkOTlDWDNVUzU1cWlKdlhzc0JOd05UQkhoTmRD?=
 =?utf-8?B?MTUySGY0RjJ6ekRrSlBUSnNBb2ViU1o2eWJGcjg4d01WSXh6SjUxTkVzdTBp?=
 =?utf-8?B?UnpuQThZdEZPRWVuSjA1REJrNmxzQVM0Zjlla0Zka3gzRFR5QkdvTUc4em9r?=
 =?utf-8?B?dFowVTA5cUxmUWc5aHFWOTREMTh4cHB4WHJHUnJrTjl2ampTZGc5cnZJWitM?=
 =?utf-8?B?eGhWenNQN2pVaTlidHpKQmZvUlY2RS9Zei9HUGt4QTVMazV5a2QvZnJobXBS?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab234b7-298c-4694-66a4-08dc64404b54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:24:08.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+Ut+25UZaloQrOELVYKXilyyVfmlGdo1oYvGZEq3LADW/4xpjIp4o7QU+/TGSXcPXXRl6+6OUbgay/xKNWtydyiPmg0z2bKjEPU7svQZH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Wed, 24 Apr 2024 11:20:49 +0200

> On 4/24/24 11:05, Alexander Lobakin wrote:
>> From: Tony Nguyen <anthony.l.nguyen@intel.com>
>> Date: Mon, 22 Apr 2024 13:39:06 -0700
>>
>>> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>>
>>> Extend devlink_param *set function pointer to take extack as a param.
>>> Sometimes it is needed to pass information to the end user from set
>>> function. It is more proper to use for that netlink instead of passing
>>> message to dmesg.
>>>
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>
>> [...]
>>
>>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>>> index d31769a116ce..35eb0f884386 100644
>>> --- a/include/net/devlink.h
>>> +++ b/include/net/devlink.h
>>> @@ -483,7 +483,8 @@ struct devlink_param {
>>>       int (*get)(struct devlink *devlink, u32 id,
>>>              struct devlink_param_gset_ctx *ctx);
>>>       int (*set)(struct devlink *devlink, u32 id,
>>> -           struct devlink_param_gset_ctx *ctx);
>>> +           struct devlink_param_gset_ctx *ctx,
>>> +           struct netlink_ext_ack *extack);
>>
>> Sorry for the late comment. Can't we embed extack to
>> devlink_param_gset_ctx instead? It would take much less lines.
> 
> But then we will want to remove the extack param from .validate() too:
> 
>>
>>>       int (*validate)(struct devlink *devlink, u32 id,
>>>               union devlink_param_value val,
>>>               struct netlink_ext_ack *extack);
> 
> right there.

We don't have &devlink_param_gset_ctx here, only the union.
Extending this union with the extack requires converting it to a struct
(which would have extack + this union), which is again a conversion of
all the drivers :z

> This would amount to roughly the same scope for changes, but would spare
> us yet another round when someone would like to extend .get(), so I like
> this idea.

Thanks,
Olek

