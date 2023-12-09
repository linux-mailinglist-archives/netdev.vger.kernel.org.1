Return-Path: <netdev+bounces-55509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913AA80B163
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94542816A3
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4317FB;
	Sat,  9 Dec 2023 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BUZdLoBE"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591EE10F1
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 17:22:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad5NTOHUaeXKNBda52qBe4pZ+ef58ZwEdxc21nyT6dr2BjCeYg7v10e0aAq2uEQsJ3Q2woJtLwR4OatQNjcCGGrcnK5uVtFZNiy2Do/if9/WB4L2+LzDrtKvUfU6Feo5Qvx4JpmR4o/spNj/ko/tMl2WqLr9D9dIPGrEmshRx63V22A2k3VwjNBrAjguoNDRRVfSPbjpuezdivc7lMrX+9itwHIxZSYAowkG0hsLTsYcDaCbkfF8koGj5FmdPeskp5JtujOeTZzPzo+elrMizhamspnSQNZuDxMIO7yd1QIr9sY994Oj9PTXBBk1jbWvD8tX5zoruH3/RhieW9XbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtalRfWzxV8SdfwSQK8rRQYLkFMzZpEj60+ODFwh1S8=;
 b=HvZJsOESy09POfppwWHRwMvvK922li3Nz4uiiRkUpR0TbWH/bV8msm83KQ6siWb7/EzbQ/MW2txspRuCt0UtZ7CrOqu6tJuIfVTaACo5462SuP7qH3bZqcTUX/xs4k9x+o2JV8TYp73G+BmXtMvHPlrRnyXc98jx+5manRre3mOiB2V10SISwdOY+wMYyTkM5YSwJnrNFDSYdW2EF2OP2O2j7hZLMmeCYRbwGFl88C9sV0rsvBkxscHmydYRk3iD3bIHktyqiVbb7wO8uhxFbLbpcsqjudS1N73wRMaDiLhkHTkXeyg1MJc4pGAcgbyYMbdo1ny56donX60KbKK9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtalRfWzxV8SdfwSQK8rRQYLkFMzZpEj60+ODFwh1S8=;
 b=BUZdLoBERJu5XHcCPVMs3yHGCJXg13HK98fxF9NOlDBwocNht8DIR8FJToImTtqxkRLDbyEuddNKzjbgHfOO3/7zVO6Ahmp0/ay/hFU+fZqMcHkQwsqT2p3O/TsuYBpaxeGOR3CSC8bLz8Yhhs+8DZOC2UC0c7GMLo7eVj0oyLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU0PR04MB9275.eurprd04.prod.outlook.com (2603:10a6:10:356::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Sat, 9 Dec
 2023 01:22:07 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 01:22:07 +0000
Date: Sat, 9 Dec 2023 03:22:02 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Alvin =?utf-8?B?4pS8w6FpcHJhZ2E=?= <alsi@bang-olufsen.dk>,
	Madhuri Sripada <madhuri.sripada@microchip.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net 3/4] docs: net: dsa: update user MDIO bus
 documentation
