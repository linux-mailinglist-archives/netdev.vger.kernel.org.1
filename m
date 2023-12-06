Return-Path: <netdev+bounces-54604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829C807988
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AF91F21761
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D8E363;
	Wed,  6 Dec 2023 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ooma.com header.i=@ooma.com header.b="TN6/tsKY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C62D53
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 12:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFVr51NW00qILRTjnVrY/VzptMJPlgdNc2dSYg7xBuXDbvGdy7rrPxqbr/5slOU3z3HEIWgUdxjoRxVfFYTAszq3SjX9jKKOugjyBXn4DpzC/X3bW+VZGa02wJCwkNjryevBEi3t6gyVMsvDOXgJBQwmqwSHqDsScqV1IkUJWsDmntZcQvvoqK3fHHHy5dsDnTYNVWjgJSKxTEisrsstFhtdESM8v5lN0XtmxWdql+7/aV5DMeei0Zx4P9QZPIthct4LOT2apZk9jcAykffjf0xeBECCmm7bjuVxDPhscj8g7j/z8+rN5fvDdtVvY7EQUd+2BqfSs4SbtGK93q9CHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0QjOYmDJx+GALX73BKHAYQMeb6bIWTHpN4NYnz7fYc=;
 b=fTpZaRhR+448jRNSS6f6DRtc5s82HAm5KFwxV4dx1npBhKlqGorKP/wAbaDqBlpVNnSsaSPT5JARBOyC/ytSzdHCgBxBmmNa+NNtZrEn1GcYXhHaCBzHY1ucn5eJpZI9tWG1PpY8ZddqKL1HH68IGKXJrHj6IRHeOg2ufzW33/W6x4e9wQQVfKIAr7OlfqVPhqPQQSLW5KF8hdvRI9kemuFgsDmkpBiasqIL/kWORmp0bRvfqoFoezCwCvcWlLnGwGl+W0QuLxQ+PA7Cr5Kgt+BHwS/2JRfUs9ps5mEcSEW/0eeWrqbhjALrkVmi1Z8ytzwY1z/Cn3OhH4YrDTBjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ooma.com; dmarc=pass action=none header.from=ooma.com;
 dkim=pass header.d=ooma.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ooma.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0QjOYmDJx+GALX73BKHAYQMeb6bIWTHpN4NYnz7fYc=;
 b=TN6/tsKYY/6x8NvuTQHLNIOejB1ayUZTovkWKDmkYoyyOYOhkko57umT1WAwJut1/CXVAhx7bNaJ0BJtgw1dwHw41VrAfgtFdiieKl8gVbFoGQwbOFJQYBZ2PH32ty9bEezTfKLMQp8SWGi39Cq/r2ORaAXY+zihM+M7vdUh+84=
Received: from PH7PR14MB6163.namprd14.prod.outlook.com (2603:10b6:510:20e::7)
 by SJ0PR14MB4506.namprd14.prod.outlook.com (2603:10b6:a03:2c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 20:37:50 +0000
Received: from PH7PR14MB6163.namprd14.prod.outlook.com
 ([fe80::878c:cd61:3b22:1ba8]) by PH7PR14MB6163.namprd14.prod.outlook.com
 ([fe80::878c:cd61:3b22:1ba8%4]) with mapi id 15.20.7025.022; Wed, 6 Dec 2023
 20:37:50 +0000
From: Michal Smulski <michal.smulski@ooma.com>
To: Tobias Waldekranz <tobias@waldekranz.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net] net: dsa: mv88e6xxx: Restore USXGMII support for
 6393X
Thread-Topic: [PATCH net] net: dsa: mv88e6xxx: Restore USXGMII support for
 6393X
Thread-Index: AQHaJ8hvrLygSOh9hkOG1PRLI9YmVrCctw+w
Date: Wed, 6 Dec 2023 20:37:50 +0000
Message-ID:
 <PH7PR14MB6163EE62811682A3927F79AAE384A@PH7PR14MB6163.namprd14.prod.outlook.com>
