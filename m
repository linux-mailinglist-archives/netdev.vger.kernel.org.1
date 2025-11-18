Return-Path: <netdev+bounces-239384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6130DC678E8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 06:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AFE8341350
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE422D3A93;
	Tue, 18 Nov 2025 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rdrLmRks"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93512C0F9A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443529; cv=fail; b=sXjyVx4fxmrDU1rG6wOSsh4H8qpzGyWrIIqlDFDIAgdDnu76xpT8/4EiSzdgtn7iD310LxMpudiWVRjrDrmFsVGur8E1Ggfm8fvPdYEbk4ouzT1Ic9vfm3aataVQtfw814w4y21j8U+XxLPJmnUEGciQXYR7urN7j26TL8TpT7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443529; c=relaxed/simple;
	bh=X8wVAjCgh6vnuOluot9csLhcNEppwK6Cb8izasnBgeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6ZN2XdG+i3Te4cZar6AEw47tQopuxgcXPVl4WT1rFlMakVYefb3BAhrSvrUhusp7occSTdNWBcyKKQ4SQhovCxc2fMA9wxLzdM2mtcB4pkY4/EDT4baK6CT4obBkeomy6AJ3zTj72PMoyAppYBd3EY9ISsjV8oRkBZcy6aTaEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rdrLmRks; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLF1/ZQRu/+ZpKr9wfml8N26B1Pb3mE3vvwOhq+XH9R/OIzva2c4SSnoxigzOF3CcXVXmcW7PmbONLoNsEYPLXrIA0FzlLbUJb6TIE8sxqeqWK/F4Sb76jVrLn5Uha4+3DDHj/w7wRalAJeim6KDU3Hj9d0rhqIz7F30CMnjMXKP14spPb0wuCjYWjOeONOg/I2POHA32OZ7MZBF0gDa/YdQfDI2fs3ukl9Xep9DDToUurqAK/Nud0CFi88ujERiw8+JlHYT2A9X22aX8p8/u27/Yt9h15mrPjYD3lKTecIVKQpMqeZYWcozZ7MzUM8mVkshLZtDT0kD0y5LEbTB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkQCm5o3viiHVmHZmTEj6jvRlF4tHo8pmlqDboJhw/Y=;
 b=VYPxVSBeeu+Rra2kGAUl8ah5gm45mbc5ak7ymPosGq192B5ZXhT570OKwGMC/nW+2R/Y3JEZp+cXHK2qw8lSLC01Id8GyJuv1xhVa/ECDf5w3ulo3BgE/mGRt+b89+x65XWMmpR7nVmD8/Sv3cQJKgjhcE4csBe/KmRwwcCdxRXH/MA2uuePDWvp/LvD0aIO1eypu6cEsnuX+UQfnXCmsYU7CQm2W60d3YIXrVI4jh46AW8/gsr+aOtHvVdVgjIazstzYtWqIHl8kDLLj+dhw72NxDELhWTpR41dsbdJQ3iVZM9/u3p1MCUfGdDWlY/9J7Accze+JV10Bh3s4v20GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkQCm5o3viiHVmHZmTEj6jvRlF4tHo8pmlqDboJhw/Y=;
 b=rdrLmRks1Q1SOovGd6OnvNeob6rP66Ih6VVSExUoBbi4eTb11L2TmQrrQjuBBSprGc1aEJ8B94/d7ppwzsCioBXhbdwwRo+iwdz0rV3TjOuz64AKaBN0Sv5kuWaCSu9UTRCcW++/io3axBYX4qnoQk2U7weKsjIiymYBkv5oR51rKFYiV8W5ECLLrsKhQJGblaQCHMe7bDd6CDF4oG8oZ9AXn69XeDmw6a5tH8u9oBLzgjUz3ZttmOANK4ZeKOx06zH+vc0LD7DE9MNCt2I5bR54Lzew8fPuA8A6XS2zZINFnEwAkLNHJyT8C0bMgmqcUmvaI0RvbsCHr55VGE7Bgw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 05:25:23 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 05:25:23 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next] devlink: Notify eswitch mode changes to devlink
 monitor
Thread-Topic: [PATCH net-next] devlink: Notify eswitch mode changes to devlink
 monitor
Thread-Index: AQHcVdrQdNgAaqHH4UyJKs95sBKeebT3zpuAgAAacKA=
Date: Tue, 18 Nov 2025 05:25:23 +0000
Message-ID:
 <CY8PR12MB719576A592BCF41591F83C23DCD6A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20251115025125.13485-1-parav@nvidia.com>
 <20251117194101.3b86a936@kernel.org>
