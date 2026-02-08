Return-Path: <netdev+bounces-257836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAUOJkSziGkkuwQAu9opvQ
	(envelope-from <netdev+bounces-257836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:01:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17057109552
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A3DB302414D
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD134EEEE;
	Sun,  8 Feb 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TDgkxgbC"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF71348860;
	Sun,  8 Feb 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566459; cv=fail; b=Wxx51KntWd/JqmYZDL1VdqNqhGxVb4ulkWPIJ1EsY+LvTendePET7fb4sZUeorqODyzLJhvxEjhNnwRKj9KfFkYGf1tLjeh9hKkmirAp6yq+eKnp0X9mNr52+1TRsv5GbNezw+mAtsePViKuKfmZP1J4bIZrnHF8/rXaLqNEG2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566459; c=relaxed/simple;
	bh=TQPX+bkZ192HPGXh5WjJkLA806wNHDlKDWXSPJS2gFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jYswPL5HBCY6HS1N3OGxSmid7qnVhzLBsg0xxLXKRF39bp9mOiceyWz5RDIFH/Tn6DaHU8wzOHzQw4FqfcM1SJ8wM9ZxSCTfhXc8tvJ3H/iiJH1sCC6MrEaq7n92w0wY2iIM4GJi5Xu89RWQvxc105Hab4IGbv1L5MnbtB5HDIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TDgkxgbC reason="signature verification failed"; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovefrU6sTYr5gcB+Sxhsex9vczLiYUMg8vJW9ml7hByeFYFZmhCcUJsLXsx3IiyGxwfiW43kjTk5pB1JUcakDx9hySbUcelMcsarnAiGIXsHMc622hJF5PwkT5ohiIQlFGaXyhAdHpQ8XdmNYOXNxNLLqZ4ABgGZoLsOZWpxLBcDP9wpz0sQ7uMYMX+Y/cIT1nqRwbhnNXCHdICNncNoFwCEoywSoCVOC1zBK8p0lcrxzvlQeOHYjpzQmST1U/fGq/snNNXi7rPgBSHm9IMWk3mR3Vk8L3uk6D5fBK5Qe44Y0bL89svCc0cewgUFCdP/ejRlB5SAUMQhS5E8FsDRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKuhP7jwuQI990FN5b/oAHRiHRrbGZi3K9RlW4z2SVw=;
 b=uDjeFoe0lYxA2WJE5nLtxd8IElPj+Yst2uaod7EILH//aU1VKxalwHVkQkSjzztDWlv9gHmsKXibgu2kcBunZMXFP8UCoCg/5znV+u8inJC8N34O8GZh+i6ma3xxkCAJc1X9fkV4Zi9Wpcz1kqhUgJ5/WUB+QHEckPSvIzVPE8OlJyEK8KKagzL/Q5O3vBceWdevXpdW7v8yWJZssPyJZAMQI0kkilxm+06uEkSKkvj68mvZzeAdBjhSDWkJi6IJkAf/U5jXhDvN7D7MMLCoqdxdt2JSbTNr82spZdbVT9Dx16yoHkwQ6gC7IbnZUD4Z3oMNsnUKURn2/PL9ffT4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKuhP7jwuQI990FN5b/oAHRiHRrbGZi3K9RlW4z2SVw=;
 b=TDgkxgbCy2N7YpwhpPvjCgKQNOc5DksJLr96xfimWl0mNrG9aQLFUQ7bTcXqiB8me2L5f7WeAuKdmqys0jptwL/HgcEYPjVGNkhCJTWAf4GKEhWs77RIS5+LFZ5UYYjj2uSlwgC2dmburNsjiRefY0Mfe+PH7fbxPUVtd+NOYOqtlSqBiLu4IOvhMa0wCySv5YvhsWNJ0bjQVLAbPqKAys/KbShogyVo30ZPWNJlABHIRkxEkCoOFTqkbgnRXZ9Xpzl2i8YbtaN2PjemIGkRCMt4H8CIhvvp8qso939qFUgTEHedxvi9qwj9rM3hYuErXwxNU7mS7dAV/TCDjwW2wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:00:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:00:55 +0000
Date: Sun, 8 Feb 2026 18:00:46 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 02/14] net: bridge: mcast: track active
 state, adding tests
