Return-Path: <netdev+bounces-219644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617EEB4278A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C181880851
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A472D3EC7;
	Wed,  3 Sep 2025 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YtlYlOP7"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8B2BF00D;
	Wed,  3 Sep 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919084; cv=fail; b=cSzIdPDTjvvwY6WYpGy+NVBJK2BIcZ/dAiE8khuE5YVeH9YGc4n+s9SvQGhqeJs96LljJGRm7PNTlBHNCI21ii7c8/DiizJqslyNN0P7eWNhIIYKgdKryrlMvn1fFo6V1l0Yw0TZc/D4M96zHCF6UGeQV/vepoQZ9zpCchsgNkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919084; c=relaxed/simple;
	bh=MH/0OLA0ABfLF26rCYKwAEDrb0NplTQAZ5Y5AKfBboM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hSmPdFMdsjQHdEin7nDD//FV4dWVejvj8RI/oJRpf9wXWwuraY/H6Y+SPrXeiOsqmqAJ+ZXY/RltCnz+nfNrx0OAgGRTpc1IIh3fpxqkLpBGCK9eQFwBO2zhR/kywyugmHPIYn9ZmAqLdz/zGJwHHLekGTbwiEGvAlAIO3F1c94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YtlYlOP7; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF4zucjF5F5OgDJ5w9G9YKq0Aj23UaQtBOftZQE5t8pRAuKmx7vHMndeJMtPYSqAB6RQhhEOpPK6jvWQhrr1SK7gFElTIA90yuEhO+yo1C5rfC/z0XQBH9UyAwj3E3gFEcHtefCNJAYk9iof9RY/55ovRJeBLG36c2zF91B+P8xy4WqjR2IsgWtgoEdurdhRDiQCS/pS1v4HVBStrlvm0CfFU5GGZmX4uFIZhTFoVp8lUIQDIrjRYXLDNI9uKGiY5YFuK+ChfWIPEXwJ6p8bZKdiBlbN8SbQ0u+xFi/LcZj2Pd4av+DxVAijCGn2tIiasT06OfQi5C4IYyA+f/Y4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDdAMMQZJQQWY+YvrfzNN0YPrEU844hgUKP8StSYaL0=;
 b=v0U3ROTEDQKbivGBDLlv5t7RqwDL+YB/CO2GMHQK2C39IQ2YIy1QzcJRI1vVGtbq8J4wdTIlswa5npm+aUyp7YDHr06xjLuHUlw5rxI8r7Al6jNj3b4JO9w53wh6fS0KeHKTxqQz86kLJV++mvb0X0aIpt8o5zpmPYWagA592ATZ9kmp2JTX/6nqn+zqkIMsS1Y0Akw98iVjOJcfwMkfNGcmteu4c1DYSagb/lQ902TUI397LcK680/02nkkjiGTFqO832Cu/ay30whbpO00l5ZiSnEAjRmHp9ZjpJCFBTtsmKb2iyosMfmS2jSvcH0DNKODjZV96ePU42I2r1Kmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDdAMMQZJQQWY+YvrfzNN0YPrEU844hgUKP8StSYaL0=;
 b=YtlYlOP7z82zCXpstWeoMf49OraDl6S4HTtnHRpLNvE/1MbJv5dFSi15vEhfB0XRnbkbXEaUPFgVKSeGol1QNpwSgd0lkW0F+X5iTMrtp+eEOzRyqpBr8J0QqNBbSVCTBHQHAtV6JxSodFb+ex01Ek/A7RrEpibyoqXGeplcY3sOsO8KnUOQFXew8Enr7FrF2SUUQ2CGWmmV08MByMtSCR54ZUTu5mlvqyUS8huh7IJBetMVv9OrA0+U4HxSJPbZl0ABlM/MoLSDi5zTlsA8NkEJNPiOC/meEGKTshxkW2LiECBRvUx8kRHXz7lxNSpbSXXZaJnh1DuHUT4A3RidRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10724.eurprd04.prod.outlook.com (2603:10a6:102:48b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 17:04:40 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 17:04:40 +0000
Date: Wed, 3 Sep 2025 20:04:37 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: phylink: add lock for serializing
 concurrent pl->phydev writes with resolver
Message-ID: <20250903170437.5oqjvszb7y6v4alm@skbuf>
References: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
 <aLheK_1pYbirLe8R@shell.armlinux.org.uk>
 <20250903153120.4oiwyz6bxfj3fuuv@skbuf>
 <aLhkKVsbrkXmFbgK@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhkKVsbrkXmFbgK@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR09CA0155.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::39) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10724:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8b1569-9ded-4d16-0b90-08ddeb0bf84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWedjLL5yRJpoymxcWiuCGm9j+71I6IcQ9ZvbGSGkfxOd+yloP9qW1K42gUX?=
 =?us-ascii?Q?84EitCesz4n4sYI2wyyDtWX5bwW2vUaxA6D0tTuouKszvHnumDd3h38tJUqw?=
 =?us-ascii?Q?Ge+l5JN7cNpvkLneCh0/HG1UuGo+Nhhcyqfe4aa4FH61sfC1HrmZwkbrApGj?=
 =?us-ascii?Q?YcmkxtjyGMFj2TnCghdSqUR6pfXaipOYZRNGFrilZXfVL4jM+5nMMdY6oZgY?=
 =?us-ascii?Q?W5OJq8QVby9vtAsExlGoXVnUQoHmH/LqYh/B33hp3124UvGK50OU6IYKk+CJ?=
 =?us-ascii?Q?U76DjCLb3O5Dj1wo/UxoxsoVz56Ynx/oMSo51SoixXOijaW2cAgLORcULojF?=
 =?us-ascii?Q?mXIjj0QqrMKxENCws3nh5ggXZm7KUB1buMylFDWr5B34Zi1t88G0aFu0gUVy?=
 =?us-ascii?Q?vMDEuWPNu/san00g3CM0s7R3dGmw2tT4AzBy3hdBND1E+ekgGyBDgzV59tjx?=
 =?us-ascii?Q?qwWvKFXlcIrm51o6ktJjlLRav446ASg0Y0w8xVujZAgSGY3lnDN6VPyb1zER?=
 =?us-ascii?Q?Rk2wTOFsJ9UaM6MTHC6Bj+CBLwovG8Qv67OV9ixl/Atr24M989KaBifEhTlW?=
 =?us-ascii?Q?9ejlsxJBMW/l18NSX0pinQtc/xYgXhzFnNlxKZrfDPY+EArwfcGpRjjyjuSp?=
 =?us-ascii?Q?B7H/CFBsygTvoBPP0ZtuWN9UPyEBXNtM7kuVf2CkzsU3D3C5/PF7LdGKssCM?=
 =?us-ascii?Q?KHtXOGyXVlVs0dW9gFPfgOaMeh+77SXcziOpOdYwiqDwx6xTOV7qrQIDjUZQ?=
 =?us-ascii?Q?yZTksvDvab9ldPCFheIeYpEvYbm1VK+vD/uP7KXnLZoPIA+I2Fdvki+O1zIO?=
 =?us-ascii?Q?n3QQTRqbIXEuqGlxItRHJs0r4JqVKbrTHhLqwdogoxz5zzJpW9x2imBKDoL1?=
 =?us-ascii?Q?MrfRRclzdxr0EPB5u08/ClXRy+KSESAQyJ4BZ+QQ+TN8BUghagQVPj0KSM7W?=
 =?us-ascii?Q?9AhkTXv9uogQHmz5MjtLgufSpey29RafzIsQ8biP4BgXXUj/5AnFNPbGtWVt?=
 =?us-ascii?Q?geFC4RHCySxMWXlc5ol6bSIBv0NS3eWh/pGFbAXIrJlj7ovKMquL6RDjNEdz?=
 =?us-ascii?Q?7nlP72iA58f6sGWdidRU1yKX1yVDQWgDCi03mtFGqJ7Z0OBOSoRpOWz6nzpH?=
 =?us-ascii?Q?B57LBuwjIvsN1+eiAFgIwJmQbittvTAn7SiEyjJpy7xLr67X55LFNui9ggJw?=
 =?us-ascii?Q?TgDuEWrBfzWu3fjcitzU1/CfQe4zHlWwKe4JA13PpLSRTwtEng24HZRZGZxa?=
 =?us-ascii?Q?H5KdMf16gzp7n7X4bfKFbpeMD5SO0KWNd3A3ilSzfshz2gyPkWHZI45HnVtZ?=
 =?us-ascii?Q?btC1EA2S6nSMpybfLltCPo/T3yNsfRj4zqquNXV2WPZVUSNqtE7IYmZ7yk7a?=
 =?us-ascii?Q?lThuzsG9D9FD4ckdI/yrBtR/fZbAmQXSHYFIsYC5C8VtX7WMtmkUueKmyxWT?=
 =?us-ascii?Q?GlMHeP41Hfs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFabTlU3oA1FlmDyjG5Lmb6rwSDWkaKYp/5Bf/kakGOtszi8JVzddlgSLI+3?=
 =?us-ascii?Q?RM/7FDWM+BkK8ZnH8OV1k149Q8TVjmSVmiHX3vIt34TqvF2D1B7V5NwELKRh?=
 =?us-ascii?Q?Z0WzMGWxpjAa2ord5g/kXmiFnn8h7wu1tcWlXRoQlaWePDbbAE6eI1fGXwR1?=
 =?us-ascii?Q?HS7Pi9HlQJMKaTugzQUXfHqBW2tZAV1X4tBqXw3VMOTtZmGn8q/IDX0sAgbJ?=
 =?us-ascii?Q?WV3BM5yYBgnK/jLTjyHw7JK9pH9WKRNQFIwDP4U6wQlgOrsTBYOqDov30EcR?=
 =?us-ascii?Q?YUpNGdcBHyxOhRh5w+B7P3ywizaC1n1i4LEGExeehAeVpAG8VYnRsqvU2gaP?=
 =?us-ascii?Q?Zeo/3SiiHQ+pYnCNTNDneODlcWM8ni5GIQlvWIZzlbRH839yiTJNqvxeQsY+?=
 =?us-ascii?Q?U8LRRSNk7OgQ60TKyrFCqkEKHVWHh1g5HoDdZ4o7tapZZlzcWzOCKuxI9j58?=
 =?us-ascii?Q?vhcD1DHcA9V6rsoP8v2G0xN/zVuYCLwv3CjfXpNbI7WrQNHVJJKfMdULCJ3M?=
 =?us-ascii?Q?hHCZQf/9gCMfaBDLYn+FX+FpQje+60pcud8Jn3awwaUTJSU37IaYUUO0Niyd?=
 =?us-ascii?Q?6nkCwYfbwXYyrpvyXzkfmeqgZEe8oeyo6A5rU+UDwuq+E1WrkncreCRftgGa?=
 =?us-ascii?Q?O0SazuCDDJZrQPv+HA7ri0ivp2mic3Q5c8DWK+T5GgKcBzR4npxNq4Wr/mQQ?=
 =?us-ascii?Q?A//BjoFUu6fC9Xd9U/nJL0mVinG6hrv8xViJ+Lyuil7NUgNT2Bvkg5dN5nu8?=
 =?us-ascii?Q?VagEhh/Ctvx5oErrXHh7ZhG0zvGzVfBe2Irhq0FI8Pg2cEUQR4TJTp/3u93L?=
 =?us-ascii?Q?0yYHGNX3KTan1ai6/sg7zfEBfXWrGM+B1heEBlQSwmPPlgBM3P7nV7H836Qt?=
 =?us-ascii?Q?J597Oe755b09ShJIVDvfoBIsUf/aXaVwLXN68PgivcW25g99bqw8b5aOYhzD?=
 =?us-ascii?Q?K++gBrmneUlqEG9WN+f1os64W1lkp0bkZ2A7iZuAgv0lujeuiV2hegNbMAzw?=
 =?us-ascii?Q?824hlfOHuPMmlTLiUUDXcxAqgDcjzSOKcE2HOhk77evbjX1GXRD8XmnWmr+U?=
 =?us-ascii?Q?BxjtwT88yeGA8ohNTHxpVWHioXzeszQ+F4/xNjir3AejM89ImZ+QNOePTthX?=
 =?us-ascii?Q?aHPzg2PGqn+qTogAWrWFyrdaJJA1m7Idu/zU6hd75puL/aWIAk/X+2cyfURH?=
 =?us-ascii?Q?R+ndEap+gkwIS+yqsnwPBXzENs5T02YvVRq6ekCwPrdbEgmXbFEDioH52Vha?=
 =?us-ascii?Q?iLgRRHL0TEOqD3RwFMkQPH4S0Ha/TsazijsJyIvaAa2HB3PO7rSQLGkuuA7+?=
 =?us-ascii?Q?5k6xdfIjymCi/W2qLUH4b6IunrSo8qmRwWjK3Jyl40icMQVfYw0fAZwu0bsQ?=
 =?us-ascii?Q?Z5bSET1hEqKm5hOTtBjBS9m+etj+UtIL7Z82uyZfb3IY3zRjbe4uejQeRHHv?=
 =?us-ascii?Q?2SEYvfw/AbLpeMkGp6WpfvT0VpBgPNZ7uTPK/VZjakDJs9RHIWeKNzcezDza?=
 =?us-ascii?Q?axwX2cV0kSvbHr0Cl1OkNSJ8Vxdh+9Bx5kJcVxDO3mc1OK+XnH8f95yQ7Vvq?=
 =?us-ascii?Q?73BZjNbetHD+MqF/nv1M5YQq2JuCGdIwWeyI43iTJ1ZyjRy2x4ICyyG3XPlO?=
 =?us-ascii?Q?WmvGgQTJZaN3V7o5UVc+CEIO8RlMwQW3hmF7bT0NPEE0GKy3NwiaEawJcd2u?=
 =?us-ascii?Q?CL0aJA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8b1569-9ded-4d16-0b90-08ddeb0bf84e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:04:40.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH1LRe2gi5Zu6iW1+4+YMcYpDhfdocaqjqj8XpCdaK/qkD2OJJXgiFCZ4iy+HLsUkN6mvR1YNx8tOtXCe57pAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10724

On Wed, Sep 03, 2025 at 04:52:09PM +0100, Russell King (Oracle) wrote:
> The reason I'm making the suggestion is for consistency. If the lock
> is there to ensure that reading pl->phydev is done safely, having one
> site where we read it and then take the lock makes it look confusing.
> I've also been thinking that it should be called pl->phydev_mutex
> (note that phylink uses _mutex for mutexes.)
> 
> To avoid it looking weird, what about this:
> 
> 	mutex_lock(&pl->phy_lock);
> 	phy = pl->phydev;
> 	if (phy) {
> 		mutex_lock(&phy->lock);
> 		mutex_lock(&pl->state_mutex);
> 		pl->phydev = NULL;
> 		pl->phy_enable_tx_lpi = false;
> 		pl->mac_tx_clk_stop = false;
> 		mutex_unlock(&pl->state_mutex);
> 		mutex_unlock(&phy->lock);
> 	}
> 	mutex_unlock(&pl->phy_lock);
> 
> 	if (phy) 
>  		flush_work(&pl->resolve);
>  
>  		phy_disconnect(phy);
>  	}

I can make these changes and repost tomorrow, after some extra testing.
Thanks for the feedback.

