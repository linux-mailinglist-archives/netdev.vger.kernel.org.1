Return-Path: <netdev+bounces-178684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F3A783B9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5A818903DC
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0BB21420A;
	Tue,  1 Apr 2025 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Pd2ZPrcM";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Pd2ZPrcM"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023098.outbound.protection.outlook.com [40.107.162.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91B1C860D;
	Tue,  1 Apr 2025 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.98
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743541202; cv=fail; b=QDHiT03+IOdfdDtmGzC8USSKX20AA8iImLJU8FB8BqBKcHXZjk0xy231BH8ZydnHVX/VfU1yUrpntM49GPT2Rkrx7e4s4LC+awylCzEXvv6cDEJ9ijRqeAHBT07hor13fYj8s6TZNnuSvb4U33W0CeWQQ/OEYjPVcOwEFoI7KMk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743541202; c=relaxed/simple;
	bh=RkclcgLADWczq3xyjvlol3Zg3+PSlKe30Swn6rEq6h0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T2BbsBvQ0UmQrQD9kj8bdBsY+hBC6Z0edLD0yCOu6soTImn0heeqPizL2IzqwIQwY9utv5FPGEa5Y+tMkIJu3wNYJ/2QEBKxxufTuCDPwoTaEwMsyH1IYthhzxD/cxywO3y2WY01CgJKrEOE7Zy1pdpqxrlWeVelFNWpHSWVp5o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=Pd2ZPrcM; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=Pd2ZPrcM; arc=fail smtp.client-ip=40.107.162.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IJd1s+Si7vVc8noFKts6VmXdWW3fyvRNpYRNvJXjY/74hEg8LMKcHyjaPg8d65oRtK6rkeNdypTy49dAr35a17UgbagK6pkJEc/ys0QyoNTqtGga+ASFMDOz79e3Kqih8YxhHnCcArY5kabNbML2EewAHdlPtY4qHOqk9JV1JDXQmrRG7xd9koENWeJXTp82byg56p8D4MOXYk+nVtrVIjxnCked2FA1E6BNH7O5PbOZjGFv2jW/zXx6O1qVxLY7FO/jLyOjDOweFP82bJp14ta/jpcVkI5gKx2LHVR5DrBVZkCzWjHjprQ1nCYouuPiXCZ8YPBkdBN0UJq5+/fc5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChHV5cdfSgPDMKUT6kCWb1GRQxIe0Fw1Sfp69ykbj4k=;
 b=S7jiz/S3YIwB6h8SJ0Y+t3IUCXL/c7cBjS7kltvUSzrctjtjfmXLGb3L09zSk5Jb/khyY0kwsUca7+hNm+bpiT4LsyUMXPxqTZYvW/tQOfuc9m4Abw2r73Nn581fK5tYCK/Ixc3b1GWahmlQDtdDn9D8wsBFlfMKWyhte3mVHte7i+vD8/+mL2yVQOmyWhGrdv0e1cg/o0AFU+Wtwgilh3ongTBRGZh9oPgc2pmRqdMOihQkTffFiJeofqrBQh8DNiv5GWvwKEdVMsafE7xuBDhyD/2y0X/+jfyCOjxO0tiCRkLq3JcFm6CNFQQXqsNmjgEv30N3Ni4ZN9ma+KeirQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=airoha.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChHV5cdfSgPDMKUT6kCWb1GRQxIe0Fw1Sfp69ykbj4k=;
 b=Pd2ZPrcMgZfq6jaeE99uzgVPPPW27HwsAxj2PAhMPo1/vGAqt0/LCvVYekF72Nlu5hhgjPQWTFg+cECP8WgRTXQqV1eC2lbd4gFfStHjuU4tzqfMGemfO84NBFY/+pDVw8iiFeSuAlaX/q6F9lSlr21fNkzA5fhvOsI9twT4N54xGdaMDJjbLPCElAafM2GSunNip1zUuLaHIQ0Ac4npJtB8k2Dh7GOnClOKl0NSbaD2/gKVaInRplnxo/Z5Y1qoOM+ffxt5mHI1V4hwT2lQrm5rSm/KeQ5m4c4PwzKCKmkAN9rWEZGvJixhkKJVW6FG7yipnW2fX084TGeipIzu9w==
Received: from AS4P192CA0038.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::7)
 by AS1PR03MB8149.eurprd03.prod.outlook.com (2603:10a6:20b:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Tue, 1 Apr
 2025 20:59:54 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:658:cafe::40) by AS4P192CA0038.outlook.office365.com
 (2603:10a6:20b:658::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Tue,
 1 Apr 2025 20:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Tue, 1 Apr 2025 20:59:52 +0000
Received: from outmta (unknown [192.168.82.137])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id DE9AB20080F89;
	Tue,  1 Apr 2025 20:59:51 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.170])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 178D720080077;
	Tue,  1 Apr 2025 20:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHOtuiwPSspx5jMrGHWqF0QCqSTuxKZM2iqfP3Eg2nYg/4ZdslGXbBtAqeVAV54cASKiHeaMhacccyoPvsP1MR+Qez28MMnzNpo84dqz68RItdo3Wq/ARmtQCsh4lzo9AYho65J30XhjKWPXAFtFVzJTmp9tAzg9qmA30IhCvifWLsG7TjNgDw66ed9grSIgr6a+/SVttetPErxaqvRq6MaEWRqzmIMjlkOKSoTR78fPkrGDtgyFdjg7IyNRrz9eIdZqM82ORkjZTgnLEaGT34rOV2IW0LI21y3mrEr2M1h5vQkfRDfzvfhbSKhZV7W6ulLE1KzRCxGnK1huCjCbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChHV5cdfSgPDMKUT6kCWb1GRQxIe0Fw1Sfp69ykbj4k=;
 b=NCPY+tOaLUibpLja5+UhNfu3I9r9tPQHkAdyWP9vxGLQ2b8XBIJh/Dwa0dOqCu9v6lpxwXLmhP5m2dI6yFZWn/IASA5kqszu6Z2LbZ56nfeMhbJsjXSVQqEJgBawXxwR0IHqK3p8CJgvA2tzJ2tekbnnTxZ4TWoxvIr6r5wcXRBm4UJiXzCx+weF0ucohFszog6VuwJlYoNXsp3HTI3UtEl/ch9orxiR/tRKTbVrHIEK9WRqf1Eg2L6koRTXf/crPJJdNWFPelP45t+q6bN5XCI7e1pRFKhLAwJeiwuKmFshSO5H871AObNENsMaVmN3rx4gqFnr0sZ62pyvR2A/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChHV5cdfSgPDMKUT6kCWb1GRQxIe0Fw1Sfp69ykbj4k=;
 b=Pd2ZPrcMgZfq6jaeE99uzgVPPPW27HwsAxj2PAhMPo1/vGAqt0/LCvVYekF72Nlu5hhgjPQWTFg+cECP8WgRTXQqV1eC2lbd4gFfStHjuU4tzqfMGemfO84NBFY/+pDVw8iiFeSuAlaX/q6F9lSlr21fNkzA5fhvOsI9twT4N54xGdaMDJjbLPCElAafM2GSunNip1zUuLaHIQ0Ac4npJtB8k2Dh7GOnClOKl0NSbaD2/gKVaInRplnxo/Z5Y1qoOM+ffxt5mHI1V4hwT2lQrm5rSm/KeQ5m4c4PwzKCKmkAN9rWEZGvJixhkKJVW6FG7yipnW2fX084TGeipIzu9w==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PA1PR03MB10915.eurprd03.prod.outlook.com (2603:10a6:102:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 20:59:49 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%3]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 20:59:49 +0000
