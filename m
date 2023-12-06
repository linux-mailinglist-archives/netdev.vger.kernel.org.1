Return-Path: <netdev+bounces-54630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403D807AA9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C411C2114C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769697098C;
	Wed,  6 Dec 2023 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ooma.com header.i=@ooma.com header.b="Qg+0U/Nc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90544D7F
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 13:43:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afk5AvWJADDrc4BZ+0j6pfZyEseIcX28czNmjMp9yMuYbPUogoo6BMz20bCfY48OMTM6wAGw/C5evuTIQaduWfJJVZn5CfeIKz1A7BPRDinkAs1AKmCQWlLwkUkpysZUcjFuAottqwaOQUC5B6kAJge6AN3taLeSXOdLCBb/yZl79oO3KH2x0GnuTOrB6OOS2XDIBw+rUh6eL2EcndWhoG2t8hUi0x3wKZCVv6NszZiYgRkArilP48TghAWjMYPz6EbJZf2JcoTjJykz2Kwr5rLoU4nAVZzHmclvCIa+gJfWg0488NeMB3uzNtNyEAxqcL1uhzdHoc8RSwIgD8WoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itbs/rEjt41qKZ86TY7IDANTGXWPvLpLBHNmbZZw3lE=;
 b=ED/dbE6T4RESHrrU4O1wYkEujdSS3SsgtvMYRaBhgsCgn9xB7o+ggzIJb2dA4uniNLrzHYXzeuDTSwtpzECNztToRSo/Es1Wg8jEPsc2uM4CUH/tObeUw8j8xtVzviyToptP0ZSkQaHoGVGsO5YyGB0f1JA2tTvgm8uJ+QkT/i9dvGSLGHxZPE7snWZA3wTjXG8ecNocvdgduXX9SKoANek1Q5iNlbxCHieBlBx6CQqbnstfA3N0QGwvaLclSJw6V17ECv2IPp3FKRK+MbhNZlxoRq2W2BGhWBcKEmDTjgayDGFrEg5+lDGaJibs3w+mcKv2PCatLWciJMjKvhovDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ooma.com; dmarc=pass action=none header.from=ooma.com;
 dkim=pass header.d=ooma.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ooma.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itbs/rEjt41qKZ86TY7IDANTGXWPvLpLBHNmbZZw3lE=;
 b=Qg+0U/NcUgoIOUsDu13kasEGsuAr/kE3ircILB7p1BBGnOjez/iCeb+fLHjb/Wb8w1H4E48Hlc0kyj3IwPOP/10qmFUnisK/gXp13ALbcgu+vyxfkeTPD5bvK/6nxQnn4PvcuWLS4HeJk6vRFS130JPUyPICNOHDMS3QpFLUVEE=