Message-ID: <20260208160046.GB154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-3-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-3-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab57931-c66b-452d-902b-08de672b3dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?i+aZ8hHzCUNqc7D8Uz06YonhAbLa8B+hi995+m7IJmNarfQcratzlf0ceY?=
 =?iso-8859-1?Q?mv3tsfP0yfsOOAAB1Oa+bJGM5BDWOO9eKDcFGbF9egxg7W+5gwheZk93v6?=
 =?iso-8859-1?Q?KoTmyeKz41gof6I2BRUG7YwhZQn+mCioyxQVEOzZM6e/b9VftA6d7tFcYQ?=
 =?iso-8859-1?Q?5Tzk1Mgp3BAgpSxK+SM9ad3F9lsc9zKB3yTuaKcJPNwr8kjPfc//It6Koa?=
 =?iso-8859-1?Q?8mtKEqn+TvJ1E12xialO6pYLQIzFEFEHu9m8Wg9CVLRtoEQkTaXZ+QUfSD?=
 =?iso-8859-1?Q?BKewO7Bqw4xWMSB2dYEqNCjtaBuAyIU9V8+mkwOOyvxhzOpG6edwuE68+8?=
 =?iso-8859-1?Q?JxLruq1/by8FpJeawhNylgwbSOMGrY6mvps5fjGYfjPoIKWiL74MyqCQrn?=
 =?iso-8859-1?Q?oIiRSb0uCniesxyVpVWWp16IbaveKEM5xAmraHF0YVzXbZp+Kocx9G+Dtu?=
 =?iso-8859-1?Q?iOBKmoy71xIL7y8vByitkmYYruLYmFUZyKtxbwrm/OraVnFo6xvPSPlN3L?=
 =?iso-8859-1?Q?rhpX50GtJP6OUGVKLjEQw+9oHD4qlyKvUQBnGcCupChc2cuLRgUSYtdXO6?=
 =?iso-8859-1?Q?biJINDprjUzpIxL1M96sNn51JExFIQYx/OxNtNkLEpNabkvqPA/FKZ0JIm?=
 =?iso-8859-1?Q?IkBqzjXhp5IyAp0xZGp2hfXf+NHFsiVq2ywqCJhbrtyZBTSpgBWjtEDemm?=
 =?iso-8859-1?Q?Cau1Lx0+IdOWCxqo8abTDH/xN6IFLC+nr/Xhc4gHRE/E0qYh457fNZAMPa?=
 =?iso-8859-1?Q?ERMJIdL/HL1I7PRzrodBxbea5P8mayvpJvSzKjrUWa1OIOWhbLW0D6OiNG?=
 =?iso-8859-1?Q?X3KdY8Vtx5mias88/xLVJF+hhRNF+pGangHmslORyq/3IX/9IrxibB9rRi?=
 =?iso-8859-1?Q?vcpZV8lCiDvpP2Uut5etJcVWooGIH61KDi3vek2B1msCQBWHdBTr2TEcm1?=
 =?iso-8859-1?Q?8V6HEyupNTC/i8DawLzwQJDNpdSpxOQw0LqSwacB0W7uF4U28n8d/qTW+x?=
 =?iso-8859-1?Q?vhWelTnEbohmlCnE0DigH0/atWG2LKckjkSN6/bgcZcGeOlOoV5Z3dU7ew?=
 =?iso-8859-1?Q?LagdxUhp/vnYad/qm1rqGoUn0IMzia311pxt+meYpnhnfgBO8Ip+aeXca+?=
 =?iso-8859-1?Q?SXKRthjdXVsg+JS1DhvvkbhuloAz9OijElxiFWUDWmZvqwY6zoTw/rZ5XW?=
 =?iso-8859-1?Q?YlB1bGHsaJnRJtfCSt1HD2oOFS3bEk1V88Ccglwx4dXpA2X9C1xxzW7394?=
 =?iso-8859-1?Q?7njbFltqOJKW90lsUVc6kx2JwkiZBpPBgKeQEXtqvv5NN18eaAUNsuxKyx?=
 =?iso-8859-1?Q?QMFCDgrOs+Y38J89Dzk+zB9X30KNABR6gtNLlLoUXE8eTuvX559Fohx6VW?=
 =?iso-8859-1?Q?R3XerxBt5R6gVaKF0Wc0He1Qpm0m+/JHTlFz6c9U8fTzP5yio20qnxYmmK?=
 =?iso-8859-1?Q?x+eXn84xtbjrz+/dGtujQYVNOKStftQahhSLH3z6EyUAKWBRBUX9y30X0N?=
 =?iso-8859-1?Q?sLk23oZQ/lpsCCQIKZWZMZTTHx3Myn11db4HjJHoR8QK1py3vHgqAhl1og?=
 =?iso-8859-1?Q?StGhyF/LWxK5S2yS6U4CtZeBx4vunQchGpP6R+GEHfNMsGGmlFiBIayoFW?=
 =?iso-8859-1?Q?dORY3dvj2DyTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?jajfHlxH5SVtT3cHIKMZNXqukL92nGYqOLkXKCK/0jTHMeErQg1dVUqTbH?=
 =?iso-8859-1?Q?MViBq264hcn7rWuslvU59SIxX4CzexNYcauqTzldGc58e/imjq5VFvgdBS?=
 =?iso-8859-1?Q?pIEjJIZTpTAELG58fIW7UZbWiTmiLfFu0I28wjpSlI35E1y+ZqdWs4Z7xA?=
 =?iso-8859-1?Q?XsiKL3c1RevOaiOI5KwArxqUc0OlcK/SbG4qrquBcSwDM/Cttt56+EgQc9?=
 =?iso-8859-1?Q?+4AdZ/DSsVreS0P8RkU8H00ekWDXZAICEez+R4Ind4fGqn14zLEUB8OVqk?=
 =?iso-8859-1?Q?+NG4NyY3EottsKEPlkYUEIrpLPZIHY2WiL/d/hWddz4VNT4GIe18M+gbSB?=
 =?iso-8859-1?Q?S3MRRD9lmu+WX/bbMPDKWU9EeWMvV6WTDrf43q2i8t+cq8cAS/L1QTwMqN?=
 =?iso-8859-1?Q?3gbSYSghRHxXIRg2OW+jJhH4Udsjko6clUyJ0xhNgJY9LN2t94TUtA71mb?=
 =?iso-8859-1?Q?uVBJ0pLzaY3kJlMwDLc3O8X4siDxQqZLLvXphydgDflTRytAziwFbPmjVi?=
 =?iso-8859-1?Q?2ICQ3R8FiFD4FHEcCS72brkvX+/IYK2465RdGWvP8l2vHZ+6LTsbRDROxN?=
 =?iso-8859-1?Q?hUR8z+Hs2WWHRwvufuw+vG1ReRQ5kxSB7xMc3dI5HdATf+KhefkbwWigfD?=
 =?iso-8859-1?Q?qxVKK+QRX6TUiLAV20ICtintTf5F5WHLWKU7bIFWNxbgeay6mOcjWO+Dc7?=
 =?iso-8859-1?Q?6H7+v2/SCDZNBnXNEnwE+xga8htuznv3y86OX71BPmnjwxPT9xl6qyqSy3?=
 =?iso-8859-1?Q?PqwKTpTYkt8ioipYd/6nGwONj1G1IgfJsr0TWBfnL2bON5gouNvIKYSLcH?=
 =?iso-8859-1?Q?SWWhfC2LYe5SkKlj0673wiuGmazyA8PCk/ZbHrGLfYe2TjiZa037yr2Pmq?=
 =?iso-8859-1?Q?PaYIPVNnZBtDJyxFE/AeVtZMJZtLN7XvUQURrdUTmVchtVvloC8zXon9O0?=
 =?iso-8859-1?Q?9ymtockP2uAGc28MP4Zkitii+KNJa0czPE6BWQSe51BEGrWcflm2NjSQd6?=
 =?iso-8859-1?Q?0TmRWiyBVUPwgEg3ZJ2OPRylL/G/bcDq6ke1d0honIDB7Ikg7toQPP3iow?=
 =?iso-8859-1?Q?vnwgDDicJewIVv2VcfmNQvTR2AlGRRsMGsKhgRWYt5KZXJfl4QQ0n7X2Xx?=
 =?iso-8859-1?Q?6iO5jmE7DD0qzsyEs3T1LT+tntpYhzfW14P8mOHyd7bhScKGKMydtmhQIN?=
 =?iso-8859-1?Q?/eynOsRMKTxh+NN1mhFHXt1+iXa9WCHZ5dEUIywXH8vJE5iphvtShEmjxF?=
 =?iso-8859-1?Q?WMHnwSBtAJ/9wO5o1RynINFeD3eW8ALY+Y/jfk7DqQNVB2rzsn68UKeWE4?=
 =?iso-8859-1?Q?JepMkaKDiaP5GsBZ/clSlQbApKC53ShngTBAra7B3AZXGba8fHn/TCrxwD?=
 =?iso-8859-1?Q?WC/FXPlsmw3XZmFKAydIsA0YRRSqPwvT/GJdXdGGBfhMZAqserxjxWJg+p?=
 =?iso-8859-1?Q?usdDpY25JIvOCQsHmXfm0CUS0IHGnvGntBDIlXqLToVeXT6ulfrUIKJo/m?=
 =?iso-8859-1?Q?nfay1InhrTQAZdoThX7C9mvXCf9JJegq36oOMKY73Fk7z/zJgcyyWHjrUp?=
 =?iso-8859-1?Q?vTEKWZDqyIgpvf2Urqm5rfQzHVleiwm2XHTbaKclKioHt+yM9x6yuKiiza?=
 =?iso-8859-1?Q?4+uiHXmcImx2HWYJTnbkBa0EkJGSu/t1nr1+ebf3+lftxKzK8zt/qJ7smC?=
 =?iso-8859-1?Q?PvHYMifJd2F+NDLLY3iWvHSoCqFemuW/JV/cCx3i8dYfalUwxJH2XrKQyG?=
 =?iso-8859-1?Q?Lhmd8uK8DkJAlz+xh8TgS2A3BCvfcUaUdm4DxFyGyu3WMu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab57931-c66b-452d-902b-08de672b3dec
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:00:55.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXydHj/zl+L93j2oJMK9UAqsY7SfHI5XxFSmrOM2B5GkbzKMdSF2qZGjSd446ELdIN9UDg04TXKSj24tw/os3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257836-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c0d3.blue:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.sh:url]
X-Rspamd-Queue-Id: 17057109552
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:08AM +0100, Linus Lüssing wrote:
> Before making any significant changes to the internals of the Linux
> bridge add some tests regarding the multicast activity. This is
> also to verify that we have the semantics of the new
> *_MCAST_ACTIVE_{V4,V6} netlink attributes as expected.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  .../net/forwarding/bridge_mdb_active.sh       | 682 ++++++++++++++++++
>  1 file changed, 682 insertions(+)
>  create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb_active.sh
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_active.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_active.sh
> new file mode 100755
> index 000000000000..5b6e14d88bc2
> --- /dev/null
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb_active.sh
> @@ -0,0 +1,682 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# +-------+      +---------+
> +# | brq0  |      | br0     |
> +# | + $h1 |      | + $swp1 |
> +# +----|--+      +----|----+
> +#      |              |
> +#      \--------------/
> +#
> +#
> +# This script checks if we have the expected mcast_active_v{4,6} state
> +# on br0 in a variety of scenarios. This state determines if ultimately
> +# multicast snooping is applied to multicast data packets
> +# (multicast snooping active) or if they are (by default) flooded instead
> +# (multicast snooping inactive).
> +#
> +# Notably, multicast snooping can be enabled but still be inactive if not all
> +# requirements to safely apply multicast snooping to multicast data packets
> +# are met.
> +#
> +# Depending on the test case an IGMP/MLD querier might be on brq0, on br0
> +# or neither.
> +
> +
> +ALL_TESTS="
> +	test_inactive
> +	test_active_other_querier
> +	test_active_own_querier
> +	test_inactive_brdown
> +	test_inactive_nov6
> +	test_inactive_snooping_off
> +	test_inactive_querier_off
> +	test_inactive_other_querier_norespdelay
> +	test_inactive_own_querier_norespdelay
> +	test_inactive
> +	test_vlan_inactive
> +	test_vlan_active_other_querier
> +	test_vlan_active_own_querier
> +	test_vlan_inactive_brdown
> +	test_vlan_inactive_nov6
> +	test_vlan_inactive_snooping_off
> +	test_vlan_inactive_vlans_snooping_off
> +	test_vlan_inactive_vlan_snooping_off
> +	test_vlan_inactive_other_querier_norespdelay
> +	test_vlan_inactive_own_querier_norespdelay
> +"
> +
> +NUM_NETIFS=1

