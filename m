Return-Path: <netdev+bounces-168110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DFBA3D8C4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC53BF65A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C81F152C;
	Thu, 20 Feb 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zyvp+iG2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5E1F150A;
	Thu, 20 Feb 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051058; cv=fail; b=Vv7ZHszKsfJaSKzwHSvgYBQ2zCd8hYJkPD7eGIB2UyxKDjKte/gIdt5hlykLjk1XLjoHro6CsOozH05GvO0XrpIWJCJjz6LyZxfot4n+VpjgIRBZLV/CaPVZcjmLf1mXx43YbmsP4UYU9WniWBS3ybB2kxCRxk3fICbbfdsmF6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051058; c=relaxed/simple;
	bh=vKrO60ttM2iAB+Z0KMRnxkLelYa1FlR2TWBOtmgTaV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mw/1OJOShaLn5M6bBQ+QEdq3a7UCpJFUcgsnuN4zh0RQiyFuiR6yNVo3LbUZGAh3B9Sx5e5O0p9SIRfFcSHodxtk8znL0jmiBk8bHpMxZ3gH8+ecS20tdsyGfzZRiQeK26bNFgJGhEL2rx9mB3mGDaIIVAskI62rztCM3b08t7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zyvp+iG2; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYfak4L6l1M/4Tt6vjopG0aL5rCyucNMsfKCIVGLpSI/+SKndKZVTHVkmdk11v6LJdvHpskL1W07RdmQcJz1cdIcVFQTj8KYzsp4ILtIDSlFnKmr7/Ejs/1NxCnHvSwi1JgTzL75+ocero4BE8Lykq5V4gABuoSiIzvX9jbvrUUYA6l0TOYDoHOjB4jzKu+ADfSbSpFpyhEiQPN+HBfJVFEy7JUDmTpes0od2hx00n+ZposCXs64WiM6JTdlVTBOlZXB11nk4a97D445c2/6LYhF9Jb2yUQnJUm/vlX7J3Ahat9qfhPHmUViZ1eAIrTPNUhHdhd3UPH/4RJvdyJZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUtpMqXZmMNjypzX84jIAFde1dRigL9UsVJeIGz+C/w=;
 b=wVVaCODyC6eO7yNjzD7Gr2gIZvIHEQDbBghJF00HZJL8dMrrDZQngIvEbKrcuTEivsgYDhLgqZFJZJE/7tLAfax7AlYC4RoPqHofFEkVZ7Up/mtW6mbSd7y9YVhc5aoDC4r5SEpzGtyslaezfvoyjgJpnakKX/wXkrmmParRFr7wBE1sy56cIlXw+yY1/mJiVEulnjSUmUO7O2N1CG3ll97Rs25tq0KkKCU5qj8MzC3zNubwQabWvtByA2u+MKw16SeCtZB6YyxBGg37MZWxMnAKH8UvXdvd2a+aSaVuJ3q3PRjQXt6irWuKPtMI3v9huUmKFHBHJbTMxuDyydEh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUtpMqXZmMNjypzX84jIAFde1dRigL9UsVJeIGz+C/w=;
 b=Zyvp+iG2+4NR+5JQV2xEi0aJZF4gkbbFoBPcvG9etIQc2U0KkYocLRD0hJLR49QS5LTBmonNW7TiIkcJTtGP08zVBT1JrQz5mFhcQUEIM58JLddRSCBd0xSDT7q8oCtf6T+mlUDxNnghso9ghM19fa63XQJhNliojCaHSOUPuQ0=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 11:30:53 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 11:30:53 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Russell King <linux@armlinux.org.uk>, Sean Anderson
	<sean.anderson@linux.dev>
CC: Andrew Lunn <andrew@lunn.ch>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Thread-Topic: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Thread-Index:
 AQHbOZPrN4QoHKQMl0i3DrWTLLaCrLK9McgAgAABAgCAAKDGAIAA6DIAgAAGTACAkbR4cA==
Date: Thu, 20 Feb 2025 11:30:52 +0000
Message-ID:
 <BL3PR12MB6571FE73FA8D5AAB9FB4BB3CC9C42@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
 <9d26a588-d9ac-43c5-bedc-22cb1f0923dd@lunn.ch>
 <72ded972-cd16-4124-84af-8d8ddad049f0@linux.dev>
 <ZzyzhCVBgXtQ_Aop@shell.armlinux.org.uk>
