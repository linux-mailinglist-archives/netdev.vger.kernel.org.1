Return-Path: <netdev+bounces-201575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1CFAE9F4D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BE55A26AA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB72E7F37;
	Thu, 26 Jun 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RgD9DkVp"
X-Original-To: netdev@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2125.outbound.protection.outlook.com [40.107.116.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B32E7648;
	Thu, 26 Jun 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945511; cv=fail; b=g4vJSMwewlOEbG0lhISsu8PRyri4Z/zNFYA5knWXz5ATnSr+xzjTufIZBxR/P5Gr5edNERsDCjk2QVR8ytgwys7hB4aoTyp/7qv7BfwrPtd/BKQWXW4ssu+RSkJ1oAw0/zXICmlNlBk4wXPPPGTFi0vgEoTOLHDQyHraYtJ5ofg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945511; c=relaxed/simple;
	bh=jL6jOH4CuHpT4rGzlsC7NNR6fGVtNCLjLBbp4zml2NU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jaRK89NR9adQac0U9CP85ob8DiBf2SVteTRI8JrNXrX+opSDSndgnJv+WrM8p4YfYqnx+LpujFIElazNw972cN17UhZYI18TYHmQ+ZKyNG4lNyjAWgpglHfM8PAyDAiKaC5/dwV99HIx6JNgmSjrSR7aqjMZwMwdpS6hVUcWkTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RgD9DkVp; arc=fail smtp.client-ip=40.107.116.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyKrPFh9SIC/xd8StvtflxNxzeEs1rI5SxcoHZeIHM4XnxtlFjg+Hi83zH+aMuNwSAsCR5J1v2CrE4TOpKtfpjr/fgRpUP3EbDkdubUmWD2BjqSIjNoJUvfhxaAo5dfpQCSNDIpTssXg3CxUHbLv2LcX7mbbQYhgB2F8X4v3vjiiaDBTCEsPGbZy/WsdJVBGAg77Zps41sN1EV1sZXCGK2jWFPM+8UpuhxSy8pTnhTsl5VSMQOoDHuiedYxhub8XbHexLycSWMvEuk4p9JBmV/s2zOJBtYxxEPZRzeFwYrq97Om7zLhnRTYzkGxVreDoo1oZ+rn0J+vlq8hWx3g/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SFMT1BeEYXXQLjYb56cJKqvplcBjSbjF7Klpq8/iCw=;
 b=R8xTm8Lhx84cEhDVvX/A4bGVexu2Q/42tZYnZRLHBsJ47JyxQp1+CjvhbcTCFnxOMUkTBOVn/gHwsl2lHLz5NrcBeKjt2yhCnECg3l+2ki9UXt7afcJ67RG2Gpsztbed1aN5awjY2FMI0Xl6Wkr3IEfGh3CmIe1yVr7iOFFZgsm7pFCQ+N8DZ5R0I7rdcP0Fna0jyegxv6bMvvx1iKE8cjdm+zN3StdGtsQ7ws89W5M86qPLNGMJr+bsqOFjrH+GewhRWWb0SlmXf0exmodOvMsRCDWp+fqsY8wlY3Fq0hBYMY4QJN39We0wa1cI7WuHNseq5WxDzL0SFp2K+HQVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SFMT1BeEYXXQLjYb56cJKqvplcBjSbjF7Klpq8/iCw=;
 b=RgD9DkVpcfs0mHfqkhMZ6f77LuT1AiuvC9/34j7lelwhXQHzlqUt55DJo+OyocMceOVWtschC6KYDM305lCbfmi+Vk2mp/G+ydNfcrPrh7LGi62sjBV9T+dfk5fYVRBayPrpTZ4DVQdjxtmzJV3FOcllLS/1jxK2BTVs7EP7K2Q2OUHNaOyMd23b1fRS64vJuwFlFpgwO9Ylfz12AC8jxHVIN8N5WW0DNVK+n2WF7nAnzw/ce7kx2Q/7s9278ZC2ILBk4ornihpbSWj4LAkOODC0bBPgh2Y+5vuOD+Cj6ujlo5ekJfFzf8XYAd2dcPPYMGaI1zvpOO7vw1offqtfjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8392.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 26 Jun
 2025 13:45:06 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8880.021; Thu, 26 Jun 2025
 13:45:06 +0000
Message-ID: <7f64c1bf-ae54-4bb0-b85d-d2a369596993@efficios.com>
Date: Thu, 26 Jun 2025 09:45:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Introduce simple hazard pointers for lockdep
To: Christoph Hellwig <hch@infradead.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Breno Leitao <leitao@debian.org>, aeh@meta.com, netdev@vger.kernel.org,
 edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
 Erik Lundgren <elundgren@meta.com>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <aFvl96hO03K1gd2m@infradead.org> <aFwC-dvuyYRYSWpY@Mac.home>
 <aF0eEfoWVCyoIAgx@infradead.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aF0eEfoWVCyoIAgx@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: b69926f0-81a9-4f53-ba7e-08ddb4b7a8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGRqczhvRVZNQXhUVEFlQnpDdVE5ZkVsNm1ySU9PQXYwZ0wzUmI5L0ZUZ1M5?=
 =?utf-8?B?SFhwUmx5N0R6RWx4N0RwOXJVc01TVVZlYkF5a2o1cDdadEhiS2NrOWhVWkdU?=
 =?utf-8?B?TUFtRTBOSzNmNnBnNXMrdkpRL09naERmaC9NZWVsM0VQdXRkU3VLcm5VeHRn?=
 =?utf-8?B?ejNtOTRweVZibzlFR24vaUt1UitLNEpPSTJGY2lUM3o1UmN6bjNONWtLVTJ5?=
 =?utf-8?B?Tk5IZFN6R2dFTjlnY0tlNk9vS1p6NkU1VlZGUzJoZEo1TnB3L0pGK3pXMUU5?=
 =?utf-8?B?QXZhVTVtQ1lkSXVkL203ZGdtdndhUjBnQUowaDV2dFRFbmJjc2xMVTcrUTlK?=
 =?utf-8?B?clAxeTdBeWVzWkpDYlRVMnYwMFlNYmhlZnhNdFErK1ZidzNycFppSzhXamxL?=
 =?utf-8?B?Um55YTdHakVCU1F4Vm5udm9UUk95RTRHRmZnaVZKeG4rS0xwVDJHM09QY0pO?=
 =?utf-8?B?cm5xamR1cTZuMHd0MThjdFlNd3dhN3R5ZFpESEE0K1NBS1RNR3BBTlorZVBu?=
 =?utf-8?B?cTh2R3hOeEkxWHQwa3JSYTVrdFR0Yy9XVFdtdWYrcmJLN09Ya1hOK2Y2MWlG?=
 =?utf-8?B?RWRBUFgrYVo4SjFEME1xeHl2WkFVVlJzeUVVSGV6bFdUOTNpTTJMMGNZMGpO?=
 =?utf-8?B?YVBEN3l4WUh4dWVzZjJjWllDMEJIMTJ3ZmtrMjgxNEk4aUVqaUlXUkU4RzRx?=
 =?utf-8?B?UkZ3SGduSU50Z21sandhVEJHczBjbjRpa3VnS1Z3S05hd1hiaktNaUdUbE1z?=
 =?utf-8?B?c0l3ejBwM1BLajRjTmFnajJ1aGF1V0RWaUgyemRNdGxuRXQwbVNUYlZ0SFFy?=
 =?utf-8?B?ZEhJaU1wMTJPZDAzWlNDKzMxTnlNNHR5ZXdOSXp5eGZKR0RCQUVoVGlQSjFz?=
 =?utf-8?B?MWxVZXcyZkQ0YVJxT05Jbk9yakVnRCtuc0Fkbk85RFF4b0lxSlQreXhnd1Bs?=
 =?utf-8?B?UEZ6clkxZTBHMWI2WnBFZlRrV0U5OXVoT2w0QW1laUhQeDNZQk5KQkxxaUVl?=
 =?utf-8?B?RWp4SllqaGx2eHF6WStTc3dGdDYyU1N5ekQybWJ0QzdKdEx3TEw0eGZyc2Nl?=
 =?utf-8?B?L3Y2Tkg5Zys1YzZTQXNqazF5bGdHSlpNaVhrOUEreFRoVUN6SzlIWWliSVJl?=
 =?utf-8?B?N2pvNXZNY0hPUGY4dVZ1NHo5UnR5YXFDM1QwZGdyQ0ZEQ0FPV0lGNUVLSlp3?=
 =?utf-8?B?WUZXbVJaMTJHY25qbitjcm5CZHFJRU5vTDdBeUpPZWJIUGRFWWJXTFRJK1N3?=
 =?utf-8?B?alRtWnZqNzZNVGk3U0w2Nk1JemxNVlg4WWYxV3hkcFhXTlZJZndPVzErcE1Z?=
 =?utf-8?B?QnR2Y09KQ3k0M2EyZVZibnlnMXdhWmlJNVFETzk2NlowODVUeTlMTzRsTzVF?=
 =?utf-8?B?SjZQbk53MzRuUlMrNWZjZ3lSQXpMRmpvd3FqSXJPL0NUODlpS1FPU29jU093?=
 =?utf-8?B?R05SUjRkS3d5SFd2T0Nwbk5OL2dMTFZSL3VRczRQVWxKcCtMWmZ6SUY3MzBj?=
 =?utf-8?B?R2VWd3ZsbEdyNEJ0eXNSeGRzS3dGQ2IydEtQMHI3bG1EYTdUdXAyQUZVMVUw?=
 =?utf-8?B?bVN1akt4Z0pyOHNNUlMvdE5WNXlLQ09oaU5IcWF5TjNxWTE3RUtGeCtiWHUv?=
 =?utf-8?B?UXBQdnlmSVduZmZtY1pUQkFsL3pqakltcWdLd3hmZXAxeXgxOUZGbG9RMGh0?=
 =?utf-8?B?aUxlaHp4Q3NrQkxtWlBDVWZ4VlIrcUlDZitQQzFkL1diZFVuTjYvTUMvNVZ3?=
 =?utf-8?B?eEV6YTlCd2Nhd2tBb002VTBGdE9zRi9LWUdKaDJvYWphRm1xTFRrTm5yenJL?=
 =?utf-8?Q?rZEP2/8089aXwjonJVOaOdAT6bT3p79AaISY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnhHT1VTOURYTTZMQ2xDQVZTKy9uQ2h0TzlkUUVTcGtWN1dWSFFySU4zWThL?=
 =?utf-8?B?RDhGZ0xEN01Lc3FoUTVnVFlMVjZmd0ZuekkrdGg4RzZEaTRoSXdMb3YxeEY0?=
 =?utf-8?B?T2lOUzFBT3BKcE1BVTNycjdpc2lNOHRTeDBnSzhNSENyU1I4Sm8zZFFldDd6?=
 =?utf-8?B?MjlrSXVWTFRKN1FtYWZuVUg2Qlk0cG1iamtIYm5kNlQ4TDFNdytxeGRuTlhH?=
 =?utf-8?B?bEc1eVdNdk9VMnlsYWMveE5HRE53dytzWmU1WG8vVjlaYjlNOEJsc3g5aGFY?=
 =?utf-8?B?QW53aG5pdVZPc2pKV0x3U21xTVFhbElsUXlSQTVtbWVJUmx0R1lUbm1hZVh4?=
 =?utf-8?B?YW5haEIvV2tCTVBOM2RHTklGWldUV1VlRitaZmFFclZqM2pxVkVBbFpBcVd0?=
 =?utf-8?B?UHRoVlZvK1EwSkUrR3M5NFJHMkhyamw3a05CS3VmVk45TEYxaHp3OFJHNmw5?=
 =?utf-8?B?ZzZYcEpiSy9SUE1WL1llRThNRUNhK0tvaU1ZaEhZOS9TcmdrRW1uZ0o4SVRX?=
 =?utf-8?B?NCswRStrclNGZWs5RUNUZDF6ZitENkxBM3RQd3FLQlpjMHpIT1JMY0NPS3Fl?=
 =?utf-8?B?SFo1aFBpNUN0djZ5QVo4ZGVGVE45cDcweTlIczNzY1Nrcy9sS1ZTcS9xRjZI?=
 =?utf-8?B?WDZOQjhkeHRreEZEenlUbFBiY2xyMDZxeHFzUUVpWVJQTXFWYVNCNXBDU2dW?=
 =?utf-8?B?RXFVNkhJZjB2UnhwaWh6WnpVWnBpa3pQb3BmMlVnS0dvWkVHSDRZdDFkR3Rr?=
 =?utf-8?B?MGJJbW5Ub2wzNTBTeFc1ZEYrdkQzWUp5S1ZRcUEyK1FLeEoyZHQ0NXlQM0dQ?=
 =?utf-8?B?OUFaL3gyVUNSTWZkUlFWdVdSa3VMZDd0YkxYT2FpSGJYZFZVRGc4TlYyRXZ2?=
 =?utf-8?B?WU1sbHFsTkJuek9NTHJGeEZ1YXdaTUVXQTc0a0tNcEFBL1V6SFVoTEVST3cz?=
 =?utf-8?B?eHdYYjY3ZjlXVzQxMGIzTGN2dkVya1BSU05RVVBNMWN6aWErNUtZNURsTDlC?=
 =?utf-8?B?ZTYrdnFLeE1RUnlwaWZ4K0YwellxWnJ5b3cvNU9uSFloK3IxVHN3dTMyUlBN?=
 =?utf-8?B?N05YeEQwQjdtNzZFOEN5eGdZMHRIUkZoNnFXUXB6cFR6dkdtUDNGL3J2Vms5?=
 =?utf-8?B?NUgyU0wxTEZpblh0MXprTjU5K3VKREJJRXJ4S21hcGg2NXJhNTF1QWJGRU1C?=
 =?utf-8?B?TXhiMmpseGRGVWVqeTVyTi9qVnBXUytxNUdUMTVBWUxzYVl0azFyL1lSTW9I?=
 =?utf-8?B?V3VPWWxreTFuSlFJSFU0QnN3NTIwT1dSRjJyTkM0QzEyUnJpbzArbVpxK1pT?=
 =?utf-8?B?MVJYbkpFYTlYT2IrcTljQzJBYlk1SW9mZ3BmZHdSaCtSVEdJWXN3UURndXZx?=
 =?utf-8?B?MDduLzZKS0NxNCtaWHFIUWh2WUQ4UktpMmVHRElWY0hkZXBBK3BPUmRsQmMy?=
 =?utf-8?B?ZWZoR1RsMDdnUy9TdTgyTzJkTEwrS3I4TURaTWQ5ZERxK1luK3l0MEl0WUZu?=
 =?utf-8?B?eU4zazFvUWxQckxrN0ZhS2JLWGJJdXJBcjVhajJ2L0srNjZ3Y21vTTFPa2hM?=
 =?utf-8?B?V1l5SHJvdFJtSHlWajNFUmhBWTZNR3JzeEdUcWxqRzNKTktrSEIvK24zOWsz?=
 =?utf-8?B?bjBpWXFxV1pLVlVkNEIxRU5PMnozOVVNbU1RZlNUZzdEOXZLMFVuQVYrbmJK?=
 =?utf-8?B?SzkrQ0FFamswMnJXbEsrRElOMWsyZVVvMWhMUVVmeHlqdHRhQWFCL3pOV25H?=
 =?utf-8?B?Z1R0TytDaUM4bWhtWDJwWU5admdkdHUvVGtTOHVOTkZqYXByUGFkZVlCaTNn?=
 =?utf-8?B?Q0pnZEhjaVlJQ3BqT2Y5YTR3MXd0UGlBbGp3UWdNRzZ1bWptQm1zck5tTTZT?=
 =?utf-8?B?MTUrWTQxTFl4d2dOSW5mbzZMY3BEOHNOVEY1RzVPb0dkaXlxNTRLY1NrWnFh?=
 =?utf-8?B?MVhHSi9rT3lEVzFvV2lsQ1FxaDkzWHhuMnZReE9OUC8xVVNkTmIzNmhUMXlR?=
 =?utf-8?B?bzUrdmtheE91bGxUUHg1R216VlR5dnNWcG11R2lBRmxSRkJxN2kzQW9VMnRH?=
 =?utf-8?B?RC9QR3ROOWRyU0dIZmNlM3BlTm1ON3hBZHd4NHBCMW5lNEgxYUovZ3VzRDFY?=
 =?utf-8?B?RnVJR004TENJc2d6OEM1N0Y5VkJnbDh2amdxUlRKQlRTL3J3U3hkTVVkUzlw?=
 =?utf-8?Q?b+7ZKki5dFQuZhEHfsKA7EQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69926f0-81a9-4f53-ba7e-08ddb4b7a8b2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:45:05.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDP+7VH84hST3V0CbOK0kdr2JlZdYol89Qm0NRR5LQZYtdDphsSRN+aJltM23bZOy6u0oH27H73aF4dFoOCZF1gIG3pS+0Su/2ieTgpCn5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8392

On 2025-06-26 06:16, Christoph Hellwig wrote:
> On Wed, Jun 25, 2025 at 07:08:57AM -0700, Boqun Feng wrote:
>> Sure, I will put one for the future version, here is the gist:
> 
> Thanks a lot!
> 
>> The updater's wait can finish immediately if no one is accessing 'a', in
>> other words it doesn't need to wait for reader 2.
> 
> So basically it is the RCU concept, but limited to protecting exactly
> one pointer update per critical section with no ability for the read
> to e.g. acquire a refcount on the objected pointed to by that pointer?

FWIW, hazard pointers can be chained with other existence guarantee
mechanisms. I've done prototypes that use hazard pointers chained
with a reference counter in the object to implement something similar to
smart pointers. Let me know if you are interested in the details.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

