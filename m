Return-Path: <netdev+bounces-139157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D829B0803
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FA61F23427
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3929A209F3D;
	Fri, 25 Oct 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABoxKO4P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B82E40B
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869577; cv=fail; b=ZDj54xZcIbWwAGhQk4fwg7ZQYPDgIAgbDQ99JupLJNgWvwqfEBky4oVC+iKvLAnjvIp+JDqIuOv8J9abfiAhS68jfb9a+WyCwL81iEp4cOWC9NYOWQS0Lw8zZyqUAqFE3DkMkzDQxvzYgqjTpEcbyGsJtbcjYLZXgaec2BEml/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869577; c=relaxed/simple;
	bh=TRNUGv19Ugo/e2Czuf8jvKAJOBnuOU6X8mTteuxI9fY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EbtLdIDW2TBiNvFUaFY0IofFqiyIPzkHchGgaDxuBKDA1xH2cxD8YgCrhofswNyRFTyg+PQ0kSwe1KjkH3GEUpFMHar6miuRTfZAocxIt1HbgQbQvCSGCh6hIEZBLIrvUKuRCV17HpdW9AdffBLNxq0KdnEEWd3+akFTJntVJFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABoxKO4P; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729869575; x=1761405575;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TRNUGv19Ugo/e2Czuf8jvKAJOBnuOU6X8mTteuxI9fY=;
  b=ABoxKO4P0eat0CtvcXKP0HCFMYBVtnE9zJR3dLAOSKnxSzwq4/PoDrlg
   6Gf4SpKEBG7SiS/mUSDGBVhl0iY+zolv4SKLGCHe9ApOxK55DyZJ5uutN
   jqYZ+loLXS55rjF1GjdXPlSWbFtiAmGCr5Xtc2GpWMedJEPG3FewfTWI7
   a0s0fdYP1sWQHA3lH8++EM9VZ6Izmd/Z2XCPSV8+mp6I1bRuA7ggN12qG
   Jf/o15TX0RlQwrFSP8jHCiALlfYbadggMgiumxOGUvztMtSOB3Xkisvv3
   Di3BRkzmOo/bSXs/McDlQRgwjuw+9vXFY04VTDi9zvUTw3/bwVrF/dFd7
   w==;
X-CSE-ConnectionGUID: d7/LEwMDRjOt7UrxJJfhcA==
X-CSE-MsgGUID: t7vJ1qDWQ62aacSIHtw8dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40156939"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="40156939"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:19:33 -0700
X-CSE-ConnectionGUID: ZKRglhVsStK/2WbeKXvhxg==
X-CSE-MsgGUID: E+I0E/d7Rj+Ysx6E2eLwSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81049070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 08:19:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 08:19:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 08:19:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 08:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu2t/r3r/XW9uR03U8dG5BfoGE4RTdeY50Hg3cWxmybmflOGeTkClfMiBjWDB5A9M6FGtiuMR5XgvRDCzlJuWnM9uPhxf9LOE1gIGZ8CzsQb121tMn1vDQvDaWkTCQprYymm3Jp4qz80RXbX6Asy1duoB6nyjOGeu+t425lArpUGUVV6vJPVEHkP5Jq6w4AnMvPaKM6fy8EfTX0VhR643qNvtfYCr2g6CMyVmN08qHRr1TYwqqP4n1mRaNeW1ITexL9kBv9Zn2Pko2onIGy9MaDonAKj8Q9nvEZJPPlViisp8ErehRkM/BDNBgeXCf5kje81SEVZn8UPkuiheihxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DEyUhguvXyOiufOOoByJYH20cfVC9tVHV416hamA/Y=;
 b=PcWtRBfusR0WUuBQHYb0ZJauZa/0G6XTBawve6B0FsELNz6ShL3WIjDRXaCX9+E8x4UAijpBkjen6cW0ZhQmh/0p9TLDhO7xEzzvJhSRFXv47wye1Edc3UDVjEh8zwzdjlPd1oTLrXQUyV8Fv4GEPwLCBTCZLvhF5h5Avx0X84i9JqQbJTAJZuyfqr7vXJROoBTxn5aYUmfOwrgRXDjIf6hT9mvDDn+btWfFxYzPEzhbzZMqr5cNWXKCIFbWg1TDDsDKtw3dMwSXpOtPwCSfhE1tafEC1wQ2ps///iGw08PXRGvA7hJjqaQ6OBhy/GE9rtQ3bIh1RJ1bVCQbLrXT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 15:19:27 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:19:26 +0000
