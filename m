Return-Path: <netdev+bounces-207344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D5BB06B4A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F003B4D6D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511C15A864;
	Wed, 16 Jul 2025 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="myNV5fvU"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022090.outbound.protection.outlook.com [52.101.126.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30BB171CD;
	Wed, 16 Jul 2025 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630345; cv=fail; b=Qt2XZL+Te8BQ0d+LvhVYQckzTEjS1opxMNzfoIpW5kIIzTLeJfndCxbrgdr4Wo+xGrAn461n9ooHN7jpvcgwYEV9AW9IcPOlOhSFXmS6ccZAzLrJPwLBB/DrWzYHenGXziv6So4uIp2Tu/AH6hOeV4Sbr2TRqebUHTst8t5qLKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630345; c=relaxed/simple;
	bh=hufels3BR8UsvMJAdWmlxJXYIhHzxrTIGKw6EWow4cs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ugX7JLv+VhaMsRgqcVpEYUjn4MWrA1q8oZU5HfQKc5ZsDxjEj2up0T9cxfL9UTmYHoo1vje202MEePKesX7BzaodqD/qY+wSYccL+spshJpDoHO7EB7KAShIiedMLR4DPvfO6eiFKAQXWs61GwDqfcC2sSdwTqr+/2UmN96yqh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=myNV5fvU; arc=fail smtp.client-ip=52.101.126.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQFhT7RCORX5LPvi769a0gk8X6lVJCVOzFf19zvx7vvzTFQUw+cTz6nJ3w4Xwz4OoPfyVRg36NsrKlvWKhj5eLIA09A1eDNJJpR3P8YPLb8fMMPyr0VuuGiJxnyIlapSoFiaWvAPbHfzZpjMiAbqkGL7a4OUG670h8AOGLhQmPH1lW9uRNSNnYTkZY+FgiiV9e8eJSziRuacW3zAW6tYsA3TQDSuMNor12li04Ny0+jaLC3NjQUs0FxCL4uyKcdAsQHdBs37dV3OMjEXy8DXqRxZzxLOGA/vRatpblM4RWaSQodblQ2y6pLKUIOohC8TguZcxP6vhffWfybKMYlcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpOqpOVOP9b89W4Io0FjSt75NFsDb6dnsKH0sPdiu/o=;
 b=n0eHPVaT1QRhqYRazQerZ6fNtLvzHZDfP3bN5whimAuIYX4CHJfZOlOhv1woyrTw7YPEUvSIm/hkSovk+uEru15565ecRO+/uT0EW57DYmhZStm36z6WM/UEqE31jw04aQHm4iPUKNRsL17v3PgeIep4cXg2zfJavQLkhGfDj19aGtWcjz5PgaAM1smXLDrrPjdF0ECvhWdXwA0FbJmnfK2quH/ZhbnrOp9Ti6+GMi6uT8YXVl1kf0EbWMh1CsBLoNztcAiWM21ghlbMZ8wDN0KLnxsylRvN9lO60ns9WMCtDlPXatN3ba/Agm7Zd0XDLAUCDCorCBhxpVfnct7VMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpOqpOVOP9b89W4Io0FjSt75NFsDb6dnsKH0sPdiu/o=;
 b=myNV5fvUnUhPcpOZVjqSQMIMjG/YjPHiP7IuEzr2QKSf/s9jFLEGAecs5EE9HNDUXuOTvAacswuNwAq8xMxsAqI1i0EM4LS39ngPnc27u7x1WxJX+04o01K9qoel629rudC+EylNXl+I8TnTNQL/n+VEA25yP+MJ1br1czth8vBfFYCQnqqtWnotoDHuX0StEPkTWGM5k9BlHvBLLb8UUxmVycHZdKq0oLpm7hyH7bBvvtg4SstCgMEa4anz5q498/Gvd9sWmsp8BUW/5JnG6HEv4pk9l+SDso9FYJbX/64kxlFigmFYC2ZQKDTJOwgbNENQ/D+hPFbhOgDNGr0jgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYZPR03MB8535.apcprd03.prod.outlook.com (2603:1096:405:65::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 01:45:40 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 01:45:38 +0000
Message-ID: <6b87db20-4b74-41cf-9900-3237edaaaf81@amlogic.com>
Date: Wed, 16 Jul 2025 09:45:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Pauli Virtanen <pav@iki.fi>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com>
 <dc9925eceb0abe78f7bafe2ed183b0f90bdb3ac5.camel@iki.fi>
 <CABBYNZLFnbfdXjRV0taeTNF5bsey-WFf4TFsf_ox0FNuJbEutw@mail.gmail.com>
 <CABBYNZL1Aicj15eYBgug4_KARK6xcd7eVKnzcE=vUK=mugUM4w@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZL1Aicj15eYBgug4_KARK6xcd7eVKnzcE=vUK=mugUM4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYZPR03MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 49803726-e0d8-40e9-1c53-08ddc40a7752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3piV3U4WmRQdmVTTjR0eWNnSmh1VmVVZkVYRTZOZFJhME43bFZQNU5Oenlh?=
 =?utf-8?B?Y2xoNzdkRWluSXJwc3ovcTFVY0F3UzlBYW56Nm1Ha3dRQldWS1lWMXg4QXRn?=
 =?utf-8?B?eVVMRzU5cDk2MHYyRWd0clZiRlduMzhKQUlkbE1RMjViQk9rWURpaC93R2ZK?=
 =?utf-8?B?eDVrWXZZaktuS3hsQ0NwZ1o3WElvWVI0Yi9hVVJjdUdzYWdEZXl5QjRVR3gz?=
 =?utf-8?B?QUllQ29oZ25aUFZPKzJWYXpKbStYQ3I3TGJJaDgxNVhpWXdVSUdmRXUvbnI2?=
 =?utf-8?B?TGxaUVlFOFA2dDU3Z1RqR09NYzhsNUFrQ0JEWmlnYUJ5K0htZjVVSmVnMFJx?=
 =?utf-8?B?R1luYkdnSWFERCtCVnBtNUdBQmZBZFlZcnVlV0R5S1lSYUZMa05sSXBGUUFm?=
 =?utf-8?B?cllwSVl5UG56KzVJMGpJeWsvdkZ4OFZ1bFlocDlDemIyNGVuNGQrN29UZjcx?=
 =?utf-8?B?K3lrbCs3bjIwMkVqRUIzeUc1cSt5MVRKQ2lhekdPam1IdkZqZ3NtTWs2eWFp?=
 =?utf-8?B?MHoyejVsN3BjWlhBTHN0WGVJTDFPeFRISVhmM2hoTXp2L3lEcWNycFlrTnhY?=
 =?utf-8?B?cXY3bXdTTTZVanhNdVBTTGJ2Q3VDd2ZhY0NYVlh6ZmQyMHcxdlZyZ2RVWURY?=
 =?utf-8?B?RzRuNFBLZG42ZzNQZGsxQTd3THZwbHRRZUw2TTAvUzRJM2RDZU9Xa0UzWVY2?=
 =?utf-8?B?TDIwVVIrWE5vbDZ3emZuR0xyMUoyMTBBanFQam16VGtWcUppaTFtdmVSTE1Q?=
 =?utf-8?B?TlpFTHpmTnhrYnF6M2tlL3VlUUpscmpsaWFrNGMzSXB4VTZqZUlxWGlxTmRV?=
 =?utf-8?B?S0pzUXFNUjBtMG0wcUF4Y3pJOG5UdjVLR0xjazlsbSs1a2hHUUhuS0pKWXB2?=
 =?utf-8?B?LzdsMW9hUUlBd2RCbHdlcU9FUmJHcm92d0QvdWVSdCtSTjVtTGVVYmJDSU5q?=
 =?utf-8?B?VXUrMTdQYXBkZHc5WE5oUnZmRGN1R0FhQlArMUNJcjFoeHR2MGtGMG9ET3BQ?=
 =?utf-8?B?Ung0K1JrSzZMSnBCcVh1SUs5cnJlaTZqUjhkM3ZkQ1p6dlJScm5Wc0xRQUpF?=
 =?utf-8?B?UHNyT2lKSmp6RENldG1tTjFGdWp4TEw2NTRySjBZRVFvTmxtbExRV1haeEFS?=
 =?utf-8?B?bitmVzFjQVJNb2ZFUThBclVaUktlTXdSL0Y3YThxaXdLRE5Cb05UQTdKRWp6?=
 =?utf-8?B?N0xHek9STkVYVzVzb1VRSWJoQUpNb29sRlBpK09DTW1aSHZGNWJ3YzBxWUVH?=
 =?utf-8?B?NUNBUmNlRVlWVm45c1NHbExjTTZpZ0pibXB6VHBVdlV3ZkxTMThPbzViRXA2?=
 =?utf-8?B?eDJDUmI3OXNMWkcyOWhFRTg4WStYQWlmZWFLREk1OWZoVVFERGVLakwxL1h3?=
 =?utf-8?B?ODMxRTZzbWQxdmtMVmxiWG1memFTb1VyNmgvNnZhZXMwVCtxVnNCelZoOEx4?=
 =?utf-8?B?RTJQQ29CdnVVWGlJTjFLSWpGZnorT1NiRlNoK0Q1MUJkTjhjUEpuMUh3Qitj?=
 =?utf-8?B?OFg4NFZONXdTbW9HeStZaE9CYUM1bURiRFc2bG9Sdkl5VWhTaUkyckJXZ05Z?=
 =?utf-8?B?WHZEZ0lZRXpjeDFWeFJUUnA1cmQwb09hZHRLbTE4eVkzTWZhelBsa3VmcGRu?=
 =?utf-8?B?alpvS1plWWhsY0JoaVJPdTF2eTRnck5kNnlmQTZCNDJFeTk4N2g1Y09iRU44?=
 =?utf-8?B?TGdkcjNtNXJUa0VQY1Eyb2hEZVhWMk9YcGtpSUQ0SEs4cU85SWJZbndkYmpl?=
 =?utf-8?B?OHYrR2xYSUxFc1F1SmtqekZmWDIzUVY3azVnNFZpdFBjbUVld3hMT0Y2V1oy?=
 =?utf-8?B?OUVZQkRPZEkxRFpmeTRLQXgrMXBtU2QzaHlGL1k3Qkw3dlZyL09xQXVBaFpP?=
 =?utf-8?B?RFlNOVRvV0g3clJuRnN3RVRva0FsTlRLZG1pa0F4TTB5bVVZRHpRMHlKSHNw?=
 =?utf-8?Q?t4k2TlzxDSw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0s0Zy9LeW9DbjAwbVlDdDg1S05YQjhQZzNpOEJmQjZtMkx6L1B1T2t4OTN4?=
 =?utf-8?B?eVlkQlBzeW83L25HSEY0WjVuTWdUWGgzV1pLOVgvT2Eyb0hKRGhxbmdtRHdu?=
 =?utf-8?B?YUtWZmxjS0g2VlFHdWtQalZLZTNjKzJrN1BRejJnVkQ5ZmswMWVvTTJISkEx?=
 =?utf-8?B?MWhYMEhIL2JQaVB1a1kwNDdNRlh6b2pDdGtCM3p3QjhIT2dRMTd4Y2RjN1JC?=
 =?utf-8?B?OU1jQW1SZUR4TVlhL2lKQXlsN2xtNHc2a1ZPczBobkJPd3hJYVhjekd4T1hF?=
 =?utf-8?B?SWwzOGtZd0Y3aGdNd0JZWFFScVJtU1hyMW03bS9HWDJnL3FzN0JJRzhVamUy?=
 =?utf-8?B?M2xEOTBlWlFKenVhY0dzZkN6ME1EVnB0VGowZms1b3Z6YkNsTm1mUGV0bFo0?=
 =?utf-8?B?Q3lCZDVhYmJPWFVGUmc0azZVeVZsalkrTDVtWjNmbjNIY0Y5UGh1K1VJR2tw?=
 =?utf-8?B?V0pYdkxmU3BYb3pveU5sWWtPUkRUQk5kQWZOVmJaL2Z3Tkg3N0tEKzErM2dN?=
 =?utf-8?B?WGFndWF6VmYvdzRnV2x2OWRXR0FnVXRIMndqMlJlY1lFRDZzdlh0ZDk0K1RM?=
 =?utf-8?B?QXZvaHd6YUU3VThHdjRDcWJQZllzdnVSVHFKTjVEOUNkbkl2cVU2N0V1L1dP?=
 =?utf-8?B?RmdUTGgyTUJDUEdmZ3J0TlhBL2dBRjV5U3VndFJ5emhSRFdZUDdoWStVZkRK?=
 =?utf-8?B?TDNCcHRrVnExK2NESlNKSFRGWHhZblRyNUZ0dXFHU3BxRWFEeDRRc0c1MWZ5?=
 =?utf-8?B?dTRDdS9pd2pFc1dOODk1Qk9NSVAwNGUzQTM3NlU2ZGVZRklqbThwZXNZa1Iv?=
 =?utf-8?B?ZG5WemNvUGtQWTF5cmttQmJGSXNtTUpuTXRaS3pnajZlY21IUE50MzRYbVIy?=
 =?utf-8?B?SXZmYm5QQWw5TmdpdnNoeEUrQzhSWjlDZkNhY2hHOS9wN1pqeFk1THJrK2pS?=
 =?utf-8?B?NDhLdC9VT1NDaCt0b2kzRmRFQ0RieitReXMwZnpPYmh2T0J4RWZXY241YXEr?=
 =?utf-8?B?RHk5WDU2Z2M0bEs5SVhFRGpyNnJYS0pra2hIQ0VzZ2llSmVIK0k0QVMwQmEv?=
 =?utf-8?B?a0JuK2Zaam5qcm1JRmhoVzBiZmNoWWZ0cXZuOGNURXRlWnZoaUFGRlp3T0Nx?=
 =?utf-8?B?Qi8rcERmemp4enU3NWsyNkxJaXgwWExmc1l1L2wxSWZqWE1yZExoYnJabWhN?=
 =?utf-8?B?MmpFVnF4OHE2R0RtSkVGMEd3c0crdkZyQStTaGNZbGk2OVN1dmd1UmRSbEhY?=
 =?utf-8?B?M3RnOVZsZW5kY2RNaVlubHVRa3VhOVRka0cwRzE5YjhhRFYwSUhVRytmdW9S?=
 =?utf-8?B?Mm5ETlpveFJnZ3JGREh6K2xTbzV5MVl6TTF5MWZoT0swN2NTcjhrd3JDV1Vx?=
 =?utf-8?B?b1NBamw1amg5RnE4SW9rRy9peFF3ejhnek5MY1k2REVDUWVqZmpFc041UHRn?=
 =?utf-8?B?eGhhVWZWZFZlMUFLQllydHNLZGQvVGVFS256Z0Y5U00yd3BNREZLVGorekJE?=
 =?utf-8?B?Vmo2YXZnNkhGYW5hdmlwQmdSVlVmUnRsZEt5RnRwa29nMzArREFsSEJhVm4w?=
 =?utf-8?B?WGJ1MTQ3cGVWelk5VjY1N2hDODhhSUNQbWhhQnFacEMyQk81dUNyc0dsYjZL?=
 =?utf-8?B?cE5ZOGhabW1VdSt1K1l1WXg5a2c3a09FRHdwVW5oMnBYOG1mTlJhWXhFZmpW?=
 =?utf-8?B?cExhem1Yd29ZU0JtaHhNSjlvNzc2U3pMc0J2YXRDdmJPZ0R4aXlHT2MzR3R2?=
 =?utf-8?B?NzRlRzJ4YkFCNkFjYmpIQmM1TFJTT2YzNHdLVkI4RUFyUFVER0FSRWFLYmpx?=
 =?utf-8?B?WmVPTVprMC9Ha0l5VXRuTi84Mit5d05rY1B3djBGUW5NYlJPaEI5QjFZVFJk?=
 =?utf-8?B?b0ZXYUUzT20vUTRjd0QyU0pzcWpmME5VU3ZPNFNMeEowNUJzc0tVTjZ3bGtD?=
 =?utf-8?B?TktQWU4wMlEydXpIMDVOUVNFYVBUYTcxUlpOdVFEN3pBaVRyWmJLVzVGb2dH?=
 =?utf-8?B?NEp1anJDV1JFdm5ZZ0ZTaHFtaVkzWk1MQjdnREV0K0NxQXpyUG5sU2NSMXlk?=
 =?utf-8?B?TUtjZGE4QUxCWjFpalZRdEVUb2loZlZ6QVdtVmp5QXh4WkxRWmpLT2xqY1FV?=
 =?utf-8?Q?F5/a/fgSqTg1fBuKn7d1ACgsJ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49803726-e0d8-40e9-1c53-08ddc40a7752
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 01:45:38.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNjSYwR2JGDEnTEQyudg0plPgLPqeOjss1lSy2KwRBVob/qlyvfoomtPtB0UG5YWuopzgC6xCMPxeJj4E3wy6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8535

Hi Luiz,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Tue, Jul 15, 2025 at 9:37 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Pauli,
>>
>> On Tue, Jul 15, 2025 at 9:30 AM Pauli Virtanen <pav@iki.fi> wrote:
>>> Hi Yang,
>>>
>>> ma, 2025-07-07 kello 10:38 +0800, Yang Li via B4 Relay kirjoitti:
>>>> From: Yang Li <yang.li@amlogic.com>
>>>>
>>>> User-space applications (e.g. PipeWire) depend on
>>>> ISO-formatted timestamps for precise audio sync.
>>>>
>>>> The ISO ts is based on the controller’s clock domain,
>>>> so hardware timestamping (hwtimestamp) must be used.
>>>>
>>>> Ref: Documentation/networking/timestamping.rst,
>>>> section 3.1 Hardware Timestamping.
>>>>
>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>> ---
>>>> Changes in v4:
>>>> - Optimizing the code
>>>> - Link to v3: https://lore.kernel.org/r/20250704-iso_ts-v3-1-2328bc602961@amlogic.com
>>>>
>>>> Changes in v3:
>>>> - Change to use hwtimestamp
>>>> - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068@amlogic.com
>>>>
>>>> Changes in v2:
>>>> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
>>>> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
>>>> ---
>>>>   net/bluetooth/iso.c | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>>>> index fc22782cbeeb..677144bb6b94 100644
>>>> --- a/net/bluetooth/iso.c
>>>> +++ b/net/bluetooth/iso.c
>>>> @@ -2278,6 +2278,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>>>>   void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>>>>   {
>>>>        struct iso_conn *conn = hcon->iso_data;
>>>> +     struct skb_shared_hwtstamps *hwts;
>>>>        __u16 pb, ts, len;
>>>>
>>>>        if (!conn)
>>>> @@ -2301,13 +2302,16 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>>>>                if (ts) {
>>>>                        struct hci_iso_ts_data_hdr *hdr;
>>>>
>>>> -                     /* TODO: add timestamp to the packet? */
>>>>                        hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
>>>>                        if (!hdr) {
>>>>                                BT_ERR("Frame is too short (len %d)", skb->len);
>>>>                                goto drop;
>>>>                        }
>>>>
>>>> +                     /*  Record the timestamp to skb*/
>>>> +                     hwts = skb_hwtstamps(skb);
>>>> +                     hwts->hwtstamp = us_to_ktime(le32_to_cpu(hdr->ts));
>>> Several lines below there is
>>>
>>>          conn->rx_skb = bt_skb_alloc(len, GFP_KERNEL);
>>>          skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb-
>>>> len),
>>>                                                    skb->len);
>>>
>>> so timestamp should be copied explicitly also into conn->rx_skb,
>>> otherwise it gets lost when you have ACL-fragmented ISO packets.
>> Yep, it is not that the code is completely wrong but it is operating
>> on the original skb not in the rx_skb as you said, that said is only
>> the first fragment that contains the ts header so we only have to do
>> it once in case that was not clear.
> I might just do a fixup myself, something like the following:
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 0a951c6514af..f48fb62e640d 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2374,6 +2374,13 @@ void iso_recv(struct hci_conn *hcon, struct
> sk_buff *skb, u16 flags)
>                  skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
>                                            skb->len);
>                  conn->rx_len = len - skb->len;
> +
> +               /* Copy timestamp from skb to rx_skb if present */
> +               if (ts) {
> +                       hwts = skb_hwtstamps(conn->rx_skb);
> +                       hwts->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
> +               }
> +
>                  break;
>
>          case ISO_CONT:
>

Well, that's great!
Thanks so much for your help.
>>> It could also be useful to write a simple test case that extracts the
>>> timestamp from CMSG, see for example how it was done for BT_PKT_SEQNUM:
>>> https://lore.kernel.org/linux-bluetooth/b98b7691e4ba06550bb8f275cad0635bc9e4e8d2.1752511478.git.pav@iki.fi/
>>> bthost_send_iso() can take ts=true and some timestamp value.
>>>
>>>> +
>>>>                        len = __le16_to_cpu(hdr->slen);
>>>>                } else {
>>>>                        struct hci_iso_data_hdr *hdr;
>>>>
>>>> ---
>>>> base-commit: b8db3a9d4daeb7ff6a56c605ad6eca24e4da78ed
>>>> change-id: 20250421-iso_ts-c82a300ae784
>>>>
>>>> Best regards,
>>> --
>>> Pauli Virtanen
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz

