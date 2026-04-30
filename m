Return-Path: <netdev+bounces-282976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPhLJguj82ly5QEAu9opvQ
	(envelope-from <netdev+bounces-282976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:44:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF54A71A6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 225C1300D769
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07247D94D;
	Thu, 30 Apr 2026 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsicAHzB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4147D950
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574655; cv=none; b=iZC1u9bGpx9QjVH4pgSHHlrE+1iIDArWEgloonCrspffSVZNvWQPp4c0pC5kIiJm0eaFtZupk5gH7GUhZT+vdwI9jQ+RU1+g6U/4DWikXzFm75fF/szL+aVjcnzVvSxhDPudIYw/bDhcKk1PCWt7dVdpZlhSdMb3JZ5p5Uc7mys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574655; c=relaxed/simple;
	bh=/HEsPTBP2Z/J3XuWMk0gaH/F8ujsApOQLRx2eiOFc3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPbd7jXlceTzoRQd9/8HJ2Hwd4p7HjuuJQTGa9N1jv8gHmA3+Psi0or8uOQVqICmFpXNIcu2g/0ZGTacHH0Opr/TBfdSWMAsNh5njhdf4qUcapTpVLafRIQMACB7ECbHlJAWlggzeQYQfA2o2TuPTEh2eignn4ziqo3H+gSeKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsicAHzB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f504f6b75so723332b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777574652; x=1778179452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8B+EV+dAZPjMHacRoI0PFkSCDi+v0zDQ1718UXTo0aI=;
        b=tsicAHzBnDU/zQai9tEdrPbtBfZxHKL9iACY6xY4FCLp6R1G8+XWdcHvtpAjcFx6IG
         S6GUHaMkQJ6eswhc5JEXCzOSXzUgiQRBA3ZFeigB3qHNned7Eg3KI9u/fLoUkRZeJMTa
         8wNdkg5y6LFLsAglWjS+8YuK+X5QuG2FunEGo15keOB7Eo2qStrJiEAD5vGrMgNMjjJa
         ZypxWBf+ks7EzOvNwLkbL4jNkFoXHyv9fpNSdVNdFWpeZkDReLjlpJ9aCTn+5vsVEPae
         ddum1atanFQI5+RqeeaEqjhuuXsdMKdWXM1Una0FY07nA6m+Q1/Sj+FXJLnhT6NGwEX0
         TRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574652; x=1778179452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8B+EV+dAZPjMHacRoI0PFkSCDi+v0zDQ1718UXTo0aI=;
        b=fycNIk95BxZ2JGaCuODKHpe+so6Cw5T4Nh5mL/IuwrvbeaS77+RaMY9Ywnc97Zn8yw
         n124DljdS6XEwbXIc4AVqgoYfGQ6Mv5O4rO5nU9vTM1JT6CPc5zHye+66GCcE++ncqnT
         aG7g9zAkcTRPRkAg2IipDAYREJY0TWVtirdUor27FmfuECz4tf3nzksdwTs4s9WeoofE
         uAMqIxzHUgKvKzz0xukjbBEsXKMI83bw0lvLgAPRr6XdG0WvYhHSq98z2QE6TANy8EHP
         k32uz7aJ/YQ0Y/SwFsZpNNdrbxmbhPTKWSTtM8dpWAiUfmakqouZhVt6BMpwsPgHT7m2
         9/rw==
X-Forwarded-Encrypted: i=1; AFNElJ+LaimtiX7aLnnCRDrN4/TP2OBV+07plNgv0bA2QpS4XgFlPSFDMbUUIYOF8Q234Q1sNzyrieo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxilLnBICIwRAM6DAFSkxkcoYvAlU3dD47QfjoHsidMrDCa0R7c
	JN8FmovpkfxQu6BJVhU92x3cfjQuv5xZIhQ3MfKCYH82FlGH5wQIXbRB9bxfQcmhz9J/XdOg43g
	ls1xIeA==
X-Received: from pfva20.prod.google.com ([2002:a05:6a00:c94:b0:82f:8afc:f74a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b46:b0:82f:390a:69df
 with SMTP id d2e1a72fcca58-834fdcb6501mr4991165b3a.35.1777574652100; Thu, 30
 Apr 2026 11:44:12 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:43:52 +0000
In-Reply-To: <20260430184405.1227386-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430184405.1227386-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430184405.1227386-3-kuniyu@google.com>
Subject: [PATCH v1 bpf 2/2] selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5DAF54A71A6
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
	TAGGED_FROM(0.00)[bounces-282976-lists,netdev=lfdr.de];
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

Let's extend sockopt_sk.c to cover bpf_tcp_sock() for the
wrong socket type.

Before:
  # ./test_progs -t sockopt_sk
  [  151.948613] ==================================================================
  [  151.951376] BUG: KASAN: slab-out-of-bounds in sol_tcp_sockopt+0xc7/0x8e0
  [  151.954159] Read of size 8 at addr ffff88801083d760 by task test_progs/1259
  ...
  run_test:FAIL:getsetsockopt unexpected error: -1 (errno 22)
  #427     sockopt_sk:FAIL

After:
  #427     sockopt_sk:OK

While at it, missing free() is fixed up.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../selftests/bpf/prog_tests/sockopt_sk.c       | 17 ++++++++++++++++-
 tools/testing/selftests/bpf/progs/sockopt_sk.c  | 16 ++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 53637431ec5d..87e771c8991f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -190,7 +190,7 @@ static int getsetsockopt(void)
 	fd = socket(AF_NETLINK, SOCK_RAW, 0);
 	if (fd < 0) {
 		log_err("Failed to create AF_NETLINK socket");
-		return -1;
+		goto err;
 	}
 
 	buf.u32 = 1;
@@ -211,6 +211,21 @@ static int getsetsockopt(void)
 	}
 	ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
 
+	/* Trick bpf_tcp_sock() with IPPROTO_TCP */
+	close(fd);
+	fd = socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
+	if (fd < 0) {
+		log_err("Failed to create RAW socket");
+		goto err;
+	}
+
+	optlen = 60;
+	err = setsockopt(fd, SOL_TCP, TCP_SAVED_SYN, &buf, optlen);
+	if (err) {
+		log_err("Unexpected setsockopt(TCP_SAVED_SYN)");
+		goto err;
+	}
+
 	free(big_buf);
 	close(fd);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index cb990a7d3d45..5e0b27e7855c 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -149,6 +149,20 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	if (sk && sk->family == AF_NETLINK)
 		goto out;
 
+	if (sk && sk->family == AF_INET && sk->type == SOCK_RAW) {
+		struct bpf_tcp_sock *tp = bpf_tcp_sock(sk);
+
+		if (tp) {
+			char saved_syn[60];
+
+			bpf_getsockopt(sk, SOL_TCP, TCP_SAVED_SYN,
+				       &saved_syn, sizeof(saved_syn));
+			goto consumed;
+		}
+
+		goto out;
+	}
+
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
 	if (bpf_get_netns_cookie(NULL) == 0)
@@ -224,6 +238,8 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		return 0; /* couldn't get sk storage */
 
 	storage->val = optval[0];
+
+consumed:
 	ctx->optlen = -1; /* BPF has consumed this option, don't call kernel
 			   * setsockopt handler.
 			   */
-- 
2.54.0.545.g6539524ca2-goog


