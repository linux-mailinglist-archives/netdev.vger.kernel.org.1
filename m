Return-Path: <netdev+bounces-173041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA25A56F70
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 208657A7C9D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7924167C;
	Fri,  7 Mar 2025 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YX5gtq5i"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3422C21ADD1
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369364; cv=fail; b=YgtCA784sFdAFlEsY4a6jyAZFaW5azCst6Mld0ZgyMc5Ddxj0AMtDtN/ZEeFjp5Erm1Jm0a8mX19SY3MyVgnic7B6kgrM2uWri0L6RM7fOyhD3ppJ+Y3K0CLCYYvdqIywDAnui8KEwV/vyQQsYcofwTJiZY0YyzusATKXILavNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369364; c=relaxed/simple;
	bh=SB5StzCc28EVbboE6CPE1fK+s6NqTdoWCScXZ9z00qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GwhLrszkreQ/3LKC6dyIu/76gi/mSCH9xg25kt4QHaC9xjl++mMK3/N/HU8Me3EHknWoTPYolEqw+SEkAI2pOfnj/ZruYkoKaoix/T/8nm3TpV5Uum9+nMtqfmMrmiMSXgrZbe3W1H6QChXLjfgF+mJF/z0R0gzEVSerKrvfJTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YX5gtq5i; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caPnwAxmmx6q1VKeKuNB+5Z3UJt91dND9QVA5iR7BejK40lMRdYYaX6c7vA2LUauhDZ6QnhJM8CWUgxTox380Ii4LFoVZEPC5VcN7dg1ddMM8T0RoWAa02O4Zwe9Nmq+OzEqkVQg/Zd4zwV5r3byryf0Xf/FbyCxSwfMcwR3EqTN+E9XWZFf26rzriSvWH4lm2bfpT5ZIy8vqmy7VIHPV+6uL00SkdomM3YCiMpGd7v1qeEwA1JRNlQfgyy/knTkNAVzV9ADsfsJKevwGrX+wLeBspyEZTWPu8T9lbuOW3Sb+sgN1wfgwOwvGiOB6DnjM4P2E0q/lGe6eI5CYwmGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrCpeRauqmsqjE1ZTCDcAGVx9UPkn0MIREKLXQR08XM=;
 b=fBsZ8YXGh/4ABxWw8fpASDXq4KLVfH8H7TLAdqy+SMBr0qO2iHLOkBZyhS+URKQ9gd7o5CZZF2iUf41H7XIwbmF1gBAIGn8QxiKDpYGLJtb1qeLKSjezrZysy89YMnrsfhKSOLjJOHWuAvxXyH7ov/OFXtFMjDcFOexL7Es7m2rbFn3dieGbcVEXUbnNPp3xl9VIi8eHtQacZGoykUglc7tvJ5GZ/lOCE44UhSyTwNVEanqmBxDLdQbKZKH1pYYXpKtNsNObWClccWaAj3q6SSrgPlyqFKH24rRpD1282h1kBwiMpBMq5SxIPFicNEACLBG2r+RGINdb9dCkiXrz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrCpeRauqmsqjE1ZTCDcAGVx9UPkn0MIREKLXQR08XM=;
 b=YX5gtq5igVgET3aufQLPLl/8L7PGvmscXootqvwx2kV5vOe9uPRa69BMZb0uc1hXhLs8usNFkd2D0vQkX9bl52PqFFFrX5xFFv2kTT+C+YoCq6tCcvHSFP8vEfwKx+h0p/rihE5BYuoYakI5gBuBKq8Suv7nfCr6T4LYxTos92EzaLeI2yxcJEg47rCnHlyPZnmQPYc5lGbvU+oalGXy5ckP/ivcvbnVDbM8EYg/Z8khglUI3aaE1tp7xwtX7wIwzxPt4/8cKlHQkHpu1nu9eBRdPt0qX/JkXXhvqJitbLA/pIc/58A8R407PBinEBLc66Ew0okjtNCTynOIiV5QaQ==
Received: from DU2PR04CA0310.eurprd04.prod.outlook.com (2603:10a6:10:2b5::15)
 by AS1PR07MB9594.eurprd07.prod.outlook.com (2603:10a6:20b:472::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:42:36 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::b5) by DU2PR04CA0310.outlook.office365.com
 (2603:10a6:10:2b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 17:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Fri, 7 Mar 2025 17:42:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 86C0021788;
	Fri,  7 Mar 2025 19:25:01 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v7 net-next 0/3] DUALPI2 patch
