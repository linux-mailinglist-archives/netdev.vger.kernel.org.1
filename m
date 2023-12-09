Return-Path: <netdev+bounces-55519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD7B80B19E
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 02:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4BE281937
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A9810;
	Sat,  9 Dec 2023 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F7ZhoKms"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3410DA
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 17:58:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSJr+lQqb2vPbU+L5xC/H91TRsSojf6dQ8L+0tJMPvSzMoAInv3/g/CUkzHBFrv/y7jkm0fLZpdqM98muHSm19a3e6VXZG+tfU8DKix/MwR4Gtj1il/+VtLY7KNcfizEqZXTA3/3wj5lEk5NxA5ns9nlRo8WcJ2aCH37oqDoF/E7R3yMutgf0QFHN4U/AaXghDbljlAqIoOsYIHsPdMUb/7+VR+xa1ajCfMtq54lId1UieS9fRfPTz1+kAipxOCSqzTcUG2ddBV6jGen/HJzJm0/guRUL3Mr5ugliCzC0bgOgZw+aZCNo+ZUnXtn81saCMsBbSf9IcZPYFM+4KRC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S92HJ/4aeTioqfgxTjlnKb27MghMMZmbl2mUKVcxTjo=;
 b=Y9JaOn5+nowz6Seu9dTmkHXRHQkhgYGIGnlOflbdsN18E6ubqPWmU2RiqSPJtQ3CsU9ChCL/CCKumDnwyIA3VFPZVVvQUHzG51jQik/e4Lwxl78BfUKZnWeNHesGqvMaN8g7/gks3UZ3Iw3zR88vNk1jUoaRJQJ5MHHw0mZjyj/C4XdBL7p1vtXB0yApVXdm9AukzMH/gkOBD57dQhKI9vmcesd5GaL9uAaX8WpPAsTjGaYn+ObmBklswAkVohSESEQ0kfbjNWVE1RI8NVBYhM2tsF3AfWy9CVzso9df4FPKPN5wDYr+6Fq5oaw6gtvLYklWkc3X9Yc70Y7WhNsinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S92HJ/4aeTioqfgxTjlnKb27MghMMZmbl2mUKVcxTjo=;
 b=F7ZhoKmszoFKw46HliNhvSw4hBEyKcdkE+yaFYyvACKJwFlJArf041viDu/c9wErFd0jgQ01+zDhcxFe8IIEAWZNdhTFwkZTw+mVxOFdLrx7YevY3Dmk5BxXqI8S7dlN7dxHwKXBLzuU6fvypnY7NO0rAYPJu05AJp4MJQBsCgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8324.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 01:58:09 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 01:58:09 +0000
Date: Sat, 9 Dec 2023 03:58:05 +0200
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
Subject: Re: [PATCH net 4/4] docs: net: dsa: replace TODO section with info
 about history and devel ideas
Message-ID: <20231209015805.zilrf5wrtlccixyw@skbuf>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-5-vladimir.oltean@nxp.com>
 <2b4f6a45-2af2-482b-b8f5-f2bece824912@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4f6a45-2af2-482b-b8f5-f2bece824912@gmail.com>