Shouldn't this be "2" given below you have "swp1=${NETIFS[p2]}"?

> +MCAST_MAX_RESP_IVAL_SEC=1
> +MCAST_VLAN_ID=42
> +source lib.sh
> +
> +switch_create()
> +{
> +	ip link add dev br0 type bridge\
> +		vlan_filtering 0 \
> +		mcast_query_response_interval $((${MCAST_MAX_RESP_IVAL_SEC}*100))\
> +		mcast_snooping 0 \
> +		mcast_vlan_snooping 0
> +	ip link add dev brq0 type bridge\
> +		vlan_filtering 0 \
> +		mcast_query_response_interval $((${MCAST_MAX_RESP_IVAL_SEC}*100))\
> +		mcast_snooping 0 \
> +		mcast_vlan_snooping 0
> +
> +	echo 1 > /proc/sys/net/ipv6/conf/br0/disable_ipv6
> +	echo 1 > /proc/sys/net/ipv6/conf/brq0/disable_ipv6
> +
> +	ip link set dev $swp1 master br0
> +	ip link set dev $h1 master brq0
> +
> +	ip link set dev $h1 up
> +	ip link set dev $swp1 up
> +}
> +
> +switch_destroy()
> +{
> +	ip link set dev $swp1 down
> +	ip link set dev $h1 down
> +
> +	ip link del dev brq0
> +	ip link del dev br0
> +}
> +
> +setup_prepare()
> +{
> +	h1=${NETIFS[p1]}
> +	swp1=${NETIFS[p2]}
> +
> +	switch_create
> +}
> +
> +cleanup()
> +{
> +	pre_cleanup
> +	switch_destroy
> +}
> +
> +mcast_active_check()
> +{
> +	local af="$1"
> +	local state="$2"
> +
> +	ip -d -j link show dev br0\
> +		| jq -e ".[] | select(.linkinfo.info_data.mcast_active_$af == $state)"\
> +		&> /dev/null
> +
> +	check_err $? "Mcast active check failed"

Please include the address family in the error message to make it
clearer what failed. Same in other places

> +}
> +
> +mcast_vlan_active_check()
> +{
> +	local af="$1"
> +	local state="$2"
> +	local vid="${MCAST_VLAN_ID}"
> +	local ret
> +
> +	bridge -j vlan global show dev br0\
> +		| jq -e ".[].vlans.[] | select(.vlan == $vid and .mcast_active_$af == 1)"\
> +		&> /dev/null
> +	ret="$?"
> +
> +	if [ $ret -eq 0 -a $state -eq 0 ] || [ $ret -ne 0 -a $state -eq 1 ]; then
> +		check_err 1 "Mcast VLAN active check failed"
> +	fi
> +}
> +
> +mcast_assert_active_v4()
> +{
> +	mcast_active_check "v4" "1"
> +}
> +
> +mcast_assert_active_v6()
> +{
> +	mcast_active_check "v6" "1"
> +}
> +
> +mcast_assert_inactive_v4()
> +{
> +	mcast_active_check "v4" "0"
> +}
> +
> +mcast_assert_inactive_v6()
> +{
> +	mcast_active_check "v6" "0"
> +}
> +
> +mcast_vlan_assert_active_v4()
> +{
> +	mcast_vlan_active_check "v4" "1"
> +}
> +
> +mcast_vlan_assert_active_v6()
> +{
> +	mcast_vlan_active_check "v6" "1"
> +}
> +
> +mcast_vlan_assert_inactive_v4()
> +{
> +	mcast_vlan_active_check "v4" "0"
> +}
> +
> +mcast_vlan_assert_inactive_v6()
> +{
> +	mcast_vlan_active_check "v6" "0"
> +}
> +
> +

