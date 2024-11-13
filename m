Return-Path: <netdev+bounces-144369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0740B9C6D60
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3829283D92
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F098F1FEFDE;
	Wed, 13 Nov 2024 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KC1SxhVY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63021FEFAD;
	Wed, 13 Nov 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495957; cv=fail; b=LSmnTgDKdKxb0RStUITK38FqhH9mbAl3kFUZMZSoXkqryC5UQNGqqUlP2j100b/pocfHlVVvwkPDk6OC6po14/nHyDxtzM3FHddO0F5wp2FCmWcMqRnjtJ/+y/6vDWJZV5gxTPI1aZUYtaMNrUexfIhfKBJ8fYsmjMnAjj9tTdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495957; c=relaxed/simple;
	bh=rxxUJwLyjQRhaDExrklnelWNxMRm7eeN+8Ppv6qCkLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PsBIDoTn/h1JCOd/sIyxsbJuKojeXcxW3OBZ4yoj81V9onF6SGYIw6dbABDechWRsYzSdm8ycMIhRogNqEQ3iM2p9+IGUOUp/jR3VTp9l2Rz1stzBYM7pp+HbZ7j20f49PlOI6Ev3UpnGMZ2/+0aOXt4aVp2PzRl4tdxz5ivIX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KC1SxhVY; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbWgo1qhsVJGaHzbjFUwDWnvub8tukw/TWaDK1WiRcBqg2/wwPQtD9rnTr9xroK1QGHOzFsQ9x4JXm9woUzoiemwodE8L1R0lCKr6xtz7F8ZzRgwgMCSV6O2mRQvs/lmTJALP/NOIpwXqj38UsYlX9qcb0Z0K/OrBRGfcWkfP/3obE61nQiPzv6e+6mHnfZ+t1DM9aPnmvJjxlPOl9FePPXWlG5tEATSoqxwTUehf4H2nisKQHZTxnQQVYeIz2fSz7aGpGjyNuLX9sV2d+Ikhzc7LcmjSCS2PjRnQLGgTvM4bYT/XHEv+iqIOnP3DSbhzWGXGDASya0a3ZUde+y/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFxM1AFI06o+yvHELlYz2TzqXGrrOjLMAAroXYuyLB8=;
 b=h77VsHhiBS8iM1O+ZwBPhTf5ccgSu5adX70FF5NthxQgGj7UstmSCRmVL5wXW965i+q5+9eH4Nb8/Wqyfsa/xXM66T2jdsj/RIG/6Ed/FTtcDVyV8qUAU0MqCEDlFPXZDJKte3KEOLLzrYvTxvgADAfaay9zMRbmTqycg4czUDXy0HsxwrndXh/CFNUcMM1IWz14mm/0p8zL/zfxR4LgG75yWyLjXI/dUhEnY3+hAw8ff6BCA1rusrlqBooVLr1g8/hdYnwN/9FgtJsXNMv5adlW75BiVskmoqOyu3aef6fh1JfbyPWMXi5EPmF3EgnyUy6hIgTirXMTZyWUVhoN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFxM1AFI06o+yvHELlYz2TzqXGrrOjLMAAroXYuyLB8=;
 b=KC1SxhVYYqjJBpKPNlrNXizXLCeXVemIhaRKSxe+9YuYzgr3p5nDsiNtd80zIKnhk0PvkkvB6z1X/xR05x4ujxdg3itDAPCxXxO7KcAcLpU+JTbAGQKsvWP/ZHGDzmacwkksLmM/71qMSoruYKNnK6v5jN4uVPCul7Zgk02dumPm+sjEoq/vdfh68AtGyKDY36ylIzlFJqfRLr9HDSkQv7m2DuZU/9Ju3pxQ932Q53EUQuGbRdrAWl0SZQtviOeYeWEJjxXftYk+SFb28PEKll1uDYF22zrmdWIwSbt5u2qqbyyQputEk0jQmv2j2TwbaAyJzqKbjb8yYW4Mxr4cKg==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 11:05:51 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 11:05:51 +0000
