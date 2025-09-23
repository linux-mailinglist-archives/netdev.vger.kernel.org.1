Return-Path: <netdev+bounces-225563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66449B95726
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0127B4479
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70AB2F549E;
	Tue, 23 Sep 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G3JwxiiX"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619B2745E;
	Tue, 23 Sep 2025 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623710; cv=fail; b=uQLdKQ9prF6Cx23/iA/Rmc8SbETWisdStXbil8+uiQ00Xq/dQbcIkHoM8uqEupuYTzEfDt+bTEzKP9qXqQm3zmCoUTPJF8MqjsUfMP4PaBpG1MZlyh8+hdg+FKZZvMa+r9OLrtWt8wtgdbSjUC4wTElLZbcrMsHf2t0lX3x6q6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623710; c=relaxed/simple;
	bh=AXT1jb5wQ4J2YSnd9aKFuKhBpzoHrLYjL8SHXANQZdk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHi2hDwc7xBFcpFGK2eZjX9Y5iuQB9zzBCizYGrymMeyCyZFPabQM2q835F99aHtLPQLSuefQM6j7SjhK1iHAGd1kylKVtg/Fxk3HA6ac9nQHThWIyCENMkKC//cxzCq5Mmc/8C3ILa+OjQospIVi3OPa2kpfElDe3RgtrYi1VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G3JwxiiX; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylT+mdHSPhBstE4vSm9PX/U46kiG4o8p5pq3qqFUSkc7+VmGnHmnyfa4vAW0lHRodS5jsxgX9k8dWslJZ6h+YSn6F/8WDOCYoF6Fng40H1MQAJrXpDEdHTB8VN+dexj4ttqGyO7FZpnD7GXlyd4xF2TGdO9c4W4pOwAHlxZr726qFlMNdRh3skdBkF0FQHE0X1SyIVLtyky6n3gYEAG323pJce7ly58aZtrsdbUU8WzMApHUw15rlKh2qBu+G9a8b9/x8/fm6gxcBC5VvlrD2+fsbeanvZg50oSUHa/ACUQYwn8H1gAXb7uYAbqR5O7zJpNHr4INtyQw7ctKojPR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfaIUI23sEeBbZPxqTJGOAJCRCVouLjHGeT8SN1EbOo=;
 b=U8SVSgMsCDvAC19PiKkBFYmK/02pu8THtkaHXL651btSwZuTaWZg04sh3hkSnPBMvURQDk03pOcdAIZLaqMb9moWW2EGJikEHjyBgOwHdZ0P0lCk5zyt7kXpjEBXQ72XGIg7cZECMq7hRVE+uVJ6TlASfjONG4k3seWFsv+QWYHNkxqQXRygqWJzaVsA6DlOb7VzpIgFRy1MwTOhFRsn3kvJWjMv9Ohl/tIzXw9kcFuI55pRdpB4yKOnsca49On/f1LWRh+6iAkHiLmfRTWHVFZqu59e3LAATSeKMZmLHU9yxJnh+OUA87bXHzvUpPl+C8jAx4UT3FJJa79yAacq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfaIUI23sEeBbZPxqTJGOAJCRCVouLjHGeT8SN1EbOo=;
 b=G3JwxiiXjbPOwh13Sb1bSIzMZdLjPdUzFFqxHirCuUEoN2ZCIvSrghgsZZKMkJ9zWiaqShLrxXW1clagiiZ0+8l1vnFeXZcbfiaWw7jZQO2BPoyOvQuCLPdwYqxgjo3XKhe5NVp0xh8pxv9hWftf3YlpgW5JdA3zwTg2IgXJymY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 10:35:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 10:35:05 +0000
