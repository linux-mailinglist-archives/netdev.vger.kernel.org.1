Return-Path: <netdev+bounces-185044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67C7A98515
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C47178F2A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71E81F875A;
	Wed, 23 Apr 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Og3ZvrS4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7B1F463B
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399653; cv=fail; b=R/nCReWgUgUYTPtqW3K8yEUMrht1YI5lohzsp37PYVH1Qxgh7lHx1Gy8Zm2p53QyABh4gNV0X3CY+X5C7scp/5cyEG1M6tG48yJR3Hhitkr+M2EbBSBjFIyHTgMkzoziE9GANBG3GrVTH69K/1Fui01vKSfNOqupYrnbHteX6dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399653; c=relaxed/simple;
	bh=3906AxArYu+Pw7AXLN4Nnrwp7e04mMK5J8EMdM+LJVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VeyD9wRktZZbVYZ50KOvePel5sgbEkBNgYOUeEiYYo3y55DZ5EFxDipSk7sO9rTHoMKL57i979eED63UoER68TAAovizERfjgorrMyTKT+bJtYJNJoyjRGQQ1aDsXKiSk+ifMluvSiA9vbevurm5V6amsRNe7kzfsXanLXIGkhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Og3ZvrS4; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUrAfgzQ2JbmGr5LNF9MML22azw+mH8nZKskkplB4+8NAJCv/j3k27VTdBikc3gvhUpdydfiBRu3aotXYv+ltvU5xG/eTgyRrEOrwIf27cF3CvScKeWxDsdb5BGEkvFfYzesJxf0LVOqmhdtIWZYnJjKwMqzfTRVKQnHmNwjUxPjSjmctV7mWEwiAbHgVjw2xl8+PVIvUVWjg2yCK2g4lsecwlFLC2JndY9repEv/T4Xq6T6fYqKIb+AkMR1sAw2fg8x3x3VUhp3u1E2xXVpZ5tG6GqsYb9Ryv130l74T35ccNL1OcMUS5tqg+lq5ZMJA3kr4+lYw6Kb5k9fWSVoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF3DlP8Em5fZXdYfhLcT61jeQQHkpKHc0y/JgwrGGik=;
 b=qb0zOqwKvbU9pBM0mO31nKf6eLwr4kypqXKx4PKB3RniAzALsF/JHPCUmtCrCXh88efXgGterp9xDQrElE76rXH7kvSAueQlgDSrZg8DxfPLQpc+xMthlref99lrtgweTN6OW02gMN+4kANW0wTK2OQzKj5DC4CkvLGU0PT210UZ1F14vYrmT6xm6h0aiX96TSjbS9kbe7vkc4LMATRkYHP0wIOu0OsU/p2GDLJ489NbSBe7hTfe2BYzHDMI6hjx8O8Sx//vT24Yl/xbt+5WWCbjutWtzcjC+2sh28gNH+hpVgf738SXjvaqigAEuDfC0hqkp2dk8nfecr+RZo1kNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF3DlP8Em5fZXdYfhLcT61jeQQHkpKHc0y/JgwrGGik=;
 b=Og3ZvrS4Fqnzbd4PaCW0oYjd4pv3i2EXeXnG8m4r1T/OzylGWnHAiiLPtbwiGRXdfEcahYTYYIjFcrnGCozinqPixlknT6i5YYTnvbE4rYyDVUefmoitE5/Y+KTLnteiI0NwBZ95p30tLg2pQiUlf0bTOIutSyl4b/IM0KvxSwB7euXaLPZd7GEFfvxOhKynFhzhN3Ak0CUMHTnrqPiQDxVspnW8oitvfGTbqRba/UvDX+swfuDWk3xVIWnRwyiM8SU9+OHyTjbEhgDPRy9ZVUG/LUjeRTytWRrijzDjTdE0VISgQAZCMySa2xajX8hklP6a7LEqyC8vX1hbg8yciQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Wed, 23 Apr 2025 09:14:10 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%3]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 09:14:10 +0000
Date: Wed, 23 Apr 2025 11:14:03 +0200
From: Thierry Reding <treding@nvidia.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: calibrate tegra with mdio
 bus idle
