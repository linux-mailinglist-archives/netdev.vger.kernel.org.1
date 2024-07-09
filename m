Return-Path: <netdev+bounces-110141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7043A92B1B4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E909282B42
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736E13E40D;
	Tue,  9 Jul 2024 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpyPFpXe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA901D556;
	Tue,  9 Jul 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512145; cv=fail; b=LZwUpoYADOLvsc/GVb+gQ/fokEEOVo4fpmvfwQ5VWvUOshiwe3zqY45MXyiF3Fnz0Q3LrccnqRy2mj5pec+/GozmYBB8ZyKvMZtWotYDf5L1WiQ47ALuEc3xt6UcYyf8WoQ7Zwjpryk+o1UZwq4W1Ztr8K8b414wO/AnytGluVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512145; c=relaxed/simple;
	bh=2PFfKFIbIEqnTlU+vJk2zyB+k6v8O0W3sNGesMpE0Cg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lls/2FaZwKyD1ZDkfaZDHFml1ydNggM5zaWWinaexcEG/Lwzfz8AX9N1WvXPQg4cicueMth1ZA3TT83OR9X2LYdkh7G7CLv5Go6RVL0hoD1Kq/rCaRgxrAQXQae/kPw5vBZS0mo/bQ6BeGYGWqpkeRm/NJIuzKKRTsJSAodleF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpyPFpXe; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720512143; x=1752048143;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2PFfKFIbIEqnTlU+vJk2zyB+k6v8O0W3sNGesMpE0Cg=;
  b=PpyPFpXeCSNkO7Kbk+OjeiqaUWuD8LE5D7FYNAouqU87bKqgt4sqmrRf
   nbG6JTYT3Bbpj1vojJaYF2JtojqQlplKBkHxb5/KZ6Wb+PU1JEJ/BzsAq
   HZYsqRe8HfIfgJvChnCwqoGr3AQ18ykIk+KnSsbcsOAiF+PIsGkh97Iwo
   iAUWHdE0FE3D9f3zPANkHj3DjYvJX8ztnUCROP+FxQubqTobb7IxKu83J
   THGX9UYSmY0kKJiu/siI2FSgoVqU4koYcKotaVeBuCxE0LP2bW533wRF7
   ZO+WPh7gp8FI2ha5wo46rSI1Zjj2oy5oNRkJVUzL8ja7ou75La3kZ/kTB
   A==;
X-CSE-ConnectionGUID: LzIUH0RNRVW8/MgtbAZq/g==
X-CSE-MsgGUID: 0WZYvXjIQ8aPhOPmVinSeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="40257873"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="40257873"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 01:02:23 -0700
X-CSE-ConnectionGUID: GYMoAGoFQRK4PH86ITt9dg==
X-CSE-MsgGUID: NJIQIiHiQqCK/q3XDHbrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="78508729"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 01:02:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 01:02:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 01:02:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 01:02:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNtQwCEOEPuRiL+vCGfTuxEkBHmLPu00pIL1UY4RuSoPcMyZCSZDm9E9btSmKeyKRZpEWx/qPgumYADgvJwkU+88RDkNaUSz1QVfReidzptfn9Hb9CwH6ADWFCSlzVxUSNk8XTCR/mTHzUG12QzoosP8v+MuDb4FGsRrkMuZ5vUixYReJZsk0IKcnsv3/TIUcYh6ODKUBLbkXMMketMty7iihXPCyuE70LfFCnO5CPoRSAsIAdMmfIgPObC8Zkme+/c+TsVrqCGjGiu4sQNHNW7H6dZeNDAWsTr3DTzMiixzizLp84Skjpe1ev+dR+M6emWZOtxLwDoN+1VgtllvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jlg6Idi6K+jY3xZsUT3zCzv1QjYuzfalv4ERzs+N3lw=;
 b=F4eKYtfczGby8SbC5OITGyQ8wXc22bLcMGFvlhSlMrbgNwwSwsqDm0R4iAWNafevWyQrnPB4Ge0MLQBlAa2dG8sauNUHeVTuDHcgK2CtkOLjhKLiWVfVWwt7fTXNB6ptiN/jUCXnb70991pV953Hk2Jdn4XmCuG3JCeZQtRU6Us/DB2n6K1pi0vcV135olfOBztbQh/WE5BDRXomfiEZsxvjwTaQEoTkmkVF0t9Px1L2oLLtFWJUibKbwJEH3QMHRIq+XxKoUV5lXBJOJCFCNLdiIfgNZLpwqORUpTSZUxMNbRfOqEXEnHO8KJOWJpDMhoXO+sA2oc262JbFW1TJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:02:14 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:02:14 +0000