In-Reply-To: <20251117194101.3b86a936@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA1PR12MB8597:EE_
x-ms-office365-filtering-correlation-id: f91beb96-fb11-494c-7c9c-08de2662df8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ly2qBnK3IgEjRVcE8mOh/tRUWmddyRHibdlRsmFEWGaMhwzhI7ul57Jd1fiR?=
 =?us-ascii?Q?mSyBFlygL75ehtmn2T2ZcYB4ZivsLBR20jl/vsily/3Q381qeUDV2XQdhuUU?=
 =?us-ascii?Q?EZ2RKL7kYdxib5ustmC0Iy/jAVtzkV4In4fbMPVDOs80rFbTrlFtE4qUg3nc?=
 =?us-ascii?Q?1ny06NcGxuMwPUGlxpr/E+fVha6tcdJeFnvEROOI2IvnP1ZCjAtYb26MuuCu?=
 =?us-ascii?Q?FGHi6WMuii2+qRaU0SIIshdvIq7MLAC0KsS51s5mnvtzkrK4fjir1kXPS/lV?=
 =?us-ascii?Q?f6v1g0JKVC42fJbADZEUPbvIbNe/NDYotDvWQQY5NrPcWjsBatzRohJiPP4l?=
 =?us-ascii?Q?FR7SwmnykbDiHWh+zuMOQiHf2aVLge3CK/g6dIowAU3EnM5UBYjV/QsplKxQ?=
 =?us-ascii?Q?lRwvg4yrsLLwrirx8/jikcoi5ZhnG0w4rGRx83cvHvcHz76lyJY5q5X50vVP?=
 =?us-ascii?Q?LKpXZyyk1vCU3Fzw58NkxkTC2vUuhIcm1j4yq6IbBsetzEyXPMk6XwtC0ytz?=
 =?us-ascii?Q?sk45uz+5ZbRH+MtGctXTtJj4ppm+NK2aqyPkBmpinuciNpJHHRqb27MJNe0T?=
 =?us-ascii?Q?6/cUuf3ouWe2OzyheHX7nskADC8z9cWGVSFjBNCDFSqB5C+BVhWzCz/6dQRP?=
 =?us-ascii?Q?qzkpsmbzdrq0gEIgypUS28mw5zNf9h2jkhevMHCR41y+B0sWYG6D+Cw2mae+?=
 =?us-ascii?Q?+1EZFbxWY8o8fQYtJ8j3minvm3f3BSeD/Er/Ot3uWNLea2R+Cd42d1nIHTrl?=
 =?us-ascii?Q?N4ZxPFfiKcqD4OFOsLM2pqYOkFjahrYIQn0QxPXbxIS8tre9TcD2dLXkwcTc?=
 =?us-ascii?Q?o7CRrRZHNxIy1aToDLcL55kh/c2Bp/vY7tVV+rj1oj2sIL7PX0VtmFdn2GBd?=
 =?us-ascii?Q?LDjvSO7NFsGkUyRZKhJjhJvhqofTceFRzi1rZVQsY8xAuYmczSLf2CilqJau?=
 =?us-ascii?Q?6Pjah+CdI9Q0r6D6tZNqYyedJtdmnjz2lY43SwcPMK/LgxwuTAk/PNRqHIfy?=
 =?us-ascii?Q?m15oHE9epJZwBT+abvGDnoqdcWeDWRY+srA065d0lxHzNyKePWUuVTjx7hbE?=
 =?us-ascii?Q?vREkyRMrswgDQs2OvbQMtz2ufANgXPpmpy+xjZBZGOaDgJ8Erb11QSffQCRB?=
 =?us-ascii?Q?eHtPLxz30mXurAM/pivF9czlBi+tX1XUDjQ5mzVgsRtiDo1b+WGB9CLSu8C3?=
 =?us-ascii?Q?G1/vMbLf6vp1VSP4SX5E84Edb2/M6s7D4+FbYVsVTBJE7g3+/7faq1qva0M+?=
 =?us-ascii?Q?UtSBgjzUZggB1P4S6l74no5SzSqhoool7NnG+ERBPmw4Y6GEaGxxFHHXqaS1?=
 =?us-ascii?Q?oUDHe1XUX13j1Phimri/8Qfyzx9AisMX8fh3e7O3Y2/HX8mm7hhWTHjxf9WR?=
 =?us-ascii?Q?7ESQ9km+AcPAOg/wA3LwRDPBfvxD3y2FHteSZQ3BiDt42FLZKqHQtejHmXdO?=
 =?us-ascii?Q?9hYWxl+f6SvxGpfHzCnU4ZvoXs5gS5K8xMfU0lFcxtyK9Yaj4AUVlqDQ/iSp?=
 =?us-ascii?Q?c2QbpLMgkLJEwVQpJfT7N7bhakMrEsR8Hhu/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j0h8NmcZycd74zD4lbXPuOvjqeFKVDj6abDVbdrkMEpnLHFhhgzvlgjKNnay?=
 =?us-ascii?Q?7ddmhzZ4gpDWziMjO51GP50RHsNmVSHLwoQLtfzdFidZQ1hlrZkTeUCoK2kw?=
 =?us-ascii?Q?aVh0xVJZbA4RBKhWbImEg856hDaRbFXg8Pt4UPbwBIv+JsrgiIaSbBGaZS+9?=
 =?us-ascii?Q?oS/3Nn5w2stFxj3lfHx/UOmC+fS6O+qCzl7wXJioIJIyX2fGsNXw706N4tZy?=
 =?us-ascii?Q?669W3Z2erL73TOBFD3cuY5NLELVwmzbbR1t34uiKIDwlowxCPVLBMQSPgd0w?=
 =?us-ascii?Q?+14ChkUZ6TC/+35x0t2drSBANZXpOh6h8UGtgyL+ZeHMcl15gI5NBnH8dvAc?=
 =?us-ascii?Q?hiOIvcJaZWJx1Qf0qTep+i1kqDRAxut15cB1L0QhazCZm0pj4angfo2Z4ZHV?=
 =?us-ascii?Q?hmDZ3qqDa6RWWEDcja8Lq54brI6rhzbZjFhNJqVKeC+dXw5Z3KPqySM9YKl1?=
 =?us-ascii?Q?f2MTM9afNscKHHJuL9e+Oh8MvJk3jzqxgoOvr95KKNS/yNNwDZNH4Xa63CY6?=
 =?us-ascii?Q?/VBZBvZXMdMWZSHvjwSwvL4goYYiLtS5Ub/vaxnOfB1NleaL56HUE0NYVXeb?=
 =?us-ascii?Q?oLHSM7wdD2XlzgivKQ3sqy4IdGxVS975B68M0w6NfuryaBSHbHXMrqriDDut?=
 =?us-ascii?Q?YoOYOUCvEl/DWTohMNhiao1UWH0VjLPMltvf2WL8Nbp+nzQbnIFw+R00pTn4?=
 =?us-ascii?Q?+gVg+VUKf/5JJ6ihfv+dmly4A8ivtP9FJInxIYtZocRf+ajYr1wxTCGW4ydx?=
 =?us-ascii?Q?bu3DUrYFwa8pAr7ug5O2Ml5lrjj5SXTzYHTODI6ijC+XU2l0BL8fXri2K0vc?=
 =?us-ascii?Q?CKpmvMExNysP60OHeR+Yh445Fhcy+3K/NSrUrgtykfSPJ0v/cgWSvclqRtE5?=
 =?us-ascii?Q?uZ7dWTkpYWOZv6lqJAV3+GZMq8VTAe3WimoaEbNJjzXC1rUJqVdrmEsR3WRK?=
 =?us-ascii?Q?IWLlPaV2a4K/8Cs4JVvA31D7K72qnpxK6uEqngUeYeRwfENw66SsOgQycVot?=
 =?us-ascii?Q?OxsEpIJH2zCAcgRMRV+Z8zc7Osa18tbFOCSspY4o2kJpSt2ag4q3TKnxHx/e?=
 =?us-ascii?Q?288QXGb/oSognyArDcaVvq9gnXijHjbFYOnb/Xtd85GmhL0pA3d8F2P4Tt82?=
 =?us-ascii?Q?M6zHhyQCa6s++cQmkOJ1tykicLlM17CgvGyw5Mc8hBIazDNe4y0WKqJgIRPs?=
 =?us-ascii?Q?OkIzW1vk6s1GWxSwJlIpmvkhpIZ6sKjuawaIHPaf7sssz9XOwRq6/y51GG9Y?=
 =?us-ascii?Q?rzSaiNX6eAGND/yi7oYUovKHHCGPRpwG+jCqaY9Ta1b/5PonrDLuBtx7QHuK?=
 =?us-ascii?Q?7GRWHQoAgpHfAxzEIqxOOlYf9ZdZPaINOR0LSHDD8dC1Q47wgxWEL+KFHIpu?=
 =?us-ascii?Q?+cdFKgMrnOh24xMXsa8dAklFTwb0CAVC0vuArGXeF4c2YBk6j2Z+1JMJZZFL?=
 =?us-ascii?Q?2GXmX2XYMCvSvUGNuL1pbe/Yzf09eaKKTaFMB2dgEiIuIQidG8Urqcec62Sy?=
 =?us-ascii?Q?+i2NaOaMc6CwHcJSV/uCAtqv4K4TnUozZzI6TDm1IdPzv0tNTjZcI+Hz7jjf?=
 =?us-ascii?Q?aBFHrmx3tLC35YZJFZc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f91beb96-fb11-494c-7c9c-08de2662df8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 05:25:23.1756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ukm0wgHn9eoUXipE1effAVSnu67RZQO2vaWBKK0HhvPwc8nC4+tpVit0K8ab0ls5iu57ImoVxJ6ggpGHc7W2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597



> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 18 November 2025 09:11 AM
>=20
> On Sat, 15 Nov 2025 04:51:25 +0200 Parav Pandit wrote:
> > +	err =3D devlink_nl_eswitch_fill(msg, devlink,
> DEVLINK_CMD_ESWITCH_SET,
>=20
> I've never seen action command ID being used for a notification.
> Either use an existing type which has the same message format, or if no
> message which naturally fits exists allocate a new ID.

I am not sure fully.
1. devlink_notify() uses DEVLINK_CMD_NEW.

2. devlink_port_notify() uses DEVLINK_CMD_PORT_NEW which is the input cmd o=
n port creation supplied by the user space.

3. devlink_params_notify_register() uses DEVLINK_CMD_PARAM_NEW.

Do you mean #1 and #3 are not user-initiated commands, hence such an action=
 command ID is ok vs #2 is not ok?
I probably misunderstanding your comment.


