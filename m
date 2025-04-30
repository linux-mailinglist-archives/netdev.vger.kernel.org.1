Return-Path: <netdev+bounces-186967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AEEAA4612
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0695E3AF25B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71CB215073;
	Wed, 30 Apr 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nep8IgSj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C321EB5CB
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003481; cv=fail; b=faUiYzlUb+nZOUnsczHgCz1pdqlbEm89xJLb0QWJTfxKxy86kRyZLe78Z/WlGPInqwPgeMl8i8zPcf0dbsjfhd26wBo4QWYDCINXMaIHqf9o+z7aumjQPaUCCaMyXHFpG1WjLkSE0+UhnefFY38Bkr3Qh090JmcVdNCnuJGNi8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003481; c=relaxed/simple;
	bh=V0ogRrAGFFPjS1oEQgUBZIevYX/8KGkX5QYO8WBux2o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qoguu4znAecw9VLgIPyULMqkdb1C4Eky7NrakZqWf7XHoph5HKXso748WN3Zmu3+AyjL7rgnTWX8YfUdqa4UIJhDcNNzhgNzm3xRoCtBRNPMJ5cm3qzLyBis3lcWhfHzQ58RWJk0TQUQYgjuXHyVKiVYLqistCzagqYgwPO5AUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nep8IgSj; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtS0FIdI5iioR1Kn0Ak0VW4rCBKLDBjMlQDbbz3eUCroM15Wtl8Gctm3d1xUKGt5tmSOQ0d/6cgX0BznShNUJUZk570KIZp4hqeYcTSiLfhretBvlmoLTf9a1+uO6HFqelM7l13IPG0aVpVSAjZwkTnERCTnLsDQhLD2E7R1PC7FueLvnij61nwwhVB7tIUEjR/C6enXsKrWAKvYfXRWitwrtkDOo89wmFJV1+5eX73CvsB/eIAGdL3B3n7bA+jGEk2HJaCb5yLDlyNzL83NulmfpKVur4Apx017OyoAj8vE3h9v6JsXxq+udmTJopAMr2YQ4q/Pw20G414ER0+Xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICzf/DhklwZJ6dTFs85y/fGwTAagp3PcbNl/CE4qoQc=;
 b=MtF967zeA3+htu5jg+5MSbjSt/WstooqOottMQ+1dz15MzHq4mnElrRIKwuUU67nkVdDaiQykwA2AKGgOmDoyg/3JLZxu3skmQPEZzYsN7hJ43ZAz32IkDiHWVHDaGIcCVT5YgkAK+6pr7H5uT/fldwAJHQQ+uB+qiwa8UbWrMfCo+7LW7mIII9PDB1IZJ/ZHZTBwhMlGkP8WJap0t1+L+FrX4bjlWd6ET8bi22ZGo0M3iDVN1hOefhnJXUUxBDfv49wUX/UzAgHXj0ax/7NDRNkptahj1449L5yLbhXM0Us7rvVJICW7XC/V7cni8Lx1K5CZAVBqAumDGDRbO9C0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICzf/DhklwZJ6dTFs85y/fGwTAagp3PcbNl/CE4qoQc=;
 b=nep8IgSjTCOjTDcENwz+9fNvr9uDCbHXB4wmW6EJeErSO11HuMw0SRRi/nRWKrxzpPw1zlah4fTcvKBT8HpU2K6NzyMrcwQvEABLjfnUfxF0zIFnbcMOv2zHYOWXwzZm2RAU7LCqIJRbh6lNafsea6qQb/yPSTdvl5BpgpEYtM7MsBld8NYkhnh1gb+/2xvbf4wNvmfLF3UvTNIlgQXi774+2+5b2U9weM3vdmaAefablaTU/sMgPfOMKcoeXSSgOvF5eUrmDjZtZEuYRA3tJAIyaybfFkHkE8dGRqQs+XSu3SE1khi4OiElrEd+ugFvySE+K0Tp0gA+I5/0TA8VPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 08:57:52 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:57:51 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	edumazet@google.com
