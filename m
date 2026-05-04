Return-Path: <netdev+bounces-284066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNnhJMYe+Wlw5wIAu9opvQ
	(envelope-from <netdev+bounces-284066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:33:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0E24C46A7
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 00:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE2F3011749
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875FC370D4A;
	Mon,  4 May 2026 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAY8IMVX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA93233F4;
	Mon,  4 May 2026 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934019; cv=fail; b=fkkP9M8DbU6Qg+B30U96DkRTuN2MZLiST93wAWzfw+PlAYEZvamrhSnH2Bc6VnvraMrb/R7cx27gr5qmKxuaFCMuNO/46HTOFlrY2keqapAse12wgQi9K1p+lvrS4jVkNKxUalzxZdshliubemBNJH7oL2PZBasJusjLZ0lH1dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934019; c=relaxed/simple;
	bh=sfWhgvl7UeSwvqPcYSbZCsD3QfAsGw9//ZPEsE39DWc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gdrth7uzpm7CtjmakCziI99IED44K0+6lZCkea2gWyBD31avM7d8b+anCQH1d3/3CuDpbvw+O83ll9PHxgO5hH6Rc+uWmDXSx2NJ6gvcOOj+YReYA/yg00C+MEZOvMAJnxjHNsRuzz3Gd4f+xPtdviy3bFWnPD/PESCV2YA3bmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAY8IMVX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777934018; x=1809470018;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sfWhgvl7UeSwvqPcYSbZCsD3QfAsGw9//ZPEsE39DWc=;
  b=jAY8IMVXsZdwBEX171yiub4G1/JAC/99a8CqQ1GZBFSPZXfczo04KNAE
   SuHkSwSaeMDQ3GOI7Qp6FifmvxB5AFqpu3vd6MV+cDmHgMRfeEGgrKtwG
   Oq1xYBNLdr0/ozCQZuAq7ch5SKmu0cgtKYe7+sbG9ZcSzr5Fgs2RDgLvj
   dwRLoUdrYa9R4A3uSUoh/+xT+RYcf+tM0D8HiRq/OxSqem43k6B3pFW6B
   GGeUBeFBUwKsbpKgw+/CvmWGoRedi3U/AZ8waN93gT2v3pbmMpdmm4gld
   cCKh6Hd5MCpEHXx0rKglPZFA6IbrezpUwXgQ6JESvU3SOwowx1EkIfrQY
   w==;
X-CSE-ConnectionGUID: JSMbFF6jTCKlZJ/eeqwoFg==
X-CSE-MsgGUID: GbPq6xX/TAmOIbpknJoNrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="66329488"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="66329488"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 15:33:37 -0700
X-CSE-ConnectionGUID: x0GIUhyVTm6KMZtptUaHNg==
X-CSE-MsgGUID: W1XLRnI7QwCtBaylVgTs+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="232499294"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 15:33:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 15:33:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 15:33:36 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 15:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxDsFXbylaodCfcEVSpr7x6gMArj87Jo+p8IKI+0EFjdjX1v2vlV0crJKuLicKposkz2sqxU2BTeBhu+plSPzslpQUl0NU9QAXMxJrG8CGNbA+k7zkKMgPG3Es7obfbp8l94csvC3hGp9XlDMdpQo92JBhnTecOlN2UvjHYoAHJxq6ViK+xkuD64qtLGTRQrH+2P1Ac2vMLRFkNVu8QhST4048eJkXHeTyjTEyclcqtzrdVC6QgFoYV88vNjv6NsYxn8fQ3ap1/VgvS8PnOJDsnANJAnrSRYPxqI5kdksK2jLjM6yMOwHdiOQgWgxhNu84neXyYhwFnukI2lqrxahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpHn3TrF8xSYaf7fmZBniQXiG8qjcy1AI79qdeRwyvo=;
 b=fh+b0aKsif8FUtlBQcEa+Mrk7j/3lewhuUdXLFmflfgPOR6NVKWXGUeyK+zUTAuG3ttWEGRnts/5A/nUiC2aWIMWN7YUnJjh4gJ07s2ENnAJA+fbGcjaw9MKmVyiUIdrbNQGGBU7jHYRK7o53ecZS/luKKzndHkKa8vC8oPszwzHVbuLA9jhJDibWDk1rbts4QL1keCWjRzu8cBIpsqVWyyXcmY2rAnB7YJ+zLlgQcpqriwcegQB1BsotIhG1teg0IwfMWdxBQDJlHeXzRyFevX7IxGkHu8BPFhlYxlDDoR/abD//QRhKmcbViFFqpqq5F7hueKq2stToepltDqnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 22:33:31 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9870.022; Mon, 4 May 2026
 22:33:29 +0000
Message-ID: <7505d7e3-4686-457e-a79e-776c634e9edb@intel.com>
Date: Mon, 4 May 2026 15:33:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/15] ixgbe: E610: add ACI dynamic debug
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<aleksander.lobakin@intel.com>, <horms@kernel.org>,
	<michal.swiatkowski@linux.intel.com>, <jedrzej.jagielski@intel.com>,
	<aleksandr.loktionov@intel.com>, <grzegorz.nitka@intel.com>,
	<ivecera@redhat.com>, <arkadiusz.kubalewski@intel.com>,
	<anthony.l.nguyen@intel.com>, <stefan.wegrzyn@intel.com>,
	<piotr.kwapulinski@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <pmenzel@molgen.mpg.de>,
	<sunithax.d.mekala@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-7-6f27ae1cd073@intel.com>
 <20260503020636.4114758-1-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260503020636.4114758-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:303:b4::28) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 441c8858-b167-4fc1-0916-08deaa2d2a4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +JjnHPFSGIl6Sk69aKDE3bjOX9Hv3E3mcab9VI/VYRncYowxVjWLnx+mx5+Fyo92n4wEADqrDZwBiV5AGTwUsJcwhpIyOUJXnOk8YchYovUbdzGpMpw1EQSGDWoCDzCxukQMUuDnb4soYw2/7qiP0Fm/+gsAaD661CCAAtt23/NY2KjA/QPxvvNWykadE3y39qmMTUo4TXmirInP7R6pXFLjez7600c/oRiIEEzGRZL+txGuTvVyusILAMm7oyVtRPNlBT5ovH+Mbg1GyYSxFAkyGTLtdIfiseMyaqEeWBV/1DOVxXbe1ZZ+ulkjreDQAXB+AMNBsW674SfzvxA+uOhn6ysNHzaxJlCrpNq5cva4dVRXCnPSsn9K+0HXTtNO11PKX55C9p2dPa6RK8gn14h3kFIpD+AVWbSFtW4fk2RYSvQJrDlXdNf2tRq7sviPwOCTFPPStXjj+KmhqKFayLIl0YzHKSNCQmvrPptDfn2o4suXZe/R6Ybh2EcM7TaDJg6/fkihSXhsdk0TmFqLvuPpOlJ1ZOzhqzjVO9r7TLBw97+KgCFa0Q+n0zyXIBKB40UcZWADnzJYvhd/qZngsz+YRz52CDb0SI+ue9Ku6KN43ZkiHx3mXEYyW0lNVqUCXNB2vh69W5CRyw1w63IFjaG0WKWPh3V9q3E01DhXJYpRZwN872aMgvWk0MEeR9PK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk9WZUhqUXp6OWcvRU4rWEFJcmJGRVJQcGlRWnIyRnFTeGRoRDFzRnBiL1ZJ?=
 =?utf-8?B?UnFndDhWTjJrbFJ5c2daS1BWNWZEUlBPOWtjSjBZMStYY3JRM3Nld0kyNmk3?=
 =?utf-8?B?RFFuamtqd3pWSWhPblgzTkNZWkZNbGQrenZLOWRRdGtEQ0MrVDNTYVIrZzBU?=
 =?utf-8?B?Q3EraitSZFE1V1UxUURsK241dXBYVGdJeFhzU2lXTXJlSXpKL09CZjBUaXhS?=
 =?utf-8?B?Nk5DRm5HMlZKQmlydm0rcExuK1FYeW4yY1hPKy90T2pYMTFoMmJjUzdhZ2o0?=
 =?utf-8?B?ZnFBNmFFVWNNRlI3MXR0V1FjUk04MGN0QUlFWjd6aWg5UUQyaExLMXA0Zldk?=
 =?utf-8?B?dnNEc3NHUVYyekJWb2laR2FFYzVLSjlHKzhKZ2dOL1FDcSszZXdVbjVDeGtM?=
 =?utf-8?B?aU10S3ZTMlhmcVBzYlZ1R3Z5aXpoeXZXRGU0bHp2MUJkV2tQNk5YOWhrVW5U?=
 =?utf-8?B?aUVNb1F2eEJQRG5uL1RwcE9QVzc3ckN2RVd0bXg5MEdHTk9EZHJtQmdSVWo2?=
 =?utf-8?B?QXNFbEJSZlFQZUVWUitZTFVNN3JUaDlBZGNFWmxpb3RKcEJmVWRCUEowY2Jz?=
 =?utf-8?B?bGx4V0hESWtRdm1RZFZLSVczTFVCNW9wN0F1L2xudnJCQTNKN2NwTVdYdnlq?=
 =?utf-8?B?WW1nZktkTnMybFlBUm5oUFdRT0sxd0tqV0k3R3NqaU9qYm8wMzBVTHZPM2xG?=
 =?utf-8?B?dVd3d2YzWHp3ZnlkT0NyWkFhTzhOdE1MTlpqTUM5L0tCR25jeWZFNmI1cUor?=
 =?utf-8?B?NlkwT1VpcHo5dS9aRjZTU0daeGh4b3ZDMVBmWTFsMjVnVzBKMjF3dGNxQjMr?=
 =?utf-8?B?SWlwYkoxcU9IOXR4VEh1TGxmK09SMmlMc1pYdW1IekE3cnN4SXMxdXB4cEhL?=
 =?utf-8?B?Vjd6cTZIUm53MUZWVWVZbnlxRjA0OW04SEw0eGlCbkVybnMxcDkyTm8vY3Zu?=
 =?utf-8?B?eUZmVU9iS3VxYVk1UUo5UHppenRNUVNrSkV2bDVzTjdQQldyTU12a09jRE0v?=
 =?utf-8?B?MlZRMTdKTjM2UmlQQTFkM01YRDRoeWtOYlhaWFhaNG15UEhwMTE3ajlLMHRh?=
 =?utf-8?B?SWlvd3FsdHVOQ09KR25hdzJObWo1NlJRUkVkMlR1OWN3MHZrY0JZM0t0dnNu?=
 =?utf-8?B?NGxub2F4QTdrakRkQy9YMDNZS3pnUTh0T0Fxck1PZUZuMWlPUFc0TXpLZk1H?=
 =?utf-8?B?SDZIZnh3ZWRvVTNlUysvSCtUK3hQV2orakRXYm54ZlhyNllPZm9zL2ttOVFJ?=
 =?utf-8?B?dHpEdkFPNEpaSmVYdnlScUpMRUVXZ1BkMUJJR1pyY1E4Vm83d2FYemhMc1Nh?=
 =?utf-8?B?SkJHOG9ud0JGejdUamlWS0FDaGpiQUFOaDhjTEVwQ1l0UmxUTHpITFFEMlN5?=
 =?utf-8?B?bVBBWVUzaWtEYVg3cTNrOXZwdVRLa3VuMXpnYy9zM0dWMllOT2lJck5kZWdl?=
 =?utf-8?B?UTZhbDlaNHBsNVV1U3A1TW5rUzRLSzBJbVk0clZZS05OUVRHSm1UUlpJNXBx?=
 =?utf-8?B?Z1hrdEVhWW1vT2FBcFY1MXNLV1VUalNPc3VpTzFEQlRMakt0YzNxMEhyK1ZS?=
 =?utf-8?B?WklZWVpYd0NDOWRRaXRseEhBem9ZTnJPUmVPSkFwZkFqeW9obENGNDRWNU8w?=
 =?utf-8?B?ZWE4ditWYkJkODkyaGhKa0xHcjJKbUFnR1FtdTlIK3JTaWtyaW5VRUJPUjFT?=
 =?utf-8?B?Q3h0UHF6dVNqWnRIQ1VseFFVQlB2eFowVW90cG9yZHhBbDVWTHU0dEFmd3gz?=
 =?utf-8?B?T3IzVzFKSkZnY1Qva3AvSVQxdS9hRUgzeFZ0bk1WMFNlZXFHMVphbzNRZ0ll?=
 =?utf-8?B?QUVuRUl6QlMvYUR0ZkxOUXArZkRVL3BxNmc1U3FZVlFiMkZTNm9hSmVNWHBq?=
 =?utf-8?B?Tkw1V1pBc2hpUTdDQkhidWowWnFaUlVNSVowYnRRMWtmdVNSM293TmpCQThI?=
 =?utf-8?B?dU4zWFF1a3J1Q0pzczQxMDVrOFNIb2tCQmZPS0hWMVJtUy9FSCtNN0hEOUxo?=
 =?utf-8?B?YVpwS28zV29YQ2NqWDNPeUdTaVZwLzJHNGFGK09FTDJFWURINThIWjlTZk5C?=
 =?utf-8?B?OXhKZnZEMVF1R1VRYnozYUdUSVNkdlFjZ3NSV2JmVXpGTW8yc2dKRUx3Y29p?=
 =?utf-8?B?Y0I4QUVrbzZ6OTYzb3JpTkx1cy9ZQ3lyQitiRGZLU3Z3dmNKVmVwOUtqREoy?=
 =?utf-8?B?YVNlcDMzREo5VkRGZ28xR2s4WUpZbWZsZWJUTStkS0cvMW1PSkE1elZkMFdh?=
 =?utf-8?B?dTZYYzZHUHBZT3habDlXckNiRDJJVUFLZmYwdDRGb0RFUzF6N3pTYzRRelVI?=
 =?utf-8?B?RmpQZEVyWlIzVkVUaTE3Z3d3b2J3a0pNL080UGxZTk9Fa3d0R0F5UT09?=
