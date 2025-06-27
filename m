Return-Path: <netdev+bounces-202016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 174FAAEBF60
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68171C461D4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2921F4727;
	Fri, 27 Jun 2025 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MNvwQe5i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5572BAF9;
	Fri, 27 Jun 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050855; cv=fail; b=foZRlHn3xMU7NF8ix9tRIcNUDWLcMpXJkX7zvkGyUGLNiEnEm6A5SusHQCCPwS6k6ufQEUPiR79/YqoMC9rGa+crmdbIYirHjIAaU3+mt4JkowyYUzgEijcyiqXekWPCWOpPGTxFbpoydB/w7VNpkiPH3vo6JD1zTn7TnHN6dow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050855; c=relaxed/simple;
	bh=DsDzp0Or7Sza0rnM+N+nA3lTEmHErKnG8MV+2EJNG7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShsOH+riNERthcglws3+yZzl5IHGV96Vi//yGA6U9JD8bc843DeXScVou/2c2RZn1VKIqFnnmCwtGcurQq8cgvlrhHsmofLSYbTTW16zRhDlFtfVGko11ocKIskO8cnCrKmafH7I/UWCXpwpU0Sx5YDmW5vkTJseHUin4pnitmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MNvwQe5i; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/aTJ3PPGG6D7Fe6RatTtcWdyXQpzlIQoDruakQNpXqRO6WgI8m2bqkNgCOxrdurEspcfn8JhOcoTtubiXqW7pjewxGt9JBzNhMEUtEZ1SHUEUujN2EaVwngr0M8gciNwiARPARdkcw+GaL+CAQJdL4LsomprZafeA6iQiUcaXopYjUoL08P8XlKdULOheHWhA2X4gazEMssfBb/n5H5Xq6/FsgyNtGHnmKuuwkq25J+29ucHHbO7VlnUy6SiYRSP1lllvCSpqfjFcE+q+1v07koUAHjp55S3CROnyCgjt3z+2c3uoPpDlrrThJZQSCsdxmVosC6B7kbcV9KVds6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZ8Emrj4V5eZkLLT9jx2/r9Vi0wFQIpfVI28JDOa0vM=;
 b=hPLB+yPH/r+l6ou6dD060GN+MeHIgzTebztOqRcc7Y62EPLwvTHHAQW+zPaJgDlnBrLLNo1+ncuPWendhEzoS3KFU1KMSyXfo3ILA/IDNLvndq7u5WhXhVIiCrypOTpeBll83kVLd2lac847f68pWPcaIZ6zyWK/0zvpqpwiCivffleo3N0V66IOYVBv7Ee0Iz/uCg+bV/0tEmFF6fnkWamyv24NMUdXpHIDO6aQvOoJ2a8Li/WQVcFwL5MIkVWmP7cPBA5nhB1G8KTF9lQenEr+qY45+vVTCLenlmfQYz1xvWWtKi0ZI9H8mMakZ33SE5qW4XcdahgYIlVD2CI7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ8Emrj4V5eZkLLT9jx2/r9Vi0wFQIpfVI28JDOa0vM=;
 b=MNvwQe5iOedoCe4HNKGAE/6DfoRQzDsH3S9RBVP5HfY90MAd2SNJJqozQu5K8NzZwFqX0IwGbgauygfQ041l5idnBTf9VSvfVKW4CUOKMBfYzeS/Hc5VYvoF2b2ww/fbQPiVI2V1NlPKh4Z3wVuzl/BQhGebhkO2IPxVK4OMIMCa/J81MUUhx6z4hPA+OpYb/rDMnf9VOx3W5FaMU4M4PE7VKFhy2413djaw5jGHXOcSZIx64rAnIZIzFCzzxeveFelBbgE2m0O8gDUxQM4TJQ4kYC7OCsA7AloO92Chr06p/RyfGIFqaHP9tY2T0Q1lrV9dZQVR5+G+apSDMmXisw==
Received: from CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 27 Jun
 2025 19:00:50 +0000
Received: from CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee]) by CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee%3]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 19:00:50 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Topic: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Index: AQHbPTCwkw/5mDAiDkuucKlF479Xq7LJ1/+AgP/0uKCAAAhugIAAAetQgE7YCVA=
Date: Fri, 27 Jun 2025 19:00:50 +0000
Message-ID:
 <CH3PR12MB773870BA2AA47223FF9A72D7D745A@CH3PR12MB7738.namprd12.prod.outlook.com>
References: <20241122224829.457786-1-asmaa@nvidia.com>
 <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
 <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <6e3435a0-b04e-44cc-9e9d-981a8e9c3165@lunn.ch>
 <CH3PR12MB7738C25C6403C3C29538DA4BD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
