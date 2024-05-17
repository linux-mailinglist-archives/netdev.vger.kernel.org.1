Return-Path: <netdev+bounces-96879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F478C81C0
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38952281F18
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442A179AB;
	Fri, 17 May 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cx3jiYnY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F0224D6
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932154; cv=fail; b=BvSd5zBwpa1exJxsxx4pH9Srv1No7Zqpqrqpllul1WYs5URMU8rKmql7XU+tFjpC35zFbaIevLZQCS7kiBswetyW5VJsFITUVmdFnlUCgLJrnV4sZrfEpFS/pCduL+FVtIAVV+BUXN2BgpNTrIW8Z+mtAR1lwXkDhsUZR1b6zfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932154; c=relaxed/simple;
	bh=p1krMm7zmqj/4EWYo6/sZ3rHpoNKlDQT4QbcjwjuJvI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KAPi9BJj4WPSzDZ4xPMXRHtzJBgHt1pL0NpviB0IzCiKZSpC+Ow4T72beFvJ6WSeOLHtEbE93YT1IRWHJldgFykWRlsmYgpj+Kc8/wJGUBmZRNE0zOLrb1H7A5afR/ofFvwgZVe0uejBuweWoq308DDQ+7MY/Gn3+3LoFnDHVJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cx3jiYnY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715932153; x=1747468153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p1krMm7zmqj/4EWYo6/sZ3rHpoNKlDQT4QbcjwjuJvI=;
  b=cx3jiYnYlBWEQbc+KSG5YC9+GuPUF0R2RyMfDNXSNdjPljVbpGkL7Tc5
   N/6YTFUVFRsNgAYXIcSDBCSWqplrIoyqeu1qbAlvx0D0YZjpoHuipqj5H
   GqRyx5ig1u11uBA8PGlfaVN/cBWfqfrMBR2YviMnNcigySr12RmAEPbwt
   shZLDUd1Bx8FuUfrRJnyyRMogpZbUMdEotVEfWputfyUkoVPwMNrvSoom
   EnYRCaeyf24a7U3rXOh6GHlk4AX8/UBu7FbJw22vKSm7g68tSGQAwslV4
   qODvLZibgH/sBGjoEuMh4vUIMMxlwJd1O+it54jqG9ZkPqTacZeJXeITH
   A==;
X-CSE-ConnectionGUID: QSCSQ/+lTCel28/qFM6TPQ==
X-CSE-MsgGUID: u+QTJUAQQXOXMv1HS+7WrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22672187"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22672187"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 00:49:12 -0700
X-CSE-ConnectionGUID: C42xw/gRQPSB/jWzUTx8+g==
X-CSE-MsgGUID: auLFd0FWSaSyColoLjdRag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="54922064"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 00:49:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 00:49:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 00:49:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 00:49:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 00:49:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6KuuyxgtZiHIpclDUJiuzvV6e7/iW5LnO9E4rsrfcAERmfPi76hHODxq//F3z8clveqG06Zh08cyGkUTFJg8zfK2t3D9GDkEoxR1L6JNcK7LJLMHEKxRCgjsRn/BnCMwtiOTS5UDtQof1+GYqhDrZtHx8bxoSbvo8bJcUS5KS57KPt7k76asVtN+GcypGl5yD/YFCyGeMCgFcG3TCQCkvaKOtZG1UCgl9U6sE5F12Xm5wRnbgIn85OcozAOz6rRZjzZErjZNuZICA27ezt5osAxQk6b6jUdSxGcamG68GnlkOygaYkgWoK04suDZjMjr1ifUcEF9c7VTkSxhQWQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGpEe0Jah2Gh0YP3pngFTfaKs5P4oyTTa1gkx4Mhhgk=;
 b=VjxiQFOB4WMvurkBrmBAHWYYMsKqE+2ZL4tKxPmH2Vmp209QDhpZUlkPLF7xaaWwovTb3nRLfoBsdbdFgaFJJzCU91WFKH9DJCfBqPxgD+ZR4cv7e0vaKNJlBHqkdxu/A1JGXY6urngRIn/E3pc50psypPirEtLE96Zj0snxj1Wus5TOKZ7cxapcaPRmP/hKOkTl4X9rx04KJQuKTV2qJ6MUJyKL26LFYoJYIQ01B6MNYp6RdkCX6cCMSEWPvTudgH1zXkH+ycAyby59/aDW3DpITqcJaEVSct7r5oWRDJ7Jh4d+VDSfe3l3Y0VkbzFucNLYKq8qvhngZG01nTzgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 07:49:08 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 07:49:08 +0000
