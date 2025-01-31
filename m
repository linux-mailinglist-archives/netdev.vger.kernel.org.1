Return-Path: <netdev+bounces-161781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED96A23F33
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1993A4180
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A051CB337;
	Fri, 31 Jan 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BsWuCJ52";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="f8CTFHgu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="pNIPzURC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D3EAC6;
	Fri, 31 Jan 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334254; cv=fail; b=rysHUkUCzTxGIamNSjMPDP0evkY3gmF57fsfFU69ZHxMI/s7cj7jQYu58MPhzE8U+gCzGjgTkzfNu3D1BcS/TX1faROGhz6KkDlw6jfrr33bXIZzTWmvdVlaGHxlpItCY64isbdc1bi38Dl9Kb/d47zVQRMNm8PrSogn011jhFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334254; c=relaxed/simple;
	bh=XJhiObd1fdyUZb/9lbNVPBolzn5K7OkQnSzT/KAVpW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+6iNbqdI79XTJvtJMaZJ5pKRmavrkDcL58nU5KT7WYVIxKEtOiC24dh1zZw6eOh/lWGAR26P2Q3fDznoVbo3gG4R+dxfSBIO4Yh25Umct55YqTJ+xngRMdBYduIIhqr+e4/FiszPDFnU8y/ZhfVKtP04v33eIT08SjFue08TZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BsWuCJ52; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=f8CTFHgu; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=pNIPzURC reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V8lvHg030137;
	Fri, 31 Jan 2025 06:37:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=DKWWOxN5iCKsbuWaBvG0feZJjyXSKZ3XJUBRb+VVlbk=; b=BsWuCJ523rdM
	adxcqFnZZuw+tmbU8BXj0wZ7icAVYhm+XPeoU78MdQ1Ng1ID30sKowyCPB8B55xx
	3tevV+1ALiQUAuvLBsGH9D64YeLLXcX0xghrvCwUC5C6mwINpxSGTZ1wub4Zk+Tb
	FDNuZju1uVSqqFEoNtlakQIlaUbdNoP3rKyZcS3yUXe4yxyZe+hoGcr23r9Q2tqL
	oE1Y87YsiMXh4WJjiqWsKxO6mcTXcKepXHvn6mID/kYHW8wEkVQIOHFVDxz9K0Jx
	G7Q7TeN342SVpmMFsy1WCZsTxcg78FpJkCimHDYTlEFu1JkNak8DezpLHIWe502a
	xWCBgOUwmw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 44ghqcv33c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 06:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1738334221; bh=XJhiObd1fdyUZb/9lbNVPBolzn5K7OkQnSzT/KAVpW4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=f8CTFHgu8UO5JnoYKbk8a5AOXbGAi7BFQRH96MVWs3Y0ef/HUWZUbxvavzzgrtRw1
	 4GNB74OviqKyAGEOkq7I39rB9TjY3bkhxwNZKO/fvdCUyDeIAoFqmG3tBYnEgkY6jp
	 pViR9sJJfObYaIOkhdrebb6EWa6423qOG5nlUnv/jm7suZgMMXJZHQUv2r6z2uRUpU
	 Aodrm0ozaKe/lpgjdXAYjetdgnHWN3W5zXqy/Y9rYmRcWKe5/hYnpE7ToaavNJ9VHt
	 fd+Rn4B412d28DRe7JHAtHAtEXeiEW7t3S8ypIp7bzuYt/3oscPK7g4TV3tH7llH9a
	 LojGaosM9raKw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 71D4A40353;
	Fri, 31 Jan 2025 14:36:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 20AF3A009C;
	Fri, 31 Jan 2025 14:36:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=pNIPzURC;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 120C8401D3;
	Fri, 31 Jan 2025 14:36:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI+GQyGIZSclK7cywANM3/o3VdJLPDfHM4dRZyhes/ME10OV8dwUNarxNE2mkEGom0aFHW7k4Zt8ML/iNp6ell1cbuSqOpcovpwHF/z6EniELPSk4Fyk0SdpzkCse1uMGXuT+5gFkjr3jVgG0CJTfX/In2mWNry9m1PrdthYSNRYbNNmo2coSc6JTlKPAKhtKYPek4vnwjGIMOvmbLttxHGpeex61VBs3j1H7EUaN9i5hN8G7UJFftfwbtXVegE5w0R0Q1nxbFFQZlSXnNMpbY6nkAYxicGnjB2yTuO7MPIHTicz6tV7p9oknbFo9D7486yygqMPdEzFD32xO6mLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKWWOxN5iCKsbuWaBvG0feZJjyXSKZ3XJUBRb+VVlbk=;
 b=X8TPZuPuw+KlSVZ0dPWcrZFVG9VSIb84P3GjNksYi1pDDGRCC8uwBVcwxEJS/P9g9rjUnUZUdNhmgSWtKcow109k0DoOr89iUGHa4366CKnAcn8/7B1huMbUyznWDMxiH8xtCoFoy2CSz1Jgd4ZumzzNSQ0y1fK+gugGLOETsuohhoXXGQOnH+k0pHrG6xngz4cF+/wIBRC+f2JcSEchkMJ8QrN1B0FW8jRVoumcWbh8BfXjmnlgE2IJB2IWejw7tl1ytFldfRlCQPaT9CupUQDJy+5dRQxr0NkbvfRLVrslYldLQ2g2rqdZgEpZIqHzfrflUGon+s0G/jGlwmATyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKWWOxN5iCKsbuWaBvG0feZJjyXSKZ3XJUBRb+VVlbk=;
 b=pNIPzURCCkWETtV/IAK7+GQNJc3XCbSp/ox7wTyr9Tj4phjuYrCsLcWqrQFUKQVOPz7wRu1KcCwV6vXMgBYKhQ4Ynb0PxGBuACVqtwmzCby0q8BLmmqLleSiTHWskW5bCkPj30/bi08gObDy1B/pvmBV8V07Hy1TYkl6R4OPlY8=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 14:36:49 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::894b:2bb3:a3e5:8ccd]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::894b:2bb3:a3e5:8ccd%5]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 14:36:49 +0000
