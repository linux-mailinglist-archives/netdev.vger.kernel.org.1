Return-Path: <netdev+bounces-161629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF91A22C66
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 12:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AADD1623E9
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879021B6D0F;
	Thu, 30 Jan 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rrHvdnCm";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZAaLNxsB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vXAbsnh7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C82AE9A;
	Thu, 30 Jan 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738236090; cv=fail; b=JYs6oWZQxQrFRkBXKngARvVA4tNtteaFOpGVFmgGhosMcKkaa5DIky+l0Qf5Q99spozAi+n9YkIZV62S8iWzKcph/hzlvwmGBu2NyrLHTShDVeHLb6etx4T4Epd2+CI/kBMkm1FpS307n7zg2v7reNk0q6hKlmZBnJdiW20G89Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738236090; c=relaxed/simple;
	bh=aSmAlloLs1CM6tWGbpowHmaoEWHh4NiCX6i/n8EMHE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bna3L9LFc4l3hAFrAPYm3js7g9LYccl/pL5XIO8rv75JkO3Vcs6ZtFzIJHoL0sEiD3jOJ+CnST456i/5rsskjcMBvG4sgV+cmJQnelzCqlpYndosrhteaZ+Nf3ZzLRr4kAfWMM2cXAADnlcCDhFjSuQzAvLywzdt4DnKr8EDx74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rrHvdnCm; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZAaLNxsB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vXAbsnh7 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U9g73C027479;
	Thu, 30 Jan 2025 03:21:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=/JTBIasgk71WVto2qr5EYYC8qYwNKVoyYrwsGwvqvIg=; b=rrHvdnCmqQK8
	W+89R0tCwlXL9CQa3PUbu7K2Ihy2737Rr9YrRo3vQIiRc9mqf8riQS0ZMOKC2ViN
	aPfXQSyZXinwwuiRGZ0SdvYtj+Z0EUKF2X/l+WOqQKWthvkAzWrTaF4G7c2FUjr2
	gSXSyqNUpFc7H0jZ+7Cp1xKep5rfoX9ZjuCaFtaC5DPZ3VlwPkNuh5mKTgN2SrIR
	JXjXbacyj4ZpzFHp8aDWaNHuKtOsH6x31Gc+O+xTGGm5xxe4Cb5or0LmdWUY/oBz
	NVpiGDt5E9FQu6DVs6UE/lg8EANI6hGjmm+3PRfhnoEYoJ+dgA0PqQ9letW6YLsU
	Ah/1c7r4fw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44g7198dpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 03:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1738236065; bh=aSmAlloLs1CM6tWGbpowHmaoEWHh4NiCX6i/n8EMHE0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ZAaLNxsB+wlH40URXzL2+jLiFEDiw2liRUzPbm8NUuhBcREVTrkRBEIaE+7KwvtVH
	 Hnyrq2nyKa1dNQ3SeAHY1kSw4SWXqaLGdv0yQncyLBseorD+AcHRfI+gMDfXvrRQFA
	 HDNND18kM+WU7YuT9o/3KazBy1/NA01gl15K3W0OibBdn3w/NAIyU+yhlwWnX3arhj
	 L1PvJo70oew9Av86Pm8ceg1K1d/xX9UDIZk9TZ4hEUCBk9uhSy/L7AlBZLOpelkhrg
	 aihFbzSXk9MoG71bGf8h36y9Xv3EytJcPp0v6hTv4o3TlN6O2pJeTy8CW4atd3w58h
	 L/Dj+/3Z/nVQg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 82EA44059D;
	Thu, 30 Jan 2025 11:21:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 00C61A009C;
	Thu, 30 Jan 2025 11:21:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=vXAbsnh7;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3335540126;
	Thu, 30 Jan 2025 11:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmlpXb5MsfuAEr9U4K3YluLlcfMrfQQkqOJrOV+0kD9w4veaUfpQltFWSLojvRaVCWIM/oyIsIgN1dHUKvO/71jLYlXbm4cT5Qsr+WqC8rj8X4MUvrTDd6SKlqMtvg+rdRJD94Ut5Rez040oRyQGqRzLv1kDrHnho7XNuvrfNM6d5oUhRuN3FfZSfB7iWiQtImOJ6pzfMPAvOBLratwSImxhMEl3GpxPFY7DDOJS5tFvBY7lAWDtkXrjQ2s7FUCxIKC/yabQ04W8iYXF4jv3wdBUG5PUzrHxyldSBS5CVsOwNn0bbyfzND/0FIy5rOhVIYWXGfQqrU0xmkusCUTJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JTBIasgk71WVto2qr5EYYC8qYwNKVoyYrwsGwvqvIg=;
 b=cA9iKw2LHTveK4W6cq9ILeRwRxryjqZTh58OlrkVWgfvcfbfcH/T5fBEwT6HccvRynsaAAnw28JYDtfsZ4rwhpQkEBRG6BeWHZw0rrGbCkU7RT1pZIi1ysOvUsayuXA++KRK3IbR3tIp2NLQtmEUFJa8iYXBVaMDpaiFFQeEkjRAb6Nmb7VnX1jBAbAUmxWACC5P46orUEs45rym5W+EYhq5rWSTCroUQ4Az2w2Wh8of6afb1HaB0BrTvDka8doL5dylH5g+97EIB0ekiXtyWm9n5HAwVRdg+rIhfonej7q8O64DKaj9AFflSQtMp9FxJJ6nyf4Kmk/wv8L84wp/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JTBIasgk71WVto2qr5EYYC8qYwNKVoyYrwsGwvqvIg=;
 b=vXAbsnh7y2DVI0cGVgj+f6hrcEupGTTm758veUmQO4dsTKDoxLh+arNm0C0LcBdl1quaZlL6FfvEGpYuefGalQISQO+paUU+RZRopcpOyItfr3T8Ael47b+dEDoPdgQZkiyVu6/wWU1SVeXB1JuChn2RrjHIHqo4mOsIhEmU70Q=
