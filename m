Return-Path: <netdev+bounces-148562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09F9E2839
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A493B2F074
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4BD1F4709;
	Tue,  3 Dec 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Se/7OvOv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF21EE001;
	Tue,  3 Dec 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239473; cv=fail; b=OwuBHwd4BxvP7+1vlUhO1WtPfCj1leAjF47GUngPHVLxn4x9+3bu9CEs1RnshrLjWQYLzK6wCe4LEDTh+sCQb2PyvpDaVgXF3yT5YBbvSXpoD+bjUnFs2aaQIsY3Nh2WM1ylMoeUpmt4ZxJc165mTWGt0OMaAqk+PY51mW1xW/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239473; c=relaxed/simple;
	bh=Iw3lJ0PGm5oABSY/IW9CEVs+SS0HGnw52Kzy3i6vG6U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ez3nZnJhZ42ZBK+D9uF6XyZkjZxcz/mmLL0zjpocVCZR82OQyvEUjpArie+H92U2N1EEIVakSIko9ngAS9a0l35TTEcm12nTMPkco6ifDO6S6AWq73UTG0+CGYGBxcThErJjDITz9t2MQeGfYMJPZIEclxk1PUoaGFN4bGNHyEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Se/7OvOv; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT+JUgvrd7vEXnF/7MNE/QreR67W9BxFBcY27KEvE2tLDsriM9lt8Ntnhnq9vCnSY7Qrb15CX0mkJlos9wP3kMRuPwCMTLrJanTvEs5kafEVa/duiICzCRmekxgs6l7u6RNyS5wQU/8uA5niucEDc3Si0xBSxVHYHDqODKLT7LniTSTx4ru00n6f5RDjqPNFxbiTohSibCeNByBLLcCJ6kDoyDeFz9jCt/US6CQcXoVkI+sUY4ChKX3dchUm/AxAvPNu+woB5KHVzJvWbBhUyTci9+rDMweD6XIUH05gnbpfbhfiDLGsH93hMxpuMWULAwUwA5yYBhZqCeEEweN8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enMuWjTT/jU9pjJ3w81dvy3MtT7Jt/STuKcvTNSl/iQ=;
 b=N/y7MYoXJnffZUDZepgPcqliRr5pR3cmlu9KFy5FKbfVD9x8LZuoHM73dayQqkeXCAroeETJkowbe8J10BxEx3MFzB9LHuXTXrZLBWBGVcYQJH9JfYhpYhu0OmypuepCVG0E03lwafIg30l70O52PtmTEOHDo8DDTKnmrDWfFAWFSGBijfml4hUqSdSJRnNaDK7a/hhAQsQTl7QHGFjekw70suzW/UqgocH1miPIprm1c7sOl8rL/2yuTYLysXQpoqfun1xRg/cxRqXC2cdqMK0TTzGt0Uc1b5wkBnW2fiIdLmst4SyfgaEgamqP+s1nhb2lkM/aBacT07Vhu9l+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enMuWjTT/jU9pjJ3w81dvy3MtT7Jt/STuKcvTNSl/iQ=;
 b=Se/7OvOvlZMlq2wnwge6xfJ4h0Akt/vd8hgbSubHwqLslk02GTT35HMaOM8/rf6zbCroyOM5J3kqo6DdsdhraZNiH0oXKur2gBbvogZxzNzU6SIN9+9A378bjjUwDx0K6cYrmR0EGBSR2NO5IjbX6A/a42McucqxCWhwR/v/+IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 15:24:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:24:22 +0000
Message-ID: <e4784997-08ad-0300-0472-d4a98963000b@amd.com>
Date: Tue, 3 Dec 2024 15:24:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 16/28] sfc: obtain root decoder with enough HPA free
 space
