Return-Path: <netdev+bounces-260456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN15GbiCnWlsQQQAu9opvQ
	(envelope-from <netdev+bounces-260456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:51:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E51185AA9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A6E33012BD6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29DC37475A;
	Tue, 24 Feb 2026 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYb4f8mF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928A156F45
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930285; cv=fail; b=aLLSIC2LMKXbA1tPkPM3fUiQj0vfP0zyvXKV9AMApbD9ilDOe5abRJc581S+iWH8k4CzTXqB6AaEJnE00nI4QT6PZ2q1qnK5zf+17ZDJHW8tVHqkZHSDahm7tvMFZPVeAdPRh3cbMKFzGHhsJSP82Wzo9HpuxxgecTdZ4F4mW50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930285; c=relaxed/simple;
	bh=qVa/6RlI1Hf1ChGwU10tR2qbExOd1PPljxdAeSdgq6A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AHl/4rsZLCm9FiZTKQzmhomB/jf/L5RaiPK+8xDma00lNfmwnk66MqDr5TZoo8sttUcUhUuNzi05CGQp6CilX1IroYbMw3BAACSH49zJkjil0lkLLkZe2yHHpg/urBPQfchMVlFMOamuloCdiZ0t85evZcKzAqrknajrcZNh6BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYb4f8mF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771930284; x=1803466284;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qVa/6RlI1Hf1ChGwU10tR2qbExOd1PPljxdAeSdgq6A=;
  b=nYb4f8mFCxY3u2LBHwwJaNWqDr9gkcfv6yOzqtAepPgk4e4Tut5BJzn9
   yr14fAUOOrrr5XnHuuy3p9dZm6tuw6gocNrKb4CA9rcdNIO6bHEVpHV4J
   KYCsdRvoLwUZsRxytYU/uAYOXV9HDiRTBJUuNazsJzqHVSXiXluXgWQJt
   G/3/7jxyQXE1t8rQhJUEGGGtJAwF6TZVgDCmVc7NZekjZkscmyt81NWGM
   prXPPmvotF6XUkVfwCZpCDeABkCnOQ6Y1/3g11+/1RhXFRHjDfxQ9r26r
   1aQcoTCDzdv+gbAXB/k4Q9BtwtNxhFRon6YFr3HxF0bCZG0SToXIT78L6
   Q==;
X-CSE-ConnectionGUID: 4lVgyClaRyaHeKQW0hD8kQ==
X-CSE-MsgGUID: s6sKwGbETKW/QSox/XqvQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72852784"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72852784"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:51:24 -0800
X-CSE-ConnectionGUID: wPIBNp4qQti8pRh+iV4WEQ==
X-CSE-MsgGUID: UwvIa3jrQwaJZ/7CpWr/4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220862941"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:51:24 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 02:51:23 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 02:51:23 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 02:51:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey0yq5nMF5gCyxyLXuBlyoPtoiTrjYba+8b2bcKnOzwpTJ0dnzi1XDmxpE59kpRkHVWc9ZlnFik8cxFnLLsGHo/yQ2HrkMtf/LsbAxaxPrdTjQhJSHJehgrMI/vul8UEElmdF45Br4eiEzrHAYM9QZJ64GR9A78vm6c2TnNaL3TETG0BMTyLTs9Tmp2PrP5GxOAwN1ypXdRkkpZMOl5y78y/B968OSOEdpUXe7RI+OTTndS1AaiEEe1zNBJ288y4dV02FCSVQLKbVkvK4sz4An/nlPzNeD7jJKaU0cIE8OnR4QyF9v22josx2jz61HmCaKXSRroZaIM5Jea0AgnVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHSLCo6fNaEsdTWj20V0Anhc7ImOnSAWHSGn/8jAcSQ=;
 b=f1v76CJihpE0q0Yb848Wezf1Jh6a71kss3+/N7KKat2vXKzfCPD5PkgDbUsgmkMuf3pz1rOqfTo/t2zLqXpSToZll3geb+l0Eg+StQRZm+A5uBX6yVqBtTK9vBWBq3pyaLpB4Js0e1nn8v4OOeDIi/UyNsM6g80grPkBCmoxiifx34hJmEkFskWTL7U4q+1LbMFhGimYKsMam3jJh1YJllvubwgPrJuOmH1FSTWx55vbusb+8WtuGyyvgKHvTozRkUqB4xGLH5toDizKAO8eEWYb5PaCUJymnRPyljPHD2Bzd19Y5wCuy8lTCmz29Y7kgqnshFg0jaG0vSq/YLA/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by DS4PPFE901A304F.namprd11.prod.outlook.com (2603:10b6:f:fc02::5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 10:51:16 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::2769:b184:69c6:6eb0]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::2769:b184:69c6:6eb0%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 10:51:16 +0000
Message-ID: <e7b6fd33-587a-4d6e-ab41-c3843d24c1da@intel.com>
Date: Tue, 24 Feb 2026 11:51:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: set max queues in
 alloc_etherdev_mqs()
To: Paul Menzel <pmenzel@molgen.mpg.de>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20260223125157.819135-1-michal.swiatkowski@linux.intel.com>
 <15d16cb1-4b7e-48ff-97d2-7d1064ebfa42@molgen.mpg.de>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <15d16cb1-4b7e-48ff-97d2-7d1064ebfa42@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB3PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:8::15)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|DS4PPFE901A304F:EE_
