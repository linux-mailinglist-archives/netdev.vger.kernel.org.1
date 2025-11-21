Return-Path: <netdev+bounces-240700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A69C77FEA
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 566074E55CE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB02F363E;
	Fri, 21 Nov 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDBj18+G"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11B22A1D5
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715107; cv=fail; b=qCQ3CJcRWVzHph0fdx40i/I9niWDYvtjEJC/i8hpMhgAqjYZIT792/bLrBEvYmzh+CGDbFEFx6VMPoVt9GyAtr75ylRp4YKQJcJKP16tUeIEvgOw38zUQYW9fucB51dWHQ4E4McXacef4Vnt6HXAJIKNe7/eN0wRlz9Ye9IQg3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715107; c=relaxed/simple;
	bh=kURbqG287N9KrxfAWygkFqdE2g0oWbijO+WStuF/wNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pESlL2YGd+WtFCqNnLfVb7T3c6aUEz4sznXSdSOqVsvu4l/8UsqoyBfbJl+7t4P6t3lGr4cBJpz7zZWmCOzyzA4TZtSSfL+UEAGxjMEF+aXWHLW71Dr8kNFdbcvg5MdPvD0si0Iz9RGwvPVF3iEE+5eqKCwf/058aCzUzaal4sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDBj18+G; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hht6cWNQhMq1r/qeG2m1zVudQQnOCneVXFvDZY4cGScDAryVJwuvSM9GZiBiz0bTR1zlFRu1enw8zSFSCsqLfAYlEe3O+Oi25nXoU3kBuzwv0S0iE/y2y1Ju67bFbyzohYPskr+pqN99wrUedDXYnWenX+4JE4cFCWgd3xnyYQrvkv0gJXg+zbI21TYrjEQhdt3+5zqnf5a5YIIrCpzoGeEG13WJ5GnAjhhVPrtr8Us12x9vs0lbwVxkFN7qIUcJxAvxoUKp9lwsWKYQNBotUOQJt/SIQkZH0JaTEqW0PbEcmDlTAtKKlwIGUAzbe/YJ15yyrFYM7AvpGKmv5Owxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kURbqG287N9KrxfAWygkFqdE2g0oWbijO+WStuF/wNE=;
 b=jeR51q6nDWhLMVZMqiRIoOWf7xXW9VhC1jITHwtnVuiR5iVcmnlX1Z7qFcFONAOFb6/nlfzSQNtCJujjv6SaKS7qElQb0cpbWAZtSK1qbyf46119J+mvyCKW7/s5wuwtbsCo4Jt17WYP68YY/gAVBtpGKWwXgI1FTUM2mA2K+7xkUJ8SGuUowE2g38dQLeTVAJv53EuAscaubg2CPRORkEmDAPignBYo1nniVjpgPiBY+mPk4ZdKfHK+SaxRoMIDTBpLQifYeaYY98qp4jqlodFaRAPnsacPU3FbY6aW8B/7zter3VDiQN24oWCmV3I5cjcvzUONpk6UabEY/H89rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kURbqG287N9KrxfAWygkFqdE2g0oWbijO+WStuF/wNE=;
 b=SDBj18+Ghumulb2rqESvB+yzTZPhuiQDJbpkqeO7iJbRB4/AW/UtvBLE4BPIMfOXy0/n7laAyFlBC/DpiMgBO4hab6hYgs0cy02oU7F9dZOvtjJmmhJ25Eo+hqFNC3GBnrRtYqVXd9iSozfGXOtGKWyK2UEUC+4df2oMSG1XpIl6rc9t34T3phKxyFduqIvJttqp3rkN8qoVd920Xi/NOXGZpbDSc+WYcI9KSsCS8iPYOL7/jcHuSugUwmOwW39V9WCAqXroKqN9fcl9Jbz6XCts4r9zOdXLjcYMnvzhqTDsRko5DK20Z7q+crJJ7K8vgNuwx23P/bPOiJryAOMnPQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 08:51:43 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 08:51:43 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Thread-Topic: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Thread-Index: AQHcWXX7teMkj3OyeUyWgPTZckbpj7T6ztgAgACrToCAAC18gIABKQEAgAADUvA=