Subject: [PATCH v28 00/20] nvme-tcp receive offloads
Date: Wed, 30 Apr 2025 08:57:21 +0000
Message-Id: <20250430085741.5108-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b04445-8ab3-48b8-8b9e-08dd87c51690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkpPa0Z2Z3N3NkFrU1YvVFczUDFQK2g1T0U3RkZPZGtNSXZHT2xhdW9YeWlK?=
 =?utf-8?B?QVA1S0g4Nk1VajJXWEZMVU9yMjl5Z3pWNWdUb1pFbEpxMTkyUG5vS1J2bjNR?=
 =?utf-8?B?MGFJb1BRcFNmK2ZYTlA0NUU1dWxMSDhhSDlDZWlrYVFtQms3aUtTbDQ5VDVa?=
 =?utf-8?B?ODRTZ3dDQ2Q5Q2NxU3F1M0p6alRNeFJJSmNRYkkwbDJ5cEZLRGN2WnpsWHhm?=
 =?utf-8?B?NHpPOUpQRWx0ZklsYWZpWnZweUxpNyt0cmRxcURDbldjc3FzV3YxeFNiTUpW?=
 =?utf-8?B?RG5PNVhCZjViRnZPQURJWmdialQvaHpROUNuR1VhK25wZ284cThFTlVKbFFj?=
 =?utf-8?B?VGFkV2tUa2Q4c2Z0ZEFWYnRSR0tWWk9ZUHhDYm90VkhncHJkM3Ribk1VR2Zj?=
 =?utf-8?B?YjZXTmpMRVgwamRXcTZjYTZpUzBFUjVUbTMrUFpWYTRnTGFxQ0RHejNFUndU?=
 =?utf-8?B?Smg2a3JESVcxV3M4cTg0VkMreHpqRkI4b0Mxd3BnNEdudHFsTDYwQTcxZFB4?=
 =?utf-8?B?Smx0ZVhhRWpQVXAyZWp3TTRUZVRZdE15Y3k1NEp4RDk0L1RVQVo4REt0SEph?=
 =?utf-8?B?SmRPeXJkRjNkR0pJN1Q3cEZLTVllOXNkY0ZkaVF3NjJlVFVXS0hJY0RQdWZr?=
 =?utf-8?B?SXRNK2VucHRwRjdPRlZRdHQ0emI3NzZEc0RrZ1V5NnZ4emZkUDZWRkhYenl2?=
 =?utf-8?B?eEFtVlZ2UjNjOVg1SXJUNXREajRWdUlvOHhsUVNqQ25DNk94ZndqT1h3Wng0?=
 =?utf-8?B?cHFNUTlXNHpzbGYwVzc3bE9xQWFibWRkbjUvNmsyb0FjNjQ2NWVzems1UWVR?=
 =?utf-8?B?TmtwK0tBZXlVZWlOcnZUVUFlWi9ST3VoeDIrVjVaSHY0UFFvL01JVW02L0RK?=
 =?utf-8?B?L0lmQUpMZDJhNTF3VWs5RDFrb1ZYbTBncnI3a21GYzBWMmdQdGhsT1dXVVFa?=
 =?utf-8?B?U2lFOVVhNEs2T1FocWdoTE12RkZkZVJ1V01jMXlKOXFmVFpFVEx1TkFHcTFN?=
 =?utf-8?B?Z2YxWnNEOEE5Sk5jT0t0ejA1bW5NbWM0eWlZYVVERkRWMmpFWHZ1clFxODVm?=
 =?utf-8?B?QmsycTdrN01Fa0ZpQXAybmhLK2tIV21zTzc0bkNUM3RaanVnTU44dXRhN1JI?=
 =?utf-8?B?aDh0T0YzWmxKNXVJSFFWYWJ4QVdWZlFjZnhCNHc3TXAzVTVqaFVobnQ1czl4?=
 =?utf-8?B?eTI2eXp4ODhucGRkMFdlQko3ZkE5R25oVW82SFpxNTF3ZldsVlhHS3RXTUFR?=
 =?utf-8?B?NGRMZEJkQ2MwbjhTOGcvZ3BZTGtTaWFxT204YWF3czBsNitBRFFFK2NaQXNI?=
 =?utf-8?B?SHI2Zkt1dC9HYWV5bGNWUUtoVjhEM2E1TVY0Ly85ZS82K1lpRGN1Tm1Mc296?=
 =?utf-8?B?cHdyZko1bFhEUzVuVTF1Kys2QWE1NzNNYVJ0U1BueHZFeTlUdTJ5K3BjZ0Rm?=
 =?utf-8?B?VHJ3U0lGN2c3ZW01dkxUeG05NjNoRDJOQ1lPdW9iMVZYOW9zSzlWUmNuRW01?=
 =?utf-8?B?bjdvcFRrc2ZBS05RK1k5ZS9KcDU3ZDlobUtYd0pleWNsQTdrYjRKM3B0TDBa?=
 =?utf-8?B?cnkzT0FmemwydjZHUGI0TjRCekxxV1kyWDFUK3FKbUh1RmFYSTk3blMzajBu?=
 =?utf-8?B?c1dGMlBPbUNEM1BWS3dhcnJiZ3prT1FRcytwdFNCOElkQTByQW1iK0V1bThG?=
 =?utf-8?B?bjFIVVZVa09FdGcxSGNuQkVwVTFybFh1T0tST3Q5bktGREY5cWpPSW1RTGxO?=
 =?utf-8?B?WlFFUks5UkNlVHArd1dudUF4a0pqNThzNzVLS25zcUV4MG1lOWhKcXBkeSsy?=
 =?utf-8?B?RFpPbUlscmYyVXFNZW1mY2Z1V1pTT29uWm5kUEI1aEZEcHVtdTNBL21lRzJQ?=
 =?utf-8?B?OWVyUUpkMkhjS3htMEZ6M3VZQUhxK05rSndyeDdHSllYTTVUT2FYRFloVmdy?=
 =?utf-8?Q?e4qtQtGWpcg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDZQN1lvUlh3YnVab1FsekpXaFhzR09RVDQyNzVaT3VaR0hwaXNxZ2tEcFlx?=
 =?utf-8?B?Q2FReGhuSVFEOFMyM3RCVGdERUtWVHVtT1hZaTR3L3hyN2hla3ZKOGI3YlpM?=
 =?utf-8?B?V0o3V3UrSjBGMGsva1ZUeUYraDF0OStKaDZhaE9NREg4R0hxeURyKzFFUWYr?=
 =?utf-8?B?VmtXeHREMk9BTGtpU051QnNKTWNsWXBDSWtnamg4dzRWV2VMMWhvSHhwRk1N?=
 =?utf-8?B?bXJhVXBYTHE5cDNPakhuSzNySlZES3YyMWhWWTdZSFhLcEVYVXNqV1IwTFZV?=
 =?utf-8?B?aVJxYmk5bVhuQlBqTkJvUlI4OFdSZll3VVB1MVdCWVdPT29HTUhiUHZoQUFE?=
 =?utf-8?B?d2thak5qQ3lSSHhYWFJwVFFXbnhNWnF5TDI0eGIxa0pOMnVDeURUYktJazJh?=
 =?utf-8?B?ZnFqV0U2c0lqMHRocW5LYnVMSXNhRm9oVVhNbnlmNlo3ckFzNUlreEFwRFdU?=
 =?utf-8?B?YlBtUW5MTkRXN1FuMnlhL21LUm1VLzRsVkJzRm9uUWZPUmJkVVhYQmhuRkVm?=
 =?utf-8?B?d1lOelNTOWViSHFwcjV3OEg3MDJXZWRBVVVFREc4YitrNjV1elpZSlArQjdJ?=
 =?utf-8?B?UndyOEVKcnhwVFkxQ1dhZEFOdThiMEVmWnpTMkhDeFFUNVZqV0JPako2REt4?=
 =?utf-8?B?YzN5Zk1PUisxVDV4V0dYQ2VzVnFvK3M5TmFlQWNINXRweDJBS21VZkVGclZI?=
 =?utf-8?B?ckV1b0N6R1ErQzBHYnhVUkpPcUUwWEt1TWVBZkJVK2ZZaXdIemkvNytxV3B1?=
 =?utf-8?B?V3VsdHU2eXJwcVI2TEJVNHQxSzN6cWJ5ZXdiMXI1dkdaUzR1dUlmRHI2WXdB?=
 =?utf-8?B?U1RsZFpYMmVMQkIvZDZGSXVvTlgxVHNocVg1aGlqODV2TVArNm9NZU5BR21B?=
 =?utf-8?B?cGp0ZWlrZjZVZDJnZi9TdDFkU1JqektEYzZOcVY3ZWZlbTdMZEo0bDU5TUU0?=
 =?utf-8?B?ZjJKSWRkSytXWFI0Q1lwNWo4aEZiT0ZIZlZ6VzhVeG1CbTdydlpocDdEN3Yx?=
 =?utf-8?B?U0xZSFNEaEFkQXdqcHhjeWJlQmdpVE0zbXIzTk5VZUd6L0ZOdWoxNElFU1Rt?=
 =?utf-8?B?Mi9IcHhkOUZhUUJLa21wTTRzM3lKaUpiNlh1c2JPVlhPZ3ZOTDduWlR6eWpN?=
 =?utf-8?B?eVdLV0RPNThUbGp2V3IyaXZlTE1vTU5nMHF3MWFxek00TnA5ZjFvNG1xaklH?=
 =?utf-8?B?em1QNGNBOVd3c1djNHJTUWFQQmpuV2Vyb0NqZzdJK21EVG5xVXZURFNVOExZ?=
 =?utf-8?B?b25BUVQ3VUt0cUdhZXhDWFhEKzRxUVdHRVJ3cXo3OUJxK0hMTlJhMHFhK0Fx?=
 =?utf-8?B?WGUySnFoVE5PZVB3S1pITTRQUzBqaTZvUXJWUU1zalVQMUNTMTl6eGpBaXRj?=
 =?utf-8?B?bCs0R0dLbCs2UzB3VUkyaittUS9JSGNubXZRVER0Wld0alJoVmFzZVNoSnNj?=
 =?utf-8?B?clBFdEREUDZMSGo0VU9ERnZPa0JhVjZ5QllEWHdCdGh0RkRxNnh1RUM3VCtP?=
 =?utf-8?B?VGVsWXNXckFBaXRRK0ZQa1dCQ0RMVGR6eEJONml4RlFrQ0puMVlaM0R1alV3?=
 =?utf-8?B?ZElSUTJETWRTMWRnd0c3eEVZNnVGeDY3TjBXNU0yZTAxZHBIRG9YOUl3NHBm?=
 =?utf-8?B?UnIraG5lajErc2VyWTYwM3IyZUFMWjBwck5jMkIrc2hyV0hxYmFMbU54SE1L?=
 =?utf-8?B?dWZ0RzhiZFlrbmdIMlBaaTdUa3QycFlTRTVPbi9CanJobjkyU0FyNWtGei9J?=
 =?utf-8?B?QUpGRjJFMjJZdXZ0R3YxY1U5N0tOdTRXZ3hlN1Z0OExzVGRON1RRemViaXJl?=
 =?utf-8?B?YWc3a2xucCtheVlDRElycm5KcG1ISEgyZ0F6THphRENPTFVKZDZpZmppeDk2?=
 =?utf-8?B?aGsyK2NxNEVmeEwvSFFjQ1RIK0F5RTRTN1ZLM0Ivak1XZVdhV08zYzhFS3JF?=
 =?utf-8?B?dWpERVNsT2FmUmJ3bzVZV3hSRHh6TTZWTHdnYUtjMEdkWWVjTkcxUk9YQU5F?=
 =?utf-8?B?R3kxUDMxd0JBYVVpTmdHTXluNGs1enRQZXpnWDMzZmJPaitaR203dEQvTUlq?=
 =?utf-8?B?VmpQZzBCblZwQ3ArL0tTZ3FaS2JGZ2doWWlRQjI1OHB2MXE1aitIYTVSb0tV?=
 =?utf-8?Q?YMEWVbV8w6B3YxS+3aAA3GM+6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b04445-8ab3-48b8-8b9e-08dd87c51690
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:57:51.6916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRB3QrGWtQX5wTit7h1WU3SLshI5WPdYmxlFuBInbtgtWkqmgjiWSGUYqcKIXKYW7NAfzKZYBud/YiZfViUcrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

