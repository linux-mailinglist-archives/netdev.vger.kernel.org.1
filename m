Return-Path: <netdev+bounces-171698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FB6A4E3BD
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4328C883942
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22227D76F;
	Tue,  4 Mar 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eaDrRyps"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E4253337
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101324; cv=fail; b=luXgCwgshgpzTHLdwpX4aFrA3u2Lee5wdk96DD2Wt13C8+PXt+MTa1lAUtmF05jLUrz40rDb2lgcJOrvbTPr/jAuxcZh82QyFm+zIb+PI0CeJRvAj1BR9kHArQ15sGiyzG7El+VXaOY4kmNPEujCxgIElYwwjCtay1OHhgxfE9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101324; c=relaxed/simple;
	bh=b7KVw5AtiVppJpnzFegO+KwmMR0HYToY18ZPJ8tNVxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RxrJDeWF+Y5TOR3nlsA5n61OC1EQkGpYwA0yr8W8bDIQryNHW8VNJjtqk+PlSjRmL5ozxOd7Foup77OQtU4FVQ2pjn8uVJpFl9nCpwcYgnnSNFNNIQdScj5ysi4B1bTuI+5qzex85mAEMYvIlpu684g1t8r/6d+yf/5khw2ndgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eaDrRyps; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE0DRiBAdszJ84jrEj+O7z/3cqL08yWlCl/VTDeZcNKkUOHuysj2kzZEmVBEHHTLLZu7r1JEMBDDq9OzM3zVtPVBLMwOEw6k3cvpB9uC/CfK6BI5cRiaDIFYr3UiaE8ILt7BgsY6hCfBMKda6CvN9FX6jQoAl6i/RNDgTiqaAsx6R0RLRTkATwoU+sZsCSoyPXOzp1LCWXii+Lw9gWj4oi1yyn2jXZ386a8CMi2Ja9S4Z43wgj6lso5Lde+I83xwLc7jkthTEbHeuIk095B++NSLTk2gU52sBPRk+o06JzCJYLbCcOKOMRhPIgihHVUMmrN9yYO03f8jni/9S64qXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7EtQHFMsO+a7gp7nlcO8P6ZaAzgl3Sd/cYX8H7TV/s=;
 b=mTPLs1G/NKgwaTnqw5FgDkvWg85Ec03VZMs7zetEqu4R7tAGYi8N2HRV/v3lBeHmyiXouskqvdWggPdY6CPaEE36skCqlH4hclaXVwOkH8rBXecFLjCMizWGIhtSGNKmW37u375DNaKrIvbdOeitgJOQd9Of0GXwyuLbtkwwnaVJgFvhA3oP0rjgUm0b6uy+gi/9EsGDVRnDoHVjymRsI3DTlzXsSriC6kTUAcwbMqEneHk6h71vPBSZWVFfVFzHRTJvepBrhrEKH7T5vmn4IUn2Zg7ncwWa/XEB4kiPXhJuePFNibPz1Ib6rtTeCfuNfClXl43HG4KtbvjJyLErng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7EtQHFMsO+a7gp7nlcO8P6ZaAzgl3Sd/cYX8H7TV/s=;
 b=eaDrRypspzOdP6dDONDAB6m58/MCUs25bSjQftKGAFvXDe8duSytyZsQtr44Cy/uiNQQEI5rwdyhUcyN05RR4B9KFbql8Dd50KKJQnlAYCfolYH+sQozHy1+ZhAtOLzZaPOC93x/8gJOJYl7CnHZLWjNEGlA/MmbAsWj30a0GA1wBsOauyibj6ZINPn0INb8wHR1ckCtAH/SMp6uzSoZ/O8rjFpQtXxcMRddOALiLlFP6XgKWrT3KMgYU53rL/DaX64WQXbA3Mlh6vcpskVNW9VOLxsi8MqTKO42CvdIRi+fTwC8uMVUmNHAjSrb3D1KN7RlI2Dt8l+uNmnMEGVwBg==
Received: from DU2PR04CA0165.eurprd04.prod.outlook.com (2603:10a6:10:2b0::20)
 by AM0PR07MB6308.eurprd07.prod.outlook.com (2603:10a6:20b:157::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 15:15:18 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::94) by DU2PR04CA0165.outlook.office365.com
 (2603:10a6:10:2b0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 15:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 15:15:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 524FFCeL009727;
	Tue, 4 Mar 2025 15:15:13 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v6 net-next 0/1] DUALPI2 patch
