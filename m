Return-Path: <netdev+bounces-159323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EF3A15180
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81A23A9438
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE021E52D;
	Fri, 17 Jan 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="I2I74jGU";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="CAOmDqMK"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay33-hz2.antispameurope.com (mx-relay33-hz2.antispameurope.com [94.100.136.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F880604
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.136.233
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123427; cv=fail; b=pviZ5yton9Yb9MLug5qzOQTJVh+YtHXtxSGVo9owznyDHNntVu2tHn7uhdQXUdTl4HVn0XG4LnFnDAiHMZXTN2VQTlkA+r9lk4BPVh39JQaKJxJanJHvC1NjOOs+Wtj7YW3VJ9pVjDLXEZLTZi1zNPrMIjTRn5k2SKoh5TPhAtM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123427; c=relaxed/simple;
	bh=6ISM+cxVAbArHdqq/zx5F/5areb3OIDimgoJOcR2Jmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RgsWPd7TLkm1t4J0npqwix62RjzOKrkJNQAvpfZ9IPvtRwEH5tiOeaDf0EIb3KEMLxWNiNdX2h0WKpyrtILhs+DBT1QLg2cZFFUbhPaL9Nx8uzZijyiynqIIPCAUrP3vWcvRe3hJJHkSZ+Hz7gEeXV88UFHr97zoky/SkmRVsS8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=I2I74jGU reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=CAOmDqMK; arc=fail smtp.client-ip=94.100.136.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate33-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=104.47.51.169, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=eur03-dba-obe.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=5bZ9Ezf0LgxCXeIt8NrtoH+AqedTGZptPLorgP43jx4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1737123385;
 b=f1tPwY0EHTHi+xi/Tu1gpeGN0+45WhQkpDo22XBfiEDYdjse3XX0dQ3fNJziXyv6aoYvruRT
 pgfu4hvpsxuI+tP1sXACgRoyJlhjFxSRj5HknvXxonSg3sjzBduGrftp32nrIF2wyCe+zoJsXYC
 qYc+P4ufj9y9qiiajyyR32XknJWCzfRWJOXUl83iALtQXbExX/Z7Odo6mTH1+G47No5rK65pqR6
 5P4iJuHHXQ/xeGo3VNcJeGo3MLdbF6Yn3DPFz1DpzoW0lw5gxSDkC3uXVdi9IzhdLgfGQsjoA9W
 cd2EWtQ5aIPO7dpf130KLzbgSgZVjMQTJ1VORFaTMACOg==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1737123385;
 b=giH5IypXdEjcoATljnxPjzjNqYWOJUbzGF1yU0F4e1VSPdTCGylYXOnzjoEY9jK7qekDYGBW
 AqGFbTRRLcoNobJOnNgcm95nXMHKsqseVltfo6TrBmExmI9qWc2CVFv3KXccRKzMZkPcddVaCYM
 igDiCQ/bLX+r/ZdX1tgkeBf66hNIZxkL3ii8mGtYy9BWrniU5vQM2CB/ijda6ghOZGhfKP8Jd2f
 AIfpoUU9X3dmkgH5wZk03Ly4eTcsLhNpddZ+nrh44afgTQoznOvefiFlAxAqMG3Y0OgOwSN+QUg
 Qmu09soJhjAqT4EzwlOiBThcxfLDFHib7yItoMoRRijpg==
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com ([104.47.51.169]) by mx-relay33-hz2.antispameurope.com;
 Fri, 17 Jan 2025 15:16:25 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnLLmVfzWw+LSUTiCCREsxZcWzl7fFwtOUYXiudydA1qoX7AR2LwQc1Xo9avqu2pXV9dhyyL4bDeUMELp36XG5uk683apzyUos1j5Q9eR1YDXkm8R5Zh89Eux/vZRRLM7JFbokKC6V8Ksm4aamhihc69a9on8vbyyzg2pnaT933dyGoR6sh2jTyOVhBx+RrSHEiq4kL4Ly5kEynKSAOdnNM5bkBVbq0hs/YpesxxVhZn1cr/tov5nkEwOlWSFVcndWdHMhLhw6FkhN37qPBKHnq5xf4/aYaJTWvsfx3iOhpxf2SrqSh4YrIPoZkuG0A+WQ1F1cZcaWPeTpYdUyXZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bZ9Ezf0LgxCXeIt8NrtoH+AqedTGZptPLorgP43jx4=;
 b=j7nMhPBDsTeGSao17MPynBNSWvNXxQgkHw/J9mZsC1eb3RK0zB0xDMY9PIX3+o/DRIaFpg/hoNnFbgqLjbl5fPO16xAlpUPfOQIxrfBoGpwnBireZ6T7MPRwFkM4o+C+4WkWAXKuRdyWquN2BDyozIfGMXoWh9FLhcIoWBJ2bPw8UXRWASjeXqFeSR8mTS7jog5JJv2AFQ0YpmEPeaL7GjaL2WrNT0RwyFnRW1w/kDoqNFukPUpytlEHrdoTyLqYGWcGDa6vNR0dI2NNf/AgZhA9DHBSwesix5ESRrgT5AftaSKDdritvo8OWQA4agClvyyAW4hRb8nPuJ1O7GLA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bZ9Ezf0LgxCXeIt8NrtoH+AqedTGZptPLorgP43jx4=;
 b=I2I74jGU1b43VYmy8xjUWcVNlSeUIcdg5dAikUaD4vexaQ2hsuGdBuDgG7sZhKYqJcIM50MDBCJIpy4U0mpwCUdO8KjmNsQcSjNo1fPv6W7zUH6E9VYbrZgTfiK6/C1CTXIwxsGbifU+xmjR1id05SJw2NoUzXRt/O/CIxkTD/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::16)
 by AM7PR10MB3703.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.7; Fri, 17 Jan
 2025 14:15:47 +0000
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9]) by PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9%6]) with mapi id 15.20.8377.004; Fri, 17 Jan 2025
 14:15:46 +0000
