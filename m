Return-Path: <netdev+bounces-135554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7199E3F1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960F31F23D46
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD3C1E4110;
	Tue, 15 Oct 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="X37mKPSq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212611EF087
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988232; cv=fail; b=mHhE+DM6XT64XW170o4QWZMPYB/0xtxgA2V5ZC2hKjPas4DxiHbmTMRXfH555lxGID1SAGZt434R44JBrQA9V8Ps0KQ/Q947p3izKAfXA8du9wmM6yRrluNrJ9L/ULShIk375xeL04KKVps5ASsMeBNYP3k+de6xKuio3uIbxoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988232; c=relaxed/simple;
	bh=Gn1/UHy4PJ7gn76PcQtxLIFaOwAKdGOwbNQmuf3ct8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBUQOpV2RxFIr9o14GOFGBong82d4HJRAlavYx48DOhYI2TIuCZm+0rKft+bbL0Vsgdb0b0oDR2nQu5TRHbBXw0GBUDnYq+/wDodLP2+y2LF2fERcIVu3bD0BGlxAqdouZUcEKl5ySaY52U3svGOHnVpO+6V6+Juefkemthcx/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=X37mKPSq; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2f7DYVW5JxChNdSl7zpSdzaKoAk+Lckd124KF1bt8lxNjUO4n0qcvT7zV9+GZfdsBa5IO4MTcy8OayiU949ZmDmh4f2EHML0TZzjbu/+RosgqTglcygimPGIvyxwxX9GIoxn9d2ocaXQi4sk0KUe8xKuaUQVgQVStYlNF6Jj8xy6kH9cGQXlYXANimi/5Y4g37AlyuzSrXaUJKmagq7FFa0wuHHzl1O1Cm1Y3oRGzr9M4WMj5WgdJqv2JPp5ROoEbopQpX1O8b3RfPwsGKxBMQUx86bD5sxs5dHyvlcSLP0mBrB0nGoxyyNq/b+Qq+lh2rb+P/ahY3j4m/ybN4Eyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9WwR2Xv4FIHJwuPLcvHdHKdLc6GIQYEULQNRRvPIyo=;
 b=Z6KT5WqeULtzjtiq+RYTK2hYF5BWvw6vEHSZdkGnUnXtJx3oLV8vfw3qLOeOZ6saM6x2WlWWTzDMS60TqNIhyQdhpK7y0KmwY1fNBrC5TFsO3JRqcfHuyj5tYxSSiKJPnc8o8UkpYyua1hF62qNJPyIBmxYNhNKMxlOp4Zoly1SbL9HqMZ9mSUwibwbG/JyyJCY9td4lrrFtKk8OokLS5oUF0zHraqxwSba9kMsu0cekw728YrOclZiN+CSCDNocQS+QH/9d/7q4JQAB0BE7oxab9tIJcdf/eMH+FdgYerlRiIMBQZfyoMqcJTpkE+BSuDqDX3I9xLyI7t+1KY7Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9WwR2Xv4FIHJwuPLcvHdHKdLc6GIQYEULQNRRvPIyo=;
 b=X37mKPSq4d5phqIkZXwiE4RTFP06BrLEYfrClqRlKxecupQdt9FYVmbbfuDrEJVPHvra1+F/jjyGuZlkGJqHpJ3McRqRQzfYalgqLrvmmDX6yEWbZOjjw1u+QwbTyIje8YgjuQg8DTDlfPcNLBXzwxtweuOToPME/wtk4651qsxgaHskpw2IZxv0wobyVx0YZJJfDOGrghEW+RnKjODTAf/MZ+qGicpJ0TvuEMDH1Bob4N6vu9vr8As4GrZCsZvb82WOrWmA276CXMICUfeP6mEqV8aY/AmXqVdLfX0aIkQr4NZXSNfnoW5Krl+GIFHWLhEEfhuqVprJCKYS6lDj8w==
Received: from DUZPR01CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::14) by AM0PR07MB6273.eurprd07.prod.outlook.com
 (2603:10a6:20b:144::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 10:30:28 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::f) by DUZPR01CA0066.outlook.office365.com
 (2603:10a6:10:3c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnU029578;
	Tue, 15 Oct 2024 10:30:26 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 26/44] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Tue, 15 Oct 2024 12:29:22 +0200
