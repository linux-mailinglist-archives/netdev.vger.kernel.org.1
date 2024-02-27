Return-Path: <netdev+bounces-75423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE2869DEC
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCE51C215C8
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3E4E1CB;
	Tue, 27 Feb 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CkMTc0uQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D384EB52
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055559; cv=fail; b=Sdyqbr/JEso73w4LgJ8bB+Q7zUTacfx7fMOaoMWZ+5b/RhWaUbFWKyDjCzbC9EdWGlPjd7d6/w6JSEHZG4Ah7rrkZJ73hX6M52fN11qP4UkpntFhuLf0SLhLjFTnp3Rh7blkUCV7xuzAVyvBibPSS2ICHvBXYaFWxlzseYTNBd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055559; c=relaxed/simple;
	bh=AlYHY1E6AsGsRq0q4oOu4WnuboMfYz/QmK8iOZqCIts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IgMkJ6CS24gMJNyktaKqlUb/LRFY4nu+zSOsd+Q1grkYfDCj52/HHyJPyLwuOYxxEgAIGps0m4PPH4tmmiHo3KhAO9S5gB51YXD6iWPJmM4+r2vx46igWIHhKHTnZ8n4/9+O3yCFCFE4kWpJ9SG0LK2gu/5GsZrc7eiuzQX5s+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CkMTc0uQ; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLIgfzwPiShVoUO1L/9IG0PwBR7RBLPH7H3uCdsGhA/kOIMIJBOh8nA00Y+Kr7RlJkeD45trCK6j4KwLIyYFKu03cYbW6tVT4VB95519g06zv9dV9JSZfDw7xRg0WAseBYiTgPtj2izAO7DwqR71OzI935IU3bDOxshSXH6oeXMM/BjpZsAnefmrHTboQPT3E73tqnaFzyJZdLq/RAPhGk7ZQ4XPDElzV7H5zV9/bCV7GklF/2POUieonWVHH6k6eZ0j3nEV02in6N+0k77xX6XrhzeEFFlxfW7NWUDNE4dpuhuHKR45PopDXk0KFsnkVmjIv0a7MYwMcVi41cA43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlYHY1E6AsGsRq0q4oOu4WnuboMfYz/QmK8iOZqCIts=;
 b=FvYgFtI3411Nvrrjmaqq9iVlXFXMO3Il58mGKEj5UkuVKuWi3UnT4yje/2P5A5Dt0ntLkTjAJMqry+unuDpgncJi7CgX5V+ptaFdJtslORzSyqLOU6Y6mpGrdkBm1kmMEbK9+uhwQvcsfRwBUWkajDL8paC13KgMrWcy/Ck5cJPR8tGDRoKgMwW0HiZZUFkNYEdEEd3hsfBRNpYEKR6Iw3Hb+vnUmeb/61krfgfTQsaM4OfMnRY4JPbal4T2BD/kW8rUy8JbbP1HqhgeV0O5z+wm8Qg7+OJKqTyo/qDPG+/Nyi3gNS4IhwRtPxBHFKXpbGyCyl2qFtP2MTDozQ5Ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlYHY1E6AsGsRq0q4oOu4WnuboMfYz/QmK8iOZqCIts=;
 b=CkMTc0uQE9wis3porkJls1ucddUFKmyYStsPpOlDBKTTJoQdx0AzXrBJtyLXGxrhqsdarl6VNsBclz1JkmMWellr4MuvQs10NQ71FB00U+YZAvQeheAcEx7sCh69u+Oje8HdGJD6mm1UpNGWIgEqrdcTRggoKsCPDHB0uEY+RPx+FgaJAn+CcyYEmhWiGTMqIgB/8oloquWDpUq7JIsrUr+vtR4mPx4beGpdUo5HertWsp8skvxMIuUeQXQ+a/AoS2bbynBhp7ajZx16b0hEbTaz5zUxMqopTkkB/dYgtTlBN5+tIKOmzCXKioEju9FLDbOCkbiQ1MVnPVZyoEbr1Q==
Received: from PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 17:39:15 +0000
Received: from PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::2fde:dd68:ed00:9a7f]) by PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::2fde:dd68:ed00:9a7f%4]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 17:39:14 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "taoliu828@163.com" <taoliu828@163.com>
CC: Roi Dayan <roid@nvidia.com>, Paul Blakey <paulb@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dima Chumak
	<dchumak@nvidia.com>
