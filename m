Return-Path: <netdev+bounces-56864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE478110C1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE554B20C51
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B86B28DC6;
	Wed, 13 Dec 2023 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sL/FEI5J"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71430B0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFu1AzpAAQVd3XjY8oT89BCEsYCULkG3igcyN3FkE1rh9/UPbU3bnl38HZHJ9DzD2bPlkQvm5xpIZtQD3LRZLAflzArFj73IsO3PepjEgEJmjuCDDjCBMGaZWoID6Q0Z5UvfxvQs1QZPUXgLbOoNvJXuPQwJ9XHGNslLAjxiFmCu3OZAE6s8vc6qic5Xjy63p2ExKM0dUVq+B2hXWBUM1hv/mWk2Fm0a6qBqZu19WAHLws/y7u+ke0iXiYFQCfWp1z4I8CEUqKqE1SLnde0spNt29x/oO2kJDudygKMoEtRQj/WzJykF0ULykSv1ice7+7X/BU70mpUQN+vyrfYk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f3WxP1HWA8hKjJFNm7bcJOd5Hi04kl8k05lnyLspn4=;
 b=Fh34nBa7K7kuwebHcHz3XByhOMsZtG5+ZeyUIdPgCLlq20DI5sH01Nu3IGGtvsh542QYREIyHnFvatMBJcuRWbxxf/JV9d3DNQ89sXIW17+yxO/DYUaRDl9995v1KLD7Cr0OY7cUbNSbx7BfF2NzTOohPxZxmHhpFX6f21dvs2HlhkJtNLjPbATHQ5SgIMJC68069T3w+Wph2xUbzdqbr96Dds7AiAshi3DbkR0/gvJBEaLC2zpwAGe9Ywb7xgKNev3w8j5i2JdLm7e7r/N4RjRdOZ1yIqZ4Sr3NPJwRWphUSELewGu2/XdqL0xX9cYXqVNHKbizdKxRiIfbtGa9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f3WxP1HWA8hKjJFNm7bcJOd5Hi04kl8k05lnyLspn4=;
 b=sL/FEI5JPLH4sUjRgVqBsYlAgWSys42j/rMkKfc4hyxSn3MumDhZo2stxbeq6yMsnRGbCHFaNvG9nSgd6Nc7Hrl+SH2WEQyK7qah6+mpunF4gFGUF05vXw82dQZuUtSx6ssQDSPUl+GWwI1MYt2aqAxoG0zXR5s4lF2C8NvSfss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB8032.eurprd04.prod.outlook.com (2603:10a6:102:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:07:00 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:06:59 +0000
Date: Wed, 13 Dec 2023 14:06:56 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Alvin =?utf-8?B?4pS8w6FpcHJhZ2E=?= <ALSI@bang-olufsen.dk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Madhuri Sripada <madhuri.sripada@microchip.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net 3/4] docs: net: dsa: update user MDIO bus
 documentation
