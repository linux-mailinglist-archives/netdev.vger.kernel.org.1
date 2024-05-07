Return-Path: <netdev+bounces-94176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 118308BE8A1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71637B252F1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86116C699;
	Tue,  7 May 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CqQlc0QR";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K5LmxLBC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684A168AF1;
	Tue,  7 May 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098749; cv=fail; b=V1HFXNbrCDCye6HzcOfX7TEAr+4v6RG9U/9Jxy1gCf/1oGSo5B4P+JNs9e/mxD1gwC4zpuhFM3XZUDnMt5SPcd4l/XoU400lG9ejwcz1E6zWJnVDVPdoHdvBxD9PjyesZIm9wOZUrobPigMjAqjxHU+xhjimtFx3BE14uCuzXhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098749; c=relaxed/simple;
	bh=prKQFYozuWwL5cVHuZlrfiJadSzmzHiK9glDEIcLsGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oBLCxKvdkq0iNB94Hd53yjc993pPSlVywdIgaasP3XxImOdGsfQNjXl6ypn21TPmJ+kgtOAmNaJ4ZjdUjfDii/Lzne/mk0eEKTUbW7PMo8wsIeB4QWCbfr4plaLaVt+6mx+deCHnmC8siOnLVCaKzjN7m7LNpj01bxdUyFgUEis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CqQlc0QR; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K5LmxLBC; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715098746; x=1746634746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=prKQFYozuWwL5cVHuZlrfiJadSzmzHiK9glDEIcLsGc=;
  b=CqQlc0QRO7nIkIsnMNDM7679NtfSL7G8HlFy7BS1yHnRS828qtHyx5N4
   Cd4NMdeiH8js/c8lvVwFLvf/oP3WeHXxeL5wI+VWIrEbJCE/0ZV5ajOvZ
   e4LmJnKt4ZkIFrdfXtUMX4gS0uQOHUPB9jCivFiKiPgzh5SWUqHvATUiN
   DyKjobiD9iIGsms0aVOv/WS+E01SxemEhF1P33szZrs0DXRnr9k1ZEnzv
   LPwmzs7JqiNxBEwHrtRLPKeRHma1W2/leBAnqkQmKwojvPL/Emkm0wZ7E
   +virraCFn7sCpgZyj9lDZL5Znn09hM5XcO5BCzkdInlWacAg9pKa4MfCr
   Q==;
X-CSE-ConnectionGUID: iX7H8nhCSiiWw+rx9lVSkg==
X-CSE-MsgGUID: 4/nfqMllTFycyzcV7OVkBA==
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="191326679"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 May 2024 09:18:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 09:18:30 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 09:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5SSUzfT5t1IRGNtDf2yJxM20KQM1tTE4uxXQOrXLifSbn+Wn2TmywaSOX5vueq2EL1CufW7g2JjBdPQxAA/EZ6Qc5N/pC74cwWt5ZURFlRSXsijxfgGTJEYkaqW2ASgw7APELrwAtNtw2gToslxUuRLInZUjC8bOw36LgaP7A2F7ZJ58/REHQ5qjOv0cEpu4v3HTfyvQnvY7u/iGXaE+7J5DqWrXMXvGWxwMd9bQqb9guuhyUbdQ70swurWey0FWnRy6GQbbp9RIW4hj86oU9+i5y9E7YXk1eHESXovgK8O62guYpe++mnW93Up8XGy6PurJUmcUVXI579bPrYhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prKQFYozuWwL5cVHuZlrfiJadSzmzHiK9glDEIcLsGc=;
 b=Bd70jW1GsplhGm51AHROo0OYEckJ2OeE1eNDyJ339Y7HMedUErpO/odT3qhh61Bo6dbJzGx7Mcbeeofnu3cDJECocHzQ9TjEZ3KR39IEFaahuk0XHDiWzAmnlMIZFZjb0xwfOk4kSiuWLM1Ktk9oN1C5IVj+9BRYLd+GZem3FSai08lvUHsBkDAfgsIgif2mCODt6Yd3L+DOWWQYocPCUeR+OH26p/2ITjcvGFuNBqhpknGG80PkcjlrDmkLHI3uFAIztoDPg8gdcDcpj0pPgeuHLWV/EyAuohhHnjSv4Js7/ZPGN9qD3VI0H73NwsEQ6FdUheiVgPTftHJf4h4EfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prKQFYozuWwL5cVHuZlrfiJadSzmzHiK9glDEIcLsGc=;
 b=K5LmxLBC4Mkrso+0h6fk0Qmyj5Wt/hNoZTOt529sk4zqnl6x1MVs/Pd7JVDjhn4CW+Xbqo4JoZyDQi/8jDyMuS5bWkkBbHLgDT46o4+E34AipPtqd1HsIb8N9dOjboB5Egqw4zifNAl8AczyFSEaf6GPkgOC6+ZIAYqWDbueEo6hI1kibxhnuxi49JD6rgSBjUUATKJ0zO3rzCIdVVIyCrokCq04ODQmiiBSDpKgmn98M8AjaOB5YEmgQuhzghfZ0uyhZ3UgvMPRgcLRgp05UrJNcXGIB96hihLIzqk+cDfhZgbY69Ir33cBeJUkljbgVOIHwDqosH03EZHdsP7d1w==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 16:18:27 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.7544.036; Tue, 7 May 2024
 16:18:27 +0000
