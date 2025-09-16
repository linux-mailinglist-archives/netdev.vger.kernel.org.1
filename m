Return-Path: <netdev+bounces-223626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D1B59BD4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA426160C4B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91101313267;
	Tue, 16 Sep 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="alAGEuXf";
	dkim=pass (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b="ad9mqby6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233D20DD42
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035646; cv=fail; b=pMNIjGWw2tpzHah0DaCQFb44Fsej0ls+9hOUUTKvemH0w97ckh388hSsQDrdFR20NAbhkgWY3nCgYfiErUa+2u6jWmSCY3kWwi2KeTUMgg5IH/5tZMexqe9oVxSh7BM4fuVxOOtFZSK09Oni1kH82/MKGbAJnmqbaW2FqSxXl0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035646; c=relaxed/simple;
	bh=Lrx4Ril9hvwRgVy+NkaSvXaH9WCwCpZCGEdmjGRDtxk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AomaNU3e8WwVgJGN1AcjZgY4YP+jpSGZHOF7CYXd4h7yTzI0V+frxpRfHYCNAAl9i8aXENtG0/WEdorFyHvaq4aFAt0HaAK9JRn+BsiTyiWccY3WoKJjXP1EqWUwY4grC2zZJU+GnwhBqiTaYZ0B6UmRbdmiUun2GKAW1ULTR3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=alAGEuXf; dkim=pass (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b=ad9mqby6; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCS9ei000692;
	Tue, 16 Sep 2025 14:39:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=IsEG1AWLxODFbzUC3WWnTiK9j4x8hnwtdT/znt5oopM=; b=alAGEuXfgQar
	EX6vzGLuyYIJQQpXZKJG30hpX+xr4QzKd6Eqm/9QYeS2Qu30ZVdAibbGmSdFgJMT
	nxQ8fdReDIsAFnUAdV+Ypg4PoN1LTrzjxuA1e7HOAjLYu5xLmVRmw/l901kT2d3G
	o9QAN15Na0rFbjMfpG204lAeBVydH4vER1wX8FBdX6fWc61+KSEXmFRCY32xJzIM
	7wWnvU6ahoP+0fzy23mDpZlIk8VQl1wcIemHT9DyVOnVMm3vpp5hZEIW/P0aGw/K
	3EeLetFkXh3+PLlMyh74dluDF3c40pTS6bsfNtWAAOfFtskZgV9KNsbOxzxSIJOp
	dR82GYnY1g==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4950nrkdm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 14:39:08 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDFxMx004097;
	Tue, 16 Sep 2025 09:39:06 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.24])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 495j1t8dw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 09:39:06 -0400
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-dag4mb5.msg.corp.akamai.com (172.27.91.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Tue, 16 Sep 2025 09:39:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (184.51.33.212)
 by usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36 via Frontend Transport; Tue, 16 Sep 2025 09:39:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2Kb/5lSccIh23LnKZiJ+v31MoUfrncLx4+vKpKXeKljWQjjP0aiWh0XdJozdx+7Lie887qq8oPU8s6fjBkm2Fs5NIBxw0jTOBXt1+Xn3omMC2g0bF8MKb2SR9pfoVMtkBcY51fI5QQ5ZKT/03IRgMNHSSlH2SJDIaB5+843Qd+J9aw4WkeGD5xFuOFae3Tw/WAGz9IR9w/ipO13CVDd4LaxtuwPu2bD45hUdRGTYjak545/EJAz+QkiN0LrZy+AeeJBqGjt0wkQh16aaRvfA+h5/15YmaXA+piCVWmlzNcKfy2CPuhKxTTiwvV0KfdDq9nKDYrZd5njHDqIhOwRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsEG1AWLxODFbzUC3WWnTiK9j4x8hnwtdT/znt5oopM=;
 b=dJ/1eO2pUVQWV3/OfFj3wA9CSEmw8hXwM1i0MsdelNuKSSsT5k/FW68OXyExLww5Upx0Dzul24Y4W1E7iw+iKkNw9T0eMrvlDV98SKP5cszQ9PZ/RD47vVK7ALDhMf2ej2lyMaeWsdl6RTscH4xnk9YiTT1iwxCY5zweOLkyQphZIp0fau/me5nQaBMZIcwxXcS+epPZ3EJRIkH7ZZNyw3T9QIpcFwD16oJFiVNaObf02Mgrg16enct/6Ko25xO2hiC7RKsC+wRYypHkGerbRC/9iHREYIj36VrhVHxrgySXOVoTvtYWOeoa7VvD5uTrmbgexpM6sk3wFsPlz2zmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsEG1AWLxODFbzUC3WWnTiK9j4x8hnwtdT/znt5oopM=;
 b=ad9mqby6Hjbfj4qr8XlfahaLqDAp7/gyAFz9Nhi4QtEvYHYr9LeULj3yFv3Uc2awlh9hD8bPQDl+txn7G/lCCAg6fVwcU4/prXutik77Lgzd+Slq2W/GeLKfq4m4YdFo5k2lVVly7d8ZFrIZPCO2URiq2yH61cWPDPjx0chDcn4=
Received: from SJ0PR17MB4870.namprd17.prod.outlook.com (2603:10b6:a03:37b::13)
 by IA1PR17MB6999.namprd17.prod.outlook.com (2603:10b6:208:451::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 13:39:03 +0000
Received: from SJ0PR17MB4870.namprd17.prod.outlook.com
 ([fe80::8ba7:58e9:1925:49a4]) by SJ0PR17MB4870.namprd17.prod.outlook.com
 ([fe80::8ba7:58e9:1925:49a4%6]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 13:39:02 +0000
Message-ID: <25d0268f-ab13-4e73-888d-ff75acf8b551@akamai.com>
Date: Tue, 16 Sep 2025 09:38:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: allow alloc_skb_with_frags() to use
 MAX_SKB_FRAGS
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, Willem de Bruijn <willemb@google.com>
References: <20250916034841.2317171-1-jbaron@akamai.com>
 <CANn89iLMd64djnN_KZi6y49zcd46Lg96uDO7YxkHaDsaJ=vdAw@mail.gmail.com>
Content-Language: en-US
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <CANn89iLMd64djnN_KZi6y49zcd46Lg96uDO7YxkHaDsaJ=vdAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:52f::15) To SJ0PR17MB4870.namprd17.prod.outlook.com
 (2603:10b6:a03:37b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB4870:EE_|IA1PR17MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d74c3a5-9144-4352-4d8c-08ddf526661b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGJJSFhKVkwxVXBKQkNSQjhHMm1QR200MzFLeGVyUk1GOXI2c1AxSHVEbHJt?=
 =?utf-8?B?NyszQUh6YlZETzVISkgxeHZicGJ2NzJCQTVLblYxS0c3Zno1NEJiTTNORFNJ?=
 =?utf-8?B?QWVMeVh2T1dTTE1SZ2d4eVBEbDRmWWVMck50VnpmUnVhNEl2M0E3WVNBaHVE?=
 =?utf-8?B?VXRDNHl3Y0JMVTdhVy9GSkxyLzI0dWY4V3RKMURZVkRLVXpvdUx3UUtCUmZD?=
 =?utf-8?B?bjVZU1R1SVp3UzRHTUhOaXZMSVZmTkxwVWRxaExtQkgxZDBBVW55U0syTGxx?=
 =?utf-8?B?d0FtbGVydWJ2WWJRNTBlSEFadjFadVVvRTdMVDFEenVTcWRtaXpOTFBmMTJN?=
 =?utf-8?B?MEh6NW50WGxEOC82RVJxZ0p1b1h2SWNDKys3c1dkQTRVUmVVRWRTRGM2MVZZ?=
 =?utf-8?B?Q0xTSm5sS21JTXZtckF3L0FNdWM4T2Fvb2lxcnprcHYyKzNmaGduNlhjV2NM?=
 =?utf-8?B?aXUvbzN4SkpjNWJsZHk2U1RrWnBEUDBKay9XRlZSdFkxUlk2RGFrTmdkeGlQ?=
 =?utf-8?B?cE1qM0hhRnNYWjZyVzlKUzhSaE5ra3N6N3hkQVJrK3YvdVpsTEdZcFJvTTVE?=
 =?utf-8?B?SjZySUw1OFJCUjVxMDFjWUgwTVcwMW5US1Aza0JhU1V0OFdZUWxKRFJoaEVn?=
 =?utf-8?B?QlFnanJJejEzTEJaZm1NcHE0K0NQdmxxVVBFd0lHQURESFdZUlEvbXNkZmtN?=
 =?utf-8?B?OHV2Mi83Q05lQk13bVplakJNNVAweEhsL3llU0FhVlE3M2o0eVU5OU5VZFl0?=
 =?utf-8?B?aXQ3bkNObHNGcjl2cVcrL1Y3S08xT2RzRkk3ZHFkMXVINzArMzZYclRxRWJm?=
 =?utf-8?B?aEYyZGJwWEpiczNjM0x3aEpQTEY5ckprb1VCZWxSSXVpMFBVUkh0Q2RLeXVz?=
 =?utf-8?B?a1FnMVdZeW5PUjF5eFNlVnc3UTVkNWovQ0xBTUFIbmxYSjhXUXo3TVU1YU95?=
 =?utf-8?B?ZzIyR0U3SXZzc01VK2VuRmpDRzZXQUtUaURmS0VaNWJkSW9Mc3ZXWENoZWNi?=
 =?utf-8?B?YVF0RHNhaHFKS1ZUYjZNeUtaYXN4UEtzcjVLVlVqT0dQVTIvdjF2eG9obnIx?=
 =?utf-8?B?NStYQnRmOUtDL01Fa0RZc0dVREJVZXYvdlZ2WEQzL3hNbjl2b3BFSVQ3KzJF?=
 =?utf-8?B?Y2hFVzFiZlh4bS9lVlVLcFNUOEZnSENTT0prdTBBbkZVME1tclV6RGlodmdm?=
 =?utf-8?B?bXRWTzh2a3dRbGZwRk55cUFpK2t3TzBLa3AyRkVxRGduMHZYTFQ1VTRZc2pi?=
 =?utf-8?B?UkFMRTZ5NURnMFdtRnoyZzdnUUFoZG5ScmkrUkJNUkVLMEl4REpLK0NEcHhC?=
 =?utf-8?B?NEZ1ejJnaVprQmFJNzNzTmx2bjhGV3lCbWN6M0Z1WENrMityL2QrMVI3WTdx?=
 =?utf-8?B?VWVKRHVJbTZ5UkEwMytSeFlySWg0TXpyVGdINFZyY0lvZWo3aERoRTFaTGE2?=
 =?utf-8?B?ekg0WTk0MjJVYVU5bmEvQWIxSXZpTG1oMi9HamZ3VklYdmUwN3pNWUY1a1Jm?=
 =?utf-8?B?SUY1Tm5nTjArM2lvU1NWd01SN21xdithZGhZUkhWWlNwQUlmaXhMaGhXc3dI?=
 =?utf-8?B?Uy9RM2pETGc5S2ZLVDNUc2Z2ak9rWmtQb0FSNUdJNng1TXdMNGJKUlYzZ2NV?=
 =?utf-8?B?ZTdwb3hNa1BZR2xxYVB4NFdRWUkvUVdYNWk5Qms2TGF0dlNxQVNkU1pEQ2l1?=
 =?utf-8?B?NlF4RzBUbkFsdkw0djA4NFNEZGdFZW8xc2FmV2g0NldvMFFGdzBOMkRnRVlB?=
 =?utf-8?B?aHQ4RmxqSm1vaXp5OUt2RDdhMGxOWnplbWs3TlNQN3dQVHpBWU1Bem10Zndx?=
 =?utf-8?B?Y0F2ZE1yckNwVlU5TnU0cklNV3dkWTJYa2x2a1hiZElMOEZKa3I2UWM0WnI0?=
 =?utf-8?B?dHVQd2ZSS2pheHc2Mkg2NEQ3UGVseVpSVDltRFJ4MGgwbkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB4870.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhHVGRXT2p2eXFTNU52NEduSGpRdUNLb3FCelkvaGpaOTlwZElQcmxxOXRi?=
 =?utf-8?B?NGJPSisrZFJpLzZmQzBrZkIvMjRFTEc1T1plNm0ycmN3QVBlekRqMWNEL0xX?=
 =?utf-8?B?YXo3dXgyYkRoL29XTXg0RTFpc080L1FCQmE3SjNhRmx0UjR1U29nVkVPM1R2?=
 =?utf-8?B?VFVOKytLb2VHMzFHQXQweDFtYVV3L0RESldFMnRMUGZ3WTF1bjYzZ2JOTy9a?=
 =?utf-8?B?ZWdUVEVlKzhFbDdZKzU5WXJITDdVbHlUUnhVM3BIUHR6MTRUdEZXSE5EdnRR?=
 =?utf-8?B?ak9YaGU2WUZSVUVuaVBLUWlEQWFNTGRXTnJvQU1rZHlnWWo3Qk5OTUVCWFNr?=
 =?utf-8?B?aUtSN2N0Um1mQWxrS2plY1dDaG9vQzF6WTNRNVBoOUkva0ZVaFF2dDBSZDlB?=
 =?utf-8?B?M2lpcVFrYzc1RFg4YjIzWUx2K01WN3BJelBqU1Z6TVBzVUxrUDJ6cEZaUWFL?=
 =?utf-8?B?R1FHNFNFY1Fxb2l2V2dEK1FtYjkvOWorZFcxQlZUY3V3WXpHZzczM0ErWisv?=
 =?utf-8?B?ZkpNaUl0ZzcvWTlFMXBjNmJORXpsMjUrZkIrZlRWNGlqOG9UMnpiVkpFYTdO?=
 =?utf-8?B?VFpac1lWWStBM0NjSUsxYWk2UlVkd3EvdERXVkkwbHhrejlGSHdPTEQxVVBD?=
 =?utf-8?B?eE9pdlBOZWRHZnhZRjVaNlJ5T3Zibk5jbkswL0w3NTl0dDFBemNrSlJITXdH?=
 =?utf-8?B?bkdldDQ0OFI1MThxRkZ5S2o4UVlsUXpkSmFBYnVpRXRWc1Jhbmc5M21pQzRs?=
 =?utf-8?B?WWUyZW5sUjBKM0c1R2toWDdGZFdOM2NOSGdPSkZJamhzckNIcDl4aUFBdjYv?=
 =?utf-8?B?OTBla2g3bmRjdnhwZDJvK0xlalAxYlQ4c2J4dkhPakNVOEFJUy9UOWZmRnVi?=
 =?utf-8?B?c2dwdzBXOTVvOUpYYWNWNUc4UjBUTW9RQTVHT0FmbjRHU0d0TDd2ejNmczRr?=
 =?utf-8?B?U1VaVzJvUnA5VGVGempDanpLTHlETFEzV21VYlJlRWtNTnhVSlozalIwbWJo?=
 =?utf-8?B?b2FCWWxZaHdhU2xqaVUvQzBiOVZldU5FRU1QNWpkQmp6OUthTVo4UVU1bzky?=
 =?utf-8?B?S2IwQVJUUEVKT3NSdUlldndMbE84c0kwandoZHdqQ2dzbjRncDZmOS9MMHBw?=
 =?utf-8?B?M1I2WkwyNHFGVEtaTTFRR1p4SDJROFU3K2NROGRtdFFWVWx3Z1VlK1NMcWpP?=
 =?utf-8?B?UENFWFJsbTRmdUZLT1NOaGMyMG9vUlpDSlhxc2VyWktLRkd5dmYzSWtsQm13?=
 =?utf-8?B?c3NiWFMxeVZTRXVIemFzamt2TDZGdW4rWDRHVG5xdS9qQUhudER0ZGpKVXFI?=
 =?utf-8?B?TmZ4d3JtbGphQ2EwVmpCdEtQOTR0aUJnb2NFR21KR0RvejdQNVNSVnc1RG5W?=
 =?utf-8?B?ME9KajU4UG9jVGkyMENQbWpqOWNIbXJLUnArWXVaWW85T2V4NEo1V05vTEl3?=
 =?utf-8?B?SHpiaGZEdk9xcmxsK1p2ZktqMERtd0IzdS9aU0duNnlDY21veWFzNnp4eEdj?=
 =?utf-8?B?ZlpqY09vNnEvZ3d3cUtwTkRnbE96UVBPL1g0VXp5d0kyMXdjcTE0SHNndjlL?=
 =?utf-8?B?NnpYWWdrb3dPTzZ5U2JvalpIZnk0MUpjM3Mva3pXbTRsNFZ4RkQyR0MreEpO?=
 =?utf-8?B?SkxCM1dMV1BFT0l6UUM0RGZPMjljMkdWZ2pPbWVVT0MvTU0rU1A2VUZmYTZt?=
 =?utf-8?B?UVd3VXBQSHVjZmYzd2JQN0dCencyYnlJdFFaUVl6VW9YTTd6S1BUTzJPM21h?=
 =?utf-8?B?R0lKeG9zWjBkMUdLUFR2MVNKOGdMaFFnT2sxRWtXaFJCSXRxZTA3SXFDWjNw?=
 =?utf-8?B?eEJxTVRXQVo1dXBYNlNtOGw3T2huZ2wwRE1EU3ZwWmRSTjJQUDhaam5SRGlZ?=
 =?utf-8?B?eVl1aGM2WlcxWlkzeGZUNVJsN1d6b1Bsd2poaE4yZWI3NnVWZmdjNjgzSzA4?=
 =?utf-8?B?T3ZZTlA3VFZiZFRHVUlYdWNmZG0wK1BCUTFxbnlvVWNBZ2xzMGZFSngwRnZs?=
 =?utf-8?B?ZVFUbVo1c0hLY1AxdEp3RFhCREE2RkszcnUxUHJxQXFYUkZxSFFCUFZjYjlU?=
 =?utf-8?B?c3dSUWhvUVhqYS9QLzFEd21jZkxHZVg5MVB2QjMwREFFb2dITWQyVDFLM3BU?=
 =?utf-8?Q?PoHjJI0lsPpVhbliGyCFlNx3e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d74c3a5-9144-4352-4d8c-08ddf526661b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB4870.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 13:39:02.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 514876bd-5965-4b40-b0c8-e336cf72c743
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qkm0wBHe+jzq94+XIr8PQyq7sQLHTeVDqNnU8sEW6Kmy/zaPXU4HlgWEbQPq1nyncZidti/xmEvEf48R/F2eug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6999
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=821 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160126
X-Proofpoint-GUID: aPpUkl-gIDgnVZylTCHwC5zwln5WRl1u
X-Authority-Analysis: v=2.4 cv=bPgWIO+Z c=1 sm=1 tr=0 ts=68c9687c cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=g1y_e2JewP0A:10 a=X7Ea-ya5AAAA:8 a=lIACeMZzyNQdy_2YakoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX0RRQHIiUG4X0
 xqqWvPAecbHs+QxQKJYEwttZjPE4VMGc7rZP9cabPzKhd+GVuftt5Q49/afs0ytQAWs6uygwlLd
 2CHu7EgG3ytbGCVZV/pVGW7keXBVsQeStg7aULIH53+kPEYkl4rgaJUD+81Jn26MU4JtwXdlY+e
 aJL9rVsT8woTejOF/IRhply67S3G0amboYyelSQ2MY+enYnaRlP7GcNHlI7WjtzT0ssRCH0y6pO
 8GNXOZcqM24zwrE11oz8iJmLJbZuyylefuUQPM/B58uXB2R40ya7vGAbP6Aa/k4GgHZcjxbm7+6
 xuwx5bW2HXiXqL9QXUV2EEF9jsPuKVkbMWlYvz3YPs+kaNPvTEL2cmdR80O83PSYUUg4fNUMCmV
 6juXWwNJ/ztSZwSKiZ3a2/12vfgLUQ==
X-Proofpoint-ORIG-GUID: aPpUkl-gIDgnVZylTCHwC5zwln5WRl1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508280000 definitions=main-2509130029



On 9/16/25 1:59 AM, Eric Dumazet wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
> On Mon, Sep 15, 2025 at 8:49 PM Jason Baron <jbaron@akamai.com> wrote:
>>
>> Currently, alloc_skb_with_frags() will only fill (MAX_SKB_FRAGS - 1)
>> slots. I think it should use all MAX_SKB_FRAGS slots, as callers of
>> alloc_skb_with_frags() will size their allocation of frags based
>> on MAX_SKB_FRAGS.
> 
> Hi Jason
> 
> Interesting !
> 
> Could you give some details here, have you found this for af_unix users ?
> 
> They would still fail if no high order pages are available, for
> allocations bigger than 64K ?
> 

Hi Eric,

So we have an oot patch that sets 'order' to 0 upon entry into 
alloc_skb_with_frags(), which effectively tests/simulates high 
fragmentation. And yes, as you guessed, in this case we saw that 
sendmsg() on unix sockets will fail every time for large allocations - 
data_len will want 68K or 17 pages, but alloc_skb_with_frags() can only 
do 64K in this case or 16 pages.

>>
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>> ---
>>   net/core/skbuff.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 23b776cd9879..df942aca0617 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -6669,7 +6669,7 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
>>                  return NULL;
>>
>>          while (data_len) {
>> -               if (nr_frags == MAX_SKB_FRAGS - 1)
>> +               if (nr_frags == MAX_SKB_FRAGS)
>>                          goto failure;
>>                  while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))
>>                          order--;
>> --
>> 2.25.1
>>
> 
> We require a Fixes: tag for patches targeting net tree.
> 
> I suspect this would be
> 
> Fixes: 09c2c90705bb ("net: allow alloc_skb_with_frags() to allocate
> bigger packets")
> 

Happy to re-spin here with this, if there is interest in the patch.

Thanks,

-Jason

