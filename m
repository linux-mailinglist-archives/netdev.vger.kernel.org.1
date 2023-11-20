Return-Path: <netdev+bounces-49268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC91B7F1599
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B20EB21791
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 14:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5BF1C68F;
	Mon, 20 Nov 2023 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VIyvLhG2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF60ED;
	Mon, 20 Nov 2023 06:23:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTbRu9DXMDB5w+dTFQttsrAYUVLjEJ922Re3zQxIiZAmLoIFbusOHplmUrYYmtye6kdNTNA6GMBhL4PGrpe/UeZrhldzjdHAwlUBPZHMoMMgy1HUmyrPAq0rvu5jwFBydiXcKDbRHJzvlSG99vpGwQqUXWF0cgzaFphB9rUpAVLjBi0rUlUSA3F5kQQMLBGZGmWZZwWghN6pHyYd1y7JomNeZz+MMcwaEpFcI7Q/m+LCjPaf7J3r9cRw14/iSsWk5lJOi2HAcdVaCLSTktI3XgYl36oVGuzF4s7RtZIKA/WuxzGZnEfw0Xpn7JU5SXP2XDmqP077CqUCo4DQY5HROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Rp6BhjePW4n7yLGOUpJXrOov3HVfU9u50Aa9xjNaw=;
 b=BoDzLw5E2GopaedvGSdAL4UAxKpRB+lCgfvW4Q4EcDAUhnugl9MMtX0tYSkFAJElTLD5hkQm9bhrecJ4/3t0GbOn8fRDX05u2sgv6HFXy9CLlYbGq1MGq2herio/ZoJ8jCLFxXubZdXhJgrI/cRZ0cwxDSAO0zkBR1vse9ZsYcsnVroSecCbc0pDoey/VdWWzs9O5qK+0sioNsBbwOQ0QAivmNk9fYh6ykkQQy0qJgTEbwQZytsGZ9xDpFHh5A6qYlL2694sUCjIR8gol40iFL143jQBlPGVlyvtNQf3JxUSziP8QxuYRMvDjnTcQsy2EXUuj20vc67Y0GyJ70Jo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9Rp6BhjePW4n7yLGOUpJXrOov3HVfU9u50Aa9xjNaw=;
 b=VIyvLhG2CgWyhGs12SXBGl4sgdRzAeuPD9Vf96/DpTfjfrTOSt+F6af+cSIGNTd5b608MlWKVjvRClDTrOkxfqbaW7WyNovg9N8DGWh6wF/MuDKpGEIOKndCYgsqrS+O4Bf6lwloMK7Q48yD6VYe0vdVG50DMS8w1vV+qVPBF1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PR3PR04MB7468.eurprd04.prod.outlook.com (2603:10a6:102:8d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 14:23:20 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 14:23:20 +0000
Date: Mon, 20 Nov 2023 16:23:16 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231120142316.d2emoaqeej2pg4s3@skbuf>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
 <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
 <20231118183433.30ca1d1a@kernel.org>
 <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
 <20231120105255.cgbart5amkg4efaz@skbuf>
 <20231120121440.3274d44c@kmaincent-XPS-13-7390>
 <20231120120601.ondrhbkqpnaozl2q@skbuf>
 <20231120144929.3375317e@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120144929.3375317e@kmaincent-XPS-13-7390>
X-ClientProxiedBy: AS4PR09CA0001.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::7) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PR3PR04MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 824bc22b-a8a1-467f-2997-08dbe9d43f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s77GlYJDL4Huga4N5iMx7G/kNieA4sFCH38zrxbSlX6svEwqiAHISjFLcvOZ/Y5Q0ssb9X0jQhCOZPcXco2OMZBnSPVDI1UsiLnHi81DTfquM+O1L/kF+/feUC2wCTouc40mKL2cA/WqlJCcDJ3sjpHKQ/ctsY9n6BVyT3k5pmIT5INvg1qBG4s3B+kT0kzTHft5nRxsluc6J9KYQ9Q/wor1H/kTv5CQ5a6rSK5pAZxB+N59JwyjB28g61J9qUSj/4xa2OKrkVY1pzP/7W6h6VC8QVnPxqJG+b1di5v1TcsQBt/mS+lfAb2DgYTyxPgDFM0sxSi8cwgF1+olhauMuRjQezQDrMQZAnP5/mhtGPw1zftaFuTdQ2mDQR9N/vbQD0RlwUIOS9W03C9U9VeyVQoHiR9M2EjiIgyJVOl4ebLTf5BD7Tm6ev5ZAPcM1DQ4oUdL2C19c7UpwvzQZjOMqF+7L4zSBbWWWaG4U5D4oE3jVmEsZrRpWFJh16IUHhpq2G6tKnaMNNqnnjCnCo9jCsXgh19m9NmylVM+qYXOrFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(54906003)(66476007)(66556008)(316002)(6916009)(6506007)(66946007)(6486002)(478600001)(966005)(6666004)(9686003)(6512007)(38100700002)(26005)(2906002)(8676002)(8936002)(4326008)(5660300002)(1076003)(7416002)(83380400001)(41300700001)(44832011)(66899024)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?zgMjhw2lzm6ArnZ2G9jsIltBL0VRyB7Fk+Qx/TCK4PCSt6Nl6y98ibZOBK?=
 =?iso-8859-1?Q?bsuBtrrVsq5nFopoFAGar9hAd3vjCazVchgg/PFWOKU0sgLe4ciMzRY230?=
 =?iso-8859-1?Q?tznvCiB9J6v9Br2l+VDdZCOaNULEoi4/J8OCnq1kRHwvVxOXO7Eb0dr31B?=
 =?iso-8859-1?Q?M+b33i3lC0MYjj7fnZbdmuKWpvdcCGeoUq6+0Pr5GZgwEBvgAxj3ziIKKD?=
 =?iso-8859-1?Q?p2NbgNRrOH5+WYpeWR5/SYwrYiIvAwnERUCdEPmQ35jYHy52ydB0pjkGFe?=
 =?iso-8859-1?Q?vCV3qzBCXSwNN61WzfgMWojBqCNCGIO68knwBsljhhO5srirRNmjCgVOl3?=
 =?iso-8859-1?Q?BXr/t/fsbRola9vXcpc+x4Nx/FJYU+y6aDxf0OTDzeEAxk8Gw9fypT1Ef0?=
 =?iso-8859-1?Q?CEj//YTE+8woMVRghMIysjkrPa5LVTkEHn4y6DV/EnymvwNWkba9Gv7pY7?=
 =?iso-8859-1?Q?zEsI+0+0QP570gdaKv9AosDyu3Znmksa3tYq8u8s0eQDnPWctEs/pwwgf/?=
 =?iso-8859-1?Q?EXMZAZKh3/DTaCpLw+Z1N5OqNuSGsFCmguTJmDM0Sy7AoP2KfOjV5oPB4M?=
 =?iso-8859-1?Q?fJ6E5Vb1ARvPtbQawbdcWUpU/J0HrugalpokvAdOrLQT5hUwVdyAzNezgZ?=
 =?iso-8859-1?Q?SwObbbro2885ASEiYLSlDZtrsmatB80PbQ8J6yz3k7fvDauU8q4lMHMUtW?=
 =?iso-8859-1?Q?UNwI3bHg5tGFNU0BmQfSDa+G5+so3JRANnxhglhijIuMAPOCwLQFbx6WBF?=
 =?iso-8859-1?Q?0kN25FPHZTvhPqyweoJvdY3Tmtd+VnK2qxpEpQ6/ytFY3/CsT4VpV/2oJ/?=
 =?iso-8859-1?Q?Rwnb+oU1Gg3fGbkBRfALyptAf1K1bSfi0jNdoq4q0AJRJ2W1TShAzc0giZ?=
 =?iso-8859-1?Q?PsDutSI8fmxFeafj7yaZum7v13Cx4l5t4jh37YH7ZhVKTWAqVilZZn2mOu?=
 =?iso-8859-1?Q?CARo4Hvzx/VzTzbM0iBkd3XNEI1QurO1Wwc0iJo7fGLlS9ccq+argxgwU7?=
 =?iso-8859-1?Q?WKzHfA0iuIG48QkBdbzXmF+pWAB3UNw0t0ikU+l/GWq0dcYW1IFhFGMW4C?=
 =?iso-8859-1?Q?Cz29gcLtXCWHcCSrlTPbMFUBVfiG3Qsd10MZtmYxrd5xn+8k+b9SgE4uaI?=
 =?iso-8859-1?Q?9U332RvUGEsfzVetBmHBq0IF+P1osaKMZzcJVNbrGpu+KOIaX3O0ZJGeVZ?=
 =?iso-8859-1?Q?Y+ZzEwM4p0sdCGxeefSrOeidVCwv5A9VotCqAiRftCGmNKkWFWHDFbrwbO?=
 =?iso-8859-1?Q?TtlERwlza4tMQaTrJaxGnx2Axky7CRnSJW4J5qmMAQoa4uTVOWasez6TRF?=
 =?iso-8859-1?Q?zTb21crfl29GO6eq7MgmpY5j1nZjpBSFrC2y3GWOyxbrSyHD8DT9yTdaDb?=
 =?iso-8859-1?Q?UsjFoSNMwp0/OxLocHfYB5UCyeqpYhhZtZZaCL7s0qbsbeCGAI+m/S4dH8?=
 =?iso-8859-1?Q?8JZONwz2fs0QkGro60daO6YbIx+ftzMqxhYgrTP+J0j0/CNT6KSWtwIBwm?=
 =?iso-8859-1?Q?/c39aghbvfEjvVNEGwbeu09H9dQdlJGiGJvJXcBE1dG9hpgUyg9bROjUs5?=
 =?iso-8859-1?Q?I9L6tpbky5M6iDu14mJqiDfYiRBshVs/fkQqR3avpHmV+THIL6BOkmVN8S?=
 =?iso-8859-1?Q?xeJnBuxmg3GqzdgwBdCS+0dcR6B3336Jd0f78ewxfn278eZjjdEbRpkQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824bc22b-a8a1-467f-2997-08dbe9d43f03
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:23:20.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZCCV/GGihoRzApZNS4EJHFeroKCeQ/9wDPRVCc0JRdy8HUQbINd4ZqKesBIr+6UQTW/dgPDNi52Xx8QFGIs/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7468

