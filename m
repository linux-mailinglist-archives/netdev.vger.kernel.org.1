Return-Path: <netdev+bounces-240426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 153B0C74B02
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B30D02CD6F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9812D8776;
	Thu, 20 Nov 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f0rmcJLD"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D53C2D9497
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650621; cv=fail; b=q5OhTQaTXt+SdLhnySSPbj51FKoYFELQrhExcLqY5hUaz8v2tSQ3WtOu/dWLeCCg+47ODgYJbSd36Q2e3NpXTfYf0SCY6QtZtSq0vh3OAO+DWVdBprvIokC8/HBNqgy+Q8FmduFIHGYumbuoTz6ObwuuGxPA4eK1oHaCGgb08h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650621; c=relaxed/simple;
	bh=cAThT4oEGRA0qna+sPOPMRrKbL14fJG5wxYr+M/gJt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ViKOMoD33GaQRyYKPbyVBDmqnSRXnGB/l0tRI/IIl9/d5DwgRwqlXTLzK/lqTx7DLZ+5fS7ZX13f2yLA126rKByo/tUgDEDG+GXbpIWi5Ir7kWz+k0nx8So8+7E+9V+g6DpK9iIK3YKs4dw0WoywUXlGDOBe9nkgXgX5wt1i8mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f0rmcJLD; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyEnFcZED3gOdekfkPSkNXOYSCfQ+UImm89tbH4dUsXLzESwtgRRQX6RgBb5FZeIS/ev7IgZ1YpS+hf+9qpA3u1m/3K4AZxJIUskxc/86VAgD2Hz8CaFvszW1R2mX14UJyBAZc4x+YDanla9J5rgl9iEIyk9qxnlbyNu7ijoO41nghLwslcus+fHw5t8KbQnnR5b0fpc4QH9F4e5o4tTLSre3utX2+Q6bE1XT16RlYgmnvoWfJ2tHLIjioeyQrESxPrwj1veB5JPbzSfd+9oaWlZMh9/Qy4yNaP2KztqUgIUEVRTwBZDoOtJJ04PfHthNyIHF8w+3j6aEfuOD+3AvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAThT4oEGRA0qna+sPOPMRrKbL14fJG5wxYr+M/gJt8=;
 b=t7C31X9njKU72r6TXFbIhKav1xZhSm3wfHrFSfBZMMbIOQzs15PoksZZZatg02WyWiN8gbAKzZRd46ssLJQVNdgM0IYUocLjtsanGbq818WTCZ8IiJ8tvRzLaMraf13aI+ZwleNwnurP5+zwlFvLqDtXUQEgd+4jOs/nFk5r+vM2LwwNl2Yt7+BVW2wPma/a/DErKECdi6tgf8mGOoRbQd2kk/v3BWhtNGlVpV2Nmc5y5TM98jZf4AGKONipr1Vrkkx0IZ+SBNH5qw4SByHEdfNEVtIily1r7SLZg8NjIBfM1bIiUMEkDnlvyU8gFd/uAoKj1De7LYfaoMCcxIz1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAThT4oEGRA0qna+sPOPMRrKbL14fJG5wxYr+M/gJt8=;
 b=f0rmcJLDym/+H91vg7SAHTtD8QzTz+VpG9cblGOpIvljA20EWl8wgPJziOzAHegOzWEeK1fSiynO2PGR1cGHuAKC2lLMEw/NrlBQnTIs5Rd2j1AKaZHfqaw6TdDAW4jz2Fy9YspLna8b/dcfJ72SkSEK2bmrR/AipwO8kUcdpXiZYypZzB2qqNorDofKt5lOm2ZYB+mco43QxAfjVLCREIvnVfNSlTusTBmZD96fIB+8vdM2X+Mq3sPWKs65sKWd4Wnhi+6fNplNG0yx8dKsDq8VlHvPFR9/yAOCXpznQ8Ft9BYdnJEnMgrS+ROB79VjHfb60LWlQdX+ngE0wIoyrg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 20 Nov
 2025 14:56:57 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 14:56:56 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: Jiri Pirko <jiri@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Thread-Topic: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Thread-Index: AQHcWXX7teMkj3OyeUyWgPTZckbpj7T6ztgAgACrToCAAC18gIAAAHww
