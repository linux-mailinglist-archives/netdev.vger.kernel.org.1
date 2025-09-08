Return-Path: <netdev+bounces-220708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0A5B4847D
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B711B20027
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52A2E229C;
	Mon,  8 Sep 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="fLwptiyd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b="diEsv35J"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F42E2299
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314389; cv=fail; b=nl32zV5G3D3PvOGRcQh8SE/bqk9eqQbd7mv4SUjFm5+/LN0TVL/ZPqxi8CI8HmwPQ9shyf4W0Ll4vf0IbeGyNHj8PpooY3j1nld/Amaw5WXHzBUdhQGfD4CWA/IaPNDGcgJHH/uP61HXmQhJ669EL80xdyj7TDa6MdVTmpSjo+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314389; c=relaxed/simple;
	bh=N3ruNfa+YwputsGcC+fNK4B3t3cOgE9dr4gyHqcHub4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Jm3bDD7wA62wh7zVCwTwSi0G5iz+34zpA6139grhGN8FJlwcGHLZyZBYPbS/xLHzNMxSVY6fzHJVPbTd2nz+/tD7ybDWleSQzOWGVfIlN2RpOZ7MG7XosEDWlvxqPd4V6rLdFs5z2lX+qdW9rRiLfzUpIldEV83Ppq6A1CHlrzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=fLwptiyd; dkim=fail (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b=diEsv35J reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5884vLwv005540
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 07:53:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=jan2016.eng; bh=N3ruNfa+Y
	wputsGcC+fNK4B3t3cOgE9dr4gyHqcHub4=; b=fLwptiydlojIbV2FoHz7NZaCo
	XobxMK+CwZexrbd6SJyDUWNPECL/ucUymhQTo4W8HqpzvTXkW7EVhbHnMURjp9vX
	72YGsJ0uAiHRpvpzvOk33lHH/iOoBvLbgvStuHCx07nQMmjFlSKXoFtsxFXrXveK
	RMN0Yx+RoCiWKhBk1up3hG8z7VAysiRneLvTz18QYnf93cCMp+/fUp7Mf+TLh0zK
	x0c21EwiztMe4K8iDz/G7QK/HqyUM8GmOlnzUvehbZobAO7VevK6/hAyhrymVcyl
	v4G3lTHPxIVqP0IodROXumTQYoEaBIUU22ZZm9rjGZlW21b3k+7vrbwPlDmMg==
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 490d0nhttq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 07:53:07 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
	by prod-mail-ppoint4.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 5884JP0I002106
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 02:52:50 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.21])
	by prod-mail-ppoint4.akamai.com (PPS) with ESMTPS id 490g9x275q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 02:52:50 -0400
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Mon, 8 Sep 2025 02:52:50 -0400
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Mon, 8 Sep 2025 02:52:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (184.51.33.212)
 by usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36 via Frontend Transport; Mon, 8 Sep 2025 02:52:49 -0400