Date: Tue,  4 Mar 2025 16:15:02 +0100
Message-Id: <20250304151503.77919-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|AM0PR07MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: ac05885c-f166-44c9-8c6f-08dd5b2f5fb6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NXZEVDJXVGl5b1Fyb2MzWjQ1Tlg4NW9YbjlJMUpWa2JEYWt2c0dWcUZlbCtp?=
 =?utf-8?B?bGtFS1Y0L2YvQ3VJaWkyeWpEK2NieGwxT1JmNFY2eExBL1JabmRzY0t2Tng1?=
 =?utf-8?B?cWxGZjBhbE5lWTFrdkNNZXM4SVNjWE1INWsxMXdhK05SVGRHZ2JpdnFpc01F?=
 =?utf-8?B?R1FqRU9XQ0lxdXptZmQ1S0RiRTlzY3UwSy9Sa0FrNFp1dVpBQWt4QmQ2L1da?=
 =?utf-8?B?cUFuUnNTYnR6dTZVa0h0dFZPOWtyMVdkNlhPMnRqWXNGaUIzVnV2dWhRRmJC?=
 =?utf-8?B?ZzNDSUV4UUYwTjZPV0J4WnpjdE5RYnM4Q2dPc3JUbm1rWkQvaHRvSmViVC8r?=
 =?utf-8?B?NlN5R0FxNVRuY1RkUHBZUFB2OGFVcW5FLzBTQ3luYTFDblRZLzFIa0psOWhM?=
 =?utf-8?B?RVdLL1VIbDZENFhyTGhtUS92KzgyeGJDcEhSZWJZSlcwcm5yS1hkWVBUSnpB?=
 =?utf-8?B?RDJ1RnIrcXhmUy9tYldXcng4c3cwZGV2QnJxckI1ZjVxZkZIRkcrWmRPZlE3?=
 =?utf-8?B?NHI4b0d2RXg1bGxOeGJnaXlUWlZLU3ZHMnRqbk1pQkhYcUhWOG5ieTF1UEFY?=
 =?utf-8?B?eUY5dFlnRTJySEVkMy9OOGdyV0pNT0d5N0JIT1hxSEk0bDF5QlUxSytqLzN6?=
 =?utf-8?B?YWhTenEwRTQycThDOElIYXJCekFOdnlxTjZmeVBQYnJ3Nzg4ZnpLa2U5ZGdQ?=
 =?utf-8?B?ZU5VZk1yTnlUeW0wZVJramI5U0hkd2NrK3hSYXlNUEVGd3hWUkVPQUJvazll?=
 =?utf-8?B?Y1JHU0FGZE02bWhOd1JEQ3I5SHlBbWNhcjR4R25wUXB4L1dVZG1GL3YzQ0o4?=
 =?utf-8?B?aXBYc2JPNFljWTA3OUJLRWExVUw2R0ZwMnI2K2c3VDVFbzdudzBsdVNscTNI?=
 =?utf-8?B?RERUcVlGakF6emI4RGpTT084aWNZdmRaWXNrRnptVzRzbEVyWjMvQU5SZlNx?=
 =?utf-8?B?c2NvMjFYMmI1ajRVSEVIL1BGN1ZiZGpSeWhvTC9XZTNGcDJTMTFIY25mUWxU?=
 =?utf-8?B?L2gwMnY2cDNLZGtLOFR0QVRGTm4wWm5yc3U4cGYzL0xWTk01SUU4Z0dJTzAz?=
 =?utf-8?B?K3BrU0FrNHU4VUNJV1E5MkVjemlwNmNFNzhFOEtiMm9aUUxscXVCNWhUS0lx?=
 =?utf-8?B?OFRSQ0R1dXlDRktaRG9Tb082NU03UUxJR21nU2tzMTI0eEZZUnZNME9oMm9T?=
 =?utf-8?B?OTdOUlA5YTFJQVFLYmZoVUZLck96eEFvN2lqWFFxVGpEUEhBNVpWS29XNzNC?=
 =?utf-8?B?UEZlRUhGcVNiWVJpckNPakpTT2EvVDZLbTNST252ajdVSldDZGg3cEFsc3lO?=
 =?utf-8?B?aGJ1WncrNEN3N0xmTmxMS2VPdEw0L1NaL2pJQlpxR3h3VUdtd3RRaVRqdEVm?=
 =?utf-8?B?UGVPeHZPNHpaOUxvaEhScFJvSzU4MnBYM3BlS2VlaHU0dW5nY1NNRkc4aXdj?=
 =?utf-8?B?bzF4L1VYYWRGMnZuUENHRVdBcXNJajZnVFpHNWdlQkIxazdQRUI4OFE2Y0RH?=
 =?utf-8?B?UW9RUmg4M3BVT2kzMHlSUGhqQnRoZ3YzcmZweEVTUVJWOXpHLzkrQUxLMjZn?=
 =?utf-8?B?elhSMFNUQXZHbEhLeWQ2OUVHazNIV2ZCWE9MWkIrQjFwSHZwSGllMkRHdlpJ?=
 =?utf-8?B?QTUzTEVvRlF0ek9MYkhZeU1IY3VzeWZROFBLMzBQTlhhM3ZKQ1hnSEFjNlNh?=
 =?utf-8?B?aFVGQU42UWNGVW5DVlpRRHVIMDBDYndZUGt1emVmc0g1ZWNIU1pGd1hiRTRP?=
 =?utf-8?B?SmZNWERySTJEd3ZrUzZkdWpJVU1MYWFIY2Z0WkVzZ21QK0xldEJXVHhJdHNJ?=
 =?utf-8?B?MWFyUlViamNtQytFcU8yaUdGYlBzV29oZXZNSFUydERTSDY4UFY1VktlTm9Z?=
 =?utf-8?B?UVYxT0VWNytBMnNzaXFETnNZeVhiOG5hZ3BwcUE5cG5BNnRURGd4VzV1TUlO?=
 =?utf-8?Q?ie+nUA/MSobW5rcJL3ZPnfjs8RhNoa0g?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:15:18.2149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac05885c-f166-44c9-8c6f-08dd5b2f5fb6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6308

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find DUALPI2 patch v6.

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
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349
  
   - Summary of tcp_4down run 'MQ + FQ_PIE'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.21     1.37 ms          350
      TCP download avg :   235.42      N/A Mbits/s     350
      TCP download sum :   941.61     N/A Mbits/s      350
      TCP download::1  :   232.54  233.13 Mbits/s      350
      TCP download::2  :   232.52  232.80 Mbits/s      350
      TCP download::3  :   233.14  233.78 Mbits/s      350
      TCP download::4  :   243.41  241.48 Mbits/s      350
  
   - Summary of tcp_4down run 'MQ + DUALPI2'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.19     1.34 ms          349
      TCP download avg :   235.42      N/A Mbits/s     349
      TCP download sum :   941.68      N/A Mbits/s     349
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349
  
  
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
      TCP download::1  :  2353.65  2352.81 Mbits/s     350
      TCP download::2  :  2354.54  2354.21 Mbits/s     350
      TCP download::3  :  2353.56  2353.78 Mbits/s     350
      TCP download::4  :  2354.56  2354.45 Mbits/s     350
  
  - Summary of tcp_4down run 'MQ + FQ_PIE':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.20     0.19 ms          350
      TCP download avg :  2354.76      N/A Mbits/s     350
      TCP download sum :  9419.04      N/A Mbits/s     350
      TCP download::1  :  2354.77  2353.89 Mbits/s     350
      TCP download::2  :  2353.41  2354.29 Mbits/s     350
      TCP download::3  :  2356.18  2354.19 Mbits/s     350
      TCP download::4  :  2354.68  2353.15 Mbits/s     350
  
   - Summary of tcp_4down run 'MQ + DUALPI2':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.24     0.24 ms          350
      TCP download avg :  2354.11      N/A Mbits/s     350
      TCP download sum :  9416.43      N/A Mbits/s     350
      TCP download::1  :  2354.75  2353.93 Mbits/s     350
      TCP download::2  :  2353.15  2353.75 Mbits/s     350
      TCP download::3  :  2353.49  2353.72 Mbits/s     350
      TCP download::4  :  2355.04  2353.73 Mbits/s     350
  
  
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


