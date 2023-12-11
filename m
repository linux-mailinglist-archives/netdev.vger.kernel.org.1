Return-Path: <netdev+bounces-55926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0B280CD9E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4183B1C212CE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859164D117;
	Mon, 11 Dec 2023 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9dCSt1P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAC12113
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f26RdZzcRxuG3W4dZ55ELs+rXqxqakdAjEe/uGPxsGBjUADJSNV9hEtf0AylOFvPBirJdXQf0B/RwJBLXupcSHVW247KAxU0G+nACS4gQFxQVTuI+zQN5HNmAN5woXfcQW8ucvC91KVYz9Fncak8wV4tqjypumjkFrKhP4mKGP6i4+4yh8z/LgnAnJ0S/Kys47S3Z9sAIIfQjxZBzhvwvQSX3S2olLhWnNEhjA1gL8wmLQXcRjCJ2qydhj10Gk/9Qum4Gn4y0MKtpbuAnpKD2KRFMgQPOGQNcYnD1LThnz6aEGM15rTnlOVDaROcRQflrR2vbzLAoAuhWrlNNKC6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEQshub/1/xJ1F043v9d07mHlf+sScRDh2PcizKwZTI=;
 b=g1LrXXJKwSslYQXnqNP81BuhgVtcMNjtD8JY0wh+SVu8UZ6GL5F4qyt1Qy0PZ7RMS+5CjW8JwBZd1SyTs8jcRJpCWTBqEpavS+YyLrNjjvR3BemctNFTG5lgiY1zJf4EeN0zLOTrkRU+wbIha1Q9syrdpMHup0F03boQt5CKDvSnxVnZV2i6A2rqD8REvE3Ajv0Kx0QWMmF0XHpIQtLUFELcXnJSs5R2J2uO7Qlmco1gPM+UspDKRFf5efbY2D8x8WWGX8Fw99CWU2CRlFF89g8vbHju9SoBAsQz8NihE0cnxnC86hwQJc8mYIaHEH23+GIVlbKCaaSUgIJxtPu+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEQshub/1/xJ1F043v9d07mHlf+sScRDh2PcizKwZTI=;
 b=f9dCSt1PuGgUmxBQviqLg6APInMveViut9KjHeeRMm44iANHWtZb+npZF5WUYv7wNa4U0pUyC2XqwHYGkC3FSAk8D3C3JXry09bzP8UtS/xal1TYQjXop7yhAG4Fuvy9ZVwVPF6gr4pm5HP2CtGMA8TGmZK0hE6z7sxp0/6NB30VhIdm1RvQHRuqXR//xfiInyP+O41U509/8FqdDvxO9Xyq+agzgnrt687oQfm+LYgkfM0xubF8ELZ1RvjswoSSTfhKNvFbLuC+3Ajayb3zDso6smR75L41BbweeawZwqgz7jaHg9SHpi/zMMkd+ZhciZDEoGQJsWLlLBT420WTdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:20 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:20 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 16/20] bridge: vni: Indent statistics with 2 spaces