From: <Divya.Koppera@microchip.com>
To: <kuba@kernel.org>
CC: <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next v3 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
Thread-Topic: [PATCH net-next v3 2/5] net: phy: microchip_ptp : Add ptp
 library for Microchip phys
Thread-Index: AQHbNQgeVkJxLAhi8Ey0kFel6qFDyLK0OAYAgADVXRA=
Date: Wed, 13 Nov 2024 11:05:51 +0000
Message-ID:
 <CO1PR11MB47714631E6DBB1AAF54A00C1E25A2@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241112133724.16057-1-divya.koppera@microchip.com>
	<20241112133724.16057-3-divya.koppera@microchip.com>
 <20241112142014.044ec21c@kernel.org>
In-Reply-To: <20241112142014.044ec21c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|LV2PR11MB6024:EE_
x-ms-office365-filtering-correlation-id: 4bae9c42-bc8c-4432-1387-08dd03d322fd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AvrFZHT8uvmAomiRUOnvY8zclQg9em1jRD+IFCIg9Q4igx4v/iHmZ10z3fWy?=
 =?us-ascii?Q?X4Cg2xRrGFNIW8bvd6xCWn1vKGG9tM8gSM62z1Py3lNmprgUt5JGkZ5ogrW7?=
 =?us-ascii?Q?UXb0oQcvO1WJjF0NolUH7x7QKYBV4tiSBJtZFiXogibfpzQfLN090128KWjw?=
 =?us-ascii?Q?Cnmo7cS/Qp/4hYoFbs82lnviYTXXRkuVbeeOsTeDXdarOMr1ptXCxvXr2drb?=
 =?us-ascii?Q?AlakImutz4SwosG1ZaT2kCa3zRQRed7ibQchZ7InE1pMYUz58+J9iFrd+woG?=
 =?us-ascii?Q?SlN3qZxf1/JfErHtzIRh+oRwk5IGxE8ETxAB3ZrX2RTerTpQqxBhTlCwwfFO?=
 =?us-ascii?Q?2EJLFZc6uJwlJsigoO8clKy6243czLWi85RTi8dkDmwjHzVlAiuHCAG/fKNN?=
 =?us-ascii?Q?4hnNQn6KSZuoUcxcxHIEbthV8HEDFISQ80T8WQCFh6NiiSjW+Jmq4M/xsnsh?=
 =?us-ascii?Q?R+dAffSumymXngD0IvkIvZpldAvzygfBADNkeTowfnvUQ9CBs5ZpYXTE6lkJ?=
 =?us-ascii?Q?Ns0qgvd0m8XoOM85tQ7FDyVcnmxXCpH9MX+DW2i6COy5RZBkNASmvJGbnzaN?=
 =?us-ascii?Q?9PYFPOzGSMC2K8msV4CKPB7ViQqo2qBShU+QRialvYHaeDjCyB8WgNvtIftl?=
 =?us-ascii?Q?DZ9s0ytIeRmEUMWN49Xo0RlKbSRiYl8U5Np39hXTPheyrtcRfYbU038BBVzd?=
 =?us-ascii?Q?LPDuLxCWCng0V5PkTqLGudedxdReRvLtruANUVYBupfUqIwKIY7Jz8nLZRcW?=
 =?us-ascii?Q?pNelc0+DFEUfQznFnthlKsIBftpR4PLZvlbMdD/nrSP6jQXYUAZ3+noi8IFe?=
 =?us-ascii?Q?74O+QXCtmAHgcnDLotnNI1/cDo5spw9Xes+AdQKkBiU65sUx1INWCZbbXEEh?=
 =?us-ascii?Q?ln/ouJ5HbGwQ11WT2VCHxfR8zJtP/hzZNCRYgqBrBND/V9tHcqJXDM7fOTM/?=
 =?us-ascii?Q?jyNxACYzcXOr4m4o4TX0XyzKfb1quIweLdHf0WCFdJkLUovEFHgZW25JCUlw?=
 =?us-ascii?Q?yRBxVHYg5rMDNsFJN5i1LBopiws43MmMLJX7rgcpZ8ikQ+xKUOrsK1nZOD/w?=
 =?us-ascii?Q?BeCPvLGzWQ6BQRBo2D/Mcotxr0W8wBKw+Ml6CsyxuqU8BR8LzHcSbaUM7JVa?=
 =?us-ascii?Q?JVDUoQJkXm4tFfpNR06yz97O421unMzayreKpED4aQmg+woGUZpzx8fYpaq0?=
 =?us-ascii?Q?+s0wl4UifTcrWPChXP6+Oq4M5x5jFTgAcvS4kC1/j05BRkAFK9bCO6ollXcF?=
 =?us-ascii?Q?HxNZXEgLVd8UjjGa5LpU0VI7a+/fSNFGAKTnkEKcybC6eip2l9Aj4GQ/ydg1?=
 =?us-ascii?Q?SDWz1kEoD4V5hhXnZRQfpIMjKABxbkbbeXgcJat5CQAersc+XFO5Wlpm8INn?=
 =?us-ascii?Q?AdtIH9k=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cJK5MKYLHmeiZfkPsW7hJ+fscm/DU0ii+AdifHy/T+3EvZH2uwCyq3tgYaOs?=
 =?us-ascii?Q?HFg7wI4Ml6rSzsrrH1j1L5OJV4OnlVRiHIxPYTpMcXshxRwo9GHIHYxJQ8Hi?=
 =?us-ascii?Q?jvVisJ79lcMx8we8ZcdV+Ffc28GOwH3fDdkwCpcEoaKw7k8wHqSFFfquQLpK?=
 =?us-ascii?Q?hH4uNG/CEEnAv96amjUI7DTrjgnc/vluR4mt2vKheFFsd+vmUDkxQzCtCBtz?=
 =?us-ascii?Q?ZusE5H9+LneKDipEZH9MToh+Ig2hWQuGe10szOfQA8jjMJIgWmsX2ayE85F7?=
 =?us-ascii?Q?l+H78V5R+ytFeSvDH7QoD7ZshSBW0Gx0g363VKc75kqd8KdG8c0U9yhW75wE?=
 =?us-ascii?Q?8imdSyQ/S6oLyOZ19Yuza5s3tTvbkS5UzuxQ7lPfPW9T3KFezudm7JyZbC4m?=
 =?us-ascii?Q?dLef7XBRw29xWUcfr/Vtq1AgVcgTF0oXg9l0Y1zrfLrY0b21U++7kqS7xqzg?=
 =?us-ascii?Q?GDWK+WHV6IWFbjGL/eZmo+YBOVAU8JAT9nunOnW5ge8fRQrW1UShsNEM1o6b?=
 =?us-ascii?Q?fq0ffuMk5JtCqfObPrPfUgDIJKP/9YDtLISoW5WZcoVttGYt66YeXrrfpxwT?=
 =?us-ascii?Q?hJ8euFAPd9vN6hmF8uJoE6XQzchFG6x/ABmJwdwpcDQ/LCclxJYmshs93jFg?=
 =?us-ascii?Q?JB1JBXS/DpO7qlnrMkgViCDSpylSdMr8H5peuBT1Zdr+e9ccGMvPmc0TYJRm?=
 =?us-ascii?Q?NHx8jmhvKChIEqg3IAXNo8B3splb7nu234u3kYcYwKEyWaJJPoTKNDORG2Jh?=
 =?us-ascii?Q?9PtbTsyMp+D8/MCQJ/rjv1qmPX8g3zAX7JbpuKxf37VHTrWRnV/adX7z3c4d?=
 =?us-ascii?Q?GCqIPEs2xO3/BGRc5NGzA/7fNH0Q1Ll0q/G+W0Ekn5YayfSARBNNHe6kdEDp?=
 =?us-ascii?Q?bMXWOeD35+hj1B7+VjbQ+1S5QH8X4/RP1Cb+R323lbe+cDLUP+qM+ZR7dNAr?=
 =?us-ascii?Q?jZbs5kFpqzWTXUofhdk9gg8Z0HrO1l7zfwV2v0vtXMn3uzYPzlcHOvJxiIvU?=
 =?us-ascii?Q?8vD6o2TiMa/pYbzpHfQNDdDIxvlrtzkDxxZgRnovvtP/2zyDszxl7hi/QDdK?=
 =?us-ascii?Q?tTcX77XPoJ9iZaEODsCYoOeHRBaReGSxPHR+8u41LUXmBZY0PTuGDmbbk+7u?=
 =?us-ascii?Q?QE49AbuUuq+hR+I9IV/l81lOaCK+zEUy0xll3qv8X/eCRqjArNuWDkiUhOGD?=
 =?us-ascii?Q?3TS4oXMJH/rbSl0ncbNlFZxH0RKWIqNuiotTOmR5hThGDNrQzICn1P/mDMPi?=
 =?us-ascii?Q?NiLCKQw233vva+elNqrLwUffJRsjY9pxeQiOaTmDHS0/fa4E3tcDCUvxZAun?=
 =?us-ascii?Q?GXatz8o2ceKcOfK+t0kd1XpYaHIvH0PpmuIBeUFxebvV8NaF7oPD9PsMcEZ9?=
 =?us-ascii?Q?dL5Aw7VV0pR+dPoOqsm3MylMfP4scIXYXBUt6aEE0Rz0YnSJdyiDL6vparhb?=
 =?us-ascii?Q?H71m4oSKhIt8AfJZuahGx+5AJi6vz2ykmhlAq8pWKdeC5iYz9M9iMwI7zQ/F?=
 =?us-ascii?Q?OYWFCYDNRVYPJ7v/9l4WDqDpDZ2QjPIWxsw7pfSn3duAxnmCAb1UIFY8zZWr?=
 =?us-ascii?Q?FhllZNtkl/QARgQ6bQQIuKPryBSc4OB0gFsfuSAwDkGuALAnKxqOwn9H7T1m?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bae9c42-bc8c-4432-1387-08dd03d322fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 11:05:51.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCzYZ/bGJSlhk92CfZKZhbq2FXu218hJNB94RMfu0ltXixvAs/QywGiEIFnlvdohgVhe0NGm5VZY1nI1EEkWQRjLu0fiMRTRye4iL3rzGdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024