Date: Fri,  7 Mar 2025 18:24:48 +0100
Message-Id: <20250307172451.97457-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|AS1PR07MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcbb66e-9916-4fa4-7877-08dd5d9f72f7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NHh1RDVYVWxkVnJwYWtVSE5Qci9zY0ExVFNabm4xN3dxckZHS1RFd0tzMmRq?=
 =?utf-8?B?dHg2OHh6SEFmZ1Q2MldvVGdWWGtRcllQL0F5aW1KRUI0NVRMcWF4Um03QVNl?=
 =?utf-8?B?TXdPb1dFTnRNRmRHalNLNUhyamxjNnVYbVh2ZmhzUnRlRDFlcldZTWdFa3Zz?=
 =?utf-8?B?Zlc5RzFmN2JHL0xsS2tjUGlIYm5tSEhRcHYwZnVZVU9zaTdveUNkeVNvaW4r?=
 =?utf-8?B?NDl1amNMV2Y3ak5SMm1wRHR1SDVZSHRpeHdvNHdVN2d1TTNENytPZDV0RHI5?=
 =?utf-8?B?aWVwZElTK0NkemJVMnBzbnA0bi9lSExNVFpoYTFBcHhob25NdGpyd2dXR1VN?=
 =?utf-8?B?YUJwOEVPUDlqdEQvT2xsUTU4YlY5elJHeHkvTzJyMHN5R0VHYXR5NzAvcEow?=
 =?utf-8?B?S0I0THQ0Z0xmVmZkd2dDSHhDUW1FcERhbm5XTkx3ME9wM3ZsNzlXYzhoZm1Y?=
 =?utf-8?B?K0t5YlgzZTAvL1BSRnVnY2ZXdVlpeGgwK0xxQkk4czZHTXVFRm9LRkdGbi8v?=
 =?utf-8?B?RkxvMFVkdmV1L1V4NWFMR1RRNk9uMGFoeGxaS1ZsL20zbzhaVDQ3dk1WVC9M?=
 =?utf-8?B?WnhGMzJ3amxnQUJ3R2xzMThXMjlNRXFkRGk1dGlwR1U2Unc2MHpWdUtlQURw?=
 =?utf-8?B?OWdVSTRTUkFzZnJlNHg2ZzJpcXRBWDZ4SXpOc2lBL1k1WE9zelVleG9hUTh1?=
 =?utf-8?B?OVcyZWdVRWVNdTFON3NsU0liZzRnMzYxVVpBM2tjS2I0dTZwaTdLMHczUnAx?=
 =?utf-8?B?LzJicm5KQjEwaUs2Ty9ndkVHMWZnR2lCQmVxMUw1M0NSUGo1VC94Q0ZOamd5?=
 =?utf-8?B?N0xzR3JaaHU3aVdEeEg4KzNaaG9TV1JMNkI1eE9GQ1dES1QzNm90d09WVmd2?=
 =?utf-8?B?STMxOGdmSjBrTy9oUjJvMGpMRG9VZDl5K0xhTkhLdFFGcVdqeUpjekZyY1Fv?=
 =?utf-8?B?V2VCR3dhTFZBenJMZUlZa1hhcTRvU1d0ejU2SlZTcThiVjNTQ2h1Vit5SjJr?=
 =?utf-8?B?ZVV1NXlzd2NuNXZ1U1EzVDhyZ0U2bFQ0emdkaGRLNWVmK3YzM2hpdE5nM2V3?=
 =?utf-8?B?QnJPdHlua0gybFYwZ1IrWFVNVllnTExlMk8vd1ZCMW1mRmovY1NraVpvWm1j?=
 =?utf-8?B?NzZ0R1RLOWQrdjJkWU0zMEhBSWt5TXlZaTQ2RzNoTmo1SUIzTmNZSGZyMmQv?=
 =?utf-8?B?MVNvTmpjVTZabGVyM2JwaHNjeklzMkpOTnZmR3NTYlBrNW81VVNVenZ0VlZl?=
 =?utf-8?B?SzNnODdDUnMvZVhsNk45Sm90akM2bjYxQUNmWTdZVU84YTVHODNXK2F4QVFK?=
 =?utf-8?B?VmFsTWJLNHZUK0tnZklJTnd0MXBrQ21ZWWk4c2hnbnIzL3dTU21yYWR2WTZt?=
 =?utf-8?B?K1VhNUxlRmNBcmplc2F6cDdUTHlhKzh0YTE4M1RkN21sS1hWaDBqV0NPSFph?=
 =?utf-8?B?K254Q0NsTXo4allsWDZ6U2NkUitIenZEMndHMWM5QWNWQWw4akFBNGZXMUdR?=
 =?utf-8?B?SGdTamVGVzFyTzFBdS9sU1A2WnQrRmZIWEpORCtxZG1NaXVmaXFYd2h6SmVB?=
 =?utf-8?B?Zk1LZU9UV0g2Sm5wNm8zSVdsMmtQdG12SXFVaXFtbXFsSlAwZ0poZm41QlpN?=
 =?utf-8?B?Rkg1cUFhRk5qTVVLblF0aW5hZ2p0T2R1QXdJZDFCMUpleXh5VDdrV09pYkZm?=
 =?utf-8?B?VEZydWZVRjJ4cDAvZU5nSU1CZkFZNm9LRFREbEp2enZGYW1kOEkyUmxsT0xC?=
 =?utf-8?B?d3BUWDhSTXdCOUJhcis0NS9RQ3M5dWFZRE9ZSWY1RG9scXFidHk4OThZVGk4?=
 =?utf-8?B?aTNtU0laOW1KRlRDSTZJL1lsbUNhcExCb0tCdStpNk9HZGpyam1uVEVzZDNR?=
 =?utf-8?B?UTMvaDJ3YUloWlVIK1dMZXROTHFRd0tTM3hMNklJTUpTWG4vRzI3WEhndU5z?=
 =?utf-8?B?KzdMZ3h5Q2FMTUhDZzhOV200VlhFVTdqN0I5Z1JiUk95cTI0M1JUc0Ywa05R?=
 =?utf-8?B?UXc1cjBmbGZQUlVpczlsT09LWkl4b2kwOHBRYUQ4aHIyczNkSWJkakF6WXJr?=
 =?utf-8?Q?SCzIS4?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:42:36.5232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcbb66e-9916-4fa4-7877-08dd5d9f72f7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB9594

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 patch v7.