In-Reply-To:
 <CH3PR12MB7738C25C6403C3C29538DA4BD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7738:EE_|DS0PR12MB8575:EE_
x-ms-office365-filtering-correlation-id: 95313719-8054-45be-6650-08ddb5aceec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Re5TaWb4yqmRNaHBrgU3WbKaq10igpZ05PrMF2fCnlujgcTJZguf+/3cx04D?=
 =?us-ascii?Q?RzyTljV70AxMcDjNis5oATaWNXO2ZloCdNl648vyDshfuK3YvTnaBqzg1etA?=
 =?us-ascii?Q?YEnFUg2h0OBPe702vthl0mfn4u8K4k7hEW+XsBxgl+FltZGkYtxOIyIKKlVV?=
 =?us-ascii?Q?Y7bAdri2vGoVXQUtVc4dESYeDXSS1r1zGl1RwU2CKYlL5OlJuTk1lhQtNJ0N?=
 =?us-ascii?Q?0PX27ArKJt/W+oA7HjInoT9AmqJ2O7WArLRqPjPajJNio/B5bU+0RXJ6nhbf?=
 =?us-ascii?Q?mU/LwBAMYvhR0zwDZkqUCxorgwvUIslXJS/It7SOmBt6uNrvpuEzEhpIfPGo?=
 =?us-ascii?Q?OPzyd4vzRCJkdkkcMB4kGZUDjKY/UdSVdc1h2TRLWAu5QLbZLwv6zmk/n/+k?=
 =?us-ascii?Q?VPFKXK7z0oj1POedFBXSdldwGX5aOyavs8Glak/LML2aANwx9I/cN0fS17vr?=
 =?us-ascii?Q?dbcktLX6Z8aUsNx6g8IlAyYXGtz2oiDvoC/f33Su7uCY4N+CJON6FtpevLYw?=
 =?us-ascii?Q?GVpgEFhdhobecqEQ3i8zDPrYEMgwPjNL1UcEjploR/3ZURRYlscUI1YydlSU?=
 =?us-ascii?Q?dCeC/5SkVPhujKnHiU1xaQs0XbBDzEPjmmBItI8QeRaRd40FD2CcBkGdyXz6?=
 =?us-ascii?Q?ih2mX+cPL9pcyfb4Z1Krvt4uIlPE8QfaU4ubQKljxYNKfg+ibDkKQtxWSoqG?=
 =?us-ascii?Q?p2GLZal0IxF5Ga4hSIDpNngxIcNvKTnPPqZXhT7pH+k6ceCrBnp5VcKFZpm5?=
 =?us-ascii?Q?Hn7K+ZbeJ5phc6Wo9SrASSE+4hDbVLV9ncRS3W34Q/t4AB1zlwBc8J3NOJFn?=
 =?us-ascii?Q?BlB/HGDSUTt6eMi0Y1aP3LWhLhRHhHvo0a05cID492ZWUtICIgaB7Hmtbby4?=
 =?us-ascii?Q?7lJxtdZiR4GfsLl6XxaEFDbYZ1E9acu7ql/JlOWGtVYY3y+lMHSoRyQTLnwK?=
 =?us-ascii?Q?hDQeLpJftbu28sfkVj93IzS/yb1BeVBOXdqwMfGBFir/lvw/di6OdgJU7FVG?=
 =?us-ascii?Q?8BrXGnz6IBp+7BoBL7bgCq9tjyZWTHX3pflZpeOxUA4XJa9k7C/iaVZaYXgO?=
 =?us-ascii?Q?9QoltlM5lzwWZNb0mriNqx94nU+08LEq7HSN41cyxPDiA3ftQSCAX2iKcmRJ?=
 =?us-ascii?Q?3Ac8zV5Fb1chODtHLsRFQrEhYsqaVLctGvUlF9lXl69uqtSOwhDmWuSRs6FW?=
 =?us-ascii?Q?byC47WkkqCasmAzM130efJg8AHVTnF/JioIfi1nHVowJSYcU/T29q2lCwE3x?=
 =?us-ascii?Q?fRCz2k3QZI0olpy7taU+WzB8MBnBVYty+1MZ8Zic6yCvpbGYilr3dM4C3msT?=
 =?us-ascii?Q?Qpvpy5azJdLIxE82oNOyR4DnDFjRCFlADcgjUGoba+kYL4BLuut4LskKA8Cb?=
 =?us-ascii?Q?eMSIJvkK14OHSeUekDwH8m/+4q/2beeX5GyHNjseaVpvvuQyuYTHb2rvNqCd?=
 =?us-ascii?Q?atKBxiudPsSCobHeK5+Xv6xQpPGmG2sW4UZUdGDb0JqAgCsgofX0KesbEy9A?=
 =?us-ascii?Q?/kXdWKWKesnUjgk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7738.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P/TFaKvAF2t0TTqQgdtWPoNQbhiJF0nV4TLgD9x6neRY2hCIGhf/USNRoDTd?=
 =?us-ascii?Q?xUT/JglO0BOOUFRH604Is/X6L1JNSvDbNawmwMtpmyYKbUDY/+z8mv6Jzy+z?=
 =?us-ascii?Q?BYKhsqxhtPZvh4h7mqgGlZ4tDxJNy+VaPaUPWgMhkr4HVCjkvYRmHtwnm/if?=
 =?us-ascii?Q?glVnvTQOxVWoiZoUa5Az1Mr3ApwoKLxCIio/MWCX4C53ISgvel/Zd0aRfe6V?=
 =?us-ascii?Q?ps+2iv9Y/Zd0aZe41gveKFRMmbnL4Y0GOZzZDj8QtMZPE2ConiKEEPtq6Tmp?=
 =?us-ascii?Q?EV7mwVL5TB6Zmnfanv4RqzFh+0IBE/gB4Zy+JyrgPzX2VF1DLfvbu/36xUr7?=
 =?us-ascii?Q?JXOcJt2P3iwhBGZzPRuZ27qoGjhT6x0a/XOdKlCzhH3dFTY6TKOtU8DqHbVR?=
 =?us-ascii?Q?TYSMW4xHhwlRuRgbkomN9vszAZiE/XBCrhv/eOdMJVvN3UTxJ9K9t5z7ZM/B?=
 =?us-ascii?Q?uuCxWyVxL01+2GO1z4cClp9FPA6mzyAb10T15qfduiFzHg3HDD+Lg+sE+Jc8?=
 =?us-ascii?Q?FgzK3Q0+ynJDFEUrqPioyG+iiw7XLrjuDHd0G0HJ18PweZj+AXXqJZq/Cbxj?=
 =?us-ascii?Q?DgCtEqVsbxaHCACLmA6fUYmmWht1q1dP1mUMrz+Izd33w8bUu/XF81nQVSGi?=
 =?us-ascii?Q?10eROHY/3QWLnfEczV7Luv5sMMCmyXPwEPo7YQyzRDZe4bPdOWXjDZ1cqfat?=
 =?us-ascii?Q?2PslOym6hWYEI/n8PFMT8XD/ODn1Tg+MEVlBSH7AMEvQXtjIVehzL+dR/YVP?=
 =?us-ascii?Q?9cGzguo4Swgg3dIgZsdhPg0+5hIrHLeo/ZGqpoWPm5s/cJ9Qa3o+M7fdAWWn?=
 =?us-ascii?Q?JUtZgnjH58ZgjBTMP3cd/eIRaYOerEqD7e62lMlQ0DpTqHcgwcKSA0raTP7n?=
 =?us-ascii?Q?+VUFk3lx284qQxzVW6tv2vDaZRVhHByVN6cg6ItACIetHZcB5YWl8uXqGSx6?=
 =?us-ascii?Q?Qz/0hnSXxZ43rSPN9Wl8bWJpfV4IS6aInPrpQbOJhbQNE/KKxb8iqJRX2+Nz?=
 =?us-ascii?Q?LTOouCyGuJyrbCQq1f3I9/RdCbWowQn3MBMmEnfTuVhY2l3HMUyW1G+aWzcS?=
 =?us-ascii?Q?V0hCW+MR5sRAS3bLOA5ayGx05rBlsyJPTx+FTtI0FR37QIPWC9vuUnIXQgso?=
 =?us-ascii?Q?gkW6wdqX8XoNGt34mnZReG616p5loulQJ1hUgy8ZexHPK3b6rF4pCu6d/GHS?=
 =?us-ascii?Q?1exFuGOiCaYdRg3O9ebFOEIbEWsPxsixOoQ0J/JRN7bWIVFz2YW3JsPDHgd8?=
 =?us-ascii?Q?6KxsJccI1VhgNtGGsCKGcfJsjtPqmvLWQrMPbBMAKZMTAJhzmCyZMHiTo3TY?=
 =?us-ascii?Q?+Plp3oOwYIQ57rBZwPlwWV2MqZub6Jcg029C8a8rSpKEznuBP8ZaIrpAlgMb?=
 =?us-ascii?Q?WSyTauZVx7e1CHcMqseCFBeSLOahEj9UxYIVXB65Va/0LLcjIvOkwh1UcP/7?=
 =?us-ascii?Q?n9bkk4IshMmYpvmL+ilsm2RWGDqzr9MuA/qlZ9J64FsjDSb4ysGadUEzjwuS?=
 =?us-ascii?Q?QMXn5xIcsRTLghhNSVudbUpL2XEZZz1yjEuqnCAy8cOgl8I/fBNIzUD3QJm+?=
 =?us-ascii?Q?JwifeFfD8UMiUbBVkoU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95313719-8054-45be-6650-08ddb5aceec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 19:00:50.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /q+//Q1X4slGDG03hDNk2SnJMzum3lMtc71z6zeFVQxyiR6eBiCod05o3CGVoglPsMfV+LZ6Q2AA7JhHMRwM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575



