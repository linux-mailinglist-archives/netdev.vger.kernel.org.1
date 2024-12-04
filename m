Return-Path: <netdev+bounces-148916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF99E369B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39C416927A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C3187555;
	Wed,  4 Dec 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sTBYSVPy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D018E056;
	Wed,  4 Dec 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304628; cv=fail; b=j1YCK3PYPRg4SAOxXyFTcRXxevl3opNNtYq7TxyZTgkkJR6YVNKO4OHYagrLamKyiNIz+eTuphXCr7huzc+lmnmzAD9b+hPr18hgs5Qlh5k6gIkgGFJMDz2XJZS5if9nKEFHJxbaYJMwlru7dQ1KGm7mjsl14pDolNtzUG/pE38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304628; c=relaxed/simple;
	bh=rhPg2S2Tjw9LSt9601LU7qr7SU8HoLmrA864J57scDw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AzWXqLh/xTTfB0QBG5hN21dT0jcujhDDxLb5OoKwal6FtqRXfEPRlBzMktvqMoxbYJlPmJoLzqF0ES2lloGGuPy+ZIS391ztUfv06tKqAMhT302GcIzGiZ1pjSIac0ypJayWjm3CU7488vo+yvxhICaxXKnLisdue/tx1lnVjws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sTBYSVPy; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSQlfCvb5OpPD1fyZsvCmpk2x5pymmcSHSTlEFHYIJM877lZ5I32WpeqOWzIZr77ajbx0mRB0ex4Qo9Q0eeEf2D2BRvzRzkKTDgZO6dLWNs4bvhUQH6TdzSXk/tI8TL1x6V4wkrAQ5CSqe0+8qMj5LxItrs+rvWjBxhWVwkJs93/O5gJwnubSYzDihtHivSgxaKb59wbA4vMotOfpK+Fiy0aS8ZmSKOSXShF6qG97AK9z/GtHk0GJUnXUeEuFPvvBwpYWn91Gc7eDPu6Wmu66yYLepFyhLS78wdGqlnvaYffd6qJQH52h82UY8roZvbrh3hegC8m7yrxj9dndQ74Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwECQQtOGH/c80qytBAcYr5h0Sj3AUV5pjPzjFb0/QQ=;
 b=QCkjqF7apVSRxGOq5wTnIzYs64d3uG6WgyOxo/fJ2dXM96W//pAO1swarQGhPmtb2HbsXAHHc7l8o3MOvqlOCN0JRIWRVRWwrLfoBS0A85d0+3nIEEwaPOVjC80jD9T9MeJ4qPoXeEfuBoZddmF0bwQwDjSctyfxWCMlBTobkfW+mucmLmUUDhs7Oae64fFJbfrOnhWStDALGDCzCVr7nTKNKV+NMsC4NCYA996AqjoCDEhwPNVIxtq1DQAVHFQs6jgpRzp1PcmJzZO0pmq82wmgra/FLBlyIyY+e6eFwzSqvwdfJzsDt7vLrWxJOqOy7UL5l/yUr5FSAtgppQBK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwECQQtOGH/c80qytBAcYr5h0Sj3AUV5pjPzjFb0/QQ=;
 b=sTBYSVPyEQaiP304PpKIqKN2XFu4Hh2FxKAAzv3gD/aWxuKEIC25uKeCkSRbFZmgaZqjw4CRmlJ/tRoBkkpjiwQoGpQQUs2cFs+SXwrdGf4vP1yYgzJddNvSFD13WkZtGKOXoBanLbJGXcRkMNnckOcZ8d0NqDoHLwmU0GHxQn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 09:30:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 09:30:23 +0000
