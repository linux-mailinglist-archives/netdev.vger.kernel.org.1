Return-Path: <netdev+bounces-173021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0C9A56F02
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65B516B436
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24F021A44A;
	Fri,  7 Mar 2025 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VBO9Nn8k"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCE14293
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368531; cv=fail; b=GIcyB+pSfcg/fw63YOUYTv1Qr1qWO3JEpiMckF1Vsl1RuLIqjNpb8E60/2BiRO3HxLWqKlv8mZsoitGXnfI3aLQaYFY+Qwofuzbd55S7QteS4GUCsQTFC1pKfD8jOmSXObOwdmb2yDnlhl+kU9OcP9hbr3Xc9J2NH3Ie+iahQyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368531; c=relaxed/simple;
	bh=SB5StzCc28EVbboE6CPE1fK+s6NqTdoWCScXZ9z00qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mdOWWwv9QN35Hb1IasYPtQ4jcPFFm3S7+lWkSA/b11JcD3IL7aaJ0ZohHKCsRVzkjTGSjHyFTaZ/rkwS0BoR/b3xZ7+c/U/3s+MOjpzk3TDCxtRP7rXMo7bVS7fCzPR0foPSHDDuXB08eFBW2nftkGmxrkfCEQKoRtiFjqMyVzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VBO9Nn8k; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA2tdcA8NVJRVKSiPJPoCATXb7qYjiyhk3kVSN990NdLdiv7MBmGxJ5NfQZZvdQ9XX1uWceNICgCDS78HjWHrwT38QwEpVhYlz8sv1JvsRkFNV54ntcb739FBvgRhHzXtGdTDJIVpu+BbPKNtUTWm+Foj0qoH77dXKqEaat4ZDie76uiuddTy18HCq9cXYtVoM0l73PX/VLIhu//Hrg0ANKdxD9zq6ATQOdAcnbtukBUWmYbc2pjmLdpj6m5cH64rRVEpRJaJo0O1tly7pN1MypMVlMpMoAN2l4AVLkXjjo++OfVDymILp8Q7EtZcDSBzk2OocLqhg/RJPeh/4z6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrCpeRauqmsqjE1ZTCDcAGVx9UPkn0MIREKLXQR08XM=;
 b=U6RmX1PHvEVaw8XkWSkiVR+GwRtQCziPuDfwzqEDcvCuSnm9otX1YBwjLzhjS+HONPdOY/YpaFGCFycqPB7pO6pZ31brOjqKxut5vMzOqFC/naekYWHshqVDUdvX9o04ZLbDsMPbDfza3DHtPiXxgN4hCK/KNikmtwI/+qY0NBZgp1L+bmY9H2mnigRdcptbC7Eu4hO7C7bG3joJ/8MIZ0shyEsfhbJCdHhG74OwDeZpwv+KIgp3HBIKkZtJbIAoXGMOejOdfGwRFvZpt+11aXD2upZtlRDn0JaWvzePlUZcefTgFIqs9fj2NTN38yvKvbu2/eiTOl1hUOlc3LbmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrCpeRauqmsqjE1ZTCDcAGVx9UPkn0MIREKLXQR08XM=;
 b=VBO9Nn8k63lVr7dCMcTR90OVcPHfBg/toUlj71/WZw80Tf0SwsT3YWxLILV4ji4p8t7iz46Wel9/NSboGt1uA9gu67w0x7Kw5/qGUTrLIB9uLqCIWjv/zxHt8smk33iE5/Oux52wEsaotcMr/lEm2ToNWKNS24jpCEwxgzPV35e4Yz7ra20n990+34gMdQMIdSNAUtj2XXoSggVrJmX7Cw/oQyJHHVwLpL05CxrdLMt8hCkCz7kTOTd1/TZeggwYL7BEefOw2ZKhkTQCuh0H79Wdnu0Io28hsT+HbSzTq+i9wqIjVfW/hPqRD4V5AJvZXsdY6lWYc2vfi/AB+ktzlQ==
