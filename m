Return-Path: <netdev+bounces-250071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA74D23A2D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F06301B83A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D8B33439A;
	Thu, 15 Jan 2026 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l5O7Q+1V"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47634E761;
	Thu, 15 Jan 2026 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469977; cv=fail; b=sSRmk0zt2/npkqkH4k/+fTve9NPcZmLAusnvetOU3lHmPR42eBLfDv+xDCTMc4f1MxS6vedWFqVfR0T7bYLfPLu2uHPQEH4udBfR8by+JRz5GGaAoHHWRkz5bseHbADEPKf3k7qTisl7wP1CcldFdCx1Y3LaqMMtBV+zmmWrdGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469977; c=relaxed/simple;
	bh=yjIIIJkS5UAUMM58OIr5gmGoUhNh66kVyny45ChgnIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d4W9pAaxu/trjfbrnN7DfdMa2PhC5TvAXbK5DqkBvBgDJr/X9JCFDJaLOoo8blABuunfDW3V8rgsvAjtK8rM0nM1TpkFfLto0lm4xomuK7GL1Be1MXblsePY4EpN2mXfXmMXsjUg9sBa7yAHVrktRHW5gyGgG06CywLPeptlWpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l5O7Q+1V reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjR69AFwZwL5SdFd1OBiN+gZyRO9BSkxthFbC3IwTEke/WX6/47deh6c5Dkxqx/KkzMrOUZrTPegLSYbtJ38HBw+xhliBkZWxPjZFg97jQ7Mk3OLhny8MpQ+pzYxKd9P1IJptf9N67s/5zf+riZI9IbsCI5ZEh+41SJH47uDyjfBGWxMTBJKDqnnQaAJRzOR5ZCNX5663Qp/PtGbX2I9jAzl7cTbmaPmcnj3MuHV7MQ6Yn8+xC7tJ0dJpHp+A0APzgfNVI3koQm0fpOxsFLHIxAdDDhVDTnfyMK3PUparZs/3H+S8ZG0iYD3SmMe3JuQ84jhoA3t5RSzX6emL7uKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6SkURbgMCB4EOuxnc3xx9cr5FD3N+HfwTz0gbtQcjo=;
 b=xfCdBSRHcasYeG03RMlvQxuRfwEgTwXo5YXpzIZk8wOwhXJ/9jx1p5dfVrsOP2OwYCWHRLBboB9x8hESh4FJWHVCzOGWDKK1P8LHF5MQl/6vT+yKb7jHTBNEbutNG1mDTtQvHykTncHwqJHNjFWqvSF5vOHZ25AJVcpIv1FhbqSBo7ICRq1G2B0VVKxZWkVvqTJJV0uXh2KrvJiq29U0Akd75Q+IRgE3rjfEL9KbFu79BW+fb4lRPv/Qu3tXZNNzSCgBmwIrpvrsp4giYMjiTo2eoIilTtpl9Jy1pg07cmwrcG2FGFy7X40xPdd14vA1EGRHB7mXmWeAj/VzrZ6w5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6SkURbgMCB4EOuxnc3xx9cr5FD3N+HfwTz0gbtQcjo=;
 b=l5O7Q+1VWIDSJW/+4fYJa5vkftLMdPQi7Enm1O0f0AgwlfKUT5pbeb59wZ5XxGn4NcQcJFL01lWHIYogfv1eNUOfbtfixoVe0y/MZJZZ7V7Dprl+lakVRRiMMSymg/JQC6WpDfs3VGIHXODEE2HdIQkBkpZNJ2spMhM70DqwBxr0N+hVs5gcYmZcQxMmZZFdr3YErujuT4DLD4tGkJ4wHgs5Mg/tZZKO1JSC58fokuWcv3uNFHAKMnQPRue8pKdJ8MYYo1nZWZHHivLJT6ePTHfTF692IbUh+0W3PM5SoMIqMTEa3Z9epBkS2msR1WYQhwylQX06CA6Rtp2b0+8W6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU2PR04MB8503.eurprd04.prod.outlook.com (2603:10a6:10:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 09:39:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 09:39:31 +0000
Date: Thu, 15 Jan 2026 11:39:28 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20260115093928.hdqlxkt6bd5w4xud@skbuf>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
 <20260111093940.975359-6-vladimir.oltean@nxp.com>
 <87o6n04b84.fsf@miraculix.mork.no>
 <20260111141549.xtl5bpjtru6rv6ys@skbuf>
 <aWeV1CEaEMvImS-9@vaman>
 <33ff22b4-ead6-4703-8ded-1be5b5d0ead0@redhat.com>
 <173d1032-386c-4188-933c-ca91ce36468f@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173d1032-386c-4188-933c-ca91ce36468f@redhat.com>
X-ClientProxiedBy: VI1PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:802:16::33) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU2PR04MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b664e3-a81d-4ec8-c398-08de5419fc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?leDsOMrDuot4f5icJ565AH2QWxq+bnEfTQ996pXHYJNQVqCITiy3k7ZuQa?=
 =?iso-8859-1?Q?nxXPQYotjeMD8j4vjQVTMqUSWKe9E1CVezLho1N9k6SnHyz69dmoIvNmdH?=
 =?iso-8859-1?Q?VJScnsyKA0qeCzIFOMIF4bV+YZxNrWvvB+1d9pCQ9IJ+NWuXuPAYq2uT6k?=
 =?iso-8859-1?Q?z0q2zzYca8akf/7PP1chv9w5yJhmqDdUa+BcuWDm8R1Fk1PAjadhARltUu?=
 =?iso-8859-1?Q?zPkPj2cXwgIB3vw9BfXwE+xYfFddhqFCWuDdMBUMq/cS3Lv0RYIJPZ7778?=
 =?iso-8859-1?Q?pijDogQc1JpjQdsVLGzrPRsmBAso7tM1LjcETPIFwH6YipeEMXqES2V2o7?=
 =?iso-8859-1?Q?F/td6RZuAfYO0qun6yMQFSwuhmVf8Qw+QBmrIAMmGu5039BnXKMsvOwQGH?=
 =?iso-8859-1?Q?N8YGQge6YeujYxa4dFDI0eDkfkZfUAOeWtjW12iJ0K2QlhOx8wRvmH5pw6?=
 =?iso-8859-1?Q?7Le8+z6XNfqGpQcag+imIBTTuryd0F9gJSucd7iFV459fr2usxaFVDxo/Q?=
 =?iso-8859-1?Q?hU+dSvQ6LvfNZnPkzZD38Z2qOIrRMZRsbxQ89V79jMLLCWsr9JpV8RSUXx?=
 =?iso-8859-1?Q?zhkxJAwgbZoHeojbxAnhbLroDnnX8sZnYH86aHpcdL3GsUw6+zljgIVKlT?=
 =?iso-8859-1?Q?LXtMB2gAoXPyJAj1WMwe2eqiDDlQtZDZM08uBqJEefrhkWyijRJ60TXUmo?=
 =?iso-8859-1?Q?WUrw5Z4Aafr7gnb5zIvXYWqBW6r6+8kzF9M96GE9JmceltMHKvv1U31/Bm?=
 =?iso-8859-1?Q?gTs909LKoHUPh9R06uwbplNskwHkWwQiBC9K+5m7VVX6sUo78xKVpwyAcn?=
 =?iso-8859-1?Q?TLWgG2vP2o6dBvI+ly+cLRA/x6n9qO81jEG1G4Cp0PWF52NT9EqRCnMyQp?=
 =?iso-8859-1?Q?BO/6252+gwKGNqkmR6/p8Kp0XOftN6GibnEFDczmKjGleaDKRt92xF4710?=
 =?iso-8859-1?Q?CNNMIFQQRkSD5UD+o2eznOCz84Ifw3NxWRjNlF2wKYX6yv0qt18tbfFgPE?=
 =?iso-8859-1?Q?LdnxAsD2eJz3Acnb4He35ddHQcWZkuJsmQr+jLi0Ov8JbrcYEhM+aNka13?=
 =?iso-8859-1?Q?Vq0DryB28c6hpUt1n3qwtgLMBPoB0U4CoGGF4jR+idlsJ22yY4ThME5MVE?=
 =?iso-8859-1?Q?CObvj1ig3iEfygO72t2Jz8V2EmmQtJQYdFwjvFZim88mG7A3WQQKIN5xF7?=
 =?iso-8859-1?Q?McEgVkQN6Y90F4S2r4SyzQZ9y5ViYgNEAB5YP88kPXCIGyPmiVb8vVVHpZ?=
 =?iso-8859-1?Q?yRyORHxY273cklidnbTVbUUnhNKVI/C9HFfGFhSNgdkzdWYcPwiazB5MbI?=
 =?iso-8859-1?Q?RZ0hEVSSqyV4n5Tsq2ku/HLL8v76Y3lztjuFxeX3Pnhrn+WXqimzvJdBM1?=
 =?iso-8859-1?Q?sGbwsvu6meOU49PicvTItrbhuHJF7Wg40lpzEO5DdPn41APDKs3QetMzXD?=
 =?iso-8859-1?Q?yH3HS1IC7bLKEJOVqVOBicsvxo5A3QE/BPZVGNAqQdwfPreIQPdU3SplOo?=
 =?iso-8859-1?Q?zYPRXpFgRbEONXAPK2hVmEgZdRwsOHHKvxZbcJ1xQeGopmfwvAMcFoDLPH?=
 =?iso-8859-1?Q?gt2pHP1wK3WzGdnaHb2jYtGbU9XegJDERSyVSVYOuy4XrlLvEZxKAqtUJB?=
 =?iso-8859-1?Q?QHlrvdqPSnpp8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?LTosrikQAsb4xQZmyUhJbAlFR3+GJITOzOWBo9P35mDeriIlgL2cpsDSVG?=
 =?iso-8859-1?Q?rRrP25RLy1pXA/GTiQvMS304uJxzDZDCZFpir4xcON5OOGJVc3umfWUy7k?=
 =?iso-8859-1?Q?4F5CN9HpVF0sCoqDctgrZulzX1y+Q8iOk0uR4EPjFV16bfl9aqdA+cP9ck?=
 =?iso-8859-1?Q?/voNsQAJmJeFUw5zPtzR+OaqGszFAVbnmjP0VSxwqmgdvFZyXovKy8J3hG?=
 =?iso-8859-1?Q?APcrLY5+LwNuCR6q0sa0e/ztXWt0GYlEi2IHdK6wWMhaeopyFm59lSnMvN?=
 =?iso-8859-1?Q?cP/u4DzHqJcrN5LCO/ywzR2lXXLf9C7nz3DEWrmET+3P2sNU75AVzvA0fN?=
 =?iso-8859-1?Q?O52UXfqpctp8GEov6h4XFwvCDFO1YpJI5O2Tda+DGjrsB8BBAEB+30M6Tp?=
 =?iso-8859-1?Q?IZIuFfLBxwt1t5Ebght3H2a524FHMo39hmP6AqXd1k83nHbYSkbn48IxZQ?=
 =?iso-8859-1?Q?PbPhaC+uXvCqy3bsi8+tv0vZH4j5F1jGLltaubLYHt79FfU383IyzoXxH8?=
 =?iso-8859-1?Q?KqoImgkNT/J6qaOEsFuEpRDSztO05juoJ/IrHu1LVONPzkvlgFzYYqn9Qs?=
 =?iso-8859-1?Q?zhp5qKTddnkZBnCAWqxi5WM5uGKzwoydgug5PUdNoMoE18VlC7Z6MSAfp5?=
 =?iso-8859-1?Q?Osd08TN39hDs7WthMh04an/wONdCvvQ3y4qF5CkXQ/4OmVduzw9QZhVdYr?=
 =?iso-8859-1?Q?aQXXLfX1rCYRU7siYXoEMbMRocyTsWjkDilFGiipumcmlRbeWuTwOA8dSE?=
 =?iso-8859-1?Q?ZZG0elxy8Jfq3JLLlWzBxh4cMVHbBPnXkq8PI1TSTsuAhUGEUiNO4eIoXy?=
 =?iso-8859-1?Q?TqhvHX4ZO9pVn4EWRaAWY9AZXut9Ih4EoEQ0Se+UzIWvdZ4QZ88hTXIYzE?=
 =?iso-8859-1?Q?qPTbq7kzBBAkshMmboV6j/CbXLFuL1PeODSnOSrBJs+Lj5MrmlkNp4R86M?=
 =?iso-8859-1?Q?+XrOLsqZoCA4E6HQX5saHOqKmaTGsLm+xKj5Gqm1sBUWcTeIOqFFwpNMfx?=
 =?iso-8859-1?Q?IzRZoQ5xXTt+dgAng2jg1UiL4aG4FlVbZw3mtymPzFuqk1yYbVPFslCBVz?=
 =?iso-8859-1?Q?MAB9ZOOnRy/wOKHAO+ZDi0mnSsi4+NSjbRY5rZrxIamf4a+WPBOPhn1s/i?=
 =?iso-8859-1?Q?pd2Edb+CY84QFAT6AMq4VkcYt931nUzRcM3tf0mBE2aYoOfBX3NTxyHnUl?=
 =?iso-8859-1?Q?7fsiMS+jTMDgqbheHxiWvTZBjZOmvmVtvXs+6OQd4Fhk8v9pyjk43H6YyD?=
 =?iso-8859-1?Q?9Ojk8u5znODvDRHnwnswDet/eoSX3EYZDoqyl3yTcRaxCLM7gE/xg4D/Mm?=
 =?iso-8859-1?Q?wLETNSPeqCeE7zIpCniGNq4vOu9giLN+GZww85N2aSjw1pEKNU62mNy3TN?=
 =?iso-8859-1?Q?TnsvImJc/baPEdFJ11gkMrS/Z373ZMkmByK07WH8LuC/X4KYOeGQJrck9d?=
 =?iso-8859-1?Q?iWHvvp5yXQooSTPqlbmZqxxSvT09tnfDc1GbslnSPnVMXMe8kFWiF2Td5W?=
 =?iso-8859-1?Q?SiVFEypxkANZ4OZL7q9EhLAeYklAJGjmKcyAbT2VtTeqlpy73ld1s+Q2sF?=
 =?iso-8859-1?Q?mps83otJ97OR9XYqOZ9U4nwmHwgvTHJE22Y8p+NNg0mAPNI+4fvRSnYC9s?=
 =?iso-8859-1?Q?WCNpv+otRz4dTz5aRVu3prezWOx4nGSPoxGE9r0RT0ESAfIConWKsMSmGj?=
 =?iso-8859-1?Q?xcFDzUgkgTgW2UcSWQLhgc8i7pEit/FVisMitfP8y6M2dXwb5StmvhxbK+?=
 =?iso-8859-1?Q?W/xnSymxwb1Kq4Gllz1v3lget+AMOWHuR2z1jkHplwYUdnPOpMsVhxxI8i?=
 =?iso-8859-1?Q?vz+w1cXxJ3iwzM0Qh+GtxKDnMW7TWItnXzOlDTLxON652Pbgu5ZjVMBLJr?=
 =?iso-8859-1?Q?Gm?=