References: <20231205221359.3926018-1-tobias@waldekranz.com>
In-Reply-To: <20231205221359.3926018-1-tobias@waldekranz.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ooma.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR14MB6163:EE_|SJ0PR14MB4506:EE_
x-ms-office365-filtering-correlation-id: 58d9e524-95de-4bfe-ee7f-08dbf69b3706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pTWBNh3h75Lj1Rgol7yWDEZOKMMrjdo/deLfyIfddCyH8ZIMgKQ5BxaSIpZxh7Qx4G6dYVFaq/yDLlK/9ihtvXsl1eFjXqL7NtlEgUjdmEAEPfwI927c8hKwsE1XXLE2DKoA/OvbPcwjPn2DepAUxbJhOEyYhK41cqtocKB93Fsafh2HiYtFYxESaytEfucEuyvGRz/sIg1KkshTI/kZothWOTPw0veaCxDl0LGrRyMCdQaRMpTGyebjwDCXDWAcLMh3RL+W7sFHOn1xtPFANw2MZi5tbpISrNGZjhYI6H/zeBxfKPsUQmPq6y6IWHKE9xXM26qiA5tPBQFQFMN08WEmClO601cknvfZgaDM0aqBnBzc3YsBtIPxeq9xRtRhwrUhjeVkUKEHrF9WHK7popANSHZ0fMOG6qiieNrmGdDX2HxxMSD02VMgCPS9PAndJxCU7I1/0qGA0TQBfxxeuRz+GlWUtRURB+IRUgulJ6rAOQfZpPivaweiKF+m96pkyK1luwxdFTm/OZD//45JTS+yyC+DjRjSLYFIle2aI3Js7dAn5E5a7U9uiCcIsECuRe3ordU18J9gUkOCBbKmy0F7kajnvza2LakMB9jVeDyCX6uTyciKa/k9rOFpMWmECvnbL13sazUxWFxUY84lQeNK09ajwRL1h+zsLjJfRSU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB6163.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(86362001)(83380400001)(26005)(44832011)(38100700002)(122000001)(66476007)(76116006)(66946007)(41300700001)(54906003)(52536014)(64756008)(110136005)(66446008)(5660300002)(6506007)(9686003)(2906002)(71200400001)(53546011)(7696005)(8936002)(478600001)(316002)(8676002)(4326008)(66556008)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tAdPYs+13O9a5pG9M4r/O38/5pWQFaX6ubjq2G4Uuetj9PEZbLRV+NTIx9Eo?=
 =?us-ascii?Q?KNEiW7erqLClvzKmjCIx6lVGqwXwusGIREPVKnf4lxwexrmBtEhTw8UXasQN?=
 =?us-ascii?Q?naWOgiArqGIX8QecZmIRWoBw0FuVkt644x+pdzqgw1TaMg4LmluZRrtCq0To?=
 =?us-ascii?Q?pdVnlrHB7QUG6HrWWSo2fax2rj/ammQnlu7WggIF/it7hdbHssmk9yhigPot?=
 =?us-ascii?Q?NoDwojwVckBSmwH6Uvb8o23w2gfs9CfiFnK1esu9fG83ISc6oYVGI63BIsX4?=
 =?us-ascii?Q?yERNvzQVXoQWgUyIObVrZ2JVhdIeOI/L/yFPL0AQFAEqWEwAO820T1Nc17jh?=
 =?us-ascii?Q?TgW9pcHOUuUZOTSjTEfIWD2G0lpJDb9H9g8pFWCZp7sANcWhVqmfqPsEt7tm?=
 =?us-ascii?Q?1tvXBPxZhEiP4GdwjerFn32a9Viiek5y2g8J7A2lMIuAHWJaLpr5VH7pSWGS?=
 =?us-ascii?Q?mnYCS4mvTiRlyF0cIdVNUo5PlM1QgE4ivRx0OXYPd7eRQknNqw38/Fk6WQ1a?=
 =?us-ascii?Q?M80LVjHE8cRvvIreOdSSuZudcmtfgmz4Rhd8gDxY1pWhpm80GwQrruZOJxId?=
 =?us-ascii?Q?wDXDOLB/LyOpLU5LEf6MVEKUoFwoVG2oeqcD1SGz3CUgcJRyi72AoFG2kW35?=
 =?us-ascii?Q?zVGlywuzYHhAGtPcc+6pmO7PCrns4c6n8ooTW4jzW64m+b3QLM8piVnYt5Es?=
 =?us-ascii?Q?etBZT3KkQ0z5Yph+zMS6onixN77lMVygc+7VkvWsmPBW1O2ZwC76bjTbijb7?=
 =?us-ascii?Q?/gQTXLIUbPPO7gYix9xSdOoXxCtKcQ+yuEf4zp3mF1wd+tR7fv6pJQ/pFi3U?=
 =?us-ascii?Q?FiGj5RNdDUjHRq/2a2LvF7E2HAqAO7Poy/jNayjOqFrX+8vQp7MWGWlhY5cP?=
 =?us-ascii?Q?anE03io6qdhifrEylxd1960sJj6LaihSgBCh2r24LkudPw0GPM5x09HFAfmf?=
 =?us-ascii?Q?y2c5yTSTs159R65v+/QkfWQ7KMyyw3JoVz6mqe003MyDruISKsVngP7Q7B2S?=
 =?us-ascii?Q?/wOCRQqh9PL2YeMtSgQMJ2OpkAAKUCCMBeXipYKcXjDaBrcGPlL3DP5ZZskT?=
 =?us-ascii?Q?0gBuCq5C6uVUmZCYcvE0scF+tFskbEwFKfUKbD49o/cqeaKPmoe5ZBEc5Neo?=
 =?us-ascii?Q?aYXQG6oby6sClRs+qFiqUzAX5NueiilqqrxZZROPCEoRjpCPLBU41tXwzvjz?=
 =?us-ascii?Q?Xbu0Yz6nBKC4YbbawNx5FU3hhS57+OpXYvMmDOssIl91ifF44H+NStcXqvL8?=
 =?us-ascii?Q?iUribpreicHJqPOZKmQsMfVZW2/SDKjEQp/GGockRGqi/XJry2+P7Ig/IHIH?=
 =?us-ascii?Q?8UPhGrJjre2Xk9wM02eDyE4gpSyZ4beAICkGdiWdpYSG2dVWuTv+XLAVWskS?=
 =?us-ascii?Q?L/6RaVLaQGH+J9pn54BcIiAYjros+fEgdnmp9GQdPDLVFAkq278QVk+I773T?=
 =?us-ascii?Q?iIWzUIfzMcHCG7/lmnKBSCnKp+k37ffgaCmvW1XsK1JWDtocvEe2fuKhPYW/?=
 =?us-ascii?Q?s12HbFLG5D3C/oOMjVM90RU3xOou3rfwz+SXkRk0CsRAnq0nbAQ+1RJ2Ij8c?=
 =?us-ascii?Q?abSebOrw3EoeVc+FWR22zGN+9v+TgRsD/9wNat+m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ooma.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB6163.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d9e524-95de-4bfe-ee7f-08dbf69b3706
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 20:37:50.6349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d44ad66-e31e-435e-aaf4-fc407c81e93b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hu6GM143B7LWj09AUVAt7OQo1kYt1P890ECDFCPbH1zXh1pG/14fu3OxCv4x09ign5Hxq2KibfmlQZ6qj3aAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB4506

