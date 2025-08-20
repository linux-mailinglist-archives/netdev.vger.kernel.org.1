Return-Path: <netdev+bounces-215179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13146B2D76B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD9D5E6E6D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872382DC355;
	Wed, 20 Aug 2025 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OjvuN6b/"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013058.outbound.protection.outlook.com [40.107.44.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85D2DC327;
	Wed, 20 Aug 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680291; cv=fail; b=BHHFRoFaQBVJj/cfzNhQoHtDaxo2L6g3WgpM7HHUrpBCmEy23Ne3guEBSVQSHJOMoZIjkXQDKBb0Z+7HusIa+WhIuFic8uNkCT61cCpiGepXmTI4FlGeTOwPVjYW7gdRNxgymyR7chpRJtP7ohRH/jFna55sqPHg017a3GfOztw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680291; c=relaxed/simple;
	bh=oNo5IN42N2b3TDB3n1mIY3ZK4QgKz7ccBp+nhPO9nHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vglx/0wu6p2FwZFHgd/odkjwldmvfbHSkkGhXLcvDOce2lvMwXnyKyYDfn/J10H8DjihyvCcWx/yTUxOUKNRmP6Q4s28kpFKJJBsbkydp0ckHm6tOIGtZrPwHdTLuNuoHhRgcptaSM16NgAWKdMCctGWjeo6SZqr7X/XWbdhCrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OjvuN6b/; arc=fail smtp.client-ip=40.107.44.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hql2wZGaMe9qCqdLmt2IUhxi0sOMNOP7hKzM6PPgi0rI+0WXVeoAJk+LiVs5XSLMw9YnjpC30io/Kg6PN3KuP+B8I6y5wQMi44rJS1Vk9paRQZwkiFtto1bIPYImZcEgn1BUx8K2sdDcdgCl2G6jaTLkN84x/KOjqGj7hgDZdEl9U8PBWSNXjCFE65558hePuFF/3panfbqd7qB8zGQLGtYcK44hpUERyGA+xj+qvwg+CAQnvdWt1jTcNc6biywGEZQR6IGlXi0mV+3Fsz+D5F0NJ+6b+z6CZHzp9GpisH/B/dE2QBn4QykLCdZ/zujlU91wa0RoEBFTiZbh1czQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HpDExpdrHtNHippJS0aqqJYZBwj09KsbAWuS2g/RC8=;
 b=ZUUV4vR8BkN6p9FzsqR0KAlOGWXEmoOtghx7JAx9xhRWkH9q5j6UMNZtoFCgHc1pj9pzHKga3aHjjjMvKRmBYZ4CBcMfAUa+N/AQxtE62Viw0qlj7I66GoluAt62z5UlmOqkqXd49+tsrFInrlzsrtAXYIgGB+aVYFf/DUgMkMqc/cT5wwn/SDyEpww2QbpnKD1c3PSLKDLh4/hzQqem+RYzz1kcwlEQww2KaINtGYpgaTS6+845KWnyPld16Re4zLyFx3MuwxMwWP8fi9qMi1PKfHYbSqceqJCBkEk9qaQN+rPfbNx+9w6h+vbVKchPVArdwTve5+1NQQL1NTwlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HpDExpdrHtNHippJS0aqqJYZBwj09KsbAWuS2g/RC8=;
 b=OjvuN6b/FsKX92uHDkxzKysdGWhcprYMGnmHS5O7Km57Zv9r5jDD/JhF1xxJU4T/YBznptN0vNS50kxn2DvGwzduMAy+2yfmu1WxHVKzWi7w3O7rRE0eJHxf3P9LW+InKW9/8IAObu0luBD6hjhkfLumGLx2Df7YagxZ0dKwxlPyc6bcoYujG7ry+LTNGHPqdksQgee56ks1IhtT19zrrptOdAexNfWLjEU+08lU3tzls5VMIJ/1aMG0G3/sGv3TcQYfGSlqxdKFc06ZS/voEo4D5CWIVLqcsKMymSVfwimoEQ4MQbxgtckh6UeGf4Cs9WRmZKYD3d1vpn6DC3W+IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB5664.apcprd06.prod.outlook.com (2603:1096:400:284::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:58:03 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 08:58:03 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:LANTIQ / INTEL Ethernet drivers),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH 2/2] net: dsa: Remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 16:57:49 +0800
