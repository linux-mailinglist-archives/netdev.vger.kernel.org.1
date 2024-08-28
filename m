Return-Path: <netdev+bounces-122704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE867962438
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C015285CD6
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A5D16B72D;
	Wed, 28 Aug 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eng/4qe8"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E595167DB8;
	Wed, 28 Aug 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839270; cv=fail; b=TJOdW68SCFf2HGaoDFsgx56IMFE9BdNB4qDgYMXlaOMz+rU5hLwO4AYOMRyLHkCwaG4e4vEOWbkIv848qFLcwx5uiSooQ3O7Gptredu26MBXlHXRHakCQ+xjLFaOQ39jat86VbOS4WkdVrLu9kTbX6dCGKA6GgrYh4Ja16Fo6+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839270; c=relaxed/simple;
	bh=HHUCgXhR3J6Op8k6eCFzuzJOj1cLRU5TRWSNL+s7jSI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hRho/McQjrn+S8p0b6bB6QmPmY8n/dAFBpwWKQe4aM49sH/Mh591biejD40qLbEQff/X0hxSpkAXiDAErsqVltr/X2oDYt1AbWVsTzbY92BIkmPbEqS3Z9LInjuPWDOeGk9hEiEWTatKXnWdVoZLqNM6ctAn+0vmgB82x1go9fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eng/4qe8; arc=fail smtp.client-ip=40.107.215.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vuyhe+h0Nhnxk+mP5W3gntBNyAFvZDj1gCKhcX75sjZofDuuKwLjfV2kG+cuYFwTpEddzkw/D2Hoz7AbtRr5AmkRa0QWVh/x0/8PY5/u18i7c78s4GuYiiDoUT0p4mPMcmC4ahq3HKFWvmNGaPC3YcgfoGdtYOC3a/pKWwQtVYFuL2isxpkt09pixLOcgBhQ5WLutcXSfQPi/H4cfFfLwazc3fmD0lO8qmv5LOEcaiy4NndV6ZxgAihwYb9GFt4rgmBLbVeSCCvKHSukO1cADaSAUH4OoQFlbxJoSKlkfJg4Kem7SlfJbtfMrUJzcsIxba38y3F7nIMBUkcuVNC38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW3SJc+Wmz9FB6cgMxmBl4LzFElVPkoKwQTGwp8zlA4=;
 b=JDrWIEuex6h5cr9Htgz758vKhnNG9HoLSlNqGy2Z5Cm8dKOcVwss5lDHUTRj1HbwiVxhYnPIL3K/jS+RjbeWOhnFPIUrQAIr7TwEIRWu9OuZddQDC3xXS42r3EfijNMGnNrraUQooCQZM7sWu98hLqKDb9OBmSvVfbV0wnXTeTbvtNZdstdznMrwJqd6pN1VxsZfJRQnyi2b1nyUaryIVPpwKboYHIXmYALzsuGXOcPjb9YfO5FGs27i0H38esiPPrDc90wQ2iwhxgBAKCo8qQiVRwpARl7xYirq/9uyiMP+O2mLbMsJPUFS0BcWboUUM0ePhlVpPq42Jx+hA2lrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW3SJc+Wmz9FB6cgMxmBl4LzFElVPkoKwQTGwp8zlA4=;
 b=eng/4qe8nXu1rvnKBkORbrWgrnVHLlVmxJnMSVmeMN0OXtCz16HYiL01w7nhw8O5hVP/d0wgLE3YXNUQL+TRtKuY4X8bGFnV7BFnpjqLWuJZnONTTyi1a/RGJBKAUZiZMPDzzIYjq+hvA/1DNMk9ncOwZYTU36+jbUqlLg0+rEkaBahdLehPHjsldvKzJzUkw+nsl5hSOgH0IHx5JJZrvgTowhswwt++sC0cRKlPQSft5D/cVi+V1NMIA/MbCh28XFffNDaQA8Dlo1plBuvee0ppU65TlKgegdzvkdunmteRqLuSF/dABhgdEvwFZ0PZf1v06cVNT0YvsMW+9JwLsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SI2PR06MB5067.apcprd06.prod.outlook.com (2603:1096:4:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 10:00:59 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 10:00:59 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] sfc: Convert to use ERR_CAST()
