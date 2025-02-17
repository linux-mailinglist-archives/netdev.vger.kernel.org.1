Return-Path: <netdev+bounces-167001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90DA3846A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FD21637FD
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C19B218821;
	Mon, 17 Feb 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fZKUi2w0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4C5C603;
	Mon, 17 Feb 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798327; cv=fail; b=q2NR+tSrp+oPY+YprOG4YkH4xfBViTjU6T/ZwLFsrVxKUSnqRG/3nGvFNr+uCRGjyjMZ9Au9ZckEALhl3t5JMfJEhVDz0OR5F5kDorylRVGl9gdN/ilQhfYUzEaUB7JOohMDSbmkH8qiCSxPc04k4PqOZeWx+87EzHrw8OlU6Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798327; c=relaxed/simple;
	bh=Wmgh1GX0y0NHFoYQncgOwS8DpbpGiJD+hXPMrVjjSb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PzD3SEniztlqHqGBwNrmSQvcKimvOE0pbie5T/nfMkMMyv0FwSBz9AllqjOrd/RyMn+7frZ+f3/PDNh25srJ0XSOFwakT7Mrb2tXrLw00cPGUOL9GLg8xr4cvrBJNS9722QvwRIfC6ujSi6XoTwFHo2nGBhdJuXzuTiD/mRLNhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fZKUi2w0; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZKERZ00FvebEW78iFwd16oCVRd4pSkYMLDCkAci1DdI+aUoE1oFa69DuK+KBaSW3luViJTeRe0FYBrl/jcge/xjzBjaG5sFccr2kxxQoztyTXnzj3oATgzcVaLHcM4IFO8SVqINxxF4BHkrgpZLsQ8qU6VWHKQihDeOY/cN8EmvDKFCdMdEnY27eJmoSazyW6Y3IG3k49LzJzdxQL38xagaKhwXJ3jJNrEPt3QBrERkQ89PLfyWDvgYPYRfxrCzAsNTqP047PcQVKyR3NREsO7hlpodgbvrFHuJCOsiBvfxVZYlDaYbVxAhoGctJ4yxAL12WRBQsM1PJkfzQL6tsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGj7fXIgsAlHDkAn4/E9O8JJaRRIINVfWCwxfMpe8NE=;
 b=nbh4DGgHjVwjnXO/f67Z1oT3ZgohzGeVb1fme7EraY/chENdP4qCJXTihPJxVll2dkUo2W8hGGHVWizKNPB59FJdKg3lOHiN2ZEZnQN7wGxKCiLsIYacm9QfF8eLCXjJS9kydWhZP+soqeYsw+h7zZbqvqg6GEaPLW54pZ7apj65IaRuGDrdFKY0GqS92fZ/36pjW5PrYJMIeibeMm4Y6fSnLLirUnoM7ISjIuPSrPP8shPQzZ/yIT9UxA+LDzf/GEykrixo/LS0S0OCBvR5KCh9iV5PgIOVaX7dK5Ti8N9pvHYyOBrtPn1oYWYYXMNIuUFbYicNvTgiNAZFHyBgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGj7fXIgsAlHDkAn4/E9O8JJaRRIINVfWCwxfMpe8NE=;
 b=fZKUi2w0zkpAg5JqKTudZ35GjUIW8ylfubyq3ZnR+vkXch15cn8ByU+VxaCiXfpIsX+Wz+YuAQmJ479GJEONR0cogxLTxKkfHjPOu7QhtTHbgqjqYBvbJ88gJUPRRxykogxoHxGlK23rCgaFFpYLlm20Mp41TaiK7KyhkN6I7LQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:18:43 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:18:43 +0000
