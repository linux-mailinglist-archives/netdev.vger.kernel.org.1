Return-Path: <netdev+bounces-285642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KOaHkyA/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:18:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1A4F260E
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC5E302D09D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDDE35AC10;
	Fri,  8 May 2026 05:37:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80733A9C1;
	Fri,  8 May 2026 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218635; cv=fail; b=VrWof5CooC5AgR1KigNReMp/xQZawnK4NjgEclQxkM7cA1w5KLvCrfb8WQth+d7Ob8kqvmjxCgvyquGcttlTjFszUaD5engEMmZBk6wmJs1yQ4TQtc4sS9LgFcuBuFMORRkogFPAKJNOUy/ktzipQHLtHiTBLNcADRMNN+VQ2mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218635; c=relaxed/simple;
	bh=8kb9A18eVeU9BIMlAS09m+j6+D9IbFvJi+G6dom7p/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVvYhcJlprhaXw+fMzMl6SDW+s+M567two7Qs3DsNr83k+zHjV9LwWm5g7sIHaLmwJRgeceh/4R5evXiVGwTLc7jfNc7d1PS811+66MmOS9GR/Jo2KFbSvIjWbwcUPIfBUr6beReAN4SsK/VnUqXOtFVZwInt2Fo55Zd2/N6DLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H19kePfHX/7vJw7WoDHAH6JdONKe13tGS2/b0+7GlFcwRp7P+cAMuTgHZHr7jkToluKWwIht6ePbWV4iTBOCKewCoN7K+ZXaG2ubuvZtEjVC9J1lJy0lwbOEWquvcAIK+UHQDwDFQosZ/eiqyJNEYoS6zlLWjuYZeZ8CtimePS/veb2R8glvjmA77Kii58zukBomsTt1WnOJdK95c7/4h2HiOl8FNPeTQPF4eahwO4ALKQN1lJ916OJKZ3ftd5uI5txLkdNlcT6+G9DyunltBBcrhf8ZfKNTaKvRrMiTOC4XKUcSxeQADIPYGmNHrXa+79kTk90um/nyaBDVoAq+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwI5pL2oFR1vNqG+G5abCqWUhOQYnZP8zdL331PSWms=;
 b=UoqOqG+D1iJQS7DvzW50Kg82NPq193MSPV+u63nadDXpjm0juX0mRXP2e0SOi9Z2C/mSD9RAmEpuXf7WWM5nR2tcq9fiNDkLjuHI+g4/kynCEeTY0QE3WXwm6WMJgpACF+UacuGmcjtOxbOwjhs0Qv4blkHLO9TAHyhxBE4CiGnfnPluP2e9+n3ANNd0tLfDI/JyyRibD0sRfivmyqaOh3Vp3fVhbqIlY3AClXEEWjlYYv0w+UC5DBMgl48zErm2A2xYnKHRvS3soiQDT7MrfFQZiI3Vrvxw8xcOZe0bESEnnfFmvvfDYdsB9qACgK/cNxVeIQZOP2sdjI2+rn1R5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1236.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 05:36:44 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:36:44 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 02/22] reset: starfive: Convert the word "jh71x0" to "starfive"