Message-ID: <0b36e5c2-2f15-4e83-bf4b-c4c15f55d3d2@amd.com>
Date: Tue, 23 Sep 2025 11:35:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 00/20] Type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <33f5b788-c478-4279-bf9b-a5fc1000bc23@intel.com>
 <c012498b-d9f9-439a-a926-ef5f10689bf7@amd.com>
 <aea329a3-9cb9-4552-88e7-2b354483ad53@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aea329a3-9cb9-4552-88e7-2b354483ad53@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0222.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: b28ec2b7-c8ab-4ca8-372e-08ddfa8cdc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTdsU2h5Z3RBTUJhT0x2NW9VNHEwVG03THo1TDhNMDFtSFhjbDY5aVZ3RmF1?=
 =?utf-8?B?R3lDMVF3UkVBNGJHT0hrZW1qWnQrNENrV2xicklwMjJ3cG5sYytPSUorNkpr?=
 =?utf-8?B?M29QbWxpRUcxY1crMFA4NFhuNFQ3YjNrQ2Z4NEw0bE9hS21kektLZm0wWU5m?=
 =?utf-8?B?emRQQlhRTEdiRG4zSmxtZGVBMlIvMDVuQXBGRmdFSCszdU1hUXBFaGsvUjBO?=
 =?utf-8?B?ZTVjaFUvbE5DR1dXVTBmdkw0NzRtVkhuOVhVZmR6LzlFVWRBZHMzQlplSDl4?=
 =?utf-8?B?T2xqNm1kam9qYjhad3pkU0MzN3Y0WDR2SFBQYXFFY3lUVmNndUMxY0MzdXAv?=
 =?utf-8?B?NTBielNwR21WT1NFQkdyQmxFT1JuMGE1enRUQ1cyZFFXOHU1YjAzNXhhN2U3?=
 =?utf-8?B?M0htcThBT3ptWDhxTjhGN21NQkFpRTkvbitEYW92ZlI0RnRpa1JPQlVsM2pZ?=
 =?utf-8?B?QUVydU53SHd2WGdidEdhRXBKMHYyV1RJamxUV1JwSFdIZm9Ed2NHUmdlMFVo?=
 =?utf-8?B?RFVJM2x5WG1HVzBrTFM3akRvbTR6NVVYQlVBN1NnTEpFMjh3OU5jbFVWN0NX?=
 =?utf-8?B?ZWx5bVU1K3lCZHdtdWRKYzY5N0Vyc1JCc2dNU0RmOURhR3hjbldoenlWWGFP?=
 =?utf-8?B?TWRBR2lmZFIyMGNPNm9RbmxFazJuYzR5cmtKajc4NHdPQ1orVEVRWmJtcUcv?=
 =?utf-8?B?cXA5Q1h4dnRJMDZwSHJwa1BUSUNTYlRIZDNlSmY3U3VHTmlBZDdGUi80VWNT?=
 =?utf-8?B?YnBoSHc3blA3cmtlQkphUUd4SWROYnJSOHhhSG5uTi9FUlIrZTNaSWkxUU1t?=
 =?utf-8?B?cFdMUjhVOCtvUVcvUlhqNkM3emZOSXdINGRBUTd6SWNYd0hMbS9VeUp3aWYw?=
 =?utf-8?B?RWVCY056Q2kvZENNaU1EQXZYZkhUckJtZDhFVUdJa2p2VGN0SE01SHJjVG1h?=
 =?utf-8?B?OWVRVHFEeWtHR0pFQW5jc3ZWQSs1N0NUYllxeGNVOUVLMGZTdTFxTG5rb05w?=
 =?utf-8?B?UTlGZWpJZ1BEOW9CcGJ3WkRzaWh5MVBDL1ZPWEhPWmxhNUdLcWhrdmprOFFE?=
 =?utf-8?B?dXpIRkNReEZSbmtuZnlONTRoOFltQjdva3Nsam00RlNadS9NdExyb1pWbWhP?=
 =?utf-8?B?RXRWaW9yWVRXMU9aamZTTnVFRGxFQ3UrTmpaQTZwV25mU1JaNFl6SWhtY1ZV?=
 =?utf-8?B?dW13WjdBSk95UGF1V3RWVlE0ZEhJLytia2xIZEZuaFZ0cTJuTEYrZGI4RlUw?=
 =?utf-8?B?RVByYzRSSUZwTDNXRnJkdnhIclhFUHUyQStMQnM2bUtyaHFPaU9RN3F2ZU1M?=
 =?utf-8?B?aHcyRlA5VXpEbVdYU0NtdWc1QVdjYnRTbmVaOTFoL0hIMjArQ2l6bE8vL0RQ?=
 =?utf-8?B?RlQrR1NaYi96ck1BdHlMY0hlT1ptNElvVWtLWk9ia1B2U0VJNHNEa0hQeDlK?=
 =?utf-8?B?U1B6clpZU3RRblFUemlLc2NySTJYemJKUnhTRWNUWmI1cTJSdk9aRnRldTVp?=
 =?utf-8?B?WlRQYmVaU1U2WUNncWRpOGZXTVJsZ2NxNGloZzI2OXBXU3BiV2xxVlM1Y0d3?=
 =?utf-8?B?TGJjRlZyOEZOMjkyWEw1eWlDREQrL1A3cFVkTWd0c2tubHprZlBsMVdBYmJw?=
 =?utf-8?B?VStlalVDc1c3cWZLdStaYTdYMG5EakJOTEd0b1RlRk55c1NmaFFsMXlCVEdO?=
 =?utf-8?B?SHJibXMzTVJhTUdvd0owNm5rUTh1ckYwdkR0ZXBYZkNqY3JpdUU2Z09ndUNj?=
 =?utf-8?B?Tm5GbC9WQlhzNW94VVR4MnZVRENTY0VtTWZrMVpLSFd3aVFEdFcvV1QrUmFt?=
 =?utf-8?B?S0lFUHlua1p0QjQ2azBkM1dxNUloZHI3WmdDZS9GT1VhTU5xYW5DSGRkYzZ1?=
 =?utf-8?B?bFlkd0N6RlVIUnJEcWdEQXFLeW1JbUJ5K3oxa2FBK0J1OGp0cGdBRzg2ZkM0?=
 =?utf-8?B?Ky9Eb0hxL3RVNUxxN2c5cFRBZThIOWZ1Tm96NHRkN3o3aG9iNkNKellhWisr?=
 =?utf-8?B?V0thVzdxK25BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUgwSUsyTW9nTURjYlhGa0NSbzVwMzV1Y2RZSTBzbGdtbGZSWnd0TlU0STFZ?=
 =?utf-8?B?NVdYYVBSRVViTHpkUUFOdEtjT3lJdVNJSjVzYlg3aE5CdDFTR2krV0g1a3NB?=
 =?utf-8?B?Nk52d0o4RlVyRzZyc1ZGUkVubXRGTW4zSW8rTStWeW5qSUNycGVhT0ZydktM?=
 =?utf-8?B?ZGxidCtxWXhFYmtrbGlkUE8yVzlsWWZYOERyL05LTzVwT0VNcFFrVGtPamlE?=
 =?utf-8?B?ZE5lVWtRdGFuV3N1YVFpNC9TY0dhOFNTRGYvb1NkcWcwZ0RYU0dvV1ZBaUwz?=
 =?utf-8?B?NzlDUkc5Z1owWnhOMTNHTExCT1JmVCt0YnRZa1FpZUZlNjBEZWVERjZPbngw?=
 =?utf-8?B?eUVGMmNXRzVFM1Q5dFlwdEhuV0FDa2lac1l2YzRrcXl1TlYySEhOSGdWT3kw?=
 =?utf-8?B?ekVEV2szVUIvYmdXQklZTERSMWFOZmhLVVRxanEzUDhFYnpWVFZuRmRGRHBZ?=
 =?utf-8?B?WERZa2dzWE8veTZrVTAydDFkZ1lSMVloVW5udGoybVpzeGJ1ZFhjRU5zTTZw?=
 =?utf-8?B?dWk5eHJUcXpPMzdYSHNSUVZqWjJFUHhsRVBZT1VyNVZUeGFHZEpRQlYrNkgv?=
 =?utf-8?B?Q1ozMG5XSGxEV1A5WTNZY2hVYUI4NlhMOXgyMEtPY2xTSzd4WjR0cVJuOGNv?=
 =?utf-8?B?SUNkWmxOaTN0eVdlS3FDQTl6K21CVlBqV3UrM0NLL3JhZG1Ka1QwNExYengy?=
 =?utf-8?B?bGJEYWpXMHpHSDhIaGw5TXBhUk9kUWpnc1NOR2ZyWHRWc2E0MDk0TmFhZ2Y1?=
 =?utf-8?B?OUhJcGY2U1RNcFppSUVpb01mWlIvRUFiM0pXNEZUWS9wclQ3dDdBa1hLdXlu?=
 =?utf-8?B?bmhHRjJoMkhQVktoQXhyaG54UDJ3eER6eDIwTGhkRi85azI2TlVqSm1wS0FK?=
 =?utf-8?B?aCtpNDRsK0I5TEIxWVIrS3FDMEsyS1lNRmdWelp4VDVWU2c5ZXNkUFByU2Fw?=
 =?utf-8?B?ejJpVEdCMHNSR1ZKMDBSZE5vVkVjejJZR2lSbngwZkhSUnZqODNlZnNycGkx?=
 =?utf-8?B?emdrZkhyZHVoN3V5RW8yZFo2TlNBMThXcXI2ZzJISjY0YWRIWVpPWGJOdWR6?=
 =?utf-8?B?Ri9vZFM0UWNWM1VCUWl6V01TUW5rUkloUSt3SnNWUzdzRHVabStDMDYvOHBZ?=
 =?utf-8?B?TGlxUnlxV2QzZzJsUlVTb2t5Qml5UlN5eFBYcmFqSWNBUkx3bndmRE8vNkll?=
 =?utf-8?B?R2lZSE04empScVpwcVI5UzEweGNiRWFlRVhVNGdvRHN4YUVqR0Z0LzBEaSs4?=
 =?utf-8?B?bTFaYjRGeTdaL1haNGRydlp1ME1Id0k0bjR2Um10eERZcm8rMzNwMndNQjdn?=
 =?utf-8?B?SDBmSmpOL1FOZVo3SXdSYXd6eHI5ZVJ2SFMzRklpTzlCaS9HY21GUmNVOEl4?=
 =?utf-8?B?MHpGQVo0NENvbXE1R1hzZU1tR0FzSHdhLy9naHpmNFNCWkdFYjdZL3BKZ2kv?=
 =?utf-8?B?VUJGWFhyRXdCNnoxODhreTk4OG4yMXZQOWFORkJLR2JrdlZNU1lZb0FXTjVu?=
 =?utf-8?B?Zlh3dW8zUUxLY1dFUEFWOXdzZlhwWEJzOU85OE90bEhzQ0hzMEVKY1FHSVBu?=
 =?utf-8?B?emdrYjV5NHJUYUtZNlIyeS9sejJTWXBFOURXdzgvVUtLWUlSUkp2M1pYdUpD?=
 =?utf-8?B?VmpEM2xjTlVMS1p0QmgxdVpBdmRFNTQxUHI3VEZtUGNUbjErc3R4Y2tUaVRw?=
 =?utf-8?B?dWtiUGtVVFhwY1dQdkI5Zy9LY1hYaEtudS9Reml5VGZZQVl2Z2xEcVlFR2FV?=
 =?utf-8?B?RkdnMlM0cDhMWlFPK1hscWJrTVJ5U2NVK3NOckdSSUVZOXdvNzFYUi85ZGU3?=
 =?utf-8?B?ZWo0NFEzeFlEMlNMNjJWcmZQY0pCVDVZY2pFMWJMOWhZVmltYzZpTHJJVnRP?=
 =?utf-8?B?MUV4UCtQTWkwVU5IZUswWjNIRkFuMlVOWHg5VS9BQ0UxWllKVmtKZUd0UUt1?=
 =?utf-8?B?Rit0OXhUdkpEbEJDb3JteXhweDVkVGcvRHVvODlKWUtzUGNYUk9XQ2NqODlH?=
 =?utf-8?B?c0d2bE9TQmJrMFhyZEp0dzdNVHl5ejhoUEFCS0RoRmM0SjVUN1VJRmZySyt5?=
 =?utf-8?B?dmlDTENsa1B6ZTJMbjIyekpoNTJHSUd4NG1zdTZJaUdyc20zMHRjdDMzVEZC?=
 =?utf-8?Q?RLO2vVHpguAOo6pcC/6AJgQg9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28ec2b7-c8ab-4ca8-372e-08ddfa8cdc50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:35:05.7664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1+SYtTtU5awqdHGrIzS2E80zvpIad6p6EndggG4OXApZN0OOVkOqfct5ZV1VspLpY4r9bnJ6g1V1IhicByNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717


