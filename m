Return-Path: <netdev+bounces-293787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDEcFOeTHWqmcQkAu9opvQ
	(envelope-from <netdev+bounces-293787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:15:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED00F620A02
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 838843002303
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A391F3B38B9;
	Mon,  1 Jun 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xcdogr6m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25B37CD48;
	Mon,  1 Jun 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323287; cv=fail; b=mJSlFOr+z8z6XKDIqzOWKngJIisMXremEQxg/+065wANNEFtl7HqLCtfJfNywzvnrS7WGE6kQPOA0irBONNr9+y+F6kfb5kjr19sDZQ9gPINNr0fLmLPf2iPneJ5Baa0HCa8GT/IYzpmoc/Id4zJmo40lOqcNe+aH92MuTVdQA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323287; c=relaxed/simple;
	bh=owsdwjeuOZps8f5VITtPBvo9msvGa+AAG88aQZpU3OI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ICIbSXWiAbBoVJGQ2T7PdIMpUADc8jkc+qQ5R/79vO5UiTaTx6WYrH11a2lV0jcD8EkzZr6sP9ZY8VjptWlGvEusnIhMH/dXzRZiS2iFbn3hPhPrD8V1LfNWE0q9nycAdsVGQ/r0+bzyphXdT81C2CZUKmUWCN2THqfDJeJQsAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xcdogr6m; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780323286; x=1811859286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=owsdwjeuOZps8f5VITtPBvo9msvGa+AAG88aQZpU3OI=;
  b=Xcdogr6mnSXdCLHxebjyPIZ/sj1A7k40sWrV4U9a2boOQiJ0s4o892V2
   3FjYGE03XoFgyiR4JCE2IRpl0CefEg8h1g8hFQA7xntWxHcskHA5YD3dI
   8M5T8fqsbb7I7WAmF4vlzT7fB1wPww8heM2bDgXkON4Oc/HtmewCXufzp
   JlXAPfh23srKivYi23bFc2ikii/8igmqTwrmNKgpUnsEW09DqkWGfSRvi
   2lsY0qoG/rBDBIWYM0JrjqCWD6tEYIGw4YwRPI6SfqRpWK/CzDtg5Yw9s
   wSErqWbp3MVRDPTIExGLTjTEhEVqxyTG+4nkHLl9+mGixcMIpCcjirb3V
   Q==;
X-CSE-ConnectionGUID: +MU4g7QGRiKTCghFpO51xw==
X-CSE-MsgGUID: dG5AUAAhQeChk1E9IVb/yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81266349"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81266349"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 07:14:45 -0700
X-CSE-ConnectionGUID: BZfUDY5bRieCUvrwUkUyAA==
X-CSE-MsgGUID: Lv7HsXrVTdGHVXYlt9gTmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243688943"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 07:14:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 07:14:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 07:14:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 07:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRXswJV2aBvTyNQy3Ht9sbHUllJsTyyiFiLqYRz9vYwWuf9VHPubTVaxg1RcQQW5r5Dw3xfaEX4U90K66zqKOwAKVmBFHmk09rgO4RMO352Lm8JZtCYHiMhabXuBqdnhYFKgI00ZEG3IVLSdRW6dfUqwHvHEpw8gK8IrsneKE96Q8MwuS0mn2lKW0LQ6uCQOxIAt3LqvDb6XlVTlYL33B3ocl+iB8zblhO7ulhRUwtt61P4eKtNBIZvZ9W642KG5rtXVYoY8gpmXD1/CZgey1l5FEh8KrPp4rs1dd8Z1+pKHHAau0JbDCf6PVAii+VPC8L4In+3FsJ0srj12DbGkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H043X2wPR1zBoDm3gftXaqpCcSW40w0yAws2jAgmJQA=;
 b=c9mXqZxue3ekNR4DdVXysTU00XQRrrteL05s97lzCIcIfS8gvbIt+nhxgqbS+J+ZzgB5/oV4so4fArsKBaCeWElrH1qBfuledFwmSC0MuL4AsF3FnGRZf98vo3LmZgUJz4sC8k3iu9NLbqZF0HDylVmKlc3FIlJDH3yQMBLAKEtGrMflLiCbxSnHbLl7X/4nbQqlTD0fx5+3p9fQyrSSrjCVISChbEJ/ZKXQLQJG2YDQstJlm53zg5bdZQr16J7YeXAiGHd50jlV17+/kPJscYpm+Zv0jPKZ+Ro7uSd1ftbfIUsyaLLic8v08QTT9+1OYwhy65ZlzF0H52I4XXR+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 14:14:41 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 14:14:41 +0000
Message-ID: <0e5bea5c-57e2-4ec5-bbe4-5602c90756f6@intel.com>
Date: Mon, 1 Jun 2026 16:14:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: macb: check return value of clk_prepare_enable()
 in runtime resume
To: =?UTF-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
CC: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260601061906.127174-1-kaneko.dev@pm.me>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260601061906.127174-1-kaneko.dev@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0182.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffb39da-6f3e-478c-722e-08debfe81efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2BAPoEZApUc3T9r1PKLrRGtFBqn/YLyGXwtnmxNB2zboA7nQJJ2XHbN2jElKKc7j8qivWks7UUlOJGpKzL27FkyB3YQNiWtJXyrMxoFm6TICLHLxmdsmV4UEdizn6tKfhA1hFZAVPnmsh2Cr+9szyCOReIw9oDfk2IbOwhT20ykfZnAgKo3IQbURqi2blCmG7PCfMASr+3j3LpvnZl1BY8zipnskKL6wHGAo/2lbMM2Sd4qKLJkVnODhILNq59sJJeuDAmvoMP5Xvvma3T4BcICAmxwa4pnMGMBAqa0SyUUizLpH06eS9tBQylEs3Xo36iaFfhMT/kLkTlrRpEQH/XmGDcGHwzR/hFBUKFRtUVtxMoX+/ibyRPjH9tEswQrnbqUYwlFNdh4iicKQNT5S+UlimOaHh7SsPJMRhmG6qHmGDAADScgWJl+ipaWD6op/3jGrhERRWjG0s8uKjKHI5YmO2vSEtxZe56ZSBuVhkFaJokrC+QicovZVQNVj+4hP0AmbGoLhCm7OxnHlLEQWKI217cnmH37VeBTClCYzWn5xv6HhJYnbypvGv3nV5KHym+MfGGIJCEEhdTuG76+7x2++UvH0nP3K25R956jcptSV9gPuN7npOfzmvOGaXdfFNb0fCnA4sFzOLmF1Q6jeCYUStnGwOMYJ4p5lFuO/p9mcqGQPGoLUaem48sKXZen7YSbc5HiDvxQo4hIc+h0Eaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZC9DbjNRRnlRbUNJa2FtSnFkaGgrblFaZUNLSU9xbVdhZHE0ZmhvQ2haaHEz?=
 =?utf-8?B?RU1NZWJRcFBjT1lqN1FiMXl4L2dYa3RsdUZuaEI0RnlwV3daZHlOVmZqb0Yz?=
 =?utf-8?B?VmliYS9FQkpyM3BudG40ZkZ5ODFLcUh6V1pjQzRtRDREQnBPSkdjeTJVeDVi?=
 =?utf-8?B?SGpTc2VkLzBIYW85Tk5rN1RacDZuNnNkYXF0NEFFQ2R6ZnNDTUdDeTV3bzNt?=
 =?utf-8?B?UHgzSDdyWW9zZkRiNUxkb29LR2dXMWF0eEk3cFF4aHlLclJFcHNZRzIvMXJT?=
 =?utf-8?B?RU5vQVpqciszNmxuTzVmQ3dmVXBPNElmZWVFZStCbEVsaDBuZnlxakYxNjN4?=
 =?utf-8?B?QTJFWTlBS0gyMmpkdnBxWkI5UGx3M2NYb1VyT1U4cE9Ha3JLckJPWW9YQkgx?=
 =?utf-8?B?MVk3NWNZQ245dXJHSGhVR2JoQnByb2dSbjJpQW52TldibjdvUXVnbmZtK29r?=
 =?utf-8?B?cnhqSGRJblRkaEczK01GbkNHNXRNOUZJRXlIYndnME9SZytQKyswckY5dzY1?=
 =?utf-8?B?VU5McXRQQzRIeWVSeUttS2drbUhBcUZlVXU5cURlbXhrejdrU2VQRHhIb0tr?=
 =?utf-8?B?aWFNOGtTSkRxWWl1L0ZXQnNuVTViZ2k3aTVNYjRqY1pXblE4a051OW40dkox?=
 =?utf-8?B?aERXSmsyMURqNUlNS0lDN2xRMEM1SmozZW9JVWd5OS9EbDlFaUYxWWdvVFpv?=
 =?utf-8?B?MnB4R05RZVNxRTNKYzNNU3NWVThuYzhGOU9tU1kzRmVxelRLKzlDQUFiOVRu?=
 =?utf-8?B?K2xQbWZmWEJ4QmJmUTBGUkRMVEhJenp1d2pNVU00VldWRCtYaWFoSWtXbWtL?=
 =?utf-8?B?VnRoWkVxZ1JsZzFQdDFwZTZxQmJ6Rjd0ZmxXMEFaQ3Q3VFdqMExYeEp1MGRH?=
 =?utf-8?B?ZFVwanFvczMvbWhBTVBxNEVydHdBN3VjOVBUcTZqS0w3Z0Q4Y0QyTHRaaGVG?=
 =?utf-8?B?SXpOcnI4VGVqZWxjdFc5R2NkUVdqZ0Erc2tlSE4vc2dDblJmMVpEMmNXeEdi?=
 =?utf-8?B?dnNGVjhmYnpiTG5BR0U3OWdCRVI0dlA0YTlSb00wS1dkYkMvVDl6OWs4OXVV?=
 =?utf-8?B?bGtqUzk4MUhqZFBLdUdVRWRydnk3N1ZIQ0YvWVhvTHRqRWc5UERMemhiNXYw?=
 =?utf-8?B?SjZ1dHlYT2d2dmFtcFFTa0xyb2pPeWVqT2xWMDdicjlwTlEyT2JLS1phd2hh?=
 =?utf-8?B?ZU9wVWd2VzJHUk0wczV4VVRJK2l1MHhxMys2enVuWUZHYkNiWWU3a2hicnM4?=
 =?utf-8?B?WTlBdkZyUmp4UldUNyt1ZHl6TWI0blRlQlQ5cXBZemNKZFlxR1VGbVNsdlhj?=
 =?utf-8?B?Qkx6WDZCNFFkdU1jSGVocWt1MW8zRDFSQk1qOGx4ckxJdzhFOWZJM2hzcVRV?=
 =?utf-8?B?SDh1c3RVZjRMODhDbi9kYUZKSE1GUXFLa2hObXNVSkRsM2NBUnNxYmQ3eW5K?=
 =?utf-8?B?TTVzbjBEM3BkV3RWazFpUGZ3Q296dFFyeUw3c2NKek84TDJnSk13MkY5OFhG?=
 =?utf-8?B?eWw2d3dRSnkzWndKamZSUUFVd3RRclVaMW1lenVIcGxoWU5rZ05CcDBrR3BO?=
 =?utf-8?B?dHVZNzZURDJMWXVXcEFsekh4WE1DSmpsNnljZ0RuM3RBYWxTVE9iVmpkSko2?=
 =?utf-8?B?RUZZSFNCdkNKU2ZObllKU0lpTWVQOVN3OUlkOEZyVk1uRlFaS09vTElEVDY3?=
 =?utf-8?B?YTRZM3VnVms2eVNxRG9QYjIyM0VDQWc2VEZ3WGphdmdUUHkvQjJpUjNVUVR2?=
 =?utf-8?B?azRSbVZvbDU0TElWV1JHMGVjVXFCelo5ZFhlaHp4TGJYcWQ1RVBLOFk1TVpo?=
 =?utf-8?B?clpXa2dtUk9RVHR3RVpIN0xYVTFLYnZuNlFDRkFkVGNaRGFWUmNqcDNBUEZE?=
 =?utf-8?B?UFZkV1E5RkFJVnNxUFhwcCtYZ0M0TU1JTTQxNi9UR1dONFhNOWU4c0JwSEJI?=
 =?utf-8?B?aHVCRmNuUUo3aFNwWDIxanFhK3JEcEY1azlsaVVrSVFDVWdjczlsaXdKQmFD?=
 =?utf-8?B?RmhHMTRlYVJFMDVBMWZMRDZLVVBQby9rd01sTSsvVmh1SUIrSDhLYmRHS2Vv?=
 =?utf-8?B?aS9FaERtWkhsOUdmeEw3Q0tmM3h0bzVoM0Rzakp4UFNCMXUyWFRreFcrUHZZ?=
 =?utf-8?B?RVl5bytjc1Zrb3Q4eVJrdFNobUVBTU1zc2NjTzgrM3krZWlMUXk5SW1YaXRq?=
 =?utf-8?B?N0lod0pDVHdvZVZmTi84dU1YcXRlQmQvZi9tOTZlSVYvbGhxUm8yN1NlYnkr?=
 =?utf-8?B?NUhCbk9lV2NPbTFwcXVCQkxnYVdJaW9JYjgxRXl6UEMzYUhJNmdNZ3F3NFRo?=
 =?utf-8?B?d3Y5UlVyaTB6Uk40SXQ1TXpqMkdBQnorMW40SDFHVTBibzFxTXJNaW5QSXVJ?=
 =?utf-8?Q?ikRM29uMVbLqF/g0=3D?=
X-Exchange-RoutingPolicyChecked: acXJW05a1+bGrOX6qU0Bc8IL2dE+vb5RieAqcV6c/OLOYSFnsNwFqP/4lMBEd3IutBuYun5uU+E5gnBYBLsUPZYKVZonjs1Y78xeABylG1XDzDFP9o3n9yfDKaaNfbBBog1ZQ8Lt/6pNpp/4ivFeCd/Yj2C7wYV0RdHP/tKnlUaQ7xQdBSozNyw8xtr1kwqPRCIgogQ2Av6EeBNWuo2J1S3nFQfyPtC+vBHmI3YUiPgAVnVpmbo+30WRcSFdZJk2MLLewikB/V2GhHBDo125TVd++u5ucAHQdoMw2yPpXWNLXV2aIqZ79LSc07UlHp5X0KCiycKrQNghJPcD6jNEkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffb39da-6f3e-478c-722e-08debfe81efe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:14:40.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+WvtLDjWbI/HKTzWFr824Olsmz4A1T6EFNF660jz+5wTBo4/mezm0r6yX9jnCqu/mpd1iMgoIGj4c2lJoEpQ3y9YmoIMUhWYYio/SIVssc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293787-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ED00F620A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gustavo Kenji Mendonça Kaneko <kaneko.dev@pm.me>
Date: Mon, 01 Jun 2026 06:19:22 +0000

> macb_runtime_resume() calls clk_prepare_enable() five times but discards
> the return value each time. clk_prepare_enable() is marked __must_check,
> and if a clock fails to enable the driver would silently continue with
> potentially unclocked hardware.
> 
> The symmetric disable path, macb_clks_disable(), already uses
> clk_bulk_disable_unprepare(). Convert the enable path to the matching
> clk_bulk_prepare_enable(), which enables the clocks as a group and, on
> failure, unwinds the ones it already enabled before returning the error.
> 
> This was found by code review, not by an observed failure, and I do not
> have macb hardware to test on; it is a robustness fix that propagates the
> clk_prepare_enable() error instead of discarding it.
> 
> Signed-off-by: Gustavo Kenji Mendonça Kaneko <kaneko.dev@pm.me>
> ---
> v2:
>  - Reword the commit message: drop the misleading "atomically" wording
>    (there is no locking involved) and describe this as a robustness fix
>    found by code review rather than a fix for an observed bug.
>  - Cc the networking maintainers that were missing from v1.
> 
>  drivers/net/ethernet/cadence/macb_main.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index a12aa21244e8..85bd4ff0e4e6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -6185,16 +6185,19 @@ static int __maybe_unused macb_runtime_resume(struct device *dev)
>  {
>  	struct net_device *netdev = dev_get_drvdata(dev);
>  	struct macb *bp = netdev_priv(netdev);
> +	struct clk_bulk_data clks[] = {
> +		{ .clk = bp->pclk },
> +		{ .clk = bp->hclk },
> +		{ .clk = bp->tx_clk },
> +		{ .clk = bp->rx_clk },
> +		{ .clk = bp->tsu_clk },
> +	};
>  
> -	if (!(device_may_wakeup(dev))) {
> -		clk_prepare_enable(bp->pclk);
> -		clk_prepare_enable(bp->hclk);
> -		clk_prepare_enable(bp->tx_clk);
> -		clk_prepare_enable(bp->rx_clk);
> -		clk_prepare_enable(bp->tsu_clk);
> -	} else if (!(bp->caps & MACB_CAPS_NEED_TSUCLK)) {
> -		clk_prepare_enable(bp->tsu_clk);
> -	}
> +	if (!(device_may_wakeup(dev)))

Oops, redundant parentheses.

> +		return clk_bulk_prepare_enable(ARRAY_SIZE(clks), clks);
> +
> +	if (!(bp->caps & MACB_CAPS_NEED_TSUCLK))
> +		return clk_prepare_enable(bp->tsu_clk);
>  
>  	return 0;
>  }

Apart from this:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

 


