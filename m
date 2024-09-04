Return-Path: <netdev+bounces-125212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C196C4AE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010541F26118
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CC282499;
	Wed,  4 Sep 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SaWeR530"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5236811F1;
	Wed,  4 Sep 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469385; cv=fail; b=GWrlyoslbLiYE+d72SeKatIAUX4totEvGy9GJwcqsnRoke6n34B4bPXggy6BOvCioW2mybKDi2oZYlAgsNrknQunF6Zox/HwnpEWXEJjWJYWIdnFtIugYCb/WotEBuUEFMk0LgKoKCOY+IW3hTZSKK7mc8WRejJZMb1py3lIgMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469385; c=relaxed/simple;
	bh=+aMCVnft4KXWKU6iY6wZJLcu9tB/3dAGaYm30B7bPVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mc2IPtTAJ7mIiwT4DeGoibhwLgkAQFQd/IpTw2n0aMU1o8x40pNDoA7Upw0YQcidDbeZKM/vs79aR0DmZ8MA6NNqoi9hjVmx2PHT/cVWTkuxVY9stAEnZerpW6ZjwUKI3+LpEyqaXnW8HMQ6kqPtczHKs2EvLH3WG3GyoA3LAhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SaWeR530; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnTNoDszmI+6dqvVD8SEvI8LhYoaI1NyCDppo3jtVcu3Gi1yFg8LmsqLbE1bSOkUIIhwZNYJK+0XPnB7QHUwc+Lf2d1K3eIqeKxHmI4COxVohZIFEOloaTMcmQpjw+9wM4v8AfdGZ3/R9S6f2AymzGzVxhhMJDy1NlYyUl/+gO5DMqmalyAhkUxw4vTlDAO9SPRvG2mcCAsvazR3cB4CUip7edoOjcAUMvz2zTJuU3rSCxlBzCIxMxsv+Hmr580uXZKC8ZgP3PNS1vEdWQgYDJZ8KfWim3UVZ6uBKZlgDBBWUtgIJlcaMf6xKsgUHMALlH6JmuK0AOyWv5y3DzdmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lvu6GEcDqv8uL7VOzGZuxf3wicq17W8jIgrU3C9Ysqo=;
 b=tOEHoSdDYNDzmdpjlLAZ3EuMBYI8g5hEWvHFUBWHfZQY2YgjVKZu8xAmDeA0ekPEytaTtxMM9I7CY96ogK6qgKdoKDAJP3n0ToI/gpZdEVFAPtCDjYTDjpcFQvZ1nzaNnBV/2AgaM4GZjN+iixjL0Q2AQQghvybvVM9qi7PYz5dpwMF3Sah3NDFm8edOlrIyIt18rtKiXUlLZGsfx4ZMz8Fl2q8KkcGt6fx4fcxGhPu+u6Y0DcCxUyelVguuBkjxOa43bE/s1V/QG+cPT3L4RD4iLhK1smSmbXWfnxRJvXQkAQ6ehVVrJFD5p2FO19aThbBCbKcHbYSXK8kIp3UrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lvu6GEcDqv8uL7VOzGZuxf3wicq17W8jIgrU3C9Ysqo=;
 b=SaWeR530pfAAn7X/XzicGHcM4egsOOuggQDMgDWqH01FShcx/nXzRZmAiJlGBXFbsDwkdorga1s+/ztcvTu+COUOg6ZZB9aZQbaWLA/7DAdv1D8BjoD0UQDv43eRb6LALvrhK9dYl2RCt85aO+VKnI8eNk4CyxUQ8z1V9F+IloU=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 17:03:00 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 17:03:00 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] net: xilinx: axienet: Remove unused checksum
 variables
Thread-Topic: [PATCH 1/3] net: xilinx: axienet: Remove unused checksum
 variables
Thread-Index: AQHa/jE2l5K+uvPwLUOaF43hnhChabJH2b9w
Date: Wed, 4 Sep 2024 17:03:00 +0000
Message-ID:
 <MN0PR12MB595303AE2C49E45A0CF435A1B79C2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
 <20240903184334.4150843-2-sean.anderson@linux.dev>
