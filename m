Return-Path: <netdev+bounces-61982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42AD8257AA
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 17:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E02C28273B
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FC31725;
	Fri,  5 Jan 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XAiFbGWj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF0328B3
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9dnjL6bhYN9wO5+V1cks3zKlATept6g4pt28Vm1uvgaSaFtCO5EtkPB8XC3T6iZHrQtJC2zNFS/qVYYIQmsfraiZNasjOkVLRGI3yPxkpnsoqE3DAl5pt7cCMOIED60/Kw6BrtvD9TWtMjL1Pe8yXLOWHWKYuB9jjx7GiG9v7zHQVTbrEGbcAYGitpcLiWjSCSY2Yk4+IsYGwQs9zQTaH6EAsYPAXX5JCV+DtF5/iJ37OV+oURlAf9vXPrHk95Modx/YZByzaHEDu1k9gAcGjHzQlUGg39antLqg/piQfFJjEbtt4y50MIv4WXcIYkoIEsv+Rt8qHRZEuxF+6shpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhQma6p8gN1iXykVu2WAqQuf2Q0+JUrioSWymQORfbs=;
 b=E+YaWnSk05MOqsylUJvRHiLlY2ydglFH777Orw8+eG5udBEvDPcrtmEOLeuKm8V/jnEU1sf4F6X3lVLZKwRPCDriRPwZY38VKOc9mAObjMJup1lXOPZjR2GgvuRrujN5ZitqD5vah+XBf52iScT8ZR8Prrj9jB1Hqalrafcsonnxs0wRp6SkBmgP2on/kk5M09n0P9MozpIi9zavl6r8VsaMosKtFiYkiwSz5DXfWPBJYzOxyDnf5sP0LOG3YtpQy+bEryb4TrM6rzYZPCZdO4Nu/HiINhL6eQWBabBagoqCP9XinOO8bSz290f85i4spnKtyUEAhlCxKlADVPdxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhQma6p8gN1iXykVu2WAqQuf2Q0+JUrioSWymQORfbs=;
 b=XAiFbGWja2OaX7GFH68BXHBh3MZojXazV1L98cn6rfdd5pq8XLD7PMZYsBPNDH5AAjy3fxL1s8V1yYf38RcRvmPhbpGOmOjOwL8FGnPu7IMn556gLk1L2S8pd5qahNPDsKWUUygY0vbxlPUBx3c2LtMoiJrhXcnc+htWBv7wh+SlFqXTrzsTMyPT5RJPxIBT1xrF8SrVjy4SIt6zJd0NGhjsyIBy2drPd6KmvTRn3HlEK0LC1X/7uHSsIoxbYAnGUYM3kHETWMfYa4SEeZFNTUajT2F1m+WaJgDI7kJi6xA86f+5RO7x/v6geGCTwXZQyDFDidMDjwQRb7CkT0/VxQ==
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 16:05:47 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 16:05:46 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: RE: [PATCH v3 1/3] mlxbf_gige: Fix kernel panic at shutdown
Thread-Topic: [PATCH v3 1/3] mlxbf_gige: Fix kernel panic at shutdown
Thread-Index: AQHZ7XtbKQBMq7gXmU2r8HgR2iQihLAnHeiAgCDSUDCAhBZ1EA==
Date: Fri, 5 Jan 2024 16:05:46 +0000
Message-ID:
 <PH7PR12MB7282BB0D130E7A1E80B72ABBD7662@PH7PR12MB7282.namprd12.prod.outlook.com>
References: <20230922173626.23790-1-asmaa@nvidia.com>
 <20230922173626.23790-2-asmaa@nvidia.com>
 <64a2b71c-f3ee-4a95-a2d4-79d2258a70e8@gmail.com>
 <CH2PR12MB3895A1CB1D3E148E6707BE2DD7D2A@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To:
 <CH2PR12MB3895A1CB1D3E148E6707BE2DD7D2A@CH2PR12MB3895.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7282:EE_|SN7PR12MB8604:EE_
