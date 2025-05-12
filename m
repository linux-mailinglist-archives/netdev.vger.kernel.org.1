Return-Path: <netdev+bounces-189609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785CFAB2D0F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD463BB6DE
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B3220E6ED;
	Mon, 12 May 2025 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="rHnqG32i";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="UE6xHzEJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75D20DD51;
	Mon, 12 May 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013305; cv=fail; b=njipegHrCNvf45b6lhUr6rivvsImj3zHcziu0OJWjYbmHJv7UptWw3GUASbmztYJzAaAObJ4gQMadiVMiXKSDDVopMAma0KNZ3NOKwe5HnmbWz+cFRIbUuk94eZ+SqETiScMpj+W2KCPIo/o1lsl9smtAIWZW9/eHofA05248Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013305; c=relaxed/simple;
	bh=dAKWjc1lp0N+4UoGb8D/DAdkichT0/NtezYZCn+Pnzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/GQWqjCfW4VH2AW+XmHweqL3ZAhTdq5XMK41VKIFLXh34YqHrgnlWsSUqd7ghfqZ+cc9sbAfRyKXS5U/rpwqrB4oGNTu8V76cHB7/dSOHnJzYimlOD1re3QOaeWxY5Eof5iAwu119BczaDQGoV15qMZI2FEgahjOnc3p5HJk2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=rHnqG32i; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=UE6xHzEJ; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMe1Ru027700;
	Sun, 11 May 2025 20:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=mzwLE/RoXF6S94UGYe2XD8Gl0bdLPmQo5X+hh2M9HfY=; b=rHnqG32iUT4r
	9Wu8VxciI8qoJ2RQzYfucTFIgdXJDDFiSIbi+/Yk2gmDYjUSqWdgy69GyBGWgr1m
	iIdTSOCGdbe39UPh+BTRpBkWsMv8/ir5ZyZVLF6p45TLkf+qX8ClwAw/69ZBKuMq
	0qRsAgjIXUdbdv538xFaIPasgAZ/8Zn6RH82EN3iReZ9Pczb74ZpQ3yorc6vekLA
	6ia+1ZwZ8ka/x2R5JfAw9IsSWiw3waP5qKZiUwurXC7twrn/hXJA2hSZvk3H9DPC
	R9F2qErpUo1Qma88dMZ00TTPV7yvuQhirapLO4r6AkKdmOV7YAHEcOQIF2MBSCuz
	+c5ZXx4QiQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw9-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGjcFxc4Wa5NFVoWxQfU7po18tlsx1dtD6WTQWiPwLcJaaGFQi0An+2FeMwxitcYOrniLf4rzGRL5h3C7Hv3mRDDkwR/S2hNDuIGi13zfYdDdB4l6YpvmbuwGDTJAio4sTb1Gbvl2HRj3461Klpvo+JCOgCClLJm/FYySLcQhM7PI4wJWbq/M4JnYoSc0lxFgFZ30QeRzdnETrLIaR/Wk1wG0kc/kr/f7DcHVa75G6Zxx9PEM4OO1paoLgqMCV5ZzB+YlRCaIWmEjZrGrpYj8c5prb0RkkGKqPAa3qDHvDwzNzcQ1TVzPGMwoqkOwiZzt4CCw2uQ+OQGhPIZs4RjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzwLE/RoXF6S94UGYe2XD8Gl0bdLPmQo5X+hh2M9HfY=;
 b=ZkCpdkJZeHbi7HvOmOzcfwKKWcs+U+09X8gheDFNY8OdnuG6Wtj4PSUlReKqZfVakVxaej0WQPuwdgj8Pnyf0g9PAiIRMu/QmuTqKfq7wytHFxLaUFC5daVw+VJouz7+qmEU854k3G4YpaAPG9xEu5Zud/kme9ksLunRCmpkQPm7ySIWrLLUH/JNxTNWMnLuR1psKcFR8wDetnd5mRnqKn0RGLx0VgAM1xgw9xykSc/rypGbRP+0veG30abHwz81ktqHXso40KDr41IMptFjhki10WAQYPMWU1I6qZZ9Ry4c+s8GXyCzQBwQQoUil8taw8jB5eVM38rEBhTjhZdSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzwLE/RoXF6S94UGYe2XD8Gl0bdLPmQo5X+hh2M9HfY=;
 b=UE6xHzEJsaofjf/giU2gK5Oj7VufRfRnnloO1RcwUIwj+Is/TD5+ARGCzO5WeXvIZ9HYsYiOs84SimSl//9xmJfmmtplUuLHvhpXylMZyc0aH9E4etMwm5ZhNHt0kfhpqJzmbDEzKJj4B+zrJyBUYLnGU1SUSE3XxZMEv0fF4uw=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 01:28:07 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:07 +0000