I confirm that applying this patch to net-next tree works (and it is requir=
ed) on my hardware.

Here is log from the kernel running on the actual hardware:
[   49.818070] mv88e6085 0x0000000008b96000:02: switch 0x1920 detected: Mar=
vell 88E6191X, revision 0
[   50.429506] mv88e6085 0x0000000008b96000:02: configuring for inband/usxg=
mii link mode
[   50.509099] mv88e6085 0x0000000008b96000:02 p1 (uninitialized): PHY [!so=
c!mdio@8b96000!switch0@2!mdio:01] driver [Marvell 88E6393 Family] (irq=3D38=
8)
[   50.577062] mv88e6085 0x0000000008b96000:02 p2 (uninitialized): PHY [!so=
c!mdio@8b96000!switch0@2!mdio:02] driver [Marvell 88E6393 Family] (irq=3D38=
9)
[   50.635256] mv88e6085 0x0000000008b96000:02: Link is Up - 10Gbps/Full - =
flow control off
[   50.641109] mv88e6085 0x0000000008b96000:02 p3 (uninitialized): PHY [!so=
c!mdio@8b96000!switch0@2!mdio:03] driver [Marvell 88E6393 Family] (irq=3D39=
1)
[   50.697091] mv88e6085 0x0000000008b96000:02 p4 (uninitialized): PHY [!so=
c!mdio@8b96000!switch0@2!mdio:04] driver [Marvell 88E6393 Family] (irq=3D39=
2)
[   50.725072] mv88e6085 0x0000000008b96000:02 p5 (uninitialized): PHY [!so=
c!mdio@8b96000!switch0@2!mdio:05] driver [Marvell 88E6393 Family] (irq=3D39=
3)
[   50.753074] mv88e6085 0x0000000008b96000:02 p6 (uninitialized): PHY [!so=
c!mdio@8b96000!switch0@2!mdio:06] driver [Marvell 88E6393 Family] (irq=3D39=
4)
[   50.781085] mv88e6085 0x0000000008b96000:02 p7 (uninitialized): PHY [!so=
c!mdio@8b96000!switch0@2!mdio:07] driver [Marvell 88E6393 Family] (irq=3D39=
5)
[   50.809080] mv88e6085 0x0000000008b96000:02 p8 (uninitialized): PHY [!so=
c!mdio@8b96000!switch0@2!mdio:08] driver [Marvell 88E6393 Family] (irq=3D39=
6)
[   50.815677] DSA: tree 0 setup
[  170.719608] fsl_dpaa2_eth dpni.3 eth1: configuring for inband/usxgmii li=
nk mode
[  170.735697] fsl_dpaa2_eth dpni.3 eth1: Link is Up - 10Gbps/Full - flow c=
ontrol off
[  170.813015] mv88e6085 0x0000000008b96000:02 p8: configuring for phy/gmii=
 link mode