Date: Mon, 11 Dec 2023 09:07:28 -0500
Message-ID: <20231211140732.11475-17-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::30) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f514781-4eee-4ba3-4c9a-08dbfa52a108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k6wah/MO0f5RWr1Uk1RkLFNX0suU2oKj7C86O8i9diKUBdRDeD2mMPjZXMB7uQNrjOiI1RsVzXUnzN89Rzf7fbsO0YiOXTVACKimO8TdlaeCmTyvAfNY+fmBQAN83i5AyEYgcUXUpOkKcvxCWKdGhS5gwzuPKkSkgQd5pTKugUHjYpoMGfcSq2rKFfqEQJ5GMmPwqTfs/Wa8RtGzZLu9vYNfRZ27bb8HWsaxHbbQ6+UZZAu7REtoVdVpuWr8pQ8BcCSjITLiDKwo/66mNeUiOjEoR67ktAYV89qrfsvTeqVh8bLL+aiB94xYHb9SRLOtNBviC9f/muGxXua4N6l+z0gLIrBzCe7oelrMT+Iqa7Hszb4vIUHCXCnNkuCJ1GsX38qaWZz7z8/rWuRE+GZWCLGHEASH6c95luJGAynZFhsL5oD8l/zPJxNafXYggMHogxCCA616V9eNmhoBFnZH67Dv9cJd6gyT0VrRP4XXTZJ/u+a6hasLpH9hbRc2rTNqbkG4QKYO0lGkr3cZiMWBbE33DNP9hXAdrquOjYmmjvU27e/GX+4y3JaaBaWKjR78
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(1076003)(5660300002)(26005)(2616005)(107886003)(36756003)(66946007)(6486002)(54906003)(66476007)(66556008)(6916009)(2906002)(83380400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D36iBQR/9hGcsTm/eAeU2Oaw3Nx0QUNKRWhcYb/aC4rWuM4K0QEvtBRhrVEP?=
 =?us-ascii?Q?e9iTxUhfCzZUUARymGsUDOJgdt5n13TlTolFf5iqZfKVObEs2DaR3kWkHlY3?=
 =?us-ascii?Q?j0fnEvwLXnF9/YZjbfdso3eX0iQh5zfQSBxDB/6tUJLMwhnKUXZakqWKgrD8?=
 =?us-ascii?Q?+w6T222YbEKBwxCL80Bz3xwhrXQoIf0mC2nC9P3I17seyklYStgDbY8V77Tx?=
 =?us-ascii?Q?WIWDtKEOJ3ciXQdW6ArtCkhL3XFoyuraIFaE8wDZIPEGUN5wk/eMWw51kr5L?=
 =?us-ascii?Q?OkknlJ2SuBVq3UzlrDE+ncKjUNd1MsQLfuv51hSW2X8Fu4kzUvu8tKGTkOSG?=
 =?us-ascii?Q?y84vCJfIrOfvUXen074DJeWTQyQYlSkMmwJ846Gd2VHpSuEjkv80z793QOFw?=
 =?us-ascii?Q?F66iZbCY9w1W76EiZ89Ks1Cdh2SJrukpnJg9cOFMaiP7B7lz4EI1SDM03nZv?=
 =?us-ascii?Q?8gmPhsO3fHQhDkGtKTdmzyFCbL5nqGvtPGiKCpnqQNfdts0da4AvurmLqGnG?=
 =?us-ascii?Q?nXCU2P9hksw6aidsZ9QVsCzW7KqSXasJCLBYNxmAiiNlp8y+CVNKzAdmVkfp?=
 =?us-ascii?Q?XX/eUjf1Gy0NNd+AWu0h+fHhmuKG8CTbdaFTgpspW3OVSo7mm7FsUg6vLy5Y?=
 =?us-ascii?Q?01kl0b/UZtcv5b3qlrDA3ST8k/AwJpXseexXE9FhsfnaSH58Z8TAkmeYsDqq?=
 =?us-ascii?Q?mDW8ZfldXscQe/0KLS98pCJW6c/ThFppejY2AV+oVuzQEi95EsU7Qq8HyoFf?=
 =?us-ascii?Q?ge3GhLh5TqzuknbUIL7AIdSHR5qQxK5kRA7R7YkSbJzYjaet3+jdpjDjJfS7?=
 =?us-ascii?Q?SLnNLiQ6jUbP3nGp7M9b2QaJR5Q20IRTaFy3j7/oelu0rAuXNt7H9Cxce+m7?=
 =?us-ascii?Q?RRu7GtoI94WmUZpjkTHRyli1seSY9ckmENEE9FmmDmGPalWOnU34E75blQcN?=
 =?us-ascii?Q?gdB3fIWdjF2O5oLVn6RA20BOQLD/QkIwiYipF41MGN2UBCA/tERTaF7tfrYH?=
 =?us-ascii?Q?rPdFv8/LS7e4927jGuMZGPFZvcI4IG7XMnbiW7KVSCe580VztV5N+BaW6d05?=
 =?us-ascii?Q?9PSOGBWc3yHg7ym+ZbweYLJjkgpn1OJfzXdNc0MkMtFKLly4PyTarPUry7p2?=
 =?us-ascii?Q?INuM6r+iS8qVj5tPBM/1iCvpi3p4SxqalhNTAyGZVbUuWLgN0HA9nU5REu0C?=
 =?us-ascii?Q?U+Cd7Utbopiof+cmb/xxvqtTsdPfnTm50fR5IDpDXzvk+BDsP9qRiDcCvL8L?=
 =?us-ascii?Q?yUgO9GYmhMA+Y8s3+l5rfgWy+aBhbnWFvf0eBhOwHm+nmmOvsbVWp7rtMEwH?=
 =?us-ascii?Q?StRTsztATGQc2ICmqfPOMIniavZ3sx9PLVy4wfg2ETTFMwd5j2qKOSbuVtiO?=
 =?us-ascii?Q?FWZosF4RM1Ffu/MGeD8A7gze166x1ynmeXVikYZzrSpivnuBtY+6AaGMnwar?=
 =?us-ascii?Q?gZBCGZn8yab9W6wWDRqg83GgtAGMLX9XXd3PCW+Lm6o8Sko9Z9WlS/Us5AYe?=
 =?us-ascii?Q?F34N+9U7YOaUuszAPUh7glYI7OsI/R6EVKBzmKQtNU5kSFThLCWC44i/iUif?=
 =?us-ascii?Q?mVVOPbzUCkctEeyZB0bDLDhN0OpAFRZ3N/ezw2fp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f514781-4eee-4ba3-4c9a-08dbfa52a108
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:20.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4hPVEw5emgc45K/UNJjuWtn0bF3FUY8ch5EdZzl62cSEYzeNRC4XvJoqRPhrYPwHhQwn9TppIPJNj7sBZg4DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

`bridge -s vlan` indents statistics with 2 spaces compared to the vlan id
column while `bridge -s vni` indents them with 1 space. Change `bridge vni`
to match the behavior of `bridge vlan` since that second command predates
`bridge vni`.

Before:
$ bridge -s vni
dev               vni                group/remote
vxlan1            4001
                   RX: bytes 0 pkts 0 drops 0 errors 0
                   TX: bytes 0 pkts 0 drops 0 errors 0
                  4002               10.0.0.1
                   RX: bytes 0 pkts 0 drops 0 errors 0
                   TX: bytes 0 pkts 0 drops 0 errors 0
vxlan2            100
                   RX: bytes 0 pkts 0 drops 0 errors 0
                   TX: bytes 0 pkts 0 drops 0 errors 0

After:
$ bridge -s vni
dev               vni                group/remote
vxlan1            4001
                    RX: bytes 0 pkts 0 drops 0 errors 0
                    TX: bytes 0 pkts 0 drops 0 errors 0
                  4002               10.0.0.1
                    RX: bytes 0 pkts 0 drops 0 errors 0
                    TX: bytes 0 pkts 0 drops 0 errors 0
vxlan2            100
                    RX: bytes 0 pkts 0 drops 0 errors 0
                    TX: bytes 0 pkts 0 drops 0 errors 0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index e9943872..2c6d506a 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -187,8 +187,8 @@ static void print_vnifilter_entry_stats(struct rtattr *stats_attr)
 			   RTA_PAYLOAD(stats_attr), NLA_F_NESTED);
 
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s   ", "");
-	print_string(PRINT_FP, NULL, "RX: ", "");
+	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    RX: ",
+		     "");
 
 	if (stb[VNIFILTER_ENTRY_STATS_RX_BYTES]) {
 		stat = rta_getattr_u64(stb[VNIFILTER_ENTRY_STATS_RX_BYTES]);
@@ -208,8 +208,8 @@ static void print_vnifilter_entry_stats(struct rtattr *stats_attr)
 	}
 
 	print_nl();
-	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s   ", "");
-	print_string(PRINT_FP, NULL, "TX: ", "");
+	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    TX: ",
+		     "");
 
 	if (stb[VNIFILTER_ENTRY_STATS_TX_BYTES]) {
 		stat = rta_getattr_u64(stb[VNIFILTER_ENTRY_STATS_TX_BYTES]);
-- 
2.43.0