In-Reply-To: <ZzyzhCVBgXtQ_Aop@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4e2f98a3-0c7f-429e-8121-08a55ce68c64;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T08:52:59Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|SJ2PR12MB8884:EE_
x-ms-office365-filtering-correlation-id: 8def91e6-e078-408c-0468-08dd51a208bc
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?A5hQVXPzI1y+CZi19iWsHRDZrVODnZV2D2buqe6g2thhOXdN/L2xN7xVgo+I?=
 =?us-ascii?Q?f1cvmA2O7NWiAgeOO60u+UrvivKeOexZTqoSi5c5JrRI1URZnoWeCQyuuXMk?=
 =?us-ascii?Q?7OQqAngqzCQ13BNOYaxO6CPL1Gb+0AFs1y39Ew+r+q/qQZpb7hlu2W3Rmats?=
 =?us-ascii?Q?Q9cIAT179nX2Ej1Vclqmni0QkMStoFjyWrkza+GVrsJffpKtHY+iNQ1mSwi8?=
 =?us-ascii?Q?UEPRjLD8XbaZMTFzxh0yLZZYeZ75KpyEfrLMP7+3uoZXSiWnV9eM1syu6Fie?=
 =?us-ascii?Q?MgjaPCXBOhTgi8+BzcHatmjxkLi2417l3g/FH9+Mehl/gOdRX98U+oIGqM4y?=
 =?us-ascii?Q?cGNT3uNBOHQKKV0qkZ96ELCbDWqRnst/BBTiMym+/7VuoOnTrtl5V6rnnK0n?=
 =?us-ascii?Q?azLvw999W2avTWBaESZYxhm3ZuIADlD+mvmUU3TT4iUeKoFS33qK45Y4VTMC?=
 =?us-ascii?Q?QyW/54+7Bi88YDbmzCI8jPI8CQn639ShJTRWkO8dUGIVX6kq38XHht7LhcQZ?=
 =?us-ascii?Q?53VEBdqZgKxby2BrqJ22SEtklKc+TeAmIxYbOIR1+WiImIzm6hexDvKeMlCE?=
 =?us-ascii?Q?dxN/XsVcbjQRQO7Sv+v4/ACCmiTYLzFLfQxj5nF+RmtAHOSEqeHq+O2kFol2?=
 =?us-ascii?Q?9XKYRpTcUohFvV1OJpi9MCbRGzp2PLjug9nEBhQm9lQLO0ezxeDTp7S0W2dF?=
 =?us-ascii?Q?c+7y8nDoN0g7ETDr98dy4xgdS2TjDgXUMCzNuT38F8TN0ENGeNH1FDFdAvRJ?=
 =?us-ascii?Q?526gN0Of/aeu6pm3f6OF8Nc5bw2dT1RAiXanGu3xyt5t9PPEcaMgqaVNwA/F?=
 =?us-ascii?Q?IFUi6DRHMISIQUMsJw3Mu76/Hh71fnePQfkFR0FE87RooWB7jaNHUTMQTV+F?=
 =?us-ascii?Q?Nn1L5n6Wkm070o+D93AlFznFU7CfiupdkTpALHEMsBysKukC6a7+yVgkxHf9?=
 =?us-ascii?Q?wTUkZk4o0OQeC9g2HFV7JtYFaQqKw31mhIp/ejFrpaYa3kVLqUMjsek0c/4c?=
 =?us-ascii?Q?jUivBslLa/Luv1I7oWA8NZgxenNbYQFgKbuyhtA14g3hRCrGOCtahtM1eL2a?=
 =?us-ascii?Q?3QbyK2IOqPveua2D6xh80IzKVLtaHvXXlp0n1Xk2YCS2HlWdyXC9P+6L1jLt?=
 =?us-ascii?Q?IW3w2AaEUv0shcBChLSgPa2Idp6NNzxBkU9ufu60Qf/6oZn9r7bHo12EL79c?=
 =?us-ascii?Q?Ji/g7Zgzifie6gb4pl6XL96bCVwNqkNiKOJxYq399LfR/0hb5yQf3HeO6sBW?=
 =?us-ascii?Q?NkZZnOvEVK7yOJ1p7xLhK3vNzSjAkQUCup4N7E/ZHdXJiKrWxLMgKaSYZPvu?=
 =?us-ascii?Q?03IU8pICz/C4Yd7Flr5F1n9Sf5bUtNlEJmSHoNPC+jj12IWSSjFE1n75X4uR?=
 =?us-ascii?Q?NqgnYc4wuDdae2EK5WMkRbpoUcI8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9y5zSfnMiAwkGYEe2d33xsXxwY9h1NnANcv3pwXFJC/EFJd39K4oXJ3Lu92E?=
 =?us-ascii?Q?b1mzXRNGt31/XRo50H87fqvTGyfnRN+hV+hxI2N74gE+9OFAWqm7fJ15yY/4?=
 =?us-ascii?Q?AHbBH9twVxUVDDt6czy6jI10E2I+qU6FK89NB8EhsUNxk8k345Z0VRQtW6Nq?=
 =?us-ascii?Q?UFvUvnX/+ta/UnyjHH96F/BiJcA9SFNOzgOFYLjdXjA2hQod2hq9FoPQI6zD?=
 =?us-ascii?Q?4crxwX4Yea4qQaR6fwF4ZEbuwS8KEE/9MFVjwqm9WXWgLNy9tKUh28/7vVYo?=
 =?us-ascii?Q?aI/ybwO3lLcxJF4O/uoSzmMh8i++Y8rMDZ6LxU5IxwHe1o4fneSj2DtgGWZM?=
 =?us-ascii?Q?9LCkM4YwQDyqe3S8WkDdBnQ+UNR97eAprXhieVSXPRWZgJcGEXvEEN0Od5dB?=
 =?us-ascii?Q?pr8tzO9BAUuO/1dqjK3Q4KcMflwcuNf3K5F7KHaZBK8QjEYSoXginofFBtF7?=
 =?us-ascii?Q?HQIXt0r9OWVv+AoMXU1mH4gzd4rCSB4iKHzIw77PhkUnx4vLR99uS+9WpdGK?=
 =?us-ascii?Q?WYguNSAHIquXh4Eum3WmaKVJKPkBhiykifCGHMJj+TvornuHa2/iSei/hVPK?=
 =?us-ascii?Q?cb5rLsx8lPe8Hz7lEr93dK9qjmDs61tkpKbPsyYMNqKPUcCXyb8QZqISM6r5?=
 =?us-ascii?Q?njcoML/vwNO/cBw/S8rMo91NZ+QsSHeZS+JlSXTfS5g7TvzvCzvmwci2Mbq7?=
 =?us-ascii?Q?jAeZq9PUb474/0y7cZj3yimtw087LRq73efgyD6twx8cDUfflDJJOP9cWa9e?=
 =?us-ascii?Q?h4h3x4yTxLdx4iodfW0+LiUyPU92NlEbZpZbzP0whN5WuafM9kpyEQ5k0QYI?=
 =?us-ascii?Q?mU8DAK3JgS15V5hZUyJAkc5rNMuOTH/0Zme9LM3sB26GsvnTkjkfmiE19DCC?=
 =?us-ascii?Q?7rNdrZSZhk2bWgt27Jqh08yXHZZEWGeTOcAWn3YzA++wgUitexkR6B5FXZfm?=
 =?us-ascii?Q?FRfqSYYXtAwYQDC9Ptyu17/gnlKvF9tSfv7fEkY+UbRKaoX/EDWtkSxwaU0B?=
 =?us-ascii?Q?1JH6G/8RCc/iYIhgAqHRR6jvzB5a89XfbQIo3/5lbI9UYxh6rb+LmBWcQjJq?=
 =?us-ascii?Q?St9QedXgcSs4g/XHoMzFxPAHuMmX81e1bCdCSwPcObjLoYrxbxO0T3n+7s4/?=
 =?us-ascii?Q?7rnxirsVpt+E4xykC3s4ZsYOnZENTVvSIXs7PsUourQLv3PgPEI/UHLZJIA0?=
 =?us-ascii?Q?8LHd0Zs+ndvzkzWifYOKLhyHkfHqJo2TkhlLFN+OTYm9u6diW1AQmUw0zuwj?=
 =?us-ascii?Q?5EvSQmTsJSodtyjzT0UmVrIvBuvBE0Kk91PuYjjH66f1425g/0TuGLJjdT2B?=
 =?us-ascii?Q?qjfsLw9tmjRSiKGNdQQ2pf6dyk2+MRy0t1WtRLwrW1BGfkg7bdcAYJ5h/pfm?=
 =?us-ascii?Q?Ejl/ffOYHC+Gml1bFB5l70lCEbIGjREBbaQOJC30+9XQvBZ/usbQ0B4wmajH?=
 =?us-ascii?Q?YA3rBH14VL818g7cfVJBchWItNGt3sIQnAHGnaYBzoRcEVku5Ar/bYCg2jcf?=
 =?us-ascii?Q?2Ttamk1kRz1kSRKkxpCkaVByR08/B2MoDtq37w0g5UHpJSyv32M2HoLABjvt?=
 =?us-ascii?Q?kzCd6hZZ46IzBtxbEDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8def91e6-e078-408c-0468-08dd51a208bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 11:30:52.9401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mv2BWCE9VULMRA67Y+7Z05KqSq505dgEl13IELAhvW5O68W2QZHeXDFP2kgbj0n9sGP7m8Oc/Yx9/Hmo7KRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Tuesday, November 19, 2024 9:19 PM
