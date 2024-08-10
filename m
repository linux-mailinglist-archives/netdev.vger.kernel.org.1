Return-Path: <netdev+bounces-117333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E59294DA4C
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A811C2122F
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 03:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E149626;
	Sat, 10 Aug 2024 03:33:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2108.outbound.protection.partner.outlook.cn [139.219.146.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414F4F1F2;
	Sat, 10 Aug 2024 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723260789; cv=fail; b=Pns9BFn9r/aF+16KpQJbaamtx4PWXldq8Cdb2CntHXCnUY+rb+w/wa9seJEBtKVnmOfUUWhbPoDZ8AggxrQ2ZeGnfY6NU2LqDLql7YwbMZPehFHfkCEUT5sFdW+kZdXIJaSl9yH2HvNk77aoh/3QSmPv7BFMGw/O3XeZoQ8+2Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723260789; c=relaxed/simple;
	bh=G4j1U1PlCWV8b6x26ZSBJatkv2Dso50Fgxh+cjKW+aQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B0U+fYLcHlJSWvOMJgnn5F40H/q8gcBokuKXUl8UlQxWcwlSQCxoF9HaytTw5l7wl8Virt7inEVAHGjcpYV+W4OWkwj/AohXgGMmHaBqzVBHMQ841xMY4a3LS0liJqjdSzlJiVVM/uElnP9bRIqImtuFY6/ALtxWZna74NEHWyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sdr3OWi6T1UqHMxJX6cfbe+J9ADiq9X0OjN4t99654HEFoS3IE+mCk+nMIKWfJi9qr2aE+ZmLP3eHhfjblhIpPaBrbz7O+SPro7+HgLwH+l7IfXF4cVtL3YoXoWsTkDtKC+jmS0W2yFR29AzBqvCCmtw6biQaYIYSNVQPGBcsJNvs5nzCxWRDW+Q5bQ6iAiqfB14xAPZM4Kj8o5PhQQKrtA80yM3Wnl8osXDdP+S71U5xFBAwAR36eOOuKox5f/Uso3rfbIEov01w7ltzjoya9SPOOkMBLlmf4lHxVMTrGleJaPPo13jPjyB37m1wKbhSO5Qm/Q81u9DYkZPY5EoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vVI2PJHC3kF1tLCJLAL0/gu4Gxly3m0NKmeGTc8s0g=;
 b=eAjEOCicPo3naFEhkJpJcOndtgcKYFeKtD7IMFv6faZnljAnXfyxEHmgsd0V3Q/ugs6BG5xUOzlIfqtu0/D0Db5IrQ8Jv+ly6Z747r/MV1xZ9qU86/AttwE0/yeixRJOxoVHMV/Zn9fXETsaG4UuBXKNvVsBTUkXQsSyJ7s+tSuYVBznRehzjeFHTeAfe0/P8tKELOhDuk8ETWocsY4iVUc+3liG9aTNjwZWTHVD1/2uu1KdtRhBcXQ7+WiNqavs+yZW5ux3zQFeK8KeIdVzUU7Ql1SnUC8wHRtMVMz8fjOi7HvR6rOkRgAzRUB+/g2DNKfMAbubnsA7EErneoCkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1115.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Sat, 10 Aug
 2024 02:58:51 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%4]) with mapi id 15.20.7828.023; Sat, 10 Aug 2024
 02:58:51 +0000
From: EnDe Tan <ende.tan@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>, Tan En De <endeneer@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>
Subject: RE: [net,1/1] net: stmmac: Set OWN bit last in dwmac4_set_rx_owner()
Thread-Topic: [net,1/1] net: stmmac: Set OWN bit last in dwmac4_set_rx_owner()
Thread-Index: AQHa6mpsL3AZAh6pMESP5aqe4vpacrIfX6CAgABUEkA=
Date: Sat, 10 Aug 2024 02:58:50 +0000
Message-ID:
 <NTZPR01MB1018A388BD187A1CB38833B3F8BB2@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>
References: <20240809144229.1370-1-ende.tan@starfivetech.com>
 <06297829-0bf7-4a06-baaf-e32c39888947@lunn.ch>
