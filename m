Return-Path: <netdev+bounces-290374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMdMIfL0Dmq+DgYAu9opvQ
	(envelope-from <netdev+bounces-290374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:05:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2FE5A47D1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 523303092386
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289002857FA;
	Thu, 21 May 2026 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PITG1ADR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770353C9EE0;
	Thu, 21 May 2026 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364956; cv=fail; b=nMGGRdNUB+DE0n6OSiaRb/RsUpxiDCzLEBN7lDsZG2bRiRAcBbtL5oJTLxjTqhI7VgQbapO33XsTAOo3ANutZa6XmABhekp3y8k9DDqnJknP3o7b6Fq9vBmnLB1Rd+ogoVZupi0CKrUj1o9ms5g0qkV3OtkYf/m0waZQ+hffkPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364956; c=relaxed/simple;
	bh=mW+HNskCL+AnU/SK6hN8yKVr2vz9W57b9Ku5BeLjeFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PHABrsv4ru//Mt+WlOn7zEL2Ueh9L9cGNWlSeMFpSt4CYyEMIM4RXMsJmi5PLfWZRaXyeVuA/O3XibON4Ib+2FmNae7GJ1FP7PYD23FlbjMYBFbbVTUXLzUgD6nrgjv5g7vH/KdF+NV+fIpFjNqyVET9EA0KlLjdiGPf6h52dFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PITG1ADR; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779364954; x=1810900954;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mW+HNskCL+AnU/SK6hN8yKVr2vz9W57b9Ku5BeLjeFU=;
  b=PITG1ADRj4kTcX0UgOaNI25sNidlkML2Yj1f19IMZ/W8rzITLb5NKcfw
   4dY+fBl0MxO0/8CwoQTeK5ueU1/F5beSCENBGB8Mll74CqPs+r2oljlyK
   uUcgDu3sKg82zcVNXIhMrMF5RioSf3/YR52nY7YLBsVzTPdwPvVysh1SI
   SJ2ra0S57L+QTsGlJpB0mXzhbMJS5gzdLJeRTcT00VgWCvc75JOzQMqGf
   tfba6yR6Z8F05iYDQ9hbX1ZTqkeRx+GYtd0irUfx8CrOyRQZoVqGprZZO
   xN23asHnB7HfPx0LchKb1XNZdq6oqXxUIkXvil8I4DCK8j52HbTpUlcWk
   A==;
X-CSE-ConnectionGUID: aXhPaJtTRkyqljHczg4f0w==
X-CSE-MsgGUID: WHNaUzWBRr2mlc8ryPbYpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="91752339"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="91752339"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:02:33 -0700
X-CSE-ConnectionGUID: gx8yk5VOS5SROl/8wcyzNw==
X-CSE-MsgGUID: tBQwdxTJTK2eH6n1adM5BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="240745032"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:02:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:02:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 05:02:31 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:02:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Occc4Xq4QiXXgWjb7nCoAzkJBQv/IB41RO035E5yDZ6sq3M+Q7JaHX88m7XS9QV/RUwHCCnsa9f5bzi5uGpyNH/O3qJi4tMND/S7DhfSE4bFlHCLt7AVua7ETeMwXwgdNpKa+R6j+c2+5ibmDNLKAjESzcnbHoqGJiBDRHeeF+PsGe8bR0HqyQspbl9m/dIFceWJdg6+Fc4ggtdwlxT/8W+7sMZL8aAm4IPDZLOjnOEGyL/2xY/vzgmxDJM+3rYHIEFbXYWX6TZmSDpIPoyqYgyKNTdPFBn83mZ7ajy37SABifQteJYA1z3ylL/CozpzKDtyE+OZ7S6Tt53IVjbb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNQ7z9qOEMBgCb65Sv336FNFb9UPMrx3Zkff/ZOAsFM=;
 b=htCjAJGX/Sn0e8JkZ3ta2mPRTjNDNE7LvaIO/uscmGIatz+b3BR8ZBonIdKy3RrDxmlTyY8MRgpDLbfj0ZEYGkOX1B2G20lPyWTofNhyRkHMmTibingj9/kZetjDRs3i381aBPyXHcA13SZFZdY4ehV9qvq9V938QXZ8m5hcXfg3ABuo6b1Qlmwvx6mIEz1hXO5ll/fFmqzIBTvB+irbMHltsSF/ReL8/FWox9x4tcp86RDRimqKNdr180InFXFWBVA8KtTju1eNx1l11MUAEVzbASGCZTZfhueYawOEEEWtrbu/lTjVZHgBzTnUEeDFkxgiVx3ROM9oR2zVfNHcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 12:02:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 12:02:27 +0000
Date: Thu, 21 May 2026 14:02:14 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
Message-ID: <ag70RrU4nGy0Nlna@boxer>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-4-kerneljasonxing@gmail.com>
 <ag3c9/EF4h7DLQu3@boxer>
 <CAL+tcoAvbEZ7U2oXBWwLAKeuC==gAHi=GXLZcrEPxbb4mQ9sfA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAvbEZ7U2oXBWwLAKeuC==gAHi=GXLZcrEPxbb4mQ9sfA@mail.gmail.com>
X-ClientProxiedBy: VI1PR08CA0238.eurprd08.prod.outlook.com
 (2603:10a6:802:15::47) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA3PR11MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 537ee957-7962-4aa4-4c46-08deb730d38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099003|4143699003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: N2arQh6vBqfe4QB+3kL91+AGyGEA1G6Ku3Sb0nT35W8EFEU98PvYc0XChq1B7YJZcuhRNNRcMgmvEpDrVmTnXe1TuMptldVMhkYtFZ+WbdGtfYcmJmBT+ypgCDWqGyNOW61s5r8Ka7z4hBWzFPQ3IwLvLp3GEFQloCtoXKzcrI24jaafzK7CqqPKId7CulI/GQ1+a+yksIL8qFfIe1ewvNUEz9jO/ScbYW7TJje3ttvsWTw0vgLzTfxA5NJhHuRqYVixoFYunbbxsw/zXL5o6h58jHVQAcfq7B2RtRz8+fujU06uaTTb8+wsA8FGU9yfDrudpaDLXAEY+j6RUVD1PFOh1XHoffAKooyU8IJwcP0Y11q7357DONr2gQPuhQyUAof7XBFm8lTgTd7c4myAlvc4DNDapfFniT8E0+yN4CtIFN1MS8RSwEFU85bhD5WKyy6XgjwiVs25I7W8b25n6swfeI+n36zVOlR8153NqP1c8L/mMXgY4HqfZurMNvuOqHMrYoomUun3B0tSJQmbNzKoyVzUOxePC5A2UvzopwYWK1+BudyfmEZM7C3HVdpK27kd6k6CjlmO1d8fb2C51KuXNRbxAEc70VkAISDEj/mLO5JCHzyiv4JXVQ2APrAyRYY7OvOojUlSa+kxcOE0Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099003)(4143699003)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmNocElhUnpabGpxZGsvcDlVSEJpRDhSaFF5KytDYXJVdG5qK0hXSjQvZVpl?=
 =?utf-8?B?RlpGd1Vhei9ETzVKUW5weTVDbWgzUHBkeFpGb1dIU3g1WlFqYTJROVZWelFK?=
 =?utf-8?B?VGsvT2tFeFl5UEpvQmdZMHUxQzJzWmhHcWN1d2FsWllOdElQdDhuU1M0aE12?=
 =?utf-8?B?cGI5Smt2NkZhbndZWG4zNFhkVXAwQlJjK3o3Z2VWaDZ2cDY4cm1hdldicVYw?=
 =?utf-8?B?VUxlRklkVlVGS2tERUZ6VGs4L3ZXeGVqeHJNU2pvU3dPWHcrODkxVk9vNm8y?=
 =?utf-8?B?aGdORWhLeXBkOXBubUpXUW5hUnhuM2c0c2x5K0N2cEIwMzlBUStMelhjNW41?=
 =?utf-8?B?QWZucjlDa0R5SW5QY1Y3bmVjamNoTlV0L0R0bUJ2OHphcjdGQjR2dFFuQlVJ?=
 =?utf-8?B?dWllWXFtUkFLSXBoREc1dmp5dFY1MjlVdXBNUmt0K0RVRCtjT1RsOXh0K05Z?=
 =?utf-8?B?WW9KUmFBc1E4QjZvM0VlWGo5U2RvelNPbHg3MUdLaFRSMXE0UG96SnhqQkt5?=
 =?utf-8?B?YUZtTVVDZXhKQmsxcnVaR3YvaVBZY3VnaXZGa0o5Y0FBZng1eU50QmxmbXR5?=
 =?utf-8?B?aTl0YWJoMmtCcnJEeUtEdG4rOUN1cEFQRzBVZ3dQVzJ2aGY4clgycExSc2hY?=
 =?utf-8?B?UjlSZURrTllueDZpTGlVczRYcEFVV0YrSTlGenhiUXFnd2xoVHdzanQ2R1Bl?=
 =?utf-8?B?S25hUWErZmNhZEZRV2pIZVVpOG93Nm5YM1VnWmJSbG02VjlINlZFbXUxRGI3?=
 =?utf-8?B?K0tMNjhFRDRXUk50NG5NREhvay8xMTRxNmc1cUlieW5KQmJCR05aWnkvYVVp?=
 =?utf-8?B?Rk5saEdBcUN4UXd2WnlqSWUydS9pM2g4cVBpZGZrYlhrL0xHNU1CVENmNUdy?=
 =?utf-8?B?c2JLZjA5V3dBb3VTYldGMjkxeW5pRDhDS1dyU3dqdzlsZ1FaZWQ2UEIvMVQ4?=
 =?utf-8?B?bkpId0lUNWpxeHcwZUpHWUtKV1Rsb2JkNXlXcDZQaXFzSXpzb2kzVlJkTUhs?=
 =?utf-8?B?azJINmZ4VllRMGozbkM3TmhGVmdselFBcnAvT2pFMkhxYXhXaUFHb2p0RXZh?=
 =?utf-8?B?aWJxZU1ibmdhS3lVOXlZTkovcGtSdzNEdVE4WjdOVEVWYkZOYk8weTZqTTRL?=
 =?utf-8?B?SDdWYUlKWUJiNlljK04wVTV1L3kyWVpGTFpJT2RIVDBudXJhOGh1WUZOWTJQ?=
 =?utf-8?B?dlRNU1J5N25oVDVjTXhtNG4vTjdDV2JtWThrR3JsK2hnbHc2Y2lvQkhUTmFi?=
 =?utf-8?B?Wmc2OFh5ODVIaFVuVzdtM2V4YnM0bm1Bb04wSUFTbU52NnlwL0FnMzJldzRX?=
 =?utf-8?B?aHY0VVNtT0tjcythOWhZQmpVc2l0S1B3N2JGalJnbmxQeDlRbk81Tnlacjht?=
 =?utf-8?B?SFJ1bm9BTTE3YnBxVzV5a1Qxa0Q5RCtBLzQva0RqTU1wMnlDYXVyOWhYZUFj?=
 =?utf-8?B?L2s1cG10TkVtUzR2MnVCZ3hFUzJUbEJXWjhlbFdkVCtTSWtIenQyTEhYWThW?=
 =?utf-8?B?aU9iU2tybFhDbmNjaEdIbkxuVkV5M1U1SDBNYXR5Zm5wZFRHL0dEYXNWcyt0?=
 =?utf-8?B?ZmJZclhxN3kzQVEzT2dnL1N0TEZGZ253d09ST1NTM1hqcGwvVko0RnRaVG5V?=
 =?utf-8?B?WWF6azdmNC9QM3lmbDlmamZ6a0RtakdTaTBQNk9YWURKaGJSV3hzVTVqN1R0?=
 =?utf-8?B?alIvaVBvelFYUFN1cHhjcGkzK0R4VVJzUHZHRGhlSW9kbHM4STN6amlKRFRZ?=
 =?utf-8?B?NEJOaW00dG8rRjE1WW1FbER1czNKSUtvSmlrdUgwdVdKTWI1cWdLYWJOOThu?=
 =?utf-8?B?U3lxcUdWalpobklPZmxDM04yejd6NzdDeWZXdnNHSFBCcGJHUlRpU3J0aThM?=
 =?utf-8?B?ak9wTEZqYUYxcVEyaWxtTzAvbEdxSk1kUWI3WjdUeCswcjMzNHpZc2ZDOVlN?=
 =?utf-8?B?bDNnVFpZSEtid3ZLeEpqaXdLRFZ3aHNtWlA2cUp3MzhwTmNWZXBlclZXRnZz?=
 =?utf-8?B?RENYbGdsMDNrajRDSktmOVg2dGs0QUhjU3RqYUxlcHVOWWwzalpMOXRObnlZ?=
 =?utf-8?B?ZWEwYm4za1BzTHVJM3htWGZnN3NVdWhKeG5rbnh6Y3IxMTZYb01PN2M5dkZR?=
 =?utf-8?B?bXJmUXRrbjRHanlGYTNUUkltV0hLaURxd2NXcG5JMzFweDFNWE5nNGdpbUFv?=
 =?utf-8?B?T1dzWGt2MWg2aEU0Ynp5UGhYRmphYjNpOTVwTHBLWnZGSXZhNk05bEExMHJy?=
 =?utf-8?B?VTdvUlJKMkRFbEV4UnJFT2J1cmplV1B6ZnlkTGJCSnVQRVFEWlBBYTd0ajQ4?=
 =?utf-8?B?d1NwTHZ6M1ZiL29Pd09UVTBOdVR3T0RYUG5xS0psNzNCc2s2K1ZXdDRhYVo2?=
 =?utf-8?Q?zFpKgjFT6m8YZSqs=3D?=
