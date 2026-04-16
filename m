Return-Path: <netdev+bounces-279010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE3nBnPI4GnjlwAAu9opvQ
	(envelope-from <netdev+bounces-279010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:30:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE040D6FC
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62E0E301C5CA
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676A3A7836;
	Thu, 16 Apr 2026 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UF1KpSD0"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636F39DBE2
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338666; cv=none; b=kHWzLdE3+i4bBG7zzmsoF20q6qoVTyc+TeQ/QDOIM7fg64E3jbX4+M0cUpFQlPesTLzs1Rk9xMYY9U3c6Kt5tBXtOEiLaME6PA2CMCKAP8oR3xZjZbufv8Kvzs7Wo+0EY6xqZcV2hERK4Cn+G98uZoFnE3Ol4UNnTl/XBTStIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338666; c=relaxed/simple;
	bh=tGOhrptT9PJ5/cvzp6EKffTU5Kr88yNrPL4dsjtp0/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxJN+goL3je3jp/He4ACsZUNvqiz8kjvF9dyxigX81Fb2MhNLY2BrU6pkz6GU9MmgAid6dWFmcNIJP1sPL/xPajZxHzEmrKVVTiGPKk2jjyGOKadq407fmXFBsppRw9incxWF1Cxc1SYXQCHLUimprYTBLwvqkCQF8PVrdvEcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UF1KpSD0; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776338662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AldNZMVHS+FDrWsqQWGH6HMzCXTBhC6l0kEDtweIFA=;
	b=UF1KpSD0RSSqrsSf0EPQ+pdlhKbgUzEbBpVt3z0hBlQ9KX33ed7Ig5M4GtdluxgiCN2NdE
	NtRnLLXQ+AAm4swHPVKFRRkpN+J2ZGW/ycKIQwiQNJzvTko3F5O3GFRrx+5/FKPmFEY917
	a0VVUGPFpWNVuzdxNaUDTio4cDNPofg=
From: KaFai Wan <kafai.wan@linux.dev>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	kafai.wan@linux.dev,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>
Subject: [PATCH bpf v2 1/2] bpf: Reject TCP_NODELAY in TCP header option callbacks
Date: Thu, 16 Apr 2026 19:23:07 +0800
Message-ID: <20260416112308.1820332-2-kafai.wan@linux.dev>
In-Reply-To: <20260416112308.1820332-1-kafai.wan@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-279010-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.966];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uestc.edu.cn:email,hust.edu.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 3CFE040D6FC
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

A BPF_SOCK_OPS program can enable
BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG and then call
bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB or
BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

In these callbacks, bpf_setsockopt(TCP_NODELAY) can reach
__tcp_sock_set_nodelay(), which can call tcp_push_pending_frames().

From BPF_SOCK_OPS_HDR_OPT_LEN_CB, tcp_push_pending_frames() can call
tcp_current_mss(), which calls tcp_established_options() and re-enters
bpf_skops_hdr_opt_len().

BPF_SOCK_OPS_HDR_OPT_LEN_CB
  -> bpf_setsockopt(TCP_NODELAY)
    -> tcp_push_pending_frames()
      -> tcp_current_mss()
        -> tcp_established_options()
          -> bpf_skops_hdr_opt_len()
            -> BPF_SOCK_OPS_HDR_OPT_LEN_CB

From BPF_SOCK_OPS_WRITE_HDR_OPT_CB, tcp_push_pending_frames() can call
tcp_write_xmit(), which calls tcp_transmit_skb().  That path recomputes
header option length through tcp_established_options() and
bpf_skops_hdr_opt_len() before re-entering bpf_skops_write_hdr_opt().

BPF_SOCK_OPS_WRITE_HDR_OPT_CB
  -> bpf_setsockopt(TCP_NODELAY)
    -> tcp_push_pending_frames()
      -> tcp_write_xmit()
        -> tcp_transmit_skb()
          -> tcp_established_options()
            -> bpf_skops_hdr_opt_len()
          -> bpf_skops_write_hdr_opt()
            -> BPF_SOCK_OPS_WRITE_HDR_OPT_CB

This leads to unbounded recursion and can overflow the kernel stack.

Reject TCP_NODELAY with -EOPNOTSUPP in bpf_sock_ops_setsockopt()
when bpf_setsockopt() is called from
BPF_SOCK_OPS_HDR_OPT_LEN_CB or BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn/
Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 net/core/filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index fcfcb72663ca..911ff04bca5a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5833,6 +5833,11 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	if (!is_locked_tcp_sock_ops(bpf_sock))
 		return -EOPNOTSUPP;
 
+	if ((bpf_sock->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
+	     bpf_sock->op == BPF_SOCK_OPS_WRITE_HDR_OPT_CB) &&
+	    IS_ENABLED(CONFIG_INET) && level == SOL_TCP && optname == TCP_NODELAY)
+		return -EOPNOTSUPP;
+
 	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
 }
 
-- 
2.43.0