Message-ID: <1f6fcbb9-5df8-4549-bb37-46ec136ef865@seco.com>
Date: Tue, 1 Apr 2025 16:59:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 2/6] net: pcs: Implement OF support for PCS
 driver
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Philipp Zabel
 <p.zabel@pengutronix.de>, Daniel Golle <daniel@makrotopia.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-3-ansuelsmth@gmail.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20250318235850.6411-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::17) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|PA1PR03MB10915:EE_|AM1PEPF000252DB:EE_|AS1PR03MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa0103e-b16a-4da6-2086-08dd716025c3
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?M042OGxBWk9nd1pXQXNlZ2pZUmdWT3ZGOXRKTHVhcWZIM3N6dkV6d2RsU2E5?=
 =?utf-8?B?cEVMdDJmSlRSTzgvV1hhTzMvZ0laOWlpdEFwY2NyMmpDWE5uY3FXMHc3WThq?=
 =?utf-8?B?THRSK0N5RTl6WUtkdk5kT2R6TzFYQVYyM1VYS1V5RitsZGV5b3N5Z0ZJZGdL?=
 =?utf-8?B?dnppOUpuZUIzUEtjdlU5a21VdXlaSXdXR2RIY0ZZUURjYnNIeHRwSmNwRlVT?=
 =?utf-8?B?N1Fhejd4UkhiOFNVYUxHZDN3dzFZZmZnNTlLdk9KWXpYTngyNWRWb2Z1KzdI?=
 =?utf-8?B?eEFEUmM5VFN3OXVNQ3pOZVdoVVRCanBQZ2tiUEVYY0hQekY2T25aTjgrYkls?=
 =?utf-8?B?YzlyS1BxQWVyQjBSeWkxcDFtQUlNZGt6V2RoL3MrRnpGdlhXV3ROVU03QWda?=
 =?utf-8?B?cG8wd2paS0FUbnQ2elJrMGxEV0Q1dDVvUktKejNVZ24rZ1JXa2ErUHNRVWw4?=
 =?utf-8?B?N0w0MTRsREZmWDBBSklBWHd6c0Y0VkxNNXVxTlNkU1ZReTFYZTRpcmt3em1O?=
 =?utf-8?B?U3E3dzh0bXNuZnNCblNnbzdvMXladFpyT2lEVUg4RjNzZzhsTkZvTFNmTVh5?=
 =?utf-8?B?dVE5QkRWdmJnNVlBWjZ1c21kSnllWlZkaGZWQTh6ZW9IZlV1bTIyMmFDbVBW?=
 =?utf-8?B?SEdZZnpydnZKZXZNRWU0bHdaR0JRTGdpd0VUU1BZelVmU2ZIQ251OUdRMTVS?=
 =?utf-8?B?U0V4K1RjczFQQ3lpclpicDc4VEpaaWtOSjA3aW52L2NueG1HQzhjMFROZ1JU?=
 =?utf-8?B?MXF6cUpyTW8zYVZ1bTNuelJ2RnFCRmd5SGFGMFJESXVxYUlaejNRa0FxdDJO?=
 =?utf-8?B?RXJwMmQ2Q3pzempqVVJncjd6Y3hSU0xHUU1CUktkMnFPRTJxa2FkRkZ2TEUx?=
 =?utf-8?B?ZWVtY0VjZ2ZpRDZ4V0xaQnFCZWgrRzZBYkY0L1ArdEtwc1JaT095NGRTS29m?=
 =?utf-8?B?T2ZzcmluRnMxMW1sZlFTZENmdXNUaGJSaG1RM2ZGWHU2VmpzZkc2Z3RxTGZx?=
 =?utf-8?B?VnZKZm9SNk96cnFhOGpkQTNCUEVBSHQrZmJ4QnA4emhQR1BqYUVBQU9Ya3BG?=
 =?utf-8?B?dkh2QTB4Z0EyYXJkakRML1JleGtsRVhESGFQUmFDWXh3QXNlb2VoRWJDeGlk?=
 =?utf-8?B?Z2pCODBCTWs4Smg1Mm03M2JZY3RKQlRZbEZ4TmVGMTlyQlBkV0tRN2h3SW9h?=
 =?utf-8?B?bHJrTC9QelRKM0dWNUV2MU1Td2V4MDBaMFBQWkFBZWxjWUYvOGtJWTJ4bWZR?=
 =?utf-8?B?aFhBcHVIV20vQ1Rjam12b3FTS2F4UjRBKzREdEk3ZlpXQ2p3NSs3anlPUjU3?=
 =?utf-8?B?aEI3Qjc0MW56TnJZc1FqMVRlVXc0VzFRVkNZUnVzNEx3TE84K3NIYlBGMG9B?=
 =?utf-8?B?ZnY1QXZYdWhPdDFvQUR5ejlMOWpKdVpEU0M3TXJKL2RKS0RpNVhxdHdZc3pa?=
 =?utf-8?B?dTVHaDhMcEs3Q3Jrc29sSlVneWZqYy9rQnRwK1JhVi9mak81S3FxMlM4UjBm?=
 =?utf-8?B?R2lHNzJSWTBwWlErOGUrQzFtck94V1c1ZzBQbGFkanFuTDVEdi9kZnJrUTZK?=
 =?utf-8?B?cmo3T0hhdlNIbjY1MmpnRWp0T2tYb3NMY0JnUnFRaElEWitJOXkxeXpOeDBz?=
 =?utf-8?B?VjFNRit5bUNuNjdsWFB6NllNamw4NXg5UkI3aVZlSGpRWCttQnQxQnlJTHp5?=
 =?utf-8?B?Wm96MzFkcE9aMVF5U1F0eitMTE5pTlJNblpxRUxJUEhnOGY3c244UUNzRm1r?=
 =?utf-8?B?cEJhdXNzSC9TenBiMnIrZ0lmTUVHYkN5cW9pekpxYTJuTTBXUWwzUzd0Vk5H?=
 =?utf-8?B?VWtmOGM1TUoxWFZYdVYveXBqTXFPQXZwY0EzRVFpUngyZkFOTjFsUjR5K0hK?=
 =?utf-8?B?WUFodmhIdVArUkJocWVnZXNXaVo0VXpuNmRCOHVPcDdtY3pEc3A3Wk5nQmdM?=
 =?utf-8?B?bkExNXBWOGVNbGsraENEeC9WYXIwbHVGb1lUZGxZUnhPRFJ5MDRIb2UrUFVm?=
 =?utf-8?B?dmg2MzRZWG9nPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR03MB10915
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	79d0c988-ccb9-4fb3-06a5-08dd716023bf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|14060799003|7416014|36860700013|1800799024|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RndUY0piMjZjVGtVSTMxdzJrd3FiY2RRQVNnMExIWXN1VjFqNnlZSzlsNUMr?=
 =?utf-8?B?M1Y2akRQSWJMUzRVWEdPaWhSZmM0NTZmbW9ZejhLczZmbE5BYzhpWGZTR2Ey?=
 =?utf-8?B?aEdNeEsrVmMyRG1pTG40ajFtd2FWMXZFYkROaHc3dlRFNjFCbWEwZFhMYm0z?=
 =?utf-8?B?VWx1Z24wMG82OTlERElLcVpRZTFXdjBKc3hiVHNsYXBZVkhxcit6WTZlMEV5?=
 =?utf-8?B?OFpaUUNwbVRZS2dZUG9Rb0k1OTFMMitOQlFPdDhIZzVNcmQvekV0MUtvU1JL?=
 =?utf-8?B?R3o3QUlZRXhDQmdjRXdKL2QvRFlPWlAyQ2U0MytLTTJCczZLa0o0TkVZbWZR?=
 =?utf-8?B?SFhMMXE1UlZ2ZGpISUx5RW5qSFlrQU9pME43MWFROFAyaXNYY1JoV25tY1VT?=
 =?utf-8?B?QTU1cHA1YkhmVHozemZGS0tRdnZqc04vNlBpd0VabVhsRStZOU1JbkZMNEgx?=
 =?utf-8?B?eHBvTjRBZXBiU21FeEV0dHZEUnpkSjkyWldNaFdvM1lJQkhqUTk4bnBMVEhO?=
 =?utf-8?B?bG9SVExTTmdldDVSLzQ2UE96MzcrUlpCREFrYkI3UDJjQVI0L3JuSU9pV29j?=
 =?utf-8?B?WmRET3RjWUMwaERXNHQ2NE1JcnViOHJKUG5IeUp5SUtXckhZc2dEQmZoZFZy?=
 =?utf-8?B?bFBGUU8rNk5TUGRHRDNPMUFGc3RqMnJrV2Z6S2N3aW1JNWdscDhGellXWVRn?=
 =?utf-8?B?VUt5T0RidU5WL1BuS243VFV2TitVY2tVSWlxY25CT3N5cXJoNlRWR2dnNS9k?=
 =?utf-8?B?L0ZHNGxyVXZJMnhZZVcwZUFZUUJNZU1peTVrOFFDUURwRFJvMDZrejIxWEN0?=
 =?utf-8?B?dTVsdWJ2SkJUWk4wSEpUN3hnTHliRzcxKzlhRzZqNk52Ymt2aXlPbjZkT1d3?=
 =?utf-8?B?bjE5VzFLTTRuS1NDSllxTEtzaGg1eFlKUWJ4aE82VG5mMHZBU0ZxZmswWXpa?=
 =?utf-8?B?Uk1JZDlpYXB2U1ZQYXZrUlpIMVB1VHprUTdvTzU3V3hVaGF1RFYxMFdreWUw?=
 =?utf-8?B?WUpvc09PdURXZytoTEtMeG9yS1YzMTM0MGwwUkdUSi9UdWVDbU9PYWtTYkFR?=
 =?utf-8?B?MVVwSzNzVWZ0UEZCaGY4MURzbk1XU2E1N1E4RUJJWitmUENmV0dPRmdIRThH?=
 =?utf-8?B?Y0M1ZmtTWkt2Y1M4ckgrYThBK29CZjJVTzNERzB6QTBrVWkzLzBoZ2tremUw?=
 =?utf-8?B?Y0c2eUtEVzVna01WR2V3UGdCWlkyN2luSllqdXhPcXYzM0Y2cU00bzZpL3JY?=
 =?utf-8?B?TS9INW5aUnh4ZTFmYTZUUGthZForM2NUc0FCbE1Na3E1a3M0VjQxZHlPaUxD?=
 =?utf-8?B?bnNoTnBJZHJaUVZmSWpGbnFCOTJGUllBL0hwYmdVUDZLelAwZklvb1VtelhH?=
 =?utf-8?B?NyszemJDTmtCNFlpejBWYkFZME5WdGJrQTVraEU4eUtEZGlsUTV5U1VUd01v?=
 =?utf-8?B?dmVPQlFFZFNjSk5YV1lkd1F4NlRIdzhEUk5keSt3ZzM4M0ZJQWxpbnZOTTN0?=
 =?utf-8?B?OHlZRE1EWXMvclNNZnlXTUZKd1IwZVcxZmlGWTU3eGhtUzdGR1RkL2drTTRm?=
 =?utf-8?B?YlF6a1paMDMzZFN4QnJOWWFrVFFNQlRNdCt4RFRWS3g1VytaNXBiQmoxWXB0?=
 =?utf-8?B?aWN6SHE3OFpnT1kxaFJ4TnNWMkRIYUlyb0JIV2wyTnhmQ2thNzM2bHkvMkRX?=
 =?utf-8?B?VjZLMzY2bXc2cnRvZUhEbUY1clZXUmx2ZG1jZFRNcXJwZEp5Q2UvV21JdEM3?=
 =?utf-8?B?Q1JTZ2xFUGh1YlJEbFllaGEyT2ZqbjV6TEZQL0lmZzc2NnNSMlZPVVlMOWhG?=
 =?utf-8?B?RXg2TlF5R1gvelYvdGFjSXRNOXgrNXBhUGxKaGJsa2ZvTTZrcStzV0FlQWpC?=
 =?utf-8?B?b0pzUW5WRDJJWDl1MkxJRFphWm5LT21LT0YzN2JvQTZ6VlUrb2p6OG13aEps?=
 =?utf-8?B?enNSMUVkMHRyQmNMbjBjTmhEK3FENFJqK2IzcHF0T0FSc3ZBR1RMTEJVODBw?=
 =?utf-8?Q?rGbmNSzFJyMPr2r+QAZ9BHy9IYEZrk=3D?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.80;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(14060799003)(7416014)(36860700013)(1800799024)(35042699022)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 20:59:52.0353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa0103e-b16a-4da6-2086-08dd716025c3
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.80];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR03MB8149

