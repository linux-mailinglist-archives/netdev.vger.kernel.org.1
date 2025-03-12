Return-Path: <netdev+bounces-174246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FDDA5DFB5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192E93A3294
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11324EF75;
	Wed, 12 Mar 2025 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JytmCbef"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2122DF8F;
	Wed, 12 Mar 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792002; cv=fail; b=PyTcQNPHdfIss29VgrvMCYUStyhaB43mSmWu3xeIzK16o0c/HySp9lIJ/kbJc6kI5EnB5QqlBl0kwMJSRGQy8dx12AmndfjreZoxl9Rlfet3yTyvPTXSbVpJDP6amiHx8acNaOh6aRXuOqziR7Pd4xHlqGNmt1day8U9uuVdsGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792002; c=relaxed/simple;
	bh=LV5SOYUvz2jVfOkJRywUWN0ooZtC6+TNi/gTmU7Swt4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oAwsqHNvTXFmtRheHY0vsViJ7SYw1rE8tAgFZ5s3XXGBbYkMH8jblRZlQ51HDQmsVZNtXRZhwRmqBHpdREfV/M7bu4sbMyd3fV966M/ruuv5GgjZrD50oAYKHi/H/uRB8RuqyOZbUneVBKV5C7gMnFCxqVbXrRf3h+5WZljfAlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JytmCbef; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXJEoZvKSQbwr7/sFczxwZmFpzdemsZkIP1426R0+wACAJmtztFf9aA4iAWC5YXALVQZu3oJvqQXjIyjPImqKvqmpczsaHbzDCDvFxWD2gtepLHiwDwy2cjQmSBWGuQSYOC3Fl+YYub6pqZtlcrIQlOH/4uq3UvFz1awJB/o2gfZLCzWr0L6AsDsIiQxrNUOG1wmWfmQiwuX6+/DxoOAq3rkxTD3STyeG82zYi7XvcBM5Yp8upV+e1+sIUp7PwBabkI7DCGuYTdItSummDzwLbjLBFLctIk1m9+xm9PJLxoTC65Kc+5NlAQMPBa0iVh+0+9rw0Pm08m/1nX5PfnlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/AIVmWJAI+MmCLqZ+zkMCRBnvRD/M5OO3/wcKcn13I=;
 b=OQvpdjyohME3GSkG5VAbA5HN+KFpm10UoPPwyG7RjjReNSjrHsz7fjyN8nD5pbiJjNd5x7Jcb9swH6USbfCe1znaVXvOUTavvNAISioLGla4U7512IY8CsSD5KSHMMQzIqz5ZWJgUBWcBV0rDDtMfZoITMJrXM020dQKAzkC7Vh8ZP174aSUqKJbOPg8iile6AlzcpCMrl3Iydfsw9r0tXP08bu/QIRn9Tp3u1Ctb1L6+yI5okYewdxxN2If/XuMqhkW7vyoyMgd385Dmc0NDAMwxd3Gijr0hC8Jdk1xEUEmWNv9Dh17oh5lFGvb0iq00FU9y1vi82Xiy/THflTzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/AIVmWJAI+MmCLqZ+zkMCRBnvRD/M5OO3/wcKcn13I=;
 b=JytmCbef/QOj7FjYiOrsbo7h4lA/9Qq82DnGYOPT3ujHdS7fnRfbhL9DbczSZ5uxjsSQNahu8FcvVvsxRiMJN5KLirjCWsGCnlMx7pRVSJUwwJasQW8SkqwIZk4CqR8Nbpm/pSH42wTsBtGw/7GMRtCqRKiuvAZSo5J6XoAFfEQ=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:06:34 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:06:32 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Russell King <linux@armlinux.org.uk>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Topic: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Index: AQHbkzTKsOmRASZLiU2r8QNuR6Yh/7NvfgWAgAANigCAAAd4EIAABRmAgAABiVA=
Date: Wed, 12 Mar 2025 15:06:32 +0000
Message-ID:
 <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
