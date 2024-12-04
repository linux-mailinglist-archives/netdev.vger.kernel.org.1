Return-Path: <netdev+bounces-149087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E79E4512
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 20:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1FDB80230
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E13522F38F;
	Wed,  4 Dec 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NN+RIEAy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9CC22EBD0
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332344; cv=fail; b=XzA85RdEHPQq5AYQFaW9KpNQFAPAv9sZVy6hXo9Bwrl/DBSdn9stFPRHqEgscZXLJwiRa6p0vkPAPd8pOmMrpWg6znpRGxsTRurRECEcfC5ZmsRM0xZSbltg2f53qF30dy4xPJ6mpxH2uLkr01FWea+yc66ahgKs/CdBjVrfFq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332344; c=relaxed/simple;
	bh=MeftOVPlXt5sINc4FrFXR3l7hVCgLjBbDq9e5rRZVto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ebUHGZZSV9JRhLv/VhsWYZmvZuRLZMiuBLI3f7GwMvjrY3YL4sf1M2/fFZsKCF/v/AMY5Xi+9k8KZurX7eN08uPs3iRCZ9flGO2BhdmV9aNckUEcfrnws3x0d2ol2DU/ys8AJQNwBGKu1yhtGYF8Pz9Q4F1N4atYYS9gjb84bIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NN+RIEAy; arc=fail smtp.client-ip=40.107.247.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuLKAhzmQJ78RIZR40t7zYnkKKMCsXW/UpsidM4tfplkOIvdRMZfKohIHgHGN7HYa+AJ9EbfYFD2qiYlX5Xz5LwSfps3sI86ljne4jmZLDaua2x5pqsDYo125WFAT4q6d2WyozdzdhAOx9Xd9hl45HeAZqM/aNXA8mWhBZM4LZAoklWGJ/0Qa3LWCw3+o8zkgdOJbfy7rMjK1/AAbJGbEvUJHlNFfINy/5xHn/Qi/hfn/d3ZlLSXVAgN5Ua3I2AE3DSzSDKBcViMLDAFiqgm04m+eOgPWBSzjM/DrbaKU+0ZG9UUG+b1UsRo9JGKsbJYkpn9aG1jV1RQKXujngLkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr0BHRZK4HxPMobk1FIcqgkgcsN2ZdyJ9tsuwqFO8g8=;
 b=m9ORLyUUmzP3e1ZJgdRy/UAgSkC2k3gBLlpJdKJUCAw2jrDsgln9C5uLUtcmZ3FK3/Mq+TYOl44p5cmf2wvdj6GvPQu3UGauX3fUqAKtMf/6m9h8qLXqLkapAdkllzzjMnyLs3qdMrCLSMjT9MCBiq0Ws2vdZLZgIykRywggHvTSh/zUjwAwHbJQE1+kevTkd/qkxrMsI+xiYzamZVmI97I8TDS5h/EawoAOt4IAu4Xvdl4yc1Xc9BiYR+Sgl4I53uIUAhJL7LUfehHOsVy+A95CKuFkAa6GI+OrLxHVt1cL9qm8cMMdsHLKfxbSIvF9P4IoRY1WygBuMEi2vhu10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr0BHRZK4HxPMobk1FIcqgkgcsN2ZdyJ9tsuwqFO8g8=;
 b=NN+RIEAypzsx9iC1GED2cULmzUp8TJt8w/pMpmvCc/HTiNqZmAI7PPzEfS4T6fszPt3Je7zw2SR5xN/zHTdYaN+SbESrV4WjUP+scW/MI4jD+fL4dYa25+cCQwRXWUt0D59F1mCzTTvQXZ6LeuyRX5sNx4DcqAn4clr9I9XdoV7nS1+XWbhen3cTrwoBVK8TM7k81rWVlWuZeA3RtJ+9P1RZAO8fF0At/geY6Aau7vejO+CWktGL9QeRM2MDGj8fJ9UCtTCW6/mfgLAwC+9MPv7Td1xHB4m7sbMM/XiD2yhq0x5JpOPaiHXZcJ2UqxeLW9nocE2Scu2puKQw0s8Tig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 17:12:18 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 17:12:18 +0000