X-MS-Office365-Filtering-Correlation-Id: d7418b6f-abe1-44d9-b275-08de7392a1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmlIMXhUbk1XNXdHT3FnNUVJMnBMU1BQRDFrTEJWWldrYW5iNWZCblNDRTEr?=
 =?utf-8?B?OGVJeS91blBDazhpSXhsRkd6Tm5jL0pOSmM2RUZmeEtaY1ZqdmNtWThacDM5?=
 =?utf-8?B?L3lLZVZjdE51VDh4YXlYbFZQZkl6UllWUTZ3eDBKUmE4VUFlbm81VmF4bzhM?=
 =?utf-8?B?RENCME4rZzRPaEkyTHcwYSs2U0N6L2YvK1dxMzNTZnZNc3JhZUF4alRod21V?=
 =?utf-8?B?emtPRjUyY0IwNDcwVDR2b1FZQzcxRm5zN0hJTldoM1hzY1Ryc08rbTlkV0Ns?=
 =?utf-8?B?MFBCcXFNRE91YjM5MkVaRzlUL1NrM0hiTUZoL1ZlRlV1aDVjd1ByaXRwMVkw?=
 =?utf-8?B?aVhsc3ltT0pXQXNBZUV5aTR6UDNRUUZlZElueXZWUnZ2YXU2Znd1bmIwZDRX?=
 =?utf-8?B?MVBWL3l1MjJyQjdoclpUOHJtVkNlUkNrWlRoY0RURElYQkhDem01WmNsWEJR?=
 =?utf-8?B?dmVPZEVLQnkwL2Fhbmc0NnIwSE41Q3NPdWhLcjVUK1U5ZUhIU254c29BdHhx?=
 =?utf-8?B?dDk0Q3ZvbnVSNlZhUnZzT1ljUitrRytEZzNOaXdyNDQ5Q1JvVEVqV3NNVlhn?=
 =?utf-8?B?MGtheHZBL0dGU2MrSGhKU1o2MzBrQWhTV1A3Q1VkNW5zcWdUWkdSQzlCdDIw?=
 =?utf-8?B?SlJKSkNNcnBIdWFXVUdSZEwyYTR0eU5PYWJUc2lBaDNpQkM3TmVwdVpyZlU0?=
 =?utf-8?B?NzFsVXF5aGFqWW1pSVNoQzlhellkb0xPOVNJNU5SbHd0TFZCWVIwV1JOKzJ3?=
 =?utf-8?B?TFZJbTZ0UzNhY2gybEdENUUrNWlWU0psWmRLN1lvd1gyd1Y0NDNrR1lnVlRk?=
 =?utf-8?B?RGx2aGxIREhrcHZ2MnpmLzZ5TExLZWR6YWpsRkV0OCtEdzU0d1NwcVlYZXE1?=
 =?utf-8?B?MHJjRUJWanBoNFFxMlNaS3hoY1FNY0dGMy9RdjhKYWRlNllBUnZlMWF0dEVi?=
 =?utf-8?B?N091aXpQQU5yMzB3RXRNQThsYUMyUU9pOVpwSTBVWng0QUhiMEcvQ2ZrUk8r?=
 =?utf-8?B?K0c5dDVwamRyUXErdnJFUXF2TldYc2RtcUl2c3BwTExGNW1FbUpQR2c2QVZx?=
 =?utf-8?B?NkFwdkR2SFJCRVVQcE1LQjlNbHRtSkRINW9mSUtLV0pKUzAvVWJoMDIxZUpv?=
 =?utf-8?B?UGtjM3N2UzdRMitQSGVmN1FwSGdtQis5SGNnTUxzelUzQmJQckdOSkl6eTRT?=
 =?utf-8?B?WTh3dERCTHl3MnczOGdNK1VjRGwrVEJtWDBJTUFvVVlOdktFTS8wdWdjNGI1?=
 =?utf-8?B?YVZlL2tKZUZnVUlJVktKeTdNUEVqUWN0SU5tYkZlS2tRM0VTdHlldnYza2tY?=
 =?utf-8?B?YTFOWmlWOHZqamE1bEQ3Q1RxOUZuUVpZcFRXdE9ra0pySkRyY0tUUE96RDIx?=
 =?utf-8?B?LzNWU01nbkdvUFdMWDZyWjdaWFJqL3ZNSnFVTFJIVUtteWxra0kwakxZRHF1?=
 =?utf-8?B?d1JHa2ZZeFQ2M3cyV0JpcEZGNmFQcHlIUjJ1V0xsUU41SUpDTXRuVExxWjF2?=
 =?utf-8?B?WDMvRmdOSXE3UEtTWURLWVBsaXp3WUFIWXdWTEVPN1YxRVExdmkwQzRBdmdJ?=
 =?utf-8?B?WlJUUFVWQnpZRDZQYzBQYU9CRjNtNlFmLzkrMGhwalFxQTlDbytRSlVxNVFY?=
 =?utf-8?B?WFNOd3crSGF4Q3BGTG9VcDlTWUIvM2UvMXgxT1U5bFhvR3UvOTNNNDdlT3Nt?=
 =?utf-8?B?SC9uVzJEQ2JQYXdCR2dsRklDcUszNkxVelNodkRtcnh3RXlqTCs2WnR4M3FY?=
 =?utf-8?B?bWtBQ1lGaENxZVc4czdBNlpDV0ZtcGFRalVWK2xFY0tRa2Jpb2Q3OGQwZFNI?=
 =?utf-8?B?eFl0RWxFRXBFQmR0b0hGMVAwTEkzZmVrTFZqTVgvcFBTMzZ5NW9HVkxPNEtt?=
 =?utf-8?B?ZlpkcHExNkhBaHhTRWQ1bHZNYyt4SUlucjExOGRxMmxEdVNqcHdnd01oemg5?=
 =?utf-8?B?ME16YzBKVTN6eFlPR0ZoNDFMNjEwMm5JNjkrWU5tdDhBTmxFTlFpSGszTkhI?=
 =?utf-8?B?OEpNNGJ6UDg3S3BsdVFIdTd1WHlxWWxBd1NrQ2hCOUlaZ3JPbHNnbE5rYnNp?=
 =?utf-8?B?SUZRQnZDczFlUGJCUlNlMG1nblB6Y3RkVXlLdHdsa2piSGR5M2RTVWdWZG1i?=
 =?utf-8?Q?S4UY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtIOVpZSjJQSTRlYklVVThXb3VQdGEraSsraGI5UnRKZmw4d00wcklVanNl?=
 =?utf-8?B?SkVNakFZemtMY2FxMm5RS3ArZU5mcW14eVBJMVNJSkh1MzhwU2NJU2d0Mkdm?=
 =?utf-8?B?bzNwUGVPSU5ZMHg1WmxJRFRKeitlZDFFOFhyS0orTk03Y0lNSk1aeHZYQW1C?=
 =?utf-8?B?bGFhOUE3ZWpEN3l0aGptZDc3UmlSc1ZRQ3ErL3lDN1J2QTVOUUlTMTNYSkE4?=
 =?utf-8?B?M0RvMTBVWEtMbGdZNUxGc2R2Y3BScHlNT0dZYThLbmtrQUlzQ3FXSWJkNk1Y?=
 =?utf-8?B?QTlFSm85bytVVzlVeVZ3dm9VUU84YUJCWlU0aDRFNmVpSlAwQnJIenFrWUF6?=
 =?utf-8?B?OTRPSEx1eEVkbkJTZXQ0U2VPMUhmbDlTTWdIdWVvOGZjRFBCUkhGSld0cGM1?=
 =?utf-8?B?VkI3WThXMkx0aXVsTi9Rb3kvSWRNaU10WlhLbkdLbUFDQmg3cG4vSVF4RjFM?=
 =?utf-8?B?WitDUS8yN0hYVlhYNDFYQjFhc21aZlNPWHFNTFh2alJyWHNadFJ5ZXp0TzZq?=
 =?utf-8?B?T2pUT3d3NG4xTDVHeU56ODJ0dkw4UTVhOUlEaWFvWURWWW9EVm5rTjFvaTdN?=
 =?utf-8?B?bDFyR0FqNXllSXVBUUlGSjJETHM1QkJ2encxdXowZERHcE1kZ1lxZGgzUTlw?=
 =?utf-8?B?dEg1Q1RMb2dTbng4RUlnMHBWQnZHSGZsb25yQ1U3TURzTzJMTjZDTlJaVDRp?=
 =?utf-8?B?R2VCZGxZUEN6WnRvOUdmdEFPN1Y5V3RsMFBvbGk3UU44NjFtTWJWb3Z2NUZG?=
 =?utf-8?B?MHRhVWpjd0tJYjVXL3NtcStFRWR0V3VSZGg0dHBxOXB6U1cwYmtySHVEMjl2?=
 =?utf-8?B?RTZPTlBGMzBYelhya3kzaDNwQ2w0V0U3ZnZTS0V5Zzh3OTJPYzVuS1Q5Qjkx?=
 =?utf-8?B?Y09Rbk1EekhEUDExRm90R0hIQ1JqNmx1b1FoMjUrRmJjdXNlMzdtUWRnTnFH?=
 =?utf-8?B?T0tQK3ZWQlVXSk1jWnlPaGFHSGlub1JkakZsZjlTMk9yYkZSN0RxSFkva3Bk?=
 =?utf-8?B?VWd2TFRCem4zTnA5QWU3eENFakRGSFpCM3FUT2NpcXJ0TlFVZzVGL1hjS01K?=
 =?utf-8?B?WTJhVlVwSkxJNnQzQVEwM3RwZ2ozRXByVEpWekwybXc4UHRpdWRvZkNRSnk1?=
 =?utf-8?B?Y2xlWXpuSmV3Wkh2WFdoZGNUU3o4UkJzSml3N3ljWWVSbXM4RXI2QzVFczlU?=
 =?utf-8?B?NnZUZUlhNGFtSnVtbUNNOS8yZy95RnB4d2twb1JSLytLOGxxaWd1eWUyWGkw?=
 =?utf-8?B?d2dvY3YrWk1RTzVDNkIvWUJORjUxMDlkUFRXTW9vOHpDQkhEZm5JZHJWNTNF?=
 =?utf-8?B?UmNwTHdBNjFUK2V0WUFxZ2MvTEdxdWtuRmhPbVp5VDJMbjB0TXJhU2ZqcEg4?=
 =?utf-8?B?TFFrajNmZTV4UWJoNFcrRWRrcDlhWHdFalBwNGhLeStXTHlXQVVyY1FnNkh5?=
 =?utf-8?B?WnlaalA0SE9hall4ODB6aUQ2STVralBQSHNTcEpVejVicDdwY0NVWVQ0T0JS?=
 =?utf-8?B?K3RuWW83WmY3WUdGQ09RNVlvemhDdFNyeTVMVlMrbXljY09rK0J3SFFhR0Zz?=
 =?utf-8?B?MHowZjduWDFwak1lanlOdnVzNjMybDExSGJTRi94bDFsNTJ4QXBvUTZqa1VG?=
 =?utf-8?B?MytIUVRhU3czRmFERVB1NzhkMThOcVFkTU5kVkg1Vms1S2dCaG93ZXJRMEVv?=
 =?utf-8?B?aEh0bVpLQ3ZhcjFnSGY1Wk5WRFJaSkhWRXFMcFgxaVV4Q3h3SGhrUjFJR09K?=
 =?utf-8?B?UEZuaTYwdUF6TUcvY0JDeW1GZUdQdEJPV291bjNWRzRHY2JTcUNmTFA4Mm1Q?=
 =?utf-8?B?U1pUZGtkR25NdStyTmthMDNHWjNWbWkyUWFPTDMxL1B0RC91TmJBaExRS0Fs?=
 =?utf-8?B?RWtYamxnbUZ2TlVROHhERVhDRDlhcVh4QW1FekdUeFdRVzdhR0MvdVJNSkNH?=
 =?utf-8?B?ZmMvRWpCT0RaZk9hY3gvR2F1cWxYR0c3QnpEdGF4bDJHdUgySmJtajg5V3JE?=
 =?utf-8?B?VkNZOUVFbmtlQ3ZRdC9rZWJTc3c1cmt3S2luSW1lYnhHQzRFeUw1WTAvWS9D?=
 =?utf-8?B?RmMxb2FYeVhjMjhJOWR1am04elUvWEpmWHA5ZklSTDU4QkU5WDB1bHQ4RDFy?=
 =?utf-8?B?RzVpM3owWVlKZlpXVWliVDZ4TnhUREJoZlNnZHVEOXpJNnc4NW1jekZsTWR1?=
 =?utf-8?B?TEx1d29QNlZDRUFEN3dqelhhcmdYcjlTZ1BZc2pNTGI2VVFOV3o4YlJYWlpO?=
 =?utf-8?B?emVQd1ZoTEZlOEVQckFwZHVEcCtaSUFVUjI4VmpvYU5TcjkyNXZGMTlUU2ti?=
 =?utf-8?B?cnVZN09lNVdTUHBVeVM1bzBEbXpuT0RvUDhPbWFQMC9hbEVJSjlUUEIxVGU0?=
 =?utf-8?Q?LerMNKrcNOIVsyt8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7418b6f-abe1-44d9-b275-08de7392a1d7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 10:51:16.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTUWlbFvGXhsnLt8fpFbmC6qT7U6fU0fyaimT63aUKpDpDyoKlrfrlXbMBMUNi0Z9O1X8gk7kjbErb+jPbzO9sDQWereRKF0uk/ziIUxHjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE901A304F
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260456-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D9E51185AA9
X-Rspamd-Action: no action

