Return-Path: <netdev+bounces-175877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 373B5A67D92
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D535E18922F4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60B2210F5A;
	Tue, 18 Mar 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bwOMk4Bt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F90EACD
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327955; cv=fail; b=Dw4GB+QJJea4n4KkbKQGChzYe94eNniE7VCK7h3Z8er59AWKXLlEUNmzIpF3I44vdgb5qh0z6iB2DNB0nU8xtx8owkGuC0Mhqpxtxir+UIdKh2MrSEvHsZ9GA2YQFdh3XES1IuvGtfgCOEV5d0JuSzfEWpzz/deL598KNSdYYNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327955; c=relaxed/simple;
	bh=iRHq7vlQ81nQ2Dy7KQgr1TOpuhgFAsWnRvse4zWH+KQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U7x1rcU9PxX/tckM6HwIvYcgmTJSCpbZUIk2tVveUBhPE5Ubi1gQLhIKoEup7KNih4FgFS0VIX02TAc8Cf1P0ncbIb79qTKCa4tpsIJELpnW61G80eRbpNDY0z8NeYIQtKN6isOObdqD9MFs1zVcchJVIJFKIiT0mgsCCGUhOR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bwOMk4Bt; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCQhYESgumE4suYnjktWAKwGajYgfvtSMN2diNKFBXYscSpLxovYezGh3bp9kanXRtp3EpWXEteGQe06K8cOKLEMoSBm5O3ALdJjZ+Uz/buXT+lg3JaSntoPvy9yXBNC2mdO27Rb6ES74tLAb6+vdCyceAsuYj/Roq+wxWelP0yMNoC/D+I0ZFQFMyttPI6pJYtDgXyclb07Gl60UAlJmnJ9ovx9Zsmb90qGHA3HiTbwnzlC8Zrq4/htpWugWtcSQ4MEgdCy96jDZsoBiSRpgL92UvpZzNZ2iSEEtjY53FtApymMqOT0bWCd9XFNUMCbDVsZVwmNSSwZs7b6OaRlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybpxq/2teElS+vX2GnWhc+nqwhoeprMhxSUW31Mgr6E=;
 b=SAEvkX7DnvMIyGIVWrX1c4Ns5+nHgIf9dWzpmKKRS+rTq+jM5N4mjAF4yYB83+DKS+nlcZXtx1kPt3Kb9t8iMnFWmhPg/50i4NADA1h1u0hOla5zlFxHsCzMx80sQuz1HSXoapnEzXnebq9//Zsc5esd0QsBvEDrzeL0ACgWm6o86vqS51Z5qYwAsm7ex51VDmODUu4snGtAVgt5dWduAgdVq73czCjm70rbKkj5aLsT02VJm4FGgKEFJbL79RyMUuXSfgKvL1X7qKqKIdLBLJArxqXcMj+mA/c1E0b33VkzgFWjoNU3Ko0Djxv6KwbDHyNjdS5qXIzUo2E8IjJ0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybpxq/2teElS+vX2GnWhc+nqwhoeprMhxSUW31Mgr6E=;
 b=bwOMk4BtssiUchFvNvfgHVNmc7puNByQxezvLVuwyPHgJ4fhUX8L48Bucwoot0v785vgNiLM6ipVil/PxoN0n0LOIusU34vVekmCAYaJE1FOjQ2hXAjoq+LnBfIMJyOQTBgzSL5grB+LdTK+WJp5C49boiySdWgXtnvjwZ2epZV24Y5Q0Tp4/u4cDDLLwmteoX64kqaE8MtzyDHVjdQeFWj5TPQxfwbZACXwXqMwnWk7K9oMEQUBrmBhkeM5lUUSF5V8jEdoJ7REUFt6u/ZQDOFPoY8b+TnIJaHrE0bcMcreUNC/N2jlfXR+tSbdQF3iVoesCYhkx1T+MSzxqwm6yg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 19:59:07 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 19:59:07 +0000
From: <Tristram.Ha@microchip.com>
To: <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<hkallweit1@gmail.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>, <olteanv@gmail.com>,
	<Woojung.Huh@microchip.com>
