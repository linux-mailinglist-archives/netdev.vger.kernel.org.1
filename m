Return-Path: <netdev+bounces-210777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006AB14C66
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 12:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A856B3A5678
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95828A722;
	Tue, 29 Jul 2025 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KKo9vKt4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85062882CF;
	Tue, 29 Jul 2025 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785670; cv=fail; b=VTHRsGj4dzN4Ku898gx1kKQVuqC82REMadiPkGX1G2kSegCHW5Ul0FfYEZRQZsjuDxt3vM6zDgM1q15OGWseByQAjg7E+Yz3zr4emDO8HcXr1XuDMV+hB50HrMaKpQ17HZhTBhNX/qiAsigi/wdNecE0YKVFXDYRhYzSoCZLCzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785670; c=relaxed/simple;
	bh=bfa5N+hZowzdBkLG1IeNNeUxVgDE6pObOvP7AVlpmGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GNnvBdqNYwC/bfQuzzgdrjHm7QW9t9ch9NQ6JYTHsDgfqIxCk3V3EUaaKHFfPSItfuVtu+By0K3Fl1v/9372n8N4o6+r+rHsEUfSkYtNsh00v66oNvhQxgefuOzISW2CKiC7/WAWNRnNGlVNRMe6dkur6ZlOon9hE2cpp2tXO7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KKo9vKt4; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNDVFkZTymKsPsKM0vZlPZOEIDYIHuGAMewYVv9nBnq8/8FfNUjIT6aN6Ewg4SP1Ig2Nnog0pLESG8udYB1lKkHM7dKeKlmJI8oPlHwkoItHiGp9vsfJd4xQshFWlvV2G892kAfEifaSjIN7AFHzy0eto30ZgyFxacg80kpIl9kHqKa5xjvULpSqNP6aEnio5dwdXwchtREGiv/JIOZH/WfSm7ZjxGdYminoAMLny11LMIAnpcSr4KwFLmkoSLpsaodGtJXcqpXGHqtjAFyG3qBbJRaRYBVaStKNhdyGbZN/ql+KyZvsPJTLzUw8C4KjLiOEGuheYJYI+8EZpfSCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHtmlEPgJxnYOUWjAfhxm1L+3lUg3FIEwP7VaJadRQY=;
 b=L5vzC7v1Kl9N99iO9qUFXsF+h0D4vqvJI+1Twq5H693LMVxDXh6EVT0FOL6FPT415F+txJSH6PhIFh4h04USD26muEFo7CM8kdX4Yt6r10QGaP7ZWKp9fa9qKNiaCt78Ynu9VxdKSA18f2RxgZKdtW6LUe9VLfpcjoAlZd8MTGHC89suKSLlZ2yF8waiGkZt1PvMc3R2mxKszx3VpQFzCzzuSI/UCr1B1ahnXsFnBfbK+nSluOL195JLGLRDHgHJgr917UljYVb4Ubos7xZdEFnZt4ZVJYpPGbpBr5Dfe+D7AWQ2uj+Jev89m4YDczJIRP+7Zs+cBE+yzj1o05jWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHtmlEPgJxnYOUWjAfhxm1L+3lUg3FIEwP7VaJadRQY=;
 b=KKo9vKt4YnQT7u9+46C23l65e/4qGMhQ3gAp5rn1xEpupLxyTe3oARis3fac5v4BKJg4fleGqkxExPFaxwiyZylIzeKaa2D1rt6QbJ8aKFQwvj1m4TeHzXdzGdGWgLL5rm6I6jxUmJut9haUtIBfhSJEmNLCM0L/H5ezBO4Xby0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 10:41:02 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 10:41:02 +0000
Message-ID: <4ede2cb4-76de-411d-99e4-70a29f97edca@amd.com>
Date: Tue, 29 Jul 2025 16:10:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net] net: taprio: Validate offload support using
 NETIF_F_HW_TC in hw_features
