Return-Path: <netdev+bounces-157813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E8A0BDAA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D321881981
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFE93A8D0;
	Mon, 13 Jan 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rPxnomgj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0214A4D1;
	Mon, 13 Jan 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786174; cv=fail; b=dVyejUrfZtEgCThXJXj3+C/dwC8+Jk6xlMtFOB0IVNdFC8jCClMRMbWc2cM0BE7IUH1l9sybicrTInUWtKOVdg7VR2SMHpUX9JTpAsH8oyvo3keaUzu5OnzILjGKTkaXPmwsUBF/bC+jlHGOxb+eeHSpxkXUIKIhIrP/wm1Yueg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786174; c=relaxed/simple;
	bh=thntNetpq9+B7TXe4ResnR2OhGFESxoiEhdhZKcP1QY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QDrsuhFQ30lyuKmafUQRu5zh8TBuENGKdBYhzq3ShTxi4B596LWIIDs7FKs5GKrNXrHbUOJk53VPxrqoCZ0nmkT12z6XtrRO3GALHCD8iG+nKpZu6mfRE/TCiBM/JUMGjVszeVOTy0UoNjPwAMYWbzPp+6d5lQPT+sV9dQzPQqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rPxnomgj; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfu0js/DbJwhhA3PjleFGM/wJW8ORSgKxLjbcAd9wApAmNF8a1W+bedS9Xad/vv0W5HTic5ZllsLRKfWov85KEKiMbzqEbQO6t8gweC/Hewsb1j20YJxQ0uty5UdLQGoTJnoEzeUR3RimyGISAJJ4svu00+kKkXVHWAaikEvK94mh82Lf+JJEXyBlt7QIjENyyY/qBYpF93elKQhSrJxmNO8OpK0WQxu7pajc2zImnnaqP8gmrT0zJU5JkfhFubquwCt0I49GKzLnA7KcVdoFzzPGYWaA8BuNzOhrA2vK7pjFtypIFqdne5mN4sQozJpEE6cJDitB+DT4VGX5cwd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ih4TQsGi33I+NDjev0OgeD34K68qDcxVxjqWxI1rxc=;
 b=u8NwS2MeI2IjiXNilPW1JKgsnFLqe0trpenWFfpGePmKsT5G1ru/0HrwtJpt+/CGfqQYCPKjrSdhSdFbJ19y/II/dFqWMjNI+wbfRCZfWsZpiACE9B66tPn+qKAy39U7JpNfkffIjBup88XZi9WLDJlUYTSv12mBQyOxqJQRBo+VsdbdWTpIYEC24emIjlEZQ62p8ucDaHdF+u1Wb7l7ALrLJAese+14ja4iH9vJixnB/kAGE4aTM7i39ruVx6pBPWwekG/oVqiJu+WTGFL4CLV/78rF0QIsQ5QyI0rVFihe059M/4hXBnSBB6HE0H0tidBqveTgUSI6totxvrl0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ih4TQsGi33I+NDjev0OgeD34K68qDcxVxjqWxI1rxc=;
 b=rPxnomgjJG7kOfcGDwdFcNPSRfH6+WFJT59bJ0thIe9LtzzA8n0SgAUasd85P0+57R2+IvSv4C6JVOW6j3SjFc0iyI1qvAMNCMHon+G8meSz3QlJ60KNikyXrmhuLEjGybEuLyHMP5igDWGOT2yHJ1gP+sGvuGxs3QdvAqsJ8K8=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 16:36:09 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%3]) with mapi id 15.20.8335.011; Mon, 13 Jan 2025
 16:36:09 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "Nelson, Shannon"
	<Shannon.Nelson@amd.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Simon Horman <horms@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [PATCH net v5] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
Thread-Topic: [PATCH net v5] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
Thread-Index: AQHbZdh8u507f+QAB0CFZ0mPgE2ku7MU5mqQ
Date: Mon, 13 Jan 2025 16:36:08 +0000
Message-ID:
 <MN0PR12MB5953D13156EB1257EC961C9BB71F2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250113163001.2335235-1-sean.anderson@linux.dev>
