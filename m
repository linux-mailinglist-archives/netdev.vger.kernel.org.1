Return-Path: <netdev+bounces-248516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56D0D0A825
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C31E304A90B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A0B35A952;
	Fri,  9 Jan 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oDGf1b7X"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341935A95A
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966629; cv=fail; b=p1Gt25sgxTDZ/3SQuWr+1pl6iIGg+AYyV9BfbId8Y8AwUz4pbGzgSYZUoNE71V/PGgiY/XQ+nkSB3kwtx0jpMGeCboDiaEPvpUQRGQxkI+k9lkdP9U5m6gEkgpCmRc6Xydefl0LwpHan2iKKGgWyoBe0ExjQEqUnhhz7vS8rmeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966629; c=relaxed/simple;
	bh=a9X3W0OlBTIeAGxs8ZbEh/OgGxfe5beJAQVrYKDOrjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bFEV/e7uMYP6Cj9AhxDwtTpO/CjDOrYyEoUEqFv1j+LXJU2olOvzzm+06jF4pioR4DBg36ebc1DICE5mpXYgc6Y8a6ouLOGGC3IzTYWIISmmNLejVsPRzwn1qgStltj4bDyxF15F7VLIVxiEJrg0EXY6SfRcVh5T24ZIBECXn2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oDGf1b7X; arc=fail smtp.client-ip=40.107.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZGFdpCo3h5Py6ypj5UbE44TGJQ8en0QnDGl63pRK9YBbu01SH7jI1NnMbb1oAg1rZJFbhBGjdpeu21mwFg61XH5N3cTlI+YSKvIpXMLKnUiez1E/DcFr8rfhy5AaZEexVxD/DzTJEGuQgyo+HFblsfLGIlom81B0vTrLFHwSxLyL2JqgpyfArDBLvmP00GMTHw5mxA2vjxRRWNNZeVJoF1k7vchyocdWDvv/OAoMFNELkmRQf77i/EYKNuW+Vthovo24rc8kygcaskmzuOa2dGfZKQwfbX7U4PyaiJLHitKI8JGGX6q3YFu//JH2UggutvjOkXr3kva5vXMQV/lQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9X3W0OlBTIeAGxs8ZbEh/OgGxfe5beJAQVrYKDOrjQ=;
 b=DX2uQkZ7NyIVCugqc+lfVQ4JDBeHyDOBEd8G4uDkPocs88PKB9eRZBZs0hDXM2MTsFfs5qkL5b4Y/W739clr9HB1loTNikAkX1Can4KJVxQD+AxApi7WFEnddey2dnH47OzZoKa2qSpsnbs9p6dCa3zkDbH170BQW+psc/W0iEk0Hpa5t9Vq8SXba9I/f3sn4nW/TLRHfhB+g4RyztEgQzBC9e4yP/Z89N20oPI+GM9B3AM9KLx9+ypXu02nf0nxmWU9el5RDR1OKM7XeZHk1vAekGgQsX3M7MtB1dp4HF/OLwHdDrOUnDw5ohVaSjY8IzqYQIZS2M+HCj2dH/ZITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9X3W0OlBTIeAGxs8ZbEh/OgGxfe5beJAQVrYKDOrjQ=;
 b=oDGf1b7X/y3lL7ETLYzjCfY9txXAK7aoSHUBhs1CYUkHlVe13fzv+mt5OWueDsdMPviu58Ps+46TNmXsR+PnaAL81c/hj66KtzyGfbe9FyOhI4Q1K3FgBaHqlpskiDbErl97oXTBj9lhRAnoKrxAYWidIMZH4medkEVygmdzk9DCEipyYTqTD69CIVgBJUPb5tAAjG6Ffk3hMZ7jftwKRmth6Jg+kkT8KVMaoD2lEMqpt0pAqZJBHm4jKZSIrNNJFErDAj3MiYzl26AOYR7UWERmfoXy+iEXFKoQxeuzUWfOgGyRAwhoNA8vIWI4Sb20yzb6jIA1JcvqlbBzdhXe+g==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SJ1PR12MB6171.namprd12.prod.outlook.com
 (2603:10b6:a03:45a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 13:50:24 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 13:50:24 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Dragos Tatulea <dtatulea@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] macsec: Support VLAN-filtering lower devices
