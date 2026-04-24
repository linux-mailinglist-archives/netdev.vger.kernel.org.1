Return-Path: <netdev+bounces-280978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAr9G0VJ62mWKgAAu9opvQ
	(envelope-from <netdev+bounces-280978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:43:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C214845D488
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D09D6301F4A1
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A55338D019;
	Fri, 24 Apr 2026 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uvDVvc/A"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A4838B7D9
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027354; cv=none; b=N2QMUxLI6WqYx2brIOn/tktfZiGjCiVj8tIoJGp/mOO7KcO5J3RL+gUiue6tOXQZPHgGbeVvKsllAg9Nh4+zwoqasqRevhig+KMY11zja0iC2WdJE62BCVpGisUPgocv/K5ZtKTKswA1HW4fyrXOlhZj8Tjta4ERBE2MXIehbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027354; c=relaxed/simple;
	bh=KYN5vQK9o4itUNm01aqvLz11z6UGNL1p5CAu4M7+vn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCHAwE00QztJeJ87AuRxnU6T0wfbahxOxqfsHtjO9bAnrUjubWgo2sX0YYgn5cPHSimQCym8MGguzxMAzCVjNhyUc6q0fOaRBCij1Wu1BywnJwsfsgAg+RqqLu5bwJlnCUCbGtJILLNBAhcCOj3CRUU331TbYjmAyfJJ/29BXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uvDVvc/A; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777027349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/a9gKZ5swoURq09zQknYGoxq1uz7/i9spgkhwJ2l2tQ=;
	b=uvDVvc/A3ArsBiQ6LZAuJ35hbQrJfEwtrbrZr8Q94B3hiLudKd1nEAVKVtfF8TGMq+wZVM
	+Ucx0nJ3s7Q8x/Gs38jO8ngmmiSsq81avcxF0phDu/uGKElmmE/0a+NW4kLQynFcneu4hk
	9a8LI6WRj3YmFJc4I3YvEPQ3jKcEsDs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 1/3] bpf, tcx: reject offloaded programs on attach
Date: Fri, 24 Apr 2026 18:41:40 +0800
Message-ID: <20260424104201.217604-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260424104201.217604-1-jiayuan.chen@linux.dev>
References: <20260424104201.217604-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C214845D488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,hust.edu.cn,iogearbox.net,blackwall.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-280978-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,hust.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

An offloaded prog's bpf_func is replaced by bpf_prog_warn_on_exec(),
since it's supposed to run on the NIC, not the host. But tcx doesn't
check this and happily attaches it to the software path, so the first
packet hits the WARN.

XDP already guards this in dev_xdp_attach(); tcx just never got the
same check. Add it to tcx_prog_attach(), tcx_link_attach() and also
tcx_link_update() so the fix cannot be bypassed by loading a normal
program and then swapping it out via BPF_LINK_UPDATE.

Use bpf_prog_is_offloaded() rather than bpf_prog_is_dev_bound() +
bpf_offload_dev_match() (as XDP does): bpf_prog_dev_bound_init()
already rejects BPF_F_XDP_DEV_BOUND_ONLY for BPF_PROG_TYPE_SCHED_CLS,
so a dev-bound SCHED_CLS program is always offloaded. The simpler
check is sufficient and also rejects attaching a program offloaded to
device A onto device B.

Fixes: e420bed025071 ("bpf: Add fd-based tcx multi-prog infra with link support")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@hust.edu.cn/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/tcx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db0113b8e7c..1144627483d53 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -16,6 +16,9 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct net_device *dev;
 	int ret;
 
+	if (bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = __dev_get_by_index(net, attr->target_ifindex);
 	if (!dev) {
@@ -209,6 +212,9 @@ static int tcx_link_update(struct bpf_link *link, struct bpf_prog *nprog,
 	struct net_device *dev;
 	int ret = 0;
 
+	if (bpf_prog_is_offloaded(nprog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = tcx->dev;
 	if (!dev) {
@@ -315,6 +321,9 @@ int tcx_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct tcx_link *tcx;
 	int ret;
 
+	if (bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = __dev_get_by_index(net, attr->link_create.target_ifindex);
 	if (!dev) {
-- 
2.43.0


