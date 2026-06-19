Return-Path: <netdev+bounces-300724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Jj/KnlaNWoytwYAu9opvQ
	(envelope-from <netdev+bounces-300724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 17:04:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D86A691A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 17:04:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=icaPiIDi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300724-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300724-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E030301C3C2
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E343A254A;
	Fri, 19 Jun 2026 15:03:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3F1548C
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 15:03:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881437; cv=none; b=fxFgCf5ULOImRGnEbx2m11khQHLDsshYh2uTzcLjotH3GOUtEdw/iP6RDnldWGl7tl+mKtg4ey8goqyjG5EEv1oYLlzP9LDuOVygy8gdSHdd7NpF5J7zWLhAlnIOF3YJHglaecFfSYSSnWQqIhT/0pYWvRXJ48hoOmNNvyojxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881437; c=relaxed/simple;
	bh=n0TaIFU2dlUiY6Vzb+eElnBvXKO/Y+F2CeNOmOSDEpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrEdBl/jiaR/i8kv/rypc0wSP7951wn5m9+4Yeak3OXfNFCzux8xUAzLRFLRFeij8hO3qSep1xdLaAJBBCz+erg5Owe8eXq/JtU5PVk/P6IGJmXsKmbAmPPGltZoFMlALjQZsXWDNtOrBFe1Ju/4lk0JkcbE612gAowQ/X0DjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icaPiIDi; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423610ec93so1925354b3a.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881436; x=1782486236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5fF29AhKZUYQkqmksxc4GcdOoLjfu8vsoNrkddfAwM=;
        b=icaPiIDia+iWmEFhB2Z748fn+YVVv6PPRnGMgZMay8iUtTkG7gu1SsqMAw7Skq6vFo
         Aij2rIUYIY5Ft41A0gg2hN0XapAOQGCSm18cZOvew193TwvFWFpbVnPph7wBqub0Q2p4
         Scy1nT3lyVvtRb3bVrddCUwlYbM8K+sT1hdyLtpsjHi/70Ro9zaP3T4AVhhtny0DTdnC
         67LXG+zPFF4ZGoP4zz+3V3M0gFWkKlmdRfKif61AeWvLVLkpgXokbEN6zejedbmUlcoU
         wcBQKVfRezT3RJV52pp/0ptJ6lzVx8rxxSpJssrV7K+G2OpIDj6uYs4sjJPd+Mxa1Gt4
         nlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881436; x=1782486236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5fF29AhKZUYQkqmksxc4GcdOoLjfu8vsoNrkddfAwM=;
        b=UYHodfZNuZdU9IfRweDyWkHVZ/QV3O+qyp73qGmQBEuQU3FoduDNOrpzK1IeZyt2Jr
         bC+lx1+i+sC0xCI7tbZWhg49VEmyjLKdCHr9SyaLdbbRfJX8adVNMzv4HqsC+GTRsJq0
         1jn9TnebSm/zFfnr9z95+0yTOgOZNIZBtOx4J+8G7qvLV9QAhoUyQuD7GMSHcxn9kKmc
         THrs9g2iETfN2ETM2DQXt6+UM3lZq55wc8VR+5i/I0QmxdZcqn8qhzj7ac7MNfXhKgtY
         c/G6sew+0P79OT7z8K4SC4w82AnFDBxw9nm0TjVAyyj1/NHBmlwYnjif30XgSuLH9wHi
         XuGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8roDJDulURiNoG87ElBXQYB7JazBbQgNHIYUREnGEyUgeCPv/JpHLGhCS59IB6SjW5hCveics=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImgPota5fDum940xyKSM9/Slz9Ovv4yREjr9c+6Df2Xe7VTve
	ZFB45iO2QSCrUd8IwR4ssPzYKkhlA3aK2Kb2IitPwReod+EpOaRWwq+x
X-Gm-Gg: AfdE7clkci27+3kTNO8Qsq+ONE/MyLP+S6CQigxOT6ZIn4seukd/9fn9o0vVQlkRqgE
	wae2kfOlBHd9rTY4pbXuT8CioezOn1M3Ii8t3uUJA2D2I7WtsgYe1y/P0rzxyPnwmmWQMan/w/M
	nC+H2N2ZrkF67Ke2XahPvDN901+Cilhcck5qbkJAj9mJXWNL7qj/fOtyQnEPUWgRYVh+JR3vW6W
	M9DvCjI/cEGQDcZpoMVXhFQBduXiQQUa0ze7FEUp7yS4Eun4tFEh3sf04vTboApWt1nPWr6XYel
	cwVOV44VF4WKXScw6/H0MhL97/NArYXBEZLqFY13/KE8h1B+Vq9mX6z25B27tnR31pCniqHiVyS
	N9uqm8VCIlNlm+E+fbnqRh/7pjYknv7pY4iskyZBCTrmrWivgURETb9t5KoSqxZhR+/4aCXmcWq
	cn3k59G5fMk2hT26yVxXPsyr9/T8lIfaoceBKutd3uo1rAPjgYnGw=
X-Received: by 2002:aa7:8882:0:b0:842:7e7f:2914 with SMTP id d2e1a72fcca58-8455078a5a4mr4177673b3a.4.1781881435832;
        Fri, 19 Jun 2026 08:03:55 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455366ec53sm2844747b3a.13.2026.06.19.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:03:55 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] net/smc: fix out-of-bounds read when sk_user_data holds a sk_psock
