Return-Path: <netdev+bounces-31594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9012C78EF23
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 16:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C077A1C208C7
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25311C81;
	Thu, 31 Aug 2023 14:02:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F811722
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 14:02:02 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on072f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA59CC
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 07:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q347pi+AAZk/KLFuyq+jkTPftBNg40N611F5YA88t/2lxWFk4DFWhWm+EOyeki9gkoh0scpRbiaFsZMosiL8YoaspAqz1UTqd2HCv0RdEZB8MvVjjn8keY3IBsSV0OvHQNhZod0fHMPsf/CD8+TJaxcRXglr2l0JeVzuwy+NqmRkckfEsX2oMoHOS6vQQIMx88CIEle+AvhD3gnn6fc/rjs+0rfL4+6HCAM8dfLzLkw51NoIwC7cyXurIJiOCXkQbASlK+VBpOThTEGVtrLONs4YccbcnMP3i1Xj0FYsZnx4KADtPzMcqEoIQH4TTs57l+h2dDDwyFffCN30lKfH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWG63L4BxylE7aK3djet3FK4p4FBVQKYRF3Uhb5uSNk=;
 b=Dz95ut3rt+/ArNPN7k6dKC6tpP1eOiw4XmMClij6d6eIaCk4vASAQIpK9owgwDaHodZpFElcNtG5YreNLFqOiFItwyqXzssfVFLSttkDngOcA9eIwA7ju3JuhgvLrPRMCNhAO0F0shyVklIiCz2p3nJ+Q6j41JZtvMYU0BG/f0ckhgKrLoJC5D56sz2g/u2GyRg+3eh14a+jyY9fjsqirxi/E3wE0JycjEqPiknwylMTHmpIqxIepMfNORyOQHQKyJDsb8kCsk5PgcJyzU3HVgVZc6VeC0s9mNmIlzHs18ncwRip8r7kQ7aCLxNG3ElwJlrpyQuTqCZomJcc3AkgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWG63L4BxylE7aK3djet3FK4p4FBVQKYRF3Uhb5uSNk=;
 b=JIMWb5/izeSIS2Rx6S1Du911H9qeeu5IWsFVqkHRWc92Vk5aAHvsSyS9EjS47J2jxGZ7rXSUcDsKSg2dp/AfWYU/KVhOQ1SJxNfuFnK0um8cCmiBYO7hcRXTVEWsx6r5hetTm46xSUkocucBS420rUiAYX1JMvUWoyI4rsOkxDSIGLa3jihNiLy9qvRAE+f4psrHjyIU4xDjWIQ0uJTXl9nDMRcKiAy9pCvQ4mbkkmrCjlUBbSBhuH1JI9F3WAfGMpf5RYB2J1if2XwgLfvt9qAINg+vH2E5xGZF1YaGH2giZGMHBrdZdMbfHveEuTHtEgO0UjG75CXhT57hLP3lLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by DB4PR03MB10106.eurprd03.prod.outlook.com (2603:10a6:10:3fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 14:01:54 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 14:01:54 +0000
From: francois.michel@uclouvain.be
To:
Cc: netdev@vger.kernel.org,
	francois.michel@uclouvain.be,
	stephen@networkplumber.org,
	petrm@nvidia.com,
	dsahern@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH iproute2-next] tc: fix several typos in netem's usage string