Hi,

The next iteration of our nvme-tcp receive offload series, rebased on top of
yesterday net-next 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW Stats").

As requested, we now have CI for testing this feature. This has been
realized through the addition of a NIPA executor in
KernelCI[0]. KernelCI now has access to execute tests on the NVIDIA
hardware where we use this feature and then report the results for
NIPA collection.

If you want, you can follow the test executions through the NIPA
contest page[1]. As expected, tests are failing right now as they need
this patchset applied to the netdev-testing hw branch, but they should
pass once the patches make their way in to that branch.

Previous submission (v27):
https://lore.kernel.org/netdev/20250303095304.1534-1-aaptel@nvidia.com/

The changes are also available through git:
Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v28
Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v28

The NVMe-TCP offload was presented in netdev 0x16 (video available):
- https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains
- https://youtu.be/W74TR-SNgi4

[0] https://kernelci.org/
[1] https://netdev.bots.linux.dev/contest.html?executor=kernelci-lava-collabora (tick the Individual sub-tests box)


From: Aurelien Aptel <aaptel@nvidia.com>
From: Shai Malin <smalin@nvidia.com>
From: Boris Pismenny <borisp@nvidia.com>
From: Or Gerlitz <ogerlitz@nvidia.com>
From: Yoray Zack <yorayz@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>

