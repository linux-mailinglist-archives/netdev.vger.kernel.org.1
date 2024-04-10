Return-Path: <netdev+bounces-86524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970DB89F194
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB32E1C2210F
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466015ADAD;
	Wed, 10 Apr 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ULZCF6Jj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2136.outbound.protection.outlook.com [40.107.212.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28415AAAE
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750350; cv=fail; b=gkAxsj8zvTVhUTXt99Kd9cFtHOEND2Oe7MR0/evl35USVLQlckSAIi6LSu3bUiQU1IoyIKgPhEnYxrlQt3XSOE5/UHWYnmbflvJudvbjBr883oZtgU04pAH+4B6XE4UmiTRVL16vgM6o8WUoqyGIUwDB/gls7xSXCylHDo5MVDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750350; c=relaxed/simple;
	bh=0g+iJNsSD1SdfJbkfkNX+az9V6cbDdm2kF9Lbufiw+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dRBUAiCsogpEKkmSscWzNQGT6Wfw7VNmuDVOLPfU3+U7VGIe5UJZHAqviYxDgUWedD+5VMh5eBdePgBQxmAvhtJ7A+TwyKD8IESYKwIItl8URF4bLpj+ehrk6Noc4Qht0GqJ1RXulJQLfC+tQM8Br2oRQbP48+n4UHU3P+Si8JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ULZCF6Jj; arc=fail smtp.client-ip=40.107.212.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXlW6mkYyimDycuqEV0Kr3jlZK3lDabQB55TkAqcYDrmce549sBJIOkLglIvrs9pECKt2qh4/GLjYSNctmmmsKqyKXWzdkpzvPNgbkW2Ohh3zW5delAfhTwECSobFv73YhIvCW1FVGHukKi7ccWyBDCVL1KDXsSdB66ZmpK+JOccRhKNUdJt2Vn6MtnXpxmgjAxi6dNPvfdf3RooJLn+4gnhuAwos+lsq120LeA9L1ULAlofzDUdrL+RitxLKEWS7bT5s/3t6D8nTAjAY5ec3yBffNDy5sSDryNYm3FLB4FK51WBhtzO9OFKSv74myTMFS4nZhV/m+BV3TG1AaW9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2EBx1ek62fYsp61aITbxVaKKLxU7ms62LyaXy09ziM=;
 b=fXWN7U7gdKkttpPLkzh3JNzJssJcaf3lv0Itx3KxKCuYzZkmXGEJum5r+qhM1oz5H0/3P0GeRyz0qEfZ9M6jlZ8bc7KhJ/uh3p+v/p34rpCK7pEv3r3JP8+asLtPGAm63MRx29/HHPgV/ZqCVB1BBmnkHoxk63jSq5ufQuUFOQNtr2lAzi1dwlnVjrdvUqFip3++BPAkOjV1CVNUKnGI/eSI5eMSwcJSkECcvcW3zzfs/6zdWIA9FmBQlGbbdFZlgvHA3gwzk/spiriwujYvv1XV4/mirmj2TPGxojBMgg/MyFLYxzF4i6MWi47NR9NM8MCxg5NRmEUFCwzPlYgfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2EBx1ek62fYsp61aITbxVaKKLxU7ms62LyaXy09ziM=;
 b=ULZCF6JjG8+B3UCcmo+fBtatXt1gEhQ8SKpU20gKhdna8qptgN9VGZW8JDXzKmKJc0xuI3Qy8HH1dsgKfsVEs+5taaoEKSx3wETiW12B1tRap3Ix8aeFfGkqg6vNUFrS9gmoCgGmVDpimhVjvXkqP8hAQroFVk/98CujGJN6C6xo15xLhnZOQKomu/jSV0+jKGtiParRy4ambskwVaVmB16rq5txwZO7Fzk1vHCkrQjvcJhE9Ig6s1KZlEkFeQ/s0jIuqBrUwLGDrAWdcOPGfiwyspGptn5mfq3MHyZlh39TddhfrfSVUVXWwsLRIT5k/q0oVuc5mUKb5rBfgzQdXw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:59:02 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490%5]) with mapi id 15.20.7409.046; Wed, 10 Apr 2024
 11:59:02 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, Jiri Pirko <jiri@nvidia.com>, Shay Drori
	<shayd@nvidia.com>
Subject: RE: [PATCH 2/2] devlink: Support setting max_io_eqs
Thread-Topic: [PATCH 2/2] devlink: Support setting max_io_eqs
Thread-Index: AQHaixpCzmaRYIInIEmiAz2nnZrw2rFhPIWAgAAqB5A=
Date: Wed, 10 Apr 2024 11:59:02 +0000
Message-ID:
 <PH0PR12MB54817708565077776DF14E8ADC062@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240410073903.7913-1-parav@nvidia.com>
 <20240410073903.7913-3-parav@nvidia.com> <ZhZbmT8BIpw4E-a8@nanopsycho>
