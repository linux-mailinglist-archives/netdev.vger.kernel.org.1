Return-Path: <netdev+bounces-288286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHgnMLoIB2qcqwIAu9opvQ
	(envelope-from <netdev+bounces-288286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:51:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829654EC9C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D222130BB71B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDDE478E3D;
	Fri, 15 May 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAhu/XEc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F022FFF8D;
	Fri, 15 May 2026 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844705; cv=none; b=UAf8XMkdsiqVqVAJq3SOoHkjujN/1zKyBAOe8a63fy74YtHTgYAnMzyEpuMsf8+SJ90x6HHDl8et8Rl1OMlBTWRkAbNKv6q0yQl6/c61uJEUUfoOyHPETTq9hd7fHPZBlNn0Puq9GBGn4z4QrN5cLEtV5nWWSdced1V5+/7uDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844705; c=relaxed/simple;
	bh=9UMwMoC+MEKv+MhrDhEiM9ppsniOk0mrpvgJ/t/dXpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qP8ImwVXb56L41lYBi6EVlhzvEbug7y0ZTaFHzzAENDnhhVauqumeCWDh+AHRHiY1eW5eihOakjiFjSf59EIEFguPfI0Jg5BapVg+/cvOVDphHu8y64go7/B1iQsTeYq02ZchKtRGU74HjTKXutXuM+9O7/tGo8B11F8XfguptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAhu/XEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296BBC2BCB0;
	Fri, 15 May 2026 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844705;
	bh=9UMwMoC+MEKv+MhrDhEiM9ppsniOk0mrpvgJ/t/dXpQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mAhu/XEcqoAp7sfKM4XVUwipya+8pjHngPk9I7nCEIDCa9fb6eEhOBYPHaEbKxZDC
	 ylYmWJTT1iTPYA8a50MvvI3DAAt9eEZdd+905BoVc6C/tebfBHShpnprP/ByiqUKT+
	 2DzpVAHu2H7kRCC2mc8cuQD3M2FY0ZaH1rhyIEpepfLAXxYALPJq5U4M3QwnDk+g6o
	 k2f8n6B8BkkfGpTsi9/+CAGLlltL2tT9N+ES3aJL2Lt0+qlig38jraTwwR3Ix/medl
	 +PG/KSa5JwpNPISqsbjXSQJi2H2k8QavpOQ3M35LNlq6WBJ5Y8Y9VvkhCi9Vo4vgMX
	 uFycKmV/NoJnw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <kafai@fb.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: test_run: reduce kernel stack usage
Date: Fri, 15 May 2026 13:25:37 +0200
Message-Id: <20260515113102.2389020-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3829654EC9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,fb.com];
	TAGGED_FROM(0.00)[bounces-288286-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The xdp_test_data structure is really too large to put on the stack
and results in one of the largest stack frames in the kernel:

net/bpf/test_run.c: In function 'bpf_test_run_xdp_live':
net/bpf/test_run.c:387:1: error: the frame size of 1608 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Reduce this using dynamic allocation, which avoids around 1KB of
stack usage.

Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in BPF_PROG_RUN")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
found while build testing s390 with gcc-16, had not seen this on
other architectures before.
---
 net/bpf/test_run.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index c9aea7052ba7..763891df02be 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -362,27 +362,31 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
 				 u32 repeat, u32 batch_size, u32 *time)
 
 {
-	struct xdp_test_data xdp = { .batch_size = batch_size };
+	struct xdp_test_data *xdp __free(kfree) = kzalloc_obj(*xdp);
 	struct bpf_test_timer t = {};
 	int ret;
 
+	if (!xdp)
+		return -ENOMEM;
+
 	if (!repeat)
 		repeat = 1;
 
-	ret = xdp_test_run_setup(&xdp, ctx);
+	xdp->batch_size = batch_size;
+	ret = xdp_test_run_setup(xdp, ctx);
 	if (ret)
 		return ret;
 
 	bpf_test_timer_enter(&t);
 	do {
-		xdp.frame_cnt = 0;
-		ret = xdp_test_run_batch(&xdp, prog, repeat - t.i);
+		xdp->frame_cnt = 0;
+		ret = xdp_test_run_batch(xdp, prog, repeat - t.i);
 		if (unlikely(ret < 0))
 			break;
-	} while (bpf_test_timer_continue(&t, xdp.frame_cnt, repeat, &ret, time));
+	} while (bpf_test_timer_continue(&t, xdp->frame_cnt, repeat, &ret, time));
 	bpf_test_timer_leave(&t);
 
-	xdp_test_run_teardown(&xdp);
+	xdp_test_run_teardown(xdp);
 	return ret;
 }
 
-- 
2.39.5