Thread-Topic: [PATCH net] macsec: Support VLAN-filtering lower devices
Thread-Index: AQHcf8MYq0aPKotsqky8aDx5Wvpp8LVJpWmAgAAUJACAAAe+gIAAHPgA
Date: Fri, 9 Jan 2026 13:50:24 +0000
Message-ID: <611d927472c46839ebe643bc05daa2321bd183b9.camel@nvidia.com>
References: <20260107104723.2750725-1-cratiu@nvidia.com>
	 <aWDX64mYvwI3EVo4@krikkit>
	 <5bbb83c9964515526b3d14a43bea492f20f3a0fa.camel@nvidia.com>
	 <aWDvTx9JUHzUKEGm@krikkit>
In-Reply-To: <aWDvTx9JUHzUKEGm@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SJ1PR12MB6171:EE_
x-ms-office365-filtering-correlation-id: 81406f8a-a6b6-402f-4c91-08de4f860a36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tzl3M2czNlhnZTVlY0czOXdXNmM2YmJnOC9WOXlVTlgzc1dnb3R2TVdXb3Ro?=
 =?utf-8?B?WUJhZ2R5MWIvNUoxUUtyZEhmbEdoQU1uaGROR3RRYm1FeE80R2xFVW12N2Uw?=
 =?utf-8?B?dTFGQXZNMWpKUVVXa2FvenRYUFVUbEZ4Y2RDMVk5dGIwYnl0L3dadnNQckg5?=
 =?utf-8?B?R29vWkxESEI0ZnBKeGQ2Z0ZuY1BjVDJJYkNkaDFLZkp1aXU1VDJyYmdSRndx?=
 =?utf-8?B?aGtmMmw0UW8zZjJIclNFcTg0ZWpQK205aDBlWTRZQ2FMam9Ub0lZR3ZoV1pj?=
 =?utf-8?B?QmRDWkh3OXFLR0VlcGRzL2VodHJNQmUrdGdDMEhOUWxrUy9FZnRpK01vZU9a?=
 =?utf-8?B?OXl0ZHI5enhIQUZNWSt0eGYvY0VuZkJvaEwwQnhSbXZYUXVidHkwaDZpQVor?=
 =?utf-8?B?dEtQZVEvTzdEYko5dHJtZlo1NCtTYkxkekZQK2FHN1RuRklsTVIvZ1g5NUlR?=
 =?utf-8?B?dGt1dGVOdFlwbGlGMk1ySzZkQnV3NmhlYW9hWE1wUkpTTWZsTnRWUXkyUDFP?=
 =?utf-8?B?aUYvL3RTbnJJNU85VUpXM3VTQStYV0ZaTDhBWTZBVjdGQ1cwT25hVmcxSkRB?=
 =?utf-8?B?cmdqVTB6RFFrTnl2VzlNcTBmbk5yKzBPR3Z1b0lkeFVFa2xhY3RNWE5tUmFj?=
 =?utf-8?B?N2JhNkVYVVdYRks0WldvNlBXUmM4NmszT0kxWnVXREsxWWNNd2lGVWZXU0hJ?=
 =?utf-8?B?RmU3b2FFTWZQbFh6djJiR2EwNnpnckJpOVRGbndWNUFCclRwcXREdmx4dEJv?=
 =?utf-8?B?OTZjZGpudERsR2htbVlYc1RxeGI1UjlseHRXWHNHUStiV2phMFhibnh6enV4?=
 =?utf-8?B?M1o0ZmFXUzF2d0o0SlgweGhuWWVwclM1ZjFGRzg0MUE0Q28xYkhYYTNLZzlS?=
 =?utf-8?B?UDQ5NnJ5c3V5UjVRV3BlMzF3VjhjWENMdTU2RmdseEo2TG80bG5xaDNQdUVj?=
 =?utf-8?B?N0hoZU5GRHAzYXlPSG1rZUpVTjlLYlNydWlLOExmNkJpK0kzUlB4MFgwR2Zp?=
 =?utf-8?B?bXFHcTlMa040L0xuZ3ZpQ1ZPZHdaM0UyMlRVSnBtbHpndENUbVdDaWJyOWhk?=
 =?utf-8?B?TUlvU1Q5Q29KaFllQnpBZnFwa2VWK0NNdlZSQlFFVWU2Vy84RWxROE12SFNp?=
 =?utf-8?B?QlBTV0xrL0dRcjNvS1NkNEI2UFF6QzBXSStlSkJITXpneDJXeloxWlQ0MnV5?=
 =?utf-8?B?QWlzektEa0FBRlF4eThpaGRRaHU1MENzRSswSEN5TzlMdzRCUHlTdHB4UUhm?=
 =?utf-8?B?TTRUejJHNVdqS1hIOVlGR0tQdzBoSnpYNi9sbktuMUNWSFNkYzNZUFNoYUln?=
 =?utf-8?B?WEl1RW5IOW1WN0gxWWw0K0F3UXJJUU9RNDVzMHBNTWptSlI1OGhkdDl3Q1oz?=
 =?utf-8?B?cjNrUjBwZXZHV0JjZXNVTFFUc2hQTjcrRkVlS0ltNHpTMWhoQjZyYk11SEg1?=
 =?utf-8?B?Uk1YNDg2WkkvdkJMbGpHMHVTNHJGSkNoK0VIN0FFU3NIOUZ2N3BWZ0VkN0lV?=
 =?utf-8?B?RSsvQTFUcVQrZXZ1NmM0YXBkTUJzdnpuNEFScWZrMXFPRWQwUzJiOTFwK0VG?=
 =?utf-8?B?d0pNRHVGZ0tzQjNVeVNsQnNLRFpwaHU0VTFLdnh6TzlreVA3c2VHWjFaejM1?=
 =?utf-8?B?Q1ZjaHR0WndyWnpzakJhMlFZR0ZJRzUyZloxdFNxM0RhQnFqaVdvdkNJU1I4?=
 =?utf-8?B?cTRIUVpwbHhqMldqU3UxZ0xCSkhoZlNDSzVhbFFjQVZMN3ZwUDY2WDFNMWEr?=
 =?utf-8?B?NFhvRVFiMWFSWTFvWVN4R1l4WnRLaUtrRHNZQTlPbDV3MWxqRGxlMi9uVGFk?=
 =?utf-8?B?eEZMenoreXNPeWp2ZmJuSFRDSEFtaVpWZ0UyOVhyZVNqYXZMb0wyb25RNlpS?=
 =?utf-8?B?MmxzRk53aFhVODFjSW9IeTRneEUvZHZ6NjJEQ200TTgzT0lxbGUvNUZGdHA5?=
 =?utf-8?B?MFJyZThZOFJ5dGdNcjE2T243M2JpaXVlU3pXVkFDeVVOVXFGbGQ3czhmVW1v?=
 =?utf-8?B?dnRXdGY0NWplMVNPRmFwcWVVbzRNdEsrenBqblhabSttN1FJTmRSdE5UVG1O?=
 =?utf-8?Q?mk+AP5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3lnQkVERkxMem1GSGZzSktVS2VXT2JDZmhJYjAzNStQWnUwOG5RQ005RVRz?=
 =?utf-8?B?WVR4M2RTeitQd0FOc0huTWpCNm5GMjFlQ3lPYm5mYXkycWwrMUxHMVN6L3Ra?=
 =?utf-8?B?U0JyeWpNZVgyYUlRWUpuMGtIWE9GZ3FmbEk4MnRIbzBQVXdjdUJ2a0Q2UnR2?=
 =?utf-8?B?cHpsWlorekdVa2d2dWdqNlU3ZXEwNXI1UnFqVmVVUXYxTzM3dHpseitTZUtC?=
 =?utf-8?B?bzJDa3pMcUpDRUx3eEdaNHlHV3lOYnRoaXYvWllXVEZUMlMyU3gwOGx6THNW?=
 =?utf-8?B?NDhyeWxDdnpPMk1QVmFjalJsdXFLcWliRlJNV1M2VzFwSGhsQkJFWHBhSmlQ?=
 =?utf-8?B?ZWJkZnQ3eU9DQ2poeDhKK01MVHkxdHJvNUQxSEJhc0xTZm5kK1FLdTdCZjM1?=
 =?utf-8?B?ekJTM3B5V21QSUtOdDUySytOMnR6cDJ0eW9udzAvOTlsSTN2N0hPZVNPejNM?=
 =?utf-8?B?TUhXYXUvU1VqbnFpS2l6bzRNaWJKSXJIVmh2WHV1OGlXeGpRZEt3VmNNdXdC?=
 =?utf-8?B?TGhRSGEzbHJoeU4wUUYwanlYeUNtZ0dWcndjZEp2R1VCbjQ1NmVpQlR1VVRX?=
 =?utf-8?B?eTdMMStiTXJ5UjJXK3V1OXBnaHdKQy8vY0lUL0pSZlNINTFFaDhMeDY4NVVm?=
 =?utf-8?B?amZ0ZzI3WVVJU0R4Y3VFQlhLa0NpeVJUYVdKVTU2SFN5ZGxRckF2eFBFRnFU?=
 =?utf-8?B?bEIyci9yUWxqWmdScVM2Y2FSNzR2S09wQ0tJT1hlK3FaNlk3azg2YkNIajlv?=
 =?utf-8?B?U205T1JiVEliY2tET2drTkNqQXhuRDdsQ2RTT0VyRE8raVFub296cHQwN2pV?=
 =?utf-8?B?QnBxaTQvcGMvOHpoTU1oMGlSUXB4czRzVXFER3hzeTVPVEdGelFkYWxhZWRk?=
 =?utf-8?B?OC9nc0U5Z2ZuWVRtTkFJM0V0U2V1dStsWXdFNWVtTGgxL1QvVkNRQUJXUzEr?=
 =?utf-8?B?Q2I4VmpiUDdpcTBJdUhhRGhrNHllcC9VaFVhYU1vaWdTalphOTVHNE5jWGt5?=
 =?utf-8?B?U3BZVlJVZnUranFudkpuVFdYVEhGZE5qVHFSOXpTYk1KRks5K1BtUVhaUFZi?=
 =?utf-8?B?YzNUaHJ5L2Rld1A5K3UvWkZrR0xCbXl4UXhHWkpUcUErWGlEMXlUNFdGYlRC?=
 =?utf-8?B?bzBsLytJOXhYa25mOHQ2K0txbTgzMEJ0Mzl6b28rY0VDdUhFdFA5QnBta29k?=
 =?utf-8?B?YS9rcWVGbWpJWjBMbXljYXhJSEZqVExMTlNPcEQ2SzJtemdZdGFSUk1kZ1kw?=
 =?utf-8?B?NlJTbjFiRENmZzRZSUI1NkZwaVI3R3BmTWtHc09HeDFyQVBzZlpYQndINWZC?=
 =?utf-8?B?OHYzY25yN0FrRFRHeXJuaTcyOXRQdWI0SThzRTAzbCsvK0xRK0FnMFBuZ3dF?=
 =?utf-8?B?R1lqVStlNWwwbm5INXdGNE1kTGtGWUdtZElGNHBrVEdnRGZNQVFPYnJJdnVL?=
 =?utf-8?B?UjIvZU1UcFF0dkozSWVEa21tZnhkcXdWUys5YWNLU1p6aTZsL2tZWGwyb0E5?=
 =?utf-8?B?ckx4VUxyTFB0Z2JZYWl3TFBhUGpiY0VWcVdON3l1VDh2S2NNKytERVdSVWV0?=
 =?utf-8?B?aUlZWFdITnZGWGFSNkpSV3RYd081VzFsRjJVcVFpcFFvL3ZOM1dpbjgzalR3?=
 =?utf-8?B?RGUxdlBFMURGNi9vSTBGMm05ZGswU1ZiNDJkbkllL1NpeExBVURndlN5UUFm?=
 =?utf-8?B?YXNOZW56cmtvdzBmL0V3dzFZeVdHNUMvb0s0QlN1WnppYmd6OGMzVXpVdEF3?=
 =?utf-8?B?V0R6TzE2bndud1E0b1N5TENCVmFucEZ1Z0k3WXQ3bXYwcmppVEUyNTVONHo1?=
 =?utf-8?B?cUJwSld5VUFhTkkzdDY4bmx1UDdiK2g0ZytGdm1nVkt4c28vbDRLcmNOQUFN?=
 =?utf-8?B?YmJjWUxmZmorNGtwaEtkUW5Kb0RIaWRISyt2VTRHdDB4UTRoVitBM0c3Z05Y?=
 =?utf-8?B?NUtnSE1KeTJrb0hHV1Myb3FSUWxtRmhkUHVmbzByeHRHb0x3V1JXNkJ3aWJC?=
 =?utf-8?B?VldQdGg5TVBRaHhxZnpTOW9aOUZnOUZhL3hNTi81OXZFdnBZOEt5VFE5V3lp?=
 =?utf-8?B?VEppeU1IQWd6N0VKb0FoUmV3clZZbEhUbWsrMTRtamtzZEFoWGNQYTBaYW9i?=
 =?utf-8?B?WElZM3gweEtGRUdrVkFwSm5sc1oreU1Ud3RHMURLZ0t3VWhPdVdtRlNUZ3hR?=
 =?utf-8?B?V1VydXhRSU1taUlldjNMWGJwOFg2LzdrUHVGWnZvb1pwNTI5ZjRDM2x2d0Q1?=
 =?utf-8?B?akpjY1Nwb1NTN2tjTTVGZXdKOWRUU0s4Z3dJY3ZGSWZsS215cmdSK2h0RmJn?=
 =?utf-8?B?a0x6RnZlQVNVR0twZ28yV20zMUtjZE5JTmcwUzl1dzFUQTFlaUFEUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B32C814FEA19454DA59E65C989810927@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81406f8a-a6b6-402f-4c91-08de4f860a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 13:50:24.8406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n64TxrD6OX8aMLw8oM36xxMBH6nOp+jTqblRKSunY30VkX+iqLAB5fNhh35e/H0iAb6EDsLRAlhNQqfCBL1l/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171