> -----Original Message-----
> From: Asmaa Mnebhi <asmaa@nvidia.com>
> Sent: Thursday, May 8, 2025 10:53 AM
> To: Andrew Lunn <andrew@lunn.ch>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> David Thompson <davthompson@nvidia.com>
> Subject: RE: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
> degradation bug
>=20
> > > > My reading of this is that you can stop the clock when it is not
> > > > needed. Maybe tie into the Linux runtime power management
> framework.
> > > > It can keep track of how long a device has been idle, and if a
> > > > timer is exceeded, make a callback to power it down.
> > > >
> > > > If you have an MDIO bus with one PHY on it, the access pattern is
> > > > likely to be a small bunch of reads followed by about one second
> > > > of idle time. I would of thought that stopping the clock increases
> > > > the life expectancy of you hardware more than just slowing it down.
> > >
> > > Hi Andrew,
> > >
> >
> > > Thank you for your answer and apologies for the very late response.
> > > My concern with completely stopping the clock is the case we are
> > > using the PHY polling mode for the link status? We would need MDIO
> > > to always be operational for polling to work, wouldn't we?
> >
> > You should look at how power management work. For example, in the FEC
> > driver:
> >
> > https://elixir.bootlin.com/linux/v6.14.5/source/drivers/net/ethernet/f
> > reescale/f
> > ec_main.c#L2180
> >
> > static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int
> > regnum) {
> > 	struct fec_enet_private *fep =3D bus->priv;
> > 	struct device *dev =3D &fep->pdev->dev;
> > 	int ret =3D 0, frame_start, frame_addr, frame_op;
> >
> > 	ret =3D pm_runtime_resume_and_get(dev);
> > 	if (ret < 0)
> > 		return ret;
> >
> > This will use runtime PM to get the clocks ticking.
> >
> >
> > 	/* C22 read */
> > 	frame_op =3D FEC_MMFR_OP_READ;
> > 	frame_start =3D FEC_MMFR_ST;
> > 	frame_addr =3D regnum;
> >
> > 	/* start a read op */
> > 	writel(frame_start | frame_op |
> > 	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
> > 	       FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
> >
> > 	/* wait for end of transfer */
> > 	ret =3D fec_enet_mdio_wait(fep);
> > 	if (ret) {
> > 		netdev_err(fep->netdev, "MDIO read timeout\n");
> > 		goto out;
> > 	}
> >
> > 	ret =3D FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
> >
> > This all does the MDIO bus transaction
> >
> > out:
> > 	pm_runtime_mark_last_busy(dev);
> > 	pm_runtime_put_autosuspend(dev);
> >
> > And then tell PM that we are done. In this case, i _think_ it starts a
> > timer, and if there is no more MDIO activity for a while, the clocks
> > get disabled.
> >
> > The same is done for write.
> >
> > PHY polling happens once per second, using these methods, nothing
> > special. So the clock will get enabled on the first read, polling can
> > need to read a few registers, so due to the timer, the clock is left
> > ticking between these reads, and then after a while the clock is
> > disabled.
> >
> > My guess is, you can have the clock disabled 80% of the time, which is
> > probably going to be a better way to stop the magic smoke escaping
> > from your hardware than slowing down the clock.
>=20
> Sweet! Thank you very much Andrew! I will make the changes and send a new
> patch soon.
>=20

Hi Andrew,=20

I implemented and tested the changes you suggested and the runtime_resume/s=
uspend work smoothly for MDIO.
However, we have another issue. I noticed that even if mdio_read/write() fu=
nctions are not being called, runtime_resume/suspend() are still called reg=
ularly. After investigation, I found out that this is due to ethtool being =
called regularly. Ethtool automatically triggers the resume/suspend even if=
 we do no MDIO access. A different team wrote a script which monitors "etht=
ool -S eth0" every 60 seconds. So every minute, we are running resume/suspe=
nd and enabling/disabling the MDIO clock. Seems counter productive. That te=
am said that it is a requirement that they collect these statistics about t=
he mlxbf_gige interface.
Is there any way to prevent ethtool from calling resume/suspend without cha=
nging core kernel code?
If not, what would you suggest?=20

Thanks.
Asmaa