Date: Thu,  7 May 2026 22:36:12 -0700
Message-Id: <20260508053632.818548-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
References: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::12) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1236:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2b7024-2343-426a-d506-08deacc3ca09
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	guJsVaTqcgmMpTwO4y2wWU0ykuzcpa5Inhlf9fmFmYq7mt+VOTqhM9TjhHRCmt+7gIQbqlRFZSoUwhvtT0lQ0vZfLabqcHQxQ62SK2CL3MgPZ1XqWSr5+giVOguuL7sVoWuAU2p2zpiAK8+MTw1v0uN85mN/qIMwcMATWXtIykZYEtXhGWjw6Q2+XGRzJL7rCyzHWVcpaexeGe9weudzSYGxg5w/60qeVR3NLF4D+/H1GdFPymaTAYVJ159uLtvUYRk9QNgp4s1H5dU8GuyJrZjLcSBY5yY2bDYmlPrxojl9Atp25nuT2A+v/9t4w6HyG5Crv1/eJFIT2BjMX5KB91r/yOJLF/DWmxcNl+tf8DgFRnqEBkDmZ5hgkCbRHa8P6q//iTayLHNLSf8cAiaAnlz66o93knl7au+lyUyQF+L0hqcS/tbtnYmN/Lamy9Phiz3qKNG3VtQ8MB7OzPEsKM2npug/IWTumSf3dtLoFeHX9Ueg0f9MJJo7UTaDATn36NqBK6aw7y+Arekp5stLEHV+4pH0BYqG3R0P+hm0yX2OzgUX+Wqf2xu0KKspZ77CAMWwAKtMTCh/whEV5Jegxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXtWIj3UhfFU4PlkeM3UutGQDg5QMJ+9/L5xI0/rauKbK0b0h4fWiYEcj40T?=
 =?us-ascii?Q?b5O80aBZeZc1UgbJM6Z3W7mWkuq2MFrRucRfg2mHzedvGygeqZsxKOwKhvth?=
 =?us-ascii?Q?fEZywXCaTCycdtNrPPXWX5cZ2vSe8M86r1A+0TR/p1mPCmf5mrke/FHn9RxI?=
 =?us-ascii?Q?GrQ+1qz6ybCio30+aFLhDKh8foSrSnE5HIGlGLAYqPmUwDpiOozRporzoQ2u?=
 =?us-ascii?Q?cae/oVfy/P0A8Igdsf3ob+nfRY64qtXQHd6y49mKdz2+PObcP4ks9AlnIKfU?=
 =?us-ascii?Q?EXd0/zTTUY6Efw0Wt0BZBw/5AVhRXtAGDt9Hr2qH43F05CQMQUcCouRoFk+w?=
 =?us-ascii?Q?rl2t73mh/m9wC+Rsu7E+M6ufXG+b6IIN7zTIBms98d4dg8OHDo+dZi4vjMS+?=
 =?us-ascii?Q?uW9h2hK9sRnrfcjuWyaVqQ6SKpFZBBaCKqcxe0tnNeDTqncavBxl0Oj0dP2S?=
 =?us-ascii?Q?R+sfoiTMRg/AZFUxyjIwlKx8WgcHfh5VEB+SY46REERKr2PkvN5TkvVkZ1kg?=
 =?us-ascii?Q?gv1ewOvDfyUDzVGsc2oJqoot45N/M5HIC5Syu25WQoyEdQUU/A0tucsmSNCn?=
 =?us-ascii?Q?++kWk0db8zi6HhmTt3c8jGoxBS7B6qneG9ryfb1Ea0MpbZaQEnSXW3lViH5n?=
 =?us-ascii?Q?3pcOlOhSx5Ayy1fMQF5yBU7BeA9BQ2DU+tUwEyzwAG10Kzc7CvZsymvtE1rT?=
 =?us-ascii?Q?0ApJkGV745Vdun/V2p/nNosgggl7hKajdRixLva0svXQEhriabo3FYOqIzwB?=
 =?us-ascii?Q?KKE8/H7xdtPtogEH2byLqoB3L6PtoY17CShdtlTqKja1be/g3W2fTtKCClQv?=
 =?us-ascii?Q?uslqqoCIuOmKc2b1k2yAsU3QIxQtVOATfaucPxoWYusBnmoBb/wGhNpfH4fW?=
 =?us-ascii?Q?NrgPjq5o4DybtcbAi3jDQ8L86e5De9o6gdtWsc/vphnyLuUv4a0GGE7TRXRf?=
 =?us-ascii?Q?/FPD5QjboH0HzCi++slUB26CGO+YilY9qQN4nt2auhLbIy0l1ZTKot+Tjhx1?=
 =?us-ascii?Q?6OBgT3eu8JI0/5aM5EaLUVEWc+v+meWYjcIHHX1t3EPn3UW7Gpc0OyfBO96m?=
 =?us-ascii?Q?y94A1XVoYBoDtt1OUmroItPrtE/gOCKuSE8O03nSbJUM6KFJLpSyQUIJ3Xc9?=
 =?us-ascii?Q?qLgwEEs3aPIjghZ6cXtWTHD1rHfFoKjzX1Ugb641PdriDZm+941rM2W1E2Vy?=
 =?us-ascii?Q?ilZ7b3FRYo400A7w84/NEau0K0V0boJwqLypYgS5QL+Cdjv2w2Qydbcnqr6u?=
 =?us-ascii?Q?3rSpyNib6bKn6dTG4+vpZSqd7cYHHIFB9MF4YGmJr8iqF3gQNiN+OdIQIQwn?=
 =?us-ascii?Q?TDijAZb0lkgKa9oUPe+mI5Y+DZak2EoVOWygZceGOrQ7Oa8WI2cgiw+nGU/5?=
 =?us-ascii?Q?BJL+eCBjaYKdcVxvMyDq0ZbXGfUq6qaYEmimHmtgQauGL0QAbrr8pP8j1mMk?=
 =?us-ascii?Q?SDq0b9/9524ITweaNrhdVH9H5GkDKS1nrmsMJIWcav2o0rFfnfsxaH8x4Oft?=
 =?us-ascii?Q?O/KZgKrPxGjrJzGMZGsr3UvHTYMiZQdL5a6DsnA2gCmultq4R6+lssfzlplW?=
 =?us-ascii?Q?8i2Qy6ETWVVI9d7l7RZuKGsyIFH+5OalcekO3KRHa/EhW+m1holCNeBP3C8u?=
 =?us-ascii?Q?/1bXHry60XPCyjVPaVaTthYXYCxP4VkGGE7s6NvUzeWJVWO/NKcxFhz4MiJz?=
 =?us-ascii?Q?KungyUGITQBLbs0ROdGB42DoRm0XZGOHvAC33fiOnuZTX78npwLJkDrabe+w?=
 =?us-ascii?Q?8f1B4HIccQKneYzFwTl0rBtBRY7bycwlmjPZmiMwssUDwGDSreHk?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2b7024-2343-426a-d506-08deacc3ca09
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:36:44.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRRS8d1WthPH0SUcSOmymMtiPhn7swkCVaaoVPZ49aiOhvV5w0WfWMTrksTxKWqPgz8I0LCqdFZ8SDs8rJQOBxo+PeJUIO6FNsxbBVvZ5a/OeTaDtfrAVhbHYKCFQdJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1236
X-Rspamd-Queue-Id: 1AF1A4F260E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.34 / 15.00];
	RECEIVED_BLOCKLISTDE(3.00)[139.219.17.101:received];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285642-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.646];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,canonical.com:email]
