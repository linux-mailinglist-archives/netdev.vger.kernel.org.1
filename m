Return-Path: <netdev+bounces-225589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE5B95B73
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D448F19C3456
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66092F6184;
	Tue, 23 Sep 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JEqiUcLJ"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF6212D7C;
	Tue, 23 Sep 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627824; cv=fail; b=LGoA7aniEhLBzwh2dJQMIYJXeKgp4SDqP91SiMJRX8Xk1TZl8TGkVNh6ZUwFaqUBSLn9S+cXvmn4lSy+jCAD3F1SGxFzc92jRDIVLAeqbh+xCDV4TMoefuo6ZT45HvjKBJY8SxfroQHYzu8msZGe0MjFfGdz90SbVY3A+teNOwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627824; c=relaxed/simple;
	bh=PiO9AP+rFihki583R+rbVEN/4xXqFOtH7MPa/6ihX5E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ep0gzzPzNp/aFNv5zSQQEXmIW/Ip3AZgI0/EOl56TBgiRJEJG7Gi9nDU/l8WsWDSqzL6sUnNPrLlRpUsqCVHnglPo6Xx29bMg5LAnSi4TDfEIgS2u6aVSKmljaz7xuT8pWPELnKDDDW/JcVMR2paI8BUfkH1Ocl4hcLw/FLwPFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JEqiUcLJ; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1ua0b/mQLHJoQhMc3Jp3TntncPXj7Ddgf59Mtd7rlKPAdmPufqXEKTX8VUy+kTtGr4yQC6P/F6Dl5H7EBgrcL+K8+SbsNZ0Devpa2qPpOgGdZbjlZuDy/Fz5UlYwGD5nKtQg+Qt0ZBOqx79VvicxAwVJLezX6vP/chlSjGte5X23Vcz4ghE6GdOlGs/Jv28wo9j5Dcfrf+fU2upHZvdMSnAXMAwB67vA9crfFUTE9JRpc5q1nhV+yEHaqcdBUfHjSPOvLZQTcxxRlWVknXk+Yx5iZhJBM9pak2DgHWkYvEWNJvH6+Q5KN+nrHiPdTf9Mir3L36mm2v9pPxzq59SFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaGhOoszEQ9Ii3sk9/lP4JcGOFQcbmYtvktYWhgBvaE=;
 b=lvSp2CR8uB/xuhiC5EqW9iG7ty5kqzRfNOKyxtccu5JdM032dTNlCnyRIh9yj+xVW46nlxnraszqlnY4ucttP2Q7YQVoAS2IL7YjfCdXBAR22rRN+ePdRmHgFJYbb9qCeXam2Jro90e/KKJxrtjceJQfXS3aotH9YcW2PZ9fxIDQEjHNz1aJqz3sxOVnJTHBgCT7R40wsz/UpjKh8SJ7Nv27fI0U2EhW/bbIJTs4OyUMxx/sLVsTMTZCLqh7W7K/u3syXqrI1ln/NlpFrBx3oDC7H/AHCCdYpF0pC7+I+lTSSWoZp+itBKDSJALOhernYvpt06kXzREIL2V/pMGOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaGhOoszEQ9Ii3sk9/lP4JcGOFQcbmYtvktYWhgBvaE=;
 b=JEqiUcLJGPwdJuol2AXKxgh/6I7W1tKJIEAMklkZLstWxvEcPPJ9fCJwW7RBFHKJwmMit/CkoUVPLSKEF5zkJ5XOf6Yc87NJGs2y//McWZRRhlFU6AHiDF/HQW2ZeVxTk3RecOIzzbzqKp8vodZshBUMYsDj2uh0Qj+1URRP6zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 11:43:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 11:43:40 +0000
