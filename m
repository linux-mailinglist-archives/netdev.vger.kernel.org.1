Return-Path: <netdev+bounces-260678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMucNK07nmkZUQQAu9opvQ
	(envelope-from <netdev+bounces-260678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:00:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3249618E3BD
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496743052BAF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34D322B96;
	Wed, 25 Feb 2026 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnyyx8HF"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204522129B;
	Wed, 25 Feb 2026 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977619; cv=fail; b=KjrVzFymY+8uO0dqX8PkyTz7xgTi3IRotEUslEbL0bz7tQ6lb4qCtIwerM7ypOQOskt9CgySYVk94ZkoSJX1yr2DtrpAD1dRx3EAmjrP+B1hnM0FZtQPlk+sVIt8JXhYgBsZh6AUMELLhdXzrMwhdHCkjEJJLOrfZpKu1JgbzQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977619; c=relaxed/simple;
	bh=lxh4yj+mYD7MgljNNc/lbQs13ngZ1FdFIuD9v3KMozo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okAmHf7SyyhSkM990Ca0WHkoP6iPRaUA3fNPxS4P5F/ygyH8NKyZmcz2s9J8kee1S07GcIbNlStizGmYXpprrR8RCMjcx+6JgeVKSfuC6wDkZEnBZCRzofRS6DSeW66IWCkMBObz1gDKRBQRHEV64h6/j/GPIl1IY3tjjwDUHEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnyyx8HF; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFEcxLcypqyEDNQqtjv5b9D9k7gB7igrEkbqOlWGx0a1vWKy1ynu/0TSQWaH6DnSmf+F5sufKRrwvXT2my0F0RLIdhbR8J82NshwnF1N4JKUBnOYNXMOCA+fXMREsy/x0oQJ3JRTZ+LroKCZG/51dz3zQhyJXQ1yt4fyJEODRyl5Ce2C42cI3O3S6iuZqrMZf7vbuQD8ED9HBjw2jEBwZnJQjNsNQHpZs6yzbsp2mqtlRXs54ygGqPayieUrP3yWFdl7dQHIN/fY+B+Tw+ly6MAAP6fz5mptbirB1JFNmXMWs24m6QndJcawepmJVt/2pQvm2dsERudOilMLIkZtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdyTGNr8Eer3pyR/Bdlb/OklFsOqCzUlwQpSOtHSEO8=;
 b=C0hl7wMliijiNYqZd1XMUNkSsCpq9gB7P5zS2EYbpZmP950DygfKoAk1VSAvmI6VW8ayCInqh/QOoO9tsJZzUEST5jp90CnVCb1Z9RwUdTDT1N8dKP7ATBfwGqnzHk483xPyEaLrm9OqwM21uapW7u4gXcQsc1juLzsI1IwKjx7XlggCFKu6ZE1PoXs+pnsK0zF21fpRAZBPYvzkqw8pp1WI/a1ZG931mrRbfq+iWcX5OCB8CFtsbN5SH8KAePoEo8njGFVpSBfQPU9IZvFV5yX79Ds9ETeyK2GRVkc+9En/vCWnpxw7uaiPzU2qZyAYLlGKuLcCvdhKta9nG8o6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdyTGNr8Eer3pyR/Bdlb/OklFsOqCzUlwQpSOtHSEO8=;
 b=mnyyx8HF5NKcAIFJQuQmmUc1CsOPCtZZCC3Yjv2mOimarDtjLn6Jtd8SErWl8ZIHuNUDSqq/xzbCMkG7Clrdb2nSch7hyw+y9qABCKu8uaBXu7fpvtRG/y8rgOqPx7I10QJbwH/bxU8/x6F9QxKbhAs/tC5mso0Txrsv+JZRyyGQSWOvSpk0GiyX9xaVZqaaYcaulZJOo/BFO6hQP8TTxaokmbBFD1vBn/HebS/qlXND3pmN0sI1tu8aMA9MSdgtF3j9MPs/E58fIDBTdr3yRUU9/USAcXK66ha/bDxoFhrqpqlsf1PDFVAuF4jvtT5aTSdDZsLFcjxIRhihHK40mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Wed, 25 Feb
 2026 00:00:11 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:00:11 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH RESEND 1/3] bitmap: introduce bitmap_weighted_xor()