X-SNPS-Relay: synopsys.com
From: Jose Abreu <Jose.Abreu@synopsys.com>
To: Russell King <linux@armlinux.org.uk>, Vladimir Oltean <olteanv@gmail.com>
CC: "Tristram.Ha@microchip.com" <Tristram.Ha@microchip.com>,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sadhan Rudresh <Sadhan.Rudresh@synopsys.com>,
        Siddhant Kumar <Siddhant.Kumar@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Topic: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Index: AQHbcwZtiX2CcNa5zEuI6dm3yXlcQbMw81Hg
Date: Fri, 31 Jan 2025 14:36:49 +0000
Message-ID:
 <DM4PR12MB5088BA650B164D5CEC33CA08D3E82@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250130100227.isffoveezoqk5jpw@skbuf>
 <Z5tcKFLRPcBkaw58@shell.armlinux.org.uk>
In-Reply-To: <Z5tcKFLRPcBkaw58@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWNiZGFkMTFjLWRmZTAtMTFlZi04NjdmLTNjMjE5Y2RkNzFiNFxhbWUtdGVzdFxjYmRhZDExZC1kZmUwLTExZWYtODY3Zi0zYzIxOWNkZDcxYjRib2R5LnR4dCIgc3o9IjIxNTIiIHQ9IjEzMzgyODA3ODA2OTAyNjI3NSIgaD0ia1kwRkJuSTZIT3lvNVdML0lDZDRKUFRaVVVrPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|CH3PR12MB8726:EE_
x-ms-office365-filtering-correlation-id: af5ab181-402b-4752-5b07-08dd4204b244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?p6ZauqZKzo/nvk1jfJ9V51PLyO5ARfqwKOjxu5hk+GFmwvsyDFTjYdH6vlTY?=
 =?us-ascii?Q?CTeiQOZFwQr7bYsU2p1/SY6xKqxNZEaOamPBBveE94bZZ9ZEvYZwSxDCTkGN?=
 =?us-ascii?Q?bZmH0rtc3jjq2dCWibFUnZN4MRFxWR7tzMlEshLnP/LRd5O7kI2+ggdStC7a?=
 =?us-ascii?Q?I7J4ckPl2mDfgXmg6T0znQu4mZ8/GntSFcRGvir8kLPh4U/eoxX38r1/Tj8b?=
 =?us-ascii?Q?FARQt9LINAJ7vMXfAy8Y5iuB1N4m7AfjFoGRCm25CqtiSXobdF/6/2Ajt/cP?=
 =?us-ascii?Q?i/AfGZkdn5d+lwK0J36waqMMVE3PYjXBMK4ApsamP1sy+9uTtJnwQeb4alTA?=
 =?us-ascii?Q?F22F74iOZDBjNCmUKtEGmrmxn7tcnSuF2PYXbAAJIWvcCGKHXcxQUKN581On?=
 =?us-ascii?Q?W7pRohKm5zpzEiOCEqzE/C5zAglqbej+7Fxgz8iGwhXEFWflBttNSJBdBN9V?=
 =?us-ascii?Q?QmcCxwC2o9MVr7/7isTAjLya0w4oOqNc6VdGiLMxLtl8ilGdKnwf6vNnVksV?=
 =?us-ascii?Q?+E307/vPssZODV8bK4QN3LYCAGrkkyFCKbJWjH6C2nxRkwrCalUK9sby2+1m?=
 =?us-ascii?Q?tvTzIfN2keAze1VYb/Z9pBDqh3QXiTIguX1mc5PbPizJ71aQqLlO9Q7s12dt?=
 =?us-ascii?Q?DmSrejPo+kBz31UNDFa0RDu6EbF9lsxxnUQ5PYBgeVhDOoHi/K3qXYBKbkT4?=
 =?us-ascii?Q?1Cp9Y1aoWz8buU1dq7JDdrsUPNOqsn2mnrCDQEaMKNB2tKEI09pCCJSe+Pte?=
 =?us-ascii?Q?higqki3LJ55KYPYRXdrtEjOk9JOnZI+fdHxSlL70JwDdNicw9ziIBcdJM6Na?=
 =?us-ascii?Q?uE+FAafg4cineGFdWwyHhuBJzNTqzJxqmyJPSQVLkUbfT85zArIZ3aVqD3xC?=
 =?us-ascii?Q?A7baOuo8C/MpudcVI7rkyIVYrbT2M02TkBe7cRjxzZWnrVfJco+1/nr29YBA?=
 =?us-ascii?Q?6t/tMjc9xWFVIB9AaXSyKGA07C3v36W8SZQj0hKA9WSiIIkQWl32MkbIeSXa?=
 =?us-ascii?Q?/Te5zZMh0/+iZuE1ytffzBh++08t/O+Vr643GGiflVW2oBIg14Bp3BDNGmRf?=
 =?us-ascii?Q?4fvyRGlZz496WYqWlODifYqjHs4Py2KYJpcMAw8KIzyeFvw8i1WBvV6Ie/pl?=
 =?us-ascii?Q?AYYG9WxN7Hk+0LUmXULN7Aojol6uyEMFKLjyeioFZ+S5D3ri+lAhmYO8GA8d?=
 =?us-ascii?Q?R6W+nyS3dn8gAhEj2K8XQ11st4SORPFTwe2yGPkY5DFr2mCbeFsNsYt/wLCf?=
 =?us-ascii?Q?9HOyC4f45c4A8fmX8ozpA7x66XBKCiaSlqfzb7jJKjh2/Y659kRu7IGulaU3?=
 =?us-ascii?Q?M6NhXUXPTG5P/c2gaBSW31hn/WORnPQzQ7WwNcP7DllpBv4FHriaYWv+0z1t?=
 =?us-ascii?Q?b5jW8gV4RpsZhRyUdE+GNchR0Rb9+t/vIGRjXvTY3kCw0hcFaDLX2rFwzr8Z?=
 =?us-ascii?Q?np/k9c4fqZ08jWi8bL4PD/EUbtAQHhsy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lN3YBcaSbavK60TiRgJjjLgeb/sceme/ytNQ8CrE0uh+Pb+SH4XAjExzoiPU?=
 =?us-ascii?Q?4TGXIXMN6VrI00GylY5N6kWYZDJUT7L0AomGykfSGINc5pRsMbfdIYaUAOt3?=
 =?us-ascii?Q?UnnZZDX26mI0y/QX7z5/I/lJIhr/Li0ACHN2lRoMO/GGRzpOk75O1+9OJq8k?=
 =?us-ascii?Q?DlBL1nEn2j8xiCADqxHoRbe6/Lg5lwrNUTTjtq2eiNZl01hGla3zJq1JebCg?=
 =?us-ascii?Q?oPSKvdjHeId7eypvcFaR8WwSRqr0TqvQ8bA8aJdvdFD6wRDzt8NYK0LPqry5?=
 =?us-ascii?Q?/0B6XzjdqZvlZ32KEpmKsAtPqSqA7UjBB3i8k0qUMKjZJKVOrP8YiOzamr6R?=
 =?us-ascii?Q?wWtbZDej0mCjbAz3ih6Rft6HB6hGL7JtGgVbosIPuFJ4jSK1QHRFi+Fcq+Y2?=
 =?us-ascii?Q?d319BXtBbBh4DgH4Q50hRhW1dgK7Xw+LdD2LtPtgMvN/nRCUaskIhf7UaI+g?=
 =?us-ascii?Q?AZhdMB9G9xLKSLMEdTjkaWgRrxwG8OeTTvmc3pMc3egS9REQpLGZxyRgHhH7?=
 =?us-ascii?Q?VPiRTAorHSbPXEnBO5DqN8Kbee2QuEfv7FlM9zJ4RIQZSiJuEMOLVn3PO//s?=
 =?us-ascii?Q?bUQwVvG9qvSzs0+FyIWBgGjMJcGlo3lMNGXqYnm3RNUfmf+hNkAgTvTZUbTd?=
 =?us-ascii?Q?vyN989xAkoUsanzPz1od9CPzQwPtZvvXIxqSn6fqenYV6KkkI5h3altc2qEQ?=
 =?us-ascii?Q?dtDK8q35AjiEZuB5us/y2UzT1s6TKYZ8JfL6Fa/o/7eS6W9RORKBtzJMiOof?=
 =?us-ascii?Q?MA5YmCprdDG0Rf1SSxk5kLMpPPObJKSDTRLpf9cpRaalELaewgHJv0ZELHNm?=
 =?us-ascii?Q?WuC7rzp1J0tjSTSqxbsztluT+kXeWBctEp2pnOmjsmIxiHk0IBDNxIWs9Zhq?=
 =?us-ascii?Q?gCAG2rcw85At+7MqieI/sVoVMEPilXhLvQa0xXMkAxk6bowbVMnrx2ZUKoF2?=
 =?us-ascii?Q?FPyaTQJ71bnq4OhJMjxS8i3VbNnIRxyBqjSicBNt0yBCMVggk2QUUrwJ5m/2?=
 =?us-ascii?Q?qoPsjIW67OS2aGQyKwB74iRCvEjEoeo2rpJgJZ/u8VVHa6P7ccbdPKj16Yiu?=
 =?us-ascii?Q?lC3k2cOw9TDQWkpRL+oo131vWSzBSNiVcMvcGFMy/TwHxL+fkvWZRlrppnF6?=
 =?us-ascii?Q?N39K1t6oFVWg3mjbx8lEPxdFNCP7x5PCx53b7N8+oiYWkKIy0QImzepih1+W?=
 =?us-ascii?Q?nBzK4j0f4LP41M8uy4yVyHg8Mj2JESHG/FOpMPUdoIY+sKZYH43j5gWCTh7q?=
 =?us-ascii?Q?M8xuDgdlt3o1BG5yH+HKP05rL50e4OKlGCvT3tK9rVlTxITp5TSrDK/91aft?=
 =?us-ascii?Q?gohkX7bqJ4v/u006uauzBxptcCHJezM41QVTH3mZu6b8l7uEM04BDWT4uR3/?=
 =?us-ascii?Q?tulE+ojCgc7F6LdZg7azA+S5wzy9KuEYbeV03N8veJan92b8Vf/jL61pK4Ed?=
 =?us-ascii?Q?c/RL48Tv2KDPpsHzkLiC7GJjcRAHobpBDgsnFLSVWidNA+qAJ3QUk8InzgPE?=
 =?us-ascii?Q?vm/QJSLePqo0iO8aajQV7g4oUzZT5LFos1HXhIokvDlkINrX2Ivwffp/BgiR?=
 =?us-ascii?Q?Yb+fBKvN5yB/nOTWX4WkqZmiw429rf6nRNTeoK7d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	84YyIlW4sCdL/dl25YlcZCSHwDFaY65d0IYHwBSaoH///MrO56lKpjvUvGdOv+luVxxEzknVMCvASXYXIxdwDOm4VTAYPVEHy/+TeM9gDsBUl/VweyfRhHlVB5Ywc2ZupxXZH1cTcElpoJikvAQnSoCjhacEjfVOJiBlotNLhW3F4H4vAG2DG6FKODRF7/drBf5tutd401jeegKwv3O6XJBVJSHS4U4BNlJY7PGYl2erCx5rFon89iM7ATNes2mK8NyyKrf1rpSfyZ01hozAUsUgqmccfw2X+zKepVc5uUuWVIw/5mOPIc5iecB2VZfq0jE9s+O6ja4OuNJdD25PifRX1m6y8kCXiMdOMr1+OtXtELr+nqgDARmC4653GOIc3cf1WIpbfIdoggmHumGactkvpfBo0guurUIQj5mzkazJjlSBSaUiUHjfCRG0x+HmZfQkanxExo7pQtfAVp8WslGtmGbl3TcwL5YsZ5L7pVmLQO4N8/CNWr0ENaXh16W/gRH1914CeYtNPwnd6SYS2CD6dFuVhOhtiPEPac7fAUTcSAlh3z1IGG2RkPwO6+R3gFL7lfTe2M/Np8cxRiCuQHAaGvO6FKKr8r9cgwL9J13WoOKhHRd0D3OJZPEVJofB5zpuQq6q+k5o9a1BILpaQA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5ab181-402b-4752-5b07-08dd4204b244
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 14:36:49.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0PO1TuRqn5EVYBJKjg+8DtFZAfLcZn6Bx8mxEc7PlP89eJcy+UK92s1RWcPBksRcQzFxifDZSCyNDYK8br+zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
X-Proofpoint-ORIG-GUID: Fe0GcauUv_ArLip2VIbu-91EyQ5XnU1T
X-Proofpoint-GUID: Fe0GcauUv_ArLip2VIbu-91EyQ5XnU1T
X-Authority-Analysis: v=2.4 cv=VbANPEp9 c=1 sm=1 tr=0 ts=679ce00e cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdSt8ZQiCzkA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=PHq6YzTAAAAA:8 a=6F_kDPKpblOy84LOVAwA:9 a=CjuIK1q_8ugA:10 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 spamscore=0 clxscore=1015 classifier=spam
 authscore=0 authtc=n/a authcc= route=outbound adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2501310112

From: Russell King (Oracle) <linux@armlinux.org.uk>
Date: Thu, Jan 30, 2025 at 11:02:00

> Would it be safe to set these two bits with newer XPCS hardware when
> programming it for 1000base-X mode, even though documentation e.g.
> for SJA1105 suggests that these bits do not apply when operating in
> 1000base-X mode?

It's hard to provide a clear answer because our products can all be modifie=
d
by final customer. I hope this snippet below can help:

"Nothing has changed in "AN control register" ever since at least for a dec=
ade.
Having said that, bit[4] and bit[3] are valid for SGMII mode and not valid
for 1000BASE-X mode (I don't know why customer says 'serdes' mode.
There is no such mode in ethernet standard). So, customer shall
leave this bits at default value of 0.  Even if they set to 1, there is no
impact (as those bits are not used in 1000BASE-X mode)."

Thanks,
Jose



