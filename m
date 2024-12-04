Return-Path: <netdev+bounces-149024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899A9E3CE0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182DB283536
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E099A209691;
	Wed,  4 Dec 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cm29lFUn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66291FECCF
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322871; cv=fail; b=VPZqkXcybYHq8Vsutdf5RCv8+DXQXUh0DJT1gQqAetldwGAh5Jnzl4RK7hhzxgzsg72CJsKet60ruzjfBuIP9+I0ooiPJ0ecDD2nC5tCTUizqSbedrtxB9eqC9muRqAGxr/VGcRsKVv+4nicEOZWnLLw3aScJjNeYzZ0qelmdlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322871; c=relaxed/simple;
	bh=ubA0PG1kJcqqzrbHkhBH6JD6vucDVALIzlQgcQyypLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jT0ePva0QW2s82WF3jJx/BPvELqSstV+yvfkIodGKJBqa8fUyQ3hs0zXk9kfahxUU9nIyxqG9lxt26oZAgqnPrM4+kVXIaIHRYvmR8PYL/UKii1/gzVZDeikyw9UyakewAp1Qefi+prF4oYWOHbGdCBvHA2XcKUll/L0dng7a9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cm29lFUn; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGAsqGFAfdKatEyyUKBeH11TMPU3WNLudA1uwUDRghQ/MlN7U3enzjb3K0hAQGfdU1d3euGfE1ErVd1N4i/UwxMalz6dk+yRZFfF/f83F521XebbWBv6St6WLsSHc7dzKrza50OjbwG6d2mP3yAr9P1BCR/8uxfqAvBsJFczgFsGyjYWg2L/VZLxjr9bNnwpxAjfjwk/4wPGU1dAzbWnQL9slxtM39giC5VtzH5PBojwtUjYBVlRhKg09K5jxDrOGvt/tDgnIbfATHGcoANfA503ouxAQnLkup0X9YulQv/uyQuPHsucnQIq7ohTc1eMrGhEDm8AiYceKVlFcdo2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX2YcxxA40cHakcI9iSh+VgvzIg7G9x3JlMIqQuTY6o=;
 b=LlfkSSj5/wSuyl8eEyl3zVBiY97Ltz5AvirngaqrIdznLelWeFLbRJCR+dmreSFBrwAWD7SPpzOXCnPYMWcF9WeCXyPou5m/QilYsJTVWfX4R5ovumQqr1GHwKzc8ogdbZYPMGJqan0s+RO0ShdAHyHuigeqMsf86sLk99JqYQQiB8Kus5tg2r3P8N1yHFiZPxqh2V3nLm9ydV6o30dGRmecaWdVtcpFotV6COfwH2/LR0UgajbaaTIpcBLVS9B5ZfKqRMyiW7Fs98J4OAVKCPaKrU0PyunHPGeUFjvINqK8lu1hmorfGHC1iZZbZzszJs94SAB9pSYbefvO6ETcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX2YcxxA40cHakcI9iSh+VgvzIg7G9x3JlMIqQuTY6o=;
 b=cm29lFUnfamTIqVJeLuTFY3f3Oe1MaVTjvsIlgmV7zyX4oAW9F5QKqpCIlmlUGKEvRxIYx6bIxN4ZtzO5jucRoH1LeM0S51b0pQfBNokhr61BVWXXATokxcNOA0L5mAMvqO41/OlgFuMaDBm7kMo3xHYC+9iNi1H4kKlGFZ17DQ0MORfbIOuBW6SEZmv7HeSwesPfaDFFKe4T3fvHU+mKmqj14+sf95XrhINycapqreWONpKa1CBeeapB7b26VhVXoGk7fKwKcnfsehnIU99BoMH2GB4VjE65NfrEzTE+nYN7gkJ1v7LeKGSJOgUonU57W9y1tx7l11gHym/B6DHuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8620.eurprd04.prod.outlook.com (2603:10a6:20b:43b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Wed, 4 Dec
 2024 14:34:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 14:34:26 +0000
Date: Wed, 4 Dec 2024 16:34:23 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: avoid potential UAF in default_operstate()
Message-ID: <20241204143423.eewibpbgnuoqyyzn@skbuf>
References: <20241203170933.2449307-1-edumazet@google.com>
 <20241203173718.owpsc6h2kmhdvhy4@skbuf>
 <CANn89iKpzA=5iam--u8A+GR8F+YZ5DNRdbVk=KniMwgdZWrnuQ@mail.gmail.com>
 <20241204114121.hzqtiscwfdyvicym@skbuf>
 <CANn89i+hjGLeGd-wFi+CS=HkrvcHtTso74qJVFLk44cVqid92g@mail.gmail.com>
 <20241204125717.6wxa4llwpdhv5hon@skbuf>
 <CANn89iL+2NeV59p57bN+hc+vWB61DWWjRKAoit-=QHXC0C=RBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL+2NeV59p57bN+hc+vWB61DWWjRKAoit-=QHXC0C=RBg@mail.gmail.com>
X-ClientProxiedBy: VI1P195CA0091.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd08851-9ad4-4d38-171f-08dd1470c0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVhLK0pNMGIvQW1NeWNNUzlFM05WUWJDSnJPM1UrNjdsWGRNRnl0a3ZpMWdX?=
 =?utf-8?B?V2dOR2ZiMUhDekFPN0lhM0wvNjJhTjEySXlBV09tWXVPK2REUVgwL2Vhd3pN?=
 =?utf-8?B?bGhKVXRBWWd1Mzd2NFpoNjMwTXNDbC9yTlV1bUhYK3F1TlpuK3p2cEg0S1hL?=
 =?utf-8?B?NWoxT1E0Q3ZxODl2MFRkdVJndUkzckpBdnVIZGx1Y2F3UmkxNDhWSjM0alE1?=
 =?utf-8?B?UmFZandwZ0o3QzFTcHd2YUU2VERZdzcwdWkvVGo0NXFnYjQ0RkQvUFFjWUZ6?=
 =?utf-8?B?MVk5b3hybW5VY0Z0aHVrejJTM01UUVFCZmMxZHJ4QUlFOC9DaTgxWU5IQmpG?=
 =?utf-8?B?dUJYcjRVNTN4NFlxUHdlMDdhOG1Zb0hsbU9XRmxYanRJREYwekdBMXlHNGZv?=
 =?utf-8?B?bGU0b0JLUmVSeTdiRjQzR1VvWFNvWFM4ZXc0dWxuUkxHVFQxZktnWGRQYzM4?=
 =?utf-8?B?bElSZnA1cXpwTzh1ZEJoOXdGMjZhaVJocHdtU1NEM3J5QS8wVWJVeVRpRFFK?=
 =?utf-8?B?bEU2N2RrNUREbVE2NFdVZlRpNU5aRVpYZ0ZSOU9TYU5TdGIzcDFtM3I3U3Vt?=
 =?utf-8?B?VzgvMzlNdlNORHJoUEx0RXd4a3lSWUdaeU9NOVlQQm96NnYvejVMS0s5VGx6?=
 =?utf-8?B?MGFhQTBGd0ZoVmpkOHJZNzNTc0NsSThIalhVb05MaUdUOG43OTJ2MzR4bUNI?=
 =?utf-8?B?cGJiMGU4TkVWNjlhTGMvek4rejdlcTJ4aVV5L0dYOWRNQzlxVDN2YmQyRjFv?=
 =?utf-8?B?RVhIazFaSm9WSktzeGlhMFhDcEFHVTlpQThFTWI0U29KSVJBbEl3N3A5S25Q?=
 =?utf-8?B?b0RLcTAwalZKajI4a3Q5S1BBUVoyS1pYSklFcFRkcGtJT0dUUWpyVWtxMVZa?=
 =?utf-8?B?SHhSMElIUGorTlk2MU5BVmZSUnJTRWpyVzNSdWEyWUtJSHlqSFpGUVltOXR0?=
 =?utf-8?B?aTc3bnhlZ0FGcFM4SUFtSTUrcHdUdVc4cXhiS0RPRDRuaFphQjZuNCtaOERW?=
 =?utf-8?B?eGJMVUZBK2hOSnlDWHhhbThscXd1OWJaZFV3YkN0MlR0SGVSYXFENEtrK3JL?=
 =?utf-8?B?V3lFek5kZkNRV0p0S3pUMlhyaTZnazR0ZGRsaTBKa3FZT08wK212MGt1cWRO?=
 =?utf-8?B?eE1KbVIwZnlQWkFiM1pZK3ZCeXhBU2I2bUR6My9OOVlNeXB1dVFDbU02cTRn?=
 =?utf-8?B?eDZMbm4vckttcE4rVEtaeGtETXV4ZHZqRHdISXdLRzVlTHgvWms5Wk44MXdQ?=
 =?utf-8?B?cXdlOHJmdFQ1N1FzRUZCc3RrdjkzVUJ1QURGRnBTZDA0NTBFZlZPbGdHQk9x?=
 =?utf-8?B?UmdsNTZXSWVHclV3Z0w5dXFvQllkM0llZnpSLzhPNVcxU3VTdlllZkhWd0Nq?=
 =?utf-8?B?WjBHSXc4ckJ4cG9hSUNTb3BobFdVNGVMdWN6S2tPOHArQ2pZeVQ0TFU1dHRK?=
 =?utf-8?B?OFpkamxxWERGcHVuQ2xzVjJxcXBFV1pvdk4zSklwK2VFRlFFZ0FGK2xyQnE3?=
 =?utf-8?B?QWpIWjVJUlNMK2hqZkZ0Nk9UYUhPenFyekxHaE05YUp4ajVpVHdTYitaSWVy?=
 =?utf-8?B?RUY0YWo1S2hXZVNJQTFoazNJRmViSko3QVd0enBoL2xKaHhLRmdUYVM4YUFU?=
 =?utf-8?B?bHZvSXhLWG5vK090Y3Y3cHdvQkJuaUNra1l6WElvYmRjVWE4TUxvNEs4K3dy?=
 =?utf-8?B?MXNQVmpBcWhkVTQ4N3RVY0ZPbkYxV2hqS2VHcTM3dzRYbVNCb0JFUHgwMkk4?=
 =?utf-8?B?bGlBSXJnMk5uRmxRckEvUlU1eUJNaE5VZXFZZGtiWTZ2YnZETjJkVVVBYnJt?=
 =?utf-8?B?M2pxaTdvWHZUUjZ6UUIrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUl2K210bXdId1NWa2U2WWh0RS90SVJVakNBOGo1UGVmbXlMVEVSa0dmaEVH?=
 =?utf-8?B?bVk4OU9aTFZoNmRIVmNiV3NtbDUrRG1CY0FuaWhKN0pFeU5pZlhmY2ZWcTBu?=
 =?utf-8?B?TlhKWkJZK0w4ZmRWUGJjYmY3WDNtdjlMZ2dMc1F4bFFQeTVrWnFUU0M0b1d4?=
 =?utf-8?B?WTZTWURLU2ZyKzdseVlGdUJNT1NzbnlhVElReUZRN3JrOXh4cE1UZEsxU2ta?=
 =?utf-8?B?VWNlWnpwSTVhNG5wRE9GWUk0VUlZdzRHTjZ4cFdMaDMyZDNycThHZmVDSnJh?=
 =?utf-8?B?MUpmOUcrc2psQ21ZQlZmR3lLcUZCYitWWGNaYkJ3cEVSc1JyUkw4dzg2dGJv?=
 =?utf-8?B?UTNlTU8wTFVCcE91NWR2TDJpKzVGWjJhSEJiQUo4YUFKU1loUWhObzYyalc3?=
 =?utf-8?B?eDFEbGZSeU9acUNCL3VORzkvc2kvaG1oY2RHTjFQeW5ac1pUbEN6VmZTTWwx?=
 =?utf-8?B?N09kUGhnQUpwY29DNk9ZVzBFSVBBUmd4UlhZWkhVa0lWdnh0Q0Fqcmx2NVhS?=
 =?utf-8?B?T2pwL2VUUlFCRC82OFg0dEVmbVBPaUlWVGJzdnJnL0J2SHlXRzg5WE9ScUU4?=
 =?utf-8?B?dEU2eXBpVkFWeW1zVDZrRFcvK2Zic0lZTitXaTJzVVIzL0tKSlVqTHB1NGw1?=
 =?utf-8?B?UDhaMVUwOExURG5tMGY5cm52dTlvVnQrMFMvS1FqSjVPeUJ5dmtDOWF4NFBT?=
 =?utf-8?B?Q0lFQXRTYXp6SENUMFVGaUdYYVQrNnRFQjhSUzRsaE01UTNqbUx2SVNjUFVF?=
 =?utf-8?B?U3VVdmYwTDNzVEVHbmhUeldyYSttak03UEVSN09mMFVVL3JjaEZqZ1ZweHJk?=
 =?utf-8?B?WEtRV091SC8waVIyNTV1V3RkL0lXTzdKQkJCQWNHM1pDTThubXNDK1E5ME13?=
 =?utf-8?B?YjlXdnNjNE5DbXhOQWlyZWQrYk92T3NhSi9yaHN3bEw1NkQ4eVVvWlFodjN5?=
 =?utf-8?B?ZVdZeW1lNzVZaENlVGJqMjFBTTlocldBSDFVWFIzek9UU1RvWXJ3SWRiRGVu?=
 =?utf-8?B?ekh1ZWdBL2QwZ1JycnMwUTRZNzRtNTNpU2JOVXdTcHFoZG5MVXczd0IxcVV6?=
 =?utf-8?B?TkQvVVFNa2Q4aWVUeFI0NUIyVklicmVoU1dGQzdtV1N4NXV3czlFaVBWdlht?=
 =?utf-8?B?LzRzZm5JM3poamZKMFFpV1dLTEg0MTZyNUxISk1SRUxHNkdsbmJyaC9MRCtP?=
 =?utf-8?B?UWFmRXdkREQzcFZTYnh6NzNNcVVEdFJQaFNGMmhFbit2dmZJcmVUQkpLaCtO?=
 =?utf-8?B?bitVQTNwK2NFNVNvT1dTOEFSQ29IYlAyMHhtL2xJUlhCNmx1SVhjSktVTGJD?=
 =?utf-8?B?OWZDZTEwbW4vZXRjNHcyVDVKWHdmS2lVaUMyNkI4Nkg1bGJTSWJjUVFpQVJ3?=
 =?utf-8?B?RXFzbFlGK2s0RUIrVERGOXBLMHI0ZUpqK0JnbzR1RzYwelNVbjlFUEVzcjFD?=
 =?utf-8?B?RWpZcFlzUHQ2dDc2RHZyb2ZpbkJRMTU3RmtuYmd6RnUrSmg0eXFRU0FGWmJS?=
 =?utf-8?B?NkZNTnRZdytGeGVVd1ZadGdrZE51S2hJZzc3TXVIcThMSDRjNHlsNUpoNTM2?=
 =?utf-8?B?d2YxVUdsN3VSN1BKRXN6NmVvQk5hTldOUlZGeHZYREMwcjlqLzArUUNYOXVv?=
 =?utf-8?B?dUdMRUNFSDR6Q2dKZFRyT0s0WjRBdnFmZW9jVjVPTnRWTXI0aU1VaExNT0lH?=
 =?utf-8?B?dDlJaFhpMElKcGF2RHk5eTB6UEZLcFN2NzA4UXUvU1A1RmZFU0EzNzNzV3hr?=
 =?utf-8?B?aUlqeWpqSkFiaHVYb0p0M09SNmtRa2JIRjJXUU9OTUJlRnd4RHlXT21CNzVu?=
 =?utf-8?B?b1NRMTVXOThnY3hLamExc2djbHc5b1paakZ3RlJmUWZHYmJHZ2QwTUhVS0Nr?=
 =?utf-8?B?bkVOT1VEVGJwQUV6SGZnWXpRTG5lNFpKR0JIdk1Gakp5cXQ3T2xLT2lBM2Vr?=
 =?utf-8?B?NHFLREdIMkptbWtPV2xBYnFoUElPMDZ0UW5YWWx6c080T0ZKc09sNVQzYS9M?=
 =?utf-8?B?ekZwWHFpVXpmRXUwaGJsejRUbjFTNzZUVmRkeU43RUd5d25SVnVKdlBKVUtV?=
 =?utf-8?B?US9xK25TUTZPSXhGSGcyUWY2SnMvSytSdk93Wnd4S3lVVXRGazkzWkhyMS9I?=
 =?utf-8?B?U2QyODlNelJHbnJkbFBGU1IyNHdueU1FWVJ3cUQ0TU5mKy9EaDhBTXVjRElj?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd08851-9ad4-4d38-171f-08dd1470c0b5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:34:26.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JskV8UNrzuF9HDV8H5LEeR1vHp3jrLJcT+wsD0U0ktAobyzK5ATroogVOcc3yu/0/U+MDBaLXptZi5FVqASkgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8620

On Wed, Dec 04, 2024 at 02:38:14PM +0100, Eric Dumazet wrote:
> On Wed, Dec 4, 2024 at 1:57 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> > On Wed, Dec 04, 2024 at 12:46:11PM +0100, Eric Dumazet wrote:
> > > On Wed, Dec 4, 2024 at 12:41â€¯PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > > >
> > > > I meant: linkwatch runs periodically, via linkwatch_event(). Isn't there
> > > > a chance that linkwatch_event() can run once, immediately after
> > > > __rtnl_unlock() in netdev_run_todo(), while the netdev is in the
> > > > NETREG_UNREGISTERING state? Won't that create problems for __dev_get_by_index()
> > > > too? I guess it depends on when the netns is torn down, which I couldn't find.
> > >
> > > I think lweventlist_lock and dev->link_watch_list are supposed to
> > > synchronize things.
> > >
> > > linkwatch_sync_dev() only calls linkwatch_do_dev() if the device was
> > > atomically unlinked from lweventlist
> >
> > No, I don't mean calls from linkwatch_sync_dev(). I mean other call
> > paths towards linkwatch_do_dev(), like for example linkwatch_fire_event() -
> > carrier down, whatever. Can't these be pending on an unregistering
> > net_device at the time we run __rtnl_unlock() in netdev_run_todo?
> > Otherwise, why would netdev_wait_allrefs_any() have a linkwatch_run_queue()
> > call just later?
> 
> I do not know, this predates git history.
> 
> All these questions seem orthogonal.
> My patch fixes an issue added recently. not something added 10 years ago.
> I suggest we fix proven issues first, step by step.
> If you want to take over and send a series, just say so.
> 
> Thank you.

My understanding is certainly fuzzy, but I am not talking about some
behavior from 10 years ago. If I made default_operstate() require
rtnl_mutex last year, I did so for all call paths, not just for the
direct linkwatch_sync_dev() call that you point out. I agree we can take
them step by step if the UNREGISTERING state also proves problematic
(I don't have enough data now), but I disagree that the problem is
orthogonal.

