Return-Path: <netdev+bounces-239270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D84DEC6691B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A776E357650
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0731B114;
	Mon, 17 Nov 2025 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GYx8EtmT"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E84322520
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422912; cv=fail; b=iw6d4X3iROjOsJe4AEyLRJ4YYaRUtIQH0HLFLsgc4nYwv1LijOTZLJkV918y4XqNYkrxEPKtevogJJM2mTLPn10tu79qDSmd9WaQJ3zrcPaUSzp991oALZfiuBZKWg/LA7PL9aZE/iAUhom0Pu0fcI9f2vRdejj3XRw8YjhJ3ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422912; c=relaxed/simple;
	bh=l9p/9yHpWq2mwKSPpxq6ddOxYk2+RWiST/jJxS/Le6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jYEAy2q9oJrLUdP8MzcYleczU4gnUdlx6WGMZ1cQ6U+Kwbfqn4lUn9zYY26Nc3uiE6YBdAE2a3bf+MW6nXtqXyw8j6E1I06f8RxDHGXXpcBAVD6F3V8LAWTITzZ7UCoyEPdmlk/7CiTpdQTZflxcC7UrMw+FfKvMuR00/2LUTZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GYx8EtmT; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v64OHX0zqC0u7Z//1Rm5GjvhFo5EX/WyOXg9Tb336L9gW/qOu7zE/d6Enk0f34Mg1Fe0+nzcqRThWiioxZc5F2A9aAm6ses8ull/jH8ktgnWK4AlAwVO1gz1Q08+HQKqVNHkr9g8gRhXMQSrOsVWe8SYkcz2lgS9GaXqQUUENfjbVBshqAuwM3cJ2taib1q1sGlhhys4WfHbiNad5nZuuR/K56I7dmlPqWqvrNEE14SAD9K+EcxoBqmGB477CYpz+xZkDwFeyVnrJN0vIJdjqMGVVfNcwyaXNkNMgEKhZqZUds1RkKXWVhRxL8eJA1fD3NgLwFTkO4fKJCEUAUYnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDnXYpEcEhZbdZWPOP1Dix1BPo2f7200ve/Iue1JjQk=;
 b=Cbe9kAemCfiK7MWcNS2Ulhhu7tk8CO35tnlm/cYRMTcCmuDrOoA0A4YsO6aEA5VXgvwWcPHcfxdhY6Rea+q2ChzzQJD7uJMemxVncEwxHQpSL0tciJaQa3COg6b2uJ7IEpNZhOW2LYNWTUH6BIwjX1MGQFLZSU/MB1udx2qE4KKE1dPZKavsIRQVVOJRQKMQM672Enz4ylOSS5X1Be2Gakuk1bCeVGkqpND7Trf5QTWN1bPeOnc0Hn/27Dq9CDJxRceHa4kCH3w5NFceYmaqJSNoqCu6y160mSbIoJa1iDsCUxAR841cEFiSaGcgjw0FvfVOIn81E8cJzNZawH7ilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDnXYpEcEhZbdZWPOP1Dix1BPo2f7200ve/Iue1JjQk=;
 b=GYx8EtmTyxDUHfFJPuk466YnHyCSY+mOe6vnArBc6+G6r16HnxkFYkrfP5FJyoDI8nfGXjC0ZLLI56yfKEtC9POv7pOC2xds2UnC++6vI8Ngk+XisMvRh2vtOKIYga/ZzMng0Fjkss+vnLrfN75jiT6gYY/BD7AC4p/CJ4R+Iyt9bN/IkraBhKFERewoCftbQ5ffMsSKsmcq6f9GucmBXckfzWjyr63pV4KPzUvZ5S/yNp3lneqSqIrxjpZSIP7Kx0aOIJLz0skSY/oNopAknKHMAlmgfleQ48dw/o048ZemQsAaPthFxIU53SlNP2cTVwf8fuwz2HQU4xv3spQQUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Mon, 17 Nov
 2025 23:41:38 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 23:41:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH v3 net-next 4/6] net: phy: realtek: allow CLKOUT to be disabled on RTL8211F(D)(I)-VD-CG
