Return-Path: <netdev+bounces-214289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD63B28C38
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 11:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A199AC2F42
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F323D7E2;
	Sat, 16 Aug 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XgQSTMhg"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013011.outbound.protection.outlook.com [52.101.127.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0423D28B;
	Sat, 16 Aug 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335269; cv=fail; b=limQvCo3I8KfDJX9WhRrwxVtA4SfwT+GRtogIdSY7n07GL/zB4IkzMe2PQo3e4NK0/Yu6LYVA76h5Fp16vNQybZTH5xt0S8xv2Plw+FRVv0GyQl4+VZPVTr/ndcSnXfBNx7SdTt4g5E/JhDvaGcAElbbWhDwAo3Crn36uXE2GVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335269; c=relaxed/simple;
	bh=f40SC90tPKtoZ7Cj2J/CqZajhBshVqx90b7oEWgXLmU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ehn/urOiQEI192sn8dlomsWPWJzQH6jNY3KyaKmdQY7w5+sYfXwrJwx7USNIi4K4JYgxL6iQwlUZiLRHLN0F1cYUU5so2MQX5DwE2SnELZi3qi/baIRfh5xR89KSxO1rAlhUSt5fAA4NV1DlLuRn4kiMqOAUUH5Bph9aYBdzJCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XgQSTMhg; arc=fail smtp.client-ip=52.101.127.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh2gGpSWP8E3p6SkYX6M+w+5FIOLPy2so2F8ry9TgLcaXxVfMlMg2mV3tV4kG53M4IM4R3bsSTzZ7ZJ7nNzOpmF9aH8/dwDfe8PYMrmey0zeU2FJzAImCYpudNGwHZ/cWTHb9c0g+ZbOEOGMxjXi4HBV+Osx/9wp6l89vT4cAqGlOnZ6M+ejG5wvOmI1fUR2wEIXqfNNHcKeVp7Hfl8NVPo+zm+RqcXeaShxTHWU0/HyM5myEhkC4fGBIC6ttdRSzxbjI8ePcDXcGjYPz8Rs08D+UHadqWgynB9FQQksvjec4R9/XiFsYkLNEr65UguDH88bn9Szzn4If/EhbqSgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLLpn5ML36UuYeOf0UF7XSFFXeK8or2O3Ypq8gq9GP0=;
 b=voUzx12HAdyBIrUb2NMkXt37lr2N6f8gnB04HXvgX0ttsk5YhdE69o47U9OaVxxwrGk4GcNCqVhHtv4v8rugQoWrA0eO16G+/NHXUX7/DdJTrqe68wrMUuOFLD8x4ZWeerqHnUHuMA9A8BAts66MPdJy9IVvn+PixkB50LQ2hOPT4WbXOdx0aLag68CyhBr7m94u2YUdunBOhWPSmR+gi0CEVEG2q4thEgHGmx6B4O5eh3EtSvSCzc6xLz3WCcQDB1DgQt0d/73UEgXwP4A8HWYp92w6pFzDVpB7HFvZKje1Tp2vZwuQ8bMv3AS4bVGvTAxl68breJfgMbjOPvhDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLLpn5ML36UuYeOf0UF7XSFFXeK8or2O3Ypq8gq9GP0=;
 b=XgQSTMhgzLnb0HbQRyM6zQWHXb4GW9ew2s3OjV9Wyg13f+gT2bVtwSKPM+z+gvT7ZefbBuX5V0cCiBmgHbn44NyUitt/k9YOWpNvy5jnmU7r0O4kS2s3ledJauEUk9G8aihPdBvBStgmKiwOyhGXyOUJVgBVu/9IpNY9mkVDSYEQSZwk9fSFo8Qcy4lJLZd/P7Km5mEHFsdHcSw4wzRZWsjXEZRzhz1RZGWBDE1uUTVZV0Q+ZISvpxsTV4SIOvq2hugQ/DYQsKonSM3ejomaMojFIX/CTcxreGJvgnOS8gQfhVhWdCQx8ggfjuFsGbbXe5pRgLmNNJ38bnP3ONoF5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5962.apcprd06.prod.outlook.com (2603:1096:101:d7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.19; Sat, 16 Aug 2025 09:07:41 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 09:07:41 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/3] nfp: flower: use vmalloc_array() to simplify code
