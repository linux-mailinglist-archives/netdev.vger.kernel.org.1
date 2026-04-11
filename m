Return-Path: <netdev+bounces-277638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGqzCMik2WnwrggAu9opvQ
	(envelope-from <netdev+bounces-277638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:32:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC683DDDEF
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDE3A3048126
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8F21D585;
	Sat, 11 Apr 2026 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XzHgE1xl"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DFC18050
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871172; cv=none; b=YCfrYHrd4GNyNqoH5YRaMIO/kxT9pvB6v3vw8oLuHWqAfo0XEDNEV99FuoGMLZ6d4igM0yKrgeVLVo1jF1eNDNLRmp4H+h7Vol7smagF1Y+pdyd6DwmuQmYmLsliCdgF3/S5i3A5bgoIeYLbsK1NUffKaw9898GDpOER1H89UJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871172; c=relaxed/simple;
	bh=wJBoOnYjhw+pUBicokDxqfaJkrZTKbpeqNHlpSLQoA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nj3D9mycrKPoceJgxjcrzmuicsK6aGMf9udhSy65Zz9AYOq3POK9MA58QLABbmLLDe+SCWBFTnsZoptq92DosfliXURxPNBhiHF+7+uYlwWBobPB0iQbl+twOzPumvC+0CTkrXZszRop6mly+PXZfksLHe+R3UaotAn0VTvQeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XzHgE1xl; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775871158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E79Q5CkAVpFseZarzsSAQtNJelU2PgVkwbeuT/mWF94=;
	b=XzHgE1xl12TudtuCmASy/U7V6lglBs/QQk2o74v1gvkitxUrlSbtnqnPlOXR5QDrwcsH1+
	U0OuPzkBk1aXr4e1YD8Vy9+AXvYMzvcBkspJrkDMY7FmtrVdfUQ9EFtX91uyhoXDNRhLsg
	+kgk9/cRslRssLpldtLrgW3dWNlIBWA=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: add missing syncookie statistics for BPF custom syncookies
Date: Sat, 11 Apr 2026 09:32:04 +0800
Message-ID: <20260411013211.225834-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,google.com,davemloft.net,kernel.org,redhat.com,gmail.com,iogearbox.net,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277638-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CBC683DDDEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1. Replace IS_ENABLED(CONFIG_BPF) with CONFIG_BPF_SYSCALL for
   cookie_bpf_ok() and cookie_bpf_check(). CONFIG_BPF is selected by
   CONFIG_NET unconditionally, so IS_ENABLED(CONFIG_BPF) is always
   true and provides no real guard. CONFIG_BPF_SYSCALL is the correct
   config for BPF program functionality.

2. Remove the CONFIG_BPF_SYSCALL guard around struct bpf_tcp_req_attrs.
   This struct is referenced by bpf_sk_assign_tcp_reqsk() in
   net/core/filter.c which is compiled unconditionally, so wrapping
   the definition in a config guard could cause build failures when
   CONFIG_BPF_SYSCALL=n.

3. Fix mismatched declaration of cookie_bpf_check() between the
   CONFIG_BPF_SYSCALL and stub paths: the real definition takes
   'struct net *net' but the declaration in the header did not.
   Add the net parameter to the declaration and all call sites.

4. Add missing LINUX_MIB_SYNCOOKIESRECV and LINUX_MIB_SYNCOOKIESFAILED
   statistics in cookie_bpf_check(), so that BPF custom syncookie
   validation is accounted for in SNMP counters just like the
   non-BPF path.

Compile-tested with CONFIG_BPF_SYSCALL=y and CONFIG_BPF_SYSCALL
not set.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
No functional bug here — CONFIG_BPF is always enabled under
CONFIG_NET, so the existing code compiles and works correctly.
This is a cleanup and improvement, no backport needed.

Added a selftest, suggested by Kuniyuki Iwashima.
---
 include/net/tcp.h     |  7 +++----
 net/ipv4/syncookies.c | 10 +++++++---
 net/ipv6/syncookies.c |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6156d1d068e1..570a8836c2ba 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -598,7 +598,6 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct tcp_options_received *tcp_opt,
 					    int mss, u32 tsoff);
 
-#if IS_ENABLED(CONFIG_BPF)
 struct bpf_tcp_req_attrs {
 	u32 rcv_tsval;
 	u32 rcv_tsecr;
@@ -612,7 +611,6 @@ struct bpf_tcp_req_attrs {
 	u8 usec_ts_ok;
 	u8 reserved[3];
 };
-#endif
 
 #ifdef CONFIG_SYN_COOKIES
 
@@ -715,13 +713,14 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 		dst_feature(dst, RTAX_FEATURE_ECN);
 }
 
-#if IS_ENABLED(CONFIG_BPF)
+#ifdef CONFIG_BPF_SYSCALL
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
 	return skb->sk;
 }
 
-struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb);
+struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
+				      struct sk_buff *skb);
 #else
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index f1474598d2c8..d685631438cb 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -295,8 +295,9 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_BPF)
-struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
+#ifdef CONFIG_BPF_SYSCALL
+struct request_sock *cookie_bpf_check(struct net *net, struct sock *sk,
+				      struct sk_buff *skb)
 {
 	struct request_sock *req = inet_reqsk(skb->sk);
 
@@ -306,6 +307,9 @@ struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
 	if (cookie_tcp_reqsk_init(sk, skb, req)) {
 		reqsk_free(req);
 		req = NULL;
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESFAILED);
+	} else {
+		__NET_INC_STATS(net, LINUX_MIB_SYNCOOKIESRECV);
 	}
 
 	return req;
@@ -419,7 +423,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 		goto out;
 
 	if (cookie_bpf_ok(skb)) {
-		req = cookie_bpf_check(sk, skb);
+		req = cookie_bpf_check(net, sk, skb);
 	} else {
 		req = cookie_tcp_check(net, sk, skb);
 		if (IS_ERR(req))
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4f6f0d751d6c..111d7a41d957 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -190,7 +190,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		goto out;
 
 	if (cookie_bpf_ok(skb)) {
-		req = cookie_bpf_check(sk, skb);
+		req = cookie_bpf_check(net, sk, skb);
 	} else {
 		req = cookie_tcp_check(net, sk, skb);
 		if (IS_ERR(req))
-- 
2.43.0