Date: Wed, 4 Dec 2024 19:12:15 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v8 03/10] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241204171215.hb5v74kebekwhca4@skbuf>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
X-ClientProxiedBy: VI1PR02CA0072.eurprd02.prod.outlook.com
 (2603:10a6:802:14::43) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e532230-4d7d-4867-1f47-08dd1486ce91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8emnwnCcgwnTZTP4ifr11NHP+zRWod57+fS0zAKcfVm30AaLBCPzd9Tqoa3h?=
 =?us-ascii?Q?VMoTBtGW5Bkcc5pZzNgwthPXUKM7o+cEs8MYa0S88IisMLtY+x7vqF6Phj3c?=
 =?us-ascii?Q?WQzvnmCeO+XeN1vGxYxN17PKJVmfQvmc0DWc4XmTPhdMr+F9Q+5Nfs5SpjF+?=
 =?us-ascii?Q?QG7d0Ks7QbLuqPSsXAVrffVrrFpnEtm1k4DptdjLtneUILspWzY87lfepVS4?=
 =?us-ascii?Q?XBdTpULSOXM19ef0Xn7NJVPlIjZ67qO0ptgA1kvmXwMWC4C8O/gvOiYUy2CA?=
 =?us-ascii?Q?o+K/3SjqD6C27qz1sLv+565IzoLkUVa7iDipRv3uEjVXPr07EZPPF2OtoIfk?=
 =?us-ascii?Q?inKVWnFuy8ZwPPNDNFycJU5ZHUAYYH0j1F/d5J4VRRQhbChaJEv2eTT/A1OJ?=
 =?us-ascii?Q?VSmaRIAV3IbPrO688OzIuquRl5/d/9LryxtrbgnENB6/ojPUx54lhNh7r8zb?=
 =?us-ascii?Q?LePDAS/P7XALySrt8y3GA/GGNeIB5bPe+qCpHt48pPrGp4o0MpdwhxwaKx/w?=
 =?us-ascii?Q?aZyVZ+61cj9cpppUU8mhv24wl/Wmzp94ejrqtf8xlmEi7ARivXM6GCCbBj15?=
 =?us-ascii?Q?xP26ceAE7MEa7VCVZlW14ovnEGsFfUOZd9DeDNNWVQ06we/5s4qexDPi6uTz?=
 =?us-ascii?Q?ZLqBV5fbLNPMGRHUXQWgaV6s23twsP7oMfuJbz3FB6qdDCIhxqWdrqzKQ7UG?=
 =?us-ascii?Q?PQuDoBTTP6IL5ub35E/BKNuT7q+Xsb1TbWT4bJX721NCVAqlH9ZpKiMpam5S?=
 =?us-ascii?Q?kpB83OBHnyCTOWM2TdYS67h0NSHzisS6s+1XuB4I1/tbDr9zorHQItyz8noT?=
 =?us-ascii?Q?OWm+z7Mdy352DgrXafkswquY/Ua/KAJrNJTZsw03QnGqtmJpdR9Fbis68R/x?=
 =?us-ascii?Q?4jMFck4VhQ/j+h2cZfpjLs05C3aoE0Y0BSd4lIo+UvrmKhxhlS56PvYR9Ihm?=
 =?us-ascii?Q?9+54/OzIYMIR3qy4dOF9hYA8VbNUySz+ZWa3gUrKf5o4Ts7+lkn9nCCcAVH8?=
 =?us-ascii?Q?wU+b5Ys/3xFDYJccCm28PVYHpphmGGxKc3WQZOCWrQhza4tvkHgThmbF9tt3?=
 =?us-ascii?Q?yaCDVZap3oCWxl5dEh48mFWQ9qm6NcyKqnQun21mMYSOQnft9vaZiSiuhkzJ?=
 =?us-ascii?Q?hNM28EYuKLThcijv7GnerZgD36BbWP5HGk/nu6ESorPPIKJzdoz6WjHe5Acr?=
 =?us-ascii?Q?vx6I8b7OXgD0DiD2JAs+D4FK6KCEHcRSpVLR5YEfMm8FHDSWgKCOpK/OMiKw?=
 =?us-ascii?Q?IYEACDbviGLZGZrzV73R2xWrxZTVic7EnwuWCnP56gKqO7YYMgWcifm1J/r3?=
 =?us-ascii?Q?mYh/888kHA8o7Pqwo2tGjQ/6HPEV/RCjb0gKQ0wa3D+bbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7loCvjaqds18TqBNP5oUOvaubOgJO7HpiMAlgFEzrh881pwpUQMSgsC7BnCr?=
 =?us-ascii?Q?FyVAhWLCpEkLGnzgrrpTvcX3+DrW98s1QubCzC9eoqAoNQ9447mzQcmTYVQj?=
 =?us-ascii?Q?dUbGqEVv3UGXLkNDxcolXwnBHr9HkFwZaVdXi51kRmg0Pymf1lrbqAT9gzTh?=
 =?us-ascii?Q?QI5C8tOnNHX3PRESgHWXxR/LBgEXjVSX0lwwM7qZvaS92vDHTrXVoJg0EF9T?=
 =?us-ascii?Q?NlfG2O2uq6Lr9L7+4W39YZ9Cxm5PRR4T89GOxUEAVQjwu+iivfIKmquN31b0?=
 =?us-ascii?Q?lyTburdOwHQxRYnfx1hcDYYh4ZeeI5gvHjV5iym2cL9Nz5GT95sV8VwDOeBn?=
 =?us-ascii?Q?AjgXNQmglaZQUdDDy5v5IpN/CWHODe48eejSgvtFrenuaHMx3HOgGfhS+WPP?=
 =?us-ascii?Q?6uzNNa02NiwUk5pqppncZoYJFIeyxfxm4Szl1h7SGR0YEQcpJzSbxGJ3+Z0r?=
 =?us-ascii?Q?TBeH2d0lXXrX78nq/w521SfwaMnTVEZ2xgcqfwh65aikSFnWw8WTtVrVFG5h?=
 =?us-ascii?Q?xdVguDtFq2g4EvSI/C79YgDuWPuzVd5z7tpBGVwMDX3bOT7pqH67vI86kZ4L?=
 =?us-ascii?Q?SwSYkOCCxqIcp4AA6J14wuzz19whk2bAb3aC795CmLU+HgFW3fYkFJ7nhohB?=
 =?us-ascii?Q?Gek4m1XXtQFbSVaZReacYCKn8fas481dtqV2vxWuIP7drwhRWWLRwmcirbNn?=
 =?us-ascii?Q?/qUTd2s2k02SvbwiKg6kzh1CcUeM9PY8pwVRJSb1BRj3Kv6iv9L6Gm64zZb4?=
 =?us-ascii?Q?Ft/GwW2HRgmhZiFY7cHwKjl2gF5wY69G8HBpyTpBs97c7sFq/wbSP/Ma68OZ?=
 =?us-ascii?Q?yd3gSYtsYBA9iZrOt3AyDVBx9KDm59u1q4V+B5QyooNRym1vx2IDKg0cYWen?=
 =?us-ascii?Q?sI01SWzKYPLltqnvtVB3QjX6T6FQCpsYGy1Wet64kCrgepENDRm9bJ7dtPmL?=
 =?us-ascii?Q?txQuYEsUKkDa0qxduPOTz/S3BfL8gNT5wCt9GQEdGKdD4hQXuO7aq5eB9II6?=
 =?us-ascii?Q?q0bwCu9NFJvXx7kx+7usC5ilk33g/cnNAauLGrVSmHTgS5vfKLkMEFYPOUCS?=
 =?us-ascii?Q?k/ARQbco6hiUYfrXsebu8XHAxJR/kP6PC45GwOmzDpHPZ3tnPCW2mIeVo9WO?=
 =?us-ascii?Q?hGbNLEJ8MYCeVZFP4IxB+2RHkZ3arB/Xzw/pzld2t22WkuBVvepHMoe9JqWg?=
 =?us-ascii?Q?T5gUS3H3w+pSFDncFcTjCSs3USBIa4oA3MHG5w41hxB9jghfPjYL7za2Z9rC?=
 =?us-ascii?Q?dXJcmZwa8nLMCfogVX6Rr9VDYHJhkNBvhPny7dOU8SAEn3RL2iMnEQ1VxLu+?=
 =?us-ascii?Q?ZjKR1Jil/W1IjovWkRKVjuHhkc7cF1QbVgGwiINa/xjPqiUmuUfdMHwNVqWM?=
 =?us-ascii?Q?AfKiqG/9W1wE7+3VJ61wHl1aExaDRJt85UU9LJWQlkHYN2JY+KWY2Jrx0U8N?=
 =?us-ascii?Q?uEceh10zCQZmbPamjMEXYgr2tBY9NO8pb0BnTlYMQVI8zeU7FJjCxk1UM9w2?=
 =?us-ascii?Q?qKrnjVd7lk0NoCtD66cKw7ziuZIYNvLNFDT7IvDxhqnzN9t36v6fDdNCfpjJ?=
 =?us-ascii?Q?UWg7McC0nfG3+x/bs7OHSSekciKJoSBBJPrra/MTHJAdxI3DzvkrMe5oMIdU?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e532230-4d7d-4867-1f47-08dd1486ce91
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:12:18.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDyNYj+UXUzsg5TlPZ223fMuw9wVi/2yfRtnBe2dfWa/g13TBohZpgtOhxIaMWntizN2SRyVASc3inPt/tNnFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8981

