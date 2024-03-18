Return-Path: <netdev+bounces-80409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7F87EA74
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9781F214D9
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808E48CFC;
	Mon, 18 Mar 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmBH7V8W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAB4AECE
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770247; cv=fail; b=U7+An5GG1+Z985Auv7i12YDSqHLnSQFgJjglAEPoyBCrS8gJ1zSbPmE5xTgjOw4r9D9u8ZLGq3iTpQTtZje6i3OU31H+pRcWsf1k0Ed/g1+Wu91ql2lFbv55nCfnD6YD01j1iVi1yFjQVa/V1m34hZIZESpmoRXV6mZQo5pGxCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770247; c=relaxed/simple;
	bh=GxWbFZF7lnEzymPruiBncY8USrDApOla/gJi/nGeIiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iBxqakELsjme47hN5MD64gg/bdG7by/EA494Ey6taeg5D5qTC9wExnQ5qL43BdZKTXkbzbBAXJVvGtnFiBe/kUmQq53aHDF4NetpR//U1GzxqtEh9oJjj/PlOJRWunjlE5cbMo7OT3hH6NFCEuzlCr2k2OJLJb2fYr2XJiD6TPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmBH7V8W; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So9pqstbYXR5tO4PO3qeDlU1FP8VdvayPl9ZDLsXX9IZVlINfumfCPZcDfvXj0BKPVbttQu+i/vMJpRD8OXGElHW4q9R2hk2NMgqoZi0ZK38f+MvYG5o1wKfg5yhxqIxGKGbPfIoohI8Cba4vzpp3FFEMbPTmyxVwnbQFE5gileN8ZuQrgMjasnpd3iN7bnVrBYooEnLyRJ8JV8LtTI4B79grNsEKxA42HnK5XO4vQId3F4/qnoZoEYso2R8+HF0ZAp6WKwLaZIhTDF7ikSogz/iCEORcEOW5XX7DhnHgiyHR1MQk3zxCLzo/s0TU4o4h9Rz7joopOKovlCBaUqd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FbDlm0NcH5bCuuF3G2yHjL17e/rQ/yKsmrMz3V81wU=;
 b=Q6OoIPmzTZEuq7I1CWku602kofe9o4uEo+QS/3l9vYbcbF24NOTys+SJn8xQPZ5jqcG+RZallYeeiGP754LpRyGLyx+poMzQi0tuW9dp9IU53COnjjZ7nAfdFXaWv1i6k8Nx5CwQSvr3YD3aphoiJII70q/+KIbEKYbjIKZQ6zPIM6Xc/+Ww19tNJJ7RTQAifiVBig+nfnCEE1tkohaSjGfqIsLpmYM8oc5+U0M/Kvo3fr0Ab2vCJ4wgRl9g+Solm9L57BtUWjd0fv7AnazyI6VqfNBCEHJO/2nLD8UPtnxrllwTFky6NRZNHUXeWphab09dHdG9vq02T0VVdfLdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FbDlm0NcH5bCuuF3G2yHjL17e/rQ/yKsmrMz3V81wU=;
 b=DmBH7V8W2+ocgfGGPOA4Otnn2myxCTRsd7ZsgNVZr9jx6ONkoXyO+cij6Vc61obfMG80hRK3AGJdOubPXmoYbQlwvLsfbivar1fSg8/LOcIQyhzdAx16k+NqMjpBj/WQdJov5w9Dubqds9HWId/n4MyCsiL4xTUh3elyLanrTfvrVKaad0h2n0h/uJ4a7rUdjAb8leHu/U3nKxWts9LHC9s1QjJBXRQxHPDWquL/z3sIJKEfqBGRfSH72ZcXy1s0J/EJGzQn6YcBpSTd4HJlIH9q3dxhKx972l99UKzN96/+0f0vTh99fiUEAsyyBSBYfzsnBsiDUslmMiLHuH+Pcg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 13:57:22 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::6894:584f:c71c:9363]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::6894:584f:c71c:9363%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 13:57:22 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>
Subject: RE: [patch net] devlink: fix port new reply cmd type
Thread-Topic: [patch net] devlink: fix port new reply cmd type
Thread-Index: AQHaeRVZdtGZ9nZwVUumG8JkfYowxbE9ha4g
Date: Mon, 18 Mar 2024 13:57:21 +0000
Message-ID:
 <PH0PR12MB548144194C053A632B9397FDDC2D2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240318091908.2736542-1-jiri@resnulli.us>
