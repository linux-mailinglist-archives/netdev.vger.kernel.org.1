Return-Path: <netdev+bounces-64412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1141832FAE
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 21:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F112A283DEE
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 20:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9156744;
	Fri, 19 Jan 2024 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="An86/9+n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D641C98
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695485; cv=fail; b=MVKQKSBsUU1Nhqzh8SW7BtjpHd1Axs2iKQCLvSl8z/OGVG0W2BnZcABWPHoOm2yMbs1VMQGX8Zia9mp+EwPk50b1BfhpGb5BuKKE7Le3iIXsjKI/w8GCZXqg6FGHW3fpqF2FA1l+x1wa4HTbmE4+EAE4AnfwEitN2ZLYvMLpDOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695485; c=relaxed/simple;
	bh=I0LToVFsZOJZlTn9vjgzkowfTuxupatjo4UajGUEAUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kqvvej5gWkdYMMsWj3OadUjn9/z+GcdtAvimXcXFsrU/qIPH2vPw0GuEu+IRK93ef2ygzZtrwAYSziD1WXypSsETdzWruAo3Gd4QypKnbZEe3BVTC12TXDLxupYr2eDC+epTc4c/DHreEJUXnLXPT7cARoly2Mtf7avsA3+7adw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=An86/9+n; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVlEI+a7p0r+mPuxr2Zvw9BEHIdoU1yP4iKqZ2RAKDhBnxUWGpZHA3QHxO5b7u+QSb3iK3riEdRGU/JMHz6nwJD3bE3kEOBuAcJQMJ/wefMO7rok/QYrrmyA7TmojuYJnOXHSGgCqCqpwnrRY48bsfhqMR2tD8Rv8OfVuSrMYMx1JyFNapsZ6tOgk9AuzA0a8dA+4/2WyEQA4lwPKq7HKEhjKVbqpEuu/JX07MDU6y8xAWEhG91GpuBTCRUkVbYrWzH1jSKDYWKiWqcePFwY4bdhozYwWDdyQF0e++LXoDKIRIZD0GZGZdU3jPPnxaC5mjcUnjT1ak9Be5EVAk8DNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoioadC1JoE8fz+qWAY/bDTl9TI8drXLUVAkpKie5IU=;
 b=ITBAktSCuy8UmXxnVzJjvpczKiGQh1guZJTrFEY/xsBRMD9uo/TMUovj/gcdZxO8qRw02oB0NIXpeBwDG4KRBqNatX2NyBYpKvb2tasAHImpsU4c4uaAoGo5xmqhL4nn9E6+ihAEvbcDd7+/yQ/FwFIaGCIyT/OAicZiJ+88/NR8gY27Bq5Tuh546Pmy+QnAXe3ifMVy7HBEKpC36A79yU/T6z6QKHE4naWsMOTcozi6ZXHsGZbeeBH9yYPf7jWvaFWadCMwvyzp90WS55VxBxiccgMGZuScxeSLSr0WcRosnLktRYBBWYnQySFTjZEsNgE4AJaIVWg/8nbir0bmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoioadC1JoE8fz+qWAY/bDTl9TI8drXLUVAkpKie5IU=;
 b=An86/9+nKtLhyRIEjxunbGPoMXP4rkYpCv1BCYFMayTWfQ6MopHAL1yDng0nhKIUiAYUv/Z/ogyTWdHPNH/R9CbxHw0BuC2eP9USvoctQzNNHOmwGE0uxUxc8ZdYeu9uZahf3xPEAELJNdSNmQtoitaXiysOajZhMG4sgiZRZHpXbNjHlbZkAChLxVmYWkvE51saIWcbfiM4rrSfYt9Hj/7k8fjpowXtjT0w1p65RHOA3uXnyXo3d2Z17mB3C47El6caMJP2r/ZPzoscw3f2oyvepdVv6hi81pD26+C1kfxNG8QKIjA+fixc/NOCyS1wjsVkyroNHVwwpUFSFTFd4w==
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 20:18:01 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14%4]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 20:18:01 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Topic: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Index: AQHaOAaE4SV+OFEcQEq30M+e72jYobDG55uAgABwPwCAGjhxMIAAH2YAgAAEHpA=
Date: Fri, 19 Jan 2024 20:18:00 +0000
Message-ID:
 <PH7PR12MB7282617140D3D2F2F84869DBD7702@PH7PR12MB7282.namprd12.prod.outlook.com>
References: <20231226141903.12040-1-asmaa@nvidia.com>
 <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>
 <99a49ad0-911b-4320-9222-198a12a1280e@lunn.ch>
 <PH7PR12MB7282DEEE85BE8A6F9E558339D7702@PH7PR12MB7282.namprd12.prod.outlook.com>
 <a6487dbc-8f86-447a-ba12-21652f3313e8@lunn.ch>