[  170.913510] mv88e6085 0x0000000008b96000:02 p7: configuring for phy/gmii=
 link mode
[  171.014155] mv88e6085 0x0000000008b96000:02 p6: configuring for phy/gmii=
 link mode
[  171.119832] mv88e6085 0x0000000008b96000:02 p5: configuring for phy/gmii=
 link mode
[  171.230594] mv88e6085 0x0000000008b96000:02 p4: configuring for phy/gmii=
 link mode
[  171.346344] mv88e6085 0x0000000008b96000:02 p3: configuring for phy/gmii=
 link mode
[  171.472394] mv88e6085 0x0000000008b96000:02 p2: configuring for phy/gmii=
 link mode
[  171.594045] mv88e6085 0x0000000008b96000:02 p1: configuring for phy/gmii=
 link mode
[  969.248179] mv88e6085 0x0000000008b96000:02 p8: Link is Up - 1Gbps/Full =
- flow control rx/tx
[ 1089.691582] mv88e6085 0x0000000008b96000:02 p8: Link is Down
[ 1452.761369] mv88e6085 0x0000000008b96000:02 p8: Link is Up - 1Gbps/Full =
- flow control rx/tx


Michal


-----Original Message-----
From: Tobias Waldekranz <tobias@waldekranz.com>=20
Sent: Tuesday, December 5, 2023 2:14 PM
To: davem@davemloft.net; kuba@kernel.org
Cc: andrew@lunn.ch; f.fainelli@gmail.com; olteanv@gmail.com; linux@armlinux=
.org.uk; Michal Smulski <michal.smulski@ooma.com>; netdev@vger.kernel.org
Subject: [PATCH net] net: dsa: mv88e6xxx: Restore USXGMII support for 6393X

