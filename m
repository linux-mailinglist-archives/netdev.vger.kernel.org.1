Return-Path: <netdev+bounces-220032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29966B443E4
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D316416C819
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8B28153D;
	Thu,  4 Sep 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="v4ahdQpE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585991F91C7;
	Thu,  4 Sep 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005582; cv=fail; b=HLL0BxmEqXNRsHj6rhVJodVHTm8EADXE1Xxab/mlzt7EdXK+29LYS7RNcc/QuFRl4DM3REpbXIuXojsGU0ecDdSN/C3encqDG+2az5BvHoUIAiTtKsuckeNbj2hvmTQgPT3jlppcekoK/H8X1F6AVAUOpqVhqYahI3mCjZPiTto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005582; c=relaxed/simple;
	bh=bkBKnSgLD8zxklJ7lMfXDQ+xsTrZS4b9/LBWpxD5Ljs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fK6hsFsuOhp3k+DXrmaicsU42yS7UQccGDU+6eI56ZiB3qp/1nshnKu3+orZKtqZ/DGk2fck871RacJ0Ssa4M0sENdlhQZsCiUEw56+fde3akQkBXA8qQ9JinLBcVbHjziRTKlqNxsyU4dxunq1t9ql0hfjJY9TLRIoL9/LKoOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=v4ahdQpE reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.244.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn/LN4LXHVoy9OnjrXj2TruNHNP33UoD4rMw5XTv6dDMesKiCMkDIEAPFYavz60EeXEkcDLSOXvi7LRcb0dC/RX2MVayfkfLkmkEXK7ofTrCdAUJyFFyxl5lVjeTQ2ojnOR9RXDBDEaxbchGe/WJ4QT3BWx2yZcKB2a6kPYIlMkCs/VAo34snGxwvIbCP/3bOGoW1Ir/3/C6riIJvrRjnuK0dsE5ClKD9MYg5gErAaDMXXJP8v6PIqx8bCNKRnqjoih8QHrCFXJQaZMcbBPOzaVRwOfzgWVjIRIfHcqBzNIHmQyd/byGWElrLiBsJOQxifSsYLpF7L2/7p4gihKDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnw75BzX24PoBCKMRgWsgCtPsWYA0TtDOHpi0xIaTw8=;
 b=dDaeeBa1WFIufoqrIVj1K2CsgjuXmRz0zB4YzMuHzkahsVMGSvYhAKrS26opgxhT6tEle+5NBD3YkF7gGx4HiMFFd2q/Eu7HSEehwc/Pe4+Ae9/VgCAZF99I4lOwwt8anuo8LDSrCcRTlSDBEdTdE64N2TPgi7guIM7vnOYYKjREmx+sox4RYF5a+0bBpZxFbVOqUeQv3Mw0DKUFLIXENgyhVshqGmXPb3StGPfi6eH1DxSIRQ7KNdLmk5uOVUbrvOL5jnR6ex/4MbmSxcv4YZkP6DiD1GeqxY6pwb4Ezj94Rp21PixivFgI3riYXNFT0sOUeimCwkMTlOWMC8jkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnw75BzX24PoBCKMRgWsgCtPsWYA0TtDOHpi0xIaTw8=;
 b=v4ahdQpEoUEajxDRzds1T9m9kYCUUtIznctvhXrxCwCO5bLibnvoIA2yj701IXc+wWZd4ud2inIO4bvwhLf5DkEWtNE6QHjipePZBbDrE0/BF+hoJj7kSGe6mke1P8YIkdfbKM0TMt9CpzxUAvSgGfJOIe6LYUNygC4hJuuNE5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS1PR01MB8943.prod.exchangelabs.com (2603:10b6:8:219::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Thu, 4 Sep 2025 17:06:15 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 17:06:15 +0000
Message-ID: <2456ece8-0490-4d57-b882-6d4646edc86d@amperemail.onmicrosoft.com>
Date: Thu, 4 Sep 2025 13:06:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
To: Sudeep Holla <sudeep.holla@arm.com>, admiyo@os.amperecomputing.com
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:930:4c::16) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS1PR01MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 7293261a-8056-4098-a4ed-08ddebd55b6d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEJzVjZuMnBxVUFJeTlxS0d1RWFTNEVObkN3SE9yUTV3WFA5by9XdVBNYStl?=
 =?utf-8?B?bmd5WkF5dVEzelQxNzY4WjE5V210STN5U1d0bHJRaGZQcWlteVpqQks2NnVi?=
 =?utf-8?B?MDNFdXgrc3VYNEc1K3J5YUdwUFlnRGJJTmcxVWtFRFVmeUVLR0NadXNpdzV3?=
 =?utf-8?B?ME5xTTlFNHlhZTBUK1dkNlUyS0tZWlVjRGp4cUJ1YVJwdnR2YVgxTmZzVzEy?=
 =?utf-8?B?SkdncEI1Sk5oTHFydTVTTDh1RU9VNE5YRW5hK2k2bE1RQjZpS3RrUENJQ2Ju?=
 =?utf-8?B?M2dTWEVxZGU1Rkl1MEU0ZFgzY1JDWVhVQTI4cURyY25kVC9ORTNZMFU3dXFC?=
 =?utf-8?B?OFcxenFOVmdVUHVSVTBXNGcyZFNyNm44N0FET2V2elAzT3gycGppeWtLZGlr?=
 =?utf-8?B?c2FaNXNGVW9aQit4ZmR1ZzB5S0tUay9iTEZQUi9yemxVRjBRUEVDRStsTnEz?=
 =?utf-8?B?ank5Q2dZOVYxN3VaR0NKdmo2RTUwelI0bjJvK0NRMkRaMXBzNjhRbTk2VGRD?=
 =?utf-8?B?Tkt6SWRDUHhpSi9SQ1p3alUzLzdRVWVzRGU4ZUJhSk9nSG9JSURmcTUxcjlv?=
 =?utf-8?B?TnhvSEwwMzRpRVNUMkRLSEpSQ3dPc0ZvOGdwN1g5dER0TGl5V0lWSDBZeEhw?=
 =?utf-8?B?UnU3aW9MTWUxMjFBRXFDMU9tam1JeU9lRmRPTWFyQ3dtNHdHek16RFFkTGJT?=
 =?utf-8?B?SExqNFN1djM1OEtvdTVGNUpuc3B2Mkw5K0NqYTlMZkZPWURqbUhIa1o4Slp0?=
 =?utf-8?B?eko0NEdibWFiSGRuT2J5amg2TGdFVFNoMnhMWklBcTB3cjJ5WDVtdDBEaTNQ?=
 =?utf-8?B?TG84ekN5Uzl3ZXRFd1YzajlSSFNOYkxCZTZJbmkwWDVsQlNST3B3QjJlYnJ5?=
 =?utf-8?B?REEvalc3WkIvbUV5UTd5UjZkTTJicTNFejhLRGJjY05PcmIrKzNTa2RMTlhv?=
 =?utf-8?B?RDRjTzJLR1JPdFV3bGhSb21Ha0xHcXpJYndEK0VCdktNcWlTREhtNFJLK0xK?=
 =?utf-8?B?MFBUMDk3R0p0ZUY5VjkxVG56SXlQOUZQY2V1dHRWQlphejY2MENLK21KRTN3?=
 =?utf-8?B?ejl5L3kyOHllcjJTNlBBUWJ2bC9NaDMxN1djZGI4OWpscFpYT3FNVDVCM1FU?=
 =?utf-8?B?bnJRZzRxQ1JLNUtRRk9jSUtySEdiUlUyZFJOc2pzbm51a1N3cC9IbDdHNUJx?=
 =?utf-8?B?T0FRSWxxbkhHSzhlb2t4UnVUZUxQTXVuMm90bHFIQkZyNEIxejRMV0dSTW4y?=
 =?utf-8?B?ek1GMW9Fb0F2cmJUdnFKY2dndkFtMHprOSszWitjOS9mOVoyaWlTRXlzdnNM?=
 =?utf-8?B?dFpqa01CdjVOTEFFL1RSQ21FVWNuTHQ0K0Z6TVFiZFo5YVJabThmdVRNSTBK?=
 =?utf-8?B?bk95LzFvKzkrWWI5Q2QxY25GTTdUZm4rYkNnekp2VDZmWHd2SjAzNGpqRGVo?=
 =?utf-8?B?Z2RleTZ3U2labzZIQjhHTVRkVmp1VmF6Z0hqcmNBREN4QzhjL3d1Z2hPdTdE?=
 =?utf-8?B?a0o0TGFseXVUSlhYb20zdlJqU2I4M0V5SEdiQ015b1N2Nlh0SHNHVE1sWHJU?=
 =?utf-8?B?STFCc0NEVUt0dmdFZW4rMTVvbGdlSUszNVRGMFpIaU5VaVZkVkxCM3dyZlVx?=
 =?utf-8?B?M051cWxsUjhmUUJjanNZTTR0NEhNWnVDQkx0NCtLbEgzRDdiMFJ3c0dNSDI1?=
 =?utf-8?B?K01Dc1dUbGNIcU5VUFVtSXR2Mk9NNXBkaGpHSStYdm44V2JlSmxrSnlaWUJK?=
 =?utf-8?B?MkxFZVJVdEc3V0d0MlV0NHFEbVZ6Z2YwTlA4WjJyaWJCZzkvTlpTOVZHTjA3?=
 =?utf-8?B?ejhtbkNrcWRVYVhXclNSaFZ5TWg0ZEhyNXN0R1JrY2REL3l6R3NYZDd2QnZX?=
 =?utf-8?B?Z1VTbFAyc1NmcmFBemhxaHIzWDlzMVc4UTROZWl4ejVXWVpaMzZsY2grVGNh?=
 =?utf-8?Q?hUvz8RBKUp0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUh6ZzhUTWJXcVVReHlRTG02TXdKUXVnUGpZcXdFekxBNEhBbGtiamo2YU5v?=
 =?utf-8?B?RUdreGdxZzQydUxsQy9hR2h0QVB3UGVaS1JZWnZWWkRRYXFUN25BT0ZXSDRN?=
 =?utf-8?B?dG5VbmF1c2VjOFFLcHBZRXNLeHg2ZksvV1Vub3FHTFdzaGt2RDloYm5CMFRG?=
 =?utf-8?B?WS9QT0ozSzZMeURwb3JZWlhsQ0RMc1U1dzlTYk1DOXczQkt2aE0xTXpndWdz?=
 =?utf-8?B?b1l3ajJLNXFDSHVyNkpSRXB1ektVOEVzS1VXMmFFVmlvNWJwRFVSNXFRR0ti?=
 =?utf-8?B?YjNoSWxTbTFIdjNzNkgwTVl2NVFvZmRqQ0czckVwRUdYVHpwbDFweU5uWlF5?=
 =?utf-8?B?SlVDVnBGYUpZV2xUOUx3YWNwL0JCZDFncHpxOFovZUxNRUNITG9jWW5JaVlu?=
 =?utf-8?B?aFFvQ0o4aGFLREpscDRjeXd2OFJWSEQwQkZ5YllLUHVoUFd1UW5ocHU0OUJa?=
 =?utf-8?B?dm9Bcm5pZTdFWTBtcmZOc2draU1zVHp0cUlHWGF0cUJ1cEdCWVdPdkxrOTls?=
 =?utf-8?B?UHhGQUZxTDdNNVBrMGJtWVNKaXBMNnNldkRsclZXcDdWUjdWbC9ZZnlHcm9T?=
 =?utf-8?B?RXFWK0tSczJ0VFJOYWdlbUZmL1lBcmZlZ3g0eWljdG1tdHJiTzk5cEpIempm?=
 =?utf-8?B?cWlkQW96TzIxT0EraDJGdm1Pc2lBQStueVFUbTlQY04yZ1RwSDlWR3ZIb3NO?=
 =?utf-8?B?SEE3Mm9yUGttNnJjRnpwRXIwRnRhb3FKeDhuTVliZm5CcnRzdmVHeVdjdFBX?=
 =?utf-8?B?c1p4dkxuUVpCb1JxOFhYMHpmM2RUTTBpZnVNT1hTUEdLSGlZTHI1RitWRjdG?=
 =?utf-8?B?anQ0d3hkQTlWL05Uck01RTVKclhIelFHVXYyK1hqaU10N0ZoZ2JOd2MzWURl?=
 =?utf-8?B?MGVHQVVERGZsL1JyVDZ4V1krYnNyU3NXeXR0b3BzdEUvVmFUM0h6WHpRdkRC?=
 =?utf-8?B?cmlYeFZuWDhZYWwxcG9uVkFvNVBFOUpkUC8vdmIycjdOQXFsVVJYVlJmaUcy?=
 =?utf-8?B?K3JmRDIrWGVtTDlaODFTWlJSbllzcE5IWk9KREtMVDUrcDkzWWY4YjdVMzlt?=
 =?utf-8?B?M2xNRjZwVHV4dEdFeEp1YlZMRVhjVlNKZ1J0SlhObEVpUHZxZ1h1d2JxTk1k?=
 =?utf-8?B?b1UzNGN4QTdqZ1RFL1lLUVFsWVVHcG5NYTJoUm9WV2Z1cGNjZzRBRjRpTVRP?=
 =?utf-8?B?eXkwT1c3UG5iUUxzR2VSWWRwTDRodGZYN2RvRlhGRWxoVDNVdDcyNVZIMWov?=
 =?utf-8?B?Z3plV0h0dDNSTHVJcFFEK0ZYNWFHN3NtL3l6L1RQRU5oU1VjdlZrbEhGbWtN?=
 =?utf-8?B?N2pZcDR5SGdKOEZOdTFuOHJaaHVWVVNZdTZoNEs2czJDdVJVKzJwakJ2UWll?=
 =?utf-8?B?TnRtM1RyMWd1OTR2ckRDRU9JWFpkR2RWUi9OQkN2LzVpRDd4b3FuSmRUWjls?=
 =?utf-8?B?N3pFOVdlUEJBcHljYkpVZ2lZK3ZmSDMrSXNNQitwQkg4N0cwUWEzWUJGaTJL?=
 =?utf-8?B?bXFUSGZzT0NieVdyK0VaSk9KRVZyeW9uaVRHT2UrT2NiRkFnOGx4UmNKTis5?=
 =?utf-8?B?SW9TVWJ5SEdqVmJKSW40RGRuTGxSaERxNVJna0xHTU94dGp1dndMMXhxOEpj?=
 =?utf-8?B?TnhVRmQxdjNJTnV5NjNWM2tBL3hWbFViUk1xUHpPZlA0QnlKS1FWVE1wTGtV?=
 =?utf-8?B?YWxoU2FyV1QzM2o4Sk1reEZyYzF4YkRkOEwvTzJPeHJlYUg0bDM3U0lDa1ZJ?=
 =?utf-8?B?c3FUWlFVWTJma3VleVRXOUk4R1hMbEU3dUlXRUc1S2MyM0NUWTZBb2ZQT0ZC?=
 =?utf-8?B?a25SNW13emFzdnBTNjk0dE5wQTNUWlorNjNSZThGY3VLL055ZmdMNEN6TXhO?=
 =?utf-8?B?MkxsejZ1RW5qVXcvNHBETGx0N2hlbFYyeHI2QzBkQUFNU0JMOUdGcFJqb2NV?=
 =?utf-8?B?MkIyZnM0d3ZSYjBxU2tqeVUydWF1RWZlRjQ3T1hxeTdmSXluTWNVcnAzMjJP?=
 =?utf-8?B?bVZGVHBENlA3UjVNM1NBTXM0WkxOU3YrWlU1ZU5McnppUjROdDZXaENGWHpU?=
 =?utf-8?B?STNiekJEaDQ5aFk2U3hsVkp1MHNndTFScHYybFhtQ2hKTE9xQzQ4dGhBYzd4?=
 =?utf-8?B?Rkl1ejF0bU1ZWmV0TzRNbEdYMDRHN1lab0RqVUgvaUVHRFY2eklETGFUY1pL?=
 =?utf-8?B?TjhhbW1adjNtUlllTGR1T1NQWnZiZm1VNUxYTTNaaW1YUjhpUjVXU0kvVXRr?=
 =?utf-8?Q?27TgRos4/KpFYUuio6c8CP3OGrYofwnX8ORU9ddLD8=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7293261a-8056-4098-a4ed-08ddebd55b6d
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:06:15.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcXyWB7aUfpCUbkw8Qvd6FnKP5ZaWDi1FNfcD4eNKlISoKdDI53xhwrqEOrS9VuEFSkWmBzn6c+0ZMW+DvNp0R50B0SC5RWwXrfY5U5izRQ+CS024/6OiWzgMsBJoouV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8943

