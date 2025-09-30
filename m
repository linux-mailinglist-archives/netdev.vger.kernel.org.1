Return-Path: <netdev+bounces-227398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00290BAEAB2
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 00:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD0D1924A3B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E227A469;
	Tue, 30 Sep 2025 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="SSdkhH7Z"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022110.outbound.protection.outlook.com [52.101.48.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAA1547C9;
	Tue, 30 Sep 2025 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270375; cv=fail; b=uGhYAgu6cPCDBpx3QdSCYrCiUGLKZzmkf7mRySjor/tqqxT2stcW3B7Tln4bl9qZuxI7Rkgx7faYdWsxtO8ygRh6VtBUOJ2QoAOOh57r5v56pHE5HRzAh45w6JH6N3jOBLN9z4GzPkiQBh5PKxf5P65a0YR4k8mEorqQjfpQ6BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270375; c=relaxed/simple;
	bh=x1ef6KPCms/sHZX9RiFK4wbMs86+W5xdlecCPfYqW3M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/o0IMioQZQSGgFHnd7bT9uCOp7bwLKJM8LIqbxr+Gnk7A/IEj6X4nCp9yjblusRJ/VmMUfh+y45tMzRDvrlzqBmbnhqiKm/xx5VIiOYo7b51pPdZa+X8vrL896WMxPw/3uSpBVosUtLB30qiggTJoPTvOjl/lp66lACTz/3z4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=SSdkhH7Z reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.48.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UM1iP5h4EAqOJZKO6YDig5bIFlWlKZGc8PKZJQvxNBStCrYXOLZi2o5cEyAtO53r1qQIqWvZ7dpn/OH1rHCJM2UWiYiBSsC74H5pEuirQbMeQoEn/72CJmxulx8ipW3Go38jbrgkGsVDas8cUnJw22mY122f0hmUF/H2lHOiQv6Tobx839NTK4NGMSHpZrCdw0JfXQvlr5+AbiSwLUV81pDiMTq6fdudvPiDbkj4CE/Jjy6VQTbt7HY7sssoR7G6wq+Mg9Zw1yuquUGhwz2JelmZvZ5fF1P39T+1j+tXcgLXJ60j/s549iV3QECldmfUfIL+I4xzrTk9QKTpS0Kd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tndZZxG42YkqQS1WN0Z66qCfZBIdUcwgjTl2oMq+paQ=;
 b=I84VFSj7j3GLa1neq+gq8mw4hS6CgTjPvCPDvaWl3ifR2HHrp3q3erawm4JNby/xFdPUjbaYGdOvqI3XsZ+nIMVbvd/3yHWZp05jmIYmzyv65R7rNV5ALuasGdP0WeILwSQSqHtdqXLUJyYPdA7PWsk0lPPahaEga/qchjQi4QHEswnkNOTXRd0J1VP8zU/nFkYeOJfSn2W7KIZVthUDiSmUAvCy/Wq8RruSsVfzgr2xwA6ycy9iluViHSjsLFbLqoy6PWCnkM7BApfrCxRgFGYnKycS7goaXiq6zUiGBbJiu5faUn7Vr6QB4Cowm1Cz7zg091lKVoH5j/pZmcmDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tndZZxG42YkqQS1WN0Z66qCfZBIdUcwgjTl2oMq+paQ=;
 b=SSdkhH7ZQJ391SCDv33EKs69g4dIyffmZalL7whEAiAbtfpFn/6VG+U0p+g8UeIMFgzC+8vFq6oZ6lnugAHfMvn7CL6G0h25xn4kEP5Dayd+9EOeuh8+o0wzFRUPUHqQfrzmVLgvBM6l2PhzVaNH2i2w76Bx2NpNs8lLIn7Fl88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV8PR01MB8653.prod.exchangelabs.com (2603:10b6:408:1e7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Tue, 30 Sep 2025 22:12:47 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 22:12:46 +0000
Message-ID: <422411c7-231a-4c05-a99a-60639d560fec@amperemail.onmicrosoft.com>
Date: Tue, 30 Sep 2025 18:12:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
 Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <20250930-little-numbat-of-justice-e8a3da@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250930-little-numbat-of-justice-e8a3da@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:930:8b::22) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV8PR01MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: de2f452c-fc42-469f-b516-08de006e7c5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWswdXpBK3VMcWVsRXJKYzdCKzNTQTh4ZS9kdzQzL1UyV1BEOFhzZkNsd3BQ?=
 =?utf-8?B?N0xTdzY1dWMrTUROOXgzYm91cUJ0WVorWCtGTy80NCtnbTdHRzV2S09SRllo?=
 =?utf-8?B?NXJZaXlyZkFSOHZMbGY2czBhL3M4UncxQmtLb2NFTitmWHYwN0Z4bjNLbENZ?=
 =?utf-8?B?YWJOK2dSWnlad3kxNE5IOTBDcnhmQjBOcHBUelFZbGVlVjU4TmlwcmtENnZT?=
 =?utf-8?B?Ri9NVWJlQVVZV2ZXVTJPb01YcDgyQjVUbUIxZi9iRTFUZXhOdCs1YXN2bk5x?=
 =?utf-8?B?Zmg4SnlGZ3JPRnEzc1hNUmZKRGRqaC9YZzAzbUtUeUd5Tis1ZUJsUDVsUm5W?=
 =?utf-8?B?UDFIbzF1OURDNnhmVlRxTEFhYStEUm1IdFhPYnhMYnUrQkpkRTd1MjlKRVZl?=
 =?utf-8?B?bWNvRFBxOWRoWnFTMnFhd2VkY2RsQ0E3dUV0dEx2R1NvZkNYTndUSU1yR0FX?=
 =?utf-8?B?eHExNnlpNjRPRDA1QjVuTTU3NzgyQ2tnc0pZNm10czFRVnNncVNWb1Izbnhy?=
 =?utf-8?B?bFA5SWFvR2MxU1M0aTJyYVJwMnhNNGNhZVo2M3RnZEloY1VDVHJMbWl2c1hx?=
 =?utf-8?B?d09INm9pQkxDOEpkVkZnVXlIU1NBdHk3VlZPOHU4d2V0cW5oYWdpNzkwMmNs?=
 =?utf-8?B?NDJyTFI1cWF2Rm9JN1FCNEhWQ0xxNjk3OHVrME9NSC9ReWFwcWhWR3NTWFJQ?=
 =?utf-8?B?cFBJRFpOWEZCYVpsd251Y0VFYVZBU2FOeHBxSFVrQzVEa3V2UytWbmZBdUJl?=
 =?utf-8?B?dE9IWFErKzZwNW83Z0lVRnoxUHNESTMva2VzRU1VSkpwOHpGQldzanhiMmgw?=
 =?utf-8?B?MnlFOFptdVpLVXo1dFdjaW94RE1GQ3BzRDRJaEdqdCtaRFloZWp1UUVXZ3I0?=
 =?utf-8?B?aEc5aTRRdmc3cDcyTHEwbFgyOG81ZnBvZmtjdURiVHYzeTFiV0U4UUVndi9V?=
 =?utf-8?B?OGFkcndSMFJQMktSVzE0NzFmUHRTOFRFWnBPRGxYbHlBalJ3VWxUQzZBUlo5?=
 =?utf-8?B?MHZ4UWtTUmZHcUR6SGE2YUtPRlJvd0hMU25TcytpNTl1RkNYYnFqcmVWcXIr?=
 =?utf-8?B?Vk5UNFJnb25YN1E3Q3VtU2tBOWIvNGU5RzZkMVhoR1ExeXdWVGNvSXNwSWpi?=
 =?utf-8?B?SVB6VUZSQTQ0dDZSUnFKU2RhNjhBUytCbldrekZBVTRIL3Vtb3ZkdzlaSTMx?=
 =?utf-8?B?TTRwUllBSXdSUkFVT0s5RWM5R0svaWhBbHFzeHRmUTRzcFZ1dllNRzRFUHNC?=
 =?utf-8?B?YWU4Q0dOOFlOOWdyYURBbmpldThmaFJUTTR3WUpxYisrZTJ5TEgxbG5mUTVl?=
 =?utf-8?B?TWFMbm1JZW1oQ3BZODlvUVhpVWN0a1lOdjE0ZFZudzRmRlMrdHlWSGJhQkR2?=
 =?utf-8?B?ZVJ2VjBUOWp2aDJLcHU0NzNoNDROTC8vYXpodXFISkFUMWV0N2w2M0NtbUgx?=
 =?utf-8?B?ZWorelE2THcrZDRaYmU3eEpUSEM1emVXQk82dVdtUnZiaStjT2NsZ3lSTS9B?=
 =?utf-8?B?anlCSitoK1N0NkdOanF4UFhRTkx5M3J3d3lGWXZjV29JY3VHUncxVXpnUlNS?=
 =?utf-8?B?Vm16ZFowa01kMnVrbENCN2JrWHZ2R2E4SG42d0w2OVIwZEtCa0lnU25KdW54?=
 =?utf-8?B?bkZuRjNERFlRblBMODc3QkZZRzNyMG00cWl5TisxRFlFR1FwVTUzUWdpYjgw?=
 =?utf-8?B?blZrdFZwR3NFR3Z3VEJrclowT09lUVYrVXB6RjBqUDhDa3ErdWM2Q25xMHc4?=
 =?utf-8?B?S2xKM1dHRmRxRHFxdkpTbytoRm13aDArTStGUWtyNGE5UEE4QUk0YlpFMzl4?=
 =?utf-8?B?VTMwZ0l3dmIxcU0rcFdLU25lNVB5Wm9TZVVqV1JYSXAzVDBJb3V6Q2FyMW9k?=
 =?utf-8?B?c3NxNFU2L01jZWluYWxtY1p0ckpQaG1udDZhTlI1a0Q0RU1DdGFUc1pnKzNu?=
 =?utf-8?Q?F0QlTgInnMbgFCBRoPhBhI0duu8C0fFj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGVKRGI0K3NOYUNudDRZa3hQbkNXUHFEQ2Rtc3ZvRU5PUndVRWJhY3NEaGZa?=
 =?utf-8?B?VUMyelJMRldPTENmRzA3SFFmd1BTZnJhMmJXMzJxQWF1aHhSZnpnaUZxVVhV?=
 =?utf-8?B?T3pyWHFibXgyS0xpT2Exb0Z6WGlzemxxWTFvMFFOd2ExbDJXeDZxaFdodFdm?=
 =?utf-8?B?MXpud1ZSTVMzM2xxRnhpWnNFZnVhL2JSV3duUzQ2YVJRQloyWkRqWXhVRVRV?=
 =?utf-8?B?dU5rWkM0OU1UL3J4ZnQ2RnNqYUcvdEJkcVQ1M294TlJqMCtKTDdGRUt4ZVl2?=
 =?utf-8?B?Y1dJSXplSWlkb3hRa21pRTFEOWpUeFVRN2dTTVFaaENkbHNqRjluRE03RWwy?=
 =?utf-8?B?eXpRVEZRMUIzUGwrSXg0NjVrNnAzZEwrcG9zNVdXcDRtb21ocHZMRkkrb0hU?=
 =?utf-8?B?WnExOGJLVGhIUjRqbHV5Y2VyMzNObkRKamI0U1o2dUtucVpwR1hUSFc4MHZ2?=
 =?utf-8?B?QW9SYXdNZjJRWTI0dzJQVU1UTVZya1BqWUJqVWQ2bTBpeTVtK2FuMksvYUd5?=
 =?utf-8?B?eCtzdllPQStyS3dQa2RkeDRLWERVTXB3RzNXREthdERSK245MlRRRjFIcFBG?=
 =?utf-8?B?VWtHWWdVOW10NVNoSnp0UERjdFhpcmYwTzdPK1owbGRhTHF4angvdXRkNWN5?=
 =?utf-8?B?bk5yelpPelZ5dm4rcVNrSWpwRVdlUm9EL1R1MVFtOENnOWZhNGxkUnE3ZlhX?=
 =?utf-8?B?a3BvTTRaOVEwUGx5UTg5emFBYjRWQWo4UDBQM3RldlJHOG96QXBOUzZENlN6?=
 =?utf-8?B?aWhaNTNnZjJxeFg3UE1YeUFEMlhqR21MTkZ0MjRFSTlncVZoQkhlSSsvVnQx?=
 =?utf-8?B?M25EZC9QVFRPeDZ6RnVOdXNIQ3J3YjlnRUlYbCtKS1NvTHlSSWpUVUJlQWpW?=
 =?utf-8?B?YlIxUTdtZDBXMEJscmc4UWlMdUZIeU5EUytycEY0QjRJSUR6cmtUS2E4SDNF?=
 =?utf-8?B?UllWSHNxU2tVNlVuWFhYTTB3QjJNK242NFU0bzlVNlBwWW1KcExETFdFWStv?=
 =?utf-8?B?Y09CTnpTNkRDbU1XQUVLWHZ6c21MWE5ycHZyamVaY3dzbGRzZ1dobnJCdEw2?=
 =?utf-8?B?d0pGZG1BdWROZXNoeUtLMnVlcm1BdEdBWEphT3ZOaHFQcW1YVmRScDk5aWRv?=
 =?utf-8?B?c0dCWkJ3RXdDZjZ5QW8zVEp1bGUwa01pbXRJamhUekoxK0RNTnl4S0hDNlZY?=
 =?utf-8?B?N0dWdmFkSkpWWGxxeXlNeFN6bzVGUEJEQVNldDdUajVBQ21jRVRiSTQ4T1hy?=
 =?utf-8?B?NCtZZmI0MjJrWkU1ZWNabTgrTXUzNUxxbXNwTkNvc2ZmWkZCNzZ1b24yWlVL?=
 =?utf-8?B?QWtLQkgwNGdBbGE4SlRtMmJCUWNJZ3BMQ3cvZ3JDODVBTit4dWtIUWNSNXI3?=
 =?utf-8?B?NzJURjdvOEdDeEpGV2VxbEYwRkRSSldsK2ovNFF4UU9GSkNpR3B0di9QTGxL?=
 =?utf-8?B?ejYzcWM2Yk96bkRqY3lLVjhHWXpSakpHNmdodnZNS2J5L2hFa29HT2g1N1lO?=
 =?utf-8?B?NGF5TjE1NFYzamdOU2RrdVJaTzN2SkliZEZIVkZrNm8vcUpZaGZnREkvNmlr?=
 =?utf-8?B?aWVmVWdkY240bVdESlRkTTl6UXhrZXArNTF6VERqV1FtZkVWNWVVNXhCS2l3?=
 =?utf-8?B?TlJ1M2JvbzdzRFNRdFpMUXllUzFXSEFSem5yM1pPc0dSWVZiWFNlNDhsWjR1?=
 =?utf-8?B?bmdJVkpmMmhlTkh3TnArT3hMNDFTa3crS2IvcmtFU3JCdGgvRGR6WjVNNk45?=
 =?utf-8?B?THlzaHg4UE9aSjZ6c3h2dFU1cjZLMVRuTkptalVTeURodVZnMitjRDVaR1hx?=
 =?utf-8?B?SmNtcGF4Y2doZ2ZMSnltSnZrUGwxUVhWSlg2K0tnaWlFRVlVeHE2bE5paHhL?=
 =?utf-8?B?LzMyb1hDaUR5dXZycGdkd3VGTHJ6NWl5U1hlMWtyMUR0eEtzN1o4V3dTT1Iw?=
 =?utf-8?B?YjJBclBEZ2M0M1AxNkRBYVBUTXRTOWJlUEN6MnMvRGpnaE95bms3V1A3eEJa?=
 =?utf-8?B?RmI1a3diRXRNdFFXNmNsQjlYMUpxQWVjb1czc2NHUHFkZDViSGg4SzBNRnJX?=
 =?utf-8?B?OENIQUJhL2lmWjM3c0Yzdm54eTlnUkR1b2l3SXhyeDhMUytEK090bWtLTWJ0?=
 =?utf-8?B?V2RiTXlNaDQ4alNTSGs0c2tBWHltOUMyQ3NJV3NxQ2IvN2FLK0tsY0dIRCt0?=
 =?utf-8?B?V3F2dDBTcUdST09DUkZ0dmx6R1czZjFCRnhCOXByNVhyL2J3K2dNTnNoZ1ZN?=
 =?utf-8?Q?VkN1zh5RDHG1uxjtG7GN6Un377z6kIZ5kon5LDH9/8=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2f452c-fc42-469f-b516-08de006e7c5b
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 22:12:46.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp77T01CGUY8uVROz2GED2ERDrGVOXZIgLHrjvXnMPTXnwlip7d+2yQ5uOXcsAI20wVscVN95M4DAjeJH7Q4oR/nfcav+UX/VzWLIyvmmxkCRRTq0XZJYJK+S5y0o2ta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8653

ACK to reverting. I will submit the changes again, and in separate patches.

I will try to address our comments in line, so we have continuity of 
discussion.  We can point to these messages from future reviews.

On 9/30/25 05:37, Sudeep Holla wrote:
> On Mon, Sep 29, 2025 at 01:11:23PM -0400, Adam Young wrote:
>> I posted a patch that addresses a few of these issues.  Here is a top level
>> description of the isse
>>
>> The correct way to use the mailbox API would be to allocate a buffer for the
>> message,write the message to that buffer, and pass it in to
>> mbox_send_message.  The abstraction is designed to then provide sequential
>> access to the shared resource in order to send the messages in order.  The
>> existing PCC Mailbox implementation violated this abstraction.  It requires
>> each individual driver re-implement all of the sequential ordering to access
>> the shared buffer.
>>
> Please, let us keep the avoiding duplication as a separate topic atleast for
> the discussion. We can take care of it even before merging if you prefer that
> way but we need to explore what other drivers can use it. Otherwise it is
> not yet duplication right ?
>
>> Why? Because they are all type 2 drivers, and the shared buffer is 64bits in
>> length:  32bits for signature, 16 bits for command, 16 bits for status.  It
>> would be execessive to kmalloc a buffer of this size.
>>
> Sure, if there is only and first driver needing large buffers, it is still
> not duplication yet. I agree it can be moved to PCC, but lets start with
> you client driver code first and then take it from there.
>
>> This shows the shortcoming of the mailbox API.  The mailbox API assumes that
>> there is a large enough buffer passed in to only provide a void * pointer to
>> the message.  Since the value is small enough to fit into a single register,
>> it the mailbox abstraction could provide an implementation that stored a
>> union of a void * and word.  With that change, all of the type 2
>> implementations could have their logic streamlined and moved into the PCC
>> mailbox.
>>
> No, it is left to the client driver interpretation as it clearly varies even
> within PCC type 1-5. Again, let us start with client driver code and see how
> to standardise later. I agree with PCC being standard, there is scope for
> avoiding duplication, but we will get to know that only if you first present
> it with the client driver code and we can then see how and what to make
> generic.
>
>> However, I am providing an implementation for a type3/type4 based driver,
>> and I do need the whole managmenet of the message buffer. IN addition, I
>> know of at least one other subsystem (MPAM) that will benefit from a type3
>> implementation.
>>
> Don't even go there. It is much bigger beast with all sorts of things to
> consider. Now that you have mentioned that, I am interested more to look
> at MPAM driver usage as well before merging anything as generic as I know
> MPAM is not so trivial. You pulled that topic into this, sorry 😉.

This actually got me to laugh.  Nervously.  I wonder what else is coming.


>
>> On 9/26/25 11:33, Sudeep Holla wrote:
>>> This reverts commit 5378bdf6a611a32500fccf13d14156f219bb0c85.
>>>
>>> Commit 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
>>> attempted to introduce generic helpers for managing the PCC shared memory,
>>> but it largely duplicates functionality already provided by the mailbox
>>> core and leaves gaps:
>>>
>>> 1. TX preparation: The mailbox framework already supports this via
>>>     ->tx_prepare callback for mailbox clients. The patch adds
>>>     pcc_write_to_buffer() and expects clients to toggle pchan->chan.manage_writes,
>>>     but no drivers set manage_writes, so pcc_write_to_buffer() has no users.
>> tx prepare is insufficient, as it does not provide access to the type3
>> flags.  IN addition, it forces the user to manage the buffer memory
>> directly.  WHile this is a necessary workaround for type 2 non extended
>> memory regions, it does not make sense for a managed resource like the
>> mailbox.
>>
> Sorry if I am slow in understanding but I still struggle why tx_prepare won't
> work for you. Please don't jump to solve 2 problems at the same time as it
> just adds more confusion. Let us see if and how to make tx_prepare work for
> your driver. And then we can look at standardising it as a helper function
> that can be use in all the PCC mailbox client drivers if we can do that.
>
> You are just adding parallel and optional APIs just to get your driver
> working here. I am not against standardising to avoid duplication which
> is your concern(very valid) but doen't need to be solved by adding another
> API when the existing APIs already provides mechanism to do that.
>
> If you need information about the PCC type3/4, we can explore that as well.

I will submit a more detailed explaination when I resubmit that 
functionality.

The short of it is that the Type3 Register information is in the PCCT, 
and that is not available outside mailbox/pcc.c

For Type 2, there is an accessor function that exposes if the buffer is 
safe to write.  For Type 3, you need the command completion fields and 
registers,...and there are two of them, one for setting and one for 
reading.

Without this field, you cannot safely write to the shared buffer in 
tx_prepare.  I am attempting to write it in such a way that it works for 
any extended memory driver.  What I followed here is the PCC spec, not 
anything specific to the network driver I  submitted to call it.

So, yes, the alternative is to create a new accessor function that 
returns the cmd completion bit, but that would need to be called  from 
inside of a spin lock.




>
>> You are correct that the manage_writes flag can be removed, but if (and only
>> if) we limit the logic to type 3 or type 4 drivers.  I have made that change
>> in a follow on patch:
>>
> OK, but I would like to start fresh reverting this patch.

I can see the value in that, and support the decision.



>
>>> 2. RX handling: Data reception is already delivered through
>>>      mbox_chan_received_data() and client ->rx_callback. The patch adds an
>>>      optional pchan->chan.rx_alloc, which again has no users and duplicates
>>>      the existing path.
>> The change needs to go in before there are users. The patch series that
>> introduced this change requires this or a comparable callback mechanism.
>>
> Not always necessary. Yes if it is agreed to get the user merged. But I am
> now questioning why you need it when you do have rx_callback.

RX callback is optional.  For large buffers, we want to let the driver 
specify how to allocate the buffers.   RX Callback will tell the driver 
that there is data, but would extend the pattern of requiring direct 
IO-memory access instead of using the message parameter.


>
>> However, the reviewers have shown that there is a race condition if the
>> callback is provided to the PCC  mailbox Channel, and thus I have provided a
>> patch which moves this callback up to the Mailbox API.
> Sorry if I have missed it. Can you please point me to the race condition in
> question. I am interested to know more details.

The review in question was on Re: [PATCH net-next v28 1/1] mctp pcc: 
Implement MCTP over PCC Transport

Jeremy's comment was:

"Also: you're setting the client rx_callback *after*having set up the 
PCC channel. Won't this race with RX on the inbox?"

And he is right.  If you bring up a driver when the platform has 
messages ready to send, the alloc function needs to be available as soon 
as the mailbox is active.  If not, there will be a race between message 
delivery and the assignment of the alloc function.

That is why I am proposing a change to the mailbox API.  I realize that 
this greatly increases the scope of the discussion. However, without 
providing the driver some way to specify how to allocate large buffers,  
message deliver becomes much more complicated.  Essentially, the mailbox 
needs to hard code a message allocation scheme, and that means that a 
mechanism like PCC cannot handle different allocation schemes.   Since 
the driver I am writing is a network driver, the right type of buffer is 
of type struct sk_buff.  I would not want to make all PCC type 3 drivers 
use struct sk_buff, obviously.  I wanted to limit the change to the PCC 
mailbox, but it does not appear to be possible without the race condition.

The change to the mailbox api was submitted in a change titled
  [PATCH net-next v29 1/3] mailbox: add callback function for rx buffer 
allocation


>
>> This change, which is obviosuly not required when returning a single byte,
>> is essential when dealing with larger buffers, such as those used by network
>> drivers.
>>
> I assume it can't be beyond the shmem area anyways. That can be read from the
> rx_callback. Again I haven't understood your reasoning as why the allocation
> and copy can't be part of rx_callback.

That is correct.  It is only the shared memory region.  Yes, it can be 
read from rx_callback.  But the protocol is more complex than just 
reading the buffer, and I was  trying to write it in a reusable fashion 
and inaccordance with the intention of the mailbox API.

>
>>> 3. Completion handling: While adding last_tx_done is directionally useful,
>>>      the implementation only covers Type 3/4 and fails to handle the absence
>>>      of a command_complete register, so it is incomplete for other types.
>> Applying it to type 2 and earlier would require a huge life of rewriting
>> code that is both  multi architecture (CPPC)  and on esoteric hardware
>> (XGene) and thus very hard to test.
> True but you have changed the generic code which could break Type1/2 PCC.
> I am not sure if it is tested yet.
I did basic testing: CPPC still works correctly on the systems that this 
code runs on.
>
>> While those drivers should make better use of  the mailbox mechanism,
>> stopping the type 3 drivers from using this approach  stops an effort to
>> provide a common implementation base. That should happen in future patches,
>> as part of reqorking the type 2 drivers.
> No you need to take care to apply your changes only for Type3/4 so that
> Type1/2 is unaffected. You can expect to break and someone else to fix
> the breakage later.

Agreed.  The code was written to only affect the path for Type3/4 
interfaces.

The managed_writes flag was originally for just that reason: make the 
code explicitly opt in.  However, the write (outgoing) message flow is 
only changed for type 3, and thus managed_writes is not needed.   I 
would suggest a standard that the mssg is NULL for cases where the 
driver is not going to actually send the data via mbox_send_message and 
instead is going to write the buffer directly.

  The write_response path was only taken if the rx_alloc callback is 
set, and cannot happen for a pre-existing driver that does not set that 
callback.


>
>> Command Complete is part of the PCC specification for type 3 drivers.
>>
> Agreed, that's not the argument. The check is done unconditionally. I will
> send the patch once we agree to revert this change and start fresh. And each
> feature handled separately instead of mixing 3 different things in one patch.

The check happens in pcc_write_to_buffer and only

if (!pchan->chan.manage_writes)

However, we can and should make that check be that the channel is a 
type3/4 instead.  I did that in another patch, which I will replicate 
post revert.

>
>>> Given the duplication and incomplete coverage, revert this change. Any new
>>> requirements should be addressed in focused follow-ups rather than bundling
>>> multiple behavioral changes together.
>> I am willing to break up the previous work into multiple steps, provided the
>> above arguments you provided are not going to prevent them from getting
>> merged.  Type 3/4 drivers can and should make use of the Mailbox
>> abstraction. Doing so can lay the ground work for making the type 2 drivers
>> share a common implementation of the shared buffer management.
>>
> Sure. Lets revert this patch and start discussing your individual requirements
> in individual patches and check why tx_prepare and rx_callback can't work for
> you. Please share the client driver code changes you tried when checking
> tx_prepare and rx_callback as well so that we can see why it can't work.

Thanks for your attention and feedback.  Much appreciated.