Message-ID: <eb7293ac-3674-4e89-a11d-a8b8fd470dcd@intel.com>
Date: Fri, 17 May 2024 09:49:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: implement AQ download pkg retry
To: Brett Creeley <bcreeley@amd.com>, <netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>
References: <20240516140426.60439-1-wojciech.drewek@intel.com>
 <342a9b10-97d7-4720-92ef-a548179b990f@amd.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <342a9b10-97d7-4720-92ef-a548179b990f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0021.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::33) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: b06ad4fd-6c53-4f67-bf42-08dc7645d564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDArSnk4blA5STNVc1RHN3lkVkNTLy9ZN05EeWRVT0FlL0g2dlFVOUZiM0pU?=
 =?utf-8?B?RG1FU0RHT0xIUVlvNEl6OGVteUladHMrck1MUEc4dEpITHpmWGEyS2lPTXBi?=
 =?utf-8?B?VmdOVEVUZnAxRWkrbTBHekVhendyY2svcHlRTnlERWRoQzhST1JiQ0xsUzA3?=
 =?utf-8?B?UDNHNW1seWFSVk8xNElvWmdhbC9tYXpock5OV2Rib0ZYV0x1TUhGVThoMTJZ?=
 =?utf-8?B?Q1E0cWZnM0ovS2h3enpTNEN4dUZJVzY0R1dJb3VLbVpzSUZtT2tkVlYzbWNW?=
 =?utf-8?B?UDk5a2RscW1icllqZWE1VDlHUTgycnVodkFGanB1ZnhjQVVLT1BoU09neEta?=
 =?utf-8?B?WldkSm0ya2hDWitXWnpxamNRTklqejhPY0grZ3hUa3BNd000K3pEUTJrR0ZL?=
 =?utf-8?B?eUIyZ05DVmowSzBGY3BBakJ2cmp2RnNmc3dFdWMzREp4NnVKK3FTNEtvcHds?=
 =?utf-8?B?RGRlTERHemZ2NGZObUNrdjNpeG10N1NEUVNFb1Jiak11aStneGplS0l3aVJX?=
 =?utf-8?B?YzdLNUg1UWpMdW9tdU5XVmdSNGUvU291UHFCQm1JMklUbm1kdVVFYmN4UVBH?=
 =?utf-8?B?dFVycWE3Z1hab2tvZU4xZ05hS3Y4d1N0d2ZMSG5WZ25EYlFZdWRXcHI0ZnlE?=
 =?utf-8?B?cDZNRjFKdnZxWlBrVkZLUUFmWGJyVHpJb0tKNDhHeDU4WG5ObnBHTXpxQXA3?=
 =?utf-8?B?VnhaZ1Fwb2dubDlIVVhPTmxvR1pVZ1pWTkRXcGpTdXNLT1dMQUZBMXFCZi9S?=
 =?utf-8?B?MG5PS3hSR0xzdWl4S2RNRGFiMnEweEl4K09ySHQ0QmZhcHFuUUxVMW1uaC8x?=
 =?utf-8?B?Mi8vV0VVTS9PSnpKQXI0cDUvSVhtdTFDL3dGMGdNU1Exa3VJN3ozSTBSRm0y?=
 =?utf-8?B?bUNwY04vOEhCeVhhRDFrSkFEeXlmakFmdVI3YmI1OWRZM1ZjZ3E1dUt5Q21o?=
 =?utf-8?B?ZW1iQ1NycTI2MUt5dm5SbXQ1bzVRdmJpUmtDalBPMWlMNDJtUWJsVGhRL1pt?=
 =?utf-8?B?ZE5CT1p0WjcyOTFueVhWMFlWaCtSTDlXMisvY2FjZ040OUk3Q1REWWZLY3JQ?=
 =?utf-8?B?dDk1d2lrSjd1ck5IMUw2T2xLZnJvamx2Y2c2ZXExRVNXTnpxVEUwZXFtTTVj?=
 =?utf-8?B?U0NtUjJhMjJ0Y1NYRlkya0pSMThPTFRsMkk3V25nNFpNYXNsM3M5Ri9BOVlR?=
 =?utf-8?B?QkxDNFNoWGtYSFYyL0NuaVl6VTdvVEkwMWl4NGZOcndLMEhLYlUzTThLbWE5?=
 =?utf-8?B?WUhDczlBZW9KUjg4Mm5Fa2J0cWl5ZlhaZ3c2QTQwdWtZSHJudkVyMU1ieThD?=
 =?utf-8?B?TGlBVGlqL3dGN3E2S0xQWTNwZnI2T2psUis2RkJOT0FvY1VRRDJWT2VxL0I3?=
 =?utf-8?B?V0txVHNicVZKWk01OHIwMzB1aGxDZmhobFlKUWsxNU9Xc0lOUWZNTVJDOG9v?=
 =?utf-8?B?RjZRNVBjRm1WaVVlb1ZZSXZKbEg5LzlrVlFpdjZYbGprNmRaeWg2Ly9tK2lt?=
 =?utf-8?B?cGpSbCtCZ0NrNi9ua2xrU3ZIcXZuRWZITStsMTZnQ3RyV0ZEbXpqVmFCMkJQ?=
 =?utf-8?B?VHdOS2piUlQvSVlvSW4yMkVISVRIMEJKK204Y09Va1JtK05Rd0RUR1VJTmY1?=
 =?utf-8?B?T0dxenA0NEFRWitkRS9lcmxZemh0eUh1S2VqczJoL1VySnVIaFdoTDF6aDlZ?=
 =?utf-8?B?TWxSNDN0MWNnNHJFU3M5QXNQVThpS2FaanNveW52QXRTYTZCa29uM1RnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lWVkVxUGl2RFRKa1dzczlMNjFBUklMK1R4RVY5Wml2K2ZieVN5ZTk5Nzl6?=
 =?utf-8?B?RFB1Z09xbTZNbVFvdlVxYlA4VXBBSGxUZlBOSG15ZE5aaEFPV1FxNjFrejNs?=
 =?utf-8?B?MEZTOFlGaElzQ2szWlNvMDAycEpZN0cxNmNWOGZZMTNQWUFNSHpkUUxmamdN?=
 =?utf-8?B?ZFRsUW9ZTFhlMGlIQjhFTzhmZGlCT0RodzA0MjI1OVZsRlU3aTNxanpQd2Nv?=
 =?utf-8?B?NEJpMldORS9ZWXdPdk5MUlp1czZINUQxZlpsZ3BLb2pWdTJKeS82UUZhbGdM?=
 =?utf-8?B?MkZ0TDBCMkN2MS9SSkdnRG1RdWpFOE1UWlRaTHZlK0hlNVd4MFd0NjV0SWQ4?=
 =?utf-8?B?bkdHbm5tWWdKd0tHK2J2c0hBcFVndmdVTGhYQ25mMnk4N21KcjlaSDNxUEdG?=
 =?utf-8?B?SFlDY3FjdVJIajhJbVo3U1YxMmM2VFV3SXJkU2dDYlltYVMvbkgzWnN2U2Q4?=
 =?utf-8?B?MnJVT2FSbVR2S0RaWWpHeW5ueWVGMEphVjhOUnluaC9oTHR2OGlscFM0T3pV?=
 =?utf-8?B?QjdFSG0wcEZXSnNXM3hpU2xKd05Da2xYdGpBUmRhcWJjL1V5eDkvZXVhSG5E?=
 =?utf-8?B?aDZlL2RhenhlM2FBekpUOHBvdjZxN1pFaDZqN090b0wxME1jTTVUZ3pBZ3p6?=
 =?utf-8?B?eUpHeXJWYmwwSFNYTnJpbkE0MWthMWdhckNYbjNhVFBwOStGMTJyVDRzWUtz?=
 =?utf-8?B?NXY5ZG9ObTZJMGs4YmQxSzl5U3R0ck81eWJTUWp4K3pUREs4NVJ2OFFMRlor?=
 =?utf-8?B?MUZxOHowOEI5bnRnS2c3czVKRXYycWxzeDdWZ3gySTdXejVEMHhMM3E0emFE?=
 =?utf-8?B?TUZLQ1c0U2pHWCtjaEVOdUh4c3FXOFFsRklKT3BpNEEwc21hbVBaWXBEaUJG?=
 =?utf-8?B?alM2dGRuNUlmbFVnV3RuUVlHSlFXL2E1UHBMTFVkR1NoeXIzZHdKQUE3dTJU?=
 =?utf-8?B?RDZzM21XbXVFdGZ4ejg1bnhUL3pJU1JDcnkxWXV5VUlZL3BWRHlOR1Erelhz?=
 =?utf-8?B?ZEdtZmY2anBycWd6dnM3d09yT2NLSXZsSkx2dFg5OW9ybEZReC9sRy9sL1ly?=
 =?utf-8?B?WkdnRURqWXk1ZnR0eG1ZSC8yNHBwY29RTlEvS1JmWGNVZU5kNktqZ3FDV0RS?=
 =?utf-8?B?M0UvbmlHSUVZY1piRFhPOXRMT0lPUkIvUXJpc2haYnBwd3k1UEJvd3RxYkhU?=
 =?utf-8?B?bTg1RDNlSm1DWEkrMXMwbUpmTDNiMUVXQnFHYzhxeEpmTnZPdGljeW5iVHlz?=
 =?utf-8?B?YURCQmNrNWdsZGdDTExya3JuaXoxaEpXRVl5QSswWjdkVC9XNHZVQ05ES2FZ?=
 =?utf-8?B?Ni8zTVNPTVduZWxwbHU5Q1pTZktvZlkyQ1o4Tk9oMGw0SFk3QXZYTENPVDdB?=
 =?utf-8?B?eFcrby9aNjZJNlcvMktJUjlpMDY2Tm9ZbkNPcXE1cVgrV3dhdGJSZ2pmb2N1?=
 =?utf-8?B?NDR4VEhBUW05UXBobEdRc2pBUitTL0t2WEttdjBuSFlsYy9oaUplSml0UDZ5?=
 =?utf-8?B?aElwc0dKZWtGR3RtNHU5REdNeE5iWCtyeE0zaENtcEMyaVYxcWluMDNTYnkv?=
 =?utf-8?B?T0NIS2Y0cmk2UXNSZk5ybVkwaTJYOU1ERTJKS1FTc1ozQ3dHZ0J3SEtrS3dR?=
 =?utf-8?B?WElwMi9YWnZXVFRZN0haSFZlSm9PalQrSERWSEJaemRyczFkWGFaTjA1MzBC?=
 =?utf-8?B?ZjBsT0F3RUdvc1cwSngrWDVKMEk4aktUZldxQ1gwaXBySXNVWldOZGpVTmFO?=
 =?utf-8?B?Y01RY2xpUnU5bnpUYmNPNHRmaGtHSFZyUE5aNDNyellUVWFHaVhTaTVqeEti?=
 =?utf-8?B?cjZnZkg4Tzc0aE54eUpHV3l0QTREZmMwczdQR0ZXdHRDRzV1NndRZ2IyYk9B?=
 =?utf-8?B?anBGbTZWVVU4VkxjTVZCajROcEVtemVDWHE3MnlIV0hGejdoa2s3ajFuL3Vx?=
 =?utf-8?B?WjlNNTVHNHpiUFR3R2RKRmYvMW1WcC9UQjlMYk9YdWkyUHVqY0FVbEltTnZm?=
 =?utf-8?B?cDdFTzFRNE5Mb0tzeCt1bHBaYXJFNlNMWmU0SWgyNEZBWDhGRmpTWE1yKzdh?=
 =?utf-8?B?TzVMa0ZVRHFod2ZuMEs3RnRYc08yaUVwUlQ3MVdaMmFDY0duTEdLZkcvNnpt?=
 =?utf-8?B?RHZUZGVDTnNKWXJlZmxhejZ1RDRxODlFRGpUM1BWU2lLMEJqbzZibDlSRDh5?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b06ad4fd-6c53-4f67-bf42-08dc7645d564
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 07:49:08.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6P6pIAoe+HfgPLFJCeTrU7sNYoUZGXiwe4wnajnDvVyBtdp88XvUGoi4Ns8sri/MyeZUy7v/9Gwo9TsYWJMze/yksG+ZaWBl2yF2Z7qbXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com



