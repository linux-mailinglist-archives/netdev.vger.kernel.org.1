Return-Path: <netdev+bounces-179566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26ECA7DA41
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45532188D148
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABA23AD;
	Mon,  7 Apr 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q3DQnXuR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E652309A7;
	Mon,  7 Apr 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019458; cv=fail; b=FWP+s4pWb7YSB1cZ4KIhM9s4LYOgW5evSzLmmxVuuNXoX+15ZjkkZ9HrQ0zs1btNi8r90P3wQXJ3hvBJktEOQEHPtOwlIyb07Epf5o9XxgsvNepDTsjTU9BBnLSb9jYmEsfcqlZvE60Za6zQ5gDSFHriinzfhaYDI4kTRv77XK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019458; c=relaxed/simple;
	bh=Ilz8QNuT2sjzhgfRohMyJOj78eLVY9qURgJhvDTWQic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WPyh9lN3onZ2V0va83+OR8J8/iJdQO66y5x6ErxcRwuOj47CMM1uCif0bCo6k8c5ZWLvmgZVryMJgOMGZCUtgt/cNxukh4y8d5Kcmf1TO1SLvefvQtqlnR+FD36EUIWcuZa2NGzCQFenxsIzeJ/XmRNlQ/7/ucD8qOHKCnPH1E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q3DQnXuR; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmjpKr/f/W3NWpSZCG+/3FTPMx2bEfRfPFwRm3Ee7IbMowSOjD3g3/EzNUf4UEv6LdqoddMVv5iXQXuqcPcDJrxvRw4Q7qh0mGOeKeoLtG3nojHGVzNaYKlLDVL8Xvh9PHVvt09ZQ4Yg4cET66S8Nchs5FA7xiFJVoUJYsopz9k52oWvbgC9RUPDpLzgzFq7QFCrJ4MBq88Fv7fSt0vcTe7bNX4pNaS46jLmihcthAdvCGzQI0bSmF3tnSYA6mA0P3/abudzTuroMx2XLvRIGE6em5o8hmPUXpYLso68YghZpxyFmJU17Vy+DdSqL5ciVqeSflg365aMcZkJZnSMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UQEeZb7OoTgppk/kNx9LRNb7YWn4oflW0ZAgKNaejs=;
 b=gefvbq6Vwg0hi7etNZg2vQAX9yu73p7cbYOI6vmZFEbhpWCkRegcRijEQgQdL1VuxhssC+R8qH96rTtN2P1hPHnadNpCeZ0wNG5ygK646wOvw1ygoFaXoUR7PajsEoHPdAFj/Fde9iOhU6ALWomX8M/t7MpmctaZWxmddxrBkrAA93KH2Zl4QI0tu23QH6S9IrSopN3ywwxMmE1kXRlTVfGcG1zqwLl+bImGe1wJU0gdwK8SY/yvl5Qry9q0C4o9isGjlR3Rb68CVpqfz4oCSGmKT1UUMvt8OOGhR1IjmFXCqQoQHtBwcVnYPH9CIxxXDH4BtddEBhuPVhdAqnSxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UQEeZb7OoTgppk/kNx9LRNb7YWn4oflW0ZAgKNaejs=;
 b=q3DQnXuRjbjs4Y0t+HMG1oLrsOWy6kihmHZD+jAjtSK6i8+pNoOnCjMksqnQkcC6TSIaagCCLDGqKgj4Z6xxPC9iLOuMraNL8Sxn9t66vAK9A65grc7gVcXnBIx441Mn/0yWXpxw2BezuvWxVL8yf1k3Sx3z0ljl7bhNV0ECkCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 09:50:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 09:50:53 +0000