v7
- Separate into 3 patches to avoid mixing changes of documentation, selftest, and code. (Cong Wang <xiyou.wangcong@gmail.com>)

v6
- Add modprobe for dulapi2 in tc-testing script tc-testing/tdc.sh (Jakub Kicinski <kuba@kernel.org>)
- Update test cases in dualpi2.json
- Update commit message

v5
- A comparison was done between MQ + DUALPI2, MQ + FQ_PIE, MQ + FQ_CODEL:
  Unshaped 1gigE with 4 download streams test:
   - Summary of tcp_4down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP :       1.19     1.34 ms          349
      TCP download avg :   235.42      N/A Mbits/s     349
      TCP download sum :   941.68      N/A Mbits/s     349
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349
  
   - Summary of tcp_4down run 'MQ + FQ_PIE'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.21     1.37 ms          350
      TCP download avg :   235.42      N/A Mbits/s     350
      TCP download sum :   941.61     N/A Mbits/s      350
      TCP download::1  :   232.54  233.13 Mbits/s      350
      TCP download::2  :   232.52  232.80 Mbits/s      350
      TCP download::3  :   233.14  233.78 Mbits/s      350
      TCP download::4  :   243.41  241.48 Mbits/s      350
  
   - Summary of tcp_4down run 'MQ + DUALPI2'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.19     1.34 ms          349
      TCP download avg :   235.42      N/A Mbits/s     349
      TCP download sum :   941.68      N/A Mbits/s     349
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349
  
  
  Unshaped 1gigE with 128 download streams test:
   - Summary of tcp_128down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350
  
   - Summary of tcp_128down run 'MQ + FQ_PIE':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350
  
   - Summary of tcp_128down run 'MQ + DUALPI2':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350
  
  
  Unshaped 10gigE with 4 download streams test:
   - Summary of tcp_4down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP :       0.22     0.23 ms          350
      TCP download avg :  2354.08      N/A Mbits/s     350
      TCP download sum :  9416.31      N/A Mbits/s     350
      TCP download::1  :  2353.65  2352.81 Mbits/s     350
      TCP download::2  :  2354.54  2354.21 Mbits/s     350
      TCP download::3  :  2353.56  2353.78 Mbits/s     350
      TCP download::4  :  2354.56  2354.45 Mbits/s     350
  
  - Summary of tcp_4down run 'MQ + FQ_PIE':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.20     0.19 ms          350
      TCP download avg :  2354.76      N/A Mbits/s     350
      TCP download sum :  9419.04      N/A Mbits/s     350
      TCP download::1  :  2354.77  2353.89 Mbits/s     350
      TCP download::2  :  2353.41  2354.29 Mbits/s     350
      TCP download::3  :  2356.18  2354.19 Mbits/s     350
      TCP download::4  :  2354.68  2353.15 Mbits/s     350
  
   - Summary of tcp_4down run 'MQ + DUALPI2':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.24     0.24 ms          350
      TCP download avg :  2354.11      N/A Mbits/s     350
      TCP download sum :  9416.43      N/A Mbits/s     350
      TCP download::1  :  2354.75  2353.93 Mbits/s     350
      TCP download::2  :  2353.15  2353.75 Mbits/s     350
      TCP download::3  :  2353.49  2353.72 Mbits/s     350
      TCP download::4  :  2355.04  2353.73 Mbits/s     350
  
  
  Unshaped 10gigE with 128 download streams test:
   - Summary of tcp_128down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP   :     7.57     8.69 ms          350
      TCP download avg :    73.97      N/A Mbits/s     350
      TCP download sum :  9467.82      N/A Mbits/s     350
  
   - Summary of tcp_128down run 'MQ + FQ_PIE':
                             avg       median       # data pts
      Ping (ms) ICMP   :     7.82     8.91 ms          350
      TCP download avg :    73.97      N/A Mbits/s     350
      TCP download sum :  9468.42      N/A Mbits/s     350
  
   - Summary of tcp_128down run 'MQ + DUALPI2':
                             avg       median       # data pts
      Ping (ms) ICMP   :     6.87     7.93 ms          350
      TCP download avg :    73.95      N/A Mbits/s     350
      TCP download sum :  9465.87      N/A Mbits/s     350
  
   From the results shown above, we see small differences between combinations.