Message-ID: <ohg5yigr3ubfzpa7aoyx2leburdkspjqft5zg5dwbmqoxmy7t4@r6lw5m6bk2bw>
X-NVConfidentiality: public
References: <E1u7EYR-001ZAS-Cr@rmk-PC.armlinux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="agtd2sevkjmj27eh"
Content-Disposition: inline
In-Reply-To: <E1u7EYR-001ZAS-Cr@rmk-PC.armlinux.org.uk>
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 154d2eeb-e859-4e7e-62f8-08dd824734d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i12PoLocxoEBxZhrRVrrVN8cCf2/A0tqT1a+y1mxxhEUmsP1n78if5Ecs/+3?=
 =?us-ascii?Q?+NpkBCaezLappKboDwiGlsBuhK8SQcWjpIYtq4EJHkriB670k+puUyq5pJFq?=
 =?us-ascii?Q?xTsv3yAJzNSS+hQCWymJlwZ1/3MotCqJw3jG1GRp34/xbTyQSlq2V/sbYwIj?=
 =?us-ascii?Q?qs6JvcSPYXLyww47SmXBT5B01DRXbAa7njT4bAVa5PKjOhRFQoE8iie1fEi7?=
 =?us-ascii?Q?lQ/G0Mgi5RWQLD0FS04Vd0cL97DrqpckqaXT3c9pukhZJKgVodURCM8ElO5v?=
 =?us-ascii?Q?BkDAtMoO5h3fCn0NSjcfml4ycqTpJsfQTX2QmUKqqOg9plBUpj7Mz7+3cgHw?=
 =?us-ascii?Q?9xRyxr1mm2pNu+eFF7duXnRfbeRUCunwziAyQTvJx5K/GR5Rd6xRBa8FhwbF?=
 =?us-ascii?Q?ofsqQ4gffQYM69gaA0ovzhC2wqzoMfAzegT+1MSsf6Xg07eXbTi/fa90CgUC?=
 =?us-ascii?Q?w6hLwC4gL8h16gZE8ZfTAW78v4ZZE/qqkX/UIUUEztTwGZOEhV9EwlU/HKXJ?=
 =?us-ascii?Q?El+vOG9ZpBIqYcXMLNofG4E8uKUicRIxvJ1LrFGs9OJKs8x+1IA7AfYjNscv?=
 =?us-ascii?Q?L5WXWMmERe9JOOmtIxAjTDNMe/tEl529x6wIEFjPrW4QoYogLbY8YQgb/wor?=
 =?us-ascii?Q?r0byEdZe9MrMN3GKhmnGYfyPufJC4Cl1H4ZipaQbrhz50031UPDm+1j7GUlS?=
 =?us-ascii?Q?QPaknl+/5Euf21nY0hAcezP+aIO8OIOUvU8bGpm6a66HDE1+KAqcB9LPAGH1?=
 =?us-ascii?Q?8ROy1FAotwwUnSJUh4wyhtXUQu9pl8PFRobc5vaZcTZDtUQVMxp2R7bkUd0y?=
 =?us-ascii?Q?t3MgPk//RxyphdpJGT0TbkgnsTbeiqpAQEmfs57xl861bFC+VSpDBPJzXAQs?=
 =?us-ascii?Q?dtOPclFcyvIrRciLuqyO7xJWyFylP6weV+VKX6BU4Tno8ECeEQYTJdZaxDHm?=
 =?us-ascii?Q?2uCVd+18dC8S9juY1eboOVuenpfNfeX0SFGocyAjiwisquiAiHtX3kaAGADm?=
 =?us-ascii?Q?LoEDicC3Cmf4Ne4OJaO1vCn3K8TC4VELLfwFawFHZMDpKN+gYwbTaF7lwgPN?=
 =?us-ascii?Q?tRnKXIAw4qkT007tuah0WVNKZUrVLRz//5mMCYgA4PwYYp+oIo5W4lZkxZ1n?=
 =?us-ascii?Q?JaH76Nwp81aOhsNbMiDegzG4YRdXNPIs2+54RWvRR45hxfE0uyxl2/zqsM0P?=
 =?us-ascii?Q?J9TL/wVc4EDFwHXXkX1i4w46Ob+19yndqgZ01aqz51ThWieZ4kjyFZdWwkSI?=
 =?us-ascii?Q?ckDFNRb2Mo1uce1DIcczHIdgqhf04W59sn2757cI2d5x3Lg9U/I22NkKYUDJ?=
 =?us-ascii?Q?3GJkmpzkI82X625R/Gb4/+pSZlA9nXjlHEldGq+cZ9RN9UzO667Yl8RHPS4O?=
 =?us-ascii?Q?X7VPtjOj6FfxPmlYRpW099CDVxcD6il8Fzzkd9FLildnlM3nYneVp+XGQFQw?=
 =?us-ascii?Q?gxw0R6ZWgqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIfkEA7bgwf5ocTe9m3jpqgq57TFbhlUq5w3Km0eWQGq90qdtNO3eu9RYY0n?=
 =?us-ascii?Q?Px/D7XBq+C/iwhoiI1U6DA6w8hEl8hcIc7BfKDgIqpglgd3YKV25YM8AD/KN?=
 =?us-ascii?Q?a8BNptkQiW844QBwVyJxo3WV2ojVicFffZp0L7/sBoRqTDibqFDVdJcFOnCz?=
 =?us-ascii?Q?/5P64OgA435yMhivF88YkMBl8ZdHpDrp+trymZ3MGgHNObjJ3b0Iqzeq4HyJ?=
 =?us-ascii?Q?/meesH2XZ4JUFV+lVjTtHAllbbN+Xtxe/nQgI73/HrInLGvSJst1yhceZsgT?=
 =?us-ascii?Q?zq5KfikHkpofvIpd5VafqAGdvd+Z+eItAHda+qRJ2jneIW2uaGSjRvFnxjKh?=
 =?us-ascii?Q?QHPOvZr/Dfb1qp36a+HdealykSUr57d25mcM+puUcBerVpIL75BtfesLTlJ7?=
 =?us-ascii?Q?hbFBjrqlppUuSeFJJmpjY3NPqr8m+6H1L9WHgu1sQWENCqfa8XIocKlh8c1c?=
 =?us-ascii?Q?/wGhMDvRZ+FlfEHQGJI8+VbhqyQ8nojv41Z5CZFywdtvmPFI2gEABQmWcL3N?=
 =?us-ascii?Q?Z5EhhCS17hQUat9zhX7zpgAibnIwwskImVBn60DZF5q+Lta8nkzOTqMSziDn?=
 =?us-ascii?Q?sF8DqmfH5AtBEc9QkXzdYey6/Iah+vp54vmHpu9Gbri2GbZ50qfkLGWWrEPF?=
 =?us-ascii?Q?MVWhPMkhM5yVb1yca9T6yodiMEh5JlJ47Rehh/KqpxSCe5L6YtfqlDvNyXiJ?=
 =?us-ascii?Q?7TUPr+e9kWe5dkqIzuGZnrSVY3IEVp7mlWVwbzvurBxHqWVtu0MNasigdFn3?=
 =?us-ascii?Q?yJvxb47E3ORS8BNZBJwqJUBhg7aJOyLc9MTy3B6ZbIIkqTLg+QOKMhWkfw3d?=
 =?us-ascii?Q?Jv3rNIFgyRUCsEFoSIg+s09xxGOtYvvDACO/UjTtLYkc+FbqjO+Tx+yk+X5a?=
 =?us-ascii?Q?yortwSH5ZA+Nf772aekHFcuckEc+DolbQmic5GMXoc1UATm/BaQG6JtVW+aL?=
 =?us-ascii?Q?Om8z+XUYY93kCym4lVN3av7rU1Lc5HY8iZJJpF5hobNwA7hbFxc92GBrQWxd?=
 =?us-ascii?Q?+kV72Idjj/Uo6NVKatnU5S1WqqWUthQTex0c2Xma3T+LKqdEebhl/agJJJrD?=
 =?us-ascii?Q?cj/xefCyqqSlPF1GwOX1HwdBv6mJXKhSHALWXPnsq6JD+AmfuIVMiRQJg9J5?=
 =?us-ascii?Q?LMVapzzmbmwGcUX+kfQiB/JY+znd5+w7sJAFmOUIpqo5ebCVAci5RlPQrv15?=
 =?us-ascii?Q?VKpIjz6fxu/N5SjJLbx6s7BsQyVOoSngtWMgB+i32Xlk6q9heO50XJdgTM06?=
 =?us-ascii?Q?zEn5oi5VSj6GTHpo2AD2zcOqGNbGdg7Y8CMvEeHgbVwpJ/y3hv+wzll2Rbyj?=
 =?us-ascii?Q?m9L3zm1Qmc+hG9rffEEJFoR6MI1OaYhVXlX2wLbgnOMrkTnd9pcmPgsjNqdB?=
 =?us-ascii?Q?fKb8Htkw45GK6Vn9HOtbP6n5qFDMdDTwEi+Tu79fuKD6zB1AXoNTV/rDd3oa?=
 =?us-ascii?Q?uPHTmowHsrWEKAzNcsn7jtXZIgGm7bEq722sx+X734z1VXb/iTFsbdm6HSil?=
 =?us-ascii?Q?atShxDcrP58aq5e+bTWJAvEQIV2aj85s+vlDxoRIf93eyIFbkuckefzImNS+?=
 =?us-ascii?Q?5hRVxvOy1/+glA32IdAxW3KBOZpj0wGdBvkbbYqoj/csbpzx4+9mU9ZklXbk?=
 =?us-ascii?Q?aaRS8G7/6a4Nf3ClRvG3RpU3erPR9yLBNEnRCaVzso3F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154d2eeb-e859-4e7e-62f8-08dd824734d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 09:14:09.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLCUl5lzDcIVa0xfAAD4c/UXnob8TjKvcOTUazA4DvsIs71g0NDhr0fa+oK7SotlZePthQmPSSqQVHoSGG3Ncw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