Message-ID: <20231213120656.x46fyad6ls7sqyzv@skbuf>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-4-vladimir.oltean@nxp.com>
 <r247bmekxv2de7owpoam6kkscel25ugnneebzwsrv3j7u3lud7@ppuwdzwl4zi5>
 <20231211143513.n6ms3dlp6rrcqya6@skbuf>
 <CAJq09z4_dY03AaFm=e4G7PU5LwBegGXmTCTaMp9C=izh7Ycj-g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4_dY03AaFm=e4G7PU5LwBegGXmTCTaMp9C=izh7Ycj-g@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deb78c6-4090-43fc-5979-08dbfbd4027a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+21rFZ0zSXim/X0/bFSOxWyi1HwyR/UMFdrj5xvXunC7Pp1VuWVOeXeYBuZOzozVnbxd+MjHvg7/UzOV5Fvs8vQA/BcS9eq0dAXrdv12voEX3tzaepTZS56D7fRnG+5kx41cCDrDx1sJrCoOtXQzoJSrcw8d7gEPfKdDNW9BlRhX5zBaVZ7bb5d8BSxKhqv01JSyHdfN4vAMkShxI4NpLX9YJoPHXvk1pY/LN0Z/LeTY1aQO9Umrvly1fmw8XZ/JioyVoTlROo2F/W8hUMqa+moB7aBL+SWBAMuyhIxXpUGMxF9smYtvvqMojp2ildpJVu9kLEHEBsihTRpmLV0zGfMsZsgjO7wS5JUdMYVNPVV/h2Fhh1Mrwb+neXN8icSXVW0nwMgPsG+0eSRyQhNFb1KB/Mj/3hwmqA+7zDfNxYH7G9pw849Pb8mdTEZQYYy3xyIY/eBqU+X61jcmFk571Z7tozfoUWDGsv680OitiWc57KWZoiLUfDtrvHCD9IyWdkaizVVoQVqxVJXh5T1xq263PrKaccd/ymhbVAeP3D0dOVbVrCfYFUc52hBYbrrz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66899024)(86362001)(33716001)(41300700001)(38100700002)(44832011)(5660300002)(8676002)(4326008)(8936002)(66946007)(316002)(6916009)(66556008)(66476007)(6512007)(9686003)(26005)(54906003)(1076003)(478600001)(6486002)(6506007)(6666004)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NyiX8FB11nFn9nPnL2lMhJO98pixop4Vxj0y1M+2cGrOWIceyHeJw/JJZbRt?=
 =?us-ascii?Q?d0LNmHRtc0YGi8+aqJ+Xndmm/L/tbmqu0/6g3FAfl3AQCDSXm0H4+P6t+Vqy?=
 =?us-ascii?Q?LGbXPlS8nfOEYzqqjNvKE5xia0urSbC/fExhJ2XHoABD8ju9H8O1yl97jqk5?=
 =?us-ascii?Q?EacaZ+qaDFXIGo3HSg4pXM7TlPpr06VvO/0zQS7iFh0dcWbQP3fNkBKbfwQ5?=
 =?us-ascii?Q?kXyPN9SP8qdPYpfAejOZDdWAKbLyLDhsW5+60R31N7kLYUAcW64+2fk8mLZM?=
 =?us-ascii?Q?XgSj3oqYDMrDH3Nax8Bz0P+pOAX3FRAglHlspjHnZbihf+rk93sFX7OYATGd?=
 =?us-ascii?Q?dTWZV1UqYSzjFXuqwo6YkgAQ/6KDjQySiIXfw1vOcr5eHdP8usUrYX1PNL9e?=
 =?us-ascii?Q?Y9/459sfdBXfgljQuqpZUSRGQe9mY6E6PtK6Agq9TKmRWN6MDAIKpFMZSRDc?=
 =?us-ascii?Q?mBJKP6hdI4/0aqMpyPFyJglr9bWDkWZNfcy5h86hF6bzi0lJ+nkBTHK3Iism?=
 =?us-ascii?Q?WAeWzMxB+Md3vsDDLEZcnyyCoq7FnZYE/oBgEJPO4qjRU5p59DL1TdORxkx7?=
 =?us-ascii?Q?5pkVtQqRDlimZfEdQy5G4r5ky9o+CsxP4VivUQpJEGst01IgBKdVBlOJWylH?=
 =?us-ascii?Q?ixBXYw7N+R5jD3Vq+6B12VEzn+BjSz5ZpxBGcs7fsAiJ6nnFwG74hi1BQ4j0?=
 =?us-ascii?Q?yEITPhJb+mGDMeH1kLeqEz6lGbjCoSohp6mtZvwrOjLybjOJDvpq5qJaR+IQ?=
 =?us-ascii?Q?V1ISxadADPNywH1bX5gy3j8BpQfM5FK9V6g7BeK2ze8gjVbSrU7TvTfB6A5R?=
 =?us-ascii?Q?YFo/MT4T5kuWJiz8bhj7DGNant+VmndIc++HwN/VWRV67NspyCYx1CwLbQ65?=
 =?us-ascii?Q?aiogyFkF/Vp8GhQVYQxx8FrHKDY1uewbJO4hXi1G/Jq8ZbSmuVvhXNRJ+5Ta?=
 =?us-ascii?Q?WkO2wx1L9HMK4Zl4XotIR1OHoBCNFcSlBuhsbioqMZzXiPkjoJI+QBAHv+e6?=
 =?us-ascii?Q?VdurpSZ+kViy6AuSk4/LJIRY6Ax6u7b3BaiHyGuWOVbdre1sne3rfCG8xrPX?=
 =?us-ascii?Q?0uktRitYAh2gnaUh+Znvj0nolOU9crISZhX2U2WhszesdHiSVkFluWHj6EOq?=
 =?us-ascii?Q?mmWfyiIns7IBOrfesGYoWk9ZA9Dez35NRQTB1YXfcqMk+3xhUNk+6Zmn0NsK?=
 =?us-ascii?Q?DJzCS1JF7pVUftEoICtVnsoQ3ioMcRmZCcjPeyVt+jHbo6mGlpYPAn2ioeq4?=
 =?us-ascii?Q?l2riePZLBI1AzH8bWLhNjIk/zE5aEwM2VmvcY121GL0SvLPl35nfILCtcfex?=
 =?us-ascii?Q?GFXHErx4zy3UaLO/JeJcAs+jy2h4+g2iixUUL8S5FVZq2sdpwq5XMUgLkTFa?=
 =?us-ascii?Q?6CZn6uj0B/cRoY+O0Q8baIzU69snrgCEf+CWMjulBfIdSLuKHBAfz9yun0mq?=
 =?us-ascii?Q?8RTGc2hvGgt5vkxZ9cxKKlZbxKZ1NVRImv6wVl1jBwjsWh9i9AUC5lf9KuX3?=
 =?us-ascii?Q?Cb84nZ7IyTJk96IqDSjQ81OUDIflqTVJ2Ok0U62+iVh4mLsYBnoqD5J44d+3?=
 =?us-ascii?Q?RCT6cUdrireaVpRgi/Q6n1r8eIqVCRmkzxa94QquWSr+UsOlrHnG41Est2k+?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deb78c6-4090-43fc-5979-08dbfbd4027a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:06:59.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+wcVp5WxC2CzxPQCsqvRQi/RiLqHb4ZWc/BS1jCYW+Hpb16Reigp5GU/1lmXIR/+Tx2zcP5pexLEeBlnn4zeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8032

