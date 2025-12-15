Return-Path: <netdev+bounces-244709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBDBCBD70E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 684243011F81
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9FC2D8777;
	Mon, 15 Dec 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qq5l0W8h"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226122E8DFA
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765796676; cv=fail; b=f3mdy2yBBJ6qa6PpA8cNCiG+Ws9Khrmx3yj1GH2L4hNH3nk4Mqna3IVIGDSVgQjHEXaajVY6YEBEja5lnVubN8fiRxb6ORn4zXNGNCnzm6vX0A5U7R2FuQi7RMF3IC9wOGh5rrTVX6O6NL526FFE8GvifB1pwhYCTgrL2x6XCC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765796676; c=relaxed/simple;
	bh=oT2U4vWmz4lpdhTQvRtdzuTZuy0BA3x+z0UR5/op2yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UigNSniKtBlXFUNJ68DzdyO0I7z4TJsK+qpY8GXZM5rDzB/1gLdqMcHtU/BYlHscV+RO1LcqR4ftkQZvju+Icg9jrUljrukIQazVpPfXVgVZBi6806gCsXGbKHo6lnFi9HClofG/WDv67pI/LLGWMQjNUYLyYVSysrVNscdc3gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qq5l0W8h; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDoja0ZkFF3J63BLw/6ZPxiuwIgK8CncbaSQul0GsyDhLV13evsvKcAHuW7lqyt27P/0QqILswMUNwogWJuU1yto5VI85+Zog1C+otbjKMzW6WKcgMYRjzmUp7FKVpXCDf+KxS+TMA+84iO1ZoffQHdnVDAGP8Vwn0rgbYHVN6hz2GKpX9/wcUrEbCdko2Cd06gVc5/M3lMd+jB8N5X/DNx1uy1ll0IcCRsJzk0sbTgX5okveRile57o3VHukVnL97hyhA3tFiYlnhKeJ5Ns49h5iPl16PBvxM/rjwAWb5xlyT1DCkiwzO0BmJyfmmZrCt6MdzJeIF2z18Ecc/iWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/UK8/3UXCA+/BjGqJXpH9QFa/BTxjE/A4Igp6CZ4QQ=;
 b=UjKXaiWU9VXcIlCjdaRlUc7MKjs8hq3L5tZ9B6JFkV02sqdi+JgMtpcOdDehbiACHxWJ6AE+VYtWTLpggsjm6I6umykDO8I/aI2+IWg8IcBcYQibTYubGGMyPO4JtyCN4Tc9vWVU2a9rFqduHyM39ERi11MwURVuP/KsQO0HUUJ9wUtzG30/xtB32Z08A5sKqJGna7uFaO29qf9bi9zUyv0Xd1HxYFO5NL/BB6pVkoR68bg4QyEmG1F0ednxD9umHvbhqD5NjLYlbQKxF0hJVPmknrtfttNvY14yhZhN+kZmRg7xzagVeemfgv8OEA3ZCEBoPZV7U93AI/2bm/wgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/UK8/3UXCA+/BjGqJXpH9QFa/BTxjE/A4Igp6CZ4QQ=;
 b=Qq5l0W8hJZFyvniwpE1PF5byKnlT/TerE6fIxSTxMIGF0WJPnq7JbwWFyPKSl9XFZ1L1NKYXk8AIQ/nekgphXCsSYgxKgLuV4EC+UKedRH1a+tfrMRYYABJ2zzPRa7v5JMWLSGYQng3c/OXkdsFxxdSszRZtMNJMhRMWKYuWUlluR6QdUoWS7HA+1ZVFmnchjpTm7ncSoPRKlFKyvoYLd9NXTnErpOVwq4gFdTZjkfHR0wHWmMOKRfSpA/kfoLmjskpn5rgDud4JgLEuQfgyqJbCbquWJ9UazWDkgieu+94xZa7YANltYI1SgWUyy2Ato6FhJzHP+nYlxO6sbSI0qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8285.eurprd04.prod.outlook.com (2603:10a6:102:1ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 11:04:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:04:27 +0000
Date: Mon, 15 Dec 2025 13:04:24 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ma Ke <make24@iscas.ac.cn>, Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: properly keep track of conduit
 reference
Message-ID: <20251215110424.ovvp3x6mgf765gzc@skbuf>
References: <20251214182449.3900190-1-vladimir.oltean@nxp.com>
 <CAOiHx==MmOsF4aeBf8zbEaHgN59Q4b=FMUEvLdJC9xXfFa5FLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==MmOsF4aeBf8zbEaHgN59Q4b=FMUEvLdJC9xXfFa5FLA@mail.gmail.com>
X-ClientProxiedBy: VI1PR0102CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::28) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: b024af66-0769-4aa6-ae39-08de3bc9b6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cC9HRlZvUVJ2cHMyc0xXWTlxclAvQlRzczVTUG5FeG01c1lwWU1iVUNIN1dk?=
 =?utf-8?B?M0w3eU9icHN5bkFhTkhvYTZxci9zK1JaMGpWWldVeFZKdGw3QW9hbGYvMXRn?=
 =?utf-8?B?K25KRGVQaU9NS1lWMlBYbm4wNWR0Wm9kU2pRY1JqM2N5ZVJ5MVFRcnpCUUtT?=
 =?utf-8?B?aGZBeHlGdzZ5TlJBblJ0V21KbmNobzUyTHBtS0ZtSHVCVDRBSEl3V2d0U0M0?=
 =?utf-8?B?U3NaajBKMzhIcW9jTU9vQWpVcVQrUzV3WjFLcmVVQ0d6bmVBbGpadEpCeFAz?=
 =?utf-8?B?S0lTSTNCTkxYY1lrMWQxdU90Q0pWMmxtck14MTErTC8xUVhsb2VrQmc1b29R?=
 =?utf-8?B?TGlwRHNkcjN0TUFpUE5JeWpJMHVHWWpqb3pHQ0h2SS9RdGxTanFHMTNKQlkz?=
 =?utf-8?B?NWJETkxZb1p3dEQ2NzRIVUdiTGQwMGMvaHlsam5QdDFsOFY2T2VaRnl5enBz?=
 =?utf-8?B?eW9PdmpiQXBmUkRiVzg4VTY0Y1ZtMndHQ0VIRXlFYnFsYlQzdkwvQ3NoeG9O?=
 =?utf-8?B?eFdkTDZWa0lQaVZ3Q0doUFpHSTI1c0FnRVR4MkJiRnZvZUdzS0p2djIrTlJQ?=
 =?utf-8?B?U3BkWGY3Q21ndFNJLzdmdk1INm4rVG1hVWNrZVZRSFQxRElDU0dQN2RIQkFa?=
 =?utf-8?B?MTB4OE5GSXFlSkJTbjJYZU5ST3pWTFFXUHVJdG04WW5ldS9zalE5cGVmYnZW?=
 =?utf-8?B?QmVPd09LbExtcUZ2dkNjeGRwazNRWGRDNWxORE5xdU5yQUgxb3UzeHhycFh2?=
 =?utf-8?B?NDg0M3ltMklSVERnUGlTTTdOb1paeFdIOEpEdEVzSHBwT0JWcXcvbDE5UG9J?=
 =?utf-8?B?UVJoNm90cm9ySkgwTGFnTVNKVy90dXc2L0RCNWlJc0RBeDg1R2RqdG5HZXRG?=
 =?utf-8?B?aDYzNWFPR1FaR0VwODlYd2pJMmtmL1o0ZktvYllZZ245YWkzWWUyeDZGTlVC?=
 =?utf-8?B?KzNIZTJkRlhLN2Fsb3ArcVRDcU1PY1FXbFBxd2JBNTI4QXJJUW1pUW9Za3Nv?=
 =?utf-8?B?SlVYVzQ3WEg3Wk5lVG9IUkxrY244ODJLSTY2ZUtyeVZVd0NIVGpZZkRDSGtK?=
 =?utf-8?B?ams5VllzSUhWZlFGT1k2YzJaRVlsNGlSYzJJVXlVd09lTGkyQUR2WDlOR2xY?=
 =?utf-8?B?a2FscHAyMUEzd0ZqSnhGVk05SmQ3THVSRFJnYVR6d2VSajJucHhsNXBuZmtG?=
 =?utf-8?B?MkdveVM1UExXZEJ4Zmg2Q2RHc1RNZFRMVklBYXR1NzRabTIwcmx3anpRejJY?=
 =?utf-8?B?VG5PZzh3T1pLaWdLelFlYkNrTjl3ZnFlSGJPYmlSdGRLRGo5SUxOQ3Y0cHBw?=
 =?utf-8?B?OGxVVld3ZTN2NjlFdXNGemtuZFN3ZVRlWTkwN3hwYlVaMzM4R0ZQNXdXb3BG?=
 =?utf-8?B?VzZNNGZUU2JQcnVCZzlqTWYxVUdwTkh3UjJSbFg0TkgzbVRZUmF5L3c2Tjcr?=
 =?utf-8?B?MlhBNmZwTnlpVitmcGgwcHlZWWZNeXA1WHdyMWtkRitFSnpUWldpaDdpdkQv?=
 =?utf-8?B?ay9qWE5HekFOMVJiejh5bG5MQWo0MzllMEZncEJVb2VYM2RtZWRxaFdoOHNq?=
 =?utf-8?B?UTQ4YSsveUNXMEdWUkc3TGZPNXdDaGdQMEJRZUYvcDBOcmY1d3NVMVVEZVp1?=
 =?utf-8?B?cU95SVBxRFdYMndIc0s2ZkIxWmtsTVpnWmNIOE1mL3dwZi8yYUxma29xbUxz?=
 =?utf-8?B?YVMwM21uWVQwUDZDVWNueW5VRlY0b20veFFkU1pXa1RaKzRhc2NKeWpwWnNR?=
 =?utf-8?B?dWkzQTF5QzlpaldscEpIYjVWUFpiMWlZblZ4REIyc0FMTHpHMlVuZlhab1g2?=
 =?utf-8?B?WGlqK2V6L2kza0d3elp3d3VxRW1Ic3RHbDlXMzdpQy92UXZ0UE0xMXpyRTl0?=
 =?utf-8?B?K2VYdzdIQ0hHTzhsaktQR3JCK1pnZmhxOEV1cFFvQWNZZktnYm5Va0JJTndk?=
 =?utf-8?B?RllNT044Um9XNFluSTJQYS9NY2VWeW5hRWRPanR6WVJURE9ia3NWdnRtSjJL?=
 =?utf-8?B?UzFvQmU1cjJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0l0ZCs5Kzl4SnJhQUFDSWIvdlJtYU9rRy9tdEYrdzVzTTdJaUo1R1NralFs?=
 =?utf-8?B?amxLVERDNmZtRzg5a1J0bEJOZ0ZveGhhZUg5TWh5NVdENnhsdUV6NFB1amN1?=
 =?utf-8?B?blZJYUlMK3NmWXAzN2xUNG1lWlBSalo2bEJwVk9jaXBGTHh1L29qcU84dWh4?=
 =?utf-8?B?cm8wZ1RBTFM2cWMzS3djeE9aOXEzQ3M0cnRNa0V2SmpHZXBVdEgyL1dqRHU0?=
 =?utf-8?B?NmlBcDNaWDg2YS9TVlRhVzhzbC9xdFZxMGk4enF4Z2xRdy9YY2hlcXNrWXBQ?=
 =?utf-8?B?MHdUVlBMaGVBRUx2MlNTdjdvc1FOS2tRc2xmSFd4cVhHNjBxQ21lZTlSRTFz?=
 =?utf-8?B?RUFKSVRLQjNTdW10OFE4Q1hDS2xmUzdGbU9IVHhnY3lJYzhxaXBPQSs0MmZP?=
 =?utf-8?B?N2hJQ1AzcFY0bTJHTWtXbUc0UEpYbGozV3RYOUZrazFpblViTjRJK1F0cWQ4?=
 =?utf-8?B?UUQ2aU1aVENVZVZDM09VdTRZQUM0MkZiQlBLVGM2NkM3SE5Dd1NsL0grUDM5?=
 =?utf-8?B?ckNYdzk2bGlJNkpIZUNSY253dFp3Tjl0TUNZbzNuUW0zNHFiUzhOUWR3NHZ1?=
 =?utf-8?B?N3ZucmRmclpXRVRSa1JIMWZ0Y2tKR2NiMGxUTmlvMmZtdWNoQ0ZZWE5VM3NJ?=
 =?utf-8?B?MkIxNDhPd05DNmNGZzEvRnQ1eUJtaTBsRFVscjZzMEtIVGFiendkR1Y2aUJ6?=
 =?utf-8?B?eVZXLy9zWlFOcllzbnJaZmVJYldySjNtdjRxbTEyV2hXUG1kdk1KQjN2Q2g5?=
 =?utf-8?B?QmZmdnJUaWZIdU4wQktSUlQra3M1OXlIbTRjRitFZTNZRUp1TnVPRXdkSFFZ?=
 =?utf-8?B?dnh6R0xYRmZxNUVJVWQ5cnBnVVBHN2hGU01ZOFpzU0pvWjhhaFM3b0tlWWxM?=
 =?utf-8?B?M3Y3Vk0rRnlYQlo4ZnRBak1sM0JaeFpqcG9JQjNtV3NtdnlZcHcycEw0NjIy?=
 =?utf-8?B?bVA4aHZiKzZYcDJTNEpSV25uSFlKU2tlMFZ1NG8xQk1nU2ZHdDJGRlFPTTQv?=
 =?utf-8?B?aDVIcEVNUE5raGhjcVZudmRId0tGUVdKSlRXWTJNS3lpMkUvbkxqem9SNzdL?=
 =?utf-8?B?RTlTaWU3K0lMZ3A5UFR2aHdFMEFlUGoreld0MzFrbVI4cFlObWJnUWVjV0dR?=
 =?utf-8?B?Z2dxRGdpQzgwanp2RWxreWNmTWkxUFRqY2EzMFhGbW4xdy9rVHI5Qm9zME5D?=
 =?utf-8?B?YUVwTm5USUJaNnMyU2Y0THZxSmFvUjVZa21qK3FiY2FTNlZXNG5MY2UrbERs?=
 =?utf-8?B?N1pmMjlxQ2x0VHNSeUlMVmpMRWF5MzlYbEk5amEyN081L2RTRHZ4OUppT2tR?=
 =?utf-8?B?M1h4WWllaWMvR1piUFpZNHd5ekZsd3NoSnVGbzBOWlpBWHcwNC9YTTRCUDZV?=
 =?utf-8?B?MFBVZUZ5aE9FWWIwTGhNMklrR1BCTEpXaXdYbUJHOTdTdTVXWVRSQUtmMm85?=
 =?utf-8?B?Rk1jM0FMRlI4QXZLdTlYWUdWUWpaNGdrYnR4ZkZJNndXcmJDL3BjYWpwN0pC?=
 =?utf-8?B?RkFTckEvZ3J6Tzk3TW9OTmtVelhRMlUwUzFMckJuWWN1ci9IcGUrSnZSTDV3?=
 =?utf-8?B?dWdIRVJtWVR0UkdHV3BJaXFEamhLN3IxQnBKWlh0dXFhR2hXU2R4OGkxQkpB?=
 =?utf-8?B?cTNMZjNmemtkaFJBNDgwbk5PMlBacGNVbkQxS08zcmM5QVVBRlE0cnlCamZE?=
 =?utf-8?B?SW9aaHpiaW10aENsWi9keFZXSEJBQTMxdThKWXhNYVRzZXpJdlo2azhONW5Z?=
 =?utf-8?B?cWlUM1dLNFlweWpsQW14d1FuU0pGNnJSVEhqTThUSFdlaldDRnRMbUFRN201?=
 =?utf-8?B?YUtwbXNBY0JIMU1qbVVBdzYvNDlDRWhYMFV1Qm0xVDQzMGNESDQyNjBWMGJY?=
 =?utf-8?B?L2czeDF0V1A4ZWpibEI0NDNiWWw1SHRORDQ1ZTRXcis3cnAxcDRFTU5nMDgx?=
 =?utf-8?B?bVl5UVdlUFdxUy80K0dncHhBUjhNeEpWMlYrTERJUnJBYm5IQXd0OHhKdFR5?=
 =?utf-8?B?Q1lzZzNpWTBJTzRObUwwYWx3NVZNek1GT1RvNmhBNVBsR21BYmpkbXVQdndj?=
 =?utf-8?B?bGVwV1ZTT3kxcnBwVG82TDhwVG0yNTZTUXdaS1ZxVmtMMmlOUW5xbFoxUFlG?=
 =?utf-8?B?MHdCRVFrYVhVQW0yVUg0ODFGSXRINjVtRGUwU0l6MnFRc1NjL1JKcHJOM0Ri?=
 =?utf-8?B?MTJ1UXV5ell5UGRFZXNiOGU3L1ZSSWh5UktTTWtiU09IUnhwZWhnblQ5NEEv?=
 =?utf-8?B?WVY4S0NZZ2xPSDRudHRvKzBXdnd3PT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b024af66-0769-4aa6-ae39-08de3bc9b6e3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:04:27.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32itehvpAbORAe5p/NmPDte67USPnrW/HTSK/sNXmVmnvq4951MaS7zRcgINEOMWBNUpN1IXC+OYQfNjC4D6lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8285