Received: from PH7PR14MB6163.namprd14.prod.outlook.com (2603:10b6:510:20e::7)
 by SJ0PR14MB6667.namprd14.prod.outlook.com (2603:10b6:a03:4e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.37; Wed, 6 Dec
 2023 21:43:02 +0000
Received: from PH7PR14MB6163.namprd14.prod.outlook.com
 ([fe80::878c:cd61:3b22:1ba8]) by PH7PR14MB6163.namprd14.prod.outlook.com
 ([fe80::878c:cd61:3b22:1ba8%4]) with mapi id 15.20.7025.022; Wed, 6 Dec 2023
 21:43:01 +0000
From: Michal Smulski <Michal.Smulski@ooma.com>
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
Thread-Index: AQHaJ8hvrLygSOh9hkOG1PRLI9YmVrCctw+wgAATOEA=
Date: Wed, 6 Dec 2023 21:43:01 +0000
Message-ID:
 <PH7PR14MB6163385C72F5E88748A9F6A7E384A@PH7PR14MB6163.namprd14.prod.outlook.com>
References: <20231205221359.3926018-1-tobias@waldekranz.com>
 <PH7PR14MB6163EE62811682A3927F79AAE384A@PH7PR14MB6163.namprd14.prod.outlook.com>
In-Reply-To:
 <PH7PR14MB6163EE62811682A3927F79AAE384A@PH7PR14MB6163.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ooma.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR14MB6163:EE_|SJ0PR14MB6667:EE_
x-ms-office365-filtering-correlation-id: 2dc7e6a5-f42e-4525-2734-08dbf6a45250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LOaeDGxysQU+5XZlyyd2XWbtKvzCRvYKpAmicMuWwpW8kbrEowk8g/ZlcmCSM23pXMRK+cE5BksPcqnoQ3JcgKURoJ/776/QJK2xJ193YycQUvELsoBthl5NkuIkUUeLqIpuvXrZjlyEm1r0SzCUAEOuoDkEo55hvVhJhKrUgn1Vp5a6Nf1OKzo7jkUns5D4y+CcxxCh0jyQGmjsDgEzlevdBX0wXcjzGKp19z4FXkNLxv7rHxC9q2sxs4XeMRoXVPdVQdesJfF0FgFf4N6geyUmWzI7KVBEY7O8n6RAeAaOWMaQA7ruJdoFPqIPtSIWQ3PtgBbLRRxKi9fwH0gJuTaY3iwX8O8DIw3wz2OzHGj5ka6vdhqJP/HFhPkp5MmDUK/K/W7/NpSbGhHT6BMj7yxMdyH+jTmQAZrilYvRmfxpzpbqTBC6D2s3voiRrEe8sikh8GL94WVOQ8uknKW0eSStchezbI5atwSEAIE50aJWv7CmoukcJ0A32hl1ZvG0ZZYcdYa00MWA/O/LYJiJS5QITRHPK7FuZ2pD5wu91Gj7+aZb+jqXMRheLQq9YuJHTsnHl3h7wvH/8g9AGY9U6FIHUdk0Gyq36W1yXb0u9C8jcbeIf2OzLjn2WYqn2GCCgrMaqZXuVKUJyKsNqEj+CCeRgIO0A+CIWXZiPCrP3PY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB6163.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(8676002)(8936002)(4326008)(316002)(64756008)(66476007)(54906003)(38070700009)(66446008)(83380400001)(5660300002)(52536014)(66556008)(478600001)(33656002)(55016003)(9686003)(41300700001)(2940100002)(26005)(86362001)(6506007)(7696005)(53546011)(71200400001)(122000001)(110136005)(76116006)(66946007)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?45YoaiTy8sq+W7kU63Gf3MyE3TpB50JzgWKz+sHrAD3QEyl659waDN+Z8T9z?=
 =?us-ascii?Q?3u2IocsvrFS/uBNKryeAl13SvEyigLF1qXLbk2ss6Q1MRFvKPKq73h+62kjD?=
 =?us-ascii?Q?BfWSfpg4nZ2WFmqm9VAIdgjrTwzRdlwEpanu9p52FGyEjWwIQOZb7jJjCZU+?=
 =?us-ascii?Q?mPRVSE5YgmrXg2q8t/uhdcgbhr7avhdO7ib+hFb2EfLWRYUrkbxYKcr8DabU?=
 =?us-ascii?Q?0Pfkc/IQlAB5UI4OBlfpxHkw0Rzb/WwoYdDuir91zNG6Mu78Gh6iyAFFNOa2?=
 =?us-ascii?Q?/uTw7+rrLKdNanT/3qgi4Vo+zH/TXGdl9EPRjdzQdKna9Opuxqv+i8At2PbZ?=
 =?us-ascii?Q?cPtLurUs1tlhnhyRM3MBWUl9QFRp5wrEyy98Gciyqb1+oTWQ+oh+wMqpkBO3?=
 =?us-ascii?Q?bIfleJtzVhb0l9VT+cKN0CtgGDP4/OShKEvp9xzVMZTjNSM413a0FzlkBq8z?=
 =?us-ascii?Q?o0wwdTZrbHToD8JJEVtY3NA6nFH+fQlxMPul9a9rkfZ9RUH00HwgaxFZguvG?=
 =?us-ascii?Q?d5MKNEB03nnsslQqtFYTdZaLVaAOObnqGA37DPUBeED72pwr7VYAX3lerytF?=
 =?us-ascii?Q?3opA+9wbffw6t1jMKWnql+vjdn2GxmuckBMfUf/9ZVLhyPUn2LNGh3IP2oNO?=
 =?us-ascii?Q?teRnLTF7nRBG3kUj0+W8SbtE0T0kBz9akRD16ZYltbnE6/vaM5I0LkuX/DhB?=
 =?us-ascii?Q?pxt8JaO+fDro2rqOe5O629f2DajaI/g7RKqFitMx8y92zfWuWEtTURNpVGd6?=
 =?us-ascii?Q?LTdDyflQ93ahRBqH/tF7mBIZk8AM54RosdPwI5Xkse4uTBtte0bHe+n4rDfI?=
 =?us-ascii?Q?f01h+XW7hM76TPp5d61Jbggfk33S+10gZvmJW54erSNqd1iCsG/HFlWbwPd6?=
 =?us-ascii?Q?nD5V7a84q4xuUbYCDU8Zp4boH4XfWbh9/DtwWSR943LRJsPctq9bc5h4aYLb?=
 =?us-ascii?Q?oJugDiUxWT/6YCZLescQ4LM/G+uOp5aTvo9t55WBLPrzfpVHw2z30vVroRY5?=
 =?us-ascii?Q?vq+DIHUndSFLot875KwKEDd7X5mpFMZC01pxzqjZ77W3Yq8mOD+gEJTXtb4m?=
 =?us-ascii?Q?m3ey92/3MV/fh26uGlwJkZSAcTn8s8p2lpNeE3sXjgdkZ9cNgYpXOWWtmw/H?=
 =?us-ascii?Q?FGRRkg3e5OgL8aRDXvpRGR3TPbZdsehxJ3DGLwT1MTclntuh9lF/JWNTw9Vg?=
 =?us-ascii?Q?8cAZMQCY3EyEuKVkFByVexTWA7KlXIJVTvGDHHGraXanNtqwdVEJUHbECxrM?=
 =?us-ascii?Q?TRIuVUJFzEV+0EFdvEtPjMsMGQ3MfybcFiwfNb2I3NsjzoCg/lLoA6i8aNZQ?=
 =?us-ascii?Q?vcqnNptpvNrMRSwdDrwtrWe96FoqmjU7IvM3q4H2NyeiKdN7zlN++yA3ii7A?=
 =?us-ascii?Q?21IYPf+zYN7dkGYfGMC6mXYzSJKAxKKuMR5wqgYWPYYUcE79pyfXptSKtpnR?=
 =?us-ascii?Q?fpsc/ngqEmz4aTKudXXrPP9DHWc+R2iJpUDU6CxrEzp9fDS25YcoIsiCuow5?=
 =?us-ascii?Q?OKRr0Oq6uKp8G9LA+Td9/BNKphHFYZWhxWY4Ef/2UBRhtXWh9LHR4lb9EMh0?=
 =?us-ascii?Q?41/Hu5x/Y2Huahcynp46iENSJ2dYMWvfTHOA0lHc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc7e6a5-f42e-4525-2734-08dbf6a45250
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 21:43:01.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d44ad66-e31e-435e-aaf4-fc407c81e93b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ls0NhvE3FinYl+tCqncQACeQ8gmBR9AOeMu0dT8PbxcitYHkJqA15VJVOWFN6zpmk+FPhwgHFVCssRJveepIlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB6667


Tested-by: Michal Smulski <michal.smulski@ooma.com>

-----Original Message-----
From: Michal Smulski <michal.smulski@ooma.com>=20
Sent: Wednesday, December 6, 2023 12:38 PM
To: Tobias Waldekranz <tobias@waldekranz.com>; davem@davemloft.net; kuba@ke=
rnel.org
Cc: andrew@lunn.ch; f.fainelli@gmail.com; olteanv@gmail.com; linux@armlinux=
.org.uk; netdev@vger.kernel.org
Subject: RE: [PATCH net] net: dsa: mv88e6xxx: Restore USXGMII support for 6=
393X

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
nk mode [  170.735697] fsl_dpaa2_eth dpni.3 eth1: Link is Up - 10Gbps/Full =
- flow control off [  170.813015] mv88e6085 0x0000000008b96000:02 p8: confi=
guring for phy/gmii link mode [  170.913510] mv88e6085 0x0000000008b96000:0=
2 p7: configuring for phy/gmii link mode [  171.014155] mv88e6085 0x0000000=
008b96000:02 p6: configuring for phy/gmii link mode [  171.119832] mv88e608=
5 0x0000000008b96000:02 p5: configuring for phy/gmii link mode [  171.23059=
4] mv88e6085 0x0000000008b96000:02 p4: configuring for phy/gmii link mode [=
  171.346344] mv88e6085 0x0000000008b96000:02 p3: configuring for phy/gmii =
link mode [  171.472394] mv88e6085 0x0000000008b96000:02 p2: configuring fo=
r phy/gmii link mode [  171.594045] mv88e6085 0x0000000008b96000:02 p1: con=
figuring for phy/gmii link mode [  969.248179] mv88e6085 0x0000000008b96000=
:02 p8: Link is Up - 1Gbps/Full - flow control rx/tx [ 1089.691582] mv88e60=
85 0x0000000008b96000:02 p8: Link is Down [ 1452.761369] mv88e6085 0x000000=
0008b96000:02 p8: Link is Up - 1Gbps/Full - flow control rx/tx


Michal


-----Original Message-----
From: Tobias Waldekranz <tobias@waldekranz.com>
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
+                                       struct phylink_link_state
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