Received: from AM4PR07CA0024.eurprd07.prod.outlook.com (2603:10a6:205:1::37)
 by VI1PR07MB9498.eurprd07.prod.outlook.com (2603:10a6:800:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 17:28:44 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:205:1:cafe::df) by AM4PR07CA0024.outlook.office365.com
 (2603:10a6:205:1::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Fri,
 7 Mar 2025 17:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Fri, 7 Mar 2025 17:28:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 1DB8B201D1;
	Fri,  7 Mar 2025 19:28:43 +0200 (EET)
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
Date: Fri,  7 Mar 2025 18:28:30 +0100
Message-Id: <20250307172833.97732-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|VI1PR07MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0a6913-ae1a-44aa-6173-08dd5d9d82fc
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V3RySk83NXhlYjBPbVJiMlJVeEdVTUQ1MHlKa1B1aElYRzlMdEt5QzU2Z0c4?=
 =?utf-8?B?NXFzSlhVenBqYzBxdS84L3VoS3poaHVMMHZ3MG0vMXNzM00yQmZTVXdXdkpE?=
 =?utf-8?B?WEFraWFsbUxQMVZSUlZpVkxyUnRBTnJGbDdTOXkydkpwaXdjb2ZKL3QxdmxS?=
 =?utf-8?B?RkQ0QnVFcCtHZXhXeWN6RVhYakdTU3BFY2syeXgrM255UkRTMER3TTAzZ1hX?=
 =?utf-8?B?N1R3MDN3TzJGQmlma2JLeStNZUVwdWN0RW05OFQrOXMyWG1yV3dyZVpHakxs?=
 =?utf-8?B?Wjd4UHA1SHpvYWdRR2NyMVVIaTVVMVN1Mkdha0ZEaEJ2S0xmemk5bGsvTmdY?=
 =?utf-8?B?RGhEcjAwNWlldTQvNzZEeld4YkJJRHRYdGl6NEdBUnV6U0xkMGt2QytLaGhu?=
 =?utf-8?B?T1RTSE1UZzVKc1ErRVFvb2kvUFFCUk9IZVRNYlpwRUNvTEkyWG1BeFo0UnRF?=
 =?utf-8?B?bWVzSnJ6R0JEUlRYN25OekorY0ZXSWJGVk13OTllYUR6Y09KdEg2OEIvd0ta?=
 =?utf-8?B?WHhVOTFwTjk0SDZXUU82RlR1aFdUY0FhSVU2bTMwZGZST3RaNlJjZ2huQ090?=
 =?utf-8?B?RXdOUWdqcE9qZEVHR3UvbkpqcnZhemJ3Q2txdU5lZlE1SEIzR251RVpVWWI5?=
 =?utf-8?B?VFlvYWsxS0hYR3JJejl4M2JDZk8rblZwVzMwRy9yQ2dvelVaMkJ6ZW54blVZ?=
 =?utf-8?B?TmRDU3RvRUowekJPaTBFSVExQzY0TzZMSmJic0x2R25YQTlZSkllUjVPSEJJ?=
 =?utf-8?B?dXZGWnViUUNjNitpVk96OHM0RURTWExlMFcyU25jOWo3TkZGSHlselJYamIy?=
 =?utf-8?B?TjBYWFBVWXJhQkJjbWRFd00rN0ZObWlkdjJEQ2tMcTF0UWVoZE0zaGk5d3Fz?=
 =?utf-8?B?R3kzRHdBL0I0ODdpYnlmT3pBaEsyU21jaGc4Z01lMzhEYjdGTi9IQy9JeUlE?=
 =?utf-8?B?cUZwc3JybVBOSTY2T1JBOXhHS2FtekZxQSt0aDRQVVM2SGFqWGFsL3poRVlN?=
 =?utf-8?B?LzQvQ2VCbFhNMnZqOTh0REpsSVZZa29HVUlMcG5qL1FXemZmM0dlTGpNaCs3?=
 =?utf-8?B?NGdKenFLZjlHdk9rUFYvQUllVklQNU1oQ2tLbVhzTUtnOFlndHlmSGxTcWta?=
 =?utf-8?B?a0NUcTdQQXY3TUFGQ3BsSGVxdS9iMy9lMUk3c1BPRFRPaG5iT3A5SlZ5M0J3?=
 =?utf-8?B?RU9UTmg2dy9hS1p3bHF6TDBmS05RSHVoVFFyRStjdmdqaVFkUHg1Y205VXdV?=
 =?utf-8?B?bjJWdGZ0TXdGdS9vS01GdURrN3pCd1JvOGhKK2pKUlF4eG5rdFJVZXYyb1V0?=
 =?utf-8?B?eFpXc2tqeEh0OUovQ1ZYUys2Q2RvaVluNEJtd21JRmNCWG9UU1JjRU1yby9G?=
 =?utf-8?B?d1lsdFZkL3VHMFVRMEhXZzdLcVllaXBSdUdaczZ1VU1GTTNORHlYUFhoczFn?=
 =?utf-8?B?RUU2QnlZb0x5TEVoK0FSQ3VuMThweDJndXVjd2k2WXFPOHBWZk4xRnJWeFBp?=
 =?utf-8?B?K0ZiOHNsb2FBV3VweEplZm1xWHdaaGNNSGZhR3hvMHJEbjNGUitxOFpmY3A2?=
 =?utf-8?B?VlVyYlU2cTUyYUx3K3lRTXdlRDRHM2F4VzE3OWJRMmVkbk1pTmM2cmc2TmZR?=
 =?utf-8?B?WElpMU5XcXpKZE02TkU5a0NyUlVtZ2RKSGNtYWRvUitMNHB5ODl0SmJsaThw?=
 =?utf-8?B?aS96d3JlTGJ0Y2djNjhnZWtpK0hvVytmQTJqbWRpajhzTEtVRjNXSDhTejFY?=
 =?utf-8?B?ZHp6bVBXUzZ0YVFnbFBoL1RBMU1zMk5Id3JTUzZ4bDdQOTVTRGxsOHg0YkVt?=
 =?utf-8?B?UEQ3YjNnNVR6T2ZqUmhpYnhsYXRHckIyOCt1ZDlTQW1JTFJUWXVaOEUySUx4?=
 =?utf-8?B?QjNPRjlVZklmS2RKNnZ5Nk5KQkY2Nkhxb3hNUlRYazlxYUhFTjdMQVY2dEdC?=
 =?utf-8?B?UnBKVWMyMHhrNmM1VnJRRG44dVplNzBFM3RpN1lPRE9QVW80UHdHVWcrMFFN?=
 =?utf-8?B?b09Oc3lmTlRKektNVldYTXNINWs5RC9WYzR6Q3hBZkRqVWZLK3BsTVQvaHIx?=
 =?utf-8?Q?vwEe+e?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:28:44.4367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0a6913-ae1a-44aa-6173-08dd5d9d82fc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9498

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