From: <Ronnie.Kunin@microchip.com>
To: <linux@armlinux.org.uk>, <Raju.Lakkaraju@microchip.com>
CC: <andrew@lunn.ch>, <netdev@vger.kernel.org>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net-next] net: phy: add wol config options in phy device
Thread-Topic: [PATCH net-next] net: phy: add wol config options in phy device
Thread-Index: AQHamryInbCB9BYIukGo4mVuOjWyY7GECwQAgAAS4wCAB30KgIAAGgIAgAA4RqA=
Date: Tue, 7 May 2024 16:18:27 +0000
Message-ID: <PH8PR11MB79658C7D202D67EEDDBD861495E42@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
 <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>
 <ZjoAd2vsiqGhCVCv@HYD-DK-UNGSW21.microchip.com>
 <ZjoWSJNS0BbeySuQ@shell.armlinux.org.uk>
In-Reply-To: <ZjoWSJNS0BbeySuQ@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|MW5PR11MB5930:EE_
x-ms-office365-filtering-correlation-id: 3e496bec-c1ed-413b-a1fc-08dc6eb153d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?VI5V/YCdv1KcbbASF5An+fIq2ZAOXbZ84VorKtq4vZjHzvl8L8HZ5chV4enC?=
 =?us-ascii?Q?aj20qrGKEKa44eUeNOB1YcOse0Mnxs9y5gGFCPhl6+1IDp27n+YrjEtu3940?=
 =?us-ascii?Q?1ylrq72PmIemNhmK+Uz5rP9z23rhrHqiflLpyNlLbqorSp9MMkRHuNDRAScg?=
 =?us-ascii?Q?1qfvATryI/Ng3GKTjsXaOAd1a9+EreeqLWXm52VDWueb4SADxTg00eO9ja/5?=
 =?us-ascii?Q?S1h+6O7VJq8r10jEdbmgvvD5w9X8U6OuFoE6RQbS+Q65cCdgxvjZJRU3wIZN?=
 =?us-ascii?Q?NKeXvQWq2pbn+2B7TjNX86TbAGWxIwZm1TVKq/0ugl5gq8F8l4aJfmWA2ogM?=
 =?us-ascii?Q?kzln4fvSil0/qboJWeR+x1ZJTkI3ObM5RRjNzLNCmPN0n5FDbomTxeWNiqKj?=
 =?us-ascii?Q?2exxgzpgpUIotm7+Snj1GtWlZjm+SMHr1hIetLUWr8drD3yIrJGMAylNCZaS?=
 =?us-ascii?Q?9TGk3TbMhWUMHdjC77VuHJJYFArwBYpjfNzZxSuozO6xIexuzctNTNN9eLcc?=
 =?us-ascii?Q?FRd0ZOg1q4Bk9Kfb4bLmcS2H2j2q5JcHBRzXwUxN9kqmX6nRoS/p56pC8AUh?=
 =?us-ascii?Q?LjMfPv/M0A/1YH2SVoKsSTR0Hdl4EhjPy9gitGNwgzTpWpf6QMgJx9TXlRan?=
 =?us-ascii?Q?NxcsoFhMkeF8pyqGFXrFLksyHa7Y0fKGzvVyuQWOymPJ6y9nqdfErRMWT0eo?=
 =?us-ascii?Q?Io/mZp2norE1oi8KpjSBF4PtCProWxBq+y+I+5UF5IkR7fjpuNNIaN/cMljo?=
 =?us-ascii?Q?ctOi16sLk4qT0CRkuqbm5aVUG29k2eUdmDaqk4qRlOw07gE7ChTA+nCFkBbQ?=
 =?us-ascii?Q?zlCBQzriqNAc0z67fwVLJUfjkGtL1H7vM5WFCfU6exRpvBFsFC64PLSox+MB?=
 =?us-ascii?Q?EmjfVeu5YMJd+6OSsog9Ve+KP6ydahCN8w4ACVLo3NUf6G4Xg7ZDQ2INJHWF?=
 =?us-ascii?Q?gI7DtpeaQrFm5/bjkD52eZQce6FSI4o+URUXER14Y1OJ+JB2r6UhSkKfmlJy?=
 =?us-ascii?Q?eElbh9nGEf3o0v+/SiPgZK2Rtwfy/1FIuQHW5UB7pBx15lFAzEBj+y8YTIuq?=
 =?us-ascii?Q?DaHDpZvbDuWPJSrZJFm0xuMOkY+S88Xz6BolPHfj6moXtU8ahC1Kgmxxi5pK?=
 =?us-ascii?Q?Gqq8CwgrTf8VFTp83ayTgtuHEvcG8234wz0s0zJXyVSvn1iH7PD3jNZh8auH?=
 =?us-ascii?Q?IapXteDvKmctlbtobihjpANFljKzCpSwjm6vXjX6vlvRQZVqr7OplgRJYCXz?=
 =?us-ascii?Q?hWPOoAJ1vuyTxDPWFh2UQEoTkcttiXthUMb24kzSiQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mRQSnSNmqUA6uMmyUFHidP9Fu4k5lD1EzT1qeN3CADk1NXdk3ql04fz4DfMd?=
 =?us-ascii?Q?u35YfJEoZf7D4oBLpSRT9xua/jQPjSDvJP4iW8xo1IgmI7xq1Kz51JFFTWlY?=
 =?us-ascii?Q?UiQDq8rrTZKDamVHe7Vi8iCXpkMQEZgYiG7su+W2qnQ9wqgUfEZwMlUvYKuz?=
 =?us-ascii?Q?MHLq9plaZm8OnH7ZcpY7O60NuDuLYT60mgvsNGU8FhCPYxjwctjHkGpl7RTB?=
 =?us-ascii?Q?dVU+rnzql7+nRkOXGzRZnUn81WqLTjhdDOdsZNKHvBg8xI+iipfiVfTGcnJC?=
 =?us-ascii?Q?Zs8cMYWdV7W2MOfP4m9NXdHnblIlz2qMVQrRTlCLKoC1eZ2Mrn7euS+pDvpf?=
 =?us-ascii?Q?CdW72krQLKi/ULk56gGgOykWYt7taCUGwAGgbwvxP4cvqiT8CgVMQNMrBzRA?=
 =?us-ascii?Q?y+KncnlLoWoMB0jGdCQxk4C7hOr+6ppNrLSc9VHNhyYQxlulOiMTaPsRQod5?=
 =?us-ascii?Q?fvt1OaH1AeQ/N2XWPSltubCHdfzbzX7cnN+INZJcU/ILDO06vb8DS1bUuDt0?=
 =?us-ascii?Q?rbkoE7pVVXDNL22vOJL7Lg/8W1nXEQksNrvrpDVa3nPQ3BGKXOBKiGdmvSPI?=
 =?us-ascii?Q?kZkoKiOV5+X+Y9NMIVpaOoIsDYr34nQr7++/hLIN/05UHRhl/24Mupx6MHW0?=
 =?us-ascii?Q?GJH0oiLnerBD2HgfPvZs2PxJ1CP2pgZZu1gwbNc93QHBIqcpuzAg+05uwY4H?=
 =?us-ascii?Q?8U9TIhiicoENNwsvUOyzIneLwTrSXnwD54bzJmrC4SbXYk4altgEJicxcyRM?=
 =?us-ascii?Q?AeJP6vaT0Z1NRfo2Fp5fc67UAu8qTOjuXFrZmgAY/8fdvm0V9N8yyTJjnY0K?=
 =?us-ascii?Q?/wq1XBfuszUNdiHtQlLGFZVnAAWxD0+y5e2XGTfUp5yJKE3Xl66znP2dfPni?=
 =?us-ascii?Q?LpoDYofrhIREy4wESpFjhV2A6GhspZTVca0sX6Ql4jInc8Ndj6/wGllb4W4S?=
 =?us-ascii?Q?x7Le11oMQ+3gjd9FOuBcxXff0MgpQagIYjBzneJ4cPwmAz0IukUnEIuLB5/l?=
 =?us-ascii?Q?/PgTEmk64XSaWrs1nOc08YdmKK/zpm1ygt6rcCUxdyYPXTxUdQhZZrSNEzf8?=
 =?us-ascii?Q?s18QIraMq/UEEoRxDIANeU+tMaGsVhfWIXAWl+eXsnNfHwN/8iuMgUDOaOd5?=
 =?us-ascii?Q?OvZfry2quPDzm58CXsLwnHoCYEtphFH6JQUsAQGddRWTRPmWGV/b+MPU9EnY?=
 =?us-ascii?Q?2Vo0TRz7zQTRuU5xoc6ZGZ8LVe4Cr/IWC9UQtCvwQa5DSpaatB3fcbIZRMUK?=
 =?us-ascii?Q?myAgC71uw5Ciqcd0gZa0y4GAt+bm17B5Tturo797wTGsNcKorjLOLdqGEF8x?=
 =?us-ascii?Q?3Pt4n3bKsaSFam9Fr9GuoGo9ENPXQcSWCxDI4gZQoj3T0g1vqxlGFdWMB6wV?=
 =?us-ascii?Q?KGmGGj0qodiPQ/U0oDqgz1GMIuYHrlzWaDTC20gATl0d/wNsfyB6UxjNKc2M?=
 =?us-ascii?Q?Mxktm6RRlTTPG4WusNBtxS+/2HbyXgF0cyMsTapFEKM8LcL8XNw9obVMi3JN?=
 =?us-ascii?Q?eQSQfw4Tr5UpN1nLrOXj0IYDJLt4qhkjlIp7XK9kVmKYl+kBhpfZLyRPIEnv?=
 =?us-ascii?Q?fVotytZUDfmb1isssHAel8ZLMI7WRgzC9fle4cAR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e496bec-c1ed-413b-a1fc-08dc6eb153d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 16:18:27.4471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0dC85wC34hEB5t4wnuvutbM13SmFfffAMrCckj47FCg1YbfQ4SLxURBrOiaM+I4JqZcWa7lUENRNFB0EhwsY8kZ4ksglwJeYYCNlYYcHvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930

