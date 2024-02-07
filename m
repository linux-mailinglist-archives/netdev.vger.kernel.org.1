Return-Path: <netdev+bounces-69778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A871184C8BD
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C0F1F241A0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE75802;
	Wed,  7 Feb 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dAiG8MMo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C267168DA
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302014; cv=fail; b=X0lD+R5jPbM4ouY+mNz0KUG+lcLqdRifQ6XEvER9X5BqsT9x89jjThx1j5vpxkNyGu6koC25RN5XzHl2zrOEJUqTfzNGE2OtVBLGWAERtpLElkYChoUKe88h1nfx+zsq7WpsqKixbQMYAoBosuFgQPlWQ15PQ5QTYfuWZfHJ1IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302014; c=relaxed/simple;
	bh=6KR1CKM8v7qpRLVZCMpjUkbpvJyPvAKyEpQ7fMITzcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PPoAQH3YvLPGSIB6zJHTziozbTYei2vjF1HMC4+gb/ilzhTTV/CwXqjC08IMmy2Y+fY/R2Kr42GqjgtA4LjE0GVyEJ7p4hI5cwZB+PNYOngzWAhgBGnt/8HEEJR+WcK7n5VGhx6pIaEwC2txhbX43F0IjeKCzi9C2nqwalWS3iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dAiG8MMo; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXIb17GDaU6MdYpzq6XUlG5Jpo3GQ6DiHBP6tQ8+vhVkcfZnePMz0TzrmaF+YmoWIyiNgCUJMRJEs1KhM9NgDzS20WryZHLL68umdGfvZNRzKlf21Z6T6NpdkKektS0WuFNYrq8RYaMz3k500zZoil1SJVSCTGXDxtr5Z6cJ7KBaB/uE4gjCR2tFqCRMZAqAaE2LD+iuIwr7nJuYm4QdiZG2QS/qgCwn/u4OCtMJWA1Ku8/zd+w06OQP5SEbBS78Zo94Nj7iEQQ57oTk8Scd7KD+wNpIEwNn6e/y1E1+q0oDuj34n7GVCVQ02doWl78ZQ5MDu0csq2Lnabd96/dppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KR1CKM8v7qpRLVZCMpjUkbpvJyPvAKyEpQ7fMITzcg=;
 b=SYgaBbnjUZgFbhvC89Vinh+EqemniuOmXAm0ZpPoPiMAbZb1rFYz8jVdpYhEQW2N6pKfo2WeXlOEx/eeyE4YogcA0sJzfTvG++Xm0DUTyiecwtK9C9594AUgBMT9xC7jfJWVxQ4BkvNwHHsuCMwY6iWNBcpgyS5rH5zbwj8RWgceuaaEXOEjxf5ORshmdZyd/blGu9F/L6Ng/qrtxw88drny458uVP2D7YnrCa+rMy8jW/NP69Wdjeni9/vTBVdSdlLAYVdyNomTua5pEJyqbI0ppxtQpiPN9L1cpN7mtufgEOw1rqyzAYlAIzyitYbruYdKL4WVIAgVVc75HO6DGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KR1CKM8v7qpRLVZCMpjUkbpvJyPvAKyEpQ7fMITzcg=;
 b=dAiG8MMorPK9M+HVXJyVBq0deGPCsE8N2a9hryh5qI75YOywykK9zt/2fG0rhRNoRbrwESGEAHoLTrCBbD2ZE5ScyOYp7nFzLW3K//3X+VuTkEXkdtmYJ6s2I0r3WzR+mqI1bMHq98l+TRYIM/B1ioFrjUjRwP4XYlFl4SlV9sdBv+NzrTBJ9/SxfQ9gDmpJzireLXPCo3u1LwXcghlyaNzE32U5kn2nSxeFheG6fN7edtYH8w/EL441yFYMp19yyL7HuAtX0KMtwBkq4uFDcKVBjC32A00YyDf6rI7kplnpYlTxGRCyBo4NXcN4Wepap7RSIGzZvdpmJvO9++L0Ew==
