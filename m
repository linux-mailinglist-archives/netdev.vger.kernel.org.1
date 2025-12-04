Return-Path: <netdev+bounces-243579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A8CA4021
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 15:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DD5130093BB
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9A342CB5;
	Thu,  4 Dec 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Rcd2TA11"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0B340279;
	Thu,  4 Dec 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858479; cv=fail; b=pvlrpEkv5+eULAqclhmK3vI+wET7D2eLH8Ygpdd1wDTYObe76015Amvl6JEVmJoGsykF5imAE7VEa/3BNrYLR6TrIM4DRxvFZsGUliL0uSCx37hAbFq+KgiYLJDUNxKMCc4oNgFDmHT3GTyb8ZHIRXgevUUmQ+c78CJRI+nOY70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858479; c=relaxed/simple;
	bh=lIDYvIO4Ue7pwHMWCIqnq+762Eqp+t1GurNDHk8GmTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n904jrrSbLW36I1P6Md5XBIiiZAvtN0XdgCGuFBaKidplLhs9abDJCTf24ZnfFcwcTl9KL3FMsXviPS15evQqAFJtMQ2lrZzr/Z5Fo2zRVIDBThLSJ+67qFHLReZbnCr6sjwNNQD1XdaS8dvO2aTQc5LEHcgh8OTme+7jzkmB9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Rcd2TA11; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJbMPD8qaEmPBcYWFn9NJjGJyCDEHvADQyYN/PKkG11/iuSjxnOCwRYQyRSsdIh45mJhXMztj8otv9kos4RFf5LIOaT5P39EaLrRE2tiofUJ4jzKB4a8anITRRhJ0F9jFydVe0rtA8AX46DYjz5SihcGnddAjcVcGh67hGyYtTc9s+fnw6TYmyc7fDjQJjUUZimB8CE6mgN0vY+2WQ6JzWeM10S3ABG9LlYrXoRHcEvz1lYhOhKE0+cxA2BjkI30/d+gnBpmg1sZqUWclWQZXRqXNv8uXFHtdm83/cMgw+UjGpeSbGeGviM3PYC0cZ/heNoNGCVlKqbbNNdw7nTuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIDYvIO4Ue7pwHMWCIqnq+762Eqp+t1GurNDHk8GmTg=;
 b=mtk8vXSjn+KE8/xF1fWdIIR3ggyD5AgN1DwZVZIfFj+/e+QwWiPxYakeTQSFoEpoqpkqQNw0yP5yUbHg6AzFWLM03ZgezKua4EsAQO3AtcJIlyGU2npZFpSfJ3zX5WZ09Z5NF8t8CfRB4oqZCmVjXLpyoVpY2KKTJdTUMNTzgQhQHLf9ZH2zYOnCuPkAy6BucW806gr3H/H9Kb5LO1tOzKH2+N1fcKMAPH2cU9YyCJnz3Ksv1uMVQx3pPhuEg0QwFuLZ5QEiHiHRLzd7tv/uvc7S/PVTBfeEVXon2QebeggM/GdHQB2zM1xOu9JstjaiuuO9Em+DPAOpjAON5HgEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIDYvIO4Ue7pwHMWCIqnq+762Eqp+t1GurNDHk8GmTg=;
 b=Rcd2TA11hYA3XED/X6cutsD0miuBJK4g6J8nnzYMZgKx7BaDLy+VyTlo6I9kGQzlRtad5vxTAIK6kOzvcdXA4tLVWxeJu25Y/4JTCp/s5gUWN/TnMc+VMC2GxX8oPpXhERK9Nz9JE5gRf4LtPtJ91/jWZCLiIyiZksoKiu4eqUo=