To: edumazet@google.com, vineeth.karumanchi@amd.com
Cc: git@amd.com, vinicius.gomes@intel.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729061034.3400624-1-vineeth.karumanchi@amd.com>
 <CANn89iLhSq4cq4sddOKuKkKsHGVCO7ocMiQ-16VVDyHjCixwgQ@mail.gmail.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <CANn89iLhSq4cq4sddOKuKkKsHGVCO7ocMiQ-16VVDyHjCixwgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::11) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4dbd36-7b47-4d64-5909-08ddce8c698b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkpJdGZJNlllRlBUL2cvY25qTVJhR3ZDT3FtM1lzbWlQc3NxNU4wc2FXQkEw?=
 =?utf-8?B?ZU51bk9mKytLamZINEExWGFOdGlCVjZIb3AxK0oyVENpaXFtSytYMmQvb1ZQ?=
 =?utf-8?B?N0JwRVlmczVZSEt6OVc0TGx2Y0tWZHFjUEJscW9xcFZYYTJKQVRCcDB4b0Y0?=
 =?utf-8?B?d0h5U3dwd1NHbnFGSW1tSmp6K2podC9EMjZxQWVnS0ZqWUVZMFV1amlNdFBq?=
 =?utf-8?B?U1NtdG1XWWI5d2NwYVNYZHpJcktHa3Y5VjM1cm1HSHZDUDNUbnhES0tuMHg3?=
 =?utf-8?B?M2pia0VvbDgwWHJqbnF5SVk5N09YWEg0eWF4MTkwczgyS3dHVHV6b2duR0U2?=
 =?utf-8?B?K0d6SnhxL3FWQndiMlg5U01pMThiT1ZxNHYrQzNuWXN5QmtsNWx3cHB2cFN4?=
 =?utf-8?B?MDl3bU9xVWo5Zkhta1BJNGk1YVdiRExnMjdXRVlqVE5wSFhJZ2hoNkFBbDMw?=
 =?utf-8?B?Uk5pV1UxUWQwWGwraFVtVExWWElvQjV5U0lLNEJzN01mN3N2YzdGMjJyUnlT?=
 =?utf-8?B?cUdjVitTeU91QjhUTmU2UW9wT0NERjZSOGhXdk9kZGNrNHVrOFE4MkdjQnRa?=
 =?utf-8?B?VkdmZXdPNVFSUkd1TUVFejVsN2VKVE90WGlNcndWL3I2UG53MnE2V3krZTVT?=
 =?utf-8?B?MFhSQWxmcWxpRDJZUWJDTkMxZWhkdVFtR1dVNXVGajRQakpoTm9GR0NxblBC?=
 =?utf-8?B?OUhFckpqbjRpRW4rM0ZYWllXcU0vZkN2Wkk4Vnk3MThDL1o5dUFFanFXTDFR?=
 =?utf-8?B?MGdoUUZwZkFOQUpINGY4OHR0V1Q1RnRCNUFIUGtXYjRsb0FEa3haRU8rVEFp?=
 =?utf-8?B?dmczcTdBSHJ0ajNIWnY3ckJ0NFhpU2o0K3gzUGFrL2twQkhRbDIzNlRNUDhY?=
 =?utf-8?B?WWJINjJiaS9WeWQrR3R6OWRUZC9QVStRMDZFRktaUUttdzFnOWFwdWZPK2tR?=
 =?utf-8?B?Tnp0S2JMRGsyUEV5bmhOSjVXRVBTYTBIUUtFV1liaGxscjNjZlBrVEFrRnFl?=
 =?utf-8?B?RkdYNHFJVTBuTG1PRFpZY0plVW5tWWVRUU9yckpxUkNwR3lRQTlwRWpOd3Zt?=
 =?utf-8?B?VFR3UkVPL3haSmlnSTlBSElKUGNkcExvSHJzU2lhVlhUZmFlWXBhWTZKSm9X?=
 =?utf-8?B?dFFxbzFMaTRHM1kxdDN4Nk1iOFRkQ3RNcStXNEV3cVVrREpkemM4SFVHM1BC?=
 =?utf-8?B?OUNkYXpCWmRDY1NZSzlXRjNrZTNGaEppZWxGMmVQUkVrYVVpNW42OEJhU3dE?=
 =?utf-8?B?a0wvWXlIZzRtMnFsbVJDSEhrNWk5WWU5Wmc0Tzk4dzBrcUV0L0U1d0JXVzR4?=
 =?utf-8?B?MFVVRmNBN1dhZ2FOQklsY2dSQkhSVUVaYVlIdm81QXlRTlRqNTNtYzVvN29T?=
 =?utf-8?B?aTNGc3JJdUJhRG9KdnliUzNMUld5bzRyVEl3eE81U1dsZUhRUlBmYmxRMEQ5?=
 =?utf-8?B?bitSQnQwVmNVV3k2YldaNjBweVovbWt5bVhxc3hJR0x2QnZiM1pwczI2eVVJ?=
 =?utf-8?B?b0dCME5GK3dIcUgxY0ZTeWNDSEpBOUs5OTVNb3dYQlUxM2ZYQ2pWNFZUSXNn?=
 =?utf-8?B?OTh2TXdlLzg4VnB0NEM2bDVFNUJZSUZiYjVwdDVmcFBMeWpJbndOeFUrR3Fi?=
 =?utf-8?B?N1hIbklqSDhaN2NHM2ltOTVsajNhRDIvSXdDd3hLUmN3RDhaQS9OTDZ0enZm?=
 =?utf-8?B?NVg4bTBFM1VtWjA1eVV4V2tHZDVyK1V6ekgyMkhxRERSYUQwSmZRanhOd1d4?=
 =?utf-8?B?MzFwZFZQbTA2UktoMGc0NWp5cDRpY2dMMXBDc2plRU4vbjJIRVYxTXJPeEpm?=
 =?utf-8?B?bnYzWVZ1Nkx0QnJYdlhFV1hiOUFpUjc0cWlIcTJNRktYaVBnTXhBMk5jNXo4?=
 =?utf-8?B?SE4rR1NNTGFPWWlYbU0rdjYrK0ZVdHNuaDgwVmZ6NnM4ajhteWV2SCtvRGMx?=
 =?utf-8?Q?6lLsFR4jX9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N24xNWxxeExnRWNCbEJIK2l6K0lHV0xBdnJFa1JVclNPWGZ1L3RWdFd2S2sv?=
 =?utf-8?B?aHhYei9taCtqWHZxT0RvZzZQZnpqRWExK0pETU1vZ3BabC9rUnR6Mld2WnBu?=
 =?utf-8?B?NnNlcjl4ZUw5ZmYrRUtFeHkwRWt6R3NhRzZKTFYvR3Q4N1U2eUxwYU13ZjVj?=
 =?utf-8?B?ODVFSHQ4Q2FZYTl4Ti9iRTM5NFpLNkloWFhmWE5yR1ZhMFZxMnlJKzh1eVZ0?=
 =?utf-8?B?ZTMzdG1Cb0dyZXdidWdMKzhnOEhrR1RjUytSaElDNmtvK2hObjMrMEtDanNv?=
 =?utf-8?B?SGNjME13NWhEUjBKVHJBUmcwWVp1U3U3Mk1tcTlPdXVGWXdEL1dHZ1NXVHk3?=
 =?utf-8?B?ZXZ1d2lFZEpFYWtPSmROelFaa2k1dnVuUEsxNUljRnlYNU5LN1RwbklRbytx?=
 =?utf-8?B?cVpYYk9oQTFySnpOeEFYdEdmZE9PdWdpQkFPYVJYMzE5WEYrenE0T0RleExm?=
 =?utf-8?B?TnBUYkQvMERSaEJvRUFBcU9NNGIwUGNBbFhOVUFhSjlYMzdnRkl3QS9GL0h6?=
 =?utf-8?B?S2kraGswWDNna0xuSUdtd21JVU9OQzNvOCs4OCt5YTVVc3VNZFB0bEtGZUVl?=
 =?utf-8?B?Q1dSWWwyZm1iZldKNjI2OFJYQTREVVFsend6RE8xdDV3TmxCclJDM0JaS0Z4?=
 =?utf-8?B?dWN3RFBpcEFhWC9BRmpQcGxoRjk2d01aVFloeEp3SVVxSkNRRjVaajAxMEo1?=
 =?utf-8?B?MGw3NUptbkJ5NEwzTjkwVWtpYlovTllHR09vUXhXQVRyaUUzYTJmWlJ2TldE?=
 =?utf-8?B?WmRoSlRIUFZBQ1dyZDdJMmN1V3pGMzJrN0pzZXQvQVB0UFlrNHNCMHdxb09V?=
 =?utf-8?B?RWlRV0xSNUFjOXhaRjd2OEU2L1ZBdGJYNTBvN3hFZ0VML2UwVG5SZGRDV0dY?=
 =?utf-8?B?amk2UTVHL1BwN0grai91T3BCQTJSU1Z4VzN2cTJZUkg0YlowajU5TmMwTVI2?=
 =?utf-8?B?MWU2S1hKeXRsV1lkNWJvT3puZ3Bsb1BSWGRsUGVQRzlYZTA1K3VOckpFallG?=
 =?utf-8?B?NWZSREhES1lJZVNqanBwSG9PTUUzV0c0TzU3d25VL2pMUFNqaHJBc0hjSVRH?=
 =?utf-8?B?WWw5bHdjWnlsWmlYMllmVUp4S0hMSHkxaGxGSVExd3IrYUxuZnI3UWF6QzZR?=
 =?utf-8?B?WG9NU3NLeG9HZXFQRlNRUUNnajBLbVp3czQyaDFKVXBVL3c1MTZPTnpwaE1H?=
 =?utf-8?B?aExXeURuaHJqVXppUkJmSnZqcDFUY1pXNFNGK1VCWlI2VmVzbE04aHhkWHl0?=
 =?utf-8?B?eW41cHVoZ2ZtaCtjN3djU0xLRnIxZ3JkWGM0NTNQcTA0WlpWRDBnQlpWTkdH?=
 =?utf-8?B?ZExCUEYvSzQ3SXQyenIzK3UwUHZSNTFuUkFRN0R6cFd3aElpZkZmYmVwcDVR?=
 =?utf-8?B?N1ZSM3F1NDVMNkFSN2QwTVJ1Rk5GMGxjV1FPa3FWTlEwbk4wZnlDTXE3eU9P?=
 =?utf-8?B?WURWSnFoeCtYY01lNGRML0NWZ082ditkd0JqdWJBbVl2RzZHRzRMWlRZTVJ3?=
 =?utf-8?B?akkrMFp2T2JMRXI2WFhOeTBiaFZ6ZUk3TU5CWVNKVUNYOURIb3MvV05ib00y?=
 =?utf-8?B?UG11Q0pSdlVKaER6ZXI3RU5ySWlqKytrN29HR05wMVh4QVlpSXhkTG85QUpt?=
 =?utf-8?B?dlFTV1ZyL2JaNEphQ3dEdi95dUJJTUJjUnpLN2VDMExIQVpEbjJPVWV2bExC?=
 =?utf-8?B?UFVLa05PcWgzUkxrSVFTMUVFajNxWkc5NUszTDZKb2E2d3BGMHcvb0VrTEhw?=
 =?utf-8?B?a3FFZU1rZExHWWNIR2ZISzBLbDJQWTE2K3Yxb0NUNjZvNHZHSmJjOE55YWRz?=
 =?utf-8?B?WG45dVJva2VnMTVoSVVadE9za1VlZGxuVTYydE5XYzV6b3ZTcXhZN01ZeThV?=
 =?utf-8?B?enRSQTlCai9Bek12RVlOZ2dEMGJqS1BHa0JMd2tCWHZxVjBvdEtmRllCLzVw?=
 =?utf-8?B?RkhoSVZITVk3SmJIVjFiYjczMkRrMXFIOU11U2wyUEg2a29KVEFwZG9OYTRE?=
 =?utf-8?B?NzVpeU41YTJycXVJTzFReFRFYnBkN3RTRGtMMVhmKzAwTkZ2ZDJEUHNCSWtI?=
 =?utf-8?B?bitXbFhvMzdnb0h0ZlJTdEwrMlFaWjUxeCt6SWRPNUpKTk4yaUVFV2RyWktt?=
 =?utf-8?Q?F9yyZeTbO9++26TH1yCfl8lqx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4dbd36-7b47-4d64-5909-08ddce8c698b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 10:41:02.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF4OCFAqPKZsib4tYs+6g0l+ybAkJ9PuRGlXFVfgcJ35GYMTLNVk/Jyw+kRdXMsx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777