=========================================

This series adds support for NVMe-TCP receive offloads. The method here
does not mandate the offload of the network stack to the device.
Instead, these work together with TCP to offload:
1. copy from SKB to the block layer buffers.
2. CRC calculation and verification for received PDU.

The series implements these as a generic offload infrastructure for storage
protocols, which calls TCP Direct Data Placement and TCP Offload CRC
respectively. We use this infrastructure to implement NVMe-TCP offload for
copy and CRC.
Future implementations can reuse the same infrastructure for other protocols
such as iSCSI.

Note:
These offloads are similar in nature to the packet-based NIC TLS offloads,
which are already upstream (see net/tls/tls_device.c).
You can read more about TLS offload here:
https://www.kernel.org/doc/html/latest/networking/tls-offload.html

Queue Level
===========
The offload for IO queues is initialized after the handshake of the
NVMe-TCP protocol is finished by calling `nvme_tcp_offload_socket`
with the tcp socket of the nvme_tcp_queue:
This operation sets all relevant hardware contexts in
hardware. If it fails, then the IO queue proceeds as usual with no offload.
If it succeeds then `nvme_tcp_setup_ddp` and `nvme_tcp_teardown_ddp` may be
called to perform copy offload, and crc offload will be used.
This initialization does not change the normal operation of NVMe-TCP in any
way besides adding the option to call the above mentioned NDO operations.

For the admin queue, NVMe-TCP does not initialize the offload.
Instead, NVMe-TCP calls the driver to configure limits for the controller,
such as max_hw_sectors and max_segments, these must be limited to accommodate
potential HW resource limits, and to improve performance.

