Return-Path: <netdev+bounces-119723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226B956B9A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65491C22251
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296BC166311;
	Mon, 19 Aug 2024 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZF7n4r0Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EF21DDC9;
	Mon, 19 Aug 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073336; cv=fail; b=S7wsfNXDLZYxxEr1FtvYgzvuZxw3/lPWUaiSdXzCYhJGR6hrrogpN+CArQQkzwpUuR0Gctsk5l8BgUbhPPpd40bwWMYty+0fHVeUSTmjNSUHJlUXEWB3Dmra07ifER1oJZbOg5EtpnMCAADe1o9mMvZCM9KiaVLZ7jjacaaIG+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073336; c=relaxed/simple;
	bh=oDPDUo3G0iVgVjVQQwdDoimYZRen4mbhC8PVberg7Ig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKxoU3gTd+CW0J/D2Yw9XOYjXCWVujv+GbemVt2GqyRgEZvzAnct/9ym1iDMnwclLSh5QKA5cRZl9pQVy5AHmHZIjI+grQEoXBHK4NIBElM0STu3mkir9nfOPj9kXb6UB981+qOyb486tgFYmpDWelCim139Sad+lmpvv1QKPy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZF7n4r0Z; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWqUuWCzLlreAaU4XTwn1CaKjMH7DlE4yst8Wd/Vl4lEVlZ6MhfsbHLmdxapMxRKkL6IVUzUDKWMgKf4Xe3OqqfBlUaWLnSwXDlIK4qU3U4ariNOEj03LxEemAoUS9wXxlgqGsgHqctGV9K0xlWCwlp3NMBnSKFpbzMG5Es35aHPaKg6yZJQehATFKlIZYEtTDKu0fgp+Ekcf5v3QGWSqyIAeerXZvuYN25TYg6dk/Wz7Cb9cnYrTMmHylhzn8Qh9kXDjgHtN4KZqxRfFonuMzg6WR6YF6J795TBTCqfb6Xx0FWEMUFaFl9ekK0pcb1+n1Ly/H5T1P2+nOp2Y0aJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCbGdctHuoxIbLmXQxaYHzDVz/7WyQuSe0JW2fBzlo8=;
 b=yNgNlkXkh8modqn67Ei+DAfhY+zRhmhjAnSySgyl5FOsl7aDWydf15BB7gvGa680iB3S1O1EU4qRdgcs+vp4AF1mNfuIe5oFg26YQVQKCXvB0jWdLc6OnAqYvfy34tgyXdbpVKf5qIfnnaMAtmkofHfnWqmQWHdOHP0f2Rh/muspjIpNEkU0NUbKX9ueuFzzQ4oz/M74EAUnxW0Y4HC5Jtj4GCItKxlOLF5U5norAGl2dUzqoFa0wDwe2nAczeV3aD0hyCK6nZ/lP0oyrHltGCmE1NXuNrYU/e5iy+4kPhkbzSbRJrUh344DqWbRpTc4SVTOM1Q0TqlUNVX2E5kpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCbGdctHuoxIbLmXQxaYHzDVz/7WyQuSe0JW2fBzlo8=;
 b=ZF7n4r0ZL7+nSLpqFJtJADM5qEQ1k1sy6QKlgLQy01CSbD3o099UPAK7SEmbOTusUThMEEGoNAdkcyK1hbqQZrlY9IdsLMeONXMcwpCA4SOaXICRrbb+DzGK+8taTzT+IQJ1bPyRmZERtHX252evIuUDbAwmzMgtr7hFY3QFXHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 13:15:28 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 13:15:28 +0000