In-Reply-To: <a6487dbc-8f86-447a-ba12-21652f3313e8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7282:EE_|CY8PR12MB7754:EE_
x-ms-office365-filtering-correlation-id: 1a220bf2-b767-4b42-4997-08dc192bbc0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WB7guydnCArPoqL3jcsRsCrmwWkVZmKm6/dXMSdvR8PYmhnhtPQgnhQNKCvXkTiWaFpfxopvdybEcXonXfvZnWNVVEkuAn9466m/C5tZWZCmeRh2sdNy9Gg0fbOgh/LQKSinrbBUi0SpYIoqON+zhueJxd36pcIF4IcFVXXiAnFYjAXcaulRcPaKV8hDUKH/Wi77QoY+ka46G3Tw+DyUgTYxy1RFYeli0G1yByDXCJuxwKBnFE+UEt4PlUghCV+q4mPddJFBXCR5YF5PplVRe0mzfbZ09RkpzpXtUDj2qb6xT8fc8jhX6bfk2qUGlwGaFF+GqFXtmECZ8QfTYes99QsecdkPuXzBYqAmvR4VkCMaxO0hHhRUwAsqt6qkEbCjjFJkN/M5efyTBiCTJUPQ9J4dLdVD7UD7hZO/OWVTe4HFSFh311zN9+u5lzq6VYaoAfMojRCdYVi5PYVcJICIBgUjnYdksq8pqkDShFAGEt+is0Jmt+bblV6AkDSRgwrH+ka4sRp82yfGCyKJFpFNF1qJunEZtH6CO+Nv0nBLnNH5ciyJ8k0GfU/8imbjGSQkckg+ZY2qcbnCJBqusngkFhm5wQ5oIwBCuenasgnuYtgBcP5LCknoqDDlO7qfENQt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(9686003)(41300700001)(122000001)(86362001)(2906002)(38100700002)(33656002)(5660300002)(54906003)(6916009)(76116006)(66946007)(64756008)(83380400001)(52536014)(6506007)(66476007)(26005)(66556008)(8936002)(316002)(66446008)(8676002)(107886003)(4326008)(7696005)(71200400001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zIaz+2WGt46gmBN/D8kX7uwOyZ+jmePfVpAJDfsrI0knzTUDypSbmwQN9qFV?=
 =?us-ascii?Q?i5n0KQu7iz+KMHle1xMjHH49t3amXDQa4SxbT2WqS7UTvHF0wZN5dC3x5ls6?=
 =?us-ascii?Q?YG4OMIJvFkJjgO90vR08gnGs1/YKrX8lO+IpH2w2nB/b58aRjrJ/UyZEQz5q?=
 =?us-ascii?Q?c7Z0Pd57O99mxM+8ICsAtbgs7G9UPmKU+2cGdfdruKEkn/cTaXRGNaezHKzz?=
 =?us-ascii?Q?7cL8GE8lN3H91jWWctcxl8eX2wfQgjvdNIey0JimASZ0RpMfysqzDhN3CJ/n?=
 =?us-ascii?Q?jKPCKvZzKZBCEnsDlrUVEuF7oL8FuHxaXsBH9gcri407vHQhBaHRxKMb8gx1?=
 =?us-ascii?Q?sz3eGe6fx/ix1nN2dICsNGwCu9fjsCjc9omR93Y0JkDb+yvKwcGv6njsp3X7?=
 =?us-ascii?Q?9nSE7SwAjWNAiAPb5i1tp4JJnKm+fneZrEq+LGxGjFWQvaw9DngmyvBnLMFN?=
 =?us-ascii?Q?N9zajiG0hVawKLHODyET1e7sWKM7C/dM+9zLZKhSk/VThsSXqi3QAfeNVL40?=
 =?us-ascii?Q?mlv9wjp9ROmLm6R8m7+qPevv4A0MNTMdb09oPcjmDsINhr2ajCwKfZU6jnBS?=
 =?us-ascii?Q?8KN7m2BMAsKpK1kZUkVecOVkd83lnFVyp+46+FhNXC5dwnPrni//dPzb5gqv?=
 =?us-ascii?Q?8xwLp/VFbKVYgCFTmFQRkhOqmXCZX/OjouUMbzIVBTwHZ5Fu31rnFbF95FPF?=
 =?us-ascii?Q?dwYoF4OUmzsEN64hT7X18RtsipNogm4g/TSmHVX7Y2nMXD8CqtxWbZ3jJtFs?=
 =?us-ascii?Q?dKaG4Q4hxi1kLCxm1UBO8ZigcpaA6H+tFqZE2kPCPITvb5rsH/sQaTMiUWYH?=
 =?us-ascii?Q?JGGCT4zXffk419HQNkqSn6ghP22VGByaVNa3GSrOJRvr/pq0QkEaHsdIG8ew?=
 =?us-ascii?Q?UD45IEePXNuSsMWsYnT45ZwQJDfqEEb92ycmUkB2plry+DQSGB5zSfB7Rdyj?=
 =?us-ascii?Q?0Zu7hBBxXOViPweq3+bM7k6JGQU3TQs00E9AORGIYVyUnWsBk6LGnFFq2Hqx?=
 =?us-ascii?Q?7KTufUDsrM2yEiRN/FPImGERpOZf+wBl8G9CDdA3LVDLHRu8LoHg8X5TO2Yj?=
 =?us-ascii?Q?qyc7X9VTyxTpwTOBxLY5fcYGGcuKGmHda2qo8MJbk/rWlWZJAsypBzPPfNsg?=
 =?us-ascii?Q?9cNCsrsqMjFA2e+LQIljLTvKyUMS7vSOjxERs5uMfxaRofY7/nAM6GznLLFJ?=
 =?us-ascii?Q?NFuKHAFlmBGKm8p7bK/FInQTZ6iAQfGH+4E819xDDYFZqcZX8qsN4dJlciiV?=
 =?us-ascii?Q?fX3KBvZoWwIBqsklIcu2nUhAjd/39+W9393BkfUUnnDviY/P0tRwoMLqbwuR?=
 =?us-ascii?Q?UEuEaRRK6sE39hOH7EBhjmU4wIhFohCAyUgMfA4lhwtlK55ya/XMXP5YRmjb?=
 =?us-ascii?Q?+Bm68aHiKGIaY8iyI9v7FKaO20mNaGZBLdXM/pd1hnHGx5XOuGPVipYo2bkx?=
 =?us-ascii?Q?1cDPaudLDfb+Qwx+EDgOD0rxj0nz65aD7RiuE+DP5K7ORSHDt6xUGm4JrkU8?=
 =?us-ascii?Q?79J2XediPutzOmWUXdwSW5l/FmhdrVjIfhVVnMzx9kBvMptdlTWZbNbJxIhN?=
 =?us-ascii?Q?agMEHHEmmSXstY3MnKc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a220bf2-b767-4b42-4997-08dc192bbc0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 20:18:00.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9kxAviTLsVCygQVzXWhrRjMLIEoRD4FgKng7RZ0AFeDjm5HCeo+kHSQAoR+NUGRj9XKVuyCeckQma11khW0oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754

> > >
> > Hi Andrew,
> >
> > Thank you for your feedback.
>=20
> Lets try to figure out some more about the situation when it fails to lin=
k up.
>=20
> What is the value of BMSR when it fails to report complete? You say you a=
re
> using interrupts, so i just want to make sure its not an interrupt proble=
m, you
> are using edge interrupts instead of level, etc.  Maybe i'm remembering w=
rong,
> but i though i made a comment about this once when reviewing one of your
> drivers. What about the contents of registers 0x1b and 0x1f?
>=20
Yes I dumped all PHY registers and didn't see anything suspicious besides t=
he autonegotiation not completing:
root@localhost:~/phytool# ./phytool/phytool read oob_net0/0x3/0x0
0x1140

root@localhost:~/phytool# ./phytool/phytool read oob_net0/0x3/0x1
0x7949 //aneg didnt complete and link failed

root@localhost:~/phytool# ./phytool/phytool read oob_net0/0x3/0x9
0x0200 // correct advertisement from PHY

root@localhost:~/phytool# ./phytool/phytool read oob_net0/0x3/0xA
0000 // nothing detected on link partner=20

root@localhost:~/phytool# ./phytool/phytool read oob_net0/0x3/0xF
0x3000 // correct ability advertised

root@localhost:~/phytool# ./phytool/phytool read oob_net0/0x3/0x15
0000 // no errors

root@localhost:~/phytool# ./phytool/phytool read oob_net0/0x3/0x1B
0x0500 // no pending interrupts

root@localhost:~/phytool# ./phytool/phytool read oob_net0/0x3/0x1F
0x0300=20


I also added the following debug prints. Please see comment next to them if=
 they were printed or not during the reproduction.

--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
static int ksz9031_read_status(struct phy_device *phydev)
        int regval;=20
        err =3D genphy_read_status(phydev);
+        if (err) {
+            printk("ksz9031 genphy_read_status failed"); //not printed
....
          regval =3D phy_read(phydev, MII_STAT1000);
+        if ((regval & 0xFF) =3D=3D 0xFF) {
+          printk("ksz9031 err"); //not printed


--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
      void phy_state_machine(struct work_struct *work)
        if (needs_aneg) {
+        printk("needs_aneg"); //printed
          err =3D phy_start_aneg(phydev);


--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1718,6 +1718,8 @@ int __genphy_config_aneg(struct phy_device *phydev, b=
ool changed)
                        changed =3D true; /* do restart aneg */
        }
=20
+       printk("restart =3D %d", restart); // prints "restart =3D 1" so aut=
onegotiation is restarted by the line below.

        /* Only restart aneg if we are advertising something different
         * than we were before.
  =20

The above prints proved that the micrel PHY started autonegotiation but the=
 result is that it failed to complete it. I also noticed that the KSZ9031 P=
HY takes ~5 full seconds to complete aneg which is much longer than other P=
HYs like VSC8221 (which we use with BlueField-3 systems).

Regarding this comment in your next email:

"Please could you check that /proc/interrupts do show level interrupts are =
being used."
I don't think the problem is the interrupt. The interrupt for link up is is=
sued only when autonegotiation is completed. If autonegotiation is not comp=
leted the link just stays down as indicated in PHY register 1, and no inter=
rupt is issued.

Thanks.
Asmaa