x-ms-office365-filtering-correlation-id: d8593fd3-0c53-42db-f178-08dc0e082d77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gXyE5flZYwHtKUMc8x3Am5kw+3YvVfV4dtan9CT4PSdXs7B66VbgHkTeuKynUPVrxmQ3sEzMEJiT1z+sDNokzFfTTq+KhHDU7DW9M5BKLIYUbIvdSrW0WYtZIlJ6pygbobsRLRaNAwRnrXRx4FSXFgVeh6dSiZmS6H9nKsONFEND+LWhvX4hsepaSTAg3owo8xwMT4FTZAHUDdrP4hRs1eHCvA2SSKAwOnM6+q0G0an5AW6qn2ZLnMJj5gCSllMRyylYhfwOx5LYKtGJ882+plUt4/DV1x0G9xntz7qp9MXvvrqZb1xk5ACxAebyk1sAubdAaia0JxNBggFCP0iuoZyORErplU4ylesZ5j3m6f0oORQUvZ6ctrNhP1/MXt2b1WIJk/0JifUFa2X3uqDSIM/eej392zVG+viXyd86PVQWrG0Z5yikBwbnmSPB0+cVedq563l5oCdyXynH04EcflF0WtJ3c2dcCAKzx5UT+mYAiHOHEGfk2TUV1/BpdBCIZ5t8P072v90ciOxQP11O/Bu0FnRUGn5uPwhMvBJFADv14ZmFAHKbwjuS9Kf0whmZ+gwPf+++w4W2f8JQdudUDu4gVxFRIUK0ksx8BFOo5CxwhzMjg6Ft5ix1m3s+CHev
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(41300700001)(5660300002)(9686003)(478600001)(6506007)(7696005)(4744005)(2906002)(8676002)(4326008)(8936002)(52536014)(38070700009)(316002)(76116006)(66946007)(66556008)(122000001)(38100700002)(71200400001)(33656002)(107886003)(66446008)(66476007)(26005)(54906003)(64756008)(86362001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K01odks0SW8wL0tXMG8zRW15OW5kTFJLUzNXVVZRVzNycVB2QlNpaTA2ZVpi?=
 =?utf-8?B?TndjanViTytWTy9IUVpidG81RHN4TmJYNG5QZW5RQkt3bUpvekFmNFo0YXc2?=
 =?utf-8?B?eXV6Q2VHbGVUL2Y2eTVLWDA3OHJVRzVaa2R4RzJXYjk2dGFZS25DSjVzWXBV?=
 =?utf-8?B?QzJTalAxUklUSUtvajJSRjFmYzh5QSs2SkNIMEk2Q1J6R2cvYUFUZm5HYnUy?=
 =?utf-8?B?cDZuMDlCVStLVG10Rm1sTkVDUHpIQ0VWRUxBSGtQQ2JVNk8vZ3BxVmY0Zjcz?=
 =?utf-8?B?cExVejJIUHJ6c0ltSlhydk9ud2s3OUVEeElaa0VZZVlVTitWUHFXMWFiRVVU?=
 =?utf-8?B?SDlVWVRUMHBPMFkrdG5yUVNNRUwwNEZsODR3NE1YWDdsYXVTZElGZ1p2Nmhh?=
 =?utf-8?B?MEpOUmNPN25OSS9zNW5NY1VZNlN2SWVlN3VUQVdyUjI5bTdZekgxeWl3VXgr?=
 =?utf-8?B?Z1lsUGdYcFZDdzM3OVN3MWJkUmVkUitQb0xCQ2lBR3lEenBTVmk0bnhlUW1r?=
 =?utf-8?B?aW5KSDJuT3FhZHRBdFBPZWdNMTc5SlhMMXM5TTF2eTlIM29qZ3owLytWWkhV?=
 =?utf-8?B?aXJRZU5mUWV2QmtsMjJPTHNnZVhRUU95T0ExK2JibHI5MHRyM3J2OThZaDFZ?=
 =?utf-8?B?VWJCVmkzZXRKQjdwYzJmNHF1Q2d3anhNUXBRSzJ2Rk1MREhkdktwei9Idlhw?=
 =?utf-8?B?dHpnbm9wejhZSGtVdDhvcWpaYkZwNVdIcXBjTVJmYXRSNklkdWNibi9wM3Zy?=
 =?utf-8?B?VXhwY25yc0I5c2dGYWcrZzRrQWlid2VlbzJyZkRqeklmQzRLeFZvdXVNZkdE?=
 =?utf-8?B?VWthOHovMEVDT0pldnlvZGZ6end4R0RDWk82SndOVU9hVVJaYmRReUJWTVVR?=
 =?utf-8?B?RlFyU3V2WkxVaGZDUURJY1VzSG9sdkRYNG5iL3ZLbkYySmlicldNbEtCYito?=
 =?utf-8?B?SVBvUTNhUmhSbllWT2Q5YmwxOHNpT2dSZVlsK1FIN0YvdTUrdmRVOXZ5bmw0?=
 =?utf-8?B?bmxMRFZnZXRITFhpSXI4dGxnb1kzK1greWl6aVg2bkVJMmRxNllBNXd3ai9y?=
 =?utf-8?B?ZjlhSU9pMDR6U1pIRGQ4T2ZSeW0zV3hjTjFvaCtKLzJxZzBoOGZBelJuSTdz?=
 =?utf-8?B?VzdXK2hTdnJtWDJrWDNyVDBrTEFoTENVdGNPZlMva25taVovVFVLZkFFcEFO?=
 =?utf-8?B?S3U0eTlDTitKd01lY3U1MlJnclpQSm9CT3M5U0pMcyt3QmZWTWNSWklyNGhv?=
 =?utf-8?B?bnJlQm5LQWdqZUFKcVVTdUZoZC9Jc01FZWVpYkFGWkVaY0lZVWRqOWFHZ0FV?=
 =?utf-8?B?NDE4TzFlSEhDSVIwK210aXY0aGwrV1NYNHNScnpYaVFrWllxMkZnbmRwbThz?=
 =?utf-8?B?Z2V3OFBaeWYxSWl4OHZxN1RlRFoyWVNick5CT0s0NXRuK1piMXJGSG83djVq?=
 =?utf-8?B?N3dWb2dTMXZXbVY2V05XbEUwcG4rbGdZRDJPbTVRbFJVd3pQcm5RemI2Q3dr?=
 =?utf-8?B?ZHBYbkE3VkRuckxXMXhVYW5QSnVsamQ4WERqZzVYRHVrOCtUekdnVlozUWht?=
 =?utf-8?B?V2ZDRjUvd3FmQ21BS0N2V0xlaGVNSW9hczFaZVpoUEZnTVZRaS9YMVdieGcv?=
 =?utf-8?B?TWJ1OTYxcTZ2OEFhUWlwS21SWXp5ZkIva09saC94ZWRyaVpZaWREWFFOQjUv?=
 =?utf-8?B?NFdza3hlTEhjUXR0bXgrQjZub21tdU1KUE1uTzc5NWFkOGpQOFNLY0lVaW1P?=
 =?utf-8?B?RWk5VVQveHRrWkRtRVo3K0x5QWloZlFmUmc4cnlISHJCRXVuY29vcUd0Unp1?=
 =?utf-8?B?VzRVTFVoVGNWQ3ovditZeWIzY1lhZFcvNGdvMytxQ205Z1hBK0dXNmg1UVow?=
 =?utf-8?B?QWowUE9uNFF0NDJlUHhLS29BOXJpa3EvZjJDcGR2TURmcEhEd2N2bUllZCsz?=
 =?utf-8?B?VjRheTdVaThCbTZ3cUxCM1hQWkUzVC9vVVpjek00TVF6dTFRempoZjZtZG1Q?=
 =?utf-8?B?anBWWFZsdWpDKzY2VFZBQys0dEVlTXN4Y2FYaUgwY1RFRGdpbzArSlltcENv?=
 =?utf-8?B?T0l0bGZWRUg3aUNqNE9ocHRXbC95YW9QSVBZVWtNUVdmSDZSSjNPbDZrWCt2?=
 =?utf-8?Q?QhBo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8593fd3-0c53-42db-f178-08dc0e082d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 16:05:46.4608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8HeDHaMPxlTy2sCOuxiRWQvgLvOGqLz3oueopxlSy8l64vuWPU9NlI6PWUo1XnJpGI5tm3kk++r1av/xhhSZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604

PiA+ID4gICAJcHJpdiA9IGNvbnRhaW5lcl9vZihuYXBpLCBzdHJ1Y3QgbWx4YmZfZ2lnZSwgbmFw
aSk7DQo+ID4gPg0KPiA+ID4gKwlpZiAoIXByaXYpDQo+ID4gPiArCQlyZXR1cm4gMDsNCj4gPg0K
PiA+IERvIHlvdSBzdGlsbCBuZWVkIHRoaXMgdGVzdCBldmVuIGFmdGVyIHlvdSB1bnJlZ2lzdGVy
ZWQgdGhlIG5ldHdvcmsNCj4gPiBkZXZpY2UgaW4geW91ciBzaHV0ZG93biByb3V0aW5lPw0KPiAN
Cj4gYWx3YXlzIGdvb2QgdG8gY2hlY2sgdmFyaWFibGVzIGJ1dCBpZiB3YW50IG1lIHRvIHJlbW92
ZSBpdCBJIGNhbi4NCg0KSSB3aWxsIHJlc3VibWl0IHRoaXMgcGF0Y2ggd2l0aCBhZGRyZXNzZWQg
Y29tbWVudHMgYWZ0ZXIgb3VyIFFBIGhhcyBkb25lIG1vcmUgdGhvcm91Z2ggdGVzdGluZy4gDQoN
ClRoYW5rIHlvdS4NCkFzbWFhDQo=