In-Reply-To: <20250113163001.2335235-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB7940:EE_
x-ms-office365-filtering-correlation-id: f54846d1-1298-4ea5-2580-08dd33f06243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xzIHgTwuRwGtSNk3L9zlRCu9l9frbrxKu0E93uthez6dZF0LnAMagrvAeLCf?=
 =?us-ascii?Q?wrSoxkac4z605+Nq+JpV57SdP17MXnzshJO/wBKHTguHBtCC6Zp7cw9Zw5rI?=
 =?us-ascii?Q?5J1SwGZ566wpHQePipiR/2GXybykNyFxut/8rIYYPzyEiXXpEYW5smPwAqBh?=
 =?us-ascii?Q?yupsvSZSNstIOUj+d1Bo0f+6CcR1zehxETVeoTMb6ZZPnauCH5gufLIF6gKU?=
 =?us-ascii?Q?pH50JopeKxlua5DIa/P8tneImZGNUd4ZFTScFk1NAsBeI3Ph56cvkMw/0gUO?=
 =?us-ascii?Q?f5QUYQ2AbYH6w4cjVZPNUEOGu9lpx43zfy9WYmi+NKBopUPhJGsApZzBAuQC?=
 =?us-ascii?Q?Cvyv56la4SD65VrF8ZlRwrX6zGZpbO6WZLTxyqWE5VeXCS5UUCIqIh13ISkw?=
 =?us-ascii?Q?kGLAiYY2lrAWJqKLIq1UMflPkAbKlugO+otjDXmgIfJyCq2R9w+eQFbFUNM+?=
 =?us-ascii?Q?rB0zwnGMqBfbJG1eRMI8uRLhaGFLQ6ErkUpt2COvFXDi5GdLZnMTp5snwb6L?=
 =?us-ascii?Q?jXtuHWD0ZbN5QIbSsJjN197FK14BIhuoCnybp+NIyU0ADiNM4sKV2tfTMnlf?=
 =?us-ascii?Q?c0NizcDc/5CUz88V3BZlZoZvG3MMySGa8zUEQuNrc5atstqN9QDcKMOtwZOi?=
 =?us-ascii?Q?lsxbNe2/FOm7Dw2DhVCTmfh8Ta/aNLsSF21O6la9BFrknX/BAO+WYBxbNzh5?=
 =?us-ascii?Q?5ja/xV4DJ4Uavq4Beyrpkxmwcve5Z/aiM1qWdyZpljtyeKxJj8fDqvBIORJH?=
 =?us-ascii?Q?RIY1UfusCMapKMYx4yuX7lXXx2kagvbxGTfGUbKAwWmYVLHKPbVEdn/Yi74j?=
 =?us-ascii?Q?6xecxXDoOmGpEzJKCAChtzCZtDz2cy83HVpOptsBqhnRzpPWrqs8klA3L8Pw?=
 =?us-ascii?Q?LY8Ju1telcJqo3XcCtOeXwKPo4tibrSLVmW23ErVj7ZKb62Q9WY/1R+sxtX1?=
 =?us-ascii?Q?x1XCjCwsdo2VlSRvyEfiFKAl9G7OUJ/CNXrXj7rEZDBewcG7XrcQoJys3WQJ?=
 =?us-ascii?Q?bSQ6oCD6cC7VlWb/TGV6+oiu9Ls1pfglaMRI4tDiIP66WAYuNqZ9wFdIPttq?=
 =?us-ascii?Q?dxmAr9vJuIhog5Pa8uOIwInrzMslCy1q8EDvvbS2QMXDjJGpeglGchb7uV3L?=
 =?us-ascii?Q?gipXXmUgeItUFpRzxaa7K0mhdZVWqK6boXnVP/Daz+RUONBR8DAL8lMi6AoX?=
 =?us-ascii?Q?nRxXDsRUAO5bkEucD0d7OxfjRmk89oTO9b/00BrKV5zNX49MwcpkNDhh0ydm?=
 =?us-ascii?Q?CGks0b55QXQbdq2XmUQoif9wZkaVkcqWw00DS+sIDCgz9yBHPMLlnddU0pvc?=
 =?us-ascii?Q?EI3n9VNjkGOdX62n3YCr7/h+g/stFfpOhHER2RS15eBKp3sS+3BkmK2vGtoS?=
 =?us-ascii?Q?C+7eIhNHPuJ0E60ltqgycWosBCeRvwoRrSIMOHwIgTnUkUacic3weafwk2oh?=
 =?us-ascii?Q?0R26ecxi+Mf409m147r2167GjtXwyrW+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EO2m7xrcuXDzeLhBvFPBva4TPLdOXwC4ESelt355PBGUq8IG3pRifFlSeZFu?=
 =?us-ascii?Q?gDKqLs/GlYDkiPuS9ShQ2n/Frb3zgZ6Fhg9CId4rrC+LsK2rNQMOwDoIhiKh?=
 =?us-ascii?Q?wnDKFXYCM3o0rsPziGQbPVCEU03pvvg6alngLxs2QUCTZddVurVJVO47uqMr?=
 =?us-ascii?Q?pc75K1jvqFP348KKNR3wHDoumGTW895YXKgU96gJodTiZZZW3xcW1VMXUqJx?=
 =?us-ascii?Q?CCKGRY+L9pN7ac0NkPwSiSjeQgMD8qVEwLpVw/WuoBYAqlDpjGcWPPSoLB7D?=
 =?us-ascii?Q?9SvX1MFD/Xtfn6GWE6gP34aPUsyM0Iih6Bf7qKhzIFvihnoVh38d/tfZ7bNt?=
 =?us-ascii?Q?4WWDxT+FJBLLJqlMe4mBwqLwHv1LLxQq9TwAvuQ0f2IAyrba5hfaJGFerCTY?=
 =?us-ascii?Q?8TzfYg+vbhQ3mQhVCB7pIMvKf0oDh1Gip9BC/qE33ExWxfa2QXLuRCUZEdAs?=
 =?us-ascii?Q?QyYGqYpnWGAOZIw9NjmwLHOWXQDN9wGkkq2mg3wscuh5XycdqlEgjy5majvj?=
 =?us-ascii?Q?yhUmaA8HY99PZzrYseHwjtuCUmC8FdjRla69j0HGrAUTqVoRew6Lgcj3qBI/?=
 =?us-ascii?Q?Igki9TRGriCsdrUl4/pEidzUVV/JEIggNzprbliNYEdW5G9W7d2HcQGgSw58?=
 =?us-ascii?Q?dIrnaMDMuEDS2DBrbx7c5izBno1WfsffAlhRi5Cda/wQVXqYUUbmYphBpgYo?=
 =?us-ascii?Q?mKrRMuphs/urqRtYSpVhU7eSh+bOmuL2n+HuI/g/eSE7UCF3/251jrBBxdeZ?=
 =?us-ascii?Q?1RVnNMfm2fOfflajHi/SmCF92nv1eIvMxVWiKsIlCI2HLcNCOc5TfrZ9cgHW?=
 =?us-ascii?Q?+1ZBsI6TlAdcdEn88YIwtl1ScFXorAt4MnUGmRIVRMHYun13a1z9QNonqAn/?=
 =?us-ascii?Q?fob0z7pRAfNsKSOXoJuYEV9ksR4a38um7WAv/PHCH4p60J0gqqkU5Z+XfN9q?=
 =?us-ascii?Q?aRJ7kwdb564gHHD8XIqo6efUsS8PYrfB/WMpNA8Xi0w1IwVpPN02jovVUFyw?=
 =?us-ascii?Q?kO3ATjb5eWSHUalnhJ289YQ9E61S/BZP7ywJ4NHDlilagS25nWYYJRPnqxJC?=
 =?us-ascii?Q?JIEcsWtyt+qDk647yQoufuwWrGUZX78qz2oYxseDH2MCFzNKE4ffqsrHfwgl?=
 =?us-ascii?Q?UESWfiBAFlH57fdrBLpcLxBcfH9baFW2mPSBaUtmMMj06qANKd7iEBk5Beir?=
 =?us-ascii?Q?QFf9DmFQIlzs+Idy8XHaLyf2apTw6xqPS8qj4UBORljm2bMYeH/+R6mgbkcG?=
 =?us-ascii?Q?zVaBVcXqIHv1OOI/ERKdS11EKSYxzwxxVWwHnAFDHU8gLpAFecvyLlJ+M5zy?=
 =?us-ascii?Q?0s9aGIwk18c+FfLXLVlQnyCvxFppGFyFNcMCIW2ttquHYGkqLl4uC7i3q0/Z?=
 =?us-ascii?Q?twiG6Xcnn5vVfet24RXohbBRYtXVcFZK5fQmM/HmNzZv/y2m28qCmNzfnGRD?=
 =?us-ascii?Q?656z73hDJH90JpeasDN2uXy/Fv2U6QZzUeNa1ZZ9D03oJHsDI7VVdIGZSU5N?=
 =?us-ascii?Q?JtnMxQQbMMNsnz9pVhJ+xjFvCu8/wW1AxIJ+WvJ68fhQBVF4idFwNXQpk0Dw?=
 =?us-ascii?Q?gohFH0SwL7LMKGE0AH0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f54846d1-1298-4ea5-2580-08dd33f06243
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 16:36:09.0061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SS4qchY8YAdisu+ve+Jd0VzX6/S/9PnRzlVNsxrsC46TZQN1DqcFiuLoAUmPusyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Monday, January 13, 2025 10:00 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Nelson, Shannon
> <Shannon.Nelson@amd.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; Simon Horman <horms@kernel.org>=
;
> Simek, Michal <michal.simek@amd.com>; linux-kernel@vger.kernel.org; Danie=
l
> Borkmann <daniel@iogearbox.net>; Sean Anderson <sean.anderson@linux.dev>
> Subject: [PATCH net v5] net: xilinx: axienet: Fix IRQ coalescing packet c=
ount
> overflow
>=20
> If coalesce_count is greater than 255 it will not fit in the register and
> will overflow. This can be reproduced by running
>=20
>     # ethtool -C ethX rx-frames 256
>=20
> which will result in a timeout of 0us instead. Fix this by checking for
> invalid values and reporting an error.
>=20
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ether=
net driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>=20
> Changes in v5:
> - Fix typo in commit message
>=20
> Changes in v4:
> - Fix checking rx twice instead of rx and tx
>=20
> Changes in v3:
> - Validate and reject instead of silently clamping
>=20
> Changes in v2:
> - Use FIELD_MAX to extract the max value from the mask
> - Expand the commit message with an example on how to reproduce this
>   issue
>=20
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 0f4b02fe6f85..ae743991117c 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2056,6 +2056,12 @@ axienet_ethtools_set_coalesce(struct net_device *n=
dev,
>  		return -EBUSY;
>  	}
>=20
> +	if (ecoalesce->rx_max_coalesced_frames > 255 ||
> +	    ecoalesce->tx_max_coalesced_frames > 255) {
> +		NL_SET_ERR_MSG(extack, "frames must be less than 256");
> +		return -EINVAL;
> +	}
> +
>  	if (ecoalesce->rx_max_coalesced_frames)
>  		lp->coalesce_count_rx =3D ecoalesce->rx_max_coalesced_frames;
>  	if (ecoalesce->rx_coalesce_usecs)
> --
> 2.35.1.1320.gc452695387.dirty