Message-ID: <ab476f51-de8a-be26-4dbc-f462c858d8f8@amd.com>
Date: Wed, 4 Dec 2024 09:30:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 02/28] sfc: add cxl support using new CXL API
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-3-alejandro.lucero-palau@amd.com>
 <66ac91f6-b027-3732-882a-4b5f32edfaf5@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <66ac91f6-b027-3732-882a-4b5f32edfaf5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0638.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1d2a66-43df-4169-0103-08dd14464752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qkw0VFpocjJDdUdJblBGY29UenIyNjVCNzQ2a2VFMHJPeFVpZmxMT3BseDdo?=
 =?utf-8?B?alRXYXpXSnc1bzM5cTgyK1JXcTBrQ0Y4VkJQSG95dG1KUm85QzFNQ2VISUFo?=
 =?utf-8?B?TitHTSt0bWlBRTZ2cEF0S0pTd0p5cXVsclUzY2Z5VXNpV0E3VEdpZkxkOGRY?=
 =?utf-8?B?ZnNwQkErNUJKMFgrZHcvTG42QmpjalFLWmN6aE9XQWprUUZZVG8rZUk4UkxS?=
 =?utf-8?B?ZDJnNVMza2dzcXgraDZicU5HZ0oyZ1VvOE0yODRXVi9ZSll5TTRGSXpXMWs1?=
 =?utf-8?B?dkYyZW0vbEhtSHhEQmRGd0FJem1LWksxMVVBUXZHUytIeWdvZWdUMHA5TG5G?=
 =?utf-8?B?NVdFaDRHSXF4bEJEaHdYOVo1NUNDUlNLclYwTkhBOHc2ZlFkN1VwUmtJbFBq?=
 =?utf-8?B?Uk54c1RVSDQ5WC9SYUY1R2JtdWMxcGFaYXYwRWhnRjlxRTZpVG4xMnZha2xl?=
 =?utf-8?B?clZrZW1HMEtRMVJUK2EydjdxUWVSUkd6YVZXNTQ2VE9NM29mN0ZIUjdkZVk1?=
 =?utf-8?B?MmRJYWg1bDBYNVZ5OGNhd3hja3h5NjNVcTBXaXJjdTJuMUFLQjB1MzJlSkc4?=
 =?utf-8?B?VUdZVnQrRnBGOFk4NlhhdmVHaTNMTi9NVzBoQUpYOTZqNXpuQmZCQllXeHVv?=
 =?utf-8?B?em9raFpHbkRHWkx4TlZhV3cyQzdtRGs1YW1EcVRlMHI0MGRCWDVOK1ZmaVJX?=
 =?utf-8?B?WnZlUFBtcjJEWGpYenFuelBEOWFGcmtobWFlNFdjQU5icHA0OENINmtDUExu?=
 =?utf-8?B?Qzh3UXRwTnhQWTZBYm80V05selc4RTJaa1BBZW85QmlyRm5aaDFwUkltNUdj?=
 =?utf-8?B?alhCZEhSU2dYRXdjZHZCUWVCWWlqWVVhS2wvaC9XeWYxeGoyK1Q0aTQ1WVRK?=
 =?utf-8?B?SWU4ZEppRWVZMnRUSzNKU21qSnpXc3ZhNlJmU2dUUnY3cmdheUhDQ0JyRXVP?=
 =?utf-8?B?ZHB5UE55SDVXTE9oOXJHSUJFM3JHMVptZTJiNEdkaVAxMktZcVFkUjlSVlM1?=
 =?utf-8?B?Z1RyVmxtY3l2bWZGNm4zR2QyUzZXR2tSRWc4UkVNZFhQOUJUSTYzY0diN1R0?=
 =?utf-8?B?YjZOZEdHd2RtTDZlOVZSR21FTG92RnNBcWxiZzE3UTlVV0ZTSU9xUHk1ajFt?=
 =?utf-8?B?d1hWQ0prWnd1WTNDVlpOVmVXT0RYOGpEOTFBSmdWYWtJTVVOTjRQQlppTnFi?=
 =?utf-8?B?MVFMUXVDd0JocVg2Y3NRMlFIM0tKQ0lOWk1yTXBXM1JUZmlXdDBObWowMXlm?=
 =?utf-8?B?dXA5YkI4VG9JMFkzbWFwUFNNaDBScmRZUEVTd3NNL2xMR05vTEx5amFxRThX?=
 =?utf-8?B?RkVJRUhxTHhQYVVWV2ROK0YxRW9qMGgvOWgvMVMvVGcwalp1RVpkNmpadWN5?=
 =?utf-8?B?WExhSkp0aFlHUkVXTWF2cnplNHdZM3Z4VnNwNG13SWhzU1JvL1J4VmF2eDAy?=
 =?utf-8?B?bURTSktwWjVsd3NlYStIeFRQRU1QUXlqc3VjRlhCd29rcG95K2RjbzgzNERR?=
 =?utf-8?B?L2dOU1JEOU9QY2pJcUFVQUtBUnlqWW5NYnBEeG81UWVJcE5iTnV2aWJqaXJz?=
 =?utf-8?B?b0Q2bi9jK2w0YUIvZDE3T05jWnNaWlFOZzhkMzc4Vk1ucUhzSEtoNmRJT1dp?=
 =?utf-8?B?eGtjMDg4c0YwS255VTYxdWswQTRQdndmSnROM0JjdkswUnE3N055NDhSOHVW?=
 =?utf-8?B?WnRFSUxGclV3U3RqSnFPZHVmVWlESlhmdjVzbVNyS3N0S3JVUjFhRnN3OXEx?=
 =?utf-8?B?V1NlNzV1UVZzK2w3amt0YjV6bWF6QmNXMU9jWUpwMmdYQkpyOUtUT2RGdkVJ?=
 =?utf-8?B?SUxxeUVhTXVMcmdSTHBsYlk3QlBqenpZNENiT0daZ1dYRGRzeTFubS94OEFD?=
 =?utf-8?B?d1RMb2l3T0ZvcjBxenhYZGE0Vm9qVFZ1MDhhN3B6NjN1M3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0NZUjREOXZ2TjRpUkhibW1LcXZrZnkwMUZLR2VkWFlnd3Qra0dTQWMzb3BQ?=
 =?utf-8?B?K05XdGVKV2YzVDNXdndVWTRoTUd3WFJGMlNSQnV3V2xnZHJIdGdsQ2JFb2NG?=
 =?utf-8?B?b2o0VGNCN1I4UFFZTDlvMFRiQVZUb0ZYVnpMVG9YWW96Zy81dGhXVTE3eGR3?=
 =?utf-8?B?anNaWitqZ3gwSFFXY3JyYUZMVTBqck9jTEVLL0xKZnNUMjJidkNuU0xkYXYr?=
 =?utf-8?B?a2JaY2VsREdMOHhmVmEvWG1pOVFyd0pWZUF3ZjdrTndEdlUrYXJNZWx3QmFo?=
 =?utf-8?B?ZUVuUDJLM2tOaWw4MTdhaXh4dkhrL1QxKzZHR2k1REF2ekFmRWRyUlhqUzBm?=
 =?utf-8?B?RFhKMTRPNEZwZ2xKSlFXdkovY1ZVYjh6bXJjK0pUNTkySktUV2tJQzlINk9q?=
 =?utf-8?B?SkppU1pvc3VkSkx0YnRTMXhLSk5WblVRdUlWbzluaVpFWWdBb3o4M1lNODZY?=
 =?utf-8?B?UTE1cXdLc1UwS2tMWWwvRGxXdnpCVDVtYkh6NmRiNEVhREE1VGtYU2JwZ09P?=
 =?utf-8?B?Sm5vOENWTjh5UG5kZ3k2ZDgrTUpaelQzVEcwRXM4TEJ1bHRnODluQW04OEwy?=
 =?utf-8?B?RFViSE1FQmRldFNHUTlkNWE0a3ErZ2dLTG1uQ2dncGxUTnp0d3U1c2pZQ2ly?=
 =?utf-8?B?UGI3Unc5WGtteFNEeTNOMmFOTVc5aDRXaDV3ZmVBT3crNUlUYjBIcHkycitC?=
 =?utf-8?B?ZHJIV0xDTUdYT2VUSW1qTlF0UkJCQmtmWlFxMlBDaVhCREdzUkhrZzB6SWpM?=
 =?utf-8?B?ZFU3YlhVcncrWTNwL0FoRjVONkl1ekoyUDhxN0IvUlJXTUNwengvQk5KZStM?=
 =?utf-8?B?eGJkME1FTVM3RUlmZDBvSlBSWGdpc2xTQ094b3RlVERnYjNBb1EwVDVsWkNk?=
 =?utf-8?B?KzhOTXcrSEtoN2NEN1FicWd6ajE5MU9ORHdJTURMMVVZWXJtd0phRXU3bVFY?=
 =?utf-8?B?czZJaHMrMytrZ3Zldi9nSm9WUmpsS2VaVHlOWTZVck83UWFKS0RyaHErSTVG?=
 =?utf-8?B?Z0pUSDFoeEx3N1RFZk1TWGhMTDk2S2dUZUxLZ2Q4Q1RZUy9KNEs5RUcvY21n?=
 =?utf-8?B?eVplS1I0R0lDQ00vVjdVd3hRWWRGNlVhellPN3BGMW03MFVNS3EwMWdLdjFi?=
 =?utf-8?B?ZitydWpWbnU5QXpzSFQyMHBqWGxZVzI2ZnR2aUcxMm5YTEV5OU5xZlkwNkw5?=
 =?utf-8?B?SVpLRnh6OEdQNUh4d0lkUmlyWGM4RWxCU0lhU2lqTWYzd1U0U1dINnh1Y3lt?=
 =?utf-8?B?U2x1L1ZCakVwZmp1SnYrTG1ua21WYnVxMXNpUWpDSUdlSFFRQWtPZzByNjRp?=
 =?utf-8?B?MHowWUpHQUZzamQ1bmQ2NjJZNHZ3UmJlVTBSaVBWYSt6UnZwMVpNOTJ5eHlX?=
 =?utf-8?B?MlNhME5YT0NreWlLb1M0K1RwL1FSa0FKVWRzWXdzMnR3WEFsbnljV1B2V2xq?=
 =?utf-8?B?ZTBQcE9TUDVaT0VtdzJFd0czSm9tbWlic0FPbk1JRTRFY0E1VVljMWsvcG5l?=
 =?utf-8?B?R1FoNXVWL3ZERzlLOGtRN3pYV0g5V21scHh5MWh0dERtK0dGKzNNdCs3eGdz?=
 =?utf-8?B?TXZ5RUtxZSt6WVFRamd6V0p3NHh4ZmhyQ1htYWovV1hXWnQ5SlhDKzJISlJn?=
 =?utf-8?B?N1VhS0RMZEJVKzYyU0tJaFVZU0t3QjN1enFlUFoyR3NKekFMKy9pcFNwL3hw?=
 =?utf-8?B?QTBZWVNjdktSdXh2cDVsQVJkSUFEM012WEFtd0hiS2tPWmh0UzU1VEp6RzRa?=
 =?utf-8?B?a1NqbzYwZzNKL2p0U1Y4ZGxJKzUrVE41UjdIOSt1dDhUL210QzlVVi9GVGZT?=
 =?utf-8?B?dFV4TzhMWWJUN3MrNlFSVFlodXUwUFNrbStBaXBHaE1OOXcvTi90bS9JV2N3?=
 =?utf-8?B?cEh2U2hrMmR6NWpTT2grck5VYSs1NU9RZ3NaQkdsU2lXZ0ZTSE9CbGk2R04r?=
 =?utf-8?B?eCsrSjVydFJpTzNRSUpXbU9INXFHZDF4L3poRlVDc05JM1lGUmhmVktaOFNW?=
 =?utf-8?B?c05QenVUekE5VFo3YkloRDFnR001T294WTlKZ2tnaEhZRzV0dVB6WVJ2SlRi?=
 =?utf-8?B?S25FVXFYb1I3RWxqVlg3Y2V5N3dyNnk3Q2p0WlZZczNFNmJKeFpleVNUSFpV?=
 =?utf-8?Q?O5ugZOHsAmSdf1XOffujFTK3R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1d2a66-43df-4169-0103-08dd14464752
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 09:30:23.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDysIdv996EqlZMdjz5tv4izQyHAUqsCPODyWrmBTrW00x/paoAr5dZKis5KkpcvsbE1Ek5NaqAKupSJLsE/Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170


