Return-Path: <netdev+bounces-242801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DEEC94FFF
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2452E344620
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E4627FD7D;
	Sun, 30 Nov 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mUC/NDHG"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CC27C84E
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508665; cv=fail; b=uwt3yr+wuQVKIMo9qlCckGNTMkd/X3sc2UnSvYSytpZq5W/WHSdRw2vXD1+qYMiCWtRtEi3i6wC3aoI2GAzDEw3PKY5zcjaD9zx5cl3rkm8jMr+Iz20NVd7aFnenp7CKlYd1g73RO2qJGEGiieaSEZAyDpCgN+2OehKw0F77iuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508665; c=relaxed/simple;
	bh=X3/5Ulyb5EcseMjpLGFCP9TfnUyql3AObJInjpdNLVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KvOSMw6royv2exRQ/iwPu+CZi44DzpbecdvEcY/IVhqmvCivJspfFuJykZX2+UGoOSrwXqGl3NGACMqzIpR2NIkPfCIIiOuDbxb99OMhUY5+w7erEO/YCqdHrHkpA+C+gVhYLuV/LFadoERDRABSv9N+ydadYb5xSp3kI9G8Pbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mUC/NDHG; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyXeFFfyHNhP3Nw4MqGDHzRTEiWNwCP8jrOfaDT6sNIIPcIKsR0csfU1Yeo6HbGZWUVxsllcM4nGbhw1Z/HISgcdjTIFUhzPW7r6qn9oB3uwn2fQod3TGESt/zBnH7vie4hrc0PbRIJq7K06uxpYNfi2YZeiwT5PDkfsv5E99csf0yNCzWbl69OU3gx+wtPxsLD8V6Byny0DldmPjPEidpkBXjUPY9OsYotqJDdCbYBbd72lweNdaGNtfkWSzw+mbQ8h22/om7DXn/lMNmVviEwnALil1tMUyRNPQf2r05gThUgsz07QTsTAtDq+MwG8K9GCg7OU5cSn9v3Pjj0OrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBnDcSKPVKlLpvOpK1FMOIjqo2hHeBXPsXnqBVG8D4g=;
 b=ERmjxfXSDShvQPQlP0aEvBG3Iqre2XiAbzyZnYYKSFQnzuzhR1xsh3/btA8xZi+BfT20OMqUVapfFjVnHCjkZeV9HQCMJBT0Rh7V4o2ws/JvVNyQRCZCe5s/fFNRzkgX2sB8h+XjvBjI3tEEZumshvZKWNISpRKHmf8ovUfvP/0SAqqCu698e9AHQDwgozVN3pYHbNTvKfeJsPaxmIh65QELl1ZVE+HIoF80IAO6poOcAOym67Jog1AUY5pGUuZQmbfEKPNd2nRe9cLffRCZCGQzWDP8Yj6y2HLmGJh53Jj+pa3iV7rM6Yji/P792K81d0JwtQVvIDsFi7zZvk77CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBnDcSKPVKlLpvOpK1FMOIjqo2hHeBXPsXnqBVG8D4g=;
 b=mUC/NDHGny6hOzD/PoMJubv8HdZOmwrdqYFaWfCJuEdDncA7xhBHqATeiuzZzVLxMkm5aIMzuv7o6b0hJaqYa9pqP/Af3nDf/30JFzpYEVpwonvCqTeaNZRMYt9GUSONPijNZ3zKpfAwNvBHy/9JJTSuQVkWjkh0ys/evQnUjvpemx41HQ61q8G7FwUhzA+wGmBkCKMGSZO6rvri1hGphPArNvbiaNVVXSS1dU9h4s1cOUX7pj6rq7OlfPrJ3Y86IbQ6ApoSWA++a/6kRSYvaEoaHcF5UYnNM4OFZix9i56rW0KKIv8gOmqcIoopXV6kbGy5vjQgSg9zoewftjkH9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PR3PR04MB7434.eurprd04.prod.outlook.com (2603:10a6:102:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:41 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 15/15] Documentation: net: dsa: mention simple HSR offload helpers