Message-ID: <fd325d95-2e71-492f-ae87-86f591c6ffef@amd.com>
Date: Tue, 23 Sep 2025 12:43:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 01/20] cxl: Add type2 device basic support
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-2-alejandro.lucero-palau@amd.com>
 <bead66ee-b4ef-48b6-9164-d9086b6de3ae@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <bead66ee-b4ef-48b6-9164-d9086b6de3ae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e94a6c5-71d9-4efd-4029-08ddfa9670d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1F2TitOTE12cHR5bmV5bHlWbXczdjJpSWlDNlkybU9LaHRKVEpzcjkzQWR3?=
 =?utf-8?B?SE1NZzVKbkVOdUduVE1OZmV2Z1g5SlA3Z0FQdnp2QXJSRS9LcjU5aktHemFL?=
 =?utf-8?B?ZmVPRE82WnBKYVZVTE5sWG9iOFVlQ0xMN08xSjFQaTNoallCSk9WTFlYRnlJ?=
 =?utf-8?B?ZUlvdzBmQmZoRjRyVTNwWjc1cm9Bc2t3eEVRZlBKbFVGUFdZd2lMY2Q2Vktm?=
 =?utf-8?B?T1FyV2FFazk1c1FVQWlYMldUdzZFSElKTzBidTZsdjlYNUZubm1NRXFTRnhS?=
 =?utf-8?B?OXRRVzZPamM1Qjc1SUVDa3BlSVBDbU5jUVZidlNGNVpib29YS2JlVGhQSjVT?=
 =?utf-8?B?ZUpyMWdTQUMzdjZzNVlMTXF1VWFENE5rTEFwcXcvTi9tQVhybWs4U2tqWHdN?=
 =?utf-8?B?V0FRMUFpVXhOMkx6cnVRUTBQUit0Y2NMZ3RuejVwbHNERG92WldaTksySXdE?=
 =?utf-8?B?aDNpM0hqak1pMStmdFNlL2wxQWgxN2tzZVhrYmhZdzl4d05NY2hqZ2pmemYr?=
 =?utf-8?B?R2lmcnJjcUFpL1ZLYWFVREtuTXNBSHUySTZNbFJOTVI0KzliMEpQbnBKUGFn?=
 =?utf-8?B?QXRwU3E4Y2Qra2hvKzRXTDNIL3FzWWxFS2xUZkhJTG5RcnVZU2F6Rnlhb3pO?=
 =?utf-8?B?OXNTay8wMnZqU3Z1emk3aHZsVnNmV1NWK2FXNW1JRGZMUWJFQTUzc1NGYVAx?=
 =?utf-8?B?dmY4dUpaU2pCMDdjM1VCL2M0akdYM0NLb0oxNHV4MC80Rks1WHlUTFQxM3Ba?=
 =?utf-8?B?Vkk3LzZCcm84cmd0cDNWamhpOEwzeWNYRW83STlWSnRXR2o2MnExWGc0UXZs?=
 =?utf-8?B?cElRTzM0N3VHUGNQZnV1NXVWcC9acmZMOWk4dUhpWCtzUnY3TUZuK3dHYWVD?=
 =?utf-8?B?dlpYQ3pkUTErRFh4dDM1OEhndDhnc2syRUEwRnJwT2dSVFdZSTdjSWEzVC9Y?=
 =?utf-8?B?ZnBBK3Rtc1JjT3ZCcUVFOEJwZUZBZk51alVCOTNibjZmTTg3NmdvOTdkSERt?=
 =?utf-8?B?VVUwSGhtQW5ZV2V2VDNiWlV5S1F4WTFhcFpBMnd2VndaQjRvbFplMEFNWW1Q?=
 =?utf-8?B?cmE0YVhYTUZDMXAzTUI0aExxVlQ3WTJRaU15MXZSbktTWnMxSWlmeFROcWFl?=
 =?utf-8?B?Mkp1cGttSFRVQ25nRWJuL3Y1Vy9WeFNDcGRnQ1ViT2paWGlPK0NFaWN5c3pT?=
 =?utf-8?B?d29mNzdjbUYya3ZqMVZiaXJnRk0wcjBjSGRKQ1crVTZHL1JoMStQNjBleHd1?=
 =?utf-8?B?ajlWdXQvSDZaRXVyZTY5V3B1VU9SUlpwbGdMZHBNUE5GNFpYdjdxZHRORmVT?=
 =?utf-8?B?RGFXYkJlQ1hkcXpCRmtoVG44TUE0QXl1V2ZabEYzUEpZTitaRERHZnB3cFp1?=
 =?utf-8?B?VTBIemRyc0Z2WWZnQzVKazR5eDBxUTlGQ2k1U3Z4OU1Oald5eXFwaGMzNThZ?=
 =?utf-8?B?NGFXcjRVV2dNbTZCaXltSW9qRkhPbjdKNUhMOFZqSlA1aTJIRTVvSGVNM09n?=
 =?utf-8?B?bTQxb2VDUFoxV3lad2YyTEVQQ2VnVFRFQlRUZlBpakFCK0pFQm5kZll1dzU4?=
 =?utf-8?B?WnVXa3hIYk14SE5IeUpleW1lc0FuTEtZWXBrOEtYTmNDRVhMM2xSR0xYY2dM?=
 =?utf-8?B?MDZOSXlIempIZnBIek1RZWU5T1plcTNQNFZqUGw1YjgyaEE1QzNwSTJ2TXdS?=
 =?utf-8?B?UERjVG5wUXF3eS9BMFB0eitaQjZxU1pSZVVna3lvWERkZEFuaEcyMFM4ek9L?=
 =?utf-8?B?RXQ5bmVJcUxNK1JPZnhUczRJMTFkdC9iZ3pIZHdzckFkb3RnUWZKU25yVjBp?=
 =?utf-8?B?Y0prOFBvNlZXN2c0UjNMRUVjbVZJOTN4Y1FIeTlBNG9hR0pGUFkxODdsNEZD?=
 =?utf-8?B?Q0JMTWdsV2JvSEUxRmpFZ0pRSm40ZUFJRFhmUDFMcGxxV0dSbFdRM241a0xz?=
 =?utf-8?Q?3WJrnuYNb1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTVmTjZwMlhmanM2dCtUQzVQVDBKaC9tZTBZdWhvODhxVmE0UzZuYXY1cm9x?=
 =?utf-8?B?ZXNDVmJ3MWJxUi9UMGRJdUVZaWRBcUY4bm1ITW9IQnlmS3BXUjlRbjdPVGxz?=
 =?utf-8?B?dUJrcVN4TkhQZHZ4dUJtY2x2S0QxVGFJSXFvU0V5MkpWeGIvOW5TVFMrSnpy?=
 =?utf-8?B?WHhhQ0hlVzBCYloxeXBGaEVEc3JrOW9BejdubFFTSUV0TU16ZkhIdjhIWVBN?=
 =?utf-8?B?ZlpzaGdXemVxOC93L28xUWhOOFZWdm9Nc1Y1ejVLZGdSVFpUdTVQTWRsQ0R0?=
 =?utf-8?B?ZFFlb3ZNUlpxTlZpSlNxY2cxTXJveFJHN0V5QzJ1YjhiZHhVYWlzMmFhaWwr?=
 =?utf-8?B?TFhScnJHOEkwc3VGSUZ2R3hORm5LdmZZY0J4eEduYkwycTQvOHFHYml6aENk?=
 =?utf-8?B?S2F6RFdxYVpDaHhnN1JwRTNJSDMya3o5ZFR4dlpLVEQ1aTRJR3NMY2JvY0VY?=
 =?utf-8?B?NktBcWF0cVdreDNmbWV1UkQ0OEpMZngzaWU4bzVTWWZsOUhJZm5RbTVVNFZY?=
 =?utf-8?B?WW9yUXVDQVdaTTY3MVRFcWNBYUlpKzR1UzFmMVpoLzUwRDUwQXJnb0VaZ2pX?=
 =?utf-8?B?aTZiL2hTSWlnQlpwcUdlR3JUZDR2dzZDS3Fuc0NDR2tDdXRzZURtc3JXMXBj?=
 =?utf-8?B?NEFXK2c1S3R6Y0liZHBGOVpneDlaTVA0UlV4ZXRQcG9WUGZvVG55V3dUSXZo?=
 =?utf-8?B?aVhwOTQvd1c0MDRVeTM1NnJmTFFERG1zR3NURGhXbmtDZHBEY0dSdXpKemVB?=
 =?utf-8?B?VWhHYURWNFYrU1ArQkpXNUVmdWhCU2k5RVM1cjcwbWNQRTJwV3Fiamk5dEZS?=
 =?utf-8?B?THpJYmVGUEoxaTQ2MzJlNkZmWER6VGdaVTJhRnFpMkx6SnptTE5PUTBQd0px?=
 =?utf-8?B?QUR1QnZSQStYdlhNUnhFRk5OUjVPSldJNWdrL2NjTnJIYSt1dHFMYWp4WHcz?=
 =?utf-8?B?NHlDZ0JqbnNJKzNxMlNjRkhOa1hjR0FGUjErelEzZU43TFdVZUNQcktUU21C?=
 =?utf-8?B?NXdKVHBRdUxmbXVSaGV4WHAwLzU2bkJES3FpVzVZU1lmdmcvb0txKzc5TDhr?=
 =?utf-8?B?dWdTYVJQMkNvZEdFcHdxd2FtTktWN2xDUWhRcmFUMDYrTk5XWHpKR21HM01m?=
 =?utf-8?B?Q3V3MGlWckljTVAxNVAxQVJwcU5vRFhGYlE4bG9TZFJjY2x5TkVDbmRpcDNY?=
 =?utf-8?B?OGVyM0F4R2xrSWdXYzAvWVhqODJuTDFDVHBGeHNTQjVEZDcycDBGaXFyMkRC?=
 =?utf-8?B?RWhHQ0hYY0xzbFREMVdySC9raEQvMGVzS21nYkpnd1hxSW0yaWtiaVBnSmRH?=
 =?utf-8?B?aVF1UFg5OTkvSXRsRG5uN2xFdGVJZ0gzOTRSNmNFK016SGRXYWZtSWZSTm9q?=
 =?utf-8?B?d0c3YmNZeStCZ0g4enFzdzZDTjV2S2YvR0YwTk1LcVRrVlFtVEFFZ0N1ZXor?=
 =?utf-8?B?MEJLMTR4VWRSQ2s4VlFRcGJZZElnN3pBMm1ISHpmNUpyT0cvRE94eXpJRUda?=
 =?utf-8?B?cVN5R3ZmaUx5UVNaT01US25ZTWR1NlpnZnBzWEVqN0hMN2ppK2tQRFZ4SWw2?=
 =?utf-8?B?NnhPdG5iRklJSVZMRDdSKzJxMFVRNFpqZVNHWFVFRUpxRUVSNDAwVVcybEF1?=
 =?utf-8?B?L3ZJZnFXOHlmSkpmTHRPVWtKbkRUUDl6K0FXQWwxZDVkWHpadjFLWUdKbEZr?=
 =?utf-8?B?elhnRW50eXJIVjhob2c5M3BmNkVQTWJudjRtTWZPdmRuWEJ3UkV0c3JHMkN6?=
 =?utf-8?B?bjlkSTZmdXRDVTJVcDZ0Z3c3M0hBY0g2QUtiTnI2MkI5eE9hTjlwamozUTRq?=
 =?utf-8?B?Q0lpZTY1M2ZqTXlzazZlOE5xNkR3enFXU01pdnVqTzZubUtRbkltTVFwL0pR?=
 =?utf-8?B?bFdGYmxUQ0N6Qmo2YkhCYXlwYTdWL2JCT1NLRVVWRHJuckpCRk0wb1Q1MFZa?=
 =?utf-8?B?UGFUSHUvQ0JWSGM4U055ekV2aE4zbUIzbEc3TTFBbTVKRGlsU2l6WTdjWnRk?=
 =?utf-8?B?UDIvRkJyVG0zbTJrd2cvZFB1Rlhnem9TbUg2TVhGclBBSnA3MllUa0l6Z0Ez?=
 =?utf-8?B?NENLS2Q1UFBqUVRNbVRsQXZNQUwvbHlOVEJzYWpzQzkvUmhLdERSZWltS2N5?=
 =?utf-8?Q?mTdmb2JxmfmXQjbGEGWuApBYV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e94a6c5-71d9-4efd-4029-08ddfa9670d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:43:40.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTJXgyNyusLqeR4gzZPYxkyBeS6NGxtoPiGF5KzbmlAlTkr5HWmvCJGmgXLinnEdyDvf+28QC74XYRFPDfSWdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975


On 9/22/25 22:08, Cheatham, Benjamin wrote:
> On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> [snip]
>
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> new file mode 100644
>> index 000000000000..5729a93b252a
>> --- /dev/null
>> +++ b/include/cxl/pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +
>> +#ifndef __CXL_CXL_PCI_H__
>> +#define __CXL_CXL_PCI_H__
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> Terry added definitions for all of these (I think?) under include/uapi/linux/pci_regs.h (patch 7/23 as of v11).
> Since that series is a pre-requisite for this one, I'd go replace these definitions with the uapi ones.


Oh, yes. I did see the contention and avoid the patch removing the 
original definition but I forgot to study the implications.


I will solve this for v19.


Thanks


> With that (and Jonathan's suggestion):
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