If some error occurs, and the IO queue must be closed or reconnected, then
offload is teardown and initialized again. Additionally, we handle netdev
down events via the existing error recovery flow.

IO Level
========
The NVMe-TCP layer calls the NIC driver to map block layer buffers to CID
using `nvme_tcp_setup_ddp` before sending the read request. When the response
is received, then the NIC HW will write the PDU payload directly into the
designated buffer, and build an SKB such that it points into the destination
buffer. This SKB represents the entire packet received on the wire, but it
points to the block layer buffers. Once NVMe-TCP attempts to copy data from
this SKB to the block layer buffer it can skip the copy by checking in the
copying function: if (src == dst) -> skip copy

Finally, when the PDU has been processed to completion, the NVMe-TCP layer
releases the NIC HW context by calling `nvme_tcp_teardown_ddp` which
asynchronously unmaps the buffers from NIC HW.

The NIC must release its mapping between command IDs and the target buffers.
This mapping is released when NVMe-TCP calls the NIC
driver (`nvme_tcp_offload_socket`).
As completing IOs is performance critical, we introduce asynchronous
completions for NVMe-TCP, i.e. NVMe-TCP calls the NIC, which will later
call NVMe-TCP to complete the IO (`nvme_tcp_ddp_teardown_done`).

On the IO level, and in order to use the offload only when a clear
performance improvement is expected, the offload is used only for IOs
which are bigger than io_threshold.

SKB
===
The DDP (zero-copy) and CRC offloads require two additional bits in the SKB.
The ddp bit is useful to prevent condensing of SKBs which are targeted
for zero-copy. The crc bit is useful to prevent GRO coalescing SKBs with
different offload values. This bit is similar in concept to the
"decrypted" bit.

After offload is initialized, we use the SKB's crc bit to indicate that:
"there was no problem with the verification of all CRC fields in this packet's
payload". The bit is set to zero if there was an error, or if HW skipped
offload for some reason. If *any* SKB in a PDU has (crc != 1), then the
calling driver must compute the CRC, and check it. We perform this check, and
accompanying software fallback at the end of the processing of a received PDU.

Resynchronization flow
======================
The resynchronization flow is performed to reset the hardware tracking of
NVMe-TCP PDUs within the TCP stream. The flow consists of a request from
the hardware proxied by the driver, regarding a possible location of a
PDU header. Followed by a response from the NVMe-TCP driver.

This flow is rare, and it should happen only after packet loss or
reordering events that involve NVMe-TCP PDU headers.

CID Mapping
===========
ConnectX-7 assumes linear CID (0...N-1 for queue of size N) where the Linux NVMe
driver uses part of the 16 bit CCID for generation counter.
To address that, we use the existing quirk in the NVMe layer when the HW
driver advertises that they don't support the full 16 bit CCID range.

Enablement on ConnectX-7
========================
By default, NVMeTCP offload is disabled in the mlx driver and in the nvme-tcp host.
In order to enable it:

        # Disable CQE compression (specific for ConnectX)
        ethtool --set-priv-flags <device> rx_cqe_compress off

        # Enable the ULP-DDP
        ./tools/net/ynl/pyynl/cli.py \
            --spec Documentation/netlink/specs/ulp_ddp.yaml --do caps-set \
            --json '{"ifindex": <device index>, "wanted": 3, "wanted_mask": 3}'

        # Enable ULP offload in nvme-tcp
        modprobe nvme-tcp ddp_offload=1

Following the device ULP-DDP enablement, all the IO queues/sockets which are
running on the device are offloaded.

Performance
===========
With this implementation, using the ConnectX-7 NIC, we were able to
demonstrate the following CPU utilization improvement:

Without data digest:
For  64K queued read IOs – up to 32% improvement in the BW/IOPS (111 Gbps vs. 84 Gbps).
For 512K queued read IOs – up to 55% improvement in the BW/IOPS (148 Gbps vs. 98 Gbps).

With data digest:
For  64K queued read IOs – up to 107% improvement in the BW/IOPS (111 Gbps vs. 53 Gbps).
For 512K queued read IOs – up to 138% improvement in the BW/IOPS (146 Gbps vs. 61 Gbps).

With small IOs we are not expecting that the offload will show a performance gain.

The test configuration:
- fio command: qd=128, jobs=8.
- Server: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz, 160 cores.

Patches
=======
Patch 1:  Introduce the infrastructure for all ULP DDP and ULP DDP CRC offloads.
Patch 2:  Add netlink family to manage ULP DDP capabilities & stats.
Patch 3:  The iov_iter change to skip copy if (src == dst).
Patch 4:  Export the get_netdev_for_sock function from TLS to generic location.
Patch 5:  NVMe-TCP changes to call NIC driver on queue init/teardown and resync.
Patch 6:  NVMe-TCP changes to call NIC driver on IO operation
          setup/teardown, and support async completions.
