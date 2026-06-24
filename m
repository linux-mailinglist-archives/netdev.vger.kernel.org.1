Return-Path: <netdev+bounces-301663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wRQMBjngO2pneggAu9opvQ
	(envelope-from <netdev+bounces-301663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:48:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 631036BECFF
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bEDtwo9z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301663-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301663-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4017430F2AB8
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7213B8130;
	Wed, 24 Jun 2026 13:45:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C722DC350;
	Wed, 24 Jun 2026 13:45:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308702; cv=fail; b=Msu09aOeNpWWT1B8/1OLxCzoAQ7Tgam8B2syVtA4jf/k20VqWkn2XRVh//YIdKzg/Ooj3j8JN8Eo/vgGN8Ci71J3DsQyrtsIyd168jyaZY19YPEP87vcAJXPaT61/7ZVg/iWsCu7TE8NtzLt1BmOO/KueKnxcduaRbJWIxXAg0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308702; c=relaxed/simple;
	bh=LgWSj0p/zzENec3beqLPjz5NlhmApjDXBhBbqoPLR3s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=afA30ZJB+nXDfkErHI0P+ECKFc4g1UcRoVCBqTxRmCRvMb6T+ynBqGG84qdxVuAjk+3gn3KmJxUjL2XLmEskeEIIa0VqSi+1oyrWKZFol4A+1N5rbuDd/OrSavkMeVWZxdq9hWjVKSW2rpyefmLNVWTCihELUoOlfHXlvE1j2hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bEDtwo9z; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikZvFUFtQkyNUsccI5yOjuFK/JNIxwXpeZyfqgqaFDsCntpzL4pbbreJkXmMyKtCAm10drTGlj5rRNTqG9zF/BAZEKObvYXawm3YOIYxKR5qy2ZAkHImGWcYaRmRpPeTkIJyxA1Jo1f3wBiuH9G5WaFPaqOynMO4V8TBYwSMcZw3Kx6rh4+zOJTMblWIUR0c0Dndi9wDELSxgxNqDMU6lKqezV+2TikC7dEgBFsIPRdqw6dhD9Rg1VIsuPZsG9kxR05KNArRQzN8AivuPdcDWIeVz7SIb1rsQn8+wxYULtDfiqJRahdzblXCpmNpAmxje9Sq59OynHgpi1TZac4Ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD9qE+jv6NT5diyP31Vqbex0XMnCLhH7EoclC6175WA=;
 b=oLDkH24LvjhJXlsR/BLYWWbiVwS55aL9ZcdcQNwVYgRzV4gPZ9o60QS/3+1X7JSZU6LpYBGv3vIHaUltKR8u0v8U5HKvOsPb573ZHu0bc7NybuccAGj3NJ+E7XpAgVB6X11cvyY2ncE/JhCkHlqkLhjQddw7pZQt6B57aMHMXx1aSNv9Llu5ZbI7c7dtu77Pc/eIh++PbWGMYc1uLejAAd5NVlycS3xohCIJ+ioSi0wVklzDqR7RTReO/eSqCkSWa3LTKlXpnD9J9PRPQgOozlDgrnujfUDRcYe79ooBU93VNKDjq9AKTh83E0F2oaNVbXNCq07TyTKl33rGo9+kqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD9qE+jv6NT5diyP31Vqbex0XMnCLhH7EoclC6175WA=;
 b=bEDtwo9z5ds+HSxXN26EPsGKFAJeyp1t42CBTjUykm3fSiG/TxAPAXDe+0mUVY2Q92U9EecmzUhAM2k3haG3KOnvmwR8sE9sGQvFnz2Dy7QYcHofGMpqbZMFa73StfoMVJF4WKlweoyDRvzheu0XTy4pUyElMc97tqFa4uYFjhbG/g3N/TrH/zdDo6//u0O3A9q0iWrGwc9p/+Mgt+IBtv6cno2XPtZNE74Op9qlHftJjlV8dmtzsNcrjCPNkUzJG5KycJYhqb85bV4qSpJaLI2UtJZupv7zghrSpANaNCPja1bfCUDg/DFLm8qhbv+zer2nDHTc2+Mlt1MvggD/Dw==
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 13:44:56 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::29) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 13:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 13:44:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:44:30 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 24 Jun 2026 06:44:30 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	John Fastabend <john.fastabend@gmail.com>
CC: Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nirmoy Das <nirmoyd@nvidia.com>
Subject: [PATCH net-next v2] selftests: tls: size splice_short pipe by page size
Date: Wed, 24 Jun 2026 06:44:16 -0700
Message-ID: <20260624134416.3235403-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 259b76ad-f5c4-42f6-edd6-08ded1f6c70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	OOygJeGHQXvqVhHl9Q36RLacIhXA8N9YBrtBjj2KlIm/htRKz0uZ6tbL9cbxF82NZRQCTUef8bzGGrD9QPmuJRaNOFkBPi2lfpbI6l7u/cJT3QTE4VF8l8pa3tEtcNle/AWjmJDkyVHyjMiC+yfJ2m3xFGcCA2DfV1xGkVCoRhCVtPPUp3rl0lHWIztXkj2Rqh8InmI7phG7PusfAXi4jbpBAF1afVKVbIBicNrM9JzK3YseEpd5+0LwRzw3Zr1shPVkXQCozBHRLSHuf1r5nMIntLsM1qAbvnSreNpQCTxGlK1wRrY6Iteb2h64BsabzoaGw4M1hQEMH+orzdnXK/QYBfFbzQhUyoZH39biGT6mG4g7tXbOJKW6z3CNdgYVQNxO5YWN6n6eP+ZMwkE14TupApwoTgHmjZKkeWOYZ/+iXTmiVO5boehXIXnp62s6Y6syC+HHqjMLenDyofBaw3135bbhLMNshI/6uFK1g7Yc/Uld23LFRvzlKDi8QRHYDXxBcJ1kvqt72qrQqVJM79wMLAea83i92p5innNSzl6dncLolinSCQckTKGl1soohEvMyS0dpx7B0f4rnzZ+exLug1HWE+TEMXbG0Hz78/qVPI0sDfrpTJS/0czVSDiXcMPKoIwkRmDkt12VyeNi7qhaB1JNDoN5mqRY+TFddK14hUslo7qO3kzwjspcy8Drp5x3xIltyxArvEXAryIg8A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c21a9Uanxj9TXlXqwoI3J4UM+vUHsLAqT5xmZwvbWV3+6Uwnzb14OC2W77ZsjGKV6hrEkQA0eFs8G5vdvh+k3wOnyHXO7lfKkucpb9NPLEZBOfSVL1sT1z1Ac4G6F0RGCK5axjiA5Hq7LQqEtuhWfwKIeO7XqKVdMrWhraZeyLcahovQ8dbQWlN2QPYgGIYghYRYZfcrR7ZSUM9n3GD3TaQkFt6o9PBfJw5gUWkD7+TjyUGhmhU/50uJyu6THx1Kqmko/SI8iFrOVFHx8vM14my0lO9qCb9hX83Ntc4CZt7aJ4oXvGfznzrIxTwtyIgKO5i3ve98CeNKTnzr2GTBqXcPqa2WiMEqO3wXdlIgL0Kj2zNBTFF67sDT654KcX9u2H2x5tk98D7R5d86FGOAlieRIWBg6Nk32HYi9X3NaAxnnQhWXwXkHJOLewnWDzRU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:44:56.3109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259b76ad-f5c4-42f6-edd6-08ded1f6c70e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[nirmoyd@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:sd@queasysnail.net,m:john.fastabend@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nirmoyd@nvidia.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,queasysnail.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301663-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nirmoyd@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 631036BECFF

splice_short grows its pipe with (MAX_FRAGS + 1) * 0x1000 so it can
queue one short vmsplice() buffer for each fragment before draining the
pipe. That assumes 4K pipe buffers.

On 64K-page kernels the request is rounded to 262144 bytes, which
provides only four pipe buffers. The fifth one-byte vmsplice() blocks in
pipe_wait_writable and the test times out before it reaches the TLS path.

Request enough bytes for the same number of pipe buffers using the
runtime page size, and assert that the kernel granted at least that much.
If an unprivileged run cannot raise the pipe above the system
pipe-max-size limit, skip the test because it cannot exercise the
intended path.

Fixes: 3667e9b442b9 ("selftests: tls: add test for short splice due to full skmsg")
Assisted-by: Codex:gpt-5
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: Remove redundant ASSERT_GE(ret, 0) (Simon Horman).

 tools/testing/selftests/net/tls.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 30a236b8e9f73..d805a7dfbdd51 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -997,6 +997,8 @@ TEST_F(tls, splice_short)
 	char sendbuf[0x100];
 	char sendchar = 'S';
 	int pipefds[2];
+	int pipe_sz;
+	int ret;
 	int i;
 
 	sendchar_iov.iov_base = &sendchar;
@@ -1005,7 +1007,11 @@ TEST_F(tls, splice_short)
 	memset(sendbuf, 's', sizeof(sendbuf));
 
 	ASSERT_GE(pipe2(pipefds, O_NONBLOCK), 0);
-	ASSERT_GE(fcntl(pipefds[0], F_SETPIPE_SZ, (MAX_FRAGS + 1) * 0x1000), 0);
+	pipe_sz = (MAX_FRAGS + 1) * getpagesize();
+	ret = fcntl(pipefds[0], F_SETPIPE_SZ, pipe_sz);
+	if (ret < 0 && errno == EPERM)
+		SKIP(return, "insufficient pipe capacity");
+	ASSERT_GE(ret, pipe_sz);
 
 	for (i = 0; i < MAX_FRAGS; i++)
 		ASSERT_GE(vmsplice(pipefds[1], &sendchar_iov, 1, 0), 0);

base-commit: 47186409c092cd7dd70350999186c700233e854d
-- 
2.43.0