In-Reply-To: <06297829-0bf7-4a06-baaf-e32c39888947@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB1018:EE_|NTZPR01MB1115:EE_
x-ms-office365-filtering-correlation-id: 3d8db981-56be-44be-58e5-08dcb8e85cdf
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 FpRRJ3W4nbrCUsFS++vsEalEZWBSXXfef00ck+4yysVFR5KVAtcjEzWXQmtRx7RHCUk4YBNEIKTQNwfxYzjlz1aY1RiLFefoLz+OPF9xz3QIP4j6IXHv+OEcR8iI8kAODATcCH4Vr4WPvu/bgjYEXoiBbkJNrSeOQdu1QDKlCxFg/KDFnFbMEuoEcQ1x4BXH964mSc34EMUbsldd8g7O3STgSPtfRx05KyTovwyo5FkogUnyLOVWsXp/KL9HIEHw+auo6pyag1O9x6MS22kkXhDcEICwjSux0IRI/AXrXLnDNn494nGs27GvX2JrdWF42Cgmliww+SGAP3eSGpmET+2t1VsI6OB3Q7JPfdET0gPzX+tekbdb8gXR9sFcLZPaBrwQzEmy49khdJjOYkU3PJj6yqZscpVdZebksw0jRr83vUet7YSe29dHYkvrOUNLSDXXumSm1s+5LHVj9PSUSAS65DnOO/RzmHKv9Vlgh+qcYkMNftaYXkgMJ9UyMG+T2iOdU0w5YmNLCw0hPEef3K1ZwoSlo59IcllyII+QxDuaKDfUFAVYCJ5w1Xda3hv0kyq/0Qhjb+FaInp/ozNAremFonBKo6xgLmO2u+8WZvbgMpP3FJy0gQGw5Pux0Xdk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tXzMgkTVsOKCrjHI2tiI7cNyJawB+/jntcy4wn2GRu9H2WN8M9XXLA0MGJXL?=
 =?us-ascii?Q?psoglVrUgor9Rao07uF+GfTQzhnRlh+ITK7yPpSyuKmTGvew8FWIvy8L3WyO?=
 =?us-ascii?Q?It2DSi4RSqQ48WGbho3qxnMyOk+1CaXaDoeukf3GOUy/+RBwk0UZV+Qg4rnZ?=
 =?us-ascii?Q?tOXXtlAL9T1SUqCjYvTgnSiRtbTfDM4QTxxKUgmZ3cASgP6kYZNpNcDNOjpE?=
 =?us-ascii?Q?XSV+qRSVc/I46uxxXxJsI2fVWIYXcHYWlEb/ggRBMzSCYsfNGD4P/Z0biDZe?=
 =?us-ascii?Q?FQKzqKD0xKp65hSzFlefP3pzC8Ao6IRj15ZTPaJcC3qYoKv8RXoCqoQR/le3?=
 =?us-ascii?Q?gAxyajdWAHi4zP+Pw8+GNtxWp4aeV46CDx4cecuK5WyqEBIW7AZDokxn83zT?=
 =?us-ascii?Q?IPYSYConKLWmWf5ny4KLq8ckCdKwV1qPiubZLXClwi+AKDMZ5f1D6adGcstx?=
 =?us-ascii?Q?4HrK73KpRveqsxpp7C/gFaFfHL1hdUd1aY6vUDTyaAz6aYDlVMU3q8E9Riat?=
 =?us-ascii?Q?c3vNSmYG0jfO/LoMVddRZah8d+Miv5Avwicpcq+wcwj08Wo1q6/eEz+Tbfbs?=
 =?us-ascii?Q?6l6caAsuiEs8FJQZlXpufLr+NxyyUOXWnCrXcankZU5SlOiTzUBvEPbvKuvz?=
 =?us-ascii?Q?8P4WaiJb1vNs4ESvG9+WK3LzW1YFb7gEU+AsOSk0Wh0/3q82Ql+oAGECFFZX?=
 =?us-ascii?Q?KKxGDas74NjbAoto6B6ehYM7xIJiMnanN0QY9QtZLMYJOdEmKY7VVcXgcs2y?=
 =?us-ascii?Q?EtXxIeGDDf/Y6IqxwdWpjO9UJ/bgAqC6IYNPc8AX7XOEwE308ELy4/+HbVQI?=
 =?us-ascii?Q?FmcdSrTM06OgXtQrXZtxUij4Ar47MT/+xHc5v52TA+/tUPSQWv26jGIQj7qb?=
 =?us-ascii?Q?qqbYQjEEpKPZTI/oGFuMPdgxmyWJLR3QPoEZbpuTDrW7oaQhCkkT9u6JrcIH?=
 =?us-ascii?Q?Ap2aOr5TSnSr3KV9223LBEBeQ7ZRxce3i1grQGD2G2GPO8gJKp7/c43lFV1v?=
 =?us-ascii?Q?mIl2VkOSYisEqxmenD6W9ZyuxMDTJUKUHXCyvKdyMz6b3wM352Ndwj8UgcHr?=
 =?us-ascii?Q?hdKNSmfH+bJa0o3prsV4BA4gwKJkactHYHgECJ8yMnYELIsqGnzWOWQYMsij?=
 =?us-ascii?Q?gR2meAsbF4Ibn5U00OyCyd8kjx6fjJF+8mPFCZICyfIAMKQt/et88B+atm4W?=
 =?us-ascii?Q?3nafcOkNOKRRj6U67ra7w/2uC64Kxy0N2TA8dKANUrwOCZ6KfPkWExfDI321?=
 =?us-ascii?Q?o6sY7zCeEiSj4C6QGeyZFK042kHD7Hk3W8Wpn8jvmZ+BnvsaEbltpP6xpFiR?=
 =?us-ascii?Q?FcLC6tVO1Dyp2kSSaHj0K14svOV5El108/7DFp2xB9IXMfSpVywBYu6GBVu6?=
 =?us-ascii?Q?00pY2d2jUZMiiZYAQuel0oEbIhHWGXHW1YAoAywfuWHTUI3TO16MBFztZtxZ?=
 =?us-ascii?Q?U2BQJWjwQ71nnoqLnwF7UbxU/aSQUDHZit1GZu/EOJT1VuK5nR4uqEm27YQh?=
 =?us-ascii?Q?6tXCCYXVhWDDB1kM5uqGHHUKYTwa+BzfYxuVn+5PZPPVbTePC4u5VzmaSn+5?=
 =?us-ascii?Q?2fsq9NQXK6aQOpRj+2gISkupiGgmY1EtHLy9h+TNZUNYU2TRAs7dn/oJvQH1?=
 =?us-ascii?Q?LhTjkHPkf61QfrjWsgBLAlh/qwM/SZMnszQOlHJmKmSz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8db981-56be-44be-58e5-08dcb8e85cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2024 02:58:50.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/lYMU58jYOkiDHIK1qBhf4tydBR075jW19RheN66rMotFdiecFIQGttc/MD1+lWTpCHI9wrex0rnBAKdDmyRDw0qejWcxmpRiebeeHDbqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1115

 Hi Andrew, thanks for taking a look at my patch.