> To: Sean Anderson <sean.anderson@linux.dev>
> Cc: Andrew Lunn <andrew@lunn.ch>; Gupta, Suraj <Suraj.Gupta2@amd.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>;
> Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; horms@kernel.org;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>
> Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G =
MAC
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Nov 19, 2024 at 10:26:52AM -0500, Sean Anderson wrote:
> > On 11/18/24 20:35, Andrew Lunn wrote:
> > > On Mon, Nov 18, 2024 at 11:00:22AM -0500, Sean Anderson wrote:
> > >> On 11/18/24 10:56, Russell King (Oracle) wrote:
> > >> > On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
> > >> >> Add AXI 2.5G MAC support, which is an incremental speed upgrade
> > >> >> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT
> > >> >> property is used in driver to distinguish 1G and 2.5G MACs of AXI=
 1G/2.5G
> IP.
> > >> >> If max-speed property is missing, 1G is assumed to support
> > >> >> backward compatibility.
> > >> >>
> > >> >> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> > >> >> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> > >> >> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> > >> >> ---
> > >> >
> > >> > ...
> > >> >
> > >> >> -       lp->phylink_config.mac_capabilities =3D MAC_SYM_PAUSE |
> MAC_ASYM_PAUSE |
> > >> >> -               MAC_10FD | MAC_100FD | MAC_1000FD;
> > >> >> +       lp->phylink_config.mac_capabilities =3D MAC_SYM_PAUSE |
> > >> >> + MAC_ASYM_PAUSE;
> > >> >> +
> > >> >> +       /* Set MAC capabilities based on MAC type */
> > >> >> +       if (lp->max_speed =3D=3D SPEED_1000)
> > >> >> +               lp->phylink_config.mac_capabilities |=3D MAC_10FD=
 |
