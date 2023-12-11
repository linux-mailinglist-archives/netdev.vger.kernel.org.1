Return-Path: <netdev+bounces-55940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1DA80CE7A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568101F2110D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C5E48CD8;
	Mon, 11 Dec 2023 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NOiOSD73"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018CB4
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR/Iq0kapjOmOhTejPPd4upmRgooBICIvZ1R1wQ7Kmh0mz938/cQWJp5K9n4IkHErgYCc0pqg1f3BhOG5b65wkciGK+P5Wda+0ra6RSCMhKnBNFltXjN3VnaU2oc53ok8Dkmm4lduRBnHHRmniXGpOiUSvyM7OYRP6dfLv+DStkkKpzQRZY3R+Sr6dx7f6MhmWvm5qg/B6y/cCrVyCia+GGcB1CWPF0xif64yIJ3FEw+VnKtSkSlIw5RYTeOfSe+Vo+Y9myJ8axvkv1rTP/Zt106HIUi2HUPO5njTxMC+KizkxXLsClQjCLxhyxTHxAPJs15kPvcnA7fPkKs0Zb6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEQeToCqohy28shUzSRAoWJU85+5d+5H7lFfryLV6oA=;
 b=HFLbCAaARNJHQ4DNpUWAF3dDhrswgbKHyroY41YPnae+8XpdP19HslccmTwwI5pRv8bGfIozvvvW+WBTqDwWrzvcRR3sf0cpxLTXB1CvUf5oLcSfqimgosUjASRNkXFta2Bfl8XWby1tA/Umknl5WFkgyUvC86pSKguH4jZ4/2eFa8mqOfY0nFS2BlSvTmKcfdIq5Sf0rKP/VfZEeypL/LTsDpmC11cfWBu5XuqHLTVCKa0UD8ZJNVL+DfdrRrAAn6Gd9qvFWU0nMDp23FzqypQSttrK86yW0Pv7lys3i6yYIOmzsGP/Y7RhDUfqtHVWF+Zoa0m92UAG3Zj6vSAPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEQeToCqohy28shUzSRAoWJU85+5d+5H7lFfryLV6oA=;
 b=NOiOSD736gWfOf7c7Pm/DvIULfiikMeheHrezIJ7ILtcKXkXkgZ1Ax/j6t12L90ghy2ZFkFIKmbOMJ9+nsI6jT38V8c5o8rARGLMLBE0ksTImBqiLYlQzu/KwD6eIwCx3DPnLdCSWgUGcjsKCf9SYfaUx3V6h292qhFZhJNYepU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8235.eurprd04.prod.outlook.com (2603:10a6:10:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:35:17 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:35:17 +0000
Date: Mon, 11 Dec 2023 16:35:13 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Madhuri Sripada <madhuri.sripada@microchip.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net 3/4] docs: net: dsa: update user MDIO bus
 documentation
Message-ID: <20231211143513.n6ms3dlp6rrcqya6@skbuf>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-4-vladimir.oltean@nxp.com>
 <r247bmekxv2de7owpoam6kkscel25ugnneebzwsrv3j7u3lud7@ppuwdzwl4zi5>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <r247bmekxv2de7owpoam6kkscel25ugnneebzwsrv3j7u3lud7@ppuwdzwl4zi5>
