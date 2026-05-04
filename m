Return-Path: <netdev+bounces-284043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMzPCLAK+Wnt4gIAu9opvQ
	(envelope-from <netdev+bounces-284043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:08:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 770454C3E0D
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478893051288
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216D33F598;
	Mon,  4 May 2026 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ills+6fq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CF33E368
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928779; cv=none; b=pYBJd88PbQ7TaQkY5NBS47aw6skPDw1xm3yprDDbM0VDzr3P+6UIIYwcjX41F02HfAvhQcfyA6JfykvRMtJWPwNVHgyxepKKvhaQ4JS7DGKqiwkPhEnCU+1UhrO8frhARe6pvn8schhEEoI+C9PD9YPrzgDXBFR3bAMh7pqCELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928779; c=relaxed/simple;
	bh=t+vSCHW8sXankiqKU0KBJsHXgvrd1DectD2FhYEqlNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AeQv6IhLU1le4fZHB3rl7Plqa2mgeke0cZ2gqU+DpVlAte1AFycAVciLHJaapxW3lmrK51lnOeolDUPuSUrAGzGCZAM1CwD5lpSxrpPtmXUI8hjXMIftlPdcq/nycktaxvnrInVCiydwJ80d/INHB2Xc8IPo78W8PXkTpxVID6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ills+6fq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36512c65928so2579668a91.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928777; x=1778533577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSqMpkiDL5DK8PRDUUfeCWvxInuXlDLXwweDPX2/AgM=;
        b=Ills+6fqXtP2x4NrQJNgHEXv72pgDxqQ1XDWEcYKysIX9wh3s1vkQZom1OjFtV7A2h
         POK8ybLbpGdmcOujQsVcGQojlt6mYkUbzHegCgdbSth38n1Xqlxz7DkiHWTe6qRxvKcV
         +hOqe1k20h8TKBVBqfTL7KJvY7bLGVv37z7QRllSmbbZjnVWRsqFs2nV5X2+NZ3Z7EX1
         dnGKQ+fzwqWO4ybqgswgOszEg5Imge/RXFJt8h3BnVyPPkpcoV4vZVjempnX6/BccHuA
         9lLn+wLosE2+Qe8B6u2kmtloCDiLtREAQT/tb0zRm81Q670hIu6twZIdZfUEZsA5/4CG
         OWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928777; x=1778533577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSqMpkiDL5DK8PRDUUfeCWvxInuXlDLXwweDPX2/AgM=;
        b=Fn/iiyY2R/bRm2WsjhCoFDPoxrnW5kKpTOO3+MNTmNWwGUHYx7P1z1KWramPEZJzPq
         CHxtaNsqswvsyoz5N7CrkBnLKU9/puuhm66FbS33QaOmq5BdUsAzUValOH6HKdhXOtAJ
         mcQY9xo3zrmRm6QMJLvbcvx7k6q/a23wKYOT0xbtbp3vGoabmiXzNRRuxx3jmu/APk4S
         qCro3jSPGLAFuGGXqL8bz8FDgqGKS3Qyc7WvYpcSJQwWA6KeAmymDloXN5ET2ej88+Uc
         nITkckiFG7nkt4MdyiaGUeQXGUAaxcEZILljtgFeVMhzhAChgt+WC5xEcqlj11TtLhG9
         6oAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9eIJA+QH3HmHu8/wfMGJNFmGyISjNH6zujsItxA0nJ7cSrJ8qxccCW93tf4pnZbXU7VOmu6oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINau9Nvo+9RsrzNrPaOuFzxi0d/iBgt5jMYQkptUs99sJDuWz
	ZzEbyRFs7IL4dSRI+QGTa98tRS6VJxXRON4nNNKXsUJwNiT2a+fIoXZZ6Q0X78o4c5iKJyW07Qj
	NPFE6nw==
X-Received: from plas14.prod.google.com ([2002:a17:903:200e:b0:2ba:1a1e:b2d2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48:b0:35b:a7be:ae47
 with SMTP id 98e67ed59e1d1-365774d3253mr527355a91.21.1777928777100; Mon, 04
 May 2026 14:06:17 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:50 +0000
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504210610.180150-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-4-kuniyu@google.com>
Subject: [PATCH v2 bpf 3/6] mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 770454C3E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284043-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

bpf_mptcp_sock_from_subflow() only checks if sk->sk_protocol is
IPPROTO_TCP, but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

In this case, it would NOT be valid to call sk_is_mptcp() which will
assume sk is a pointer to a struct tcp_sock, and wrongly checks for:
tcp_sk(sk)->is_mptcp.

Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v1: https://lore.kernel.org/mptcp/20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org/
---
 net/mptcp/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8a16672b94e2..4cc16cbeb328 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -14,7 +14,7 @@
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
 		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 
 	return NULL;
-- 
2.54.0.545.g6539524ca2-goog


