Return-Path: <netdev+bounces-302018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sFXMElBPPWpY1AgAu9opvQ
	(envelope-from <netdev+bounces-302018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:54:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 047FC6C7313
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:54:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=virtuozzo.com header.s=selector2 header.b=R9UY3B7M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302018-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302018-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=virtuozzo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCFAB3042536
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C081317161;
	Thu, 25 Jun 2026 15:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021117.outbound.protection.outlook.com [52.101.65.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458D30E0F2;
	Thu, 25 Jun 2026 15:54:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402886; cv=fail; b=MVidnkae9ceKrq0jyqdt6mw913vu7StT0t9UJUK0cyalzEg3Ra06XCtJ7YuWnOChrSBChcIOdqqc3UQohVr5BDlEjz62xEU14Pkoa7uSqNIkba/bvlW7YfdDS0AEbuU8UoACttkA+C+hHDSYEvnkDUjP5IdRfjnWyP+N/UjT9ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402886; c=relaxed/simple;
	bh=L/BojsP8yyI0nb57Z+qZBqGasoSyA7nlbAPVDdZwjek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2pockA9KJ9gI2cBCVHFdR/7FssLB7S2o2PbulDWDsLcNCQC95o4ks8rIZ+7jjJ9R4raWo/909V5w9UargjBH2tSdN13ihESJdEo/26KPW8X/iCQtVc80Dakc2KgqClL831nPGsU12n9ITXVeFdM8lShdikbdD+lr5HXsqIA/gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=R9UY3B7M; arc=fail smtp.client-ip=52.101.65.117
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yb0YmqbskegST6X0bI+QHhMuoJN8NqvhseA+efRkO3YAE1rWdzLQOiOw2njT6GIacj7TOg0hRh3A2FnJItb2hMjKG4dCceKAaS3q6tIRq2NsEF4ksd0Nki6R0OfTNMDWv0UgT7TOYZNzwYvRwz2Hh3huLAbKJnv3jkp/ZlXZzJMSPx1gYBCwiZ6pfRc0yO/ybFpa/sl/rHXYtq4v7XH2nJICn7zIuH2e2pRqe7UbRW9vRG72UbueqiIaCRvmDv24YhiPmNW+pb1CnkwZ5SNELo2FcShaNf/ZndDkSdyHY1aGePeXMuqECatj7X9WIyC/4E11Bf0r21lrrYmSCEFHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rHYF1cIDMgIwJGrKADhWGbf7I4iCXiNFVVC4wuY/yk=;
 b=qludm551c+KEk1vvYfFIsSPKDkS/jk2o52CpNXrOoMhmGRwnWqSzTm3ePMF03EyEleZI0JLzCeQ9DWUtUklYtmrZhgsN+r84F6LBvDCBlK/tCtRk/XT24koyug0x66BQpc7/GgxFrcWwwXN5gEvPE0U6YHO8KxNvQUiKDpzrBfY8o41pAoKhBB+zMC7vBJ/JYt+vaDKOgwKVjrA9xV/jThHABST0Pf9tD6mR6FmJxjm4270I4YXA5CKIZJfajE00DFmd2Jp8WLcqQiJ1jIZwHutQT66DE1icuQkG1YCtLGERy1RHqX31ufT+NrYzF7Uxl2k4EJ/LSyWXgl1Y0K5Jkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rHYF1cIDMgIwJGrKADhWGbf7I4iCXiNFVVC4wuY/yk=;
 b=R9UY3B7MupnqTM0670OgbMKcD1F617z/br+ZYxeDoDKhAEDGnJdbUvD8l3b8ZWOEYRzY8u5xQ6gPFQkjbKiB3FIiJGlSOBjksnNL8z3deZC2HTyl6ujGOkrx/3KMrxk8h8kCTr0z5w+hJ9rFHGr7HREtzHf/gJZKH1cZBXVvGfwWjD+1jJJlDkkvaYZDa2QQ83fR8CndB9W3RtNhCynard3BvTPkHKfxZdbKIZ26iW3HJQQv/QvzmaOrckOPgd1tUkF/q4UG+2iyp/ePqhVd9kmxql1nrQO15jvm/zaS83R9uH4C5I9IsAHJJLM8nxy+x5mnDb5MNANz+kmgnHtE9g==
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
Subject: [PATCH v3 3/4] vhost/vsock: re-scan TX virtqueue on device start
Date: Thu, 25 Jun 2026 18:54:15 +0300
Message-ID: <20260625155416.480669-4-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d8fceac-678e-48f1-36ce-08ded2d20bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	sbotd0Jyd/qylLtSljRxL+CaVOu5fo3Mt27tecPfKaAXK3mVb0cbMNcVK5TDOezEivOQ1c4qJpPFFlRolCDj/IvFth9YPMgIycWsyvhO54UBVKxPtqwhoWYGGuX7AoXfrkIskIdzLlpFf6EQC+T3xLzPFF5qokZHOBLdAnP81tVfILsIJNcx9yq1p2nq0e0eeyaLK+jxLkQf8ZCfpeoVNa+xQdCQrAL1rb6pYP5BLzKbkHzkUGDYHawRPDQxfalrLUG1AtUdgZUegFtLqER4IGJaq0/TDCT2H8Ot1UdhFr2Vl3ruMoOuqeR8txTfH+W6d8/tTCIWMay0DKTO6wKLsynNQVCuPjZmA0ObPfM22bo4d7W2+spXhviPx/HaKGIoX/S5BMnW0BdGL+9zNd1uDxiclZNVdJWLHfONmwsPMxKIpAkGDhL9KJo18uVHpq//kZ5AnGD5mMSx2t56Nwd4RaN9Ob809inzsViMDOo5BAN/813bArBg3r9+7m+/vOwHrquhrXAD9plVoJrvBRDLlidsm5fpjJAcDmEXDaBq32V72yyG5Nfb7hx6XpddvCx1t6UsUQeLBpb5FHmwSU9YaLkXzYGdIOOUV3R9rqO1wqG/tWoFg3LJSdT+r/6dhW95kLrD/h3M1FL9PbQkw70wPdLfIxD569SIfYYUgclByFae06pvLs8+gsX3YcZjq7hdWjU8PZ2jNvO9lyvEGwxpHIL3ux4gC7is1CuVMsDfx+Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(18002099003)(22082099003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bGzfPjTC0kvGe1tDSwGdjtw5MpujnEb97arpyb0OJ0dzJn32XKgfmaC+2HK7?=
 =?us-ascii?Q?+jYePkeOV/plJ0Dy+xsq3rbu097eSIIP2RtQkuWfizNzos8FCpbymgitrMlm?=
 =?us-ascii?Q?XfqNY9TiBdafcC2agFlxTYWQz0HhYHSatinqTUN+ZRWID/+BJ3KjJ/JkRJJ+?=
 =?us-ascii?Q?IbWTVN5htol37gng9LOXoeLhNWV20RZ1L25lxmCpaLM75sySJIzg8xQbPy0j?=
 =?us-ascii?Q?FfOeCRJHgo/vWd2/DzIGLt/hrNkrLRL6ItROW0keol1ZvsKC4rP2m9X4jPzR?=
 =?us-ascii?Q?Ob1RByiOFO0aFA2PLutBizTx3cRpESWaRzOFLtqdfRMQtk48TZNVHesmsMKG?=
 =?us-ascii?Q?r1PPq5fKvZqtc6NKQQti0tOfqcri2eZYnqXINPgu5ytZYKxIvtJimDTPDA7L?=
 =?us-ascii?Q?sPA3A6mPEF5kiiybUflC0jzhB3C2CkRlDqPe/E4nlRa4v17WavmX0ivAuX71?=
 =?us-ascii?Q?JYlMNycdLtSGjvGKKEMSUjLIkB0DXVTgcvHqz28p8ksg5zs7uddk1VZmhasn?=
 =?us-ascii?Q?W3YGl3m6EEhrGnJW8eLxKkL+W5U014mcFYYG1IW7lHg2i6gToRgr5GY8Z149?=
 =?us-ascii?Q?Jyyar5uE6yeezCTdnvJK7/DFMqzmkJBZcZ+WxG8XCMlvV4kc0fYdWyapKaNj?=
 =?us-ascii?Q?Jj0w3yD99IwVONkIJPsXBkGeZ39UtR7KZmUOecdUnpiytEokeRB63PB6z2/S?=
 =?us-ascii?Q?rSG97YI6/iw3qiw4rHRaIdKqCCQojVU+qvS+5ert3ctdpvgqdf0YC8vSPdz/?=
 =?us-ascii?Q?s7/9LlLGcsmO3IA9sVvK99mqQNtxIsAzSBb+fCR2aVrMct/V5CEwce1FlykS?=
 =?us-ascii?Q?uYtKuexvVMKD5gxwdYwsKpc92qTYAwIZ63++SRVQr27WDedNilustiTVnMA6?=
 =?us-ascii?Q?tsTJQpbBnLgVNRsNtFHWTM10DDd8YyFd/uHAywMiorfm1qL+4KtAQJrHW92D?=
 =?us-ascii?Q?HMJSxk3toGvyLhtMMWrN7CdVUdi+76VbTjAVNKamr64Fcy2pTEFmN+Yx0xe2?=
 =?us-ascii?Q?cn236yX4nNHFbHHH5OxKWbjD+AU/5wYvyHlEYinorhEOYyAdJ+G3zGwgsm0O?=
 =?us-ascii?Q?rSg4Rf63IJhJtBkqXlqtHI8j372YZupps/JE9JcpAtf33XTqYoZmoPuAReaq?=
 =?us-ascii?Q?i6G40NRcojTc9vajaCYJZd34zD0qZJdKmRfdrmuTO3lbvW2jc5RSk0qjH9nA?=
 =?us-ascii?Q?UBJnBv3FqKHpZeg8T7WZt3aPKOcy2jWbVqyTSWTcKQ0OiouT05OZtAGiYvh/?=
 =?us-ascii?Q?kXVfy91woH05qke42cgBzs8xT1Kcnid7UvNWAAaBgu0Hxwea1Pu9w8JWr9GQ?=
 =?us-ascii?Q?cn4xA8TMOxdvZTb4XO+rQCvWgMqqcEosAd5gkfxaNsPR3zl7rMKt3uqXqQD9?=
 =?us-ascii?Q?HKVMNkNG7xC+AXHru4TjvswZuWGG31YDlVIUY6ZwzuqZw45gWOhTYxD/Ismp?=
 =?us-ascii?Q?J6IkPQ9lF5QK96CEe/PkKuCMBtJdAnoAi6BVGBsSttn7yHmasYeuyt5SezwQ?=
 =?us-ascii?Q?XKAiNEHM1+YtpisL48F9mmF3NOAfgRWQtH58x4pwhj/Z5mOKNEOZQsYohqfs?=
 =?us-ascii?Q?gUEPW8bPm6j39IwApjvGstV6AKqImSBbX9IIaEbyXMGVaocW9KY6uXDISPEC?=
 =?us-ascii?Q?n3/zVJE1ifyyGxh//YZFfcDzHvOk3LQBOl3Dej3CJFIyZCrq1xVcByyAZMqW?=
 =?us-ascii?Q?fLPXsQ6rQuumaDsebfYIsp3VK+NL8Uwbpd27eANDQhaHS6ywiW7FZShTRkLE?=
 =?us-ascii?Q?IzwzaaOwCiYlFarsXunNxiMU5hz+4rA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8fceac-678e-48f1-36ce-08ded2d20bf5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:54:32.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99N1dAy7hvuRGCrryb+ej3oOZU4iZCHOroehuQtm4BvLsBTuDeXV/Ud2QxNWHTaEErs2JMfsxtrxvC42EOYar/NBj0qlizvoos1/Un3vV2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,m:andrey.drobyshev@virtuozzo.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302018-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 047FC6C7313

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

The issue itself is pre-existing, but it only manifests during a brief
pause caused by VHOST_RESET_OWNER.  Namely, the deadlock is reproduced
during active host->guest socat data transfer under multiple consecutive
CPR live-update's.

To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
queue the TX vq poll so any buffers the guest enqueued while we were paused
get scanned.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 drivers/vhost/vsock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index bec6bcfd885f..81d4f7209719 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -646,6 +646,13 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	 */
 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
+	/*
+	 * Some packets might've also been queued in TX VQ.  That is the case
+	 * during the brief device pause caused by VHOST_RESET_OWNER.  Re-scan
+	 * the TX VQ here, mirroring the RX send-worker kick above.
+	 */
+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
+
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
 
-- 
2.47.1