X-Exchange-RoutingPolicyChecked: JgjYIBJEUvbI/lvZbY/qvO8LgGCUDqyPvm5+3YN2fBHTUhZUezi8QeeTKNolgUe4fR9ShD1g256W989SetUkeLAY0CWg+pD3jJi9HTOMZHdUrExIoOk86JA4gddK1uGzrc37EK4BJF9dAUGmjZt8qMjjm2dHbsA094mnTfkH+5MZlbhj6onrPHtv+X/zFV3D5aTtBRJL5voE+Eg5MotbX7OXUdq17U+pUcWflCurQm2OPmLg9qo6Fy92HoiRXk5JgmQyqaW8RegX8Hw/iBJYFxZaThIjSWdGDnAFmoZw2mESyeyOwWu1uLEvn9vgndA43kGwB4BauTVvMCkPL01LhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 441c8858-b167-4fc1-0916-08deaa2d2a4d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 22:33:29.5997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InhEMKgoAWk8ErZ0WKE1OdSDaERH23Fo4S8wJ8ULdF5bY7qVscMWB9n/aHEREImqqBp1S8opMoKtVvjZhMTM1UFF8vTJ1CzHHR+WKKtNnn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: EE0E24C46A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284066-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/2/2026 7:06 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ixgbe: E610: add ACI dynamic debug
> 
> This commit enables dynamic debugging of the Admin Command Interface (ACI)
> for the e610 adapter, allowing ACI commands and descriptor details to be
> printed into the kernel log.
> 
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> 
> [ ... ]
> 
>> @@ -106,8 +185,12 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>>  		if (desc->flags & cpu_to_le16(LIBIE_AQ_FLAG_RD)) {
>>  			for (i = 0; i < buf_size / 4; i++)
>>  				IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), ((u32 *)buf)[i]);
>> -			if (buf_tail_size)
>> +			ixgbe_aci_debug(hw, desc, buf, buf_size);
>> +			if (buf_tail_size) {
>>  				IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), buf_tail);
>> +				ixgbe_aci_debug(hw, desc, &buf_tail,
>> +						buf_tail_size);
>> +			}
>>  		}
>>  	}
> 
> Does this result in redundant output being printed to the kernel log?
> 
> When buf_tail_size is non-zero, ixgbe_aci_debug() is called twice: once for
> the full buffer, and a second time for just the tail. Since ixgbe_aci_debug()
> prints the full CQ CMD descriptor details each time, this appears to print the
> descriptor headers twice and fragment the buffer output.
> 
> [ ... ]
> 
>> @@ -183,10 +278,13 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>>  	if (valid_buf) {
>>  		for (i = 0; i < buf_size / 4; i++)
>>  			((u32 *)buf)[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
>> +		ixgbe_aci_debug(hw, raw_desc, buf, buf_size);
>>  		if (buf_tail_size) {
>>  			buf_tail = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
>>  			memcpy(buf + buf_size - buf_tail_size, &buf_tail,
>>  			       buf_tail_size);
>> +			ixgbe_aci_debug(hw, raw_desc, &buf_tail,
>> +					buf_tail_size);
>>  		}
>>  	}
> 
> Can this read uninitialized memory from the buffer?
> 
> At the point ixgbe_aci_debug(..., buf, buf_size) is called, the loop has only
> populated the 4-byte aligned chunks of the buffer. The trailing bytes at the
> end of the buffer are not populated until the memcpy() occurs later in the
> block. Because ixgbe_aci_debug() consumes buf_size bytes, it looks like it
> will read and log uninitialized trailing memory (potentially from the kernel
> stack).
> 
> Also, similar to the transmit path, this calls ixgbe_aci_debug() a second
> time on &buf_tail, which will print the descriptor headers again.
> 
> Could we move a single ixgbe_aci_debug(..., buf, buf_size) call to the end of
> the block, after the entire buffer including the tail has been fully written?

Piotr,

Please review this report and submit a new version of this patch to
Intel Wired LAN.

While you are at it, please review the following report from a run of
sashiko I did myself using claude:

> commit 198ec0389c757125d9079647a6c8aba34ba29048
> Author: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ixgbe: E610: add ACI dynamic debug
> This patch enables dynamic debug of the Admin Command Interface (ACI)
> for the E610 adapter, adding descriptor and buffer hex dumps via the
> standard dyndbg infrastructure, plus hw_dbg() calls on error paths.
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> index 665a9813e251..b686636beb93 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> [ ... ]
>> @@ -147,6 +230,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>> 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
>> 			raw_desc[i] = raw_desc[i];
>> 		}
>>+		ixgbe_aci_debug(hw, raw_desc, NULL, 0);
>> 	}
> [ ... ]
>> 	/* Handle timeout and invalid state of HICR register */
>>-	if (hicr & IXGBE_PF_HICR_C)
>>+	if (hicr & IXGBE_PF_HICR_C) {
>>+		hw_dbg(hw, "error: Admin Command 0x%X command timeout\n",
>>+		       le16_to_cpu(desc->opcode));
>> 		return -ETIME;
>>+	}
> Since raw_desc is declared as a cast of desc:
>     u32 *raw_desc = (u32 *)desc;
> and the sync response read loop overwrites raw_desc[] (and thus desc)
> with firmware response data, could le16_to_cpu(desc->opcode) here
> print the response opcode rather than the original command opcode?
> The local variable opcode already holds the original value saved
> earlier via:
>     opcode = le16_to_cpu(desc->opcode);
> Would it be more correct to use opcode directly in this hw_dbg() call
> (and the one in the invalid-state check below)?
>> @@ -183,10 +278,13 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>> 	if (valid_buf) {
>> 		for (i = 0; i < buf_size / 4; i++)
>> 			((u32 *)buf)[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
>>+		ixgbe_aci_debug(hw, raw_desc, buf, buf_size);
>> 		if (buf_tail_size) {
>> 			buf_tail = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
>> 			memcpy(buf + buf_size - buf_tail_size, &buf_tail,
>> 			       buf_tail_size);
>>+			ixgbe_aci_debug(hw, raw_desc, &buf_tail,
>>+					buf_tail_size);
>> 		}
>> 	}
> When buf_size is not 4-byte aligned, ixgbe_aci_debug() is called
> with the full buf_size before the tail bytes have been read from
> hardware and memcpy'd into buf. The hex dump will show stale content
> for the last 1-3 bytes of the buffer.
> Should the ixgbe_aci_debug() call be moved after the tail memcpy so
> that it dumps the complete response?