In-Reply-To: <20240903184334.4150843-2-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SJ2PR12MB7823:EE_
x-ms-office365-filtering-correlation-id: dcc92c62-3292-44e9-fa34-08dccd036e9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VRzGmfOpYYv5COeq7Rsq2Wpb4+CZ4akqEOl/uDD6kQFBjaclZzPJmqamOSDP?=
 =?us-ascii?Q?S5kQTeK1VPSh5jbCII9F1S6xdjTlr275hXQmGnfQj+w3yuTXGCUESqDXNplf?=
 =?us-ascii?Q?O38SDkqxHFD9dbyIoKipOewkOJrStOpec055wrokQxElFygPV4S1MCN7aR+p?=
 =?us-ascii?Q?+LnA+JvIPMhdTmp2BlREHjQnGYLl6ZmiqKZhcArxQcSj7AEGne/5McUUQjqb?=
 =?us-ascii?Q?KmKLYjIJ6S6Jxc035L4TF9ohApwsL4iOSXsqL6Qkz0SRV193a046L38Ws6Ra?=
 =?us-ascii?Q?ZNvopkCEHJuG5ED7YWNvMNwsHhCynV6YpWdDK+ISRLT3jh9AL25MwxSBptcF?=
 =?us-ascii?Q?1GJU6NJNzLhMAFr9Bu7+JtrW73ilspOrzGvVuASRYMxyP5R6zxUHCGoT928O?=
 =?us-ascii?Q?gC0V8s7aJHnluEzSdmqovukjEaD/Xw8j5O0IhnlkNY179+383eos0ppbXKEe?=
 =?us-ascii?Q?fubZwIeGIwPMm8aIfcIqUf4GPSr2MK02SvHdhQCE4bKJWtIS5zn1HFVJy4om?=
 =?us-ascii?Q?GSzePaO98CaLFBvRcsFhCoOyGRufqjYmVWkkHE4TbadMSwBGhv6uvvUf/XXP?=
 =?us-ascii?Q?bJ91OA2HDkogmjvBAVSAAp6WLwGgU9Ymfj+P6/X+AFuYEpmy93TgfIwWQTgE?=
 =?us-ascii?Q?/nZ0h84IdtSZGMLxfnDF2J/+FqnQ7FcFbHwY+rmAC1qRcTp4ZolwhY2cANNt?=
 =?us-ascii?Q?Z8tyiRFlZwZUnZys1sVvw+MgI/vIFErRkZhENZEqPvXlHxmAfWo1dZ3eJ7JY?=
 =?us-ascii?Q?Sj8o+vbnXLjAD2B3G6wq9paEeXr2+J2pD8Q/gSxAay6CIstb2Me12i78Z+va?=
 =?us-ascii?Q?0tJGIJpWM3XtqgUI1cEF734/+gvLxYg6yr4ZdNhnnBev7Kv1YrcBSsCvJzXq?=
 =?us-ascii?Q?gP8US6M1l8Uhyr8moKMgbu9sZlRBNoTL7oNlVB1Lgf9d/JfKOQN9aiUiuOEo?=
 =?us-ascii?Q?yM2311lCO2m/q4qWqztFsXiBwVMNtsXthC8mO17WLx/0P8NoRiNHckPjnz8F?=
 =?us-ascii?Q?oClHVllJ2F/D3aB0fKhzBFZVbw934AESOzy5hqYHep7X0hUU8vKEBLbc/nRJ?=
 =?us-ascii?Q?anWZpLGKf4gmnxwGYaBTKIg8VedRgN6vvN//E42uzWFkplSxKX6iBcB8r8NQ?=
 =?us-ascii?Q?j4jEclxbxl/VyzfXSdqJpe84aqAFAUjNf7Ln8z5UwcB/aycF2rIQsxpJNoaQ?=
 =?us-ascii?Q?FKe4XGUEf6BXXCHsyF5f5wJ2TiYdzGMwN2N+GSRgpQ9i2FZqiQT+uIIja/Z3?=
 =?us-ascii?Q?p7KVI38EgytBSrd1ptMrAhGH+Oq6I1qbrxUmBXhwhzdYM6VWM9gffnl5OoM3?=
 =?us-ascii?Q?Au1L9AYzuC0rggTEO+EM3kp0zy9qLsKlsazSuUBuejscE4xX7qd7K0F2fi0R?=
 =?us-ascii?Q?/GsjXK3jE6j+EpW31qya1DZd5pPiP78OC8AHb+9ugxxr1qNBXw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KBqGKPB+XSUz/3u1QgCgGs7/ffVzPvr85KifDFSmK2GuU3+HaQ4nl/TT/xbi?=
 =?us-ascii?Q?klxcqHtEctgt1PksQ/eTy5kSdnT5S6N9bVA9cBAVXCGRGgHG16BmeX8l1RG0?=
 =?us-ascii?Q?gF2BFVRJHZbx6YVuxZcucTGqeJYlU6ui50cKVH+t+EYfipRVYefifcyPhoo5?=
 =?us-ascii?Q?JWBPcLr/gr6jH+4XH4QKMUnXo2qz0bzVpkgV+PrRxxksdY5qVn0LBxDsrYdC?=
 =?us-ascii?Q?b+u1wloPQJ9fsfJ3+wK2GDcouZP9BvCJ/2hSOys8c3PKuVq9nW86AtDblPBb?=
 =?us-ascii?Q?+Qmllp2j21SWanSzbiO3Il3fVOK3kVILSL0mqBnN9eJ4iX0BGpNgO1JQ7/DA?=
 =?us-ascii?Q?VLR9vTZXkSdYoLId6UcTO+L1uhxNdU7wtB37+fDFCM6/RS7USyqgaz2uK3FH?=
 =?us-ascii?Q?X8LQS2U39AfMySQC5g67xnkyz8QpiT7CroPAks3xITs4AzKB4NlohcOpbuGo?=
 =?us-ascii?Q?Fgg8uoiZzlmP3+d4IM55XrqfoTh++npvDBcdoRIudxe68oGgw01iEGgZfSR9?=
 =?us-ascii?Q?gcFm8+jgSbPe0bWmVwglRc63OJhQ8h8QH+M+R6vjYKaxhyvo5F+OKbHrPqgR?=
 =?us-ascii?Q?q/yAF1GZ7kH8epZQ/eLdmeXufOzk8tF3FCbfNXBi6r8UbVPLkix9uxU4agE2?=
 =?us-ascii?Q?jchN8hOxzf4qhqjduPZLiTHUml9/OeuBtNX4tH04uu3thlw+QSitH+mWi7gH?=
 =?us-ascii?Q?A2KsDCB88YlkcWRDgQpQ/8mV/dWeUPQdK6H+zqdUpJeLNSIGCDwUEbdVrhFC?=
 =?us-ascii?Q?NgchwygQI93j64g9x/+GFatD/ceHz4UElwoC2YTeeoh212iP7rDJW8bYdwD7?=
 =?us-ascii?Q?wq5Gu1faZwgfGOy8FPpzqweb3wFMf3GR4WUGFhZgfMJvz64Bs8Vp3UTyn8IA?=
 =?us-ascii?Q?LrBgYWvT5m6bnnwZ2cFZDNfuNRRuU7kNvFdRY+tNOoi0WW/NdvugTsaxBJYy?=
 =?us-ascii?Q?m9tgu8i2t+e7aMni9kbOj+e0NFTWMZ3SNb2VvD6htb+gvclr87qbboQAhIvD?=
 =?us-ascii?Q?VFDCPJ+/2+Qmc6fsPfBjK6adQyceMg/1pfi/4H84D0FfPdRpdUAVWafpswNK?=
 =?us-ascii?Q?BHbO8SHcwM0KoVd/XuJVHvPCUzTc3nc+PbgCaPMD3sO5To2TzZ+Ed2muzgkk?=
 =?us-ascii?Q?/ukzS+MXaA/1m12R+6BhNLcyhGhiMNTANHqNzLhCbdnTJSydXt8Lox636hPi?=
 =?us-ascii?Q?M+fdrxqUFSU0eDih57lIajdjYyz2M4p9RV5FJtOC4hKL8IaeY8irGLjwDLLt?=
 =?us-ascii?Q?/PEDc/yO5NOkuo0hb2sJuJ5y5BgRIQX5oC8xlsyaM1+L2ielAI0N+SWFeGUt?=
 =?us-ascii?Q?EHksQfY24uLIAqmEvsRgwoZ2v3Ml//Xl9ygADxn8sQ5Q+o+5SR+TYBMcs9RH?=
 =?us-ascii?Q?s4ZYnhagk56tAR3SOrSNXPFSjx/okhIBDPmWrvvH5rqriQTKZPe/2aZ7NV8r?=
 =?us-ascii?Q?UijJVdhI/LljpkEoLOXgmR59vXHDmfAzwiPjXsdgdf0ScHZ5NyE8+x8i9WnI?=
 =?us-ascii?Q?+raCDbGZ/hlUeEMBvF2K3hmdiS8OhtY6E7XuYccsr1Y6cqnw0OUezQ6jAyKn?=
 =?us-ascii?Q?Nggh2y8WszFab8IoOrM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc92c62-3292-44e9-fa34-08dccd036e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 17:03:00.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h075UVpvfr5R0F7alKrLT9uJlw62A6bNhM6BFKbecrXUoFrAfCJsq+0FO3DU0Iy7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Wednesday, September 4, 2024 12:14 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org