Message-ID: <c3fffeca-cecc-486c-817d-9232061c3a0b@amd.com>
Date: Mon, 17 Feb 2025 13:18:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/26] cxl: move register/capability check to driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-5-alucerop@amd.com>
 <20250214172150.0000136c@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250214172150.0000136c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JNAP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::13)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a399b6-9a12-4631-7798-08dd4f559a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWhaRC94MTh3cjlYanNqVUF1bitVUjdEMXQwbDcyWDBXTUJQRmZQbXlLa2lO?=
 =?utf-8?B?L3dZOHg4SlRRRlczUFNXeTVlSC95S2crOGNEb3NjKzV3UHhKSVJ3LzdRZjdw?=
 =?utf-8?B?aFNtRlY4TXNLc0pIZ0NoNlprTHQ0T3pGSUxRMGwyYTZBOGw3ZWZFMHQzamx4?=
 =?utf-8?B?Z045R284cXB2bGRYUWR6dkRtK25oSmN1bmM4T3djUzYvam4vWnR3YVR1Wm9o?=
 =?utf-8?B?Y2p3aUJJUDU5K0d5RlV2WFk4eHRRVDd5NUYxMmFzWXhTSStTL2ZTUEVsdExW?=
 =?utf-8?B?bzU4S01vQ2hrNHdUN0FKSkNxQ3BNc1FCeERTR2NhTDZRSW04ZGxLSmxUOE9E?=
 =?utf-8?B?dDJlcjBLRUc5RzBwMThocnk0ZzNMeUkzd2RTZ2Q4bW9rRkR1a2hKMTRpc1dT?=
 =?utf-8?B?RlNnVzhVbFU0YndGdkJsTE5XRUpDWnNLcE5ONkJNUVBMVTN2aFdwOTJxN1Qv?=
 =?utf-8?B?c1U2K0taOG1GTSsyNGNDUHNDZmIydHBudXVLYWw1MTRDeEFMOUEzMkZHME8w?=
 =?utf-8?B?Sy9OS1R5eEloOXpsR3BjNVdSakdRdTl1dW5RdHJHYU5DSnVBcXVPWmh3TmMw?=
 =?utf-8?B?NG9yTitqaWU4ckZYd2VMTjRSSlZpU1JhYkRJbEdtZHBuT2RNOEtqeHJwZE1C?=
 =?utf-8?B?ZmhtVkE0UmM5SzRiWTEwWUhoMXFnSUdLOFZZNEVWNHZlVlNnOEYzMm9OdW4v?=
 =?utf-8?B?cnJ0MUtmSkVSWGl0ZXFHeDNhVTMrY3ZiVHFJSlNXcFBTa2ZscE1DYSt6N2w1?=
 =?utf-8?B?SEhLUE05NklpVFZhdUhqcHh5VGNVZXY3M25vUVVrVTNiQ1Bvc3F4ZE9LVVp0?=
 =?utf-8?B?YUpHRExKa3dsZGU2c3ZuZkk2QnQ1d0dBa1hBYTlWQ0hDeUpRY04vSXRlQklM?=
 =?utf-8?B?VjB1ZjB5UHM5MnBrbmtCRC9CWm8zRzJ4YW41TVhnaFdFK1VDdldnNDI3RnE4?=
 =?utf-8?B?ZWtNUEdTb3NZWlhhNE9KSkJJejVvb3A2RmlMQ2Jtbm92YjdPTnZMMTE4R01V?=
 =?utf-8?B?azFWdytiTVpCOGpQMk1PRkJDcGhvRzFFci8zUC9BSVdIZGJ6NDhaQ2Jjb0lw?=
 =?utf-8?B?MDIvMGxIVDZMZVltS1JsdUlqeFN0RUJPL3p0allsM1llODFIai82azZnN2Jx?=
 =?utf-8?B?b1MxaUpuSVk2Wm1xL1ZwZzdxdTJRMXBNbERCWWU0YXZjWXpLR21ldDJsblA5?=
 =?utf-8?B?U1NiT3hqREw3SVQyU29FMkhSeEFKMXpLUnhjbU1SMTR1ZGlkaFBHUVcvcy94?=
 =?utf-8?B?djlJWnRvT3dodmRpR3BUek55T0QyUDdKNm1CaEg3YUp1aGh3Rk1OU250eGh1?=
 =?utf-8?B?M1JOZTlCbkszQ1JydkxyaDQvdDhnZ3JBTTFNTUhueXlYK3I4VEJmOWt5U3NP?=
 =?utf-8?B?Uy9XQUpzN2lvREtBSlZVRjBuaDdRbitHRENITWVubHN2alZvUlAzK24yR05t?=
 =?utf-8?B?d3BoaDZBZ2FxdFB3cEZOdFU2aEQrSmx3QXh4SzFHeSsvUEdLeG85azhmcndM?=
 =?utf-8?B?dXlkMzZRWjlDbWd4cDFEYW5mMHUvSE0vWlpnQ3JCRFFWOGU0ZXBJTFFZSWFm?=
 =?utf-8?B?VHhySFBORnNUYlVDVE1FbGVTKzN6OFcxM3NJRkQ3RThpWEtjTzNVbGJNWHF5?=
 =?utf-8?B?bTY0b0d2ZHdSVHRKajExdE42d0FNbmVFSk1Uc3ZRcG5GZjlCaVdEdWQ4SVlL?=
 =?utf-8?B?OE01eXpLNXlEMXdIRXU1b3BDUkRWUTZQcVNCNHVCcm5VNWp2SW5mR2dPWlUy?=
 =?utf-8?B?VGdhQzFjSG1meVNtWkhHMjFibUlYY1ByUFJzTXM2dk1uTURXRGlobzNzVy80?=
 =?utf-8?B?TmdGbVNxVkE4dURUSGZ6MWwrS3pKeXJJVHY4ZWV2RUgzeCtNY1FrS3Ivc3Fq?=
 =?utf-8?Q?PtbuE7NBvdekT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZzcllNemdmWllhMU92YnZVNWxSbzZTNmk5SzBXdGV4K2wvaVB2eHNPYVlF?=
 =?utf-8?B?K1hJVHcyZjk0dDJxVkYwcGhlMGNmK1FoL3NWcUU4cHhFd1JKQWs5d2NJcXdn?=
 =?utf-8?B?K1V0SFNwdEovL0o5SFpUZTFjdy96QU4vZ2xRUEZLRVNXMnYvd0J2cVJ1cXZ1?=
 =?utf-8?B?amd4bWg4VzBtMHNjNnB1MjJwRTMrZSt6RnlKWEw2dlRQQmVFU0daZUFSdkx6?=
 =?utf-8?B?d25wTzU1TkdLZEhpT3VpR2dBRHdXZEwyQzlrdkRNOWt6eFI3ZkQ1SnRUZW5L?=
 =?utf-8?B?M1Z5YkZhQytzd1UvUmkzbmJUUW1yYnkrUElyc0FUZU1Bd1ljV2ZlS2lBaG42?=
 =?utf-8?B?N0Zoa1N3QjUxVkRhUHh0MExyQ2dPdFdmcDJYKzd5VVgxQ01mWktVYkY1YjdQ?=
 =?utf-8?B?VG1JZUNTTUdDbjl5VUZQQXNMVmNQckllUFhFaTY0NzYycmZMeGVBUEhIZjEz?=
 =?utf-8?B?Ty9wSDNPN1BJcHIrZk5hVkIzY05nZTBHUXJIa05oQllPWFU4Vit1b0VkbTlu?=
 =?utf-8?B?YjdPdm5HaUlUc1JjQmsxazBDRmlPTW9qam80dE9NWEpoM3J3ZUNiMHZ0WmFn?=
 =?utf-8?B?ajNJSEFOM1VPYXdJSnBuTTZOakNxNHAyUzJuOGg0R1htWHJhdVM2eFFKbFNW?=
 =?utf-8?B?WDdyM0IvWUhJam04QkRrT0dlVUtqLzlwRE5jMzVKWXhyaEFxbm1tQWpXdUpv?=
 =?utf-8?B?aVVVU1J5WDhtVEFldUhJVS9vbDVUWlpDM0J2YTB3Ty9EeUtRMVJ0M05LUThL?=
 =?utf-8?B?eFhiS0pST2ZCTHJmc2dBbDdUZVlmMVZ6b2g2aG1SWEd1cnNsdUNOQXlQaDBz?=
 =?utf-8?B?S1BMVk9vMDFHc0ZwakdHYS95RHpFd1BYTFBnd25CRFdUY3hQMkI3azh3VURm?=
 =?utf-8?B?REFZc212S0NWMWUwNUxWTlBPa0ZTMjdRZmlTaWpQcm9ra2owQW84ZFU3cUNF?=
 =?utf-8?B?UElKUmV0a0cwR1I2OHk4UTBkUmlYbVlHdHFzYnhObGNQamdIRUF6Y0FnZlBu?=
 =?utf-8?B?M2t2c00zWWtDNFIzcmMvM3pVSmJUbXhWYUcxRVV1TTQwdVJuTG53akJ3czc5?=
 =?utf-8?B?cUhPVmFoZ1k3VGYvalk1NC8zTlFuSjNJbitHenJBRXZPYnJKZk9HQ2NqU2Zz?=
 =?utf-8?B?UVY2MEFRL3JuclJtaTlnaWNtaG53b1pWbm9WRVJBYUpmR0NxMXVyVWhHbm1L?=
 =?utf-8?B?eVNMRlg3MzRvY0dOVDIwanpFenRKME1vVkx4TVRpMTdldzBjMGdlNkV1aS9U?=
 =?utf-8?B?RVZab0N1SWp0NmdzbENkL0czVkdEcDRFN3kyMkw2ZW1ldEJPZnFUVnhPcXZP?=
 =?utf-8?B?NEVOODJIZ0tHMnJxU1REK1cyWFRMV3hTVjY5UkhEUi9LSzRXLzVnMkY4TGFq?=
 =?utf-8?B?b2JjVFFyUUswbVd2V3lvQXk5VTA3SUh2YkR1RXRnMnMzbVlTU1BUa3B2YUpU?=
 =?utf-8?B?dWtPWWkvSHJjbUNQeTk3bVFGU1FpSlh2V1lKL2xIcUxnNktsM3VOdkNiUFpC?=
 =?utf-8?B?TWRVeW5PaHZBOHlwUGZnbGdBT3M2V2ZhWlZQT1BWa2hjazZkSVlVSGFKc25I?=
 =?utf-8?B?MDF4UENaSUVtV2k1TEliUFNXckVRaWdYVmYvRXNwRmVuWUdFQUt6QW5pbm54?=
 =?utf-8?B?Yk14ZzFPT2dFSlUzSjlWM01JNTBiQURQbkFvRVFNRWFkN1FBbkVwSTkxN014?=
 =?utf-8?B?USt6bUhZcUptdjVodFBjYzhPZU1uSHhFUkJhSHNiTVlqV3EzaVpKZFJQVjlv?=
 =?utf-8?B?cGV3bDYzMW1YVFcyeXBlNHlBOEdlSW9lVWppMzl0WHhMdmhUcmkxL0UrM1F3?=
 =?utf-8?B?NnNnWWFZdU90ajR5aUJoL3F1NVJsRGZjc3k3cjlOS0QwTzNSRjl2c1p1Vnpo?=
 =?utf-8?B?OUE5bDJHbzV4WWpJRy9MVVN3c2hiaEpjOVhsdGM3OXJmakFLYzJOWkN4T0pi?=
 =?utf-8?B?cmxYaElmL2I0R3F4YWNWMGZXek0zVHdSYmpQUGhsVE1QZnVoQ0ZEeEVqMFp3?=
 =?utf-8?B?ZHh4eUZzblVRNUpxY0toVE9tRWYvaUxrREdGY00rbDlMMnhwRHN4djlMaHIy?=
 =?utf-8?B?RTNiNjhXM3pVUHliZkozQzRJZUNnbDkrT1liWU9sOENNVUhhYzUreU9TM0ZM?=
 =?utf-8?Q?cSvCj1AdZVL98bawP8NLkNRD9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a399b6-9a12-4631-7798-08dd4f559a1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:18:43.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayvDiXEelXEmtaTqht4Drj+pIrXbuBP004JNHfoNHTTJavH0MTkf/oX9Jj5y0ytE38/202KcUuhQbMyYl57HiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066


