Return-Path: <netdev+bounces-68588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2784750A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9CA292551
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD691487CD;
	Fri,  2 Feb 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PDVmXxCk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B8148303
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891933; cv=fail; b=B+4RtSxO5Q39Knm1QGRcPYCE2y2uWfToICjqWh38KiCIbDi2WmF53h7FXfJFT5WN7PGorT+u7Y80di1ietiSlnpXoUTxF1InVFTTPARIUW8rqOUxMs2m0tu6pKBsaqeKmkGzt51Pd9BsHOGoBu8EOs6os3tgFIRdZDzu7WLWQao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891933; c=relaxed/simple;
	bh=d/IKNnG6B7kEKpNBldqumucAnfqKdU2ogMlu0G5wHKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ib6RXWJoTWBXWKCbDetqNwBiaxlKWEV9KApanLKvYoHrewzowgw5CDc4ZiQ95HjCI5Hq60wCzLr1AGAHQspYI5MQAtQJ+03o7hphlF1U5sKkd2C2zCQZN9znjJMPqwzefae4kscaH+4bHbQM4MhV9P1nGCWLPfRhGnAWpItTlII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PDVmXxCk; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZTSWUvOcRnvwAhNyr362cPm0hQbU1rV6r4HG0EVKvOlPT+oNf+58LCcaDUSlMF4+CA9/UYNqHIswKDj8ehgrZ90Uv2A5schHjqK0VGbcuzi4DzARM9LLxJu25/WznLLY2jCTE3aNYTTBvWshYkGp2fp9cdqnGmSl9yl7gXZuel+SwLJAOANfXemyNT2547gjbCzDT4qg+jCjcs15Cxjls4q4bYLLTMn3njqRgRSK9WHIYOmfrw8g/ht18zsM+QKRzkSFdfUzzjQU1Fc4ZE4bqH9NrBUxFPfLHim0M5BaYUPiCo2uCcxRJSPIWxdaVGdxBxSqPP9LeYkgvzffNPPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MGi2Wzxqg0o5mdGb98qiRSFJOvgTUu8XEKKYcWJND0=;
 b=WvUq32Q7LyW1CT2CnhemgfVms1RZQmVfYtgzZRtfz9IoHiNyBe+fdmTiu/6eDd+7MqoO9/V2YIhjSvinZmyuv654u3Gg7bU3B/lgGaNsQpat6Y+ZgnLkPYOhlzjpfLsEN8Aon1slbg3JmV2E2IlwwrKG/qqdTuDDMJTGwnE99qQBy/KIqcpMgQcEATDMEzLHjf4gwgTxd0XhHG30nKYxUf5u0TC4PdXMa5mDpqP2JhpiFSAez8J6KhZh3N4plgWyIOg/o6SREfXWnip4eTr66CSl+xUhBB+QcTcildJhA8V/jkX3nxMju2bpLzwJnNZwP90afQPA9RcCtjXDOgBN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MGi2Wzxqg0o5mdGb98qiRSFJOvgTUu8XEKKYcWJND0=;
 b=PDVmXxCkD5FBIYFxLEOTRehi9oXo47hfoT/V2jJhVhewUH5/OE8stnxHkQP4mr0zT7oALy/SM1VFJVnhhIVMOvh3Kts6Syq7z5Gd5axv4iW4w/udZZF3hKIrbxYafZCw8Z6+5MFq4PaZsBrT1BwFZHOuk+/tJuDuhCBb1rjTdnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by GVXPR04MB9974.eurprd04.prod.outlook.com (2603:10a6:150:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 16:38:45 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:38:44 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net-next 0/2] Fixups for qca8k ds->user_mii_bus cleanup
