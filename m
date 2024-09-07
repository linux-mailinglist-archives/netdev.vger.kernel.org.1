Return-Path: <netdev+bounces-126261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E40F970410
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 22:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C481B20A91
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5AD15E5C8;
	Sat,  7 Sep 2024 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1uEk2vQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38D3F9CC
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725741132; cv=fail; b=G+AXAtmLLAh2PrVQ2v3oU0CnkjQxyQtVrnmzj3+IFIKtNIoXzVpNncvaqrDsuKH2WuY+xsfzJynUL/1Neh12ZRXcFLjowWauPdzo0bZK3PaVGb6XQPw1qLMBIoec+rkQB5BF+csvK1lEhd3SQ1SUe1T/Qos8gGM/v9e2dZkkLxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725741132; c=relaxed/simple;
	bh=qIs5P9ZQEe0nvU72MStKYh2qcGSufcd5VS09nzwbW6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iauf/xOAoDN1nfZXWL3kpMasUG9FxzsFaGZ0NDhNd+CrwSthL3fV8rhpLRd/Y0R1tLud5T7qYD1ipIv6BjCXwCMgxS1oTLqN+NK4O78BmBE0zAtRzbzhXsPO9rY+5LQSHaRvneIqZN2U0s+JYFcU26gCB6EDe+O44qO/91awxr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N1uEk2vQ; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqmPUnWIHu1dUKfYnJV3GuGJbsaNHZayWvBic7rjqgOCSoaYjIbyZFlSExMNdvWvPXFhmsnK6OmrzJP6IKnwLwLSJEY3ReULyxiaNfmLGfJ0b29FnaAKF8fyDix5YbbzzZZiEoAnX4sH+fV2/DK1hNUWVSUSIefXtvxSu2JVrAPscemlJpjdQkINJU1bo71hR2jRbdivMTPRXMpZ9wP908BfMiim8DaRrgSoiIl6mx0CuZ71bK4LAsoAci7OVkW1mqsSvTiihmoi+D+Z9KqN1L/D8BqQKosA6ucYr6/blo89KOVPSZM0BkZHapoPEAm7/INKDyo8fIg0PEbs1C86PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SeD/EdRV9h0DFkaumt+N4zXgpItcIv4BaOsoo23YLQ=;
 b=jf6u3bU/O2NaKW1YAexEdtKU2R5W6Pq1Y+ffoG5cM5TW4/7M4SIEGrxsdY0cXs87AKFPPuxdMz1a2Bxv5JJwesAO7uE3/uEz1nWZavqof1BqpaAYvddOuTHc2MrLmVvhMsGOqThlDrZZINTPFtkkOIIkNRKOJqQs7lJQU3l1UDCjwH8DVglZeb+tZGdIXx0TTm7DbJlK97Tjez2FfAKVdQCBCAiFTW72vItX/5jOGkmsw4Jifev2Dz1muWl7v/YHQeU6D4nrBvL6qLC5rNbo8n1ojx+dUyz9iBodQPFctRiopViAPdAa1wHFLlejXzKFYhNu5DiD6sMOQOOSzBt7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SeD/EdRV9h0DFkaumt+N4zXgpItcIv4BaOsoo23YLQ=;
 b=N1uEk2vQ8tv6mhsN7yLoOhdjIV8s09juqryWF6uEKENVcum+3Kqf9kFa1K9M6CmwL2SicKFn3etlL0reh6h8aaCsWbs4bOu8pKwXaqzBAhGQqi18XnSRgyLNvtpfKrdHJzN9Ovk+3PMIDsWAsbNBYd4d4TBv65YC4ly7mvNQ6l724HIuF8lrnebiErMIPVfpHl7xiytYmWrs6TtzDxR5uxhdHZEs8nfHsGhTSITYw0UgUHvW63BKrgHiC/yaQKrjp9aQw7XGElPCa8tymH49NcSHNTQN3pPOBBQ6R2PciiqRPtgL1VEGU4d5EIpvbGGJjo6yFVvszJm70/QcQQtlPQ==
Received: from PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 7 Sep
 2024 20:32:06 +0000