Date: Fri, 21 Nov 2025 08:51:42 +0000
Message-ID:
 <CY8PR12MB719597CF0D93BE6091CBFC09DCD5A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20251119165936.9061-1-parav@nvidia.com>
 <20251119175628.4fe6cd4d@kernel.org>
 <32hbfvtxcn3okpylfcgfeuq7uvrufpij4y7w6au6vxrernwthb@pdxvc6r6jl5z>
 <20251120065223.7c9d4462@kernel.org>
 <q5n6ata2nhrtbkcnemyuiuhsf43365uqpdrbhm2qvpckxkyyuj@u3ugwpyqab6a>
In-Reply-To: <q5n6ata2nhrtbkcnemyuiuhsf43365uqpdrbhm2qvpckxkyyuj@u3ugwpyqab6a>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM4PR12MB5794:EE_
x-ms-office365-filtering-correlation-id: 61e4899a-5795-406e-1e54-08de28db31b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9SHJgXmj6oiON1VJOXeoZwd4eA2QnJfQ34gUqpYkwsotB7LfEdlid5YUZnLh?=
 =?us-ascii?Q?1UP8NMDzVfI8OQ9wFQx9ptrRnvvInUglLKiUsRw0TDoKWYZLS5g7vsk70csn?=
 =?us-ascii?Q?NsVbraAnCIiDLmCn1+kE48H/oINm/CDOyRcIYIAslr5sZ0HH96CdrHNYvTX6?=
 =?us-ascii?Q?GEYt2Cvshs0nNiKXhdi7qpb/P5L2u9pLA66NvtkfOtNqdZpdTEMNHCKrEsY4?=
 =?us-ascii?Q?QG1UzciCeEC/6E4vf/nBQ81ZpF3XGcBVegCmzJzBM2bYKUPayx6v5MXTyYw8?=
 =?us-ascii?Q?tHHrDdvivGkgsKItg2XgQehFe3w5qrS2zxEsikF6XsmBX92VeKVGRah5Js0R?=
 =?us-ascii?Q?U5rdRYwk7dpAmRahfYuO5jORaI/G6RSj6IkJjaw8/PXdpMarae3ZE0PeIlu2?=
 =?us-ascii?Q?71GgqcdRTnc2gwSymoYDcah4uus9ezTAPgIg9aWc6R9ABWXQhc6JWQ5qcTl3?=
 =?us-ascii?Q?yZXkLwNwnCLxjLD0bDlYcf+R7AExu7prMOwT7luISywPlLEx6iFTIlKsjlI+?=
 =?us-ascii?Q?SrxH1/FvEDDqu/pwO4lYoh46gf7Jn/8UTGx8eD8N4M1/9LwfLB6ORtRmft3p?=
 =?us-ascii?Q?XMWlRdiQE9dlXLqC75wS5GaRW0SBA4zxBKQw82zkAAFfLhPnVBzq1t86ARZF?=
 =?us-ascii?Q?T/C+UPOm54EwhWY8ReDtwwr90z7HDuT5/jDCi3uTiHCv+sCdJJ3g8ImYbuQ/?=
 =?us-ascii?Q?hFw1I0T9tQ1814YzN5BAt6bre35FGKgh+EMKMfjzyTCIFFeFsWKn1vSO6LHR?=
 =?us-ascii?Q?jUxtgGctvcF+lQYfBkK3NpEw1hW5AS9ex3VJsv9KaZVxAJalydoGGcDf/tbk?=
 =?us-ascii?Q?NaCEQ6qG23mPZyEQYAY23nsINHCYyQBnBR3aMmN8XTfplp9Ig+Ki8YI2OBdf?=
 =?us-ascii?Q?hbYYkTr3TdLex1EzMAhhXK3opBZiYfpOkc5vy3bynBGy0vWO1klWHLImhrZb?=
 =?us-ascii?Q?B5UZtgauIeEGZhXszTnxWTlYBeF6dnFDj0r25vOGAX8mtsaIh5E4nJcogKDU?=
 =?us-ascii?Q?7eeLfAViMKVg2+UVgYfcv/GdICIotO3ar88n4P2urrx+UodbdUmjhSQijZ6k?=
 =?us-ascii?Q?GinteJtKMNaOrJKUIsezJBqJXzSkIkVceo20q5e5ABzN5/+ouq5MfiVyWLZ3?=
 =?us-ascii?Q?sCYKpTIDOvsUOkFsOmAuOLwIwAjMOBmzhXeS+T/WZ2fUf18TpSxEiHs7iCRN?=
 =?us-ascii?Q?IzcbqcC4ZyQHhrlyyob2kpbzzi+WdVCnzP6XSfNSJOtOgzsdUVztEMT9clJ3?=
 =?us-ascii?Q?hssyVm+PxkhOkGUWc+3gBUSM8x2WprkDqUuvKtTDX3irfxf8EzB6SkzGGvD2?=
 =?us-ascii?Q?a0QtMKcstKjWcWZFhbe4kKQKpuVswTqLDB5nwSw9R5MIfEw8X5S1Zn/AG19Y?=
 =?us-ascii?Q?y22LtcNV1GTcjeyYtz9j/f5TZ8ug/Byseb+RLHaU/WDkNjmdQmtBaNlUOTlz?=
 =?us-ascii?Q?hqchVNstnfYaOO2J7MEUw2gSDFubdZzt83xC0aI0leKp0aTtOt5osYfDjBxV?=
 =?us-ascii?Q?dcJJ4T+i1QLd9C89Bzq+mzzIR6P1fag0nnVD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5U5YsU69y8Jag25PRpY0t9Hnfdw/lIc4ED4pSxirsZrC4IEjtyICUvu9hFCd?=
 =?us-ascii?Q?jfBp0+IbdL1iPkHRFUAfQ4wJAvdt7/cmKZ7HjS9ilR9bX/DBpOvSB1sGY3O+?=
 =?us-ascii?Q?Eh2jqqZ339iYkeVvEgIZ/PCEyyKBxQysTZ8vnhYcfaaMEOjjsBsJFxMHOkES?=
 =?us-ascii?Q?nu0swRejtyNtYK1LoFXMTmTZ10Xi3KfcSUprnuxWzMfEZ/FbS9mgvjUKtsf2?=
 =?us-ascii?Q?v2D1kaaag5l26DxdEA/7cY5rhkLjRt7ydzg5cIXRQX0Wzq4xKIo6GB8vbb1D?=
 =?us-ascii?Q?ynhFFX2s5i74SM+S/FFjtUJKdq6mpQt7ctNGE6Dsi2ilMhZIE0M/O0Qn3xZm?=
 =?us-ascii?Q?prNv102cSHUH0hYC9dbAVLQL6dXbg+zhbe9/QqhdkIQvkQX6T30BpzFnfNBH?=
 =?us-ascii?Q?dNLEUYIeZ+nwFKD8c3xFgUcZ/1C/X2DUotHcIGM/qa1vXVsdmXi+xBKBjJVW?=
 =?us-ascii?Q?kpMCndItXz0PyTfPt8a0FSbX0uS9gklUnnI8iIcTavzqmR61JN/ElKvCpruc?=
 =?us-ascii?Q?/8+OcQ+P7TvXIpn8NpiK3kz/fvRtoJHgUpWkRh9ePFP1HbiI4vkkopMRxoHf?=
 =?us-ascii?Q?cYp9Nje5+R/3u4ZV7Newdp0gM2OPywC0dHDk7C+JX6rhWSlKCbv95UbSwYKy?=
 =?us-ascii?Q?rHk/NPqTzJMSg2v7wKQHL+Qc1zjMJ6lDD+zE09eZsisieed7izDDKX/OT5fN?=
 =?us-ascii?Q?d+XauSQjtSV0SumCt0ZjK2JlcNe4nhA8PYrCahyb4Z9p7VesyMckHJ+Xvu/k?=
 =?us-ascii?Q?H+tcXVsA2TUqQ00Up3L49xheIoY3q2W2och1GVMLOUomhcq7bL3evYPqfwjL?=
 =?us-ascii?Q?XnbXQapwzhLueKdKgea7pH0UV2SAFJi8zCXZXaN4W8MT/QVOIhqUMNlCulzG?=
 =?us-ascii?Q?7Jt3Jw2IYIrteGht9PRDsgzGJ0UnIVX4/RhSCXttqjCuKot13NKLifEaVFWc?=
 =?us-ascii?Q?vCdOiLZJmGc3dCuxIl+Q1Temv1ht+0a9Nq4HBZ88NVLy+eAGYSsrvxm/LPyE?=
 =?us-ascii?Q?mZ/CXOJZy4efajjNA8WZkXbAna1MCnlkHlamzflSgibQqPnpsgeFZbXo9twR?=
 =?us-ascii?Q?r+gtve76M/05I6KpJaD6up/anBr5mgDUDiY9z14SuwZZrEsXSQ94yVi3566M?=
 =?us-ascii?Q?QXlICWEk8z4VlZCStjYG5kI2Z/JwYC4WQ2x173BuZQTJDh9pzpYJck2hOC4H?=
 =?us-ascii?Q?czltFzIV0mf8KYVeCReeQ9qZ5p6ToJhRCzVNI31poL3iGXLk6BS7MZkx1LR4?=
 =?us-ascii?Q?N6FgwuZWW7L2O4LI5EpPkalfYxtZaiD+7speF4VazRYGK6zy/H3fJxyQY/as?=
 =?us-ascii?Q?zRGPDskJvl2dCct6/PbG05wwXom4jiaekG0tzAkX6hCiIl0afDJiyvptM9hQ?=
 =?us-ascii?Q?87BKsQjA1N01n5qxGY0+MaTNKJmWmMTd2LP2ny+S04PH8y9c2cQJfyC779/Z?=
 =?us-ascii?Q?C1a1ty2hh/Q72HeZ5+t+2B6Nv+sugEWmN01+6r30/PPm0psLeJEmK2Xg0gvf?=
 =?us-ascii?Q?PtqQ600NQFWEk2JFgGprCPhwwb95IBTCF8ZJu+HY8coo3l380PLI4CzgypM1?=
 =?us-ascii?Q?qqLz0B/3060YoQF7DOc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e4899a-5795-406e-1e54-08de28db31b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 08:51:42.9968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EP7KKf51JWt/Ucl/Ca1NRxIiSRCHx9EnYj381D7LCz18GNMwhlmzMwL6TL4KNEOYKu+6PrqHvLgigQCx4PyDew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794