Date: Fri, 19 Jun 2026 15:03:41 +0000
Message-ID: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300724-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:kgraul@linux.ibm.com,m:guvenc@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C1D86A691A

SMC stores its smc_sock in the clcsock's sk_user_data tagged
SK_USER_DATA_NOCOPY and reads it back with smc_clcsock_user_data(), which
only strips that flag. sockmap stores a sk_psock in the same field tagged
SK_USER_DATA_NOCOPY | SK_USER_DATA_PSOCK. Nothing keeps both off one
socket, and SMC then casts the sk_psock to an smc_sock.

A passive-open child hits this. It inherits the listener's
smc_clcsock_data_ready(), but sk_clone_lock() clears its NOCOPY
sk_user_data, and a BPF sock_ops program then adds the child to a sockmap,
installing a sk_psock in that field. The inherited callback reads it as an
smc_sock and dereferences a clcsk_* pointer past the end of the sk_psock:

  BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
  Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
   <IRQ>
   smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
   tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
   tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
   tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
   tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
   [...]
   </IRQ>

  Allocated by task 67930:
   sk_psock_init+0x142/0x740 net/core/skmsg.c:766
   sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
   bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
   __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
   tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
   [...]

sk_psock() already guards the other side, returning NULL unless
SK_USER_DATA_PSOCK is set. Make smc_clcsock_user_data() and its RCU
variant return the smc_sock only when sk_user_data carries SMC's tag
alone. A sk_psock then reads back as NULL, which the data_ready and
fallback callbacks already handle.

Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/smc/smc.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 52145df83f6e..88dfb459b7cc 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -342,13 +342,25 @@ static inline void smc_init_saved_callbacks(struct smc_sock *smc)
 
 static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clcsk)
 {
-	return (struct smc_sock *)
-	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
+	uintptr_t data = (uintptr_t)clcsk->sk_user_data;
+
+	/*
+	 * Return the smc_sock only if the slot carries SMC's tag alone.
+	 * sockmap stores a sk_psock here tagged SK_USER_DATA_PSOCK; it is
+	 * not an smc_sock and must not be dereferenced as one.
+	 */
+	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
+		return NULL;
+	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
 }
 
 static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct sock *clcsk)
 {
-	return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
+	uintptr_t data = (uintptr_t)rcu_dereference(__sk_user_data(clcsk));
+
+	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
+		return NULL;
+	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
 }
 
 /* save target_cb in saved_cb, and replace target_cb with new_cb */
-- 
2.43.0


