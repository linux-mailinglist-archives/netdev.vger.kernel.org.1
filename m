Return-Path: <netdev+bounces-110087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B1192AEEA
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2361C20E5A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 04:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03262BD05;
	Tue,  9 Jul 2024 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KnciCvNq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7BE639
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720497659; cv=fail; b=nl3irdAylnfCqFWf5Tnu6KsRtKeenS7RNop/XHJ2e2BMZcwbAqywf9XmtcVzpabLoMteCBTf+xhFce6RyV34eiC/6w4FbPwqfuRxJ/ablCLE5HSxvIBpBCyNUcXj8dpWj6PqZJeo22H2D8XybdUQuhZN2OGZyeLoLEVe+FWUqh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720497659; c=relaxed/simple;
	bh=IsXWWykmWo4vzR/npWht+wELlY+fACc9A2utkbW8Uyk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ek+SiD+ui6sR7VoFjxL0h+NT4t5gdVM8KUEfsIpwmzbc0huYnhE9/xuMQOehQUDZ55dKnWIT9Ninp+VvfjSg147D1o8fdxSKW6uKFQL7mKYe8MsSpFg/1GOBCCcMOCnYZWm+dPzjlmewy4uu6DOiZ/I0SDNh65a37hJRdptGG7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KnciCvNq; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtewXcwBpJr/MrRoR++WrbpKozgdx20ma7WadFnv99vu7N6JG72RxL2KtKUV5ja2hI+n70dIQ1St60gm7KnxcbFwltKwG3rgWFV3clCqiQeeaJodXNivtMWv7ONHg9LrVNQabPahbLvW62agn+S2X3CJUI4kFw+ywy6/5wAflENd3Z1R3XuQaZt7EkUh/YnE+XmYRl1tj2S2hhZmwvOumSTf9Knn049UgM648Gly0lSxNKO+mMPqBSi+30+QHQx49JF1a+kg6Lx1Q3Z4rTwGv/lvyWTDB1xj9OuLRbI6sEw8SEbthvliCs6sTiws/oRRku6DEXvKTRvycWRa70yt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkBqeRFGHjcdiKSmgbaRDQdG/oht4ktqO4o4onUBHsY=;
 b=Q6k6pRIFprx2O5w4SMdYmV7IYSiqI+SVmv6vAHrvg/NNuiUBqul32KZL6i9OsHQjh5lmsj4FGNoOF5z0sKTb13EIfSOMeThS642BVS27ZLJtiFVSzaxRdeESyfJGdRUPRFfUtLWyl23ySCtBOBXPaHnnYWv4sOO9iIWMn59f2w3G6zWojofzxv2iG/z5LTMgAO91GDaRb5irNf00TKrSA8tBK10nAZhzqUGui6uqnDPHmYs0YDxn28IezhNE7ILwBnuZJdFJms1VfsZBCiaboginO2g/Oh23udLWDMQAfvkX5NUJs4c13y4I6WZ3qtK1fNcnlbjrNZ/nOPGsnzq93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkBqeRFGHjcdiKSmgbaRDQdG/oht4ktqO4o4onUBHsY=;
 b=KnciCvNqIi0em26iP4czYMYLu4Eql97CIgVkT/nw4qI7FhuWhI1DDmBKTTwUe922kTvmeZXjzFDfZc/J7XfT4lj3Wm/B29n9ryAQa65aqAufk46v2A2ULu4mpjJpntiY/6bqayYuATPwyvolfHAASVQFRL+qSyFvuAUk2NgUfp8d2P3kFyf+bxHYwH5A1CkdglixppPhxErudMQQ6Qs3CsshK2/TUpFRSAejKDgIEdrdZYKL1Bjw2f0eJhfpw1H6upI/PPdF7kwQxDUxYDc6w5N9engQ1OMeqc7aDs2HeNI4TI13MRyg+aemEQpZJrN1KJu8UhnYc13elBBzazafpQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 04:00:54 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:00:54 +0000
From: Parav Pandit <parav@nvidia.com>
To: Cindy Lu <lulu@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATH v2] vdpa: add the support to set mac address and MTU
Thread-Topic: [PATH v2] vdpa: add the support to set mac address and MTU
Thread-Index: AQHa0a9mvf6pW1H6A0u8aW3WMiCvKbHtwEjg
Date: Tue, 9 Jul 2024 04:00:54 +0000
Message-ID:
 <PH0PR12MB54814BEA4DD2E8CFD434DF4BDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240709032326.581242-1-lulu@redhat.com>
