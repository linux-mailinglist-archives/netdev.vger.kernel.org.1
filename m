Return-Path: <netdev+bounces-110567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6992D25A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51131F25D13
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089119246F;
	Wed, 10 Jul 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGMjmnhm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B219246C
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616917; cv=fail; b=OwmoYJ6Pmi4xtG2bCD8q/hey8uGqytOhiT/cUhBoqEXeCC9SoniKYEuWr95RxrcKE5gtvBcR/O/8+UXhLzsHDYYpzIxds5xATgHYRvp+gh6oN9DzuOyDLurclWjr121WBA1f7aO3eWqctYWPaxTByLNO9ptiLvd44CMXUzP6Hww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616917; c=relaxed/simple;
	bh=tZLNQ+ociDbrI8cNhjnYfqXHBpjgOkzENmbUsQgDv/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDhbDzXgwQ3Nv0zbSPB//0+We3diagmzit4FdQdeu6pYHP2svbmwkUtNABj22gAsFTo6C6QDGG01IUa5t+49Bhto+5XLCk5jeW7ug+j8eKbdl2jJ9j1iM20ZaBldrtBIwjI1god0iyGEl85d//ZjFyloWRVLPyPr6ZLB4mtK2Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGMjmnhm; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsYg/dGalQksbjL6Pknu6tnLoRxPXFVSDv9uNnEXAjILGKeI59asKrpKJWheYk8pNFPEcwbHqREvt0S6+fYpXeaMZ5EmYTwhy4ELMUhYzRmWTYK8T+DpkmvO/5ItYSR3JMxSf3HaQ2rqXEN/bE9FnQ8w87L4qpxx030KnA6KvxRIsJ2mzh6bzwCa6xvw55odzNgL+VaJAfSz2KjVKrnqbxNIp5PsNJC5KbE7vmLQsaMzS6ehndMAhHba0HM6gLm33lrGoqgXqb4ik0vE8a64iXlpmG7Pe1Ayr7ZMqawfH24TWe45ekQs8V8v1A3f8+bw2SxFaOQNlP+wTOzylYz2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZLNQ+ociDbrI8cNhjnYfqXHBpjgOkzENmbUsQgDv/s=;
 b=cq4o2X9//G1lBOv8ExfdxgoTd9TB7QPCdjDKuJ/jssAzDx/t5pDSRrK1/lP4pKq6bN77nuH+YXriWoBUvAZQHgcXFxzADsJw2kXPhulpby+7AynOzCLyvatnCWW/t2d7LcRhfq5udSzssuZ3QoHybyuUx2tAJRgj4OzDzHb0H3RXsq395MeqAIxU5G6hVvUXP1Z3N53ATXM1rSVL/dpcxoB8n9gx57rbjqyVKIoRF+kWeDDrvNPHg3LuDYz7r3l8WXU7PEEmmvmVJmNTzCdCSpkBa5FfqN2eREI72iVPvI4U02X71fEloM8MaYwlFBcjxaghUGbF+7gfOAocxiZ/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZLNQ+ociDbrI8cNhjnYfqXHBpjgOkzENmbUsQgDv/s=;
 b=fGMjmnhm7DkUjlLyf0QhtV80v6iv9oEuYx+9X4unLqIaXid6DxNyH2XRg5rGBs17ssvEnAIpCKQ+3jro3ylUptQd8N3e7Da63nTWcCD1h3z03nHSMfqgz1C9jE12PBxq1JNfLLsFkH+CTAeysFty1MQvaSI96mrGzM2/RgtabgFMVmlDO8CyGDhovULFGMyW47LnYRwosYDEvC2l936+RnMstobm9Sv3KTyrtvLoVf0wzE51bAP0xRMZjf/r2U4lyX1sjFfmK6CGI/tc9m6fSYyNs3L/zL2dehhUz95jw5LqdXyxjsVQQjcdy304IcC7Ubrh+ohM1K5KZn5hq77rZw==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 13:08:31 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 13:08:31 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu
	<witu@nvidia.com>
Subject: RE: [PATCH net-next V2 01/10] net/mlx5: IFC updates for SF max IO EQs
Thread-Topic: [PATCH net-next V2 01/10] net/mlx5: IFC updates for SF max IO
 EQs
Thread-Index: AQHa0Q0VjW7hNZwI20iMHRAxp8yc6bHvNisAgAC7lcA=
Date: Wed, 10 Jul 2024 13:08:31 +0000
Message-ID:
 <CH0PR12MB858029A605D7AF3849C54F6AC9A42@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
	<20240708080025.1593555-2-tariqt@nvidia.com>
 <20240709185444.6ac9f178@kernel.org>
