Return-Path: <netdev+bounces-215920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62941B30E85
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FDD7A31DC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC522A1E6;
	Fri, 22 Aug 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wz/C3T/z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459D23505F;
	Fri, 22 Aug 2025 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842876; cv=fail; b=ehnODh/R2d1lRPGryJ1/zkA7QT7jsYsMLokODNdfGCr5Cohf8Nk0a8NVjnc5zemhwPgvK+8k5U2BhkU3np1GZ/YsfpxIZKX4JmD3AP/UcHY+2yYLinXoMskbShA94imqwFLv8QFf13f64B3IMvclK/5PnwcpTx8JCv923zEharY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842876; c=relaxed/simple;
	bh=4xKl0g8NuGbC0xz8DiSBqjcjW55nYwdEOeItv+5+1B4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qFuLiA/fftQBv2OgCQ+u18etJRQfzde6d7RqiR2BlhkyMWgfAr5RTU3sieeI6Q9a2uG9tsEIB5BjEWQ+a7fA3Nlj8LyIuQqoy3YoY23nHUBSkq31xg/ueMNOs7/Z3kXUfC4nkkRwxbMwavuf36xLUAK1Os5iliCaqmRq8qZQX0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wz/C3T/z; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye9M5eiIVVpw04uXJsM7r854g5Kxy3+hhtzdeg+637JgkkBB72r1D5YhfpEjVfZBv1tbWxd2pW6uv4L0fRBmtF++P0OGHgy/nzyAJuZMbWXEKdpf8J9DZ2hR0sbMQ+wNxy5gqdmdnMX/ulL41XZ7rtviGjvAVxgHXS0qeEkPFALmrlC4fQ0u5t6IhGJPaWh8RmmrP+5f+sQ/5YghzV8ZWRRZM79R83tBQJX90RluCBvFSKAtEiIg4WHhHZ0rA7UDd3b5HNog0FFeczOOWwzzHKD7SdwlUitNP3HxYAIJBhC6qFaTSFfXd6I7k5S7Nt90IVytmOSqIv7tOoZLV98bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xKl0g8NuGbC0xz8DiSBqjcjW55nYwdEOeItv+5+1B4=;
 b=J2LotG+v5/bQiy3sL2/r601NDEwtjguqK1vhQ0GULu+vyYCSRLir3oHIiI1xCU4bpMcixpnffWgZxBQlyrGMgUZL1FT8cxnbxb/dERxQ29fIDljiq5idJXJS6fp2pJo0MTHn7Hc+iMYwv40aMQZeCUnOC7VxkaE/kKCuLQBM7g1nAJBUrMUumsfcn4z2OmuWYR0Za2Tfxk819Df7Er/6u/L+goVW+68hIQ7LPzNGalOiFS6wnMByadOyOnpjFcLlIxoBDF4/rpDUOIDEVn16wAO/HzjDBasNVj+CY5vFo65Vf+JelXn40iIai8ZQF1KgMqQlD1Z3Nodg1REJmjkmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xKl0g8NuGbC0xz8DiSBqjcjW55nYwdEOeItv+5+1B4=;
 b=Wz/C3T/zESE3nM/Gfgo3MacxDo4g1RTHRHtuyBNqC/hRTh5it9JdaRXoKhcdTL7Sb8jNetwe8nlVWEpPgcLdV8mY52xuQLpCEx3jGCoSZJ2+gIx04euWJd+va/w2ebBrBKpbPja98zMC5vrIkGOwlfE4sdSenrufVzeJsyFFP0p3xBpnqt0ijX2VnjEbiJVhvdFCYCJIAsnSxNVTBYeaHignT0065sggojNrdSfeVUbLms49MfRc9j6SqrOwQa9piqJdTBqXWZK9UVhvyhHFa8Zx1S7817ESejxs5tzlvW1vRcKy9ZgAU0YO3lO2mGz6xCJjd/q/Ior6nOZkOqQanw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA3PR11MB9464.namprd11.prod.outlook.com (2603:10b6:806:464::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 06:07:52 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%7]) with mapi id 15.20.8989.011; Fri, 22 Aug 2025
 06:07:52 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <dong100@mucse.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
	<gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<danishanwar@ti.com>, <lee@trager.us>, <gongfan1@huawei.com>,
	<lorenzo@kernel.org>, <geert+renesas@glider.be>, <lukas.bulwahn@redhat.com>,
	<alexanderduyck@fb.com>, <richardcochran@gmail.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Thread-Topic: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Thread-Index: AQHcEw1/LwXdpHe+ukGdpS5U/+GtHLRuGj+AgAANZQCAAAhvgA==
