Return-Path: <netdev+bounces-146166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6B69D2298
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D60528321E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8E19B59C;
	Tue, 19 Nov 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zLlWqomM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82B19340E;
	Tue, 19 Nov 2024 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009266; cv=fail; b=YozhI8E8AL2BxSwPIkTZXF89ZTCMbq4gQYNrASGgIpx9iyqwfTnwVoYvHT0wuToUPSewk6K9Mx9j2hB5Roy+JlowK3tuBt0cEzr5x7l8hMX+lLAyvTMeWDf+9zOHpONoK17Y7GXyBWQ729WuN30eM93pz95d4Fs2YUqT8fvYztw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009266; c=relaxed/simple;
	bh=g/FuLekuikgYKE4s5RbM2wI2/8npsqxxNCXMyUQMqQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHj3lGh3GRENNyiIQlAvJcS1K7y3MsH4ZGlcsnVpc78PFT3u9HbqmDJOaCVObZunwcDQJ6UrEinQMY/wzZ12uep2Ii3z/qptg6cumam3EbCSL5D45sn4Vo1ov/HawjOa3H+vGQDWxB24NrIXD3aeT8xsbPKacZqP3afVqxDiq7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zLlWqomM; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxC4BtKo316mCNj5V6l/Ndn1LVs+ixCBsrSaVBfuWlypWHGEu51BbPzhh9wr683HeJiXbi5bH4U4EF4iEu3gTeF265ZDjopZezpcJ6HArh0fp8KjyhCSpDZSqZEcJ4rDuqE/BG3ILg4pUaWLojwkGtgvW0Tk9hRC0cLRmX77Ry2Rd17c6iWxhMlvImSK0zF5DucGrovNaLlvuat+BTfl4f1PD10XJzqCkqroxNsXlz/iSmoFOV3qoO6F2H/PTcwKAWaK/bL5mf4S9YNMW9WtuuUZv+WuZlj9s30Ff1HmV7Vr9H3nNPbRQW0D3aEa6eKVx4528GTBvYNDOHIStT7DMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHx4LjeQL+js3vVn3zL0hfwY8jEjIfaS6UKxQR0viOE=;
 b=kRbMNZipx9YjU6u9wGxEaCQ5D/0+xZGDa7e5hp9EzlgrJEJp/N+bZJif/x61W0+VvNX9OSH51jgp8unBJ+NRkSw2XpOqhmsbValnRjjpqK9zEzftNru8ruMTAhCKqEzZZe1UFCYiEWzmEMm/kCoLo33IO9uOD65PQ8sYMWtzJeXXkoFRqfj67MxeBoPahr+UHxh9lCVRvvcjwuY/ozqtYRwKqOWoc9ixRlU1A0vy5chPnNX8Frfiaktz+u2Ehlb5wuZIbN3hl+UxCQHeS8AUSQFbazZ5UIcOlLOL2saW7dKfV4IKS1k1v0w2uUzjRUXpMTYIHhtyUcccqfKdwvZR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHx4LjeQL+js3vVn3zL0hfwY8jEjIfaS6UKxQR0viOE=;
 b=zLlWqomMiIq3raUPuaHxz7jsKou7ywAZDFYuihy2INSSZzQT82V5n0Wn6gDXFZzR0Bpwpae10L3VhQNxKfgK+n/1HqTg8lSgsTACP7rHl62n7cZ6r/hxFA5ZfrrnzrimjY9aiQeaFCvYN+GXFZrbi+3ftlY6B7xIkcXj7WG8n/k=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 09:40:56 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 09:40:56 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Andrew Lunn <andrew@lunn.ch>, Sean Anderson <sean.anderson@linux.dev>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next 1/2] dt-bindings: net: xlnx,axi-ethernet: Add
 bindings for AXI 2.5G MAC
Thread-Topic: [PATCH net-next 1/2] dt-bindings: net: xlnx,axi-ethernet: Add
 bindings for AXI 2.5G MAC
