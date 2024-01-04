Return-Path: <netdev+bounces-61531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651B9824332
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B132F28664A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F82232C;
	Thu,  4 Jan 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gKK2+jOg"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D33224CE
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhjZklwXSO5mPFVtVtqEdP52ufigi6JR5I9wkBnmoOL5KKhZN0Gdxj64A3tPg1ANpJerJNC7J5qt3i2SWrrtA26dlCJhyslhEoqqe4WvE8fD3eveWR8hj5QUsx5WRDrrrk2EqYUQ+bCktbGfBHNznsPBZhebjDzWvabXlh3O684q9eQDLuLA4sD8qW/sFiUuq/ebM1OTAQ/w+6l4dFNgIwO/tnBmTd06urrpQ/6/vKa94nuJgSVQ8Tqf3cgb+UjSAbyUlUVZIQu2vidyTKZgembRXHXgXZzdMTxqMtkj0GIOfgtTAa+oRbfy81kZS2NZbKhdmmcOTrHW4i5KBJQNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbGAb61AlNP2JUoAroyRrCmsCkH4jiMQVdEHM0ymHdk=;
 b=nfl+Z8zNkRXybSAb6ecE1Mhoznj+t59CpmYMJA1h9NUK/L2kFd3oTBRKuBEqItTyJ1o0OiyFdENMgT1NM7HG4oCq7buCntd99ZFIgintdqKNWDEuY/7LNPMIdTQTNngTaQtiC4fyTyMmAbZNzJ38Maz+eUbN4TPpLwLkAw+3vp2GsGBk5k9hCBV9ENwyMaCQmQDxsrWbsQypK3ALN4F6RnHnmHMfdPiKpVqIDT1D7wMCLfKH6qxKDkW5FMUDUD0vY/IVkizt6TOfJPp5GZugjpWIHLda652rT43svcZWeCLoP9Ybd9NSy5owL6mXYf3BizH489q1fW6IJsw1MA7Usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbGAb61AlNP2JUoAroyRrCmsCkH4jiMQVdEHM0ymHdk=;
 b=gKK2+jOg9JFfGKgnuGv5cw48MO1cz9+z4uEzlnptb4SuRCPqmNEaC7eEues28HvlztLG5n00LYpkv9QILmo8VcxsyUIbKineXl9lbWO+5ewZwet2O0sVXcVIY++2IPThfKmfQTqUm1tnjqGHm1LXixVzJyfoxsRmlPjU5t05vjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 14:01:13 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:01:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH net-next 00/10] ds->user_mii_bus cleanup (part 1)