CAUTION: This email is originated from outside of the organization. Do not =
click links or open attachments unless you recognize the sender and know th=
e content is safe.


In 4a56212774ac, USXGMII support was added for 6393X, but this was lost in =
the PCS conversion (the blamed commit), most likely because these efforts w=
here more or less done in parallel.

Restore this feature by porting Michal's patch to fit the new implementatio=
n.

Fixes: e5b732a275f5 ("net: dsa: mv88e6xxx: convert 88e639x to phylink_pcs")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/pcs-639x.c | 31 ++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6x=
xx/pcs-639x.c
index 9a8429f5d09c..d758a6c1b226 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
@@ -465,6 +465,7 @@ mv88e639x_pcs_select(struct mv88e6xxx_chip *chip, int p=
ort,
        case PHY_INTERFACE_MODE_10GBASER:
        case PHY_INTERFACE_MODE_XAUI:
        case PHY_INTERFACE_MODE_RXAUI:
+       case PHY_INTERFACE_MODE_USXGMII:
                return &mpcs->xg_pcs;

        default:
@@ -873,7 +874,8 @@ static int mv88e6393x_xg_pcs_post_config(struct phylink=
_pcs *pcs,
        struct mv88e639x_pcs *mpcs =3D xg_pcs_to_mv88e639x_pcs(pcs);
        int err;

-       if (interface =3D=3D PHY_INTERFACE_MODE_10GBASER) {
+       if (interface =3D=3D PHY_INTERFACE_MODE_10GBASER ||
+           interface =3D=3D PHY_INTERFACE_MODE_USXGMII) {
                err =3D mv88e6393x_erratum_5_2(mpcs);
                if (err)
                        return err;
@@ -886,12 +888,37 @@ static int mv88e6393x_xg_pcs_post_config(struct phyli=
nk_pcs *pcs,
        return mv88e639x_xg_pcs_enable(mpcs);  }

+static void mv88e6393x_xg_pcs_get_state(struct phylink_pcs *pcs,
+                                       struct phylink_link_state=20
+*state) {
+       struct mv88e639x_pcs *mpcs =3D xg_pcs_to_mv88e639x_pcs(pcs);
+       u16 status, lp_status;
+       int err;
+
+       if (state->interface !=3D PHY_INTERFACE_MODE_USXGMII)
+               return mv88e639x_xg_pcs_get_state(pcs, state);
+
+       state->link =3D false;
+
+       err =3D mv88e639x_read(mpcs, MV88E6390_USXGMII_PHY_STATUS, &status)=
;
+       err =3D err ? : mv88e639x_read(mpcs, MV88E6390_USXGMII_LP_STATUS, &=
lp_status);
+       if (err) {
+               dev_err(mpcs->mdio.dev.parent,
+                       "can't read USXGMII status: %pe\n", ERR_PTR(err));
+               return;
+       }
+
+       state->link =3D !!(status & MDIO_USXGMII_LINK);
+       state->an_complete =3D state->link;
+       phylink_decode_usxgmii_word(state, lp_status); }
+
 static const struct phylink_pcs_ops mv88e6393x_xg_pcs_ops =3D {
        .pcs_enable =3D mv88e6393x_xg_pcs_enable,
        .pcs_disable =3D mv88e6393x_xg_pcs_disable,
        .pcs_pre_config =3D mv88e6393x_xg_pcs_pre_config,
        .pcs_post_config =3D mv88e6393x_xg_pcs_post_config,
-       .pcs_get_state =3D mv88e639x_xg_pcs_get_state,
+       .pcs_get_state =3D mv88e6393x_xg_pcs_get_state,
        .pcs_config =3D mv88e639x_xg_pcs_config,  };

--
2.34.1