Answers inline.

On 9/4/25 07:00, Sudeep Holla wrote:
> On Mon, Jul 14, 2025 at 08:10:07PM -0400, admiyo@os.amperecomputing.com wrote:
>> From: Adam Young <admiyo@os.amperecomputing.com>
>>
>> Define a new, optional, callback that allows the driver to
>> specify how the return data buffer is allocated.  If that callback
>> is set,  mailbox/pcc.c is now responsible for reading from and
>> writing to the PCC shared buffer.
>>
>> This also allows for proper checks of the Commnand complete flag
>> between the PCC sender and receiver.
>>
>> For Type 4 channels, initialize the command complete flag prior
>> to accepting messages.
>>
>> Since the mailbox does not know what memory allocation scheme
>> to use for response messages, the client now has an optional
>> callback that allows it to allocate the buffer for a response
>> message.
>>
>> When an outbound message is written to the buffer, the mailbox
>> checks for the flag indicating the client wants an tx complete
>> notification via IRQ.  Upon receipt of the interrupt It will
>> pair it with the outgoing message. The expected use is to
>> free the kernel memory buffer for the previous outgoing message.
>>
> I know this is merged. Based on the discussions here, I may send a revert
> to this as I don't think it is correct.
>
>> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>> ---
>>   drivers/mailbox/pcc.c | 102 ++++++++++++++++++++++++++++++++++++++++--
>>   include/acpi/pcc.h    |  29 ++++++++++++
>>   2 files changed, 127 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index f6714c233f5a..0a00719b2482 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -306,6 +306,22 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
>>   		pcc_chan_reg_read_modify_write(&pchan->db);
>>   }
>>   
>> +static void *write_response(struct pcc_chan_info *pchan)
>> +{
>> +	struct pcc_header pcc_header;
>> +	void *buffer;
>> +	int data_len;
>> +
>> +	memcpy_fromio(&pcc_header, pchan->chan.shmem,
>> +		      sizeof(pcc_header));
>> +	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
>> +
>> +	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
>> +	if (buffer != NULL)
>> +		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
>> +	return buffer;
>> +}
>> +
>>   /**
>>    * pcc_mbox_irq - PCC mailbox interrupt handler
>>    * @irq:	interrupt number
>> @@ -317,6 +333,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   {
>>   	struct pcc_chan_info *pchan;
>>   	struct mbox_chan *chan = p;
>> +	struct pcc_header *pcc_header = chan->active_req;
>> +	void *handle = NULL;
>>   
>>   	pchan = chan->con_priv;
>>   
>> @@ -340,7 +358,17 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   	 * required to avoid any possible race in updatation of this flag.
>>   	 */
>>   	pchan->chan_in_use = false;
>> -	mbox_chan_received_data(chan, NULL);
>> +
>> +	if (pchan->chan.rx_alloc)
>> +		handle = write_response(pchan);
>> +
>> +	if (chan->active_req) {
>> +		pcc_header = chan->active_req;
>> +		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
>> +			mbox_chan_txdone(chan, 0);
>> +	}
>> +
>> +	mbox_chan_received_data(chan, handle);
>>   
>>   	pcc_chan_acknowledge(pchan);
>>   
>> @@ -384,9 +412,24 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>>   	pcc_mchan = &pchan->chan;
>>   	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
>>   					   pcc_mchan->shmem_size);
>> -	if (pcc_mchan->shmem)
>> -		return pcc_mchan;
>> +	if (!pcc_mchan->shmem)
>> +		goto err;
>> +
>> +	pcc_mchan->manage_writes = false;
>> +
> Who will change this value as it is fixed to false always.
> That makes the whole pcc_write_to_buffer() reduntant. It must go away.
> Also why can't you use tx_prepare callback here. I don't like these changes
> at all as I find these redundant. Sorry for not reviewing it in time.
> I was totally confused with your versioning and didn't spot the mailbox/pcc
> changes in between and assumed it is just MCTP net driver changes. My mistake.