Message-ID: <f1264e0d-5efb-458a-a232-e97d56763c7e@amd.com>
Date: Mon, 7 Apr 2025 10:50:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/23] cxl: add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-2-alejandro.lucero-palau@amd.com>
 <20250404162429.00007907@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250404162429.00007907@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: b82ecaeb-a232-468f-48af-08dd75b9af5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVJTNTliNkg5UlcrdldXb0JYQmVEMHdiUnpocDVRay9CSDZZa0ZyTVFJdkdx?=
 =?utf-8?B?VW1RRkR0WGJPSkhHUEhkYklrdVVrUU1qdzRTM3VyWkpQUmNrSS9CekpKY1M3?=
 =?utf-8?B?OTVhRnNsWVQrcktRUExxZ3IxNHVURnNURTFONjFtUUtCdW03a1JtdnZxbENJ?=
 =?utf-8?B?Tk1KUlBzejJzU0FuRk9MakQ1Sng1bEJYU1JiWEpKRGtLRTU0cUVnd2NLOUh3?=
 =?utf-8?B?dmhCRGE2ZEdJK2ZnMWZoYUlkd3p3RXBtVityUzQrU2lrRWk0aXhKVUJQSERp?=
 =?utf-8?B?UXdWdFRVMG5xcXB0TXNuZ2pvYUVPYWh2OWx2VGtWekE4NmJKbnhLMTE3U3F5?=
 =?utf-8?B?MHhLNlk5SGpaajVuWHlpNytndE94dlI1QVlTNi8wQ2RXWnJFSUJtWmwvNVVk?=
 =?utf-8?B?cVJtdkR5azk0citpM0Zray9NZFJMNDUrRVV6TUI5cWFtR2dpcitaMnhUamxo?=
 =?utf-8?B?RFVGVHlod2lYNUZiSVBaUThSOTVvYzNsZTF2bXl5bm1Oa1dWU09yRURES2xx?=
 =?utf-8?B?dURJeWFJYnNsdFhhdVNiZ2hBdGZLUklZVklkcUJwYkhUSFhuNGZBbmh4NlVx?=
 =?utf-8?B?MnRMQk5GUk9BNGZGV2EwZmZMemtGN2NKVFFWUVNlZjRiSk5QQkQweWczcDFq?=
 =?utf-8?B?T2QwdllWMnZGVkR5VXJ4ZjRuenN3ckZKWHZLNXp4TTBUNTJtd001MW9JL0RV?=
 =?utf-8?B?cXdFaUFPZzJsOHpXTEZPT25ab0hWbEg0ZmRUUSt2UUlhb2xTd3pXZGtsbko4?=
 =?utf-8?B?UXhueWoxcXMvYmJuQ3Ezc3lxRXN0NGMrZnQ0Q1hpNUpPWk1lY2tDOUIwcG11?=
 =?utf-8?B?dnFMQkNDWWRtK0J0SVVaTTJRRlE3TTNROWVLQTNLbDN6elF2S0ZNWHBkWU9s?=
 =?utf-8?B?TFEwUU8vMDVmcC9aYTlZdnMzcUl3VHl4bWQyNUczZTR3TDlEUTJMVzFkdWEx?=
 =?utf-8?B?cG9aK2YvNk1YRmRnZEhKMDhPRUNQY0hhYWR2QXI2eWVnenpCUjk4NE1WR3gr?=
 =?utf-8?B?SE9Yeno5V1JVUFZ3cUQ4MFZ1elB1OE1SWWpiczNBYzF1bDVwVHE5ZVRtMThH?=
 =?utf-8?B?bVZRVEhRZUY0WmVPLzJVcUFTQmtISDc1QU5DVlJFdk8vYytZeEtiZVRUN1hi?=
 =?utf-8?B?bTZSSHdWUjJycTlzRGNUekRwcmJnZ092a3RURVNYSzR2WnN2N2t2QVp1UGEy?=
 =?utf-8?B?Uzd2akMzQU5ZcC9jTWJhMlhtRmpGUTRsZ2N2V3Ewc0hzblMvb21DeUt6MTRY?=
 =?utf-8?B?dUd5Z05LS0pSTDRWamU5U1ZaNzhVTXFMSnhkTzRxUHlYWnI4TkxaTXYyZzNK?=
 =?utf-8?B?REgrOXpXRUI5NDhrQnIxYmJ1MlFSak9mZkRvaE1VSWJra2dJc3VWOVZvaXRQ?=
 =?utf-8?B?MWcyUzdWNEJGMWVxY2lLalkxSGRtT2NTcE1heGttNkZuMFpSTCtEWXpnb0tD?=
 =?utf-8?B?dytVR2NKSEd4T3JiNzN1RDVoQ0NoK0w3NWJ2SFIxbVc2ZDlORGRtK2xHRlUy?=
 =?utf-8?B?UG1uTjYzZlMwUXduNVNQc08vVXJSU0s3UzZUQTNKcExHR2pzNEt4R0JheE9N?=
 =?utf-8?B?QkxuMFZCbE43cWpsTHFSRGF2dDlwN0ttVnorUFNQWGJPTDRnblovYTB4VXRX?=
 =?utf-8?B?V3BVdEh6dTR6azQ1bGQzUHZQbXFPOE53UE9KSGZKd0ZsRTExcVRzSG1xTDZJ?=
 =?utf-8?B?L0tXNmFaWWpKZCtTcit3ODQ0VDNrTkpJM1ZLbWlVdUFuRjRkUjdycGZmUUFv?=
 =?utf-8?B?QjVaVFVLVXZHcytjd1B1QXR2eWRMdVJhUkNPcHBId0gydHRUU2xPczFIU2dF?=
 =?utf-8?B?eldaUW9pdXRVRHV2VW1aUUR3WEdTdlBqbWRxZWpTM1NNWDV3bFFZOHlEZHEw?=
 =?utf-8?B?RUFycnkvVXlYWG9Cb2ZjOWFGUWZtRDJRMzlnaXRHSzVoMW9PbllmK0lvUHNC?=
 =?utf-8?Q?+mhvgBuwuYs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTNGN2FCVEFvUE5hZUQxMGkwcWJ1Y2M5RUdjdmlQdkh6UFBhZnNIaXpWd2dh?=
 =?utf-8?B?NGI1OTdqRWgzS01reTBacFN4Tk40MHkzZ3ZxdXJhR29lcWxkclhsd1FtYy95?=
 =?utf-8?B?cEpJSmRSQmk3WjNkaG1DdEdraE9hVmVza1FhcXEreWlGczZ0Q04rV2dkTkhO?=
 =?utf-8?B?QkJOd1VqUFpuN1BJb2J6T2prc1l1aUhQMS8wU1NzSkRPQlRSaVphQ2NVVXdr?=
 =?utf-8?B?QWdzbFpsMnVHcHBvU2xDd3JmZnFJZWQrUEJoUi9SdVgzRUlQT2trZUlGSUF3?=
 =?utf-8?B?bkV3ZFpNNGJPUUhJZ1ltTG45eEQ5UWVKUi9VaFdzNG95VlkrNUc1ei9wVFk0?=
 =?utf-8?B?QS92RXc3K3dCVWREbk0zdUo2bTBZb2JaUVlYWHlPaWxvbmJMMnFvd1lhcUtQ?=
 =?utf-8?B?cWZCQ0dIQlcyT1lYd0xwNm4wQnpZeVU0WlNLR3cxbXR6WnZXd2NSZnRYSzho?=
 =?utf-8?B?dWMwY1N2TC9qRk9yMHQ0S3JQcEZZTENSUEdlOGl5NU1ISHhkajNDeUpOWTlu?=
 =?utf-8?B?Zk9QR0JEZjVWNFAyQ3FFZFJjUS94MXVIYW9hYkpEYWhKS3dPREZ4VWtWWWZZ?=
 =?utf-8?B?bEhueFZBKzBIQ1c4KzlpaTJWY3AvT2huRDJlMHhpU1FtZnc4VHRYNEd6VmU1?=
 =?utf-8?B?anVTQjZvN2w0UlFOUHhpRXY0RUtEZ1VkUmVvbjFkMTZFWGtzOTRobWNIRVlV?=
 =?utf-8?B?ZEh1MUY0MmNZWmV3SVcrN3pIM25CWmJKSGJNRS93alQrTS9odUdXUEVtMEVE?=
 =?utf-8?B?ajlQcXpEOG9vcktTTlpMdEtSanErZDhVTmgwajFzK2dCRnA5MWViTC9WeDVl?=
 =?utf-8?B?a08zZjdVS2hBaytkUm5qQnlmaHEyS05LYmlyaytBWmNLdHRaT1VFakQ4OFps?=
 =?utf-8?B?b3FXSE1MM3E3NWF2RUlvdjVRaEZ2SFBmeDRMWUsrak1mZlBpa3ZHNUhjaXdy?=
 =?utf-8?B?RUpYTldjd0tMbnFCcEcxZEMrT29ScytpWkNYRUJBL1BGd2Z2ZUVvLzhBczBB?=
 =?utf-8?B?eXVZR0YySjN1bjVEM25oSmNTSU1zQmloZTBTaWpxL0dWNXRlYTlmM3VnS2l3?=
 =?utf-8?B?WmtFa2NlZlJYak16WWNpbG5Lci9FRWRoYngvdkR3UTZoSHBaRGgxcTRXNnBo?=
 =?utf-8?B?MHJPRVh4dWhDbHF0SjFXMktXZ0ZZTDZqVFRIaVNzNHdkY1hJZXJqV0tOeUhE?=
 =?utf-8?B?VllVc1lpYitQOHJWN3Z2REdITU54LzlBaStBNkRseEFDNmVMa3ZwM3dqR1Ja?=
 =?utf-8?B?SElzMnBFZXFwRkRiWHZyZnFxL3NBdDdMSFZPOWNzLy9mVi9hanl4UDEzejJt?=
 =?utf-8?B?N1pWaFJ2MFNiK2N5WWVUNHZUR0RXbGlYeFNCZU5ORFkwczhJSVFTV1ZpN2lP?=
 =?utf-8?B?cjNKMG81ZFFlc2JSMDdoWnpYcE9HNytMUU5TM3c2NjZPS05sY1RwYmRReThV?=
 =?utf-8?B?UHBBVFM0T21tTEg2akdXRDAzWFBaUm5nTmxsN2xzdkZYZ2gzaG1Db3pFR2Jz?=
 =?utf-8?B?OUR0L0ZMK3ZZdGhLcWtITmlpRFFSM1R0L2JGVlUzNUlEU2RmQXhZVnVMWGtY?=
 =?utf-8?B?V1BiSDFXY3FWT2E5VnhFSzZhaC9Odk53Ym1kdEFVUXNQVjQyRitNdG9pdjkz?=
 =?utf-8?B?cHdRbFRaLzRTLzZGYkZETmdIeGk5Qk1DMEoxdVUxdGJxcE8vcjI1V3JxRytJ?=
 =?utf-8?B?TTBmTVhaRGErb3FyRTkxS3FQSFhwK3V0L01wUUk3RzNUbkV6VEthOFhTSmZZ?=
 =?utf-8?B?cXlDVml1TTBxSGNHTjhtNWVhZWpabEZaNktvb3lXdVg0YTV2R1FDSDR2d2E5?=
 =?utf-8?B?T1lPa3E1UEMwazZPZ0YvUUhaZlNmZXVLL1BJbklpVG4zNmN5TWYyZy9QQkRq?=
 =?utf-8?B?YVNydEZtSUQ2UGZPbVQwcWxQaGdyMG5FdDRTeVMxZk9sSGdwbEQ4dzFpcldK?=
 =?utf-8?B?U1VDQlpLbHpzWEhocGZTN3FWbythT2VzVWFFOWk1RWQ1R1JYTXFSTDRtOUhh?=
 =?utf-8?B?Sk92RVFCT0xxWmZyZ3AxeGRKRSt1SE9mREN1UU5jWGxuN1JsZDhGeWZ5ZERv?=
 =?utf-8?B?QWcrWjNIYlVkQUdSZjh2RTlYclNhYTRwL01aM1NObXJTZEFWSU1JbmlIc0ZI?=
 =?utf-8?Q?xHnozwwB1G2SkEq/R0G3gmS1P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82ecaeb-a232-468f-48af-08dd75b9af5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 09:50:53.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZktw+8qV00RymcxptX/lweUBxg+a8UVYl79xBjbY8Vna6TkvVKv8z7y4iYV++0ss72AaddyuqE9AK4Af1stjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089