In-Reply-To: <20240318091908.2736542-1-jiri@resnulli.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8879:EE_
x-ms-office365-filtering-correlation-id: 862b7d7c-6b0f-4106-606f-08dc47535562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G1GnG7rursbLvxw/4SzU5Y3X+iiLgAg2iHihdt/znHbfJ9E2MTbVLuoMrIh0YTIV5uxJj4/4TqJmNad0XBolf/8TOtxXAfUozqCPGhENF/bzI4VKxVpvac/AMk0IHCyNBBenObGaCo1iJLaoAmugc5l8H9Kaohrik3Ib6nEBSymuTmUu2esRA72gz9nIVoXbzVfeCFTyttsPUJTp3H1LmLxtplR80AOa5XlkzZiIqaO+s9zJxHG4G8dH9kmu5O4QC1zenea5pReRyD4q6QWkay/WbbD0VsaHQaxrcH5fUtp0bI7tGowKT3rTPIXAE3CLhVmRNhbV51vVUxtsgGFE3VZ9UfHyIxRYOAlt2HZc1/j940hlhdbN1eAqIhKaqLm8v8Kh3SDn2J6BW9U30OUIHZYNc75cnps5wRZgFsilVzwmMyIvSD5lADV16RwJB0wvfZRRr1e+UcLWG6dSs126XPlokTd3978wqXO8kdehzinl5SjzUuf2W6XLPcrrXYDgucyYczL5aTW46A5nMNbmEISW7CXNoB/IlqHNGX9/IiDthyAPnFUiBW3NWwbRRz47EvjKxCM0wo9AX+uwjMlYIH6pvQ6f/Gk35aWlXlt1fmCJzO0Rg6mdhDXbTUHT063eGJ6F5P0SQJS0085kdhx2GAk8TF3+/QUQPpFAeNV3p6vlPUchjKGYvJZjGEsu978F6oLaQZBqV5g+BevoQvIVdAC9raUHp0HEkJmU8DVN9UQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UICR7wtxo0cEXH7b4bIUSAKphs4NwrUggRvQgEL9+WBbEkf8dljl0PT6ACDF?=
 =?us-ascii?Q?mO13u/b1q9t9N/TLg8AtzSwN13xn3nVFEODdTINEkpvRy7mQbPxLYwuV2hxE?=
 =?us-ascii?Q?G2pRC1J6NIkg27mobAcEg6oKiQ3c30tkbZyx2c7+8IrqYbg5GrYXAjVvhCTB?=
 =?us-ascii?Q?hTVpaEtRIS9AFqWHX3byeYFGhZRR81GTIFteMCZsuzgyd/XfBDC9tosS/ht7?=
 =?us-ascii?Q?ZDzq2xCnuCj+jOStvTnrrHbpqN/nxDODnjEXmleL4N90O8rvKco3QikVkGna?=
 =?us-ascii?Q?seQnrPMSCgoYBItPSYX+m2X/8JNcQgjTKZXo3yqFhqIEQlhTYCcFy5U0Sx/A?=
 =?us-ascii?Q?K8rSL8D8eD9UyNAYiUTLz0QRxbh1M9uiU9TrXQlemST3H8pYyE/EmhroWBWI?=
 =?us-ascii?Q?uStLKOfahRyWYbtcgvAFgKHkcSIP71D67u6UR6UdC1YpgQmJVPMzIRzDs52T?=
 =?us-ascii?Q?tEaK5qta35WDLD9eMyFLoWVL65kULx/8GfrqL3kShgDqCtO1kEkOrzBKLf9x?=
 =?us-ascii?Q?RXPhujDiamtQWUJIdD7s8T5FJ62+ES7ppMb7aMmB1f4eAvMz3GcSggommK1n?=
 =?us-ascii?Q?zZH3KK+OYydLJvuPTnhRN9FX6Vz31BPfGj5tGX9CECKPlsoBSHQXekmJF2OT?=
 =?us-ascii?Q?wa21Pc8jbFaGA03WaOgZYcr6saqrmeZ2Dql8uWDKmpGsZoyLr+3GkbiY1gk7?=
 =?us-ascii?Q?wmnbe8bD+Xiw47BP0/ZmhN8QxcxE6JhFoWO1FL8/R1DzlDKTFJ/ZeBlMJYrk?=
 =?us-ascii?Q?y2ptdwO1VoUm8d2GjSynqsoLDNn7E9Tv9o7f2x8/QuIJN4BlNhRiOA/5nKHF?=
 =?us-ascii?Q?9sr8X9AC3LfmplAqEuN5/HCH2E7Y1TQjDnT340i8FiB/aaqeTWgLbf4D8sD2?=
 =?us-ascii?Q?NzbhMjT7HFBubrYk4LwBcTZ00hJkeQCec8J+4ju+cm/pKifIcr+5p/eDKZmm?=
 =?us-ascii?Q?rzoQv063KWER2AZkboJxvhc6Ulcqnx1/FrAuq0GQy7rVGna4wBhBPartR645?=
 =?us-ascii?Q?H4OUoS5GQmzarcnHC0pADgKQ0clruU3Fp3sYBQaeST+B/15/eYvRtfQKAikq?=
 =?us-ascii?Q?mX9eujypTizfyoUrq1qyfkEV//Nsbbs+FdYOse3I0x4H2HlVp4WkEsCnSYy3?=
 =?us-ascii?Q?ZJ2g6dUQg7iSe0MoM0Wyel2sKs+hSLv1aQ7qSvombYdFk6aAF3WWrVszeHhs?=
 =?us-ascii?Q?mieujc8+hNTUjSdN5o+MjuOMlXwlLzPcDtt99IiY9M0ZCVDdPLVelVmTep/8?=
 =?us-ascii?Q?MXrW1cJkldRcI6o3STgmQiLkh/x105IOdnPMr+SXBiRZSJ/deUliINcd+qME?=
 =?us-ascii?Q?lgwPYIo3pZZH0RevDQoDoKzpQTxgpNioN0vLOdps4oVnFx8ZxvWWLhS5TLX2?=
 =?us-ascii?Q?EqlG3DIOkp6jWIH/dv9l3b8MBMaVKZxDtcbfBmok5HYAEB1yX2wjci3FlklK?=
 =?us-ascii?Q?72HoPx6dWDGo/CCd22Y6cKLEvR2W9Cmj467HNqOvc+qnbeK9/JQEQ96TeHzE?=
 =?us-ascii?Q?yvwcrSsw0Yeo1h8wWWEmSw+WlmxYiwY0mJrDKD7GWat+fKtoQSzBDhlVXlTs?=
 =?us-ascii?Q?suOyhKvMcK2pVh/ZOHA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862b7d7c-6b0f-4106-606f-08dc47535562
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 13:57:21.9740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NZfhctVkN5+DfXh5ifX18jjws2Kn4nvEQXS6xHbvSq1jE4+s7wm3+TvBYQ1JuCmaIDN9nRA9w5mLkPRK/it5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879

> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Monday, March 18, 2024 2:49 PM
> To: netdev@vger.kernel.org
> Cc: kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net;
> edumazet@google.com; Parav Pandit <parav@nvidia.com>
>=20
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Due to a c&p error, port new reply fills-up cmd with wrong value, any oth=
er
> existing port command replies and notifications.
>=20
I didn't understand 'c&p' error. Did you mean command and port?

> Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.
>=20
> Skimmed through devlink userspace implementations, none of them cares
> about this cmd value.
>=20
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Closes: https://lore.kernel.org/all/ZfZcDxGV3tSy4qsV@cy-server/
> Fixes: cd76dcd68d96 ("devlink: Support add and delete devlink port")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  net/devlink/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/devlink/port.c b/net/devlink/port.c index
> 4b2d46ccfe48..118d130d2afd 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -889,7 +889,7 @@ int devlink_nl_port_new_doit(struct sk_buff *skb,
> struct genl_info *info)
>  		err =3D -ENOMEM;
>  		goto err_out_port_del;
>  	}
> -	err =3D devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
> +	err =3D devlink_nl_port_fill(msg, devlink_port,
> DEVLINK_CMD_PORT_NEW,
>  				   info->snd_portid, info->snd_seq, 0, NULL);
>  	if (WARN_ON_ONCE(err))
>  		goto err_out_msg_free;
> --
> 2.44.0

Subject should start with upper case..=20

Thanks,
Reviewed-by: Parav Pandit <parav@nvidia.com>