On Wed, Dec 13, 2023 at 02:30:48AM -0300, Luiz Angelo Daros de Luca wrote:
> Hello Vladimir,
> 
> Sorry for my lack of understanding but I still didn't get it.
> 
> You are telling us we should not use user_mii_bus when the user MDIO
> is described in the OF. Is it only about the "generic DSA mii" or also
> about the custom ones the current drivers have? If it is the latter, I
> don't know how to connect the dots between phy_read/write functions
> and the port.

It's about both. It has to do with the role that ds->user_mii_bus has
(see more below), not about who allocates it.

When the user_mii_bus is allocated by the driver, ds->ops->phy_read()
and ds->ops->phy_write() are not needed. They are only needed for DSA
to implement the ops of the generic user_mii_bus - see dsa_user_mii_bus_init().

> We have some drivers that define ds->user_mii_bus (not the "generic
> DSA mii") with the MDIO described in OF. Are they wrong?

This right here is the core ds->user_mii_bus functionality:

	ret = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
	if (ret == -ENODEV && ds->user_mii_bus) {
		/* We could not connect to a designated PHY or SFP, so try to
		 * use the switch internal MDIO bus instead
		 */
		ret = dsa_user_phy_connect(user_dev, dp->index, phy_flags);
	}

So, the ds->user_mii_bus is only used if we cant't do phylink_of_phy_connect(),
which follows the "phy-handle" reference.

The reasons (that I can see) why we can't do phylink_of_phy_connect() are:
(a) port_dn is NULL (probing on platform_data and not OF)
(b) port_dn exists, but has no phy-handle
(c) port_dn exists and has a phy-handle to a PHY that doesn't respond
    (wrong address, ?!)

Out of those, it only makes practical sense to design for (a) and (b).

If the ds->user_mii_bus has an OF node, it means that we are not in case
(a). We are in case (b).

Normally to be in case (b), it means that the device tree looks like this:

	switch {
		ports {
			port@0 {
				reg = <0>;
			};
		};
	};

aka port@0 is a user port with an internal PHY, not described in OF.

But to combine case (b) with the additional constraint that ds->user_mii_bus
has an OF node means to have this device tree:

	switch {
		ports {
			port@0 {
				reg = <0>;
				// no phy-handle to <&phy0>
			};
		};

		mdio {
			phy0: ethernet-phy@0 {
			};
		};
	};

Which is simply a broken device tree which should not be like that [1].
If the MDIO bus appears in OF, then _all_ its PHYs must appear in OF [2].
And if all PHYs appear in OF, then you must have a phy-handle to
reference them.

[1] There exists an exception, which is the hack added by Florian in
    commit 771089c2a485 ("net: dsa: bcm_sf2: Ensure that MDIO diversion
    is used"). There, he starts with a valid phy-handle in the device
    tree, but the DSA driver removes it. This makes phylink_of_phy_connect()
    fail, and "diverts" the code to dsa_user_phy_connect(), where the
    mii_bus read and write ops are in control of the DSA driver. Hence
    the name "diversion to ds->user_mii_bus". It's a huge hack, make no
    mistake about it.

[2] This is because __of_mdiobus_register() does this:

	/* Mask out all PHYs from auto probing.  Instead the PHYs listed in
	 * the device tree are populated after the bus has been registered */
	mdio->phy_mask = ~0;

> Alvin asked if we should store the mii_bus internally and not in the
> ds->user_mii_bus but I don't think you answered it. Is it about where
> we store the bus (for dropping user_mii_bus in the future)?

The ds->user_mii_bus is not just a dropbox, a pointer for random storage
that the DSA core generously offers... It would have had a void * type
if it was that, and DSA wouldn't have used it.

When a driver populates ds->user_mii_bus, it opts into its core functionality,
which I just described above. If you don't need it, don't use it. It's
as simple as that. Use your own private pointer to a struct mii_bus,
which stays out of dsa_user_phy_connect()'s business.

It's very unlikely that ds->user_mii_bus will be dropped though, unless
we resolve all other situations that need dsa_user_phy_connect() in some
other way. One of those situations is case (b) described above, aka
device trees with no phy-handle, which we don't want to break (for the
old drivers where that used to work).

I cannot make a blanket comment on whether all drivers that populate
ds->user_mii_bus with an OF-aware MDIO bus "are wrong". Probably out
of sheer ignorance, they connected and tangled together 2 logically
isolated code paths by using ds->user_mii_bus as dumb storage.

What was written carelessly now takes an expert to untangle. You now
have as much information as I do, so you can judge for yourself whether
the behavior given by dsa_user_phy_connect() is needed. My only ask is
to stop proliferating this monkey-see-monkey-do. If, on top of that,
we could eliminate the gratuitous uses of ds->user_mii_bus as plain
storage, that would be just great.

> 
> You now also mention using the MFD model (shouldn't it be cited in the
> docs too?) but I couldn't identify a DSA driver example that uses that
> model, with mdio outside the switch. Do we have one already? Would the
> OF compatible with the MDF model be something like this?

I did mention it already in the docs.

"But an internal microprocessor may have a very different view of the switch
address space (which is MMIO), and may have discrete Linux drivers for each
peripheral. In 2023, the ``ocelot_ext`` driver was added, which deviated from
the traditional DSA driver architecture. Rather than probing on the entire
``spi_device``, it created a multi-function device (MFD) top-level driver for
it (associated with the SoC at large), and the switching IP is only one of the
children of the MFD (it is a platform device with regmaps provided by its
parent). The drivers for each peripheral in this switch SoC are the same when
controlled over SPI and when controlled by the internal processor."

> 
> my_mfd {
>     compatible "aaa";
>     switch {
>         compatible = "bbb";
>         ports {
>             port@0: {
>               phy-handle = <&ethphy0>;
>             }
>         }
>     }
>     mdio {
>          compatible = "ccc";
>          ethphy0: ethernet-phy@0 {
>          }
>     }
> }
> 
> And for MDIO-connected switches, something like this?
> 
> eth0 {
>      mdio {
>          my_mfd {
>             switch{...}
>             mdio{...}
>          }
>      }
> }

Follow the clue given by the "ocelot_ext" reference. Search for the "mscc,vsc7512-switch"
compatible string, which leads you to the Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
which is the schema for the entire SPI-connected SoC.

> 
> Is it only a suggestion on how to write a new driver or should we
> change the existing ones to fit both models?

First and foremost it is for new drivers. Read the actual patch:

"Authors of new switch drivers that use DSA are encouraged to have a wider view
of the peripherals on the chip that they are controlling, and to use the MFD
model to separate the components whenever possible. The general direction for
the DSA core is to focus only on the Ethernet switching IP and its ports.
``CONFIG_NET_DSA_HWMON`` was removed in 2017. Adding new methods to ``struct
dsa_switch_ops`` which are outside of DSA's core focus on Ethernet is strongly
discouraged."

For changing existing drivers, on one hand I would be glad to see effort
put there, but on the other, I need to be realistic and say that I also
tried to convert the sja1105 driver to the MFD model, and it's really,
really hard to be compatible with both device tree formats. So I'm not
holding my breath that I'll ever see conversion patches.

