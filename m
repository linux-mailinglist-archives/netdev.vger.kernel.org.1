Return-Path: <netdev+bounces-99067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1728D3936
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100111F269CE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D35158DD7;
	Wed, 29 May 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XKB1at0J"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2072.outbound.protection.outlook.com [40.107.15.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC8158DCE
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993041; cv=fail; b=j+w6zBhLfntsOkIFtATR9IOgwkShxxVY7ocAaO+W3FQUwoGlvJ/wBa74QHWZHyh/MCds72k/7j6iPt071272f5ixWIHN1dYhuSB0ByXfKsB9MN47vyF2sfRnK2BjgirtvqtmJbFuZgx5TAkY4h29PtllIlcPhIhwIjdeuZi1sZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993041; c=relaxed/simple;
	bh=3kXs8aCji29tvhU+mLK4ZgSb2bLUa4foze0eB/H53kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uKXY2Pb15w7Yi3srTI1SbsrcTsw04/T7QqNTiQKIFhxwkAcnRqgfAxmnfYrvwX4J0nLkDyQEthiYm942tXUpOh+jR82EfzzsotTAnBklj2AtnV7/YIsxPTD1KzRTEhv98s1gsro2TXTQbIC07Xx8AeD028DqhZ/TwK5PVK43Vqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XKB1at0J; arc=fail smtp.client-ip=40.107.15.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c00muJyfvkkb28CJLzdtAiWUvq+PeSBy9cnj17ZvKQBncwk/hldjXMpU9W1VzgRwRr+QDgHXwaMONQhJVfya9EfjtFI/MB8VbtkpIxQGcTFCLqhSt/y2NOsFprwioNLKQUCQ1xdxDTbtkmKyBb0bJC+nQK8IYP4Nsej8dWoNKHz/1+E/68sDYgmr/59UflC60b23Ad5k8ZYiDSmTkCCcQ+rlVYU/2tSCL9v6ezsB8nO7onHIClCZOacWbJRLaCgsPq0TLL37pZm+TByQqbJpdr9+EcdGIQKVYvkLBoSM1C2swn0zAnemxJ9u0VPBBCRPAGr7PkkLmV0gRgKf9iZvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgEhGeMQBQ+AKZEj5e6XdvTv7C0bZEiAFE0Ob/4IQfA=;
 b=dorbc8O4ps2F5zyLUl39ZbF5h4Nu50RiiOSvtbg+YX+h1Zh9v+K8pO6jsNzmqTh9PkwgAZDvye4j4VXqJryjIf74wWdnD7dpnryu+CKwGM+dqeHI0JGoTCa2pvusRzRuoq5ioAOIN7Kk+Ca56ll2ud/S/LDPlxclODMnWvzEWr0DNGJmNkmlAvEoW/MmYiMfEWfZVhNvj758rLhELBxudfd1NuYbFbSnloTWKkIjuMgQrQgnlatiZxGBVc/+sgFLChI5fQJAr+k2yIQp+9yv+U2mG7eNTAPmF1T9v0jZyEODYDESDcyQQm4OREUyIEBHZ7sM7TzwR2CmkJgTC+yDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgEhGeMQBQ+AKZEj5e6XdvTv7C0bZEiAFE0Ob/4IQfA=;
 b=XKB1at0JtvAXHBi/2u30Ot7RjjpQ3LPGDq4tC/Y/uIUTW63NXnRNLpQuqpglLr3TQ2UHQdrKas21z+zp+CQflIKaLpi3A4KW1kydkctZt8iwDW3IG9ykToEch2ywTklXp/NX5KD6oBzZOtqUTRQJlO/zfFV5wOokgJqozjgxzqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AS8PR04MB7621.eurprd04.prod.outlook.com (2603:10a6:20b:299::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Wed, 29 May 2024 14:30:35 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 14:30:35 +0000
Date: Wed, 29 May 2024 17:30:32 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: felix: provide own phylink MAC
 operations
Message-ID: <20240529143032.goa6u6ntt6tpwr7o@skbuf>
References: <E1sByYA-00EM0y-Jn@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sByYA-00EM0y-Jn@rmk-PC.armlinux.org.uk>
X-ClientProxiedBy: VI1PR09CA0183.eurprd09.prod.outlook.com
 (2603:10a6:800:120::37) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AS8PR04MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: e7184e47-21c4-4f07-20b1-08dc7febe75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CDciyNwyMJ8j+qcKYgAIM8Mkgm8wNvkM2giKa1BYX0cjKEYRDaw/pnO8VUCJ?=
 =?us-ascii?Q?PRqMJQKK5qdFUxbNj+am2ST40/YAyWAFPUrDv/tgIeyUgCk5IDZGInnE/tCe?=
 =?us-ascii?Q?2GYKRMoawaulYS0JbfEQlI6s3SpE7kdLBxBWANrsbmu+btZZFDX+Rwhwpi2i?=
 =?us-ascii?Q?5b5O4jdvoCvij0hUNxtIDHZxYwJy128PsVsC5X/d1PSTUkhUMwal054as8gp?=
 =?us-ascii?Q?vB9xbfMOy83KuJTR/ZQmHuAW55VL9hGKdFImAN8vtFIiekzbHzWGOp6CIEzL?=
 =?us-ascii?Q?8zAth7nDiSt6cN7fF6QNQKfmNJUawK4t8lB+UuaZo/bSa/XzlIR9CUfdDKsy?=
 =?us-ascii?Q?QFpaE+1oqpZ5joyOaYnWoWFgpSiECElwJyGPSy3+F1R82jUg7QaIixzIZ0RC?=
 =?us-ascii?Q?U7ww5GSzA6qQDvpbPgnfiCJObpkfH5P1k/fXcEST8i9eaq7jqBgNi/eIkpom?=
 =?us-ascii?Q?03Er7v0KApMtLsQBHFeNczmA60Wcs3YSzQZBAX5C+P7EAHAvO4bqsWIv2Eif?=
 =?us-ascii?Q?uJSmwrrx7Wbf1nFXA0zj7KSivFL+i1OLhTomG8XSvsIs8WKYHVvYsP1mCvtx?=
 =?us-ascii?Q?wXALIK2eXeNFhnAuYjyqTQs5GiRSxjx/FNoMwR5QAeKSTM6jXGnr/meOiuiA?=
 =?us-ascii?Q?MVZAja3X2alPK9n6NSOCeX7naUZYtyucAINtl3MEFl9VSF+Hb5/gD38EZiQp?=
 =?us-ascii?Q?OXL/kImbduhqBbyq/G2WY8Bh3q0zkM0E+V/PdJZEZy2Maauio/XPlZu8MfSS?=
 =?us-ascii?Q?Db44K0mpDRyC+vsnfO21Kez/1YjH1CVhyIsDwqTlz8ileiKswzL9JetcBVQg?=
 =?us-ascii?Q?WbqP8IOK0EbfCuDxA/neweKwISCoFyw09WphGevjp+5QOEsKyWayVCP10jHb?=
 =?us-ascii?Q?nbB0PhqfMs5pbtgHLtTS293qJKK4jf/Tsq/s5zFtZDyszjZuPtFn7mVNallJ?=
 =?us-ascii?Q?9FkTiqOkH84Il5wXVtqzFE+yE/J3erJFHT+rsG7+0Cs0YyrOktS8jWieote4?=
 =?us-ascii?Q?Y06EwxPHFlcoX/Uhh4778uZXsq8xMPJYjgxGwXob8qjMotbQeYyxBZrqzO6/?=
 =?us-ascii?Q?uJUCjuz2goPv5yXy1Cy+0JGSSZR0vQDLXxmQ0AR1+ZuS+3CEY5vWzV6uQyEB?=
 =?us-ascii?Q?hgUTuxOTwQyI13SRe25JtGEQdT+3xPT/bmeCLwLj2saQPuh2jTjrrNgT48ys?=
 =?us-ascii?Q?v+Qqd81MHWBy500dW+fNBzB9rWz/tg9f8M91GV5BZAqcfvzM067p8O3pwPA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lSIE3bS1Iefdg7TPbcIPOX/YiUFL4jic72ddPBP/bEM7u1gwEz8313KF+580?=
 =?us-ascii?Q?OFjgIU/H2mI0DCp9D4eFrL4Nspl5KY0wEsmcfJ9A4ChMdPadwACriaVEuWfd?=
 =?us-ascii?Q?s+HTnnr3egnQ+qDqbNEboJmBBfkNXAhst50fMxElfbtdedR8a/yU3nvHJPwt?=
 =?us-ascii?Q?HoXwpd+MDvql/HZz0BHaAZty/d+X0BGjE8qLjYyWx0Yfn4LKlbOZhnzCrydk?=
 =?us-ascii?Q?rDpDAwGzae5aEHbhZQ4g8Z3qSi/tjT7A17VBihVtMY9bh7sG/s1d20Y+55tH?=
 =?us-ascii?Q?pOQRNrXvywT14FEVDYnzplVp+/Mm8vWJlsOgWtcLdYWzMw233eZPERHUsi7p?=
 =?us-ascii?Q?QcaNJCaXsEcHRjITgU8IX+zS/OdcntA8LOxNWDodRhWChK6bxN5sIOhoZcqJ?=
 =?us-ascii?Q?o5CVf3MXXV2aCNTHjaX40K1V2xpS6BlJN7EyB0qTeNaGWBcjwmDY30eI0WI9?=
 =?us-ascii?Q?KNNZI2yHgrqOnUlXpdOF7tccnGwzyuVTxZcT5gZEXBXMujGpz6CJmG4RGSwt?=
 =?us-ascii?Q?rZZY1aUPTfyyCkj7eYnfoBedYhVPCd4MOT290g+6TSPNgKNek8ZObOrZcWyL?=
 =?us-ascii?Q?0gP4gwpYO1zX/p9h9E8kbxJG2knyQaAvF88+YYrRgQyDeZHNIXYRnKyW3wOh?=
 =?us-ascii?Q?CSfKQb1tOIk5tJTaGsC5r7WueLWtf5zH6bA+mYSSFb/I7zI/pcnaKzTPzRZl?=
 =?us-ascii?Q?npNNV6fCgExmRRFfbDfiM3Z4VusHuEJEcCi9nQhLV3Va4SSMiSiRbULRw6Uo?=
 =?us-ascii?Q?345gUF9JngcHbo+53uS8Lqfbw8hadn45QKU5m5kcXMnYg8yt/LDu6m47w/Cx?=
 =?us-ascii?Q?lwV/07MvQuhOgA4vyC1baQu5gLrJXUaDkLn7Huq72EQcMZf73UmKxV3ZqlTj?=
 =?us-ascii?Q?YVRrqITJpNtP0SBB6ocOhrF7LSAbzbkiPu6QzhHmi4etbcklNakMMhfxyDGX?=
 =?us-ascii?Q?SmWRZyRBFvMUi6Tv3FdzlavCq4GX+eyuxVukHNm9of34A1hYvM/Ff9Fti32n?=
 =?us-ascii?Q?U5oU9pLISP/GZtm4GPhff4tniutlv4LW1HgA4XluNOETAmnqvz2UCEMmMcNP?=
 =?us-ascii?Q?wECYXdvBPbMQ1bJU8xm6S349h4ClceZMqQFkd0f++q/HILN/7vvk+cnD/Xb/?=
 =?us-ascii?Q?1NNSdA4sGyhgevu0IEPqBuPtOiW82oiJI7guz4TiGWphMwekOvx49CBAmOnb?=
 =?us-ascii?Q?/kFzYq64UA2wj6YR2n3q06s+pfiQzj08ixkL51mgzIeZUcEGVgTe4ylcMOUy?=
 =?us-ascii?Q?n+gvYmirTsxfLV3GUsaKPWbw0mOkqfKXp0evqx9fmlzGYqbiTFzcyHG5p/ki?=
 =?us-ascii?Q?tx6MyAevLIHsHcAPRwxDR7N0OFbRvuH8kOAXJSe35c6z5ef4NKT/xrBtPoWn?=
 =?us-ascii?Q?NDgjlQASyavjcXM5Zgs/nO/hPOKFxxlDN2g9Ino4T/K1rWKiek/ipNNmmxsI?=
 =?us-ascii?Q?oNU5jyGvaL5CyTtExgWDECj7Aujv5+oSe3AYceOoPzm740lJFcAyVm5J5uic?=
 =?us-ascii?Q?BKKtG2I/cbMXd4f5nWxC74i/MpGByorQGXMSffwBJ+vR7hE+HhYa2HayGe58?=
 =?us-ascii?Q?2rFajg9KbUv7pLIivpKokYya7pSvgsxcNmRl+7qus85gW3ibtoGwcVSnsQrZ?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7184e47-21c4-4f07-20b1-08dc7febe75a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:30:35.7335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvuiulVwVv3OeyNNeYsuTqIw6+ISUfh4Qc/Xg2R/oGOuf/dDiNMTpOx/EMWRtVekdCylu2icJ7gxx+jhlIZULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7621

On Tue, May 28, 2024 at 04:15:42PM +0100, Russell King (Oracle) wrote:
> Convert felix to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Back in the thread for the previous posting
> https://lore.kernel.org/r/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk
> it was identified that two other sub-drivers also needed an update,
> and through that identical code in each was identified. In the
> final message of the sub-thread from Vladimir, Vladimir volunteered
> to pick this up and I agreed. However, I haven't seen anything yet.
> I guess Vladimir's attention is elsewhere, so I've done the minimal
> fixup for this driver.

Indeed, sorry.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