X-Exchange-RoutingPolicyChecked: mqkE80gp38lASAKYnvlhfgc9tnQBHkUSf5zOAnKesGBjTV0aSYMlqOCbDce+hAFZa0nNzQe42JF8sKrVCxKe10s2YPOG1kWs4Qj37BQlb9RWGDmhmvktIUSEwU+dvtSpOVERMXscGyoSjfuBNfJ646EZUIzduVk5Hsms2jE++k1e6mIG06eZkf1x+iuaDJpT9jN4Xv8hKxWRvRHq48Sf8OoEdIMPQwxps3GEQ2O0YH4ZTwYxFInHnSujhigUogFEGovZRA/N1YyLe0BKofYM+/ioRd7TSgWue3hcIBK9A0gqpgeQslqzk4lhkOrMpr/HQp5jVJlbhizNQ0XB3KI2+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 537ee957-7962-4aa4-4c46-08deb730d38f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:02:27.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xS1tTj4IIVio/rnMp9XjnZ5/PnQKtTY7wbxeeiK/TS3WKARoG6KkdXrLIUZr0+k4ctpfsivQ65MVhOE0qNYuqe4FDF32BcPQM/LzkjvRR+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8047
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290374-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email,intel.com:email,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DF2FE5A47D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 07:53:27AM +0800, Jason Xing wrote:
> On Thu, May 21, 2026 at 12:10 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, May 20, 2026 at 08:42:42AM +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> > > only the current descriptor is released from the TX ring. The remaining
> > > continuation descriptors of the same packet stay in the ring. Since
> > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > leftover frags and misinterprets each one as the beginning of a new
> > > packet, corrupting the packet stream.
> > >
> > > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised,
> > > so we have a chance to examine and handle the potential remaining descs
> > > of this big overflow'ed skb.
> > >
> > > When the last fragment (without XDP_PKT_CONTD) is processed, the flag
> > > is cleared and the loop continues to process subsequent descriptors
> > > with the remaining budget. This behavior follows how previous xmit path
> > > treats overflow packets.
> > >
> > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/net/xdp_sock.h |  1 +
> > >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> > >  2 files changed, 20 insertions(+)
> > >
> > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > index ebac60a3d8a1..8b51876efbed 100644
> > > --- a/include/net/xdp_sock.h
> > > +++ b/include/net/xdp_sock.h
> > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > >        * call of __xsk_generic_xmit().
> > >        */
> > >       struct sk_buff *skb;
> > > +     bool drain_cont;
> > >
> > >       struct list_head map_list;
> > >       /* Protects map_list */
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 0a6203c42576..f4add7be8c93 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >                       goto out;
> > >               }
> > >
> > > +             if (unlikely(xs->drain_cont)) {
> >
> > Hi Jason,
> >
> > could we get away from introducing dedicated boolean to xdp_sock for
> > handling this rare case?
> 
> I've tried several ways, but they didn't work. Please see the short
> conversation with Stan:
> https://lore.kernel.org/all/CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com/
> 
> That means we always rely on a flag (that is either static or like
> this patch) to recognize how we treat this abnormal descs.
> 
> >
> > > +                     unsigned long flags;
> > > +                     u32 idx;
> > > +
> > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> > > +                     idx = xskq_get_prod(xs->pool->cq);
> > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> >
> > It feels a bit off to do this cleanup one-by-one.
> 
> Actually no, it adheres to the basic send logic in copy mode.

Not really. Here you are producer to cq which we have batched variants for
usage.

But after second thoughts I don't think it would be worth to put any
further effort onto optimizations here. Anyways, even though generic xmit
is a whole bunch of mess, maybe you could pull this out onto a helper
function?

> 
> >
> > I wonder if it could be covered by xsk_drop_skb() where you would walk the
> > tx ring and store addrs at xsk_addrs and then use xsk_cq_submit_addr_locked() ?
> >
> > OTOH, in theory the amount of frags after we hit the overflow case could
> > be well over MAX_SKB_FRAGS again so xsk_addrs wouldn't be able to cover
> > them.
> 
> Right, this is why we now put the logic into the xmit path just like
> other kinds of descriptors. We need to check and send it under a
> series of protections like the check of cq pressure and budget. I
> don't think it's an exception to escape the check logic. The whole
> process should be fast as there is no need to build skb and send it to
> the driver as long as this case is recognized.
> 
> Thanks,
> Jason
> 
> >
> > > +
> > > +                     xs->tx->invalid_descs++;
> > > +                     xskq_cons_release(xs->tx);
> > > +                     if (!xp_mb_desc(&desc))
> > > +                             xs->drain_cont = false;
> > > +                     continue;
> > > +             }
> > > +
> > >               skb = xsk_build_skb(xs, &desc);
> > >               if (IS_ERR(skb)) {
> > >                       err = PTR_ERR(skb);
> > >                       if (err != -EOVERFLOW)
> > >                               goto out;
> > > +                     if (xp_mb_desc(&desc))
> > > +                             xs->drain_cont = true;
> > >                       err = 0;
> > >                       continue;
> > >               }
> > > --
> > > 2.43.7
> > >