Hi Cameron,


Thanks for the reviews.


My replies below.


On 4/4/25 16:24, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 15:45:33 +0100
> alejandro.lucero-palau@amd.com wrote:
>
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
> Hi Alejandro,
>
> I'd have been tempted to break out a few trivial things to make
> this patch more digestible. Things like the movement of DVSEC devices
> to include/cxl/pci.h and the other bits that are cut and paste into
> include/cxl/cxl.h  Whilst I know some prefer that in the patch that
> needs it, when the code movement is large I'd rather have a noop
> patch first.


I think in this case it is preferable to keep it along with the code 
requiring the movement. This is not just a matter of refactoring things 
when they get too big and messy but something the functionality added 
requires. The commit message refers to this relationship as well.


> Maybe also pushing the serial number down into cxl_memdev_state_create()
> to avoid the changes in signature affecting the main patch.
>
> Anyhow, up to you (or comments from others). It isn't that bad as a single patch
>
> I'm not sure we long term want to expose a bunch of private data
> with a comment saying 'don't touch' but it will do for now.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..f7f6c2222cc0 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -1,35 +1,14 @@
>>   /* SPDX-License-Identifier: GPL-2.0-only */
>>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> -#ifndef __CXL_PCI_H__
>> -#define __CXL_PCI_H__
>> +#ifndef __CXLPCI_H__
>> +#define __CXLPCI_H__
> Might be reasonable, but I don't think it belongs in this patch.
>