Message-ID: <20231209012202.tiawvab6qkbxosou@skbuf>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-4-vladimir.oltean@nxp.com>
 <f4e08518-290d-492f-89ea-31fea9974abe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e08518-290d-492f-89ea-31fea9974abe@gmail.com>
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU0PR04MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e8cb3c-2782-467e-a40c-08dbf8554220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IR6unnD2q9NzmXXbwNtHgxGxtOKh/8l0kxYSFBkBI3kbLbuv3j0ZOzIa+2M+FZxb59hLBTi2ViUTMw66BL+QyX/kDe1aBfzu+nYzW2fi/+SyIew1hAnMFz5Xl6UhT10HxwRhVElSRENkO6Xl3axcYD9Kw7xYqjb8nBgAfOgsSnsKQMeDsxRX/uy+RIO8bCraLhOyk+bki9HdPI8W8Blu/JMoQoY7pS2+zBRAWM3RUUrsxRzhNjqPBMtpOePVwrrjBui1dTg56JeqUCLPIlD9xuDOD5z77w1Sg/SkDWjHK1YLh/IOTGfr/RWM/zfYTqqSc34VC6c3VvT+kdTVb79J+qvIanxg5AK1UuqNLa5+r3vrd46siOr3mtHCOz3GfC2PL1TbO840eF6YabpFOsrPGNBxSqR6zB2QAXmDMUzuq0HH0tgBz1mDDr/awyTDSiyTn5nAhTMRNwUBlW4yeB5L8DtLkJqoV3+nuxUBC5ChTynbEHNDghyD20ctM6kVuQc0Ekdgbafnwm1u3sa3AN8YURprQY8kITIUVpoDa738f2R96ZphJr5CsOlzWi2ZZIi2T0rvC+V2mUrLMnQRxJWgypMHAMyYI1LmJHxPi2DGY4L1vcGK9YtGujkMvbxLIRre
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(316002)(5660300002)(7416002)(2906002)(478600001)(6486002)(83380400001)(33716001)(8936002)(6666004)(38100700002)(8676002)(86362001)(4326008)(44832011)(54906003)(66946007)(66476007)(6916009)(66556008)(53546011)(9686003)(6506007)(6512007)(1076003)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F2BgVHMA+K/iMKWxpY8lVIthRnVYaNU0NRszmY9wMTNF3zD3RZViQX+GDRsI?=
 =?us-ascii?Q?F8zRJpbB9S/XLADmWQnbKSNfU8OAtoANa+st6rSxG0dRAZyoeLexqQnJjOmw?=
 =?us-ascii?Q?SkRvjc8xUFmc4z2ak53z76cUAqSqMOKbi6sxMfXud7rVQxY7TKlND51QKJTv?=
 =?us-ascii?Q?Amz8O4t+P1pCNRKPtVwE6v2xnZh3AfdoYgdmSEjGjWKpTL4ohF5UF1u0LxQ9?=
 =?us-ascii?Q?Vxzhe8w8L/Fwz1lVvNCvCeMtIrnkPt2BirTFIb/1e5gIOpMoEmfnI14II7e8?=
 =?us-ascii?Q?WC4Rc79rVlwBrsRaYNX5Snv9uK3oUhfwwxfprzkgc500qysO97h9oFYgkXpq?=
 =?us-ascii?Q?3mAN5WSbkjICgH81k1ni3gq2LHEsJlGyrDsUxXNJpgd2ovDcFPCh74boAMOW?=
 =?us-ascii?Q?gcWVfMPby2aps1vUUfaZWKXUVyUombJyYlmqqulZMjHymojzcIbb4Y82DPyM?=
 =?us-ascii?Q?6uN8PYGG9vSEXgyVO0PKxMAReoFSYClPZtbML6Xy99gg97CC/QawXJoBhaag?=
 =?us-ascii?Q?DES4/PeijOAjnacXQhknjrQRzWDdsKuG4mZqXnQhzrGXOOGwiKiWGd85TL1e?=
 =?us-ascii?Q?YkgaNfX3YxXkCuFjLJj3OKv1pRqTamTAI/hMUvPXGHUqykL0bA9x6WthYm2x?=
 =?us-ascii?Q?wTombBMVorLsMDC1bCI6A9BgZBqPVH5NvaEwj7QkFl2ZPfCAXSuu6UOdelJH?=
 =?us-ascii?Q?XBXo9aqLE1Av9Yefz2AljbWkEBy+qWHD9gRGnk5W31gt1xSi4Wydo7blqnOR?=
 =?us-ascii?Q?BAK+bAct+gtGQqwdW4PZOCq05WUo3mvWSmxSeGkWJa4NSGNPpfXLMxpiBYjK?=
 =?us-ascii?Q?/2HXEjFpBODMDq5f0fPICJdqidl45qm8jlbqCVEgvHXu6ptzTHitTKjlEqLu?=
 =?us-ascii?Q?tjclSlOkKxjFfkNmdKqhbxJAegZ1L49G5f2/MLOHJLLuAv26NMKts2xCwxn+?=
 =?us-ascii?Q?0VQ7j4OQMbVHKJ9LWm3eJqbahwMDOVFUH1d4XNM5lb2FrW9XZAcpp2ETl3hD?=
 =?us-ascii?Q?daFqg/GVtp1jd3vVsTknQeGWpz9EX8lEC7Y2zRzCYzb2ngBLK+3N7T2O5+mq?=
 =?us-ascii?Q?uer2zFHARvTJkTdcp2/8fxnt6bJuqGrEzfQPzKlrGu4+DkqMo1gJIDp0+CJK?=
 =?us-ascii?Q?Ja5Xmibv+DS2Rm+St6Xvf9/2HTDKjrO1SzNG0q9X+siyKJfF5Xi5O/qbhxF3?=
 =?us-ascii?Q?HN1Rq1AJ3FocJiOevLM3cVr/OlB2VMxy7xbNl7+hf5dPLkZwKdm3dmFfEPRH?=
 =?us-ascii?Q?3DSAb6DxQXq/n4S6BckVcYp+nO+CvrlMZSmXUCgzHoixXuotk+NG5E+rSuZn?=
 =?us-ascii?Q?bJP4ZiDJRVUqkL3cqwBljf+ndcR5WF9RyAD1eflk+MLaW0TiIbegVgl4BYM5?=
 =?us-ascii?Q?g1+qdPYUlcSXbKhp9QD8AhX6DzhzjAq3U/0maSSmpo+r0R/aahYm3B1zJ0HA?=
 =?us-ascii?Q?anu8LPmUTAtUXSyqZkNAJgqfdObmvtSSsOZJzCZy/CasSv3RXbeJTqTBiBbj?=
 =?us-ascii?Q?P7atKmmaCNZdJNRdZfRNAjbsjj9Y/ZwPBZO7qEaymMu67XJdB8wVseUFKkKq?=
 =?us-ascii?Q?ih/EuZkqKndaCxH3XXtcPCJlbSSWzu7XPxEOHeZVs2PoVi3vKKsYBgiWpy6S?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e8cb3c-2782-467e-a40c-08dbf8554220
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 01:22:07.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcA2qwGqIktYq0Uex1iGcgh8b9/Yev+NZsX7/fNz3ffOMG9qEW1YYw9qi9cCr3MQ6WgEhSVtTtrh5z/W3FQiLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9275

