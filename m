Return-Path: <netdev+bounces-31421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E478D6D2
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955301C2081B
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D76FBE;
	Wed, 30 Aug 2023 15:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B323BD
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:06:40 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2090.outbound.protection.outlook.com [40.107.13.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5391A2
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 08:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZnatN6wIQsxpvCm2/zQyWulzksP2/4Oflu33fqzt+7lw540qOVinW4I4Cceg898HuY2v//2aisYmMXVkQnexLUOqM33hIXQpkieXgEm/L8NkiFe9P5mZqd0KLz+Dk1P1maGMWGfGuYf45LTe05NPiBxz91BgVpCWMzlFiQHwdINbj9S3QZppSsKDf/q729W6abg+kngqLvLcoVsmUjq61tnC2koj3eIChyeXO7MJPnA7d9Lb9r+u4pErcL/+kuuI+nwcNaMQyo+e70EkoHek5qG51WAHJK1VqYCHKNLKVootMZ6Zkl7U7OTH9Vu85yxqFmLBr/RXwGZMEG0ENbFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t741ClAxi1xNAJJX2Y9OYvUVOj+jS89N84MKh/W9ogY=;
 b=MuHwMg4NR8mfiW7fy8l/3/RT7qjhPmHOPBJVOaW6gKzrhdsoMtpWQIQucyagNFGhrp2ERxciEPel2JFRNlbJUU7vNR2WeJqvTFka55sCdUTXUZWUT73rLVo2PG3a9yVlWjntYh0xKtwpRFQrbDVQbwef2uzJMXontBZkxVWpASOrWFLNNuCj9bB8/vYWwbgiZTzBrr9sDqa4m4bUpXqVFB51UZcMF8BQWkfRcp9lZHtpKRYxJ3eeNUrSOHPQMukbbeWXPQH6hESLfhxw8rRkUlUsXv89qO82DlUh03RVS2IwkYt1SBe3tkASKhhBykG7x/cWKe7f3z9EFRAxJ6qZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t741ClAxi1xNAJJX2Y9OYvUVOj+jS89N84MKh/W9ogY=;
 b=uuzfV37HPZHsyGtSNzaRo5g79F6o0LG5u3VOMwiacUEjQaRdMKPk8cHmD/4QlEab3izlntAsAGchAqTV4Ei6rW3ywrTHKN1ehzcWHaYisdhseOpAeeub/LI8c9KuMYf/i/b6/EExdsY2mJ0d+8M6T2EmpBsdqGYFEd1ZM9bRDqVqITo+U6q/YqWrU1q+I5eaU02Pn4iT1YJ8KPh4WGd9ngfd3YBZPaxCy/yjUbm+pOnaboXT6EmRyZVRvydJwyAhKrZItHZpxZYCvCTTNf3mKBwmno/vf8qWnmkb6MyQMvHr9zprz5rZZXzG9ePnF+Bx1IT8DGNMYO66qtEEVKr2IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAXPR03MB7951.eurprd03.prod.outlook.com (2603:10a6:102:21a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 15:06:34 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::b3b9:9dc1:b4b0:ffe2%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 15:06:34 +0000
From: francois.michel@uclouvain.be
To:
Cc: netdev@vger.kernel.org,
	francois.michel@uclouvain.be,
	stephen@networkplumber.org,
	petrm@nvidia.com,
	dsahern@kernel.org
Subject: [PATCH iproute2-next 0/1] tc: fix typo in netem's usage string
Date: Wed, 30 Aug 2023 17:05:20 +0200
Message-ID: <20230830150531.44641-1-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
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
X-MS-Office365-Filtering-Correlation-Id: 550977fd-5ba9-4672-243b-08dba96ab383
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Um2pai976aUDTrPp7ISmnJjvOZM+V9V3Xv9qYOFGugSFN9Hz2mxBm+YvTEmsYAv+GhdWD2OcF3eIQm5bZy7wnmnxFc9Eoe17gWfIs0WKCrmVVBCVBw5VGMJzrt/xSrXMtQTibDJEn4YScC/MR8cXAeFXhT1KHmoSUnHSYb/a5FCl++ubJBIXjNGEnIfyDRR3u6ilCQBN9GrhLALHy7Nfo9H2xFn/3XyyCeILlSV3jZJS515PqDupzDhF7ygkrmrQMb8tmzknupPxzH1O3VcDo6RlEg6onZxDMLD1+Q58vOlWfuR1F5frY0xgyOsESOSJwTFFFDlw1X87yw0B8qTkkik5snAFoGcBZyuFMOu2aQULyD9jyHlr8f1Ud4RQ9UA+TK7abmWTD4ub+Cf0yEmN2ExnsNX+5xxl/bydFurhUN778MkCBIKc+CaDIe/a4JXuWCh9YE6ZqZ1iBdgVvHxv1AH/JawO7NwkUfJJ2oE0geJtVKOv+X5OUMn1e/ETchYkW5ed+h3gEjYmFDz6IG+KdYDSMfnkKcD9Lw5/BGBFEO1TorDaK5eHlRUF/itzz1ckfOVpCSUsMGakLWF7pUB0Meo28DLecVKDGMw07DNqk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(109986022)(6512007)(9686003)(316002)(38100700002)(786003)(41300700001)(4326008)(66574015)(558084003)(2906002)(86362001)(5660300002)(1076003)(36756003)(2616005)(8676002)(83380400001)(8936002)(6666004)(6506007)(66476007)(6486002)(66556008)(52116002)(66946007)(478600001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE5QWXVFRExCUzRLYUZrQmFMdTZLZ3M2TjJRNi9yK0hURGdIZVk1bzQzdm96?=
 =?utf-8?B?dk9VQTNUV01QZGRJT2tjZzZ2aG1SWHZGeDE2bHpDSWg5V0J4UlI4UEE5cjR6?=
 =?utf-8?B?N09Ocm9FOW5DeDJPcG1sQVV1K2VpRGtqdENSWDgrWXpmSHMrNG9VWHpwYXhl?=
 =?utf-8?B?YzRjTjVpRmVkc3NLVmpsdHFlYlJmWGZnQnU0RzlzMGZpazJVUWFnb3VhTm9p?=
 =?utf-8?B?R1hSc2svMTg5M3BuK0JPQkRoclhQLytxRENPK0xEa3dUZEpzaHpma091bWhF?=
 =?utf-8?B?aVhuNGlERjF4R2hLbFIzQ29mektzTkR2NVF6bE1QdlUwUzMraHhrSThKUmhX?=
 =?utf-8?B?SEcvWDY0L0NsOG9JdW5rZUt6Y3B3STVPWjBWWnRSYS9hNm45VEEzR1Nlam1F?=
 =?utf-8?B?bGdWdW1JSURta0hMMkE3SlZsajhKUVlsRktDdGhoUG1VYTM3anFkKzZ6Y2xo?=
 =?utf-8?B?bWcvWm40NmRQa3Q1OW9kU0xCKzQ1eStkL2tkVU8yOWpvOVd6TldmeWJEampa?=
 =?utf-8?B?NDhWcGFYS3Y2OXlRWHg1bW9zZVkraTFJWWl3NlBlV1Fpejk0NHVsb25MVEQ0?=
 =?utf-8?B?cnlNT3FBOGljd08zYUtiSVdPMmRBd2IrY0RXaGl2L2UyQ3gzVmk1UVZFTUxs?=
 =?utf-8?B?T3V3dnVTa1Y4dm5BTm5yMFk4cUl2b3lUT0xTLzZtY3JhYmRTNVNRY0JZL0hj?=
 =?utf-8?B?aGZZRTdHYVcxOW82WXlWRWppL3FqNUpocFVLYng5T3V3V2w4YW1SbUZFYUUx?=
 =?utf-8?B?dlVNc0RuSkJGTmFjMXpMZkhRZGZuUVBSdVhNa1RLMHN6RW9VVjVIaUNib0pl?=
 =?utf-8?B?eCtxakJvTUpwSk5jZUVwRjhhRWk3dEpDOWJXTWFFcE5zekVLMGJib29MVEpZ?=
 =?utf-8?B?eGtTMXNYc25ac1B6enMyOFZhV0lqTnhyM2tFZ2c0cTlTd1JjeUFlSzAxZEg4?=
 =?utf-8?B?bFNNR1drOHBzT0JPczUvVFZlL0dBbmh2REN5Ni9oUmN2Y1dlbUtPSzNPWFRp?=
 =?utf-8?B?STVBeTNaV0VRMlA5YitJQnVzOGphZGVXNXE5UjRUSUM4Ti9SWHdHYWVMdTIx?=
 =?utf-8?B?RjBVemRMUHI2bmMrZGVuUzF4VkhDYUY4OTBQQWNNSm9lRm9HV0NqZXBCYWNY?=
 =?utf-8?B?SXFMMEM0SnhmdkZ1VDRmS0Rram04eGQ5MzROZkhUa3B5YzhrK2VoUjlkQi9S?=
 =?utf-8?B?MWlrbWU4MVo5TWRybUlQeWZSNElaOHhsQ1VKN0NCcEZTKzYvcEVWYTNTV1Iw?=
 =?utf-8?B?RGhCZXhSYmJ3SkxoZ2M1bTc5YWExUCtIN0d0T240eHRaTE52cjZ1RCswZVJX?=
 =?utf-8?B?Um81OUVjT1hnaFJVem5SekdRT0RCbGxxckZaSklYTUJEVU5jWlRYL1VVWmcx?=
 =?utf-8?B?T0dBb0tWZmhKQ1VkUWQ2QXVBd2tMczdCYUxTWTFINkRPTU1CQzFSaWZJRHZJ?=
 =?utf-8?B?UGxVVHpBZE44dFpDMDd2QXFwc2pGaWNMRTFKeHFaM3pacFRPaHdLWUhWTXJP?=
 =?utf-8?B?aEhZcXgzUjU3U0w3UEszZVBNNHhJQTZQOUkwZFRpYTZ2eFlsc3RRNU9WMG9m?=
 =?utf-8?B?cmVTenFkTWM3N2xiVFNkYnNNajBqbzVJZU96alRDa3llNUk1eitFanhYRkhW?=
 =?utf-8?B?b1JNZ0tMa2xCTXhWdHdMeGxjeG5HVmhuRSt3cVVVcS9laWdpRUNHblI1T2FZ?=
 =?utf-8?B?ZVdiUWtaa3dJazdJRHo3SEpoMmlPeTdpWHAyWXBPSEZtZmdvWnVhZ0dUcUpG?=
 =?utf-8?B?Q3J2ajNkYWtIZ1M1M2FyMkplVzl0SWYvcVUzYTM1ZVBlMmcxMlN5Q3dBNk1D?=
 =?utf-8?B?MlAwUjA4R1lDRkU1ZjMwdEZvdW9YMHMxTm9hUFFwOVMxQVBadExZanBEK3BL?=
 =?utf-8?B?SWdmSzZocWNvZmRVRUFlUFFNL3dpdUlRczE0RFhiUmxsRUhGakxscmd1TGk2?=
 =?utf-8?B?MTJOYnFtT2Y2LzFJdzVHTTQ0U0FUS2dqYmswc2MyNlBNUkkrVEgrWEc2amVN?=
 =?utf-8?B?SWtxdWdnT3grS3NhSkpKbWx4Y0trZ0k2dTVIaGtLRkRqWXpDMHREOTQrOHNy?=
 =?utf-8?B?c3c0ckhLblIvSHRYTkJ6akl4NDdpRWhIR1ZRS1pHdkwrUzFkWkFwSU03czV1?=
 =?utf-8?B?Z1pjK2pSUWltR2I5SlpNeFFIalVlRU1aQ3NiTFhZUVNKeW9FaEpmSjBjMEtK?=
 =?utf-8?B?UWx1VURxMTVyN0lkRjhnUWNod2VWblRyVitHbnpyVFhyanVIV3NOUmdNaUhY?=
 =?utf-8?B?UEhoQVp1MlVSNWFqRzZxK2wzMzNRPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 550977fd-5ba9-4672-243b-08dba96ab383
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:06:34.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H65O4NTIhy7q2iMEw6PppEDrNrs+GhDnLG0X7fJRL9VCuxfXxAb8ajLLtdOIWpZyOD/CZon4kYU/UgFPjKTKWUhnz60T1ympmKU2Lu3HvaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: François Michel <francois.michel@uclouvain.be>

Fixes a misplaced newline in netem's usage string.

François Michel (1):
  tc: fix typo in netem's usage string

 tc/q_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: a79e2b2e546584b2879cb9fedd42b7fec5cc8c61
-- 
2.41.0