In-Reply-To: <ZhZbmT8BIpw4E-a8@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB7942:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OdBA6LN4otD82/BLhYWA3KofwE0YO9ElEhT6i+GZc5VX4kP3ACHWKzTq2r9mIIUGPjcvJo/RktAn8Agjj4ann/dbjjrLdnoJrpM07HWj+7e+zd+slP/gRfetFp/QrAv2zRdQoE9o4lA5CICAbc8XLJaVI72FtHj4vV+tqbTIjngWlJ3Pu6n443qZ+sihUtfSsGE4hWOquBkhQeKDqol/d8uyujj0McrkilfmhYXIv4h2lWYHNM/t7ZsA09DiHpsxZP9mjMshI384ms+f+tui0rFhNjGn/eYfzh7kODDvyaj2oU3EIx8A6F2g/bz/QUFQJp48HPbjJpLhydEuMOo+/VOZ43NMCo1+JA6Ptlvek+aeAop7MK7M2cXClgKZcqlXA/tOB057xqu8a/ou7z3ho38y5/1rQJBxllJUfnp2tgB7SZJLUPefsjUdBQDKlCLhbYxN1T6tnANsYfLAFdiCfMXqxeCH5GlIBdvyBcEluKlbpZtDd6T1vF+i8JPfoUXim6nW4ubhLYpnDkw32DJQVxYOUw1lKvF+zgRJkC94UT1W3pZ0GvA/xuWJ4KBsW+D2cc49+9R8en+DJHC6xiXsKFfrsNCu/lHZSe3FSByPWOoRcKUJrtxuKo99V4uoab6sle7zrfjBoAnYXbi+/NIVtAxt2fTDjk0+KsyQgphN5/c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qkaRZEwz2+Aid7KvhwWoJSCRBptP8PI/4CIt0MPVb39xhp4PJd5J0s7CHkco?=
 =?us-ascii?Q?qkAsAK+ygMaOvoRdbXtzrseSqJo6VwjhrujFwUavsDo4DElOSxDVeyFZoi1Q?=
 =?us-ascii?Q?EoM2OFyaRTWIy7JIpaQZhIbMCaLqUotOd7whMajDdU5erWnMCncZYKbRh15F?=
 =?us-ascii?Q?JLfMBARZknt6ss2Q8AGc75DsSSD+vCIXPBeh2gkj8OpzZbQbLifu2y5VxxFf?=
 =?us-ascii?Q?AGSFPPKb61vdQmpQDhZWJHdgiZ1HOAxj8xNTcv076bE8Smg9e35dLPYKllaA?=
 =?us-ascii?Q?3wrjTuFMUqhwzGrHDWOvMhbpSqSvPar2/0m1Zt1ncVWZfTPJ65R21ivLackN?=
 =?us-ascii?Q?2OCD2AzidimwH6W+mfyi5VogpLKS0Jie6Gr8InNlcDS66g96zgu45RH2wOg/?=
 =?us-ascii?Q?1UAMALGz444d0HLuU1L0IRM2JVAInSgzpIW2eyPPz3VO7SeT4eNVtRzoBbVH?=
 =?us-ascii?Q?CPtibVkL5HNlXLvYhNe1KSa4Sdsues7t1YjuNULGvo3ub7heqcUXHjU2JcMX?=
 =?us-ascii?Q?JtuMmo91Fer1NQCT5F4482VcQ1typ+ciNlNVYimYDomMn4oSwoymHVIEgAkz?=
 =?us-ascii?Q?asAGSvQhZ5LoarrZKB9Ya7kSH7DQzrJwCXtvpTnXrUv/AT7YvL69yo1OUdOw?=
 =?us-ascii?Q?oLkh80nSN4SPBto7CwTOfUm7i6LSwx+kZ4dki87jboX9kTE0rarnkx2H5yu5?=
 =?us-ascii?Q?hKdcstQba77xVtZV+qDxzR6IFHxy5g9CBbw3f+tpEKLChqVB1J6wWQSkhn4z?=
 =?us-ascii?Q?X0tbn1kmoUcjHFJPl/UNxvdOjbgFGcB+qm6OIjw3rAXpFu6crEbK0XzCZN5x?=
 =?us-ascii?Q?EZnskyD2mhZcB/9+tI1gRlGjXhSSMtKX6JxyfFn2us9H0/Te3ALhZaRBGEEL?=
 =?us-ascii?Q?82vN6AgeqC8wgKa1Ti5KqqkQUMxTkN3LYL0jkKOGzTQSuqAglDcbs1jtsh5Q?=
 =?us-ascii?Q?eJ6EGxwdxQ4KEeBOqr3fdOVSxv9PpkmWsNIFFA3xmiX28BUo/jgi4KoSomzA?=
 =?us-ascii?Q?EhdMEEMDY/i6SsMh8wTyKcqD5OjwtTk2cVoiYQtgomYAAOI2eVuKWRKXVJ+e?=
 =?us-ascii?Q?7ETvnWwkc4kpPZqu7Lk1Fd5YFX6hCMlPKGo3/fMTNvyZ3xuGeJfx5yf/xLaM?=
 =?us-ascii?Q?i1jKSC0MVeWDszsI9nNAyOfk+gYcHV0XxEA3OWVvcUtRDEVQonjI8HSAVlqc?=
 =?us-ascii?Q?Qm3yjQAZi34Cc0yXzxAKVzCeXRYCQ7W4PPLAppc8hWKVUHra9F1WcJkPrKMD?=
 =?us-ascii?Q?QenuojDej8ZBvv1R94XgdJ/+e1g5jMQuQdIfETQcV/xA1nlD6ST31Z0dyqi+?=
 =?us-ascii?Q?U2eocyWpkrTm4QIBKDjD/xNap3/0oM6CmWV1srg8WMOhnxwXH5Ywl87i8xVV?=
 =?us-ascii?Q?OTG8ePkqnUXsxRvhqueW7/3trkZEmw53uOgTOVwvtHY0MlzsjhyXg198ZVqX?=
 =?us-ascii?Q?fbfJgnyhfhViM0WQA4Dzf+LhQjhJYrw4bqVoKx07O+Q45wu3YEeN1j+R6wcs?=
 =?us-ascii?Q?S3ZwEvFnPJr+qCBNx7LoOIZL5C3cTtVkMFlTVWX319yToXBkcnOMH8kX5jDh?=
 =?us-ascii?Q?kzWpNVQNao4mgTgXE2c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b659c145-0334-45cf-5cae-08dc59559d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 11:59:02.5793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05qzADN59KBnregaCcUdIUlelToru9kWk1E89H+XUtTM8t7vA8Iwk/P6z5b81E8gntad3TlT55FfIn15ad1mkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942


> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Wednesday, April 10, 2024 2:58 PM
>=20
> Re subject, please specify the target project and tree:
> [patch iproute2-next]....
>=20
> Wed, Apr 10, 2024 at 09:39:03AM CEST, parav@nvidia.com wrote:
> >Devices send event notifications for the IO queues, such as tx and rx
> >queues, through event queues.
> >
> >Enable a privileged owner, such as a hypervisor PF, to set the number
> >of IO event queues for the VF and SF during the provisioning stage.
> >
> >example:
> >Get maximum IO event queues of the VF device::
> >
> >  $ devlink port show pci/0000:06:00.0/2
> >  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0
> vfnum 1
> >      function:
> >          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 10
> >
> >Set maximum IO event queues of the VF device::
> >
> >  $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32
> >
> >  $ devlink port show pci/0000:06:00.0/2
> >  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0
> vfnum 1
> >      function:
> >          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 32
> >
> >Signed-off-by: Parav Pandit <parav@nvidia.com>
> >---
> > devlink/devlink.c | 29 ++++++++++++++++++++++++++++-
>=20
> Manpage update please.
>
Oh yes, I missed it. Adding it.
=20
>=20
> > 1 file changed, 28 insertions(+), 1 deletion(-)
> >
> >diff --git a/devlink/devlink.c b/devlink/devlink.c index
> >dbeb6e39..6b058c85 100644
> >--- a/devlink/devlink.c
> >+++ b/devlink/devlink.c
> >@@ -309,6 +309,7 @@ static int ifname_map_update(struct ifname_map
> *ifname_map, const char *ifname)
> > #define DL_OPT_PORT_FN_RATE_TX_PRIORITY	BIT(55)
> > #define DL_OPT_PORT_FN_RATE_TX_WEIGHT	BIT(56)
> > #define DL_OPT_PORT_FN_CAPS	BIT(57)
> >+#define DL_OPT_PORT_FN_MAX_IO_EQS	BIT(58)
> >
> > struct dl_opts {
> > 	uint64_t present; /* flags of present items */ @@ -375,6 +376,7 @@
> >struct dl_opts {
> > 	const char *linecard_type;
> > 	bool selftests_opt[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
> > 	struct nla_bitfield32 port_fn_caps;
> >+	uint32_t port_fn_max_io_eqs;
> > };
> >
> > struct dl {
> >@@ -773,6 +775,7 @@
> devlink_function_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] =3D {
> > 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR ] =3D MNL_TYPE_BINARY,
> > 	[DEVLINK_PORT_FN_ATTR_STATE] =3D MNL_TYPE_U8,
> > 	[DEVLINK_PORT_FN_ATTR_DEVLINK] =3D MNL_TYPE_NESTED,
> >+	[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] =3D MNL_TYPE_U32,
> > };
> >
> > static int function_attr_cb(const struct nlattr *attr, void *data) @@
> >-2298,6 +2301,17 @@ static int dl_argv_parse(struct dl *dl, uint64_t
> o_required,
> > 			if (ipsec_packet)
> > 				opts->port_fn_caps.value |=3D
> DEVLINK_PORT_FN_CAP_IPSEC_PACKET;
> > 			o_found |=3D DL_OPT_PORT_FN_CAPS;
> >+		} else if (dl_argv_match(dl, "max_io_eqs") &&
> >+			   (o_all & DL_OPT_PORT_FN_MAX_IO_EQS)) {
> >+			uint32_t max_io_eqs;
> >+
> >+			dl_arg_inc(dl);
> >+			err =3D dl_argv_uint32_t(dl, &max_io_eqs);
> >+			if (err)
> >+				return err;
> >+			opts->port_fn_max_io_eqs =3D max_io_eqs;
> >+			o_found |=3D DL_OPT_PORT_FN_MAX_IO_EQS;
> >+
> > 		} else {
> > 			pr_err("Unknown option \"%s\"\n", dl_argv(dl));
> > 			return -EINVAL;
> >@@ -2428,6 +2442,9 @@ dl_function_attr_put(struct nlmsghdr *nlh, const
> struct dl_opts *opts)
> > 	if (opts->present & DL_OPT_PORT_FN_CAPS)
> > 		mnl_attr_put(nlh, DEVLINK_PORT_FN_ATTR_CAPS,
> > 			     sizeof(opts->port_fn_caps), &opts->port_fn_caps);
> >+	if (opts->present & DL_OPT_PORT_FN_MAX_IO_EQS)
> >+		mnl_attr_put_u32(nlh,
> DEVLINK_PORT_FN_ATTR_MAX_IO_EQS,
> >+				opts->port_fn_max_io_eqs);
> >
> > 	mnl_attr_nest_end(nlh, nest);
> > }
> >@@ -4744,6 +4761,7 @@ static void cmd_port_help(void)
> > 	pr_err("       devlink port function set DEV/PORT_INDEX [ hw_addr
> ADDR ] [ state { active | inactive } ]\n");
> > 	pr_err("                      [ roce { enable | disable } ] [ migratab=
le { enable |
> disable } ]\n");
> > 	pr_err("                      [ ipsec_crypto { enable | disable } ] [ =
ipsec_packet {
> enable | disable } ]\n");
> >+	pr_err("                      [ max_io_eqs [ value ]\n");
>=20
> "value" is not optional as the help entry suggests, also don't use "value=
", also,
> it should capital letter as it is not a fixed string.
> Be in sync with the rest:
>=20
> 	pr_err("                      [ max_io_eqs EQS\n");
>=20
> Something like that.
>=20
> Rest of the patch looks ok.
>=20
Ok. sending v2 fixing all above comments.
Thanks.

>=20
> > 	pr_err("       devlink port function rate { help | show | add | del | =
set
> }\n");
> > 	pr_err("       devlink port param set DEV/PORT_INDEX name
> PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
> > 	pr_err("       devlink port param show [DEV/PORT_INDEX name
> PARAMETER]\n");
> >@@ -4878,6 +4896,15 @@ static void pr_out_port_function(struct dl *dl,
> struct nlattr **tb_port)
> > 				     port_fn_caps->value &
> DEVLINK_PORT_FN_CAP_IPSEC_PACKET ?
> > 				     "enable" : "disable");
> > 	}
> >+	if (tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS]) {
> >+		uint32_t max_io_eqs;
> >+
> >+		max_io_eqs =3D
> mnl_attr_get_u32(tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS]);
> >+
> >+		print_uint(PRINT_ANY, "max_io_eqs", " max_io_eqs %u",
> >+			   max_io_eqs);
> >+	}
> >+
> > 	if (tb[DEVLINK_PORT_FN_ATTR_DEVLINK])
> > 		pr_out_nested_handle_obj(dl,
> tb[DEVLINK_PORT_FN_ATTR_DEVLINK],
> > 					 true, true);
> >@@ -5086,7 +5113,7 @@ static int cmd_port_function_set(struct dl *dl)
> > 	}
> > 	err =3D dl_argv_parse(dl, DL_OPT_HANDLEP,
> > 			    DL_OPT_PORT_FUNCTION_HW_ADDR |
> DL_OPT_PORT_FUNCTION_STATE |
> >-			    DL_OPT_PORT_FN_CAPS);
> >+			    DL_OPT_PORT_FN_CAPS |
> DL_OPT_PORT_FN_MAX_IO_EQS);
> > 	if (err)
> > 		return err;
> >
> >--
> >2.26.2
> >
> >