Double blank line

> +test_inactive_nolog()
> +{
> +	ip link set dev br0 down
> +	ip link set dev brq0 down
> +	ip link set dev br0 type bridge mcast_snooping 0
> +	ip link set dev brq0 type bridge mcast_snooping 0
> +	ip link set dev br0 type bridge mcast_querier 0
> +	ip link set dev brq0 type bridge mcast_querier 0
> +	ip link set dev br0 type bridge mcast_vlan_snooping 0
> +	ip link set dev br0 type bridge vlan_filtering 0
> +
> +	echo 1 > /proc/sys/net/ipv6/conf/br0/disable_ipv6
> +	echo 1 > /proc/sys/net/ipv6/conf/brq0/disable_ipv6
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +}
> +
> +test_inactive()
> +{
> +	RET=0
> +
> +	test_inactive_nolog
> +	log_test "Mcast inactive test"
> +}
> +
> +wait_lladdr_dad() {
> +	local check_tentative
> +
> +	check_tentative="map(select(.scope == \"link\" and ((.tentative == true) | not))) | .[]"
> +
> +	ip -6 -j a s dev "$1"\
> +		| jq -e ".[].addr_info | ${check_tentative}" &> /dev/null
> +}
> +
> +test_active_setup_bridge()
> +{
> +	[ -n "$1" ] && echo 0 > /proc/sys/net/ipv6/conf/br0/disable_ipv6
> +	[ -n "$2" ] && echo 0 > /proc/sys/net/ipv6/conf/brq0/disable_ipv6
> +
> +	[ -n "$3" ] && ip link set dev br0 up
> +	[ -n "$4" ] && ip link set dev brq0 up
> +	[ -n "$5" ] && slowwait 3 wait_lladdr_dad br0
> +	[ -n "$6" ] && slowwait 3 wait_lladdr_dad brq0
> +}
> +
> +test_active_setup_config()
> +{
> +	[ -n "$1" ] && ip link set dev br0 type bridge mcast_snooping 1
> +	[ -n "$2" ] && ip link set dev brq0 type bridge mcast_snooping 1
> +	[ -n "$3" ] && ip link set dev br0 type bridge mcast_querier 1
> +	[ -n "$4" ] && ip link set dev brq0 type bridge mcast_querier 1
> +}
> +
> +test_active_setup_wait()
> +{
> +	sleep $((${MCAST_MAX_RESP_IVAL_SEC} * 2))
> +}
> +
> +test_active_setup_reset_own_querier()
> +{
> +	ip link set dev br0 type bridge mcast_querier 0
> +	ip link set dev br0 type bridge mcast_querier 1
> +
> +	test_active_setup_wait
> +}
> +
> +test_vlan_active_setup_config()
> +{
> +	[ -n "$1" ] && ip link set dev br0 type bridge vlan_filtering 1
> +	[ -n "$2" ] && ip link set dev brq0 type bridge vlan_filtering 1
> +	[ -n "$3" ] && ip link set dev br0 type bridge mcast_vlan_snooping 1
> +	[ -n "$4" ] && ip link set dev brq0 type bridge mcast_vlan_snooping 1
> +}
> +
> +test_vlan_active_setup_add_vlan()
> +{
> +	bridge vlan add vid ${MCAST_VLAN_ID} dev $swp1
> +	bridge vlan add vid ${MCAST_VLAN_ID} dev $h1
> +	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0\
> +		mcast_query_response_interval $((${MCAST_MAX_RESP_IVAL_SEC}*100))
> +	bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0\
> +		mcast_query_response_interval $((${MCAST_MAX_RESP_IVAL_SEC}*100))
> +	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_snooping 0
> +	bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0 mcast_snooping 0
> +	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_querier 0
> +	bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0 mcast_querier 0
> +}
> +
> +test_vlan_active_setup_config_vlan()
> +{
> +	[ -n "$1" ] && bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_snooping 1
> +	[ -n "$2" ] && bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0 mcast_snooping 1
> +	[ -n "$3" ] && bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_querier 1
> +	[ -n "$4" ] && bridge vlan global set vid ${MCAST_VLAN_ID} dev brq0 mcast_querier 1
> +}
> +
> +test_vlan_teardown()
> +{
> +	bridge vlan del vid ${MCAST_VLAN_ID} dev $swp1
> +	bridge vlan del vid ${MCAST_VLAN_ID} dev $h1
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +	mcast_vlan_assert_inactive_v4
> +	mcast_vlan_assert_inactive_v6
> +}
> +
> +test_vlan_active_setup_reset_own_querier()
> +{
> +	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_querier 0
> +	bridge vlan global set vid ${MCAST_VLAN_ID} dev br0 mcast_querier 1
> +
> +	test_active_setup_wait
> +}
> +
> +test_active_other_querier_nolog()
> +{
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  "4"
> +	test_active_setup_wait
> +
> +	mcast_assert_active_v4
> +	mcast_assert_active_v6
> +}
> +
> +test_active_other_querier()
> +{
> +	RET=0
> +
> +	test_active_other_querier_nolog
> +	test_inactive_nolog
> +	log_test "Mcast active with other querier test"
> +}
> +
> +test_active_own_querier_nolog()
> +{
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" "3" ""
> +	test_active_setup_wait
> +
> +	mcast_assert_active_v4
> +	mcast_assert_active_v6
> +}
> +
> +test_active_own_querier()
> +{
> +	RET=0
> +
> +	test_active_own_querier_nolog
> +	test_inactive_nolog
> +	log_test "Mcast active with own querier test"
> +}
> +
> +test_active_final()
> +{
> +	mcast_assert_active_v4
> +	mcast_assert_active_v6
> +
> +	test_inactive_nolog
> +}
> +
> +test_inactive_brdown()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" ""  "4" ""  "6"
> +	test_active_setup_config "1" "2" "3" ""
> +	test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +
> +	test_active_setup_bridge ""  ""  "3" ""  ""  ""
> +	mcast_assert_active_v4
> +	mcast_assert_inactive_v6
> +
> +	test_active_setup_bridge ""  ""  ""  ""  "5" ""
> +	test_active_setup_reset_own_querier
> +	test_active_final
> +
> +	log_test "Mcast inactive, bridge down test"
> +}
> +
> +test_inactive_nov6()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge ""  "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" "3" ""
> +	test_active_setup_wait
> +
> +	mcast_assert_active_v4
> +	mcast_assert_inactive_v6
> +
> +	test_active_setup_bridge "1" ""  ""  ""  "5" ""
> +	test_active_setup_reset_own_querier
> +	test_active_final
> +
> +	log_test "Mcast inactive, own querier, no IPv6 address test"
> +}
> +
> +test_inactive_snooping_off()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config ""  "2" "3" ""
> +	test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +
> +	test_active_setup_config "1" ""  ""  ""
> +	test_active_setup_reset_own_querier
> +	test_active_final
> +
> +	log_test "Mcast inactive, snooping disabled test"
> +}
> +
> +test_inactive_querier_off()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  ""
> +	test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +
> +	test_active_setup_config ""  ""  "3" ""
> +	test_active_setup_wait
> +	test_active_final
> +
> +	log_test "Mcast inactive, no querier test"
> +}
> +
> +test_inactive_other_querier_norespdelay()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" "3" ""
> +	#test_active_setup_wait