Hi Eric,

On 7/29/2025 12:15 PM, Eric Dumazet wrote:
> On Mon, Jul 28, 2025 at 11:10 PM Vineeth Karumanchi
> <vineeth.karumanchi@amd.com> wrote:
>>
>> The current taprio offload validation relies solely on the presence of
>> .ndo_setup_tc, which is insufficient. Some IP versions of a driver expose
>> .ndo_setup_tc but lack actual hardware offload support for taprio.
>>
>> To address this, add a check for NETIF_F_HW_TC in netdev->hw_features.
>> This ensures that taprio offload is only enabled on devices that
>> explicitly advertise hardware traffic control capabilities.
>>
>> Note: Some drivers already set NETIF_F_HW_TC alongside .ndo_setup_tc.
>> Follow-up patches will be submitted to update remaining drivers if this
>> approach is accepted.
> 
> Hi Vineeth
> 
> Could you give more details ? "Some IP versions of a driver" and "Some
> drivers" are rather vague.

At present, I’m only familiar with the GEM IP, which supports TSN Qbv in 
its later versions. The GEM implementations found in Zynq and ZynqMP 
devices do not support TSN Qbv, whereas the updated versions integrated 
into Versal devices do offer TSN Qbv support.

> 
> Also what happens without your patch ? Freeze / crash, or nothing at all ?
> 