Thread-Index: AQHbOZKESLv/ZUD9Z02pSi5VFRh/TbK9MUKAgAAAz4CAAKJcgIAAf8pg
Date: Tue, 19 Nov 2024 09:40:56 +0000
Message-ID:
 <BL3PR12MB657106F2B29FE44123C672EEC9202@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-2-suraj.gupta2@amd.com>
 <20241118165451.6a8b53ed@fedora.home>
 <410bf89c-7218-463d-9edf-f43fc1047c89@linux.dev>
 <ce534b32-7363-4433-8b1d-4e01c3d92084@lunn.ch>
In-Reply-To: <ce534b32-7363-4433-8b1d-4e01c3d92084@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|DS7PR12MB6288:EE_
x-ms-office365-filtering-correlation-id: 343ec834-128d-4a5c-496e-08dd087e44b3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KCn0LYhv1gRB2HgacCeTxLMVMLdptmXpAAzpuDLraoihu3rtfKKtOmkdr82B?=
 =?us-ascii?Q?nTWPmI1rUbLtEb+dFC756z6hQSINDoCb/lUVicsHVIWIHnHwRy6tcDtsSHl8?=
 =?us-ascii?Q?HYLVCgN+ZBX/3b7AdtB1RbuxOjio6ek0TEVno+UkhqWJXi1iL0Cs8+35WBN1?=
 =?us-ascii?Q?aP9OSiKbBvd9Lf87RaIBkMrWTNMnDiapM1DCMbuy9vRf3NZH+ehuvAuSlUFF?=
 =?us-ascii?Q?KLGnRtcdfihzKkD9SjpKV0Fr0bmbzo6GCMmN2VfI1Ua3Msjklp3Lz1CK+G+L?=
 =?us-ascii?Q?NmKjq36Bv8GCIIfCparPwLzd8B7CYBoeR7poT+8ndGUN6Pcq9CEacY08efKy?=
 =?us-ascii?Q?jDbTK4y+1UIJF/LNnVsAIDE7DjYpoPJ99zB6EkEFzCHUiKVz5LjppPSObqvI?=
 =?us-ascii?Q?4t2IWSx2oZI1umyLepkPfACkAVvgt+DJTzlODe8nAJXZnWBoun357B+X73PH?=
 =?us-ascii?Q?s9NtOVUtPDzWh4UwxMskE+NuXdvbtK0hI7w9g2ZvRkgFR3NG+CymDoVgkIBR?=
 =?us-ascii?Q?mDB3nNgDLSD20RPJygnqg+KvxhcLQn/rP/4+9LZJ9EXUvWSa348DCLFl/a/T?=
 =?us-ascii?Q?pm75nz/2e8oyIRKrCuQ94fnXWVg6moExbBhj9WS93eUovN70Ksc/JMhvhT9b?=
 =?us-ascii?Q?vqDVHkjO2fo6rhPvpCN5JLiqWx3+a9v0h1XIRpEfJMeoDPoOGWuLg52LfCNZ?=
 =?us-ascii?Q?a4Pnz2OVbw6WZ/qisQ4YXDR3plT7lGC7n63lToHv1Jvq9qoJJUKNJG9lHdTc?=
 =?us-ascii?Q?M9PKtDrctyoc5EkLIcU6Y9rZ+6Eh3ow0E/2kdlWhV+k83Km6gUnR5kG8POLR?=
 =?us-ascii?Q?cAo6TsMoIqwIKY/suf4WUw96xritbRWM5Dc6mpik7y3xJLXRZGqJzWWrHgib?=
 =?us-ascii?Q?vwH8VXPZsF4yJOUutJAQfLsGp9995Vc6hOXS97ugS9hwmio/TKrzgOYkdGti?=
 =?us-ascii?Q?FEL7MTeTonfroEuFhXvlktlYNr/XzPiMNpmj+n3dWne1HUWu1sRG+FP+GQkn?=
 =?us-ascii?Q?rvDHFytPO17HBtwT9fVqGq4FWgwWTuySqSm0IIIHl7QDun/AVek5/0ZGMrNH?=
 =?us-ascii?Q?WmR8WvVBGmY2DglgmhULPbQz8zF1NmCszo+HoQjeHv4dwRfN9cZn4gRLaFoY?=
 =?us-ascii?Q?lvfTe3Twd+py9Z4RB0T30WPTPKcqHOSHL9r441qh1U/dpNaXuCs97MjV0keg?=
 =?us-ascii?Q?Ef3ah6SHor+YRHCfIQQ86uVjC+R82rbvZIUIQa1U2geUB6w4s3oDXk709LR7?=
 =?us-ascii?Q?maQq0yuAbvH+HbKIdS1pX3kHS7I1/hD0CqUxe5PIpaSkz087D508w73veEzG?=
 =?us-ascii?Q?M+udKedCSQ+JpT8hBBdz2NqGYla1oGJ0+a9DtYh1nAWVHEdPcc6LvFP9xNhh?=
 =?us-ascii?Q?veK3u/o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QJIQOVaS3B045Wg4iGmrrpyNvUlCxCV1vryXFvRByCHYqj7eTCcywgIV0eJp?=
 =?us-ascii?Q?TbalN4tpJH7vnN53cTVxVSEy2qQpLv9Vs/ivCpVgnuGQfBdQcTwSRoXWsklw?=
 =?us-ascii?Q?hRLTM84PHvhaFLBvB4p8noUizsAcYD2gUjZjsSKUHY41cxIxBX47v/sBHDld?=
 =?us-ascii?Q?YopLtoidVM0Gkt1wgNN5swrAkxkTLELsbL4i0Yksx4YGuxjCcW6aWXCMb00U?=
 =?us-ascii?Q?KPkTV7c7XmMhCpmxq/xPj8DNuGfH7TMXZy5AYZp5HIQd3Pmbfgks1Fqgp2ym?=
 =?us-ascii?Q?ZyB7YeYHR9TrNmiaDqtl/fZIm1Esa5/t9G86yrJMMvlYkEo5D7N888/3w7lk?=
 =?us-ascii?Q?WiWFhDjimBr9JGX/H3fV2G2mom9LBaq4qVhovyyxCFZvxNi8lahcsS6Yjvyo?=
 =?us-ascii?Q?ed06SmjUVn5MubhlTm1p2pwbU45VcfP8DeFBYb3SPqrBlCNjO+JYCopxEnl3?=
 =?us-ascii?Q?47FqehRXNQAgnieHHDNQ+IE2HaD1ncgdtO35IvODEQ8FWE0SY8/XRjJn2E51?=
 =?us-ascii?Q?EPvnQFmgeX6ATirN4tfW/sNFKMCbtjHz8Fs+YAQ9t3Fm1t74HovR0HjXTXUp?=
 =?us-ascii?Q?0daEHr15r1jccuNOqtsFTGQXMEKXtgN7OL2zQiBFt+5wAj7nL9MFYu4Dj0jS?=
 =?us-ascii?Q?LIY+iHKaCbdBdlnj0COtMASpLLfn+PVC870gqTLF4edyJp9AnXz7BZ4+8+34?=
 =?us-ascii?Q?OBd9aozCGiM5OrmL/TlrFpe7tYC1/R0XGALExmtNcYaqTOqoajIgHKGrAo5c?=
 =?us-ascii?Q?nCiC/Nh+2VJq0RV3wmA3ulx5H84p6d6C3hV/j8o4Q5j1iKE1yTjQms7wBY0w?=
 =?us-ascii?Q?ZEvp/BXnjbR8MJgXj0BoBzMGM3TDZxLqVEYXhv4sASMXrC7jI1mzjYUA7NuA?=
 =?us-ascii?Q?gvy0Y0LDqZiiasSDmwEhb0jmu9BdmfspiNlp24QMQe6mnywGX1gZUdYUmbMX?=
 =?us-ascii?Q?GX2lHBkG3Mh790OkDLIWL7vsNt0dCCbq0+9M5Mqt/UXtxUGwOjLd9d6DJvPt?=
 =?us-ascii?Q?D0MBBRokVV28yJlRyS80RhpYOf5eavDc4fe3u2O8nN0X3oYvOWc2FTgZnGH/?=
 =?us-ascii?Q?8hEC8JI8VL4LIZoUOBTKX3NMm1f3J3OAWMjzV/o6FIpbtvsiAHa0a7eWuAUr?=
 =?us-ascii?Q?Dr8EfayqmuepwqWbgASxVSvtTlm2KpjbXd+aVdmabfp2jPNrMvkvUx894sG0?=
 =?us-ascii?Q?sjOk2hkztdTb2jYIjqE0xvDAtsziUWHk9rOHJAeXtIb2R0T5I5m/qSsfpyp1?=
 =?us-ascii?Q?tL82neC/jBAiEou66afUNVsqrLN3mHTwzmXpzmr5/vWwdv+YX3yh0PBe/zfu?=
 =?us-ascii?Q?sYF4j3XPr6V9Soz9pnuQk/XgJI3M0G2IOo7pKVPAO6tEmQ0lOHE5EkjsyNas?=
 =?us-ascii?Q?M5+8BpMrXuM/Fo9OrkE+V0N7fcbzWsPG9I5xfqBip/m2M+5c4ohGoIXTcOZd?=
 =?us-ascii?Q?Ip/eq4h1SO5VaaEHlOQVpxiMyTlbsJRxRIICvPnJvmQ+X981AF/RMCsEhZtq?=
 =?us-ascii?Q?a8A5zbqU+Rn14A/+SgepD/8ecC5Cu5E5BXS7V1olwZBANUDTrRoHsKZY53Wu?=
 =?us-ascii?Q?fx09WvO4spN3Wdm9MCQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 343ec834-128d-4a5c-496e-08dd087e44b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 09:40:56.7582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbYM0p3NWYx13O75B+buPqZF1TDbQXWTXfhDOLqHGVTT0uGkeu64k1Qta+mXhKECa8d4C2rGQ+uQEwLvb5hJTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, November 19, 2024 7:09 AM