Why the comment? There are more instances below

> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +
> +	test_active_setup_wait
> +	test_active_final
> +
> +	log_test "Mcast inactive, other querier, no response delay test"
> +}
> +
> +test_inactive_own_querier_norespdelay()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  "4"
> +	#test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +
> +	test_active_setup_wait
> +	test_active_final
> +
> +	log_test "Mcast inactive, own querier, no response delay test"
> +}
> +
> +test_vlan_inactive()
> +{
> +	RET=0
> +
> +	test_inactive_nolog
> +	mcast_vlan_assert_inactive_v4
> +	mcast_vlan_assert_inactive_v6
> +
> +	ip link set dev br0 type bridge vlan_filtering 1
> +	ip link set dev br0 type bridge mcast_vlan_snooping 1
> +	mcast_vlan_assert_inactive_v4
> +	mcast_vlan_assert_inactive_v6
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +
> +	ip link set dev br0 type bridge mcast_vlan_snooping 0
> +	ip link set dev br0 type bridge vlan_filtering 0
> +	test_active_own_querier_nolog
> +	ip link set dev br0 type bridge vlan_filtering 1
> +	mcast_assert_active_v4
> +	mcast_assert_active_v6
> +
> +	ip link set dev br0 type bridge mcast_vlan_snooping 1
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +
> +	test_inactive_nolog
> +	log_test "Mcast VLAN inactive test"
> +}
> +
> +test_vlan_active_final()
> +{
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +	mcast_vlan_assert_active_v4
> +	mcast_vlan_assert_active_v6
> +
> +	test_vlan_teardown
> +	test_inactive_nolog
> +}
> +
> +test_vlan_active_other_querier()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  ""
> +	test_vlan_active_setup_config "1" "2" "3" "4"
> +	test_vlan_active_setup_add_vlan
> +	test_vlan_active_setup_config_vlan "1" "2" ""  "4"
> +	test_active_setup_wait
> +	test_vlan_active_final
> +
> +	log_test "Mcast VLAN active, other querier test"
> +}
> +
> +test_vlan_active_own_querier()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  ""
> +	test_vlan_active_setup_config "1" "2" "3" "4"
> +	test_vlan_active_setup_add_vlan
> +	test_vlan_active_setup_config_vlan "1" "2" "3" ""
> +	test_active_setup_wait
> +	test_vlan_active_final
> +
> +	log_test "Mcast VLAN active, own querier test"
> +}
> +
> +test_vlan_inactive_brdown()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" ""  "4" ""  "6"
> +	test_active_setup_config "1" "2" ""  ""
> +	test_vlan_active_setup_config "1" "2" "3" "4"
> +	test_vlan_active_setup_add_vlan
> +	test_vlan_active_setup_config_vlan "1" "2" "3" ""
> +	test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +	mcast_vlan_assert_inactive_v4
> +	mcast_vlan_assert_inactive_v6
> +
> +	test_active_setup_bridge ""  ""  "3" ""  ""  ""
> +	mcast_vlan_assert_active_v4
> +	mcast_assert_inactive_v6
> +
> +	test_active_setup_bridge ""  ""  ""  ""  "5" ""
> +	test_vlan_active_setup_reset_own_querier
> +	test_vlan_active_final
> +
> +	log_test "Mcast VLAN inactive, bridge down test"
> +}
> +
> +test_vlan_inactive_nov6()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge ""  "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  ""
> +	test_vlan_active_setup_config "1" "2" "3" "4"
> +	test_vlan_active_setup_add_vlan
> +	test_vlan_active_setup_config_vlan "1" "2" "3" ""
> +	test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +	mcast_vlan_assert_active_v4
> +	mcast_vlan_assert_inactive_v6
> +
> +	test_active_setup_bridge "1" ""  ""  ""  "5" ""
> +	test_vlan_active_setup_reset_own_querier
> +	test_vlan_active_final
> +
> +	log_test "Mcast VLAN inactive, own querier, no IPv6 address test"
> +}
> +
> +test_vlan_inactive_snooping_off()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config ""  "2" ""  ""
> +	test_vlan_active_setup_config "1" "2" "3" "4"
> +	test_vlan_active_setup_add_vlan
> +	test_vlan_active_setup_config_vlan "1" "2" "3" ""
> +	test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +	mcast_vlan_assert_inactive_v4
> +	mcast_vlan_assert_inactive_v6
> +
> +	test_active_setup_config "1" ""  ""  ""
> +	test_vlan_active_setup_reset_own_querier
> +	test_vlan_active_final
> +
> +	log_test "Mcast VLAN inactive, snooping disabled test"
> +}
> +
> +test_vlan_inactive_vlans_snooping_off()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  ""
> +	test_vlan_active_setup_config "1" "2" ""  "4"
> +	test_vlan_active_setup_add_vlan
> +	test_vlan_active_setup_config_vlan "1" "2" "3" ""
> +	test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +	mcast_vlan_assert_inactive_v4
> +	mcast_vlan_assert_inactive_v6
> +
> +	test_vlan_active_setup_config ""  ""  "3" ""
> +	test_vlan_active_setup_reset_own_querier
> +	test_vlan_active_final
> +
> +	log_test "Mcast VLAN inactive, snooping for VLANs disabled test"
> +}
> +
> +test_vlan_inactive_vlan_snooping_off()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  ""
> +	test_vlan_active_setup_config "1" "2" "3" "4"
> +	test_vlan_active_setup_add_vlan
> +	test_vlan_active_setup_config_vlan ""  "2" "3" ""
> +	test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +	mcast_vlan_assert_inactive_v4
> +	mcast_vlan_assert_inactive_v6
> +
> +	test_vlan_active_setup_config_vlan "1" ""  ""  ""
> +	test_vlan_active_setup_reset_own_querier
> +	test_vlan_active_final
> +
> +	log_test "Mcast VLAN inactive, snooping for this VLAN disabled test"
> +}
> +
> +test_vlan_inactive_other_querier_norespdelay()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  ""
> +	test_vlan_active_setup_config "1" "2" "3" "4"
> +	test_vlan_active_setup_add_vlan
> +	test_vlan_active_setup_config_vlan "1" "2" ""  "4"
> +	#test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +	mcast_vlan_assert_inactive_v4
> +	mcast_vlan_assert_inactive_v6
> +
> +	test_active_setup_wait
> +	test_vlan_active_final
> +
> +	log_test "Mcast VLAN inactive, other querier, no response delay test"
> +}
> +
> +test_vlan_inactive_own_querier_norespdelay()
> +{
> +	RET=0
> +
> +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> +	test_active_setup_config "1" "2" ""  ""
> +	test_vlan_active_setup_config "1" "2" "3" "4"
> +	test_vlan_active_setup_add_vlan
> +	test_vlan_active_setup_config_vlan "1" "2" "3" ""
> +	#test_active_setup_wait
> +
> +	mcast_assert_inactive_v4
> +	mcast_assert_inactive_v6
> +	mcast_vlan_assert_inactive_v4
> +	mcast_vlan_assert_inactive_v6
> +
> +	test_active_setup_wait
> +	test_vlan_active_final
> +
> +	log_test "Mcast VLAN inactive, own querier, no response delay test"
> +}
> +

The test should check if the new attributes are supported by iproute2
and skip if they are not present. See bridge_activity_notify.sh, for
example.

> +trap cleanup EXIT
> +
> +setup_prepare
> +setup_wait
> +
> +tests_run
> +
> +exit $EXIT_STATUS
> -- 
> 2.51.0
> 

