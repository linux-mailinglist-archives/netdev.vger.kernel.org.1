Return-Path: <netdev+bounces-298739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mclCGK46LGosOAQAu9opvQ
	(envelope-from <netdev+bounces-298739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:58:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD467B223
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:58:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b="Iqh/9VjA";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298739-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298739-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A43253144999
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60F74048A7;
	Fri, 12 Jun 2026 16:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021127.outbound.protection.outlook.com [52.101.65.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD79403156;
	Fri, 12 Jun 2026 16:57:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283455; cv=fail; b=Hn5mUQE27lyW3ad0IjOvytfew+CC9BqiMN/tVd/ME9488trawPGQang4gHYb7ZoPqsH3bltTZxClf2pDy8q5gh7NpjX9gRLShktl8whoQ985pBlhjEDK+B+UnceK0nQNORLgWh4UZU+98joay9MkVF/XKmi432ERAA7du7cHCL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283455; c=relaxed/simple;
	bh=Xq4Vq052e6S1lGduiAwXcv1O/7WPSYNm7rkTQW0OWL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tvL/dQyKAiaFz+d96XI5ljFWf/TKDIGa5Cbu1a2Bkgi28wBrrZGouqftk4zC0XHBVV5dLxtcwFNq3Rnnc05eDAavYLdXniB7VPiVDg44/l/lkOtgYv9SIdY7NYBW0tD/FvW9VPAJEZwLLkbYczKoyvtucQnlr63lBhEG9hAzLFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Iqh/9VjA; arc=fail smtp.client-ip=52.101.65.127
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFFs2KDHDbds8CODA+Hzl608h1zodgYCQY6/DLZ4gyojsVd4jVDByE0DzN18fA5f+d5zRPGURg3dHoVwUYd3h8VTlh6r6qfF2SGdNkT9ZzK52JxBaCSVeCU3rxCJo9xgD7hUXOxLA7vTL2b1pwurILXwpbQJUOdWVqw0SAbKebaRugcv9mXUTOyYSyDE8w9LQWz8DW4c4Xqde/645/cA++1i5cXzOIoFWfDmbYLcYeCcMYvGq2SedbOQxtVsQUBmfkcpPSMZ1aXnoC+LM3u0Neo0kqTAaWVM/+XlIDMaaCh26P600b108nQl297RZl6D3XBu8DYE4MTddTycAAmalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xbRwYmjyOaHwGQQMlD5kdLcB6p8wIxYQT0w054OLyE=;
 b=l+Uc53daGVPdgpich+WXrKtT0hit7CLRGVvct00da2ac+2ubHzRKXmmbpy7bESAqwerwQKy84dxSbgOgJ3nfiBJdCgdf8sxehRzuFgx8qrlMYAyTE8+4A0lbaygdkDM9OVarW7Ni307qyplgAapaqj2QAs9nl8AAbQ4FJ94LeBQR1QSc33M0wF7HGX89qSUu303+CXMEKkzMxPt+LnJ+/CE91/J8q1nnvMnxAV+ET6r8/0n/nmFRTpnLs3Xbmst/MPP3UpCrEJBYgzrFaVdIkqgnB00UFOG8pSU7JY1t8xI8FWkuxM8yleVNa8zmP+QA0rNhY/9roezfu+6kZfFpeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xbRwYmjyOaHwGQQMlD5kdLcB6p8wIxYQT0w054OLyE=;
 b=Iqh/9VjAzEdWjCjC+22PiBFtcb0tPSajtO4ASLz4SZ2AyD4aVOCUzXGK0mgyv2+s+uv6FI9+Ak7CEKZsE5mJYYkTt6AIt8LgVDloxIJWJ9B2ZBruMNWjXoba5Hfagk/1ygClKHWNqx/31ULhl+31BwvWLskdeODZbFZH+09ZPB/dJVYFVVwKc4oaFZneYpctgayCrMHcegKH1TBqnC/ViGIgkjEP65zRy0+k28ZmM2BsEivA8npgjQZ6NKuT61TQOb3NypPBfzzBJ8SYu5Rkx1m/UsLz/qng/y75vkZHuLXo/18/a0q5E2dT0ZOOY1Tp1Y489J4x8/qHt2iwQpf1nA==
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9416.eurprd08.prod.outlook.com
 (2603:10a6:20b:594::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 16:57:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 16:57:29 +0000
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
Subject: [PATCH 1/4] vhost/vsock: split out vhost_vsock_drop_backends helper
Date: Fri, 12 Jun 2026 19:57:15 +0300
Message-ID: <20260612165718.433546-2-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1527e209-4322-4855-f481-08dec8a3ae4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|23010399003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	MOOu4E8AvezAaKDpMyph8BnxyZaaNAdmyX9zZzYEOiV7RbFxASH+U8R7o/g6/Qihv3cx3TshnXSUBETvhMb+y0UT8xJFQp48itwHfyPrSUWq0AnVcK4KmtVe99m27M3Jm/g81TS2PaGCQIdFcFYLuGrT6h2g2j6yygaN7qB2ASvX2gDho6F/bdd545G930eysxdyhuD99apsa3VGgF/wYz05ITpo5SrukaU8+HHCXRnSTk74VeAHwrVAQHEYaSugMwOpiFPXE9L6S30tquzO5JDyLo79t3SyugPeBxmkXQHj0QAOVhPhvnQw++ZFfAfA3hNIfUtKhERsURsGsYPm19/fECKcd4DZGTsN6zHeOGrjS5gtifh6utcQuyUpmVfTuyr28r1VfiIODogEof8JFRaHzBeQDNDN+MRd3CCEn88h/1RaTlnVwHiGqqkS3KfrWGGNTueqMjgR6Jx4hKxHs00sO8J2pfGukuUZ1pXjGNC+zmapSMeNKoBGnOTs48zOEVAZf/tvfPKYOCT+M85YewGb1TEIomTsi9qmKXM903Gc49NFLZWwJLKOCgDU/+2WsaEqeVSLbh66t7xcBNJPfsmgiLh7g1jPW1NHdu+cyYv6CyFP1lHJhRjtkADhf727g8y4ToXiFSuoLvIuoA89vGcLk/9rWpAcEI6HyJINYTuuUbBf/ubbA8fDn+//+NLt4qJaYhWq+ayA6TKRH9OigGtfkKt/pnGgtNnJcC8u2JQoxJnoZpwyIxMoILk3mOL5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lxTuX3Cr5SrcjGjgPQbUfw+LjG4Ml4VrwjXrqwKjSZU4ASVQYPYhQtc3dLxV?=
 =?us-ascii?Q?wcbe/gH+5jN7K5ZInD9OpEmk1wphJUqx9bqZRDpwatO/abKDW0cDsFIM2DLY?=
 =?us-ascii?Q?kGUnzNellbCYt2j8wopOyIuin4IXq2bYhI0h10bdKyTS+O0wCuLN/P1RcHgo?=
 =?us-ascii?Q?GAp8X5mrtIKs4J4gFQM1jQYGbg6HfWKDScKBYYngTBz8EHKByrgfOCDEU56y?=
 =?us-ascii?Q?bdzRaSCtx6WES4PfNRCc5FaW9XHiQaAG7qAR/a5HxMY5Gbce+96N2mxsOkVx?=
 =?us-ascii?Q?ggXGWvw23YIaJ7IbMf4ekhu+i4kfPeoKPBoi9dXSIjBn/iQdJeoseLN0v1yI?=
 =?us-ascii?Q?xDCx2uGJzBdTjoM1AuKk3HTkthHaBv+8Az0aus1Lqqhg9DS+j3sBWWBAs+y1?=
 =?us-ascii?Q?YHLx8RO4GHVoBWTH1tH0lNCp3xWmzT5CiPLOLhdfr178y3oHOHWK2GFBksPI?=
 =?us-ascii?Q?PvpDPJea0c7AL/ZkW04So/h6DEa4ukkQr/1Vxnvb1MSv88hEODywfSpe+19p?=
 =?us-ascii?Q?9DR1wkZdlwMJ4TdPdCLsehppJkk1QqF5FtauvSmMH7jr92RyXTwyDUi1mJ4D?=
 =?us-ascii?Q?QSnofaflD0JVNvHAfjx2lkPNPfEKzV/rVSX9s1vXE8iQc33KKKVH7ebL7CyL?=
 =?us-ascii?Q?hAu6T8d7AJH9wbd0HcpBFCNtxbyUTZQoYcRQarSCP6xDfAiVBo6pidq9/cWP?=
 =?us-ascii?Q?FfNXrnSOZ5BTLpzITmGBkFoL41PiyrruQVyE4mc7pulFbYcOkwgSWPG7eGDU?=
 =?us-ascii?Q?Sbp9utLa1cysNrshB+0rhlX5aST/G5gBGSW+64o8lqRLkn7ISO8ub0R2JouG?=
 =?us-ascii?Q?GgnLuzrygROOD1z35rZHlP39GR7uWs0wTo1lcz9nr8WpiMPtR31d+DMc9JPq?=
 =?us-ascii?Q?Mojx1ymRUg6wTzirikWqx3R3Kvezgv7QGXqgKvhh2rbx7cjEWVjwb2VxuMRJ?=
 =?us-ascii?Q?MjwMImDFlE7wzuyVTl50x6WnQdDx38DaIe2BnYF/HBC2fT45aNpABQyqsg2N?=
 =?us-ascii?Q?bAwphWfdIdxW0e/nESZ5N0Z2LyivDCXIYlSWXSmZTnC8RojE+Yq3/sNpJYoA?=
 =?us-ascii?Q?q/sHyD+r5kUFVm/6Ng0IpW6JMugtQ6rs8rDTI2OSdx1faOV611/+i/vQGUSB?=
 =?us-ascii?Q?c47/2mg+xdOwjogFGtxxTSvpZrg/pl/5VHBbyFI2EXPWvDEMdEwmwQ5+smVw?=
 =?us-ascii?Q?z9AzTj1e4S4T7Hv2TsBMN6pUyHhryOyN1LFVU2BmeLSzEHJeltThdqwBIkb/?=
 =?us-ascii?Q?r74HndVSiOJsBZR5H9YmdChHBc9Wx3ZajE4O7+6I8pBPM9Th56UPH2+L873c?=
 =?us-ascii?Q?6d49zfuuqV7uM3UvFVbbTVTLUiPKSAteRhUNHfRqTZWV9TlCFW9MLUP/JzS6?=
 =?us-ascii?Q?YhoJRJdAMRqipx7xBtV7NaGMAHjLi9NQNKpuJFsPIHT/gMAF4sB/ekGDMjeg?=
 =?us-ascii?Q?H8xmv7SRfJl95pZHHR2cII33syf7Q4t8NED2RUKNJdeVeqw7IUSpGajB1srr?=
 =?us-ascii?Q?xl22Cm5bkR2/5H3OeXD1JT8XwCl3LjCkeOosrtcse92zwupzt8/dqdfgsVvr?=
 =?us-ascii?Q?sPORMNYDgzfcGyQ9myxIMlszkmWhKM1BAjss0ExDLIBOOtU+4fzLTF7gj36l?=
 =?us-ascii?Q?Gtw5ufmpIqBpm5ARZW9Ikk7B1xOx48UbincWqLiwrjsiblvCCTF2nqOMbZ5E?=
 =?us-ascii?Q?ao/5Fc6UoHutuluTT4HBuwcb4144mAT1fvauNEq2HJUUvjYItn/mXCAsBgrX?=
 =?us-ascii?Q?WotIwWzIqnPJs64ZfHVgWq7fDv1ftY4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1527e209-4322-4855-f481-08dec8a3ae4f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 16:57:26.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5tySfwg6fAyF+cLwd2Wtg5jqZb8g8B5xHNqeaVO6c3tY4ctihL/bMV44f/K9HiIFnDEOUyMF/aTKeLY8i/5ys82b0VvPFfZ4ZtteASkeZQ=
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
	TAGGED_FROM(0.00)[bounces-298739-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,virtuozzo.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCBD467B223

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Split the actual backend dropping part from vhost_vsock_stop.  We're
going to need it for the VHOST_RESET_OWNER implementation in the
following patch, when vsock->dev.mutex is already taken and owner is
checked.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 drivers/vhost/vsock.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..b12221ce6faf 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -664,9 +664,24 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	return ret;
 }
 
-static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
+static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
 {
+	struct vhost_virtqueue *vq;
 	size_t i;
+
+	lockdep_assert_held(&vsock->dev.mutex);
+
+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+		vq = &vsock->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vhost_vq_set_backend(vq, NULL);
+		mutex_unlock(&vq->mutex);
+	}
+}
+
+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
+{
 	int ret = 0;
 
 	mutex_lock(&vsock->dev.mutex);
@@ -677,14 +692,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
 			goto err;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
-		struct vhost_virtqueue *vq = &vsock->vqs[i];
-
-		mutex_lock(&vq->mutex);
-		vhost_vq_set_backend(vq, NULL);
-		mutex_unlock(&vq->mutex);
-	}
-
+	vhost_vsock_drop_backends(vsock);
 err:
 	mutex_unlock(&vsock->dev.mutex);
 	return ret;
-- 
2.47.1