On Tue, Dec 03, 2024 at 03:53:49PM -0800, Jacob Keller wrote:
> +#define CHECK_PACKED_FIELD(field) ({ \
> +	typeof(field) __f = (field); \
> +	BUILD_BUG_ON(__f.startbit < __f.endbit); \
> +	BUILD_BUG_ON(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size); \
> +	BUILD_BUG_ON(__f.size != 1 && __f.size != 2 && \
> +		     __f.size != 4 && __f.size != 8); \
> +})
> +
> +
> +#define CHECK_PACKED_FIELD_OVERLAP(ascending, field1, field2) ({ \
> +	typeof(field1) _f1 = (field1); typeof(field2) _f2 = (field2); \
> +	const bool _a = (ascending); \
> +	BUILD_BUG_ON(_a && _f1.startbit >= _f2.startbit); \
> +	BUILD_BUG_ON(!_a && _f1.startbit <= _f2.startbit); \
> +	BUILD_BUG_ON(max(_f1.endbit, _f2.endbit) <= \
> +		     min(_f1.startbit, _f2.startbit)); \
> +})
> +
> +#define CHECK_PACKED_FIELDS_SIZE(fields, pbuflen) ({ \
> +	typeof(&(fields)[0]) _f = (fields); \
> +	typeof(pbuflen) _len = (pbuflen); \
> +	const size_t num_fields = ARRAY_SIZE(fields); \
> +	BUILD_BUG_ON(!__builtin_constant_p(_len)); \
> +	BUILD_BUG_ON(_f[0].startbit >= BITS_PER_BYTE * _len); \