On Mon, Nov 20, 2023 at 02:49:29PM +0100, Köry Maincent wrote:
> > The next question would be: if a driver performs PHY management in
> > firmware, and does not use phylib, how should user space interact with it?
> > What timestamping layer and upon what should the ID be chosen?
> 
> In that case it could be the second options I refereed to.
> Using the id to select the right timestamp within the NIC driver.
> It indeed won't be called PHY timestamping as it is managed by the NIC firmware
> but as it is managed by only one firmware and driver using the id to separate
> the available timestamp seems a good idea.
> 
> Another solution would be to create another value in the layer enumeration.
> PHY_NIC_TIMESTAMPING? Better idea? I am not good at naming.

The point I was trying to make is that your current choice of exposing
PHY_TIMESTAMPING in UAPI, when it really only refers to phylib PHYs,
would lead exactly to this sort of UAPI balkanization where everyone
wants to add more timestamping layers, and to define IDs to be specific
to their own invented layer. Maybe the concept of timestamping layers is
not what user space should see at all.

In previous email discussions, I was proposing to Jakub and you "what if
we didn't let user space select a specific layer like PHY_TIMESTAMPING
or MAC_TIMESTAMPING at all, but just select a specific phc_index as the
provider of hardware timestamps"?

The limitation we're trying to lift is that currently, there can be only
a single provider of hardware timestamps. We make that provider customizable.
There is already a good understanding from user space that, if "ethtool -T"
on an interface says there is no PHC, then there are going to be no
hardware timestamps. So I thought it would be much more intuitive if the
timestamping layer could be selected by the user merely by an unified
phc_index (provided by a phylib phy or firmware based driver or whatever),
and everything else would just be an implementation detail of the kernel.
No one should care that it's a phylib phy, and shouldn't use a different
procedure to identify its ID based on whether it's a phylib or firmware
PHY.

