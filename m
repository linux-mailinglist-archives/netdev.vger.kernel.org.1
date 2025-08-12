Return-Path: <netdev+bounces-212885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C89B22626
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1169F3B2983
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5E2EE5F4;
	Tue, 12 Aug 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bAA24V6t"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D72EE285;
	Tue, 12 Aug 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999548; cv=fail; b=AoezkZr9AwAFtwdyWKCS6PS8NaskjPy5RiZAGeQ8B5u/eMMW54NWbYhgA1TqvgNivvc8eLGyBdd8ydsuIwBDa9nD1uJW3XFL5qYx48FWyfarorXL69TMSHqqyPvUgoVj0C83P93n5ChioxvE888+VKC5UFyeaSltsiKKbtelW28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999548; c=relaxed/simple;
	bh=z+2WeJV2FRYSyfK4YyIvMspYdquvp1DQKCUcLT9O13E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UpgdXeWUpYXyPBpG5yGaQs+gg0hAUfXZ+TsQP6tddSMH9vqQNGbDoLeErKQGf9YdyxDhpRIuPJoScM03ggaMMjK2Va19hpdoBBmbSLf9Ozma7CzOfWKXxqc/TIJeQSTwrYWzIHHDJcN3IyZLrYxoLdbQhAgEsQiC653S7ZTFIfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bAA24V6t; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKQo1wRDDE5Zp8dfgwab3Rk1H9hOJEnFDYRcqHp1VzsOu/LkRlcQwdMkWtr/f0EleFwpvo+pa1nLXYeQpxWYhkML+5anW760frOBGbUSC8W3AdDed8AHUGHe1IdW51Fg+hdmPMAp6qOVnlfzLrmAUXQaaKIp7S+qb5Af/aiA/rbK5t2fkVoGed6Im+RIpiZ8IM568JMMp/L2Xu4n/VuQRC1pm11MiibIJ5g34EB+cAoeinpBpqwmQXnUSNlB9WmUqUQE6xx3tQOQbGYjoS9gqBGam8k5iA6/kl2icbMPWHw2Pch65a/iBt1jnjlcHrYFmyYEaHhCMADu4oAYhqrmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL+jmi027bkk7RxA6JSzxdLBuklDiWXgdPf+UQEQs3I=;
 b=JopJFHk21SK+66UtXq/pfe8wqxumcP9WhA0XGyCcsy1PI61fBPOTZk0odUJevRzckh9j1VWc0jamL50NpTc8p+zaK5RH/JRPjoWcWxP0rzN24Vrt1rzUp+RYO9CXeCIFUR3fDC9jLcsU/0dEZF5kYMZSxCaaCGFROifbICC5TV1F8OroPrNYbDk3khBPvYrAOjOdGqWazMxXfFYps1vRU6W/yu9UyTLl+O1ibR/74M+9+N9btut5my68fwH+aGF9FdES2dhSZYVss0bTR/oifPdA5XLecF6NEJEyJf3VQ15QWIvzUByIepJWXfZNIh7i0ZQTdYCxIHVs4MhJzsP/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL+jmi027bkk7RxA6JSzxdLBuklDiWXgdPf+UQEQs3I=;
 b=bAA24V6t1NzhHrcRCjgdFR6VrlkVjchTDcfdR+bfWUCvK+lWbxtNkkqI4r6eEMo6lUNadrqdjrBO3ZVGflORDiG1OJJsz/zkq+g4cEHvnlOKQgaD18nM1GgQAkkPHx8C7wL+dsWbzl/7BmGO8Ju3G7u8SaeWjNpdjsmOGL9CgpN3u0fijYJrrgql6cB1pT84rjgeiXpXe39gNA6w6K/rd40DUr93GS7V+DkrhuLvN/j8ahTOWNTz8c+Co4mGCNN7IXpVKUjnhlKJtu/2liVsvx2MmsTsIuYQYKK8w8h0bmots/bMa64w/4OtAVaZs9OF0vE6Bp8DkBt9oWKPgF/deA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8597.eurprd04.prod.outlook.com (2603:10a6:10:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 11:52:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 11:52:24 +0000
Date: Tue, 12 Aug 2025 14:52:20 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stas Sergeev <stsp@list.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: explicitly check in of_phy_is_fixed_link() for
 managed = "in-band-status"
Message-ID: <20250812115220.x23sfyerozalklgt@skbuf>
References: <20250812105928.2124169-1-vladimir.oltean@nxp.com>
 <aJsj_zOGUinEke1o@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJsj_zOGUinEke1o@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::36) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc44cd6-4b6a-4b76-c540-08ddd996b394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y5KYrCjEmcOSDTwPrLGsxyHXOoauATFbWuUK+wF9xRPCIjC+boFcii0oB8UI?=
 =?us-ascii?Q?0K0i3yJ/mTIaRCTnz08TwJx62dIMR7uJYDdrFdM3wCJPl2HgFd+hEvXFslbl?=
 =?us-ascii?Q?2ENMnZhttbroG30MCSVrOwUjxCAePfuIUd5/zaPfB9bKTrnhRLu2bOi0JG36?=
 =?us-ascii?Q?AXMXEYuAAZ/w4ifF7itkWCGUYWev9p44QRx5gcXjHWVqfQXHIxjRGaRIx8uR?=
 =?us-ascii?Q?4f071dGddmBQE/GTrXBaxHTtKvZSL7hpmlKXgDEm+QaDBZ03UwEhu2LDnvgE?=
 =?us-ascii?Q?+CYJE4hq1tZemO1OJYM4tGKlTVd6+DZOLNf+op0AeV8ynGyhXbb29X15d7c3?=
 =?us-ascii?Q?OoJqbbv/OUhi8ufJ2FXH18THKVtZEVtOK/eOfVcpy1+DSsu8VkpDuBdJdZN6?=
 =?us-ascii?Q?dSJgA2zKidRublfYVDxUxit6WzsPAcWR7GuSIhXIASH55EHhinIGd245SUQf?=
 =?us-ascii?Q?7xoJVOP8nhNOeKxoZ8xlvaKrYU8+CEa73gmbpOoAjw/aJv+GGotW3LiSDvxQ?=
 =?us-ascii?Q?5C/U3skOPCbkRG9y9wLZMSbvAQ5h0vS4h2sEb/nkfqMuiMwzrwJYFJDvrFwS?=
 =?us-ascii?Q?LBjMIQkGKyez8pfc1Mdhq7t5BOVxM75FtyKW4QOqvf3CGPRPWDdM/tlDy2A7?=
 =?us-ascii?Q?q8TjHMnFreDstXD+toXXoCNB48XpsJNnmswac+G9h1N65L4+w4ZqlyyKVBFx?=
 =?us-ascii?Q?sDJOjZj+ZiXs5ymhGWgodCV8YHDFuLqWbjkUMgOaXxge4G6d83EM86xDF6Ry?=
 =?us-ascii?Q?25VEmaNQr5TuLU9l6D0r516nZh7sjembegg8Ui+2kPmS45hWcijVEr7BXOnD?=
 =?us-ascii?Q?gt9bfUnKjgohheuaqEbcZ6uqOA3CauPn5Iu8x2TZnHL8qp0jk+m4zKXfZRZw?=
 =?us-ascii?Q?OUAO7QSqo7fbYXk6rBZ4IPbOkEqIRecKUFisiBVoQX5L9js8kdlFmcoVEFYZ?=
 =?us-ascii?Q?OA+hY4If42hznn0CGIRrQB7ZsQ9neuJNs+BaZWxxMqiqoEZZ06CJCbLUxldy?=
 =?us-ascii?Q?yl3l4xmCOe2bAsVgM9CujO32FUQ6rzPbngwBERFl3yONSwP1LCwfRUq44G1O?=
 =?us-ascii?Q?UFWWXt3lgmjuzaFs9FINTQA5WGrd5uzmVFWCZb0I7Dr1MuWTCY4OXkcISxYi?=
 =?us-ascii?Q?hgDc47xkRjsrxulUvpI1IRd438P/nyR14Yc6OP8DEC4zmwrI9N7OT/1ikTBf?=
 =?us-ascii?Q?4DQ35fBURrSGnHbMNPsbzT+pG3QTIpbMOr05RJN++xLrf7CfYapalAk49knm?=
 =?us-ascii?Q?ibqQyxdI9V1TjCB4LIA2Q8NLPALyvWHgB4jJcy2zeOx5xwSfDEGRjcigGkMA?=
 =?us-ascii?Q?Z8WUfXw5Rx6hSLACoOXSn+tlCPaNEs68prkYdts+GDP+tzILrzHAgWEGf4SI?=
 =?us-ascii?Q?suYUl2C9URS9eFdZB2BfGUbwzIuG2xYRDQtpd/CzauhFMMatDo9DIIlct/B9?=
 =?us-ascii?Q?3xZUC2f3lLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gKKWVytYwtT2c4T7qvvJYSkKiK7UigGM+J3QNl5MWLBzuepdUK4o+c8ytk3Z?=
 =?us-ascii?Q?W7Ukl1aqNL08H5QGqHpK8rXfmSjd05M/u7tEgmIm5eCrXlpwxQgnyW6OuUQ/?=
 =?us-ascii?Q?2wdCWiBcNtENciDWDNttI+Xwgpl4mwIKs8eTp7Sk+LdHhms8qCdkxjYB7csO?=
 =?us-ascii?Q?eaH5oeLDce4AtpgLqsYzOI9llROb2fT7KYuKwd9iOT4gwjGrwbLwD42J/ZsV?=
 =?us-ascii?Q?6HE8PYsch+LybEchrEwD+lQBa8EVjAhaigTUljVE2glLty8g13dxrNvmJgqR?=
 =?us-ascii?Q?r590oBKzylcL+SssJrnbX80jhsA1u/PU8k7nsuggp4jJtDw+7t20MYWabM2X?=
 =?us-ascii?Q?kJhCOeIMbxjPE1elBG86nM7owbk04sZua316H3D7+sb2/xfFt0b0A/ehYH3U?=
 =?us-ascii?Q?Qpq3e5WGY2EO6bjzNdfD8CE1UwomThhNUe+fblIj3VEyy3WkcfpkHON5XBGE?=
 =?us-ascii?Q?J1UFiVIT7D6BuPFmcRcNKRML4e1L9DMSmFctciEtPlGK125Wjq5ufO2KemvY?=
 =?us-ascii?Q?9JyUEyC0lMSpay6ZLyNnwyquyAtvk2YU53cDD6R8X79Q4YFD/g3P6qtNodBe?=
 =?us-ascii?Q?6vPoA7cgLY2MGqkNhJMn+Kb2fOjf0JC6J3Y/9NDXAsv81CsH1NEtLBaVRLSN?=
 =?us-ascii?Q?Pea8yFT+ZwwnKdu55HYaSmal+Z6BX+qUbfzmyL9j1QeXc7KLDkzSBYghtlN5?=
 =?us-ascii?Q?S7BY2eUo8XJxX4jVD44Nj2AN0RdX5Rjke4D/j4HjlQWt9DEUSJnwXq+vW/MI?=
 =?us-ascii?Q?Rlv0MYSLvySdu6Bo2srZQ2NCWx8ZkyPmoc/HIzdjW2xmWrtESthoEvhccjG2?=
 =?us-ascii?Q?fSRTwqd8EpkQBZI437yfoSzTt4jPw2TPEGkbZYNpM4KJZfCvdsgL92Lw7DIp?=
 =?us-ascii?Q?Ea87Z0PHugEcZ3BejkNC3+DCL098NctvDFeMvQrIc1bjzH/Avr01jvuSNX0C?=
 =?us-ascii?Q?g3Msz1ezEiO/jqTLKdnRhZ9PqWWMZeo0pdApFf2T4g+OTEyf0mfbnL0op7zq?=
 =?us-ascii?Q?EXjINi/rsRdXzZw8VkM5UXgJtvQstqqnD4UphsTVoYaTuFXkeqGRRUP///WG?=
 =?us-ascii?Q?CQuZKXZk2Y2dPqT2AwVXHGWOYIsV+lZKosnxDfwypM2Qfg26V87AcTnQuxt9?=
 =?us-ascii?Q?nxeJJ+IY+XIB7Vng0APO2/pL3StLgON8IcV6e9EzqqFAYvvRrB80tBslCNtq?=
 =?us-ascii?Q?sn6CTTTFI/N3l+fZ3W3NcF63iPYt+OY8N6opv4YB5dCD1pL8tgT2m9L/cwbt?=
 =?us-ascii?Q?Q9xalHRVzutgybzZYZep10yznQ3HxkpujnrdZnmgc8tC+/SE5goOVsd/Xj6Z?=
 =?us-ascii?Q?x0ujIRaJeNn6PkTKmzKFhYweRybK7txUJN0e3slZSJvW8cy8y6pjuoyMILEm?=
 =?us-ascii?Q?qYRYjUm5iG+OjsU7FEDqKBCrdQK+xY9F9ag2DIygGW5t7YNyegn3CagjMDMO?=
 =?us-ascii?Q?xhDMyoFONI89kgBkOUi4Cp9mKYMJtohO2y2Gu4AUfrrnq+uvdHiSIM27APMP?=
 =?us-ascii?Q?+OfbimYIPG9VsgK1oQtqI2SNFNtrZ2RttI+/hacmznWeACxuv4ERe/GT33hr?=
 =?us-ascii?Q?Wq7lRE625BD5uTGukuHpUkLq2p8iooQs8WHXaMFix/dBKTH4YqQh4cWVj6/D?=
 =?us-ascii?Q?xMxlXksHQsM/R6MwyB2bCtCCbT5rQYWeeMWTELbXZr4VB4abZmTznpYJtCm4?=
 =?us-ascii?Q?OueHMg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc44cd6-4b6a-4b76-c540-08ddd996b394
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 11:52:23.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYg8OdUZvqUECl5eM+IKnQ6kKEfj+C55B4L4765P5/hw09YHD4RANvhQlVxtqgSbRA9SHLcwau9PE4xJuobtiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8597

