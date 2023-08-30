Return-Path: <netdev+bounces-31422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF578D6D3
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9331C2074C
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ECE6FD1;
	Wed, 30 Aug 2023 15:06:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143096FD0
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:06:40 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2090.outbound.protection.outlook.com [40.107.13.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEA91A3
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzMG/OkZgC/o1PJDYifSp64be98jIy9L+zoAYZXz+QhnwGIvqhUTh74KMUqN2GCmoyWJpd0JE0vYCIwFPYU0cOKxCAyOmZiBEJSDofy7/i2WvpiXApbjZNBpi2REgdgyrQ446TWb956R84AH4eBJovETt+BOg+1sZWMC0EQWgkJy7Fpg53Ga4Btdcc3vEo4rpWGLZvWVSn3chcGeGGxDjmT1ZwkenW0Al2STcpxgZta/CO0Pn+STH36mWpN7jPr0Ju5gb+GAxU8AewjnyKSWg9UWsttffXsZLCT52j5reSFs0PawDHHAB1Ynr4oej1W3w4qxdj1Lo03DrRBNY3uS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDT0D+XudDiX+Fy1Qf3n7KgelNw9zMFkE2RIHKDJ3dc=;
 b=jYjec4nly/ak0TjHlp1apMXBBmwYLN7QOj6r1ehlptmNidOurm0hSTDg+yg8GOWIwsGS7cHW3ZLwm+4FX7uHt2pIoBQPOuA1W0mLYe0ymCPCtxun/FPiARY/lXF0xXNGAdIu9X3EfkgR7pynePMoRQEFcxTNhmScRWWTyE6FIWpx4bAKQZT2NzxAOxJKQeer0F87XrM+Ais+ZZ2LI2caOsioXjuMkn2Uf9jN8v/GOotW/G0BNo6BBZrah15W139WNLnQjOTmx4vE6X01yWOqE5F96pCecynYO8Cp2++U7ZNEP1cYWNuBUTbdzOIpRxOyZQlvX++DgnLGhBOs8uwslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDT0D+XudDiX+Fy1Qf3n7KgelNw9zMFkE2RIHKDJ3dc=;
 b=dW3IHphvSZsrv1AmCgGPB/iROZh6nHCJBWS+k9j2U/eANZbQ02eLG567839dxr5tlSJf7dqS5vvqtqhXc8Abq/WmVRv3KnpO9eZE5zsyQX5IhbjwSel4WDRxeslMoZFsGym/BrnhMxvVU3b5nx/pY/D4bAL/Wonjc+51EldD8alWK/tRRyLF0ymug4GkugIvjXy4SgZpeVPmogsurruBgrIBswxWkspUpeiDmxDEsaITbtKS0eMZCl3xmqzsC5tzh9qemPI90eBQLcVLqnAgtQh1i8Yg32sK8z8hPmSh9eMIIDpfmwt4KmRR8rrA4gZN0Po9VfK4Nrf1j2i/wmeisg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAXPR03MB7951.eurprd03.prod.outlook.com (2603:10a6:102:21a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 15:06:35 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 15:06:35 +0000
From: francois.michel@uclouvain.be
To:
Cc: netdev@vger.kernel.org,
	francois.michel@uclouvain.be,
	stephen@networkplumber.org,
	petrm@nvidia.com,
	dsahern@kernel.org
Subject: [PATCH iproute2-next 1/1] tc: fix typo in netem's usage string
Date: Wed, 30 Aug 2023 17:05:21 +0200
Message-ID: <20230830150531.44641-2-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830150531.44641-1-francois.michel@uclouvain.be>
References: <20230830150531.44641-1-francois.michel@uclouvain.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|PAXPR03MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 020957d7-c586-456a-5a49-08dba96ab3db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0FbRprGO4YuTJZ6g+uS05bZLD2awGPBENy7HJj+jqp0GryzY037lqvR7Y8c6KnO2SxCrDrswA2Dr0wpt8tJLN+vaof5UZusyMHo4JgH4VCNksoUZ4lrWS1VkvL9+3vhmlmtHrmOGYnCjCMZI6qCweQBglmlSBbAD85dm3MeXDvFLoqsJiKtrcKxhCjl2HcgFZ0Dq7LWWpCu9mWMM0LcTHWQbVbpDa2fTZ0S6v/nl7TlAu5hC2W+H4I9ZMlzHfgjwSnr4P7/y1WDzlr+zZT9U9xRj+iXl/VsGT4Up9jSaMDZjusXR+3s93WB/kjBYAeU+aApqDxGvZ+oRvUGA24lB2lLar3yqJR4j+hYmIP0Dn+9tnkhF0SahqjjyHGQyak+kdYJqq+PRvs8Ugiz9KXwVt30Tv3YsVcDjbj3Xydwc9NIhhH47iqOMk+X51vV/DgGboi1+TIMHsTqYzJQYJGmU7V+OF1IpEdLRkwYcn9u960nLe5uO+TOxX48JWCvJziezSTxQqO1EoKibHgM1QVHtxbXNZ8FLqG8Z5E8rTUHjR3nU3z+HabBfWmA/ADdf2VVrNhlwdh9weJKZ9wCYrxa5yvyKUiDdMtIdpmKQFu6UxGM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(109986022)(6512007)(9686003)(316002)(38100700002)(786003)(41300700001)(4326008)(66574015)(2906002)(4744005)(86362001)(5660300002)(1076003)(36756003)(2616005)(8676002)(83380400001)(8936002)(6666004)(6506007)(66476007)(6486002)(66556008)(52116002)(66946007)(478600001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFBQZy9OUEMxOWVOekttRmN5cHBHQXFObnVaaEp4TEdOR1ZWZDZ4aGdZV0t5?=
 =?utf-8?B?M1FaUlQ0dndOSmpWTG5aMjk0TVUrRndRTlQ3YXBSY2ZTVkd2bW5yZTl1dC91?=
 =?utf-8?B?RThPRXFiWFVvVVF0Zm5Hd1p1OExqQVIvS3FGRzF4SjJEL1Zwb0srOUpvbU1N?=
 =?utf-8?B?N3RteXo5MkgxQk9LWDlUaVpSNEhHb2l1QjVMZ3E0QlVXMEo0MStZUElBN3Vy?=
 =?utf-8?B?c2ZmQmRrNVQvS2F3MVlNZWRmL0Y2SlNGVFFLUTE5YklKdlhDWHNOSDFZcE40?=
 =?utf-8?B?Q1drUWYyQzVXZjJIR1l0Y1RERFJiTWk3d21uTTMzUmV3aVp4TmVkcXk0ZDBJ?=
 =?utf-8?B?aFVHaWt1TXhZcmxlQU95TEZtSW92STh1YXRiTk9wZURCUlAvaFRvNUVDcEU4?=
 =?utf-8?B?R2I0YkFsUEJzQnNCOFlpYVdyaTRhRlFwWHZMZGIrYk1qaFMzYVk5THlqNWhh?=
 =?utf-8?B?cUlMd0xiSEdiS1lXUUp6clZjNGJUdnV3R3hHb2VESVAxYVlWWkFBL1lCWU1a?=
 =?utf-8?B?TnpyeHdoNlQvdUR3OE5PREpzWHBnTjhPeWJ5cFNxbUw5amxkZ2x2T1NzTlZC?=
 =?utf-8?B?ODQ5MGdSOS9TTUJBNm5TcEwzTGVzQnRaQ3RXaER5REtVTVVhb0ZLN1piaTI0?=
 =?utf-8?B?ZzM3NTVQQnp2c3F1VjJWYUFNdHpZc013ZUVDTEtxNDhzS1d4ZllKbVFZWWtq?=
 =?utf-8?B?OHpKNmROL1BlNFpnZ2UxOUNBeDhQT3U2Z25UMll5NVRSM1J1amNTcW1Ib1lk?=
 =?utf-8?B?N2FiVTBhdkF5MUZkb2hLM0w0SFRvNGhlNjJMMTFUOGVRSnVON3ExcHpEWS91?=
 =?utf-8?B?VG5LL1QrRlQ0VldXQk9lT2c4VDBYT3puRU9WeUtKNXFkb1BIdHpyUmdjMVZw?=
 =?utf-8?B?QzJmMk1US1M2K3VhWklMV3lRczdsUTU1dk9ybk90Qm5HUlBoSnRPVHhDeC9w?=
 =?utf-8?B?bmlpQXJobG1rTktYWWVVVFFHWHBndlcrNnFGU2h5R0tFbXYrdWNMVlVCWGFZ?=
 =?utf-8?B?VDBrNDZWNTE1YjYzTFU1aThuTGVsSTZLbWtKeVJXVkk2T1ZHa25QTklNMDRu?=
 =?utf-8?B?UEZib3Z4Z3pDQzJVOVJ6eDNZQmkwR1loRmc2ZkFQTHZ2eElTQWZON3dqS1RN?=
 =?utf-8?B?N05jU3laVlk1K00xTzhYYXQvUlM1NlBDdm1tK3owL1UvYklKY0NYeW9BK3N5?=
 =?utf-8?B?MHR2cjJhbW11eGRoZ3JLU1Q2ZmdNUDg1SzBESjV6ajhYWEF1c2p2Nmg5R1Zn?=
 =?utf-8?B?TEJJSGJ4WHZwSHFtL0hQcFhxRUdHdG9aR2tzRit0N2trRi9FaXVCaER1Vldo?=
 =?utf-8?B?Kzd6UTRGTFhialJzbExkcjhMdmhwUnc1c29DWDBFSHBYOG15U0VnQndzTGNB?=
 =?utf-8?B?Qy9PYTFCU3diTnlDNlE5SkhiOUVQMk1XbXg3QkdDZGpucVJsSXVXTWhwMGN5?=
 =?utf-8?B?emgraWxTNFd0dytWOUtOVUJtd1gzZm5UREoyREdKVjdVand1QnVzVit6eEJU?=
 =?utf-8?B?ZEE5dXFLdXVXSFdSRHpUYUhOVmtRTVNIZ3Y1b0R2dFlUVUJQREFtY3hsNUQy?=
 =?utf-8?B?bG9GMTA0eXNpZlErL1cyajBYanR6L2Vma3REdk9mRkxQcG9SR3djRWp1UHkx?=
 =?utf-8?B?OWFZWmo4ZThTWSt3aGZDaFFHRFJsaHFZa1E1QXcxc3NSQ21TUUtDWFdVVG9Z?=
 =?utf-8?B?UTlMYWtFa1NNREhIMWhOUmFuaTJwOU95YUxxcGhoOGhMZEZkc1J3YVhuai9q?=
 =?utf-8?B?KzdTckZKTWZWQ2pSZVo1MG5CL2w3a0o0bEI4TS9URVR4eTljcDJPY1B2cEcr?=
 =?utf-8?B?MENWY1Q5UWlabDNSekl6ZmM4Z0lLZjlNVDNPNDQydlBmTWJzYmYveGJvMGxy?=
 =?utf-8?B?b0FhUUJLckNCVy90dG1GVEEwbzYzck40aDRkYmJrNHJQVE0wUktXL0NTVTFn?=
 =?utf-8?B?SG40aGRXN0pSWWRpT1d1ZWJVWWVsNkw2VzhRblZrOWVwY2NFRVFhSHdRODBu?=
 =?utf-8?B?TzJtZWVNZ1VpdUdvVkI3enRWeFRoMVIyV2tGVkFRSTVkb05lRkNwcGlrZnl4?=
 =?utf-8?B?KzdSY3NaS3Z4bkZORWNYRmZKdjVadFpDVmZQb09JMEFIWk5Ud3hoN3Vobmlv?=
 =?utf-8?B?TW9VRHVxd0hUSEpkeXdKWlBHakZkNCtwU05wby9UclZ6L25SaTU0RWwxMTMx?=
 =?utf-8?B?VGNYL0R6WVJiY1hVdnY5ZXp2d3llZjZ4UkdENCtORnFjY3REN2pKU3R2aUxz?=
 =?utf-8?B?VEtpM3pBdGJmLzRGemxNRU5TaElBPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 020957d7-c586-456a-5a49-08dba96ab3db
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:06:35.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYNE50OdEtkyljPFR78//JFliIb8RxHFISejjUEiNJICQivV7K20PTWWrS7r6ochTEgx1rpH6UxRbitsReHz2TdtjhZmmPe94OQopOEL0X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: François Michel <francois.michel@uclouvain.be>

Signed-off-by: François Michel <francois.michel@uclouvain.be>
---
 tc/q_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/q_netem.c b/tc/q_netem.c
index febddd49..3be647ff 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -31,7 +31,7 @@ static void explain(void)
 		"                 [ loss random PERCENT [CORRELATION]]\n"
 		"                 [ loss state P13 [P31 [P32 [P23 P14]]]\n"
 		"                 [ loss gemodel PERCENT [R [1-H [1-K]]]\n"
-		"                 [ seed SEED \n]"
+		"                 [ seed SEED ]\n"
 		"                 [ ecn ]\n"
 		"                 [ reorder PERCENT [CORRELATION] [ gap DISTANCE ]]\n"
 		"                 [ rate RATE [PACKETOVERHEAD] [CELLSIZE] [CELLOVERHEAD]]\n"
-- 
2.41.0