Date: Sat, 16 Aug 2025 17:06:53 +0800
Message-Id: <20250816090659.117699-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816090659.117699-1-rongqianfeng@vivo.com>
References: <20250816090659.117699-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::22) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 515980e0-0354-4031-db2c-08dddca45a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3+vjFeOoVEdz3yuxR5/VQ/FUdzaIlsKPMxL3V7Qr0SJi1L66SZeT/v1zsJEr?=
 =?us-ascii?Q?kVzPWnfC1NKNc5UfEu+4uuLotM11CzfqUlMhkcX1crqfYWzR9/0mrkVueQVn?=
 =?us-ascii?Q?O2vBx4JvFzV/n1rpwmRvw8/rMcjOmP43LxQbQIYFpuuH10/Ra3OAKNWGC9nv?=
 =?us-ascii?Q?7lPW2/WWe+8zKKTJKiquBV0Li0sIvdUA750gYlazwKAT+XKvhDhQvgLtvyA4?=
 =?us-ascii?Q?98OA3vVgcVz4SL1D/mNXU2KucPI3FvVheAolIDubFk55L5u7H4LzxIfxY6nk?=
 =?us-ascii?Q?GLuA7gPsHeFLBbFBLj32qSKAUp0Jv0JycTISJVf2sT2P4/UlXCiTo1ysDfZQ?=
 =?us-ascii?Q?mZAH66CYPg/MRjaVLStFJyUoYBkJzwcJVz4bVCSHguAFK59QKfWv/Undyq9n?=
 =?us-ascii?Q?nRDQ6zjVK74K2ckLJZuAq0IpzdW0jbqChxXJZLx67++1+y5WYozgk49o10jI?=
 =?us-ascii?Q?1o3DDW1U4zRpBBU2nChCyqvXihG7hJVOD9/MKDVXCP60XiJNQSFUitTBp/cx?=
 =?us-ascii?Q?Z7/ntmKaNuwzozJg6V9MbuWcv/aqTNk8ORAdmR74kf+iXgfVNMTh20GUBvbX?=
 =?us-ascii?Q?m1TfxoKzCGMMy/AhB2Ac/fwceRGzxQAvfXFlyXchaufolyNqUfWAQCv4wFVG?=
 =?us-ascii?Q?r064ehMODs3T5g6ypUkP0fu0JNiixO/dgFoseXJcSmA6vOVNv0ZRISppjhiM?=
 =?us-ascii?Q?vMHN57VVI0s+0qkCWHEnoraRDfuVTncTNTJYiXdrjKdeVPMxV3zCjr2+ISF8?=
 =?us-ascii?Q?/xqzJBy24ccqMTNfCYrFUj1ZZaoIR3T8oplIISlIaMsvMgEh1/tcSjbSUcf1?=
 =?us-ascii?Q?MXEY6+6pFZNqhFHqZbsqTjLUmDjVYOVJ5Cdpd8amMQvDHHOZ4shXy66NQGkn?=
 =?us-ascii?Q?xovtNtUtTMXf9ZgWFbsP6k6EiHeXrnf6UcW7weKXv3EPVW2RCr0EoSIibW1+?=
 =?us-ascii?Q?zfdxMl4vIIR7yZnaU9Fus1C8TvUM+IH3YTPYm7TEPoj5uVgOB2cWrcUek1LD?=
 =?us-ascii?Q?3Ebg9c7d6wW9ASKZeZpN878/EdT/A/1Pp93EU2rrOOURyx/t9dsyOvZA4oZS?=
 =?us-ascii?Q?jC8Fka+gjD3v8Cq6BLeKnnbxY+x0D4+7vLBHnLXOBpH9WwVF1QOBVuytBEh2?=
 =?us-ascii?Q?D58oEpYKSry3yOfyDw6Eav4qgFXDkCmeuUe1+X30vx5pt4qVVP0GVWlcUt6n?=
 =?us-ascii?Q?g0Cz2X+cnx3VdJJRdCj45kikUVW5wI1jqgndWlSoZJt9OLkJE8bzem/h+pSW?=
 =?us-ascii?Q?E28QAys3pYwG29wmCsUkm5aGcdKobQIkx76glu4qL8pZ6iraaChL5XrVwQC8?=
 =?us-ascii?Q?yv5E9b78iEoouTmv/J3baVcNFwjKq+S2WckgdHFu5lDgOu4I2DNI7/zYoNom?=
 =?us-ascii?Q?+RURtL992d2Pl0/nUTAq8Gn2vPpZ/75hjOUciRZCu8YJeQiTagJs48u5AilD?=
 =?us-ascii?Q?6IHaQkZsqFUfda5Rfz+ivDSjc+YHA+AG8epM50hzgs1fKRRlYOUKhE5PN7Av?=
 =?us-ascii?Q?qcOOOLrLJszBnj8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M4WNK832M5kBpGfNlgmkD3q5fnms+yiQmmlKJ8tTQrOUtTGxpSq5h2pPVCEf?=
 =?us-ascii?Q?O/MGCsG/5ze5fwztB2IEki3PLVO6SHEEE11DXA8mcSyhaNqQ4bqqQGroo+YE?=
 =?us-ascii?Q?FYcVFXlx/PRAaDuDP2hta1XQVlJftJr6cdttnG/wvxLfYx3RDi9yp3UcjbCn?=
 =?us-ascii?Q?WUcOLxaCY2VxvDYycoL5WzxI56J3Cy6cAgBUTFvV3K7kGvHTRgpUKUC/xK84?=
 =?us-ascii?Q?XK/zVOKc8v7ppppDtSlHVVFmRqjvi3qnYZrlMNVxkmMrgeFinFFFK+KlJEOB?=
 =?us-ascii?Q?9nUyiEeAmYVZDFRjAhqXpSxo+iUDwFl56OVq2maGsmGU8viR+Y5vEGhc1NxB?=
 =?us-ascii?Q?2UcbYa+3aon+KI0nUFVFvYJeXMAF/HY6fYpkewtsuiRx5USSQfCZtc5PE7Dw?=
 =?us-ascii?Q?xBatMoXH0W3ha9Cg0FU2c1/FaFOHiqxKkw+ik1ZPHhHClypLVPE73wpW+LJP?=
 =?us-ascii?Q?uo8ueLjSquxaTUHJDMjxr2etJ3gUqgi3KQHY5zdtIeA4vmfV2aCh5QLkCMjV?=
 =?us-ascii?Q?NWwZdcdOTPrvVEwSM42Hg95fECZOcVkKOo4hI5Noa3Kl0kqMxZ4HX3+Z3XRT?=
 =?us-ascii?Q?4zSRloJrWF06bmp3BK1+meRn+hhWR8oxDTtfkZShr2lbbd/PW17I6yr7soKv?=
 =?us-ascii?Q?6YSAsYnWaLUDeFpqD5AiTVGoCRM5amCnjVLIjnTqbv62A3m/gDBt35sUtwA5?=
 =?us-ascii?Q?oadKhSeJmAVrn8oPpS0qDx23BvgWu6cZ8LMaxceQwfWY7i7I/gAJM0u1CVta?=
 =?us-ascii?Q?ufilng8eR24cmezi4H2eTCtkdCJHCokuh4nFzOtmgcMmjuqcl+rMw6pWpJP3?=
 =?us-ascii?Q?eoadyZivE+rQwN3/5FHyNkqleGSjhdID4GnnPCxlK14HUL3EwttzhjOapD4C?=
 =?us-ascii?Q?Wm4//qhx8uQ086Czu2NXeFFrOGVDcFT7jIaPKcFFebKG8svXJ88o/uop4h5/?=
 =?us-ascii?Q?AjOsbw8quresqbKewAgE/Gp8G84YodkaVhXFJoqFDVYFqX7pDPwm4AvV5UuV?=
 =?us-ascii?Q?3owQAgsv1MeoAhElPCs0Id2tworpFfMNeQujghU4uJyjg0RG3fxOVYnjR5O8?=
 =?us-ascii?Q?g4cLQUT8ks70sNtal0oIHShoua5wG1F/sQisqqcDQTCfZ+32OSKyYYUYsQh+?=
 =?us-ascii?Q?usNFbMlnLNZQt3O2hSrsM2bfaPhb13MyCRCsWAkf+vPLe4KKr7YvT+W4DDUu?=
 =?us-ascii?Q?1ubMGsEL38ixTPQZeVHSVx6ZDfo1cMdV3bwLXWGQfRhAGDl4w6tASRSsvSB+?=
 =?us-ascii?Q?YAA9YvyFgh52I80zK4s2YQSGOKM1rG9XwS0vizQW1l0j/uE9iqHj8jmgGryd?=
 =?us-ascii?Q?G2Tqld2G2OtOt/EhpDpZripw2vSR6vbOA6tT4b7wBb1ynLJnb0RAZ86pFR1/?=
 =?us-ascii?Q?uWmoRSaBKbHqCAPbyiTkhNzwYMUSYO1/QtxCiqd7/eaY2t53X9rQJu6hiCCN?=
 =?us-ascii?Q?b3wJWETgxRSO8yWa/hlcAV2PfRPaIqd2fF2cdaxLfnfmhaywdYPodpoTP+xQ?=
 =?us-ascii?Q?Qc5+nyfZlm4Z3YFCGCSwCbVf3qC4R8+7xgyM06hhgUpwmza/KFzbls/iUZ/W?=
 =?us-ascii?Q?ileblAwT2nzZ9qxkyfoBFbR9ebiv5SRat0I9U3kQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515980e0-0354-4031-db2c-08dddca45a99
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 09:07:41.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CU5g4EltnJ1vbcCJhTPbeCxoQLj2xWX0R3HMkzGrOHeT4tvwmLnABm10u9c6Pze1yKPof79Jojpwx2TC+yazFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5962

Remove array_size() calls and replace vmalloc() with vmalloc_array() in
nfp_flower_metadata_init().  vmalloc_array() is also optimized better,
resulting in less instructions being used.

Place 'NFP_FL_STATS_ELEM_RS' with the sizeof() parameter as the second
argument to vmalloc_array() to avoid -Wcalloc-transposed-args compilation
warnings.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/netronome/nfp/flower/metadata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/metadata.c b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
index 80e4675582bf..dde60c4572fa 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -564,8 +564,8 @@ int nfp_flower_metadata_init(struct nfp_app *app, u64 host_ctx_count,
 
 	/* Init ring buffer and unallocated stats_ids. */
 	priv->stats_ids.free_list.buf =
-		vmalloc(array_size(NFP_FL_STATS_ELEM_RS,
-				   priv->stats_ring_size));
+		vmalloc_array(priv->stats_ring_size,
+			      NFP_FL_STATS_ELEM_RS);
 	if (!priv->stats_ids.free_list.buf)
 		goto err_free_last_used;
 
-- 
2.34.1