On 2/24/26 11:03, Paul Menzel wrote:
> Dear Michal,
> 
> 
> Thank you for the patch.
> 
> Am 23.02.26 um 13:51 schrieb Michal Swiatkowski:
>> When allocating netdevice using alloc_etherdev_mqs() the maximum
>> supported queues number should be passed. The vsi->alloc_txq/rxq is
>> storing current number of queues, not the maximum ones.
>>
>> Use the same function for getting max Tx and Rx queues which is used
>> during ethtool -l call to set maximum number of queues during netdev
>> allocation.
>>
>> Reproduction steps:
>> $ethtool -l $pf # says current 16, max 64
>> $ethtool -S $pf # fine
>> $ethtool -L $pf combined 40 # crash
>>
>> [491187.472594] Call Trace:
>> [491187.472829]  <TASK>
>> [491187.473067]  netif_set_xps_queue+0x26/0x40
>> [491187.473305]  ice_vsi_cfg_txq+0x265/0x3d0 [ice]
>> [491187.473619]  ice_vsi_cfg_lan_txqs+0x68/0xa0 [ice]
>> [491187.473918]  ice_vsi_cfg_lan+0x2b/0xa0 [ice]
>> [491187.474202]  ice_vsi_open+0x71/0x170 [ice]
>> [491187.474484]  ice_vsi_recfg_qs+0x17f/0x230 [ice]
>> [491187.474759]  ? dev_get_min_mp_channel_count+0xab/0xd0
>> [491187.474987]  ice_set_channels+0x185/0x3d0 [ice]
>> [491187.475278]  ethnl_set_channels+0x26f/0x340
>>
>> Fixes: ee13aa1a2c5a ("ice: use netif_get_num_default_rss_queues()")
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice.h         | 22 ++++++++++++++++++++
>>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 18 ----------------
>>   drivers/net/ethernet/intel/ice/ice_main.c    |  4 ++--
>>   3 files changed, 24 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ 
>> ethernet/intel/ice/ice.h
>> index f6a56a864459..725b130dd3a2 100644
>> --- a/drivers/net/ethernet/intel/ice/ice.h
>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>> @@ -839,6 +839,28 @@ static inline void ice_tx_xsk_pool(struct ice_vsi 
>> *vsi, u16 qid)
>>       WRITE_ONCE(ring->xsk_pool, ice_get_xp_from_qid(vsi, qid));
>>   }
>> +/**
>> + * ice_get_max_txq - return the maximum number of Tx queues for in a PF
>> + * @pf: PF structure
>> + *
>> + * Return: maximum number of Tx queues
>> + */
>> +static inline int ice_get_max_txq(struct ice_pf *pf)
>> +{
>> +    return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_txq);
>> +}
>> +
>> +/**
>> + * ice_get_max_rxq - return the maximum number of Rx queues for in a PF
>> + * @pf: PF structure
>> + *
>> + * Return: maximum number of Rx queues
>> + */
>> +static inline int ice_get_max_rxq(struct ice_pf *pf)
>> +{
>> +    return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_rxq);
>> +}
>> +
>>   /**
>>    * ice_get_main_vsi - Get the PF VSI
>>    * @pf: PF instance
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/ 
>> net/ethernet/intel/ice/ice_ethtool.c
>> index a897a6b22495..a0b0416f5aea 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>> @@ -3780,24 +3780,6 @@ ice_get_ts_info(struct net_device *dev, struct 
>> kernel_ethtool_ts_info *info)
>>       return 0;
>>   }
>> -/**
>> - * ice_get_max_txq - return the maximum number of Tx queues for in a PF
>> - * @pf: PF structure
>> - */
>> -static int ice_get_max_txq(struct ice_pf *pf)
>> -{
>> -    return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_txq);
>> -}
>> -
>> -/**
>> - * ice_get_max_rxq - return the maximum number of Rx queues for in a PF
>> - * @pf: PF structure
>> - */
>> -static int ice_get_max_rxq(struct ice_pf *pf)
>> -{
>> -    return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_rxq);
>> -}
>> -
>>   /**
>>    * ice_get_combined_cnt - return the current number of combined 
>> channels
>>    * @vsi: PF VSI pointer
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ 
>> ethernet/intel/ice/ice_main.c
>> index fa4095037be5..863ac81eebce 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -4699,8 +4699,8 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
>>       struct net_device *netdev;
>>       u8 mac_addr[ETH_ALEN];
>> -    netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
>> -                    vsi->alloc_rxq);
>> +    netdev = alloc_etherdev_mqs(sizeof(*np), ice_get_max_txq(vsi->back),
>> +                    ice_get_max_rxq(vsi->back));
>>       if (!netdev)
>>           return -ENOMEM;
> 
> Should also some checks be added to `ethnl_set_channels()` to avoid 
> crashes?

alloc_etherdev_mqs() gets absolute max from the driver, it will not
even call driver .set_channels() if user tries to exceed that

with that said, we have too much "extra checks" in this handler ;)

> 
> The commit looks good:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> I am missing the mentioning of the crash in commit message title/ 
> summary, but I do not have a better suggestion right now.
> 
> 
> Kind regards,
> 
> Paul


