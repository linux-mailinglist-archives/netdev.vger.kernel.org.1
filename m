Return-Path: <netdev+bounces-282544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id N0zHBkGU8mnLsgEAu9opvQ
	(envelope-from <netdev+bounces-282544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:29:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F0349B5AD
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C8F3300E5F8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285E39DBE1;
	Wed, 29 Apr 2026 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8tC4l6A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673439D6F4
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777505340; cv=fail; b=oQ16dO4XqS7hcOq4kpWh37+j5gEF+/LhvPQ2+h5Sb8XrS35DRlI7cjSdqiayzpDSN5U18kyIkKkO5oz+DHcZrMKn2LPxTqo4NbRkz3+wwXxjYmsKA1fJq4vhwLlHbF7AirTdK0hRkpAGlpUp9DY8qZlNhGwvo5i0GniJbFmMz9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777505340; c=relaxed/simple;
	bh=yUiuyZvKDgpzMSB4ey1kQ3m2uWZzXo9DQRbsSPn8YbY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3Pz02/IB1NCifsZd1/MDspTXGvHWrilXXUJUHK2HWRpYprg33YMHm3oX1kCPZR4OG6Yxbmth8v8gty44E8FMiq5ZL58nVmX0tobAbQk5VorsKwwhlapWA5hUV/uBMBJun3A7UM8GOKstjCCjcxmzrZHHzyEOC144iFeeKDo20Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8tC4l6A; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777505337; x=1809041337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yUiuyZvKDgpzMSB4ey1kQ3m2uWZzXo9DQRbsSPn8YbY=;
  b=J8tC4l6ApOhELCeUz6sL46XHR4/u6sMjrWWWM9YRr6VRgKIZMAHpIriJ
   vUbWV/BWZ1roFjXAUYklCIji9EgQG3lRW/LR9yL4fIIJPuAqkO2JdHYDu
   xTt+rMUs7ChucE/QgZ9CFvp92LWhQUKDH629NhXF9y7SJ0m17OQZ9tZQU
   O710VJMSmJ/4WK7ckTYl3mujd+GpKMnqJbDKi9a2lEHmqynD2fjLnCwex
   u0y1KykYyTEd/wvnQSspjQU3OANGXYbhx0mpaZkZEkf9quhD6dFrRWqNk
   Cyzaq5PMv+aJmGJh3YdXE8BCVymx35TuDgUlUGa5y3izIce4A3nNM4/E1
   g==;
X-CSE-ConnectionGUID: OnHZQAbCTCupejKkVwYgCg==
X-CSE-MsgGUID: E4zozlSaTpG+wYczjcmYWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="77613080"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="77613080"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 16:28:56 -0700
X-CSE-ConnectionGUID: OshYksXnR4a8dqL0nR8acg==
X-CSE-MsgGUID: mohDcz2uScOv8LQNSiuGLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="231768823"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 16:28:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 16:28:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 16:28:56 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 16:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cgpma7458F1Xxd3hosszGVct/Ld6RFID9KIrhJNzkTEALzweGDLXSNWB1o8DCYBldJ+ddzKEwDzlfxO3L+LmYZJXZ2bA9Hriwqvid6/sOV5bgnzaLY38Pn8tquLVJjPyMSKlHaK4s2FDygHLFGo8OlledGWklR1nwKhB6gMwKlDTnP2nHY+QEzCI1nRNyLND6SgZ91DfDVxd63WTNK+NwgrxUT5TpoN6VxnRx4ImWOdzIRtDZa8hbAzcs1BvNTGgUsXUZSJ9N9Gjn8gphw4dxDf/NPzyzPwPf9BYhz6vU0vygWzxxsDWfORE5gqIUDLMj4SXbtLIzlo2douYpYsQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPj3/F6WP04Mc4d6MQPP3L080iV+14VKfmhD1d4c2dI=;
 b=gACEegLCMzLXL725DjxN2pr1WfDB58zaIdPZOMgx0yVlSL+uQ0QrqEyL+wDI7A486QNWCZoPkzMhokIKOMCAYM8YHyhukTNyi/dYlN/ggoQ6csSurB4DsbXgcxkX/q/ToAGliSwiXSvMu+oDZ1wvLvTPidKCUr9BxqRMz46GjfD3PLya9oMWXuFyAWdhdhJK5UVsuBozZpitYQUE8fbe1/vHd6APqzSpk2pBLNyGS93jEQyvnHUyWjU4+jxtqam7fA7qBakoqp3K+GWJInKeBRP8YGSbLRWwRxLOSzqZtUA6DxfJQ7R8WKyy7+RdNdAglONhxEwEUC2xmF4Z10xntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 DSWPR11MB9691.namprd11.prod.outlook.com (2603:10b6:8:355::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Wed, 29 Apr 2026 23:28:51 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 23:28:51 +0000
Message-ID: <3c1f1894-e969-4dc2-914f-9e15db35dab5@intel.com>
Date: Wed, 29 Apr 2026 16:28:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 11/11] ice: add dpll peer notification for paired SMA
 and U.FL pins
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, Petr Oros <poros@redhat.com>, Alexander Nowlin
	<alexander.nowlin@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
 <20260427-jk-iwl-net-petr-oros-fixes-v1-11-cdcb48303fd8@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260427-jk-iwl-net-petr-oros-fixes-v1-11-cdcb48303fd8@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::33) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|DSWPR11MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c23315-5065-427b-31fa-08dea6471245
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: Co/H3BUBMBoFpEsM/kJ34bEaQWlZxGfA01eAjVcPWs/t6O5cczBdLr7qCBYtywfAiDrMKavsqad4AkOId11sbFf95w1HGjMu3yv+c+c+Iy5icw5e7m93TQp7uibRDkjS1PZ5fP7PIEU8yz/wKSnJIJ5APltl+levTQC3GvKfZ8PiOsf5lfopzHcbFk96yrovfsffpdz75W0GnGLXLCqwI+plvWChR9uVsoJbNO86E/o6cWW7idAtE3yXobPxH6DOL3WNuN1nJsHiqcY7AF5oT3X1UsowxW5CYMUVLh9AEtR2jLvttMvpvkpOcTyXuCPy5YurUYLFjIl6kT2wggJei8GXPdPsK0D6yO+QHArEMDDBuDpjmE5ge+A1JEBEoQh3Lu60UulAurIKmyftXTyHY9h5kwlfWtTpMDWEidWW3AsWR+LKFD3COdg/Fh61j+Pq7umtDTTh0UD9RLDuvMvRlfkWYt7yjucXIw3FtxUoV3X/tVtCJfTGHj54NeoiOKHBNpuqIIMRec/uWaB2hvXjGnWd+5VoFcGYN8/kFQecWVHh7Y/uQMVJehUSdh37gkz3RX3TpOHnPTcJdIjV4ML5irNvrqCgtVp9lT+uIjlrENeVIYq2krVRTCwj3q5XaGzk740sjwsfP4KHPiH4K6w2b+LppD2qfUCALFpznKoUTsnqstzfU+P1vVIX/aMaJPKdMCb5dWKVXb9rNV4E5PQ17M4RpkXV5kNQhqCzKjzLE3PH9myeftkbYEQQvhHZn+CxurcMB6ePqbF8bM15ua6IdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJPcm5RcmJVSnlQODY1OVA4cG1LNlU3dG5ROTJVdmNKSk5Ra0w2SzRObmM3?=
 =?utf-8?B?ZHdhbUVhVHV4M3RRZGtkQkI5MWJKekdYbUtVSGlWNGx0QlRYd0pIZU14UVN3?=
 =?utf-8?B?VkF6M050RVFkRXN5SDI5WjJrNWl5NzRVN2laMFAvMEN3WEh3WFBjTDc0c1pM?=
 =?utf-8?B?cGFyNWJ4cUFWWS9VVjQrNFkra1RtVHVqZ0FkTDJOUkc1aEJhWThDcUJrdklh?=
 =?utf-8?B?T1VTUExBaDFiaUJOYURyNWk5UWx1Y2RQaytoSUFGTkNBdkd5Q0tvYkVreW03?=
 =?utf-8?B?a042Vjc3R1d6QWtnZUZoNnVMOENrYWlwMThsWTlWemJ4blhMdHN2ZDZ0bG9I?=
 =?utf-8?B?dGJHUlhkQk1PZWZrUHJkZEJ3OTRYM0pzdTM3ZEI5bTg0c0d1U0x4NHFSeFZt?=
 =?utf-8?B?T2ZwSXNHN2x4eU0xbVR6N1NPZ0txSVRLN3orcnh5NlRoZ084a1RTZkpabk1p?=
 =?utf-8?B?TTY5OGtIZ09kZGVNN0F0cjZIc1Ntd1NmcHhaK0pEUjVFSnNoR0pWOGFFakJQ?=
 =?utf-8?B?V0VLYy9YeEU5YmdVR3IvYzdCcnBkcVFHZ3NDb3JCUVkvUmN4YUw0SGJIN1pl?=
 =?utf-8?B?V2xNczl5Zm81eWVaMWZMdUhKVHRzR2VJUmhXT09GVjNUWEZGZ3V1NUVHQms0?=
 =?utf-8?B?N0M2R2xSc0MwN28zTGlndzFRa2prTE16MVdTOWg4QUJQWDZDRFZWK3pQZHNm?=
 =?utf-8?B?anpuUnlHZmg2ZXFBcGp3Tk9GWTdDRXNZcmhyM08vSUFJVkpOOEN1TGRJUVFP?=
 =?utf-8?B?Q0U3MXk5QWdXV2szMlF4UXJxOUM3NVZhZW8vZTdsclNFV2R3RElTT2FWNW9T?=
 =?utf-8?B?dTZPYnYwWTFYNU0xaDFDdzIzajd2Mjg1YldpWDdtSWx3QllEcldJWUlxcTgr?=
 =?utf-8?B?QlFkNmFqOHRrZ3AvM3hBL3V3Zk1ZZWxLSFFOZ2tTSUJQY2FDRlQzYmFNYjl3?=
 =?utf-8?B?SkNFS1FEUCt3akdsb0pXdFlmbDhGWENkMXBTVGU3dkJKWE1UN3M2blAyb3l1?=
 =?utf-8?B?SHJZeGk1a2FuMEc3aUtGR1hRNjQ2WG9RN1JqLzBKS0hoTTFCdlpSTmppQk40?=
 =?utf-8?B?UHdRTkkvenR3ZGErR3pkekEvTFdhaVFhYmYyZVBPWFIzK0l3ZHpEOWdnZ240?=
 =?utf-8?B?ZnJhOW1PZ2FKUDlJNEpxcnJWeWNRL3FKMW1vSndLMDFOUUQ4ZVdzYjEvMnhC?=
 =?utf-8?B?eTcvTzg5c2tjMHNXSjN4YnRGT3VOWHpJSWdpUzlhcC85T1M1eTZMM01BOXFJ?=
 =?utf-8?B?NHVmR2pGQWtBSjBtaGkvckFTa0MvVlArdjhtRUhSL1FadGJNMHZndGU0eEZo?=
 =?utf-8?B?cERPbWh5RGpyREpEMWtZU1ZjRVNVUFRZUXNKUVh0S2hqTG12R3Y3bHJJdlYv?=
 =?utf-8?B?VENBYlVXREdiMEVpS2F5bkdYalNIbDFWYjczRG5iK1Nndm9yT3NOT2hpZXRN?=
 =?utf-8?B?d0tKdDFYMU8rRTVCS1ZtVXpDTFdabTJ4K1lmMDNYaFBRaC9YLzZQMDVTc0Zl?=
 =?utf-8?B?ckVKa0k5T3QwdUZib3dFVzd3SG9weVpvR3FEMm8vRVFsemtiRDVlNys2MWdK?=
 =?utf-8?B?NjhERm4vOXloeUV3MmtmdXRRaG5Xam83YTMzcjVHZTFZRFpGZW9lRXhGNXNS?=
 =?utf-8?B?djNzQ1Z4UE5pN21HK2Z1VnlmdEdIWHE3YlpyVkhEUml2YkZTNHVRNnRCNm5V?=
 =?utf-8?B?RmJxN1dkb1B5L0ZqZ3NRaFpCRGRFRk93elgxTS9zVWR2eUhpZTdWMzB0SUE3?=
 =?utf-8?B?dnF5Tm1FbmdmcE1PTXl3VVFZdm1TaGwxTU0yVXZFZTdLSjFobWt1Qzdhb3BV?=
 =?utf-8?B?Q3duS0FkUnZzOTRSM0tIWFR5N1hIVFRPV2FkeGxBWDJCYndYNmV6SmJzcjFy?=
 =?utf-8?B?SWsyeXhhbmE2aFE1TlY3aUhRb2djRnZ6ZDRCbTI3VVc1NFMwM3VRZXNmOHNz?=
 =?utf-8?B?dVhYK2xySU10QlYzV2VUNXFHUEtOeC90ckVRODJ1SkVKMzJ0Y0k0YU0rU1Vq?=
 =?utf-8?B?QTBhRCtQTjZTdElVbUFKdVRJYjNhTVgwNDR6azdDd1Z4K3FFS3A3aHFHYkVQ?=
 =?utf-8?B?OHpsZ0tZZjgwTUIwZUd2Slk1N0ZzSWRYcWVzN3RFRmdFZnp2cndEWlIxOWtD?=
 =?utf-8?B?eG5uWXlxNmdVbzJQOGR5MVRjcVZZNi94R1Q5UzNHYm1uQjdlS2hJTjBYT2cz?=
 =?utf-8?B?NkNUdUJWY05XMldqcTFzdU82TklHVFJodkVDRDR4dzU2bU1ZSFVadWxmaTJS?=
 =?utf-8?B?UTZkemZaUHVFdis0MnZGMnNIbG9LU0U1aDlDVG53WXRJcDlqNC81YU5uTlFw?=
 =?utf-8?B?bFl3ZktmOEQ3TEJQaFd1SHBibGVrazFYZHd4cStFZzV2aUJzWDBQWXRhRDBq?=
 =?utf-8?Q?q1Hm7+9jxFV+Heu8=3D?=
