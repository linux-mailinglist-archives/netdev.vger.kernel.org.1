Return-Path: <netdev+bounces-131997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF839901BA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A1E1C21366
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D114B955;
	Fri,  4 Oct 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ULmuO+Ql"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654413B2AF;
	Fri,  4 Oct 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039634; cv=fail; b=eJxZDlDjGGPHROTTu3yqjmxiPabulEUY7SzA1ImrMrsGfKxkBp67ndWUHisM5gBG2gNIp5cYA14mTGADsIJ9dql7eZEPaueXPGdLzOakm6AEPXq/n8ywwNp78asOLwzT8Sbdc1VyDC9Sfux3jJdotabIl/K3pdxRPjl0MyPxNQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039634; c=relaxed/simple;
	bh=bcz6e4V/4O+1veesKVu2OFP0wXAvPbTmQwfFaV5BVZc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l4Wnktp2D8xWv7Esrj8wDDWcC316vBqz0nPcRPjKJjtk573Y004EgI1etpj1ogyLhXtrhEAHvrS08r87hmTmi6l7azpKkGlOIuoEmoahPoARUVhxzjRlVXLodGtDqLZ6sPWJqsjokB7oH6jyUOql2m3AByVLv6Vy4GC/92ZUzZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ULmuO+Ql; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkgAtoxkjKWNUB9xc9xPNtAhg2Cv4VW2N8HFj8TpXMUk8YrmQqdKga8OH2N6SJCEs+yjG+ab5rb2VXU8hOkhioMNiIozKeRSHVonlSd2D2TwfrzT5UckAVfFkYziMpA87hHLevU0rJ+QFGpAdEVBKJKqWkHcmxbGNFpuM0J0gZYb70QZ8kfVSMb0jpq7yLLG+kgzt6wbkvZEuq4JksBKBevqwKjaM5LZUYFg35rslU88V/czM+odJwQ7/j29JT6hDKVQVvj5LYlCwvRNEk983CCYWs1NvaqqcVEIAwAojpcjw1NGgRjDsgJ/ABjY1+VIQ7waSslaXF6gLD2zpSt9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mwpp2DU/IIooPu3Uxqw3x7POYzqp8Nj7tryJYolS9ds=;
 b=YOqvIQ20YVYNwafgZn2twCvqTWdOb/nNFycnt36+grBOiMA/Bsj4pe+5UFLJyxQEIaH1f8lhvh3ZPg4p+WXjh8W81TRzp5FCgbhJKtEE7jh7Gu0EPLuyNkyVscBqaXlwsnbI8zXsyVnaCDYheBxbrmlzIvScA0azBFwo63d385wjV9kLxtLyzH2aWlP50QEP96FS4Y3lIxtTBWnNJ62JXWg/CK9PBRQ5zFkkeNFiv3nAOiNZ3NuyoCav6Hp1zVEn8bMKff8bWSkbx84JF8SiWLCjvPa6umr+20GQqjJWNBeg58Br+/b1DAyfW+T7Zke4BKq8b1o276dC2IDXXaAviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwpp2DU/IIooPu3Uxqw3x7POYzqp8Nj7tryJYolS9ds=;
 b=ULmuO+Ql4vPp824ZVEPoS6o1tym/eacmYo95XfLBzmCDG2dOZJ3160n0QGYZ+C+xVhvI6zKqcau6zHFU4CqYciTu9k4yrve0svPvA1VdzEDemMWU3aZkf90SHdnWhFXzarm9BlNU0f9prbzY7SSRTQj+B4rFbFVO1rMSl4+CFhpaZYgYJlIqNRH0qIqqnUDF6FHyVW4M9CKQ9WiCBafdWFqoUC9ebNUPrJ2TozaKZycYZqmJ4XZc1gU5yL2HZrTX2edSF3qDkQV4eRQjVkBEe41TAdrU+werelLWG8T1U0DL86pIIU5rX2Te+yxAqqLFQnZ96Df7gcsC3fgSN0Xnrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10372.eurprd04.prod.outlook.com (2603:10a6:800:233::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 11:00:29 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Fri, 4 Oct 2024
 11:00:29 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] lib: packing: catch kunit_kzalloc() failure in the pack() test