> Cc: Simek, Michal <michal.simek@amd.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sean Anderson
> <sean.anderson@linux.dev>
> Subject: [PATCH 1/3] net: xilinx: axienet: Remove unused checksum variabl=
es
>=20
> These variables are set but never used. Remove them
>=20

Nit - Missing "." at the end. Also, just curious how you found these unused=
 vars ?=20
using some tool or in code walkthrough?

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Rest seems fine.
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>


> ---
>=20
>  drivers/net/ethernet/xilinx/xilinx_axienet.h      |  5 -----
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 12 ------------
>  2 files changed, 17 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index c301dd2ee083..b9d2d7319220 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -527,8 +527,6 @@ struct skbuf_dma_descriptor {
>   *		  supported, the maximum frame size would be 9k. Else it is
>   *		  1522 bytes (assuming support for basic VLAN)
>   * @rxmem:	Stores rx memory size for jumbo frame handling.
> - * @csum_offload_on_tx_path:	Stores the checksum selection on TX
> side.
> - * @csum_offload_on_rx_path:	Stores the checksum selection on RX
> side.
>   * @coalesce_count_rx:	Store the irq coalesce on RX side.
>   * @coalesce_usec_rx:	IRQ coalesce delay for RX
>   * @coalesce_count_tx:	Store the irq coalesce on TX side.
> @@ -606,9 +604,6 @@ struct axienet_local {
>  	u32 max_frm_size;
>  	u32 rxmem;
>=20
> -	int csum_offload_on_tx_path;
> -	int csum_offload_on_rx_path;
> -
>  	u32 coalesce_count_rx;
>  	u32 coalesce_usec_rx;
>  	u32 coalesce_count_tx;
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index fe6a0e2e463f..60ec430f3eb0 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2631,38 +2631,26 @@ static int axienet_probe(struct platform_device
> *pdev)
>  	if (!ret) {
>  		switch (value) {
>  		case 1:
> -			lp->csum_offload_on_tx_path =3D
> -				XAE_FEATURE_PARTIAL_TX_CSUM;
>  			lp->features |=3D XAE_FEATURE_PARTIAL_TX_CSUM;
>  			/* Can checksum TCP/UDP over IPv4. */
>  			ndev->features |=3D NETIF_F_IP_CSUM;
>  			break;
>  		case 2:
> -			lp->csum_offload_on_tx_path =3D
> -				XAE_FEATURE_FULL_TX_CSUM;
>  			lp->features |=3D XAE_FEATURE_FULL_TX_CSUM;
>  			/* Can checksum TCP/UDP over IPv4. */
>  			ndev->features |=3D NETIF_F_IP_CSUM;
>  			break;
> -		default:
> -			lp->csum_offload_on_tx_path =3D
> XAE_NO_CSUM_OFFLOAD;
>  		}
>  	}
>  	ret =3D of_property_read_u32(pdev->dev.of_node, "xlnx,rxcsum",
> &value);
>  	if (!ret) {
>  		switch (value) {
>  		case 1:
> -			lp->csum_offload_on_rx_path =3D
> -				XAE_FEATURE_PARTIAL_RX_CSUM;
>  			lp->features |=3D XAE_FEATURE_PARTIAL_RX_CSUM;
>  			break;
>  		case 2:
> -			lp->csum_offload_on_rx_path =3D
> -				XAE_FEATURE_FULL_RX_CSUM;
>  			lp->features |=3D XAE_FEATURE_FULL_RX_CSUM;
>  			break;
> -		default:
> -			lp->csum_offload_on_rx_path =3D
> XAE_NO_CSUM_OFFLOAD;
>  		}
>  	}
>  	/* For supporting jumbo frames, the Axi Ethernet hardware must
> have
> --
> 2.35.1.1320.gc452695387.dirty