Date: Fri, 17 Jan 2025 15:15:43 +0100
From: Stephan Wurm <stephan.wurm@a-eberle.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com,
	WingMan Kwok <w-kwok2@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>,
	George McCollister <george.mccollister@gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in
 fill_frame_info()
Message-ID: <Z4pmD3l0XUApJhtD@PC-LX-SteWu>
References: <20241126144344.4177332-1-edumazet@google.com>
 <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
 <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:204::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4948:EE_|AM7PR10MB3703:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5d37d5-66a4-4bcb-c6d8-08dd37016f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWZRbzFWeEZWcXlkMngraXF6YzEyaWVnVVRtY2J5TktKM3R6dnV6Nks0dGZX?=
 =?utf-8?B?UkU3WGxyOFk1U0NtTVBROGw4SXZXWDVxMWRhdzJLVFRxSjFidmU5aWxXQllU?=
 =?utf-8?B?dWs2RkRPMitrVkhuQmxYYWQ3YzgycmRlTDNiVVpMN0xrMnNleC9XVXRJTW5o?=
 =?utf-8?B?Y0pzVkJXTEsvZVRBSUJyTkk3VHlmYW9iMkVzUTFGRXpOQ2tMWTBTNk83SzBr?=
 =?utf-8?B?WVFsRnRGTWlwUFBpOGl4clRYLzVCU3cySmNKdEkzQVNuQzlVS1BpeTN3elIv?=
 =?utf-8?B?dE9KTkpCMTlxWU5yZE82ODB4bWE3YkIvZFhKK2UrTDBjclo2MWlSd3JaY2Rq?=
 =?utf-8?B?b09aYkRwK0JsRlhXVENRVkNxMDNKMnRBVE8veTh2amtmOEdzaU1vUHd4MTFu?=
 =?utf-8?B?QVZ4L0x5NytiMG14OFZIQTNzZ1pkYys5ZnVqT1dnMHh2L01ObExGdzgyQ2kr?=
 =?utf-8?B?RkRrWFMvbE84dG5Vb2p5elJtRkF0bXhPd25HV3lZME90QkxrQzBrOUYrdW9J?=
 =?utf-8?B?RGNieW1NVlc0b3dOL1lCSmZFYkRHM29lbUpoT1VWV04xUXIrbzNtaUZLbFFq?=
 =?utf-8?B?enkrZHdhbGMyL0k0UnhPTUFLa2VtQmxjOVpsK3ZQaTR2dEh2d0NLNzZ1ckh3?=
 =?utf-8?B?cVFqNUVieTNSSTBIWlp2MWd5dFhiUGphMENCdmVGUGJTbEt0TTZ0UmJIM2Ew?=
 =?utf-8?B?a2wrSjQvVW45WXQwNDlGci9NQ0ZkTmM2RmtpbmNXbnJZWGwvSG5UUEpPaDdp?=
 =?utf-8?B?OWdmbE9qZDhQdzErYjRWYktlSG1vd3ZHRStsSHB5TS9KakZoaGdiWXlZVmpK?=
 =?utf-8?B?SkRwWVlQanhOdGNPVk5kWTRQbEcyOFdOWmhjbjg0aEsrT2VWcTdabkxBT2RN?=
 =?utf-8?B?UUprMFZnNitUcE80aEtTTndSc3JTazdENGhKZkdsMmxjQ1orWmRIakdoakd4?=
 =?utf-8?B?b2tzRjUwWFJ3S0t0U0hKYVl6dkMvK2k1SG5oMVUvTFNKZ1Vqbk9GNHFxQkcv?=
 =?utf-8?B?QjNzakNkMUR3dTd1dVl5ODJlSWNmZ3g5SE9DalU3WG8zZ2xXaTFHTnVlSTht?=
 =?utf-8?B?UmhIK3JBdGVtMkFnSVpYMmxIVFBsNkQ4Q0U1MU5sR0hMSWFrQ3Y1Q3ZnK1hZ?=
 =?utf-8?B?S3JLamlKUWE4eDF6MVU4c3VHZXpFbS9WeTd1ZDl1Rit6MmNKakdIVm5ROWxL?=
 =?utf-8?B?TUt0SGVrUG5BL1dtSWdZTDJySUVSajZ3WWo0WlhOdDIxN2Npc1ErdXo3YW9h?=
 =?utf-8?B?cmJiTTM3R21NdGZZSnpua1VaOHcxZWlsV1MrV2Z4QXJDOVF2SjFjWkFGQ0w5?=
 =?utf-8?B?YlBPNmVDRkJ2UkZwU0ptODltbjdhUkZXU1NLaWVFZGx1SG1CV2dKQlgrVTJD?=
 =?utf-8?B?Z28zWi9RbW9LMEp0ekZ5RS9CYllKWWtESnJpZ0VMeXZML3VMM3E5clNjeEZx?=
 =?utf-8?B?KzlBSHVORnd6QVhvYkhPS0pIVzZwMmVxalhSUWwvL3B1K0dtQllzeTBQQmtF?=
 =?utf-8?B?ZkxZZ2kvWXFTQ3ZlUVQ4UzhLaC9mMzdpM2ttWTZJOFdQeFBMS294MWRtbmZ3?=
 =?utf-8?B?ZENTSk9RbFp6S3BhVExUdzJKL01raWdBcnpjWldqSnNtc0tRK0hCNXVnNElV?=
 =?utf-8?B?NmdqTHZlc09sMWRob1Z1Qkt6eEhTSlFKWVN1M0t3cDAyT3BvNDIxaWhIOU9y?=
 =?utf-8?B?WTBlVklDclRhUnYwdEZDRmtZVkNMbFQwUUE1c1VZNDNQWlRnZDdJMGt5YTdo?=
 =?utf-8?B?c2ptOHVIRlNINkUxU3NGNGp1N2FFTVNPbWgrNUxHRE5qSHdTRGNYNkE5Mnd5?=
 =?utf-8?B?eE5yRWJEWXg2QmNCVDA5d1A0RWQzU0NPSWNYemw5di9CdWNpNzFGc3VBb2Z4?=
 =?utf-8?Q?yCnALHxopyqrs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enNFUUgyNFRRQllrZDVPMnlmMW1CRFNoSlJ4QzU2ci9ncm5jRHl0N3I3SURN?=
 =?utf-8?B?cGd1dWRxQTZvcW5YRXZOV1dXOHdsQmZzM21HRzZDVm5vZ05OeXRaKzRlNUdy?=
 =?utf-8?B?SFdNS1ZLM0hLbHpSczZZTEtaZXVhRlUxYUMyZFJOUHFuNWovQnh2Ujd2NHRM?=
 =?utf-8?B?bmRLRnNPRWxxVUpiTWNOOWwzRHl4WEFkN2ZDbDZ5RXJPVUVGN1RIZTZhVnZ1?=
 =?utf-8?B?UnkwWjJWd0dma2lOT3hsQVFBYWNLc0NjZlNsbzZiNDFnTHFCVlUwNDN4MDkx?=
 =?utf-8?B?RDdXQWRQa2JNdlIrMjhzYm1Hek8rSDBSWUF1N3E3OG1KUU4xWFZrYm9GdEo5?=
 =?utf-8?B?bEgrKzNGQy9MNkRlZ1pZLzlsUXpHWEdGWVNidFpFb3hZRlBqTzBDdzlNWCt6?=
 =?utf-8?B?RmZ3RjlBeU9qeHNVMXpNM2YwUGNkNCthR25IazUybS9HdnZVandxK0NFdmV5?=
 =?utf-8?B?RUp5REw0b2VLb1lkV2p0Q1V5bVUzVy9palArYWhCTFd0Y3RkcytzWC9DTEt4?=
 =?utf-8?B?NC9SWkFRNkM3MVhJSUdCTDNrRGVhOW5BYUduQjdRTFQzd1RsTk00VTRJZEJB?=
 =?utf-8?B?UzZrQmh2YXJqc2paUHhsS1Q1K256Slc5aXczRkZsenVHT3FvOGtlWnJraVFs?=
 =?utf-8?B?eXpCNGtUMU1SYTUxdkxwcU5pRjJaQ0wyZE9kdis2UzRDcEtkTmwxNVBPanhz?=
 =?utf-8?B?U2NVdzUxMnpHTmRLU2hqbWFwcm1QMXhuYVA0Uy84OUZIdCsrekFTN016YkJZ?=
 =?utf-8?B?Z0V6emNyS1I0b1JYd2lPVW9lR2R4eW4rc29oZmkxME1vVFZqU0xwc0JJTElx?=
 =?utf-8?B?K1JoMnQyNlJsNXJQOEpDeEFudUtMWk5nM1lyTW5rWWFTYVhna0YvOFpkaW0r?=
 =?utf-8?B?R3lDaDBOS1JIbDd4ZmUzTHJQbXJhWityMUdZVldUaHo2MDFYRDB5SjExVmVq?=
 =?utf-8?B?V1hZQVRiZlkreUJuU1FJV1ZtWGdFRzMwQTVIbGcrREFzSC9NTVB5d2xxbDBq?=
 =?utf-8?B?ZDJjUHMvdXJ4Qk9SZEZvRjZSY016U2FXanpVTk1HRDkxM01XUkpIZjJaNElr?=
 =?utf-8?B?NExhdExxRVM4cXRKSHdaOUVSWkJUeTFLTFFUcUxYbUhQUE55SXRpM2cwUTFP?=
 =?utf-8?B?c2RQdTVneVhmUFFxMFpwZFhRWkI5RmRWQlYrVXpZQ3BleTFUOXFZQlgvakpY?=
 =?utf-8?B?RFN5Yy9OZCswYmc4bUJDT2x3cVNiYmRHK2Z4RFA5US9scndLU2txc1A1dkta?=
 =?utf-8?B?eTl3dEg1d21BUkpwUWc2dUkxWE9UbGg4dndxQnVvY2pGZ2hkVWFRNzNUMlp3?=
 =?utf-8?B?ZEVWR0xWK0J6dzI3YVU2dlZKdnRnNmFxNVBZb1RiSTdhc3dDMkFzTUExd3dK?=
 =?utf-8?B?T1dnN0JuMFFkRmhjREI2MVp1bGg5YXpTZEd0ZlRNSXdKRG1MeGJPb1ViNlRr?=
 =?utf-8?B?N1VUeTN4RjVtVHhjYzVHODNpeUlHRmM1MTNsaHBYN21XMHV4bHYycEY0RkNm?=
 =?utf-8?B?WjVyamtGdnV1UHBEczhETTN3aGF1bjY0MXNFQ00rYWo2a0EzVVZGMUIrRGI0?=
 =?utf-8?B?Ulp6K1NOamdsSXVhR21HYWFkYjVuWW5QUG4ySmNhU0hjdVVtL0Z3bE04c0Qz?=
 =?utf-8?B?eUFNNE9RK0p1Sk9QR1pGb25BazFYRTJuLzJSdlpwQmVMVnZsU1d3TDdLYXUr?=
 =?utf-8?B?N0xXZDdVdU9LalhKK2ptbWF4S1d4SzloUTUyYmZ1Nmc4aDlYNk5nUjU5Rzdj?=
 =?utf-8?B?TGZGN0dYLzNEaG40WXZSb0NFVXdxSGVFSWZtZ2hBL24yK3dGbnVmVlprcS9Z?=
 =?utf-8?B?WWdpWTFLSHBzdFVqbE9xZDNtUnNBNTVuTEFMcTdJdUo3TmZHWTJZbDFQVUdI?=
 =?utf-8?B?K0pyRkRUdUtTTlFvWU5JT2l5cEI1eUtSMExuL0JVQWZMaXc2b1RvcnJCUVdV?=
 =?utf-8?B?Si9uMDZjaVZmY0VPRElWTXpyTzNFKzV6bVdJaUhlZXBVaSttSldRTWQ0YTZr?=
 =?utf-8?B?WGlGNzlObjNXNE0yOXBQUTBrVUNCSXZjc1pXNFZRK3hJNVhTL0RQNnlQN0lJ?=
 =?utf-8?B?U2QweVh6OFduVno4ZUJ4Z0FhQ1ZtSlZUNVFVS0g2akVpNjFpZGhqbWtsZk1Q?=
 =?utf-8?B?ckZjNFRTQ0EvVHdNanBuVGt5MnlBUlJqN05qUVo0K1MzU1AyWUgyQUNkV3Ez?=
 =?utf-8?B?WEovenhuaUxFODlraEJuNU8xclZRRkw4RFVZcTdCZUNERG9tckQ4dXpCb0M3?=
 =?utf-8?B?QmJTdDRhdVdTU0JuVlVXNzkwb0NRPT0=?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5d37d5-66a4-4bcb-c6d8-08dd37016f93
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:15:46.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMf46eBgSNe6qVtMaAnk/Zj1kFfPG2LHRh8j/u02IE5kgzfiMMLtF8GQcOEUdjAQM2uKIsGgQFrId0tqk9VaHUwO7a4ji2AGaCyxZ1InWE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3703
X-cloud-security-sender:stephan.wurm@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay33-hz2.antispameurope.com with 4YZMGD6kCkz10N2B
X-cloud-security-connect: mail-dbaeur03lp2169.outbound.protection.outlook.com[104.47.51.169], TLS=1, IP=104.47.51.169
X-cloud-security-Digest:7407b8dda7261c92ad52f94d01019d50
X-cloud-security:scantime:4.151
DKIM-Signature: a=rsa-sha256;
 bh=5bZ9Ezf0LgxCXeIt8NrtoH+AqedTGZptPLorgP43jx4=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1737123384; v=1;
 b=CAOmDqMKZM7MQG9bcq3R8o0nwrqcARgOjWutKZwTgDHFYjUqpYi3kvPwDQ9rGTOoEeiX/P8l
 YWWajR5tXAnY4A9Z2FK10TXOgMGKtr+foPINcu+o0JiYKWamUmyuZNHLIZvOrf7S7Tekfn8BudU
 2WjRYmEzP99cj508n5gI/xUt0YLEPnD/Upg/F+uCgrIv2xwAOl1apm3DA23u6fyY6FVDHs7kHPM
 LNMlL+gfz0/aG5ebhP2XO9TQFGPJnR/mwnS/ciHmFJWou0rcD1g2KKij7ttN3XmLTLMw6lZGAyE
 aQOrfcdTWr84QnRY7j2bXjpbpbCO/up8ryiT773meVuAg==

