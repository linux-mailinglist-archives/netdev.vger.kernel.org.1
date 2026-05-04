Return-Path: <netdev+bounces-284044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOgFCFQK+Wn54gIAu9opvQ
	(envelope-from <netdev+bounces-284044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:06:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F215D4C3DE8
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDBEE3004911
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE933E346;
	Mon,  4 May 2026 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnyU3p6r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263333F58D
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928780; cv=none; b=NG7/EtNowIL3N/qLZZx1R0mV/xsOEyZyrFB1bO8ZLZNE+wq3JB6FLao26LIwczmI5/XBDR/YpiayLBc443JByGwLu+wPbAf9iUEFa+ITO7qfKYirZpQgHEYhPZANObX5duJt8wr4ELag1mUEVeQqqAR+g+mMKjDxoZUt3a6b/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928780; c=relaxed/simple;
	bh=cmn2WSZTNYGCpkywBNeAvhkC9f6GUFEKUwCc7EBVnK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F9o4qXaL9YNai6kDmdZUhYP7lGZTmr8guQFtmkCq7s1mh86YDSpwzWBoDcJqNVkybbMJKJm8xoVqdxmAcH6mRBYXYDOyyvGlrxrxiY+UHT0HEUXQ1UqwfXbgYTzvg0sy0MjmMY6Bu1N6iY3v0Ng6Am5YOiO1wW73ekWwsDCcLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnyU3p6r; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso5596837b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928779; x=1778533579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhJlx1wKuGc9b2//z9ZBMpryakhxff7H3kevgbt7OKQ=;
        b=jnyU3p6rIFeNyVvwlFGiMk8+0QGhcu2F2FuDL4uVB5x2mRQaDc/Pv1kWmlmGucIEe2
         wP6fPsTvR8v+TiHa2+5RtCk7bOgCdgGsvUAE/X0YMYVwYubBevtjn8ssJJnk9+Wa0BMy
         sgqJbuWtnE4SSh99MpjnGKz3LwGpL2RQtg+c36YzO8YUoq57pYoospGqE3R4niZfDHKu
         ZnLO3W1OM2tis7+2uuCXQxNwkRkO4x8xTOVTbzB9gcctvCbXia4GSp7xq3ZLHn2p/icW
         5Qd7Pcg1zrltFTkN82c/TdKD3o391bn4FHwuLrE22wEwQL1QvYHsxWZRqWX4lw/oC4II
         t8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928779; x=1778533579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhJlx1wKuGc9b2//z9ZBMpryakhxff7H3kevgbt7OKQ=;
        b=rgejfkolgoUbunm+BtL2l3yduRSSm7KDppgd9nATb9qI7gkN4nRZdAeKynamB2pQBG
         /OLIwsGQpNvn3fqzagPrDqv8dO7hTxDrF/2eFf2fMcXm0t4luiHx1aYj049YjPwqA2jI
         9OK34QmuBlnvziKGDFZaGhrFnOKxPwgu1LwESZvO/iKmYZIDIaJEMgY76oPm3LACI7Ys
         hNOr241sZt8twCZk1VZ7amYr5z0sgI8NiW5m3ZIX5ZsxkPms74OAT92JdBFhTPBQjiGK
         DgrqwVIU6g5Q7ORSVRrnNjaxH0hUXI44yecjl/xnmBO+TQXdy0bYfIoqrzdFKBmTACj8
         RTXA==
X-Forwarded-Encrypted: i=1; AFNElJ+Pkh/hDZRWDo30oGEppKDJW+KKiZMZSmfO0JRf/FE6oj/haQW+ZdA4ar59LYI3Pf4uqHOQhrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZYrT/PPx3RXfV7rd0qPCM1a2GIwBEFSx+p0OrcO/ayPY7Bnd
	heYyr7+4k3NMoqQJnO/KXjd1sfp9zcdJs2h0GF81rC9QPBYmcKHd+6l46UYC6tI+9I5uuEpDgym
	dyv8UTQ==
X-Received: from pfbcd20.prod.google.com ([2002:a05:6a00:4214:b0:82f:d0ad:4d57])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d11:b0:81f:5037:a317
 with SMTP id d2e1a72fcca58-8352d19f3ecmr11425299b3a.11.1777928778691; Mon, 04
 May 2026 14:06:18 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:51 +0000
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504210610.180150-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-5-kuniyu@google.com>
Subject: [PATCH v2 bpf 4/6] bpf: tcp: Fix type confusion in bpf_skc_to_tcp_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F215D4C3DE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284044-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

bpf_skc_to_tcp_sock() only checks if sk->sk_protocol is
IPPROTO_TCP, but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

Let's use sk_is_tcp().

Fixes: 478cfbdf5f13 ("bpf: Add bpf_skc_to_{tcp, tcp_timewait, tcp_request}_sock() helpers")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index cd88633f8dc1..7d945dc2cb92 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11963,7 +11963,7 @@ const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto = {
 
 BPF_CALL_1(bpf_skc_to_tcp_sock, struct sock *, sk)
 {
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP)
+	if (sk && sk_fullsock(sk) && sk_is_tcp(sk))
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
-- 
2.54.0.545.g6539524ca2-goog