This was a case of leaving the default as is to not-break the existing 
mailbox clients.

The maibox client can over ride it in its driver setup.



>
>> +	/* This indicates that the channel is ready to accept messages.
>> +	 * This needs to happen after the channel has registered
>> +	 * its callback. There is no access point to do that in
>> +	 * the mailbox API. That implies that the mailbox client must
>> +	 * have set the allocate callback function prior to
>> +	 * sending any messages.
>> +	 */
>> +	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>> +		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>> +
>> +	return pcc_mchan;
>>   
>> +err:
>>   	mbox_free_channel(chan);
>>   	return ERR_PTR(-ENXIO);
>>   }
>> @@ -417,8 +460,38 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>>   }
>>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>>   
>> +static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
>> +{
>> +	struct pcc_chan_info *pchan = chan->con_priv;
>> +	struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
>> +	struct pcc_header *pcc_header = data;
>> +
>> +	if (!pchan->chan.manage_writes)
>> +		return 0;
>> +
>> +	/* The PCC header length includes the command field
>> +	 * but not the other values from the header.
>> +	 */
>> +	int len = pcc_header->length - sizeof(u32) + sizeof(struct pcc_header);
>> +	u64 val;
>> +
>> +	pcc_chan_reg_read(&pchan->cmd_complete, &val);
>> +	if (!val) {
>> +		pr_info("%s pchan->cmd_complete not set", __func__);
>> +		return -1;
>> +	}
>> +	memcpy_toio(pcc_mbox_chan->shmem,  data, len);
>> +	return 0;
>> +}
>> +
>> +
>>   /**
>> - * pcc_send_data - Called from Mailbox Controller code. Used
>> + * pcc_send_data - Called from Mailbox Controller code. If
>> + *		pchan->chan.rx_alloc is set, then the command complete
>> + *		flag is checked and the data is written to the shared
>> + *		buffer io memory.
>> + *
>> + *		If pchan->chan.rx_alloc is not set, then it is used
>>    *		here only to ring the channel doorbell. The PCC client
>>    *		specific read/write is done in the client driver in
>>    *		order to maintain atomicity over PCC channel once
>> @@ -434,17 +507,37 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>>   	int ret;
>>   	struct pcc_chan_info *pchan = chan->con_priv;
>>   
>> +	ret = pcc_write_to_buffer(chan, data);
>> +	if (ret)
>> +		return ret;
>> +
> Completely null as manages_write is false always.
Not if re-set by the client.
>
>>   	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>>   	if (ret)
>>   		return ret;
>>   
>>   	ret = pcc_chan_reg_read_modify_write(&pchan->db);
>> +
>>   	if (!ret && pchan->plat_irq > 0)
>>   		pchan->chan_in_use = true;
>>   
>>   	return ret;
>>   }
>>   
>> +
>> +static bool pcc_last_tx_done(struct mbox_chan *chan)
>> +{
>> +	struct pcc_chan_info *pchan = chan->con_priv;
>> +	u64 val;
>> +
>> +	pcc_chan_reg_read(&pchan->cmd_complete, &val);
> Not checking return from pcc_chan_reg_read(). Be consistent with the
> other code in the file.
OK, this is legit.
>
>> +	if (!val)
>> +		return false;
>> +	else
>> +		return true;
>> +}
>> +
>> +
>> +
>>   /**
>>    * pcc_startup - Called from Mailbox Controller code. Used here
>>    *		to request the interrupt.
>> @@ -490,6 +583,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>>   	.send_data = pcc_send_data,
>>   	.startup = pcc_startup,
>>   	.shutdown = pcc_shutdown,
>> +	.last_tx_done = pcc_last_tx_done,
>>   };
>>   
>>   /**
>> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
>> index 840bfc95bae3..9af3b502f839 100644
>> --- a/include/acpi/pcc.h
>> +++ b/include/acpi/pcc.h
>> @@ -17,6 +17,35 @@ struct pcc_mbox_chan {
>>   	u32 latency;
>>   	u32 max_access_rate;
>>   	u16 min_turnaround_time;
>> +
>> +	/* Set to true to indicate that the mailbox should manage
>> +	 * writing the dat to the shared buffer. This differs from
>> +	 * the case where the drivesr are writing to the buffer and
>> +	 * using send_data only to  ring the doorbell.  If this flag
>> +	 * is set, then the void * data parameter of send_data must
>> +	 * point to a kernel-memory buffer formatted in accordance with
>> +	 * the PCC specification.
>> +	 *
>> +	 * The active buffer management will include reading the
>> +	 * notify_on_completion flag, and will then
>> +	 * call mbox_chan_txdone when the acknowledgment interrupt is
>> +	 * received.
>> +	 */
>> +	bool manage_writes;
>> +
>> +	/* Optional callback that allows the driver
>> +	 * to allocate the memory used for receiving
>> +	 * messages.  The return value is the location
>> +	 * inside the buffer where the mailbox should write the data.
>> +	 */
>> +	void *(*rx_alloc)(struct mbox_client *cl,  int size);
> Why this can't be in rx_callback ?

Because that is too late.

The problem is that the client needs  to allocate the memory that the 
message comes in in order to hand it off.

In the case of a network device, the rx_alloc code is going to return 
the memory are of a struct sk_buff. The Mailbox does not know how to 
allocate this. If the driver just kmallocs memory for the return 
message, we would have a re-copy of the message.

This is really a mailbox-api level issue, but I was trying to limit the 
scope of my changes as much as possible.

The PCC mailbox code really does not match the abstractions of the 
mailbox in general.  The idea that copying into and out of the buffer is 
done by each individual driver leads to a lot of duplicated code.  With 
this change, most of the other drivers could now be re-written to let 
the mailbox manage the copying, while letting the mailbox client specify 
only how to allocate the message buffers.


Much of this change  was driven by the fact that the PCC mailbox does 
not properly check the flags before allowing writes to the rx channel, 
and that code is not exposed to the driver.  Thus, it was impossible to 
write everything in the rx callback regardless. This work was based on 
Huisong's comments on version 21 of the patch series.

>
>
> I am convinced to send a revert, please respond so that I can understand
> the requirements better.