Received: from PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 10:33:30 +0000
Received: from PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::30d1:29a9:2d5c:7540]) by PH8PR12MB6843.namprd12.prod.outlook.com
 ([fe80::30d1:29a9:2d5c:7540%4]) with mapi id 15.20.7270.015; Wed, 7 Feb 2024
 10:33:30 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Roi Dayan <roid@nvidia.com>, Paul Blakey <paulb@nvidia.com>,
	"taoliu828@163.com" <taoliu828@163.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>, Dima Chumak <dchumak@nvidia.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Report mlx5_core crash
Thread-Topic: Report mlx5_core crash
Thread-Index: AQHaWMpdcYT5/nHLoU6H18IfzoNOXbD+sJmA
Date: Wed, 7 Feb 2024 10:33:29 +0000
Message-ID: <055cc6cbe8521fdfd753612d6d6d76857550e731.camel@nvidia.com>
References: <3016cbe9-57e9-4ef4-a979-ac0db1b3ef31@163.com>
	 <ea5264d6-6b55-4449-a602-214c6f509c1e@163.com>
	 <ZcHZYbTGHm7vkkpt@liutao02-mac.local>
In-Reply-To: <ZcHZYbTGHm7vkkpt@liutao02-mac.local>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6843:EE_|MN2PR12MB4389:EE_
x-ms-office365-filtering-correlation-id: 680532c4-472b-437a-4fbc-08dc27c83a08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LTxCsrHRtlMUq8mHt3n2KWP60eOn83qE1EDO5aGMnPP8PTK2Brj4xhbgCgc9Qm8sPyYBWe3GBb/gjHzR1P2uzg9tGakdjMBlAfuZaowDGwpPyCZ6q6MqbjTaTQm0cLGCTAOB49UbJBH2QwRf9vrFcZHjtKLr5lbyoLawSXcNaEeT/imgSzA5UFQ0IXdWSCH1c+ZA9nojK4D9z/8oBVugmAmXLS5zkeaJWeJ16josdj/0m+XpacPSsqkaDKIhAJnwPhRZrrVpsYV0AHbdxTjzX61E6LrmF/BWy3CGdOjHiHJ99udFoGKS0zXyAxiy3JnYUn9oQWX0ukaR0/gOjpjCPmjQ/6M/zJkg7Ch7qEaa10TmdY/Gu/QVsYVbr5dTELNwYhevcyWuHaYqgzPwjVj/1YMV4h09z59sSsBpsErC9KJnZrfEHNnZTQFYH8N1ZYwEKD4eNwxIh9XcEOhyK9hC6QAVZP1CAP2LsqtxG9o0MB6Fu6eHAqJBoIGLBpQ349Y7NpDoz/nNTj3UPcoA1Mpn2nkK3aD7XEFJ5pqL0O5jH0mrLMspFRuSrI4mo1zl0LscjdThNjBrk2M5Wb0wPitiUZ7NZT1UJRMs1z6oRWrBQt0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(36756003)(6636002)(478600001)(6512007)(55236004)(38070700009)(6486002)(6506007)(41300700001)(2616005)(122000001)(26005)(4744005)(66446008)(76116006)(5660300002)(7116003)(4326008)(2906002)(66556008)(3450700001)(110136005)(71200400001)(66476007)(8936002)(86362001)(64756008)(316002)(8676002)(38100700002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b01wS0JQRUlEMTd2SHdNSHdRTmV6MUd3eUdXSWNnOU1MdDZzMzhSa1U1TzZC?=
 =?utf-8?B?UHNjekVSMnYwdElza1QrcHEzWFlINnIyMVo1d2t5VEhwcEJtQWNoVC9jbXBR?=
 =?utf-8?B?a00wd2gzV1VUa2FLdFY4R0dXaFdWRGZxWS9xc1lxQ0xKS24wa0JZMkJUbXZT?=
 =?utf-8?B?TjlxaUFGbWk3bytoVjlPVTVaZlBpM0V1NWJOa2wzZ2hvSWlQQStSY1Bsc2t2?=
 =?utf-8?B?Vlk2c0dHOE43MDgvME96bjdjOTJkR2dBYWhpNU53U1pmSnZkVEVNNzVkMnhG?=
 =?utf-8?B?dC9SRDMvOG1yamY3amhJUE8ra2NZSG53VXpVQmVKY2lVa3VTUkRwWmNoOFlx?=
 =?utf-8?B?cGlpK2xpUXpaSEVza2ZBZDhkK2tZV0JOek84Wjg4TlRFSjIrS2hGOElOcWhz?=
 =?utf-8?B?NGp6eFFSNmQreDBBTHpTeE00UEJkM1Fveko0WTJTcEpPbXF5d3dXbnd3bEdO?=
 =?utf-8?B?RVRtSlVMWFZvYXJZb29KaUI0eGpvZEdtZzhzaTlqaG5NMDRaVXoxbGgrUnpH?=
 =?utf-8?B?Y2lxRDlwU2pKSDN3QWNVYUZ0eFNkL2I4WG5PdllCMVpyTzJZVzJ0cDAvN1Av?=
 =?utf-8?B?S2E4TDk0d25jc1dHeXhFMkRQbitwZnIvbzg4R0pVUE5RYWdUanZXYnpHalpy?=
 =?utf-8?B?MWRteGZVVXRTazFYUVQ0dFJxWkJZdlVTNjZjRFM2clJJMmYvZVVGdmlwODhi?=
 =?utf-8?B?T3ZtdG04d0ZWQndudXJVZEIxU2tuaEhTYXZuWGRHbGFpcE12WGJNRWNDc1Jh?=
 =?utf-8?B?UWh4WElBb2RzRlhaeVJXT3U5bEJnd2QrbEkwYXBpK0VqdkZQOFBqQUZ6bll6?=
 =?utf-8?B?dWg3bGpOaGd0amlUR1ZKWDNRQkFIVjlCM3lRN1VtZnlYVkY0NlB4dVhkV1dq?=
 =?utf-8?B?SHJ4Rk9GcU1scGFIRThGTzNhZEZsWWFtdG0yaDRTQm5pb1ZnUTlRRW9ucm5L?=
 =?utf-8?B?UGluVkJ3OUNqYzJMTmRKd3NOaGxqQzRXRzBFRXNpTCtoNFZ3dENZS1NKMFZi?=
 =?utf-8?B?VmU1V0hZQlhLYkNlUzl5bFlTQkpNSXpQRitRYndKZGRXL0dJSkRodDhZRjVi?=
 =?utf-8?B?c05WZzdMTXE2YkoyeWJJd2xKUUlRbVhrZlhmZGgvY1BibW5zeTNYYTR2S250?=
 =?utf-8?B?c1NTV0RkNmNYSkg3dUlpd2lVSzhJYWloK0FmelJ1NU5HQXN6UEwzOFI0UHVz?=
 =?utf-8?B?TlpqSFVFS2lnbnI1Y1I2azF0QXdUMVVZS0k3SE1jVS95OUJxYTc2S0dCQWlu?=
 =?utf-8?B?TnVQTkpxV3BnYm82ckppK2syWkIzTk95LzhUdnMyYlNJRDdDTnFpOGhSYzN4?=
 =?utf-8?B?eUxVOUFuS0RQRk9neFoyQXFKL1ZHYisyVTljaFM5SktQZGlNVGQyWERXQXNW?=
 =?utf-8?B?aEZWdm1DU2hBR3gvQVkzU0pIamZIdjg4a0JEL3hZT2U3U2M4ZnVPYyt0Q056?=
 =?utf-8?B?Zjk3Nm0rMXB5dE5VbHlFazZxTWx0dHpUYnk0TWFUQnFUQ0JuVTA2U2J3UGFI?=
 =?utf-8?B?THhhTVorYUh2SVIvMGkweVBQMlRVN01kZmVud24vSFdYZ3E5cTUrQy94bzVj?=
 =?utf-8?B?RDF5blBEQStWRTgrTUgvZ3RHNlZEY1Bnd3pSMnJsU1d3d0NuaUtrQm9tUlJr?=
 =?utf-8?B?RXBjczJ6VFRLWndyUUE5c1NuZjJVd1REN3FHd0s4V2lGbytUaDBQZHRQbkht?=
 =?utf-8?B?VDcrbnJ0cVM3TnEzbklrNDA5ME1pWnJ2azlnWFdZNDdVQUtSQUozVFRuRmU5?=
 =?utf-8?B?dXhhQ01lQjVzUXdHN0pTY2RxcEdkUDVwTGdXZTdhdzlReGZrL0xpb1RoOHdq?=
 =?utf-8?B?QUJvd295ZXovbVdGOVdEaDZ2ZkxHR3dBQ0toRXVJcG4xcjNMS2hEWjRrT29q?=
 =?utf-8?B?RTJkNDg5empEaWN5aHBVbnN2QlZrUjl2bmJqWk9lS01MTGY1c1d2ek9zcUdH?=
 =?utf-8?B?V2VCT1NGdzdRRm1QNGtDdHlieDN5MVUzT2pZb1BVRk42YjhRd0JJTHY1citT?=
 =?utf-8?B?R0p5RldwaDJjVjYrMy9qZkN2TEIxSkpMVGNNY2FsUW9ZdEJOODRtSmlObTBR?=
 =?utf-8?B?NkJuZWIzSHBpQ2IvRzZXS3IzTFh0Um1XYkxIYUVtbFFoZTdkZ3dTWStPdUh6?=
 =?utf-8?Q?XMk7c58QAz29U/fUhA8aYjIC1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC185A6AF109C74F8CE0E11E92E7E5B5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 680532c4-472b-437a-4fbc-08dc27c83a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 10:33:29.9860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDy/xwwuIg7E3rsTs9R0JjrwCEXSggDgcfHPl0Wxya3boN0C6nCM/JHLN5tQIYo92bBu1EjtuPlqz0nMNV0x3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389

T24gVHVlLCAyMDI0LTAyLTA2IGF0IDE1OjAxICswODAwLCBUYW8gTGl1IHdyb3RlOg0KPiBPbiAw
MS8zMSAgLCBUYW8gTGl1IHdyb3RlOg0KPiA+IEhpIE1lbGxhbm94IHRlYW0sDQo+ID4gDQo+ID4g
ICAgV2UgaGl0IGEgY3Jhc2ggaW4gbWx4NV9jb3JlIHdoaWNoIGlzIHNpbWlsYXIgd2l0aCBjb21t
aXQNCj4gPiAgICBkZTMxODU0ZWNlMTcgKCJuZXQvbWx4NWU6IEZpeCBudWxscHRyIG9uIGRlbGV0
aW5nIG1pcnJvcmluZyBydWxlIikuDQo+ID4gICAgQnV0IHRoZXkgYXJlIGRpZmZlcmVudCBjYXNl
cywgb3VyIGNhc2UgaXM6DQo+ID4gICAgaW5fcG9ydCguLi4pLGV0aCguLi4pIFwNCj4gPiBhY3Rp
b25zOnNldCh0dW5uZWwoLi4uKSksdnhsYW5fc3lzXzQ3ODksc2V0KHR1bm5lbCguLi4pKSx2eGxh
bl9zeXNfNDc4OSwuLi4NCj4gPiANCj4gPiAgICAgIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDI3MA0KPiA+ICAgICAgUklQOiAwMDEw
OmRlbF9zd19od19ydWxlKzB4MjkvMHgxOTAgW21seDVfY29yZV0NCg0KSGVsbG8sDQoNCkknbGwg
aGVscCB5b3UgZmluZCBhbmQgZml4IHRoZSBwcm9ibGVtLg0KWW91ciBjb3JlIGR1bXAgYW5hbHlz
aXMgd2FzIHZlcnkgdXNlZnVsLCBidXQgbm90IHN1ZmZpY2llbnQgdG8gZmluZCB0aGUNCmNhdXNl
IG9mIHRoZSBjcmFzaC4gV291bGQgeW91IG1pbmQgc2hhcmluZyBhIHNldCBvZiByZXByb2R1Y3Rp
b24gc3RlcHMNCnNvIHdlIGNhbiBkZWJ1ZyB0aGlzIGZ1cnRoZXI/DQoNClRoYW5rIHlvdSwNCkNv
c21pbi4NCg==