Received: from BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 11:20:57 +0000
Received: from BL1PR12MB5077.namprd12.prod.outlook.com
 ([fe80::2402:e178:e68:fef0]) by BL1PR12MB5077.namprd12.prod.outlook.com
 ([fe80::2402:e178:e68:fef0%7]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 11:20:57 +0000
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
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Topic: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Index: AQHbcwZtiX2CcNa5zEuI6dm3yXlcQbMvK6OQ
Date: Thu, 30 Jan 2025 11:20:57 +0000
Message-ID:
 <BL1PR12MB5077C5BC597D6AC44B6ABCDCD3E92@BL1PR12MB5077.namprd12.prod.outlook.com>
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
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTQ1MmZjZmU1LWRlZmMtMTFlZi04NjdmLTNjMjE5Y2RkNzFiNFxhbWUtdGVzdFw0NTJmY2ZlNy1kZWZjLTExZWYtODY3Zi0zYzIxOWNkZDcxYjRib2R5LnR4dCIgc3o9IjQxNzgiIHQ9IjEzMzgyNzA5NjU1NTc5MTc0MyIgaD0idUd3RHA2RSs2U2RtbHY4cG1nMFVuNEdhSStVPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5077:EE_|PH7PR12MB8780:EE_
x-ms-office365-filtering-correlation-id: dc10767a-cdf0-4d2f-e8f1-08dd41202b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bUuKg2v3JhBpcNszcUHNsgAQSyUn2v9ELVuqrwlgvVTbFO9DA3xHrHFrUs5K?=
 =?us-ascii?Q?nrASqYYHHH5Cng5qRIYV2MB5F5t1ec5I9Afcbe47a4pbCPjiwM2kLUORcmNy?=
 =?us-ascii?Q?cyOBuJS1mkuAkvypjeKjxRBRpRfG/ObB+I5zO7mrAGmpJMbDAYJFJkE/lcOf?=
 =?us-ascii?Q?itMdClirAcD/pTXDImB3ojfhF4cqgInAsGJbbP5jjAEBI1ZcvpLXWeu6jU5g?=
 =?us-ascii?Q?/E+JpBWf75ig287eLGmV81CP/GSt9PrN/KCHnSSjZnNeLZw01EN/8bAfe6rp?=
 =?us-ascii?Q?ZD/5c/jW/3uydYR7rF0YNRsSVr/c5SSP7nrhEYgC0M89MiONXGvPQBRVeD3v?=
 =?us-ascii?Q?T4LBNPMTS9Q9PRq7HZZdBr8L8wJsHXqF7ToXCoBxoYDixNsHjNFIaAoofsoy?=
 =?us-ascii?Q?RbYZdghlhhkOWgQrSyrJO0h5add2eCtaLdRJ03CxtNm7OmSndvgMYM/i802E?=
 =?us-ascii?Q?w5Z33MSuestSRyV5mwxGA+AeL1evztTOLG5RFrK5w8zdn4YAf08JK8uATJ4G?=
 =?us-ascii?Q?eCaXDYbBWcxWF072KLutg2zxrgPjRtM89LjEHeaIkkLjV6vTscechd7vFAi2?=
 =?us-ascii?Q?cg1vrGYMBgvenENDVZv2EQfduBKz6njSO5LC/iT7STIP5xgfMiG/ublsM5+1?=
 =?us-ascii?Q?Ti2QiwjZOfTW5FQx99jAiBEN6lbI8YBhODjN3pxuG4DMixjVDPaiCN1Wbb8b?=
 =?us-ascii?Q?YlwI71L11sk65pIbCxp6/zmWguoA54pDsJxl4SHS4jjIS1ARcm6vlN+pCDRP?=
 =?us-ascii?Q?pZjGBa7SnLTOG2sXeMQWiF8g0FR/m2f2jGlidsAfyTSSxDHvQWg6XvgwjFh1?=
 =?us-ascii?Q?ZeiyaG1LoHT3+Pxjem0unARmubKCA6OR55Hegg3xNtkov6E/ziAEWn+ExMLA?=
 =?us-ascii?Q?qT9gv8+EiPqD5y88nxJGmhGYv+NesFvS4MX86JAHMKMYqQQCj0+0b4W827rh?=
 =?us-ascii?Q?U9cI5Ax6VPwtF5f8nJQ3mgZv/YgPWY/n+ZLpYcK1RBn2RGBVkJdKQjDiYOTC?=
 =?us-ascii?Q?Jvndf1/Z6K6i3GgsD3qCuTtxHjDtiqKjrXnoKgGYsgytBbYsKQzGjQXDNUKp?=
 =?us-ascii?Q?C0vIwykcK6Vdck8HkqyKfOQBsDSfB5q0G+YvXoNUct1wfFMxNIzIY1ChCOLp?=
 =?us-ascii?Q?GPaxYNbJ8bX6kLdoA/WgNkpTFhPPKYvBIFgPraXWvWctm7hG0SvjWVl4hbXr?=
 =?us-ascii?Q?MVncyHEONR/bmzu9naIMAuMRGauhNfpd1kwCF788Iw1qpPwLw1kdhAvFINg5?=
 =?us-ascii?Q?THXbMLudKFdq1S+59VyOvpJ92A8BJXsVIp5IkAoISYspB+izWra6qAym87Ye?=
 =?us-ascii?Q?BFP/Xc0F0OCcrXLTTz5FPHTU5GN6DcvZWN4qn1N3rQ4BCps0Mddlb8t3Vb/w?=
 =?us-ascii?Q?/xAVyaoqx6wMrz2fN6n45c64bpkVo+n+dWBKPq4kMMlNhoIzaw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5077.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Tq4UPX4lKnc3HgYQtl/Ww/RsdtLSwbj6dyf1CmFMF9kcAlBXQ4q5lPsmp6Al?=
 =?us-ascii?Q?swhnnAQk3vaiKgBm0+AW9oVV8RqDBT1awfom0kkyBQfUDmPyhav2jZkY2fp7?=
 =?us-ascii?Q?1hZ3H7Ejvx0h8NJXyzzG34aEMrxgAj9ceJcoYq76dQoG/YJJGGI+8UvtvFyg?=
 =?us-ascii?Q?S4ciZVA+n8bc4DkPpQO2ACIPosyuiBdCU9k1B/6jPTXGRSUri5KWJvA39d4L?=
 =?us-ascii?Q?P9FPIPp/OrgTV1c1O+pw49aGqSn3lHn2PWsGu4/IKEjhbJXbgajdNOJ4gFaK?=
 =?us-ascii?Q?ItUX2PDrc6YbuME88aM4q+UwKV07WcAD4u0ZxVfBHn6yHRW1qjyoTCIn67eE?=
 =?us-ascii?Q?u3A+oVYcx0QerWYqZOWSzgdDrz4uur7uLNTBqNiHNUKMyJYE9u8nN5+C4aF/?=
 =?us-ascii?Q?oVw+RdBO5MEmAbgKByhg8mQIxuqKJTvMYbGVRp2m+3EWjYH0q0IxtvCXdzig?=
 =?us-ascii?Q?HXeihK7znxQxD7zWzFA7EH0ConamtdAD1qdYpaObWHUVRmYuJS4KjlcJgE6k?=
 =?us-ascii?Q?pCNzlPS7fSCSG+a40p+mQBfUI4nf1UoCJ7iyFpD+6SJq13tUegwJEve6BYL9?=
 =?us-ascii?Q?BtlmZ9ZdJ3oRJJG0Czsav1Ofc+Ezqsk0KzFoP+TLRAB4b6Zgx+eJpMFI48b0?=
 =?us-ascii?Q?88ov0od1HUc1xM4pL7xqSKTj/DQ/frZrU03ykV3+mAbFrOjvcgbsTuiNHqhR?=
 =?us-ascii?Q?kdUjzAapnDTNIPQ4UpX2ZJws/Qjn4ILmO1euyumlhA/cfXzYFwGWUwhxOsjj?=
 =?us-ascii?Q?2cKHyjGYz0s2uh2est3TAHs64sq2UnkFhGEEiVdtA0BLq7YAKfR0C8WPopS6?=
 =?us-ascii?Q?YDhIIIhraLdcMejDNNwgPGL1JZcTrSVMOmR06XBIaTiyUDe347n35PR1TvA+?=
 =?us-ascii?Q?tnnKFuT9mzigtvWBx5u2l0pdH414BLlBXWJ+r1J5rPUPI1wgGjNahZuziRcX?=
 =?us-ascii?Q?Vj0SMRq5nsOBkHj5sYAHHns9eYcEQhAQ6VuI4R20hgRbY2c3CurOaMz+Y4rE?=
 =?us-ascii?Q?x8REpCebnLi9W8fWgFxtPuWIdp5X8/kza/OBrkcIlUhiQBJbQo6fOJLj2tAP?=
 =?us-ascii?Q?DhnM2JZO0KKjYNWSN6Q6Xn+gll3qWimSRDkX2gNglkOif52YHvgppWZ2vnWK?=
 =?us-ascii?Q?Cff88oEajStGhLR7vHxEfOYiC3nYXBqJufwOoQJemtBiD2wuYOT6EzIo3C1Z?=
 =?us-ascii?Q?HdX1QKxHrZRchcMwG0MmzZjvLhDW5UAqZ77odM/pbKloGMiA9rip+EkU2G/N?=
 =?us-ascii?Q?U9BSV8uyPdkhV82bjUn4YURl9ULXl4G/gBNpzWIQgIDMIHoG+5W6dbrEcCvU?=
 =?us-ascii?Q?PcNw04LaetsMcLSCDMOEiykKNRiXUjXBgIBUNguVnCacUIpEfbXkHoUgkdwj?=
 =?us-ascii?Q?Grz/QQ3Q/ITKBelahifdjab+roo20fn1uMmW0qg05xcl8qag+yefxTq2W2Lc?=
 =?us-ascii?Q?ZxSno4Gb4Na6ALPGOOVrqLK5lSsY+J8ku2mgN+wdEDURLGlofS2tXD9Jf/FH?=
 =?us-ascii?Q?r5qbCiSkSNaAc1RdfwXLSuvn6NBAz8Aiu1N9J3tKcbL3OUCtw739fmbPet7Y?=
 =?us-ascii?Q?0SJrMySsCEoxOZUY3VNyjd1LckglLhnv2FekvSq8?=
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
	N97MUEnmier8TSnhXpAV8J0hiVQfD2Pp9gw0Ogcb0atPOEMxLZVVq/TrLQrjmZNNhT+V11f3m67Ma670jMNyrXQrp31k8GGC1bF4pdPJDvdtkedXGZVyK9XTzvp1VVTScQz6n2X2pNzpJxEzZIlhMTGJGfrmvbopW8eB5rwNEO3HiZRi5MELcu5KIdI6dWcE60GQqJZwqZo83VHjGF/3SlN+7QltLss8afD4598tqV1vWI5Mhy+VggYYWZtKlWaogamtYY1a/ASZoRo+vxcMz8CWLk/quq85FJNlOkDV5GTuq6w+z5DtBmLcdWbLLan7ucxI/2J+Mg3llPSRlcQgFBi7JBLWjlA7ah8q5DVjd/QkOUuUZ+KSGboVaUHeIHPBvqkFGFiRwYdN5QDOrIEb+Ul2HWny6wxmeuczWlxb4eLwYyaU34N/7k7zWd2fucPeCWPAq2pCQHF6mh5yD5twyhnOZ6h5KddfIot4BjkaskrdqkvVaeJFSuYplypyirkrQQl+IkmTW5f/ZhXVdOm2yj5junSRkXA1GBWAdOx10/IHfVTOB52mLtgfxqPu9yuyk1tDP5fXTEaoTnrKi5tVPuiG6/ZyCzacaZEYvJHif+lDwYfYqnScMw8tZuXR7Uhk57XIh4jldn6eRIWwGUEe0g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc10767a-cdf0-4d2f-e8f1-08dd41202b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 11:20:57.3634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1jPKdfotqawjM4i37HSze4dZiGSG2Xmy6Rirj0oJqrPk6VmyScZXsehKY22B4LPTiihxKYBhqx1kVz4GMDQRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
X-Proofpoint-ORIG-GUID: 19AnMEYCsT-bqvDUJ0SOwRsGfCEHMgwf
X-Proofpoint-GUID: 19AnMEYCsT-bqvDUJ0SOwRsGfCEHMgwf
X-Authority-Analysis: v=2.4 cv=H+8hw/Yi c=1 sm=1 tr=0 ts=679b60a3 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdSt8ZQiCzkA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=XYAwZIGsAAAA:8 a=PHq6YzTAAAAA:8 a=zDsSoRlSe-ZHjlVMmcgA:9 a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501300088

From: Russell King (Oracle) <linux@armlinux.org.uk>
Date: Thu, Jan 30, 2025 at 11:02:00

> On Thu, Jan 30, 2025 at 12:02:27PM +0200, Vladimir Oltean wrote:
> > On Thu, Jan 30, 2025 at 04:50:18AM +0000, Tristram.Ha@microchip.com wro=
te:
> > > This behavior only occurs in KSZ9477 with old IP and so may not refle=
ct
> > > in current specs.  If neg_mode can be set in certain way that disable=
s
> > > auto-negotiation in 1000BASEX mode but enables auto-negotiation in SG=
MII
> > > mode then this setting is not required.
> >=20
> > I see that the KSZ9477 documentation specifies that these bits "must be
> > set to 1 when operating in SerDes mode", but gives no explanation whats=
oever,
> > and gives the description of the bits that matches what I see in the
> > XPCS data book (which suggests they would not be needed for 1000Base-X,
> > just for SGMII PHY role).
>=20
> Hi Jose,
>=20
> Can you help resolve this please?
>=20
> Essentially, the KSZ9477 integration of the XPCS hardware used an old
> version of XPCS (we don't know how old). The KSZ9477 documentation
> states that in the AN control register (0x1f8001), buts 4 and 3 must
> be set when operating in "SerDes" mode (aka 1000base-X).
>=20
> See page 223 of
> https://urldefense.com/v3/__https://ww1.microchip.com/downloads/aemDocume=
nts/documents/OTH/ProductDocuments/DataSheets/KSZ9477S-Data-Sheet-DS0000239=
2C.pdf__;!!A4F2R9G_pg!d5VxaxYsejdjBjTrDkvz088ikSu1bqS5__YXeLsQoUSIaWwZXCteY=
Omp6liFtPkRC1s96h5MuhFBjKiYtJ6DPA$=20
>=20
> Is this something which the older XPCS hardware version requires?
>=20
> Would it be safe to set these two bits with newer XPCS hardware when
> programming it for 1000base-X mode, even though documentation e.g.
> for SJA1105 suggests that these bits do not apply when operating in
> 1000base-X mode?
>=20
> Many thanks.

Hi Russell,

Allow me a few days to check internally, I'll get back to you.

Thanks,
Jose