Content-Language: en-US
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-17-alejandro.lucero-palau@amd.com>
 <20241203143408.GF778635@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241203143408.GF778635@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 89378585-17c7-42f7-efca-08dd13ae9031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTFUOHAwdHdNUys5MEtzcVRQUlRPUU9rTFgxKzMxb25kUjQra3VqbGZReXlS?=
 =?utf-8?B?U0o5T2VrU3BlN2ZtcmhPWFI1ak1pYzVzUVZWZlRCblB3cVkxRjBqZkNlbHBD?=
 =?utf-8?B?bGZXS2pNcGYyMnZ3MlVqY0QrMWZjMWlxTDV2VEFIOU82MGErSDhnNlkra3A4?=
 =?utf-8?B?ZnJuZU5JWEhUaVhMRHZQeExQNDZDb1Z6YzdLbkhpTUpobittd2dhYW13WjVI?=
 =?utf-8?B?UHVlZVp3SHhxSmZOZ3VpbjEyMTltcFFoMnY1UDN1YlFhS3RMVHZFc1RGY0FP?=
 =?utf-8?B?M0N5YUhCL3hURUxNRnRhMGp1cFJNNDRnU2ZLbDRvc2V5MGROT2xHdlpsYkRn?=
 =?utf-8?B?MU1qa1AvWFJ3ZVZaMTB1aTdyL0ZiNGtLOVhneHE4RU1CajNNMjQwTHdQSnh1?=
 =?utf-8?B?SzVZdWNxczV0VDg1bUhXbC9KUUdvL1hjcVBWRGpOMUo1MWh1NUJsSldHUGov?=
 =?utf-8?B?VG4xTWlDSUZ4ZTZQR2hpOHNnWE9KelNUQlpXU1VtbFFVZk1TRkludGpKamdr?=
 =?utf-8?B?VFdkZ3g2UW1kVEpwSWUxbDl5V0IvOEV3ZWFpbDJhaHJtSjU2NFNLbkxHVDVh?=
 =?utf-8?B?Visyc3FxdmxKM3pBYm5EWHVLYWdxTi80RDBjM1FqbGxjUzZiWXNic3E1QlYz?=
 =?utf-8?B?SnE5OW1tQyt0TDBob0YzamJYOEpiem1sc2VFZjZBZTh5bjhSUlRkb0hLN2F6?=
 =?utf-8?B?alRZcU1xRFdmNC9GNkljU2dNYnUrQmNJRjh4Ykt4TGZlS2JsRVB6WXA3YjZ2?=
 =?utf-8?B?ZEcyY01pVEJhNFROSEU5WGtWakw4OGdjT0Rienl6NHdpSTJLU0VVbnBITEtT?=
 =?utf-8?B?R1B0cW9lUGxMQmVDU0k4S1BTWVhMQnlHRTQ5MEM1NHBTcXVTeXN5dnE4dGpw?=
 =?utf-8?B?Sjc2dk9iNHNWUFRXYXFac01qaWU3K1Z5ek5nVmppeG1KQjkrd2w2dGNRU0xD?=
 =?utf-8?B?djFVYmRIWlY3S1FvNVhVMFdHZUpHRnRxaWRtZFg2QW9Da01ITElDRk1kZjg2?=
 =?utf-8?B?Ui90cWtYTzF6ODZBWTI0RGcyOWpDSzVCODJsT3Fwb2x4SEd2TE5GOTBIMWJX?=
 =?utf-8?B?V09QWkZYRVJVelFIc2JSSUEyQ0UvMUI4UzdUcnI4ZjUvblFEWmJaVnE5ZmtR?=
 =?utf-8?B?cDg0WmNHbHRVeFh2bkd0ZHlzdS9FYldjMUQ5UlRYbW1NM3JLRUo1TjhDejFD?=
 =?utf-8?B?azN5NHk4ZnE3L1cxRGM1MTFzb3VEcnhYcDFFa3NrK2NydFIySkRIK3MwdDlV?=
 =?utf-8?B?KzEvbGlINndWTjk2UlgrNXBIL2xLdUFFSGo0Ym5LcklGL3BOeFU1K3BmRHVB?=
 =?utf-8?B?aE9qMkhZQU5RMEtwWnJXVGxnRFlKVlNObW1zL1RLWXdjWVh3SkQyY1Z2RlhN?=
 =?utf-8?B?eE1zT24xejFKUXRTZUszVjk0R2V3SUFxcFk2Y0RnK21Jc1lBUWZTVWszdDVx?=
 =?utf-8?B?TE1IUGdHZ2FMK002RjdrMi9ZYnFKd1F5OE5IQSt0MytEV3VGUzhMMitZREtB?=
 =?utf-8?B?VHkwSjVaQVNEdE1NaHFDY1dNVFJ6TFZ0eng3SkJzUEc5T0laSzlMT1ZSSDBQ?=
 =?utf-8?B?SEliRHQzZUFkc3NoM3dhbjBKUUFBS0NxKzNiMjd5RzlncXJUeFk5OG4rTytX?=
 =?utf-8?B?TXlFL3prRjd3V24rVTFnNkxQb3B5dFpCUThqMVNVUmdYRTJIMTdMTTkwclpp?=
 =?utf-8?B?QUdoRVdOajNtQWhRNEhPKzBPUzcxSjNGWWtubzQxejJnbTZNa2MrRERFL05W?=
 =?utf-8?B?ZlNxU25URWFub0l1Y01naGduWEJzZG9EV2JTbGYxa2hlbWhxRC9jN2hic0Vq?=
 =?utf-8?B?dXVrZThYSWZLUmZ0S00vVkxhMFZDWEQxR1ZXTi81dDRIVG9CcEdRWUdGbE9j?=
 =?utf-8?B?VnoxT2VXNXRzUHNBUnRUNkR4ZngydktqNjJlODZTOWxPN0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUw4WVlxOFM0dDdSbG96dmM4MmcwMXFGNSt0VlZNRXcxZXoyK0NqeFFmTVVi?=
 =?utf-8?B?OTJLV3Y1Nk5oenYvWUovOG1GYVhpamhTaDhROTRNRmkyRE9oekVQZ1NJZi9R?=
 =?utf-8?B?U09NUEJXdDZzamlnZ2EreUduUkhSUnFMclJ0dU5sQm9yY2ZsanJsV1d0OTA2?=
 =?utf-8?B?USs2R0hVRUVHaDY0aDU0ZEFzNHlaVHp6ZTlKdTVTN0FrZElZRlIxM0VTU0xJ?=
 =?utf-8?B?QktRcEVqbFR1WUNHQmM5MWdnV1UyU2thQmlEQ2FtWS9TbzJLQU9xWHUySnh1?=
 =?utf-8?B?NGRiRVlvdjJMa3IvWE84MExRUzFiM2FtN1FkZWg2NDBjS2dDdmd3TUx3L2RY?=
 =?utf-8?B?SHBJRDNhUWFPU0RWTzB5UTFnYTExektocXBvUm12c29OSGgyQzF0aGNoY3lY?=
 =?utf-8?B?L2h6bTlycmJvTUlFSFhOQWhJbFYwcXhFQUhGNmVPV0xpTUl2NVBHMU1laE9G?=
 =?utf-8?B?SGNTRlVEek43TS9sU0FGWFhHT2FUcU1vTm5yME4yUUdPNDVVTFFLbUE2dU83?=
 =?utf-8?B?Vnk2VnBORlNNbHNicSt2VEVOc3d3QW5ydEdJNEtuRlE1QjZWaUZDNWYzbi9D?=
 =?utf-8?B?ZWQ4aUcyZU91VkFFU1NEeUphSzk4aFlwdmRCNGVZcWxlT25uM0hiWHprcGpN?=
 =?utf-8?B?eW9PdVROeXZFbVBNckgzcmVVRXVzYkZWR014MWFmeExCemJZdjBVNWFmMDQ4?=
 =?utf-8?B?UUV0SFA3aE1adjQ2cDh3ZDJXQVMranU4UlNYT3ZycmMxcEY4c2ovWFY0VnZu?=
 =?utf-8?B?UkdpQzJaZG1USk5DZ2dlejRZd2pvV2NhLzFyVTZxRzJiWnEvNXBpbGV0NnB0?=
 =?utf-8?B?anVqT0lTMmNBUGZOYWhTL0RMdm8wZTltSG0vcHhUNlNHbnlhbmFWU1grK3Mx?=
 =?utf-8?B?T2p5aFNtUDhyaEJyc2Vwd2VvT0FxM1habGpGNytSNWtQQUVNWUMwTUlXd0c4?=
 =?utf-8?B?WVoycU0zVHFKMUxTUlZncGhyQ3RZbnNTSVJRQnNlY2JIaVZnYk0ycWd5YWg0?=
 =?utf-8?B?L1hzQWFUaUVLOFoxazhkelVHTlBHaThSSHFwNG5xWGRVZ3M4Ry9ucFdFYzkv?=
 =?utf-8?B?NUdJN0pkSi9HcThMc3hSb2NjcWJMeE9rd1A3b3FTRVZpV3JrR1RDam85K0ZV?=
 =?utf-8?B?dHdDUFRtcHFHcCtkYTI2SVpUUVZ2QjZEK3YzR1VYeC8yenF4TWh3WWRvdjY0?=
 =?utf-8?B?UDNIYnRMSGhpekdDaVl6cnF2eTVyTm4rcHcwaEhYOTErNlBZYUxncDA5UHFv?=
 =?utf-8?B?TjJXNDN3UlQ3VjIxNjJ3dHpQVkJvKzVEVkczRXBvM1Z2SCtPa2M0NFhRcWkx?=
 =?utf-8?B?MmNJaU1ZNmJYQ3lsVjZtY2VVbnlNdjhGNGJIWFNETC9GUkluYURvY2xtMUtK?=
 =?utf-8?B?Q1hNRiswblZyT0FaMjJxUUVUK2x0MnRzNndBL3Q4cUh4SlBSTisyVFFSRUxa?=
 =?utf-8?B?ckV6WlFsd3ZUM2pNZmNYNmZub2VSVWY4MlBtV2JVd01icDd5S0d5amhpYTB6?=
 =?utf-8?B?Y3JYOW1reWVsZFZCZmRmUnMvWk9hNTNyYTdoZDB2TEtRYjdkSVB4ZERJY1Rk?=
 =?utf-8?B?dC9BV09DR0hCVHFFS2txNXZLb2U0Q2E0d2FRSE1aS1BMYXRXb0Q3R1A0eGFS?=
 =?utf-8?B?Q1Y5VHIwLzRkY2svNVJBS2drOGxNcUdrTTcrQXVvdWx2SWN0ZnhWTGdFQkIy?=
 =?utf-8?B?Rk9ISGJtRjUrbExOM1U3Mzh6WSs3VG5TSG9oL2YyYTFjU0UyZVZyOFR5UDRT?=
 =?utf-8?B?WEdGeEVtN3MxY2hVK2FQNkpRMlpaOEtoQ05YV21rcndZamw5ams0UDgxclE3?=
 =?utf-8?B?Z3ErTGYxOENuZFFON1lFSkhqTnF3dG9KS0dwKy9taTJjaHI3V0ZxdEt2NnVL?=
 =?utf-8?B?TkpGTVlnbXliTmdXRHg3NTcyTXpsYjViVytVNFlPVDVCNjJrb29oL3VMZXZu?=
 =?utf-8?B?VVhQRmdqdlFkRDFaSFlFQ084c2V4aXAxTVpjR3l3Wjg2TGFWMWp6QkwraXpv?=
 =?utf-8?B?bFlEVUxMa01tdlBuV2Rrei9uVXF5THJUL3BxekR2QlpLWTN1NURLcG9zTDNG?=
 =?utf-8?B?QnhhVlNtLzFVOVJidmF1eXB3eGFHeEY1WjB1R0JOanNhTTdqSm43RitOWGFE?=
 =?utf-8?Q?ywpheKewJG+7xHIH6kk5yXlzq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89378585-17c7-42f7-efca-08dd13ae9031
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:24:22.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8Z5VCP89jNml3OG8TcrojtKJUyIIbo5+334PdmyWken2ABsdl2CY094l+Dx6/UZZkcqdTY8JVuG58S2zNeGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740


On 12/3/24 14:34, Martin Habets wrote:
> On Mon, Dec 02, 2024 at 05:12:10PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Asking for availbale HPA space is the previous step to try to obtain
>> an HPA range suitable to accel driver purposes.
>>
>> Add this call to efx cxl initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> One comment below.
>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index d03fa9f9c421..79b93d92f9c2 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> +	resource_size_t max;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -102,6 +103,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err3;
>>   	}
>>   
>> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
>> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
>> +					   &max);
>> +
>> +	if (IS_ERR(cxl->cxlrd)) {
>> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
>> +		rc = PTR_ERR(cxl->cxlrd);
>> +		goto err3;
>> +	}
>> +
>> +	if (max < EFX_CTPIO_BUFFER_SIZE) {
>> +		pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
>> +			__func__, max, EFX_CTPIO_BUFFER_SIZE);
> Seems it should use %pa[p] for max here.


Yes, I was looking at how to fix it after the robot warning.

I'll change it.

Thanks


> Martin
>
>> +		rc = -ENOSPC;
>> +		goto err3;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> -- 
>> 2.17.1
>>
>>