Date: Thu, 31 Aug 2023 16:01:32 +0200
Message-ID: <20230831140135.56528-1-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|DB4PR03MB10106:EE_
X-MS-Office365-Filtering-Correlation-Id: 5727165b-a50b-48ee-7411-08dbaa2ad50b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s/ENGCNyHRpqKznAYtaMNjaGzVOPJQSSaH2JaY127lj3PFnKP6MavrB1Uk6M1iANFfqRPqkjHwazc8Hbl+pIdCPNF8Qd8+9pYbXOqaEay6xvaCERRocXy6tZNgrfWCyIdccg/v+Ou/jR7vrQpY/dSdrA8tkfiKMD9spaFqxpLexn/bXmTxoBSDPxMH4M58Wye6yQ2v45p57O/8I5zRJhQhPlCjhrmgcmKydHnL1GSHYz3oMg697zypahtkmL7Mngep2+GyJlIO+PKlm3Wyg/NPEGvyo4WddSvzSfZlY8c9r7QixNqMK7/UmAs476SdrEStCGZXSpGL8WTV9h2ofDile9qalRV2P0dwSO0t6O8RqgeQfbDkFWudQvQKdrTKy2HG4Gy2Db2wfDM7dpHrvtedMyfKNPamB+H3mUI8nqClwKVxGFDazv/57av1XVJZtag4/pEaBtFcqSkhwcOMg+Xe6uZFdAyjwfE5w4fJto1JHRSqvIo5fEGIonOxYJFRpff+mFkT8c41XgxUJDSNeEv0+ooGHoJral+vyzzbevcTfdedS4UU17eAs3wkg9L3SRYJ9v/7kTTpTf/4M8w3f4Pxpf9p1a8l9kR9Nswdu9RRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(109986022)(451199024)(1800799009)(186009)(1076003)(9686003)(6512007)(52116002)(6506007)(5660300002)(6486002)(6666004)(38100700002)(4326008)(8936002)(8676002)(478600001)(83380400001)(86362001)(2616005)(66574015)(66946007)(2906002)(786003)(316002)(66476007)(66556008)(36756003)(41300700001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0F3OFU2Nkp0SzErOTRicGlnS3NlQW1rQ2FXRi9MVWlzblFkd3VRbzhNTjkr?=
 =?utf-8?B?VStqd1VDVFp6YlVTMXY0UXBsMG9pRDhFK01idVpyN3FUUWN4ZHdQRTVpemsw?=
 =?utf-8?B?OVFZMXVCMmNOTXlMZDNJUTF3ZXBKMDExYnZHcElQWXdKZmlDTWJXMGFDQWtR?=
 =?utf-8?B?UHFEVmt4elJIcml0Z05RbzY2bUhhMVlvMlk5c09zZFduYkMwdkYwWlF3VGdS?=
 =?utf-8?B?Q3ZUakdBUzdsbEFCb3NhakRSOCttaDhpRTVmaXhwNEtHc3pLMjIya3MwbG96?=
 =?utf-8?B?NndNYUN4OTlNRWpSSERnQTBVNktvUm5mZFYvTHY5M2ZVZ0NtN0ZvL0V4eEtt?=
 =?utf-8?B?RkxPT0IyR0ZSbzJwckFNSEJSaEhSSDBsR0I4bDlhUGJxZW4xdUxzRFJFTzlL?=
 =?utf-8?B?UUxXR2FWSVlmdy9mN3FOYy9NSTRGQkFBUGtkU2V1Ulo3ZW1Ub09CUEd2b2lQ?=
 =?utf-8?B?K3lOZjVaa2o0eGsvNkwrcXQrWTJ2cXhHV0wyNXdUL1RLWEQ3TUxqalJaa3Bt?=
 =?utf-8?B?YWZVbjgwY0loWHJCWE5ENk8yWGdYRWZYQnpscGVMbUlvMWhPaWRFSnc3YU1K?=
 =?utf-8?B?ZmxTY0kvWk8xRC9zUm9GOEpUYlo3ekNsUEt0Z2xJY2xxN3Zza2x0Q00zZUZN?=
 =?utf-8?B?QVN4ZlFZRFMvTGoyUVFkZGVoWUVvVjBjck1sVnZ5NUxZSG5PV21obFhaSnBV?=
 =?utf-8?B?ejlJOVNxV3lYM0lPTmp0eXZ2bnRvMTVOQ0ZqWjA2eWNUcHlKVVVjaC8rTXls?=
 =?utf-8?B?eitzU0lYa0paN2hEVUVwSzQ3ZlRvSUg0bzZYckVFTXQ5ZWxMTHdYVTVsaTZs?=
 =?utf-8?B?NHpZK3JpOEZRa2FJTkttK0U5Z3l1TGZHOTZ3UmJ5Z0o3NXpJNHBibzM1ZnlE?=
 =?utf-8?B?QVRCZnZDbHZZdmhVS2NocURLZzNEUFRGb2hpNk9SeVZ1SEZyMTlmTVlFVGpV?=
 =?utf-8?B?aHVtWjVGazhvb0JyM05BQ1QrRTByWUVzaldLaWUyVHhsNXFWUU9iRTRZaHFs?=
 =?utf-8?B?V21SYXZDQjNMQURPMkN1K1A2S2Z5Nkh2cnlibkp4UWs0Q1RsbktkaXRwL0NU?=
 =?utf-8?B?Vnl6ZFB1ZGZ4UERHVlN0eWlaMzMvNW92dUtxOCtzdzh1aXZacVNvNTRNQ1Ba?=
 =?utf-8?B?QXkvTHdVYkFTRzdCM2RIMEVpYU4xeUc5cWRzSW1MU3pmSE0vVWhGQUVoMXVT?=
 =?utf-8?B?UHBvajVwYnVkYVhMSGoxa2R3L3hyQURJOS9GTjVoTk1YUE5XQkJVSDh4Z1Zn?=
 =?utf-8?B?K3FlTlpaM3NoaWVsRkVBN2ljT0t3NktTRWZhZlVKeFE2SjZpYm8ydG84bWsr?=
 =?utf-8?B?QThweVprV0RUTmN0d1IwbzIyNmdHWGRGNGhIVTFoTE5lUU9pRGhDSzZqZ0dP?=
 =?utf-8?B?bWZTZGprQVU0RVFpOVJWaXRlVFVpQ05OZW5adVZCdlhENnloQ1ZCajBFUitR?=
 =?utf-8?B?OW5tQ2FacVJuRVhxUXlvN1VJYW42elQyRUdTZ0UzNXlJeHBubFpYVUlNeDRM?=
 =?utf-8?B?b0s2bzhWSVhNeEFIZzFCZ24wcVBUdjhraU11bmZIdlhBNFZwbVJRVzBoQldT?=
 =?utf-8?B?a2hid3BMVk1QZ2d0V2JTMHFnVXdDR2lHTEdwZndDd3QrOWdHc3NIWml0RTRP?=
 =?utf-8?B?M1EyU3kzTW13SENLZFEzMTdZUmYvRjd0cXVPcjYxTVUvTGJBSC9OYkRRS0Rj?=
 =?utf-8?B?SWwzbnVtK0kyYWVuRVBnb1BqOVhyV1ZvTSt3ZWtRencwdWtxNndBWUppOWpC?=
 =?utf-8?B?emsxNFJGL08zbk4wTFkvbkxwOEN4UmRjOEg0aUdrc3BCZDNKbi93OEhmd05l?=
 =?utf-8?B?MWhaZG1Sa2RKVWlRSzFRUXNYMXZPcFkwVDF5TUdnWkl4QUNzaW1zY1Z2Tkg5?=
 =?utf-8?B?VklmM3h4MjR3cHo3WGxCdGg5ZTVpQ0FiVXZobUtFSTVHTlFEL1VQdVJYdTV4?=
 =?utf-8?B?NTFhSDdES1NQQTNDd2k2Znc3RnZKUEhOYk80ZDlaNG0zbTRmUEdEVlc3Z2Jy?=
 =?utf-8?B?ang0cmhRb0RZQ0loZ2IyZUx6MzlWMEJ6YVk0elVUaEphUENaWCtFNGU0allM?=
 =?utf-8?B?U3l1VFNIdkt5OStrMUJ2UWtYL29zOWV1WnZsbWZ3dTl3NkxSZS9Xei9Ld1NF?=
 =?utf-8?B?SnNVTm5TRXRjSkt3UWsrWFlEaWUvZmh6eFFEZjlSbXpZTkV6SUJjRzhrVzg1?=
 =?utf-8?B?YUdtTUQ4VkdId09kT3p6NWEwejNCY2NvL05BZEJkMHU0anFsUTJ0elNwUjdq?=
 =?utf-8?B?WGlJTGU3RWMzcDNRdEdUMEhiN1hBPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 5727165b-a50b-48ee-7411-08dbaa2ad50b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:01:54.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOzoJcFC3d+f8P439F6NxrGAyyzTILY36BOvHJUB53KKsQH0M7RXfIKxqWd0+FIP+cBRzRlAvYZBPDSzTRSWK/JitJ07YrWtW1dDgZet3To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB10106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: François Michel <francois.michel@uclouvain.be>

Add missing brackets and surround brackets by single spaces
in the netem usage string.
Also state the P14 argument as optional.

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 tc/q_netem.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tc/q_netem.c b/tc/q_netem.c
index 3be647ff..5d5aad80 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -24,20 +24,20 @@ static void explain(void)
 {
 	fprintf(stderr,
 		"Usage: ... netem [ limit PACKETS ]\n"
-		"                 [ delay TIME [ JITTER [CORRELATION]]]\n"
+		"                 [ delay TIME [ JITTER [ CORRELATION ] ] ]\n"
 		"                 [ distribution {uniform|normal|pareto|paretonormal} ]\n"
-		"                 [ corrupt PERCENT [CORRELATION]]\n"
-		"                 [ duplicate PERCENT [CORRELATION]]\n"
-		"                 [ loss random PERCENT [CORRELATION]]\n"
-		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
-		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"
+		"                 [ corrupt PERCENT [ CORRELATION ] ]\n"
+		"                 [ duplicate PERCENT [ CORRELATION ] ]\n"
+		"                 [ loss random PERCENT [ CORRELATION ] ]\n"
+		"                 [ loss state P13 [ P31 [ P32 [ P23 [ P14 ] ] ] ] ]\n"
+		"                 [ loss gemodel PERCENT [ R [ 1-H [ 1-K ] ] ] ]\n"
 		"                 [ seed SEED ]\n"
 		"                 [ ecn ]\n"
-		"                 [ reorder PERCENT [CORRELATION] [ gap DISTANCE ]]\n"
-		"                 [ rate RATE [PACKETOVERHEAD] [CELLSIZE] [CELLOVERHEAD]]\n"
-		"                 [ slot MIN_DELAY [MAX_DELAY] [packets MAX_PACKETS] [bytes MAX_BYTES]]\n"
+		"                 [ reorder PERCENT [ CORRELATION ] [ gap DISTANCE ] ]\n"
+		"                 [ rate RATE [ PACKETOVERHEAD ] [ CELLSIZE ] [ CELLOVERHEAD ] ]\n"
+		"                 [ slot MIN_DELAY [ MAX_DELAY ] [ packets MAX_PACKETS ] [ bytes MAX_BYTES ] ]\n"
 		"                 [ slot distribution {uniform|normal|pareto|paretonormal|custom}\n"
-		"                   DELAY JITTER [packets MAX_PACKETS] [bytes MAX_BYTES]]\n");
+		"                   DELAY JITTER [ packets MAX_PACKETS ] [ bytes MAX_BYTES ] ]\n");
 }
 
 static void explain1(const char *arg)

base-commit: 865dd3ab1580092221c73317a844ee65f032c9e8
-- 
2.41.0