Date: Thu, 20 Nov 2025 14:56:56 +0000
Message-ID:
 <CY8PR12MB7195C7898EE5616A10F90823DCD4A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20251119165936.9061-1-parav@nvidia.com>
	<20251119175628.4fe6cd4d@kernel.org>
	<32hbfvtxcn3okpylfcgfeuq7uvrufpij4y7w6au6vxrernwthb@pdxvc6r6jl5z>
 <20251120065223.7c9d4462@kernel.org>
In-Reply-To: <20251120065223.7c9d4462@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CY8PR12MB7364:EE_
x-ms-office365-filtering-correlation-id: f3b611e0-be16-4071-b6ae-08de28450cff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lhGqp6owUqqowHyG/N7KIhWhQaf7g56g5cxvnK+LDS30WwaDw+9wp9bboyHG?=
 =?us-ascii?Q?SY9aOC0ZChDTG3PiEFzMja9o3uG0lTC8RVlhR23QC5Ct0KSWgWIPXEHAGEO9?=
 =?us-ascii?Q?RSqHg5C0fl72M9FscHqW0L6Zq5F72w0w8MT2m+RytLEPoGiMGQ9e6vQliCal?=
 =?us-ascii?Q?z4ittTuCTqHbonZ+yFaO9SF0Han2YlTjRCRyYEgw3OIrVq34Cidqki88HH37?=
 =?us-ascii?Q?WuW+2S2uRqwNTvwbDD4l3bVq9O+O+6MCLbKSCXe7xQ4iLlr1yawd4+E3hsSH?=
 =?us-ascii?Q?f5+0qz3goMiAoWT/tQknUZA0hV8UOzRZCR/GmZt1ckuecjcGcDztkki6CDYR?=
 =?us-ascii?Q?2usrdIwyaCwwiBzKuQOavYDT66MWwlTtJ3E8nop7S7GsKrF6pzVmxBpY2OiA?=
 =?us-ascii?Q?qgnwV3Dt2bD67bYwocV6o2YJfEmbmzdh3uAgEQUJzCqGox7VwIgfjeRzhy/1?=
 =?us-ascii?Q?oz6BIhrjKu9ELjH3Q1ZAXq+k6Tw9iQFb8V+QKBCs/hyY92fCnb3oqUL9aRDm?=
 =?us-ascii?Q?CwlsjmhKhpgraL8LvG+InbMx3EU+LbArHvxkDWqgCPC2Nr2gaHDw6arSgHfz?=
 =?us-ascii?Q?5MmUYxPOJ/jeZLu9we+IFQMTMJdFOSm/PO7pu6mM7EOqKuq/uvQ0tG53etg7?=
 =?us-ascii?Q?5Oh9/BQYwtgqgm8766k4PdsYmMZwuVIlRYcNeYLPfC7DdiDVRKFikgTOU58O?=
 =?us-ascii?Q?HJLxueBArYjTIdtTkvoT5ssXe5ysj5me1HGcMjpoDbWW4d03TRpVTeuw1g5q?=
 =?us-ascii?Q?uJJ+5DzmZ0Sz4341ssRLGyOnJP2rJ53rDYvBEmDH/+tm1SgWjAPrFXcSWYJs?=
 =?us-ascii?Q?zmXXkizasRytiTkKHkp26oNhoQSRTXmY1vfVgrtymgRKo+3qoBKPNTUWctHT?=
 =?us-ascii?Q?pfsGpCKW4czB0u+wMGzQcIXcKahLhNoz4dSZldnbq7arlYfGmXukMWBtS/PX?=
 =?us-ascii?Q?R5GVszqFNqZYS3/QRt4JFrZr50z/WQyHgsRFbY9QO6Kh1sIyxHaO2oQcqt4Z?=
 =?us-ascii?Q?147gPeYeMHLXMkBb/k+B1T7pe+dW89mPl5d67HIUpcA3QtRHE/3ieccOMDZY?=
 =?us-ascii?Q?CddULxOO8W2KTB62g7JbhErji4Dml+zzp5NKSYzhH6Q0XyxAPFdJCp3bCaAW?=
 =?us-ascii?Q?LzG9oTceV1mXxij5b/46GVo1BGvblITP97gv6ob0wFtcdin4ySr+00nhhx6r?=
 =?us-ascii?Q?yGPo/FWNUT3db1BbjWGvJjwHH/wMuCCFtnvn7Leqrf980D/MydXH9G9P6srS?=
 =?us-ascii?Q?8BYKeoNSZyCFET6ZdbWZide5AUF122xf2YKytvOX86MQOSMmZ0nVaXkMHy90?=
 =?us-ascii?Q?cEYhTZuJvm3+ctgNIeudhgK/9G0qb6pO7mzGkyIiFtPcdBViI5z30qzCMibq?=
 =?us-ascii?Q?LGgxE9LR7PJ+GtL5JVvGnOz/fD2ZQQAsl3p0H0BNVJRLgWJ6pzyLX4XB7ppc?=
 =?us-ascii?Q?CRFPQH3II+PYBqTCuM4pHzZ9g4ZdYEZbd0XWCe+kTtTKTZ/f2kFbgb6m9B4o?=
 =?us-ascii?Q?e/IRAO38xsPkIUjLVIkBtSp5uzuQXGfe5veI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PQsGH+LQixS0ahNa7RDHusX4t/JqKq+SH0kGaprvM4b0e35OUFM+TBpbYQpD?=
 =?us-ascii?Q?NMhwqq4l7j7FVNjax5+zk+5qLBd88ll09MjjxN7p7wrIG8qWuoJ6m3UO9q6D?=
 =?us-ascii?Q?iB+ATPPy0S7UO0q2EodIxv58euU+0w7dxUcUT9eGHi0YmkUWGiuspdrRn7dY?=
 =?us-ascii?Q?ZaU8RKocdjTcZ/sComUmQX3dzUzlOwjlr45uQhknmfWKchTD3sVULsuY0DSp?=
 =?us-ascii?Q?HQ1Mwa2U2LnQS+nZwoXMu1pQK/8+PTT/gopAfm4FbsliQo6wqdmbQ6jp6X/y?=
 =?us-ascii?Q?jHW8SCCkBI5VyiaEq1cn1mCbkP/QNw7Xfoes9bSK3Ky31f7TC8S9M/9StMLQ?=
 =?us-ascii?Q?oKpDphQzAD0y+qt/JQqtpHYqlRda8S0wTEUok2qvVjovr96mHSQbxa0PVfKx?=
 =?us-ascii?Q?U17WHbTaw2hCnCmQtlOSfDsXBh0TCTNzmJwtpwzZl08ntDXRdFjWA7W3aOQO?=
 =?us-ascii?Q?6Gt3c3Iq8szRqiDOZ0aLFXOn1k8IWMfhXsesWFSa86zoYsGfS45L2Kso5jGV?=
 =?us-ascii?Q?imskmpjptkhFGaP7XBVsodvLATpneO2wEML4k0/wU0z+O0dY+CnOf6w7pfZd?=
 =?us-ascii?Q?IJ9UfYsIVMepLX4FyKCL9UBWhW5eYqSlC826m3y7ww8BRqpYGw2s6+Oqf4xy?=
 =?us-ascii?Q?E8KmTRhsKNmPYmsKDf2fx/IdRhe+q8v1HWFZCmNVKupSFwIoomcCZERl2+DF?=
 =?us-ascii?Q?KfNWjjOSXDe+wuvlv90gj9rVFckh186HC0BTGiqD9bTvFyY/u6QOZGGPab6n?=
 =?us-ascii?Q?oS55sQSmBsJuvDmyFhRhLdw2fiFnzTJAJPncI9dB1HHDAjN7Ib4hD+qJtVh+?=
 =?us-ascii?Q?cykSvCHOko9DzkXGDrFReQHjasmYYB89hILJXClhPKvDKO9It0ztvQz0iLTw?=
 =?us-ascii?Q?Ylmw6MmN2G11iulomHh3iz2PnTMqg6B9J1iTHTZCyMmKaXpoIpAMghEjJ4yX?=
 =?us-ascii?Q?8bmsWpUIsTv3ysHJzmnA5/LkwoCRoyM5aCsh4pWt4W5IW84GO8Vl9jlxZG2x?=
 =?us-ascii?Q?P9OzBoAMCvyHHr2dVrpPojkh1wCCvkVbsBCXlpJdegNixOTl8PqlpKFubp2y?=
 =?us-ascii?Q?Qq/0JwaIdUU1wnWNPWoJQz3R2IuuQF7jTKlD5dWQ343DaqtSkBWHOVTYUCzV?=
 =?us-ascii?Q?4FAOPC7858wt+0p8FXvSoumjhX8tGSvcaHk2+S0mL+i/RSIED2e/w8WP2LFT?=
 =?us-ascii?Q?Rkf+TxVT8ASmfqpffJ7Unhbblxywhn7CnTRh4X9mdEtH1XTc3GwoPdNk4rls?=
 =?us-ascii?Q?ovYqPhrVqkUeT7lL1PCGGPH8tHU6ppn2cpVZVSDJTT+jhgE1C398d4Cia7FX?=
 =?us-ascii?Q?09BU4ca+FA/3XO4H7YlE2OzuSi+JDPJwmYwfjqpobJmkyWVdvbvxMoElumlb?=
 =?us-ascii?Q?8DFC2HVTncOivxRSe+CUHccm+ZlopCWisTGfxisGOsVa1v4CwX09ra69hxGR?=
 =?us-ascii?Q?YIF4zxa49sPty+HcEj9P7PxCXgfZ4luCmmyqGN86fTmZeydT0SrpgGSwyrDN?=
 =?us-ascii?Q?8ZrY5VsWIF00EbNLTYQ+DLQzyXKfpIDQYBJMqq9oYxEhG7J2NkCAJgNEgt5j?=
 =?us-ascii?Q?rF73na7rUDmWH05yB7Eot5eHufFuF2uovfKNGIgvAFqJDMIq15sgHkUJdt4b?=
 =?us-ascii?Q?U5r8d79wqjclM2oG3BeH46bOzV293hJgFNTUYbz6E9H0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b611e0-be16-4071-b6ae-08de28450cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 14:56:56.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOdh/3XtgW6vZjh8LffM1WlZrwteWBnFir2iJb1Te24AThAL0wkZNYSna2FNe69ehwqAwvrbylcOXdw0LVc3Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364



> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 20 November 2025 08:22 PM
>=20
> On Thu, 20 Nov 2025 13:09:35 +0100 Jiri Pirko wrote:
> > Thu, Nov 20, 2025 at 02:56:28AM +0100, kuba@kernel.org wrote:
> > >On Wed, 19 Nov 2025 18:59:36 +0200 Parav Pandit wrote:
> > >> When eswitch mode changes, notify such change to the devlink
> > >> monitoring process.
> > >>
> > >> After this notification, a devlink monitoring process can see
> > >> following output:
> > >>
> > >> $ devlink mon
> > >> [eswitch,get] pci/0000:06:00.0: mode switchdev inline-mode none
> > >> encap-mode basic [eswitch,get] pci/0000:06:00.0: mode legacy
> > >> inline-mode none encap-mode basic
> > >>
> > >> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > >
> > >Jiri, did you have a chance to re-review this or the tag is stale?
> >
> > Nope, I reviewed internally, that's why the tag was taken.
> >
> > >I have a slight preference for a new command ID here but if you think
> > >GET is fine then so be it.
> >
> > Well, For the rest of the notifications, we have NEW/DEL commands.
> > However in this case, as "eswitch" is somehow a subobject, there is no
> > NEW/DEL value defined. I'm fine with using GET for notifications for it=
.
> > I'm also okay with adding new ID, up to you.
>=20
> Let's add a DEVLINK_CMD_ESWITCH_NTF. Having a separate ID makes it
> easier / possible to use the same socket for requests and notifications.

Ok. Will spin v2.
Thanks.

> --
> pw-bot: cr