Patch 7:  NVMe-TCP changes to support CRC offload on receive
          Also, this patch moves CRC calculation to the end of PDU
          in case offload requires software fallback.
Patch 8:  NVMe-TCP handling of netdev events: stop the offload if netdev is
          going down.
Patch 9:  Documentation of ULP DDP offloads.

The rest of the series is the mlx5 implementation of the offload.

Testing
=======
This series was tested on ConnectX-7 HW using various configurations
of IO sizes, queue depths, MTUs, and with both the SPDK and kernel NVMe-TCP
targets.

Compatibility
=============
* The offload works with bare-metal or SRIOV.
* The HW can support up to 64K connections per device (assuming no
  other HW accelerations are used). In this series, we will introduce
  the support for up to 4k connections, and we have plans to increase it.
* In the current HW implementation, the combination of NVMeTCP offload
  with TLS is not supported. In the future, if it will be implemented,
  the impact on the NVMe/TCP layer will be minimal.
* The NVMeTCP offload ConnectX 7 HW can support tunneling, but we
  don't see the need for this feature yet.
* NVMe poll queues are not in the scope of this series.

Future Work
===========
* NVMeTCP transmit offload.
* NVMeTCP offloads incremental features.

Changes since v27:
=================
- make driver code 80 columns when possible (Jakub).
- rebase on newer mlx5 driver.

Changes since v26:
=================
- remove inlines in C files (Paolo).
- use netdev tracker in netdev ref accounting calls (Paolo).
- add skb_cmp_ulp_crc() helper (Paolo).

Changes since v25:
=================
- continuous integration via NIPA.
- check for tls with nvme_tcp_tls_configured().

Changes since v24:
=================
- ulp_ddp.h: rename cfg->io_cpu to ->affinity_hint (Sagi).
- add compile-time optimization for the iov memcpy skip check (David).
- add rtnl_lock/unlock() around get_netdev_for_sock().
- fix vlan lookup in get_netdev_for_sock().
- fix NULL deref when netdev doesn't have ulp_ddp ops.
- use inline funcs for skb bits to remove ifdef (match tls code).

Changes since v23:
=================
- ulp_ddp.h: remove queue_id (Sagi).
- nvme-tcp: remove nvme_status, always set req->{result,status} (Sagi).
- nvme-tcp: rename label to ddgst_valid (Sagi).
- mlx5: remove newline from error messages (Jakub).

Changes since v22:
=================
- protect ->set_caps() with rtnl_lock().
- refactor of netdev GOING_DOWN event handler (Sagi).
- fix DDGST recalc for IOs under offload threshold.
- rebase against new mlx5 driver changes.

Changes since v21:
=================
- add netdevice_tracker to get_netdev_for_sock() (Jakub).
- remove redundant q->data_digest check (Max).

Changes since v20:
=================
- get caps&limits from nvme and remove query_limits() (Sagi).
- rename queue->ddp_status to queue->nvme_status and move ouf of ifdef (Sagi).
- call setup_ddp() during request setup (Sagi).
- remove null check in ddgst_recalc() (Sagi).
- remove local var in offload_socket() (Sagi).
- remove ifindex and hdr from netlink context data (Jiri).
- clean netlink notify handling and use nla_get_uint() (Jiri).
- normalize doc in ulp_ddp netlink spec (Jiri).

Changes since v19:
=================
- rebase against net-next.
- fix ulp_ddp_is_cap_active() error reported by the kernel test bot.

Changes since v18:
=================
- rebase against net-next.
- integrate with nvme-tcp tls.
- add const in parameter for skb_is_no_condense() and skb_is_ulp_crc().
- update documentation.

Changes since v17:
=================
- move capabilities from netdev to driver and add get_caps() op (Jiri).
- set stats by name explicitly, remove dump ops (Jiri).
- rename struct, functions, YAML attributes, reuse caps enum (Jiri).
- use uint instead of u64 in YAML spec (Jakub).

Changes since v16:
=================
- rebase against net-next
- minor whitespace changes
- updated CC list

Changes since v15:
=================
- add API func to get netdev & limits together (Sagi).
- add nvme_tcp_stop_admin_queue()
- hide config.io_cpu in the interface (Sagi).
- rename skb->ulp_ddp to skb->no_condense (David).

Changes since v14:
=================
- Added dumpit op for ULP_DDP_CMD_{GET,STATS} (Jakub).
- Remove redundant "-ddp-" fom stat names.
- Fix checkpatch/sparse warnings.

Changes since v13:
=================
- Replace ethtool interface with a new netlink family (Jakub).
- Simplify and squash mlx5e refactoring changes.

Changes since v12:
=================
- Rebase on top of NVMe-TCP kTLS v10 patches.
- Add ULP DDP wrappers for common code and ref accounting (Sagi).
- Fold modparam and tls patches into control-path patch (Sagi).
- Take one netdev ref for the admin queue (Sagi).
- Simplify start_queue() logic (Sagi).
- Rename
  * modparam ulp_offload modparam -> ddp_offload (Sagi).
  * queue->offload_xxx to queue->ddp_xxx (Sagi).
  * queue->resync_req -> resync_tcp_seq (Sagi).