Message-ID: <6d8ac0cf-b954-4c12-8b5b-e172c850e529@intel.com>
Date: Tue, 9 Jul 2024 10:02:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] ice: Adjust over allocation of memory in
 ice_sched_add_root_node() and ice_sched_add_node()
To: Aleksandr Mishin <amishin@t-argos.ru>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240708182736.8514-1-amishin@t-argos.ru>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240708182736.8514-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0076.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f091ca-f0ec-4706-96f4-08dc9fed718c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEJUbGN6ejhPVllHNlpQWlhCM2tLTm1CODl0RUVjZHFxemliRGJXYlFQeGNP?=
 =?utf-8?B?bUl3cEhPV0tVVTNmdms0aEorN0djWS9RZktoNlNvU2Y0VnIwSUJNZ3E0a1dJ?=
 =?utf-8?B?ZGFoRUJTWW9GWXJSUzFUUGxaT1BWaTI2K0NaQlR6Zit1YkZmeTVTSHlvVjJW?=
 =?utf-8?B?ZS8yb3Z4NkhoV1FGNFhrenljb3dIR251U0FCUHdidjQ4VHFjRUZrak9pbWE5?=
 =?utf-8?B?aFRQUm1TaWJDSEFVWmEvZGJpYWR6VG0wK3N6RktxUVE4ZnA0K200QVBqeTJ2?=
 =?utf-8?B?VTNJYm41YnVCWlBOWmlJWm55bS9QQUhhYUc0TE5hWDBDWEhVLzJQaVRTMm40?=
 =?utf-8?B?RHZDa1VNRlFFbERHaldzcW1QTUM0Wlg2U05vekd6VEpnWG0yV0xWTEgzZDBx?=
 =?utf-8?B?MmdXQmg1cTFyUjFBMTd3aFpJYkxxNkYyaFYycVBKd01JNVdBKzJLMHJTaExn?=
 =?utf-8?B?WkdsbTFNcnF5UGNLTC92cHhaSWM2V1hHRW1IYkYyeG1Yc2hxMW9tTXMvc2ZX?=
 =?utf-8?B?R21mTXZDWGlraGxueURsZE0xaVkzMUhYM2ZpQTN3bFZBb09TVnFyMEhTaUUz?=
 =?utf-8?B?bk9DU213UmVpek5RTE9jbHVVY01IN05oYnJGU01jbmZqNmNqa0dzSjZoNmZk?=
 =?utf-8?B?MndzbjJqbjNLaDhKVGc3eWtkQ0hCTCtzeGQ2bjFPdnRCT1JOcXM5b3Q2aWha?=
 =?utf-8?B?Nzk4RkpGWXlxdkRxZERHWDQvbU9sSVduYTFFN2pVa3RQVHlwcUFLYU9udlYx?=
 =?utf-8?B?VHFCdHJiVmt1RXNjTkYzdW9HaFY4cTI0SHVZTUg1emhaV3hjTzlGS2FrNVVD?=
 =?utf-8?B?VnZXK3FyRWZEUkxBeU55KzVhNWpRd1NPMXJxOStVR0d5NldkcXlwZE0wbmNp?=
 =?utf-8?B?VGNtQ3Z6R2RCeGZNOXJYRnVZcUEvSndtRHZOdWhKejNxZExsSldUWkw2QnpI?=
 =?utf-8?B?SVB1UDgraEU1eGlWMlhUb0p0NTFKa1h5REg0N0JSRWlqVHJFdkRVaUtldity?=
 =?utf-8?B?cjFuNkY1RzFrTnhGdXk3N2hwL2xGMXF2M0dWTy9pQmFZYjN0ZW51d0RTQ1Jj?=
 =?utf-8?B?UzYwMFNMRXlsUGlCT0tzczFHWHcrK3pzN1h5N1dDbURBUWpEMHZ5eEh6SVht?=
 =?utf-8?B?VElyOGFXcFZGZW83RGNQRFdmNi83K3h5RGVXdHgyeDJWS0pCQWdLWFRYU3lX?=
 =?utf-8?B?TU1aZ0NZK0M5cVJ1QWNIRkdsblZWMlNlOE9Tc2NwOGU0bDRycHRtOGxhZ3pZ?=
 =?utf-8?B?Mk9tbHZ3eS9veko0UU9zcXZBVmxJK1RuM1hhemc0Y0xydGtQaS9Gak5qYUVD?=
 =?utf-8?B?RG1CUzZML0tZK3Y3MDhmcERISWZmdEY1b0xWM1B3elg5MHpXRUhPV1dTOHZX?=
 =?utf-8?B?UGZycWU5NUpyTlk4TjgyQVBJc1JlaFZzNTFGaStkdDcySk9rdTFWdFh0T0V5?=
 =?utf-8?B?SnNKZ1BIUjg1eDZtajk2RmVJdGVJSmQ4RUR3OEgwK1FudlRTb3R5NjhqZXBp?=
 =?utf-8?B?STZtZEJPL1hFK3NuVW8rVkhwd0xjWGpPeVB4Umh5ZS94Mms0MXhyV0lLVk5I?=
 =?utf-8?B?T1ZVSy95S1Vid20xWGdhU3J0dWduNnhsbk1qWnVjNFdFUFVwSFBUU0U1LzJB?=
 =?utf-8?B?ZC9saitxdE12VGFPWE5jY0ozVWZHK0VBeXBNMUU5bGsveC91OExCbjZZc294?=
 =?utf-8?B?Vk5kcXJZMjZXUHp2eTJJWnYxNk5nRkZhcGFVemxncFdOb2FKMWtSWTJDQWtr?=
 =?utf-8?Q?DYOJz7QK9ZWoObE3WEVhA9ernejXLw/BfIush2m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJmang3K3dlckNsRFdTMFFkVVhOQjM1NWJFS0U2a0R1bDNESFJKMnNRV2Jh?=
 =?utf-8?B?UWM4aFhiTmN5YXE3TmtlM3A5T1lDZFlUOWJtWUwydStQYzFtR0JFVEJEQmts?=
 =?utf-8?B?UUFIL3dUVHg0aEwzYmpwSlh4YlpScVBJUUJGN2VjRzc1enViTkJrSkRxZGVi?=
 =?utf-8?B?TUJTU2dveDNUdVJha2dWVFlHaTJPOWx2NUZOWGZQT1JkTzRuZ1c0VzdtU011?=
 =?utf-8?B?a01JcGIzakdmbmtyai9nN1pmOXM4WjJRdWFsNDR4S2JlMkRyUTNPbzBzOHJN?=
 =?utf-8?B?eTRSUitDbUF2aDJVbnlRT3NqZ1dReC9jRjVxUlBzU1prTFA3NnhESytvUVJL?=
 =?utf-8?B?dWt2VE1WSTFWbEhLZGNDWUJ2UUh0a2VJeXh4VnE4d1lLTUJOSXRoWmUrWVp2?=
 =?utf-8?B?VDdmRzl5eXNXVktNdnlyUTZQT2RoOVl3N2Q5VzNCY2FRSzlIVlJHVnVzeWx4?=
 =?utf-8?B?Tlp5aUNhaHFDTlVSUDRudk1aR1ZNOWZ2RHIyN2VZMFdZUXFwcXBENElOdmxI?=
 =?utf-8?B?KytiZ1lnQXRVcTZzVmJESzgrTndIeVpnSzV2S3dxZWNjZUFja3ZiQWkwYndF?=
 =?utf-8?B?d0ZpTk1COU03bGliaWRqT3VGV053WFk4TWJRVXkzVHcxRHZMYXBSZVdNUzFQ?=
 =?utf-8?B?b1pSRW5nM2ZwV0k4eGQ0NDc4Nm9qdm1qM05va3VUMUszdGNZSXlhcDh0T1Jq?=
 =?utf-8?B?OUZWa3NBUkQrUjFPT3JtaTg4eG95ajBYSDM4dDNmYTF3ekJSck9BaGl2ck5w?=
 =?utf-8?B?bWIyWnBGQmlvOXJyM2RqOWt2emdOUzcvWWNTK2ZQc0ZuNW9mVlYzU2ZuY29j?=
 =?utf-8?B?Q3VTT0I3V1prSWZZMHo3TlYyNGV6VjNDbEFFOFJLYjQvN2N2bVAvUC9CSjhO?=
 =?utf-8?B?S3RYM3NmUVJJcit1ZXc2OHJDamc2WWFBOHBFMGhIYXdFcXZUNzNjRTJpR3dw?=
 =?utf-8?B?NW9BNlNHbVI1ZmZCSUVEUFlaY2x0T1ZWbzB2RlpyaDhId2Q4aVpMZHlJWWlF?=
 =?utf-8?B?REVxamU5TVNHaTc0NG1TbmlLSHVXT3hJa1RaV3JlN0o3WUZLMSt4cGVKUHFv?=
 =?utf-8?B?dStHakJab1NwNmNFS2FrQ1htRUpmM2c0dTU2eklVb1hKNGtXZXkvYjRZNlA2?=
 =?utf-8?B?bzJpT3pHZFc4UitDc1pVYWV4bG9mb3I5S09Gd1RXK2FKUy9qM0t5Vk8vaHdG?=
 =?utf-8?B?MGJPaE1rRnhnbTR1SWtvaHUvS0xENzhjNkc2Z010WG9vTENXaTZQckIyNk1z?=
 =?utf-8?B?SEZ0OFFiNnNua3NZWlVGRU4rZXdjb1lDL21Za3lGK3hhMjUzTDc1VG9DUk40?=
 =?utf-8?B?b0tlWVZ3TWFiZ1ZseXU2MFVaZVBNWjFHbDFEYW1BZEZLRnAvRG84dHB3S1Vs?=
 =?utf-8?B?QVo2N1pzcThIck5YWncyQUF1K0U5aVZOa05RS2pHZFltNFZHUmZsQXpjWmlH?=
 =?utf-8?B?NnJTdjZTaldIblJuSlZ2dTRWcm9WWmZ4SERnVHM0TGxZdWlQMlZHTTl1VlV6?=
 =?utf-8?B?QnpmTXIxeGk4WE1hL3FYTGtxLzRoa1FsQktJL3kxNjg4aDZnaFNaZHorcVNI?=
 =?utf-8?B?Um5IdGtlekthWFN0TlY0QktKUEZJRDFNUjZIc0xtOVM2SlliV21nTjlieVVr?=
 =?utf-8?B?MUhVbTdkTEUzczBKYVpCMlRXUFhlem9QK1lqQnJaVWJQUGZ6aVV1bjBKdVh6?=
 =?utf-8?B?RTdtNDBmbHhwVUExVGJZMnlEOUV4L1B5M1RTT3l0OXJyRG5sWlR1Y2VXU3M2?=
 =?utf-8?B?VU9OWDNmOHlMNWFTSjBLTGNwOG5yNXFnYkxHZU5sd3AzbjNMeEQ0T25GTDhv?=
 =?utf-8?B?aDYzOWxWd015SkpuUksrR1NjRlJUNFhDTkhlKzg4RlNqS1Q0T2RSQVV3djdu?=
 =?utf-8?B?QVlycmxybnZaS3BIMHZsUVNzaUM4WUVabUcrV1lQQTkxUG1QVVhhelRFNUpN?=
 =?utf-8?B?czhsZUhnVnlHSGxZaWVmZ1duT211RE5MUFJlaUEyNVpoK3Q5SGs0UGY2Rnpp?=
 =?utf-8?B?U0wxY3RlNTNqdE9DOFJ1WTZVYTNmU1JML0xZa29kZXV5QWN1eE9INWFySVpv?=
 =?utf-8?B?VnloRG4weVdEOGlQQWJTY2RZaTRPRndaS3EzbEQ3N0h6WlhURFowb2dldGRN?=
 =?utf-8?B?SFhNMFBDYUFIemRFQStFQ0REUGZWaUhJK1Y5eERwakRtRGJpaWI5czRlbVVO?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f091ca-f0ec-4706-96f4-08dc9fed718c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:02:14.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aaVq1hq+5UQ8P8gnrgC4/1VPo8AH5WEF8LFibhLQvFEt1KMi9jM2bQY3D9iiZfFghNMqXaYmqTlvEAmRRdZGel8L/tnf9eVEKS4O7wV7nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6679
