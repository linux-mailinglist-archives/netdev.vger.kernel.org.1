Return-Path: <netdev+bounces-260679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA3yCc87nmkZUQQAu9opvQ
	(envelope-from <netdev+bounces-260679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:01:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F33D18E3D9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB71B3081062
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE381340280;
	Wed, 25 Feb 2026 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B6Uvw53a"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A43328E3;
	Wed, 25 Feb 2026 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977620; cv=fail; b=NsIe6qhNa0iBrRcVn9ya18tDCgvRZLQFXRQBhthYSvBs3chMbrbXB4chcbEbAMnXO+eHpgG5lYmi5cVF+Jb3vnT6w9OzIF+RwuO+pZrPl028K+5o9VGiuNRRrLztHIxgSqIlj+OPslDnru5BL0wDMgXB8Hj56kfQpfm7INeacR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977620; c=relaxed/simple;
	bh=KjWL/rCJ3/9clsnFyCkIZmv5kLcFLenVqtTiBme/GSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHHfybEVp8rDgIW43veJbGNgX2dj3saKH3nCXCtQVgHbUJuejPwuJXA8mzHQnEFBAe61moBbNoGbgnvGdpbr/IroTaqhXgc07im11/NVb1DMUB9o8Nl+ZFM8epFMMZP9FikkJxMk/IuWrfbYMIMw7G83neTJK6FEct0cc44HW5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B6Uvw53a; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pnf/ml2jgqbxKcB7J3yz4yDp7cTqgD3rpNt9nsB8h4936zTWvQ7JOjEMMpnzO2GVKeEwXksU/aNLGDJnmWLy7jEo5KU37SFuIGTWqMEwjkiIYu4T1xXvhxQo9s9Zyy0kUshlion2VOqFLWCeFjF/AZEkhkb/Db1f/qp1NbgNmvgg467JNiD90skvgjDIF4IY8dfxEsjEGQQBxvsHNDHrjvU9mQBjYSeNWDnyjraY3Ix42Jxz3QzEQswPqlcAPOE9lF2gkVmvT1RfHNJi7Ivwlc8A45nPYGkeKdNcO5ZjHXSvjYgSL3KH0xEXAwf6pi/saIEKuWNiRXuUGytTdYuFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY+R4ZyLpghZEdOurVT/ikZx5Q9R2gakO/uzR2dTv4U=;
 b=vRGc0cY1xAjk0fVIFRIOXFPvwhDiPYIr/kjJB82vybLOvGS2Ug5U9f71RnM4Rcy5KjAPw4XUiSoKPB/o3rcaCghPjXNkvPD7aJhUmOSCzmo2ab/KDfDMnGVwey7wm3LaqSAHJbQzhTTqvixciHX8UH0uo3PY0wO0dFSULk/UpxAVfA45bLGD3az3NIeVjvvstLI0fPurXzWRL9x18B5KN/lzSs78pfmad0cKawwjy6010KuaYGYRYtdpDbtHxuLJfa/KDEbBlKlewrnWt04RSOQpSW12axG35H9R+UYitonLmTjn/X6NCbMItOVnUF96aH7h6qzLkaHeNZvLORol/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY+R4ZyLpghZEdOurVT/ikZx5Q9R2gakO/uzR2dTv4U=;
 b=B6Uvw53ahl8JkXH+Fb7W0Vb/LhaU/+jEUzgr+I3EYN4wDghF+8q0lD+yzBKUZ0daokViSb8UOX9FpY3SPGwSSElfeQ29TNw8le7YtOhLGR6AYwr2UFvRPyyWQTpQeIALb47pmVq/YLm+1EL5Aqg/HZsp27pb50LjKHL1W9ta6NwCPFea5oUEvaUemabRtZSjxSpwhPDlB3+bh0NsYZ64e5eG9HkcEkJBIKTy3iSOa222xP2e0j1WyyIrB/IiJXV3XLKIx4bGp87+WIKJ0CwFu/gmxYtusrLMX3+lUdtapEDmc7wNPx0LjzlvHCBOvZvME9t48GRX52aTqFyCsRN/mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Wed, 25 Feb
 2026 00:00:13 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:00:13 +0000
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
Subject: [PATCH RESEND 2/3] ice: use bitmap_weighted_xor() in ice_find_free_recp_res_idx()
Date: Tue, 24 Feb 2026 19:00:04 -0500
Message-ID: <20260225000007.255837-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225000007.255837-1-ynorov@nvidia.com>
References: <20260225000007.255837-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0773.namprd03.prod.outlook.com
 (2603:10b6:408:13a::28) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 47126283-6ee0-4e55-9015-08de7400d9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nzUP8TuoJqpvgbmQfjwycISdLhNXirrDihiaVbz1fjF9UH6S0lLTX+NtzFS2?=
 =?us-ascii?Q?5lsPd7/d6+4CNBX7P4QaRuTNctnx2GDR7lPL/J6lsqca3KLMk6VWT32+Sunj?=
 =?us-ascii?Q?IzdEX4Hbv6PDbC8jYtLOE2YGJJo+xrM5yX9xa7QiVyhnSV3G4xcSCH0aLYLE?=
 =?us-ascii?Q?GXYZ33qciqD0gajvbldsSflo0heW9DKGMWe3rpLLHeMtv/o17C8+dFC8r1Dd?=
 =?us-ascii?Q?LHVZrnT8p/xjdwhbC91/wwQ62gGBRbTa+MZdDt+X8uZRyYK7T7VJJ0uTHUAw?=
 =?us-ascii?Q?/zi8G07+u1tfuTU4Qn/EVfWoO//R6E0plrf8DTSfnnEpkxWMwDpYtuQd4aDO?=
 =?us-ascii?Q?VYrhB2ffyY79pRXy8dQGaHG7ZbzjlaeP1j3+kLxo7mibDtXrk/7Hy46OAnft?=
 =?us-ascii?Q?Y3hA/2xr2ms5LTlncfIQ2UctRCe7GeFZxUfJvMmUxi0Ig4kPdYpCwrD0lhuj?=
 =?us-ascii?Q?BsD4XOlDQD80zMCyMXX5e30RJqVMnpSgexPMRPwYLHVCrPDdl61gKD9KzPu6?=
 =?us-ascii?Q?NX5DFkDito0scZ+FI8J7aWTKGTZgF/GFKEWmbv93E9SZCGR6pEKTnTY7OC1+?=
 =?us-ascii?Q?kllTXyLm0YUzizaZsuYttuUOVqu4F9yPWayRADo4Xls/V0E8jED2LYBYiy1o?=
 =?us-ascii?Q?74mv3AfydDSLWwUzVaPej/2TnC2GfKreW/p3TAL79w16SO3EogD7hL/g0IWS?=
 =?us-ascii?Q?GYjbCn7T8nkR/slkpK3je2e7JZBHa+nLbZeq9mKJFYA/Y6JZjdcCKjZHwvjV?=
 =?us-ascii?Q?IOttWlD80eukWaVnMYLp94fbgZ2Cy970h4XCfpOxXqs+uIxLJ76U8EmiS6bg?=
 =?us-ascii?Q?iDcPIL/Q9qaJ5oQUxGAtYTL4DkIAnwqAZhg08ZYyG4bsXS+LPGKuB1XypCcP?=
 =?us-ascii?Q?9pr31IfYyD5hy69mGm11LnWIwo3PGbo8hpSc8i02rny7iNF+XITtJDUf3km9?=
 =?us-ascii?Q?rP4IY8MUucx6MLmB20Z1ULpY3Tm35suO6f7ydBishCdAHq4UrqIDjB4N0uJO?=
 =?us-ascii?Q?3+SYBm7/2Y2bk5khyU/nePVocCjHofgxPxaZxGZSywjUjRKZUWo0T0oTV69z?=
 =?us-ascii?Q?GeSTTw9+a4qaPph7eZhxYMHpKjoXSyV6uFjbJZXKecTgD3uix1wVmZ8hjWpI?=
 =?us-ascii?Q?26BsW5t27LRRhQoUqTep6n0J/nrCwM/9QxE/uFC/B45NUiZQUmSLF4sn8e69?=
 =?us-ascii?Q?zbTk59hMY8ph7SEAdHbMwCgh+07dLxnHJw8YyhjGxwuV+5Lao01d7og6C7vX?=
 =?us-ascii?Q?nLirttjvcue4d5r2OMhWKopdc5l059htHbidmeCHOZ9MoqkZA8OFxEAm0QTz?=
 =?us-ascii?Q?scjtgL6VJ8A5e6pBs3vRGaCmxKwqAZg2vf4HF5x2rqp87R6U/POEE6ZRi0Yj?=
 =?us-ascii?Q?Ln1Kk9a76SLiOdOs8u5LTmvE6pZOxdMuZ7hlEMYBkmQ7epFhAlRNzt0/sEyL?=
 =?us-ascii?Q?+o9eXfy7OP+cuj+q99Gb6qlNevtgOUIZOJ1U9TP/SnUI6XErcQX9CKn/88DI?=
 =?us-ascii?Q?eNSOycZiX1BI8DkvbhetHFwgo6jQ9aHQtVG+7C0hMeaUnzk9LaDbll653un9?=
 =?us-ascii?Q?8+AR/JaajYJG69f9r7nJoJMGQuCmZ1UydUQi/9RYOkWx4BadeaAGp9l5yU/i?=
 =?us-ascii?Q?9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5CcEA66tnPEI2XkSuI2IpRi7rohGXncffT4FHqIpvufnZK+s3TzdxUlONcI?=
 =?us-ascii?Q?jLXu4O84u0m+38BDp82JvmVw1XeprwAd/p/cbO8xB/zRaXW19a8OOMECr1sV?=
 =?us-ascii?Q?tSwGlHyR8w+Z2yDSaFssH0a3IC7ijc5qimgt1LJk4h4j/d7SzPbpFqA1YbKV?=
 =?us-ascii?Q?38+Z7TGgmr0ncbvcPShruXX2jMOInfNBS/muxKCSo3k8i3XgUzA5vx0POM26?=
 =?us-ascii?Q?rerYTPmCuPmwVVoPUBiZ2cfPmqpOJPRCUjRIgUYyU/uoFafe7j7bgYkWLjRq?=
 =?us-ascii?Q?I7sP/cZ3tyTurCn6HcqANGARs6EkGri22rM7eHEltjJvRhYRFq5otjcQOUSu?=
 =?us-ascii?Q?QwprbYQ9Mgru50UVqle8hCcE2vz4yNDE5PDeqK3sx+v/hnyQSPwYhofEQiiX?=
 =?us-ascii?Q?QThBJl5zTS29VA92EwSoAq2HJ1R7jG4nMzSrUC8b0qJx8o+zX9C9hM9Gyelp?=
 =?us-ascii?Q?JoiFEXmRP0PQZduMcLeZ4M35nskYG2pWpQB90X2b3BjWKCN/uurToFMMUrxP?=
 =?us-ascii?Q?5s/HXOOmvD6tGtFyZJ0fuzbZCWlpQ8gonue6UiXuLV7IjhRIYKNFyZz0xGLQ?=
 =?us-ascii?Q?ZqtdtHZNMdcYc5a3AQ6RYKrERsJW2i+VppxKJaNRozY9imGauVOTHwiGv9Am?=
 =?us-ascii?Q?loFkbPsOv6UidbQH+EAAkyO6iUbNVY7YKIP/zRMYmZCekTJBztWCIFkYTucb?=
 =?us-ascii?Q?MEsNyvp/UyekxLk4Jyu6+QVCGJOQBUh4GbbDC6zQM7mOmr+JAQsTnhRX4bkj?=
 =?us-ascii?Q?+GPFAIMta/7jG0ViqnssZWu6eatVw7o1TgQgXiSTz2+9Dw4B/pgmrYgqDYIv?=
 =?us-ascii?Q?T9vDAC6qQPwUt6d+7zOxZAGllpbqpLRLvRCpi6jMjWjb29HjXUE29yq+y6kq?=
 =?us-ascii?Q?4eH4tPxF+hfUNrYLIzz7wpUo0S8te3xr9UQbd9whgDJuRVD1V4gUbmIqrj5E?=
 =?us-ascii?Q?+TkigQrQmV0KdFY4RU68LwmhSXVlcctlXRPYzTbxvGRl4A8Nv2XMk+9Ub28j?=
 =?us-ascii?Q?oaxiRJEJertHeHVnxMKkKmaPa3X7TZBrTYyE1oj1Hy4LJ/rsP9iV4EEIGysq?=
 =?us-ascii?Q?871i3ij0YS2tUZkyS4RXqDO7/8qtoDP4GGTjl2vWb4CGoHwyNqTzUN6d0qEq?=
 =?us-ascii?Q?m8+gsgSl7t95E8l5Rsg2kJzj/n6OZJEWSsqYX+QBgdDHOJaWKEpMGfJqcfDB?=
 =?us-ascii?Q?cD4Dir0F35yrVsLQxygPjUk97VUVjMYa2nRY1purs1xw717/jZcFxtpHroA2?=
 =?us-ascii?Q?JabUm7bdCWaNzz0g1W+b8G5XCo3yx9gdOC7nu3QPAELd624AsCpt1aWbTjBu?=
 =?us-ascii?Q?OHVFaBsOp2ex4ZKO7dMh8SUlS0C1U9NIOi9eMsSEOuM9HbRBg0BkOH3+waVP?=
 =?us-ascii?Q?GLH0+cuTfvq7K97lpAiKqcdPBGVRSwZs9Ra6U/R3/rCfW719ewRYFupJp8C5?=
 =?us-ascii?Q?acZvCN+HJ+FR7YyMJ4KfJNSAAbs+M1/Oqhb4z29GBt/dKeENETstplveoiY8?=
 =?us-ascii?Q?ooelGtXhTBmYVstvPvoQjcOVU2DM4zOuHPZ2+tNiRqOaiAe7Q9ENmOEottBQ?=
 =?us-ascii?Q?M2iqyRcuPcaW6zuqep05vukxoBA/snRWjxcU3rgEH/YdzXPb3XjSJeS6pDyW?=
 =?us-ascii?Q?bnOQEi4IHZieCnwnFizgXmOCRKrtjVJxBA5KBBpMVfx/fJ/mULsjLQVB843d?=
 =?us-ascii?Q?wQH88q4cLr/KdEtcmSSPhUOxx1AXrIybY/nAtZRA45MVnDofCtTOPqeT5ITc?=
 =?us-ascii?Q?w0QSXGLrM8I+7QOsQQVEUYx41KsKP/aQggoP33BHEz9jpWqOMkQC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47126283-6ee0-4e55-9015-08de7400d9a5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:00:13.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HviTtYKbYaIMLNHJ0V5VftgAg74Gx8AxtXpPQC9WUm/mGa0O898xdsP3SZ/VsziOpM2Q4w5Ch2ZCdn1bLHN2Yw==
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
	TAGGED_FROM(0.00)[bounces-260679-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 9F33D18E3D9
X-Rspamd-Action: no action

Use the right helper and save one bitmaps traverse.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index bb0f990fa2c6..6a5875bd9c6b 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4984,10 +4984,8 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
 			  hw->switch_info->recp_list[bit].res_idxs,
 			  ICE_MAX_FV_WORDS);
 
-	bitmap_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
-
 	/* return number of free indexes */
-	return (u16)bitmap_weight(free_idx, ICE_MAX_FV_WORDS);
+	return (u16)bitmap_weighted_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
 }
 
 /**
-- 
2.43.0