Received: from PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe]) by PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe%4]) with mapi id 15.20.7939.017; Sat, 7 Sep 2024
 20:32:06 +0000
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
To: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>
Subject: RE: [net-next V3 11/15] net/mlx5: HWS, added memory management
 handling
Thread-Topic: [net-next V3 11/15] net/mlx5: HWS, added memory management
 handling
Thread-Index: AQHbAKdeksxVlpR7rESPoGzOv/ZSRLJMYwAAgABk7vA=
Date: Sat, 7 Sep 2024 20:32:05 +0000
Message-ID:
 <PH7PR12MB59032B0605978DA5D664A3B4C09F2@PH7PR12MB5903.namprd12.prod.outlook.com>
References: <20240906215411.18770-1-saeed@kernel.org>
 <20240906215411.18770-12-saeed@kernel.org>
 <20240907142806.GS2097826@kernel.org>
In-Reply-To: <20240907142806.GS2097826@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5903:EE_|SA1PR12MB9246:EE_
x-ms-office365-filtering-correlation-id: 99ec968b-58d4-400a-6b88-08dccf7c239e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BvwBMYNj+olG4ma6XBc9hRQk0hQKfIASIQ53/Bv6pU0eS48q7N0PvhSVte1X?=
 =?us-ascii?Q?Fv0Mb+GkDUCtcjeAbm1oA465KQV2I+LIcXhJyIm5RErmc3tPLqGEOF42Az/T?=
 =?us-ascii?Q?6iU8rSgS4NCv9YIUU6YyTCbQGoBQrelpJ0we/zySnksxThp+GfOM5L/jl5ir?=
 =?us-ascii?Q?rRFRmP0dF+5rgnozd9E/IjwwclPwUXuley3eCIeE+RpX1doUva6AsBWZAsWM?=
 =?us-ascii?Q?R5T3F5w4imCEWg9ktQ31VBU0XWQtl90QR1nzy2lS/ZnGGPE/XRW+hsZfRr80?=
 =?us-ascii?Q?ohWpP9aFIRHJkHHRLygR5nDvDgpNKg//ZkEK44a3Om1+Zm4tUrNTHsJ1l1MA?=
 =?us-ascii?Q?ghiSQQMLyq/QGAcjyPWPlwVFW5iE8u5rYkJBRYOLb/1kJcXC1Xo8KSoNhMYe?=
 =?us-ascii?Q?GwkWwdhPIVpBK2NRRSFjvwQFET2vDQ8agxlKj5B734FSM/s2zNOb1TfH65wr?=
 =?us-ascii?Q?S+L17ovqx1apRPJr63gKZPc3KiYKEoA9taoZnWYH/HZGN1D0kvNgfJv6gTTN?=
 =?us-ascii?Q?p0BPU7WHUCvrnJDE0aBOSlvdwupQu+hn+ZgMqim/bvA8h+BMWfgbcmqavDwN?=
 =?us-ascii?Q?I1+jxGrjdhgf3IncqqOb18oyYWFI7Q160g6ZNjgkAA1FdmTa4/SavERLDCqe?=
 =?us-ascii?Q?Dv7i3Z3F43QhIA8EH9Th5F/cS6oQQIUrKE4aMXCIs8ypCEVmv9DR5sZqZEOr?=
 =?us-ascii?Q?tyI+D13opmdPPlq2Je2ppo/l11fhyq+nRz6AxmDkRerGB2+M2uCdM1vec5bk?=
 =?us-ascii?Q?E8sApvaYMTHK0Zzs4Hnw3GjtDncXGTowOtO7lwIR0hefhKElCFYbNzP/ievV?=
 =?us-ascii?Q?Ros9yLVKSW9oO+L/7Ph/qn4S7GKdkLAB8hSdTCOoRoWGBTvWyC2Nd+RKPtoj?=
 =?us-ascii?Q?SWa13aAuiOQ2U7M9eYfXJWTxmXQjP2TwABSpoUBVUEHdfsyvvFaTZqkL5qYu?=
 =?us-ascii?Q?fTALlyZSPp2GvJWGDYmjXttAIEur4GwHs3rVeVGs/rpWGT8p0AGfar4xzo0D?=
 =?us-ascii?Q?CbSdG//keZOLtIFggLQ2ehyaw5VomBQ7sd6YjeezgI9V0x7RcfeW8yZwQpvL?=
 =?us-ascii?Q?BxwkaakxN4lT8zRcV1thaUceKcwYjxbIowVOAdLziF6YvBHq20Gr7glRHBKM?=
 =?us-ascii?Q?mQz9zKEyGTrK3/dI3M3R6//nmMZEe3DcSy1EEyt6OzZ9tI5H9eT1xMnmvMUK?=
 =?us-ascii?Q?zSAnNlvb5mE+KawbWsMAsQQ6zCX+AlQxGOVxxwe80u8ELu7OPvTDOo0y06j0?=
 =?us-ascii?Q?RUQF5RRUOo7spOXp8TB30b4rEJYjb8iRCRZUW4vK2o6Pyhyhh+uVX4uvvPBY?=
 =?us-ascii?Q?k2nhul8Wi8wDTVhSsh2o92+vnN4VJqadLfGBEk0O2702N4tLiQXuBMIngHje?=
 =?us-ascii?Q?d6lIl+GKV9vig7BTUAVdba8FmybRhLmaUevA0jVaUkg3/ZnN2w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5903.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vbq+5M937h4mF4SkdsaxLHfaew4LLsSL06zuduK3LvutV2F0wo7RmuEBIY+D?=
 =?us-ascii?Q?8K9slHkIKW9RI+9XZMbB8inF0Gj8I5qrLGcUhWmrprruYDIY7g2ptCcvas+c?=
 =?us-ascii?Q?2sXpVW4k7Kec1DVWrq3MulJ3Rvc8UUJPGY3xalaBWNaBTUNKM7HeTbbRoi5i?=
 =?us-ascii?Q?OYSMuSV4ZpoqGsOoc9xoUcZR+fXCWuIDTrvL4LFAMMIEaqDjZ9UN25ybHlpp?=
 =?us-ascii?Q?3DjT/VLiwZqJjn2pv9eAGiSEY3bNPcnIIzlkQyaKQ7+KY8Fzb+cT9C8WB6O2?=
 =?us-ascii?Q?uwhTxbyigRYMRhsf6xsg+wcXiOm36wt3IVtpe6F8kQWPOXgGKxUJPtsFXFU2?=
 =?us-ascii?Q?g5EOkmmDYuZWtDRR4Vlx8nnAPFO2t4FQE6a8n1QN9aS+wRt5HhvmE7lXA/QL?=
 =?us-ascii?Q?wRdX4tvjWc98r+3DUgrX0NnPYlNAqqF18iPnqqXhWhDHsn/42ibOgqLsyr8/?=
 =?us-ascii?Q?+3spilxxlgnRTsWrBkgUhkbirvMauJ48Nd0pEEr7ZifAOQz4gCen/WFzAYPJ?=
 =?us-ascii?Q?47gRIMeKSEPR/5ebORPU7EPX4cwVm/rjU38KkUx+uMBGw7L3zN2Qco72fbaD?=
 =?us-ascii?Q?D+jrCCUIqmARJ+V3I4Kb//Tkgzo30jPADXwe1Lcj5YDvIIPXa2oiWoSdqqbv?=
 =?us-ascii?Q?VJCojLjb6yPmTGrFCl76eC3LNIvZ+c0kycw43eQkhOX6I0MAYIMpPCyg9aYj?=
 =?us-ascii?Q?oKn3AgtuFBcICBGzcGax/BzQWtqrr9VejKoDx/aUddt1ZdsznhY3P+WNBLKK?=
 =?us-ascii?Q?425R0hugQT+6pzkZj1PcMiJLNWA3Yw4ubLacSh/i+w7pD6qpBnAaBHEIDo6I?=
 =?us-ascii?Q?HILtEuPARdMXxTapXy7z8iIpn9/bKa2Fjim5KaolPXXFddtMA6zEs2+6ebNK?=
 =?us-ascii?Q?fE88L5cqS3WkHaOPqcw5nn77Qi/qNmAJWvknaBshqKfT0oDRbVECdyQ6T1IZ?=
 =?us-ascii?Q?bOMI3D890g+0JhZ2Lz/JkUqQZiOs3bUE4uuJ3pOfAXscjPOHfkHXFVnC2K0t?=
 =?us-ascii?Q?+lA/AV4tn6fufEBeuIbyI+YhifbcnHZGJievDwkmu3JOoXn4EVjKGl7e7cuJ?=
 =?us-ascii?Q?aWNqCEMaAbLLmSuaVRtLLKLMMn7u/5DZ6R3hjDlk4YHQsPbmRgayhN5WAk49?=
 =?us-ascii?Q?k2roO668RGi3lEIq9tYxHPT9k+fx5jOI8ywoG1XOXzTRL7Z2wcytH7BonVkX?=
 =?us-ascii?Q?sDOC4Xyic6G469qfCL9/Tf05gyIf/xRJnbnTo5UE2E0Xxh3YGlHWQfltpmKf?=
 =?us-ascii?Q?hyV54XBmj/bz8GlTgt7QxcxNvjJ5NHdotpAmj4v+epyf+6Z3xP01umVNY4KK?=
 =?us-ascii?Q?GzXwmi+10Z/mxm8BHWadqEARUp+erhtqr5idPM1119w6noH7dXcZC/Jsz0Vo?=
 =?us-ascii?Q?wtgM0GALim1r7sGo+My4SGtG1xz6i67PpF0FngUAUpk6jsGbtFiQ0BHy7i0L?=
 =?us-ascii?Q?311gsFrBWlXnWQLIOKKoru70OklscShEml4XRTnqc0LZKNVeZ0Gk+zJerPPk?=
 =?us-ascii?Q?pVUm/Jwo0iFpluM2l0xskU/23YKVb7w54vlZKOObcq8aeXqGB3edIkgkmQ9x?=
 =?us-ascii?Q?wTbfx0ps9nmnpFo3iME=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ec968b-58d4-400a-6b88-08dccf7c239e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2024 20:32:05.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37NoWpI0EzpO4Go9jZY+RQLyYhjyT+m1+S2j7YMtaXFnbu4VWx8gTiPHhLwI/l1zh8LWlBw290MSvVA0T6LD8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246