On 2/14/25 17:21, Jonathan Cameron wrote:
> On Wed, 5 Feb 2025 15:19:28 +0000
> alucerop@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 has some mandatory capabilities which are optional for Type2.
>>
>> In order to support same register/capability discovery code for both
>> types, avoid any assumption about what capabilities should be there, and
>> export the capabilities found for the caller doing the capabilities
>> check based on the expected ones.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> A few additional trivial comments.
> With that and missing docs tidied up seems fine to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>>   
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 722782b868ac..790d0520eaf4 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -5,6 +5,26 @@
>>   #define __CXL_H
>>   
>>   #include <linux/types.h>
>> +
>> +/* Capabilities as defined for:
> Nit. It's not networking code, so lets use the standard
> the rest of the kernel (more or less :) follows.
> /*
>   * Capabilities as defined for:


Sure.


>> + *
>> + *	Component Registers (Table 8-22 CXL 3.1 specification)
>> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
>> + *
>> + * and currently being used for kernel CXL support.
>> + */
>> +
>> +enum cxl_dev_cap {
>> +	/* capabilities from Component Registers */
>> +	CXL_DEV_CAP_RAS,
>> +	CXL_DEV_CAP_HDM,
>> +	/* capabilities from Device Registers */
>> +	CXL_DEV_CAP_DEV_STATUS,
>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>> +	CXL_DEV_CAP_MEMDEV,
>> +	CXL_MAX_CAPS,
>> +};
>> +
>>   /*
>>    * enum cxl_devtype - delineate type-2 from a generic type-3 device
>>    * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
>> @@ -22,5 +42,4 @@ enum cxl_devtype {
>>   struct device;
>>   struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>>   					   u16 dvsec, enum cxl_devtype type);
>> -
> Stray change.  Drop it or push to earlier patch so the line never existed.


Yes, I'll fix it.

Thanks


>>   #endif