In-Reply-To: <20240709032326.581242-1-lulu@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB7082:EE_
x-ms-office365-filtering-correlation-id: 41e34f53-2580-4a9a-4407-08dc9fcbbb38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h6pCVTXxktTcOdGt1x2+G4q1R3J0sM+SaOLIqYUKnaIab8icJrwPK3tWL4mb?=
 =?us-ascii?Q?OI+VygBQ3WOsQfdRD6BUWnQSw/rQdE36hyYAkSA+lDx4c3sImq30kFcSzPBM?=
 =?us-ascii?Q?nCnPM7zuQh0BYMmu82pajG6d2ZrUBE4GCMgPYTD9UGDocZDN5L5seQT1AVyj?=
 =?us-ascii?Q?LAlCqF9yD+nR5cm3g7OEE9zCau6V5q9sJr3+RxkuUMmaKZa3Gcgg0USnflba?=
 =?us-ascii?Q?WskX5Ni8ggQpQ8d3jC8dxQ8bQWAXM9WXZ0+HV1y/kUh/rrnmnYDxow6Ts8rI?=
 =?us-ascii?Q?IdAroQ93NNSXmT7d65E3UubZuELviCkmY9voKT8LnphgagBmRtVQtZoUWntj?=
 =?us-ascii?Q?CF3LsvT8nqUu6+wEwGnLhNQnyXmhDdkhf92r8AuUsQwYR+0TCrN9VU4w3PCT?=
 =?us-ascii?Q?VxOmBM3XfmsfUOtOlRm/crI81oJfagOgQOJjwDg86uNn0pusZQYUeUtBdL2E?=
 =?us-ascii?Q?f9jdmUqd2+8KFhp1tKM46+o7NJoi08pyZR+hUDm28Zh2KGQZ4+HoF+bZb2TT?=
 =?us-ascii?Q?EiFMmSD6nHmDmxBqodUh5IESfkBKf4fPWtkXRKIVpV0OPQGkjkgBBdg/WWlH?=
 =?us-ascii?Q?Ao+AAtcrD6R/NeoayQ8WO1Nt/JlZqNgP83LeXvj/3tQ7PrvEuXTZ0idXgT7N?=
 =?us-ascii?Q?B8sKNLd/jJ/46HiuuOvDqn2paIFFBGCZxZsLEgOoyqv4N4L9DXDIo4LyOPv9?=
 =?us-ascii?Q?CWedOKQ2ajT5cwsYry43dAknhhvN//RHeYNSIdx5eKjJQVv1ieJcejY1BvrI?=
 =?us-ascii?Q?HkAbfgtVRry8apPKxUqKz+wT82N6h9GHU3uAlx6CxpQi4dQNclM/0LY3SHFn?=
 =?us-ascii?Q?aMZHPhPPHkoHrZFBVVwIAnQeJSBVe4OayV/tCfrYAmvfxqOE/iQdaxl7O9X8?=
 =?us-ascii?Q?1MpBBmijM+//VGQKvLPZYRWrqtN3ud+wSc9okwvLGrV37OhfB9/1mr5gpZoU?=
 =?us-ascii?Q?dr31Ct4k2tSwUdc81tDx3gvwkLAWBla8G6mIDxoiGmyKalr7h4lyzqkRTZ3L?=
 =?us-ascii?Q?0HfY0jRpfcIhBrv/FaSJPcLwHQvo+brqxKf23Qx5EQ2/DB+hJVqsgBa0kjzu?=
 =?us-ascii?Q?6jy7N6S0AGSqSJBT9WBb329KvKtPBUeqGWjcV2AwPhemAM61WaGjJTfOh2ok?=
 =?us-ascii?Q?6EqU5Al+VCyiOlkw6scW/ULbvFkuC5SC5oXA1x+EHid4UMlnuUMIF5ZC+Tti?=
 =?us-ascii?Q?9hCWLFqoilEPsnaF5y+heWyhKPfOkG2slysQhspk4OtxmrqidXIf9pq8BiCX?=
 =?us-ascii?Q?xmY3zVoAe22eOKKuRnDg9XBVDyIkQ6xGls+Y0FWMqBouhh9uv6d9vV/jYqrJ?=
 =?us-ascii?Q?s/aThHDNDZf9609sPVP21lWrAgPcJJEawOo49sVcosegCXp7TBR8hsoqqBp3?=
 =?us-ascii?Q?cPtAq6H/Gu2oRZO8uEtdNRoZEF2IXNSn/qatrcn2+Lmr5Wz5qw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?di+nkUINlpAWS2Gwh0QmeY8ZroVCPtgyMakToE6eADstM/H932pIs/c0Tc6W?=
 =?us-ascii?Q?5Hi2WQh029FjOUPo38LE2i0UA+a/j/RR4BMC9fMQUYVEzsikpKxPFXtswRQT?=
 =?us-ascii?Q?4xSknDPYbKeETNKcz4jytbLMG1JUSSSaJMVxHC4HH7d9n2IQn6yL0mlMGUM3?=
 =?us-ascii?Q?WFJFifSn2yji0wjVucoc3RZLdEGm3H2QrEYqqpK3rW5z965Xu2IbyhUM55RE?=
 =?us-ascii?Q?3OMLVvJeZ4+MZTaXRGRNt0TrLIAcIJJwi4+Pk+zLSk0OqKHxJjNe5iUbxIZD?=
 =?us-ascii?Q?F4CMlF3hoDGQVwWMk9J+TiFXe9j+2of9hi6ZZvPyTKpdmAW/YttMzTTt3ChN?=
 =?us-ascii?Q?VsGKyioONeJBW2xRCM4Y4KrB5iVEALpHWfdodLe8Su8EhGKQauxYhD+O6f5P?=
 =?us-ascii?Q?7KddBai/9tlm8G73PLUlPTzS/5wN9mG6SiEDE238KZaLe+QTcMgwMZHPk5Zl?=
 =?us-ascii?Q?OA4T+SP/AjtUAcDHzD+NCgchB7CJo7gZl23fB8ufkQ+/L6iCsJxqvfXF15YE?=
 =?us-ascii?Q?IjBK3VPcEQYfWYFpBeWHLYSr4b9rIhjkbUKSrn5fh3Nx0Pf74HOFQvt2JlgB?=
 =?us-ascii?Q?KAVpljQu7T9836YwQMTPYZXTldlg900feex9uhf41B6uFlgl7kyopIN69U8b?=
 =?us-ascii?Q?kcAgjeKVLhaOOO04Bv7dp7A5h6pTr6Jr8r/fZjKWsFXdOJFdfFBZNbxIf3nv?=
 =?us-ascii?Q?3XFntKjnz6UkN9J2VeyNJWC7fgs1PT3r156wZTw1NACNsOOaBd7SDdsW5WkC?=
 =?us-ascii?Q?PYnbU03NO6z2X27DFZ1rNUzSob+k73zNhgluc2oCjixQaWfyTPoIYDqycrP+?=
 =?us-ascii?Q?kALj9rsxZbyJPaDa+V/iSmO+bNKZdJPjcJHGjZNVA5h4IgZ97vO/N1u6E5l5?=
 =?us-ascii?Q?sF/delMRYWhit6mocH72rRCz2M4630FwivGL6ENif1hJl4MIeKg3hgY+h4Nd?=
 =?us-ascii?Q?kTNi7W+gMfLkjLU6MH/+1AOzQ5h0jVL5lpyAs2ZIjbQtx7ckn/0Gj6jIXQJ4?=
 =?us-ascii?Q?Z8/yYon3892kSXLpy3Ci2hoJppcZ19I4tqCKLnfon4p5HlpwBTG0hlQcO1sR?=
 =?us-ascii?Q?x7cE2egP4VwKNQITIXD4Z6L/3nZPG1PWKUKKEq1SBuEa5JqAOOZO6M+Burbr?=
 =?us-ascii?Q?IhVLNpo/0shky1Si4Km09v/VzAa4BGw45UWTbeO0KO2JC34oxbulfv2pKpke?=
 =?us-ascii?Q?R8cTgYpAEfniH8CjOXzNCctQeg/SmZUCoSoRRIsgYaUtCkC+2FsLg2zr2k97?=
 =?us-ascii?Q?PLcR0Iw5CodnNfoxu2YhOLmk/YuNC1yRmoehqUeHzlmPeE1kzLif6U5/+Hi/?=
 =?us-ascii?Q?wdudoXAnxFCRGBvWqQY/AN+fSyYVei+HRzCjzJE4U+XTJgwFw47GEVKZ6vAy?=
 =?us-ascii?Q?2E6LmJ1U6+Eh/WMnF0ZMnuuz3sittnJrXXpR41TsqZx9Pq0W3gPJW0vxfHEj?=
 =?us-ascii?Q?GKgPBdPF+8d2dO1HLIUXZubBhnwNNv6vUTwtmLb2snPZziopnWctmCjEBkoP?=
 =?us-ascii?Q?G773iOXcCsVncpyyWdmINBrunGKSnxiMHjNKBAld6aChxLpJoDtKbeoAUJTm?=
 =?us-ascii?Q?frg+PUrjUctHwpNRbpg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e34f53-2580-4a9a-4407-08dc9fcbbb38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 04:00:54.7712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9K9kvU8OLAaWqhYYD9465/9mUmPTbc0Y4FxzxaRt7975J6WWhpz5KrL9ZtMPDUfRgn8WfiZkCU4ayezdxaoxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082