- Use SECTOR_SHIFT (Sagi).
- Use nvme_cid(rq) (Sagi).
- Use sock->sk->sk_incoming_cpu instead of queue->io_cpu (Sagi).
- Move limits results to ctrl struct.
- Add missing ifdefs.
- Fix docs and reverse xmas tree (Simon).

Changes since v11:
=================
- Rebase on top of NVMe-TCP kTLS offload.
- Add tls support bit in struct ulp_ddp_limits.
- Simplify logic in NVMe-TCP queue init.
- Use new page pool in mlx5 driver.

Changes since v10:
=================
- Pass extack to drivers for better error reporting in the .set_caps
  callback (Jakub).
- netlink: use new callbacks, existing macros, padding, fix size
  add notifications, update specs (Jakub).

Changes since v9:
=================
- Add missing crc checks in tcp_try_coalesce() (Paolo).
- Add missing ifdef guard for socket ops (Paolo).
- Remove verbose netlink format for statistics (Jakub).
- Use regular attributes for statistics (Jakub).
- Expose and document individual stats to uAPI (Jakub).
- Move ethtool ops for caps&stats to netdev_ops->ulp_ddp_ops (Jakub).

Changes since v8:
=================
- Make stats stringset global instead of per-device (Jakub).
- Remove per-queue stats (Jakub).
- Rename ETH_SS_ULP_DDP stringset to ETH_SS_ULP_DDP_CAPS.
- Update & fix kdoc comments.
- Use 80 columns limit for nvme code.

Changes since v7:
=================
- Remove ULP DDP netdev->feature bit (Jakub).
- Expose ULP DDP capabilities to userspace via ethtool netlink messages (Jakub).
- Move ULP DDP stats to dedicated stats group (Jakub).
- Add ethtool_ops operations for setting capabilities and getting stats (Jakub).
- Move ulp_ddp_netdev_ops into net_device_ops (Jakub).
- Use union for protocol-specific struct instances (Jakub).
- Fold netdev_sk_get_lowest_dev() into get_netdev_for_sock (Christoph).
- Rename memcpy skip patch to something more obvious (Christoph).
- Move capabilities from ulp_ddp.h to ulp_ddp_caps.h.
- Add "Compatibility" section on the cover letter (Sagi).

Changes since v6:
=================
- Moved IS_ULP_{DDP,CRC} macros to skb_is_ulp_{ddp,crc} inline functions (Jakub).
- Fix copyright notice (Leon).
- Added missing ifdef to allow build with MLX5_EN_TLS disabled.
- Fix space alignment, indent and long lines (max 99 columns).
- Add missing field documentation in ulp_ddp.h.

Changes since v5:
=================
- Limit the series to RX offloads.
- Added two separated skb indications to avoid wrong flushing of GRO
  when aggerating offloaded packets.
- Use accessor functions for skb->ddp and skb->crc (Eric D) bits.
- Add kernel-doc for get_netdev_for_sock (Christoph).
- Remove ddp_iter* routines and only modify _copy_to_iter (Al Viro, Christoph).
- Remove consume skb (Sagi).
- Add a knob in the ddp limits struct for the HW driver to advertise
  if they need the nvme-tcp driver to apply the generation counter
  quirk. Use this knob for the mlx5 CX7 offload.
- bugfix: use u8 flags instead of bool in mlx5e_nvmeotcp_queue->dgst.
- bugfix: use sg_dma_len(sgl) instead of sgl->length.
- bugfix: remove sgl leak in nvme_tcp_setup_ddp().
- bugfix: remove sgl leak when only using DDGST_RX offload.
- Add error check for dma_map_sg().
- Reduce #ifdef by using dummy macros/functions.
- Remove redundant netdev null check in nvme_tcp_pdu_last_send().
- Rename ULP_DDP_RESYNC_{REQ -> PENDING}.
- Add per-ulp limits struct (Sagi).
- Add ULP DDP capabilities querying (Sagi).
- Simplify RX DDGST logic (Sagi).
- Document resync flow better.
- Add ulp_offload param to nvme-tcp module to enable ULP offload (Sagi).
- Add a revert commit to reintroduce nvme_tcp_queue->queue_size.

Changes since v4:
=================
- Add transmit offload patches.
- Use one feature bit for both receive and transmit offload.

Changes since v3:
=================
- Use DDP_TCP ifdefs in iov_iter and skb iterators to minimize impact
  when compiled out (Christoph).
- Simplify netdev references and reduce the use of
  get_netdev_for_sock (Sagi).
- Avoid "static" in it's own line, move it one line down (Christoph)
- Pass (queue, skb, *offset) and retrieve the pdu_seq in
  nvme_tcp_resync_response (Sagi).
