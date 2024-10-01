Return-Path: <netdev+bounces-130912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE198C02C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655CC2826AE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016981C6F42;
	Tue,  1 Oct 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="RLlRineH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D96282F7;
	Tue,  1 Oct 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793395; cv=fail; b=sTyA49tJNr7bfapUB3WAxzgxS3JZGGeNM3Xyq5G5CYfMYncyicJcC9jMbACC30MalnykZfkN0JoEbpePMje8FquholuQnwky/KzyE4v+Kz//jp71MrYUo/V/i3lNGe+j6d4N6H0kizrKCO7RC0vzfT3vCmE0DBO3l15osuTy8F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793395; c=relaxed/simple;
	bh=Dg5VgePHGTm047bbp4IKSinyJZ9WTxF7DpNLfZUWo+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sQ4G8I7/X89XmcRGfERWCvQakkUUNZJVguMQG/P+K5L/5Dsff9v7oSTL/YN4BbE2hp+3fdBc7Yoeuq0Q5pkyk/WafYWumMQQM5wITe3jp/rmVRPWJQtiJ6V3jLZ/+JJfVb4vwP47LyLHjhRMeun+pM53khPyOVgJXOQ60vASAHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=RLlRineH; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktBAwyEBL3csuAWsFMD/klJ6Tqwryx61E3TvxdLv3U/iqOZezXYborv65ZMvn7plYFNwAD1UWZSlA5QcFdJQpghjdOAEYWfb6jdCh4kOiOls/CKWEZ1vq45f7eFiy0ipWbZnbaVO7xzRz3kxi+YDDP+OmfPQhdr0yC1YM16dnre8Kp22McdxpFFYl6so11dttHowL9JMjyGud35xOO1wt6phziEgd5hKK5hlnD2Sj0+p9JoctoVrZcGjHM/yDpbWN1py//C9HihdlvAY2gTyMo2Rc7qfQPMedmBML9ZwoOzsdBhQUgU/IZw/+STngTX6euGSZnojhxDvW7b9cC1E7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezOHJciJ21Yls5Ybl3C3eX2FByvcTx2IKoZs+YdiOy8=;
 b=g1iq4vQg6ROJuKbCBWvBAWiW7GrAiZyxfs0uu05sUfcZqYw9OlPhc4CogIzwQl4JVBOjxDa03yyM1D/Q++TNo9hUBflRTL7Wukhx/E3uf5WUw/w3JGDR5Cl8ZWnarK0CtAWKjzjc0dzicotPr6IWIe4Mdw1VwStQEJmYr+8gXgona+h/pZNCTCRs3GXQawqoIa2BB/gtTTlwt1A/n7E3UO4dy8F5nAUEM2j7x3vQK8wRTJ/VYGXRxx0r1eCq3vEiqZBXuSsVuo4GDKVprbp5MfEGXpR5XAo/YrcK173d8W/nGlci/tYYeLQK0ZRN1LMVp641Ms0Ekq3Z7A3vti4Ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezOHJciJ21Yls5Ybl3C3eX2FByvcTx2IKoZs+YdiOy8=;
 b=RLlRineHm/IeEeI+ojbWTz8MrXr8cBcBcy1fMg5DdoYsvMP5oQAjsZf+jaShCGiOYBWqk7+5W3OELYlEiRb/rXS+QGRAJXVTFvfm+snvqO2RqxnEtVUHMGFmRirASQtcEwaurDqwFw+Q+wFE749Iovcw4dss1JGBFIortbYTrnWG9yg59K1KxU8IXwqSx1vI3Cb4+EgFdYaGKWbntqSVn7jK6x7MKnGvF0uypaMbfPQeiVC7cqjoLhcsLqnf07opokhj7S6eAN0nVXE6h02YFtPREYfNlD4jm1WzHC5rmM3ougU0OvBD01pZiTzETcC44XbQHlIuMmkAg3WG8/LQpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by VI1PR07MB9544.eurprd07.prod.outlook.com (2603:10a6:800:1ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 14:36:31 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 14:36:30 +0000
Message-ID: <68ee33a7-c60e-48b9-b362-c991bdcf675f@nokia.com>
Date: Tue, 1 Oct 2024 16:36:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ip6mr: Fix lockdep and sparse RCU warnings
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Petr Malat <oss@malat.biz>
References: <20241001100119.230711-2-stefan.wiehler@nokia.com>
 <CANn89iJiPHNxpyKyZTsjajnrVjSjhyc518f_e_T4AufOM-SMNw@mail.gmail.com>
 <4e84c550-3328-498d-ad82-8e61b49dc30c@nokia.com>
 <CANn89iLC5SgSgCEJfu7npgK22h+U3zOJzAd1kv0drEOmF24a3A@mail.gmail.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <CANn89iLC5SgSgCEJfu7npgK22h+U3zOJzAd1kv0drEOmF24a3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|VI1PR07MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: d27fe1e5-c3b3-46d2-e738-08dce22670c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUNwbys1QTZSNTJ5M3FzaTNPenkwT01ReVhLNmVwSlhHajNPQkpXdjhTKzIz?=
 =?utf-8?B?Q1AvbGVlT0pSdmc4b0JqVW1GUUZKS01SSkxlcXR4V3AySmVQdXpSaXMvT2dm?=
 =?utf-8?B?R1d5WUJNY0M2VkNCTU44SEMvUjc2VnY2VWtxTHRpMDRqek5MeHBxUVhNcVVs?=
 =?utf-8?B?MVFVQVBoTy96WEREVnZGMGZFbmFrRVBtcmpRSFl5Y0ZTYy95Qnh1SU1aaUFh?=
 =?utf-8?B?dUhWWXloRHFZak8xbDFjQ0hkZ3R4Qi82NW1MbkUrcXpQRlpKTEdvQmZmNkhB?=
 =?utf-8?B?S1lHSzBZSFVha3NVV01hWW5jOHJOZDhmT2pmUkZQRnZEOG1Ra1R5TFZCSkxp?=
 =?utf-8?B?RURUYysvN0RpTkhDbjVRNDMwL2V3d3JWSjJOZW4vbzZ2dGdYdXFNbkNuSGxO?=
 =?utf-8?B?YnlwcUlQaGdtR3d4NGtEUkZtNXdqVmRzNDR2a3pOUHllT01ZTElQWlJOU2Fo?=
 =?utf-8?B?b2IyNWZmekl3V05mRFB0WTlSK0cyWERLZURzTWNVZC9tL2NNVnF2WEN5ODNU?=
 =?utf-8?B?L1hKNVlFMk01OXFJcVk2OWhQSFl0TlM1Q29uMzByRUFydHd6SGtmZ0lFZlRE?=
 =?utf-8?B?QndKQ0h5bzczWE50ZzZweXk0a2JwanFibWdkYWRFYTRxOUpRTk1qRU9YWXRP?=
 =?utf-8?B?b0xBaDVGclhGWHJYcURzVkdUaHNtYTNZZVh6Q09ySVM2c2JWeUJaK1R1K016?=
 =?utf-8?B?aWhsbm1CQVcvdENJb1c0ZkpqVjhCUWpod2tybHhmb0d5ck9JTms1VTNjUUNy?=
 =?utf-8?B?ZTh1QW9IR3BHaVgyNlQ2dmxtK2FoN2NkRXMzWjJtekVxVnh5SjdneUVkNE8w?=
 =?utf-8?B?bHkraEJIRkQyb2ZXSzNLVWpkRmEzSEhrazNGcGNucEd0QjZxeUdkUGFrMjBQ?=
 =?utf-8?B?MHU3U0I5WlMwYitPQVhOcDhyS2xyNGFQM1RDNmo4b2xWaVdXSXk4Y1RiM29U?=
 =?utf-8?B?UHVqZTJ1Nzl2cS9BMnJRQ1pkZ2lPZU56MUdRbmJJQ1UyNTVIZmkxbTVWZ1BT?=
 =?utf-8?B?U3BOajhIaW8xdm9JdkpuMnJGRmp2U2lEcFJWS2FMdWh4cEkzeUlVeHdlQStl?=
 =?utf-8?B?a3F0ZlRuUzRhQmFIR2E5enJabGR2KzhoenVXNUw5cklheW5hV1dnNHNGbUFM?=
 =?utf-8?B?QTFLdEFDVCtzdXhEcGU1TUpNR0hvTS9ETVRPc3JxbnRXQldwRkVXazZLR3Nm?=
 =?utf-8?B?UUxTZFllNVlaeDlrTkJXRXlUUUJoKytJaXd3RDc3a2I3UGwxSkJhOXBiM0dv?=
 =?utf-8?B?Ty90SnNORGF2UC95cTRtN1AvV1ZYWUI3SFhZWHNyNTd6WktYMlp4c0pkemU2?=
 =?utf-8?B?blNXUmZ5UGtmc1dhK1pMVTZNaHQzdGtqd1RuRDVWMDJEZmRQNTdNQkxFNlUr?=
 =?utf-8?B?dE9KckYya09KOXFIZEtWRkwyb2UrdzZ2NUxYaDFvN1F6bndUa2VRdjNNNkJi?=
 =?utf-8?B?WlZzV2VTQjN5SUJEMUYrSkE4YnAvdTNJckRtU2RjS3RtVHRnNGVUMzVDS0tl?=
 =?utf-8?B?U3BFeTc5ajQwVTYyUVduTU5nT1FiRUduSk0zL0ZQdGVQR3pnL3M0YTB5eHps?=
 =?utf-8?B?TUtoNzBycEN0KytwN2p2NTI3SUorOUo5b3N3LzcyWHpDYWxUcWxpWFlielVj?=
 =?utf-8?B?eEliV1NzZFA4WHQ0d2xaUDJ6TWZURVAyRUw0Yk1Db0l5L1dXeUxnUjZzcXg2?=
 =?utf-8?B?UTlFTGk2SXNWWnJtZGRDRXp3OU83VW12MWcyODYzcXdDQ3pkM1dxT2RBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFNIS3p1TExLRGIveFNwcjNhaWx1cE9ndENqNkR0ZU4yMytUUjV1T0l5aEJu?=
 =?utf-8?B?V1ZCWjRtTEN0aEcrNk95cVkzcVpsYVljd05ndE1lVm0xeDBXeEFhcWtxVUtY?=
 =?utf-8?B?enRqN1kwV3dGSWIzcUZMOERJUkdaYy9ybXRwNUQrUEdsMzNiVkM5cTJpUlpu?=
 =?utf-8?B?a1lpU2JZRmdRTWo5am80bkZnd01nMHU3NzRiQmR3VGZsUTdvSGZhTFBZa2hj?=
 =?utf-8?B?b0FKMkxLRU0rRkVWRGowaWRWOEp1cXlVUzBudXNwbFpxZTgxSHNyVldxR1VN?=
 =?utf-8?B?OVdBOW9iTk5sWVVzYzNHbzlzdW0reStTdi9nVE5IbmZ4SlhsbkR6Z3pBNE84?=
 =?utf-8?B?Yi9XUmh2d2p5TEtOUXliQXJYenlNWTJpL0VYMTZXZmhRa0YvbklLMVBiTG4y?=
 =?utf-8?B?V1pMRmcyLzlXOVNDa3p2VDlyQ1UwbWFZalhPWFljakVRNG94bTVpYzROTDhT?=
 =?utf-8?B?Y3hDOFhKZEUyOElrRWl1ZXE3MTR4dVgyRjZTQjE4SlRydXpHcjhDMCtmZW9P?=
 =?utf-8?B?N2lYKy94bUk5WTVCVGlRMFdWYUdReGJZNVppb0llOHhYVEhMcDZnSHhBR2hu?=
 =?utf-8?B?cUNYVjZKZW9CTHVDOTRNUVdLV05Kd3dtdFdJQjVxVWp2VmVUUUR3QWJZOXNv?=
 =?utf-8?B?eTFGbFFjREZtUWhtVGdhMUhaRVpPNThiYUZOZFZYdWNheVdxZUJwNEc4WUx0?=
 =?utf-8?B?bnhPVmxxdjhPcDRvUmR3MVY3L0t3OXJlMVBma1hOZ29BZ0xVd2xlZ1luNEtJ?=
 =?utf-8?B?cnp3V2hKU0cwcVY1N2pXU2ZZZ0p2ZHBhOGp6cEI1MkZSeGkra2g0SUVLU0Fk?=
 =?utf-8?B?aGhydmlBN3lRTVNHcmNXa2FzUERVYWNXS2REWFdjTHEzMmFvSGJENWR3MU9w?=
 =?utf-8?B?cHFhVjZGdmo2UUhVamFsbmRDOVAwQjFtUHlIUVNrY1RMazc1S1Z4dzlmQXY2?=
 =?utf-8?B?SGJ4OGVPQkJjSldSbTA1ZGFsOUtMR0hGdHMzaUM5Q0RzYjA1aTV2YmJPSnQv?=
 =?utf-8?B?L3g1cGVRK2RjbEY4czRmVEorWElJaVcvWGlQTTJiMW9rWjI1cE9OSk14ZzBM?=
 =?utf-8?B?dmJPejlDb1NvQWdYWXYrRlJObnExczdocDBScFNxMXd6UmMwWUlyUWtINUhv?=
 =?utf-8?B?SDZHMlE1R2FYaDhWK2JGYnMvd2VIZjI4RG1HNW9ML0pJK25lN0YwdzdXeFh5?=
 =?utf-8?B?UlFJWGNWQXFSV2sxZjhiZWQxcUcwemh6Y21Dc29OM0VlaHhxbjdBb3RyS1U1?=
 =?utf-8?B?VnBxVXdMbFBrMjI1QjhGeERiblJVUXM3UXEzWVNsZ1VuM1ZjbkYxZzdPTnQ1?=
 =?utf-8?B?cVRPRnpzWXJ0bkZNM3lJQ3JvUVJmMXRQOWlPcUc1NUE1cVJPVWo4dWFWWTRF?=
 =?utf-8?B?ZEROMWQwZUdxb3VibzIyOE5tUW5RZlJtQzhpcDg1UlRoNzhZbk5oYlM5U2Rx?=
 =?utf-8?B?ZlZtODhhSEJWL1oxSFVMaGphMFlCTTNEQVo3cVNBeWhoVisyRXNVY0xGdVNv?=
 =?utf-8?B?d25ORENybUVGaS9lNVdsRE5Rckh4RlZSZFgyT2cyWm5XNk50SnVwWUhzd1hu?=
 =?utf-8?B?VW94MXE3Q1U2RlNvUTI0aHgxOSsrV3NMVDRmYzBHVUJZZ3pHRW85bjc4ZXBh?=
 =?utf-8?B?eWk5TTAySVRXZVJObjA4ZVVvTkFOVEhuZlh6WERBc0plNWhrYmV2cmtuaVRE?=
 =?utf-8?B?VGNJWVBqVTQ1Y1BTcm9hWitzSFptdjg1KzVBRnlqTUgzcW0zVGMxUHBsNmtP?=
 =?utf-8?B?WlQyODVzdEs2TzcrcWtucTFMOWVvMVNxc2FGSG9aSmxNNkZxMzdFak9seTRN?=
 =?utf-8?B?Vk01TU1wb2I2VVYrT1duUjF5eFljNUJ1bUFJcGlXZ1ZWK2lyTVVKWklJNmFZ?=
 =?utf-8?B?SDNFcDJ2L2RrWlFJNE50VVNTdUxWK0h6RGJvZXNzYU9RT1FrZXk4SS83eHZY?=
 =?utf-8?B?U1hLWk5nN3lNaFZwYmNuaFQ5ZUoxaTNGSHp2WElyQSs5ZG5hdUNlQWoxZUF5?=
 =?utf-8?B?a2RvMEJvVVJaWStZVXlqbG1uWGFkeXJaUTZVWkZGSWVxY01FYXU5TU9HMG5k?=
 =?utf-8?B?RUd1TmZvN1dCVVlHdzBHN0k3NnRUQ3BzcW5oUFg0dmpyQ0RkVWcxRXlDSU1o?=
 =?utf-8?B?ek1sQThMUFBWbDhIdzM1WTNXQlZkWWJiamh6aEFhNjdYa1d3ekJGbW9OUFky?=
 =?utf-8?B?VkU0UmxORlUvWVBMRzJtZVNEQ1lSTG5ENlBBc2ZnVmhNczEwN2UydzNaTEM0?=
 =?utf-8?B?ek1Wa1I4U0N1QkVIZ1JyaWpxZE1BPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27fe1e5-c3b3-46d2-e738-08dce22670c0
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 14:36:30.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3b7aMdzcsueS4Wzt5ZtylXaHnT9RQLIJ/NInAdXRaQDcKfE7pxpiQiOAcS54zMPggbJjs4oKUUmSNfKxa7L6UGoRoBKPheoRSkJI+E0ODE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9544

> This could be a lockdep annotation error then, at least for
> RT6_TABLE_DFLT, oh well.

As you have already explained, we can ignore the ip6mr_vif_seq_start() error
path, so the issue boils down to ip6mr_get_table() being called without
entering a RCU read-side critical section from these 4 functions:
ipmr_vif_seq_start(), ip6mr_ioctl(), ip6mr_compat_ioctl() and
ip6mr_get_route(). It is my understanding that in none of these four cases the
RTNL lock is held either; at least according to the RCU-lockdep splat we
clearly see that this is not the case in ip6mr_ioctl()  – but please correct me
if I'm wrong.

> Note that net/ipv4/ipmr.c would have a similar issue.

Yes, looks indeed like that :-/

> Please split your patch in small units, their Fixes: tags are likely
> different, and if some code breaks something,
> fixing the issue will be easier.
> 
> The changelog seemed to only address the first ip6mr_vif_seq_start() part.

If you prefer that I can split the change into 4 commits addressing each of the
4 functions mentioned before.

Kind regards,

Stefan

