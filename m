Return-Path: <netdev+bounces-99464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1927B8D4FCA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5871C226FF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9884428DBC;
	Thu, 30 May 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="zXNufaPs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2129.outbound.protection.outlook.com [40.107.93.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A702376A;
	Thu, 30 May 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086303; cv=fail; b=Hiu6EwcQTSWYjIpp9YfVaFf4irZHD4GObMrl3YLegf29wu+GwYQs2q7HjZxvWCNfUFymeAoC2yGJuIA5sHRIXsKGdw+YqIlBwnwGrc/EI8TPxMs+hgN5ESqp9ZoMzSxduQC5Sjj1LgZMc1QU2iQsh5rslPAgIQbFL+TKoe2R45c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086303; c=relaxed/simple;
	bh=k2mMwNEZ/CZMIab1bN+4+fgyFZdJ4MXUageWlnXYQjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dsx/Km1HjqGryr/16B+YiCJn0UAVcyBaWV18wpU6lbHyXqv4IRMIEmzK/g2bfjnGo5jrigqTMnyiVb4cY5N5O5yXMSe9QJpqCmHEqnVr+ER7Q94aVRBnC7rmQYJPIEY+3FvNHj7coYcSPHALKrzcmYjOh4iP6Nbn4Vzak6kj4fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=zXNufaPs reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.93.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWoHymj/vpW+YDWC/HgN81BvWjgeCfZy2//Os/XAMHtJH2coQPp1iz4sOcgqGy4GF2CtfDvW1mtqscMEtNEBBouS7Syj4Jh4jhV0Vjj4GgqGkPvTEQPvoRJJROnOwtMQt3BQGruZBDriTAQvVZTElzHkia/6wQrXBFXM7KZNN4bRFiaSLLKhptNr3LRVuOik9lC5qsn0iaJtOxUp9S9OFs4nlGly7IhVz5SmV+5MAmRuteOLqwVIvX7bQq6VlH6SI/IMdaM3w6SLbELcbe9oxMGg+ZODRutMOAszbhhCHMCf5I1jVaPfa9XY/VqcTxbEPuxs6CglC4aWZlgPt2vygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf31ph3G8MTQTtY2CNUF1gzr3KEbmQOJVdyuh0WNncM=;
 b=fwIBV0vlQCnjHXPNJn8gW0MRQPdFuiSP46FFoGVsHr8OuAoOkzsBzI9OY0NFYt9OfvB8e5pbxcfr8XLj3Pmz29TW0eMr54CZFy9c8fATZlbXivgctktXbgDpziw66WCZxrwnOTizBKiRTuJj8LR7vZbunFUjudzsK8U5MfkMB9LlbH/TbrIpHaLpHz03zYbrj3WASn207gflDhWNliCo/4bT02wGfSpxMt9gY7gOvoQpdZef1fTuoHe14dFnXtLUffVtZnJXm6ZUMM8HrxWvjeOr0lDun/CPsEkt6Il8w7OgSQrf4Lh6KLVo8ZWlEH4FYQbp+awBZ7lFgCsRoCQDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf31ph3G8MTQTtY2CNUF1gzr3KEbmQOJVdyuh0WNncM=;
 b=zXNufaPskBz0zAmBtfABJ+OE5/ZokEXIhsB22qqTschetgAYh1C9fffApa6KbgAH2WUIOaSSfASxstGZMMAZlAUHvKU6tN3Pzw3GBPpBvI5i5L8jAXx/zqMF3eY/MkPWz4dpVi9y/8COaqphjXQ50sfRdj649WB/tHqbKgUz8cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 PH7PR01MB7680.prod.exchangelabs.com (2603:10b6:510:1d7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.19; Thu, 30 May 2024 16:24:58 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 16:24:58 +0000
Message-ID: <75d4b180-206e-4d48-9506-f0f602b46eca@amperemail.onmicrosoft.com>
Date: Thu, 30 May 2024 12:24:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
To: Ratheesh Kannoth <rkannoth@marvell.com>, admiyo@os.amperecomputing.com
Cc: Robert Moore <robert.moore@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown
 <lenb@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-3-admiyo@os.amperecomputing.com>
 <20240529032541.GA2452291@maili.marvell.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20240529032541.GA2452291@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|PH7PR01MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ae5bfa-68ce-4ea1-808a-08dc80c50c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHRxZHVYMUlzZ29kZXBhNzNVWkJqRFBid3h4NEVUODNUaEwwaG5lMS9kV0lh?=
 =?utf-8?B?b1VteTk1b043UTk1NDJiblVHNysyTGVyaEFHRTZYbjhoc3RTWGlWOTN2N0oz?=
 =?utf-8?B?bzBhZWU3OTlzclRaOTBIekEyQ2FkaElwWmw4a0JBcDRDU1JNQXovNm14ZFB0?=
 =?utf-8?B?YVV6eFU1ckNJZjFlWFduWGp0VTIvR2t6MjNUTDRtU2J6NWVhY080Ym1tejVj?=
 =?utf-8?B?ZDdTRWtsYUlJSnRZbVltQit4RzVldnpXRHhYY3NKZHE2MWMyRVFqdGN0Zys5?=
 =?utf-8?B?NU9maUZuZFBPUkUvMHVWMjc1QUtqM0dEY0pqUm1iZHJQclFqV3J2S0w1Umdm?=
 =?utf-8?B?M0wwNTY5eVZYL1grMnFickdUSlM5Y203VVo3ci9iMlJzWXM3WTdXZ01mOVZT?=
 =?utf-8?B?QVFoSE5oVWw4b3RkZXhkNVlsdUE4bG0vZ0s2Nm5QRXBLanp6R3k1eEx2Ylpp?=
 =?utf-8?B?V3NzcTRXTWFXSXF5UExaZU1NTDJaWk85YTRsazZIZ2V6VW1xY05UeHpHd3dn?=
 =?utf-8?B?UElmMENZTEQvekJSWXBldmhveWI3ai9pVE9Wa1VXYmhPRUZQWXJGNHlHcjFL?=
 =?utf-8?B?azRENDEwWXJuWHYxVWRRaXNpdXFEZ0hQNnBJMy9HcUZndkUyelNVM05nS0wy?=
 =?utf-8?B?clhsNDdDa2l4WWlsZk9rL0NvVlYzd2dxYWQyT2kzU1VxU1BTNlN4VUdRTndy?=
 =?utf-8?B?YkNaN2FnSzNhUnl6YWRJWEl5MkFUSTN5dmJtL0czSlcwZ3RzQUo0a3hvd1Q2?=
 =?utf-8?B?NXAvOEJ1bkZQZlpsWVVPSkhXMXdLVEZrbU10aUp3ZXBTaDAyajRNYmRRd2dq?=
 =?utf-8?B?WVhma09xYjZlcmRtR05IZzZsSWg3RVpDdjdEc0QxNCtnVG9IdkRmc05raVdS?=
 =?utf-8?B?OEZYZk1RLzROcjVDRDV4cGhKU2cvOVJVaGVVRmZLcCtEWGdUamYrMEdKbC94?=
 =?utf-8?B?RUg3UWEvbFhLMmhjbDRGL05VclJnVnNtcGptS0ZURXpvekx3TGszcGhGaTMy?=
 =?utf-8?B?QVRFUnhNYVlRRGJTT0lkUTdUckhoWW8wQXBLM3ltNEI1NEpubDVSVnNoS2VK?=
 =?utf-8?B?SGJud3l1Smd3bGpSWHM4cU9uN2g1MHEzZjUxNEVNMExNazRGQUdHSHpaRE5M?=
 =?utf-8?B?OWxxYldIdW1nVWxOTTBxeDJPNWtETkNNUm12YWpja3ZxTGt3dTRzLzE4YVdV?=
 =?utf-8?B?cEIxVW93bktpYm15Rk55bGEzM2lrNVdCL21xUTYzY2FLOWMvZ0pjd04yOHFC?=
 =?utf-8?B?VnY1NXhhTGYxczZVM1Qva0hGVDAza0dLQk5sTEJzdmRaUm40MDRDT3BoZXZY?=
 =?utf-8?B?REtzVlltUllXZWhhNUVTeHlyeTBGYjBsMEFTaVh4Q3pEQ2FJMzFnTWgvN3Zs?=
 =?utf-8?B?djFuMGZyRmRFUVM5eDJpN2hkOFRqNi83QlRKYjdkNXhWZDBDS1ExZnlyeEMx?=
 =?utf-8?B?dWNtaXRzcGFOaFBHb05MZ0ZPeWJ4UUtuRElxeEZkUFV5alFLZ01qNTU2SnFn?=
 =?utf-8?B?Mm5tSWpqNEwwOW9neHE4Yk5GTTRTQ2pQcGw1RkN3ZWNYRjV1ODhFS3o3bnRs?=
 =?utf-8?B?cEJPT0RnajB1OEx0dUI1UUV5N0dzRkpKOTZDUys5NGI0aUtyNW9GQ2s5WXpZ?=
 =?utf-8?B?eGJOMUVTZDhWQk5iUW1xT0c2SENkWFRuZTFmSXRnSjZWRTNZNGhVYUliODZL?=
 =?utf-8?B?Ly9ZUExoRVMvZFlJR3dIcTlqQjZQTEwxMUVDWWs5M3dZMzZ2UjJ1bjJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1VJekRuYTNDWFpmd1RWSTcvUGxlOWI5bFc4NDBITTIwbDZ6REt6dGFmSTcx?=
 =?utf-8?B?T1pPR09MdlY5SG80VDZjKzBkZGRJbENmMXo0YWRPVFFxa2hWeFJSeEEvcVJC?=
 =?utf-8?B?T3VrbGx0Vk9ZYTBpeXVPMUJ0NjNjWlQvS3ByZ1FUblpMOVF1NkNENlR1dm1L?=
 =?utf-8?B?TGdIMmxSQWRGemNWK1FMdFRSQkpxYjNVSzdidUFzZUxNeE1YTmc4dHVmYUY4?=
 =?utf-8?B?VkozRkF4ZHlObE5OK3VZSDU0Y3RDaE9nYnVMczlNRW42NGpyVE01NCt0bGtJ?=
 =?utf-8?B?K3hRcnd1YkRmV3pLZlFaZkNQQXlvYkUvWkhlNUtYS2p1WElSdzZHYno0aGJ0?=
 =?utf-8?B?NG1FODhjeFB1a3c4RDkySVVvOGJmL1B4VDc2LzY5Rzh5aWZLMjFTd2M1c0hh?=
 =?utf-8?B?em56OCtzR0N3Y01FZnJkZFFtOWxsVHZxZ0lyRWN3ZzBDbTJCS0FkcGQ1SVEz?=
 =?utf-8?B?Tms4Q3JUOFliS0Mzc0FySkF3eGdVOUg4c2hNZ2EwaXp4a1RpRkltWU9GbGYy?=
 =?utf-8?B?M3huTWFWb2ZRVnR0bHltT3lXd1Q2QkxvQzZ5WGphdFJ1TkU0eWU4V1hLdVJo?=
 =?utf-8?B?VHFwSXRZTXV5aGw4TFdLTXhHL1Rocm4wait5Sy9mY08xRGpVem15cGEyNXpD?=
 =?utf-8?B?dmJGVGhqaENmYmh4TmpVS2drbi9KVUQxSnV0WmQzVEZGTHpuQ2txOUZRUVJt?=
 =?utf-8?B?U2FQTk5INkNlc2xiK21GeCtyL3RrSTNUQWV3bllCdnk2WFJSSUpqb0l2bzN1?=
 =?utf-8?B?YUV2SGV1VGpMYkE1SkhyZlRtT3NwSUFuZVl4VEdTcjdwQ3FhNm9UWTNkSDVO?=
 =?utf-8?B?VWlRV2dOSHBhUjhvejIyS1RwN1BEZlhBMTQ2eXdoM2xhVldRMXdJUVVqN0w0?=
 =?utf-8?B?SDBTd1pIWXRiREQ5dWc3SUlJbnFUWitVa05yV3hIazBjYldONFR4QVlNNm5N?=
 =?utf-8?B?UVNQSVQ5RTE1dGFJUkNrTXFiK3d2RmtYVUZMSTFFRHU2bDdMaHVpbWJqSTNB?=
 =?utf-8?B?bkhLM0IxOTRZa3BReW8vRldHMDZHVGY5ZG5yc3MzbFh4T0JUNHA1YmtZbnJ2?=
 =?utf-8?B?Z0J1eFVVanhBZFRKUmc0Mkh3bnpUaFkwNVAwQmJkQ3FJUE9kQ2MrVlBXUTlK?=
 =?utf-8?B?UEt0T2pHTU9WMFlhbGJkY3NKZFdUSlJoYjhuR0hvTXAvcXNNMHNLbFo0c3NT?=
 =?utf-8?B?cjNkN3RNbWYreWNLdFI3UEZNdXJKTnRsTWVUMkpmSC9oRUsvUjVyRTZ5Y1JG?=
 =?utf-8?B?S2JaVW93WUVnZGcwTVFxV3JudkpXRUJpcG9tVTNiQzRLRExKYi9UVFpiNUxn?=
 =?utf-8?B?cGhVR3JqYUE3cW1aR2drcDVhVEt1RWV1dG9hako1R2o2czVmN3cxWFBibFVF?=
 =?utf-8?B?aU4xYW5jeGFwSUdaTDd4K0dyVUtmWXd5RnR2emlYN3ZUN05NR3B2UHBYbmx1?=
 =?utf-8?B?SHJhLzBNSnB2RmE1UVJGVDhMRHhqREFYSHRtemtjVGk2bnI2OTE0bFgxcHJB?=
 =?utf-8?B?aEVsaFc2bi9EWkI2UUZTaWtreWVNYjI0a2szMk1nMGpPalFFMHFoRmV3dk80?=
 =?utf-8?B?eTFDcWJaSVFFNVpmbWdjaDFjbDIwTU4wRkZlRnFoVlRkWFJiZE9ZcXpGWS9r?=
 =?utf-8?B?MWRIM3YvOXR3cEd2RllJUDhtbHhpRk5NN1lWWTRuWUZDdnhEanV5MU9zTnR6?=
 =?utf-8?B?bmM3cHNkRlJTbWRvQ3VaVHNxS3lOL1NpaUZOcVovZmFjV0hIeVQvRm5LdmpJ?=
 =?utf-8?B?RUVRelpsaXVQK2g5Vm83cyt4OTBBblJWMitlU1BWZTRqejkyQXdJdzVid0Zp?=
 =?utf-8?B?SVBwMVJWbndKeHNJWHlYMlI0UXRVMnB5RkdUeXJpM01HcEVPc0p4OFVZc25k?=
 =?utf-8?B?aGN5Q2czTEg5cldtOW9JME9aQzBDc3FvZzh4YlVLOEswaXVxSndHRDZ3d1o2?=
 =?utf-8?B?T1JwQlVvWFJtcXRTbUhpbDlLWjgzTC81dGFmY3dsK3pwY1RsNDRseVZwb0xw?=
 =?utf-8?B?Nmt4NDJhNjVEelc1bnlTVWFlQkZtVGwveUgxNVBrRGRMTE5Ta1JZUjBJRXFT?=
 =?utf-8?B?c2hXeFpleDhjYm9qcHFuSWVvckM1UzlwTnlrb3VnYmExVUllZnRJVjlhZ1J5?=
 =?utf-8?B?aUZuODhZMkV4dnF0SFNwcWpkTXpQemNqN2ZJQ1lPQjN3d2QwRzdxMktMZ2Vo?=
 =?utf-8?B?dThaWXRjclFnVGpHSExYcDhDQ2J2Ry85TDV6eFJvcWgvZUUyd1NYVk9FMTJD?=
 =?utf-8?Q?0ymStmzYenZhPA8vPHQKNlKK9iGlfiA1jamsDoZQFQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ae5bfa-68ce-4ea1-808a-08dc80c50c33
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:24:58.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76YBSCjZyu8FzfZZK89JU+UbjlXeOkw1oIiO27IoFQzbKG7yvqPWyGnnCrHDc0mi8UnWKzRadA8G5vva/qxMCgDe3XRPxg3EEaUJrGTPRD/bM75q4yqLV3W5GkkgeG+W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7680


On 5/28/24 23:25, Ratheesh Kannoth wrote:
> On 2024-05-29 at 00:48:22, admiyo@os.amperecomputing.com (admiyo@os.amperecomputing.com) wrote:
>> From: Adam Young <admiyo@amperecomputing.com>
>> --- a/drivers/acpi/acpica/rsaddr.c
>> +++ b/drivers/acpi/acpica/rsaddr.c
>> @@ -282,7 +282,7 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
>>
>>   	/* Validate the Resource Type */
>>
>> -	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
>> +	if ((address.resource_type > 2) && (address.resource_type < 0xC0) && (address.resource_type != 10)) {
> use macros or enums instead of hard coded numbers. That will improve code readability.

In general I agree, but this code is generated  from ACPICA and will not 
be directly commited.  The corresponding patch to acpica has already 
merged. What you see here is what the code will look like post-process 
from ACPICA conversion.


>
>>   		return (FALSE);
>>   	}
>>
>> --
>> 2.34.1
>>