Hi Russell,
I do agree with most of what you posted below, including that the Maxlinear=
 gpy driver has a bug in the handling of interrupts which is the culprit, a=
nd that it can be fixed within that driver itself without additions to phyl=
ib.

Additional comment / question below

Thanks,
Ronnie

> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Tuesday, May 7, 2024 7:54 AM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: Andrew Lunn <andrew@lunn.ch>; netdev@vger.kernel.org; lxu@maxlinear.c=
om;
> hkallweit1@gmail.com; davem@davemloft.net; edumazet@google.com; kuba@kern=
el.org;
> pabeni@redhat.com; linux-kernel@vger.kernel.org; UNGLinuxDriver <UNGLinux=
Driver@microchip.com>
> Subject: Re: [PATCH net-next] net: phy: add wol config options in phy dev=
ice
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, May 07, 2024 at 03:50:39PM +0530, Raju Lakkaraju wrote:
> > Hi Russell King,
> >
> > Sorry for late response
> >
> > If we have phy's wolopts which holds the user configuration, Ethernet
> > MAC device can configure Power Manager's WOL registers whether handle
> > only PHY interrupts or MAC's WOL functionality.
>=20
> That is the responsibility of the MAC driver to detect whether the MAC ne=
eds to be programmed for
> WoL, or whether the PHY is doing the wakeup.
> This doesn't need phylib to do any tracking.
>=20
> > In existing code, we don't have any information about PHY's user
> > configure to configure the PM mode
>=20
> So you want the MAC driver to access your new phydev->wolopts. What if th=
ere isn't a PHY, or the PHY
> is on a pluggable module (e.g. SFP.) No, you don't want to have phylib tr=
acking this for the MAC. The
> MAC needs to track this itself if required.
>=20