On 12/3/24 20:33, Edward Cree wrote:
> On 02/12/2024 17:11, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependable on kernel CXL configuration.
> You probably mean 'dependent' (or maybe just 'depend').


Right. I'll fix it.


>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Some nits to consider for v7, but this already gets my
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>
> ...
>> @@ -1214,6 +1222,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	if (rc)
>>   		goto fail2;
>>   
>> +#ifdef CONFIG_SFC_CXL
>> +	/* A successful cxl initialization implies a CXL region created to be
>> +	 * used for PIO buffers. If there is no CXL support, or initialization
>> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
>> +	 * defined at specific PCI BAR regions will be used.
>> +	 */
>> +	rc = efx_cxl_init(probe_data);
>> +	if (rc)
>> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
>> +
>> +#endif
>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>>   		/* On failure, retry once immediately.
> nit: weird to have the blank line before the #endif rather than after.


I'll fix it.


>
> ...
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>> index 620ba6ef3514..7f11ff200c25 100644
>> --- a/drivers/net/ethernet/sfc/net_driver.h
>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>> @@ -1199,14 +1199,24 @@ struct efx_nic {
>>   	atomic_t n_rx_noskb_drops;
>>   };
>>   
>> +#ifdef CONFIG_SFC_CXL
>> +struct efx_cxl;
>> +#endif
>> +
>>   /**
>>    * struct efx_probe_data - State after hardware probe
>>    * @pci_dev: The PCI device
>>    * @efx: Efx NIC details
>> + * @cxl: details of related cxl objects
>> + * @cxl_pio_initialised: cxl initialization outcome.
>>    */
>>   struct efx_probe_data {
>>   	struct pci_dev *pci_dev;
>>   	struct efx_nic efx;
>> +#ifdef CONFIG_SFC_CXL
>> +	struct efx_cxl *cxl;
>> +	bool cxl_pio_initialised;
> Not clear why this needs to be a separate bool rather than just
>   seeing if probe_data->cxl is nonnull; afaict from a quick skim of
>   the series it's only used in patch 28, which sets it to true in
>   the same place probe_data->cxl is populated.


In a previous version, I think it was v2 or v3, I did use the check of 
the sfc cxl struct, or maybe the pointer obtained with ioremap if 
everything was correct, and it was suggested then to use another way 
instead of that, so I added that variable.

Nothing harmful, I guess.

Thanks!