Date: Tue, 24 Feb 2026 19:00:03 -0500
Message-ID: <20260225000007.255837-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225000007.255837-1-ynorov@nvidia.com>
References: <20260225000007.255837-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:408:f4::28) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 24edac52-291b-4153-bd16-08de7400d873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rL7WRsl1dWSqN1Nyy0U91vNR4hK7MuPLt2SrMAvqcsDz2u2b2OEou0WUp8RR?=
 =?us-ascii?Q?iquB6rxrUS1x4cJ23fPcQK2HQPmmLGhp4Z/VxNFO8tqbMnE+m85tYQ1IesJB?=
 =?us-ascii?Q?li2CBi+3QQzdAb5GIWZBOZBahRY35Dvej0chWPfgYNptzbMuSfJCt0bEJIux?=
 =?us-ascii?Q?ALK5maTctZBvzP1u2ngDEByTC7yXHLbwczW1mcR2RLicx9nOsZMbNYnSD/Fr?=
 =?us-ascii?Q?v8dNSuhXGQetI72ZPZlZmzaVl8AGKlk9KuaSW5w0ykwgKH1wv/SF7A6SOyMf?=
 =?us-ascii?Q?e/7YcM94rX1KmwFGFarvlT7HenlQIFFr1oScRFIBUzkYSzL71tZNiwZ/ApWa?=
 =?us-ascii?Q?tGhVanzBc+8/6JamEuGH6/OGAnHASwvInMbW5/X/rP+QKVm1Pcw0q9RRww5w?=
 =?us-ascii?Q?kCXdaLqFYUmt0dKmVOjbREBEqTuEeAbWG95eWxX3BD0RveXtx9vGXaQ0eXVS?=
 =?us-ascii?Q?UkXNGv6VFzkMOkluMmJvK7ul2Hg5ctETGcLQcFbDduSZgJT0LGJTrn+uqmjh?=
 =?us-ascii?Q?LSckLnFJ5o4ZNedn6mcWiJrESHylhO7vg8l28+bowfBvdNfE/yjMnbuBxAhn?=
 =?us-ascii?Q?yOBeZyYxaZPoON96kP/khwwWH09s8CLY7lTbiZC3mMYehL6Bzl9AbAl04bks?=
 =?us-ascii?Q?MxFLBYJeIRYyrq2iTZ8NLM6Tk5dZjoFPt2eo9SM/6e4PNGR7W0gspCuhlvT4?=
 =?us-ascii?Q?y5Scb5gclHQBtx7l+4E98ObUFaugkfLv7Vh36+oSV18b8kk0b4qzSL4urdxg?=
 =?us-ascii?Q?xBLTfsAyg7hd9Ril1CoBUexdpK8BsStz6xUkMdbpu3pW7SuOy8DzYpwlywBl?=
 =?us-ascii?Q?0Fbik+VwS8unZ4O39MGk/7kIiiESbkKvBnGgcsfLKSFjXl88KkHb3fHMO+yY?=
 =?us-ascii?Q?4P8jzFTvBlnQ+K40DExfIQKV0WHYaAmCsxms+nzNp7KAnsuOARmDjxzwx+gi?=
 =?us-ascii?Q?81StkVtNWwVvH1Cd2fYS5eiGtLUj3uUhmSFeOj00c2LrTcF1RfLmM7fjQ+g2?=
 =?us-ascii?Q?dNVY9jVNV8iZLjV7TbAs2AqV1fWPlwbwo+MH+ge2xJgL6FRfZULWpzv+w9xI?=
 =?us-ascii?Q?Aw65/qbHAClVgdrnxsj/8k/w2fgDK+SPVYPpmFDFsk+2+WKyY8li25idjcdg?=
 =?us-ascii?Q?3Xe1Wctx6WBv1Ht+KSbh+grL2LUCUiM+wcFr0r3TEfKRwd6XbgdQBIaNqlaq?=
 =?us-ascii?Q?QzIiL6zGJwN+2ALywrP6fEPIFHGhykt1PL8KZlGXJOXprJU6WUIN6sUL2q1X?=
 =?us-ascii?Q?nAM+M6ozejd/1jJXluLwyOBuPJflwQPUV6I4/Ta3WespCOmWLh+FKCsnhJBn?=
 =?us-ascii?Q?D6s70TfxZSu0ozPNx76rOh8Iy0pLPSw+k5ZIa5DpMiXrQdVf8/rzsb6Y/k6K?=
 =?us-ascii?Q?aFifDNLMI4vQffO3AIDf6ZwQt1Ga3495ZLkuumpqP63OKaehdHmqDLlhmEr/?=
 =?us-ascii?Q?1gQgxl5ujHsKm3kH7IJ7BRzYIhIiO5wJCynsJ+OCYQKmd6WnB7hC498vIUM4?=
 =?us-ascii?Q?2EIYC/f+dT0Rbbphjw/Q7rEanMxS4FfdhgiCfRtiCtUEp8DMHmQCsljIno+V?=
 =?us-ascii?Q?a3n00M8BpjlpA4CC36x/dCBeCa8ZI1D/x337Mtd6elmVbMENIEKIA+5zh+d6?=
 =?us-ascii?Q?HA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hyWGotAJli6m+m3Ql7Neiq1fSdVsyQYnhBzKMCS+WkdViJR662cWCudMT/sl?=
 =?us-ascii?Q?oHdHPXDCphAAk4xddOUEXZx+1R9RPVlM36/ieeZdI/N6ogmHAGHu/XMIhxh+?=
 =?us-ascii?Q?41vewcRUFkPl2kkhp9Fmyi7P4NwSwP/aBxrkGgZ6KDD2+fu3keBKbSYPLS+H?=
 =?us-ascii?Q?/AKPQZLoOe+xAd6V4gy6RebNM9GVIWtolzH34NNE6pm97ibVL9uK1MM3Om3D?=
 =?us-ascii?Q?wvRTLnJ7frl0PGidUtGPLjmGSlUw1Fu962rrIZbK/nycjPnbQ4MfKFsMQ8UQ?=
 =?us-ascii?Q?e83xC8MfZIFRQ0gkyDE3S+YoavKmImq6i55dj4Gurrtrn0uDTAUV0cchr6y5?=
 =?us-ascii?Q?J2f8f7lBXEQIg24PGZ5wJoFPWRyOByvGqCeK6IbFcdY0dBQVNONt5s4Kb16B?=
 =?us-ascii?Q?7tJstz8eKxgCCF2qXVY949R8QT6y13K0hLEeNALTjmECpSIs3KLEpXeXUkLo?=
 =?us-ascii?Q?c3DV/BSzBiACsMVQpxRhZNLsN7Czfpyrr1dNOhAhm6QEhp9hxL1uyqMCLhkn?=
 =?us-ascii?Q?GvokPhiddEoNXlLHTOiC/XI4gF3cdBhdzWdqszfP9mA6MXiS0yzrlCudkl6Z?=
 =?us-ascii?Q?fKX0tKYQpFrJ42kHOzjEGBPUno9o2JEKtLUko9dI6lA35w/1VnOov2x5vQMV?=
 =?us-ascii?Q?IRest4ielT0PhSZ00Y3bUMEQ/52MvFGBYMtGW+9lD34zXP1e+6ibKTqXcnRG?=
 =?us-ascii?Q?odN+Tm+Q/sRpy/R7TGIn5EyqKK4wDUOzllkHoZ6JiI+2EByasT9P+oaEXhrb?=
 =?us-ascii?Q?+hFfa8A94nPaROXfJXKwe3e0ykpDwzirAk/FxNvH8MIyAgKXF5DzxId0VXfZ?=
 =?us-ascii?Q?w9W28kk5/jVmWgJiGByCZAk9HvmIhXs4JUsdUan49MhamdJsTWUHZF7adviv?=
 =?us-ascii?Q?CleYXqpIq6uIrbN6wBfxW6V5P3BcijluGFkRm1AKIZfc8Y88rGs4/uGd1vgj?=
 =?us-ascii?Q?dw8gmxlOMym4XJkho2EXvk7KN0LM40WxclspmT4uubml22Xr+ZT7aKdDicCQ?=
 =?us-ascii?Q?eylXl5yxcSZgFiL6xzb0IRLUjL4kWxn7szHDy4yV7HSOqmwh6ExSWAsVEpV1?=
 =?us-ascii?Q?f/hEtpnnzRy30T2dOp6UlYym1XLGAzgdlxvie/ONCAJHOTADqR6OLK3gNo6s?=
 =?us-ascii?Q?TGDnjdNmc9LHYZY7eG/AYQrqvAJrYVDAu75fyOgJMcDJmiMQcRf3e62moCc5?=
 =?us-ascii?Q?aPdaqxQlarMxB1f1x7Gnoo7dA6sfAOdu5Mzrl4WYAcAfcuU/CUAIzhEiAYG/?=
 =?us-ascii?Q?/vcUx3W0hQ47rj3UWSBDXL5w2r1l56cHXHoxoaarQODXOlExcuJIVBrtFoWp?=
 =?us-ascii?Q?0rRe2TgQSf8rLcqWbfsFH3fnO5q6idv+ddPWGuoTedXZ+2THeCZuYED1pozx?=
 =?us-ascii?Q?XjQAsQy++RYr4mzgZFbCdFAdRAPEdzam997N9f4rzasqraZcfYVe5zJxfDO8?=
 =?us-ascii?Q?ZUohP6PBiGvio6L5ahWRVKDq3wP+SzoCrTDc2zQH6ad4raoGXQvTuYTMHyYn?=
 =?us-ascii?Q?wnCGwmsgUxbDvVaphi15f0/GFC/okfAKcKi97ZBNRJLtZIxMrCyzuAhjNbkr?=
 =?us-ascii?Q?G2Wii26d7udiJwlvrPey7apZYQuvx66fxJvLxeSQ2+SqzLAG9Mb7JfYHxSze?=
 =?us-ascii?Q?9Ioe9YBgzTc5ToSSFXTnixOKwzzqSceAaJO9oNk7lOEbURttYjEmbHR7Lfa5?=
 =?us-ascii?Q?klPfBOIiVZQfk7wiUukHceyf2Gog029jBuY7GwvJYcfNEqlGTm36F+JM8FY3?=
 =?us-ascii?Q?s+2yfoku8kX1oyVdfABVgqYnG3SkarlBsYor3Qy5qVRTxe/CALIG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24edac52-291b-4153-bd16-08de7400d873
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:00:11.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldOWGec7nBTEO9Urrsopww6XSp9OtpKpE1mpPAhnBPNhPemeIGk4NVWAgENWq2+Gaelck4tWsghZXZxXNzHf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260678-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rasmusvillemoes.dk,linux-foundation.org,lists.osuosl.org,vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 3249618E3BD
X-Rspamd-Action: no action