X-ClientProxiedBy: FR4P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf6268b-0e6c-4c9e-ffbf-08dbf85a4b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vIeItF0PMqB1EpvwkBBqmwi/RaKR3vHwuVAaeIZi+G3PAeN2F/0Mxhxz+E8bTXTEVSCT7qa2BMd00F0dWlMk6PNhTA9fdZczCJDCBryLZctZti2FQjtPOA3P05pqu+v0xPivBsk3lmd1tlRAWyxmBU2EK42+EqqVy1gV7Np2zrVwf03PmCCMXtCZRkOEn19+lPW2DVFlyxeVs6+plbLGH8Qe62VzVykzlAHSMkZlBN3Rcfc/E2qZHjEVrSI0Ca+d0yvfzhShxH8/aI6dYMBUmCa+tFl8ao/xAp+XI0xg2pbVOH50oAix3oESd3pBNRRYTJ2MurA/Gy5v3pimEOuUQs2OtuycWTBlKD+Kv8cy+OZVnvXuBmkhg29TG8JREfCrcYo111stdXVu31UFP6M8eIc4t5YBfvvf8Lq/UHfB6oMfIJUW74PBGx45YSh7kQ9ka9r4sxp5q6dz3p7LFD3EyWd+vbRkr6d14LN3G3C3sdLKW6qxzhjhJoxPnxzufeHhGqxe7LR27fNAOm+tOsQ92psyIfZ3GeANWvsKz5Zy4nt+P0FpeCC+Y0gyKVXfgXKd6KWvk8AQSBBgsARYGXLITnKFP5YPAS67QJmqZEMtZG/Yb3TKWfHmtUILQFF29ezM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(66899024)(66946007)(66556008)(54906003)(6916009)(38100700002)(66476007)(86362001)(83380400001)(26005)(9686003)(6512007)(1076003)(6506007)(7416002)(2906002)(316002)(33716001)(6666004)(6486002)(478600001)(4326008)(8676002)(8936002)(44832011)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lpaKlCrQ3LgORmIMvnleUwAiQYSeWq1omR8jBSYZmlSpcC8KZ0AvLkDkX/DD?=
 =?us-ascii?Q?rVERja6rfapIh+cNPJ23pOk9SXZeiPbz2q0C0VENmECGuqo09PNC+Ikzqlq8?=
 =?us-ascii?Q?qfF6pLFVqThVyNOC1AYHTwD4Y2OKBr2P5Z/Cy7ZACQM7efrWiUXCH5QAU8ek?=
 =?us-ascii?Q?YOZCkYN/XvjjROk6PSQ1ktFrsJZYWM0X+uwJwsExbf39GNuC2wvkT0NYxw7z?=
 =?us-ascii?Q?Jy4R1ojvWAozOttpcPdrg/oL+6uG7tjWOy1ihWAnZrMNmj+REZZUsEcTlqs3?=
 =?us-ascii?Q?5Te1pUR+GkFjcgjx6g9rzIkEAeo02hnsaQuVrCPLrF9PBA52XdF2Vw1Pb+OO?=
 =?us-ascii?Q?YVWOd0u2rrP6divgJRBpuq58BJUch8vO+Ep0x4HRH+KJn6pSTPWr4rb6CbOG?=
 =?us-ascii?Q?KKre9odgDMJ0pnlZb2rlR8iGEVCa1zjU0Cwak50/7fWi9wa8xKOMLtHRFzbr?=
 =?us-ascii?Q?e3+k1jztbuZm6VkTqfPGWMOmRxS9c8z5fUdU38sgIfQVgEYeeBJoPUp9BR3a?=
 =?us-ascii?Q?b6rRa8NbNKBzO/bstnY4lhlP5Fbb7CxdcL1ENpBCZnSyrjHKke+1Q327CGEK?=
 =?us-ascii?Q?uX83Q7G9WKQNsCQroU5W+7ihuVSKjPd+gCXItRP22y4YlLVqonzybe5lon+y?=
 =?us-ascii?Q?IbFJn9GVxW0LmQ6nuBO8wRBPVOfBxlE8hlD1YBBSGV8LJVjdAQzVAKnVWNc6?=
 =?us-ascii?Q?dHbzsNkYSPkEKl1V6at2PUsOhG3MCo3kCZt3rYlHm5s396GXjCaOhnZDVw9U?=
 =?us-ascii?Q?Jlk8ZfTxiSA/CeP/JR+PiMGzzlD3M8u/6zSCsLZ62HXgNYdhQ9P636oGxnTG?=
 =?us-ascii?Q?AvdGxr21Wa7aW2NukS3GAIegzEpVH6j9t0Zr7UxiIcNJidpQaUDQsvSHvbEo?=
 =?us-ascii?Q?tVBBbdK0jgKAPg+9w0vIayJ1Wp7WAE5YvmMvAAtT9eef1wzmOHgm2XbCqX8T?=
 =?us-ascii?Q?7YceFU2AXJtFg6Lj7Xd0lo9XbEdyCH6r/rdeexqzjxs7OI/2mAnmW5ssLuob?=
 =?us-ascii?Q?c2N2ZBxH+kKbGLcfsXzbR2oz8DuPkCerAe6fSTUujtPXnSMRKNrfottXtUrP?=
 =?us-ascii?Q?/ZWgP8WVhr8CQhugssHbBKfZ+EPaEcZKnfQKu/CgNc38KZorAbN4fpFx6hML?=
 =?us-ascii?Q?tKeTixsnCZW2mvJL5soDUOudgm4E8w2QpPgHKeVTaNQwLsRxpl2kn1kDxoMW?=
 =?us-ascii?Q?QHpbIwK+7WjBjNXbx9vKRcjSQADj5deaBZssEp7d0EPZkhhGLsYNkkbZsDD2?=
 =?us-ascii?Q?aZdleCTYMqxXqWkSTjyKxZgWK03f6azysvMxOsv6RviQUD3nmIIl7Pvx53ty?=
 =?us-ascii?Q?YTEsaanRQYknIoxwph5bzGuiMuM9rBnTnYNgv9BRG0DKkSbgcfpHuvKOTGHN?=
 =?us-ascii?Q?Q6VwynkLfWFcbLx//6MLxRVR/T7Yfl3ytMKDT7x5RvHmFLzdPNw7zS4bvxzs?=
 =?us-ascii?Q?QHr0HOhVD191FUn5+1t+Kk4LXYYLiYwGu0+Wt14mOH8dW8jgd8L3r9PPLVvv?=
 =?us-ascii?Q?tteexNeKrihHHbKpJkrSga6iU+uLG+D6hr2QD/xhKj5HFynYovvc3X7duVjP?=
 =?us-ascii?Q?zZAhq1o8intxFYWpkbWmiMIAG5NCbD3PxJK12ziAR3bB+/pjAWuaZEplRaFL?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf6268b-0e6c-4c9e-ffbf-08dbf85a4b25
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 01:58:09.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0MFVbfcp8jSG/5QyTQ2flfRFOPunafBs52eCWuZLGdRkqEn70MayrOOt8vAyNFyRxzEEzbaQGDiNyovPHJcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8324