On 3/18/25 19:58, Christian Marangi wrote:
> Implement the foundation of OF support for PCS driver.
> 
> To support this, implement a simple Provider API where a PCS driver can
> expose multiple PCS with an xlate .get function.
> 
> PCS driver will have to call of_pcs_add_provider() and pass the device
> node pointer and a xlate function to return the correct PCS for the
> requested interface and the passed #pcs-cells.
> 
> This will register the PCS in a global list of providers so that
> consumer can access it.
> 
> Consumer will then use of_pcs_get() to get the actual PCS by passing the
> device_node pointer, the index for #pcs-cells and the requested
> interface.
> 
> For simple implementation where #pcs-cells is 0 and the PCS driver
> expose a single PCS, the xlate function of_pcs_simple_get() is
> provided. In such case the passed interface is ignored and is expected
> that the PCS supports any interface mode supported by the MAC.
> 
> For advanced implementation a custom xlate function is required. Such
> function should return an error if the PCS is not supported for the
> requested interface type.
> 
> This is needed for the correct function of of_phylink_mac_select_pcs()
> later described.
> 
> PCS driver on removal should first call phylink_pcs_release() on every
> PCS the driver provides and then correctly delete as a provider with
> the usage of of_pcs_del_provider().
> 
> A generic function for .mac_select_pcs is provided for any MAC driver
> that will declare PCS in DT, of_phylink_mac_select_pcs().
> This function will parse "pcs-handle" property and will try every PCS
> declared in DT until one that supports the requested interface type is
> found. This works by leveraging the return value of the xlate function
> returned by of_pcs_get() and checking if it's an ERROR or NULL, in such
> case the next PCS in the phandle array is tested.
> 
> Some additional helper are provided for xlate functions,
> pcs_supports_interface() as a simple function to check if the requested
> interface is supported by the PCS and phylink_pcs_release() to release a
> PCS from a phylink instance.
> 
> Co-developed-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/pcs/Kconfig          |   7 ++
>  drivers/net/pcs/Makefile         |   1 +
>  drivers/net/pcs/pcs.c            | 185 +++++++++++++++++++++++++++++++
>  drivers/net/phy/phylink.c        |  21 ++++
>  include/linux/pcs/pcs-provider.h |  46 ++++++++
>  include/linux/pcs/pcs.h          |  62 +++++++++++
>  include/linux/phylink.h          |   2 +
>  7 files changed, 324 insertions(+)
>  create mode 100644 drivers/net/pcs/pcs.c
>  create mode 100644 include/linux/pcs/pcs-provider.h
>  create mode 100644 include/linux/pcs/pcs.h
> 
> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index f6aa437473de..8c3b720de6fd 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -5,6 +5,13 @@
>  
>  menu "PCS device drivers"
>  
> +config OF_PCS
> +	tristate
> +	depends on OF
> +	depends on PHYLINK
> +	help
> +		OpenFirmware PCS accessors

