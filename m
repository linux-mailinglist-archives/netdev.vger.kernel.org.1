Return-Path: <netdev+bounces-298742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XOgsL0I7LGpYOAQAu9opvQ
	(envelope-from <netdev+bounces-298742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:00:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A33A67B278
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:00:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=cajAPhZO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298742-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298742-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F5CF321E004
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAF1408004;
	Fri, 12 Jun 2026 16:57:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021127.outbound.protection.outlook.com [52.101.65.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85840759D;
	Fri, 12 Jun 2026 16:57:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283462; cv=fail; b=IndvR6s/RTi49G15AjkT6v10heav3ijPlvXXA8YUD2SHGOxotq/rBJyLWmy69AEr6PApzH4wnsSH/glKp7J+ek4n3GtnEjkQ0qkfk9KeoJuUCOPG6Y2ij/L++LUtjQNk6QgO97A60BjaHLwYhtSWIvGH4dmQippe3h+3Al2JEFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283462; c=relaxed/simple;
	bh=bL5mYbExXRNDHRTG86ovjmCPFbXFzbiWxQMTdlLwoqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvVsgLDNGrMXGPzlLAVESzr3g/23nSBGSgww9XRgLaw2Bjz+k+Z5mCN1HnsG7Q+Hp1Xf9x3Zw5K8CZj2MYH9rE7Q5MoF7xBevIVMzGzZAsD+FItWqHV7Na8LmUaMwp4ZpYjfOWp3ZHlHE+MJMaGJKiw4g3UrptqbQwipQGntpVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=cajAPhZO; arc=fail smtp.client-ip=52.101.65.127
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDogvP2phrBzpqm0DQ+ikGUs8UpZ5klhkTCo01qJzEhkrLecn0jcrpNzwWIXs/gPCi9IfAPb0rdrFTIKWz8U1tVlkcMmfvwuT3pcIjJtJmYm2x5hLpQdqg1fORxqDascLfMexqHuAlJHOvajeRNyICC9nWVNBVhX8f67Y5AjgzGStUqRsKMc7W9nVqrjx+p91mAbUQdxxpc9CmrE/nAnT6EH+nNnSQN5jpiRpaZ2LBa+KDXC/eR5L/LTzT2FvKB5QyejvCaPhKL0MYLyAxI9Kt527TcPeR8S4w+v85R8hu4Qe9DDCGqZJj2YOwXyzXM+voxHqH838oKBTOvP3C1/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzDgox9s3tlMcpKOhmDze7DLr27Tz3ofYkQwPvXqKgo=;
 b=gYMlHCdFRLHRYeO4xNefl/5t2Lben6ldeLgG0OPbf3yyo4lMQFwOtVPfA7S5bk8KY+G3Uhr4hX5x26aNVaVdRJGWp+Q+ydge4lbJ4NowZD86VOW5Qnr48AQ5QLN0dvixraUqZmHnALk7jKSSEF665U1ycCId02Y1CHrTR5dCzwKs1t6cyqRyIuLsJ6xhymg5Uv6TucV4HrqtADiDmYsl0iOAYoyCYLw0Lmki8ciKnKQzQt4DQZj7SohPyfY0i8lwHO1/B8bfMG6t5wA1X0RlOocOcZ8OY+JUEbUVe2SMkAo5A1M8MTXYWdGDe7ihCS8cCTwcgeudGHchZp+qH7dLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzDgox9s3tlMcpKOhmDze7DLr27Tz3ofYkQwPvXqKgo=;
 b=cajAPhZOTzhHRUdTofTKBORJLlxMqBhTw6/o5G/Y24nteeYLmlluGibHiMGfaVbTTebOh/NNzKGwS1fTP17Y+PkbRa3hkQ8svwzGGuC031H1lq62fO424oa5ie5QJWpfyg7etfmyoLIrHMwcYTe7uLEn4SDFd7vHQ17YQjW/6HsxfkQMOq9BzY6FDjhE2/YzvDoc/npElOMJKWq+GF0cKeJS59HfBsjy6ijoIzO4dhpuZXiH2oc1RCGWP7Dj4umjZon2v+IcCZeS/FuIrxAL3oRRhp5cccMPA2+QfYhTBKbav6+w7Nfl5WseoJoVNwQvM4oxdgik9E8YoLvGeeHVug==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9416.eurprd08.prod.outlook.com
 (2603:10a6:20b:594::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 16:57:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:57:30 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH 4/4] vhost/vsock: re-scan TX virtqueue on device start
Date: Fri, 12 Jun 2026 19:57:18 +0300
Message-ID: <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::34) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 1310816b-6b23-4f17-831b-08dec8a3af5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|23010399003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	3pN2pZhgzKtjvBQ1kUkkogj1l+mBmZ2ov6XbV4yHdc657TZtQam36H1aSBwo1V77prgv7QFGqAFE2d0Ak+QEqkY+as0UF6ud71Y3bnKX8umkvnH8Xoh0OpoJjJZ181moLjwynrucPh45HE2HOJ4tGgiG0kTEu5a40nziXW4Kw4CSXgr5NgEjpFQMZTPg/nMGp+hpm4OXmT1QZJ+eSbhD2/pGuY7Gh56EBoOMcnGyu523MkFd+4335I0vlfg/aXG+g4glGS7juKcMpHMVae4dGC3Ihl91XG+iBTwEJCvxz+tIgdqy2IRYB2nHWZ4EBrWtRKN2CubWaIa5MCCfXmpd49xaczHFhsVSrceM958IgaICtgxvSvomb89d+bmQla6pbUnqNj/QfiQ43TsXSw1OFThVuJfbADOqshz3udJpfR6yZCBakLihVFDdqFDjBwQOMSB0mm9oxfpEbBhPZHtcGy7hGkhzA2BMvXGe114vs4jjUAW2fCpmdcG4o4bmY3LyLcM4st9XAIQWh3RzGk2abR3l2FlcEGvT4KM9RxhifUj0rU04Y9LYb4/EMsgMAypgxBQUrcpHXkY1TInDcg1A5i5wnNU14Ct11oPNvwI/vqd74bDtsTEJs4IqYZzbzp9Ld4aK0OwWCGEqyRQ6UISqPxh2OmRjr4XRupQOY5DyeKgIPbRyNNXgRU/w+IJq9z7M+2KdDow+BBuZMel22bsch8Ngdp4jBy0Rdnu2R4vOAu1scp0ateJowcP9W6ePmAlf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cZWF6xxI+qEb04PLLkKMI13PmOzYrlACwyaQ8f7iips7oEgv0Y7jYiB5rlW0?=
 =?us-ascii?Q?+gQZWSrO7+07Zl9R9ZNq0C0j+Udt2krkyKYdoU96Yw6z/XEA7tXa1qyvPBue?=
 =?us-ascii?Q?eIDfjZ6go85QsSC4SHPgwlOeaG2e90hEPI4/zoZGC7mf5s0sh3KwsbIFLyhH?=
 =?us-ascii?Q?nrP9AXMMpNr93HxRvtGfK6/+Hsk2y9vdD5HiYrluTVwTkavTbugmfAP0b2QA?=
 =?us-ascii?Q?28EW+raITds20mb930VIfnFkTXLshSkHHIpgw6P53XttMYWNuO0krvr6PbXT?=
 =?us-ascii?Q?H3qRTffEu9I54ED3+PWrRLX8k8TvhguFp5Jany+gXuLzWeyvIwMjrJ2oQ08r?=
 =?us-ascii?Q?XwRU+I58BMMb+USPGkRmhcUfLqiVWM1b1x5RSPui5ZrQL634D6PlaRJJfIA2?=
 =?us-ascii?Q?ViTIQ7uA6WgbhpiAYT4V5d4tVL9mdB5PC9GatHu1wDx1Hi0AJeuZCL0myeG0?=
 =?us-ascii?Q?1L/HuAegF1v5dsFgL5GbhZJcVpOWazMhAEx1S94+16oyX0gu7Ld4hzyfSTuE?=
 =?us-ascii?Q?+jE47g47kWdFp9o6jWvap2gyslJD3HXIHBKxKYJyAvoGGGDa6d3PXfN2BuyX?=
 =?us-ascii?Q?V5SLCvQdss9aMXUHDlIySs9BbfMIXenZVxTpEB0fqDGk0rrJNsLqI6KQgYTC?=
 =?us-ascii?Q?Tdig6WxLcvQdqmrDB+dFK0BP37PAjNWevLqymaBLo1d1RIuVdnY5CKJGm7Ud?=
 =?us-ascii?Q?O5KPHQXp064oU2Q9hzC7tqIZ3iI93KEhLb+Ysbtd32Yc3ZZbtx84juoWIvGE?=
 =?us-ascii?Q?qk4FvL4Bu0KGTgrBRqQxSrPDB8HpLYPtCWV0tiQUxeV3GR5RTA2hPlZBiE/q?=
 =?us-ascii?Q?rgfuX211fSEKM6x1ByZ2fMt0Mn/S9uRde9g0lyKUyo521K1YZ1YV5f0ukCTu?=
 =?us-ascii?Q?6DjoObyn10IrScVdfizSawnLMKXDrXt8815O48+xE5+3KeNM0VM5lRzxKdpp?=
 =?us-ascii?Q?sR+xE5aaKw5dD3c/+nN2YhotoYKuKiJqZ1mESy2hERRffO45tokuQksPRu4U?=
 =?us-ascii?Q?bJVst0NaVaSYE0bzyEqJosricwAmmGlCx1S/ePyomesOWwE/1e4uJrVSQYB0?=
 =?us-ascii?Q?Eern7zB1IKZX0TtJOSwhETUWfidI3+vMwePcs8oPNmJD0zrwDxu4E+tqzruK?=
 =?us-ascii?Q?IqU+bqZHdnkkOCQMoiAaN7u7qwGjuF93UpizjwzvvfpAiJy0bLLtigc3g9AV?=
 =?us-ascii?Q?3YmJGz3VhdFl862uvxNW1Kkv9URoLPemeqZ6HTQckPDSoEOPQjfAOkjh3Efw?=
 =?us-ascii?Q?PAAcKsplxqCNHESIgfV+kXroBlCG+CV74syL0m36JSA+8Ti/oVP6gbLzVsEf?=
 =?us-ascii?Q?+izT0hVxZnmh2Nf0pBoyr9ysjkd0XClrcSUzm9g3no/zPbQaIR/4wXNsvRdY?=
 =?us-ascii?Q?kZgYE8k4fbSwAraHGmzio3GTwaLuR2SULHIJpSj4jPZYuiF6cAPiDJXQtGIo?=
 =?us-ascii?Q?Vb3DOu6ooAsWDQz6jZu++qJ12zlUDwtsyoRG4+iprH7CRR/EJwo8jn1Dbj1u?=
 =?us-ascii?Q?9V1RdTTE6FzPbnIcJDCKjBpi3k2svtqzmX17c1Rg+qnS/ZaMyfdZBIG1Daaj?=
 =?us-ascii?Q?0MNEtRWBHbKiT9q9dN0moLyPNzayH5zhuIuvybYsKCM13Qf0E5Rn7qZdW62z?=
 =?us-ascii?Q?gDPJLxbq+Pqlsx0b2oRe6UpAWx73h4YBmEzOTR53z4P4OyjDHe3IfcuH1smY?=
 =?us-ascii?Q?7RhNufSC6wbljWlF4vADpwqYyNLqQicqG/7jLPhxDmSXX2GoirLEGlvCaY2M?=
 =?us-ascii?Q?ApmGitec9za25E+E5M6ckUVh3L8Hy7U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1310816b-6b23-4f17-831b-08dec8a3af5f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:57:28.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8SMAB8pKx5y4nUlEiqKyyQaZbfFm/MIlwVgRkg7vE5a/6XCn7/WYMyEh8IbkAIUEXwYwCWF7sn/V+KjAZhcjDDzw6cDRNyE73WCFXr9pGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9416
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298742-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,virtuozzo.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A33A67B278

During QEMU CPR live-update (and VHOST_RESET_OWNER in general) the guest
keeps running while the host drops and later re-attaches vhost backends.
If the guest adds a buffer to the TX virtqueue (guest->host) and kicks
while the backend is temporarily NULL (between vhost_vsock_drop_backends()
and the next vhost_vsock_start()), then the kick is delivered to the
vhost worker, handle_tx_kick() sees a NULL backend and returns, and the
kick signal is consumed.  The buffer is then left in the ring.

Then upon device start vhost_vsock_start() only re-kicks the RX send
worker, never the TX VQ, so the buffer is processed only if the guest
happens to kick again.  But if the guest itself is now waiting for data
from the host, it will never kick TX VQ again, and we end up in a
deadlock.

The deadlock is reproduced during active host->guest socat data transfer
under multiple consecutive CPR live-update's.

To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
queue the TX vq poll so any buffers the guest enqueued while we were paused
get scanned.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/vsock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index bcaba36becd7..1fcfe71d18be 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -655,6 +655,12 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	 */
 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
+	/*
+	 * Some packets might've also been queued in TX VQ.  Re-scan it here,
+	 * mirroring the RX send-worker kick above.
+	 */
+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
+
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
 
-- 
2.47.1