Date: Fri, 22 Aug 2025 06:07:51 +0000
Message-ID: <8fc334ac-cef8-447b-8a5b-9aa899e0d457@microchip.com>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
 <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
In-Reply-To:
 <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA3PR11MB9464:EE_
x-ms-office365-filtering-correlation-id: cf8ff557-a8b3-4f9c-b4f6-08dde1423a5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHRUeHQzalhRMVNnYW5NS2F0azN5cTExSDRSRmk5QmxwRWFhamorL29zcjNC?=
 =?utf-8?B?bkVleHV5MVFiN2JHWGl2SytuMG9ndTQ2bW1aTFU4YlowL3lJRnpwOGo0bmtC?=
 =?utf-8?B?RHhsU3owYWNMMTRxTzVydHRhb3Z3bGVXd1dEcjk1aEYzWTQrbnN4QVZLVmRD?=
 =?utf-8?B?MXZUTEViYjVLUGxMbHNQbXNyZzQwc0ZESVRYMXkrT3A3TlFNYVZCbGR3bTh4?=
 =?utf-8?B?WVM0RE8vdnVMVkN4NGNJZThLaGdOdTJrY0hzeG0rdDJKM2VrMGp4dWxYNWwx?=
 =?utf-8?B?UXlKU2pSc0FCQVNaQ1pZcU1sZFFWMTRtMUVubzdpdFQzbEludlU2VUw1am9I?=
 =?utf-8?B?YjZvR0FVbFFiOEJpeXRZNzVlZWhSUVh3aGlKMWU2a1RuWGo1ZXFiYmFrUmVS?=
 =?utf-8?B?akJPb21kbnNwQzFZQ3RVaXl0U0hsV1hRaTV1VWlSUTB3QzlBM2RBdk1zSHpV?=
 =?utf-8?B?ZVMweFlIQ2llY0FjWHh2UHpmWjdVQ2RrWkFuempxT2kwVzlPT01lVVQzNEww?=
 =?utf-8?B?WWlFdUhSOTQ1bk1TQXpUdjhiUnJPRzkweXFjTnlkTFdSMHoyQXRxVXlxWEZw?=
 =?utf-8?B?clUyUnBDbEUzQXFWYkJ6WWhoeE5EeHZDbUFuYmlZU1h2cXJWNUx1dXB5ZDdV?=
 =?utf-8?B?WEhPMEQvMFpMMUp6em81Mk80V0xWaldTT2hzWjg5bTZPMjlvRStZblB0M2VU?=
 =?utf-8?B?enhKcDFnOTRkYWp2dU5LV3lVamc0TWZmb29UbVhEaS9HZlRtc1VvVjJ0d0Rz?=
 =?utf-8?B?aFgzeUdnckV1U3dCTHE0Nm1JUiszd2NkWGVxOUIvaTRxcWpTV2QvdWJJNXZq?=
 =?utf-8?B?VWo5NEpJT2J6cmQ5cHl6UUdBdDRoN25Oamw2ODBvakhiRnAveVJ2NWZDdW5a?=
 =?utf-8?B?SVc2YzhmWGw0L0VaeTZKT3RhZ0wzRTc3Ui9hOU4yeEgybU5OeWJlYzMyTzRs?=
 =?utf-8?B?eHFDV2VpVXZBN3I3U252WWxKTjg2Y0FJTWc2L0RBU0dLaHBpM3l4bUt6dWpU?=
 =?utf-8?B?anNkc1pWRWlTd0R6WlpKTUFubFE4aVc1S0ZJYjluU3lSK3QwazlkUDY4WVJv?=
 =?utf-8?B?REovdFBlNWc5Rm05cTl6TmpWRm5seWQ3ZjJ3eTk0RmkwSldSdkZNeHJxQzZw?=
 =?utf-8?B?anVZOGs3U3BmblBmTXN0UGovT3gxZDdiQ2pFUXN5V1RhbldNMkJWaWt6emd5?=
 =?utf-8?B?YytHNEdzSjVVMXNNbC9BZnhiZ0phaWl4RnVxY2JXdnpwV1Z0ZTBSSU1sNEF1?=
 =?utf-8?B?N1U5aTJha1Z0a01SV0tGdVRURWo0OVptdlhqS0M2UnlRT0d6bXlSSytQQ01j?=
 =?utf-8?B?MG05NEczZVBTb0RSWENsL0VLcjI3MnZ0eGU0YWpWdzlLY2pYT2ZzdFA3Yy8v?=
 =?utf-8?B?Q3FVcVRYbGxHSFVJcHc5Z3ZTeGhvcmV4YnVMZCs1MmE2bElrWlBGQUlUU25t?=
 =?utf-8?B?R05jcUVHR0pQa3FwbXNmOTdFOTVnS0pBVmp1YnhiR0IrRUxYbXdOTHhYQldB?=
 =?utf-8?B?VnZUa1FuV0U5NFV0RmZzQlZ0YitYREZNeEVkMmIvV2xlakpvWjJIdW4weDRN?=
 =?utf-8?B?TUpZM05qKzlaU0grL0tXUU1jaW1mSXpXaFcwTFN2WHR3SWJvSmhPcnlMK0Va?=
 =?utf-8?B?ZEQ4Sk0xZUVkOTg4TUw5ZDhVTnJkeFFwRGIxU3VXSkZndVRhSGUvbWJMTWlT?=
 =?utf-8?B?cGVFLzJvV2Vmd0xSaHBRUkFBRm9ac1dmYXZzSmxSV3lLSHMvWWlPM3VhQjNX?=
 =?utf-8?B?UHRpUERCcExXNUtqVkFoRDQvYnBNY0F5dEdjT285TTd1MWxvYkE1Y3lISWhU?=
 =?utf-8?B?eXk1VjNNNEJRRXhpR3VhSU5uVjRIYWN1Uk80Wk5SYVN1UDRIVy9wN3I3RnVN?=
 =?utf-8?B?UWFYVWI5WjlQKytnOTV2ZU1neXZ2cS9ZQ2hqTS9nV3RBMWN6U0xOUGdPVklq?=
 =?utf-8?B?L016RWVkdFpFZGFoVENHVk1PMkE0OFJ0cEdzYUtTS0lRY1lIUCswUHUzVzhG?=
 =?utf-8?B?NFdKVkMwaWhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TC9BYkM5NS9qYmdoVWhWMkxIMHRxTGkxMWoyQjF0Wm41ZDJxMVJvV0NQRTZG?=
 =?utf-8?B?UFVicXByYTZhN3BVSFFRQVBSNmNkWG1vQUtNUHpyc0ZhNjVlV2VFRG4xMm9q?=
 =?utf-8?B?ZEo2aS9odzB6Y2I0MTBKeWR0OEF3VHlGanVJWCtic1JZRFNZNWxmQmRLRTdU?=
 =?utf-8?B?YndEN1hIRm5pdXptWjQ0LzBaVmVabENKTU9WNC9DOWlXOUJ4elkvdmZRbHFt?=
 =?utf-8?B?bVlwS2xQcFN5NkxrQmZvdG43U0Jkc0w4ZzRNNys1c2dpUXNQMm9HT2pWVnkz?=
 =?utf-8?B?Y2N5TjdlSVdmMXpMa0VPaitxVjJuUGtpWXRoQkZTUWZBeUhKVjVReXlpenMr?=
 =?utf-8?B?cXdCeXZoZVFWUk1MWjVDLzUwdy9aZzc4T1YyZzE3dysyWjZjTUhpRGZlTVcw?=
 =?utf-8?B?aXBHYXRNd0FRWmpBS1kwTGVzSk9lV09NWjZzdytGVFZoRzNuWVpUc0s3d3Mr?=
 =?utf-8?B?aDViaFBEbE1Oc1I2MDZvcjN2NVhZeE5nZ2RvMFhlZGpoMXdOdTB4S0FvbnEr?=
 =?utf-8?B?ZFNZSDRoeDdEOFJpRjc0d3YwQTdaRW11WU1uMTdYUGFhWFhjUzVyMHZlTlRH?=
 =?utf-8?B?MVY4UUVYanM3UEpVVmhvWll3UjU0cVc1TEVJcGpJOXBrOVgxQkVaU29wTGk5?=
 =?utf-8?B?R3RQR3J3clNVaVExSW4xZEVjV0Q4WFVxd3pDSHo4eWorRlRmemNIK2cxTDJ1?=
 =?utf-8?B?Wk1Pb1lUOEh0RkhUZ1RrNkhISzRsb2ZKci81dkJCZmhFVTNUT3QwNVZnc3R5?=
 =?utf-8?B?VjRGb2NEbzREeG9aZHp1VFJqYlJKUzlxRllEVDFkc29SY0NmemJqL2R5Yy9Q?=
 =?utf-8?B?U3kza3MxT1ZGZHp4WDlWWUFZUlRadTdCNGhWMUNTOVN1cU0wN0FVK0tBL3JW?=
 =?utf-8?B?eFF6OVBrMTBqSTVaSUdVbEpTNkVFYm51SkxINmhZM1BuZWNBK2tMaThnVEpr?=
 =?utf-8?B?ZkZNa2U3ZFFBNjdPYlRNV3NDWXdnZkJuNEJxZjV4ZlVkSmZnNlB3YkZrVFcv?=
 =?utf-8?B?UXN1cFpmVHVEK1M5dk5XR3p5UWNSOWJDRVVKQ1ExQUJJRU1KWUVMaHUrdlVy?=
 =?utf-8?B?UWxFRkdlclpDWVRkZjBhZlliT1JSb0Y4OUhpVlBPUkJITXIxVmtKelFxYjl2?=
 =?utf-8?B?RUJBdkpja1FWSDVSb1Y0TU5QL3dLSmNFTlE3UWgyMUx2T1ArQWtxdHZxcUx6?=
 =?utf-8?B?M1Rwc1EydUw0aExsVG80Rk4wSlVJNmdhUElCb0J3aEJVY0I5SXRlTUI2WmtY?=
 =?utf-8?B?a0pZTTlldDNGM2hIczBkelZlRWJvMVovTlpBM09raG92NEFZWVp6TmNBL0VC?=
 =?utf-8?B?WFBTK3ovSUZncXNTVXNPOVJOV09iRlF0WURReG5GK1ZLbjZycm9VYXRSbTEr?=
 =?utf-8?B?WnFRWTFRMWdjbUMvTklJR1ZWeTYwTUVzZUpVNGNEMll0Um0xd3g0S0FGa1B3?=
 =?utf-8?B?QUFFNGxuZ0dYbGN4ajJDck9FTGh2bkVrU3gwZzZ5Mi9rTjZFNnUvakpja2ZM?=
 =?utf-8?B?ZEQ3OVd1TUhUTWVaOHZxd004Y0E3VG9vTHM1R3NIV2lzOWNsaW9RYXRnSTRD?=
 =?utf-8?B?bHhKTDBBVzlaaTJ4MUpNaExmMkhXOU1Yb0pjbTJGRmhIV0dyYXhYYnhJUUky?=
 =?utf-8?B?ZlpLQnhrYktGZlNCMTJuRjZ1ZDVQRUUyUzJORWJpcWYxV2I0SmlNbnduZ0kx?=
 =?utf-8?B?L1g1QnlvMVM4U3d5NXRHYlFmMDRVTU9NSmtCN1dvQnhyUmlqRVBKS0l2Q01q?=
 =?utf-8?B?R09XQjJObjB6ZjdTVlh3N2dxWmQrRkhBeUJrME90QVNyT2UyaUoyYjVvZ0dK?=
 =?utf-8?B?QVdEVTRZb1BobWxweGcrZHl3THIwYTRqV3hlWGRrRlRjcTB5d0kxTjE0Wk90?=
 =?utf-8?B?OHdIMW5LMmN5SVdNMVJPM3dGakRWOHBIeEo1ZlZHKzJaalE5L0RENzFxak4y?=
 =?utf-8?B?LzFHblZzaUF5aUtkbThRN2RNdWwzZlIyU0kvRjQvUEk4cUoyNjd5M09hclNa?=
 =?utf-8?B?K0lHQ2NReXVCM3pQencydklXQ3kvUFlmM2hQNG85QkpNTXh5V0hveDNEcE5U?=
 =?utf-8?B?OHlYTitxbWljbk85c3hubEMweGNaV3B3TnFBRmpHUTN2dDloYVBBbGh2V1J0?=
 =?utf-8?B?aHdzckU1VGJYL3YyempLY3g3THRGOTl2K2xJOG1HNWYzQWpERXZPWUcrTzdn?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52B44236EF56AB408C4BE7DFB30F632D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8ff557-a8b3-4f9c-b4f6-08dde1423a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 06:07:51.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Twwgxq6EyhtJYWFaX31d3FMtbIpiIESApJR+wzZdu+uuxM5cfQTLAz/cHRfCiKbmIke5C2bjlc+2KklcMElMNoyJsbA7Z3Fk4/ln5GZYiCrm2jlD4l1zAHZiygY92rFy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9464