Message-ID: <e597747e-17be-0f1a-8dbc-0682ec3522b2@amd.com>
Date: Mon, 19 Aug 2024 14:14:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com, targupta@nvidia.com, Vikram Sethi
 <vsethi@nvidia.com>, zhiwang@kernel.org
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
 <e3ea1b1a-8439-40c6-99bf-4151ecf4d04f@intel.com>
 <7dbcdb5d-3734-8e32-afdc-72d898126a0c@amd.com>
 <20240809132514.00003229.zhiw@nvidia.com>
 <2482b931-010f-30fe-14cb-2a483b0d8c38@amd.com>
 <20240818095515.00004a98.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240818095515.00004a98.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b5d4b3-5d14-4e3a-e5df-08dcc050fe83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUVsamxzdis0SUp4UlJGY3hlVXU2MGxEQmtleGdNbFRiRTloKzA5U2dvS0FN?=
 =?utf-8?B?VUduM09EN3lFTmZYMWF3ZHdiclNLdjlVYW9jWEcvMzZudHZMTzhLMzNHODAx?=
 =?utf-8?B?RUtEVWwrbFNCSmNoTlU3YyswWkk2UVBiZXN1YXBhYnZrcStuVDdyU1JHdG54?=
 =?utf-8?B?TnRnVFpkRDN3cFV0S204aWlmcHd2SVdEM2hTK3UvZHJHZk5OSGtKcnNoeXd0?=
 =?utf-8?B?bXMwb0FQVENhTFREeU1jeVFnWDUvcXh6MGFjZGlDOVA3ZVFmNEJaaDdsdDMy?=
 =?utf-8?B?cG1wWWFUOUZoNDIrVEZieXBLSEJVdnhpNkhHdmhYL0EwRnRDNHE1TVd4WDR5?=
 =?utf-8?B?T1lvSjRudS9MaElydDRYdFF6MWdHQjZ6b3E2YWJzSGhRdmdzSGs1aDA3WEc2?=
 =?utf-8?B?c2FLcmdUWXZHRWhwcTVSa1ZPbGZCTEdJT3pjekdCZFFDUzdXTXpuK2hiSmZt?=
 =?utf-8?B?RXRPWjBjUnZDcHQyYm13OCttdFpwSnRCRDVjaFJoNDVvYVU4YnFwZUxKQXc5?=
 =?utf-8?B?bFBhRU5lYzZFK0RHOEJLM0s4K0pheW9IcFpNcm9WRENLaHNFaTVITXhSTWpj?=
 =?utf-8?B?eDl1REJKZkxQaDBzekFoZmlRTzBEREtWbkRhVVJMMndySkxRalNRN3NiUEVZ?=
 =?utf-8?B?TTdKZ2E2UUVJZEd6MEFCSFhxZlVIRnNXWTJaY0U4a2NxZ3M3OXRmS3RCMGVo?=
 =?utf-8?B?cmRJT2NnNTBKdk9QcGw0TFlJMFBjdnRrWDdlKzJ4Y1JCdnQrb3ZPaXFLcFhy?=
 =?utf-8?B?M1ZnM1pFRGtoS0VNakVQQWJnUWIycFhYY1JydDJINlBYTFp2aFl6TU9rRk5K?=
 =?utf-8?B?SkxEVVRFOFpaTmlSTWphRnVYbGpuZ1VXaG1oK1VvOVRzemtudWxVYzJCb1dL?=
 =?utf-8?B?MWxpSENTMys5RVNLT1BVNVltQW9vbTd3NTBOZGpHMFQyam80ZjZNc0hhaUZR?=
 =?utf-8?B?NHc3WklMMjZ1cmswSnhOOVROcktiSTNZcG0vdHdXU09CejRFTy8zWXZLWGFZ?=
 =?utf-8?B?ZnJ0VzZJMHBkUEM2OFJTdTVhUC9ZajhJdXlKbklMQXByWDhYdm42V0RmOG42?=
 =?utf-8?B?UVdiWWRteEdYaEtWZlk1cXBwbW1Uc2dIKzB1QnRxY0tyMkNWQ09RVTZRb216?=
 =?utf-8?B?c1hJVEgzbkZ4eUEwTDlORkxIdy9PczZqLzV5TGlVbTRBbHdwWFZHZUJTTS9x?=
 =?utf-8?B?M1k5SXlKVHFGNXhrWTVZVmkrdkJITmhqbUdXa3BvbWprblZzWmRtUUZzempT?=
 =?utf-8?B?N05rMURtcFlRTjh1dnByVCt2QmZHY3ZzM2E0QktiR2FGd215a2F5N2M0cmxj?=
 =?utf-8?B?eW1BQ0k0NitKcy8zYnRhZUVzY1V2dHdZN0FHenhQbllvTEx1OVRmc01mVzRy?=
 =?utf-8?B?MlU2QUNhZnRWVU9OeVUyaTFVaUJzZk83Vml4WldhUVQ0YUt5d3RKZFlWVkNy?=
 =?utf-8?B?QUdyNmZjTUJyQmZkb0F1SE9DR1V4V0dPc1VzVXdoME93SEdjSG9YaHd1bGRC?=
 =?utf-8?B?WU90UlZHeXVpcEp6S3RlMTluRmtZNnVxekNJeFNlcWpmVkRkVXVhZjdHckhz?=
 =?utf-8?B?WVBUbU1wSnl2ZG9seDByYjlDVUtlM3VMVjhIckJGVGxCWjA0RWRYcHo4QkRJ?=
 =?utf-8?B?aFVKcFZaY29RWVJIalpnNnJMekUvcndNanZZZmZnL2MxTkdKbG9Qby9UT1Nj?=
 =?utf-8?B?SmlUTitzd2R3WEI5N1djVVFMZU1BQ1JOb3duQXZsYk43TWlkYUdpVDF3Y1VW?=
 =?utf-8?B?NGtHbnlpL3lmZ2xQcUIyazZ4VGdPbFRKaW1SQTJxUkRnRG44UERRQmJ5WGUy?=
 =?utf-8?B?RFB1WlZ1SjVMYVJpd3J6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG9XbG8zV3VEYVZHcUJmTmdTK0J1NTZlNElSRUUzcTZMRzNaSDFJYjdMNUN2?=
 =?utf-8?B?WU1SN2xkUnNTNDlPQTRuaFVvQ2VhSGFqN0NvZUlrMnFaMVFnVlJRSnNCY0w5?=
 =?utf-8?B?bTVNc1puUDlzVE5MTmFxRWJQL1I2R3FVSTJmenlnV3IyWHRrT01tbzRiTDgy?=
 =?utf-8?B?eFpOOGJHYWh0UEp4d29XSk9MOE56WTZ6VFNDTVEzYmRuS2wrRlRYMitZRFZC?=
 =?utf-8?B?Q3VJZ05MdWRod3RWN1U2RDltS3QyVnlBRVExRnQyTU1Vb0ZTYW1xRUhnb0pY?=
 =?utf-8?B?bHZnQXo4UWxPeXRyOFhpRkNPODZLWTJEQkxGVy9jSUZieWo4OEhpT0h1V1h0?=
 =?utf-8?B?RWM2TkxjQW1tSE5hV3ZLSGR6c2pQTThLUlhnWlJIRzJkK3NtQkZ6ZnFuaUFv?=
 =?utf-8?B?bm4xdFlnSGNQV3M5aS9rajBodkpyTURGMFluaWxOMmRKa0hneWlKVlpNUlhQ?=
 =?utf-8?B?QmVQM0RnWk5ueWJMZVBKL3ZyTkE5Nmx4SEkxeW9mU3dSOHpCcEZ1T054VUk5?=
 =?utf-8?B?Zk01QkI5TVNNeEwxenMybjR2aTk0aldKdGp3MmZUc3QrY1FQVW8zNFhaT3ZM?=
 =?utf-8?B?enRZVWlxY3o3UVV1RmRWaFFmOUU0RDViYkJJYURoOE5VMVhzNjNhQlQvbHg0?=
 =?utf-8?B?RkxmVDQ0SHhIb3RQa2x0MFZiNkNXYks0UXFKMWd0aUNWbFpBWmtqN3c0dDdm?=
 =?utf-8?B?SjR2Wm9QQzlJd1AwTUJQcS92dUNTS1pac2JhV1dEcklnM1o0YVZQajdDN0Ro?=
 =?utf-8?B?NGpOQXdxS1VHcEhCR1h5aGt1a3BMVjJuZWRaWis3b2ZrNFREOElhb2s5TWc4?=
 =?utf-8?B?TDcxNTVyYUUxYStBNHNGUmxseFhZWWFaN242S2RUaVZBeXl6MEpXY0pHOUtW?=
 =?utf-8?B?K0pGM05OWnhRNDR0eHZqaWoyY2d0NVpLd0tJVyt4RXpzVHQ3cXBXMHZrSTNq?=
 =?utf-8?B?VWladTFGSG91bElTMlRpanQ0OVUwVFdsdC9QTVVGUzNvRnVMSE9vK0JHbWU1?=
 =?utf-8?B?NDZFL3QwM01HUStvL0lJbnQ4K3RGQm0zaVdEbkNERGFNTXVRcVk3VGlDOTVw?=
 =?utf-8?B?eUc3emVnTW9ndnhtSXVTRFJieDVZZHdjbkJuNy8zUXBqbG9od0h0OHY3RDUx?=
 =?utf-8?B?ZlRtVXBWRWEwaU5HdzNDc2FORGRIV3VFcXRIT09QMUJzNmlURnl4UnFVMnFY?=
 =?utf-8?B?S3lFM3hTYm81U2RvUVg4aHlqcDFmK1N0ZW9qWXFsNGhESDcxanFwM0tLbHhn?=
 =?utf-8?B?a01ZdGtUbXRhNE1zR3pCSG9NaWFEN01VdHl1bEMrNnFKaG0ybDVPdjljQTJC?=
 =?utf-8?B?Z3FGN2ZpcnFWVGZ0eEpJdnd2SmJQZTByQzE0SzhqSXhZQjVuMFNOa1RXK2wy?=
 =?utf-8?B?VmFTQzNISzhMVit6OHE5OUI3Z2NFK0lxWENPWnVQMVNUU1kvaldEQk9CekdJ?=
 =?utf-8?B?K0lNdXZPb1NnZXpycHdubEtqeFhueWcxODdRWm9sT2pob0xERjJEQ3kxZTg4?=
 =?utf-8?B?VE5GeXphL3J6ZmM1U3E2cnFDKzgwZm1RT3pqSlBXKzlsdDIrMmIwZU56ZVZE?=
 =?utf-8?B?ZjI1b0NwQkFiUDJaRWpnWnd2dXFKY0Z4eDhxRlN1Sm9pd2VOMHU2T3V3SEp5?=
 =?utf-8?B?T21qL0ZwcCt0ajhrbk5mQ0lFZUx1Y1RvQjVPT21qL1ExQU0rQTFVVERPYWl2?=
 =?utf-8?B?VldWMUh3R3pqTDNRL3hOc2l5THpxWFkydTUrWEc1WEphKzVDTGtoc0czTmJr?=
 =?utf-8?B?WlZQdEYzYzRyR291TGRhNTFKakR2Zk9YVEh2NU5pbmlDd21MbldZRDQ1eWZl?=
 =?utf-8?B?WnF4NktLZ0F0Z25neUZYOWR6TzJSTEd4dHg1T2ovUVNMTSt2SmZPSlpFS29v?=
 =?utf-8?B?eWpyaXJoQlJVN2ZkNU9CV0pkS3pKUFV6SHlyOHlyaXhXbmVoa2kzUDEwWUR4?=
 =?utf-8?B?ZDFUeEZqeUdUUjQ1eWhKdjJGLzJKSUZUcHY3bGFOeHVuVGp0VktseFFocndP?=
 =?utf-8?B?WmloWUhLcURCUS9kK3ZmNVUxR1grNE5hNWJ4SFVBa3V5K3pJcnhpZ3pta0Y3?=
 =?utf-8?B?d3JFVS9LaUIzWG01RXBFMnVaM0dyeVZSc1B4ZWVpdUUzTzhRWGdBQTBYRmhM?=
 =?utf-8?Q?Z6gaaQBGtVaKjIcxH4xoyQWsF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b5d4b3-5d14-4e3a-e5df-08dcc050fe83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 13:15:28.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc1vLGhXwOWYiCma3p5mhAL+TO4k6nSi/e3M6asVRhfjjjsEzQS1myAmBLkifuavx6w5p00uczIHDaPkGErx0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561