Date: Tue, 18 Nov 2025 01:40:31 +0200
Message-Id: <20251117234033.345679-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117234033.345679-1-vladimir.oltean@nxp.com>
References: <20251117234033.345679-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ff5904-8436-4e87-dc90-08de2632d9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jnNLnIzUXXM1Z662vWqM7dXV6gJOu54bzs9iAFuKDnS8BM3E4mcLhGmr69U8?=
 =?us-ascii?Q?7Zbk9ltIiuOM3c/EskcLTOrRvCuDvLD2I+klunukTrkht7sNhWPz/4XJwKhv?=
 =?us-ascii?Q?eMVjbmg/IYW2YMmRKXDKk1dduqlwNI8ts9ZmNkxuRRruNRpvX9NX6yD2TN8I?=
 =?us-ascii?Q?9r3EGovTzSULJwglWRbfDbzDyP/rc8nrBNeKExahLh/PKDYp6EqZsF7cm437?=
 =?us-ascii?Q?WhVNxre6WyulnjoU6FePnqXflyD++jE0xfafFbafZlTiT+vQw/kx3TU+VFzG?=
 =?us-ascii?Q?THG0NDK8hUEBFXWbLqyZJ90Ub58I8V7DC7ycDQfU0nI6zEwIlpdhG+JE1svT?=
 =?us-ascii?Q?fu3xxm1gIs/CtWju+7adxG3IKh/rdBSqw4lVAVyPyKp1GCf6d7nXqsBuPcvq?=
 =?us-ascii?Q?tT4bwKxA3YmLXLBap5t81op2XOro3nCYP5gTwIepuw/DH8hsW7GHRQYgrK7Y?=
 =?us-ascii?Q?2ttxCL6qu8S/CnVRA4F6X+XEnxA1FGd1cC2L66c726mRqD5e8xvb8d4Du5nB?=
 =?us-ascii?Q?8rvS9z/xtbgGQdI9DltIKSnbls+4YmUMV/e0+ttqDyJVvxBKVldPGDUWfOuW?=
 =?us-ascii?Q?SDS1CtUyWU8hOT2qfjjyT39lIdgTwhYQK0bW1LcUdfdYewBwA/3mpwCKz6ku?=
 =?us-ascii?Q?dqh0zjARbHqHYd7mZm0rUWyeoLo08LPjZmRsMkHoR8N1562RRUhr+Ez9+gmZ?=
 =?us-ascii?Q?l3g1gQgadMZnrOIb2kU6lvJXxla8GhgL6JBOpm7cVklW/WMhqaNxKR1t/rwn?=
 =?us-ascii?Q?kwFVrdgRF5LWb9rMuXATJqUEnxs8lm9tug0fNBWIFIUSDKevQBPIp8rKBKKP?=
 =?us-ascii?Q?8PJSJN6lEwcP3siBQqJqXUzLBi6CK0kRFQloqZ98KinVam95vT8LA8FHMn98?=
 =?us-ascii?Q?aRVOkdPy9SwLkXdQWDSr4JWS0Qwdf47FlGqOUg5hGSiV+c0Y1+UsWO+UA426?=
 =?us-ascii?Q?CW8TzSTzL0AErLYEk6X13MmPe4jzOy5wNCpZB3HA37+gldRXjLm194a8btqb?=
 =?us-ascii?Q?SyoqPgWj65cw8Byi9CfjUNq2LrGBrdx8exl/N9mpLaKULp55EqUTH1e0s1JM?=
 =?us-ascii?Q?1DbNFXxa/Xzs2DqPUV569pEFIcRo/qrK6DTDqCdb9yR0NymcBIBruIBQYNYO?=
 =?us-ascii?Q?6SCylHZFquo6+OPVPLSL+fnOj2atnXaqoLsyWyiHn0ylPiY9eHoJBA34yh4z?=
 =?us-ascii?Q?0DnUI3NCjnH99kwdpQ7pJEgWz51IfUacc4FNwBpT0OwrK+tagEeFxaNeZtPC?=
 =?us-ascii?Q?/fJDs5IeI01kXEiOcb+7TbAe4JotYRc8NYgms9iF24iCiK0Q2fo/WfRn8Cpt?=
 =?us-ascii?Q?2tR5bnJzv5+zJecjNoLhUeb3bnWHd24SPl0w9N4zeDxk3NkpNO4IIdzgycgW?=
 =?us-ascii?Q?Ii4yo7OKyCWf/5FXbb5dJo1eIsG3bEsk03QCmwlr9r95vVl5L1roqvRPBRPw?=
 =?us-ascii?Q?ckZ3mbynfKaI3E9m36qhDl0+4sknW7xX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/61m91wI9Rz+Gg7ghaQgqy1qIIpwnfgFe5Guh+csTbkqo7s07sPCmRy3h7/C?=
 =?us-ascii?Q?ZubZhNPP3+mnymQ8moh4pCHSelKeXjHJZH9ZQSXN2sXnKfjwtud/0zaqE4Fn?=
 =?us-ascii?Q?ypaaq2KA31v1Mc/lHkIj5uvurXsDixVSDiPr7y/7w4+veYwgNx23c2F5DNRn?=
 =?us-ascii?Q?74RHCLNatb6oUeGMP65jEy4fNk8+B96kOos6gjFeqvD9AlqXefSTVVfK7S06?=
 =?us-ascii?Q?A8i8Wfuq11k0cvegFo1ZWqlHYIcaQe4KNuabPy2y9+X3hR1IWxOytzAlrFIi?=
 =?us-ascii?Q?IX/uGFhJ1fzCVkELUCF71gb8gr4FJWOICmVoPlTB6gWxoszmpSpcWzuVkOVI?=
 =?us-ascii?Q?oj3DaeyIHst2kYKdG532pjNb5phymaL/6QRlj3eaTk/p281HvF0/Werv78+b?=
 =?us-ascii?Q?99icMxBNEy2evbZbis4RpgFlop9cSEIwLJLiZhb7HorxnNgfZNZg5+1qmb3Q?=
 =?us-ascii?Q?4pyecMCXjzEtBybdWJdOEzkWpE/S1fKM/5T5xI4EMsq5BsHGn1GowS26YjKU?=
 =?us-ascii?Q?D++C26I9IDUcKWOoOsfyuyxVTOkQGjhSIYI/ro6VbvN9YLHLXKaWoXIlQt0r?=
 =?us-ascii?Q?R5icIcwP8QOQ/bSJkyPOuriE8G+Pq9dTPTZFkZK48FjQB6g4utwT3uI8sqY8?=
 =?us-ascii?Q?jhl8l/lvzxMjmOoxdfmIAd7fgzTCeSCSlWqPaMrBCefQFfIhhI0f8cCe6XN3?=
 =?us-ascii?Q?v3bXK1z/ChANkiD51MkEjcKouxX8UPAOP5FXnvKxIbnf8AdSjkikBHZzsHC0?=
 =?us-ascii?Q?jRMxmqaRlziKaV9BRzxL60KbIgmmq9XkMVsgABATno41HDgtk06aRrFZwaGS?=
 =?us-ascii?Q?ixdlejQER2Zl3g0EUPZTlQfMz10Gvib8akJ8A+GjBcmwXRMPRMokgfxgq4Kf?=
 =?us-ascii?Q?RqqCjTTVNYnd/+x3JUFlytV0uIEG+qn+nMqEhxbbAoVcqrsJOuR9gphcHjXs?=
 =?us-ascii?Q?dxMNXYMeq4ET+rMySkoX6YIwLkB4cUJdy0Xy5Rj5G1iKWp6aWqUe+qs3jU/2?=
 =?us-ascii?Q?GuozFO6yI+avaeRmPw2aYDrwT7T3w/PgkeR2OKgJz7aU+nBtCIEq29cGEQek?=
 =?us-ascii?Q?qNoGo/C1x2Bq2S4Eu7qF7344j+GWP1B2h2kvBPgX9HrfIc+ipi9Qq3HPRqP7?=
 =?us-ascii?Q?UzuOTqcA50DYHoP0LqEqOejS8QtNlNANyzB3YTaw1tQ+mM8wNMbNwHGjPFjG?=
 =?us-ascii?Q?9O2ALjP14rOpKtdKDTSIULFlV8K+Hyl8jFqRmlIHt/6FzLwstioLneuDS2EY?=
 =?us-ascii?Q?L3n+3paA33vjUZ2+mPeGYLXsmlzqnrMZvViSJUbVO5ps41I84WCQEh/QB/Ec?=
 =?us-ascii?Q?0k3ZgSKGtTWLKA5JnHP8+T5GmTbnJ3u1baf99DfWVoco9Nb3h6giOkyZmQ3j?=
 =?us-ascii?Q?eWfQVdoy5gDx0sS5iTf+rnsK/PKT/zVRTdTb2Fy0NudBXvHce9i5a3peC1o5?=
 =?us-ascii?Q?+WS2Q6c+v5VvR08hi92feOaVmPO2+L0Tz0eie9xBDtLdodV9U1JV1YEcjOmy?=
 =?us-ascii?Q?P5/s0XSHH1T0algMZA5tacTn5xs+Lp8RvS91V0yFHcJSYqy95ti2TFdB8HLS?=
 =?us-ascii?Q?bZUCiclk9h3iqj7dLcB2Rwu/MY8pCypcXaU8OjZWG0/pGQwTrUFeizW75VVS?=
 =?us-ascii?Q?XkxGCmcUBO/8fiKex6XChv4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ff5904-8436-4e87-dc90-08de2632d9e2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 23:41:38.0389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxYhI5bROOvc4ItsN0aq9tYbbq4952OVoVtY060JoQAyTb3rCNZBcOSjig+HfvV1qS21C1npz2V69pTaTqLi/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999