Date: Sun, 30 Nov 2025 15:16:57 +0200
Message-Id: <20251130131657.65080-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PR3PR04MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 4530574f-4cc1-4a1d-5125-08de3012d6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VxVJZhrz+GDQ1ipB+WYosbDxbDSvSS1dq4tcN0JUSEqH4dlOLhVbZ0A4LSVv?=
 =?us-ascii?Q?1VM6x6rBK2+27CtMfKxMp4h24rLI+DKUbzhfnyYwaxAmoeipuOfC0nnXFfVb?=
 =?us-ascii?Q?+O69UehLtvDEKzTh7M2+flnxDHvcNOCzyqbonA7Q03M6elyALwUwYZpvuou/?=
 =?us-ascii?Q?TLCWouMuKuDhD+MyLpo1uF6D4NRJxZrzQ0fr/CADMP6KFMlxG9LdoCEnppim?=
 =?us-ascii?Q?IfufDtAfUwSpg2UMcFGwS5tQbfl9Wwnix2tP1je6VTDpVgFk/TDK6yH068rE?=
 =?us-ascii?Q?2oX5mRXiVVSIBtkrYaW5qL3z846mQC5WzjVaz7m2ru1enItgfnh1tgHrePkU?=
 =?us-ascii?Q?XVONQyqS2UKRpjyDBG+FBKmCMZJWk80s5ooJ2fcfyxs1YZwrlQeCcNgFX+Hf?=
 =?us-ascii?Q?oUsC0cSLlvkmgKsdLpKE48ox2PmwJAkcp5G7rqIZb00MY9tYwNqb4WPFHrbI?=
 =?us-ascii?Q?MLokdK4mxPNU8bp+2nBLnDScDeok5elxofDyh+tRLQIP1SwkLbT430awtl2f?=
 =?us-ascii?Q?EkIWAtXDhNBzezld1t4LrIG67hydcjXJ74RSjIv8UcXQpUGLb8UQR1Q0mY2c?=
 =?us-ascii?Q?LKg/z7/Z5Vb+JyjNyiU+PAp3D179PxpXU+1X27Is0/ttKJt3ujtZKrkf4bd3?=
 =?us-ascii?Q?VxWV7EVGTlHDfTtRAsidbYVJrsYclxBifNa+OazYDjBIGcmn3KqOzNbIEwPW?=
 =?us-ascii?Q?ANzOyM5HHFC8t2e32QtOsG5L7JkZKeVUsphbS3rfYbTqWXdAQiQjTGilxG4J?=
 =?us-ascii?Q?LAO31O86KSpbC8uEsqpOyfn01sN76epTcy/eHzUzor+c4hpujZm10VIQjLNO?=
 =?us-ascii?Q?08E3Sv4Qvq0cwpbkKawq/PAZ8EHONhcITuffl0eHa7qBn9nHzn2Yka86RjMS?=
 =?us-ascii?Q?2fXucwVnIyKz1CIZDBmQ3Md+a3BPbGE8E/NNHI7rwRxr/uhwZj/aHRZuJEqV?=
 =?us-ascii?Q?6yqpcxQSLjLWJdWctYXumNowNMT/VVdwB7UClnLG9tFu1eS1TlHMU8cZ9U4c?=
 =?us-ascii?Q?NWDrXTrvvf3R/n70mBchSQlOliJM/WC+XyKsl/zGdrpbUVDyqH0svHgiDGtf?=
 =?us-ascii?Q?fkPiLWmSL3ZSQSXyw22WqMkzW4ikRe5V2tWZuDqSTaVt0n32tkwo0biP1ykZ?=
 =?us-ascii?Q?oMi5w6bS2ajaZ9YlptISrfQ1rP8TqTTJI+1p1Zz2u3xsBlNwQRNCG3kU6q8X?=
 =?us-ascii?Q?aWyGqI+kMIlkvNf6207LqrP9Kb0i1/lvwzXvB7Zem/siblFcPTJ+/96D3yY3?=
 =?us-ascii?Q?lx7RDpf2d3FTvyvh45jhEjxwHm7PjRQYh4qco9BztfWf6l1EEp1e2FKJgt/q?=
 =?us-ascii?Q?PdV8F783PJSORmnuN1/MOwMay+Oh8TEcoDuDkRlYlt0kMZpVvOsYeW5sQzlU?=
 =?us-ascii?Q?DDFNIwaNtCIxrpj9dhoFrJMUznyzDF+QnW5KnIYoEuqkxyrAVdGv+ZFp4SJ5?=
 =?us-ascii?Q?AJtxtJDivckNIbvbs2FO+e5CQGb1i71ML6Wdg2o/Qf0+Om+2ILIJ6yuG/wiN?=
 =?us-ascii?Q?cGN9cgmlu1RQAgNps2iNhKUVbBxZ9rD8JXKN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/IkOLRnUrrKGRiscFNoLVc4frCoW8VijojmKYnzIiYij0xi2Q0akv9TSh4Gr?=
 =?us-ascii?Q?1xSdvMQfFra9nSTfcFDRjSOwGBEMpUm4ZsyVSD5/GFxyRNOHEzIg8fk6xDMj?=
 =?us-ascii?Q?6uj4GnISpuCNA/SbYHlkOerAd0iCAqVYlD27b9Hs6LqaN/3yTPw/+R0uGblK?=
 =?us-ascii?Q?VC9G6+R+D3UToI3VwLqPs6LJtq5ApdjHKKo7hwweXP6bPHzvOjiGzbaPg6N9?=
 =?us-ascii?Q?EWuG3rFFOn+t7w6n/JACriWsuBQ8fbXaNDn0XyLCu76LmjENEoq+HeNCbHfH?=
 =?us-ascii?Q?il73X4Hcr89jHgEHE+lvoBj2ujHcNdoCJk0xW1DHKv9YCC7aRDql2i5/fwns?=
 =?us-ascii?Q?kw42bE0MjKkbPElOyD2iN5V+I+77KwHJa37ArPKVMEsY0/0kh5ugLCvv2x8P?=
 =?us-ascii?Q?uQueu+8sYx9XIIImjvBV9KZK1/jwv1SFNoNXGg/sngKc1MbY3M75sG9QH4EX?=
 =?us-ascii?Q?Y7v6eBKJe+htYQ5eAG3nVELi10jhrXmvJX8voWER7U3zhvfqlAKACyjSjgL6?=
 =?us-ascii?Q?uFKDIujmGjXPSWDmIuyM7jrYa9Y446AbTRh4PZgn8LX87dfRuoIGAswbKWzx?=
 =?us-ascii?Q?UkS1ZXET6vUj96Xl+c6VaV5Y3fZmGIUpqdfEPXVz4A3Gc/Rv+DHPHBgHvIoJ?=
 =?us-ascii?Q?xfIQ8XLwZN0RN7919CcdRV+ZQqSQ6j5d6VUgp7tmt3kSSsaL4qNZ8yDqPoYo?=
 =?us-ascii?Q?vke+EGdJ4Yf7MDmGXkcXNFYxSgXZGPhJnVDlnroBrPP2Lsp/vME8PjLcp75t?=
 =?us-ascii?Q?2Hi83e1uXnWR1liN04sgtd4tQyf05cTf8Tw9oLLRpGY9VJ/9U3wHEOqERZCr?=
 =?us-ascii?Q?uB7F8E9jUW5O4GNNAav5g3X6LfTxXvFt5C3Zg00qltpZYY367S2sfYX+lnlS?=
 =?us-ascii?Q?ouv9Q7KT/k3YUy/Pq938kqEDXQtCfGaLAB9VmJCSfIy36wUoFrAdU9+7zR7X?=
 =?us-ascii?Q?gxx/n5fKRZjeXWhRf8t6WSp6V/vGJYfOSC16emgG6zzokyY5JupYU1/oPy/q?=
 =?us-ascii?Q?VwFb2zAyVVFomCjZK+pS29B2XV+RJniLs5sqBVcGSoxddfVg2SADHr6CyvwU?=
 =?us-ascii?Q?jy7qJ1wbZggm6uD5ly1EV9CTQiXI4Xyvwv2Iedgq+Tshzhghz9JgzNmx2/Uc?=
 =?us-ascii?Q?zfKKFeFIbW1KSTBIwch+QFjpJPvUStRvUKntqSdcJHCNa6bkGbn6reCfyIzm?=
 =?us-ascii?Q?hm9vZVhhrXTvuUwYqg8uLKuB3gt7qa9c7eQtlVEbIzZzkRCRy5aDFdt6Hw3O?=
 =?us-ascii?Q?bfczCk8j7hN9ZzS35o4fqAbqyNDF257RXkAsaF7rW8GTZ+jCmBh2IYqRqSTe?=
 =?us-ascii?Q?ICidI3IblyxrZm3YvJmN04KWJFM1rqw12xV3ETOgswfi9vDAxps7ezoIemTC?=
 =?us-ascii?Q?xzUB+sPlSV01+DmjlRBw9D2hhQ4+NWCU/NcWntH8uy4VPo151RSYvnCMUT3x?=
 =?us-ascii?Q?jvPWGq2p70f4LeL7QXgnvEGh0coVqpmyRCwNrQrUjDw/GjwNCFvjVoVECe0p?=
 =?us-ascii?Q?BGpQE94gloT3L8q4x1d2v8EgpddeyLNvorH84E/KZaja5r71n+mb94ib43x8?=
 =?us-ascii?Q?aX2vAO5VQG7vrIfkyoBahe6J/RV/Q1zuq5S23rXDITg87hoVp0pKXntb2vjV?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4530574f-4cc1-4a1d-5125-08de3012d6eb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:40.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZtbRnIBjd42jhpyc+BskCZVZWI1bqCtiS91rAWLdcXA3vDh18QGwotxiafSgWfC4GpAy+VN02bD6p+JXEA28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7434

Keep the documentation up to date.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/networking/dsa/dsa.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 89dc15bcf271..378f089f84b5 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -1119,6 +1119,14 @@ methods must be implemented:
 - ``port_hsr_leave``: function invoked when a given switch port leaves a
   DANP/DANH and returns to normal operation as a standalone port.
 
+Note that the ``NETIF_F_HW_HSR_DUP`` feature relies on transmission towards
+multiple ports, which is generally available whenever the tagging protocol uses
+the ``dsa_xmit_port_mask()`` helper function. If the helper is used, the HSR
+offload feature should also be set. The ``dsa_port_simple_hsr_join()`` and
+``dsa_port_simple_hsr_leave()`` methods can be used as generic implementations
+of ``port_hsr_join`` and ``port_hsr_leave``, if this is the only supported
+offload feature.
+
 TODO
 ====
 
-- 
2.34.1