On 8/18/24 07:55, Zhi Wang wrote:
> On Thu, 15 Aug 2024 16:37:21 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 8/9/24 11:25, Zhi Wang wrote:
>>> On Tue, 23 Jul 2024 14:43:24 +0100
>>> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>>>
>>>> On 7/19/24 20:01, Dave Jiang wrote:
>>>>>>     
>>>>>> -static int cxl_probe_regs(struct cxl_register_map *map)
>>>>>> +static int cxl_probe_regs(struct cxl_register_map *map, uint8_t
>>>>>> caps) {
>>>>>>     	struct cxl_component_reg_map *comp_map;
>>>>>>     	struct cxl_device_reg_map *dev_map;
>>>>>> @@ -437,11 +437,12 @@ static int cxl_probe_regs(struct
>>>>>> cxl_register_map *map) case CXL_REGLOC_RBI_MEMDEV:
>>>>>>     		dev_map = &map->device_map;
>>>>>>     		cxl_probe_device_regs(host, base, dev_map);
>>>>>> -		if (!dev_map->status.valid ||
>>>>>> !dev_map->mbox.valid ||
>>>>>> +		if (!dev_map->status.valid ||
>>>>>> +		    ((caps & CXL_DRIVER_CAP_MBOX) &&
>>>>>> !dev_map->mbox.valid) || !dev_map->memdev.valid) {
>>>>>>     			dev_err(host, "registers not found:
>>>>>> %s%s%s\n", !dev_map->status.valid ? "status " : "",
>>>>>> -				!dev_map->mbox.valid ? "mbox " :
>>>>>> "",
>>>>>> +				((caps & CXL_DRIVER_CAP_MBOX) &&
>>>>>> !dev_map->mbox.valid) ? "mbox " : "",
>>>>> According to the r3.1 8.2.8.2.1, the device status registers and
>>>>> the primary mailbox registers are both mandatory if regloc id=3
>>>>> block is found. So if the type2 device does not implement a
>>>>> mailbox then it shouldn't be calling cxl_pci_setup_regs(pdev,
>>>>> CXL_REGLOC_RBI_MEMDEV, &map) to begin with from the driver init
>>>>> right? If the type2 device defines a regblock with id=3 but
>>>>> without a mailbox, then isn't that a spec violation?
>>>>>
>>>>> DJ
>>>> Right. The code needs to support the possibility of a Type2 having
>>>> a mailbox, and if it is not supported, the rest of the dvsec regs
>>>> initialization needs to be performed. This is not what the code
>>>> does now, so I'll fix this.
>>>>
>>>>
>>>> A wider explanation is, for the RFC I used a test driver based on
>>>> QEMU emulating a Type2 which had a CXL Device Register Interface
>>>> defined (03h) but not a CXL Device Capability with id 2 for the
>>>> primary mailbox register, breaking the spec as you spotted.
>>>>
>>>>
>>> Because SFC driver uses (the 8.2.8.5.1.1 Memory Device Status
>>> Register) to determine if the memory media is ready or not (in
>>> PATCH 6). That register should be in a regloc id=3 block.
>>
>> Right. Note patch 6 calls first cxl_await_media_ready and if it
>> returns error, what happens if the register is not found, it sets the
>> media ready field since it is required later on.
>>
>> Damn it! I realize the code is wrong because the manual setting is
>> based on no error. The testing has been a pain until recently with a
>> partial emulation, so I had to follow undesired development steps.
>> This is better now so v3 will fix some minor bugs like this one.
>>
>> I also realize in our case this first call is useless, so I plan to
>> remove it in next version.
>>
>> Thanks!
>>
> Hi Alejandro:
>
> No worries. Let's push forward. :)
>
> For a type-2, I think cxl_await_media_ready() still gives value on
> provide a type-2 vendor driver a generic core call to make sure the HDM
> region is ready to use. Because judging CXL_RANGE active & valid in
> CXL_RANGE_{1,2}_SIZE_LO can be useful to type-2.
>
> I think the problem of cxl_await_media_ready() is: it assumes the
> Memory Device Status Register is always present, which is true for
> type-3 but not always true for type-2. I think we need:
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a663e7566c48..0ba1cedfc0ba 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -203,6 +203,9 @@ int cxl_await_media_ready(struct cxl_dev_state
> *cxlds)
>                          return rc;
>          }
>
> +       if (!cxlds->regs.memdev)
> +               return 0;
> +
>          md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>          if (!CXLMDEV_READY(md_status))
>                  return -EIO;
>
> Then for the type-2 device, if it doesn't implement regloc=3, it can
> still call cxl_await_media_ready() to make sure the media is ready. For
> type-2 and type-3 which implements regloc=3, the check can continue.


In this case I think the driver should know if calling this function 
makes sense, apart from the code checking if the proper register does exist.


>
> I think SFC can use this as well, because according to the spec 8.1.3.8
> DVSEC CXL Range Registers:
>
> "The DVSEC CXL Range 1 register set must be implemented if
> Mem_Capable=1 in the DVSEC CXL Capability register. The DVSEC CXL Range
> 2 register set must be implemented if (Mem_Capable=1 and HDM_Count=10b
> in the DVSEC CXL Capability register)."


I have discussed this internally, and what you point to implies it is, 
as we understand it, only mandatory for memory devices what we are not. 
I guess this is an ambiguity in the specs but the fact is the current 
hardware design which will be part of the silicon coming has not such 
register implemented.

> So SFC should have this. With the change above maybe you don't need
> set_media_ready stuff in the later patch. Just simply call
> cxl_await_media_ready(), everything should be fine then.


The media_ready field inside cxl_dev_state needs to be set to true for 
avoiding later checks to preclude further initialization.

I could avoid this accessor as we have decided to not make cxl_dev_state 
opaque but in prevision of core cxl struct refactoring in the future, I 
think it is worth to keep the accessor.

Thanks


>
> Thanks,
> Zhi.
>
>>> According to the spec paste above, the device that has regloc block
>>> id=3 needs to have device status and mailbox.
>>>
>>> Curious, does the SFC device have to implement the mailbox in this
>>> case for spec compliance?
>>
>> I think It should, but no status register either in our case.
>>
>>
>>> Previously, I always think that "CXL Memory Device" == "CXL Type-3
>>> device" in the CXL spec.
>>>
>>> Now I am little bit confused if a type-2 device that supports
>>> cxl.mem == "CXL Memory Device" mentioned in the spec.
>>>
>>> If the answer == Y, then having regloc id ==3 and mailbox turn
>>> mandatory for a type-2 device that support cxl.mem for the spec
>>> compliance.
>>>
>>> If the answer == N, then a type-2 device can use approaches other
>>> than Memory Device Status Register to determine the readiness of
>>> the memory?
>>
>> Right again. Our device is not advertised as a Memory Device but as a
>> ethernet one, so we are not implementing those mandatory ones for a
>> memory device.
>>
>> Regarding the readiness of the CXL memory, I have been told this is
>> so once some initial negotiation is performed (I do not know the
>> details). That is the reason for setting this manually by our driver
>> and the accessor added.
>>
>>
>>> ZW
>>>
>>>> Thanks.
>>>>
>>>>

