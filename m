Return-Path: <netdev+bounces-29641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64D784340
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD491C20AC7
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F21CA10;
	Tue, 22 Aug 2023 14:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003B7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:06:49 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on20731.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe13::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF654E60
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1yy3yP7pHqMnbjmvOsewoP3F7utk4ws57DHMQa3mfsunJ4PIedC1OK1csqEKX6NJe9R7jIZNQNf0LMtfhtgJedoVKr0yk9rMN/z8Mqzn7D7NEBt2Sbwp7vpmJQlexJw1qANV4fx+PVRAy81N7FcRSOkTMyzx1zM7HkCl2PTuvniYv06M/EOk6ba2etMsRYO4ELHvpUD2etQpnl8cQxYtDndyFyXCG+ornq7vOpcxeZ92rknHlAvklzKNbK5s7IBpEhIdMu3yZCht7ukk8ac9V9HYeN2kkDaPNRZrSM3Gey0tlGgBzGd2k/ssE5ZSbYl4o66GMFer65tXldQ8uOiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRkSuePn8+QLhy5YKx7h4qlDOuzYQfzFtHTDwMtT1Ak=;
 b=j/yj/6pGdja/rpXZC85dlGKOpFRwOVAfFynIPdwcOmmsGew/7V1Qsn3btJ6dDmlfvq/mIvY+tnWWHStxLOf5y6O0Wu7CJahSwnH45D4sDWKB4ONSPctvNnPGHOOp9IapdT4BiyZiAFcFjtyNo/eGyRICzvXt8SPJmWerDjs5wrxfMmYDPIaxo7L034foxSSXaGQkLzDp4DTqoKFFZjgx2Gk18oUC6zPAuI+iXc3fCo4uqV4tIj/i029ehWMpkqGuFnLMU73zvVaK9//Eh3CeSlPRkKqLVvTAiM6cX9cgi18A5Bid4jJCKul/letpXxuV+A3r7ruPlas1p54bSK1xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRkSuePn8+QLhy5YKx7h4qlDOuzYQfzFtHTDwMtT1Ak=;
 b=BwHeyuZQtg9OvtbqixANDAjWZ2a6hRnNuCwU5xbmy/HqqikADThNxIccc70K+dSOPZuaIBVt3V3xObpv8kCu4K5LoTfTX1DiCCL5Ree2cLVp4mgOv55YYZUWXPn+Qjf/7QZmNztekQHO3IgUgWaMCsEuFeNjP2hEZhpVMYzw8czEfnSae67gV7srD4Gm17yeHgLM7+a6A/RYxpOewuttbfQEJEHMrYljyKMPX0our0wyrP3RoKvQgsOdeq0YqtqyF+38QWNdd9W8jQVu8kGJJe6mCKG4UwYamUsvXQ2CVPqVIBKVmEtxgmHzIEYskhZ70BmlAPDfBJ4vD2NeHfMXHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by DU0PR03MB8161.eurprd03.prod.outlook.com (2603:10a6:10:350::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 14:04:46 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:04:46 +0000
From: francois.michel@uclouvain.be
To:
Cc: netdev@vger.kernel.org,
	stephen@networkplumber.org,
	Francois Michel <francois.michel@uclouvain.be>
Subject: [PATCH iproute2-next 2/2] man: tc-netem: add section for specifying the netem seed
Date: Tue, 22 Aug 2023 16:04:03 +0200
Message-ID: <20230822140417.44504-3-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822140417.44504-1-francois.michel@uclouvain.be>
References: <20230822140417.44504-1-francois.michel@uclouvain.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0429.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d::9) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|DU0PR03MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 763e1722-cdc9-4ad4-7b31-08dba318be19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BeMzWg/mRRN+Ftf/irRtY17zIR89nPZ3QvXZUPwEnbWROo/Y96k37rrAVUvgiAHUWJvjvlHzlsM+gRRlA6j6g31a/N/O/E6a6S2Qnpr3e4mbr1Sl3QeTVvx9T9lrF5v/kZc1TDFqK/6AlvyqUPSMT+NY3lyk4iGZh/Dd/ECYd+bOl2Kn7FSKP9mmHGr22fIDtFAZ4Hyk5dc+zF1xU975Q26K8UvLl7NhDTfIZT/+xV1Nujw/P5TzjUVr6MVcOa8cirT/RyLSv+ISrWsqFxi06yh1SM88CDD7xTKBQIw4B4QocPdffb7ZZrJn4ZlKPhjNEXp9aQWdhcf66O5Wn6CgOLc3b0y0eLWtHjRuPuuLp6wJXmy8kJQSSSMFPRNqiSi4PHxpq3n8ruOFbPnle48ZOMQGpS2W2M/wB77QckzNHZ+eTnY0AAkEmYuPABxTrstH3OK+BJJ+Y1zwBeqMBFhpOR9Whj1e1FPDlYUQ80sCGStZYLqxrUoQSNC5yVBLfGt0PxyjjqiEiwAd3tsEGDhmyQo8ObqMSisQcg3Slbqh1Lx1zxhq99LvSBQRoa1r51ktr3M3dsSwVRBl3aIFMIEQhSgVMsNGTp3OQEINwGe8TGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(109986022)(66476007)(786003)(66556008)(6512007)(316002)(66946007)(9686003)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(52116002)(6486002)(6506007)(83380400001)(66574015)(2906002)(86362001)(5660300002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjdkMkZhUzVYdFN1My9YSG54Y3k5alluN2w1K3I0Q2lkV0lVQjN3aEZEYVFu?=
 =?utf-8?B?SnArZ3VOQVZHSlE3aVpwQW1sZWlCR1ltc1d6VE94elB5ZEJsR2JFbjV4SHA4?=
 =?utf-8?B?aDlCbzV0YzNaaitXUUFyUjBMZWplNHljMEZ6N3pjYjhrbEdOcGtVdkhCLzYv?=
 =?utf-8?B?RnorRnY2RC9EdnQ4VnRSWVN5d0owenRHeDBWUytzVjVDM3ZJL3NRazk0R0lC?=
 =?utf-8?B?L2VwMTdtbVNGbU02RnJJNVZreGJ4U1BodXBrZjFsbkZLTmxNc2szaTlWR2Zu?=
 =?utf-8?B?QU41RCs3VnR3VE4wQWNKb0VnVG54em1mQ1ZiYk5sMkdHcmJLbUxja2hVUlc5?=
 =?utf-8?B?bUtFMjNYUEpFVldMam5LZ2diL25DV2lneTJIRno1U2NoaXFacWZ6dkc3cTdU?=
 =?utf-8?B?RG1mZEU2WTZXWCtRN0l2NWdZd29vSkh0eW91WkNsV0M2RTNEQmljRVJZMWh1?=
 =?utf-8?B?OXBncFRIU0xCamZnU2J4Yi9kQURNdVhmMkpqNG1UaUtwTjVvSWhzU2NXeGli?=
 =?utf-8?B?OUY1ZnpqZHZoQWxPdTIzam1QdFBDN2paSkdXbWFnK0t1ZjV4b3M1QWwzYUFx?=
 =?utf-8?B?dzRHVHhxRlRVcnllalpCTHBPU0xUTVAzNVZuOFI3NXF1d3NpL0NCY0ptQlp4?=
 =?utf-8?B?SGdqckJJM0RIUjhPTXlEUE1jMXpoWFBRTS9vdmZNUGVDQ0d0ZnQwZVRMYnpn?=
 =?utf-8?B?NzRrQ0pmTXlFLzJ2M05PQ0pENG9LWFErNWZMNWdhYTNpOFlYWUFvTGlVWGlu?=
 =?utf-8?B?UkMvbXkrVXkrTXV4U2l3dnpKdzU5MVlpeUVWWUhlVkdBSmtuRGsvSytFS1VB?=
 =?utf-8?B?ckpRM3BzdE1FVm9XdzdGZjNYaFplZm1vMGQyYUhORXhJREJLY01xbGkwd3Vl?=
 =?utf-8?B?Z0hod0NCUktJTnBMRnFJaDFFeUpDYjB3cUdKbHh1aDhEUExhS0xQMjMxaGg4?=
 =?utf-8?B?Qk5HV3NKaEE2c2xZZ1pyVnRHSE5mMVUveUlHUDMybTFjSEIwano0K25rb0VO?=
 =?utf-8?B?dStCVmtGZXNJNkhlb1NVeWNmMTduRWg3NTB5anpJL1hBZVlzWTdiZWRoSWVp?=
 =?utf-8?B?OW5hbk9TR3gzZVd1eVVqdGx6SEV6SzVldUY3NEpoN2VVUUhZTzlMN1diSGFk?=
 =?utf-8?B?L1YvMGxrRzRtbVJHMWZhRHUvR0t1d0d1UWhMVS9KeXE1TFJYNmVtaGk0VURX?=
 =?utf-8?B?S1F2TFFUTkE5WXlHdUxxZHJpNWRMMHdVMnFvZzhEZzdhYlZQa1BNNVZnbkIy?=
 =?utf-8?B?Nm5OOU1vRUxvSnk4QThYUC9VaXh0UUI2d3VxWmRvWjd5N0dCQ0lVM2FoYWxB?=
 =?utf-8?B?cEdFdm4yOXdTMkZSNHJaSEp4RFlMUTlITWlMZzJyWVVya0hwWFcrU1JONTl1?=
 =?utf-8?B?OEo0ZHNlUHd4Y3J6c3VKeGNiYkdraEhXYURnODVOVUdheDZZSUZBaWVWbVRu?=
 =?utf-8?B?Q2d3UDl3a1pFRkw0WXh3aThjMFBldi80Sm5aQVdManMrbFhBN1BtWGNJTUJH?=
 =?utf-8?B?SE1BeHFZVXBWamsyZWFGcHFZUTZIM2ZFZFdkMGdVVTROQ3Ivb1ppNjc0NEFa?=
 =?utf-8?B?TE5sMVJPVjZwYnBvZW04aTZUUkJxbE1VbG1qOUxIdUJmVEZzblV6RitkRWU4?=
 =?utf-8?B?dHlEb0lzK0RJTnY4bE9XN0Y4aWhuT3FFU1dGTFdwanVTd3BjaFM4S2N4ZnpB?=
 =?utf-8?B?STlrRkZydXJsR3FOZ21PbWZXRUtSN25DZHBrZi9YaVBrSmxHanhvZEZSRUNj?=
 =?utf-8?B?QTg1K3JrWENOQ1VWREtJbDYyVS9IRWtETytuY01HckhSRkdCaUZiR29NVGhu?=
 =?utf-8?B?QTVGT2I2a0xBbnhic0Jkc0ZjNXp6K0d2NDNlOGJza1d4bllHOEJuckh5VFpO?=
 =?utf-8?B?QWdNQnpkRUdlRnVOaWJad0R5TDZpSmszUzRiSzU1dGhJcFUrbkkyTGdMVCs0?=
 =?utf-8?B?elowazJhdGxiTEpuUnVrSWtGV3dWWWRwYlk4Q0cxS01CTGUyM0VoZVRJMHBn?=
 =?utf-8?B?NGFsVnp0d2RuL3EzU2d3L1RnZWw1cjd0ek5lVHlGc0dIaVE1SkxnbUlTK29i?=
 =?utf-8?B?OFBpT2NwNU84KzBvOWdiaVladld6M2FJUC9CWFhza0IwbTUwb3BHT1V2Ymph?=
 =?utf-8?B?N1BiQjNVVEE5YStWZlltaTJjdXgvc1dUazJzVzJkcWpzQkNwZ0lsZDJ5azVj?=
 =?utf-8?B?blI3N0pjM29vM05hTzFCMlRWdG16T01wL1ZYVzg4RVYvbDdYMS96Mno4Qlh1?=
 =?utf-8?B?MVY4RGZWL25CVFRDc1lxcUJDNHRRPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 763e1722-cdc9-4ad4-7b31-08dba318be19
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:04:46.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZZjGBplokyBYU0g+t4qeBhZgNUMrnCYodaap4gA5M/PZe1o956NIPdbVJEh+rIVLr8hR5pf14ez4JU4FU5XP4d4DKuuU0PrmP9EFiiH1V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: François Michel <francois.michel@uclouvain.be>

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 man/man8/tc-netem.8 | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/man/man8/tc-netem.8 b/man/man8/tc-netem.8
index bc7947da..a4cc0d61 100644
--- a/man/man8/tc-netem.8
+++ b/man/man8/tc-netem.8
@@ -9,7 +9,7 @@ netem \- Network Emulator
 
 .IR OPTIONS " := [ " LIMIT " ] [ " DELAY " ] [ " LOSS \
 " ] [ " CORRUPT " ] [ " DUPLICATION " ] [ " REORDERING " ] [ " RATE \
-" ] [ " SLOT " ]"
+" ] [ " SLOT " ] [ " SEED " ]"
 
 .IR LIMIT " := "
 .B limit
@@ -64,6 +64,10 @@ netem \- Network Emulator
 .BR bytes
 .IR BYTES " ]"
 
+.IR SEED " := "
+.B seed
+.I VALUE
+
 .SH DESCRIPTION
 The
 .B netem
@@ -240,6 +244,11 @@ It is possible to combine slotting with a rate, in which case complex behaviors
 where either the rate, or the slot limits on bytes or packets per slot, govern
 the actual delivered rate.
 
+.TP
+.BI seed " VALUE"
+Specifies a seed to guide and reproduce the randomly generated
+loss or corruption events.
+
 .SH LIMITATIONS
 Netem is limited by the timer granularity in the kernel.
 Rate and delay maybe impacted by clock interrupts.
-- 
2.41.0