On Fri, Dec 08, 2023 at 02:36:40PM -0800, Florian Fainelli wrote:
> On 12/8/23 11:35, Vladimir Oltean wrote:
> > diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
> > index 676c92136a0e..2cd91358421e 100644
> > --- a/Documentation/networking/dsa/dsa.rst
> > +++ b/Documentation/networking/dsa/dsa.rst
> > @@ -397,19 +397,41 @@ perspective::
> >   User MDIO bus
> >   -------------
> > -In order to be able to read to/from a switch PHY built into it, DSA creates an
> > -user MDIO bus which allows a specific switch driver to divert and intercept
> > -MDIO reads/writes towards specific PHY addresses. In most MDIO-connected
> > -switches, these functions would utilize direct or indirect PHY addressing mode
> > -to return standard MII registers from the switch builtin PHYs, allowing the PHY
> > -library and/or to return link status, link partner pages, auto-negotiation
> > -results, etc.
> > +The framework creates an MDIO bus for user ports (``ds->user_mii_bus``) when
> > +both methods ``ds->ops->phy_read()`` and ``ds->ops->phy_write()`` are present.
> > +However, this pointer may also be populated by the switch driver during the
> > +``ds->ops->setup()`` method, with an MDIO bus managed by the driver.
> > +
> > +Its role is to permit user ports to connect to a PHY (usually internal) when
> > +the more general ``phy-handle`` property is unavailable (either because the
> > +MDIO bus is missing from the OF description, or because probing uses
> > +``platform_data``).
> > +
> > +In most MDIO-connected switches, these functions would utilize direct or
> > +indirect PHY addressing mode to return standard MII registers from the switch
> > +builtin PHYs, allowing the PHY library and/or to return link status, link
> > +partner pages, auto-negotiation results, etc.
> 
> The "and/or" did not read really well with the reset of the sentence, maybe
> just drop those two words?

Fun fact, this is the second sentence from the existing text, moved
as-is a bit further down. Git blame on it says:
77760e94928f ("Documentation: networking: add a DSA document")

I do have the slight feeling that the paragraph is pitching sliced
bread (sorry). I did want to remove it completely, but I also wanted to
preserve a phrase about the direct/indirect thing.

How about replacing it with this?

Typically, the user MDIO bus accesses internal PHYs indirectly, by
reading and writing to the MDIO controller registers located in the
switch address space. Sometimes, especially if the switch is controlled
over MDIO by the host, its internal PHYs may also be accessible on the
same MDIO bus as the switch IP, but at a different MDIO address. In that
case, a direct access method for the internal PHYs is to implement the
MDIO access operations as diversions towards the parent MDIO bus of the
switch, at different MDIO addresses.

Conceivably, the direct access method could be extended to also target
external PHYs situated on the same MDIO bus as the switch, or on a
different MDIO bus entirely, referenced through ``platform_data``.

