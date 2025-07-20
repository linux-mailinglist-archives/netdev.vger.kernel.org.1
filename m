Return-Path: <netdev+bounces-208426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1BB0B5A4
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E083BD6BA
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815371E834C;
	Sun, 20 Jul 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NY7+cE5S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006D35971
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753011766; cv=fail; b=CD6ZOeygnkpA0R1B7ZW6wI1Ty9YNMzUoGAWNKSjw0RiEshXfNwjtFirzGpTNPVTdeQxejO9RtSUZKOd+Z0JsqPqDW/Q+n02+SvSIqzCYT0+tJ2GLDKEks6c3N7yLfifjXkwGOlaqLvo9/HPfCa4MyPMKqdQjfkhDm/GWbL0iTAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753011766; c=relaxed/simple;
	bh=5YD6lkOVA1Wv6Js8rvaAJnMkxZE1PIaghMVXHlvkzgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kGjCOo7VyackYZGzXXrMPddV07xbw6pbZmOSm7GWY98hjEg4S8/LtqM31PLO0i5AR/LC9GTv8gpuuHzbQZtLCXCeMIxShfhVuPtVlH5Q1Ej8VIFIom6A626IU/WNizSQ9d/cYFtfOH8qbT1s1vPFaPWrdII/BP6Td4xuevevSFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NY7+cE5S; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgKe2teSkRrrM2GsxgVaIi2t7jlKLHw0T68BlEGvEIpQHqeWX+5bJQsTWWFw7OKG3mkBIJIXz/c5rlgzcPY59D3yD55k8LarjoFi0vm2f9gdBkvBlaCpJFC7jDJ2XupBO5wDUKoZavGWYKJszIkBc33FxddE0EmaDX0Aw2p2Hw4ezVvphvXR1Ug/75vcAxaMlOtbr3YPoQznAzizj+vYaswbqqaYrLDyuoIMRcwDGN6UmkzH3adKmgJVjqj5FqXBaN3qPST5C/k8XHO0JD11AwcQH94cBrET8otBMNOM5etuiZBuKQ6hY5LGsFwnCKqmwXzzwD3EYKJlx1lNoKe2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA0eDBnKr2gDTZhuNQZoCA+9rGYe5XQYoKB/TAf2aR8=;
 b=ub8LDnj7DduUSLjuStCW73kmXl8b3iet5C7ay2XVyPCUgnOzPtOoYH/R6DVZBzH/6fLgyzVkQUsKqIAtiExcyWf3TPwmw8uwBYB8xnjlkSjLWv4y8lqSYRpFppNfOqwPtgQIAw04x4VqfEEiVx4gL+qwnW5Yep99iC4KE3oRKcKd+AEFwt4Um08AtTcp8x5IMY0DCjLPz+AqkmhA2VnfBFJ1rr8F+YlA2uF0Nyh4tQOP46sq6xBqVyP33qUHzEmhenGH5DIOLbRcLyUg8ds6xAhVgL4pqxLnG+xK0th57t3gM4IIDiuasNNh/IrKM74H7g5O5VzqFkDfhH6Zgow76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA0eDBnKr2gDTZhuNQZoCA+9rGYe5XQYoKB/TAf2aR8=;
 b=NY7+cE5S+6AxFSJhA+mIf//sxhgDpD4P/LXZlT0xgiU2ERrcEp4CEemRzbq66ejnpmDP7juy/Hra9GHS0QF+5rIeK88uGBK7BgNG1iLPDBqF+/4Ay/BM/dMGHsNZ9a2x8X23DHdHyOrp/ujx+0vxigkrsgFzELEAYC1GPYE9y8xOMkPnuoNUvtgHiJCyLc7u/ZVoFS6cjpSVaiMY74K6BXJpcd9HRdwFHJp9LfLweTUg48Nz6hKpNp1gMsKFLriveTetX3JdygT7CdOR/CtQGcvEed3KrzBzNP7kLq/X+Xs3crNdxYnw+VMPyytU+B4VnOSY3+9ZAifWkiQ6Uh8WGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Sun, 20 Jul
 2025 11:42:42 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 11:42:42 +0000
Message-ID: <70db339e-a60b-430c-bc8e-f226decb44f7@nvidia.com>
Date: Sun, 20 Jul 2025 14:42:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/8] ethtool: rss: support creating contexts via
 Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 ecree.xilinx@gmail.com