On Fri, Dec 08, 2023 at 03:03:35PM -0800, Florian Fainelli wrote:
> > +Probing through ``platform_data`` remains limited in functionality. The
> > +``ds->dev->of_node`` and ``dp->dn`` pointers are NULL, and the OF API calls
> > +made by drivers for discovering more complex setups fall back to the implicit
> > +handling. There is no way to describe multi-chip trees, or switches with
> > +multiple CPU ports. It is always assumed that shared ports are configured by
> > +the driver to the maximum supported link speed (they do not use phylink).
> > +User ports cannot connect to arbitrary PHYs, but are limited to
> > +``ds->user_mii_bus``.
> 
> Maybe a mention here that this implies built-in/internal PHY devices only,
> just as a way to re-iterate the limitation and to echo to the previous
> patch?

I am not fully convinced that saying "user_mii_bus can only access internal PHYs"
only would be correct. This paragraph also exists in the user MDIO bus section:

For Ethernet switches which have both external and internal MDIO buses, the
user MII bus can be utilized to mux/demux MDIO reads and writes towards either
internal or external MDIO devices this switch might be connected to: internal
PHYs, external PHYs, or even external switches.

> > +
> > +Many switch drivers introduced since after DSA's second OF binding were not
> > +designed to support probing through ``platform_data``. Most notably,
> > +``device_get_match_data()`` and ``of_device_get_match_data()`` return NULL with
> > +``platform_data``, so generally, drivers which do not have alternative
> > +mechanisms for this do not support ``platform_data``.
> > +
> > +Extending the ``platform_data`` support implies adding more separate code.
> > +An alternative worth exploring is growing DSA towards the ``fwnode`` API.
> > +However, not the entire OF binding should be generalized to ``fwnode``.
> > +The current bindings must be examined with a critical eye, and the properties
> > +which are no longer considered good practice (like ``label``, because ``udev``
> > +offers this functionality) should first be deprecated in OF, and not migrated
> > +to ``fwnode``.
> > +
> > +With ``fwnode`` support in the DSA framework, the ``fwnode_create_software_node()``
> > +API could be used as an alternative to ``platform_data``, to allow describing
> > +and probing switches on non-OF.
> 
> Might suggest to move the 3 paragraphs towards the end because otherwise it
> might be a distraction for the reader who might think: ah that's it? no more
> technical details!? Looks like Linus made the same suggestion in his review.