Add CLKOUT disable support for RTL8211F(D)(I)-VD-CG. Like with other PHY
variants, this feature might be requested by customers when the clock
output is not used, in order to reduce electromagnetic interference (EMI).

In the common driver, the CLKOUT configuration is done through PHYCR2.
The RTL_8211FVD_PHYID is singled out as not having that register, and
execution in rtl8211f_config_init() returns early after commit
2c67301584f2 ("net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not
present").

But actually CLKOUT is configured through a different register for this
PHY. Instead of pretending this is PHYCR2 (which it is not), just add
some code for modifying this register inside the rtl8211f_disable_clk_out()
function, and move that outside the code portion that runs only if
PHYCR2 exists.

In practice this reorders the PHYCR2 writes to disable PHY-mode EEE and
to disable the CLKOUT for the normal RTL8211F variants, but this should
be perfectly fine.

It was not noted that RTL8211F(D)(I)-VD-CG would need a genphy_soft_reset()
call after disabling the CLKOUT. Despite that, we do it out of caution
and for symmetry with the other RTL8211F models.

Co-developed-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2->v3: adapt to the movement of genphy_soft_reset() inside
        rtl8211f_config_clk_out()
v1->v2: adapt to renaming of rtl8211f_config_clk_out() function

 drivers/net/phy/realtek/realtek_main.c | 31 ++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index da1db6499c38..da30cdb522a3 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -90,6 +90,14 @@
 #define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
 #define RTL8211F_LEDCR_SHIFT			5
 
+/* RTL8211F(D)(I)-VD-CG CLKOUT configuration is specified via magic values
+ * to undocumented register pages. The names here do not reflect the datasheet.
+ * Unlike other PHY models, CLKOUT configuration does not go through PHYCR2.
+ */
+#define RTL8211FVD_CLKOUT_PAGE			0xd05
+#define RTL8211FVD_CLKOUT_REG			0x11
+#define RTL8211FVD_CLKOUT_EN			BIT(8)
+
 /* RTL8211F RGMII configuration */
 #define RTL8211F_RGMII_PAGE			0xd08
 
@@ -653,8 +661,13 @@ static int rtl8211f_config_clk_out(struct phy_device *phydev)
 	if (!priv->disable_clk_out)
 		return 0;
 
-	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
-			       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		ret = phy_modify_paged(phydev, RTL8211FVD_CLKOUT_PAGE,
+				       RTL8211FVD_CLKOUT_REG,
+				       RTL8211FVD_CLKOUT_EN, 0);
+	else
+		ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
+				       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
 	if (ret)
 		return ret;
 
@@ -680,6 +693,13 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = rtl8211f_config_clk_out(phydev);
+	if (ret) {
+		dev_err(dev, "clkout configuration failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
 	/* RTL8211FVD has no PHYCR2 register */
 	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
 		return 0;
@@ -690,13 +710,6 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = rtl8211f_config_clk_out(phydev);
-	if (ret) {
-		dev_err(dev, "clkout configuration failed: %pe\n",
-			ERR_PTR(ret));
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
2.34.1