References: <20250717234343.2328602-1-kuba@kernel.org>
 <20250717234343.2328602-7-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250717234343.2328602-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0a2140-273e-4074-d30f-08ddc782894e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWMza0VJdENhUjR2SUlqWEN3T3liSHpPcXMrS214c1dWYmRScmh6RGl2c0lt?=
 =?utf-8?B?dStlVjlLNHNSanlyVlBIUTFRWmxTeld6SHM0MDM5TFB5WmJkQVh6dlpta3pZ?=
 =?utf-8?B?c3RnYXBDQWxRVC9pd3FxamQwSENVNWw4M0tXM0RMbFBlRmwwL2RLTXVjN3Bo?=
 =?utf-8?B?Mit2NGpRb0F5b0I1L0U5WlJlTHJQSWpleERyOGs5eElMU0daWDZJNXB3UUhY?=
 =?utf-8?B?MlhnakRkZGtiK1haMjM3R2VRMG55VWk4QWRYT3pRazJvRmluMkM4bVViRlJ0?=
 =?utf-8?B?a2dxbEZvNDdJK1Nlelo2T1lxcm5WWkZLRTRFc0l2ZXgraFJQekdBMnhqVWFU?=
 =?utf-8?B?cWlDSllEeUNxZEdiU2QrZXJVdHlHOGpXUm5oNGRtakJyempXcVBlOFUvVjZn?=
 =?utf-8?B?V09pN24vS29qSEVpNFgzN2tlQWp0QnlETUtFSjhyN3hZblFBQTdDRzR0VklW?=
 =?utf-8?B?RTlqTHNQSHlLaDdwTDhncUkvYTQycldsNmk2ZWMvY0lXRVN6QmFpTTJUc05W?=
 =?utf-8?B?RThkS0RHbTI5RmRhQVo3RFhFbXpHMHU5cE81V20yYzFONzBRQ29Ia3AyT2tC?=
 =?utf-8?B?S01UajFaSHhITGZENkx1ekFlYlltSHJtM3A2KzUzNkRUSEx2RGY4MFlGS0E5?=
 =?utf-8?B?Q1ZiNVBmVGxHWGlHZGt6c2Fhc2M1UG42SlhaOVpiZS9MK2hHZC9mY2lPZWVW?=
 =?utf-8?B?ZGc2Ri82RXlGT245bloyWVJPOTN1TXg4bXE0ZmpteWk0VnM3VjJ0K0M0bTYz?=
 =?utf-8?B?MFB0ZjA1d0RDT1ROT291TE5Ud0dnZEd3YzZ5SDUzd0dTZmtsM1dJSlBOK3dP?=
 =?utf-8?B?TzdhUXZXMUIwSXdUQXcrK2VEUHUvTUwra0E0R1NoNjkxZ1JxOWdoMDVKbi92?=
 =?utf-8?B?RHZ1elE5bkR6eDNXN1NubzlrbzhrY0htWlRLRnE0YlIrbUZNcWV4YUNyTytX?=
 =?utf-8?B?UWo4dnkxYmtWZjJkMkg4dVcreHBVTytEUW1QSERJUk9HMVFLZVR5VHlqb1pM?=
 =?utf-8?B?OVUvNHYwTUxqTFI2Z28yMllCMW5wamp4cGJjMVJ3Z29RV09zVndNdUxuQ0hY?=
 =?utf-8?B?VVhSS0ROUzNjR1psU1RXN3JMejNQTVRKc0JTdnA4aGRtWWZyeThTanJrVVgr?=
 =?utf-8?B?aytSNndXY3NCRlZweTdYcmVCSnphNFh5TDA1VkxWS3VNcklhK3VnajA5c0gz?=
 =?utf-8?B?Rk1xVG12bWFIUzg1WmZmNjkrSGpuZWxXMWdaV1gyWUhtRjFBM0IxTzg4R00z?=
 =?utf-8?B?WjAvYzJnK0VENkwvNzJWckE1TVdFVTRyemoyV3ZSMXlnQzE1RTAvR0ViZ09h?=
 =?utf-8?B?VEtZVlVScUMxVFQ5WlpaZUpnMUY5Nmh0blg1V1dob2twc3NUSUkxUzF2d3ZH?=
 =?utf-8?B?R3lWQ3JsNmZPKzBjSjExVytRUDREMHlFNEsyTUNwZlRtTUcrSTNGY2F4alUy?=
 =?utf-8?B?Y29wTWFXNnI4ckNyMCtBN0t5WXZ6cDAvVWZZSmdVMjBYNUhjelRjZnFNdkNO?=
 =?utf-8?B?MVMxU0hKbzl6NENuOFBROE5CUW5PK0l0Y2VwOGxWdFc1bGdianNoL05FL0dq?=
 =?utf-8?B?Qzl5a29XOU1LY0QrQmdtMWNDejk3d1k3SysxK2h2TmMyVWRHQkRVZmordFZs?=
 =?utf-8?B?T3N0Rmx5elQxdDU1blV3YkpIOFJkZkRqQjcrRTVUQXNlMHJsKyt1Zzk2QWs5?=
 =?utf-8?B?SVNhcmZhbmFVYTUwTzNnTWswWFAvenNBUGlNcjRxRlR2TXZLY0k5TzlhUk1m?=
 =?utf-8?B?Rnh6clhSd09HdFdTdThLTVpoQW5RWkx3NTMvR3NUejBtcXZnejFzVlRjM214?=
 =?utf-8?B?Q3oyVjg3TzIzaXdIemNTL1lWVkRYZlVhOGVkWkRLK3JOa2pzVGlZQjZMdnpK?=
 =?utf-8?B?WXl6a1RNa0xVRVV6STRSTFZZYklNUnJxK0hXQkxFOWtXK3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anNXN3FWNjE2NTBiblR0MWpFaDJHaGI4Z1I1eER5YStSUzc2RmhqNGR3RDlT?=
 =?utf-8?B?MWxpTkp1cSsrMHpQT0lHMXJjQndVMTllNndvSW40U2pVM0tkRFBHMjR1WFgy?=
 =?utf-8?B?cmcrUlNqN0w2RVBDZ1UvS0txeXJBNVFpcHkyb2hrWTNsL2pzbldhR3hFcVd1?=
 =?utf-8?B?Zmk0UFpIb1IzemVnYk9LcnNGWEVhaFdhc1JiOVd2QUQ4M0tiYjFaZktGWGFw?=
 =?utf-8?B?ZXJUUUJ2M0JGOFBuTjltQzdKVTRoa1ZyRnd5MkJiNjlOVDh1VlNOV3dpL2hE?=
 =?utf-8?B?NytzdllXUkZadlJZby9Qa0dVYTlBam0yaVVibDlFZmpGRjhoNUZHd0NONzJj?=
 =?utf-8?B?bG55c3QwVkVsZE5tWVgrZ0tCd3kyUm1VNEMzTUJwMllLLy9xSDF3YWlFUUlZ?=
 =?utf-8?B?ZFR0NkdKdnJzK1FKWmZYTDVkUFdmNDV0OUJid1VRbFo1eUFkK1RKOC9Rc2pQ?=
 =?utf-8?B?ZWgxUzR2Szg0L2VZOXNzNjA3b00zQmlCVWtRd0RuVnNTNzdTakNFaXlUVGRW?=
 =?utf-8?B?QzRrMWFpR2dnMUk3SnIrREtWbzZHRXkzRlJ6TlZldzBDdWJtSFJGTWE2WnlM?=
 =?utf-8?B?ekhzR2VxcHBFRmlmYXdVOWk2RmQ5U25OVndSTEVENDI4Q0xaazJGTTlTdUZp?=
 =?utf-8?B?RXBiclczT2M0c3lyQU5Td2lpTDE5OEoveVUwYVpOTHAvaWxQNnMyeWNnTWdm?=
 =?utf-8?B?blRmNk1XM0VKUDNBczdGbjlad2E1ZFJHSEdlT0xNclhES1hpdnNRY0NsU2J2?=
 =?utf-8?B?dGNoMHhyb3FJUTVBN1hiNGpxMkRiNmVwY0d0S082NHNjVmJDRktPd2ErMXl0?=
 =?utf-8?B?Y0hVZVhZODdVT2hpaFlsa1lQMC9ZUjk0aGZacXJHUFY1VGsrTlcxOC9uU2Vk?=
 =?utf-8?B?eTVMT3FMelcxWUZYeTVoVWZyeVlIa3p0SGlpenh2YndBMVNTSGl4UHVDbUls?=
 =?utf-8?B?emtaNURnTUFxRHZXSGZJQ25Ic2NJdzF4MDVCaHdsV2Q4bjJIZUJyK0Rrd3gx?=
 =?utf-8?B?YXkzSGl5ZXVaV0VmVnlNN3V3VlVITmZlVUFDOXJQakUxRU5vVVlDaWpvWStv?=
 =?utf-8?B?ZkNFcTJnVVJqOVlhRHVzS3FCbWVDVWw0ekR3WnFQRHQ0TWxZQSs3K3ozWnU0?=
 =?utf-8?B?eVJKbnhOOU9pSzArRVpLNWRZbmo4N2Z2VVhROGNpaFN4TTFYdldVNGg0UXBJ?=
 =?utf-8?B?d25NY2YxOVovOEdpZ0NrODlNZ0lVUDB5MStkNVhDQjdvenp0cDJZVGEzUFhG?=
 =?utf-8?B?UHI5VWFFS1dvRFlwVUgrZVlEWWFXSzhPS0tWcHViOVhldk94eEhqNXlYOXlQ?=
 =?utf-8?B?TC8wR29xbk16cmkrSVBsY05JVkZObEpsK1M1SGZWbm5NZzRzbnlqZUdtRGJL?=
 =?utf-8?B?REwyNTNYc1hSZVRUZUJ0RndUekVXU241ckg4dmFCZ2MyTDM0ZHV5Zkl1cWxR?=
 =?utf-8?B?QjE1dnE5clI4Q2NVZis4aEsxdWIrWkNrTzJvUTdxUllUZWFFT2NmTC9jeGJu?=
 =?utf-8?B?Y3NORmFVTGNWSVZqWnJQSUs5eE1IaWFuY2dNZlp4VGZoRkovdHZiZHp4YVhE?=
 =?utf-8?B?YmtsaGFOVklDNTFaTVNmUUVhNUhxVHVyQzVDOVVuWWo2dGU0MmxmcFRGZUZC?=
 =?utf-8?B?UVNKM0lycGdPTzdKaXM5eDlKNlRSSXpnSlN0ME9iU3h4RW4wb3U2bGt5aklm?=
 =?utf-8?B?U0JBQURIOUN3YkQyVjF4M3RKOWtLSFpOMXVWSlB0VDBsVVpydEprS2FHWU5K?=
 =?utf-8?B?K3ZWVENDUm9TemRmYkQ4MG9PZnAxaG5pNjBOYlVtNXY3UDhXS0tOSFEzMDZs?=
 =?utf-8?B?VjlRTThhY1V1MTJIWTkrenpoeVl2V0JpeWxMZ2JJYnk1RGtLTG1RQ1pPbjZj?=
 =?utf-8?B?dmNoTzRRdlhTL2Z2S0NMSHlTQWJ6VUswcmg0cXVJS2lHOFFRNWRXUWh2Z1Jt?=
 =?utf-8?B?TUdMd3lSQXhUMGFCU0RHL29FbFp5MU9mNGpDT0VsVHViemx5TnBncC8yZzY3?=
 =?utf-8?B?ZlJ5MjJ2RTNkOXlXSS9pcFNybnBpRE5QY2RsRmdFV1E4cmRQSy9IQ2pOcVZh?=
 =?utf-8?B?OGs0WlUxQjh5SVFMcUQ2L21iL3FDRERNazF2aU43NkxKUVN1UE44eW53QmJO?=
 =?utf-8?Q?g5q8tRlWKJmZHS2A6EDVYj3IV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0a2140-273e-4074-d30f-08ddc782894e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 11:42:42.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fpvWeuF2MN5x60yL0NsvhI8qieUzPx4TMCzPpvFh/Vesy0T7HpnnuacdGiKft7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717

On 18/07/2025 2:43, Jakub Kicinski wrote:
> +Kernel response contents:
> +
> +=====================================  ======  ==============================
> +  ``ETHTOOL_A_RSS_HEADER``             nested  request header
> +  ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
> +=====================================  ======  ==============================
> +
> +Create an additional RSS context, if ``ETHTOOL_A_RSS_CONTEXT`` is not
> +specified kernel will allocate one automatically.

We don't support choosing the context id from userspace in ioctl flow, I
think it should be stated somewhere (at the least, in the commit message?).

