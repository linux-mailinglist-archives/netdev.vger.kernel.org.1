Return-Path: <netdev+bounces-115280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DCB945BAA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1024282229
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E91DC472;
	Fri,  2 Aug 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="uYOVnnKF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2138.outbound.protection.outlook.com [40.107.237.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E81DB45F
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592804; cv=fail; b=Q2kJm1lnww9AAYIXV2UGBBMLawTp6tLKUuN7+vO7GsNgO71EtHX56ep+EowQp6TLzY4yaqXUQ+7RP3HWncXQVmjRiFjb5dtgxTMmsm4nXh0pcC2VGzWtkf5mR9wD6Rf90PZQwWIV63iEne/mC9VPJqksnD/F7frP5Xe1iD9gCJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592804; c=relaxed/simple;
	bh=c0qMvGYxX6h6OS4E9U3LiMcla1HBgRdSl506sewjY1A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ks6m+48w9a8hc5m8l3FxqXLn/ynVU/hRAAARzyKlg7x+iflyfmId9qoGmVWSK+/L6oHcmS9R2EztZOTmGA+YFfjFIp2tGzEOLeNaMMKx2QDGuDVtJgpjB5SsRDLQbh+BlzOuQIAATGbLfkTytdqP70JngY2dhV4mzFP8vggVBSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=uYOVnnKF; arc=fail smtp.client-ip=40.107.237.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQRlviQGEHO30hR5fRCB649TzAibmgGapwD6HyhmG/T6n2HuNxDQZCx3rD2r+sQDqAEQMjILT969IVV2lFEe5lK2e34uVlLlvmEtPfqf0rDoz/zyUmEQmSAaHSiAaJdepmAEwqT7Q5rxqOscWhph/24w3fgOL/zMacDnvG+XjMB7rW7k5okeYWhhrsa8nAhbjiCaGtHc5YPWhF/DuhrmSWnLs+xKxkW5/Fv0+cs70i/RQoyyeVjL4XYzlbnc0Pv+gyTzrsnb3nDvhEzfCasSUqj+6lgzjhArc+JOUtGwYBIjOzR6zvUxMespjUu+82NBHJHUSeMipCYVRoXHc1xSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21LaJpDRfe81lEypjeY6j/SGgTtdEcAvbqPF5cMLZVg=;
 b=PRLlWsN5NIJB1AG5lv84VMrmpdMixqAlYId8ewSoSWw9PHmpwfz8SLBhdnigB6vuVtWMPNMwDTExE1orESjPGZ1cAYuB9K9IItui6j2rehPdkDrcOwm0d1N/R2sZMzB/k4J8vnHE579H5nwc7Q9LRF1rRdHJ8v+sVIW4Oh2MSx9tQ97oRQmZnV4L4770MEO8n2u+McVM4i5b7DRONB7GwWGOXpuaFsqvZ9t+qL1QUraj3Yu0jOTho7cDuSoqiqgzAV5vXGXUMb000qHWBLPs+czR0sdqCtlzRXn0iH5hU55JnHKqpRZllI4jiSDFgQKMTx2XJfJm3q3c+o/+geDTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21LaJpDRfe81lEypjeY6j/SGgTtdEcAvbqPF5cMLZVg=;
 b=uYOVnnKFiURv+yCGOOQgaMH2vZwDwYYXe283N9aA1OPIj+yhah/rMpfLg5dyICUEaCgOEes+w6Y4QhSXHg37ER+STr94ANJKlnVOnhG+k9zGOSIDLqOsmb9T9TNE8QF1Kz2IZFVGroax5VbFy0cutUfcfwhMUJoRzSnlhIfOCLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DS1PR13MB7169.namprd13.prod.outlook.com (2603:10b6:8:215::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 09:59:58 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 09:59:58 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com,
	Kyle Xu <zhenbing.xu@corigine.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	oss-drivers@corigine.com
Subject: [RFC net-next 0/3] add vDPA driver for nfp devices
Date: Fri,  2 Aug 2024 11:59:28 +0200
Message-Id: <20240802095931.24376-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DS1PR13MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f19ece-e6c1-40ef-1f83-08dcb2d9de11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0ZVM1BidCs0ZlRPbS9hR2hTS0NMRFVlYng4VlpoQWRXYnlrM21qUC9aLzBo?=
 =?utf-8?B?QUlDcVNiaXcreGNTeis1YlF5cGQ3S3dSKzl6WFk4NmRZdmFpWXkwbCtTY0xa?=
 =?utf-8?B?MG94WEl6L3EvQllFQVhRWlZsUmNFcm55eHE4ckQvbXdFUGU4OGNVRFp4b0tp?=
 =?utf-8?B?VWU2cVUxNCt2ajVFU1JNNkhmM1JwQTBMc2ZVS09yNGw1VjU4YTRWQnUzU2o5?=
 =?utf-8?B?ZnVFbjFJVml3dzE4WDcrNFJFUVkwVzRSbElLbXAxeVNYUmVybEE2LzQzcXdp?=
 =?utf-8?B?Wkx3ZTh4Nm1sbUxBMVNUOE5WNTl4ZE94YXFRQlV0VmpKck9lWWROZ1VaVkV0?=
 =?utf-8?B?NTc3Z0J5NGdnUytrdTRkQUZTSUdVNGxJbnptOTZtRGcxVy9MaDhrck9TYTJL?=
 =?utf-8?B?ZkdyNTRVTXlSbk9XRHNZTWNMcCt2S0RtYmVWOTF2Z2RxS2x5TjFGNEZEQUNi?=
 =?utf-8?B?MUZlZ2wwSERqOHA3dUZ5TFFIL0FwQkpDaVEyVTVKanlTTjB6bk92ZHNZM0s3?=
 =?utf-8?B?T1Z1emZieEhwQ3F3RVRXZ2tOcWxqbmdUTmlJbkQ4dU5Xck5OVW55QTdrTG1D?=
 =?utf-8?B?aTdxRXRQeFVyNzNSYS94VlY0dmdpaFJDTW9PV1dTMzdCQ3lPNytlMkdOeFlQ?=
 =?utf-8?B?UUdkelRUdjVTei9HR1FXYTZLS2tQeUlPVGx3bEpiT0x4UEdFL0x6bFVZVnhH?=
 =?utf-8?B?RzJJUHhTVE42SXBCNXdJVmFRTHVtaVJxbGNHTjBBcUdpQUJOZzlraVh6dTlQ?=
 =?utf-8?B?WDZIeHhWcFpxUnh4cWF4Z3FURjVRTFlQc0krMFZDMmdvcnhFMlgxdzFORlNo?=
 =?utf-8?B?V1RsQWtkeHkwS1hlR1dGTy9XQjZpMThtdUVFc2duODROK1VVYTAzYW52RlFT?=
 =?utf-8?B?VWJGZUFzUkEzeGJHZFAybUlMSnJxNVZFZXZIZHZDY2ZHZC9SR29OUlFlbVJ0?=
 =?utf-8?B?V2NUTkJ5YnJBZ1ZheFhyR1FMOEErV3lmUkhXVXRsNzZIVkJmZUJSbDJQd0Vw?=
 =?utf-8?B?cW8rNmM5SmoyWDNlaVA1ZFN1aFd5UGk1VWZDZTdlODg1UHhXTHQ5UGJTd1c0?=
 =?utf-8?B?S0hHYTR5OGc5czEvaUZQZ0VvN1hoRVdscm53bjBDUEpQVTBaNXN2SlI2T3J4?=
 =?utf-8?B?UitPVjR1WEw5ekZjdDJtQTdsOEFqczhrOXNkSXRJeTM2anhFZ3VCQU0xaWUr?=
 =?utf-8?B?cWExeVhDVFJrREQrd0FrMnQwUEZwbXp6NUg2RWhBZ1NYZEJyenNraHFCdEdh?=
 =?utf-8?B?dGFsRXhqTTZySzZHUysxaFhlVFhlZlRMay9MTjlBUWlKR3BYLzMra0k3Zk5L?=
 =?utf-8?B?ZU4rTk9XTExoMnFBbWxRZUtORFkrUmxwQ1J5NjA1TThndWRlVDZxeWdUdFRZ?=
 =?utf-8?B?VllVZmVNUHdQbVZ5bGtuSHNja3FmT0MxYkdDMkdiOTBTSVNHdUM1Yk1UOVRU?=
 =?utf-8?B?ck1ReXZkYUtLMjlsWXVJdk4wdDlLY3gxR05ac0xXWFNvZExyUWlQY3dpUHJC?=
 =?utf-8?B?TURsNHVzdG00dkVieldyYjhiQnFieTZaWmtCenlTMG1qRU16MkRxdlhNNTZV?=
 =?utf-8?B?OU91MWRmUWNvN1U3SkI1NVYydU12UjFnQVprQXcwTW5Nd0hvTGpNZGRWRlpF?=
 =?utf-8?B?MWxxZnduSmRZSVVNNWJVb3k1N3pBUlZpb2lYa3JGVmJvejRucHpvRnJ3dFcy?=
 =?utf-8?B?dmYvemxVWW04amhqbVFqUVd1R3pNRHVSUzI2UEJhQ1Fqcm4zVHJBQjVJK0xF?=
 =?utf-8?B?SVJ3UzRkaHoxc3A2b3d5NW5kSEx6VHpacTJSblFwZnptT1JaWERKK1krV2Iw?=
 =?utf-8?B?UUJKVVpOeU9rUXd0dVJZR3VvTHU1QTI5MnFxZzgyTS8ySSsxVmdHeStlRDNr?=
 =?utf-8?B?LzIyZFBXM1B3clRxOWpNYlN2eGVLQW54dVhBTW04LzFmV2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVhDREp2a1RZNlpNZC9IdllySy9HSGhxUlUwVy9GUHhGdi9Pc2c5NE5XdlRJ?=
 =?utf-8?B?aUMzd3YzbEgvbEVFbDd0OWRySnN5MncwUjVjQkRPcFRleVFsQ0J4QXNZTWNN?=
 =?utf-8?B?YUViNFFUSkhBV1lpMmo0MklQSnlvbmhSZWpOMjRUTkE4dURBS2t6STdCQ3B4?=
 =?utf-8?B?Nmk4Q3IvK0pzc0x6cU9rRlRCWmxHNTRTVUpZNUV6TlZWRVAzNC9XZGNPejJQ?=
 =?utf-8?B?dGp0ZnFOR3VrY1IyVVo3ak1neGhLM1JQYng4ZnFPVEtQMENkeU9DWTZzY3Rp?=
 =?utf-8?B?b2RWZDZmY3h0YUhieWxJbWxFNXhaRnVSLy9iNURmb0RzR1YrOWxnRENqb3pD?=
 =?utf-8?B?ZjJPSHZlYldWMEU3Rkg3M2FndHJITjNieGEvWWpMUlJVRUw1d1E0ZUN1REJY?=
 =?utf-8?B?cXppYnF4c2hsWlpDRGhSQVVGZ3BMMUFyU3Y5MThPMjJ0NWswRERpYSszT3Ux?=
 =?utf-8?B?WHpSQWIyNm9Yc3orSEh3M2ZtcCtvSWNwRU9lZFVCRjQxeFRaWkNLKzFMWGtw?=
 =?utf-8?B?MXNvMVhacS8wR0IxOGhYaDVUancyaXk1TjFNNUJrVVlFZzEwUnBvY2RmTU8w?=
 =?utf-8?B?enRJbkZLYkpZeU45RENFeExZcC9rejE3TVdYQmFRVDQ4Y1RPRm1YTlEydFp6?=
 =?utf-8?B?OUFEZlRGT09jMFIyQWMzK3RxeFE3WXh6MFcvNzVRZW1DQ1JrZXNLbnUrUWQv?=
 =?utf-8?B?WlpRZUZ3U2ExcEJKMG5BcmNQRW45bVJ1MlBYTmNHK1oxZVhHTzdjWU9TdFV0?=
 =?utf-8?B?U0JtaC84NnZFcm5jTWxWeXhUeURNelpkbktpS1hReCthSmdUa3BvMHpIUVpx?=
 =?utf-8?B?UTFmd2xZNklvb2pTd001WEUwM0QyU3hTK0FnRGtnbm1NbWg5c01CNmwyK2ZR?=
 =?utf-8?B?eDNteCtrbitKQTRXVFk4Z3IxaXkrbmFNQ2lYd21waHBJOXlpSnZkdlFMRHov?=
 =?utf-8?B?dHlGQkNCVEFnMVFzVFltRC9hQVM5SWNEQSttelF5d0R2dVFGV1dlS3RPT3M4?=
 =?utf-8?B?aTdpSUxNcFR5cWpMQXJZS3dDK1UrcFdML0VxQ0ljWG91djB1YUcrWVptRWov?=
 =?utf-8?B?ME9SWk9YMHNrYXNEUVA3bUJiY2ZOMGJldlI2Nzdwa3ZWRzZxWVVtazZHM3pH?=
 =?utf-8?B?V2xYZlVuVkZrOFJxNDRpRlNKaTVSaU1aeGdqbllCWUp5REpnM2x4V3ZrbVZp?=
 =?utf-8?B?NWZEczFYMW5TTzcwTDNWL21BN1VtcVVMM0JxVGQ2Q2x2UjNZa3J5cWpoRGx5?=
 =?utf-8?B?aG1YV1lUV0Y5Q0tna25rN2htYTNwK2Y2T0ZQSis4VjNDWjJaZVdNMThVRisz?=
 =?utf-8?B?TWIwbG15OEFFNUJqVVBiUnIzQ2JXU2ZWcjgwU083cGw4WDltVUEzdHByZk5X?=
 =?utf-8?B?WHEyM2pvdmxyS21obmUwVGh1akIwSTFlQ3BmcFVyMzRnOW5HZ29CRmU1cXBp?=
 =?utf-8?B?ZnE5ZHN2YXdtU29pL2dqNjVIZVp5MDlXMk9nZHlWdGx1UHI0WlB3eGxZMk5D?=
 =?utf-8?B?V1UzUE5jaDB1aGFOZmhFZWpkMEVzS0VwR042blM0TmZURHdNT1lwNGlGcUpm?=
 =?utf-8?B?V09PZDBwZDEwMWpSWUcyQ1RCclN6SkVid1pRWnI2SlZWUi9nZlB3eUlvNklP?=
 =?utf-8?B?RDVzc0oyaVBiMFhyVWsrUGl4cXFNYzlDemRwZERXVk1QY1JtYklrQTdsd2RH?=
 =?utf-8?B?eUlRb0JGdlR3a1cyS2QzS2FQTUE2T1ovZ0Vud3NxWDBZVG5SUE5JYTkvLzQw?=
 =?utf-8?B?WVpDOWFnd3RNNksyTVFCVWxqNFZ0Q2l3NVlRUzdCMXRIdlVZOUQySVpiaXFk?=
 =?utf-8?B?UVNsY25UckFkK1dhbm1pVXR4ZEZoOS9EcTNEVWZlUXlKaG1HTlFmWlJ2ODNn?=
 =?utf-8?B?c2ltMndrSVVnd3Jub3NhSTd4YXRiZ2syNW5ZK3dDRHl2KzZTZDFZMUpDelBE?=
 =?utf-8?B?blprT2tvWFp6SzM4eE12QS9Fc2JFdzB5dTlTZ3EySmQ4RXllamdVNXVaMkNq?=
 =?utf-8?B?eWthQVZucWhHUnB2bGJRZG00d2ZHWU9tZWRxdFNaY3BMZ3IwRHFjYmcyZVVI?=
 =?utf-8?B?WnFRWDNvRXBaSkpOSUlwUDNMYy9IREQ3djNFdExxOU9vMDExbU5zSzJ0c0l6?=
 =?utf-8?B?bW9CK3NaNzVKNXNrTU9KNTl1aTNoMmJ0RnV3RitKczF4VjcrQzVDWWtKeUtW?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f19ece-e6c1-40ef-1f83-08dcb2d9de11
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 09:59:58.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FetzMww4uPHD+kuCN3O5WmB/45iYTTGvDuFNnvYdmp1bdaHfvfHJL2ymjZKkcn9hesoW9yjpRYWF7E2iQS+kBAYFRpwPYpgwKJrHs2puinI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB7169

This is the first foray into upstreaming a vDPA driver for the nfp.
Submitting it as RFC initially, since this is touching a new component,
not sure if there are potentially any new-to-us requirements this needs
to fulfill. We are hoping that this is already in a state to
resubmit as PATCH, depending on the feedback this receives.

This series starts out by adding the "enable_vnet" parameter to
nfp_devlink, to allow setting the device mode.

Next the auxiliary bus driver is added, and the VF probe functions are
updated to probe the correct driver, based on the 'enable_vnet' setting.

Lastly the nfp_vDPA driver is added, initialising resources and adding
callbacks in accordance to the kernel vDPA framework.

Kyle Xu (3):
  nfp: add new devlink "enable_vnet" generic device param
  nfp: initialize NFP VF device according to enable_vnet configuration
  drivers/vdpa: add NFP devices vDPA driver

 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/netronome/Kconfig        |   1 +
 .../ethernet/netronome/nfp/devlink_param.c    |  49 ++
 drivers/net/ethernet/netronome/nfp/nfp_main.h |   3 +
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |  16 +
 .../ethernet/netronome/nfp/nfp_net_common.c   |   3 +
 .../net/ethernet/netronome/nfp/nfp_net_ctrl.h |   3 +
 .../net/ethernet/netronome/nfp/nfp_net_main.c |  10 +
 .../ethernet/netronome/nfp/nfp_netvf_main.c   | 264 ++++--
 drivers/vdpa/Kconfig                          |  10 +
 drivers/vdpa/Makefile                         |   1 +
 drivers/vdpa/netronome/Makefile               |   5 +
 drivers/vdpa/netronome/nfp_vdpa_main.c        | 821 ++++++++++++++++++
 13 files changed, 1127 insertions(+), 60 deletions(-)
 create mode 100644 drivers/vdpa/netronome/Makefile
 create mode 100644 drivers/vdpa/netronome/nfp_vdpa_main.c

-- 
2.34.1