--agtd2sevkjmj27eh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: calibrate tegra with mdio
 bus idle
MIME-Version: 1.0

On Tue, Apr 22, 2025 at 03:24:55PM +0100, Russell King (Oracle) wrote:
> Thierry states that there are prerequists for Tegra's calibration
> that should be met before starting calibration - both the RGMII and
> MDIO interfaces should be idle.
>=20
> This commit adds the necessary MII bus locking to ensure that the MDIO
> interface is idle during calibration.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c  | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--agtd2sevkjmj27eh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgIr1sACgkQ3SOs138+
s6F0oxAAr2eMw4R4LIr+DM7JY9TL6uZe7LSzVH6qJGGUC1U05Umhm6AWrEWTGLvd
Gbl119tZd1bl8DxipPyNaAJAThP+BRa9aWqBKTHGP6m0p6wSssW2AhF3yya5a7vY
nOcX9KhZbETdtItz/gaARPxgng1fSe6da05F1j8XBqx1kw4M1KgHlgXZyA3XliEg
776AQdrMJPleTnXWLZKxkmkDXgjG54dgWHTomBcg23ujBfg1T8GXK/y5WOXTGGGv
RVs+jqpHxC4wTGJxWBDlzX7hOzJatI9RV0ITon2CoCUgxV/FjMsSD4uVP3cfZv76
Ngl4DF4Qm0OqF1ZSR04tKM/gzyx8NwHXU9Qhf/D8THllqjjwyu7tRfBO/h8V0UlQ
XLOi5F87S8SbwkH02/vOjPpJXbDxt4ujXR5uJ4ov2JUJ430NouQzc/mbEX1FyXFK
skVrsDtl05e6ximsOFhVIURLy9BZIKu7iH3B5gPFwfO8u5BbUv+i8vGFH8J7bpEs
cvxCgUK8SCbJOsvH6eX0e5Tw3gdnMF3JEHfjPqON5mNP9YwPtzW5PqjZKvzCGI6y
xzVK5ANeuGb4nALyYFEWB64DcH/8hAoj1tc53JscOdbJuRCzNXgYugj5xncIhloo
sh7HQIbPY0hpYkCsQit5Y/Qw9Y0b/EWVKy1yG1esxS9pHrN7DzI=
=GcIx
-----END PGP SIGNATURE-----

--agtd2sevkjmj27eh--