X-ClientProxiedBy: VI1PR06CA0121.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 2409f5e6-98f6-4485-7e93-08dbfa5664c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RpFoms+hrzvTHBCTlRm+Ii8Q74nVjwpwt3AzOmMy7E4gACBMsGnmvSvEzgZfIZFQkEdZMcIwuuizJEmu2nvALC/2pdrUMC9igXe6Id9tdgHsVIL32mpakHFhptJMDuLINVlQs+5u4QXa4RhOP630y8jjHHTW3qiBgzbyw8L1/9xmCPKZDMhvk66JSvXmp3q4nVAVgNyLL8DpSn9mOxMaacowjW77KZaafrKZWb8UMIGabQS7kExB2yuTo1VFdthg7tsqppr68c38KFDznXQnX2gt3RbNfEnKBqZ2yZoYJi+q1ScKjdbFgg/UaxvTSRakZo9gAGFThIfA1BfWRmO18yn0gu1Q+zV992usF8Zd0WupckiNc9osxIN1+KW2QDE7vESM1Lw3ESczN1rM+SWstWx3EHtEE4IUrrDL049FrRktSZ4xOrn7H6rWETB3xKggvEvdk5rkGbTLeLr9lJaMtcd1/MIpWGGXiyvR1Q5JjhAeyoMaW8ckYOjmpmHIyxiXGwz+AF3Z6Xk6lZnRq54OfAjxZYseDspWNru0BABce3AlWO00Nf0oc1kRdnZCxG9RaMLeEbBzNqKioG8gdX8MlwG4J1oY8B7WbOwIZ7aW/CS7rJqpR27+fYAtox3RYvGO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(66574015)(1076003)(6506007)(6666004)(9686003)(6512007)(83380400001)(5660300002)(7416002)(44832011)(41300700001)(33716001)(2906002)(4326008)(478600001)(6486002)(8676002)(8936002)(66946007)(66556008)(54906003)(66476007)(6916009)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGFUb1lWNWN6TGtYdnZCODFRN0ppd0FBUEdtUythYkVwbjFLSlhnaHNSdDNO?=
 =?utf-8?B?VGFpc0g0WmlCQkd6TGNGb1d1TVpIaStQOTU2N2pXTzIzZGxuZEZWMk14ZFM5?=
 =?utf-8?B?L1FVRWtvYnAydTVlMVFjU0lFbWhDY1ZZeGtWb01LdkVUcDd0ZjhZcTFTRjBG?=
 =?utf-8?B?bDhlUkRMTWpYZCtBQkVJWHNGeTRwQ3RaU2NnanFNYmptMms1bWE0NVdXRHhq?=
 =?utf-8?B?U1ZxcGJZam50TXA2MHVTcFkyVFBIbXhNcWcvc0JTcmdRb2YyWVVWai8xTWZB?=
 =?utf-8?B?Nnd2WXV4bnZVVHVOMkdjVW85dFV4UERqMVFkclNlS0FncjRVTGdRSDExa1VT?=
 =?utf-8?B?L21MZGZXVWE1azNGKzdDQUtENjd1OVBtMkJja0pIaXJMeVhNQkN0WWVQakxN?=
 =?utf-8?B?NTlZK01XQW5WaGxJTGZIMmRpaSttVnQwZE4vU3ZlRGlEZDNLc24zZHJjQitS?=
 =?utf-8?B?MUZGYndYeXJIeVF2VHMreHJGRW9Yc3dJNW9PMjBXUnBvRVB5NW9TeUZVZUFE?=
 =?utf-8?B?eWJKL0ZnZHU1bnhxci9jeXFWbTFKTTluTkJEbDYvMUtzWmNjZG95RjZFYXph?=
 =?utf-8?B?NDlGOHdRVlFCSGsydkM3bWJyZlF2T0pJUDZ1OHl3SFNqSE44eEhqdklTeldj?=
 =?utf-8?B?bUpNTERhdjR2RGxrZXY3UjliTEJ5c0JBbXZ3YUg3U1BKelpXQzJVSE9NQ0g2?=
 =?utf-8?B?WlFPNWZUWFd2UGJpVnBPWG5rSHAycllOKzBjN2w2dFVFZWp6bHRSdFIwbmpz?=
 =?utf-8?B?YjZ2RGNPUWl1ck45aVBFdXF5cmdyV1lJODg5Ry9mdE1nZ1RqZ1JzdG9TVmFS?=
 =?utf-8?B?cm0zN280TnhPY2lBdFE0SnB4LzFxM3BibzBaT2gydUhTMjRseElEWHh1S2M1?=
 =?utf-8?B?TXBEd0x1cjB5SGQzV21MTkxXM3RuZnZKOGxOZnA3UjBXa3pDQi84YjNHU2V1?=
 =?utf-8?B?WEhubk83Z1ZvTXVkaWFsVjhPV1UzWDJoQ2hwaVNnVzlMZ2dNbkdoMy94Q2cz?=
 =?utf-8?B?eXFKRU9yWUswNVVNd3M3ekNNUGJMU09reDJObDBGdmZnamFCS1dIbWNaWXFU?=
 =?utf-8?B?M0RDUURjWFQ1OFlXdklycHpGNXFoVDFXQkRGZXNBT1Rtb0l1VGNnWWxnMkxi?=
 =?utf-8?B?L01yVUxyVk5ub2E2WWI4aHlRQmRKSTZsczlNUUNHZ25XN3NlMGw0NmRmTHdp?=
 =?utf-8?B?M2p0SFNQM0I5UjZwdzNNVG1sbXgwOGxNU0p1d3lNaGppRnYyeDdNZXR5aHdp?=
 =?utf-8?B?cURSMHJBWTQyVkhEVXVuUFFyWWhuUkQwNG1seE1SS2oxYzYzd21hdUs1eU5E?=
 =?utf-8?B?LzBBZlNWV2tjSWRPR1RsME1OSHpMT3RXTU9YN3hMb2xiWVlRSXh0cjZJOWIr?=
 =?utf-8?B?Rld6eXB6RHRzR3RrbDlvZ3h5M25FOWNTdDNjd3RNNVd6d0dWNXdQbHdpU1M1?=
 =?utf-8?B?bVZ0cGRvenI0Mjg4d0pVaWhlckEzMmIyR0ZwSkFzb3VSK1V1U0d5UWc3M01h?=
 =?utf-8?B?OFZqOTZScWdBdkI2dk9PUWZ3SjErbFZzNU5ZbnhEVktVeVJndzgwajlER3RW?=
 =?utf-8?B?VlhSQml6UTJFSjFpcUxkb2sxak84Zmx5d25jenc3Ri80VWM3a1RvTUFWWlYr?=
 =?utf-8?B?MitwQ0hHT1Nxcnc5TS9YT2Z5RXJpMG56djUwTjBIeXpQZmpxYXhTVmY2anVU?=
 =?utf-8?B?YzNBdU04N0lPQkViRDBDQ3FFa1VNU2E2SWxpWXpRK2o5QlZDQzNEVWp5dGVE?=
 =?utf-8?B?d0JrcUxBMzdZc3RkOXRLbmxyNnQ4bkpRVUpsd1FVWGR3V0hzcTNkaWIwQklq?=
 =?utf-8?B?MEFxUnUrKzNBNmVJOGNjOGo0WGhTSjZMdnRrNFZSRWFxT0FzbTNUUENFRnFG?=
 =?utf-8?B?THNwUlhZSXJ0d2t6VU5DUVozbVdJajFIM2NhYVROelFQMWE5TW52blVVZTRU?=
 =?utf-8?B?ZGJZZXZSbFVNWmdMS1NDU09GMXJBSVlPVEc2QmVZQUpVbWptR3RYemZHbTFX?=
 =?utf-8?B?RHFFUTZkNkJPUVJTR2NnbDl3c1BqSFZ6cXJ4M2tKTG91TmhnTktzZGt5MzFP?=
 =?utf-8?B?Y20rSFB6WDcrQXNvazExRkp2ZUg5am1lYmxveXozcXJJRHFIZVVaOHEzTWdh?=
 =?utf-8?B?SGFrZ1c2YUd4VFdZaEJ5WXY1L1lNYzdjN1pTemQ1Y1F4bW5EZUNwekJqN1lX?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2409f5e6-98f6-4485-7e93-08dbfa5664c3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:35:16.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW/SLVYk/5j6gRJiUG9vaYkxSxMyW7TbFi+vOYUCMZAHlVGcP6hfTjoa4E/SekylMj3mUWDRGx6+0qsnKQNkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8235