Subject: Re: Report mlx5_core crash
Thread-Topic: Report mlx5_core crash
Thread-Index: AQHaWMpdcYT5/nHLoU6H18IfzoNOXbD+sJmAgAEXF4CAHs56gA==
Date: Tue, 27 Feb 2024 17:39:14 +0000
Message-ID: <6f659353e4fe3070aaf4cb3cab6dd388414744b9.camel@nvidia.com>
References: <3016cbe9-57e9-4ef4-a979-ac0db1b3ef31@163.com>
	 <ea5264d6-6b55-4449-a602-214c6f509c1e@163.com>
	 <ZcHZYbTGHm7vkkpt@liutao02-mac.local>
	 <055cc6cbe8521fdfd753612d6d6d76857550e731.camel@nvidia.com>
	 <ZcRGl758ek_at4Ha@liutao02-mac.local>
In-Reply-To: <ZcRGl758ek_at4Ha@liutao02-mac.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6843:EE_|SJ2PR12MB7822:EE_
x-ms-office365-filtering-correlation-id: 86a870a6-62f6-4579-50af-08dc37bb0432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 O/qn1z0pkhii71qCqGDiM511K10v9jTFLYJ9VQ2rgoi0FLswuM8qQGNOPJh3ohBGEmGsBbORaw5OUq5enX0IgBc5wEgwT+fx173q0o37bxr0H79rOP4pFNk0Wehsf6rOpxY+1B8XcSFQsEZ49vYxXa2JO4ufmvQRm6ReWjd7UYAIEJUCxvAaiXANdXzqn9WhYMXPibwtDOdTLeJnU1tZPDnQCaF33+iFijY6ROgBRJ/nqMVlyhS1XLorkW6LT8Su+OcM+8nYkWbO8KpCixp8c1WZyQZ2fMBf7TZku5G2UcvhwwgBaoWB6byrlfGyPjNjILLyG4JQNUBOX6Z8/ninWNjwADH2TsqBwsj8qs/9mAmQHHSRW1c4Z7nD66hN5Kp/7IoIrK+gqrb+dfQA12qi0SLENiL72Mt5w53BjgrVwGXg/aJ/sfpx4G2OpIpx/B2nVLCbh9E8QIrSs17U1dm5d44fmIVORzTiSInznGYN+jbMj02W8fN0Zq0K5wpGh3H+ucVtUuneh7s9oDAyAyspnIBa7hA/FWXTUlbjWLBLjO5KQ5tqpad68Iy2KJUw+gtRUeYRVUJs34hbNr0c+SK5f/vm4DBpqc2UjV8/aY+xZzZOXVmx6pzvXa8xCzqXScavl/rge9+GD8Un5DEP1SbsIt9PQAY87HVIyPlCgYi4/rYoQrYmWzzKoElCKCWwqlfDSOI95WaXaWjdTDZQXTd3yK1z5zpMmRHq5EX5ninGmf4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDN3NHBjUXlJMDNlKzAzVEJOVUhrVjE4QmJFL1JEWFlwRlJRSG9pd01rb3Br?=
 =?utf-8?B?bmxaaXZQSHpmT3Q2cnB0L2N3Q2ZZcGJ6Z0FiNU95bHlHdkZIV1JxU0F5VEs5?=
 =?utf-8?B?NzdGTVovcmt2OTMrOGc4Tis4VGkwTW5WWjNOR0YydE9sRmxFdE9EMCtaelZt?=
 =?utf-8?B?YW5qQWVmSWJQOHdUMGM2Q0F5T05HZUloaHNnZWl3WXQza1AxV0hTY0JHL1p3?=
 =?utf-8?B?UHY1dVBub0FBQ3JWQWE2TkUyWkxLdVJGYXhCdGlHRkpGQWVjYkM0azZsWVlw?=
 =?utf-8?B?c2JuUTVmU2M1K1ZCOU5sMTd3bEw2emx4dTV5UzF0cGxqdHdDSWhRNWR5bjVG?=
 =?utf-8?B?VXBtZXpxbE5DU3B1ckpJNm9JaEdXVzRZL2ZOdnVERmlBU1A1NlJpYStFR3Zp?=
 =?utf-8?B?SjJtY2hpVGovMTZFblFDdHhkREl2Z0JLQXJZQnJ1VmltVmFMR3B6ZExrS1Zt?=
 =?utf-8?B?azdMb1A5SFNKWXFWV0srZzZYQVlDdjlpemlQS2xGaFAxU0hNUEw0N0VEamJp?=
 =?utf-8?B?elZSRGhYUWt2RUJiTmVhOGJDQU5TSnlRdjBLRmtuTFdpQXh1MU9sWFE2TXIv?=
 =?utf-8?B?SlBLem1iR3QwNk9MZld2bXNDNHBhUGdUU1BEVE0rK001bXhEMmFFWk9XaHBw?=
 =?utf-8?B?Q1YvZE4zU0JxVFgxRzhnK1BtRFFBQTZ3UDMyMXc5R1pFdWtRQnNTRFNnTkg4?=
 =?utf-8?B?RVB3aVVaL3I1VzArYlB0N3l5OFVQVFpveWRuams1azErcVpsMnl1YWkzUy9G?=
 =?utf-8?B?TTNZL2pncExNbDIvTjhIeUl3Zi8vdDBqTmFIMjduWUk3TFRRR2svVXJSa01O?=
 =?utf-8?B?OTZ1T2YxRUlENmVxVzhYdUg2UzNyZUhOQVNqbzRpL3VwdUJvZjNpMzVUeE5C?=
 =?utf-8?B?OU80K3lWNm5HRGFPNUVUVTJPUlpjdkpIUzNzNkh5WjZJcW9USmNVWlU0SEoy?=
 =?utf-8?B?V3Z6UG00aldTOTlmdVlUeGs3SFlPVksyRm1lQjBTY1FnVDdiM3lxRlVqa0l2?=
 =?utf-8?B?YlRxc1hUYlRyWDAxNCt1UWo3QXhNczZIMStYcVpCN3Viamgxejl3cXVKbmtx?=
 =?utf-8?B?Y3UwSTRycWt1S1hGbnNlUkFjRXQwVjQraktsZFFxSWI2WGJOUXVVdU9md3Mv?=
 =?utf-8?B?Tk5mN3VNUnB4aldtd1VoQ05VRURjdkUrY2hobkJxTnc2UUNrRDk1b2hWRVl5?=
 =?utf-8?B?b1R6T2VNZldRbG5GL1JoV2lEK3RHM1BJaHFZRDRpdTZRZzFiS1dRa25EZGtY?=
 =?utf-8?B?d1pWbEd2VUtuQnNmVEpEVW5IL2QxMHRIcTQxM1ZoaGxFZjcrS2VQWEZEVE50?=
 =?utf-8?B?SkFiLzR1TDlJYVFXUzFGT3Y2ck1Kb1duUC82UHV2M2FGNmVIaEdNekFERFpM?=
 =?utf-8?B?Mndlcmsyc1VsdHFBQWlJVG9oQXhHTUdIWTRJYkgzczF1bjFaeWtlRkIvUHJm?=
 =?utf-8?B?cGRQalFLVkg1Lzl2ZnZra0xQbHlNZXlySDc1Uy9pUmdBa3U2TjY0ZVdqZHZj?=
 =?utf-8?B?eEFUWHhQUUh3UG5taytpZDFXNnRRbTR6WHJwd0NPYmtRR1RWck1FaEU2bGJE?=
 =?utf-8?B?bnlweUNYUTVUNWlMSjVHZ0FqaVJPdDI2ZTR0bVR0VmlaMElPR3pWWFJVajkz?=
 =?utf-8?B?RFhrM0JFR1NPMld1akFkQzcrOEhJZFhoWTRqdVRBRzlUaVIrMlRuWENpWFFw?=
 =?utf-8?B?UnlwZE13dWxDNjA3OFNUYjVnaW1Yelk4NS9ZUW1VTFpEeE5ZUlZNWlBTbmpp?=
 =?utf-8?B?Tm1QTUpLOE8wR0lST1oxckloTmxWVENGWjFaWHdlRlBxbktDSE01WTdQNWxo?=
 =?utf-8?B?Sk1CQVoramNKTXVVN1VWMlhjZmdBd2RDZkkzWkI1YitJaWY2SDJKZm1XdGxu?=
 =?utf-8?B?bTVwdDRpMjFqOXBRSG1BN01tT3dqM1Y0aFdTZ3BmVHpZV0hvckRBcjcxUXEz?=
 =?utf-8?B?WllxY2JwUUlIWmlQVkRGWkpON0FMc3M5b0pDNko3NTZ5N2xLNjlyUXJVTTFx?=
 =?utf-8?B?ajQvSmdvaXRXSlFPVktUbmNuRmZtV0lsN2Z0RmNtUHJHby80RmdRc2NpQ1Zj?=
 =?utf-8?B?ei9uRUZhcm16L2EyQkw0VWhzTkJwZGpZblNGNTZGRmVMb0g4WlVYSGZ6NTRP?=
 =?utf-8?Q?1569NvCUm7Tfv94pQpaNx2Pkb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25B4C9FE6C840049B1CA949240060848@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a870a6-62f6-4579-50af-08dc37bb0432
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 17:39:14.8498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wclDK+LamY5tY+Ey01cZM3nDgc+w+DWD4GWynyQfO7dqxQfjdQmm5e0zRzFmrQRy93RcT8pCsWU7G2UpKMt3hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822

