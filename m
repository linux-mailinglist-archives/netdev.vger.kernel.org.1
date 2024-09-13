Return-Path: <netdev+bounces-128125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6947978274
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E25B20BE1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B88F6A;
	Fri, 13 Sep 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2IP6uEeH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37FB66C;
	Fri, 13 Sep 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237389; cv=fail; b=tP5tHkAum8FVwIBiLOCp+43WyjxEGEv9ZXG0aFsAmIOogYOtwjZk4r8tEgp0OZpCxEZ/me65eGX4v0tQ+RZPc54SbJTMEwGn+42L3vOCT8WKPezeRFAZ2inQBnzlKC37DlGWyiumv5NzyZdRO9ZAOCldV753C8Z+N7p0tczz+JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237389; c=relaxed/simple;
	bh=LHbK0/9Y6cD2Or0ploFIUiaWR8shENGBJdJm3IyScjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iWlLOKRgh2T3auoRzAbEzJlWH/6RxNdDkHOgnP5DcwRD+z6n9dgLH3zz6TwcHXY6Scr48AqmW4lJKZgd1cb0tD0S4Hbhwo7lCZTxRN55qfOVWTfBSlYluDUV0PCOpld8XAPb7lMhgJbXKeFo+MdBEJ/Uog7doeFZ0Ba57S8EPoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2IP6uEeH; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqlr+L8qa/9PI555Zl6QkhncLWnxLmPzEWjun18floOkb2kW+yB2rzXHWYNSq51ISPT4jMYfz432GQXAIhl9r15BqMLIrXShllmFJlSIMPWROEphZ0U04LGy6V9Na0TFwBDQAqGlDJB7rQlV6ce7mZ/R1a9NeFJx3pcI5nDN/KNVW/bbyLWiL517gax97xnJCSsRfNjWoQEQPMqU3BrBA2HKEzocC1z5vbhUj3WTsZ0w2BGAEPp57UvcENO1xSSrOyi0QpeqxqyRa9WNAAhLl9npcOaQc9l/vt4KwChERsGsSrfIlbH9eK9EgAusKeMDLWli1qBUXH966Lzrm/AWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4DRQ3E9HAUvRMRR505HzH7tFSfH3TFI1RAtrWMSUzA=;
 b=jmS5j/V1In+DTTWyoATSAeCfWhV+fKvG/QUIBFql+aUTRVBOGyAJ6LnanNn3HYNpRq1Rrbdnz4hkptxRYvw4TvevnBMPMGvTXw0YW555j/9lSh0FeuAaoJtvar0e5b8OrVGDUxDjqbCWWfBufSN6k/VB7mmnA7lCMHfyq2bxz0DWc5jtJtDNjdI1t9mkJ+yzr8WhoLAJ2n8/fDjQTfPawRryvLgFQ/O1bYFsALv675ocy1fyfySsASv971pARphqz0bU90uxuAKAkR1Np9gM0tm5rvmEl5FEF4KuahXXlLY61MRAtwPNk5MxViagv2+QV/iV+Fcw8rmrqhmDJ4BHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4DRQ3E9HAUvRMRR505HzH7tFSfH3TFI1RAtrWMSUzA=;
 b=2IP6uEeHUaEQA0/D+ZKb+EPDF51fCtv7ATCdztyBAxbyBWyoF7XqLJBp+yRUQ+k3LHXdmL8k+tZXtLXLQUkZ/GiU4YPxwujlxMq+OUqEYeY+K5i0/axdv1ZL5u459PppUvcQr9Eio4uZSr5OuBVBb51XrNIF0Ee0NM/pYuDGX0gWqhBWlaXKfQYzCx0PZ99rDlbx9vweT1rHo/oUwG0gPtCkx7zr+MbNLbeS5PJteQ1kqznnVfcFqdkFmCkvtJn4popXEaA9bBZ72g8GdqzOqnmEA4UluaNBEBLOiGfNCCn/dptHhjZtTJ2IMMf5fAtpogLwGMkcmggoIaqNnoR55g==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by SA2PR11MB4875.namprd11.prod.outlook.com (2603:10b6:806:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 14:23:03 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.7918.024; Fri, 13 Sep 2024
 14:23:03 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <Daniel.Machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Thread-Topic: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Thread-Index:
 AQHbBGX8VAfW8KWmWUiadZFQXqJr/rJS1qaAgADhgICAAI/DAIAAAwnwgAEhXoCAAEoQgIAABGug
Disposition-Notification-To: <Ronnie.Kunin@microchip.com>
Date: Fri, 13 Sep 2024 14:23:03 +0000
Message-ID:
 <PH8PR11MB7965B1A0ABAF1AAD42C57F1A95652@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ZuP9y+5YntuUJNTe@HYD-DK-UNGSW21.microchip.com>
 <4559162d-5502-4fc3-9e46-65393e28e082@lunn.ch>
In-Reply-To: <4559162d-5502-4fc3-9e46-65393e28e082@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|SA2PR11MB4875:EE_
x-ms-office365-filtering-correlation-id: 5d0e4c25-cd6c-417a-0747-08dcd3ff93ff
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0U8n2V1hSOkDpVbzNyHhUDZplys83LFpUj8ONNsd2SqgQLgJKg0gCbF9Qgug?=
 =?us-ascii?Q?zIkC2HFYuG5mGZFxYGVYFwf90B1V7gYWCxid9xQ5JpskaZKwJZCwifqcfQEd?=
 =?us-ascii?Q?2ExdRP8BvVdek5l/8ZS2Mz2ND05AHS825p7WM5TeLG7ALKwfjDqRqkOW7WRz?=
 =?us-ascii?Q?2ZIWmdEVABm62MV01TZGUpiitpvV9UZphQ9/s0ZP5rXW4sWD+dcAt1ypjkzs?=
 =?us-ascii?Q?FAX4mo74WQxswvXPbxtzYNe8zAqEnP1BwXj6JQjKk+EW4JedGCoxucAFTEf6?=
 =?us-ascii?Q?S5uNu9eoxasbBdMed1iokGje81MRphmBVRiXFjOvIVIwr41xV2KD7IpsR791?=
 =?us-ascii?Q?wncBUg0z3gsFUJHPII4Xa3+lgqSPuSbT0X5s1vtWwnFd7Z9trN/azZKxjg0E?=
 =?us-ascii?Q?v0T5MuH0gHJ/tT8cuLfijY/y+o6Y51x9cuLJ92OEJnx9U6e61YR23FOiC9wH?=
 =?us-ascii?Q?3LvMGNChMtI/sZkZVkouQumjRP364rO1F5OHPnEGIHmg0vwUv2gxpjuwPC6C?=
 =?us-ascii?Q?Wdcev5XxccoACgKc5tHcZYsTSJo8zysIva9QBm/1zBZmj4KDCIINVEWB4RB4?=
 =?us-ascii?Q?FcLja8vGcLLKIL+LdwN9e0dXXAKWqCox9bvPeKuA3T14wBVrdPJv7q+1BPha?=
 =?us-ascii?Q?aMtse2ZQg5NBZCtk4KHZNp6IStGvrWFlSFqav4mme6Ha1bQo8DDizKWDWODW?=
 =?us-ascii?Q?4g28M/Og/z1vsAk4E4Sj+OOzcssalslmyd2Lc+yInT3hsVvg5cYlAaZYBrRw?=
 =?us-ascii?Q?7GXwvUEdOJ/+efskgGr2Wa2NDvoQ85nE1Xh+z+MtXlV0fvSkSHVL3xPnplgy?=
 =?us-ascii?Q?yNg1ldAbFi4R2QKAckrHuOICdz4bzM3FT2fjq8ADwCJVLXhij81TvgDMlCzj?=
 =?us-ascii?Q?IAXNfpp9K1EuMxZ7l/g85AkeVABHHkrE63WHLS1fG6uTLmWuYBKnWwTOr1UR?=
 =?us-ascii?Q?81HgLrQGfSRgNdPXS+g+23B7PmpS59fTx8gHdsSN0E7oqjsj5BymLp+7B70q?=
 =?us-ascii?Q?O27jDDzC46KOmRqUEC4PbrdplPreu8TDGuAuR1OTbvhXnqa6V0J/1dPy2PYO?=
 =?us-ascii?Q?wSrq+gyFdJ+La9diZ8f/eJK5LMkXd0eLD3XjdDbmC7k+YViXI8Xq8tTQdlpk?=
 =?us-ascii?Q?apqrpeYRyoxIT2LDcTvTy1/mzQHbPrGEUDTMswu2W5NMgV5mV0+h32+uNe3U?=
 =?us-ascii?Q?IpaBVa0XGhfshGYRp0f1r/jXhSIOgxhNoICEdXdWOcnscfDr9t5Gem6o1hL0?=
 =?us-ascii?Q?z5WBd0sVd5RqNi+V48UIU/oV64xwosFcyvJb2aLgh1GIKKz9k//XRY+8Gsrs?=
 =?us-ascii?Q?+ihdlGrELihNksb+ymfDiJwiOXaoZK/v9Pcw4XFC4rzaKsFlmi560QOhV8XC?=
 =?us-ascii?Q?Mm0j9oUx8JWV2999WKrvaXBDZxYCIfbAa9m+LJAEbO83EQpPwQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9BnAl4nyTb+Jw1VBItnoBOexc3zgysTMK5aqFUeLyQzer+okSzKaohkBH3mw?=
 =?us-ascii?Q?jB7Gm/AmvLxXXVr4KPmlFQs/Vz0+lsuOY/SI4qkZo/lwfd1heamh5QwuaHE0?=
 =?us-ascii?Q?Dyopf3ve0lf7Jl6/gu2HF7arUiu3lTS1dAvvP41nnWhwUR6mO2YmGHTpmceD?=
 =?us-ascii?Q?rfiVLggYZyIlVf7zK2m6ABPPciF+nvljZAnJMeEVICuRb+AxKOUPKmAqJ1AB?=
 =?us-ascii?Q?tsDq9u9hf6htqiN5IWQowBswbds0KgrHF6115RAuv+Ncgn7o//VNX3mN8elb?=
 =?us-ascii?Q?UyyWtBEZfiMVueQE21ORvFeB6boZsfrVs4Gc8qTN0U5k30O+kBM/POyB4cbi?=
 =?us-ascii?Q?AYo51jzMSDb7QcoG/dmSHt+b5gl6pL3VvB6fM83AEiy8jeQQ32nNP7IffR1L?=
 =?us-ascii?Q?8tZifK2zeNts5COpULWp2huXHtECnbxIq7a/Ql2e/z1hhNGNy3oVvDIsH5wi?=
 =?us-ascii?Q?hcvh6A9ei3/f1QHbpHiVfaK+E9Wb1ed4Q4Lc/gwat9UrU6tb8qHzPkw/C3ZL?=
 =?us-ascii?Q?CyZf8/FStLG6ZykfWhy43qaQ1KupmbMGScNNbu1codRZCcFEfxO4aXoTG4ds?=
 =?us-ascii?Q?pFyob198pBJPhCc6npES2dwB430r6won1T5M4l9DKj+dAEiMnDW3KXJXDfOp?=
 =?us-ascii?Q?EGd5jGqLrf2xxciF+Qd5gjSIuopQPajmFZ25B7/K5CK/ug2bMk4yWS+WMcKp?=
 =?us-ascii?Q?YQIzY7sS6sewnAli0jUPPbCQ2MR6/OvgVlcX+9dX3foCM7Zkij7quGvtr3Lp?=
 =?us-ascii?Q?daN79akdmfzG3OMpdZnnALyojcWiFNKZTY8RcUiBtiMKa4GL8fd7DiuCSjWP?=
 =?us-ascii?Q?n7+5gDlOf0G7zgYI/nF0Eh8+lioWXxd6EZ8VHjOvxOvgHJsZ25SQquNc+f/h?=
 =?us-ascii?Q?UU+V4JxsyH3Cl1F2xjNrynRtAH3QTSEOz2itkVdzKzoCx9tJfhprwcaItXar?=
 =?us-ascii?Q?QWmnjS0TyvBJN3dJPqaMuIrI7a0vVFw5DfM0jUWfSA7Ve2OaMn33GC7sNIUg?=
 =?us-ascii?Q?LTF4DArBU/HJ5uID5iqRRZ+WYtCIXNfKmoI3ZOyp3JJZW+kQ9wVZrJTYhteO?=
 =?us-ascii?Q?mJjZXASr9N8+/pSCHP1iodA0yFc52KUlu/iO2t8GXp9gg/kA21ZPFIxB6Hpy?=
 =?us-ascii?Q?02mP1ggNLEQu4lyq1Sm/ysmmxiSPPxUXMGb4IMBMREbvemAR6s4LG5zsIuhH?=
 =?us-ascii?Q?KX5JTVqiodO4GtIBF4/poUvpgtmQ9ZtTWp5ePpeHTOjRaqBZWw3neD4ciFEz?=
 =?us-ascii?Q?eBwOc26KpWDldbsAElZXJOB5f/KztOhumaaVEtMAg888VhWBGK0kbkl8RyrY?=
 =?us-ascii?Q?3fIPbMh0ECB5FLgAh6MyCkq9Up3REekoHl6481Le9mz4vJEAOJ2bDxIjy17r?=
 =?us-ascii?Q?jPhj1t6JR31PusFDCFtia8Kael+e/g1wxOgGu5DfLu12J6gRPbmYvaf5qF+X?=
 =?us-ascii?Q?2OJgfhr36657EEh6FbDps07Nio9ku+M4htfsOoSmh2hpgokXQmCNBImT0fF8?=
 =?us-ascii?Q?I1yHuiI2rWmGaiTesmAJYHlim3KwIP8vdr3DrZyefcuY3NGTojaPMiPT6nod?=
 =?us-ascii?Q?kciFDBwRxH4DSd2/cRoYnW5m+2beZECZVvevPlQx?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0e4c25-cd6c-417a-0747-08dcd3ff93ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 14:23:03.2835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wry3srzXx7i1Dsxc+7nznC6kU5arPOsQSlPDRbO7pid7qrU4QI6bybXGVXLJOQEngVtYxt9FGW2iY1XFq111V5uuftmNIiaJdwNJbQfMcp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4875

> > It's my mistake. We don't need 2 MDIO buses.
> > If SFP present, XPC's MDIO bus can use, If not sfp, LAN743x MDIO bus
> > can use.
>=20
> I still think this is wrong. Don't focus on 'sfp present'.
>=20
> Other MAC drivers don't even know there is an SFP cage connected vs a PHY=
. They just tell phylink the list
> of link modes they support, and phylink tells it which one to use when th=
e media has link.
>=20
> You have a set of hardware building blocks, A MAC, a PCS, an MDIO bus.
> Use the given abstractions in Linux to export them to the core, and then =
let Linux combine them as
> needed.
>=20
> Back to my question about EEPROM vs fuses. I assume it is an EEPROM, ...

How RGMII vs "SGMII-BASEX"  is controlled ?
The hardware default is RGMII. That can be overwritten by OTP (similar func=
tionality to EFuse, inside the PCI11010), which also can be further overwri=
tten by EEPROM (outside the PCI11010). That will setup the initial value th=
e device will have by the time the software first sees it. But it is a live=
 bit in a register, so it can be changed at runtime if it was desired.

> ... and the PCS always exists. So
> always instantiate an MDIO bus and instantiate the PCS. The MDIO bus alwa=
ys exists, so instantiate an
> MDIO bus.

No, you can't do that with this device because:
- There are shared pins in the chip between RGMII and SGMII/BASEX (and befo=
re you comment that it is a shame/bad hw design/etc: this chip has a lot of=
 other functionality besides ethernet which results in physical constraints=
, so tradeoffs had to be done). The selection of which functionality is the=
 active one on the pins is done by that SGMII_EN control we have been talki=
ng about. Most of our customer designs have one type interface only which i=
s hardwired on the PCB design, and the setting in OTP/EEPROM informs our ch=
ip what it is (as I said if you wanted to flip it later either for somethin=
g fairly static coming from elsewhere - i.e. BIOS settings, DT, etc -, or e=
ven runtime fully dynamic you also can, but with the restriction that only =
one of them can be used at a time).
- Furthermore, I need to check with the HW architect, but I suspect that th=
e block that was not selected is shutdown to save power as well.

>=20
> The driver itself should not really need to take any notice of the EEPROM=
 contents. All the EEPROM is
> used for is to indicate what swnodes to create. It is a replacement of DT=
. Look at other drivers, they don't
> parse DT to see if there is an SFP and so instantiate different blocks.
>=20
> As a silicon vendor, you want to export all the capabilities of the devic=
e, and then sit back and watch all
> the weird and wonderful ways you never even imagined it could be used com=
e to life.
>=20
> One such use case: What you can express in the EEPROM is very limited. I =
would not be too surprised if
> somebody comes along and adds DT overlay support. Look at what is going o=
n with MikrotekBus and the
> RPI add on chip RP1. Even microchip itself is using DT overlays with some=
 of its switch chips.
>=20
>         Andrew