> From: Cindy Lu <lulu@redhat.com>
> Sent: Tuesday, July 9, 2024 8:53 AM
> Subject: [PATH v2] vdpa: add the support to set mac address and MTU
>
Please fix PATH to PATCH.
=20
> Add new function to support the MAC address and MTU from VDPA tool.
> The kernel now only supports setting the MAC address.
>
Please include only mac address setting for now in the example and document=
ation.
In the future when kernel supports setting the mtu, please extend vdpa tool=
 at that point to add the option.
=20
> The usage is vdpa dev set name vdpa_name mac **:**:**:**:**
>=20
> here is sample:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>=20
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
>=20
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>=20
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  man/man8/vdpa-dev.8            | 20 ++++++++++++++++++++
>  vdpa/include/uapi/linux/vdpa.h |  1 +
>  vdpa/vdpa.c                    | 19 +++++++++++++++++++
>  3 files changed, 40 insertions(+)
>=20
> diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8 index
> 43e5bf48..718f40b2 100644
> --- a/man/man8/vdpa-dev.8
> +++ b/man/man8/vdpa-dev.8
> @@ -50,6 +50,12 @@ vdpa-dev \- vdpa device configuration  .B qidx  .I
> QUEUE_INDEX
>=20
> +.ti -8
> +.B vdpa dev set
> +.B name
> +.I NAME
> +.B mac
> +.RI "[ " MACADDR " ]"
>=20
>  .SH "DESCRIPTION"
>  .SS vdpa dev show - display vdpa device attributes @@ -120,6 +126,15 @@
> VDPA_DEVICE_NAME  .BI qidx " QUEUE_INDEX"
>  - specifies the virtqueue index to query
>=20
> +.SS vdpa dev set - set the configuration to the vdpa device.
> +
> +.BI name " NAME"
> +-Name of the vdpa device to configure.
> +
> +.BI mac " MACADDR"
> +- specifies the mac address for the vdpa device.
> +This is applicable only for the network type of vdpa device.
> +
>  .SH "EXAMPLES"
>  .PP
>  vdpa dev show
> @@ -171,6 +186,11 @@ vdpa dev vstats show vdpa0 qidx 1  .RS 4  Shows
> vendor specific statistics information for vdpa device vdpa0 and virtqueu=
e
> index 1  .RE
> +.PP
> +vdpa dev set name vdpa0 mac 00:11:22:33:44:55 .RS 4 Set a specific MAC
> +address to vdpa device vdpa0 .RE
>=20
>  .SH SEE ALSO
>  .BR vdpa (8),
> diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdp=
a.h
> index 8586bd17..bc23c731 100644
> --- a/vdpa/include/uapi/linux/vdpa.h
> +++ b/vdpa/include/uapi/linux/vdpa.h
> @@ -19,6 +19,7 @@ enum vdpa_command {
>  	VDPA_CMD_DEV_GET,		/* can dump */
>  	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>  	VDPA_CMD_DEV_VSTATS_GET,
> +	VDPA_CMD_DEV_ATTR_SET,
>  };
>=20
>  enum vdpa_attr {
> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> index 6e4a9c11..4b444b6a 100644
> --- a/vdpa/vdpa.c
> +++ b/vdpa/vdpa.c
> @@ -758,6 +758,22 @@ static int cmd_dev_del(struct vdpa *vdpa,  int argc,
> char **argv)
>  	return mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL);  }
>=20
> +static int cmd_dev_set(struct vdpa *vdpa, int argc, char **argv) {
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh =3D mnlu_gen_socket_cmd_prepare(&vdpa->nlg,
> VDPA_CMD_DEV_ATTR_SET,
> +					  NLM_F_REQUEST | NLM_F_ACK);
> +	err =3D vdpa_argv_parse_put(nlh, vdpa, argc, argv,
> +				  VDPA_OPT_VDEV_NAME,
> +
> VDPA_OPT_VDEV_MAC|VDPA_OPT_VDEV_MTU);
> +	if (err)
> +		return err;
> +
> +	return mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL); }
> +
>  static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)=
  {
>  	SPRINT_BUF(macaddr);
> @@ -1028,6 +1044,9 @@ static int cmd_dev(struct vdpa *vdpa, int argc, cha=
r
> **argv)
>  	} else if (!strcmp(*argv, "vstats")) {
>  		return cmd_dev_vstats(vdpa, argc - 1, argv + 1);
>  	}
> +	else if (!strcmp(*argv, "set")) {
> +		return cmd_dev_set(vdpa, argc - 1, argv + 1);
> +	}
Else if can be in the previous line.

>  	fprintf(stderr, "Command \"%s\" not found\n", *argv);
>  	return -ENOENT;
>  }
> --
> 2.45.0