> To: Sean Anderson <sean.anderson@linux.dev>
> Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>; Gupta, Suraj
> <Suraj.Gupta2@amd.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Simek, Michal
> <michal.simek@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; horms@kernel.org; netdev@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git (=
AMD-Xilinx)
> <git@amd.com>; Katakam, Harini <harini.katakam@amd.com>
> Subject: Re: [PATCH net-next 1/2] dt-bindings: net: xlnx,axi-ethernet: Ad=
d bindings
> for AXI 2.5G MAC
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Mon, Nov 18, 2024 at 10:57:45AM -0500, Sean Anderson wrote:
> > On 11/18/24 10:54, Maxime Chevallier wrote:
> > > Hello,
> > >
> > > On Mon, 18 Nov 2024 13:48:21 +0530
> > > Suraj Gupta <suraj.gupta2@amd.com> wrote:
> > >
> > >> AXI 1G/2.5G Ethernet subsystem supports 1G and 2.5G speeds. "max-spe=
ed"
> > >> property is used to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> > >> max-speed is made a required property, and it breaks DT ABI but
> > >> driver implementation ensures backward compatibility and assumes 1G
> > >> when this property is absent.
> > >> Modify existing bindings description for 2.5G MAC.
> > >
> > > That may be a silly question, but as this is another version of the
> > > IP that behaves differently than the 1G version, could you use
> > > instead a dedicated compatible string for the 2.5G variant ?
> > >
> > > As the current one is :
> > >
> > > compatible =3D "xlnx,axi-ethernet-1.00.a";
> > >
> > > it seems to already contain some version information.
> > >
> > > But I might also be missing something :)
> >
> > As it happens, this is not another version of the same IP but a
> > different configuration. It's just that no one has bothered to add
> > 2.5G support yet.
>=20
> Do you mean 2.5G is a synthesis option? Or are you saying it has always b=
een able
> to do 2.5G, but nobody has added the needed code?
>=20
> This is a pretty unusual use of max-speed, so i would like to fully under=
stand why it
> is being used before allowing it.
>=20
>         Andrew

2.5G support was already there in hardware, driver is getting upstream now.=
 1G or 2.5G configuration needs to be selected before synthesis. In 2.5G co=
nfiguration it supports only 2.5G speed.
I'm exploring registers to get 1G / 2.5G selections information instead of =
using max-speed. Will send next series soon.

Just for my understanding, could you please share the use of max-speed DT p=
roperty if possible?