Message-Id: <20241015102940.26157-27-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AM0PR07MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 9313b7b3-7caf-438b-5a44-08dced04631e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zjg5MTEvbW1wcHFRM2l0OXVGZ1JyTUNXUUtmR1dWRHpodTNIU3orU1c4OTFZ?=
 =?utf-8?B?MXg5QVB2alNLdWtLVjhSZ0kxT09OSkNWaXEwanExc1ZlQzNxcTJneTlQUVJx?=
 =?utf-8?B?K3JWOFhzVXJ1Q3VkUy9ZODVQQzN4aXY2c3BzMHB5SENVWlkyMEIrenJJQWpL?=
 =?utf-8?B?SFEwa2d5bldKQUY0NXc4cHZ0T2kwSy9Xb01DU2JabHdzd0V0YVRiamMvNUts?=
 =?utf-8?B?M3J6OGFRU1NXV0x1TTVzLzd5MWhpNnh4YVB4RHJxSU1rY0xYWWovYnVIZVdI?=
 =?utf-8?B?R1d5aEUyU1M5S1lKQTBNa3NZSU5TM2doUVdYUWVQYUNlZFNkaUgzQ2lCVHBi?=
 =?utf-8?B?N0drQVFObWlQRGh1UnBrWmJRblFHVmZENGNHRkNmMTdFK0h5dUswRGlHSVpu?=
 =?utf-8?B?a3cxeS9RamRhaW9kK2dseGdmWnlLQy8zenFBYXExWGVlL1J5akM1dFVXNnht?=
 =?utf-8?B?VGVYdXM5VVcxVStudXpJVFJNTTlkWEJ2YVdUbS9zUC9JVzFkZU1WTkFNUVVT?=
 =?utf-8?B?L1p1MmZjOGlOUTlzZ1NHaU5tT2FjYnFkcXRKSDRlZkNIY0Q2a1lSZWFCak9U?=
 =?utf-8?B?Z2VvOGc3MXZmL2F2YWpuQUpVdDVMTTZ4azVDTXhtRk44dDBKV1p2N2Jka0dT?=
 =?utf-8?B?aGlabXVWNmlqRFFpNVB3bWU3MDBaak9DN1Z4VjJFQTlwSlBTc2ZFbnVhSUUr?=
 =?utf-8?B?L3RNMFRmbHFnM2pKMlEydFhjditSd01NUVVlZzh5L25IQVdqWFVEcWYxbkZz?=
 =?utf-8?B?UVdNbVg5RUltbXpOWWlLN3lSeTlabkRycktGbUI1NCtyNEhENjVSdXVlOWcv?=
 =?utf-8?B?c0hSaFF1eFRPQ3lBRG9LeVZ4SlMxOVBuVU4raU56SXliNlhJbWZSUFhUSXJJ?=
 =?utf-8?B?dEZMSlBvU1VFNDRwU0RXMXo2cURiNnB1VjM4eTFjQ0FxWEtBcE9LbW1MN21Z?=
 =?utf-8?B?N1RJLzh3RmszSWg5alVIOHFGVE5ZeHU1ZThSVElBbGl2bVJ6di9OOXJSWlhI?=
 =?utf-8?B?UDVrbUpQR3RKdmExRFBnajRXc0lRQUNDYytrVEljSlo5YXFBbjA3RXpyWWdQ?=
 =?utf-8?B?MjEzbEFBRXEyY1piMkxkV1hKMUJjcndXdGZPbUppUHJIbEZmL0pzeVdKaElE?=
 =?utf-8?B?VVZna0RxWFVwZGFaNHNxNkRIQVFJSHBLNUZKL24vRS9rbjBpWGxjZ3BLaFlP?=
 =?utf-8?B?NUhRaVNmeE9RYkNPS3MrZlI3YXpJK0x3ZjVOZ1BxK3dBTDViMSs1SEIvUFN6?=
 =?utf-8?B?RktkY0ZwRUFiR2JMUC9PT2k4Y1F1eXJ1aDVFRTc2eFdGZGRPM25BclFOdXZV?=
 =?utf-8?B?RlZiUUlybVdzR0pGZ2g3ZjF6dGFwZUdtVTh4RlJUZHBjWEd6VDh4UVZaZjB3?=
 =?utf-8?B?cURNOUcvOTFuYkhrbUswSzA0NytlZGgvODJKbXcwYVpDU0JyZGEwWjU2ZFc3?=
 =?utf-8?B?Sk9vdGYrTTJodWcvS2ZVUWFGUjc4SmVEemdNM1BGWWpxazFPYzFWckFDZC9a?=
 =?utf-8?B?dnpuanpUa0pPQ29yQXVOeGJxR0xQTzQzemptNGJ4TXhXamtKWUdHRk41cEly?=
 =?utf-8?B?amxGRHdDbld6ZjdFcnpHamVYNnI5clI4YTFTMEhLSW9qdi9qOE01bDk5Tnlx?=
 =?utf-8?B?c0pTUE4xVncwakFhVVgzcGJnV0NxN1czVDdRZFYzSnpPVzJBRG1hNFlIMnVv?=
 =?utf-8?B?R2o5REg3Qk5GcWI3YitRT1k0QWVod0F2K0cydVE5WkJvWGZlQ29tRFhxb1VX?=
 =?utf-8?B?SllXTEZZMlRNZTVrelJBREJ4clN3Z1BBbVBpY2V5V1dIK0Y5Vk5RSnRIWU1D?=
 =?utf-8?B?YmNlMVo3K0tPcXVTaDdMYWQxL2JieGtQU1lZb2FSV25qTVpyaWh2a2JZU21y?=
 =?utf-8?Q?4AQ6gheiMxTLY?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:27.6790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9313b7b3-7caf-438b-5a44-08dced04631e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6273

From: Ilpo Järvinen <ij@kernel.org>

Armed with ceb delta from option, delivered bytes, and
delivered packets it is possible to estimate how many times
ACE field wrapped.

This calculation is necessary only if more than one wrap
is possible. Without SACK, delivered bytes and packets are
not always trustworthy in which case TCP falls back to the
simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 79e901eb5fcf..ac928359a443 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -705,6 +705,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
 		if (!d_ceb)
 			return delta;
+
+		if ((delivered_pkts >= (TCP_ACCECN_CEP_ACE_MASK + 1) * 2) &&
+		    (tcp_is_sack(tp) ||
+		     ((1 << inet_csk(sk)->icsk_ca_state) & (TCPF_CA_Open | TCPF_CA_CWR)))) {
+			u32 est_d_cep;
+
+			if (delivered_bytes <= d_ceb)
+				return safe_delta;
+
+			est_d_cep = DIV_ROUND_UP_ULL((u64)d_ceb * delivered_pkts, delivered_bytes);
+			return min(safe_delta, delta + (est_d_cep & ~TCP_ACCECN_CEP_ACE_MASK));
+		}
+
 		if (d_ceb > delta * tp->mss_cache)
 			return safe_delta;
 		if (d_ceb < safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
-- 
2.34.1