T24gVGh1LCAyMDI0LTAyLTA4IGF0IDExOjEyICswODAwLCBUYW8gTGl1IHdyb3RlOg0KPiBIaSBD
b3NtaW4sDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQo+IA0KPiBJdCdzIGhhcmQgdG8g
cmVwcm9kdWNlIHRoZSBjcmFzaCBkaXJlY3RseS4gIEluIG91ciBjYXNlIHRoZSBydWxlIGZvcndh
cmRzIGlwDQo+IGJyb2FkY2FzdCB0cmFmZmljIHRvIDUgdnhsYW4gcmVtb3Rlcy4gQW5kIGRyaXZl
ciBjcmVhdGVzIDYgbWx4NV9mbG93X3J1bGUNCj4gd2hpY2ggaW5jbHVkZSA1IG1seDVfcGt0X3Jl
Zm9ybWF0IGFuZCAxIGNvdW50ZXIuDQo+IEl0IHRyaWdnZXJzIG9ubHkgd2hlbiB0d28gKmRyX2Fj
dGlvbiBpbiBzdHJ1Y3QgbWx4NV9wa3RfcmVmb3JtYXQgaGF2ZSBzYW1lDQo+IGxvd2VyIDMyIGJp
dHMsIHdoaWNoIGRldGVybWluZWQgYnkgbWVtb3J5IGFsbG9jYXRpb24uDQo+IA0KPiBJcyBpdCBw
b3NzaWJsZSB0aGF0IHdlIGRvIHNvbWUgZmF1bHQgaW5qZWN0aW9uIGluIHVuaXQgdGVzdCB0byBy
ZXByb2R1Y2U/DQoNCkluIHRoZSBlbmQsIG5vIGNvbXBsaWNhdGVkIGZhdWx0IGluamVjdGlvbiB3
YXMgbmVlZGVkLiBJIGp1c3QgaGFkIHRvDQpwYXkgcHJvcGVyIGF0dGVudGlvbiB0byB5b3VyIGF3
ZXNvbWUgaW5pdGlhbCBhbmFseXNpcyBhbmQgSSd2ZSBtYW5hZ2VkDQp0byB1bmRlcnN0YW5kIHRo
ZSBwcm9ibGVtcy4NCg0KSSd2ZSBhbHNvIHByZXBhcmVkIGZpeGVzIGZvciBib3RoIG9mIHRoZW0s
IHRoZSBwYXRjaGVzIGFyZSB1bmRlciByZXZpZXcNCmluIG91ciBpbnRlcm5hbCB0cmVlIGFuZCBz
aG91bGQgaG9wZWZ1bGx5IHNvb24gYmUgb24gdGhlaXIgd2F5DQp1cHN0cmVhbS4NCg0KQnV0IGZy
b20gdGhlIHN0YWNrIHRyYWNlcyB5b3UgcmVwb3J0ZWQsIEkgbm90aWNlZCB5b3UgYXJlIHJ1bm5p
bmcgd2l0aA0KT0ZFRC4gSSB3aWxsIHRhbGsgdG8gbXkgY29sbGVhZ3VlcyBhbmQgbGV0IHlvdSBr
bm93IGFzIHNvb24gYXMgYSBuZXcNCmJ1aWxkIHdpdGggdGhlIGZpeGVzIGluY2x1ZGVkIGNhbiBi
ZSB1c2VkIHRvIHRlc3QuDQoNCkNvc21pbi4NCg==