X-MS-Exchange-AntiSpam-MessageData-1: A55+88YUQPPxVXK9nH0DPiZLTDHr8HxeSbw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b664e3-a81d-4ec8-c398-08de5419fc49
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:39:31.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPQ+hc7UYObVIOmnz1JWxRWxStjeHaSQVAY8sQAKZUga2s4gvkM1NtH8FdKdyRssV1b92rLO29ute0OT8DINWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8503

Hi Paolo,

On Thu, Jan 15, 2026 at 10:37:33AM +0100, Paolo Abeni wrote:
> On 1/15/26 10:34 AM, Paolo Abeni wrote:
> > On 1/14/26 2:10 PM, Vinod Koul wrote:
> >> On 11-01-26, 16:15, Vladimir Oltean wrote:
> >>> On Sun, Jan 11, 2026 at 12:53:15PM +0100, Bjørn Mork wrote:
> >>>> Vladimir Oltean <vladimir.oltean@nxp.com> writes:
> >>>>
> >>>>> Add helpers in the generic PHY folder which can be used using 'select
> >>>>> GENERIC_PHY_COMMON_PROPS' from Kconfig
> >>>>
> >>>> The code looks good to me now.
> >>>>
> >>>> But renaming stuff is hard. Leftover old config symbol in the commit
> >>>> description here. Could be fixed up on merge, maybe?
> >>>>
> >>>>
> >>>> Bjørn
> >>>
> >>> This is unfortunate. I'll let Vinot comment on the preferred approach,
> >>> although I also wouldn't prefer resending to fix a minor commit message
> >>> mistake. Thanks for spotting and for the review in general.
> >>
> >> Yes fixed that while applying
> > 
> > Could you please share a stable branch/tag, so that we can pull patches
> > 1-5 into the net-next tree from there?
> 
> Vladimir, could you please re-post patches 1-5 after that Vinod shares
> the above? So that we don't keep in PW the dangling (current) series.
> 
> Thanks,
> 
> Paolo
>
Vinod did share the PR:
https://lore.kernel.org/netdev/aWeXvFcGNK5T6As9@vaman/