- Add missing assignment of offloading_netdev to null in offload_limits
  error case (Sagi).
- Set req->offloaded = false once -- the lifetime rules are:
  set to false on cmd_setup / set to true when ddp setup succeeds (Sagi).
- Replace pr_info_ratelimited with dev_info_ratelimited (Sagi).
- Add nvme_tcp_complete_request and invoke it from two similar call
  sites (Sagi).
- Introduce nvme_tcp_req_map_sg earlier in the series (Sagi).
- Add nvme_tcp_consume_skb and put into it a hunk from
  nvme_tcp_recv_data to handle copy with and without offload.

Changes since v2:
=================
- Use skb->ddp_crc for copy offload to avoid skb_condense.
- Default mellanox driver support to no (experimental feature).
- In iov_iter use non-ddp functions for kvec and iovec.
- Remove typecasting in NVMe-TCP.

Changes since v1:
=================
- Rework iov_iter copy skip if src==dst to be less intrusive (David Ahern).
- Add tcp-ddp documentation (David Ahern).
- Refactor mellanox driver patches into more patches (Saeed Mahameed).
- Avoid pointer casting (David Ahern).
- Rename NVMe-TCP offload flags (Shai Malin).
- Update cover-letter according to the above.

Changes since RFC v1:
=====================
- Split mlx5 driver patches to several commits.
- Fix NVMe-TCP handling of recovery flows. In particular, move queue offload.
  init/teardown to the start/stop functions.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>


Aurelien Aptel (3):
  netlink: add new family to manage ULP_DDP enablement and stats
  net/tls,core: export get_netdev_for_sock
  net/mlx5e: NVMEoTCP, statistics

Ben Ben-Ishay (8):
  iov_iter: skip copy if src == dst for direct data placement
  net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
  net/mlx5e: NVMEoTCP, offload initialization
  net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
  net/mlx5e: NVMEoTCP, queue init/teardown
  net/mlx5e: NVMEoTCP, ddp setup and resync
  net/mlx5e: NVMEoTCP, async ddp invalidation
  net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload

Boris Pismenny (4):
  net: Introduce direct data placement tcp offload
  nvme-tcp: Add DDP offload control path
  nvme-tcp: Add DDP data-path
  net/mlx5e: TCP flow steering for nvme-tcp acceleration

Or Gerlitz (3):
  nvme-tcp: Deal with netdevice DOWN events
  net/mlx5e: Rename from tls to transport static params
  net/mlx5e: Refactor ico sq polling to get budget

Yoray Zack (2):
  nvme-tcp: RX DDGST offload
  Documentation: add ULP DDP offload documentation

 Documentation/netlink/specs/ulp_ddp.yaml      |  172 +++
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/ulp-ddp-offload.rst  |  372 +++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |   11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   30 +
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |    4 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   13 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |    3 +
 .../mellanox/mlx5/core/en/reporter_rx.c       |    4 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |   30 +
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |    5 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  |   16 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |    3 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   34 +-
 .../mlx5/core/en_accel/common_utils.h         |   34 +
 .../mellanox/mlx5/core/en_accel/en_accel.h    |    3 +
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |   12 +-
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |    2 +-
 .../mellanox/mlx5/core/en_accel/ktls.c        |    3 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |    6 +-
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |    9 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |   41 +-
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  |   17 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 1191 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  147 ++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        |  368 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |   39 +
 .../mlx5/core/en_accel/nvmeotcp_stats.c       |   69 +
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |   68 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   30 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   73 +-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |    9 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |    1 +
 drivers/nvme/host/tcp.c                       |  540 +++++++-
 include/linux/mlx5/device.h                   |   59 +-
 include/linux/mlx5/mlx5_ifc.h                 |   85 +-
 include/linux/mlx5/qp.h                       |    1 +
 include/linux/netdevice.h                     |   10 +-
 include/linux/skbuff.h                        |   50 +
 include/net/inet_connection_sock.h            |    6 +
 include/net/tcp.h                             |    3 +-
 include/net/ulp_ddp.h                         |  327 +++++
 include/uapi/linux/ulp_ddp.h                  |   61 +
 lib/iov_iter.c                                |    9 +-
 net/Kconfig                                   |   20 +
 net/core/Makefile                             |    1 +
 net/core/dev.c                                |   32 +-
 net/core/skbuff.c                             |    4 +-
 net/core/ulp_ddp.c                            |   54 +
 net/core/ulp_ddp_gen_nl.c                     |   75 ++
 net/core/ulp_ddp_gen_nl.h                     |   30 +
 net/core/ulp_ddp_nl.c                         |  346 +++++
 net/ipv4/tcp_input.c                          |    2 +
 net/ipv4/tcp_offload.c                        |    1 +
 net/tls/tls_device.c                          |   31 +-
 60 files changed, 4432 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 include/uapi/linux/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

-- 
2.34.1