Message-Id: <20250820085749.397586-3-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820085749.397586-1-zhao.xichao@vivo.com>
References: <20250820085749.397586-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9b1f07-2150-4469-d5c7-08dddfc7aba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7tNILvXAYccnhHQ0wtkBh8TwIpCwEjqQJ/ynnoxFoVA3P3z5afYZnUj9eOWU?=
 =?us-ascii?Q?k9GChu9sjIsrhOKcm8XYS7YTIdAxIkTW/FWFm7IwuWE08eiStOxa7d66CXH6?=
 =?us-ascii?Q?cqqGP6Nk/MGMEDdTq7GvYukSa73ak78wMazx0TEGCOx+SN9uq9TQiNDQJSc4?=
 =?us-ascii?Q?DlDajvfBXYqB4lZG4LSBLKNoulQlxf4H8dnWf++5ZJf9wJXzGg744GmFKZIy?=
 =?us-ascii?Q?XpVTF6md3herydvb6KiTJ2FQibfYhbR34JDFPXunyeY5PcsIcRMjqHTPyMPU?=
 =?us-ascii?Q?rEo5yNG9iO6KZcsVeBU4y/q8NItSgzi/3wK1VmQB8HKLO4Jrwv/VXU/nX0ba?=
 =?us-ascii?Q?ZdIs/6if2ljgUljp8GQ7nLDjxMamT6jfdWcb71RcXQbdJT71PueXOivCV8rS?=
 =?us-ascii?Q?CRSaiETCd22i+kcPPimlHKjd4Btsd3hm8fFE83BA4NmsJGD7//pixj/8TcH/?=
 =?us-ascii?Q?AgPB0TaIXtcbpceT2pWgvpuSumGeWe4w24QMB7PMEMt9KKZQLSU5VwwsHdc9?=
 =?us-ascii?Q?b8tLp3oycKIOhiom71W5t9EupJrJjDp0tlYR9COYmeCzcRGqw4oic9UZ+Fqi?=
 =?us-ascii?Q?XxEhraZC/rnKQCrlNXfiqGJ1yOE2T+lmyy9dcubZFU+BjXxABpvj4qFnpWjO?=
 =?us-ascii?Q?ODajXMxt2qA5I8Mkk9zIIG+3sOi7WImHYfN7a06OtDewZ6WKUkV9uDT1N4oF?=
 =?us-ascii?Q?wIjamXANTBCYbo6NX4XvKaJuM60MC8LTJCxE5UyUwm0ox3BL/yKvLaqc6Knl?=
 =?us-ascii?Q?ocO8tbMt4G6RuLMqWwOrPXGIT62dW6o/PHCf1itFrdKgTzg0j1LK2nAqcS7y?=
 =?us-ascii?Q?QoaLij5Ka8grLZZM88BL2ZKKdb6e/cgu0bTtzJG63Cj5sY3oewEH2CJj5+yo?=
 =?us-ascii?Q?OggZViUNGi9VpA3mlOEYhVxi0V6CYGysKsvIN8GDw3ghac+MTVaZ/7u9Czcc?=
 =?us-ascii?Q?WFBOda4U+KLsSD5sER+Ib/1Gt67UH7i2mvdZebTJyVyclkDZXzDlZEG3pVe1?=
 =?us-ascii?Q?vRxPh/pbrLNTZy9G6k4gpy/TFohRcQdA0Sv+mQPrz+K7TgqM3L1QTSbInZhG?=
 =?us-ascii?Q?qWpd/tJ+g+Z0b00+CJ3N0UogTFRIzQCXCfJkewIqGYDbGTSTKVL+9PhbAel2?=
 =?us-ascii?Q?oGtixfOwyEApWOrXCsTTLq/OiWjfOi5cSTl/ij8VfJq+8kIGTp8XBuee/Qou?=
 =?us-ascii?Q?KTQPuPPnD7BC8p/q1v6fonFF0NcT1/0OS2iYbYUiVQbGWWSNk6vVPopGm0kG?=
 =?us-ascii?Q?0WcJvjZpM9ZrGaHYIDpWNzP4nbfE2esC3Ci0qWzREsoXYWJZbIgFx1Neidhy?=
 =?us-ascii?Q?TxK65EUx6ot5TaObjlB6nPaJiu5PjFmOvkLFavoKG0CAvXRN0h+OVK7HMUN0?=
 =?us-ascii?Q?12vLVqtivoVvxGHr3ilEDAur/ZtJoab59vtQ/iePEy+/DjTTtXhhpZDqHTu5?=
 =?us-ascii?Q?J6Yc3GuA0bdgUuSA/KHow4x8K8hqyhlnBLX4i+13cXXXoiS0EsVXww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Tka94ohCdZjiQg+CJz7YJMwGIrmKkQ+upw9TEUnFX4Q38JoZ18FBuEa963k?=
 =?us-ascii?Q?tYOVRe0dGQGAhN7Q2G5l+LT0MyivHNasEyVtj2NK7bL/z0kyGJBwAFElBpE7?=
 =?us-ascii?Q?+WEQo9riqs7Eh7Lb3d2zI5M73DBZCa/U0sgru95ZVkOP0miH0pE94cKu9M5T?=
 =?us-ascii?Q?OxP8hbTEybKs3UEY+P97i0QFBz+57/0325yFyGjYsQocDZv95mvIkY45JVLi?=
 =?us-ascii?Q?Q9JuNg/R6nn9QODqkDpdnVwAceMGRoK8Y9KM/UVBAtJWm9IHuVu0BY+JwjB1?=
 =?us-ascii?Q?qk4EHHVoNDDjoFk37gK910YdCnDXsCx0MczQvtjPx0afmCPN60kFPUzj+aoi?=
 =?us-ascii?Q?9zcgINT7cypuU+kBO3Zb+HoO/i66E6vhY71g54DSh2SLygvsKPLWpEWlLhRD?=
 =?us-ascii?Q?GQ6VGBxcJqGlct0moMSwApmEfP2L9oY1/XdtpAD1750zmOUhxcz077iFBC8X?=
 =?us-ascii?Q?XFx4J+VbeQxaL9LriQHJ1yAJlfEhytHXo7vbuNnJKB+PQO9OGpZjoqnIaJVr?=
 =?us-ascii?Q?PPCgEcLz/ZuCBUx3S+033WLsa3OBQuTjAhoPod/DV9GlKcLJT6CIK1iPGy/+?=
 =?us-ascii?Q?xbrksMVa9V2jmtF2AfU/KR0x34SWi7r4PQ4IgUV/Oorng3d8HcJ93oIu83WW?=
 =?us-ascii?Q?ksJQOHnSbT5yFkDAOhZmli+SON9LKB7cJNDcKqDk9GzCY8OeOD9UpwdxA3on?=
 =?us-ascii?Q?tGfDpRupazmVUwmQWHHf58PugntaMkWaRsJRBLyWq4S81lAmuMaIgLd0VxHq?=
 =?us-ascii?Q?Z7e9KfG7nVe3/sQ5gdE1cKJbuII53a8bCWnObb5jPTt0u1/uzeJHbUYORq8z?=
 =?us-ascii?Q?LLkcVs8J7TNi7S/h/q6B04trzgUD1zMQCIxQsZhSSOcu9Uh7AxIis2WdW3bA?=
 =?us-ascii?Q?RobD0Cyi4EAf3ULvXLFdCXvziJCkB1dvXe6g70Ey4J9+sE136AbeHjLoWWLZ?=
 =?us-ascii?Q?bQqgZS9PKKJJFrAzoirAKT+0EYfv2uL/r9eSu5lFmZynD6M47L2Ptlqk5Snw?=
 =?us-ascii?Q?UFL4bqzt2gO2EWDY+MZCpvRKT+/zKNnvpUII15maVVCq8fh2PB8rzefqfG3k?=
 =?us-ascii?Q?0PvlrXC3UoJxHbdCZE4vk6LyMDFiV7bG/IM9RJECczNom+b6CgS2+CWjLjm/?=
 =?us-ascii?Q?+OKq4CViQVqo9Na2EOLoNeWm3pzJkurmCZRkNopwGX/H2sHvpjzO5zqFlHDb?=
 =?us-ascii?Q?ySAwVBe1V1o58ftWdcG1ftsk9hr4h0CydNzQBxMJEtSvtRbsOp57INz4ZXn8?=
 =?us-ascii?Q?jLGBU4grNMwl8OWk8RTg9/ByVZGyRoE9Nk0hL+9oGbivy6jinkuncmm86/aA?=
 =?us-ascii?Q?72ymQ3tuyO4K3dQiqUl5uIghqnZQSPTElFSbTMn9OmsOfH65P8/XbOBs2TqS?=
 =?us-ascii?Q?+4wBqRu1lrWmWgpvoXrz8iB0eLWPnim6gNw8kht7AK3Hstv01tTU+SXQNhXJ?=
 =?us-ascii?Q?o2pODmM0uyWznAoywpcNKyO8NtJ8k4XzXs+G2Y+a7a61IlR6W7oilGkA7MUa?=
 =?us-ascii?Q?oxIgGKTz7ahLGmWF0VkpgYQqP+5qKljubFDqGx8qNz540bA6MAGS9c4XnpKn?=
 =?us-ascii?Q?WYpHJvZEWozES4OB+S7yg0Pq5O6VgqLNxlqjif2B?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9b1f07-2150-4469-d5c7-08dddfc7aba2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:58:02.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJjpFwaYAlcCrTcc1Jp0UrjGaUxtZtwQ7CxoySAFUpDfZfNRTp45K8zZDHUpI/tJauNaNhYWR05yPl//IF3qiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5664

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/net/dsa/lantiq_gswip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6eb3140d4044..ba080b71944c 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1935,8 +1935,7 @@ static int gswip_gphy_fw_load(struct gswip_priv *priv, struct gswip_gphy_fw *gph
 		memcpy(fw_addr, fw->data, fw->size);
 	} else {
 		release_firmware(fw);
-		return dev_err_probe(dev, -ENOMEM,
-				     "failed to alloc firmware memory\n");
+		return -ENOMEM;
 	}
 
 	release_firmware(fw);
-- 
2.34.1