On 16.05.2024 18:36, Brett Creeley wrote:
> 
> 
> On 5/16/2024 7:04 AM, Wojciech Drewek wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
>> to FW issue. Fix this by retrying five times before moving to
>> Safe Mode.
>>
>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_ddp.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
>> index ce5034ed2b24..19e2111fcf08 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
>> @@ -1339,6 +1339,7 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
>>
>>          for (i = 0; i < count; i++) {
>>                  bool last = false;
>> +               int try_cnt = 0;
>>                  int status;
>>
>>                  bh = (struct ice_buf_hdr *)(bufs + start + i);
>> @@ -1346,8 +1347,22 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
>>                  if (indicate_last)
>>                          last = ice_is_last_download_buffer(bh, i, count);
>>
>> -               status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE, last,
>> -                                            &offset, &info, NULL);
>> +               while (try_cnt < 5) {
>> +                       status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
>> +                                                    last, &offset, &info,
>> +                                                    NULL);
>> +                       if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
>> +                           hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
> 
> Are these the only 2 sporadic errors that FW will return?

Yes, that's right. We don't want to retry in case of other errors since those might be valid.

> 
>> +                               break;
>> +
>> +                       try_cnt++;
>> +                       msleep(20);
>> +               }
>> +
>> +               if (try_cnt)
>> +                       dev_dbg(ice_hw_to_dev(hw),
>> +                               "ice_aq_download_pkg failed, number of retries: %d\n",
>> +                               try_cnt);
> 
> If try_cnt is non-zero it doesn't mean the last download failed, it just means one or more attempts to download failed right? Maybe just "ice_aq_download_pkg number of retries: %d" since the if (status) check below will print on failure?

Sounds reasonable, we want this log only because we want to know if we hit this sporadic failure.

> 
>>
>>                  /* Save AQ status from download package */
>>                  if (status) {
>> -- 
>> 2.40.1
>>
>>