> MAC_100FD | MAC_1000FD;
> > >> >> +       else
> > >> >> +               lp->phylink_config.mac_capabilities |=3D
> > >> >> + MAC_2500FD;
> > >> >
> > >> > The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?
> > >>
> > >> It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
> > >> (2500Base-X). The MAC itself doesn't have this limitation AFAIK.
> > >
> > >
> > > And can the PCS change between these modes? It is pretty typical to
> > > use SGMII for 10/100/1G and then swap to 2500BaseX for 2.5G.
> >
> > Not AFAIK. There's only a bit for switching between 1000Base-X and
> > SGMII. 2500Base-X is selected at synthesis time, and AIUI the serdes
> > settings are different.
>
> Okay. First it was a PCS limitation. Then it was a MAC limitation. Now it=
's a
> synthesis limitation.
>
> I'm coming to the conclusion that those I'm communicating with don't actu=
ally know,
> and are just throwing random thoughts out there.
>
> Please do the research, and come back to me with a real and complete answ=
er, not
> some hand-wavey "it's a limitation of X, no it's a limitation of Y, no it=
's a limitation of
> Z" which looks like no one really knows the correct answer.
>
> Just because the PCS doesn't have a bit that selects 2500base-X is meanin=
gless.
> 2500base-X is generally implemented by upclocking 1000base-X by 2.5x. Mar=
vell
> does this at their Serdes, there is no configuration at the MAC/PCS for 2=
.5G speeds.
>
> The same is true of 10GBASE-R vs 5GBASE-R in Marvell - 5GBASE-R is just t=
he
> serdes clocking the MAC/PCS at half the rate that 10GBASE-R would run at.
>
> I suspect this Xilinx hardware is just the same - clock the transmit path=
 it at
> 62.5MHz, and you get 1G speeds. Clock it at 156.25MHz, and you get 2.5G s=
peeds.
>

Sorry for picking up this thread after long time, we checked internally wit=
h AMD IP and hardware experts and it is true that you can use this MAC and =
PCS to operate at 1G and 2.5G both. It is also possible to switch between t=
hese two speeds dynamically using external GT and/or if an external RTL log=
ic is implemented in the FPGA. That will include some GPIO or register base=
d selections to change the clock and configurations to switch between the s=
peeds. Our current solution does not support this and is meant for a static=
 speed selection only.
If some user wants to implement dynamic speed switching solution, that will=
 need to be accompanied by additional software changes later.

We'll use MAC ability register to detect if MAC is configured for 2.5G. Wil=
l it be fine to advertise both 1G and 2.5G in that case?

> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