Please add a comment here stating that we check both the first and last
element to cover the ascending as well as descending ordering scenarios.
It took me a while to realize this, I thought the _f[0] check was unnecessary.

> +	BUILD_BUG_ON(_f[num_fields - 1].startbit >= BITS_PER_BYTE * _len); \
> +})
> +
>  #define QUIRK_MSB_ON_THE_RIGHT	BIT(0)
>  #define QUIRK_LITTLE_ENDIAN	BIT(1)
>  #define QUIRK_LSW32_IS_FIRST	BIT(2)

I spent some time today to play around with this version, and it seems
to work, but I took some liberty and made the following changes:

- Tail-call CHECK_PACKED_FIELD_OVERLAP() from CHECK_PACKED_FIELD(). This
  reduces the size of the generated code from 2753 lines to 1478 lines,
  which already brings it a little bit more into the realm of "tolerable" IMO.

- Remove the BUILD_BUG_ON(ARRAY_SIZE(fields) == N), since I think
  that's just wasteful (in terms of space and compiler CPU cycles) and
  ultra-defensive, when the auto-generated __builtin_choose_expr() is
  the only caller. It was justified when the consumer had to explicitly
  select the right checking macro.

- Add some prettier error messages. Compare (for an error injected by me):

../drivers/net/ethernet/intel/ice/ice_common.c:1419:2: error: call to '__compiletime_assert_3302' declared with 'error' attribute: BUILD_BUG_ON failed: max(_f1.endbit, _f2.endbit) <= min(_f1.startbit, _f2.startbit)
        pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
        ^

with:


../drivers/net/ethernet/intel/ice/ice_common.c:1419:2: error: call to '__compiletime_assert_3414' declared with 'error' attribute: ice_rlan_ctx_fields field 3 overlaps with previous field
        pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
        ^


That incremental improvement is below, if you'd be interested in including it
(the auto-generated code is not part of the diff):

diff --git a/include/linux/packing.h b/include/linux/packing.h
index c4fc76ae64a5..1c89a5129b06 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -36,22 +36,38 @@ struct packed_field_m {
 	sizeof_field(struct_name, struct_field), \
 }
 