Subject: RE: [PATCH RFC net-next 0/4] net: xpcs: cleanups and partial support
 for KSZ9477
Thread-Topic: [PATCH RFC net-next 0/4] net: xpcs: cleanups and partial support
 for KSZ9477
Thread-Index: AQHbd9G7VcLFvSdnAUmXjlhnL1yQjrM9UseAgDw9RUA=
Date: Tue, 18 Mar 2025 19:59:07 +0000
Message-ID:
 <DM3PR11MB8736D45A311DA7C448825BABECDE2@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <Z6dHo0DFWUiMMUyN@shell.armlinux.org.uk>
In-Reply-To: <Z6dHo0DFWUiMMUyN@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SJ2PR11MB8471:EE_
x-ms-office365-filtering-correlation-id: 0a6be0da-81e0-4d3f-5dde-08dd665757b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4yrpQhYkPKir8ax3pi3U3uCI5RaYe8aUlUq7ti1HttguO10prNId4b5WwaW9?=
 =?us-ascii?Q?/dMdbaKQIe4gyfVPjiTb9XK2daZ+WDhRViOHhOmHnDXeyMthxRl3x3cfxzCQ?=
 =?us-ascii?Q?kNLpPgWW+jw4fTiJcv9ye9LdGTMYmZJk6iaEs7X1gL8/waVROV/IqnqGXEUu?=
 =?us-ascii?Q?LfdCn8jUhvngnGRS8+eASriTa2BC1figZqvr9nuEUfzsf4p1ncvbxUAMDz0s?=
 =?us-ascii?Q?au5K9pkBQdWGwjhRxenzs4I7qN9PCRE10XIXOYOktsTehnOtyHlQevKT2HVE?=
 =?us-ascii?Q?f00ndTdHEB3W8M6YRkGnYAA/kl/RwTe3xl3b4hQ9fnoWR893yQ2sBlt3ppyN?=
 =?us-ascii?Q?6xP5IMi7BrBUO0EaZDMN39WqhF59hmZo99TAx4eXXGV38Lcq1bkKkiVyL/jF?=
 =?us-ascii?Q?yHw7t9An1jirWI7kaXeMV53jaVI3NmeW0LsJBqOqfUb7lHqOfqJX0E4S3hrF?=
 =?us-ascii?Q?RVtRn3TFF5n7kJH9xZ7bOjkLx61bJXY7uGq2wPQbWFXwfMZTagNFup7CrutE?=
 =?us-ascii?Q?qvEpyhGq3xeNAIauwgcUVKlQJsMi8KDjBKNFsw+oNGmqi2cLAsHzJt++nr7E?=
 =?us-ascii?Q?qSMIdQ31FekmpDRtH3oMw9AqYLoOplYHKzef5ruFTfsliPpMbvP1pGbaaB25?=
 =?us-ascii?Q?1daDIYqSQN3gwUFfKDqCZTNdKM17o9yiCNm3HVm+e63BKISra6R/Lwq6A0wl?=
 =?us-ascii?Q?WrBjEHc1PORUxmlfy1eHYTfa2EYcmLXxc3W3nDPBTJKNg9QE+FJ1T7JMchr3?=
 =?us-ascii?Q?n8DitxpJX/8icOYtyK6cFvbWWcgFb6br6gP0rQj4n31ceURnuUWIfXASW/w8?=
 =?us-ascii?Q?YGrSpqoau3y5iJGMC/PjMxL1JLaqsuLf/TltzfH3n7vFElPR/ynQrmnpcRQI?=
 =?us-ascii?Q?X4wqzpLPi8pcRcY2DI2Y8N5gU7wTDffBGAGCgfO5klKZwBks6zRqHCFderKk?=
 =?us-ascii?Q?liN/W8+cIOpyNKZNDnytItRx+xSoNLRELiXJ9nL6BL5p+dtkKBzELGVz5FQy?=
 =?us-ascii?Q?cl3d662A/niBLsjQLvkp3dLnqCX5hJz3/tUNW0SxAos20Oe46M9jAmsp5mXu?=
 =?us-ascii?Q?wbAj+ejmmAwpBK55bbIC1O8zK2Vm5udg74roIAn1Z03cvvQdoukx2V3OpUef?=
 =?us-ascii?Q?1pl64p6b7QNZfe5Hs3aCX9KEqRwvrhEKUBJncMr4rVMaFjdhpvpXmPKksCOu?=
 =?us-ascii?Q?pirrRI8gr22PNNjA82iaA0OgcJBlB9uKb9irl0lVEsJAuZOvdMTSZdMP3fpE?=
 =?us-ascii?Q?YeFU32U7dUZdjT+BKw0wpjGuCkM5p+xDiSlbSBvE/bhpvY0tfmxob6gBZvog?=
 =?us-ascii?Q?29kQeuOOYNLYAv9a1SQsAji6eX1oSFSNO8GWbhcUsBovxSlqOYxZhXbMpT3z?=
 =?us-ascii?Q?RbirPdKYWabLsvCHpI501gNqMMBr5MalkRohKuAGZLRQemjDKHFvRGi5NIcx?=
 =?us-ascii?Q?ih+4ra9Yh9crG7axC8PSXVOm7BJrZkLy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fZIrjpNb2m8NdFpz6whTR8nzJzbncIrJe7ny/zQbuwNr43VfhibzI+Smfn2y?=
 =?us-ascii?Q?75SaTcG9BT2+wXor68QXPzBkcTiYA24h8KHK8Q7WPLqGjix6BDCkOyBsYBZ9?=
 =?us-ascii?Q?1Whncc8ndP8gkMzMYr7Mlcy5yKi2bPnFbYQiND+bQOQ7ZSMZosH0mOzz4ZC8?=
 =?us-ascii?Q?nc/I2gnbbD222updkfMXVaKfuMBhg8dkDzXnLPxO7S9CR//2tRgR04kv6vPa?=
 =?us-ascii?Q?99n/YraPng8DKRg5J/2APfRYB59Av7RiGJd9T2r33c3Qo4kR+2h2tAt1BRMX?=
 =?us-ascii?Q?4/QpfdCUY7l2EH/7rKDp8XHgaH6HqFRJr2InF7EH4J7spYAGthcyZk2DTRW6?=
 =?us-ascii?Q?T8avWGA9oarl48IV1Q4gv0Y5b18MQKdLMXmTQAvXHYmd2wItHHjMHw26WsBS?=
 =?us-ascii?Q?n7pDtFIF1qKJVuHGlMwKHPGDrm6VfOwssdnIR/N+ZGBLTRIVuJBtrMIKxMX8?=
 =?us-ascii?Q?r4PrPVrGk11Uk1oJFaiqNJ9Mfe9i7o75U5MoXzinyuAcCGzXvwLeVfzQoWAl?=
 =?us-ascii?Q?RYhJjAbqwBSOUOfjTfCWxyWzWG2w/Gvbzs6LIdwyn6vSVh0XkJXTl7xkMj4R?=
 =?us-ascii?Q?tJdkEMSQeSBngiT4R6esLtMZh6o0z8DSYWLX0jOc0rbzjL7SXmxnQbB+gB8Y?=
 =?us-ascii?Q?cMAB1TDhZKCWNU0DIxtXiZ84wOLsTubtKciuSvvr27RkIS4bbaM73k2RBjzM?=
 =?us-ascii?Q?520uTnOVszID3dWxA54SJO2ndCfa0/NyPLqluk343LN6Y+zFchkHi5GnvQbT?=
 =?us-ascii?Q?D1qyEiuSA+aVNTuiJKyEhsHAjf8ZSROt1YfYnGeH+c5a3ecqLEcBssIMAypZ?=
 =?us-ascii?Q?BMTMlTvMvXJovoAG7wD6iF/G+aPZv9KO0U9+9JPaiSflvtcjLq+DrcK8TUTh?=
 =?us-ascii?Q?KAi3LuVpqj6Gq3HVmjeqVAfsCWg0O50Q/K1JaxomNJhrOPwq1H8uzrLjtIJh?=
 =?us-ascii?Q?qSHq/ADpK3lbDRK2XpxqSCQ0uTnMhDQszXgK0AuLeiZ1t1FxwVifv2oxaf8V?=
 =?us-ascii?Q?+G7rAmPQM1NnguyDFH2/cKr87RZ9eG29JciBeDdCqomTBNtGTWt0fPNQZkgR?=
 =?us-ascii?Q?Kvj0g59em+nQPF1CD1ySqB3MO5FJ4UKM+ciSkQwfbmOagqWSiH7W4eddbJ6y?=
 =?us-ascii?Q?LhnTGFTUzYO69W+BdIcPc5Mc2Am1TGJctlGNMTKQfylIH1oKjCYukM3Z0ySf?=
 =?us-ascii?Q?XPjxbP0YdgnS55dwY7oYXMJ6d0JihUdGPXgm0Fj8upLjYXjytC1wPlQKP61G?=
 =?us-ascii?Q?9Vfi5SPSXL7Cc1aVvZcjYzYCxxA8GB2PLpdgortMlOEaGizcv42KYG6WdqUy?=
 =?us-ascii?Q?ebFbak25j5pjYbVqBuQuB9oRySIWwoQT9mI0DivQbmdF059qJi9hOhxY9/Ee?=
 =?us-ascii?Q?Is/ygeUNW08lRWH9LLUIhoV2sF0uARAquHE0NN9xzvK2mQNsr8JjA18lr7bf?=
 =?us-ascii?Q?ajffMW7dRtthxJYtpTouOn2WlVzxaeQWLFIgcpbcg+nFWuzYMmFev605XjKe?=
 =?us-ascii?Q?2nv5naC1YDM76D4/jcbc3a5IlFDSxbrBR7pDS5lodvSTNNAzbx9U60xQXqbI?=
 =?us-ascii?Q?Zj2U1ZH0vNa7POc6J1hCjapR0NPdGDobcTAgAfwa?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6be0da-81e0-4d3f-5dde-08dd665757b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 19:59:07.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPBywYtV3kFYeI65VcmomoFE9iqWpsYLO4fdqSNDoN3UDjSb5POUzSsJXzNXK4haG1wlXPcGFE+ULiJ8W24S0464ZTQQ30hQFGcj+eaDz7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471