It is as I'm adding the new include/cxl/pci.h file which uses the old 
name used here.


>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..1383fd724cf6
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
>> @@ -0,0 +1,209 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2025 Advanced Micro Devices, Inc. */
> Given at least some of this is cut and paste from drivers/cxl/cxl.h
> probably makes sense to keep the Intel copyright notice as well.


It was a smaller file initially until the required movements from the 
other files, but it makes sense and it is the right thing to do.

>
>> +
>> +#ifndef __CXL_H
>> +#define __CXL_H
> Similar to below. I think we need the guards here and in
> drivers/cxl/cxl.h to be more different.


I forgot this clash. What about __CXL_CXL_H for the one in include/cxl?


>
>> +
>> +#include <linux/cdev.h>
>> +#include <linux/node.h>
>> +#include <linux/ioport.h>
>> +#include <cxl/mailbox.h>
>> +
>> +/*
> /**
>
> Let's make this valid kernel-doc
>
> Make sure to then run the kernel-docs script over it and fixup any
> warnings etc.  Maybe this is a thing for another day though as it
> is just code movement in this patch.
>
>
>> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
>> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
>> + *			 HDM-DB, no requirement that this device implements a
>> + *			 mailbox, or other memory-device-standard manageability
>> + *			 flows.
>> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
>> + *			   HDM-H and class-mandatory memory device registers
>> + */
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> new file mode 100644
>> index 000000000000..c5a3ecad7ebf
>> --- /dev/null
>> +++ b/include/cxl/pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +
>> +#ifndef __CXL_PCI_H
> That is pretty close to the define in drivers/cxl/cxlpci.h
> which is __CXL_PCI_H__
>
> Maybe we need something more obvious in the defines so that
> we definitely don't have them clash in the future?


That is the reason I changed the other one.

Suggestions welcome.


Thanks!

>
>
>> +#define __CXL_PCI_H
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
>> +
>> +#endif
>