Date: Fri,  4 Oct 2024 14:00:12 +0300
Message-ID: <20241004110012.1323427-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0136.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10372:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9764d2-d9fc-459d-45d2-08dce463c27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q42r3WVZwrxWxEdLhYQsJwJVPYEzFyWut8MaDAkcnMw4nZfcMzC9zSxnVL94?=
 =?us-ascii?Q?N7mpllTSdQORhYi/yIE8pmzkqkvSPdUsHQq2TCM4evgKnC4oioOEvgQgrVEz?=
 =?us-ascii?Q?NIOPl6bl54iYMdpFeCLk+emWgiwAM+gD7wWMEgNz0ewkjGJlkfqI7pKHGRao?=
 =?us-ascii?Q?Eq4YvY4HLNY1pBGcOKcBWBkFFDK+BJ/ul0JCcOL+UVstmr0VAtQZyLKAdZh2?=
 =?us-ascii?Q?0rqzn39trPhNGqInvSqt81rq/sb5SeUAHCha7ZhNtfsWSAWACX1RrRjvo25n?=
 =?us-ascii?Q?z2CYG5hm7xsKl8Ced5B299gB0pkyzYi8lQvGGaXw3pcxmvQZk4beCW5sIIYz?=
 =?us-ascii?Q?DK5e030noTTkirtCH6k+rL7hbW42z8Jdfaur0/CjxyxyjPeYQf5skJV5j3wA?=
 =?us-ascii?Q?5mKKut6Optxyo6tgNiKjsjHGXXXuyYtqylZKgGGv4r0NWfxbKPbHgwHN1deb?=
 =?us-ascii?Q?bikgbWQe4/rjidMOSxROv2C8pJw76a5TWvGH90FNBt3d5aC5pcIDLNL3KH57?=
 =?us-ascii?Q?vlGnJ1PKFSx9kR5Z6ZaU1bU+xeLIpDACTGtIZ9zKpnLrNb4Pl0OT7B0wVTbW?=
 =?us-ascii?Q?Qv4Td9FJyu8n5A+OrscNuU6W8y2XgC/G1/2sb2IRgyLP283gZcoTVDXE2WgV?=
 =?us-ascii?Q?DyOViwDDX2586QVZwRCcZD7izmH8G4If+oEwDh+ND96HbpOSPHUBd40R8CiM?=
 =?us-ascii?Q?oXAfG0+uFClkIAaxEbE8p4F5iWbqvsDAvqr5cqtClfQDdWw0TOmZtGxU/nql?=
 =?us-ascii?Q?NkMblFS0E2iIEfcoFSyoPMJx5Mwo9WXhu8yQ9zKJjKOrHppVEpwBQjZyk1CW?=
 =?us-ascii?Q?3vR8ku2kZWv3o4FAj41ieXJE1oSJDyy7v0fB2bpNSBL36MtxfvUedyQinWzw?=
 =?us-ascii?Q?SMsyyh5EXxDRTcnqaJu+x403oUBuZNhBHJqQAj3TKy51uu4pl5JyGdjpFuo9?=
 =?us-ascii?Q?KuS7Vud3q9Yv4p01zHynixHmvdNNvLBdV1q2SWak86Bdn4zjmfUQmqAA3XJ2?=
 =?us-ascii?Q?1Yjq8NAlvbSaDC/Pb/AW68cDXCm/yp2czUvh9HuE5hG2YtegWAzKPYjmIiBQ?=
 =?us-ascii?Q?zepMUoJyrFh9bjMPQUgGDwCStF55ww1YzsvUihHjlrZ9CiE8e2BT7eEvfEoH?=
 =?us-ascii?Q?7RuunelXKYwSosQeAzYoG6i9xumIazfmUbsF7EW52W3WPzm8HRcnCWJ/dG/d?=
 =?us-ascii?Q?Tz8wBBncptRH51JjgKXefUNRbQvJ4YaYG7dUs48oU3Hgb9HzER2JrOXTi9FR?=
 =?us-ascii?Q?kxFzzYYAyXxZJW4ibKNkXdQPQ79clUE/nKmVGQfPR8YrYkKLXSDFf5OfAZi4?=
 =?us-ascii?Q?ZTkdRYT3Z3J906MOg0EWVKQy+2xPuykqMxFgdcynN+YVoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nqJ5Ru+SJyXXAibnX4pw6G+SzYbVbMR5DEZaJFRDtHlBtArE3TFmjs9PQfF+?=
 =?us-ascii?Q?jqeZNfeHaI1p5AoPq76ySHqXsJ3wTicwX1lmmXxtEeti/sREAxAPV3Cr/UTF?=
 =?us-ascii?Q?RG4NmSKKxJNkc9VR/cSHOeJDe4W4GVam8621gkefIn5D4/v/KoGtb2OC5zz7?=
 =?us-ascii?Q?xO0w+CDg+4thmXLH0ATKVJkPIR+Y1IIpZe3eLdDzwXWp441cpbLxRNL2rhRd?=
 =?us-ascii?Q?v3vMtYQMg7FkIfry58ecpiLtr1P5LP//rQlyL4DCxBaTQZEoYeC9a/rUInY1?=
 =?us-ascii?Q?rM1r2OFvDXV+3/kPsRCM5df4S/OOAaeEuQigrelXNxdKNrPcbZcFEUfsX4Zy?=
 =?us-ascii?Q?4A+T1deMnKugwgXRKWgq+2yGt6ECrIy8kPWTj84nqcGKTjbIoRKdKkemxHBq?=
 =?us-ascii?Q?+tsSeVswK10oWJTG8vE86Py5G6vqIb5a+pDEB+YctskM/4lv4Ph6f7UesIv3?=
 =?us-ascii?Q?D5LCsqjrrhPhm9egt0SKRAk9u1uqtBKd6NbWEU5vThqbKIL3mwcFZwIT19lB?=
 =?us-ascii?Q?6sd0Ttik2fK2fnLd4FoGMoTRdPga0T2h3OMzetF9D7g65dAE41a4kWO+s5Y2?=
 =?us-ascii?Q?6ImyTN5o+DJXS48iAUGWIeQwJuWztQYrpUJaJyxW/ncRvPFna2iL8GLf76oY?=
 =?us-ascii?Q?hojxNIS4URLjCxBQr/vHYta2acQfyGWVuJ+KVs7wjxumBgfIEYcOm3ij6iw8?=
 =?us-ascii?Q?xNfFKYrmBOnqanmFA6CCBdedD8ugaDGO/xnW4SLyHAhdmT5V3hKS/R11lOVZ?=
 =?us-ascii?Q?pPtO20DaZnwQg5yj/AH+hrzCNv8KcJLjGHAfNFZBf+n15T3/yQoEl+ptYUwY?=
 =?us-ascii?Q?K6bys00h5dTfywsf4j0j6nWNPxJdy2qZ3hm8fKkxcN67PF0chmItpsPaQHs9?=
 =?us-ascii?Q?VZvndUJ3+F8ZR0xMFdIwgYmNFXvr2R5lO19F6W0aO3qqrSUyoXVPc9ArPJT+?=
 =?us-ascii?Q?5bRt//kpcrDQFruJwpu7mW8IHKSL10Tvkp9HOIy/tMeo3xY9ef+XnF9GnAbk?=
 =?us-ascii?Q?O5KvQM+igNKrmco+sTd8zGLtBXXeye5Yyw/y9AaKufPJ9aXVaVjWsEKrek8n?=
 =?us-ascii?Q?Tkn+JL/Oc9rIpBLfJeS5S71U8/Es5V/+CXtvnuxd3wy93/sxIJR0dmsTYhua?=
 =?us-ascii?Q?+WoQEIXuJHHixbtONwzEkdtZj+PxloYvBWeXPlEytCVdsYNcuxZf3ZtXTxp4?=
 =?us-ascii?Q?3z1ovar6MaSBC+QEII/mg+wGx3/TOThjxMC/v8HueiPI+ogbcI4TAFB006bT?=
 =?us-ascii?Q?0R7OyxVFe8EnpQzQ2ZJNPlP0IwRkM9xz8ffURgL++TgIFnpN4Ep/bJJUw3+t?=
 =?us-ascii?Q?5K8dTlkSTIIRqzkOBGpDln14iTise3k0duxylab5e5vAQ4dNvIrM0ME31u30?=
 =?us-ascii?Q?7NVhvd5Srih1uwHatsOQ/E2Tif/pjFjmg6mWBE1caIKqZv7dKmBRVKLPS0+O?=
 =?us-ascii?Q?f8XpXt7kKfrZcqhJFWjWs3GDUGwnlrILbAg+CI/Z/VRMCfTTByZfXjLalZHK?=
 =?us-ascii?Q?9udjorVaMoZKTUxm2T0FKbhFhxg8anu2LpCxI/QYh/j3pa6cY/LUInn+c5o1?=
 =?us-ascii?Q?UhOnQMiUoN2v81dsjh605n+zKTDjBYcewRWDYx51EQUWQzeQuZYMrO8XzESA?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9764d2-d9fc-459d-45d2-08dce463c27d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 11:00:29.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVUVsDSqr9ZmC2LkHeuftpgeQayke7oKT6GimPhFEZCLQtDyQYJ3M6Y54RpmljJYLwZy5iny9gniGGDwJa/kyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10372

kunit_kzalloc() may fail. Other call sites verify that this is the case,
either using a direct comparison with the NULL pointer, or the
KUNIT_ASSERT_NOT_NULL() or KUNIT_ASSERT_NOT_ERR_OR_NULL().

Pick KUNIT_ASSERT_NOT_NULL() as the error handling method that made most
sense to me. It's an unlikely thing to happen, but at least we call
__kunit_abort() instead of dereferencing this NULL pointer.

Fixes: e9502ea6db8a ("lib: packing: add KUnit tests adapted from selftests")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 lib/packing_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/packing_test.c b/lib/packing_test.c
index 015ad1180d23..b38ea43c03fd 100644
--- a/lib/packing_test.c
+++ b/lib/packing_test.c
@@ -375,6 +375,7 @@ static void packing_test_pack(struct kunit *test)
 	int err;
 
 	pbuf = kunit_kzalloc(test, params->pbuf_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pbuf);
 
 	err = pack(pbuf, params->uval, params->start_bit, params->end_bit,
 		   params->pbuf_size, params->quirks);
-- 
2.43.0


