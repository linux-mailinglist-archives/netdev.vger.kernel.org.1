Return-Path: <netdev+bounces-155548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB4BA02EF9
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440EB1620B6
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF51DF244;
	Mon,  6 Jan 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Vu18K8gt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2113.outbound.protection.outlook.com [40.107.243.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA41DEFDC;
	Mon,  6 Jan 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184633; cv=fail; b=qe4tYDbZT0R8MWOHu6HGNlX3ygWWMqkkZiy67YRi14Yq/7yVUDJ/cAkWG7GLg+e5uTOlgZCvu6BEHxa2jvcQydcuhvCUbL0Thr639/bRht6+8O/52nA9bbuyiMrHsoRdmbDUbSfUnWGFYcXx53gp3FWnjVx4x/ohp+uHVqnRtbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184633; c=relaxed/simple;
	bh=B23pzKEBVwHEQ9fz+wPPNoXhtnPX6DkdYi+YTwlkfe4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tLGOpyksFxj9kD7JZqzK/8T0k8UEznTzpa851Q2qlRr43ajSW6jxIFO+TVBSfXqUIEzxXPJqHadcS0o/SeUist3kkaJAxeYPdwz/uA59V3X4YcuqdkpVej68yKDGq7ShVxekwLtH2j+P5OQj1g3iaq4tu4mDgS6b2e2HqGYTlIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Vu18K8gt reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.243.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atMG5SCTS/xct1jd+S7Y31DXJrW5P9/apsvNcdmGX+RiJelSexoKezhuCmpAenAnnZj0cC05IHmLPayAGpbPROzYiQiLxTxG4dlGWmF8QyQ58wmfnXlt6vJuyxDmePaGY4kB8VX91lvZzbqopLV6bKnBfumNvCo5DsrIzWsE9fz5Le+4puwSlLADlZBAWLfYYimavwdPM4L9hEfoX3VCu9yMauUdFYSP4+ceEGQyzJUSQbNL3DlMgcEpn/dWeTLwJwK7ufgzhFeD1J3Y9WgyGNBXQIYPFTcM3X3jNsvacUgt3LQTpqi+m4b3Wf1n7UAbg9nb5jmGJbRtI8K0pAtFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6Lh1X2JeO7tiwnFFOR4eAmWW7Zb0WRcEGPDK4KbyxQ=;
 b=vNQmSPid9m+jcjs8UEgKBXF92nK3MXkkCFfISGMSxPnDD7Ha79zVoaF2GSi9F/UHYdEjjr5OofWcFYo53IIfeX1HBAOwg5Qcvy1fEdQ4gO9hmYDcOONDH/wFGL6wKMoG7p/vCiLoT2Wea9ezlWiu8qs1F1PG9sSNz5iY6QalFmiFHdOFg9891QKXFzU0fLiP5i2HjF63xaHq43w0m5oj86a1ilLoxdc4Sv31WQWx8nhSQj4Up2B+4Hfk6HVHtVGwbJFiCso/cS+LaR5ETXpuiavjBaSzjNJK+Mb7ZTAdfoTiDF8oabirXRWb0b2zfFiFbA8hOzaKxG2jIJQCRZ2wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6Lh1X2JeO7tiwnFFOR4eAmWW7Zb0WRcEGPDK4KbyxQ=;
 b=Vu18K8gtbQYy75vlUa/7n4AWXpaS+cvdpp1Z/rL+p2Z42g36hOqZJBwwPIHRQRfHY6/aUU8SIbyJ0ZSIlxFkwSnetM3h9T1JAcrYJRgFv67VZTimjuf/qNaVbAd/Hh6SauUd/YtYV24+Ztof4rotWx6gD4obYeU/fhVnBAz886E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 BY3PR01MB6545.prod.exchangelabs.com (2603:10b6:a03:369::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.5; Mon, 6 Jan 2025 17:30:22 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8335.007; Mon, 6 Jan 2025
 17:30:22 +0000
Message-ID: <b5fa6fa9-8e59-404a-9604-18568d3c5ed8@amperemail.onmicrosoft.com>
Date: Mon, 6 Jan 2025 12:30:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/1] MCTP Over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250104035430.625147-1-admiyo@os.amperecomputing.com>
 <e4c5b40a906a560f9a333d8e9d7c556ad99d63fa.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <e4c5b40a906a560f9a333d8e9d7c556ad99d63fa.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:32d::9) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|BY3PR01MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: c31164af-f235-4a60-6a43-08dd2e77cc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHR3U3hSVUJXMWdkTFNLeS9OMyszazZ2Uy8rYW1zbFdhdXk0cE95U3dQTWJK?=
 =?utf-8?B?UWVSeWhXdzBPcFE1NERjZXg2YW01eUg0aXZMZVZCOUZhdnZZdWFKZGpDaVFl?=
 =?utf-8?B?aElOdjNnTnpwK3RmUUR1ZEJ0UDFHTSs5ejF4Z2dnNmdnc0VIelFLZS9qU2Uz?=
 =?utf-8?B?SzBBWWV3Nmg2d3I3dXh2ZytIN3JTcU5DK0xpci9vV3VEWlZGSmF6VThvcnpN?=
 =?utf-8?B?Y3pmVGYxSWluUU8xcDRIOW5aQU1XanMrMGFXbGs4UkgwTG8vZ0hDcFJxLzlD?=
 =?utf-8?B?TFZzS091Mm1iY0pRWW5TTmtYZm55RjZXejBadHUxWUxmNUFTc0lpSUxJQ2xp?=
 =?utf-8?B?YkNiTS93ZHdJNDhkMVRxaEZUNkhWOEFMQUR5bklCZ3NtdjZETmUwTXYyVHJK?=
 =?utf-8?B?NTI5MTlnY0FyNHhUeVYyczJKV3luUDVrVmpNTGcrQmo0S2FNUkIwK1ZHQ0pz?=
 =?utf-8?B?T0RZZ1NsTDdRcGI0b3owZXhiaE83Y2ZOMnFIYjVEZ0F5MGpHYW53QVhFeFBU?=
 =?utf-8?B?M2hUNktvZWRNaFN1YTNSajlpWWpYeDlzMnYzVnBReVpObWxhSzVpb0hONzh4?=
 =?utf-8?B?SVFjZlI5UDFPNEE3Z3JaS2U4NVdSaHhxaW15YXRuSHlxQ1hkVkRnZk5LRmRD?=
 =?utf-8?B?SG04OTk2M0FCZHF3dFdIZ2wwL0N0cDdoa2c5OXFxL0IzODcrYVZwUmNLWHlp?=
 =?utf-8?B?bzdvWE82ZUJ3dlZxb3o1VHVTd1F4V0R1OU9qd0hrZmwvcFZpOGg3eDRxVG1N?=
 =?utf-8?B?cCtnVlJkdzJhcUZENE4wcXQ0bEFEN0g3YUg0SWM2Q1pMMUZybnpQYk84Y2J4?=
 =?utf-8?B?MkhJeTI0NFJiYnUrNHRpUlhNU3EzbHA4ejJENnFTUDdSNUFFT09aQzI2R0ZU?=
 =?utf-8?B?eUhsaWpubWZHd0NDTytpOFNhcGE2aUJTVXVxQk51V0hsZXFHK3pUMzgrOXdp?=
 =?utf-8?B?eE5CbUszOUpISit6VkVieDBCN01NREs2QklOa0xxRDZVY2NGSXM5NDBOU2s2?=
 =?utf-8?B?R0dNZ21FZUJISEM0dldPYTJuU3BXSjNxREtxbXlJZ3Q0VTJUYmhzOFk5K1pl?=
 =?utf-8?B?ZzVyc1IyZG9wSHZmYWovVXVtaXRHclRUWVkzZWM1WGRhL1crYUN1c3haNk5Q?=
 =?utf-8?B?SEpZQ0RDK2VXc1FhMTN5YVRJWDJyd2dxODhBWGZWQ05rYWdJQWxmeC9vRnVO?=
 =?utf-8?B?YmZKKzh2a0ZmWjJ4UVFGaUJXbGkwWVBlRm43ZkR5d2trcS95L0N6dFBoQ0J5?=
 =?utf-8?B?amtJRHp3OW55bHR3ZStEWVB6bitiZmtuVDVXc2NTa0FqM0Fxd0k2NERvdjc5?=
 =?utf-8?B?U2lJeERVRm1sSGdDdDh3ZGRidjFMQ1g3ZSsxc1hwNVhDNHFNSkw3WUwrbDJo?=
 =?utf-8?B?ZjhHeW54ZTNYR3Q1TWY5Q2Q5bmpZNUEzWlNiS2gwdjY5SzdKN0FvVGpBNWIy?=
 =?utf-8?B?Qk1idFFCTW1wZkNkaVpPMHZSNUJqbU00NDBhbDFObG10WXVOK3prdlBoOS90?=
 =?utf-8?B?eTE0WHBnK0FlUmEyZUJaSW40MzZicGEyQ1JKNlc3NHBlK2Y0SEE3bWFIazZu?=
 =?utf-8?B?bHhsTk9yS29CREVEWE9FUm5UdlZSUlViNUpucEsvU3I1b2JoQ3ZYVEpvTTFK?=
 =?utf-8?B?aUs5alpHbGkwQldmZS92U1VZQWdObDNnNWJBcldxakJzWExLRTB3UkVlZEdq?=
 =?utf-8?B?RGh3VVVkdThGVmN0RXVNZWg2MGdkNXRpN3JhMTFka25ISENpWlNOTWtlVEZz?=
 =?utf-8?B?QVRXdlVHQXJWVzE5K2p0NWc1ZEhXdU9pMlQ2M3NFUjB0ZlNQVjY2clFzYXJ3?=
 =?utf-8?B?Si9WVXM2RFlPZ1hwKzAzcDVFME9PZDEzUE9aalFCZHhWMzNaTXhKNzdReUVv?=
 =?utf-8?Q?079+wJhL9+W2Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmltY2xiNHR4VEphLzBscVRBZ1lDNnRCREtCdVBEblJwRkJHZ1dmRE5wN1Vq?=
 =?utf-8?B?cnZXQXJRSUhCYTlmbnpXRFl2Rkc2ZnJpQndERVBYK3l5YUxRdWJUemt2NUZi?=
 =?utf-8?B?WUtIUXRUektwSnR1QUc4ZTAzcjhSU1lSd2c2Q1owQWY1UkVvTHREcjNhVlFx?=
 =?utf-8?B?N0dmSmNvNForR3MrZWdiOW9nZmJENWVSMTdZSzhJdkpBVEo5NWtqYnkydkQ2?=
 =?utf-8?B?MXRFL281YXJ1Z1h1TVhFMm5mdjZlbXRwcXFORmR3d0Y3b28rQ0FES0drQzk5?=
 =?utf-8?B?UXFzUDdYYlh4NmtBWjdoZUw3YURaSTRwbkhQNWNUanoySlpITnFNS1BRUnFF?=
 =?utf-8?B?WXlVTmlhdkV3L0x5UE9laVF6cWdVUnR4MUFURnVJT3BqbU55bmszSnNUVHpR?=
 =?utf-8?B?cWl5MXlUQUpKQis3TVg1WGhsaW8vYVhmc1VYOEhFUk5sT01meW9UZjFES2gz?=
 =?utf-8?B?Yld0SGdnVWxZeG94c0ROaGlySk9nRFQxNkY4OC92NFQweHNxOTlOS1o0VkVy?=
 =?utf-8?B?L0puMlJOam9vV2R6MFg5TTF3TGVkalJhcllJWlB3UXpiZGpwWUNaSlBaOGJC?=
 =?utf-8?B?QVpZR0lqYnhqZVViQnlmRW01S04xQitLRng0MkxIdXZJcG56aGM1QzlwRU5G?=
 =?utf-8?B?M29IdVNBWC9COFF5UWdMTi9UcDd3ZjMrS0t1MVJKZ1Vmb0M4NkVDTDd4VzNz?=
 =?utf-8?B?MXBhYWFucWd0eXQwenZpakNMMk4yNmZZbnBoWDB6dG5ubERoZWw2d2lZMmRy?=
 =?utf-8?B?RmQ0MTQ1SG9Mb1JCYjBNazNHS2FrS0R2Vk93R2pXVHN1d3g0endtV2tNWmRL?=
 =?utf-8?B?QUJDYk5oUXg5QWxKejdFUDFUdWJReEFSR0F0QmJJS3F3Rkc3M0pmMENrblMx?=
 =?utf-8?B?dnZaU3F2RWptN3B5RU1ycGRjbzdMcWNZejJUUytIOTkzZDJaV0Fwb3BxbmFr?=
 =?utf-8?B?Q1ZZMysraU8yaGpPenVqRElMSGUvajhNTTg4VW9GZHNHcVNIczduOHBPbnk2?=
 =?utf-8?B?Qit1OGFhS1A2R2YyWXZVYllOWHVlUWZxaHBFNE9sV21KOXFIeVMrV1UvdXNt?=
 =?utf-8?B?aWZqeWtFZXpvVWhzeGVneWZ5L0Q0WnZ2SmhMeENTa2U3VXdhckVyQW5Sc2dH?=
 =?utf-8?B?cHQ2RVhBQ0pNR1RqdjZlVnE2ZmVrWTlqNncvMzNVYmxGWWRrVTBDWU1zMjVK?=
 =?utf-8?B?ZmtUUGFybklFUlA5bk5rdGUvT3FIMFlKMkhydFZJWkJvNFU4TXNpMEdIdFlN?=
 =?utf-8?B?SU53UHhxMzBZYnkrWmYwZEdQRVhnMmJ0b3prMk9pcm9NZ0tmWUpKVmphM01n?=
 =?utf-8?B?S09adDVPN3BFN0VOU0RpWU4ycStsZnpGZUJTVVBDZDJwQ3MreDJnSXZhdXdD?=
 =?utf-8?B?M29pRHZEd1I5UjVuWmNVd1MzQjJvQ3kvZ2p3c0FBMmFRTDduTG9uY2IvT1d2?=
 =?utf-8?B?R0VLajlWQ2RRemdFQXF0Z1VrMFRydTlXK1A5N3lnSW5zZWx6U0pwd3NaYTZF?=
 =?utf-8?B?TXdjSU5RakU1cVU3WGtLTC9HTDFsdHVWeGtmQTZOR2NaM3ZSemJGcjUwRUgz?=
 =?utf-8?B?YnV6ai9uYVF5ZXB0NFJDQlRJL0tabk9jVkVUdVZOdkdIZnFZcDZnaHZMZ1Jj?=
 =?utf-8?B?Ym45bG1UaTNwTDdmV1llbERTdEhrdFk3bjZEWkZSa3kwNVRNaEJKQURzM2Na?=
 =?utf-8?B?dlpqaUZFanJrY2ZLTVFQbTdqVG5PMkFJRHlMSUVpblFHSC9jRXdqOXBsQXNa?=
 =?utf-8?B?clNNYWF2M2lxZjdkVFRZdTNIUlU4SkNXZDdFTTBYdUtsZGRZZnFEK3pFSkcy?=
 =?utf-8?B?ajVYSlprSFplNTlXM25TQVZ2V21wWWw1VDV4MXpLczZXVy9oZWZ5NUFPZnI1?=
 =?utf-8?B?TkZ0SFpjOW5HR0lFR2dCcVdDTkJPWEhDS1gwVWs2WkFlUkorS0lDN2JsQTBq?=
 =?utf-8?B?Q3pGeHRpWllpWkI0cDBnanBTcU9nYksvcVp1MytTbks2VHZkYkJsNlVRK2Vx?=
 =?utf-8?B?MXNBQmFQdis4NExzMXZib0lHRWcrMmhzbWluS3hxVDVYSjJEUFB1UGlNWStn?=
 =?utf-8?B?eWZJQWk1dVgzTlNwZTc0SnJac2w0bnovMkNJSWl6eTdKSEw0dWVJQ3hWOGxz?=
 =?utf-8?B?bmNWWjdhV1dLMUM0T0NQOHFkd1RnM2tkQkZpV09uUDYzM0tsSlduMDVxVkR5?=
 =?utf-8?B?SWd0Sk5xdkFxRTFQOHpGdi9Wbnp3YTFsY3hTZ0RTUVQ1VU1EMXQ3QVlxc2lN?=
 =?utf-8?Q?1RS8hNQ3bsA2Cl9JBa8XA9iVYehegIfng1g5uUCC6E=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31164af-f235-4a60-6a43-08dd2e77cc74
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 17:30:22.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/Je3Z3GBQofObSyd8qs4qAooOSJw2EsCQCQ7AKi6hfH+jlnrpoZK/NOU/MIBCkgxO5hrnC+zHLMLRfzSxwQIsDau5KRGB423Op/qZ+V52zusbsrHz3gMWvCsxMFCAyb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6545

I had a side channel discussion with the spec writer and that is in 
keeping with what he says as well.  V12 to be posted shortly.

Should I move more of the cover letter information in to the commit message?

On 1/5/25 20:05, Jeremy Kerr wrote:
> Hi Adam,
>> Changes in V11:
>> - Switch Big Endian data types to machine local for PCC header
> This seems suspicious; the concept of "machine local" may not be
> consistent between channel endpoints (ie, system firmware and this
> driver). Looking at DSP0292, and the PCC channel spec, it looks like
> these should be explicitly little-endian, no?
>
> The warnings you were seeing in v10 seemed to be an issue of direct
> accesses to the __be32 types in struct mctp_pcc_hdr - ie., without
> be32_to_cpu() accessors. If you keep the endian-annotated types (but
> __le32 instead), and use the appropriate le32_to_cpu() accessors, that
> should address those warnings, while keeping the driver endian-safe.
>
> Cheers,
>
>
> Jeremy
>

