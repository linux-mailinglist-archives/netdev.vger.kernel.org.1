Return-Path: <netdev+bounces-179009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B026CA79FFA
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BBF188E6F6
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D36224891;
	Thu,  3 Apr 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="iVDWoYI+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4A1F12F1
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672301; cv=fail; b=hs5OtQCnjrc7WtFQlRYEw46c2typhBO+7s1sI72Ie2vQ5Nrv87Psj6vqz0pau3YTSwVhQd7rifL+TOKt+zjG21pFsmsJmMeZHS+4KrH06lKqrKvxozlzxLgRzIAdlHzsCED+aYH2ywNT8hOQCoh7SITi5kZI4ns5qeNGFHFC+LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672301; c=relaxed/simple;
	bh=WAqZWBaFYNwP3g1Iis+UPxY+zGoQckJmNBSE0r+b+lw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S3meOejNGgRq9fa7eTNAZYLvjU0vYfFZfYo6SkdO1tDetj0XD9dVriyaxH26QsiXecwC/eKryLi7cb2Gzs3XFzzxxeK7noey4vtqVPaAY1hU1k/XfzzcxZOEeAQq0AWTqEXs3T7pj7x0v4caMdcTk2a26cFwtzGoKc14fa89RvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=iVDWoYI+; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8EWJM9flDLTKLU6lxgu66PdIQPegJz4pk3dAEhtjlBuqxFBR/0+0EcFeQ7ajZtgykkKHdC5EN+CWlGr+bBaTHYhma/EKmM3ki/mtXkkSKAED/UC0d6Exj7hBJxZS8C5iMdvf/MHMC537MWWVOF1M11zFEYR18ovVHUJ2j1Q06yO4s4iVhh049pFbyKxivfW/52xbVHH3x24hwxhXBA0gOKaQv3GlnfYwZ2NjXA0oqmio27XD6FAk2YidiEfy0eL0oWD4YLwxBL/WIEOrAC7dic7qwoK6zqlRLyj+vUgoT5g1NIvpJnTUgzjsjBNu4IiS48yASSGWeH7hUCYDqhBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT7zT1hEuzYyQwZCdh7i0CzTLFqLmKqH/p2fNwejFZ8=;
 b=xxNzxXLkGItQ0Kwv+AprIPX/d1aMj4mJn11MJaVxE7PE8kSMdTQrD8aTVE8kedZEHxNSW3eJYq80xBO7dTtzzkK7VQ/ExDQqu1R+aQnKz+pMLesgGW5Tcmm9sqDb9cBA9BLZpiZRzhgymLy/38M83M4lqT6hO5IwfaaEE9FHSoHayEdX4U3BLc+i4/4IsubNWwnpubWyve3EsqVSrC6+KlyUvJB/1dNrVGpYLwY/0GkZhiFqvqSoUVDyozI+h0Ri35tczU2FDTHLIDU5JDI+oEETTtLVpnxRDSekyIyP9V9jOaMK0e1TDPKyPapSFIw6G8caf1yXXQHxDIZQlZNXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT7zT1hEuzYyQwZCdh7i0CzTLFqLmKqH/p2fNwejFZ8=;
 b=iVDWoYI+soqiRIl4McWCpkGwAd6mjW271XMKVg6q5VTDOvXRpQcZefINmEPOUhokQ7gDejXDEoQvpZ2h3SuzkQo5ntXcjJ6lG3hdcHyZX4CHSX5mtJhH8xuDGXVloAxucBTTM9F8nKkpSSdPo6MQUewwXvIyzXKDa0vRYZhBl8wpvWbvIUfuzC2WIdvQZ8Fdf+dX0CJj2z4npl+bnAM4RyGVV/Pe4X682ta815zznbwDz1MeDday4ACG1lty4wAlU9tgGz7JXbNNwtAMqN4nvSElakxbh+s+sRY2schl9IvVdCubOzQUDrlcxta90cXKy/ACmnsgrRJAighzDFEp8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:290::22)
 by GV1P189MB2218.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 09:24:54 +0000
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4]) by PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 09:24:54 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: [PATCH net] tipc: fix memory leak in tipc_link_xmit
Date: Thu,  3 Apr 2025 09:24:31 +0000
Message-Id: <20250403092431.514063-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:290::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRAP189MB1897:EE_|GV1P189MB2218:EE_
X-MS-Office365-Filtering-Correlation-Id: faa22719-b253-41b7-e635-08dd72916436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lEQ6B9Niymx43amhfgvuT9F9H9VYeEg7Asm0c6D9Q3cxGBzE8Uj6ZwC1I2m+?=
 =?us-ascii?Q?cvjmSvS6cOcuCzRDl4PcwWlOGEyi+Q9SlGxa5mZgc80kMNVvMYL02bRYTQlz?=
 =?us-ascii?Q?VJwci4nphvTj1vGLEbIqN2f/ewSwlU3039B+AEQ3fYqPbMV2zqzwUXkrZfVe?=
 =?us-ascii?Q?LPMbZaKDnpUXfy/aDZpvDdxNrDq4IwQIA5FBZzvC95tAQkTwoYLn3dzIaigT?=
 =?us-ascii?Q?o3B0xetI3Xb5czAqSuoVZohzI9IuoeH0r00KYWEiVenVJjeGCRECGzBUUcsT?=
 =?us-ascii?Q?zztvOYyqph5LvI/WS3sLm19y+0/UUQQ4qVgmx3wRvPcf+gZCiDH90/hvy2eU?=
 =?us-ascii?Q?C4IRXO7crBH1bwxDw0IqKjxZBjkrFCdpsIdhpcGxn2tkVyipfxFwoGInz/an?=
 =?us-ascii?Q?INold7Q0kR+x6MdDOY81IxtXFXcvP1YVZTHKJQCpW9R0rXOYPFbwYv0UVcAv?=
 =?us-ascii?Q?ki0EdjC27W9wEYRjtkpEPz3RhZ6IB0EQgeoDwn6T82W+ddwVV1YQbxxyIBMB?=
 =?us-ascii?Q?zKtvHwmgXajdoIDurXBrzAIjfjwZ9TBSyaJeCfJVZ7XNyTcTmYmqzE/W01F0?=
 =?us-ascii?Q?s/uZX0Bk4xwC2q2JldmR5zZji8LzGmEjyQDgFn2So4iOvLJRQK9hvJvaVtCe?=
 =?us-ascii?Q?S0KAz22MJUGKYtU5BgjPBJJSR4N2BZP4H8gJRH7siRmmeoIl2aUQbKSQCrka?=
 =?us-ascii?Q?O2tCwBcHhA60QKaJTonYImCG+c+HehuDq2Ffz1XdpoC6FGhaCm6qcpEEldtr?=
 =?us-ascii?Q?KuLLd3A+y5/dfS11I7SFfSnRoqJ1pLDV7Y76VfHOmlBnet0wn4J409bspNCL?=
 =?us-ascii?Q?QYU6Yiflzz2oFSgHraEilan4s7D0qcRcFvxlD5o5aW/RxKC2MFYRTKYmTGPL?=
 =?us-ascii?Q?1iHNM/hqMoejA4p6PUbX/A8Py+mDGc/uTuMuh3FVu17Ek4sOZkry9Gh8ZtIV?=
 =?us-ascii?Q?nxo+fNaq9KnoHdXFeWDVvIOL3dhaO8f8b/QEOBsn9YnsYI8p/FVNeudzjSbn?=
 =?us-ascii?Q?0+0OLzC33D+niXmNnfCONedra1gRdF+BB2SOSFJthrfyBviAgAz27hBkYP06?=
 =?us-ascii?Q?+eqSL9XqAIW5KeZtUCQV43745/AbAt4XEvC53rL/FhzTO8i04BS7Amy0tTpr?=
 =?us-ascii?Q?NTOpJBkNo0RMGBN90dBrFXJRcqJ+MBBLsM6MiAKE78SViOTyPYJG/boMsXIV?=
 =?us-ascii?Q?BqpWxplKBCCOk63g8AhtUy1YboRGJmOV3zNa6eveiTleYjDwfT6bJdtBoC6D?=
 =?us-ascii?Q?zlJ/DRz84rVov8au+b57sna9oyfnVEjHMuGve52/MiW0U0WqUcH7jd3+IXQy?=
 =?us-ascii?Q?simk2stClzOg7OhsUhy5JelfCA9k7VAhY+bYyGg+8pbspjP6QnYKYUGjEADN?=
 =?us-ascii?Q?gIhV2yYcC3pY6MwNTvNTyEsyKIsn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP189MB1897.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VlIuKj/OuzNqH5S0IwV9kyYEs5jP9FU7B+7G2INGOYGLoS43bqs6XWr+CJJX?=
 =?us-ascii?Q?r7zZ93kaHsYSIyfnNWi+vORxMv8tOkuVnwJOE3xfW9MOerdMtYemifk2O2xi?=
 =?us-ascii?Q?M1poC7P/Q3WGyvgLodBaNR66I9ybVbsJ1K5ZC0acAp4H2xdkot2PmdETtmen?=
 =?us-ascii?Q?r/36JqxkkKzlqQStQar1XkFzSxMaEOFfHpGZA+fUkzZERjNAWknYIBs1FzFG?=
 =?us-ascii?Q?PC6kGRg8Zp5yQb8mQZqy5tmW8A0MINvJRq0OZLLUbTILf6iIhKOYj5B+mPtW?=
 =?us-ascii?Q?bXEDNI+D2Urpnk3IwOAPSNIo3xd/a5MsZmR5x9gVJ1r3o5b5q3I/UDqeXjSK?=
 =?us-ascii?Q?fp0rRtTVzjsLLq/B9HfdH6x+LTlvV1xZV9oOtv6UrPOyNA3TzcyRJcqUsnUs?=
 =?us-ascii?Q?iH8a/tCw36LEEFWvgwb6cv2PgYXzGKbeqLkDHLNrJ18efGGtnhTkAhU66y9P?=
 =?us-ascii?Q?Z/gASYtPuKTrTq9SsiNCllGnc5rYufXQPp22o5Kp1KsRZEdsCPGNaYDjJOFk?=
 =?us-ascii?Q?MxBlgmhnLj8bzRS9v30xMWnEL6hD6uBELLPkUDZX7JaH3Wjh9KYHByIRYcm5?=
 =?us-ascii?Q?INh9s8KwVXIhSWuaRffS7Wdtc1DaJo2ltt8PuJGbKTKb34EXh5v3Ucjk0FH1?=
 =?us-ascii?Q?t3i5iwQxROsy6EXpoVJPXp3jtMb0hKAjcVvHoOPtVHAWLm/3lXDQa07ReqVi?=
 =?us-ascii?Q?RkMc84GffTBr0SBGRUG034EWnC2E3LXhfbChUyTvIoY3wmbTu2QqCScUijmj?=
 =?us-ascii?Q?JOS6oi68HMT49r5nI53VeO+7MzDLZVIcB+Yt2Mgxam/d4vjDSH3bzJuBtzSh?=
 =?us-ascii?Q?yb9vq9BEUG7Sl06+ksv1m6zHaMnQE8Fy7QKG6I7srZrlgZMAq1lCY2sJIOFb?=
 =?us-ascii?Q?0MovLXGhWP9tdxHcRPWhrSgdbRxkd7T6ogNxQVP2EHpgu5t5cjNaTBSjfBOm?=
 =?us-ascii?Q?QRvxClTuJ6hgSQKZrYkJlZEJ0GOsmAlhnvqNi84sKuCl83ZC7kE52giILuVM?=
 =?us-ascii?Q?te96MvtQd90q7S1MN52GL8etd+f7j5g2NEWEgztAJL55MyN00PcQLJn3/HLi?=
 =?us-ascii?Q?HXqdz99DgVi8OMzMfh65uzmRL0OMBT7+wmuVrH9fZgCmt5qRlgsWDvZFJpEN?=
 =?us-ascii?Q?CqGvWtYl4XKOEkIGPqF8F0RiO7HZPR+hXL1XM5eLPKYXp7MN8kHFLI0OJqcs?=
 =?us-ascii?Q?H6jJARe2sTv9EWvX8IuRSaXZ2KK0aCIAweiA8GvykRhJZpdsgzdNOT6DMJgI?=
 =?us-ascii?Q?1GRT39n36DAOAi33VZJO2ahbsU6ULjzkiPd+bwvk/bH79jbFcZEhki+NeQKq?=
 =?us-ascii?Q?qAfPBirnHYEfXJLSkujgqrLHAnU/PkLprEkRql+FvUtK1jiN+xd6+fNz85lQ?=
 =?us-ascii?Q?HP3Htu/oRbU59uoWqzy/K4lcSSB4tpOEZaey+prcUnN4Jxj9/I1uBHLJU0DD?=
 =?us-ascii?Q?zEKm8L/99M36OOI37Hesus9et2VLkNQ6aFBchdd8weGvg8GVz+7HsO8dU04I?=
 =?us-ascii?Q?r/vIiHQhHxOJrLyA8z0g38BWIzcvxAg5xgzVQUcjT1ifRKpmgTLW34k1kPYr?=
 =?us-ascii?Q?r7lbakjPiVumKpJrxeyIK/x79MkY8sZNtr0CKVLDz9jJjZKboIRTmxgP9fKR?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: faa22719-b253-41b7-e635-08dd72916436
X-MS-Exchange-CrossTenant-AuthSource: PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 09:24:54.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6e2sOhGtVpgQ74iV/7lsisGYmHU/lHLgLKg+McrEGix6fCIKRhAPxl6MbtKjfUv7F8Cn8EfBrbSrcv+6uQRUgUhwdbhzfBbc6lnCiea9c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2218

In case the backlog transmit queue for system-importance messages is overloaded,
tipc_link_xmit() returns -ENOBUFS but the skb list is not purged. This leads to
memory leak and failure when a skb is allocated.

This commit fixes this issue by purging the skb list before tipc_link_xmit()
returns.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 50c2e0846ea4..18be6ff4c3db 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1046,6 +1046,7 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 	if (unlikely(l->backlog[imp].len >= l->backlog[imp].limit)) {
 		if (imp == TIPC_SYSTEM_IMPORTANCE) {
 			pr_warn("%s<%s>, link overflow", link_rst_msg, l->name);
+			__skb_queue_purge(list);
 			return -ENOBUFS;
 		}
 		rc = link_schedule_user(l, hdr);
-- 
2.34.1


