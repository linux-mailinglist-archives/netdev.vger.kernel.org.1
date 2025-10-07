Return-Path: <netdev+bounces-228060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCD2BC04AB
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 08:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE7684E0232
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 06:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471D155389;
	Tue,  7 Oct 2025 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X4Uko+vn"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83D35959;
	Tue,  7 Oct 2025 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816883; cv=fail; b=WI7R8r7yJMKIqRcE5NJxcT01AW9k+aaGCyipVyrpGR9k/7pBl+yJfBbrngGR44VSpdSblre+s9leLXoqOLe4V/6epVn13KTrM+jBmE98xf4rW1Ny7XAi7tIZVvA5hYDU7b6XLkragRY2js2jKHFIUq6Nb8ZR1uyvbAz/Qbtd7go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816883; c=relaxed/simple;
	bh=rtnrLOHPaaNjhOBU9IqsGTzko2kGw8JItfxgmk405/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TA7TrQeZjJsrElR1E1tVzk2UGWx5KK/ji6FCHiz9glBiM8ioWL5NAXj+sJ+la0y3rhoOyLGKBZR5ubVpjvZ/cw2TCqcFT6K0Ts5utgsufOqnhXuCzHqs5Pvp1W4RX52uVDzg+Sgb4UG3cwcMHAIpxbpEbn7WRR+UQGW9IP/agkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X4Uko+vn; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHiMV7e+s6XBxvJ/DAf8iB/VKu/3SI/ltfAyGbt6m72mDH7TdKARx2PCUHaChQ0GcaUtQYAogQhSj2Y6zaAHPp4ptbSJAo+zy6gNKz176MDxIFsEsKvsxj42Gu0rUsPgwBCmCuKbodo0AtpTYGP/XMLvrL+70CpeJgq2XJaRXY6jBUMZZoaQ+yG9JwQ7KOq56AKAxPbZCxglXsSf11Vyt7TMNLru8q20JF0AJkXa/LwCdlmQiua1e5peupklzNyq/6Eab7lNFvMMPNfZkSqNilgCgENPBhIfz/fBo5Ud97cewefgHU7QQ4HdNhPiuAA+JlJCj1WKsxpqiQUkOdwZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rSx1ChL8M8X7F4TvGSEwD6BzchS++sGFd1jDg/l4hw=;
 b=CFRGZXLBtP3kFaFt4+L+UWiJIFXlf6ba5pc7TtBYimkhKeWuyXRuXctCMhnIcACJ+GTr60RLRFkg/QCu7nCopnHYfZQdyAvPnttH85tciwvUiy1S+n0EC7XSAOrMo+Dxh3mY6QFQ+5M3H6Mm+Z2ZDwCtzyeZWszDCp2jmd5kSLocLd1bGfYtlNKTsuaEvZiKBFvIknd4zyF4V6Bx12+3fkrjtJnKuXnEfkhLeeLF5SMS+rc/92bmZAaRmDe5i6oqqNJIZiSYkxNRmOuCRII/q8rMcbHM3fkDVyi5JDJgrsVfzWG/DHz2RZ711SEUtHxDL8X3DIh/HaqHVRhuEgbVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rSx1ChL8M8X7F4TvGSEwD6BzchS++sGFd1jDg/l4hw=;
 b=X4Uko+vn3R9xl1IybQCvTa4U1VKS7GR1gftLVEbK3+XZctYjVoVT0qlBJnyZKfhIPZm5PYdB45D51BM486lqmTSqrdPHmadqrs+VNcJsL0BI35Ch/xRpLTzX4MIBwNbQ2CIbrlruCb7dW2jroERhCoVijVzSjrd98UkNZO/Em8543wBE7X14df51ju4ZkDA/B6QP1W1+OGDw46CmM0gNXDBWyF4aMJXw2gecSwi7zoZtQVIDR9aILRp+dAoilwOl7FSsi3en+YVwxqJGy38WYXphpUsUA3lt3zG+Xamlok0JdsJg2ZZhJusmqiAz4dU1BCY5ABf/XdsKR/6So9QcBA==
Received: from DS7PR11MB6102.namprd11.prod.outlook.com (2603:10b6:8:85::18) by
 CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Tue, 7 Oct 2025 06:01:13 +0000