Received: from BYAPR17MB2710.namprd17.prod.outlook.com (2603:10b6:a03:e2::24)
 by MW4PR17MB5161.namprd17.prod.outlook.com (2603:10b6:303:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:52:48 +0000
Received: from BYAPR17MB2710.namprd17.prod.outlook.com
 ([fe80::a93b:cd48:adaf:e57d]) by BYAPR17MB2710.namprd17.prod.outlook.com
 ([fe80::a93b:cd48:adaf:e57d%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:52:48 +0000
From: "Banerjee, Debabrata" <dbanerje@akamai.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Question: Mixed MTU environment support, possible kernel patch?
Thread-Topic: Question: Mixed MTU environment support, possible kernel patch?
Thread-Index: AQHcII0vP90VeCBdDEutdO9sX4Gpwg==
Date: Mon, 8 Sep 2025 06:52:48 +0000
Message-ID: <AE9FC986-D052-4E3B-A98C-EAF2235F498D@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.100.25082415
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR17MB2710:EE_|MW4PR17MB5161:EE_
x-ms-office365-filtering-correlation-id: e137b961-8d63-4559-0917-08ddeea4526f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?clg3SzZVYXlzZ0tUNHVlWENHem04b0RWWXJ4OE9mdlM1SmQ5VVdzYlRlYW9G?=
 =?utf-8?B?NlVER1ZUSjhtR245MFM0cVNLY2xKRVN0RWJsNUl0YjVqWGkxT1pHTDhVUE01?=
 =?utf-8?B?U0FnYitNbGtpZmVxTnpWL3IzYi9KU2ZOMGFGUU9nM21WQm5FeU45NnM3aTlr?=
 =?utf-8?B?U2N6RFNzSHpOR1VQWG0zVEd6N29ERUEyaVRVTVphQlIxb0IzaGpabUpINGQz?=
 =?utf-8?B?Ui9VK2cvU1dqcGhINGRoL09iUXZKaDBsR3k4NjJGem1DWGNOSWkva1kxMWR6?=
 =?utf-8?B?WFhPaFR6Q1JOdS9xQTZERTNkT2dhdGh1b21FU1lzZDZQaEtmcHVlOU1meEw1?=
 =?utf-8?B?SjFkcGlzOVBUL3RBTXNqVHVBK3JIT0ZUeG45ZW55ZXZDN0hHT09nUmlHUWNW?=
 =?utf-8?B?YXRZT3p5TlZxMjE2NWJoTVZFQU5OaUxWdFRDa2prT2NCc3R5S05lc25FcGps?=
 =?utf-8?B?Z1hTL3FSblJJTE5LWUtUVVpEeFNvYzc0MGwyVC9zOFhQeXBqVnoyejFFTnFs?=
 =?utf-8?B?enFyckwrZ2ZraG4vbElJMnNwZWszT3dLUmg5bkpsY2V2MTJtelNWTFRaNW05?=
 =?utf-8?B?dzI2b2pqQU1nUlgraWVYeDU1aSt5ZWZVNFZoRXpNTkxBa3QrY3k5RXJzSEJH?=
 =?utf-8?B?RHFoTm1pbWlNYkFBNVM3ZDhhK3EzbzhSdnhhMVV0UE5RRTFNd2ZuMWNDTjc1?=
 =?utf-8?B?VkdHOWtLcDZ2VWJEcUdwMnk4TVBsMjFTNDRKSXlHZEo4NStlZjhXa2YwYldY?=
 =?utf-8?B?WnliNStFR01lQm1oTW41T0p1cXhjSG9zQjl3YmxrUlBpYUJMQ2tPSExSQWNk?=
 =?utf-8?B?QmVBRUlyZlI0dGdVaDZsYmUyYm1Sb1VZMllLczZRYWQyQ3VoK0tQSlkxRU51?=
 =?utf-8?B?ZVFPbjhTQzFoZmFWL1QwQzVxUklsQ3dKNXYzSmVFampzb1lsajVobFQ2V1k3?=
 =?utf-8?B?cDN2Sm0vZDRtR01GY3ZyOS9kbXVOeFVNUDg3ZHVNdWV2Z01uemk4dkM5TzNP?=
 =?utf-8?B?aG1yanVTY0NqQ3VrWC9DUHVsZEVRdTRjbkxnemxtVy9CSUJNMGdIMEpPT3o3?=
 =?utf-8?B?dFpBVnlpVkx5aDNJL0xVeVNkTmdFblhhRGxRbFZUSTZaTmFSOFpiNkk0c2I1?=
 =?utf-8?B?U1h2MDE5VGQ1eTFhT05uWndtNXd2eU1YRzcrM0lEZWJOY2pOd2ZiVlRTQ1da?=
 =?utf-8?B?RmUvU2pLWjY2UDBUbThmOCtudExoSDRsVmdTT0JobkhQYXd6bFlHYUYxZGpo?=
 =?utf-8?B?c2dvcDQ1QjlHU2xZUzNCYnc2bEMrbWhHeVVyd3A0RW9UMEQwdUw4RkxXRXhY?=
 =?utf-8?B?YmFkcVZLN1lRNGZpNzJyeDFaeWpzSW04bmtJYnpVdkdjQTVqd0dzeTE2aVNT?=
 =?utf-8?B?VlptaVFQUGRNZllFVUNJbHUyL0dDdllHOE9jMG1tZW5YenFCTHYyZ1gzemxK?=
 =?utf-8?B?Q3BXYzdOQjVvK0ZEWmdmcWxsQk5vUEx4eDJBUDcrSjJuZ2dyMHA5Q29raDhM?=
 =?utf-8?B?ZWY1RzdMUytDcDI5VWhKSThZVm5DUUlRb1ZtV2RNUFh3WjBidEQ0N1VydEFB?=
 =?utf-8?B?YVZXR2RBQ3o3MEYzVUlod0dEUENTay9jbG1ldFg3OWtDLzVIU1krNlVPTWdK?=
 =?utf-8?B?T2craU1OSlN5QmQ0d05seGVLZ1paNDVvanBpQ2VHZGlqUkRuZmtJeEhlS25t?=
 =?utf-8?B?Zk1ma2hZTU1YQjhxY1kzbW8zckc0cHMvdG0wMU1ZWnVvNTNYMElWSW5neWY2?=
 =?utf-8?B?b3B5VEl5M3NIVFNCdTdGVSswV2JrU3pMS3BwU3Z5QmZSSU9rMGp5NGkvMUwx?=
 =?utf-8?B?RzlnZVAzTHlRcXU2b0Nka2RBTi83UmIxbTdaeGRrbERSUUNDREhIUGR3SUFC?=
 =?utf-8?B?VXB6Tlg1SUJGVjVFSWIrbS9MYzVMVlk1c015NjhRTmVRYkYrUm9TTjczd2E2?=
 =?utf-8?B?ZXh2Ull3Z0ExSm1CSnhiRkVidllGSmJKSWtUdktLcmZQaVAzYjQrSXVCNlZz?=
 =?utf-8?B?MU5hbldJWnhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR17MB2710.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHNDSm1JeTFFM1NaSytYajBJSGw4VTc5RDluZ2V5OS9Gc3NUeFl2K0ZYeEFW?=
 =?utf-8?B?ajRCTitEdDAxY2pIUnR6OUZJUnpCVTNFaWZEaXZEUWVHdDdLTDlQUkdFTmdK?=
 =?utf-8?B?ay9ZWmlNdGwwbHhZbUFlU2t5MGlBTEpuZGxKblJXalBCaTV4V0ZXdFQycEh2?=
 =?utf-8?B?YW9za1JlYnJUc09wV1R6ZzBPcEI1S3lqWWJDbGQzQXplb2lxTGQvSmROK29W?=
 =?utf-8?B?VE1ZazNicEJNYzdmTm55UmxKNHFvTE5JWGdBOU53NkxIS3k3RE80bTZGRDN0?=
 =?utf-8?B?UmpIMUdncnd3OERhMWRSRmJNNVlCS1g4MFRZRHYvZmJZSmhCNTVsNnk5MGVh?=
 =?utf-8?B?OUNuamtNYnRRWVNtdWZUOFVkWTBqVk04QUIyV2k3ZG1UQlp3c0gzNkpqWThy?=
 =?utf-8?B?dnp3aUlud2VjVllXRTh0bkI0WW90cFlIZ1ljMjlONFE0MCtkRXN2WWRDam9Y?=
 =?utf-8?B?VVVaYUYyMWVEUTBmMkJ6RG1XZUpjR2lUTlRGbmhmNWdMRThPajJlMS9KbUQv?=
 =?utf-8?B?cUdHY04vWWI5ellkUGlndkttUDc1clh0ZU1QOVY4Y01vdy9CTGFpOVF2cmdy?=
 =?utf-8?B?ZDhaSyt2R2xDOXNzaGhDQlhpTWhRSy90NXFPWnhXSVdwS0VaLzFXZ0FhMDV6?=
 =?utf-8?B?VW9qTFczbUYrc3lUODU3d1UrN0pqUFhjZmVzTWlzS0ZzNU9TWFNxQnhyYWNo?=
 =?utf-8?B?SEx2WFIreUNsVWZzYU9IRkJMVmxEN3VJMldwR2ZSMjN0R21rVGpHSFJMN3hT?=
 =?utf-8?B?V3ZQWjhoUXN0NVlhTUx2Q2RqeHBFZVJJTFUyd3B5OVBFOEdYTHJ6TkpQbm1s?=
 =?utf-8?B?M09tWHhxaUNHNFhja2FOQkNZNGhiZFk4dml6VmNhZ1RxTHFlc3FIRnBxaEpT?=
 =?utf-8?B?OTFuZmx4UmhuUlFnZkZJK241cEE1WUJXV3E2aUgxOUM0NmhXVFZ2SDdVU2pR?=
 =?utf-8?B?UFoyNmJlUldsUmNQd0NZcW00bVZLRGhwWVJIemZlRkhlamk1bHFjVGxOS1J3?=
 =?utf-8?B?WFBOa3FaUHJMUVdEdmVXd2QvNkF5N0ZZdkV2SXRYTDdHQjNWQ3JaV0lzL0k2?=
 =?utf-8?B?T25XdFYwUVJFRzhnVURtdnQrMXhGNzY0elVCTkM5cWdiak9SNjFwOFFKV3lH?=
 =?utf-8?B?WWxZbEZyUFVubFVUOGZTM0lPRUpwNzArNDI1dmZUUTFFYUJFZnk4cXc2SElO?=
 =?utf-8?B?TXc0ZTF1ZllFZStuQ2VFTUhKS3lWRm54VlhzaE1vVXNESzZBMWRGLzZtQ2JQ?=
 =?utf-8?B?MDJJak5HK0tzNlpBYnd1RFlFUVNqYWNIOFBmR05DWVdvQ0hydkxJM1NhMXBL?=
 =?utf-8?B?T1NPSDJIODEzZW1oKzM5NGVaYWpsTlFUSVAvUEVMMExYNEJtT1ZnbUFrL0Ir?=
 =?utf-8?B?K1NNczR2Zk1PRjFKdldvcEs3cGNvR3UrTGN3RjVNR1lEL2pUb1B2aXFnSFBM?=
 =?utf-8?B?V2YvdHdSY0FVZmZxVmJxRWI2Zm9YZGVzcjdyZitZcDRrdjhaZWdwRjFhS0hL?=
 =?utf-8?B?Y1YwYy82TVI0OHpiM3hOb2xPNXk4RzdpWU5kWjR4c1BHRVNJYndSdUp3VU5y?=
 =?utf-8?B?MnFzQ295dFhBVit0OUJKZFFZVkd2TDlYV2xHcHIxK1k1d0lyV2R3VU83ZjN6?=
 =?utf-8?B?MGt1K0hzSzhwaUJxQUNaaWgyaGRXUkpGR0VyU21GZjVvQmdDcHdSdHRIMlMz?=
 =?utf-8?B?Wk5SaVFRenFJU0Q5WUE3dVVIbEx5RE5ndDUrdmkzYW9EQmV1N3F1OE4wV3NO?=
 =?utf-8?B?MVJkTWJyS2gvWjZUenQwc3J0SXhLZDZIRm93UUJZUGpjUU1MVkV0MnVYVXRP?=
 =?utf-8?B?bzNGYzIyZUxhOVgyTDhMUzRKeGdIQ1dxT2I1ODlFazdhVnVXVnI1aDRJRGF2?=
 =?utf-8?B?Zk85cDZ1djdIT3NnV1IxSitMQmc1cjZSd1lYNW1kTW9GTll5SjNaSnBxV21P?=
 =?utf-8?B?WmtXalgvSGszUXhlb1JIR002VHNYaEwzcHRZRjg3UDR2VndUZWhQa3czT1hs?=
 =?utf-8?B?eURoUEV5MWZSKzlwWUpzZjM0aFNIdUlwdElHMkZLdzFJOWN2S1dYd1I1WU9C?=
 =?utf-8?B?dUpJcjJqbEg2djBwcUFXL0tlZGZHV3pQeE8rWW83bHhJT1pZbGROYzNSc0Rr?=
 =?utf-8?Q?A4hfaHZWcGO8MCl8TO/Y8I1Oq?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT/u/vQjr3s1a+wnnoj2QqYnADpJWMAB8rXj0jZixKgTNT0S6ylPK33qsdIpS4HlLMDaz7L/aB7fRu/v6CB38YA6PmWp0uf5jz333NgZ4XAnsGqzUYCZpb0dlybKV6Vpz9+zlZyl/sXlbCpFhmtnYv64etPFN/BdhznlokgCZVpb4H5YCV9A0sCx78w6G7ByITxN/rsLAzmMe42D0D6WKIAlTBO3jItEulgr8bLFK7QJeRpc3XdhilfPBSXznlRaNVwE91LZTp4rEcvoH69z9ytLWyQOlWCy30eugKKGQzPFKyAiMoXmYijqlOzN41Gd0fyoO4eQrv4Q/DRt/POEOA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN+Uuu2BgCAyWh+IiiekFdMMXdLCKEeBnobNv6YJoaI=;
 b=ZiGBE48nOIiDzaWS/t4fZfisVQ2NZUV9a6E8JmQMdx+NclkgGCFXBo3bWDGz4/W/qAHLuNwtY6vO0Z1qzTyyl/Syi+fcoB/LrQeQ0dzUce8Pelak0ONOMWJsojJSKfraHS6rJQIkpBTV2tI6k5eIrba65QN/6j+Gtelsa4r8x6CIwC76+wnr4AXe6pUbOI2uAYR0ssfCmvw0LWtue3uuqL/BqGvj8ZO0L19LvBWZVipeyV729QIhy+OPsyH1XOWD9pEqptQErWXjUcLwBLsRjDd3PPfXCG7inTjOtb1RxrZ4z7M66ukzfnW8Wwq73t/rd8vk5hzbpGWxvUQOwGfAZA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN+Uuu2BgCAyWh+IiiekFdMMXdLCKEeBnobNv6YJoaI=;
 b=diEsv35JSlJHxnX34JnIySppDM8Jv9IlWL20g8KdD0cBTn0vxf+dcpd0L7+VgssDp3cp07461c4PBqJjs/iyj5rtuT7tR81P5Wj/YVrGB2algmle1vOOR3CEtI+FCr90PsqPtWzFgkgm+/mK7yMJvcLKoFzSNzoPBn5Xd+dtOVo=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR17MB2710.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: e137b961-8d63-4559-0917-08ddeea4526f
x-ms-exchange-crosstenant-originalarrivaltime: 08 Sep 2025 06:52:48.1485 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: KrlbCCNBGZbBglmQD/qfbjoUp9uWTeqbeG4LVtj4Dr2KUfBNdWvJKwsEepyb2SVmnlGW4iuMIDeMGx7tCRcaJQ==
x-ms-exchange-transport-crosstenantheadersstamped: MW4PR17MB5161
Content-Type: text/plain; charset="utf-8"
Content-ID: <C236DF25E2C49C4EBBEFFE9A421A8200@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=891 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfX25yEcHkoE0xi
 nVTqb8hPEXEitDe42RWmsU9G1EKUSp/9FWqVV1ispp96c2uNOCsrXrgkUb1d7YuqXoP6UpQvVOb
 KLdyDsna5Te4kDt0UD9H3yxKDVC4NRUt0NeF1ltC7utmjb4pea2hYQS1zZ8hwdrxOUooUcxdC9k
 p1MPmiXQ7kba0YAdU/EE4LHbCdFDTSR+BCFCFLOVzInzPZOt5UJS9Atzz3ASDswk+sn4UDd/PyV
 dCgd9ZzwBSK1GAR0VSFsPMg3/y5ax4ZioJQoX5XGl6RGdzUn48cbDFLxH+AJzYLiyYvoiHEIZ5M
 qdYFVI6b3oUv4W9ISslnAeTkPKu6stVPgR2WHLHEdtpFLFYQXOa1Th3VAXIxpJsW6nEy3xrbXXb
 J1yFWXq6mgCm+QjaHuZFRtDzmjMSmg==
X-Authority-Analysis: v=2.4 cv=XdKJzJ55 c=1 sm=1 tr=0 ts=68be7d53 cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=g1y_e2JewP0A:10 a=hn6KouQsj8FLP2q12k8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lO8uDfY2By6a42z6dAfcvZBdeVAJ91EF
X-Proofpoint-GUID: lO8uDfY2By6a42z6dAfcvZBdeVAJ91EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508280000 definitions=main-2509060027

SGkgbmV0ZGV2LA0KDQpXZSBoYXZlIGEgcHJvYmxlbSB3aXRoIGltcGxlbWVudGluZyBmb3IganVt
Ym8gc3VwcG9ydCBhY3Jvc3MgZ2VuZXJpYyBob3N0cy9uZXR3b3Jrcy4gUGVyaGFwcyB3ZSd2ZSBt
aXNzZWQgc29tZSBvYnZpb3VzIHNvbHV0aW9uLCBidXQgdGhpcyBhcmVhIGlzIGVzb3RlcmljIGFu
ZCBjb21wbGljYXRlZCBlbm91Z2ggbWF5YmUgbmV0ZGV2IGNhbiBoZWxwLCBwbGVhc2UgYmVhciB3
aXRoIG1lLiBJbiBncmVlbmZpZWxkIGVudmlyb25tZW50cywganVtYm8gaXMgbm90IHJlYWxseSBh
IHByb2JsZW0gYXMgeW91IGNhbiBzaW1wbHkganVzdCBzZXR1cCB5b3VyIGxvY2FsIG5ldHdvcmsg
Y29ycmVjdGx5IGFuZCBoYXZlIHdoYXRldmVyIHlvdXIgYm9yZGVyIChvciBvdGhlciBwYXRoIHJv
dXRlcikgcmVwbHkgd2l0aCBJQ01QIFBUQi9GcmFnbWVudGF0aW9uIE5lZWRlZCBtZXNzYWdlcy4g
T2YgY291cnNlLCBpdOKAmXMgbm90IGhhcmQgdG8gb3ZlcmxvYWQgeW91ciBib3JkZXIgcm91dGVy
IENQVSB3aXRoIElDTVAgcmVwbGllcyAodmFyaW91cyBwZXJtdXRhdGlvbnMgb2YgZGlmZmVyZW50
IHBhY2tldHMgdHlwZXMgbGlrZSBVRFAsIG9yIFRDUCBNU1MgbmVnb3RpYXRpb24gdGhhdCBoYXMg
anVtYm8gb24gYm90aCBjbGllbnQvc2VydmVyLCBldGMpLCBhbmQgaW4gdGhhdCBjYXNlIHlvdSBj
YW4gYWRkICJtdHUgMTUwMCIgdG8geW91ciBkZWZhdWx0IHJvdXRlLCBhbmQgY3JlYXRlIGEgbWFw
IG9mIG5ldyBrZXJuZWwgcm91dGVzIHRvIHBsYWNlcyB5b3UgZXhwZWN0IGp1bWJvIHBhdGhzIHRv
IGFuZCBhdm9pZCBvdmVybG9hZGluZyByb3V0ZXIgbGltaXRzIChrZWVwaW5nIGluIG1pbmQsIHRo
ZSBhY3R1YWwgcm91dGVzIG1heSBmbGFwIHVwc3RyZWFtLCBtb3ZpbmcgeW91ciB0cmFmZmljIGJh
Y2sgdG8gYSBub24tanVtYm8gcGF0aCBiZXR3ZWVuIGFueSAyIGhvc3RzLCB3aGVyZSB5b3Ugd2ls
bCBuZWVkIFBUQidzIGFnYWluKS4gU2luY2UgaXQncyBhbGwgbmV3IHNvZnR3YXJlIHRoZXJlJ3Mg
dG90YWwgY29udHJvbCBvdmVyIGFueXRoaW5nIHlvdSBhZGQgYW5kIGl0J3MgYSBzdHJhaWdodGZv
cndhcmQgc29sdXRpb24uDQoNCkhvd2V2ZXIgdGhlIHByb2JsZW0gaXMgdGhhdCB3ZSBkbyBub3Qg
aGF2ZSBhIGdyZWVuZmllbGQgZW52aXJvbm1lbnQsIHdlIGhhdmUgbWFueSBzeXN0ZW1zIGluIG1p
eGVkIG5ldHdvcmtzIHdoaWNoIGJvdGggaGF2ZSBsZWdhY3kgc29mdHdhcmUgL211bHRpdGVuYW5j
eSBvZiB2YXJ5aW5nIGRlZ3JlZXMsIGFuZCBlYWNoIHBpZWNlIG9mIHNvZnR3YXJlIG1heSB3YW50
IHRvIGluc2VydCBpdHMgb3duIHJvdXRlcyBmb3IgaXRzIG93biBwdXJwb3Nlcywgb3IgYWRkIGFk
ZGl0aW9uYWwgZGV2aWNlcyBvbi1kZW1hbmQgbGlrZSBtYWN2bGFucy9icmlkZ2VzL2V0Yy4gQmVj
YXVzZSB0aGF0IHNvZnR3YXJlIGxpa2VseSBkb2Vzbid0IGtub3cgYW55IGJldHRlciwgc2luY2Ug
d2UgaGF2ZSBqdW1ibyBzZXQgb24gb3VyIHB1YmxpYyBpbnRlcmZhY2UsIGFuZCAibXR1IDE1MDAi
IHNldCBvbiBvdXIgZGVmYXVsdCByb3V0ZSwgYSBicmFuZCBuZXcgcm91dGUgKG9yIG1hY3ZsYW4v
ZXRjKSBhZGRlZCB3aWxsIGRlZmF1bHQgdG8ganVtYm8gLSBhbmQgaXQgcHJvYmFibHkgZG9lc24n
dCB3b3JrLCBpdCBtYXkgZXZlbiBibGFja2hvbGUgZm9yZXZlciBpZiB0aGF0IHBhdGggaXMgaW4g
dGhlIGxvY2FsIGJyb2FkY2FzdCBkb21haW4gYXMgdGhlcmUgaXNuJ3QgYSByb3V0ZXIgdG8gc2Vu
ZCBhIFBUQi4NCg0KSSBzdXNwZWN0IHRoYXQgd2UgYXJlIG5vdCB0aGUgb25seSBvbmVzIGZpZ2h0
aW5nIHRoaXMgaXNzdWUgdG9kYXksIGdpdmVuIHRoYXQgL3Vzci9iaW4vcGluZyBhZGRlZCBhIGNy
aXRpY2FsIGZlYXR1cmUgZm9yIHdvcmtpbmcgaW4gdGhpcyBwYXJhZGlnbSBqdXN0IGxhc3QgeWVh
ciwgc3VwcG9ydCBmb3IgcGFzc2luZyBJUF9QTVRVRElTQ19QUk9CRSBzbyB3ZSBjYW4gYnlwYXNz
IHRoZSBkc3QgcG10dSBvbiB0aGUga2VybmVsJ3Mgb3V0cHV0IHJvdXRlIGxvb2t1cCAocmVtZW1i
ZXIgd2UndmUgc2V0ICJtdHUgMTUwMCIgb24gb3VyIGRlZmF1bHQgcm91dGUgZnJvbSBhYm92ZSkg
c28gd2UgY2FuIHRlc3Qgd2hhdCBob3N0cyBhcmUgYWN0dWFsbHkganVtYm8tcmVhY2hhYmxlIGJl
Zm9yZSBlbmFibGluZyBqdW1ibyBvbiB0aGF0IHBhdGguDQoNCkkndmUgdHJpZWQgdG8gYnJhaW5z
dG9ybSB2YXJpb3VzIGlkZWFzIG9mIGlmIHdlIGNvdWxkIGRlYWwgd2l0aCB0aGlzLCBtb3N0IHNl
ZW0gaW1wZXJmZWN0IG9yIG1heSByZXN1bHQgaW4gYSBrZXJuZWwgcGF0Y2ggdGhhdCBpcyBjb21w
bGljYXRlZCBvciB1bmFjY2VwdGFibHkgaGFja3k6DQoxLiBXZSBjb3VsZCBwYXRjaCBhbGwga2Vy
bmVsIHJvdXRlIGFkZHMgdG8gYXBwZW5kICJtdHUgMTUwMCIgY29uZGl0aW9uYWxseSBpZiBub3Qg
b3RoZXJ3aXNlIHNwZWNpZmllZC4gSW5zdGVhZCBvZiBhIGtlcm5lbCBwYXRjaCB0aGlzIGNvdWxk
IHBvc3NpYmx5IGJlIGEgcnRuZXRsaW5rIG5vdGlmaWNhdGlvbiBsaXN0ZW5lciBvciBlQlBGLiBU
aGlzIGhhcyB0aGUgZG93bnNpZGUgdGhhdCBhbnkgZGFlbW9uIHJlY2hlY2tpbmcgaXRzIGluc3Rh
bGxlZCByb3V0ZXMgbWF5IGNob2tlIG9uIHRoZSBhZGRpdGlvbmFsIG1ldHJpYy4gQWxzbyBhZnRl
ciBwcm90b3R5cGluZyB0aGlzIHdpdGggcnRuZXRsaW5rIEkgZGlzY292ZXJlZCB0aGF0IHdlIGhh
dmUgc29tZSB2ZXJ5IG9sZCBwcm9ncmFtcyB0aGF0IHVzZSBTSU9DQUREUlQgb3IgL3NiaW4vcm91
dGUsIHdoaWNoIGRvZXNuJ3QgdW5kZXJzdGFuZCB0aGlzIHN0dWZmIGFuZCB3aWxsIG1ha2UgZHVw
bGljYXRlIHJvdXRlcyBpbnN0ZWFkIG9mIGdldHRpbmcgLUVFWElTVFMgYXMgaXQgYmxpbmRseSB0
cmllcyB0byBtYWtlIHN1cmUgaXRzIHJvdXRlIGlzIGluIHRoZSBrZXJuZWwgKHllYWgsIGljayEp
LiBBbHNvIG5ldyBkZXZpY2VzIGxpa2UgbWFjdmxhbidzIGFuZCBicmlkZ2VzIG5lZWQgYWRkaXRp
b25hbCB3b3JrLCBidXQgY291bGQgYmUgZml4ZWQgdXAgaW4gYSBzaW1pbGFyIGZhc2hpb24uDQoN
CjIuIEZvciBldmVyeSBkc3QgbG9va3VwIG9uIG91dHB1dCB3ZSBzaW1wbHkgbG9vayBhdCBhIGds
b2JhbCBvciBwZXItaW50ZXJmYWNlIHN5c2N0bCAoaS5lLiAvcHJvYy9zeXMvbmV0L2lwdjQvY29u
Zi9ldGgwL2RlZmF1bHRfbXR1KSBvbiB3aGV0aGVyIHdlIHNob3VsZCBsaWUgYWJvdXQgd2hhdCB0
aGUgTVRVIHJlYWxseSBpcy4gaS5lLiB3ZSBhbHdheXMgcmV0dXJuIHRoZSBzeXNjdGwgdmFsdWUg
KDE1MDApLCB1bmxlc3MgYSBNVFUgbWV0cmljIGlzIGF0dGFjaGVkIHRvIHRoYXQgcm91dGUuIFRo
aXMgcHJlc2VydmVzIGJlaGF2aW9yIHdpdGggYW55IGxlZ2FjeSBwcm9ncmFtcyBsb29raW5nIGF0
IHJvdXRlIHRhYmxlcywgc2luY2UgdGhlIHJvdXRlcyB3aWxsIG5vdCBsb29rIGRpZmZlcmVudC4g
T2YgY291cnNlLCB0aGlzIGhhcyB0aGUgZG93bnNpZGUgb2Ygbm93IGhhdmluZyB0byBtb2RpZnkg
YWxsIHByb2dyYW1zIG9yIHJvdXRlcyB3aGVyZSB3ZSBXQU5UIGp1bWJvLCBidXQgbWF5YmUgdGhh
dCBoYXMgYSBtdWNoIHNtYWxsZXIgc3VyZmFjZSBhcmVhLiBIb3dldmVyIHdlIHN0aWxsIGhhdmUg
YSBwcm9ibGVtIGZvciBhbGwgdGhpbmdzIHRoYXQgaW5oZXJpdCB0aGUgaW50ZXJmYWNlIE1UVSwg
bGlrZSBtYWN2bGFuIGFzIGFib3ZlLiBBdCBsZWFzdCB0aGlzIHBhdGNoIHdvdWxkIGJlIHNtYWxs
LCBwcm9iYWJseS4NCg0KMy4gUGF0Y2ggc3RydWN0IG5ldF9kZXZpY2Uge30gYW5kIHN1YnNlcXVl
bnRseSB0aGUgd2hvbGUgd29ybGQgKG5ldCBkcml2ZXJzLCBpcHJvdXRlMiwgZXRjKSB0byBhZGQg
InVuc2lnbmVkIGludCBtYXhfbXR1Iiwgd2hpY2ggY2FuIGJlIHNldCBkaWZmZXJlbnRseSB0aGFu
ICJ1bnNpZ25lZCBpbnQgbXR1IiBwZXIgbmV0X2RldmljZSBvbiBSVE1fU0VUTElOSy4gV2hlbiBk
b2luZyBub3JtYWwgbG9va3VwcyAibXR1IiB3b3VsZCBiZSB1c2VkLCBob3dldmVyLCBpZiBhIHJv
dXRlIG9yIGNoaWxkIGRldmljZSBleHBsaWNpdGx5IHJlcXVlc3RzIGEgbGFyZ2VyIG10dSB0aGFu
IHNldCBpbiBzdHJ1Y3QgbmV0X2RldmljZSwgdGhhdCB3b3VsZCBiZSBjaGVja2VkIGFnYWluc3Qg
bWF4X210dSwgd2hpY2ggaXMgdGhlIHZhbHVlIHdlJ2QgYWN0dWFsbHkgY2hhbmdlIHRvIGVuYWJs
ZSBqdW1ibyBmcmFtZXMgdG8vZnJvbSB0aGUgcGh5c2ljYWwgaW50ZXJmYWNlIHdoZW4gaW4gYSBt
aXhlZCBNVFUgZW52aXJvbm1lbnQuIEluIGdyZWVuZmllbGQgZW52aXJvbm1lbnRzIHlvdSB3b3Vs
ZCBzZXQgbWF4X210dT1tdHU9OTAwMC4NCg0KQW55IGZlZWRiYWNrIGFwcHJlY2lhdGVkLg0KDQpU
aGFua3MsDQpEZWJhYnJhdGEgQmFuZXJqZWUNCg0KDQoNCg==