In-Reply-To: <20240709185444.6ac9f178@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|PH0PR12MB8174:EE_
x-ms-office365-filtering-correlation-id: 73c59400-70db-4e2d-4864-08dca0e1658b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?B+7uHAj/T0/d7HiDBtxbVP8I4gkn5nC2YzkChBtAF6mQXl1JSJ4ldkuiX+ki?=
 =?us-ascii?Q?Dhcy1O8J1pDpRpeKVa0wFclFw1oDnDLeMRla+TMRvHdiHtxQ7EFp8hJI+tZX?=
 =?us-ascii?Q?mKQJXFzpf6qCoIsKoG+I6I+/UT3G3AHgSRxGATb2WpGYlsaeenmW5aDn0aBR?=
 =?us-ascii?Q?IxMVM8hx+iY9vz5g8epfzsT94UAWvb7HQAxpbYry6FGz2Grj89u63aMXTO1u?=
 =?us-ascii?Q?r7mGUn8oTrlX+5jcKeyOgrXPGGhuk+4hiM2q5Bs+s4OVPTpxdJTMp/DEeSvq?=
 =?us-ascii?Q?Mw+WuXCJ6UkD+PhIqzCVjCqKZxX7RsaTCwRJ0oU4GhytexKWrPfokFb95Euz?=
 =?us-ascii?Q?PZp/qgtZ8uqBdEyaCW2S31HuCM2ovRiPHdQmswqKllhAEH9jOumjjsyY586O?=
 =?us-ascii?Q?PbazKC+CdqxOIc7E1wDPwKfafPwqaR0dOYET+PY7jAQHPGYGpAsRoPCLi7F0?=
 =?us-ascii?Q?H1ZE97PmZ3jlysd/wYqtYv01EJqnh6xm3MzFfQ+gFaRXJIetS+6vmyBi7vQF?=
 =?us-ascii?Q?rk9nO0mbY+KtVyx+0mx48EndLQvtNUl+42K0V/e6xXARYfSG0McKugsP97NF?=
 =?us-ascii?Q?fm9qjKqJkMxRjetnp7XqpfWcnLirrAMY3rHgU/355ET2gFpPJVf2r60XhQez?=
 =?us-ascii?Q?nyfMNCFojjN36pznUm+iQj+/nnrhzh5GpYg6mW3arYWJV5OYrqVepOOaYPQk?=
 =?us-ascii?Q?0z3mAkqC8RG5HRQaJ2BQn94i92ii5WS1J1q4HIe+yT7xIa97uI4rDUJ8dWDl?=
 =?us-ascii?Q?b8xRCtoMy7XY4ce2AeKIgHV+jaSiNWcqjZPiDP8RXNyJqnns432IUu4MuR/g?=
 =?us-ascii?Q?8suSUwfDkCr2q/PplqN47Fo6QZOtj5Y4gbmy0K3HTHfK4CmTKID9cjc49yFj?=
 =?us-ascii?Q?PkxyvS2uUfnDN0nvVixOdPG7wu+BLbcq1p7Hp+ai0w97kp9raOZYw5cVljE7?=
 =?us-ascii?Q?3NkeTZSoGrbfykY9Ss9V7lNj2DqZXVBYKCZSWEi63vyK7SB4e3e40Q9GVwPj?=
 =?us-ascii?Q?UtnDvDnh4zOyKvwtFk6t8xy4XyWjgFQkgjRKBHwAR5j9qgyhdWV141HnPqdb?=
 =?us-ascii?Q?WwKAV3kXrWo5cPiLD5/8nsv/hiu57FPL8mdcP8BkGtqlQyQ0OY7PcE+ZPSTh?=
 =?us-ascii?Q?3OEoo7lRu5lyUcqpSzo/OKy6II6/QA4KnQd7RJBuKY/MO9IqMxTphtmnEK3o?=
 =?us-ascii?Q?a4RoENivf6vekACxRIlbfrfk8qOVWW6OymqEbGAgEs6SG48+PYYh+TKJ2z54?=
 =?us-ascii?Q?R7T7N6yrEKPeKv1JD8Tg395j4jVUEulIKWpWR8GebcnOe5kJwm8i3zY+z4HJ?=
 =?us-ascii?Q?7ME+W7CAv6jFs7oeLsQRcoQF9opjFthIcHDe5+jLnKqqs3urM4VhUnnOPmBN?=
 =?us-ascii?Q?BQ0YtGKGDQ//cFYA/nRN+YwhRWvU8SWcX+e9Ydc0bd/RPC6Cgw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4WEWOK9FxYiWrk4qh5Z6PBQAFUS9+U+0oMg/PdpFpzsTi1RywbtiEF8sIKwj?=
 =?us-ascii?Q?xPMlkaTyAfpnx14/9alPuoumD9D6P7/Kol4wgxMaOE627iNUqIWTbFRcmuQO?=
 =?us-ascii?Q?LZXR3hEKqj3RlnsqpFwa/eXGPiKPSwcXRlbBqEsaoaw+Efvo8516v0tsC5W5?=
 =?us-ascii?Q?Gh0Mtum7aeWAPEXFXTyQa099LGSt+9jJqXO1osgqGG1sIQbY0kH1T9yw4Mfr?=
 =?us-ascii?Q?g+hGzDoKe35g6QuAhLY5f6tt3I85Jag2IsdDAFz7BzgaSyZIJAZedodVUjOJ?=
 =?us-ascii?Q?of2iCwivk8URmRNOEOy8hqA4REsX6dqJXW5IdRLCvz9z2Ol4mdT+MuHbbsmk?=
 =?us-ascii?Q?zFcK00j2UXR+HZNQY0YNGymSjrPL4JBti/8Yu+Qjd1OJmxRj4tb4OPGjJQoj?=
 =?us-ascii?Q?hKh7COQW1lcNl1byYgZKBTQt/0YWbdtExA3Dq4bUlpTKHVkFEuwMyuIN+umb?=
 =?us-ascii?Q?7x+Ow4wlJTeEhVIhcj/uMiGV8xNTbNLM5Zah3gz9sVxtDLS1qOw6/oTT84+q?=
 =?us-ascii?Q?S7RoEn2NJtuzDvUWSE2KnUVDxjdHuLipbuiyO4AwC+kLlzKV270MmODeLAQ0?=
 =?us-ascii?Q?Wo77TQH5NyXuO7x2E0WKIPng5PLfsNZNm9/ztruwuvB7pKRsDwGvWFAYsjgF?=
 =?us-ascii?Q?NzwoDdPT3Ue5quEmXFCZP8GFqidQN2K+XSkFDQCpaeao+s/HZZi6/OCCwTBh?=
 =?us-ascii?Q?ogKrGfQ01kmDrqfYEPjkUe6hlmktZmVCBEDkODlIZV9GwhpwLCgceAdoc9A+?=
 =?us-ascii?Q?NwcpnrAmW3Kq7b6C4f3axcZKAP4+N9soaaFcinWiEWwYJmZxfsUMOd0KblHN?=
 =?us-ascii?Q?+TDC95TBkRnRjJMr3442cF2I9EzQRY/+QM5yuV8zSeFWzmlrcvOX1LF3NY2N?=
 =?us-ascii?Q?I/OXNUNBalIIzYCg+JBGqIrOc6AHNAbV/9eR5vUPnXReD0raDS8nfBomrNxb?=
 =?us-ascii?Q?sRh+EzV5PfpLuDMImHdsVVn2dxzqz47l6KDOmEbUJKV5tayGdEOcPWOWQ9zW?=
 =?us-ascii?Q?oleC9tgJxcjLvJnExN5IDm9vim79oYy+ehZVfJalAzdLpuWmfuEHnZdBVYN9?=
 =?us-ascii?Q?hSsVHunAvM8+LIXYFF10NcbfUIFtoJe9+ePIYEwl8ZLSbowQx9wBB2cVCd5e?=
 =?us-ascii?Q?8tUJcIcotk0tFUYKgu+W9QZCQwBC87/otJ7niNjuTldPdYkyc1w5dEZwa/Uw?=
 =?us-ascii?Q?qcRIssjlHZ/arEq8lEyAGrfX2ndl/Uus5TqQYGJfQmvtPLKQSIQy9Ml0/kUd?=
 =?us-ascii?Q?+j7fBk6nhBQXLSCBTQvSNUvqDZU2T0jtmWIuT+15r6JjYzaxqps6wEYeF4kD?=
 =?us-ascii?Q?GVPrR6P0TrcdvnM8eltzo1m2nCeazWSkoPSY5ekieGb6h8jg+Xm20kanrvSW?=
 =?us-ascii?Q?R+953bP58vluLQAEa8GwvFhLWPslVLJFWGEjr10Avn3OZn9P3BAyPusfVXGh?=
 =?us-ascii?Q?Hcy6qcp6C2IBigQ7KUce9S9NQ+686ExgnD8RmmgooW01SOwIYPXvimL5iMGg?=
 =?us-ascii?Q?LMn3GdzAveJGUld4AzK8uv/ZkNS738SwzxZ97kUoUE1uolM+Oa42YeAsFebk?=
 =?us-ascii?Q?vKEXIFn7/GfTuyynqJ0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c59400-70db-4e2d-4864-08dca0e1658b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 13:08:31.1112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LeYH4jJa50jcu/v3fQ4HyofxV0KpHNOUuyky5W+bt6A4VU5arm9xzkItoJ9rnOLZishV1PSjopd+JORpJtELfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, July 9, 2024 8:55 PM
> On Mon, 8 Jul 2024 11:00:16 +0300 Tariq Toukan wrote:
> > From: Daniel Jurgens <danielj@nvidia.com>
> >
> > Expose a new cap sf_eq_usage. The vhca_resource_manager can write this
> > cap, indicating the SF driver should use max_num_eqs_24b to determine
> > how many EQs to use.
>=20
> How does vhca_resource_manager write this cap?

In most literal sense, MLX5_SET(cmd_hca_cap_2, hca_caps, sf_eq_usage, 1);.=
=20

But getting there flows through:
devlink port function set pci/0000:08:00.0/32768 max_io_eqs 32

See patch 02/10.

