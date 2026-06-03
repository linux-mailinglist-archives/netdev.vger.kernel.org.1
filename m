Return-Path: <netdev+bounces-294763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HvPFCD02IGqhygAAu9opvQ
	(envelope-from <netdev+bounces-294763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:12:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A4638710
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:12:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=X8RIOewm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294763-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294763-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F01573071CFD
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB183B3C10;
	Wed,  3 Jun 2026 14:06:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1E304BDE
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:06:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495576; cv=fail; b=Iga+yzh0kZq79pVhOCmyKFd7dxD3Vu+gOAiiNTqhh+FVd3bJy22HBZO/HhqDt9x1eou5pVqFk5RtzzxH1xxTK8QBvLFiE/rR64D8NEQrAE2DDp+vYTkvWcC6/KmHOap9FiKmXUnTvRvbCWUudqljaUAaZ8pVfi+Imyrz8xXBswA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495576; c=relaxed/simple;
	bh=RUVt9D5SPwlGbthhAAIVVJrhgeOoqfLpGeDRkBLVWEM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5W61EMx8cqrAZAhlzMVqr7WrjSub0fOqErdClWjSpZ8GkVi3NMLBc1wZ9rRf/J0shtAkk30OMr1roBhC7/si3F06F3wUugMjjJWAIpHFQlYBeM8U9MWXWDPlItg0VPWUudIIGBEQP2K9JhRLJ/9QNT5X7mLgZheNqX5Wt/LzGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8RIOewm; arc=fail smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780495575; x=1812031575;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RUVt9D5SPwlGbthhAAIVVJrhgeOoqfLpGeDRkBLVWEM=;
  b=X8RIOewmtNwVfUlzb3bmiGAH3qf59KvpQN/P6fbpd/R2nlsjyUI3J3UZ
   KYU1PsGBO4Q1Lib2rkqBf8KqJpDHreNZMCvcaw9TZcuPnnpjX+664nN7B
   Su9+Ash6b6S/ZK3J6SxR5hOhu4s6D/ojFmmvhA3D0KZbaOMQKIJ449esi
   LP+J+KPyVHh00du+qhVBEI7PoLa5HKAl91FckKc8zt23ERYwYzKyP1avj
   FpkEHuRU6ZGIv+SOZZTLFYQDjxfhNzuGswBNI9UFC+peiGgwrl0NhQk+Q
   mLvMsyCmNCJqwL5UvHnJ5b781CNK3a7udWq0kMlHbFqbhqApRsh6e6ko/
   A==;
X-CSE-ConnectionGUID: KJPQO5paTLC5RKxGmxiWCA==
X-CSE-MsgGUID: BvSLuyyyRGOBom+AfXfvvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92413693"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="92413693"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:06:14 -0700
X-CSE-ConnectionGUID: mzWWCzpWTEm3cYdP5GXTLA==
X-CSE-MsgGUID: q0+JC7LNQ8WS1EJRyzjqvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="267910305"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:06:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:06:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:06:13 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:06:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNuwuyWNQUkiSMrxuvVxa8eTkXsn6LAzBUtsrOPkGBQsrhTbcZFgG3u81eklXWQmT/SSzzYSlomyqXhtTcG3ISsUCQi6p5ykcJUYTG2hbg9kuSjPO34wV7pr8mfsgUESH62ut/ADppAnb1UXfjMjYKSRFRS/GLrPSMAgpUSbndJGG8+9I0A26FpzZrQn3b1aFcmWTezDNHjgp3wZDlAfUeKD0XWZrlhnuWnR6Tdaa+yz8HTFvu2Q59I8kk7eFuIP/aABZ0nDV391nbN3xsMprAGW938Kbdw0/V5zXUNfmVjz2qI9ELtcbDVC/r7k2VkOaBw4IbXwK2+TesKPobRkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxcZ2v/n7CcAR//n1W1+QvaOVtZnqf7lBeIKE4lq+CE=;
 b=uzs+u4nSFdJHjsCs6fr4zKkrN/xz6zllQDn9SIca0YNfOk8PUDfUGypWrCUwSOGzr3Yd0Kyq36lkxlGmMZ5FnU5DePgr60NcR3+Loj6LRtnLgn25+sQLVTx9FsGkoAGxl7MdE5vWuKUYrQWWFwROpmYHZOTJxULZhp7KTtuvCD++Lb7ZVvZLOzbUJkwwC54MkftsLEtwAp/1KPAYtV4aRguF7U6xqk2bI1BLx4xKEdjF4dLAispEyHs5bLphGCaGvdcZyiNs2jAeOlmesl6QKxi/QMv4pcw7uMy7rwfO8jNDpMIHBGhxs3JZQUuxfqKPoUd05Gb9jICpIRJSunNrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW4PR11MB6787.namprd11.prod.outlook.com (2603:10b6:303:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:06:03 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:06:03 +0000
Message-ID: <3f32190f-760b-46fa-b705-3795d452bb04@intel.com>
Date: Wed, 3 Jun 2026 16:05:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: airoha: Report extack error to the user if
 airoha_tc_htb_modify_queue() fails
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
References: <20260603-airoha_tc_htb_modify_queue-err-message-v1-1-33ec3ab997d9@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260603-airoha_tc_htb_modify_queue-err-message-v1-1-33ec3ab997d9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::22) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW4PR11MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc9b83b-d6ce-471e-84a4-08dec1793f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2oPwyno8cZoiH1FWXL5H0QIVHHclWeNZ2uZg3yarNvg12RSHKpfvQrAuV6w2hd6uy0hUHTmnmM1tLIQ7bWgJN7YbQxCXir2xVcddeL3dsRiDiq+bw5oKQPP2vAFxMVne6gS6acDAowryFYL7YGZ2Ib+G8eRNiNXMgs5K206VANZmKAE6RpmoAcBOUJO8oCJidVtH2viaLvlzc0nAcK9n8cDdbrdPRE4/zzRB/A4j23fNHcvvLmmWmtPSQ9qJxWd+IJYc3YMQmWG7BZ4jb3H9Ab97EzuqaIxBfph0MW6VPXCk8nrSgiCDY/6Lm0lvy4G5uVmasCQlnLs7BK1Oz6C/KyxAKsw7xjeoj1iRqFoiYd4mSEsi01u5cPVkzjq0AL8ejqLi0V8affS1jHGQcBFvGZGI3hxpNyKWVgzDfYgEFT47WbSYCXH7o++deQdFRgpbe23/b6nTjYqV3VXDQwoaycVAgFQQ/gGjs8HSN6v7w/gVLbk3uuw6z1iAFNzibCDqWbZb0dEh/NLiq3/98+HgWeQIb0/UrwcVtzm4Gtg7hS8k7ViExh2MqXoXUg82GG9RjwAe/HQEakjP4QTYKnLqoPNuRHOC/1kOkA/5ypFXyG4QlT41s3hCwkQIUdc476nIeNmNYi3uzMwmo6kWsa4d4077zMZEugzZSvflzncQMSqtY8OccbKyBqeRMpqMLhj6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QURBMTZSNXZEdytQUVN6ODNrd1Z1NnNuN1dPczRJQ0h5L2hDVWh2aHVEeU9u?=
 =?utf-8?B?Ty84clA5Mk5mOElobmpFNnpsRmJKTUh6cVdNbzRrRU9SY3k5SkZCc1J3aUF4?=
 =?utf-8?B?OXdoUjdXU2xibFVVNy9TbmZCRjRLN2ZEYzFGK3dhNmJzWEQ1Vmd2dTl3VG42?=
 =?utf-8?B?cDFKRjJFS2I1eGRDMnQvV25FZ2FnVEI4RzBiNHc0NUJzTnJlKzU3dWRYUHp5?=
 =?utf-8?B?YVQzSXROZU9EbkhtOUVwOHVEa1BROGVpOWZrMVI1ZkJaWnRUVHRwS211MEhp?=
 =?utf-8?B?RE1Sc01KSXFmemwyL05qTnFLSXJEVDN3SkZBcGlwM05jSW1OMTZZKzJ0K3dq?=
 =?utf-8?B?Z1VwQWx4RVhteDNZYWdiSG1NNGFCR0tnSVRuMm85cWVYaitST3QyZDZtN05j?=
 =?utf-8?B?YWhQcUJZbFRuUVpEK1FLYlhYNTRkTmNjY1crOG9WU1dlYzBYaGE0MmdLUHNU?=
 =?utf-8?B?d0lONUU2WXF6NVZadExMU2ltRDNZVTYveEN2NEJYaW1HYWwyWjJsOGdTZFVw?=
 =?utf-8?B?U09nRDFVcjZzazh4anNEY3lVUHN5ZnJXbHpCZ1hSQ1JsZ3ROd25VWVZJbjJQ?=
 =?utf-8?B?SjBCWjRsOCtibGZ3bTBFMnc5M2NkYWJPRnVJSU93aU5mMDczQWI2aU5CbUxU?=
 =?utf-8?B?dURWM3F2UnJ5Nmk1K25LWWZ0QWxnbXlWUEdwR2FEMUcrNUpRazRyb3NQRzdH?=
 =?utf-8?B?RmRlRnhBN3lSQis4bTBJYjFtSWVIdmpNSngrTDBRVmw3THNJRnNHRVdiWmpV?=
 =?utf-8?B?K2NQQ0liMHNYZ0YwWmlGUVc5ZHZhMnFNSi9DNHFzMlN2NGh4U3gzM3I3YVFL?=
 =?utf-8?B?RVRObnVKZ0ZYV0NFNkVobVh6VGFNVVkveEFRRlZ5S0dKclJESGd0bEdMZTZB?=
 =?utf-8?B?c29EU3h2TjZsNU0wNmtRVE5IR3U3UHhLWUgyYXVaS0s5YkZVNVBpN3BlWkRz?=
 =?utf-8?B?YUZZNjE5UjdEWVZUOFZxblBDcGFVTFhmRFIyZ1RzeHI0L1RCd3FybFphWmQr?=
 =?utf-8?B?N2kvR2xiVStrZEtsUDZtZWQybFhhOW5xNzRLdmlQUVhoRXg3S2RJZFViRURH?=
 =?utf-8?B?SHcrZUhobzhPanhmQlo4bDRqMUY0MnpLaU1DTkpKYjZ0Z0RkMmdmb2QycFNp?=
 =?utf-8?B?L1NQbVdweTF2QzJGZEUxc1B2WEMzdVZHY3lrNTVjN0dtMUJNbE15NXBGUlF2?=
 =?utf-8?B?TTNubnZHZjFDVS9KSGdNbGN2eEtpYlZsZ3JEYlRKeHlEdzQvcC96NUdDUlFU?=
 =?utf-8?B?QWp2bFMvZG5XNlFFTVZyNFZya3prOWFnQVgrckkxTTNrNERLNVJ1QzVqUFN6?=
 =?utf-8?B?a0swWGxTb0Fmc0FzM0lvUHVGUnFpSERidU0yQTV6amdmVnU2SStWZ2IvUUpY?=
 =?utf-8?B?Y0RLK0dHTHFBTkJXYXBtWXoxdUV2TG9KeHA4UDFmcHhKOUNLb3o1bEhWbkxC?=
 =?utf-8?B?L09HWmtZbjBPQkk3RTJZZXRldHhMbTFOTmszTWtwNEpHMWdPYUkzQmlNSXZK?=
 =?utf-8?B?WE5LTE1yN2paczJxV1FoYUg2Zm5JZjdHM21XRnlLbytPbWw3dGxpaTB1Zmly?=
 =?utf-8?B?UjFndjVHTTFVekxubnBMUDNlR3llTE45VG1NdFRxUUFUK0RqeVorakVnaXpE?=
 =?utf-8?B?UzlkanptcGZSOW8rcDhlZ2p6S2szTEgxc1E1OTZWdVBycnVFTlZuQXdCTXVN?=
 =?utf-8?B?cVhRRThsdTBGaUQydCtnR0VCdlUwbkxvelRva1M4V2dTaHp2T0FWS0hhOUF2?=
 =?utf-8?B?a09peUxuekxya3RMa2xBU2R0NVRwUE5XbzdGTWtkSXhycmlmaW0vZ2Zkcm1Q?=
 =?utf-8?B?Q0lYZDBwUXB3WVY1UEJ1cW82U2JkK01oTEIxQm1GOGNNSW5kL1h5Z2dLNmJW?=
 =?utf-8?B?ZlpLVDRHYWRhQzlpaGFvOWFNTEkwMzhTR1B5V1p6UzdVMGltL1dtUyt0S3BI?=
 =?utf-8?B?aEtTekFQZWhENGNRQWFET0tiS1owejNTU2RtUDJzdVo1eXBlU0o5bFFZcS9Z?=
 =?utf-8?B?MEpqbGFqWTJXTDQ2YkdGS2FWSDNvWmhkcXhEeEpFckYrSzRYWE1vbzFkdEpm?=
 =?utf-8?B?RVBHSlZsc1BPYlBLNklPdEZTcXp3RmUxandtZVF1SVBrKzlqVzU5aFpXTEFM?=
 =?utf-8?B?UnlXai9KL01rTklxZERWSTNuZjVOREJvUE50dWZxbmdWalpSOG9KUXVDalRk?=
 =?utf-8?B?cnR1b0diS2VDbTFGV2RlNHh2dWl3Vlh0YTJFcGRBb2IzRURmL0wxb3FOQkhl?=
 =?utf-8?B?Y21acFI1RFVzbjZMZDlvVkRHRTZqTzFBRm9KYjQ1U3l3ZFpKSitzQ2F5NW9P?=
 =?utf-8?B?cWpFbjhUeFVHYlFIUE8xdlU2dlgyaExXaHptd1MrRGw5Tm13YUF3cjhyTmpX?=
 =?utf-8?Q?zAGkIoKT0TEpWCFs=3D?=
X-Exchange-RoutingPolicyChecked: cFJRwFjw+79h/uUsChxjXfkL48+NJv2V6l71bl1CHhst5WeghYbIrbf4DBDQRSpmHLUYrdhJjUlFhtHDFhbriDWMBdp4CylI3eLUaXOFCgbjk0efGNkSNvqEZQnksgt22GvgFsO14P0h3y719p9yYtZy65ABe270LHFZuNqlIY5h8VJ0gBuG7kqpvNclswzrecQ2pp846xgFuLJMb991fDAtFd52umRoNIbcpascFMLdzsRBtSyi5MoQRQaNvRINerFxinyLra76GTZ+8jwFUzhw/DKPVJxoNulUAFCqZtM3VXmyWH7aknUPbgRinJV/Mkfpipxz9jJ9lN+KkOCMbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc9b83b-d6ce-471e-84a4-08dec1793f59
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:06:03.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +joQX4XdBcIXSxklsqb5mLcUyBuZ93LBq3hZNdAg5MZZ2mPdm/NXNI4UckBEiceTqftcC5D4BTC6zcbEvQ10wVG3JNZYWHaoNOY8W2D70lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6787
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294763-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B61A4638710

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 03 Jun 2026 12:30:01 +0200

> Report an extack error message in airoha_tc_htb_modify_queue routine if
> airoha_qdma_set_tx_rate_limit() fails.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 6574901ebd19..d0d13f01e50f 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2605,13 +2605,19 @@ static int airoha_tc_htb_modify_queue(struct net_device *dev,
>  {
>  	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
>  	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
> +	int err;
>  
>  	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
>  		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
>  		return -EINVAL;
>  	}
>  
> -	return airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
> +	err = airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
> +	if (err)
> +		NL_SET_ERR_MSG_MOD(opt->extack,
> +				   "failed configuring htb offload");
> +
> +	return err;
>  }
>  
>  static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
Thanks,
Olek