Am 17. Jan 14:22 hat Eric Dumazet geschrieben:
>
> Thanks for the report !
>
> You could add instrumentation there so that we see packet content.
>
> I suspect mac_len was not properly set somewhere.
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..b0068e23083416ba13794e3b152517afbe5125b7
> 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -700,8 +700,10 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>                 frame->is_vlan = true;
>
>         if (frame->is_vlan) {
> -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
> +               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr,
> vlanhdr)) {
> +                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, true);
>                         return -EINVAL;
> +               }
>                 vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
>                 proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
>         }

Thanks for your instrumentation patch.

I got the following output in kernel log when sending an icmp echo with
VLAN header:

kernel: prp0: entered promiscuous mode
kernel: skb len=46 headroom=2 headlen=46 tailroom=144
        mac=(2,14) net=(16,-1) trans=-1
        shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
        csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
        hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
kernel: dev name=prp0 feat=0x0000000000007000
kernel: sk family=17 type=3 proto=0
kernel: skb headroom: 00000000: 0d 12
kernel: skb linear:   00000000: 00 d0 93 4a 2d 91 00 d0 93 53 9c cb 81 00 00 00
kernel: skb linear:   00000010: 08 00 45 00 00 1c 00 01 00 00 40 01 d4 a1 ac 10
kernel: skb linear:   00000020: 27 14 ac 10 27 0a 08 00 f7 ff 00 00 00 00
kernel: skb tailroom: 00000000: 00 01 00 06 20 03 00 25 3c 20 00 00 00 00 00 00
kernel: skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 3d
kernel: skb tailroom: 00000020: 00 00 00 00 67 8a 61 45 15 63 56 39 00 25 00 7f
kernel: skb tailroom: 00000030: f8 fe ff ff 7f 00 d0 93 ff fe 64 e8 8e 00 53 00
kernel: skb tailroom: 00000040: 14 0e 14 31 00 00 53 00 14 0e 14 29 00 00 00 00
kernel: skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 08 00 45 00 00 34
kernel: skb tailroom: 00000060: 24 fa 40 00 40 06 17 c8 7f 00 00 01 7f 00 00 01
kernel: skb tailroom: 00000070: aa 04 13 8c 94 1d a0 b2 77 d6 5f 8a 80 10 02 00
kernel: skb tailroom: 00000080: fe 28 00 00 01 01 08 0a 89 e9 8a f7 89 e9 8a f7
kernel: prp0: left promiscuous mode

Additionally, I have tried some own instrumentation:

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index e87447d04033..66f4c0d2a03a 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -700,8 +700,12 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		frame->is_vlan = true;

 	if (frame->is_vlan) {
-		if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
-			return -EINVAL;
+		if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr)) {
+			netdev_warn(port->dev,
+					"Would drop VLAN frame due to %d < %d\n",
+					skb->mac_len, offsetofend(struct hsr_vlan_ethhdr, vlanhdr));
+			// return -EINVAL;
+		}
 		vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 	}

This gave me the following output (one line per VLAN tagged frame):

kernel: prp0: Would drop VLAN frame due to 14 < 18
kernel: prp0: Would drop VLAN frame due to 14 < 18
kernel: prp0: Would drop VLAN frame due to 14 < 18
kernel: prp0: Would drop VLAN frame due to 14 < 18
kernel: prp0: Would drop VLAN frame due to 14 < 18
kernel: prp0: Would drop VLAN frame due to 14 < 18
kernel: prp0: Would drop VLAN frame due to 14 < 18

Hopefully this helps to identify some new pointers.


Maybe I should add that the embedded system uses a 32 bit controller
(NXP LS1021a)? This fact already led to some strange side effects with
addressing issues.


Best regards

Stephan