T24gMjIvMDgvMjUgMTE6MDcgYW0sIFlpYm8gRG9uZyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIEF1ZyAyMiwgMjAyNSBhdCAwNDo0OTo0
NEFNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+
IE9uIDIyLzA4LzI1IDg6MDQgYW0sIERvbmcgWWlibyB3cm90ZToNCj4+PiArLyoqDQo+Pj4gKyAq
IG11Y3NlX21ieF9nZXRfY2FwYWJpbGl0eSAtIEdldCBodyBhYmlsaXRpZXMgZnJvbSBmdw0KPj4+
ICsgKiBAaHc6IHBvaW50ZXIgdG8gdGhlIEhXIHN0cnVjdHVyZQ0KPj4+ICsgKg0KPj4+ICsgKiBt
dWNzZV9tYnhfZ2V0X2NhcGFiaWxpdHkgdHJpZXMgdG8gZ2V0IGNhcGFiaXRpZXMgZnJvbQ0KPj4+
ICsgKiBody4gTWFueSByZXRyeXMgd2lsbCBkbyBpZiBpdCBpcyBmYWlsZWQuDQo+Pj4gKyAqDQo+
Pj4gKyAqIEByZXR1cm46IDAgb24gc3VjY2VzcywgbmVnYXRpdmUgb24gZmFpbHVyZQ0KPj4+ICsg
KiovDQo+Pj4gK2ludCBtdWNzZV9tYnhfZ2V0X2NhcGFiaWxpdHkoc3RydWN0IG11Y3NlX2h3ICpo
dykNCj4+PiArew0KPj4+ICsgICAgICAgc3RydWN0IGh3X2FiaWxpdGllcyBhYmlsaXR5ID0ge307
DQo+Pj4gKyAgICAgICBpbnQgdHJ5X2NudCA9IDM7DQo+Pj4gKyAgICAgICBpbnQgZXJyID0gLUVJ
TzsNCj4+IEhlcmUgdG9vIHlvdSBubyBuZWVkIHRvIGFzc2lnbiAtRUlPIGFzIGl0IGlzIHVwZGF0
ZWQgaW4gdGhlIHdoaWxlLg0KPj4NCj4+IEJlc3QgcmVnYXJkcywNCj4+IFBhcnRoaWJhbiBWDQo+
Pj4gKw0KPj4+ICsgICAgICAgd2hpbGUgKHRyeV9jbnQtLSkgew0KPj4+ICsgICAgICAgICAgICAg
ICBlcnIgPSBtdWNzZV9md19nZXRfY2FwYWJpbGl0eShodywgJmFiaWxpdHkpOw0KPj4+ICsgICAg
ICAgICAgICAgICBpZiAoZXJyKQ0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVl
Ow0KPj4+ICsgICAgICAgICAgICAgICBody0+cGZ2Zm51bSA9IGxlMTZfdG9fY3B1KGFiaWxpdHku
cGZudW0pICYgR0VOTUFTS19VMTYoNywgMCk7DQo+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPj4+ICsgICAgICAgfQ0KPj4+ICsgICAgICAgcmV0dXJuIGVycjsNCj4+PiArfQ0KPj4+ICsN
Cj4gDQo+IGVyciBpcyB1cGRhdGVkIGJlY2F1c2UgJ3RyeV9jbnQgPSAzJy4gQnV0IHRvIHRoZSBj
b2RlIGxvZ2ljIGl0c2VsZiwgaXQgc2hvdWxkDQo+IG5vdCBsZWF2ZSBlcnIgdW5pbml0aWFsaXpl
ZCBzaW5jZSBubyBndWFyYW50ZWUgdGhhdCBjb2RlcyAnd2h0aGluIHdoaWxlJw0KPiBydW4gYXQg
bGVhc3Qgb25jZS4gUmlnaHQ/DQpZZXMsIGJ1dCAndHJ5X2NudCcgaXMgaGFyZCBjb2RlZCBhcyAz
LCBzbyB0aGUgJ3doaWxlIGxvb3AnIHdpbGwgYWx3YXlzIA0KZXhlY3V0ZSBhbmQgZXJyIHdpbGwg
ZGVmaW5pdGVseSBiZSB1cGRhdGVkLg0KDQpTbyBpbiB0aGlzIGNhc2UsIHRoZSBjaGVjayBpc27i
gJl0IG5lZWRlZCB1bmxlc3MgdHJ5X2NudCBpcyBiZWluZyBtb2RpZmllZCANCmV4dGVybmFsbHkg
d2l0aCB1bmtub3duIHZhbHVlcywgd2hpY2ggZG9lc27igJl0IHNlZW0gdG8gYmUgaGFwcGVuaW5n
IGhlcmUuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiBUaGFua3MgZm9yIHlv
dXIgZmVlZGJhY2suDQo+IA0KPiANCg0K