> Are you seeing things going wrong with real hardware, or is this just cod=
e
> review? If this is a real problem, please add a description of what the u=
ser
> would see.
>
> Does this need to be backported in stable?

On my FPGA, after running iperf3 for a while, the GMAC somehow got stuck,
as shown by 0.00 bits/sec, for example:
```
iperf3 -t 6000 -c 192.168.xxx.xxx -i 10 -P 2 -l 128
...
[  5] 220.00-230.00 sec  2.04 MBytes  1.71 Mbits/sec    3   1.41 KBytes
[  7] 220.00-230.00 sec  2.04 MBytes  1.71 Mbits/sec    3   1.41 KBytes
[SUM] 220.00-230.00 sec  4.07 MBytes  3.42 Mbits/sec    6
- - - - - - - - - - - - - - - - - - - - - - - - -
[  5] 230.00-240.01 sec  0.00 Bytes  0.00 bits/sec    2   1.41 KBytes
[  7] 230.00-240.01 sec  0.00 Bytes  0.00 bits/sec    2   1.41 KBytes
[SUM] 230.00-240.01 sec  0.00 Bytes  0.00 bits/sec    4
```

Used devmem to check registers:
0x780 (Rx_Packets_Count_Good_Bad)
- The count was incrementing, so packets were still received.
0x114C (DMA_CH0_Current_App_RxDesc)
- Value was changing, so DMA did update the RX descriptor address pointer.
0x1160 (DMA_CH0_Status).
- Receive Buffer Unavailable RBU =3D 0.
- Receive Interrupt RI =3D 1 (stuck at 1).

which led me to suspect that there was missed RX interrupt.
I then came across dwmac4_set_rx_owner() function, and saw the possibility =
of=20
missed interrupt (when DMA sees OWN bit before INT_ON_COMPLETION bit).

However, even with this patch, the problem persists on my FPGA.
Therefore, I'd treat this patch as a code review, as I can't provide a conc=
rete proof
that this patch fixes any real hardware.

> Is the problem here that RDES3_INT_ON_COMPLETION_EN is added after the
> RDES3_OWN above has hit the hardware, so it gets ignored?
>=20
> It seems like it would be better to calculate the value in a local variab=
le, and
> then assign to p->des3 once.

I didn't use local variable because I worry about CPU out-of-order executio=
n.=20
For example,
```
local_var =3D (INT_ON_COMPLETION | OWN)
des3 |=3D local_var
```
CPU optimization might result in this
```
des3 |=3D INT_ON_COMPLETION
des3 |=3D OWN
```
or worst, out of order like this
```
des3 |=3D OWN
des3 |=3D INT_ON_COMPLETION
```
which could cause missing interrupt.

Regards,
Tan En De