I think it needs even more rethinking than that. I now remembered that
we also have a "Design limitations" section where the future work can go.

It's hard to navigate through what is now a 1400 line document and not
get lost.

I'm hoping I could move the documentation of variables and methods that
now sits in "Driver development" into kdoc comments inline with the code,
to reduce the clutter a bit.

But I don't know how to tackle this. Should documentation changes go to
"net" or to "net-next"? I targeted this for "net" as a documentation-only
change set. But if I start adding kdocs, it won't be so clear-cut anymore...

> > +Simplifying the device tree bindings to require a single ``link`` phandle
> > +cannot be done without rethinking the distributed probing scheme. One idea is
> > +to reinstate the switch tree as a platform device, but this time created
> > +dynamically by ``dsa_register_switch()`` if the switch's tree ID is not already
> > +present in the system. The switch tree driver walks the device tree hop by hop,
> > +following the ``link`` references, to discover all the other switches, and to
> > +construct the full routing table. It then uses the component API to register
> > +itself as an aggregate driver, with each of the discovered switches as a
> > +component. When ``dsa_register_switch()`` completes for all component switches,
> > +the tree probing continues and calls ``dsa_tree_setup()``.
> 
> An interesting paragraph, but I am not sure this is such a big pain point
> that we should be spending much description of it, especially since it
> sounds like this is solved, but could be improved, but in the grand scheme
> of things, should we really be spending any time on it?
> 
> Same-vendor cascade configurations are Marvell specific, and different
> vendor cascades require distinct switch trees, therefore do not really fall
> into the cross-chip design anymore. In a nutshell, cross-chip is very very
> niche and limited.

Well, I've been contacted by somebody to help with a custom board with 3
daisy chained SJA1105 switches. He is doing the testing for me, and I'm
waiting for the results to come back. I'm currently waiting for an uprev
to an NXP BSP on top of 5.15 to be finalized, so that patches developed
over net-next are at least barely testable...

If you remember, the SJA1105 has these one-shot management routes which
must be installed over SPI, and they decide where the next transmitted
link-local packet goes.

Well, the driver only supports single-chip trees, as you say, because it
only programs the management route in the targeted switch. With daisy
chained switches, one needs to figure out the actual packet route from
the CPU to the leaf user port, and install a management route for every
switch along that route. Otherwise, intermediary switches won't know
what to do with the packets, and drop them.

The specific request was: "help, PTP doesn't work!"

I did solve the problem, and the documentation paragraphs above are
basically my development notes while examining the existing support
and the way in which it isn't giving me the tools I need.

I do need to send a dt-bindings patch on this topic as well. The fact
that we put all cascade links in the device tree means we don't know
which one represents the direct connection to the neighbor cascade port,
and which one is an indirect connection. We need to bake in an
assumption, like for example "the first element of the 'link' phandle
array is the direct connection". I hope retroactively doing that won't
bother the device tree maintainers too much. If it does, the problem is
intractable.

But I agree, requirements for cross-chip support are rare, and with
SJA1105 I don't even own a board where I can directly test it. I
specifically bought the Turris MOX for that.

> > +To untangle this situation and improve the reliability of the cross-chip
> > +management layer, it is necessary to split the DSA operations into ones which
> > +can fail, and ones which cannot fail. For example, ``port_fdb_add()`` can fail,
> > +whereas ``port_fdb_del()`` cannot. Then, cross-chip operations can take a
> > +fallible function to make forward progress, and an infallible function for
> > +rollback. However, it is unclear what to do in the case of ``change_mtu()``.
> > +It is hard to classify this operation as either fallible or infallible. It is
> > +also unclear how to deal with I/O access errors on the switch's management bus.
> 
> How about something like this:
> 
> I/O access errors occurring during the switch configuration should always be
> logged for debugging but are very unlikely to be recoverable and therefore
> require an investigation into the failure mechanism and root cause or
> possible work around.

Yeah, I suppose.

What do you think, has something like phy_error() been a useful mechanism
for anything? Or just a pain in the rear? Would it be useful to shut
everything down on a bus I/O error, phylib style?