Date: Wed, 28 Aug 2024 18:00:44 +0800
Message-Id: <20240828100044.53870-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:404:56::16) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SI2PR06MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: dc83d218-5823-4e35-6801-08dcc748510e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VYF0nKieFJdS6TKxotJoCM7Q+0t5cCcH/4YP4glV2EPuasykEMdVUSimrUz?=
 =?us-ascii?Q?dx35pMHiczZAFZxgpl2hcri74gsBkIv6cuoEdaWBsw3TU9KreavZn4pJyZni?=
 =?us-ascii?Q?5C3d16GWnp1lzljYtXYe0PgyqQPoqcUlYei1isYz2V/KGgTm07y4sU+3g/nb?=
 =?us-ascii?Q?aEc27a1pfVS3tFJzJ4MlJ6oepV3lIgzRhd2WbF3D6so0677j0TzeKQ0EyGv7?=
 =?us-ascii?Q?XJhzpqZeo7N7Q8Z2qdBJjFSTd8uzbHW7SJei0rje68cI9JuMHjwle0JXSjtl?=
 =?us-ascii?Q?H2qz3bYsFF+54IPg+Wl+snNvdHruOyeMkdsilgNRf5jYqFl+Uo5nB8XlnfrT?=
 =?us-ascii?Q?KduivrqPlx9ba1ub0Zpb1rWlrrBN3qCQGkZTtdvQJx91Thi5lMw4xj8+tPE4?=
 =?us-ascii?Q?W291VHdCJ9lqvRQYoXpAQkvGLqR7oJjfh1s6R+1d7lUG6+Gkoc4zcCcRrQD8?=
 =?us-ascii?Q?9vDi8TRp4RKg+J/MWdNBfm/JUv75ibKDeChtKo+m02I11AnLSOFfLYA7GlrW?=
 =?us-ascii?Q?ryUkjNsFmQ2q6sn3cV9f4YXw6r4N+2kVVyAkCme8b7x9W7saL3vrwqT6sLb/?=
 =?us-ascii?Q?MCuMdbBRHxzM/bZkpUf3fpL6QIsH0zNgl5GcW1WQJGjFLn5fqmIsPsCKCn0y?=
 =?us-ascii?Q?YzRnFl5Mvdne7sPpCX0xk7o6V2gkcqukO6WINFs0KJsV05y07bSqy4XulPwp?=
 =?us-ascii?Q?CSakaxU/IGChraq1DmO3OTaboMIMYYpbEUczK43QyoR7YMlAiDaPXotTb/mP?=
 =?us-ascii?Q?5umLTDXAmg8FlbCEWjwZ2cyQiWMkXBvmBSj961cga6JeRCzQuEEaTGFVNG32?=
 =?us-ascii?Q?8j+LttBIBu+W3kDc79bfMRes0e7h0sMFqn2TgWqsxGydjkXJK3v9qWiZkQOm?=
 =?us-ascii?Q?o+iarqHbPmc02jbZfYf6hNNfOTmZAUk8sk9mJE/mAGFiPlxZvwXqQI+j24/l?=
 =?us-ascii?Q?RRRJXkzZCA1Z1KdeuBVf4srdtrO2ixRjA8otM3/UF9/h+6tTPpoX9aoYgbj7?=
 =?us-ascii?Q?E3UuRlTb6w/0JMCVvgVwo6eLfz15KVQWDpSVC7whWmZ/yO27GB1O36IWuI45?=
 =?us-ascii?Q?VCj2utnee8vr+G2aQ4qaYQRq5XTTNCskGhn0OlaAm2ZYF4WMDjH5ZB/3ifhe?=
 =?us-ascii?Q?u5M4Skyty2Uij4yKHZvncHiADvJcPBCRl/FzbGsipHC+zuRNzptQTxesB04H?=
 =?us-ascii?Q?whl8imMl3yXRG9P87+/mADCH6h7m7Ctro3cu4cQ16mIrz6O0XGxJL/ZQPmKC?=
 =?us-ascii?Q?Ao3VdGa4rqxfV8q3kLbCw6YxXOwAttQLkzQ4I3R/cPz63lc5FvhLkUIDJMXr?=
 =?us-ascii?Q?1ZBXfkannB6dAGvrRp1XUFSFbhl1E6Lq4PvsaLLxjJh76j1VSWzjjQiaLUh2?=
 =?us-ascii?Q?tbEBOdmgrLkoZtv3CYnm9k5CUN1EngAG6E+hjaLh3joefcjJGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4F+sZiAKACS5eQjmU2qNK/0yDY+V2Oy+PHLrgTekW2omhYDS4QhEYMvPpmnY?=
 =?us-ascii?Q?w/cvHqEikzsnGHHTQHLXZn7e0VyeBYiKhvEDy5SVtOGDKD33vv9v/oNC5VFx?=
 =?us-ascii?Q?EJkVmj4XCwXAmBBFsnRDubvEh7cecgWLtA5mKCQmAY000ceKEODtAvu7Chve?=
 =?us-ascii?Q?nbWqbkX7TQSvaNbxZGpnYuo9HzJ615VUOAidxgEcaKP+AHDzysjMeXjx6Zgy?=
 =?us-ascii?Q?A97YCXQ9Bo1FxAfXBoqClGSW/aRajjNgoaFL1cWtIKtSEHd/BssBPG2lNlOi?=
 =?us-ascii?Q?znt4u6ta9ChaSaA6ENbCQLayzcLQDdSgrEJHXC8xOdCfSCzXrolWH9+db4Sk?=
 =?us-ascii?Q?tu4aJiI+RDU/5QyVt5+luP+/t9xB496DZQz5hT/8XAJgvLZP4SovmXimlr1B?=
 =?us-ascii?Q?14qOQxO8MKkbLYcBmlJq7rok7j971+I8M65hel5YvNULWOupUaXUSuhOEMI/?=
 =?us-ascii?Q?SFV/JQr7S1koSax7d4Uo/sbz6K459quFOh1P1JEDBVCgyh/q+gEeYyVnFYz4?=
 =?us-ascii?Q?nW3E30v7skdqxUVcNGiER0DVTAymxduRvU+D2cFB3E8IspDslSGg8vEhyUtO?=
 =?us-ascii?Q?YMDbcOp/7fV1EU5HZOrKmmFu41naIwzl3weU2uNWEW5Pqa1gfOg8a0vb3dHm?=
 =?us-ascii?Q?lLgXSzJodfV8GH/7kpQJV3an6sQtJ5ECHlY+VCmhlG5npZXRsUXYOYQuJdVt?=
 =?us-ascii?Q?W9z4uNWcsztRqmWNvGOXzrKjRPgQIAd8skrBm+ZMWBJWI03QhaQqft+LUjY9?=
 =?us-ascii?Q?WdVFH+MC3wvIE/ThaqUWyPhx4QWEcYc+6kWUBgcBKGDcXu3HA7UkMvRO7UkM?=
 =?us-ascii?Q?hZ49QABndToWlcTzTzeWtwm3NUT47HkximGaGhYoc6K/mBoC2nJAs321Yl5O?=
 =?us-ascii?Q?V/ueiRGTZ/oox+TMP0s5PR7Z7ydTqZx4+HGIDIX0YpFEqNexk5Bx6aS5m2Kn?=
 =?us-ascii?Q?nnE+lt/9Z4B+C1R3VTayMa3mDdzLP7kN1pZDAd1H0xwUWrEEezZ78CYKTrnI?=
 =?us-ascii?Q?z+bzsxFbNFF577Z8XOOEOAGA2gD/e7Yv7O88iKRqhK2OJV2+ZiUSUzVCHxvV?=
 =?us-ascii?Q?e8jwYq9KdFSKMGdf7JPv/7aZigydoyFybyqi6+0ZT/KZSwV/rXRNoYRXUF0M?=
 =?us-ascii?Q?h8wzckZZQqqZMxNDqV8gMqmiOyS4lxPiVh8gU6Tti5s5iHdDD4DK8UDODEGf?=
 =?us-ascii?Q?Sr+2U+W1ur7XxNcCniHRvCDYmprqEIR0ca9ldiRZcMXoEs1UEXQyz+wG1INp?=
 =?us-ascii?Q?VfQ30NYv5Qig9E9nBUuDn6QJeILsbW3V7g0IVteK/QcHsJbmOs5kd5NJOsQy?=
 =?us-ascii?Q?FgriqNqor9+tCkc5HKW6td4ZBsousPQSBcYGyDcy9MyFQt+ZIqR95V5tenRg?=
 =?us-ascii?Q?c2gFjnAs+pjlKMk32pp8i6TvLwauPKUMRFK5l2DEEXN05l8YBon2r7Vg0SHk?=
 =?us-ascii?Q?6lXXSQBnFhy/ttKj3pKFz6iiz5MV6Mi7Wm6kDCaFbVN8xW/dNl2ueOZLEdGU?=
 =?us-ascii?Q?gshRG9RWk+/Gg2FKFHCGrWnKNEqL2OSBLcWG1UG8vrTe8fBMQr5cx5rm5M6h?=
 =?us-ascii?Q?bOrxBkaJ04HfK7ytnedURbeLSz4gCH93BGhDsxKY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc83d218-5823-4e35-6801-08dcc748510e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 10:00:59.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJhZqwPkia5hzS2l6PpJJIUGrn/bHyKCftPmt+KX80Bm7hF/VFwMeJVQ8ZYDLyo6biRR3Y4jffhtKD9NAlJyPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5067

As opposed to open-code, using the ERR_CAST macro clearly indicates that 
this is a pointer to an error value and a type conversion was performed.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/net/ethernet/sfc/tc_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index c44088424323..76d32641202b 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -249,7 +249,7 @@ struct efx_tc_counter_index *efx_tc_flower_get_counter_index(
 					       &ctr->linkage,
 					       efx_tc_counter_id_ht_params);
 			kfree(ctr);
-			return (void *)cnt; /* it's an ERR_PTR */
+			return ERR_CAST(cnt); /* it's an ERR_PTR */
 		}
 		ctr->cnt = cnt;
 		refcount_set(&ctr->ref, 1);
-- 
2.17.1