From: =?UTF-8?q?Damien=20Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Silicon Labs Kernel Team <linux-devel@silabs.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC net-next 13/15] dt-bindings: net: cpc: add silabs,cpc-spi.yaml
Date: Sun, 11 May 2025 21:27:46 -0400
Message-ID: <20250512012748.79749-14-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: c672eb6a-1857-4520-df6f-08dd90f43fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXN0M2xadWRFZGRsU1ZtanJMQjBEcVBmaEk1SC9kWUtVQ0FVdWZoR0Zna3Jk?=
 =?utf-8?B?Tkx2TGNKek5hNXhQZ1JMbFZTVGZWcmJRaXhxWHZocEhkRE1aRVhTWTZPTVc4?=
 =?utf-8?B?WDQrWnJ6R09TQnQvZEtINXdIS1ZDVUtXWFNUL284dnRTajQxNEZuRFF1cDc3?=
 =?utf-8?B?NTZ2b1FoZExldEg5KzdpeEJWblNTME05SHBHQUtsc2RjU0Rqbzdzbm1RcVZi?=
 =?utf-8?B?UFhPRU5qNktDMWdnbHJoczJURExQYWs2ZTVRcXBNVVBkbGNKWU9GdEJVTmZv?=
 =?utf-8?B?TEFwb1ptWXdNMW9lN0RrN3FsS1Q1cnlHV0NDVVo2VXpaYjhOWW04MW0rblN4?=
 =?utf-8?B?QVVZbDh0bzkxY3c0WWpFbVAwRGVmTGM2VjE3d0cvNFBNUkZhMkNOVW4vck1O?=
 =?utf-8?B?dGxTckRIVk8zMmtYRy9sdkxwcC9aTVZmR0IwYlNFclJHUHkzYzl6b2FSRGw5?=
 =?utf-8?B?czBHOUI5STJZOE9mbXcza3EycHdWbGpBK2xnNzUwcm1QdVRXcUJ6bjgzOXU0?=
 =?utf-8?B?M1dNajlDb2VrdGxyc2U5bmlXOWo2R2pRaDRxWFJtOENPa212YzM5WGJmUG1k?=
 =?utf-8?B?L0lrKzlta3JCZnFIYnNYZVFCV0VlL0NEUU95cnVsSXRId3dSTnJmMEk2RTBJ?=
 =?utf-8?B?b3hFUGY4N1lCYW1OUnI4UXMxd1BzOGoxUVJIMWRXdlI3cW42VDdlTzJqMjgz?=
 =?utf-8?B?VXlibGp4NlRjeWhwYU5Zc1AyNHQ3QUJHQ0pOWjA4MEhRQXFPUURaR0F2aGFo?=
 =?utf-8?B?b2h0OUFIMmRqRW5jTXhIeDR3WHMzbkhLSThtbGFsaGlmcDBNZDVsUVEyaDFE?=
 =?utf-8?B?U0NVRHdhcHc2c3pNNEpneDlhdzdBSE9COVhhM1lMcmtEbGc4Lys3NGRUWWd4?=
 =?utf-8?B?NjMvUU8yZ2loSUlQdVVCcmZET0ZMMlJPQXJPYUhWeHNHdWdLa1czU3FFeDVG?=
 =?utf-8?B?cEd5UWk3dEE4dHBqVFlPcFBGTzNFK3RpbktXUmxDUEFxK0RmNmtEU1Y5aVFK?=
 =?utf-8?B?eHN4VHFoVkNwTkZ6N0pIamt5dnhyZnNVUDRGaXM1VmNNYWZIUDBiWTFvd0th?=
 =?utf-8?B?THdwckJWd0xJTlk5MDYvL3dvT0YwdCtKMlM0UFRQQVR3bGRqMzIxbFkyVUdn?=
 =?utf-8?B?b0ZvMXo4SEVKT0kwcERrOTROQmZoUE9jR0h0VXV5bStHNzJlN1FJWlJReTBv?=
 =?utf-8?B?NDMvckV2bnFhYW1DdXM2QUtDZHVROXdJaVArSXkyRHpRYnc1VkNOTnFYSGI2?=
 =?utf-8?B?NUVvbHVpMmxHQTZIU2Vsd0pOZTJ5dzdOMW1yVFUrVkR6WVd1QTVVZzNlbFV6?=
 =?utf-8?B?K0NzVkMyR1Qyb2dnY0lTWjc3OFBtbDFFdVJITW5YSjdYbHU5T3BrS3l6bCt2?=
 =?utf-8?B?WWhrcDAxU3NPby9FT090cGVJeDJJUTNxNzhtL1doSVBWL2NTSVhtM2pKZ1Rk?=
 =?utf-8?B?dVFZTmVKZm5PWFJCOXl5ZmVNb0NOQU5Mbm50Q2drNkZPWUNpYkMzVE1nd292?=
 =?utf-8?B?RkpSZSt5QkN1bHVncGFNb0ZaQXNjNjhsOHowZWNsSUUwSmVYNEpJVWFiV3NQ?=
 =?utf-8?B?ZFprWmRSMGlqZnBWejBkeWFGREJZY0sxVmdHRmhMaEVwNTlLQTgvZ0lLMTVi?=
 =?utf-8?B?eVF6MFRsSjI3N0hzVHU2cmkrSEk2NTBSYk92VmF1bXc3L09oUU03WW9XUXVs?=
 =?utf-8?B?Vm00VWJkM09hcDhYWGhuSTBMZW16Wko1UWlpVXFwYUVhb2tjNE1lVHRwaE1p?=
 =?utf-8?B?dWxtOXlZYVFMOExua1NNaUVJclhMTzk0ZVRvQmdXckd3S1FqaUsxb1ZjKzVJ?=
 =?utf-8?B?K3B1Zk9pSjY3dFlWbzhrQU9CcitLNUkzNlNLcVVzZDJBOGZMZjVXdkhwbTlm?=
 =?utf-8?B?Y1cwUktpMVprWmptTkVuMEh3SVBrb01ubUN6SE1uS2t2S0FnRCtCZjhoUkRD?=
 =?utf-8?Q?LadlKfb5g6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUpQZnBXNlF6L2trYXhsRmF4dVA1RENRNUp1MGdya0tMazBLU3ZVZW84eVlQ?=
 =?utf-8?B?ZGt6b2dEaTJuVlJ5TE4rVTRjY0ZBR1BUcVVyc2RFSlREVDdBNHEvZkFUNkJE?=
 =?utf-8?B?Nzh2ZkcrejJUVnk2b0t6U3A3SWhFbFdLMlpUTTF6MVZwaGZtNmN5czlVNERG?=
 =?utf-8?B?Zk8xYWpSREtLVnMzUnJlUVUya1dSTml1Rlc3b20xU3FrNE42VGlaYll1OFBh?=
 =?utf-8?B?dk1aVlQ0Z1ZJTS9KN01vK3R2eFRBczlYMWtaQy9FeFpoVUtqTWwvS2xqU3dz?=
 =?utf-8?B?ZHBQWlJQS2I0VjNMUXlJdS8yYlhwTWVieGk4TW9nK0tiSHVjT2tHTWpibVlp?=
 =?utf-8?B?eXlkNnZtMTNVWVBRYTdVdHhabCtxZUlvMXEvQXU0RVpCenZEeVcrNWU3elJL?=
 =?utf-8?B?dWZJYnIxOWxMd0xXZE43dzd2S0VxRCs0MDVyWEtLZlg1TTNZNmQyeTF6ZE4y?=
 =?utf-8?B?Y0h5VlFJT0dCN0dIRWtaNHpZWmdHQkptS2g4Q2Zua1RnNktIMHAxODdFTjVn?=
 =?utf-8?B?N21sZ280S0RBdTdHUmZFMm1EdG0xUHl6a1pUbktFSGQzdStvbXBTUy9CM3Vz?=
 =?utf-8?B?WUc3SnJBaTNIL1RDdWR3emY5czRUSWxteGVVUGw4cjFpQjFDU2M2NkdDUHBB?=
 =?utf-8?B?OHdrbFJjU1BsdFNqVVNzdG5BR2V5b2dKVmQxaVlpdGMxdWtUd3YxNVRSTlJM?=
 =?utf-8?B?dWsxbFRvSXFzU2tHZ2dPNk1Hb0FLTTFlYWRLQXBJazY5dVVSc2dNVDdaeXJC?=
 =?utf-8?B?L1pZY0prdUljT3NSM3liWkpsS2NCaGFMTXd2Ty85VllEdE5sbFVFbjFmV1hT?=
 =?utf-8?B?emNsaEMyWld3U0pkK05TQ1Z4VVZONVhWUTVVYldMSUxLWlphSGNpak5FK2Nn?=
 =?utf-8?B?YjBFdmpmTURtM2lyUnhEODBhcm9oNTBmNXN0TXFqSVNBNVladUNNbDlxUFUz?=
 =?utf-8?B?UjBaczluQWlWZlhsbktwUHBzRER3bW9GRFJtZ3lTY1RjanBMQlVQVFRSSW5G?=
 =?utf-8?B?NTRvT3ptdmNzSlRCWHYyZkJsNkl2MTNtVmpmRzZVSGdWKy9GOTJIcFQ2aCt2?=
 =?utf-8?B?dWh1VzVaMVhvQW9xR1gwVldlK2szeWdKRFo4TEZrQUIraGpMOS81UjlVVVpY?=
 =?utf-8?B?d1NuZFVpeXJFMlQ5UlJnbjJjZzFseER6NllDc3NSbHRjNXpYV0twc1VoTlY1?=
 =?utf-8?B?ZGxpWG01cWR5NlJHd3pXSUFHSW4yTnFkb2JTRTFqOEtERTJVL1hROWp5ekFa?=
 =?utf-8?B?NUhTa1o4VWZKNTIyd2VkWEhXSEJsdXA4TU4rbUxNQTNZL2xUMFZFTUtIdGFO?=
 =?utf-8?B?V0dodlFsWFoxcE10d2tFVlQ3MDRNaWh1aWlaVENmZ1JISWRDZ1VseURNdjdn?=
 =?utf-8?B?Tk4yTldaYWJiRG5JM0F5QVdOdVNHZ1RzVHlWWXNrTTV1TWZLdzBmUStFblhx?=
 =?utf-8?B?S2hud3ZGUWZjUUxzM2daY2U0bjZyWUt0akhDVVhyeU1TYk5XeVZtZXJ4YXB0?=
 =?utf-8?B?bUdKeUFHRStOWEFxZWJ5QitmL1lxTnUwNjI2d0dxMmpsdTZiaURGcnBXWnoy?=
 =?utf-8?B?UHN5eUY0cVJTY2U1S2NhYXFyZVlxOXpoamRQcXhWdE9CbzYreTlMekEzYXU3?=
 =?utf-8?B?MzF6eXY0YVpaVkpkQW5VSE1aU0llWGlrcGpUUFBwOWhheTBhNGlJa3N5b0pz?=
 =?utf-8?B?NUtvQ3F1Zk1VcXFrQXJTdnd6VHhmRjIxaE4yT2QxanhLdVFYbHAvamZVQ1RP?=
 =?utf-8?B?VFBpNGZNT2RpbnBUdUVkcDAzWVFNNGw5aU44N1hlMWM5QnplVklVeVVOK29E?=
 =?utf-8?B?aFkrVHBPb0xwckk4MFdINlM0RTFhSkh3SzQ5K1VEOUNpV2VJREpKQjVJblJu?=
 =?utf-8?B?WSt5SDZIZ1RUT0Y1WW5OaTMvUlVhbVFZR0tncDZpMnpjQTE4K0hSVWZKaWJn?=
 =?utf-8?B?NFg1V1d4L3R0aEFUWEh5RXA1c3paeGNYUnVyS2pORVdpWXN1bXFuM2w5Vndx?=
 =?utf-8?B?U213SFp2T0k2S05QV0xMeXZKdVFFTHhENFBZUjRwWDZZWWNlOVlUKzltZGd6?=
 =?utf-8?B?U241WlFkWVl1d01rL1JLYkMzZC9kWTFVeUNoaStrYXF3V1RBVmRQQUd2RkI1?=
 =?utf-8?Q?nQRt+yz2lvMmYztb2KBPLuy8X?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c672eb6a-1857-4520-df6f-08dd90f43fbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:07.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XU8Xwofv1qsSksqt5HIX8pBf52z4K3qfL3kgQTIIcoLgjDmx5w12ketE9QrDF4kU5cTEBVVrqtmOJCbWSiY5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-Proofpoint-GUID: Pb8nVnCeIUgcu_DQuRxBFQOuONtgEqnU