More than this, please.

> +
>  config PCS_XPCS
>  	tristate "Synopsys DesignWare Ethernet XPCS"
>  	select PHYLINK
> diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
> index 4f7920618b90..29881f0f981f 100644
> --- a/drivers/net/pcs/Makefile
> +++ b/drivers/net/pcs/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for Linux PCS drivers
>  
> +obj-$(CONFIG_OF_PCS)		+= pcs.o
>  pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
>  				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
>  
> diff --git a/drivers/net/pcs/pcs.c b/drivers/net/pcs/pcs.c
> new file mode 100644
> index 000000000000..af04a76ef825
> --- /dev/null
> +++ b/drivers/net/pcs/pcs.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/phylink.h>
> +#include <linux/pcs/pcs.h>
> +#include <linux/pcs/pcs-provider.h>
> +
> +struct of_pcs_provider {
> +	struct list_head link;
> +
> +	struct device_node *node;
> +	struct phylink_pcs *(*get)(struct of_phandle_args *pcsspec,
> +				   void *data,
> +				   phy_interface_t interface);

I think it is better to register each PCS explicitly, as no driver needs
cells (yet). It simplifies the lookup and registration code.

> +
> +	void *data;
> +};
> +
> +static LIST_HEAD(of_pcs_providers);
> +static DEFINE_MUTEX(of_pcs_mutex);
> +
> +struct phylink_pcs *of_pcs_simple_get(struct of_phandle_args *pcsspec, void *data,
> +				      phy_interface_t interface)
> +{
> +	struct phylink_pcs *pcs = data;
> +
> +	if (!pcs_supports_interface(pcs, interface))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	return data;
> +}
> +EXPORT_SYMBOL_GPL(of_pcs_simple_get);
> +
> +int of_pcs_add_provider(struct device_node *np,
> +			struct phylink_pcs *(*get)(struct of_phandle_args *pcsspec,
> +						   void *data,
> +						   phy_interface_t interface),
> +			void *data)
> +{
> +	struct of_pcs_provider *pp;
> +
> +	if (!np)
> +		return 0;
> +
> +	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
> +	if (!pp)
> +		return -ENOMEM;
> +
> +	pp->node = of_node_get(np);
> +	pp->data = data;
> +	pp->get = get;
> +
> +	mutex_lock(&of_pcs_mutex);
> +	list_add(&pp->link, &of_pcs_providers);
> +	mutex_unlock(&of_pcs_mutex);
> +	pr_debug("Added pcs provider from %pOF\n", np);
> +
> +	fwnode_dev_initialized(&np->fwnode, true);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pcs_add_provider);
> +
> +void of_pcs_del_provider(struct device_node *np)
> +{
> +	struct of_pcs_provider *pp;
> +
> +	if (!np)
> +		return;
> +
> +	mutex_lock(&of_pcs_mutex);
> +	list_for_each_entry(pp, &of_pcs_providers, link) {
> +		if (pp->node == np) {
> +			list_del(&pp->link);
> +			fwnode_dev_initialized(&np->fwnode, false);
> +			of_node_put(pp->node);
> +			kfree(pp);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&of_pcs_mutex);
> +}
> +EXPORT_SYMBOL_GPL(of_pcs_del_provider);
> +
> +static int of_parse_pcsspec(const struct device_node *np, int index,
> +			    const char *name, struct of_phandle_args *out_args)
> +{
> +	int ret = -ENOENT;
> +
> +	if (!np)
> +		return -ENOENT;
> +
> +	if (name)
> +		index = of_property_match_string(np, "pcs-names", name);
> +
> +	ret = of_parse_phandle_with_args(np, "pcs-handle", "#pcs-cells",
> +					 index, out_args);
> +	if (ret || (name && index < 0))
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct phylink_pcs *
> +of_pcs_get_from_pcsspec(struct of_phandle_args *pcsspec,
> +			phy_interface_t interface)
> +{
> +	struct of_pcs_provider *provider;
> +	struct phylink_pcs *pcs = ERR_PTR(-EPROBE_DEFER);
> +
> +	if (!pcsspec)
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(&of_pcs_mutex);
> +	list_for_each_entry(provider, &of_pcs_providers, link) {
> +		if (provider->node == pcsspec->np) {
> +			pcs = provider->get(pcsspec, provider->data,
> +					    interface);
> +			if (!IS_ERR(pcs))
> +				break;
> +		}
> +	}
> +	mutex_unlock(&of_pcs_mutex);
> +
> +	return pcs;
> +}
> +
> +static struct phylink_pcs *__of_pcs_get(struct device_node *np, int index,
> +					const char *con_id,
> +					phy_interface_t interface)
> +{
> +	struct of_phandle_args pcsspec;
> +	struct phylink_pcs *pcs;
> +	int ret;
> +
> +	ret = of_parse_pcsspec(np, index, con_id, &pcsspec);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	pcs = of_pcs_get_from_pcsspec(&pcsspec, interface);
> +	of_node_put(pcsspec.np);
> +
> +	return pcs;
> +}
> +
> +struct phylink_pcs *of_pcs_get(struct device_node *np, int index,
> +			       phy_interface_t interface)
> +{
> +	return __of_pcs_get(np, index, NULL, interface);
> +}
> +EXPORT_SYMBOL_GPL(of_pcs_get);
> +
> +struct phylink_pcs *of_phylink_mac_select_pcs(struct phylink_config *config,
> +					      phy_interface_t interface)
> +{
> +	int i, count;
> +	struct device *dev = config->dev;
> +	struct device_node *np = dev->of_node;
> +	struct phylink_pcs *pcs = ERR_PTR(-ENODEV);
> +
> +	/* To enable using_mac_select_pcs on phylink_create */
> +	if (interface == PHY_INTERFACE_MODE_NA)
> +		return NULL;
> +
> +	/* Reject configuring PCS with Internal mode */
> +	if (interface == PHY_INTERFACE_MODE_INTERNAL)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!of_property_present(np, "pcs-handle"))
> +		return pcs;
> +
> +	count = of_count_phandle_with_args(np, "pcs-handle", "#pcs-cells");

You need to have a way for the MAC to specify a different phandle for
backwards-compatibility. There are several MACs that have different
names in existing devicetrees.

> +	if (count < 0)
> +		return ERR_PTR(count);
> +
> +	for (i = 0; i < count; i++) {
> +		pcs = of_pcs_get(np, i, interface);
> +		if (!IS_ERR_OR_NULL(pcs))

As commented by others, this is really a bit late to get the PCS
and it complicates the error-handling. It is easier for drivers to get
the pcs in probe() (or some other setup), and  

> +			return pcs;
> +	}
> +
> +	return pcs;
> +}
> +EXPORT_SYMBOL_GPL(of_phylink_mac_select_pcs);
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index eef1712ec22c..7f71547e89fe 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1130,6 +1130,27 @@ int phylink_pcs_pre_init(struct phylink *pl, struct phylink_pcs *pcs)
>  }
>  EXPORT_SYMBOL_GPL(phylink_pcs_pre_init);
>  
> +/**
> + * phylink_pcs_release() - release a PCS
> + * @pl: a pointer to &struct phylink_pcs
> + *
> + * PCS provider can use this to release a PCS from a phylink
> + * instance by stopping the attached netdev. This is only done
> + * if the PCS is actually attached to a phylink, otherwise is
> + * ignored.
> + */
> +void phylink_pcs_release(struct phylink_pcs *pcs)
> +{
> +	struct phylink *pl = pcs->phylink;
> +
> +	if (pl) {
> +		rtnl_lock();
> +		dev_close(pl->netdev);
> +		rtnl_unlock();

What about pl->type == PHYLINK_DEV?

And if you race with mac_select_pcs?

This approach is untenable IMO.

--Sean

> +	}
> +}
> +EXPORT_SYMBOL_GPL(phylink_pcs_release);
> +
>  static void phylink_mac_config(struct phylink *pl,
>  			       const struct phylink_link_state *state)
>  {
> diff --git a/include/linux/pcs/pcs-provider.h b/include/linux/pcs/pcs-provider.h
> new file mode 100644
> index 000000000000..0172d0286f07
> --- /dev/null
> +++ b/include/linux/pcs/pcs-provider.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __LINUX_PCS_PROVIDER_H
> +#define __LINUX_PCS_PROVIDER_H
> +
> +#include <linux/phy.h>
> +
> +/**
> + * of_pcs_simple_get - Simple xlate function to retrieve PCS
> + * @pcsspec: Phandle arguments
> + * @data: Context data (assumed assigned to the single PCS)
> + * @interface: requested PHY interface type for PCS
> + *
> + * Returns the PCS (pointed by data) or an -EOPNOTSUPP pointer
> + * if the PCS doesn't support the requested interface.
> + */
> +struct phylink_pcs *of_pcs_simple_get(struct of_phandle_args *pcsspec, void *data,
> +				      phy_interface_t interface);
> +
> +/**
> + * of_pcs_add_provider - Registers a new PCS provider
> + * @np: Device node
> + * @get: xlate function to retrieve the PCS
> + * @data: Context data
> + *
> + * Register and add a new PCS to the global providers list
> + * for the device node. A function to get the PCS from
> + * device node with the use of phandle args.
> + * To the get function is also passed the interface type
> + * requested for the PHY. PCS driver will use the passed
> + * interface to understand if the PCS can support it or not.
> + *
> + * Returns 0 on success or -ENOMEM on allocation failure.
> + */
> +int of_pcs_add_provider(struct device_node *np,
> +			struct phylink_pcs *(*get)(struct of_phandle_args *pcsspec,
> +						   void *data,
> +						   phy_interface_t interface),
> +			void *data);
> +
> +/**
> + * of_pcs_del_provider - Removes a PCS provider
> + * @np: Device node
> + */
> +void of_pcs_del_provider(struct device_node *np);
> +
> +#endif /* __LINUX_PCS_PROVIDER_H */
> diff --git a/include/linux/pcs/pcs.h b/include/linux/pcs/pcs.h
> new file mode 100644
> index 000000000000..b681bf05ac08
> --- /dev/null
> +++ b/include/linux/pcs/pcs.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __LINUX_PCS_H
> +#define __LINUX_PCS_H
> +
> +#include <linux/phy.h>
> +#include <linux/phylink.h>
> +
> +static inline bool pcs_supports_interface(struct phylink_pcs *pcs,
> +					  phy_interface_t interface)
> +{
> +	return test_bit(interface, pcs->supported_interfaces);
> +}
> +
> +#ifdef CONFIG_OF_PCS
> +/**
> + * of_pcs_get - Retrieves a PCS from a device node
> + * @np: Device node
> + * @index: Index of PCS handle in Device Node
> + * @interface: requested PHY interface type for PCS
> + *
> + * Get a PCS for the requested PHY interface type from the
> + * device node at index.
> + *
> + * Returns a pointer to the phylink_pcs or a negative
> + * error pointer. Can return -EPROBE_DEFER if the PCS is not
> + * present in global providers list (either due to driver
> + * still needs to be probed or it failed to probe/removed)
> + */
> +struct phylink_pcs *of_pcs_get(struct device_node *np, int index,
> +			       phy_interface_t interface);
> +
> +/**
> + * of_phylink_mac_select_pcs - Generic MAC select pcs for OF PCS provider
> + * @config: phylink config pointer
> + * @interface: requested PHY interface type for PCS
> + *
> + * Generic helper function to get a PCS from a "pcs-handle" OF property
> + * defined in device tree. Each phandle defined in "pcs-handle" will be
> + * tested until a PCS that supports the requested PHY interface is found.
> + *
> + * Returns a pointer to the selected PCS or an error pointer.
> + * Return NULL for PHY_INTERFACE_MODE_NA and a -EINVAL error pointer
> + * for PHY_INTERFACE_MODE_INTERNAL. It can also return -EPROBE_DEFER,
> + * refer to of_pcs_get for details about it.
> + */
> +struct phylink_pcs *of_phylink_mac_select_pcs(struct phylink_config *config,
> +					      phy_interface_t interface);
> +#else
> +static inline struct phylink_pcs *of_pcs_get(struct device_node *np, int index,
> +					     phy_interface_t interface)
> +{
> +	return PTR_ERR(-ENOENT);
> +}
> +
> +static inline struct phylink_pcs *of_phylink_mac_select_pcs(struct phylink_config *config,
> +							    phy_interface_t interface)
> +{
> +	return PTR_ERR(-EOPNOTSUPP);
> +}
> +#endif
> +
> +#endif /* __LINUX_PCS_H */
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index c187267a15b6..80367d4fbad9 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -695,6 +695,8 @@ void phylink_pcs_change(struct phylink_pcs *, bool up);
>  
>  int phylink_pcs_pre_init(struct phylink *pl, struct phylink_pcs *pcs);
>  
> +void phylink_pcs_release(struct phylink_pcs *pcs);
> +
>  void phylink_start(struct phylink *);
>  void phylink_stop(struct phylink *);
>  