Received: from VI0PR02MB10631.eurprd02.prod.outlook.com
 (2603:10a6:800:206::14) by AS8PR02MB8760.eurprd02.prod.outlook.com
 (2603:10a6:20b:53a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 14:27:51 +0000
Received: from VI0PR02MB10631.eurprd02.prod.outlook.com
 ([fe80::7f57:534c:1bc8:2ef0]) by VI0PR02MB10631.eurprd02.prod.outlook.com
 ([fe80::7f57:534c:1bc8:2ef0%6]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:27:51 +0000
From: Ivan Galkin <Ivan.Galkin@axis.com>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"michael@fossekall.de" <michael@fossekall.de>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "robh@kernel.org" <robh@kernel.org>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, "olek2@wp.pl"
	<olek2@wp.pl>, "kuba@kernel.org" <kuba@kernel.org>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "edumazet@google.com" <edumazet@google.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [net-next,PATCH v2 3/3] net: phy: realtek: Add property to enable
 SSC
Thread-Topic: [net-next,PATCH v2 3/3] net: phy: realtek: Add property to
 enable SSC
Thread-Index: AQHcZJkW7moXoMhfEk62W8FjatzRy7URiyMA
Date: Thu, 4 Dec 2025 14:27:50 +0000
Message-ID: <f9c612bf9ad9b2990d456e6673a65b95438d6c7c.camel@axis.com>
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
	 <20251203210857.113328-3-marek.vasut@mailbox.org>
In-Reply-To: <20251203210857.113328-3-marek.vasut@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR02MB10631:EE_|AS8PR02MB8760:EE_
x-ms-office365-filtering-correlation-id: 532e6ac8-3d90-4927-e5e4-08de33414e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OU5WbUZ3b0pBbjJpVGRvRGNwNEU1TGNUNVB1TjBOUlVKcGYrUDdURGhHRW1F?=
 =?utf-8?B?dC9jdWlFcVZmTVQ1blluSnBvMlBCdGhWY0hzNXI1anRVTFNMcGpnVU80R1g1?=
 =?utf-8?B?ejgySlpjTDZoSk9hNmRUNWpmdDUxRkpUTTRxTWRwTmZiU0pUclNFQnF2UnV3?=
 =?utf-8?B?akFLY0FMQnJRWUVnN1RBY21pT3N4aUt3WmFUUjNMWkRUT1JXZHZ0aENkb1RL?=
 =?utf-8?B?QUhOQ2dQRGFsZVI4K1d1emNORkJRT2x1WHR4T2VKcnUvTk5XL25BZGdJd3NR?=
 =?utf-8?B?bkFzUjRVSDc5dUlmL0hIY3F6d1loTFJuSEZDN2gyZjRFQlc1MFRDTEhwUFlB?=
 =?utf-8?B?WXl4eTFjK28zZlcvWVY1bjNLOUJTVHp0bHh3a3IxZHltYlZCNzZ4WDREdW5j?=
 =?utf-8?B?WHZ2bnNrb05YOVcvbE5HditiWm5mWWVxRC82Z1IyNW9mRXZUNDkzRG1UNVp2?=
 =?utf-8?B?a1dxWW1MTGN5R3dWY0s1cjdDVlNXRW1vV2FLaDVuYzIvOTU3WFV6R3Y0K2FD?=
 =?utf-8?B?cG1ROEFqdmQwdXZZemg3T2gvVGFaUmcxcTJadTlNcHpaOWJnVEFIYUkvWHY1?=
 =?utf-8?B?aGRDQlFHbVVld29sNWlvRHNPM1JDbjdIWlpXK3I5OWtBaC8vNFZydnUwTERV?=
 =?utf-8?B?TXB6Y1JRVmxxdlF6azg3Z0phdzI2UStTbFArc2ZwM1ZMd1RyTWcwQlRQcTNV?=
 =?utf-8?B?VkJkbFVCMjlXMGlHaXRyNGlibVRoRHZxKzV2MzhqbHJsWlNaTFk5b2NIUWZZ?=
 =?utf-8?B?djlTUjlZNGtHZS9KTlBZYjJDaFoxZ0lCaWRBOWNiRUhwWGorSGljSWJ0Y2Jy?=
 =?utf-8?B?WkhDSEhSbVY3TVdSOEZRS3l6VVljTWwvVjFMQUlyT053a2c4SDduSmpyeHEv?=
 =?utf-8?B?ZXQwQWdnQzAyN2g2bWNHUEJOZ2IyU3JIYWVoUjVSbytzS0h1aTVRdi9MbHBh?=
 =?utf-8?B?b1NFSEpIeWVOamkzRTlncy95YkVKQTc4aVRKVFcwekViOHdWMG9HMzBoNDJI?=
 =?utf-8?B?dEJpdG5aMkNZTmRxdmEyeThlUnJoSDlVb01vQVpxdGFqd2E0OElib2N3Uy8y?=
 =?utf-8?B?Ri9yVmVWaWpmc29CWmIzOGs2TFZyajZ6VFhzbmFacjdBL1kwYy9oeHdLOHh5?=
 =?utf-8?B?YlJsOTB0d2k2SDJRZ2xCbWpUcGVxUVF5eUQ5dEgxZHVGVTFpTHZvdzNBSzN4?=
 =?utf-8?B?QVM5L010RDYzcXNFdnROdmVBdHJGMGxFMnAzU3JSKzhidEVWWVdIUDhZR3Fz?=
 =?utf-8?B?QTJCQmZod0FRSnd1ZldoZ01sUEgreGRrYWZTNVExR0k0QTBRT3FuZjJGZWtk?=
 =?utf-8?B?OVorS0Y3WnRzNlpGa001YTdKbm1PYUtZMzZqOFFIdDArU2JWcjlzUit3VW43?=
 =?utf-8?B?NlpXbU0xZG1JZVNqcjY1c3Y1aTlLRTgwcjJBTkNEQmg1RkFFeGVBYVkzai84?=
 =?utf-8?B?dzh5bGFPd3dsSy9weFVUYkZ2L2ptb3FxbXJqc2ZBQUx2NUpETXAzQnlPczFu?=
 =?utf-8?B?YTRrWFliaHZva0c3VmduQlpOTzVaUy9kYVNqY1FCL2FTZnhnN0FpSlFJYnl1?=
 =?utf-8?B?b1FXazFqODlydFVTL0U2MTlLS0d4dnVkWk0wc3JoM09sbEo2R1BvVGIvbktE?=
 =?utf-8?B?WW1QS3NpZHVWdklXU2J2TGNKWUJOalZtZjljQ0syMDNzZUo5dFl2WlJoL2VJ?=
 =?utf-8?B?czcrcFc5U2s0ZGtQM2NJYTdpN3o2NytzSnAwYi92dVB3eUJkT21DMktwM1N2?=
 =?utf-8?B?WEhSN2IyS29JdTJDZXZVL0ZoT1IzVFZnQkgwTDNxNnd4VVZIU2cwbnBneEFC?=
 =?utf-8?B?dDVmSGlseFBLUVRNdTJ1ZTh3alFkM0I5ZGlQTXVyNGtjK05aZzVZa28wNUJa?=
 =?utf-8?B?SEluMzhOcEM0UWFCWk45bTk0VFZGMjZBd1hJVjBIRWZGcis4TVJKUm1Mai9i?=
 =?utf-8?B?bHlTU3h2K0xGWEVsYjc5RWsrV3Q4NTA1TVNOdkZ1eEt0WFVnNFVmdG5LR0hQ?=
 =?utf-8?B?VnVWQ0FPVStybjlrMUNrRzBLWE9CcEc0b01RcjdvZ1IvR2tQU1ZGQ0xENm1r?=
 =?utf-8?Q?4JaQ4g?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10631.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akxwNXM2S0lRUGs1bXc3eVlJMDVUdmM4Y1BUSFA5SVJTT1BncVhnc0NiOXRZ?=
 =?utf-8?B?OGdRWVNaTnRGQmk5RE5OZUZ3ZFFXdThRUHU1eEx3d25XTUlEMDNPci9aS0ha?=
 =?utf-8?B?VW9pbkJ3VDRkUVZTYUpGcXAyN1ppZmZKYkhHOVhWLzBWZDZhT2hCMjN4WS9r?=
 =?utf-8?B?RGhVT01IdHBZTjRrcEVqbVhYUmIrcWZaazBvY0JsOUk5ck16MDJiMGozRWt4?=
 =?utf-8?B?NjM2T0NES0Q5ejRCMDlsVXUxc1ZTemtqTU43eFJVMUVwZWlINnZRdmtPK1Jz?=
 =?utf-8?B?VVJQdGpnbFhCREpOYjAwUjlRSXpIZVlFUVBzOEdkMy9pWGprS1kxOTJDaktk?=
 =?utf-8?B?Y20zYzYrOTBoa2JnUkd2d0dINWlLVXFmY3BSbmFMaGZLNnljNVM0d0ZSaWx2?=
 =?utf-8?B?bGdrRTYzak9OSUhXTDBIS2JacUxBSWU4Vm9YdFBRelpmL2xNbDd5aFNscW43?=
 =?utf-8?B?ckQzQW5zT1NtUHlnamhMeUY0RmRrQXJ1N3VXOVkrWGZpalNBTE5MVGt0TTRy?=
 =?utf-8?B?OVZidzhQZ3dhMk11QUdNMWtaTFJQNklMVmJCbnMySmJRcUN1YW50bDUxby8v?=
 =?utf-8?B?eCt5NElNY2hSTCtWY3BCK1F5emVLME44djRXVDZwMXprU0pGZ2pqOXJWREVk?=
 =?utf-8?B?UldkVEluZjdBNUNLc3NwRmJRK2VWZ1VZYVgzZzZoQXplMFV3RnNmZXRIZlZ5?=
 =?utf-8?B?NmsxckM3N1BZTHJTQVJ0WEV6bXRpZDlDZi95dU1ISjR1a0h1TW1yYnV2TW4w?=
 =?utf-8?B?K3U1ZmJ1a2hHRDJaUHNpWGRTcERNRkJpRTk5TVp5b2NBTldIUXZtWXB0Qzc1?=
 =?utf-8?B?YnNlK2Q3a0kvejEzT2dOOXNkS2xESGx2TWdoTGpTN1I5QThtY05Jd3VwODRh?=
 =?utf-8?B?TDFOdG42ZDlhUHh2ZFlndnM2TzJTUkJxeXIwazhwWWRzajJWNzFVckZDeGYx?=
 =?utf-8?B?elFQejVHV25UNnFQMjR5a1VZVGlMd1UyOWt5cUM1TGpiNWUxVWVabEpRMzh6?=
 =?utf-8?B?QXQ0cGp1NlJxaU5pNUt3dkZIWFdqalVjWkJBYzBDSjFuMklnbEhtVU9rdWFR?=
 =?utf-8?B?VnkwOTNQT09sZitOQ3UxQXptNmZWeDdSRC91c2E1WDU3OVUyVFdBMjdCdXFq?=
 =?utf-8?B?cXc1U2ZjekY4Qm5CNy9sMHJRQkFia1FVR0kyTzUrZG1mdHFxQUtFRGpzUm52?=
 =?utf-8?B?KzV5VUsvS0hEOThSR1p6UGZyUGRmalpodWVpNVpybWVhWEtiWUg0a0lhUits?=
 =?utf-8?B?YVkvUHkyeTlDdkJJSXpXNjQ0V1hvNzJSZGxxakFQNmR3cXBmeGNHNUU2L3dH?=
 =?utf-8?B?SW96M2VlMVpvTUkrMXBtVUFUdm41NVdCNDM2eXpnRVJuRmR6bFdIZFdRaE1V?=
 =?utf-8?B?RlQ2aTVjeXN3SVV1UVY1NGNwaHRZNDJxcXhsNjk5OU9md3RPRHRRSTdlT2Er?=
 =?utf-8?B?OVRGcGIvWkllc2RVVlBHNmM3S2hFbjAvWEtMMmxvU0NkeGM1VjZQdUNzTmsz?=
 =?utf-8?B?V09hMkZrUWZsLzc1dmNsZ3hiSEVDY0pDZ09EaGpGVXRqdmQzU2ZmcHhWWWdx?=
 =?utf-8?B?UWFad1hHanY5dm4zTkpPZUJBMWhQeWpWaFpwYXV5THBWYm4reVNkR3FkMjBN?=
 =?utf-8?B?Q1lFN2hKWWo4bUprTDR2N3RKdDFERXR0TGdnQmVyM0xpQnVsdmhQbUZ5Vmt6?=
 =?utf-8?B?ckxobVF2UUtOc2VPWTUwcExndXZtbGVZK2V2bkNLK1FWNkJiUzNzcFp6UGJM?=
 =?utf-8?B?NThEYndLY0FiQzNFRWdsdHMzSFlwZ0Q1TlNOTVR1dnZqbWE3Vk5XbjhSOVpJ?=
 =?utf-8?B?Q1o1UGxFdFpmaVc5cEFocWVZUWVqM04rWEV1MndqT0JxSUNoWjE1Z3ZLa1NK?=
 =?utf-8?B?NzRRdW5JdWtkUGxJK2FqTkMzWmFNSFo2eG1keVV3eG1jYk1vaGQ4Q2FWTGtG?=
 =?utf-8?B?QW1DejFITFRRR0NabDVoU1JyamJ6SG5DcVNmV0RsVUg3bloxWUtiak9JOGxC?=
 =?utf-8?B?dVNyYS8yWXZIaGo2UTZ3bWNqcjlDNk1TKzZSWkk4aHBaTDhtTzBwZDhoU21S?=
 =?utf-8?B?di91aVZoNDFZaVdwYVZISTR4dk9HTkFYS2pJUllwTWRjOGJnenRIZ3ZPSUk2?=
 =?utf-8?Q?1nj9AzQriIwKare/qQT8Zl0zX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F907FCF14AF9D40A1B21703AF660650@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10631.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532e6ac8-3d90-4927-e5e4-08de33414e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 14:27:50.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzRqyN0mbMWiFSrTbelwws2ttOml56SjAq7xz5O6Dza4i4ulYgijyr20bPtdfVCv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8760

T24gV2VkLCAyMDI1LTEyLTAzIGF0IDIyOjA4ICswMTAwLCBNYXJlayBWYXN1dCB3cm90ZToKPiBB
ZGQgc3VwcG9ydCBmb3Igc3ByZWFkIHNwZWN0cnVtIGNsb2NraW5nIChTU0MpIG9uIFJUTDgyMTFG
KEQpKEkpLUNHLAo+IFJUTDgyMTFGUyhJKSgtVlMpLUNHLCBSVEw4MjExRkcoSSkoLVZTKS1DRyBQ
SFlzLiBUaGUgaW1wbGVtZW50YXRpb24KPiBmb2xsb3dzIEVNSSBpbXByb3ZlbWVudCBhcHBsaWNh
dGlvbiBub3RlIFJldi4gMS4yIGZvciB0aGVzZSBQSFlzLgo+IAo+IFRoZSBjdXJyZW50IGltcGxl
bWVudGF0aW9uIGVuYWJsZXMgU1NDIGZvciBib3RoIFJYQyBhbmQgU1lTQ0xLIGNsb2NrCj4gc2ln
bmFscy4gSW50cm9kdWNlIERUIHByb3BlcnRpZXMgJ3JlYWx0ZWssY2xrb3V0LXNzYy1lbmFibGUn
LAo+ICdyZWFsdGVrLHJ4Yy1zc2MtZW5hYmxlJyBhbmQgJ3JlYWx0ZWssc3lzY2xrLXNzYy1lbmFi
bGUnIHdoaWNoCj4gY29udHJvbAo+IENMS09VVCwgUlhDIGFuZCBTWVNDTEsgU1NDIHNwcmVhZCBz
cGVjdHJ1bSBjbG9ja2luZyBlbmFibGVtZW50IG9uCj4gdGhlc2UKPiBzaWduYWxzLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBtYWlsYm94Lm9yZz4KPiAtLS0K
PiBDYzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+Cj4gQ2M6IEFsZWtz
YW5kZXIgSmFuIEJhamtvd3NraSA8b2xlazJAd3AucGw+Cj4gQ2M6IEFuZHJldyBMdW5uIDxhbmRy
ZXdAbHVubi5jaD4KPiBDYzogQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPgo+IENj
OiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Cj4gQ2M6IEZsb3JpYW4gRmFpbmVs
bGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPgo+IENjOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2Vp
dDFAZ21haWwuY29tPgo+IENjOiBJdmFuIEdhbGtpbiA8aXZhbi5nYWxraW5AYXhpcy5jb20+Cj4g
Q2M6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Cj4gQ2M6IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz4KPiBDYzogTWljaGFlbCBLbGVpbiA8bWljaGFlbEBm
b3NzZWthbGwuZGU+Cj4gQ2M6IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4KPiBDYzog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KPiBDYzogUnVzc2VsbCBLaW5nIDxsaW51eEBh
cm1saW51eC5vcmcudWs+Cj4gQ2M6IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54
cC5jb20+Cj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnCj4gQ2M6IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmcKPiAtLS0KPiBWMjogU3BsaXQgU1NDIGNsb2NrIGNvbnRyb2wgZm9yIGVhY2gg
Q0xLT1VULCBSWEMsIFNZU0NMSyBzaWduYWwKPiAtLS0KPiDCoGRyaXZlcnMvbmV0L3BoeS9yZWFs
dGVrL3JlYWx0ZWtfbWFpbi5jIHwgMTI0Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKg
MSBmaWxlIGNoYW5nZWQsIDEyNCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3BoeS9yZWFsdGVrL3JlYWx0ZWtfbWFpbi5jCj4gYi9kcml2ZXJzL25ldC9waHkvcmVh
bHRlay9yZWFsdGVrX21haW4uYwo+IGluZGV4IDY3ZWNmM2Q0YWYyYjEuLmFjODA2NTNjZGJlMjgg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMKPiAr
KysgYi9kcml2ZXJzL25ldC9waHkvcmVhbHRlay9yZWFsdGVrX21haW4uYwo+IEBAIC03NCwxMSAr
NzQsMTkgQEAKPiDCoAo+IMKgI2RlZmluZSBSVEw4MjExRl9QSFlDUjLCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgxOQo+IMKg
I2RlZmluZSBSVEw4MjExRl9DTEtPVVRfRU7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBCSVQoMCkKPiArI2RlZmluZSBSVEw4MjExRl9TWVNDTEtfU1NDX0VOwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEJJVCgzKQo+IMKgI2RlZmluZSBSVEw4MjExRl9Q
SFlDUjJfUEhZX0VFRV9FTkFCTEXCoMKgwqDCoMKgwqDCoMKgwqBCSVQoNSkKPiArI2RlZmluZSBS
VEw4MjExRl9DTEtPVVRfU1NDX0VOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEJJ
VCg3KQo+IMKgCj4gwqAjZGVmaW5lIFJUTDgyMTFGX0lOU1JfUEFHRcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4YTQzCj4gwqAjZGVmaW5lIFJUTDgyMTFGX0lOU1LC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgxZAo+
IMKgCj4gKy8qIFJUTDgyMTFGIFNTQyBzZXR0aW5ncyAqLwo+ICsjZGVmaW5lIFJUTDgyMTFGX1NT
Q19QQUdFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweGM0NAo+
ICsjZGVmaW5lIFJUTDgyMTFGX1NTQ19SWEPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgMHgxMwo+ICsjZGVmaW5lIFJUTDgyMTFGX1NTQ19TWVNDTEvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgxNwo+ICsjZGVmaW5lIFJUTDgyMTFG
X1NTQ19DTEtPVVTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgxOQo+
ICsKPiDCoC8qIFJUTDgyMTFGIExFRCBjb25maWd1cmF0aW9uICovCj4gwqAjZGVmaW5lIFJUTDgy
MTFGX0xFRENSX1BBR0XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHhk
MDQKPiDCoCNkZWZpbmUgUlRMODIxMUZfTEVEQ1LCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4MTAKPiBAQCAtMjAzLDYgKzIxMSw5IEBAIE1PRFVMRV9M
SUNFTlNFKCJHUEwiKTsKPiDCoHN0cnVjdCBydGw4MjF4X3ByaXYgewo+IMKgwqDCoMKgwqDCoMKg
wqBib29sIGVuYWJsZV9hbGRwczsKPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCBkaXNhYmxlX2Nsa19v
dXQ7Cj4gK8KgwqDCoMKgwqDCoMKgYm9vbCBlbmFibGVfY2xrb3V0X3NzYzsKPiArwqDCoMKgwqDC
oMKgwqBib29sIGVuYWJsZV9yeGNfc3NjOwo+ICvCoMKgwqDCoMKgwqDCoGJvb2wgZW5hYmxlX3N5
c2Nsa19zc2M7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBjbGsgKmNsazsKPiDCoMKgwqDCoMKg
wqDCoMKgLyogcnRsODIxMWYgKi8KPiDCoMKgwqDCoMKgwqDCoMKgdTE2IGluZXI7Cj4gQEAgLTI2
Niw2ICsyNzcsMTIgQEAgc3RhdGljIGludCBydGw4MjF4X3Byb2JlKHN0cnVjdCBwaHlfZGV2aWNl
Cj4gKnBoeWRldikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJyZWFsdGVrLGFsZHBzLQo+IGVuYWJsZSIpOwo+IMKgwqDCoMKgwqDCoMKgwqBwcml2LT5kaXNh
YmxlX2Nsa19vdXQgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LT5vZl9ub2RlLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiAicmVhbHRlayxj
bGtvdXQtZGlzYWJsZSIpOwo+ICvCoMKgwqDCoMKgwqDCoHByaXYtPmVuYWJsZV9jbGtvdXRfc3Nj
ID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKGRldi0+b2Zfbm9kZSwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAicmVhbHRlayxjbGtvCj4gdXQt
c3NjLWVuYWJsZSIpOwo+ICvCoMKgwqDCoMKgwqDCoHByaXYtPmVuYWJsZV9yeGNfc3NjID0gb2Zf
cHJvcGVydHlfcmVhZF9ib29sKGRldi0+b2Zfbm9kZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJyZWFsdGVrLHJ4Yy0KPiBzc2MtZW5hYmxlIik7Cj4g
K8KgwqDCoMKgwqDCoMKgcHJpdi0+ZW5hYmxlX3N5c2Nsa19zc2MgPSBvZl9wcm9wZXJ0eV9yZWFk
X2Jvb2woZGV2LT5vZl9ub2RlLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCJyZWFsdGVrLHN5c2MKPiBsay1zc2MtZW5hYmxlIik7Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgcGh5ZGV2LT5wcml2ID0gcHJpdjsKPiDCoAo+IEBAIC03MDAsNiAr
NzE3LDEwMSBAQCBzdGF0aWMgaW50IHJ0bDgyMTFmX2NvbmZpZ19waHlfZWVlKHN0cnVjdAo+IHBo
eV9kZXZpY2UgKnBoeWRldikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgUlRMODIxMUZfUEhZQ1IyX1BIWV9FRUVfRU5BQkxF
LCAwKTsKPiDCoH0KPiDCoAo+ICtzdGF0aWMgaW50IHJ0bDgyMTFmX2NvbmZpZ19jbGtvdXRfc3Nj
KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
cnRsODIxeF9wcml2ICpwcml2ID0gcGh5ZGV2LT5wcml2Owo+ICvCoMKgwqDCoMKgwqDCoHN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwaHlkZXYtPm1kaW8uZGV2Owo+ICvCoMKgwqDCoMKgwqDCoGludCBy
ZXQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8qIFRoZSB2YWx1ZSBpcyBwcmVzZXJ2ZWQgaWYgdGhl
IGRldmljZSB0cmVlIHByb3BlcnR5IGlzCj4gYWJzZW50ICovCj4gK8KgwqDCoMKgwqDCoMKgaWYg
KCFwcml2LT5lbmFibGVfY2xrb3V0X3NzYykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8qIFJUTDgyMTFGVkQgaGFzIG5vIFBI
WUNSMiByZWdpc3RlciAqLwo+ICvCoMKgwqDCoMKgwqDCoGlmIChwaHlkZXYtPmRydi0+cGh5X2lk
ID09IFJUTF84MjExRlZEX1BIWUlEKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gMDsKCkkgcmVjb21tZW5kIHJld29yZGluZyB0aGlzIGNvbW1lbnQsIG90aGVyd2lzZSBh
bnkgbWFuaXB1bGF0aW9uIG9mClBIWUNSMiBvbiBSVEw4MjExRlZEIHdpbGwgYmUgY29uc2lkZXJl
ZCBhbiBlcnJvci4gRm9yIGV4YW1wbGUsIFBIWS1tb2RlCkVFRSBvbiB0aGlzIFBIWSBpcyBzdGls
bCBzZXQgdmlhIFBIWUNSMi4KCklNSE8gdGhlIHRlY2huaWNhbGx5IGNvcnJlY3QgY29tbWVudCBz
aG91bGQgc3RhdGUgdGhhdCB0aGUKY29uZmlndXJhdGlvbiBvZiBDTEtPVVQgU1NDIGlzIG5vdCBj
dXJyZW50bHkgc3VwcG9ydGVkIGJ5IHRoaXMgZHJpdmVyLgoK

