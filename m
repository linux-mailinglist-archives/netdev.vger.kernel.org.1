Return-Path: <netdev+bounces-281113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHg4H86e7GmtagAAu9opvQ
	(envelope-from <netdev+bounces-281113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 13:00:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60046604E
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 13:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F1563003D05
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2444A33343C;
	Sat, 25 Apr 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jkt9yDDz"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5530F7F2
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114826; cv=none; b=s+ccLKnQwiaLiyN1rK+RHc1LZakpRzzF/tEOaFhhXlHz+r7l8+R7yE+15nN46hOY3nKi6nB36hCxrjzon4FhLMGd+K4kBi00LFHndgIuh0gi0NhmPz4T6QgrWccA5rmVE0BgdzBFf+3PYbK65nmVE4eqWzIcu4ZPnMHDo5BAIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114826; c=relaxed/simple;
	bh=w2LCY/0Y9pS66aRGDAL5zzSoVn8UqImz/5AFiWfll/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt0AZJYKdy0pQc8NNUYazDt182PXvN2DrT/niZ/pHPcZHrmAeo9HuBOJHW8Dl1o2+7BBe6aoK/SKIkCnf5q1E0v2m8NpUB/dMxhI6zo6UEIGlqMuYOH6vMEnGGqVv+mByK6BzbRna6UVSM0u8O6KRHoA9gAG9LSd/oSsBOOTr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jkt9yDDz; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777114822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dv1nqX9pl+QS83DIlKgQtMErP4cw097MHr3XQmGaLCM=;
	b=jkt9yDDzRuFvPEQE6rfgQLgRqrZQ8AZz15R5qjw22Z8i/r0oBE5QEwMHOKyHuMFezVt08q
	NiCYsBrUnk/MnhVDJ11US6bVMKbkAY0yO8DgNUdd7fbFFQTCfF97AyNnD4wSFENh4E1OYo
	kXCf3M5W5pstolvisK77m39R5D+7uWk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v3 2/2] bpf, xdp: move offload check into dev_xdp_install()
Date: Sat, 25 Apr 2026 18:59:29 +0800
Message-ID: <20260425105942.223757-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260425105942.223757-1-jiayuan.chen@linux.dev>
References: <20260425105942.223757-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0E60046604E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281113-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]

bpf_xdp_link_update() calls dev_xdp_install() directly and bypasses
dev_xdp_attach(), so the offload check that lived in dev_xdp_attach()
does not apply. A user can create an XDP link in SKB or native mode
with a regular program and then replace it via BPF_LINK_UPDATE with an
offloaded program, whose bpf_func is bpf_prog_warn_on_exec(), tripping
the WARN on the first packet.

Move the check from dev_xdp_attach() into dev_xdp_install() so both
the attach path and the link update path are covered by a single check
at the actual install site.

Fixes: 026a4c28e1db3 ("bpf, xdp: Implement LINK_UPDATE for BPF XDP link")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 831129f2a69b5..e3958281e8d63 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10330,6 +10330,11 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 
 	netdev_ops_assert_locked(dev);
 
+	if (prog && mode != XDP_MODE_HW && bpf_prog_is_offloaded(prog->aux)) {
+		NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag is not supported");
+		return -EINVAL;
+	}
+
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
@@ -10481,10 +10486,6 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the same time");
 			return -EEXIST;
 		}
-		if (!offload && bpf_prog_is_offloaded(new_prog->aux)) {
-			NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag is not supported");
-			return -EINVAL;
-		}
 		if (bpf_prog_is_dev_bound(new_prog->aux) && !bpf_offload_dev_match(new_prog, dev)) {
 			NL_SET_ERR_MSG(extack, "Program bound to different device");
 			return -EINVAL;
-- 
2.43.0