Hi Jakub,

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, November 13, 2024 3:50 AM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: andrew@lunn.ch; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com; vadim.fedorenko@linux.dev
> Subject: Re: [PATCH net-next v3 2/5] net: phy: microchip_ptp : Add ptp li=
brary
> for Microchip phys
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Tue, 12 Nov 2024 19:07:21 +0530 Divya Koppera wrote:
> > +     /* Iterate over all RX timestamps and match it with the received =
skbs */
> > +     spin_lock_irqsave(&ptp_clock->rx_ts_lock, flags);
> > +     list_for_each_entry_safe(rx_ts, tmp, &ptp_clock->rx_ts_list, list=
) {
> > +             /* Check if we found the signature we were looking for. *=
/
> > +             if (skb_sig !=3D rx_ts->seq_id)
> > +                     continue;
> > +
> > +             match =3D true;
> > +             break;
> > +     }
> > +     spin_unlock_irqrestore(&ptp_clock->rx_ts_lock, flags);
> > +
> > +     if (match) {
> > +             shhwtstamps =3D skb_hwtstamps(skb);
> > +             shhwtstamps->hwtstamp =3D ktime_set(rx_ts->seconds, rx_ts=
->nsec);
> > +             netif_rx(skb);
> > +
> > +             list_del(&rx_ts->list);
> > +             kfree(rx_ts);
> > +     } else {
> > +             skb_queue_tail(&ptp_clock->rx_queue, skb);
> > +     }
>=20
> coccicheck complains that you are using rx_ts after the loop, even though=
 it's a
> loop iterator. Instead of using bool match make that variable a pointer, =
set it to
> NULL and act on it only if set. That will make the code easier for static=
 checkers.
>=20
> Coincidentally, I haven't looked closely, but you seem to have a spin loc=
k
> protecting the list, and yet you list_del() without holding that spin loc=
k? Sus.

Initial patch was in right way, due to some optimizations and giving less s=
cope to spinlock, it totally went off. Will correct this next revision.

Thanks,
Divya.

> --
> pw-bot: cr

