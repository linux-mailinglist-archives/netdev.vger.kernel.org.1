Return-Path: <netdev+bounces-220030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8EB443AD
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956607B5B46
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720A22B5A5;
	Thu,  4 Sep 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="L1kkM1kG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2136.outbound.protection.outlook.com [40.107.100.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A71C861D;
	Thu,  4 Sep 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004868; cv=fail; b=dI6F9ikTrI8zEyhyZMRuLo8HOZzKhllsNTAw39JMZkZgQ0dLMPJvTnG3T/Xm9trj75yxO0o2sSKb0mcQlNFAAUs3CuJhqqXXYlkm4inBgFmKE8Z0nMuSGH6Hm2dmB5m6JHd4mOkZ8vpnou6mv9ptK3+SIOycDDqEcgiQZ3E7IIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004868; c=relaxed/simple;
	bh=ojTcIo1pCDgcC0amBGOTq7We6rrGWUcZ/WMgE2ZA02Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hoMYL6NAsmpVDLNZWhrW6/RRVAuO7pUeGuiMsfmNQ9HZs5559i3OX2E59MzoD2Jv/YS0RMlWnCROPfl5iLDhBCmP+rk5+TQ2T0LkcJLWtN+h1fF20orWe1BDiES0ZfJqvxFVC5aU8/V0Nrszp0AHOaQMhbqDWGOsEeTR98gIp6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=L1kkM1kG reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.100.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLRpOSYRMMa2dr5gkp207KonaMy6H4/l1zxYMo/Ct5bX7DXheIMRue7E/nKWqy1/CzS8U6+rkmpm/WiYBk2SJXg7zP33g6uujUNoIFBHLrJxMe43ttmus/KeKLWF/rLCIkqjGGtFwZZ7figVlWbIMakD2s3xstd/xtBbqstCmI2RBiQU9osPF8A9No0iMnJa7108C+jvfMwVT9UpJgXHOQtF/XOu0qZOONqTLn+YNm/yuWU+lWpWn4f7gCZ4ipO0gx9f5oS3g3S/UsR1/kIDeLabw3Rput97SzV7U42f+JGQl+lsZH+08fNfXj0ggUJb8n+ndi+zh/zM1sBS34tiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0+FDfFoCYjFPvui98SI4sfnna3hlZf35WX925HBLzU=;
 b=ceibkc1AU7u0tm46gKg9f/7Mc2vfIvMjfkcQff5rpZsLNrkKITvbECNVd2b82lbEYhhO6yXeEmi1VzDt1IOhv7YIYe8eMyYHzSI6aZXQXkM38C5fCQgGWRcFpUHSeouSbz3WoQNk0grZPBQ8jd2DRTFdn87YfNfUqmKhZJMuzPq3f3tH0BhZEr+K/4ikEnPcnK7Jlqosy8r4Bn/sCGB6iHuREQ8E5MS1gGVCyvy8YKh/gLfYcmdTYlvplUYavFgLLJkYb2t/gc0YyPOX76EQ7Jj/ohNXY+2dFfj4p7o+MivqCk06SxNq+qOzHd+EhdUp83h0C+hmeg2T1igUHYZaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0+FDfFoCYjFPvui98SI4sfnna3hlZf35WX925HBLzU=;
 b=L1kkM1kG8IWmTl1V0evjCkvI6sKMfwBpeSzTjGse0VuNF/JMJjbSI5Atx8XQC7Us/xKWsSpijuWHYYCzTX/JzZPajahEsABBT+CPYYsl/TLQu1/Vg7LoA/p5CBapTZArRdxXkLsWU8fuUOl4gUaD3O1nJq5xRflp/LgPYCp/3lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS4PR01MB9250.prod.exchangelabs.com (2603:10b6:8:280::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Thu, 4 Sep 2025 16:54:21 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 16:54:20 +0000
Message-ID: <59df0d38-82f5-42af-af93-4cdf33fa89e7@amperemail.onmicrosoft.com>
Date: Thu, 4 Sep 2025 12:54:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v28 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Sudeep Holla <sudeep.holla@arm.com>,
 Adam Young <admiyo@os.amperecomputing.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250904040544.598469-1-admiyo@os.amperecomputing.com>
 <20250904040544.598469-2-admiyo@os.amperecomputing.com>
 <20250904-spiffy-earthworm-of-aptitude-c13fc8@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250904-spiffy-earthworm-of-aptitude-c13fc8@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS4PR01MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: f563f7a0-4dfe-453c-50ff-08ddebd3b143
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZC94eW55YkwyTlZDVHc3bkZFOWlvS3pFZGhHUU1XRWtTL0UzWCs3YTgxQVdh?=
 =?utf-8?B?ako5OC9aQVpUTEJpcGUyUjd5OExVSCtGUVpIY0sybU52TElES2thaEg1clB0?=
 =?utf-8?B?MXBjRVRzTkFQb05nVXB4UUdSNnF3Q1RTWVplRFZZZEMzQmZsMjF1VTk0QlE4?=
 =?utf-8?B?SnRVVXpINm43THA0S0N6ZGtYUmpDRFVmdmRxcy9zenRsTCtjNzNKZjg1T1Yx?=
 =?utf-8?B?UVJDenZZQVEwZU5ERm9PK3c0VE9MR3plVkRNdnpGQXRjS2NIWVZWb2VnUkEr?=
 =?utf-8?B?OGtEblZ5MlNTcHpkNUl1MEZjdm02NWZLK2JoSFlhL3lvb3gxeFhIL051YkdE?=
 =?utf-8?B?WXFZV1BqRVFObUM4eU82UWFEQ1pYTUxvcWE3Vk9FYUNNUlJjN3JLUE5jK2Qz?=
 =?utf-8?B?RlFYa1hkdWl2cnMyWks0RjB0WlVGbWE3QXN4Y3JjMGtuY0h6NDgwRHNBaUNK?=
 =?utf-8?B?K2NjZHQzMGJ1QUplMTd0eDF0WlV6aTNtVDlzeTlMcVNLQ0hqUkljUm9RMm40?=
 =?utf-8?B?RmhIY0F2TUk0enBNT0QwK1F0eEIwbnJOSS8zZDZ3ZXFLV3BTTG9WWTVxNmds?=
 =?utf-8?B?Q2pnWW5QNG1qcUxNM0puRnNWb21VRkoxTHF4RXQrM1ZzQzM0V2IrbmdXalJy?=
 =?utf-8?B?OVNsY045Qm5acCtCY1lFT0swRUgyRXZ4WVF4eXhORXRHc3ovdnBMeG8vL0hu?=
 =?utf-8?B?NVRnaUdCZE5odWMyV09ibGVvY3NyNHFHSjVjeHh2OWRaampXL0NHZm1Qdkdy?=
 =?utf-8?B?eVZJYjF6ZEdmamh6a1QvL2FjSnVMczJ2dWNkbnBLOUxGRCtUbmpQcm5Fb2JC?=
 =?utf-8?B?bmI1cnYvRWhRbGM0ZDRHWjViQ1ZJMGF0a1BvQ0M2bmlwQk95cFdpd08xelJH?=
 =?utf-8?B?ZU9tZWpQWXRkc2NaWnljSUl6V1p5cTlWbHdJQ0kxU0RoNXE2OHVaV0RyWFNT?=
 =?utf-8?B?NGx2Y01mMVFyNTRETmV2WUVQOFYvaEdvUi9pVFZSS2lUaVNnUVVCZ0ZaQVJm?=
 =?utf-8?B?RkJEQXRDNzJJTHVxUW5BV3BmV05SNTl1anp3WVVZVnN4ZnB6V2t6cVBJTzcz?=
 =?utf-8?B?OWg2MDFFd2huSW1rYlMzV1JJTXZxS3BrZjFlN1I0WSsxdHo5ZnRkUW84b1B5?=
 =?utf-8?B?by9LY3BILzVkQWhzdnJPU1hzcm9vL284d0x0b21nSHhOUTIyRWpDK2NDK2Zw?=
 =?utf-8?B?YUYxYnc5RGwvMHdzNWNXaUF3T1lOdVg1dnBjaHhVZzBLWENRVVlieGdGT3B0?=
 =?utf-8?B?Mm85b3Jmb0xpcm1FMFVKQitWNHRJVnVYVDhrNU5QTU5pV2xadVgxQzBrbVk0?=
 =?utf-8?B?T2tBd1JiQy9lMHdaejhoQTd0TXN3bmVGZjl3bzE5WXgxWnVUTFVxb1UzMlRr?=
 =?utf-8?B?amxnY2VtZkZEZGZpdjRXcnpMa0V6WDRKZ0NFSmpRYjFsNWFQOWlZT2VIWnpx?=
 =?utf-8?B?eTI2ZzNqNGphc3NoRXd6Vldzd09jTFI0MTJ2M1JnWm5pS2xBR2h3Tjl0c1V4?=
 =?utf-8?B?Sk4wMHBETFV4VzZkNWZrTE9NdGJmYnZOc0lBZ0k1R1ZWRmh4b3J5QXYxSldM?=
 =?utf-8?B?ZHE4ZW0xYTVOWDZjSTFVZVJyN1M1RUtBeXk5SXVnZVprdVhnam00QTZ4NHN5?=
 =?utf-8?B?K1dPbXd4Qm1XT3JWdDRXREdVcG1xRzhlNEY5Nm9KcG9wOFlNUXUrYlJwK096?=
 =?utf-8?B?eG00YmY0NEg4MzZJWkVKTEU4VlQwbHU1bHFFZy8zUU4vYTNaYVZSeUEvRVRI?=
 =?utf-8?B?KzhyL3BXS1Rqeng5VHhNL0E2QURsZkdWL1AzUHhvYnR2NUJLalNSWFhlZnN2?=
 =?utf-8?B?dWcvQVh4K0dDd1hHU1pLbWFLM1dSVEl4NC9IbSttMTFSOGdSVTNMalgzaWdw?=
 =?utf-8?B?NUw3VEVGMElnbW5zbFNJWVNPKzlEdTRKQTIzR0hlWGNpc0FNK1gvS1JYVG0w?=
 =?utf-8?Q?KN9Ec5CBsDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDNnSkJBZ2s1RmdSdnNQMFQ2WHlxK0M3cTVHNWZUNlJ1bXRmWC93VEU1cXZC?=
 =?utf-8?B?ajIycEVCUUVqUTdQZ2N4SEZSQlBZWGdVZCtlZFlnbHBRc00xam5HR3ZCR3RQ?=
 =?utf-8?B?NmJaMEY4dEZOZkFtaTdONDUxQnJmVGxLSGg3Vitqb25ISkdFTkFidkQyT0th?=
 =?utf-8?B?NlpDSXpjNXYzR1IybzdNU016eWszRkxSUXFWUGVvcjFqZU4xSWcxTTZXeWt3?=
 =?utf-8?B?eTcwN3JMeHR3NzI3RUZFc2FZaVdXTStOVFhhQi9kaWtzRWp0L3ppUEJSQ3Fn?=
 =?utf-8?B?MU5yZE15UHk4RHFOQVpRTVVqYysxQ0l3bHYzWXFZZlo3K2lzbFp3R0dCWFBo?=
 =?utf-8?B?L0hoVFVjS0tFUnJSRkhXUDg3Um9PN0VNaG9wMHpNM2pCRUY3RWZ5TkUzcSt2?=
 =?utf-8?B?NngzdTVDNlR0SENLbURsbmlYcWo5c2ZrQVZPK3lwZXduUHB4RktwUEpHbXB3?=
 =?utf-8?B?bFAybHdGRGJ3d0tKTDFRaXhKUGxwUzQwb2loM2hpYXc2R2p5VkFNaGdqaHYv?=
 =?utf-8?B?dHhoZGxtVWl3eHczcDlOSDh6VzJxR1hDdnNEaVVxM3NlM1Nqa3I3TUNEL0c5?=
 =?utf-8?B?OFFqRzljWThOQ3Z0WnprMWhNaTNoQS80b3FNUFcwYlM1K1pWZmV3M3MwUkJT?=
 =?utf-8?B?R0I0aGVORDRBSHF5ZWlHQmJvWnl1S2lYbGM3S0RidWhvVFE2V1M3N1B2K3Jm?=
 =?utf-8?B?ZHNVQlljS0w4OUxuVkpQbkROMmZwS0hDN09JaHRJalNUaEcxSUxoWEZNblpT?=
 =?utf-8?B?SjRrMWhlYlB5TFZOc2RtVjRVWnlEa1EzR0VqMStyQUt2OHczRjBtdDdEa2My?=
 =?utf-8?B?L1FMQjZxMG5jcUcrY1dKd0ljaGRZQWNFYjY0THNZczB0aGFtMUJRUG5TdWJN?=
 =?utf-8?B?SFYya3JoWmJEUUlUU1F2R2JwNi92eHdTVk02WEoxUTRydGpXSDJqc0t1eXhR?=
 =?utf-8?B?d3ZwcTBWQzI0aTVwOU9CaWtPalNvTUxBVXRFR0RDMDZNMXZ0M2NUR1JTMHhl?=
 =?utf-8?B?Y2tMLzNERmx4Q0ZoK29nUmNxSFNtQnU4QWk0SjFjK2lienZGNVU3TWdXMEd5?=
 =?utf-8?B?OTdZWGczbEorQllOMmFqa0VSZmVBUktGVVdlYXhkUDFicFhQZFZDWnViSnBh?=
 =?utf-8?B?Y3Q2VCtnYmNvNUhIZURKblBmU3k0Nms2aGNuRCt3aTNFUmw3cktuRlAyelpu?=
 =?utf-8?B?Y3JIWUZKNzhiNC9kZ1hVS09peTRrcEJFWFQ0ZEl2UkhaaS9rekgzMUpyMUJR?=
 =?utf-8?B?dGUrNnlOSHBZdWtlcGNDK2RwQ25NRklXSTdQU1FWR1BZTFJvSmwyZ05uWWR5?=
 =?utf-8?B?c3dWNkl0VXY0SVV2WHllbml1ZkZMR3p0Q2o5WFl2R3NLaERCdU9TUWdSTzVn?=
 =?utf-8?B?ZnRuR0ltcEQzbXNCQWJoUUZMcU9TNjNRekx5V1FPMzJKbEFTTS9Jd1RScFhM?=
 =?utf-8?B?akM3ZWhFRkV5dkdIeDVCeW4yQ3ZtdG1pMSs5M2hXcFpOd1JZdTVTeVozSkQ5?=
 =?utf-8?B?MXgydjBLaDlleDdlSHJlQ3FMc3JBaE8yRS9TVnNDMkhocDlSaEtvb3NVdVBx?=
 =?utf-8?B?Wm4zMHd5bk82OUVlQzVubm11RlhBUkkxc0cxZzd6alJKSDMxaWhlRGVGaHcw?=
 =?utf-8?B?VnpRK042UEN5Q0lPRjhGWi84ZU51SHhhczYxaG1wTzJmbWk4eHNSNDVwdEFR?=
 =?utf-8?B?NFJBN3BQakpBc3VwR25PcDRiSTdBNVVDUWs1cEN5TUdQbWI0dmRpUFkzMjFz?=
 =?utf-8?B?TmVEQTBNTTFmeWlqNjBRMXFMMG9pQ0NJYjYyRlEvTS8yR0I2NDdBVWc0ODFs?=
 =?utf-8?B?OWtGQk9ZdGxRTkZXYWRaYldQVDFXekh5enJPOENhODNuQnJJVTVSUUZLVVBp?=
 =?utf-8?B?a1dJc2RwSEJOSFdaM0Q5a3hueXNBZkNTaGlqcHRXS0pYK0JCU0NvUUpzZEVx?=
 =?utf-8?B?aCtUYmQrTGluY2xRaFhFbnQ0akF3NmsxQUdHcTJ0TGt2RzhxTDl0ZkhIaFRu?=
 =?utf-8?B?a2NIVmhMaFJuUTVxRGRzcTEvZzYvbFk4bUdVTkJhdFZsSHREZU1pdmQyb2FG?=
 =?utf-8?B?U01pZS80WTF6WjlmU0JpV3Viek55NnU3ZGw5NHoyVUFtQWlxdHVkQkYwMmln?=
 =?utf-8?B?dE9NNk95cVl5YXdOZTdLTWVVTTNBVFNHWEVKTDZISXJidVZzL1MxTi9jR3lR?=
 =?utf-8?B?aVdDUUlHRGtZN2Jad3ZSd0d1RHVoZGZGSkRrVGFBOEFMMUJmS2trZkVlRU9B?=
 =?utf-8?Q?8n57wC7vvRpwhVW5uPaYk8TUdkXQHHBepPtghcGRd4=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f563f7a0-4dfe-453c-50ff-08ddebd3b143
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:54:20.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PncMpIA9T7t8JuyJKPrWBjasJgcpNZ6u/jSrmOErK/waLP8Mr3ADeryss4N/RJDV/HLFnBtkSF6NZHoty++5iHF/Ssq8d5SkuI+h5qEKooXpk5M3IxXgTFO/f8VrE6Uk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB9250


On 9/4/25 06:48, Sudeep Holla wrote:
> Hi Adam,
>
> On Thu, Sep 04, 2025 at 12:05:42AM -0400, Adam Young wrote:
>> Implementation of network driver for
>> Management Control Transport Protocol(MCTP)
>> over Platform Communication Channel(PCC)
>>
>> DMTF DSP:0292
>> https://www.dmtf.org/sites/default/files/standards/documents//
>> DSP0292_1.0.0WIP50.pdf
>>
>> MCTP devices are specified via ACPI by entries
>> in DSDT/SDST and reference channels specified
>> in the PCCT.  Messages are sent on a type 3 and
>> received on a type 4 channel.  Communication with
>> other devices use the PCC based doorbell mechanism;
>> a shared memory segment with a corresponding
>> interrupt and a memory register used to trigger
>> remote interrupts.
>>
>> This driver takes advantage of PCC mailbox buffer
>> management. The data section of the struct sk_buff
>> that contains the outgoing packet is sent to the mailbox,
>> already properly formatted  as a PCC message.  The driver
>> is also responsible for allocating a struct sk_buff that
>> is then passed to the mailbox and used to record the
>> data in the shared buffer. It maintains a list of both
>> outging and incoming sk_buffs to match the data buffers
>>
>> If the mailbox ring buffer is full, the driver stops the
>> incoming packet queues until a message has been sent,
>> freeing space in the ring buffer.
>>
>> When the Type 3 channel outbox receives a txdone response
>> interrupt, it consumes the outgoing sk_buff, allowing
>> it to be freed.
>>
> Sorry for not reviewing your mailbox changes in time, but I have
> comments/concerns on the changes merged. I will respond on the original
> thread with questions if I manage to find it, but it doesn't look good
> at all to me. So I would want these changes to be on hold(not to be
> merged at all).

Yeah, I was a little concerned those got merged without your input.  I 
will look for the comments.