T24gRnJpLCAyMDI2LTAxLTA5IGF0IDEzOjA2ICswMTAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDEtMDksIDExOjM4OjU5ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
T24gRnJpLCAyMDI2LTAxLTA5IGF0IDExOjI2ICswMTAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+ID4gPiAyMDI2LTAxLTA3LCAxMjo0NzoyMyArMDIwMCwgQ29zbWluIFJhdGl1IHdyb3RlOg0K
PiA+ID4gPiBWTEFOLWZpbHRlcmluZyBpcyBkb25lIHRocm91Z2ggdHdvIG5ldGRldiBmZWF0dXJl
cw0KPiA+ID4gPiAoTkVUSUZfRl9IV19WTEFOX0NUQUdfRklMVEVSIGFuZCBORVRJRl9GX0hXX1ZM
QU5fU1RBR19GSUxURVIpDQo+ID4gPiA+IGFuZA0KPiA+ID4gPiB0d28NCj4gPiA+ID4gbmV0ZGV2
IG9wcyAobmRvX3ZsYW5fcnhfYWRkX3ZpZCBhbmQgbmRvX3ZsYW5fcnhfa2lsbF92aWQpLg0KPiA+
ID4gPiANCj4gPiA+ID4gSW1wbGVtZW50IHRoZXNlIGFuZCBhZHZlcnRpc2UgdGhlIGZlYXR1cmVz
IGlmIHRoZSBsb3dlciBkZXZpY2UNCj4gPiA+ID4gc3VwcG9ydHMNCj4gPiA+ID4gdGhlbS4gVGhp
cyBhbGxvd3MgcHJvcGVyIFZMQU4gZmlsdGVyaW5nIHRvIHdvcmsgb24gdG9wIG9mDQo+ID4gPiA+
IG1hY3NlYw0KPiA+ID4gPiBkZXZpY2VzLCB3aGVuIHRoZSBsb3dlciBkZXZpY2UgaXMgY2FwYWJs
ZSBvZiBWTEFOIGZpbHRlcmluZy4NCj4gPiA+ID4gQXMgYSBjb25jcmV0ZSBleGFtcGxlLCBoYXZp
bmcgdGhpcyBjaGFpbiBvZiBpbnRlcmZhY2VzIG5vdw0KPiA+ID4gPiB3b3JrczoNCj4gPiA+ID4g
dmxhbl9maWx0ZXJpbmdfY2FwYWJsZV9kZXYoMSkgLT4gbWFjc2VjX2RldigyKSAtPg0KPiA+ID4g
PiBtYWNzZWNfdmxhbl9kZXYoMykNCj4gPiA+ID4gDQo+ID4gPiA+IEJlZm9yZSB0aGUgIkZpeGVz
IiBjb21taXQgdGhpcyB1c2VkIHRvIGFjY2lkZW50YWxseSB3b3JrDQo+ID4gPiA+IGJlY2F1c2UN
Cj4gPiA+ID4gdGhlDQo+ID4gPiA+IG1hY3NlYyBkZXZpY2UgKGFuZCB0aHVzIHRoZSBsb3dlciBk
ZXZpY2UpIHdhcyBwdXQgaW4NCj4gPiA+ID4gcHJvbWlzY3VvdXMNCj4gPiA+ID4gbW9kZQ0KPiA+
ID4gPiBhbmQgdGhlIFZMQU4gZmlsdGVyIHdhcyBub3QgdXNlZC4gQnV0IGFmdGVyIHRoYXQgY29t
bWl0DQo+ID4gPiA+IGNvcnJlY3RseQ0KPiA+ID4gPiBtYWRlDQo+ID4gPiA+IHRoZSBtYWNzZWMg
ZHJpdmVyIGV4cG9zZSB0aGUgSUZGX1VOSUNBU1RfRkxUIGZsYWcsIHByb21pc2N1b3VzDQo+ID4g
PiA+IG1vZGUNCj4gPiA+ID4gd2FzDQo+ID4gPiA+IG5vIGxvbmdlciB1c2VkIGFuZCBWTEFOIGZp
bHRlcnMgb24gZGV2IDEga2lja2VkIGluLiBXaXRob3V0DQo+ID4gPiA+IHN1cHBvcnQNCj4gPiA+
ID4gaW4NCj4gPiA+ID4gZGV2IDIgZm9yIHByb3BhZ2F0aW5nIFZMQU4gZmlsdGVycyBkb3duLCB0
aGUgcmVnaXN0ZXJfdmxhbl9kZXYNCj4gPiA+ID4gLT4NCj4gPiA+ID4gdmxhbl92aWRfYWRkIC0+
IF9fdmxhbl92aWRfYWRkIC0+IHZsYW5fYWRkX3J4X2ZpbHRlcl9pbmZvIGNhbGwNCj4gPiA+ID4g
ZnJvbQ0KPiA+ID4gPiBkZXYNCj4gPiA+ID4gMyBpcyBzaWxlbnRseSBlYXRlbiAoYmVjYXVzZSB2
bGFuX2h3X2ZpbHRlcl9jYXBhYmxlIHJldHVybnMNCj4gPiA+ID4gZmFsc2UNCj4gPiA+ID4gYW5k
DQo+ID4gPiA+IHZsYW5fYWRkX3J4X2ZpbHRlcl9pbmZvIHNpbGVudGx5IHN1Y2NlZWRzKS4NCj4g
PiA+IA0KPiA+ID4gV2Ugb25seSB3YW50IHRvIHByb3BhZ2F0ZSBWTEFOIGZpbHRlcnMgd2hlbiBt
YWNzZWMgb2ZmbG9hZCBpcw0KPiA+ID4gdXNlZCwNCj4gPiA+IG5vPyBJZiBvZmZsb2FkIGlzbid0
IHVzZWQsIHRoZSBsb3dlciBkZXZpY2Ugc2hvdWxkIGJlIHVuYXdhcmUgb2YNCj4gPiA+IHdoYXRl
dmVyIGlzIGhhcHBlbmluZyBvbiB0b3Agb2YgbWFjc2VjLCBzbyBJIGRvbid0IHRoaW5rIG5vbi0N
Cj4gPiA+IG9mZmxvYWRlZA0KPiA+ID4gc2V0dXBzIGFyZSBhZmZlY3RlZCBieSB0aGlzPw0KPiA+
IA0KPiA+IFZMQU4gZmlsdGVycyBhcmUgbm90IHJlbGF0ZWQgdG8gbWFjc2VjIG9mZmxvYWQsIHJp
Z2h0PyBJdCdzIGFib3V0DQo+ID4gaW5mb3JtaW5nIHRoZSBsb3dlciBuZXRkZXZpY2Ugd2hpY2gg
VkxBTnMgc2hvdWxkIGJlIGFsbG93ZWQuDQo+ID4gV2l0aG91dA0KPiA+IHRoaXMgcGF0Y2gsIHRo
ZSBWTEFOLXRhZ2dlZCBwYWNrZXRzIGludGVuZGVkIGZvciB0aGUgbWFjc2VjIHZsYW4NCj4gPiBk
ZXZpY2UNCj4gPiBhcmUgZGlzY2FyZGVkIGJ5IHRoZSBsb3dlciBkZXZpY2UgVkxBTiBmaWx0ZXIu
DQo+IA0KPiBXaHkgZG9lcyB0aGUgbG93ZXIgZGV2aWNlIG5lZWQgdG8ga25vdyBpbiB0aGUgbm9u
LW9mZmxvYWQgY2FzZT8gSXQNCj4gaGFzDQo+IG5vIGlkZWEgd2hldGhlciBpdCdzIFZMQU4gdHJh
ZmZpYyBvciBhbnl0aGluZyBlbHNlIG9uY2UgaXQncyBzdHVmZmVkDQo+IGludG8gbWFjc2VjLg0K
PiANCj4gVGhlIHBhY2tldCB3aWxsIGxvb2sgbGlrZQ0KPiANCj4gRVRIIHwgTUFDU0VDIHwgW3Nv
bWUgb3BhcXVlIGRhdGEgdGhhdCBtYXkgb3IgbWF5IG5vdCBzdGFydCB3aXRoIGENCj4gVkxBTiBo
ZWFkZXIgXQ0KDQpZb3UncmUgcmlnaHQsIEkgY2hlY2tlZCB0aGUgZmFpbHVyZSBhbmQgaXQgaGFw
cGVucyBvbmx5IHdoZW4gb2ZmbG9hZHMNCmFyZSBlbmFibGVkLg0KDQo+ID4gPiBFdmVuIHdoZW4g
b2ZmbG9hZCBpcyB1c2VkLCB0aGUgbG93ZXIgZGV2aWNlIHNob3VsZCBwcm9iYWJseQ0KPiA+ID4g
aGFuZGxlDQo+ID4gPiAiRVRIICsgVkxBTiA1IiBkaWZmZXJlbnRseSBmcm9tICJFVEggKyBNQUNT
RUMgKyBWTEFOIDUiLCBidXQgdGhhdA0KPiA+ID4gbWF5DQo+ID4gPiBub3QgYmUgcG9zc2libGUg
d2l0aCBqdXN0IHRoZSBleGlzdGluZyBkZXZpY2Ugb3BzLg0KPiA+IA0KPiA+IEkgZG9uJ3Qgc2Vl
IGhvdyBtYWNzZWMgcGxheXMgYSByb2xlIGludG8gaG93IHRoZSBsb3dlciBkZXZpY2UNCj4gPiBo
YW5kbGVzDQo+ID4gVkxBTnMuIEZyb20gdGhlIHByb3RvY29sIGRpYWdyYW1zLCBJIHNlZSB0aGF0
IGl0J3MgRVRIICsgVkxBTiA1ICsNCj4gPiBNQUNTRUMsIHRoZSBWTEFOIGlzbid0IGVuY3J5cHRl
ZCBpZiBwcmVzZW50Lg0KPiANCj4gV2FpdCwgaWYgd2UncmUgdGFsa2luZyBhYm91dCBFVEggKyBW
TEFOIDUgKyBNQUNTRUMsIG1hY3NlYyBzaG91bGRuJ3QNCj4gZXZlbiBiZSBpbnZvbHZlZCBpbiBW
TEFOIGlkIDUuDQo+IA0KPiBpcCBsaW5rIGFkZCBsaW5rIGV0aDAgdHlwZSB2bGFuIGlkIDUNCj4g
DQo+IHNob3VsZCBuZXZlciBnbyB0aHJvdWdoIGFueSBtYWNzZWMgY29kZSBhdCBhbGwuDQo+IA0K
DQpUaGVzZSBhcmUgdGhlIGludGVyZmFjZXM6DQppcCBsaW5rIGFkZCBsaW5rICRMT1dFUl9ERVYg
bWFjc2VjMCB0eXBlIG1hY3NlYyBzY2kgLi4uDQppcCBtYWNzZWMgb2ZmbG9hZCBtYWNzZWMwIG1h
Yw0KaXAgbGluayBhZGQgbGluayBtYWNzZWMwIG5hbWUgbWFjc2VjX3ZsYW4gdHlwZSB2bGFuIGlk
IDUNCg0KV2hhdCBoYXBwZW5zIGlzIHRoYXQgd2l0aG91dCB0aGUgVkxBTiBmaWx0ZXIgY29uZmln
dXJlZCBjb3JyZWN0bHksIHRoZQ0KaHcgb24gdGhlIHJ4IHNpZGUgZGVjcnlwdHMgYW5kIGRlY2Fw
c3VsYXRlcyBtYWNzZWMgcGFja2V0cyBidXQgZHJvcHMNCnRoZW0gc2hvcnR5IGFmdGVyLg0KDQpX
b3VsZCB5b3UgbGlrZSB0byBzZWUgYW55IHR3ZWFrcyB0byB0aGUgcHJvcG9zZWQgcGF0Y2g/DQoN
CkNvc21pbi4NCg==