> Subject: Re: [PATCH RFC net-next 0/4] net: xpcs: cleanups and partial sup=
port for
> KSZ9477
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
>=20
> On Wed, Feb 05, 2025 at 01:27:26PM +0000, Russell King (Oracle) wrote:
> > Work for Microchip to do before this series can be merged:
> >
> > 1. work out how to identify their XPCS integration from other
> >    integrations, so allowing MAC_MANUAL SGMII mode to be selected.
>=20
> This is now complete.
>=20
> > 2. verify where the requirement for setting the two bits for 1000BASE-X
> >    has come from (from what Jose has said, we don't believe it's from
> >    Synopsys.)
>=20
> I believe this is still outstanding - and is a question that Vladimir
> asked of you quite a while ago. What is the status of this?
>=20
> Until this is answered, we can't move forward with these patches
> unless Vladimir is now happy to accept them given Jose's response.
> Vladimir seemed to be quite adamant that this needed to be answered.

Sorry for the long delay.  After discussing with the Microchip design
team we come up with this explanation for setting the
DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII (bit 3) of DW_VR_MII_AN_CTRL (0x8001)
register in 1000Base-X mode to make it work with AN on.

KSZ9477 has the older version of 1000Base-X Synopsys IP which works in
1000Base-X mode without AN.  When AN is on the port does not pass traffic
because it does not detect a link.  Setting
DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII allows the link to be turned on by
either setting DW_VR_MII_SGMII_LINK_STS (bit 4) or
DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL (bit 0) in DW_VR_MII_DIG_CTRL1 (0x8000)
register.  After that the port can pass traffic.

This is still a specific KSZ9477 problem so it may be safer to put this
code under "if (xpcs->info.pma =3D=3D MICROCHIP_KSZ9477_PMD_ID)" check.