There is definite value to having the phy be able to effectively communicat=
e which specific wol events it currently has enabled so the mac driver can =
make better decisions on what to enable or not in the mac hardware (which o=
f course will lead to more efficient power management). While not really ne=
eded for the purpose of fixing this driver's bugs, Raju's proposed addition=
 of a wolopts tracking variable to phydev was also providing a direct way t=
o access that information. In the current patch Raju is working on, the fir=
st call the lan743x mac driver does in its set_wol() function is to call th=
e phy's set_wol() so that it gives the phy priority in wol handling. I gues=
s when you say that phylib does not need to track this by adding a wolops m=
ember to the phydev structure, if we need that information the alternative =
way is to just immediately call the phy's get_wol() after set_wol() returns=
, correct ?

> > The 05/02/2024 16:59, Russell King (Oracle) wrote:
> > > and why the PHY isn't retaining it.
> >
> > mxl-gpy driver does not have soft_reset( ) function.
> > In resume sequence, mxl-gpy driver is clearing the WOL configuration
> > and interrupt i.e. gpy_config_init( ) and gpy_config_intr( )
>=20
> That sounds like the bug in this instance.
>=20
> If a PHY driver has different behaviour from what's expected then it's bu=
ggy, and implementing
> workarounds in phylib rather than addressing the buggy driver is a no-no.=
 Sorry.