Message-ID: <5a640b00-2ab2-472f-b713-1bb97ceac6ca@intel.com>
Date: Fri, 25 Oct 2024 17:19:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
To: Mohsin Bashir <mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <alexanderduyck@fb.com>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <kernel-team@meta.com>,
	<sanmanpradhan@meta.com>, <sdf@fomichev.me>, <vadim.fedorenko@linux.dev>
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241024223135.310733-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0023.eurprd03.prod.outlook.com
 (2603:10a6:10:be::36) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 52db5852-69cf-4434-184d-08dcf50869f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHBNNURscmxhamhYZWR5VGpjekxXcGNPRFhOQjdhckFkNTdKQWFldkRjekdW?=
 =?utf-8?B?WXFQaTduTFhXQkIwZjlsaGp5eDlWcDdmMXFxMEprTG5iUUh6UU52Qmo5L3Fs?=
 =?utf-8?B?VEpFbnZ4d3h0bTJqSk12R1BoUzdtN2RLbkFZZTdpZm1nMGVlQVJZQ1NrQ1JE?=
 =?utf-8?B?MDhIQ3NLMllYZitjK2NKSFNVRXhhQjlpY2lzRUpvUEdGZE8zeXdZdnN0TlBE?=
 =?utf-8?B?cnRrVUYwbzVhalJSV2dVbGtLeDNIamhGODNlbE42VFNrRURRV25xNHN2UW1Y?=
 =?utf-8?B?czRkSmtDZk1tdnphblNvUEhkVDlBbUY5SFVpYm9oSjFoVk11U2RRM3ZUQ2Nn?=
 =?utf-8?B?VzhHWTd1ZnRRY2UvYlFidnFXTGtPVVVPNUZPaGtWY1dBeThuOWdWKzVzVGVX?=
 =?utf-8?B?R2RyVmZtTWNxSENqOFdEQnR6MTlaK1FyZHcwNVdxZGxuVjRmWGhUQXVzdkRh?=
 =?utf-8?B?eVdqNThXMW9jMFpwNCtnYWMrRjN6dXZHN3JxM3hZbm9YbWQ2ZVYyMXZUQW1l?=
 =?utf-8?B?V1AwN1ZoeEhMVDdLeXI5TDY1MVcxZGVuSld1dXllR0lHVWs2K2xkUk1PR3dS?=
 =?utf-8?B?K0szZkFzUlRXSG9CQjJwLy81d0lnU1NjUm1sK2g3QXpzWnN3WUtHME5SSnhx?=
 =?utf-8?B?dlhpemdMQ2NPVDRENENmMXBpUjVPVUJRbVJ6Wk9rQzdOWVIvYjJFRUdRTUxL?=
 =?utf-8?B?dkUrSVdzTEMxMWo0VndWTkxMejZ3eVM3ZWs4Z1pRV3hjdWxiRHBMZ3E1YnBZ?=
 =?utf-8?B?bzRlYm9tQmxuYWx4dU1OZXhSRnJCTnVVbG9OMnQwRzcvK0ZZWGF1VjZ6ZHI4?=
 =?utf-8?B?VmlBMitCdTF3SWlTbG1DVHJrVk1GTWNLYTE4aGVUYjJMYUo5NTU0aXlncXBI?=
 =?utf-8?B?d01LSFVSQlpybWdLRmR2REY3OHNUVnFVSXZJZjdXNURtSTh4TW1HNXFWeS9O?=
 =?utf-8?B?NGF6Z0lCRzM4bU5uc3d3aEUrVE84Mnk1SjNLUlVkdFVCLzlmZUVPWjdkVkor?=
 =?utf-8?B?cjBBQnBsdk1Wd0VPNGtPSzNHRjlOSFVZNkswUms4b1RzelFMN05Ia0ZSczJQ?=
 =?utf-8?B?NHA5amdKanNYWGNnZk9zSXNzWkFCS0hidXZmcElpWHpiWGMvdHhnQ01xaGNw?=
 =?utf-8?B?MjFLd09UUmZ3LzhUcTZERGRSZWxhMmVsK1Fyd0dXaVNXMjVjYVRjUjBJTGtz?=
 =?utf-8?B?ZzB0YWgxaWFUNERmbkxUZmY4T3RrRHhwOWcyU2diWVNpK1VNY2VQMU5SWTVS?=
 =?utf-8?B?bERSMC90UU14UjE3YXhUUWw5VVM2cWJvY01jMlBJczVkdmM4YTZzbHRueGtp?=
 =?utf-8?B?UkI2TkszUGJDeUxVSFFXcEFvWjQybmJXcFVNQnNrQTFHb3Y0S0lpcDE0Mi82?=
 =?utf-8?B?VlZFN1JKKytxTkdQM1NHK0RHTGpxbXpob0VsTXVRaEZFanhYWnRZMFByMTBZ?=
 =?utf-8?B?K3FyQlFad0luVDNoM0ZyRjVHdC95Ykw3YWF1NWxnc1ZaQXJFSXRlaFJoT0o4?=
 =?utf-8?B?aWcvQVNZQUIva1gvdDdLaGxSUmx5WllGMEloQWRzNVdrYXB5TGxTN1BJZ2l5?=
 =?utf-8?B?dnNiNXBmTld2UzZnTzc4YzF3cEtFQjFYZnI3c1RtMmJNdXMrOFdmTUhZL3VN?=
 =?utf-8?B?aytGSWR6NDlWZkFGZklYUkIyZVN4VTEzczRvbkN3TktlMTE2TlRKNU44cDBJ?=
 =?utf-8?B?Wk5TTFNlVXpmbDRWNGZmTzN4V1RvclRKaENvSVRhYndqb0FzVXQ5YlJ1eWdQ?=
 =?utf-8?Q?dBGInwAW2haUkn6MlmEXdFKV9UwDcTL7TSArUMK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BGUVN6OURyN1FMdTRKaWFFSkdZM0lJQzdiRFVhZnJRWGt1aUhxNUFWNXFt?=
 =?utf-8?B?bEF3a3BhdFZuK1NUR01JQWVuYmo0RkFvVnRRYWhOUWNBVW1LWHpwOWRuWW1F?=
 =?utf-8?B?WFd0QnlrbUlISEU0Njl5cUN5Ritoa0E5UUN3N3NlbzZsYkwvTGRjY24ydjE5?=
 =?utf-8?B?OXdjSjRlOTBOLzNWUmhVMDlFZnJxZFRIUTBHejY0eXBhOXZWdWZGcWgrU2Iv?=
 =?utf-8?B?bytHVWNWRW5yTFdVVTlGK2tBU1lPZUJZd3hKZ2taN1VnWTVUSnZBY21HSXhi?=
 =?utf-8?B?UkRuZjMwU1E0cGdTRlBtUXV3bGNZVTFmS0xmT3J2OU9iVEo0RCtseGdoY0pP?=
 =?utf-8?B?ZWw0ais1R0RCeDl2Wkc0WlI2c2w2dHZNbExyRGhtOENHaytBL043WmQ4NEkw?=
 =?utf-8?B?NGhvLzBMdnNXRjBoMStWdllxOWl6U1EvR2ZIeUt1bVBFUmc1OEhNd1NJdWFx?=
 =?utf-8?B?T1NRWE5Sb1JBODN3a0QvUE1BSjhnVzRUNmY3ckhFMkVXOSs2TW4xSzdaYUJt?=
 =?utf-8?B?L1NhS0xCckxuKzBJVEEzVis1Rm5mZW00N2gwK2ZWa0FSeXlqQU5uQ1l0STkv?=
 =?utf-8?B?alZVNVIyMmZ2OEJJa0VuU2ZNTk9FcE5PY1dNSkMrTWFQbU1ENXlMdDZWaldI?=
 =?utf-8?B?dVVaVFFTVFF6U1RPL3kzZkxCWnNZNkdxMTBJSDRieHhqcEYwMGk4eWxjZHhP?=
 =?utf-8?B?OUJNelhDTFY1MmNlaGU4dUxoUmJEcmRjeXNudnZZOHR3TC9NakZQNFhLTEJt?=
 =?utf-8?B?enlDZ292ZlB4dGthSVJISjAxd280Yk5Pcm92b0JHTzhkWS8wZ0c1ZGxBdGho?=
 =?utf-8?B?dUFzdmhOUEErUFIxMUEvRk5LRzJkRU1ON2VlSXhPTCttQk1PajdvYm80L0xU?=
 =?utf-8?B?bk5mRzJQYVFaOHU3TEgyOEJqQ3FxaXIxcTFObjkreENYNmZKR0lyUlFDV2ZU?=
 =?utf-8?B?OGtwa2lLSGdXbUczeEtaWGRUaExXbUYrR1FwWUFHMkF6MUttL2dUVm5VOFQ5?=
 =?utf-8?B?ZmhSUVNyU29IQlVnMGc1bTRJZ3QrV3N6MDlVM0hCeVZvY3JhQk1yRUQvZnk4?=
 =?utf-8?B?Nk1VaTFrOFNybDJXVXVFa2hDa0gyTkhSd2xNeWtDbExIK0hSakRkUWZrTEpO?=
 =?utf-8?B?bDdTcWQ1NHNKaHFwY2RlU0wvVmFTSkZlczJqRDF1a0I1YUVrNkVDdm1LVUQ3?=
 =?utf-8?B?WUxEVDh5SHY0S3R1ZEdaWXJHeEVmeXNiUGdzQS9UMHZmWUdhYm8xYW0vUGNl?=
 =?utf-8?B?RU04eXMyUzFQZG0raHVXRlZWa0pKUVpoY0Jqd1BMdFQyTVE4b2czalBTcGha?=
 =?utf-8?B?Wm5lNkxya3p0NWx3V0U0U2NDbGhsTHcvY3dtNW0rTEY3a0pBdzdVTi9sbWVl?=
 =?utf-8?B?ZDkwL2thRG1EbXpWWER5dnVrdHdyd1F6S1BUeEhsdXpMbERZUmpWb0w0YnRY?=
 =?utf-8?B?NXo5NjFuN0pqK2NCcmUvNDdZY1ZwaW9DUFRVR3p5KzdCTGlXY1I5KzZzL1pN?=
 =?utf-8?B?MEgraUpGZXdKUUpnR1hTNitMSlorUjJkaDlPQ29UbS9HbndIVWdQT1dHWFhC?=
 =?utf-8?B?VUVQemlSZFFQUE1SeTJrcUZxV29rdFJ3NDVDeVh4eUhObEs0OTVDMGxPSmN6?=
 =?utf-8?B?akRoRmx4SU8rRnAwblJ3UzMzeFZObTJ0UDM0OTJObG1aR3RtbGNQN0NncU9K?=
 =?utf-8?B?bzlhZ2F4RjIrUFlxVjQrSkZmTlYrZjE2YjlYZWdVRTRnNlN6dnljbGIzam1h?=
 =?utf-8?B?MFZNRDZ4SzZucXN2WFd4TUp2OE9OMDNMVHhZUUxVNW5WdHo3UHQvSGV5RWhJ?=
 =?utf-8?B?am16djJWZU1aaTFKdWY1Y21mbnVLaFpNa2tFK2REcGVhT2tNYlFnc3puWFpa?=
 =?utf-8?B?YkNMY3dYakJNMjM0ellBWTI4eDZPb1ZaejFRU3VEL0tRQnFXZnZBaDZlU1c0?=
 =?utf-8?B?STN6SnJFb1RyUkN1Mm1KM21Dek9CaXZaZk5PeSs0bkVPL3hzY2xQMmlvMWtT?=
 =?utf-8?B?eHl6TUFUV1JXNVNsVUtZMS9UOGZPbTVMLzZWOSs4NUZINXdFaGMyUVBaWmV1?=
 =?utf-8?B?WTArMFRxRTJQS2RJMHBITytoczFvYVRObDZ3RlJRemR4d2t6S2dYeW5TeTZW?=
 =?utf-8?B?RHZESCtsM3JZSnExQ2I4RFpoZmtLS3puNnVUL3ZRVm1NWkc2ajdaaDJ3ajJ3?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52db5852-69cf-4434-184d-08dcf50869f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:19:26.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6s/f0bRnkIE6hv5UcglndfLRzXBBb89ldLuRzYvKB2rDG6EgDGhAIPPQlfhweyX+J5+G1aOZ7Q/6L6IFH+lsOCuER1gC9nJ4tddGvAwkWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com