X-Rspamd-Action: add header
X-Spam: Yes

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Function names that consist of the 'jh71x0' naming convention are
renamed to use the 'starfive' wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  4 +-
 .../reset/starfive/reset-starfive-common.c    | 64 +++++++++----------
 .../reset/starfive/reset-starfive-common.h    |  8 +--
 .../reset/starfive/reset-starfive-jh7100.c    |  2 +-
 .../reset/starfive/reset-starfive-jh7110.c    |  4 +-
 include/soc/starfive/reset-starfive-common.h  |  6 +-
 6 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index edf4c45e6ff0..17fd061ee196 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -334,7 +334,7 @@ static void jh7110_reset_unregister_adev(void *_adev)
 static void jh7110_reset_adev_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 
 	kfree(rdev);
 }
@@ -343,7 +343,7 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 				     const char *adev_name,
 				     u32 adev_id)
 {
-	struct jh71x0_reset_adev *rdev;
+	struct starfive_reset_adev *rdev;
 	struct auxiliary_device *adev;
 	int ret;
 
diff --git a/drivers/reset/starfive/reset-starfive-common.c b/drivers/reset/starfive/reset-starfive-common.c
index d615c4a68cc0..772bdf6763d1 100644
--- a/drivers/reset/starfive/reset-starfive-common.c
+++ b/drivers/reset/starfive/reset-starfive-common.c
@@ -14,7 +14,7 @@
 
 #include "reset-starfive-common.h"
 
-struct jh71x0_reset {
+struct starfive_reset {
 	struct reset_controller_dev rcdev;
 	/* protect registers against concurrent read-modify-write */
 	spinlock_t lock;
@@ -23,16 +23,16 @@ struct jh71x0_reset {
 	const u32 *asserted;
 };
 
-static inline struct jh71x0_reset *
-jh71x0_reset_from(struct reset_controller_dev *rcdev)
+static inline struct starfive_reset *
+starfive_reset_from(struct reset_controller_dev *rcdev)
 {
-	return container_of(rcdev, struct jh71x0_reset, rcdev);
+	return container_of(rcdev, struct starfive_reset, rcdev);
 }
 
-static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
-			       unsigned long id, bool assert)
+static int starfive_reset_update(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_assert = data->assert + offset * sizeof(u32);
@@ -61,34 +61,34 @@ static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
-static int jh71x0_reset_assert(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, true);
+	return starfive_reset_update(rcdev, id, true);
 }
 
-static int jh71x0_reset_deassert(struct reset_controller_dev *rcdev,
-				 unsigned long id)
+static int starfive_reset_deassert(struct reset_controller_dev *rcdev,
+				   unsigned long id)
 {
-	return jh71x0_reset_update(rcdev, id, false);
+	return starfive_reset_update(rcdev, id, false);
 }
 
-static int jh71x0_reset_reset(struct reset_controller_dev *rcdev,
-			      unsigned long id)
+static int starfive_reset_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
 {
 	int ret;
 
-	ret = jh71x0_reset_assert(rcdev, id);
+	ret = starfive_reset_assert(rcdev, id);
 	if (ret)
 		return ret;
 
-	return jh71x0_reset_deassert(rcdev, id);
+	return starfive_reset_deassert(rcdev, id);
 }
 
-static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_status(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	unsigned long offset = id / 32;
 	u32 mask = BIT(id % 32);
 	void __iomem *reg_status = data->status + offset * sizeof(u32);
@@ -100,25 +100,25 @@ static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
 	return !((value ^ data->asserted[offset]) & mask);
 }
 
-static const struct reset_control_ops jh71x0_reset_ops = {
-	.assert		= jh71x0_reset_assert,
-	.deassert	= jh71x0_reset_deassert,
-	.reset		= jh71x0_reset_reset,
-	.status		= jh71x0_reset_status,
+static const struct reset_control_ops starfive_reset_ops = {
+	.assert		= starfive_reset_assert,
+	.deassert	= starfive_reset_deassert,
+	.reset		= starfive_reset_reset,
+	.status		= starfive_reset_status,
 };
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner)
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner)
 {
-	struct jh71x0_reset *data;
+	struct starfive_reset *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->rcdev.ops = &jh71x0_reset_ops;
+	data->rcdev.ops = &starfive_reset_ops;
 	data->rcdev.owner = owner;
 	data->rcdev.nr_resets = nr_resets;
 	data->rcdev.dev = dev;
@@ -131,4 +131,4 @@ int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_no
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
-EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register);
+EXPORT_SYMBOL_GPL(reset_starfive_register);
diff --git a/drivers/reset/starfive/reset-starfive-common.h b/drivers/reset/starfive/reset-starfive-common.h
index 266acc4b2caf..83461b22ee55 100644
--- a/drivers/reset/starfive/reset-starfive-common.h
+++ b/drivers/reset/starfive/reset-starfive-common.h
@@ -6,9 +6,9 @@
 #ifndef __RESET_STARFIVE_COMMON_H
 #define __RESET_STARFIVE_COMMON_H
 
-int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
-				   void __iomem *assert, void __iomem *status,
-				   const u32 *asserted, unsigned int nr_resets,
-				   struct module *owner);
+int reset_starfive_register(struct device *dev, struct device_node *of_node,
+			    void __iomem *assert, void __iomem *status,
+			    const u32 *asserted, unsigned int nr_resets,
+			    struct module *owner);
 
 #endif /* __RESET_STARFIVE_COMMON_H */
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index 546dea2e5811..122ac6c3893b 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -51,7 +51,7 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	return reset_starfive_jh71x0_register(&pdev->dev, pdev->dev.of_node,
+	return reset_starfive_register(&pdev->dev, pdev->dev.of_node,
 					      base + JH7100_RESET_ASSERT0,
 					      base + JH7100_RESET_STATUS0,
 					      jh7100_reset_asserted,
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 87dba01491ae..c4dd21761e53 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -53,13 +53,13 @@ static int jh7110_reset_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
 	struct jh7110_reset_info *info = (struct jh7110_reset_info *)(id->driver_data);
-	struct jh71x0_reset_adev *rdev = to_jh71x0_reset_adev(adev);
+	struct starfive_reset_adev *rdev = to_starfive_reset_adev(adev);
 	void __iomem *base = rdev->base;
 
 	if (!info || !base)
 		return -ENODEV;
 
-	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
+	return reset_starfive_register(&adev->dev, adev->dev.parent->of_node,
 					      base + info->assert_offset,
 					      base + info->status_offset,
 					      NULL,
diff --git a/include/soc/starfive/reset-starfive-common.h b/include/soc/starfive/reset-starfive-common.h
index 56d8f413cf18..16df46a074bc 100644
--- a/include/soc/starfive/reset-starfive-common.h
+++ b/include/soc/starfive/reset-starfive-common.h
@@ -6,12 +6,12 @@
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
 
-struct jh71x0_reset_adev {
+struct starfive_reset_adev {
 	void __iomem *base;
 	struct auxiliary_device adev;
 };
 
-#define to_jh71x0_reset_adev(_adev) \
-	container_of((_adev), struct jh71x0_reset_adev, adev)
+#define to_starfive_reset_adev(_adev) \
+	container_of((_adev), struct starfive_reset_adev, adev)
 
 #endif
-- 
2.25.1