On Sun, Dec 10, 2023 at 01:48:12PM +0000, Alvin Šipraga wrote:
> On Fri, Dec 08, 2023 at 09:35:17PM +0200, Vladimir Oltean wrote:
> > +When using OF, the ``ds->user_mii_bus`` can be seen as a legacy feature, rather
> > +than core functionality. Since 2014, the DSA OF bindings support the
> > +``phy-handle`` property, which is a universal mechanism to reference a PHY,
> > +be it internal or external.
> > +
> > +New switch drivers are encouraged to require the more universal ``phy-handle``
> > +property even for user ports with internal PHYs. This allows device trees to
> > +interoperate with simpler variants of the drivers such as those from U-Boot,
> > +which do not have the (redundant) fallback logic for ``ds->user_mii_bus``.
> 
> Considering this policy, should we not emphasize that ds->user_mii_bus
> and ds->ops->phy_{read,write}() ought to be left unpopulated by new
> drivers, with the remark that if a driver wants to set up an MDIO bus,
> it should store the corresponding struct mii_bus pointer in its own
> driver private data? Just to make things crystal clear.
> 
> Regardless I think this is good!
> 
> Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>

I think something that makes a limited amount of sense is for DSA to
probe on OF, but not describe the MDIO controller in OF. Then, you'd
need ds->user_mii_bus. But new drivers should probably not do that
either; they should look into the MFD model and make the MDIO controller
be separate from (not a child of) the DSA switch. Then use a phy-handle
to it. So for new drivers, even this doesn't make too much sense, and
neither is it best to allocate the mii_bus from driver private code.

What makes no sense whatsoever is commit fe7324b93222 ("net: dsa:
OF-ware slave_mii_bus"). Because DSA provides ds->user_mii_bus to do
something reasonable when the MDIO controller isn't described in OF,
but this change assumes that it _is_ described in OF!

I'm not sure how and where to best put in words "let's not make DSA a
library for everything, just keep it for the switch". I'll think about
it some more.