>=20
> Why is mxl-gpy always masking and acknowledging interrupts in gpy_config_=
init()? This goes completely
> against what phylib expects.
> Interrupts are supposed to be managed by the config_intr() method, not th=
e config_init() method.
>=20
> Moreover, if phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED, then we exp=
ect interrupts to remain
> enabled, yet mxl-gpy *always* disables all interrupts in gpy_config_init(=
) and then re-enables them in
> gpy_config_intr() leaving out the WoL interrupt.
>=20
> Given that gpy_config_intr() is called immediately after
> gpy_config_init() in phy_init_hw(), this is nonsense, and it is this nons=
ense that is at the root of the
> problem here. This is *not* expected PHY driver behaviour.
>=20
> See for example the at803x driver, specifically at803x_config_intr().
> When PHY_INTERRUPT_ENABLED, it doesn't clear the WoL interrupt (via the
> AT803X_INTR_ENABLE_WOL bit.)
>=20
> The dp83822 driver enables the WoL interrupt in dp83822_config_intr() if =
not in fibre mode and
> interupts are requested to be enabled.
>=20
> The dp83867 driver leaves the WoL interrupt untouched in
> dp83867_config_intr() if interrupts are requested to be enabled - if it w=
as already enabled (via
> set_wol()) then that state is preserved if interrupts are being used. dp8=
3869 is the same.
>=20
> motorcomm doesn't support interrupts, but does appear to use the interrup=
t pin for WoL, and doesn't
> touch the interrupt mask state in config_intr/config_init.
>=20
> mscc looks broken in a similar way to mxl-gpy - even worse, if userspace =
hammers on the set_wol()
> method, it'll read the interrupt status which appears to clear the status=
 - possibly preventing real
> interrupts to be delivered. It also does the
> clear-MII_VSC85XX_INT_MASK-on-config_init() which will break WoL.
>=20
>=20
> So, in summary, please fix mxl-gpy.c not to clear the interrupt mask in t=
he config_init() method. The
> contents of gpy_config_init() needs to move to gpy_config_intr(), and it =
needs not to mask the WoL
> interrupt if phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED.
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