On Mon, Dec 15, 2025 at 11:13:58AM +0100, Jonas Gorski wrote:
> Hi,
> 
> On Sun, Dec 14, 2025 at 7:25â€¯PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> > Problem description
> > -------------------
> >
> > DSA has a mumbo-jumbo of reference handling of the conduit net device
> > and its kobject which, sadly, is just wrong and doesn't make sense.
> >
> > There are two distinct problems.
> >
> > 1. The OF path, which uses of_find_net_device_by_node(), never releases
> >    the elevated refcount on the conduit's kobject. Nominally, the OF and
> >    non-OF paths should have identical code paths, and it is already
> >    suspicious that dsa_dev_to_net_device() has a put_device() call which
> >    is missing in dsa_port_parse_of(), but we can actually even verify
> >    that an issue exists. With CONFIG_DEBUG_KOBJECT_RELEASE=y, if we run
> >    this command "before" and "after" applying this patch:
> >
> > (unbind the conduit driver for net device eno2)
> > echo 0000:00:00.2 > /sys/bus/pci/drivers/fsl_enetc/unbind
> >
> > we see these lines in the output diff which appear only with the patch
> > applied:
> >
> > kobject: 'eno2' (ffff002009a3a6b8): kobject_release, parent 0000000000000000 (delayed 1000)
> > kobject: '109' (ffff0020099d59a0): kobject_release, parent 0000000000000000 (delayed 1000)
> >
> > 2. After we find the conduit interface one way (OF) or another (non-OF),
> >    it can get unregistered at any time, and DSA remains with a long-lived,
> >    but in this case stale, cpu_dp->conduit pointer. Holding the net
> >    device's underlying kobject isn't actually of much help, it just
> >    prevents it from being freed (but we never need that kobject
> >    directly). What helps us to prevent the net device from being
> >    unregistered is the parallel netdev reference mechanism (dev_hold()
> >    and dev_put()).
> >
> > Actually we actually use that netdev tracker mechanism implicitly on
> > user ports since commit 2f1e8ea726e9 ("net: dsa: link interfaces with
> > the DSA master to get rid of lockdep warnings"), via netdev_upper_dev_link().
> > But time still passes at DSA switch probe time between the initial
> > of_find_net_device_by_node() code and the user port creation time, time
> > during which the conduit could unregister itself and DSA wouldn't know
> > about it.
> >
> > So we have to run of_find_net_device_by_node() under rtnl_lock() to
> > prevent that from happening, and release the lock only with the netdev
> > tracker having acquired the reference.
> >
> > Do we need to keep the reference until dsa_unregister_switch() /
> > dsa_switch_shutdown()?
> > 1: Maybe yes. A switch device will still be registered even if all user
> >    ports failed to probe, see commit 86f8b1c01a0a ("net: dsa: Do not
> >    make user port errors fatal"), and the cpu_dp->conduit pointers
> >    remain valid.  I haven't audited all call paths to see whether they
> >    will actually use the conduit in lack of any user port, but if they
> >    do, it seems safer to not rely on user ports for that reference.
> > 2. Definitely yes. We support changing the conduit which a user port is
> >    associated to, and we can get into a situation where we've moved all
> >    user ports away from a conduit, thus no longer hold any reference to
> >    it via the net device tracker. But we shouldn't let it go nonetheless
> >    - see the next change in relation to dsa_tree_find_first_conduit()
> >    and LAG conduits which disappear.
> >    We have to be prepared to return to the physical conduit, so the CPU
> >    port must explicitly keep another reference to it. This is also to
> >    say: the user ports and their CPU ports may not always keep a
> >    reference to the same conduit net device, and both are needed.
> >
> > As for the conduit's kobject for the /sys/class/net/ entry, we don't
> > care about it, we can release it as soon as we hold the net device
> > object itself.
> >
> > History and blame attribution
> > -----------------------------
> >
> > The code has been refactored so many times, it is very difficult to
> > follow and properly attribute a blame, but I'll try to make a short
> > history which I hope to be correct.
> >
> > We have two distinct probing paths:
> > - one for OF, introduced in 2016 in commit 83c0afaec7b7 ("net: dsa: Add
> >   new binding implementation")
> > - one for non-OF, introduced in 2017 in commit 71e0bbde0d88 ("net: dsa:
> >   Add support for platform data")
> >
> > These are both complete rewrites of the original probing paths (which
> > used struct dsa_switch_driver and other weird stuff, instead of regular
> > devices on their respective buses for register access, like MDIO, SPI,
> > I2C etc):
> > - one for OF, introduced in 2013 in commit 5e95329b701c ("dsa: add
> >   device tree bindings to register DSA switches")
> > - one for non-OF, introduced in 2015 in commit 91da11f870f0 ("net:
> >   Distributed Switch Architecture protocol support")
> >
> > except for tiny bits and pieces like dsa_dev_to_net_device() which were
> > seemingly carried over since the original commit, and used to this day.
> >
> > The point is that the original probing paths received a fix in 2015 in
> > the form of commit 679fb46c5785 ("net: dsa: Add missing master netdev
> > dev_put() calls"), but the fix never made it into the "new" (dsa2)
> > probing paths that can still be traced to today, and the fixed probing
> > path was later deleted in 2019 in commit 93e86b3bc842 ("net: dsa: Remove
> > legacy probing support").
> >
> > That is to say, the new probing paths were never quite correct in this
> > area.
> >
> > The existence of the legacy probing support which was deleted in 2019
> > explains why dsa_dev_to_net_device() returns a conduit with elevated
> > refcount (because it was supposed to be released during
> > dsa_remove_dst()). After the removal of the legacy code, the only user
> > of dsa_dev_to_net_device() calls dev_put(conduit) immediately after this
> > function returns. This pattern makes no sense today, and can only be
> > interpreted historically to understand why dev_hold() was there in the
> > first place.
> >
> > Change details
> > --------------
> >
> > Today we have a better netdev tracking infrastructure which we should
> > use. It belongs in common code (dsa_port_parse_cpu()), which shows that
> > the OF and non-OF code paths aren't actually so different.
> >
> > When dsa_port_parse_cpu() or any subsequent function during setup fails,
> > dsa_switch_release_ports() will be called. However, dsa_port_parse_cpu()
> > may fail prior to us assigning cpu_dp->conduit and bumping the reference.
> > So we have to test for the conduit being NULL prior to calling
> > netdev_put().
> >
> > There have still been so many transformations to the code since the
> > blamed commits (rename master -> conduit, commit 0650bf52b31f ("net:
> > dsa: be compatible with masters which unregister on shutdown")), that it
> > only makes sense to fix the code using the best methods available today
> > and see how it can be backported to stable later. I suspect the fix
> > cannot even be backported to kernels which lack dsa_switch_shutdown(),
> > and I suspect this is also maybe why the long-lived conduit reference
> > didn't make it into the new DSA probing paths at the time (problems
> > during shutdown).
> >
> > Because dsa_dev_to_net_device() has a single call site and has to be
> > changed anyway, the logic was just absorbed into the non-OF
> > dsa_port_parse().
> 
> Largely matches my observations.
> 
> >
> > Tested on the ocelot/felix switch and on dsa_loop, both on the NXP
> > LS1028A with CONFIG_DEBUG_KOBJECT_RELEASE=y.
> 
> Also tested on b53, but since it neither has multiple conduits nor LAG
> support (yet), the testing was very limited.
> 
> Two minor nits/comments though ...
> >
> > Reported-by: Ma Ke <make24@iscas.ac.cn>
> > Closes: https://lore.kernel.org/netdev/20251214131204.4684-1-make24@iscas.ac.cn/
> > Fixes: 83c0afaec7b7 ("net: dsa: Add new binding implementation")
> > Fixes: 71e0bbde0d88 ("net: dsa: Add support for platform data")
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >  include/net/dsa.h |  1 +
> >  net/dsa/dsa.c     | 53 +++++++++++++++++++++++++----------------------
> >  2 files changed, 29 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/net/dsa.h b/include/net/dsa.h
> > index cced1a866757..6b2b5ed64ea4 100644
> > --- a/include/net/dsa.h
> > +++ b/include/net/dsa.h
> > @@ -302,6 +302,7 @@ struct dsa_port {
> >         struct devlink_port     devlink_port;
> >         struct phylink          *pl;
> >         struct phylink_config   pl_config;
> > +       netdevice_tracker       conduit_tracker;
> >         struct dsa_lag          *lag;
> >         struct net_device       *hsr_dev;
> >
> > diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> > index a20efabe778f..ac7900113d2b 100644
> > --- a/net/dsa/dsa.c
> > +++ b/net/dsa/dsa.c
> > @@ -1221,6 +1221,7 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *conduit,
> >                 dst->tag_ops = tag_ops;
> >         }
> >
> > +       netdev_hold(conduit, &dp->conduit_tracker, GFP_KERNEL);
> >         dp->conduit = conduit;
> >         dp->type = DSA_PORT_TYPE_CPU;
> >         dsa_port_set_tag_protocol(dp, dst->tag_ops);
> > @@ -1253,14 +1254,21 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
> >         if (ethernet) {
> >                 struct net_device *conduit;
> >                 const char *user_protocol;
> > +               int err;
> >
> > +               rtnl_lock();
> >                 conduit = of_find_net_device_by_node(ethernet);
> >                 of_node_put(ethernet);
> > -               if (!conduit)
> > +               if (!conduit) {
> > +                       rtnl_unlock();
> >                         return -EPROBE_DEFER;
> > +               }
> >
> >                 user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
> 
> Maybe move this to before the rtnl_lock()? Not sure if this makes a
> difference (avoiding a lookup for netdev not yet there vs avoiding a
> lookup under rtnl lock).

If keeping the rtnl mutex acquired for too long is a concern (dsa_port_parse_cpu()
also calls request_module(), so there's that), I guess I could also reconsider
moving the netdev_hold() call right after the successful of_find_net_device_by_node()
call, and release the rtnl mutex right away. It's a tradeoff and I initially
considered that, but the error handling would become slightly more complex
and there would be some duplicated logic between the OF and non-OF paths.

> > -               return dsa_port_parse_cpu(dp, conduit, user_protocol);
> > +               err = dsa_port_parse_cpu(dp, conduit, user_protocol);
> > +               put_device(&conduit->dev);
> > +               rtnl_unlock();
> > +               return err;
> >         }
> >
> >         if (link)
> > @@ -1393,37 +1401,27 @@ static struct device *dev_find_class(struct device *parent, char *class)
> >         return device_find_child(parent, class, dev_is_class);
> >  }
> >
> > -static struct net_device *dsa_dev_to_net_device(struct device *dev)
> > -{
> > -       struct device *d;
> > -
> > -       d = dev_find_class(dev, "net");
> > -       if (d != NULL) {
> > -               struct net_device *nd;
> > -
> > -               nd = to_net_dev(d);
> > -               dev_hold(nd);
> > -               put_device(d);
> > -
> > -               return nd;
> > -       }
> > -
> > -       return NULL;
> > -}
> > -
> >  static int dsa_port_parse(struct dsa_port *dp, const char *name,
> >                           struct device *dev)
> >  {
> >         if (!strcmp(name, "cpu")) {
> >                 struct net_device *conduit;
> > +               struct device *d;
> > +               int err;
> >
> > -               conduit = dsa_dev_to_net_device(dev);
> > -               if (!conduit)
> > +               rtnl_lock();
> > +               d = dev_find_class(dev, "net");
> > +               if (!d) {
> > +                       rtnl_unlock();
> >                         return -EPROBE_DEFER;
> > +               }
> >
> > -               dev_put(conduit);
> > +               conduit = to_net_dev(d);
> >
> > -               return dsa_port_parse_cpu(dp, conduit, NULL);
> > +               err = dsa_port_parse_cpu(dp, conduit, NULL);
> > +               put_device(d);
> > +               rtnl_unlock();
> > +               return err;
> >         }
> >
> >         if (!strcmp(name, "dsa"))
> > @@ -1491,6 +1489,9 @@ static void dsa_switch_release_ports(struct dsa_switch *ds)
> >         struct dsa_vlan *v, *n;
> >
> >         dsa_switch_for_each_port_safe(dp, next, ds) {
> > +               if (dsa_port_is_cpu(dp) && dp->conduit)
> > +                       netdev_put(dp->conduit, &dp->conduit_tracker);
> > +
> >                 /* These are either entries that upper layers lost track of
> >                  * (probably due to bugs), or installed through interfaces
> >                  * where one does not necessarily have to remove them, like
> > @@ -1635,8 +1636,10 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
> >         /* Disconnect from further netdevice notifiers on the conduit,
> >          * since netdev_uses_dsa() will now return false.
> >          */
> > -       dsa_switch_for_each_cpu_port(dp, ds)
> > +       dsa_switch_for_each_cpu_port(dp, ds) {
> > +               netdev_put(dp->conduit, &dp->conduit_tracker);
> >                 dp->conduit->dsa_ptr = NULL;
> 
> We should probably call netdev_put() only after clearing
> dp->conduit->ds_ptr, not before.

Ok.

> With that addressed,
> 
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

Thanks for the feedback.

> 
> > +       }
> >
> >         rtnl_unlock();
> >  out:
> > --
> > 2.43.0
> >