X-Proofpoint-ORIG-GUID: Pb8nVnCeIUgcu_DQuRxBFQOuONtgEqnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX2RmBqwW70Wwi K7lYPFkTsHBM+NuYebHh+WmJ0LIWm5qejXbkaxAsyJkvvRvyBbotWc+2GTPlYp6jRzlOdulPmzt /VqHEDL7M7hHBkxW4aOPEFrC1seYvpIN7oF5Gc2BU8rzsHHmgLEJ5lpwzWADhnSdkD2A6IcShsv
 muo2XQTJ+c+91Le8rvfjOVs/6cDvj4CgY3ndbHkJVL7DFIeuM+JWHn/Ao7IvfbaBamLSrcBKJY1 +kXK7We19k0CdvtWL19hfsM/VM5CN3gQn6noM7b0xK4YCI2uGQZxkmgOgD4ci2QwmQMWe9QYEhL 4Pnfq3PIGvbI32rbr30YBp3cemK1gRzIR6Rcwu4JAuGAECMzICBEvAf/6ah9v4/Pqa/yG7UFHri
 YRvMagMhP/Tqhxs0OhoK/IYoiTTx/aTADpt7TsFFkilX0LP+oz6C47k2oPivBLzlGMVhCGAn
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214eab cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=gEfo2CItAAAA:8 a=2AEO0YjSAAAA:8 a=BkuTzMVKkkJGYDtwCjMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=764
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Document device tree bindings for Silicon Labs CPC over a SPI bus. This
device requires both a chip select and an interrupt line to be able to
work.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 .../bindings/net/silabs,cpc-spi.yaml          | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/silabs,cpc-spi.yaml

diff --git a/Documentation/devicetree/bindings/net/silabs,cpc-spi.yaml b/Documentation/devicetree/bindings/net/silabs,cpc-spi.yaml
new file mode 100644
index 00000000000..82d3cd47daa
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/silabs,cpc-spi.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024 Silicon Labs Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/silabs,cpc-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI driver for CPC
+
+maintainers:
+  - Damien Riégel <damien.riegel@silabs.com>
+
+description: |
+  This binding is for the implementation of CPC protocol over SPI. The protocol
+  consists of a chain of header+payload frames. The interrupt is used by the
+  device to signal it has a frame to transmit, but also between headers and
+  payloads to signal that it is ready to receive payload.
+
+properties:
+  compatible:
+    enum:
+      - silabs,cpc-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            cpcspi@0 {
+                  compatible = "silabs,cpc-spi";
+                  reg = <0>;
+                  spi-max-frequency = <1000000>;
+                  interrupt-parent = <&gpio>;
+                  interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+            };
+    };
-- 
2.49.0