Date: Fri,  2 Feb 2024 18:36:24 +0200
Message-Id: <20240202163626.2375079-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0094.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::35) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|GVXPR04MB9974:EE_
X-MS-Office365-Filtering-Correlation-Id: 448d03d9-f57e-4cf6-227a-08dc240d6c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UuyyfmfmyoEjUrNpIju69S1hUrVDH7zHyOiyYjhlG2TsZlYECc9cUfvkDPHV2FBlPMQfXyLCAR14QKNqCNQPvfFgOIRuRrLW7wC0MZyq3jE9KLwnF/5huxctCCDcy9HOUChrIJfUc74YP8y9EP+0AN974n5ZzMyCKpMoDszdMJZxELiJr0h33KLlWJS5FwargW2gnxDdNYAKiOtUd0md4jL7OI4vY61qK4ekOqjjrZLsE5r0x6yG0dUqT8eEE1cqg16ejenJmeS4jqPLnjnlkqyaql4ro6QGtos3DOaYL7P5TR0fvNv4bl0XcUAr6P79nN3jm4zRqndrr4PhidrwTTo2Esd8aLZbeN43IPX5Hk6jNF7BKYnU/msRNJj8x1rVUHpyYT7BWuvpYdtiuZt7uAVAZLBzvzsScpvy32+BwZYHrR2Z1jOpn78eaAZrIe/NtMy+5nRLV9Tgs8Rdg4J81YGPYwo3EDF2aEQ8y4MO47aCE/hbk53FsfvtDC0cNAhbhSwQxKkbObJ3cXHNfBAunnoxGuy2TO7XdghRbM7gYomSUY6/YgZTb7Mj79LOpMTuCtbHy29ukksW6AA+FqbRRXE5yeh90d7TgYka+jJos35RjnNvXB08ij1pDv1v4Cv2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(2616005)(6512007)(38100700002)(4326008)(26005)(8936002)(2906002)(1076003)(5660300002)(4744005)(6916009)(966005)(66556008)(6506007)(66476007)(66946007)(44832011)(54906003)(478600001)(6666004)(52116002)(6486002)(8676002)(316002)(38350700005)(36756003)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUR3QUlVaEpNQmRSUG9tcENhSnNIMVZaQnR4YllMcHN5M1F4RElxaUhTTGZE?=
 =?utf-8?B?c01USzJGUlFmZCtYSEViYWU4bm9KdmtJRm1hbjhzOTJNRkhVSUtrekZrek1L?=
 =?utf-8?B?UThtcUEwekZheVl6NjdwQjN4Wk1yYnBIL1UvdW9oOUV6cWhDc2U0aGcrUHNh?=
 =?utf-8?B?b3FibmY2TkJrU3QzdTVzZTFLWEMxOW96aHU3RFFCTEF2Wk1xNGVmNzQ0c082?=
 =?utf-8?B?OE5VcmVNWU5WcTRvekxNNjQ3V0NLaVlucXpDaklrWTgyNDZkVjlhZUM2WWtU?=
 =?utf-8?B?T0o1TFVEcVJUZXkvV1dwOUFhZmJQWkpjQ0hNR013T1NKaW01djRCQzJLeGh2?=
 =?utf-8?B?bzVjam5uVm1DN3MvY2RZYWg4TzBCY3RmODdkcFZ1dmhHa1FpcFZSYVd5citD?=
 =?utf-8?B?MS9ma2NyUVQrRmpuRHVzdklnM0FoZ3lrRWhacXBnazBkM3FDTWlXbDI1QXFT?=
 =?utf-8?B?ZW1KWDU4VS9DQ3RFSHRIbWVlWlRHY1lROGUzaVcyUEdsdlpCQUJ4Wm9hUEZ6?=
 =?utf-8?B?d0R1ZDVicytWRUlFWVBXYmRSU2dRZXJyYklHRkJvVDhSMXpaTjNGYmc3eW5V?=
 =?utf-8?B?NGc3T0V4eVh2aGhDWWRNR0xRTnJ5SXhwQ0MrdFpRb1l2ekRRbU42SFNnRnhx?=
 =?utf-8?B?a3dVZFVqeEpSYUpPdjVVcHIzSTBVTzhlV1hMczlVdFdLSi9rdXNJR2NxUlFs?=
 =?utf-8?B?aGlaWVQwSUtuYjRRdmNLK0dRUFFMN2EzZDV3c3VicVFsM2o2dUpHNDRjTUZs?=
 =?utf-8?B?aTR1U3Jka0tLNnBwamxRNXpNVVRQMG9IdS9WTG51VEJTa1RmR2tuRjI3bktB?=
 =?utf-8?B?UG8vbjg4TzZXK1EyOUJIaHUvZ0NQdE9FMWhnL05wMDBINmpmb1BZVjZnMHly?=
 =?utf-8?B?RXN5YU1uVDRoUnlXV2o3NGtBcnIwckdjMGtybmJGSEpjS25SamlnclVBRGRQ?=
 =?utf-8?B?cEFuSURXL0U2WHprNFJWUlpzQW9Yb2d3NVd4NDJ5NC8yVCtQMGcwempJd09z?=
 =?utf-8?B?M25KZk9ja1Yyd3ZBQndQc2IwOUlBQy9oVEM2M0h0MjdRRFdSNFhzQ0ZydGJt?=
 =?utf-8?B?Wnk1NUJDejVPdFp2aENlSXQwdENiMUtkcTB1VDlOVzJWS2R1OUlVcVJ2eHJ3?=
 =?utf-8?B?RC9qeElqWkptZThLbWVRQUIzdkNZa2w4ZnFidFlWWmlzc1NydW5OVW80VjN6?=
 =?utf-8?B?WjB2dVc2Ukx1S3ovV21HL09KSGdLUndWTXh0cGlMcXhqMzhEaTBDU2luUzVs?=
 =?utf-8?B?MmVwWThtcVlKSitmZmpGUmgwWndhMTJ3ME9WU294dDdnNWcxQXFoQ0oza3BE?=
 =?utf-8?B?UkNmVDg4Q0t6eE83N3NRc3pXcVc2NUlSQnFsNmxpaTk1WUIzL0lLbERBM09D?=
 =?utf-8?B?VkZobnUvUmtjdEJONld2dFFFbDVJYUM1NitwWnk1SnZyQ3lMQVZhZnlOS0Q5?=
 =?utf-8?B?czU4RFBmb0d4S09QWXN0TU5JYXd3ak1qZDdlYjRRZ0dOZ1JDMVRaQmJrYkxP?=
 =?utf-8?B?QXdzWDIvMnhBMmlCNCtSNHZOOVJHTEJFR3pFcTJDQ25oYkcvb1BpQlFObjVK?=
 =?utf-8?B?NXlHRUFDVFdYSDYyNVpwbmJvd0pLOFYzVHQ5Q25UZDNqRzZDSWZGUkx3ZVdX?=
 =?utf-8?B?NWE0aDdCM0Y2VmdXb1llb2twT3A5MzJyS0F0WTcxWkd2TXk2NFJ1QTE0d252?=
 =?utf-8?B?cWt2UDEzYkhPRjlMVDBOd3V0Z3hhdXhLV2RLOWtrUFVmekVyYjRpaVZLUUVM?=
 =?utf-8?B?dWNzdTZId1QvNkJ4akhQK0R6UWJKeGtpZmdBOFZ6SEdFTDRiZDRlbDkwektr?=
 =?utf-8?B?VWVaQzR3RElyN014dDJiUURzTGhXd0wrM2JSWDYxTlVqVzZ1THlXK0Y4U2V6?=
 =?utf-8?B?N0RRS0gvWnFDZmVHZUNTdGlWRVBSQ25oZ21JMk42R3k5bzNodmZpdEZGQUc2?=
 =?utf-8?B?b2tMUnRKSTZVRmR2K003RHk0N1dJd2dOeHh0aVVqek16VVVRczJCTzRwMGhR?=
 =?utf-8?B?ZXp3aVlwaVNQV29tY1UySUZGMm84OEVtZU1PMWRCRVVjS1hxblVSSzRGeXFr?=
 =?utf-8?B?eGo3SG10bEdOT3FhcFlmZDdrWW4ydmdQOHJObVM2cmRzWHlZcEdwazFibUth?=
 =?utf-8?B?RmU0bFFRWHhvTzBuVUtlc21Jdk0xOU5oK28vYmZOeS84a052WjhmeWZ2aWdl?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448d03d9-f57e-4cf6-227a-08dc240d6c23
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:38:44.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nioykAJIcFY9/8pmOT6gq6idCII5S+ZVt5qRoC4LJP+cD7qpSw5aABuq7vWLl23vUxNCKe5NmmxLxPlHhqpcig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9974

The series "ds->user_mii_bus cleanup (part 1)" from the last development
cycle:
https://patchwork.kernel.org/project/netdevbpf/cover/20240104140037.374166-1-vladimir.oltean@nxp.com/

had some review comments I didn't have the time to address at the time.
One from Alvin and one from Luiz. They can reasonably be treated as
improvements for v6.9.

Vladimir Oltean (2):
  net: dsa: qca8k: put MDIO controller OF node if unavailable
  net: dsa: qca8k: consistently use "ret" rather than "err" for error
    codes

 drivers/net/dsa/qca/qca8k-8xxx.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.34.1