X-Exchange-RoutingPolicyChecked: Gi/+8ixqxpxQ0mcZ6z+DeRSBshBwMFcZWu6ABCAY8J0RhNcnIvOhNhsHYkfugIrT9k64Z9bEmdpk4sQx6iz0UvSDl1/lstAwHhyAUY1iJRxpMmtIJ9TroC1rtbhbeSkkI7PrsBPaxgB0E7beWOUJaMlVyz4qxkRentuoxzISsxFOXnJaBA49bmb80evcJ5tp2smLz4rYF7DV5Gu0GFVt1DBJRz84MdPopkN1eTx2LukRv+h7fz8jEgHLGqNXQ+Y/5cCzz4HuKGIFWvRYUKreOy8MCP/oGKRTuFvdk7LsYAVyMCBMS2eSsnSk0GdIKx9Mfab2IXCINa64/ivBFT70uw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c23315-5065-427b-31fa-08dea6471245
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 23:28:51.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4uYSmxyfka1VHIyamF285AvFgYfcvieqKTA92FagaWx+OBGfg/Ww9bhvpRg2h2xhgAVkgBAqmtA9veO2i6eRO7Ka1JtUuNm2wymCZRssE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9691
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 53F0349B5AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282544-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/27/2026 10:22 PM, Jacob Keller wrote:
> From: Petr Oros <poros@redhat.com>
> 
> SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
> SMA2/U.FL2).  When one pin's state changes via a PCA9575 GPIO write,
> the paired pin's state also changes, but no notification is sent for
> the peer pin.  Userspace consumers monitoring the peer via dpll netlink
> subscribe never learn about the update.
> 
> Add ice_dpll_sw_pin_notify_peer() which sends a change notification for
> the paired SW pin.  Call it from ice_dpll_pin_sma_direction_set(),
> ice_dpll_sma_pin_state_set(), and ice_dpll_ufl_pin_state_set() after
> pf->dplls.lock is released.  Use __dpll_pin_change_ntf() because
> dpll_lock is still held by the dpll netlink layer (dpll_pin_pre_doit).
> 
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Sashiko.dev says the following:

> commit f5e294c42ef0c3cf4bca4497a268b68f562bce96
> Author: Petr Oros <poros@redhat.com>
> ice: add dpll peer notification for paired SMA and U.FL pins
> SMA and U.FL pins share physical signal paths in pairs. This patch adds
> ice_dpll_sw_pin_notify_peer() to send a change notification for the
> paired SW pin when its state changes.
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> [ ... ]
>> @@ -1344,6 +1370,8 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
>>  
>>  unlock:
>>  	mutex_unlock(&pf->dplls.lock);
>> +	if (!ret)
>> +		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
> Could the hardware routing state become permanently out of sync with the
> userspace view if an error occurs here?
> While this patch doesn't introduce the underlying behavior, if enabling or
> disabling the backing CGU pin via ice_dpll_pin_enable() or
> ice_dpll_pin_disable() fails earlier in this function, an error is returned
> without rolling back the successful SMA control register write in
> ice_write_sma_ctrl().
> Since ret is non-zero on this error path, the ice_dpll_sw_pin_notify_peer()
> call is skipped, and the DPLL netlink core suppresses the change notification
> for the original pin.
> Does this leave the hardware state irreversibly altered while userspace
> receives an error, assumes no change occurred, and receives no notifications?
> This same question applies to ice_dpll_sma_pin_state_set() below.
>>  
This reads to me like there is a possible issue in the existing code
which is separate from the issues this tries to address.

It looks like ice_dpll_pin_enable() can fail if the associated AdminQ
command fails. If we want to cleanly handle this, we likely need
unrolling logic which I think is an independent fix from anything in
this series.

I'm not sure what that unrolling logic would look like though. Maybe we
just need to undo the ice_write_sma_ctrl? But that also looks like an
AdminQ command we have to send.

I'm not sure how careful we need to be here in this flow.

Either way, to my eyes this looks like a pre-existing issue that may
need some attention but I don't feel like it should block these fixes.

Thanks,
Jake