> From: Jiri Pirko <jiri@resnulli.us>
> Sent: 21 November 2025 02:05 PM
>=20
> Thu, Nov 20, 2025 at 03:52:23PM +0100, kuba@kernel.org wrote:
> >On Thu, 20 Nov 2025 13:09:35 +0100 Jiri Pirko wrote:
> >> Thu, Nov 20, 2025 at 02:56:28AM +0100, kuba@kernel.org wrote:
> >> >On Wed, 19 Nov 2025 18:59:36 +0200 Parav Pandit wrote:
> >> >> When eswitch mode changes, notify such change to the devlink
> >> >> monitoring process.
> >> >>
> >> >> After this notification, a devlink monitoring process can see
> >> >> following output:
> >> >>
> >> >> $ devlink mon
> >> >> [eswitch,get] pci/0000:06:00.0: mode switchdev inline-mode none
> >> >> encap-mode basic [eswitch,get] pci/0000:06:00.0: mode legacy
> >> >> inline-mode none encap-mode basic
> >> >>
> >> >> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >> >
> >> >Jiri, did you have a chance to re-review this or the tag is stale?
> >>
> >> Nope, I reviewed internally, that's why the tag was taken.
> >>
> >> >I have a slight preference for a new command ID here but if you
> >> >think GET is fine then so be it.
> >>
> >> Well, For the rest of the notifications, we have NEW/DEL commands.
> >> However in this case, as "eswitch" is somehow a subobject, there is
> >> no NEW/DEL value defined. I'm fine with using GET for notifications fo=
r it.
> >> I'm also okay with adding new ID, up to you.
> >
> >Let's add a DEVLINK_CMD_ESWITCH_NTF. Having a separate ID makes it
> >easier / possible to use the same socket for requests and notifications.
>=20
> Well, you still can use the same socket with just ESWITCH_GET. Request
> messages are going from userspace, notifications from kernel, there is no
> mixup.
>=20
> For the sake of consistency, shouldn't the name be ESWITCH_NEW?

It's the change happening in the eswitch: mode or attribute or something el=
se tomorrow.
So it looks more like DPLL_CMD_DEVICE_CHANGE_NTF to me.

