Return-Path: <netdev+bounces-286771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHIOOeIWAmoVnwEAu9opvQ
	(envelope-from <netdev+bounces-286771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:50:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C079513CA2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 670A1302D1B6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081C477995;
	Mon, 11 May 2026 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGYuIqGl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42547798C;
	Mon, 11 May 2026 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521768; cv=none; b=X51XbNJlRh0wA3aGB9i8xfPuLr6CQd79fSkBRMDqHUfH2zGMqnJV2cCw+mq+YHo3G6B7ulEc/DL4xqWtdLR8OIeZ5zN08b8Dz/h8BtyUWCoPZzJvTZvbdyLwQS5xMkyeTbErR6n92eYPY6cI5iY10ZEgNkP9gwAxljIYz0grqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521768; c=relaxed/simple;
	bh=OeNTDOfgXSxAod/UsF3bpBrIfkmyQkJU5nchPU3STWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXY7kVyrtNycvw84Zb0jJOe9Tu+EUJk0rV4NNnzpbqhpgNUPXcpG9DvvMuo35lU10Bg6S8kDqTfJArLjCVEqK8MW1lRtEK2bQzxIM0VUcsO4zAiWZJNlL7DPD4I+RnVh0ycxK32qw4MNrEZWySxFQ6qk8tzfUmU+5MR/khns7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGYuIqGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4198C2BCF5;
	Mon, 11 May 2026 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521768;
	bh=OeNTDOfgXSxAod/UsF3bpBrIfkmyQkJU5nchPU3STWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGYuIqGlZ9a3WVBAbwyR5CgKnCDKaY3PP49J0hWHCzy4r75GojdRwPpoNWooetsCJ
	 38QrrQeH/i5DtrCjanl9FEBNh/wdNwq6wOtBZvvMzXtbB1gTe150hyoGX7+6d0oreU
	 WmVo7lYrXUwB/QwVlvkToPicO0LVH44i4CTtSAhwoDbPcpVhJvWWmEz1o6H+ahJaYD
	 Z7zRBtPqRZLWujM5dGivrrmTRW5i+iH8eSVYe22T1oOKKHQPH4VTLGPF6LWOJpI04S
	 OyOYvWE7L32DBxMzVs6F0Sq0jzB2CEUbdnf12GDDIcTvdwFuWavxEkzE/6qv1dWQq8
	 hEeW9YoKmGn2Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sd@queasysnail.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v2 3/4] net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf verdict
Date: Mon, 11 May 2026 10:49:19 -0700
Message-ID: <20260511174920.433155-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511174920.433155-1-kuba@kernel.org>
References: <20260511174920.433155-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C079513CA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,queasysnail.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286771-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

bpf_exec_tx_verdict() may return having modified the record
and the plaintext/encrypted sk_msg pointers. We must always
reload those pointers after calling bpf_exec_tx_verdict().

On the wait_for_memory path after sk_stream_wait_memory() returns,
the post-wait contains a shortcut:

	if (ctx->open_rec && msg_en->sg.size < required_size)
		goto alloc_encrypted;

which dereferences the cached msg_en, which can equally point at
a freed record if the prior bpf_exec_tx_verdict() split the open
rec before returning -ENOMEM. Drop the shortcut it seems to have
only been an optimization to skip trivial intro of the loop.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_sw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 3bfdaf5e64f5..360f71fd7884 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1112,7 +1112,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		if (!sk_stream_memory_free(sk))
 			goto wait_for_sndbuf;
 
-alloc_encrypted:
 		ret = tls_alloc_encrypted_msg(sk, required_size);
 		if (ret) {
 			if (ret != -ENOSPC)
@@ -1255,9 +1254,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				tls_trim_both_msgs(sk, orig_size);
 			goto send_end;
 		}
-
-		if (ctx->open_rec && msg_en->sg.size < required_size)
-			goto alloc_encrypted;
 	}
 
 send_end:
-- 
2.54.0