In-Reply-To: <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=808471f3-b35f-4735-b785-4062f9ef37e9;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T15:04:22Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|MN0PR12MB5836:EE_
x-ms-office365-filtering-correlation-id: a591f81f-ccbe-44fc-c170-08dd6177799c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u8Sw99ItO5jEYs+BgSCqY5YzqNe0u9luoL/ZabjVf6pod48kQ3Z/raExpf4/?=
 =?us-ascii?Q?z/yVNhmmMhZlJhBlnZX4ro04EAEMoJnMvUUa+7flU1ots7AZ2go7b9qWJTDo?=
 =?us-ascii?Q?VV7FdPd+Ke2n3FYUMCoQkKXhCKKqskk5uA03TigkEImCvP5Ckg3h11KuP8/i?=
 =?us-ascii?Q?Y9q8iT0s1f5JPAj4Pvuw868ws5zCLWqLLbRmwDlutZjwVp0/wxP0ZL4LOzrG?=
 =?us-ascii?Q?Io5by1GpMs/aU/zRAtYd24rq7rQOuvDFLSf8ObPTtNAG5Lj8rlsUF/PiJNOm?=
 =?us-ascii?Q?4zBk+CJTUun16jPU9alHMAWU5fcX72qBFDe80iyBZMXJtDSXr+6PTOotlABJ?=
 =?us-ascii?Q?4dzFXiN8RAwNrsmuaosLEcXiRqxBsu3qw8Nkfd400b3VqiRi7CrKaPx3lWCy?=
 =?us-ascii?Q?oltxBh+3bkNRl45Hpl9q1pmwvonmUk5SZ23suGbKS/5tZGVKyZv6t8t8ArPJ?=
 =?us-ascii?Q?EsaVdY8TsfKlXuJrC+PmvISYFXXC813RF5uohxsOBvVrxgrF4aua/hRPN8BE?=
 =?us-ascii?Q?I57kBUlI3hv5seT19CeA9AuukiSWI4zbDvjArDhaBf/l8+hlGFlzwMvDTb6h?=
 =?us-ascii?Q?59MxuoEV5lzUQwKOSV8zLZi76LZzqMHMU3lv2DrqBiHGaDUk2QwiK92q7nBB?=
 =?us-ascii?Q?dmC5fGfDEepRZFJ6y1eIEmiEJhzrfHYMuMwjRIVA/HegM63zo+MoSWyh66k1?=
 =?us-ascii?Q?0u4yiVq0NypP3SHEjpj1NlS5IiGYUVkuqqGpT9Ox/qY8ZnjSvGQ+TCY46Ajt?=
 =?us-ascii?Q?R13ystiNgpuBHeC3TY0y05MwLWlz5oYk24JO+FTURNSYQ+QothKRwKbq7E7K?=
 =?us-ascii?Q?COQftrXcxup8dkj76I65kRafUehxKRN8HD5/rcdQ1UHeYkCWJj+1PeLltsUA?=
 =?us-ascii?Q?3ZT03bJt2OpZkk2cKAA2uJJuUhgXn68ZAZoCVsasvSABcCcjehQ75UDkvfJ2?=
 =?us-ascii?Q?3KZ/a+xeqUk++DDOgb6/kq/SVI8jA4gtMBLg8fOxZicrL9/b8Vm3Elrm3v4C?=
 =?us-ascii?Q?qF1SOcrqvsfuqkUJYQGFeXqIn+aN9hGKOXBrvQHe0Kf+4GtdibZg1eD/Srul?=
 =?us-ascii?Q?eXvETSGt3uhPXFcKmze3EnxMMAs2MWF4Q8qR8lGBnctXh04XgpYkTEsANMGU?=
 =?us-ascii?Q?mh+WCWlLscd5NUfKQLP3tQuMfb0bqcLraUZbyGr9zGIJbCw0/7S/v2JJJYw6?=
 =?us-ascii?Q?eLliY55i7oIFBJ2vWRWvkiRW5/RylNKB6nz07HsLe/Eig6bhPMMmKSdJPSf2?=
 =?us-ascii?Q?27sZIWks9CYxuznWLw/KsQtQYAR1TirL/UASpq5DEfVCi9S1a1bG0Tw4DmEQ?=
 =?us-ascii?Q?eMl1MrdzuBjuye25UHbHcr6kVd4/eoQj0yBh3ZGExc/17YgbmkYYti6/7YsB?=
 =?us-ascii?Q?ZSIqa1IzY+upB0ZHfU16QI3SZGUNnLC8K7EbYwN9MYCEk3y8r/OUhj2NJILu?=
 =?us-ascii?Q?gUHYeZt0mXMOAR5TsDJ7JrN1LMeIWos2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RHQ/MmKAVzpSYGRCTOdghJDuSm04rhP/OcIMaabsd6jXXU3fevH5EyPCEUiX?=
 =?us-ascii?Q?96t2BQKke2hgoWyZkISy6usPh/qBWVEmjI9tkxW1/rcPtzHbk4eiqlbaG8UE?=
 =?us-ascii?Q?rVcM3DJeU3u0Hp+s9X6OCKUHgD+4dLhGP+sVypIOO+khJBDloMVMm1fq1FnN?=
 =?us-ascii?Q?BixfRHK+EZvNpGnBmMpF7ajGv4lSGQOu8votlu1+EGS5e/U8HVG8g3q/JN8v?=
 =?us-ascii?Q?U3lsZfQI9rSilIU2PQkQiBsKa5SrvdrcHqUhWuEbQfW9xgDthPAcdgFjcTmj?=
 =?us-ascii?Q?KCYWK8PbYGX3eUmthuB1kgA+qDHgexOOOhi9gl5etWz7fYF6l92V/GI1/ZEy?=
 =?us-ascii?Q?j6NlbMGNCp+SwBzkjser14/z+IdvMxJfH9RaMwJsAAaKjCNmsXtElEIVBnTi?=
 =?us-ascii?Q?ues2qLym8t0QbJk6IMKBrfV1decuZjU30e/lO+/ELO/pdmlo/0o6GRNKLqx8?=
 =?us-ascii?Q?vpcpISo2VSUQr/k8bTDXz0BnRpkQ5/ghZXTsYhbsxe2s/zPQGkYg75BdsR9q?=
 =?us-ascii?Q?/M0kz5cZcnAMM9jxSwjdy4pReA2ANhMhu58c33eN5vTeVHjWWPp84UM31ERf?=
 =?us-ascii?Q?G1AxGvC6N/dkN4KBO+YSQoSA3oN6nM32DqqEpprZDlzaSmg3dpkDK52OWAWn?=
 =?us-ascii?Q?nlVmD1Nf6RyI81mf3fZLUgbr3FYNDM9xNzx+9ImLk/6F4LTMGP38DgHEubMp?=
 =?us-ascii?Q?RKwrz9qbwUds4gnWsiEc+jjnqj3V9CcIkwrlWpwI7QVJhdkZXrDGMpX7Imyp?=
 =?us-ascii?Q?ueBMyAAY1rNyhZl8tSAA0Vsh8UpkGv2tjy/dQ9KW5jNKbZ1JfuW4AMBPVWGu?=
 =?us-ascii?Q?YWHYU7i2VxHKnUgouSOA0RVaTFhzZA88k2bjLSD+fS2anuBgzheruZpTQxzD?=
 =?us-ascii?Q?/lSp9x1QZIDLmjUyu4eU6Nm1CKr13cbjyIu1aYMqj466I801hmC8k5r86eYa?=
 =?us-ascii?Q?dxhM1NlGbJEVdvBaUI8nAJewOK62rD3Y4+KOkZjfgeuY1S1hXtx8WgJbQAm8?=
 =?us-ascii?Q?VL6XT/qyzmGOjljf6uLxHgm4EUE25NPEs0nS7HLny3DcPJ6wzpUWHQNZ6eDz?=
 =?us-ascii?Q?tuMeIoJk7/TksS3GUezAm90udfh7Rz1zxwml/UH6sAp2cMdXHXfJEzok5gOP?=
 =?us-ascii?Q?3Zs1JJ0mNoTMyvMtoBPASHXxSEfBMZ089+bX+dk0P0z97udtCmH2QYmfbT5T?=
 =?us-ascii?Q?A6RT732Dw+hoClbUCP7s1kutfVVA15P1oiNchHEl53Es4o30ThH5DOIxFkAl?=
 =?us-ascii?Q?eIlucrL0j1cagpjlSn9ozbCqHLDN4z0maYqcyXRADZ2xUpHbMLW1G+tqcYzi?=
 =?us-ascii?Q?e1gNkloXI8o8QQWjbgi+U0/T9QiTcWItxWIFrcx+5ufrUhElLV9Ozv87Cds6?=
 =?us-ascii?Q?xVrAACakEIT662bqReGihMTMdv8iUvLvPOHt87pUHnuf+7jxUydMGUcqNJMJ?=
 =?us-ascii?Q?EDPOghpi3Q06W78b0mgbaDpfWdhT9v9k23O4DW+++bHMsztvBc1J/ZWhOCrf?=
 =?us-ascii?Q?SVkuuIlo5HviGfdXKpKFrd2dwuibRt/3AStAl0SYAaDKqzEhSWAVGzfuPYzw?=
 =?us-ascii?Q?0KJJYKjKZ/tiIykYEc4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a591f81f-ccbe-44fc-c170-08dd6177799c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 15:06:32.5244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iyI+ZFFjrkM0zl1rJgNd8KVWatS9I9DAQV4MixPr1pEUxF7Lslirl0rrQPqw1RcbUj3Nvxdkoh2xVPsi0ud9wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, March 12, 2025 8:29 PM
> To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> Cc: Russell King <linux@armlinux.org.uk>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.o=
rg;
> Simek, Michal <michal.simek@amd.com>; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Hari=
ni
> <harini.katakam@amd.com>
> Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500ba=
se-X only
> configuration.
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> > > On Wed, Mar 12, 2025 at 02:25:27PM +0100, Andrew Lunn wrote:
> > > > > +   /* AXI 1G/2.5G ethernet IP has following synthesis options:
> > > > > +    * 1) SGMII/1000base-X only.
> > > > > +    * 2) 2500base-X only.
> > > > > +    * 3) Dynamically switching between (1) and (2), and is not
> > > > > +    * implemented in driver.
> > > > > +    */
>
> > - Keeping previous discussion short, identification of (3) depends on
> > how user implements switching logic in FPGA (external GT or RTL
> > logic). AXI 1G/2.5G IP provides only static speed selections and there
> > is no standard register to communicate that to software.
>
> So if anybody has synthesised it as 3) this change will break their syste=
m?
>
>         Andrew

It will just restrict their system to (2)