Crash!

root $# tc qdisc replace dev end0 parent root handle 100 taprio num_tc 2 
map 0 1 queues 1@0 1@1 base-time 500 sched-entry S 0x1 100000 
sched-entry S 0x2 50000 flags 2 cycle-time 250000

[   31.667952] Internal error: synchronous external abort: 
0000000096000210 [#1]  SMP
[   31.675529] Modules linked in:
[   31.678576] CPU: 0 UID: 0 PID: 660 Comm: tc Not tainted 
6.16.0-rc6-01628-g2933e636b919-dirty #14 NONE
[   31.687870] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
[   31.692819] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   31.699771] pc : hw_readl_native+0x8/0x10
[   31.703782] lr : macb_taprio_setup_replace+0x2b0/0x508
[   31.708912] sp : ffff80008223b4f0
[   31.712211] x29: ffff80008223b570 x28: 0000000000000040 x27: 
000000003b9aca00
[   31.719346] x26: 0000000000000000 x25: ffff00080b5b7048 x24: 
00000000000003e8
[   31.726473] x23: 0000000000000003 x22: ffff00080b5b49c0 x21: 
ffff000808727c80
[   31.733600] x20: ffff000800150208 x19: 0000000000000000 x18: 
020c49ba5e353f7d
[   31.740727] x17: 0000000000000002 x16: 00000000000249f0 x15: 
0044b82fa09b5a53
[   31.747854] x14: 00000000ee6b27ff x13: 000000003e7fe4a7 x12: 
ffff000808727c90
[   31.754981] x11: 0000000000000002 x10: 0000000000024be4 x9 : 
0000000000000000
[   31.762108] x8 : 0000000000000002 x7 : 00000000000061a8 x6 : 
000000000000186a
[   31.769235] x5 : 0000000000000000 x4 : 0000000000018894 x3 : 
0000000000000000
[   31.776362] x2 : ffff800080928d78 x1 : ffff80008190d880 x0 : 
ffff80008190d000
[   31.783490] Call trace:
[   31.785921]  hw_readl_native+0x8/0x10 (P)
[   31.789922]  macb_setup_tc+0x13c/0x190
[   31.793663]  taprio_change+0x768/0xb90
[   31.797405]  taprio_init+0x1d0/0x280
[   31.800973]  qdisc_create+0x114/0x40c
[   31.804627]  tc_modify_qdisc+0x4c8/0x804
[   31.808542]  rtnetlink_rcv_msg+0x284/0x374
[   31.812631]  netlink_rcv_skb+0x60/0x130
[   31.816459]  rtnetlink_rcv+0x18/0x24
[   31.820027]  netlink_unicast+0x1e8/0x304
[   31.823942]  netlink_sendmsg+0x168/0x3a4
[   31.827857]  ____sys_sendmsg+0x220/0x268
[   31.831772]  ___sys_sendmsg+0xb0/0x108
[   31.835514]  __sys_sendmsg+0x9c/0x100
[   31.839168]  __arm64_sys_sendmsg+0x24/0x30
[   31.843257]  invoke_syscall+0x48/0x10c
[   31.846999]  el0_svc_common.constprop.0+0xc0/0xe0
[   31.851695]  do_el0_svc+0x1c/0x28
[   31.855003]  el0_svc+0x34/0x104
[   31.858136]  el0t_64_sync_handler+0x10c/0x138
[   31.862485]  el0t_64_sync+0x198/0x19c
[   31.866144] Code: 88dffc00 88dffc00 f9400000 8b21c001 (b9400020)
[   31.872227] ---[ end trace 0000000000000000 ]---
[   31.876836] note: tc[660] exited with irqs disabled
Segmentation fault


>>
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> 
> Patches targeting net branch should include a Fixes: tag.
> 
> Thanks
> 
>> ---
>>   net/sched/sch_taprio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index 2b14c81a87e5..a797995bdc8d 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -1506,7 +1506,7 @@ static int taprio_enable_offload(struct net_device *dev,
>>          struct tc_taprio_caps caps;
>>          int tc, err = 0;
>>
>> -       if (!ops->ndo_setup_tc) {
>> +       if (!ops->ndo_setup_tc || !(dev->hw_features & NETIF_F_HW_TC)) {
>>                  NL_SET_ERR_MSG(extack,
>>                                 "Device does not support taprio offload");
>>                  return -EOPNOTSUPP;
>> --
>> 2.34.1
>>

-- 
🙏 vineeth


