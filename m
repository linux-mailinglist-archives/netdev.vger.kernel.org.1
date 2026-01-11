Return-Path: <netdev+bounces-248817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D80D0F14E
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 15:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D4A63007E70
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0334678B;
	Sun, 11 Jan 2026 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KulQEtCB"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B833290B;
	Sun, 11 Jan 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140958; cv=fail; b=JrqF5aH5nKL51j+RTpmWeJ1wQtaQZDCWKo9KTahSl/U6HmwGPcqhfq5F7136zZgiqiNQ6lyxRajGchc1Z9bnaYqyGMVRpsuA/E3CyJlHuYVG0XmqlOGIGS2C1v5qLhYbkLU1OKsBIh7NgjKjLup1SUZlEyViGyPZugGtrKQLnWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140958; c=relaxed/simple;
	bh=qmG6le+QXijVKAbIlrC3tTD3+OwGKg7uEIl12iGm+uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VfMw811boFZjWSPCYNu6emuH/vXMfbKhdBXg45JEjV3lLrjLDHHWslrXvKIDpXYBws3tWQ/A3M40CyfpZRP5+xoEnJH/Cli5qYGnmzPponwdTZu29dyUdSdeZNXP/SzXAForqk6I2Yjb4Ufmp3bThhOzEPCU4raOaaQ253qgmac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KulQEtCB reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va2c3EQJViiCNXwxvIW2uliZU8g4JHTKZ7ubmmKyQ2e7xIG4GvAxwE/7oZK6hLqhwAd5UflHqdKYehKrwPAczThoeQU+KannqBbqD8kGrioic0zl9XeZA96whvcw6+iVO9SGkJE6GBo/GFljvPY1i3z726rJp56hwjAD8+rn3BSRhRSjq+3I1txrYSHy+pymYQrHbN2WEQCSZKBLkv5ezCqZgIDAdtUtVP+VtsdySHO/8+i6EZm4HBakiaN9ovr7xvNlpUPzUCP6LWuhK+nMqgtzr/Z0j6rPdaQTSSsdCkPfOTHegi1Y5PFWfQJjYKkzxBxORYcKa1NzknCHqnMGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj4KZN7sZGA7OSS5PrrF9ue94X0UiflmgwzuLwgI/eM=;
 b=ecuN1O/BSoKrQP0a/MfrslzYBHiYQUtrG8pj0M6OHF4lKMa7KN6jxD+CRRlysniHQ9zSbvXc+83P8dQjxQzWt4lveY8g/aqsAbqLocWvP3M+1NeqJYeM1+Y8SAnswISVjW67bS76reRX2rnXjYUHnmYMEg0zWDZlpzPpcrLvppV6+t8eVogNlk6R8McemOrJx/jrKx8atFPixl3u3gXIBCsDrVk1MLIBsfET65DIAinbk5a3vixiTfejcNifz/uN50KF5v2JT6S9MbCrgDRgqnTLiE1nBNXAv1h17tu+LVFk51ARfsSkIwYzMapwaKGWYvYHCHpg/4czLTrO+9+RYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj4KZN7sZGA7OSS5PrrF9ue94X0UiflmgwzuLwgI/eM=;
 b=KulQEtCB0jJDJRtfpSrP8m9lmQJOQxMigMEajzmIhaNmt0bsHTCudbNYgaFmJB4TCVJrr49DfXts5NAcP0in1DAJRG5O3ZNOvoWf8onSPuQ30C1kALk9P4ZTLiaP8/l1tG9juz6U8Bh7hzVwcRthxu9OVONkc/8awR00PwAWFprUMkhkzaFP2hRQYI2HW041AQRPQ3lnUmxFsWEq/8S8ylmM7+nCYc3C0sTU06V0p+oVhhs9WpZdoIkUZuFYE1HQWn2xc10CN/x2muSjigRQqmRh4yUWDgJCv6EEVaJmrcDyO1AUOgLtnJvorL401GVQJU+vGX2dOWObUIGcxUWToQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB8930.eurprd04.prod.outlook.com (2603:10a6:20b:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Sun, 11 Jan
 2026 14:15:53 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 14:15:53 +0000
Date: Sun, 11 Jan 2026 16:15:49 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20260111141549.xtl5bpjtru6rv6ys@skbuf>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
 <20260111093940.975359-6-vladimir.oltean@nxp.com>
 <87o6n04b84.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6n04b84.fsf@miraculix.mork.no>
X-ClientProxiedBy: VI1P195CA0040.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::29) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3144bd-5a68-4315-8c8c-08de511bee1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|19092799006|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?M6293xQp3p0IYSmWxrl6pSoBAfEkAYUtHL3VYZ8z5T2W7xkhx6rarqWxdm?=
 =?iso-8859-1?Q?Pigo9NR4o3zwk9WTSXgshcbx4XzZ2K+3cS2VA1GX5sniFUH+BLN5qBP4Ll?=
 =?iso-8859-1?Q?MntidyqQCdcL9vjb0KvRlv66q9SeZpJZLPCiEhO/RB9o2/qM4gVvupx6ui?=
 =?iso-8859-1?Q?g+aBTmJ+Eu6waN8p+dxvgvjAkxXcqdv2reQI0nNwlpV0tAa8YMXxFzKuVl?=
 =?iso-8859-1?Q?5154fUZpyBEwzk4mpfvsj0wSulYvjs4/yttBXWvwqgom/AacygS2CaP5Ga?=
 =?iso-8859-1?Q?TrPKt+VgIG8xDneqTVfgAvq1M0IUdL5lE7deugy81WxhvAFVDdSG5M+sXX?=
 =?iso-8859-1?Q?IG4AudnHDLt15j0Lf7Mf8uHTfusR1ouBFwLXnOOqlFDiBcxKz2EbhyN1r1?=
 =?iso-8859-1?Q?bLjn6zVckoDDBmOHiKJdHAhE9ZD7f6H90q96NW8nTv960zBkfAKQa+y4BH?=
 =?iso-8859-1?Q?vU4jpGtWmjkLE1ZwBa4XFEk5bw74c5hIO2q/cusrNuSG/nDPzi2vdcPaqL?=
 =?iso-8859-1?Q?4JtfmWfCZmbKHT2X7HicWLGmafui6W+/sc4gRQGEWdVdfbz6tGR0Mtt80Q?=
 =?iso-8859-1?Q?AYoUG352cWnpdFssLuR6fF4vW77q46r2pMD1h6t+re686BYZAt753sSNiC?=
 =?iso-8859-1?Q?31bjm48dnUq/E+VXJdFY82CNdV1CCYHMcPs4PmZ1WFgElvyXPbfR6UMknF?=
 =?iso-8859-1?Q?q+7i34/ZxGbFIeWEU5t16q8UFCAb4mQpK6AKj437ffvKA+JLsqpcnTCkcR?=
 =?iso-8859-1?Q?2uSEtCoJ/PFipFdFEDRg8RAHz4pKIS8nKQH7JZJ9ZwezoCKx+uXR0uwqAD?=
 =?iso-8859-1?Q?Ab8Q05uSM5VuWGX6LPUEb6iTrqQEdqo9YPTly7ZRS1IJPKQOOay44F/DAz?=
 =?iso-8859-1?Q?OhfgBxNJnLPU22uk1e6bjuAb2lJ2az8q/V1ul6uMmPBH0ta3jQFsTMMoh3?=
 =?iso-8859-1?Q?f2xcDPCwY3uVI0XmVBrfcduoNgmhLnhLLzGKizHEy9QpfV5GtEBiKshRrc?=
 =?iso-8859-1?Q?4Buqy0B5fKgk+l9oFvi+HTFbYjJb4+WPRDD7lg5BT8WrkK8D2xr8Jnjhzc?=
 =?iso-8859-1?Q?u34IfAxGRTmSzWyDt8LweFLc+Kch5iF/rGrXgsBu2eULmdAhv5iHY/Zma0?=
 =?iso-8859-1?Q?yH//TAHRC2NWJxF/j4kmvUjpJ+Mv72khFEiMKjXDLZqlSojinv4+MGqaCZ?=
 =?iso-8859-1?Q?iEEtSRt3poyhFUiBmP92At5LZEoykgCeLemOTwJMEGQKT20YC6GoU9PVKb?=
 =?iso-8859-1?Q?00qf2cFL+qalxQUQ35RH/crv7jSvFQ1EUKaXxoMnBK3VUALPz0no3hf3jY?=
 =?iso-8859-1?Q?DLjaSyxqs8U/NOFiaHG4zYh9TJUiCTo6vKYxA4F6lVYvmd5uLmHkI7oR3c?=
 =?iso-8859-1?Q?kcty8K6mqXiLt3jRqjIK6fIZS9jQGia8XE5NPesK3AZVwrSXlMwkzf63Cu?=
 =?iso-8859-1?Q?MRN6IcxRCLfG5zjvsNf8AFZqodND00UZVA3BDRzaR+OUOuhcmClOTWkKsD?=
 =?iso-8859-1?Q?ZMTPT+G/KQIT38jd2KI7pu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(19092799006)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Q/RJHktXI1Y15fosIp+d3fRY3zxEifYii4dSgTH/ZSrP6QcDm8jL95sD4d?=
 =?iso-8859-1?Q?hV3Q2SxYvsMBFArc5rNcR7HdjYVjOy/LQBVRKDaWmnLOSL84r3jzb+Q1ns?=
 =?iso-8859-1?Q?d7hojzjKE+A9Sj0traH/BO11p/qzaFeSQNvA/oJTbHiyAqw8MMb/SaEg68?=
 =?iso-8859-1?Q?hOyrhlL03UpR4pj/HmnCK0aSZkPKoJUvosNaUXd9Z3fQ10ONnnxPqN24WJ?=
 =?iso-8859-1?Q?0elP83/2aleRefFAdSQ8lHW0hLIQOVDwfKQZX7O/IyALWUx4+O3f+yOEUN?=
 =?iso-8859-1?Q?QJFyDqXPZpY9s5MhyFf8J0hgYqybNOOcqeH6pbq/SIFgKdc4muSPCpfulW?=
 =?iso-8859-1?Q?7wfvvCkC3sZpLq73KdTQpxOJBliVSTy/sVKWMQrVCY6sfhntxHhpL+7Njc?=
 =?iso-8859-1?Q?JF2yVGwn8l/kftZkZW7dv0jGIGbbepK89/Wc2NunE490AE0sISr1w+CBJA?=
 =?iso-8859-1?Q?IugzivGdtfsOZBT2xxxSpj9n4xJqXK4/ZbQCf3FrWIm2cqlN+EqYtuJsMe?=
 =?iso-8859-1?Q?M9OnqcXrV/RH4Q5g38d54WEGTCYy2NcPIkjmij/l8qZGZ5CF+dJo8Mcasb?=
 =?iso-8859-1?Q?+Q3lpN1MsLQWoKJ7brruxtSM22VuP1l6ftHxDj7/95QeeVgE5kOx51Fpb/?=
 =?iso-8859-1?Q?z5hcDzoMUl6JvUlVXKG+Oap4I92brwFfOpejO087CISTszcCrWXJdLlCg5?=
 =?iso-8859-1?Q?9/KCZF7WLOHOGfBBIyw8YW3T++3mcStaoFjTH3vGfkABXh370fGvEJ449j?=
 =?iso-8859-1?Q?+NdG8NIAuo3OuQKMgRLWrPpXJtS36S5dsBaPYp33asjeW+8B1n1tJuMlSu?=
 =?iso-8859-1?Q?5+I3kE+sRRPqK/mB1frz/R9Ma2mw3uTfFVZ6PsagIxBR4T0tvf+jYoH/w0?=
 =?iso-8859-1?Q?GFbW3MZLEj8CA06hoSX27rdVqaHdfXde+RNgAzw9Mk/qDDSx+TrOmL/vef?=
 =?iso-8859-1?Q?dl2bl2EEPcfxHh0DGI4aSBngzBHoYPMfitdqTb1h8thNBrELCCtAQvUldi?=
 =?iso-8859-1?Q?vM74U/XotEnPvwVcxGuJvxL5l7zxfs1anMlN1myCDELI+DY96n2RcujKCo?=
 =?iso-8859-1?Q?ovydoAx+chvEb2DW9xUeXkpGch50KLkmMtI0txp4eGbrIwJhZSwDfNj+1w?=
 =?iso-8859-1?Q?nKPUHW9BLtKs1JdjDfXV+f8m7Zh37ykQEKh3QHSdLwYTc1N7l14UgjxJCU?=
 =?iso-8859-1?Q?mtDvHERmPwEQ8xqhwKmosII6CvDmwCga67Z1hoS72FFvVaHPed3IEZXn/g?=
 =?iso-8859-1?Q?6FPrnrnTjklOoJcrkOHGnQLavcdSkned7N6rHFC+FVAXu5Mxlv5xLNLbQS?=
 =?iso-8859-1?Q?4J5th6ywJGLAvU6+pYjMnQ5cFRJe9Rl0hIGM04kBpji+9jYVNQgiidOJPD?=
 =?iso-8859-1?Q?QUrCCGZItSzp1lUU61J+VRDttL67Qfsi4fAz4uxk0+8TXcvUszqxylCSfQ?=
 =?iso-8859-1?Q?qIZ1hJepLbB6zA3vvOcDWzeXEhfQS0xVhkW4s7Si/rHkp2lWFjmUA/kpSs?=
 =?iso-8859-1?Q?EgQiLhgXbKXdapBOdzt5kKDvQlZOTK9qulIYU6e4EPc+FmDO1frosh2WKW?=
 =?iso-8859-1?Q?Wt3jFJIvHjUFkvZW2oVGkIGWmG7FmKrKTWUwUJwXDoxO4xqoDWIAdsYTi0?=
 =?iso-8859-1?Q?HwHlQ9GNtBT7XmBbnftmL7/OOiR3FYdSQKzUc/W0Uo7LnCQ4S8ARP+92io?=
 =?iso-8859-1?Q?/3we2UsizL9oNrLGarX7jWkXQgFI580D6yogd8Tk9IaRpZ/pzHPGknv149?=
 =?iso-8859-1?Q?AevSS+4S2H2BP4zKRAlwhyDSB1+ju1Jo/uU+WsKIJo0WYFC3cB3PxTyXWF?=
 =?iso-8859-1?Q?334ISg7CFA6c4fdC3RNRYtvnH/V3rEP176Zjm2c3tYjVp680xi2PDOZjU8?=
 =?iso-8859-1?Q?2r?=
X-MS-Exchange-AntiSpam-MessageData-1: G/G37eZxEnx+WQGLjDxYdkPdWXypZrAk28o=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3144bd-5a68-4315-8c8c-08de511bee1a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 14:15:53.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61D2FRgvQxM7zEm40JyiXs0obaboKyyLbalETwclrGFUYVkHSuUYWROFTPsJNnDLy7DRx5T6L4+vF6uScxKAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8930

On Sun, Jan 11, 2026 at 12:53:15PM +0100, Bjørn Mork wrote:
> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
> 
> > Add helpers in the generic PHY folder which can be used using 'select
> > GENERIC_PHY_COMMON_PROPS' from Kconfig
> 
> The code looks good to me now.
> 
> But renaming stuff is hard. Leftover old config symbol in the commit
> description here. Could be fixed up on merge, maybe?
> 
> 
> Bjørn

This is unfortunate. I'll let Vinot comment on the preferred approach,
although I also wouldn't prefer resending to fix a minor commit message
mistake. Thanks for spotting and for the review in general.