On Tue, Aug 12, 2025 at 12:22:39PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 12, 2025 at 01:59:28PM +0300, Vladimir Oltean wrote:
> > And the other sub-case is when the MDIO-less PHY is also silent on the
> > in-band autoneg front. In that case, the firmware description would look
> > like this (b):
> > 
> > 	mac {
> > 		phy-mode = "sgmii";
> > 
> > 		fixed-link {
> > 			speed = <10000>;
> > 			full-duplex;
> > 		};
> > 	};
> > 
> > (side note: phylink would probably have something to object against the
> > PHY not reporting its state in any way, and would consider the setup
> > invalid, even if in some cases it would work. This is because its
> > configuration may not be fixed, and there would be no way to be notified
> > of updates)
> 
> Both of these are fully supported by phylink, and your side note is
> incorrect. Phylink provides all the functionality.
> 
> With the description in (b), if a MAC driver wishes to, it can provide
> phylink_config->get_fixed_state() and override the speed, duplex and
> pause in the same way that is possible with fixed PHY.
> 
> So, unless I missed something, I don't think your commit description
> is correct. If it is correct, it is ambiguous.

Hmm, ok, it seems I was missing something very fundamental, thanks for
pointing me in the correct direction. I'll remove the side note altogether.

I didn't make the connection with phylink_config->get_fixed_state()
because I didn't realize it can overwrite more than state->link.

So I see the txgbe driver implements get_fixed_state() to report the
status of the firmware-managed PHY to phylink, in MLO_AN_FIXED mode.
That's interesting. I think dpaa2 could also do that for its
DPMAC_LINK_TYPE_FIXED mode. Currently it avoids instantiating a phylink.

(I realize we're diverging, but is the initial speed passed to
phylink_set_fixed_link() particularly relevant, or can it be arbitrary
as long as it's supported by the mac_capabilities, and as long as
get_fixed_state() can overwrite it? Can the speed be SPEED_UNKNOWN?
I don't understand why txgbe passes SPEED_25000 if it provides
get_fixed_state())

By the way, while reviewing implementations, I found bcm_sf2_sw_fixed_state()
to manually call netif_carrier_off(). Is that valid, to alter the
phylink-managed carrier state? Doesn't phylink_resolve() ->
phylink_link_down() call netif_carrier_off() already?