-#define CHECK_PACKED_FIELD(field) ({ \
-	typeof(field) __f = (field); \
-	BUILD_BUG_ON(__f.startbit < __f.endbit); \
-	BUILD_BUG_ON(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size); \
-	BUILD_BUG_ON(__f.size != 1 && __f.size != 2 && \
-		     __f.size != 4 && __f.size != 8); \
+#define CHECK_PACKED_FIELD_OVERLAP(fields, index1, index2) ({ \
+	typeof(&(fields)[0]) __f = (fields); \
+	typeof(__f[0]) _f1 = __f[index1]; typeof(__f[0]) _f2 = __f[index2]; \
+	const bool _ascending = __f[0].startbit < __f[1].startbit; \
+	BUILD_BUG_ON_MSG(_ascending && _f1.startbit >= _f2.startbit, \
+			 __stringify(fields) " field " __stringify(index2) \
+			 " breaks ascending order"); \
+	BUILD_BUG_ON_MSG(!_ascending && _f1.startbit <= _f2.startbit, \
+			 __stringify(fields) " field " __stringify(index2) \
+			 " breaks descending order"); \
+	BUILD_BUG_ON_MSG(max(_f1.endbit, _f2.endbit) <= \
+			 min(_f1.startbit, _f2.startbit), \
+			 __stringify(fields) " field " __stringify(index2) \
+			 " overlaps with previous field"); \
 })
 
-
-#define CHECK_PACKED_FIELD_OVERLAP(ascending, field1, field2) ({ \
-	typeof(field1) _f1 = (field1); typeof(field2) _f2 = (field2); \
-	const bool _a = (ascending); \
-	BUILD_BUG_ON(_a && _f1.startbit >= _f2.startbit); \
-	BUILD_BUG_ON(!_a && _f1.startbit <= _f2.startbit); \
-	BUILD_BUG_ON(max(_f1.endbit, _f2.endbit) <= \
-		     min(_f1.startbit, _f2.startbit)); \
+#define CHECK_PACKED_FIELD(fields, index) ({ \
+	typeof(&(fields)[0]) _f = (fields); \
+	typeof(_f[0]) __f = _f[index]; \
+	BUILD_BUG_ON_MSG(__f.startbit < __f.endbit, \
+			 __stringify(fields) " field " __stringify(index) \
+			 " start bit must not be smaller than end bit"); \
+	BUILD_BUG_ON_MSG(__f.size != 1 && __f.size != 2 && \
+			 __f.size != 4 && __f.size != 8, \
+			 __stringify(fields) " field " __stringify(index) \
+			" has unsupported unpacked storage size"); \
+	BUILD_BUG_ON_MSG(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size, \
+			 __stringify(fields) " field " __stringify(index) \
+			 " exceeds unpacked storage size"); \
+	__builtin_choose_expr(index != 0, \
+			      CHECK_PACKED_FIELD_OVERLAP(fields, index - 1, index), \
+			      1); \
 })
 
 #define CHECK_PACKED_FIELDS_SIZE(fields, pbuflen) ({ \
diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
index 09a21afd640b..fabbb741c9a8 100644
--- a/scripts/gen_packed_field_checks.c
+++ b/scripts/gen_packed_field_checks.c
@@ -9,15 +9,9 @@ int main(int argc, char **argv)
 {
 	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
 		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);
-		printf("\ttypeof(&(fields)[0]) _f = (fields); \\\n");
-		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
 
 		for (int j = 0; j < i; j++)
-			printf("\tCHECK_PACKED_FIELD(_f[%d]); \\\n", j);
-
-		for (int j = 1; j < i; j++)
-			printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[%d], _f[%d]); \\\n",
-			       j - 1, j);
+			printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", j);
 
 		printf("})\n\n");
 	}

And there's one more thing I tried, which mostly worked. That was to
express CHECK_PACKED_FIELDS_N in terms of CHECK_PACKED_FIELDS_N-1.
This further reduced the auto-generated code size from 1478 lines to 302
lines, which I think is appealing.

diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
index fabbb741c9a8..bac85c04ef20 100644
--- a/scripts/gen_packed_field_checks.c
+++ b/scripts/gen_packed_field_checks.c
@@ -10,9 +10,10 @@ int main(int argc, char **argv)
 	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
 		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);
 
-		for (int j = 0; j < i; j++)
-			printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", j);
+		if (i != 1)
+			printf("\tCHECK_PACKED_FIELDS_%d(fields); \\\n", i - 1);
 
+		printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", i);
 		printf("})\n\n");
 	}
 

The problem is that, for some reason, it introduces this sparse warning:

../lib/packing_test.c:436:9: warning: invalid access past the end of 'test_fields' (24 24)
../lib/packing_test.c:448:9: warning: invalid access past the end of 'test_fields' (24 24)

Nobody accesses past element 6 (ARRAY_SIZE) of test_fields[]. I ran the
KUnit with kasan and I saw no warning. The strace warning comes from
check_access() in flow.c, but I don't have any energy left today to go
further into this.

I'm suspecting either a strace bug/false positive, or some sort of
variable name aliasing issue which I haven't identified yet.