On 9/19/25 22:42, Dave Jiang wrote:
>
> On 9/19/25 9:55 AM, Alejandro Lucero Palau wrote:
>> Hi Dave,
>>
>>
>>
>> On 9/19/25 17:26, Dave Jiang wrote:
>>> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> First of all, the patchset should be applied on the described base
>>>> commit then applying Terry's v11 about CXL error handling plus last four
>>>> pathces from Dan's for-6.18/cxl-probe-order branch.
>>>>
>> <snip>
>>
>>>> base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
>>>> prerequisite-patch-id: 44c914dd079e40d716f3f2d91653247eca731594
>>>> prerequisite-patch-id: b13ca5c11c44a736563477d67b1dceadfe3ea19e
>>>> prerequisite-patch-id: d0d82965bbea8a2b5ea2f763f19de4dfaa8479c3
>>>> prerequisite-patch-id: dd0f24b3bdb938f2f123bc26b31cd5fe659e05eb
>>>> prerequisite-patch-id: 2ea41ec399f2360a84e86e97a8f940a62561931a
>>>> prerequisite-patch-id: 367b61b5a313db6324f9cf917d46df580f3bbd3b
>>>> prerequisite-patch-id: 1805332a9f191bc3547927d96de5926356dac03c
>>>> prerequisite-patch-id: 40657fd517f8e835a091c07e93d6abc08f85d395
>>>> prerequisite-patch-id: 901eb0d91816499446964b2a9089db59656da08d
>>>> prerequisite-patch-id: 79856c0199d6872fd2f76a5829dba7fa46f225d6
>>>> prerequisite-patch-id: 6f3503e59a3d745e5ecff4aaed668e2d32da7e4b
>>>> prerequisite-patch-id: e9dc88f1b91dce5dc3d46ff2b5bf184aba06439d
>>>> prerequisite-patch-id: 196fe106100aad619d5be7266959bbeef29b7c8b
>>>> prerequisite-patch-id: 7e719ed404f664ee8d9b98d56f58326f55ea2175
>>>> prerequisite-patch-id: 560f95992e13a08279034d5f77aacc9e971332dd
>>>> prerequisite-patch-id: 8656445ee654056695ff2894e28c8f1014df919e
>>>> prerequisite-patch-id: 001d831149eb8f9ae17b394e4bcd06d844dd39d9
>>>> prerequisite-patch-id: 421368aa5eac2af63ef2dc427af2ec11ad45c925
>>>> prerequisite-patch-id: 18fd00d4743711d835ad546cfbb558d9f97dcdfc
>>>> prerequisite-patch-id: d89bf9e6d3ea5d332ec2c8e441f1fe6d84e726d3
>>>> prerequisite-patch-id: 3a6953d11b803abeb437558f3893a3b6a08acdbb
>>>> prerequisite-patch-id: 0dd42a82e73765950bd069d421d555ded8bfeb25
>>>> prerequisite-patch-id: da6e0df31ad0d5a945e0a0d29204ba75f0c97344
>>>> prerequisite-patch-id: ed7d9c768af2ac4e6ce87df2efd0ec359856c6e5
>>>> prerequisite-patch-id: ed7f4dce80b4f80ccafb57efcd6189a6e14c9208
>>>> prerequisite-patch-id: ccadb682c5edc3babaef5fe7ecb76ee5daa27ea4
>>> Alejandro,
>>> I'm having trouble creating a branch. The hashes for prereq don't seem to exist. Can you please post a public branch somewhere? Thanks!
>>
>> Did you read the first paragraph of the cover letter?
> I reset to f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
> I was able to apply Terry's v11
> And after that I think I'm suppose to apply these 4 right?
> ab70c6227ee6 dax/cxl: Defer Soft Reserved registration
> 88aec5ea7a24 cxl/mem: Introduce a memdev creation ->probe() operation
> e23f37a4a834 cxl/port: Arrange for always synchronous endpoint attach
> 595f243eeac3 cxl/mem: Arrange for always-synchronous memdev attach
>
> It failed on cherry picking the first one: 595f243eeac3
>

Hi Dave,


My mistake. I did not remember I had to slightly modify Dan's patches.


I will send v19 including those patches and working on the minor issues 
from reviews.


Thanks