It's a bit hard to align my expectation of what this series should offer
with yours. I think we're talking past each other, which unfortunately
makes me lose track and interest. I wish you could have answered my
earlier question about this alternative proposal.
https://lore.kernel.org/netdev/20231013170903.p3ycicebnfrsmoks@skbuf/

> > Finally (and unrelated to the question above), why is SOFTWARE_TIMESTAMPING
> > even a layer exposed in the UAPI? My understanding of this patch set is
> > that it is meant to select the source of hardware timestamps that are
> > given to a socket. What gap in the UAPI does the introduction of a
> > SOFTWARE_TIMESTAMPING hwtstamping layer cover?
> 
> As I explained to Jakub:
> The software timestamping comes from the MAC driver capabilities and I decided
> to separate software and MAC timestamping.

Why? What was the problem? This confuses me because I don't understand
what is the problem that the solution is trying to address, and whether
the solution is orthogonal to all the other UAPI that exists for
software and hardware timestamping at the socket layer - which AFAIK can
happily coexist.

> If we select PHY timestamping we can't use software timestamping and
> for an user, selecting the MAC as timestamping seems not logical to
> use software timestamping (I got confused myself when I first dig into
> it long time ago). Be able to select directly Software timestamping
> seems appropriate and won't bring any harm. What do you think?

Hmm, can you please explain what is the reason why software timestamping
can't coexist with PHY timestamping? It is a genuine question to which I
don't have an answer - I haven't used PHY timestamping. It must be
something specific to that, since I do know that MAC + software
timestamping work simultaneously just fine.