X-OriginatorOrg: intel.com

On 7/8/24 20:27, Aleksandr Mishin wrote:
> In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
> devm_kcalloc() in order to allocate memory for array of pointers to
> 'ice_sched_node' structure. But incorrect types are used as sizeof()
> arguments in these calls (structures instead of pointers) which leads to
> over allocation of memory.
> 
> Adjust over allocation of memory by correcting types in devm_kcalloc()
> sizeof() arguments.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Suggested-by tag is for when the Suggester is the raison d'etre of the
commit, not just improved it via review.
Here there is no need for this tag.

As an example:
We don't like the current state with the abuse of devm_ family of
allocations in the ice driver, those are used in places where plain
kzalloc() will fit better.

With the previous paragraph you could go to review our driver and swap
devm_kzalloc() for kzalloc() in some cases, "proving" that this is
a correct change; and finally add my Suggested-by. You could've done
the same without the tag if you will instead assume that this suggestion
was too obvious or too broad or too trivial, but it is just an example:)

> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

I like the new code, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
> v3:
>    - Update comment and use the correct entities as suggested by Przemek
> v2: https://lore.kernel.org/all/20240706140518.9214-1-amishin@t-argos.ru/
>    - Update comment, remove 'Fixes' tag and change the tree from 'net' to
>      'net-next' as suggested by Simon
>      (https://lore.kernel.org/all/20240706095258.GB1481495@kernel.org/)
> v1: https://lore.kernel.org/all/20240705163620.12429-1-amishin@t-argos.ru/
> 
>   drivers/net/ethernet/intel/ice/ice_sched.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
> index ecf8f5d60292..6ca13c5dcb14 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
> @@ -28,9 +28,8 @@ ice_sched_add_root_node(struct ice_port_info *pi,
>   	if (!root)
>   		return -ENOMEM;
>   
> -	/* coverity[suspicious_sizeof] */
>   	root->children = devm_kcalloc(ice_hw_to_dev(hw), hw->max_children[0],
> -				      sizeof(*root), GFP_KERNEL);
> +				      sizeof(*root->children), GFP_KERNEL);
>   	if (!root->children) {
>   		devm_kfree(ice_hw_to_dev(hw), root);
>   		return -ENOMEM;
> @@ -186,10 +185,9 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
>   	if (!node)
>   		return -ENOMEM;
>   	if (hw->max_children[layer]) {
> -		/* coverity[suspicious_sizeof] */
>   		node->children = devm_kcalloc(ice_hw_to_dev(hw),
>   					      hw->max_children[layer],
> -					      sizeof(*node), GFP_KERNEL);
> +					      sizeof(*node->children), GFP_KERNEL);
>   		if (!node->children) {
>   			devm_kfree(ice_hw_to_dev(hw), node);
>   			return -ENOMEM;