> From: Simon Horman <horms@kernel.org>
> Sent: Saturday, September 7, 2024 17:28
> To: Saeed Mahameed <saeed@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Eric Dumazet
> <edumazet@google.com>; Saeed Mahameed <saeedm@nvidia.com>;
> netdev@vger.kernel.org; Tariq Toukan <tariqt@nvidia.com>; Gal Pressman
> <gal@nvidia.com>; Leon Romanovsky <leonro@nvidia.com>; Yevgeny
> Kliteynik <kliteyn@nvidia.com>; Itamar Gozlan <igozlan@nvidia.com>
> Subject: Re: [net-next V3 11/15] net/mlx5: HWS, added memory management h=
andling
>=20
> > +     switch (pool->type) {
> > +     case MLX5HWS_POOL_TYPE_STE:
> > +             ste_attr.log_obj_range =3D log_range;
> > +             ste_attr.table_type =3D fw_ft_type;
> > +             ret =3D mlx5hws_cmd_ste_create(pool->ctx->mdev, &ste_attr=
, &obj_id);
> > +             break;
> > +     case MLX5HWS_POOL_TYPE_STC:
> > +             stc_attr.log_obj_range =3D log_range;
> > +             stc_attr.table_type =3D fw_ft_type;
> > +             ret =3D mlx5hws_cmd_stc_create(pool->ctx->mdev, &stc_attr=
, &obj_id);
> > +             break;
> > +     default:
> > +             return NULL;
>=20
> Sorry, but this now appears to leak resource. Maybe:
>=20
>                 goto free_resource;
>=20
> Or:
>                 ret =3D -EINVAL;
>=20

Indeed. Thanks Simon.

-- YK