The function helps to XOR bitmaps and calculate Hamming weight of
the result in one pass.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/bitmap.h | 14 ++++++++++++++
 lib/bitmap.c           |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index b0395e4ccf90..5485076bb2d0 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -168,6 +168,8 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
 unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitmap1,
 				  const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_weighted_xor(unsigned long *dst, const unsigned long *bitmap1,
+				  const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 		  const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
@@ -352,6 +354,18 @@ unsigned int bitmap_weighted_or(unsigned long *dst, const unsigned long *src1,
 	}
 }
 
+static __always_inline
+unsigned int bitmap_weighted_xor(unsigned long *dst, const unsigned long *src1,
+				const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits)) {
+		*dst = *src1 ^ *src2;
+		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
+	} else {
+		return __bitmap_weighted_xor(dst, src1, src2, nbits);
+	}
+}
+
 static __always_inline
 void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		const unsigned long *src2, unsigned int nbits)
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 9dc526507875..a2bcb5b1fe99 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -361,6 +361,13 @@ unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *bitma
 	return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] | bitmap2[idx]; dst[idx]; }), bits);
 }
 
+unsigned int __bitmap_weighted_xor(unsigned long *dst, const unsigned long *bitmap1,
+				  const unsigned long *bitmap2, unsigned int bits)
+{
+	return BITMAP_WEIGHT(({dst[idx] = bitmap1[idx] ^ bitmap2[idx]; dst[idx]; }), bits);
+}
+EXPORT_SYMBOL(__bitmap_weighted_xor);
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p = map + BIT_WORD(start);
-- 
2.43.0