From: Mohsin Bashir <mohsin.bashr@gmail.com>
Date: Thu, 24 Oct 2024 15:31:35 -0700

> Add support for writing to the tce tcam to enable host to bmc traffic.
> Currently, we lack metadata to track where addresses have been written
> in the tcam, except for the last entry written. To address this issue,
> we start at the opposite end of the table in each pass, so that adding
> or deleting entries does not affect the availability of all entries,
> assuming there is no significant reordering of entries.
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

[...]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index 337b8b3aef2f..908c098cd59e 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> @@ -587,6 +587,116 @@ static void fbnic_clear_act_tcam(struct fbnic_dev *fbd, unsigned int idx)
>  		wr32(fbd, FBNIC_RPC_TCAM_ACT(idx, i), 0);
>  }
>  
> +static void fbnic_clear_tce_tcam_entry(struct fbnic_dev *fbd, unsigned int idx)
> +{
> +	int i;
> +
> +	/* Invalidate entry and clear addr state info */
> +	for (i = 0; i <= FBNIC_TCE_TCAM_WORD_LEN; i++)

Please declare loop iterators right in loop declarations, we're GNU11
for a couple years already.

	for (u32 i = 0; ...

(+ don't use signed when it can't be < 0)

(this all applies to all your code)

> +		wr32(fbd, FBNIC_TCE_RAM_TCAM(idx, i), 0);
> +}

Thanks,
Olek