- Update commit message to include results of no_split_gso and split_gso (Dave Taht <dave.taht@gmail.com> and Paolo Abeni <pabeni@redhat.com>)
- Add memlimit in dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update note in sch_dualpi2.c related to BBRv3 status (Dave Taht <dave.taht@gmail.com>)
- Update license identifier (Dave Taht <dave.taht@gmail.com>)
- Add selftest in tools/testing/selftests/tc-testing (Cong Wang <xiyou.wangcong@gmail.com>)
- Use netlink policies for parameter checks (Jamal Hadi Salim <jhs@mojatatu.com>)
- Modify texts & fix typos in Documentation/netlink/specs/tc.yaml (Dave Taht <dave.taht@gmail.com>)
- Add dscsriptions of packet counter statistics and reset function of sch_dualpi2.c
- Fix step_thresh in packets
- Update code comments in sch_dualpi2.c

v4
- Update statement in Kconfig for DualPI2 (Stephen Hemminger <stephen@networkplumber.org>)
- Put a blank line after #define in sch_dualpi2.c (Stephen Hemminger <stephen@networkplumber.org>)
- Fix line length warning

v3
- Fix compilaiton error
- Update Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)

v2
- Add Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)
- Use dualpi2 instead of skb prefix (Jamal Hadi Salim <jhs@mojatatu.com>)
- Replace nla_parse_nested_deprecated with nla_parse_nested (Jamal Hadi Salim <jhs@mojatatu.com>)
- Fix line length warning

For more details of DualPI2, plesae refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).

Best regards,
Chia-Yu

Chia-Yu Chang (2):
  Documentation: netlink: specs: tc: Add DualPI2 specification
  selftests/tc-testing: Add selftests for qdisc DualPI2

Koen De Schepper (1):
  sched: Add dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml           |  140 +++
 include/linux/netdevice.h                     |    1 +
 include/uapi/linux/pkt_sched.h                |   38 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1081 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  149 +++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1424 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