Date: Thu,  4 Jan 2024 16:00:27 +0200
Message-Id: <20240104140037.374166-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:802:2::34) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0910b1-f5cc-4e93-6a77-08dc0d2d9c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ocdi7F/5H79ED0CnrS7LMZ8Rv8aqJlA4Eek9cREJ3ZymCQ7XqI5V/ElT6sJcITidisAdNlyRTXFfjL38OHpl89W59X1ciJ0kx2rYOSZzoV4PMWjfZmgd5i3CXYu+RfAAsDot91JO2fXmP/bu61l9tHV6P6owqOSV2sFx9fjGg+V9mqOAeyeYgZHUR7nXXzY+VV4p0sxyh0sDiUg5PMUBUBoxIz/pOlE8pqrojD3PjP6x4qus8o3fV0DSbQCy/f0FAYeCX5zpfX+GP0jFU0qnuBhkDGoc26OMQTOjOUvnNrnLKUix/1S/LxUaJ9+nqrmuraOD8CfMXUXpDX2jCZQa5bPppJWrelClHh1hyF5Q4Mh7rpK57egpjnwZMcxWk2ZWRFy7qvxFvt3gD6wijugYK4fXoZL6BRFax3T5Sag9jJRzAQPWVUvkqz7FKa6/NW6Z95y+gHoeaidZDDMk6RnZsNcO1lZ+YypdqvK5AG135si8Iv8H02OgtpIsa0xdXut6pPYnrJZLLnaRClHwekRIfmxR7kzuXKCnSa+mHufdD6FpZYWpa7KFf+q4/TN6KhzSbHl6Umk2pkpdwVw1ObiyFtUggKTcibTZPkulKyelK94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(7416002)(41300700001)(26005)(2616005)(83380400001)(38100700002)(1076003)(8936002)(8676002)(54906003)(316002)(4326008)(6916009)(2906002)(5660300002)(44832011)(6666004)(66476007)(6506007)(6512007)(52116002)(66946007)(478600001)(66556008)(6486002)(86362001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fsnla/F+UjXvOb+IIHvIemtJ6e8Wf9dlS5X1abh3yqmg7kVtdWCP+RJWAFEf?=
 =?us-ascii?Q?A0pOkx2zm7vzRf49XS8pAF84lmzN47eyzYXYaNNmFBfEob0NWzBmMTyE9Ru7?=
 =?us-ascii?Q?40AyLKXP6HUGCZYc96WhpwIUoaaWpErPTEiXTPHGl/42cosUwI2svqd9OlSV?=
 =?us-ascii?Q?sXqSCnRxDFiHfmXEGBpEaUmyCCYXxOD+b9J0zCcxmplCRr8+6+rwiptOMlU2?=
 =?us-ascii?Q?9XCwD17ehLmyi85oNs1RQ55K6GA2fkpPsSFZJ//c5N4YkeT2eq0JNDpvzz8n?=
 =?us-ascii?Q?j7m/vioOvesnbWU9DirSuFdJ4gWKFKUyoG/yXKaZuF+YtgsmFrvE21IuZZdd?=
 =?us-ascii?Q?A8drsOB5l9ursUKza9zsf5es/pZsqxmrLdH79/tykzXVD4vNy9MoRCL82UGq?=
 =?us-ascii?Q?fM9Cle/AkjRhvtvAK7DpXkjTZ73woCQ3RhkO3e1tReMUK/bS5AeOBvUs9mEP?=
 =?us-ascii?Q?pAHX4Oc3vMKYVZxLklr8AtLLYQtst+rHgd9kA2dT3Si3jDCqP5/net7OaC/p?=
 =?us-ascii?Q?eDetnvMhi1cKj12n4dyac5EtG8ys7gEUqTx0+izmo+aSZUdjqe/c3c1LTwLY?=
 =?us-ascii?Q?kVwCOtTJBKPr67BoTUDt5PNrO3sWXDdGmPhjzHlrTV5SyrjTHoeyNREXsqIy?=
 =?us-ascii?Q?SZZsyAO0eefkUpV5OllMwpCRzJ39frkgExvPlTHyDQyUSsE3K3Up8kq24JXz?=
 =?us-ascii?Q?TgFeS08ajvMokODHikEL3EmaRdLp55Uj8PkyalC9JetBwXz/7mWP18+ODyHz?=
 =?us-ascii?Q?w4qw7RfWfrSSUrr4imLNaxh4paob0zP7kJ++mIV/Tx+Q9+Y8rtPsbVdlioCe?=
 =?us-ascii?Q?4EPN82HhRk0HESwXeLYQH7jD+IbZvDlhgxlGfBgqa+QzrSwDvTsKq07ql85J?=
 =?us-ascii?Q?U0gMo4iAsVjPYm+PA6tOZVM1Mt09ahtpduS8Q6Kle3+ay2vJKZIZq6kEt2aP?=
 =?us-ascii?Q?FT7k2BLXwqpKpRDCXNks4WiQ3cB0cZbpMlFpp81k79f1etsMJbAEsscXjUQC?=
 =?us-ascii?Q?EA6MCQaYtvut5x9MZkW/hTlHDrgb17BSDKs3q4AWcnv5WIHO3tmfwuw0jZCl?=
 =?us-ascii?Q?RcXaioVXxDd43T3LJBYIUjQPark38vQCwX1xVs+LlMC4R8qA7BqA0v60uFX7?=
 =?us-ascii?Q?cvC3pqnkZMW3W+1jGpZaBOYzimCG1KVqIKo+xIKmI11zlpTlpD4c+DhSzb48?=
 =?us-ascii?Q?xmbiR624ZHbWKZF6kuOWYDFlKCeZiR7D/UaJxpMptgLFX15bsvdgNupJY3HV?=
 =?us-ascii?Q?q2SLh5oz2h+xFpBIqAqCQ/+L9iBgf9jFTDxrplCKjBCBAVefYfCTOY5rym40?=
 =?us-ascii?Q?XwNZWVXYeyGloi8cdWUMFIm4T1qtx59U5oCNMtwDdJCnQT8TEU2MAc/nFdx6?=
 =?us-ascii?Q?BuDnqBqnK85Vp697NFhNPq6DWrasDx7UuKTJf/ubFc5QX+wALHzAbtPyeV6l?=
 =?us-ascii?Q?uQDvUGMtaoa+BqlvJufQb3yCv/mk3YLfMBpkHOd9kDc/fmF3abaEYrfC+LIG?=
 =?us-ascii?Q?VKB7IJXm5EqDlrJi0PW3abwc9YLH0YGoQFd4AbQ4ZaGlgNrtV4kxIUNBj3jT?=
 =?us-ascii?Q?D2VQtjglrI40JfLmW7D6YA/YRuD0XLh2zMyuFBei2O4kJ1WKOIs1zQg7fSiC?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0910b1-f5cc-4e93-6a77-08dc0d2d9c8b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:13.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmItLa4xzTRAhB4tEqLe54ag676qen+19uerXwt419gK9/ZTXkSPSg/kJIsd3uDiFKfreWWn/BaGsp1UEcaZ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

There are some drivers which assign ds->user_mii_bus when they
don't really need its specific functionality, aka non-OF based
dsa_user_phy_connect(). There was some confusion regarding the
fact that yes, this is why ds->user_mii_bus really exists, so
I've started a cleanup series which aims to eliminate the usage
of ds->user_mii_bus from drivers when there is nothing to gain
from it.

Today's drivers are lantiq_gswip, qca8k and bcm_sf2. The work is
not done here, but a "part 2" may or may not come, depending on
other priorities.

All patches were only compile-tested.

Vladimir Oltean (10):
  net: dsa: lantiq_gswip: delete irrelevant use of ds->phys_mii_mask
  net: dsa: lantiq_gswip: use devres for internal MDIO bus, not
    ds->user_mii_bus
  net: dsa: lantiq_gswip: ignore MDIO buses disabled in OF
  net: dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure
  net: dsa: qca8k: skip MDIO bus creation if its OF node has status =
    "disabled"
  net: dsa: qca8k: assign ds->user_mii_bus only for the non-OF case
  net: dsa: qca8k: consolidate calls to a single
    devm_of_mdiobus_register()
  net: dsa: qca8k: use "dev" consistently within qca8k_mdio_register()
  net: dsa: bcm_sf2: stop assigning an OF node to the ds->user_mii_bus
  net: dsa: bcm_sf2: drop priv->master_mii_dn

 drivers/net/dsa/bcm_sf2.c        |  7 ++--
 drivers/net/dsa/bcm_sf2.h        |  1 -
 drivers/net/dsa/lantiq_gswip.c   | 72 ++++++++++++++------------------
 drivers/net/dsa/qca/qca8k-8xxx.c | 47 +++++++++++++--------
 drivers/net/dsa/qca/qca8k-leds.c |  4 +-
 drivers/net/dsa/qca/qca8k.h      |  1 +
 6 files changed, 68 insertions(+), 64 deletions(-)

-- 
2.34.1