Received: from DS7PR11MB6102.namprd11.prod.outlook.com
 ([fe80::5cb3:77bf:ac73:f559]) by DS7PR11MB6102.namprd11.prod.outlook.com
 ([fe80::5cb3:77bf:ac73:f559%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 06:01:13 +0000
From: <Divya.Koppera@microchip.com>
To: <andrew@lunn.ch>
CC: <josef@raschen.org>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
Thread-Topic: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
Thread-Index:
 AQHcLl6B38r4+cWxO0ijQ23prCCi/LSkctsAgAGIagCAAAYcAIAEkOaAgAXUmyCABR7wgIAAt8+Q
Date: Tue, 7 Oct 2025 06:01:12 +0000
Message-ID:
 <DS7PR11MB6102A376A0EF8727DFAF0088E2E0A@DS7PR11MB6102.namprd11.prod.outlook.com>
References: <20250925205231.67764-1-josef@raschen.org>
 <3e2ea3a1-6c5e-4427-9b23-2c07da09088d@lunn.ch>
 <6ac94be0-5017-49cd-baa3-cea959fa1e0d@raschen.org>
 <0737ef75-b9ac-4979-8040-a3f1a83e974e@lunn.ch>
 <fbe66b6d-2517-4a6b-8bd2-ec6d94b8dc8e@raschen.org>
 <DS7PR11MB6102D0B2985344C770AEC293E2E4A@DS7PR11MB6102.namprd11.prod.outlook.com>
 <5f74c41e-15cd-40f3-8fb2-fa636f169d70@lunn.ch>
In-Reply-To: <5f74c41e-15cd-40f3-8fb2-fa636f169d70@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6102:EE_|CY5PR11MB6414:EE_
x-ms-office365-filtering-correlation-id: 408b16b2-8d2b-4da3-76d9-08de0566eb84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KXFNzpHBFWVuKQxx43l9wDJo7InoGlMSrOENBdh39raqJPr5UdFwtHUPQoWQ?=
 =?us-ascii?Q?p8EbC5DvWRS6G9Rd435oAD+ohs8KKllJyblYW9gcAwcMD8syyX5VHN1UmnGU?=
 =?us-ascii?Q?ThdzOwLPRQ51C4VecYl1H4yGOCFsKKhZJMC6TrBy5nmIme6T/OIZskOFfhx2?=
 =?us-ascii?Q?SXeMeXVfv9Pc43BDc/1Ugnv+wUekc5bDykeJxspYuDms60gCtfRDNFzcXk2M?=
 =?us-ascii?Q?yGDDKbC7SR09MMtujcmZrJTVKjt0dVV/nWYvglDYl+cDQVQj8rqmDxUFsZ2I?=
 =?us-ascii?Q?tGhdzxQvzfJReWUAaZoRulHkgqe2W3+2PlvEznevSHmZhokHGf1UpwT21KJn?=
 =?us-ascii?Q?VsgaT4BQF8PYdNFDzZLqv5+BlP1dM9ISAUtmR858oWzmpqMVTyTBifM6ay/t?=
 =?us-ascii?Q?HlEAtCCPOg4wg4hvUgqo5KPPDVKO99gJYT4/rvr/AFRUf7+SIp9lbzaLMXEs?=
 =?us-ascii?Q?XrYabszIk4lqVn9ZndVtEEq65KkAdVvZHbU0MoAvEziQ2Jkur+sGhUfEehlj?=
 =?us-ascii?Q?BmLgTs9fXCHxrOuc3jf8VN0lB1oI+eqI+MRekl7KY1ssEoU//yWfpfOFt9ig?=
 =?us-ascii?Q?yVxW4Pofo046/zK4JB7QcjELnczJDM3bC75Nhik3Uq/0w5EWoyKzs5Naf3QM?=
 =?us-ascii?Q?NsTLLJXZRhjyr3xdViuKw67VrJLbFPRj2vofb8sMcPW+XtlQTnczO6CAk48v?=
 =?us-ascii?Q?OeNcSGMjiqgFiVjL6sK8HrHfkSRREzGyyqo7WlOEJoMmh4y4cHr6a5jSQyrO?=
 =?us-ascii?Q?O2Y/r9ewW9rqwv1d2vXAfKfhAHiNxg6dlk9NxcU9CgPSv0104XuVMm600o3E?=
 =?us-ascii?Q?0OQyPoE+57g0KE6Du36xiuav52k3OU8WcgETw6wTsUAJ8QqwTUeVXJ/duupF?=
 =?us-ascii?Q?7PWyzYnlYx9+XQrIKWNxWPHwvV9MxK42m3t/+rOVMZ215NSS2p9xTAdrjyCt?=
 =?us-ascii?Q?MAKsysGF/KLxKN0NrYK6RnQzqMPHgRCZ+2LSd019qpBzXf5eDm3JOSWc8gmR?=
 =?us-ascii?Q?iNIoyCUZ0PBe9PiOPS//q5nd7PdiUdlURjFRpLg68zjkkfq3lcDnO44VeMbj?=
 =?us-ascii?Q?V7RqG47TsKVw1iuNA71/1DLNocdmIJ3mwsquG7IZnQJiRoRGbGRK8D08ZkE6?=
 =?us-ascii?Q?U/w31cuQsAXHjUp+SM/qPHSnazWwbmz/ljZ7q6iCfiq5OhHBAVCGrtcznIiZ?=
 =?us-ascii?Q?00/jqBz7ckSoL4QGI7xyfChGfTtV+m07c6qOW/RZyuFiFFxqBA1x4u+/9AO8?=
 =?us-ascii?Q?sinxv9ofd5JU7h8l4s3u3ChcZzVjmnrOxXCltKwIUJqQPT2MxkRTaACCdhfz?=
 =?us-ascii?Q?SyN6UVBeNMYostgP5sgkO7PPRHZsJHP5qHQCYBhywCYydGSR5TD7f3DFVn61?=
 =?us-ascii?Q?eeGYONzeBmQPXr4RkNrkmjcJCFQDnRTdn6nQbuCJjFU1yWLVGWa5OmoTssNS?=
 =?us-ascii?Q?K1paPG9eiCwVjSaCBZyd/b3PR+bdZiOu+5jMS8oZ4jVg4BcCWEvbQA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jlm/LfTYfGxf37RrszuSpBJgrLo3iV1NEgQUplXUhkDYKa8sY+sZMHq2BytX?=
 =?us-ascii?Q?zHEA/6bD7Qr1xFNTP9P/X23mTogHCofWd3p1HoSKGJdoje+3UZRt+pz5dvl3?=
 =?us-ascii?Q?P6KYZe2wKwqBXuEEBmFPZC89jOVg4dSVAI+1xD0e/1PkzyUGBaLvRaiDZDJr?=
 =?us-ascii?Q?fwMGaDaGo3luFiFAvlh13z5jRMqz8jpd8XQi+04NklMeyyai1GT1woW0mCEH?=
 =?us-ascii?Q?1q0qosvC43WESgc/JbtNIXFvfq1oIq0rVg6CuWUkRqrFOM+k2gRJqgL6Dn7Z?=
 =?us-ascii?Q?s6CCEcQl4VKKW/yHdq2K6EiWGOj44qM7lhqiZwDMoRPTsG2fqs6ou8GZlPJv?=
 =?us-ascii?Q?m0GgwqPH9mDEtQ9Y4cF59TztpBOymiVi+pNRkInYBhV1ZINsOPXML+sdHO5G?=
 =?us-ascii?Q?LH2gaCKvdnBFGNCFEbTLqPxbU1qPu2k23pAg+kMghO32Ml2diR1d1OzNMpvz?=
 =?us-ascii?Q?AL+JnBihDNeOKBD2ZmKHY/0sCMjEwHjJjrgobEdAKbf83o1mWcPkW+b7Yjei?=
 =?us-ascii?Q?gFXhKeNQ7R9EGltdMcK5IkWSiuZlUlfo4EqNmfyYftq+wk7xh8ayMYGNtb3c?=
 =?us-ascii?Q?DwPVq3L6xmZkYm21aHLN+aP4HPC+PQSF31bdm15O1jzmakizjWuj+MgyT0fY?=
 =?us-ascii?Q?wMarEtbHVXyYHIJASV7umV7Xp62g8hk/jJjkXgwwuOHHgif5WL2BIKl4xsJf?=
 =?us-ascii?Q?Miu35JGuhscESNqs8YCQ8F33/qI5A9vD4TzHHMXISzV1Xd98/7pk3uRjd76M?=
 =?us-ascii?Q?0MUeByrOBpvM+H4x6OYEGJUqnkAKETWiCW5/pA+FOUDUD1xL6RVePvNJSeVZ?=
 =?us-ascii?Q?J3EkL0CMadKjAPk2PeYOPsXI4/k/f0K6hUlRYHUAXZOwmjBDcC4AXH7IRYJW?=
 =?us-ascii?Q?WEwpdYsC76vsbYbgiJMaJmv3UmHQjdoT1YEd3YWol1JctiKu4acN8UjVzR8l?=
 =?us-ascii?Q?oUtYchYcmRbLVhdkgzQhgB6/lI3sRToR7L3u9kDX3y/CF0fNiPTKhV+ddXMr?=
 =?us-ascii?Q?xkU95zYxo2h9PASMRkPq5mA/+fIYXi35Sn3AXonZLHNtSWB3+iETZkxo1rkm?=
 =?us-ascii?Q?eg5D6kkh5qJZClAIYO7Rf6J6WO9lfGwu1CXz5Jxa3uvnmEdX8Xh//+Slluav?=
 =?us-ascii?Q?epuOhUbDEVbFHH2mhwNZCEjLeHm8YApsTa21ZSfsqnNNdemmN4gyTDsCFPQC?=
 =?us-ascii?Q?nUcdqs/JXKU6QrmWBbgJMEbB7u4o1tuz36hYW1VaJryURvcgH0pmOpNU87AB?=
 =?us-ascii?Q?ibHdwQFHj+jXwFkBqt8e0hd56AvIQpIbIlb6dfMnM2ZyRToX53EYNT9lInN6?=
 =?us-ascii?Q?CiwBQwh61bsVkQAJQK/Vn4NTV1TDpUUr8ZLZav/Azz+tZfEbUvY2K6KbVFlU?=
 =?us-ascii?Q?ulGvylB3j8Rb1CuJYc0H9CoWYy1L3Lx8FdPXRwYB4ojaNgvZ9LU0lsRDKsLn?=
 =?us-ascii?Q?ELgnHg+ZX1uoG2PJQewHIadcDMkcZ1tQ5muhnOBGB38zxmIwYMMKlPVY5+xC?=
 =?us-ascii?Q?dNEKIF1U+NEAXms7Gbli0tLdoh2p6Du8XB7ciIuv4++13koR50M/WgSSwxww?=
 =?us-ascii?Q?mFYrpEB7AGQHuNMxBVjyUaUFfqsPU4Op48vI125WF2RXE3cNkgOr5iBMT6aE?=
 =?us-ascii?Q?8w=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408b16b2-8d2b-4da3-76d9-08de0566eb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 06:01:12.8942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bobZvCDWImfcxbaJX1Wemp5Hy/xBKELE1y60Lul59eS/vul66eFDP3RRPUY+kj549hUoEiwg2gcWSNIv5M9XofgFxauZ+x0JoVqeTLsZzm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, October 7, 2025 12:15 AM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: josef@raschen.org; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init iss=
ues.
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > phy_sanitize_settings() is supposed to pick the least supported speed
> > from the supported list when speed is not initialized.
>=20
> What makes you think it should pick the slowest speed? The kdoc for the
> function is:
>=20
> /**
>  * phy_sanitize_settings - make sure the PHY is set to supported speed an=
d
> duplex
>  * @phydev: the target phy_device struct
>  *
>  * Description: Make sure the PHY is set to supported speeds and
>  *   duplexes.  Drop down by one in this order:  1000/FULL,
>  *   1000/HALF, 100/FULL, 100/HALF, 10/FULL, 10/HALF.
>=20
> So it should pick 1000Full if available. If not it will try 1000Half, if =
not 100Full
> etc.
>=20

As per code referred below,=20
if (!match && p->speed <=3D speed)     =3D=3D> This condition will NEVER me=
et for any supported speed(p->speed), when speed is not initialized(i.e., s=
peed is -1 and p->speed is 1000 and 100 in lan887x case).
	/* Candidate */
	match =3D p;

if (!match && !exact)
	match =3D last;     =3D=3D> As there is no match this condition hits and i=
.e., the LOWEST speed supported as per above documentation.

return match;

For reference: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
.git/tree/drivers/net/phy/phy-core.c?h=3Dv6.12.43#n305

> And the comment is actually a bit out of date. It will actually start fro=
m 800G
> Full, 400G Full, 200G Full, 100G Full, not that anybody does Copper at th=
ese
> speeds.
>=20

True.

Thanks,
Divya

>         Andrew

