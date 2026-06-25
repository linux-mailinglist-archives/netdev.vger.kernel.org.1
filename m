Return-Path: <netdev+bounces-302019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PHA6FYpPPWpq1AgAu9opvQ
	(envelope-from <netdev+bounces-302019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:55:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4FE6C7348
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:55:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=W7fsIVk+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302019-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302019-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6899B30588A0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA933F38A;
	Thu, 25 Jun 2026 15:54:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021117.outbound.protection.outlook.com [52.101.65.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B62E6116;
	Thu, 25 Jun 2026 15:54:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402894; cv=fail; b=qMVF1XtG2yUFYK5PlkJLBufu3QD3/I/mWENM+QRH7aqSOBo8gDls715oGcxqyKwsd0vNso/symMHuuUY2OEr/q0Aeprx5YdKSXuACpo1aa3GgO3ONi4Sn5Kw9QkpSL0+zXIW4jw4IPOGfrGa4TFP7AoCOCmwXl2+394Luw3ErPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402894; c=relaxed/simple;
	bh=gkO1+p2Z4WK/LEntxs8aV7yK4MEzzf+gN689bFC2UbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nsC1oFJmxaQaFGqjzEeDpnQLoc2f1qfyrk7zqcnNKRN/f/memV5ox9DdePGjjyyBqFpJLUj4k/kOVD5uoCOUecquqgklUE8+W5YwTWjHOhUOfFCldu4abK3zwf63SFwHP7a71xExYkP32OyIqmCPUKIgfXoMa4ShurWnhC5Ue6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=W7fsIVk+; arc=fail smtp.client-ip=52.101.65.117
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7rSzf6+0jli0xzbc0VYVHuJpVUbIA3b/ar2KO59eC5+I6YRzc8/HztVt4si4mV+hb+IXLWU8o+mHDmCgPX7uKFsZ43itFFwtetdJlN2AkFkk2FxuRT+YlUb9LUxhipJqwaoMFUon/W4eQBHlQ0+g9V7X5eYpr3gdR37paQMwGjtzmi3kmsn4bFbfgU6ye7ZyRM3LNokGJ1dFuPtkxVGEbqbqLB9fjvxK4OH+IUhkIdpzjL9/ZA+vMwX5FZvVTqVEcGljjML9Z70uIlcbejULqD1+dptDzjNpO9QrPUbyErkXjwxAjIh6/41aTDuBhM1Tz6gIXiGS72rN+Y5jk7OTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylF+3kLUlPW4NPlT7ZnbRlbmN7pE2yQ2gM7m8BlQgbc=;
 b=Pl9tCRa31lIajezb0ojEneSPTS2OczGUa+HAHjVmbMt8C/X7JclISDQv4CZtGWTqCDanRkTU+a0dL//GlhPBIHq+0Z2v7hSr3KaQpiwuX+OAJ8a2+MVa7p9CUmfes4HBZU2oz79HhTD51woCY9ge72o7bHfPeSDbbAuzNlWcgp45EGz9pIl6aaRygDU+ZI4Xmey/dwblRn80vXb5fS1O5nWCBN+Tk+OXrtsK1JEOE01AVhdU6RdDFnc4+uBdo3+oMzQdPwa8PXcrs3Tujekmk/NaHZsInTpRfy7ZWvL+vEvuDQmHatOTCzGJoQYtzEIU8+0JPJYaZsHgqaQ2pG/0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylF+3kLUlPW4NPlT7ZnbRlbmN7pE2yQ2gM7m8BlQgbc=;
 b=W7fsIVk+deXoS90em5Z2DM/Pq8jJG4F6eOm6yQY0SgcOgprCOIL79LSgti1z4zCsLHNtYuCNone4edSwI9MflJkk6UmlawILDYi8bA8CUFSFU2TFl7pHZuajYm7Yh4h4Et2oagnYTKoyDzHATKrzpifMkI0iEaRpsOl+yfytYGdD/wlanKxiibmEBMcGsVvFojoHl014KvCJ3hgCN+RvT3kIWJKMZxy4AT8sDDdn859wubQT54l7QE9CRJEpUmsN5/MmsZj72GsvC5zyXCxDgk8zB8upuxoQryywY8B3kbRtFtadez+JUbXQYeSMuYG0wkjGQ56YrDulsViIuRqqfg==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8043.eurprd08.prod.outlook.com
 (2603:10a6:10:3e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 25 Jun
 2026 15:54:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 15:54:32 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 4/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Date: Thu, 25 Jun 2026 18:54:16 +0300
Message-ID: <20260625155416.480669-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIYP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b63d36-fecd-4488-e664-08ded2d20c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	z54NewmPei+leuDcC3quKNEGCtrOKX42ubgPfQNa1XtaKLRa5yyOTQOhWJsoNSsCV125qOBv1OF1yjiamumeXcSbRkgjTyS9aV+e97GPcy5Nmw5pSpOcQf+pk9KmjjKwbCeq3+uZZeUcSdZcOM2OCAa6WWDkhpuqbmLXCMaixXRKRUG4lFyRxY0aM47VeuXIOBF0WldgRDF+8kIYeHAPOk/uTPY56P7jFTFLt420gAPcVjkkLdF6BnOxxtktLEYVFnVuvpslk25LhTDIIbFzUVWKcJT+gVdAmuGtuN+dnfZxWjdhCMQUeYhjQ6YYRvD3vqmQNITV2jeNkZzOl26Or4OxR4budTqTLLh4gzxoPI5icmjX/6EdqaA3ANEi3md72DfFFH4NHR5FA9xP/jAfNSYAh6wECpxUjcApXraOnJHqM8YHEVwZ2rkm6UHmNKuSDDBBdL7NK8Pjw+TBklNWeFnBFXvok5bgGFT+q7VNwE3f7FsBq3Quzwk2aeLU66lgtIAxRBuoXtcPt6f9L4+58WZSKZVRC4A5OZSwrqhxoHC+6aLGE9IS9ccBbx7sR83htOZDd2LyNiUr4D9wQl51AFlGu/Ecmr4U9pa15Zbz8kqJZx3l+UKtrXB9ObU5K1sCKnFRyBwSmMqPVpmAWaLb8ghjTK2nmmE4RQ76HtaWUtP0eTAZvSUIapaXSpFrMINAo4vrWrkpwpKHiHsCuhhvtx+nXgerggpS8y8O1/pie3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(18002099003)(22082099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n06WFHtISzDHagj2qU/zf52U1e+HoIji1NYczBxfR/CymCKK9gx7wtxNE121?=
 =?us-ascii?Q?m0ZVRTCF0pcNpRii2UJyL2NBh3JNm5T7ozT/i45PB6nr2z2qFs9js9qseLuO?=
 =?us-ascii?Q?t6Jeir2i6JbHAoKB+qCXR8igb1C8N71bnhOLQUmf7BbV7P0bfhLciQu1AeCn?=
 =?us-ascii?Q?uClXxHgNKa+44oy8O5uNR22Xb5YKe7HzUF+KPmCfx7mBVcOHTZC0tP1706IU?=
 =?us-ascii?Q?4glC+Dml6eyJxr7zmXvK9rQPsdnNrB2NyZtxbJJ/1CrhonK+WvG9x8jaO+fH?=
 =?us-ascii?Q?kc6zL6AWlBL/hgCXPFjCWLD4GKSMnULDXE4GuTaJZ6mOR/wBz7N6kT/7+x0H?=
 =?us-ascii?Q?pEfuJ49vlPcrkAdm/1VQWuVK1/OeU7bVeX7N/mbnInKEVyDN8IQHI5VZ1OjQ?=
 =?us-ascii?Q?7sh3DotzVyImH8PuAlgMElNeV6tMsoo3MX81PvAMTV3vGdT8bTZn5yfW4CqF?=
 =?us-ascii?Q?xaaOUC/ByXy5sEb16Ccr7C8kx5BJI/UhjSLH5O9VVzkUuuF84FKUIsB2tqWm?=
 =?us-ascii?Q?bU+L+ADAaynou8R8rjdjHHqnKgeEcKJKjc+ZMTsD2Xhvyvchb8PX4T2VOVSS?=
 =?us-ascii?Q?0g4sn2lz/xV/2EZ/5rQK808E4FrfZvBIadBdrfa97WY5zcrpuIP9py6xIr9k?=
 =?us-ascii?Q?YH+0bvcQK3rIpCmapeVn1tRPFQrQpKwcRSUdRfxAkmpH6Td/FsaOoTMGWqsN?=
 =?us-ascii?Q?y0Y9xwiB3re4Cj8T0TLhHYcxVj3s4NRbXYPj69XUHsQBZHoFTL6oBtCWr2gv?=
 =?us-ascii?Q?E17B3BfbJf5ACQ/yfZ0PObH4awUWoqLvdVKABIZRac5JhNxBH5+eruBODLd6?=
 =?us-ascii?Q?Mm4mC/WrZYA4bH5oD4vBPVGSM0474+wwzz3cpR3iS30yPwAmj2itpu0NWN9R?=
 =?us-ascii?Q?m3t2ol9p+BXroZ8OFEno09ckY3oJm5+kE9Fm59Dpae0YssmviyfG+Eh6X8BG?=
 =?us-ascii?Q?cPciBVwsHeOTU7oFWogHUwcugUoV9lb2aHulmzPc4V8heX01dCsh93hVvQ+T?=
 =?us-ascii?Q?fLmo5ST43mlHVONg4r33K/HNbPl6dp6dEaalZzo+DfvYHNtfC7IvGh+d4F9D?=
 =?us-ascii?Q?01JLGWMvSisPp1+q9KDhO0hbIoLlLOjvZsf1t9taZAqMEc7YZzMcUNw6yEcn?=
 =?us-ascii?Q?lot9mt1S6E5Fj6ntw5V1wb11vnkvNWOLwB0ja2EGeLjSYZaabejSJ0OPyoJQ?=
 =?us-ascii?Q?Z7kQG6EBfbuCHngPNnX5gi8PVZD1CVVBdoBZjN73uuor9/DIq5qLn4fVFVuy?=
 =?us-ascii?Q?8A/PjKj1Sqc/nE9ZdxcFgoa7pIzRPbL5a3psbrO72l63rc8uMGDSZN2CewXQ?=
 =?us-ascii?Q?1p10Y7x6EMM2c2zfyJgM25jT8GiM86bBCRJpGfr8RDC1FIOd0V6hdKtVxYkJ?=
 =?us-ascii?Q?9MbkyJ1bBdA/tBuSwsNs2xDDTXosVGqIjkJ9SDQBSUnkZHbCPGGJyze4fAut?=
 =?us-ascii?Q?vZ9qGdwqDiNHtB/P/rirCzUoL/5UuyjUrHw1WJttdN1kgRVcjsQFo5ztKw35?=
 =?us-ascii?Q?CXvRk/E4mxsjYrcJwZtDH5vvU4MD0xwpURBNMDxxyI2wEE0mn/Srjdrhc6pI?=
 =?us-ascii?Q?J371Tz8Sq67n8HsNZqCm+lriahQvWJedZlxxuiXSkWHnKxrWhGL3tSQoNsiM?=
 =?us-ascii?Q?lSVXsi+SjPFNUB2JsUzZSVcu7ZGFqhklJeA1jW+cMj3urd9Y1olHyQWiZNL1?=
 =?us-ascii?Q?mepJBj1wy1hf6Xsr4Uppxxak7aL1WCGZ1sdCyQf7nN2A+gzIR8VJ3CF/IBw4?=
 =?us-ascii?Q?eLVBk9V4KQnkLyDDwT4MCUC/6EI+dTA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b63d36-fecd-4488-e664-08ded2d20c6c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:54:32.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aodfnYqO2iMlZyZZLomgCaHWOiQWPwEDHx92G+TuNpzoq0E8xIFD1/R/azn4pWVKhKjCF5ZTgSBgJrIOUJr6qIHOpQ+C/YRfQV6cUE3PCYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302019-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrey.drobyshev@virtuozzo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE4FE6C7348

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
the guest with vhost-vsock device.  For this to work, we need to reset
the device ownership on the source side by calling RESET_OWNER, and then
claim it on the dest side by calling SET_OWNER.  We expect not to lose any
AF_VSOCK connection while this happens.

RESET_OWNER keeps the guest CID hashed, so that connections survive. That
leaves the device reachable by a lockless send/cancel path while the worker
is being torn down: a concurrent vhost_transport_send_pkt() or
vhost_transport_cancel_pkt() can call vhost_vq_work_queue() as
vhost_workers_free() frees the worker.  That might cause a use-after-free
of vq->worker.  In addition, any work queued onto the dying worker leaves
VHOST_WORK_QUEUED stuck, stalling send_pkt_queue after resume.

Fence the send/cancel paths around the teardown: send_pkt()/cancel_pkt()
only kick the worker while the backend is alive.  And reset_owner() calls
synchronize_rcu() after drop_backends() so in-flight send/cancel finish
before the worker is freed.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 drivers/vhost/vsock.c | 51 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 81d4f7209719..f0a0aa7d3200 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -318,7 +318,14 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
 		atomic_inc(&vsock->queued_replies);
 
 	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
-	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
+
+	/* Skip the kick once the backend is gone (stop/RESET_OWNER); the skb
+	 * stays queued and vhost_vsock_start() drains it. Pairs with the
+	 * synchronize_rcu() in vhost_vsock_reset_owner().
+	 */
+	if (data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))
+		vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX],
+				    &vsock->send_pkt_work);
 
 	rcu_read_unlock();
 	return len;
@@ -346,7 +353,15 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 		int new_cnt;
 
 		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
-		if (new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
+
+		/* Skip the kick once the backend is gone (stop/RESET_OWNER):
+		 * vhost_poll_queue() would touch the worker which is being freed
+		 * by teardown, e.g. on RESET_OWNER.  Pairs with the
+		 * synchronize_rcu() in vhost_vsock_reset_owner().  The TX VQ is
+		 * re-kicked by vhost_vsock_start().
+		 */
+		if (data_race(vhost_vq_get_backend(tx_vq)) &&
+		    new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
 			vhost_poll_queue(&tx_vq->poll);
 	}
 
@@ -903,6 +918,36 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	return -EFAULT;
 }
 
+static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
+{
+	struct vhost_iotlb *umem;
+	long err;
+
+	mutex_lock(&vsock->dev.mutex);
+	err = vhost_dev_check_owner(&vsock->dev);
+	if (err)
+		goto done;
+	umem = vhost_dev_reset_owner_prepare();
+	if (!umem) {
+		err = -ENOMEM;
+		goto done;
+	}
+	vhost_vsock_drop_backends(vsock);
+
+	/* Let in-flight send_pkt() callers stop touching the worker before the
+	 * flush + free below. Pairs with the backend check in
+	 * vhost_transport_send_pkt().
+	 */
+	synchronize_rcu();
+
+	vhost_vsock_flush(vsock);
+	vhost_dev_stop(&vsock->dev);
+	vhost_dev_reset_owner(&vsock->dev, umem);
+done:
+	mutex_unlock(&vsock->dev.mutex);
+	return err;
+}
+
 static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 				  unsigned long arg)
 {
@@ -946,6 +991,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 			return -EOPNOTSUPP;
 		vhost_set_backend_features(&vsock->dev, features);
 		return 0;
+	case VHOST_RESET_OWNER:
+		return vhost_vsock_reset_owner(vsock);
 	default:
 		mutex_lock(&vsock->dev.mutex);
 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
-- 
2.47.1


