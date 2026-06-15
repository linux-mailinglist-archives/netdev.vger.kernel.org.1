Return-Path: <netdev+bounces-299552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /fgVD5s0MGqbPwUAu9opvQ
	(envelope-from <netdev+bounces-299552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC45688CD7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:21:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ecwz1iP3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299552-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299552-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D22E304705A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDD409617;
	Mon, 15 Jun 2026 17:17:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56F40242B
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:17:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543865; cv=none; b=ACoXwt8Zi2TQCb0+710f/ix2nfkbw5XvpWdxu9X3MCTZEIu0+P9CrOG+T9hGQmHsyKsRj7hRbER6+Ejn3QvEi9p2Wn2uSlTS0IKvyTF+LLU2EWcH35LiXRiL3HkbQl+aTIkJfFLZGvJ0i42RNQ9yvjW/Oz0dXcKf0yRt1ehWQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543865; c=relaxed/simple;
	bh=ZiITZBLsFI77xgWobj+9RMtVotjFNXhJMhjFKXjJxU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u9uc0pTHJIiE3pIoMNO5gL+xuYIHdT+92N1sAG7bQMv36WtkU7ybenGRgCd5U8ZVlNCw8PjP67hwZnr+WtBaLpAepw4y1Geoy/A9YgAByWDbhvlvYvzMqYmC9QaVwiVti1qcwcO/hUg93owNC8FQwu9d7DbGpkBPle9UikYkXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecwz1iP3; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so25118135ad.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543863; x=1782148663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrG0dsMXcYLWhA7XdfHD4yvwbct/DS6UU+B83YUIjw4=;
        b=ecwz1iP3kH1MZD2f7XnSYpG1xMUaghnOXCMxyLdMt9pToY9/7P/tqLFDJ0hyJwyrbK
         L43+5SL0RDjwhtokHn/NwEf+ahwp5ZZdwePxwLfzZKZ8pbppQ8U47H4PIbsN5NUbq4n6
         +QTvcrscWSLLHLKUdMNsC03AUa/tLXqACVj/92+W8/6wK7bUkE3SrLOMdf5G+yuXyKHm
         XoJl48vyk3kGrRiLPalWfNx/KMCPjm3OxJ9h1sypJQ67yNNR1KGeipaMbxQDu3AabTZl
         EHL+XEbSCRnXPhzsmkZ9K5R3GSKrRIVIBMRkVhdbttHjZQlVrqMT80pFzt8HqW8o2OSN
         OAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543863; x=1782148663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrG0dsMXcYLWhA7XdfHD4yvwbct/DS6UU+B83YUIjw4=;
        b=slIjnHVH4AElQ/axYN1QYAeutklXQ25rzxeV1QevWexkzcfkrt1vwwHTe1MyMZ/tvu
         kVi9MqjBGxEsso89oUqXQvK3BkM3ggUTarnas7seJ7LzCLshlRKdwNUWkLm3LbJ2ulo0
         Zd/+VcxRPx3Q6HpJ7on5GIBVnEKz2rkI8kKikbx7kZeQ7dC0rfa6LzPNIWkpJKuP71gM
         TTTsjX4RCr6MQ0MWuVHC6W5Hu7DxdihGgaRNXHfW1gpSSlRq3gkmU/nw3tV8R2UuFIsJ
         FXrF46TyujuwpIwTWQYGPzxw0cexJfqAqWWdOp1TPNd17e6Cjs0DNSscYO8iMl3PV9Y2
         hfQw==
X-Forwarded-Encrypted: i=1; AFNElJ9MPYQRUCAqoL/AFDuKI+fr4mkeSM0kB+jyDrDKh3Dbu13hMVkCb6pBCrdhXKZOnTy0e18lUXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxzw6kIs+/ds6spbDGtPUSz6tgGMD4DPeJgfSoxt9CmLgWRGrT
	DYZSBjswud2DbwDXKKxygV8zMWEIHLiXMRMUFMrC5NcPzAXvBa6HB2Br
X-Gm-Gg: Acq92OEK8HTq/5pm0xS6cY+KddKVCFGOXxnc/b9WCEkaNv79KdLcmQaV/7n4bHwUZt+
	vu/51D14E75wtaaxP9SPnHtWkiNwkcd8BRoZMaVn10JNaN5ep6Qx3ZbNL6R7BlMCjoincllHw2j
	VF467n+Og7XY4de4TRWEK74KrTm4n6abGZ0y19V0zQis5YvE6wYIjTa5JISl7xPJNgoEZjz0kAQ
	eL4BEpbh0Mf0KJUjpay27yce6cqriH6GW/9pufLanta8yTyq0qplgvrhgcXQGifc8A8jNFTdzSM
	Bo6WO28vq+IlKAOR74Nd3MmRXtlvnJ84JnuQLG2chXipLa/bT6cxmTAZrW/+p7lpLZqRWtYviBu
	mrIS11UIKn8egKrlAw5DHyd3t/iTO8FOG8pcD8jwISvI+2sLE5t1+vJVEY3AuGzt2CN6AbWtzz1
	FzAFYTwFGxPzM4u9Yiql0oGYJZn7iAVX57Qc2Y7dTVCwShSsKC
X-Received: by 2002:a17:903:1207:b0:2ae:450c:951e with SMTP id d9443c01a7336-2c6641e180cmr125176215ad.17.1781543863267;
        Mon, 15 Jun 2026 10:17:43 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433558365sm106538685ad.77.2026.06.15.10.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:17:42 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] netdev-genl: report NAPI thread PID in the caller's pid namespace
Date: Tue, 16 Jun 2026 01:17:36 +0800
Message-Id: <20260615171736.1709318-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:daniel@iogearbox.net,m:razor@blackwall.org,m:dw@davidwei.uk,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:skhawaja@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299552-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BC45688CD7

netdev_nl_napi_fill_one() reports the NAPI kthread PID in NETDEV_A_NAPI_PID
using task_pid_nr(), which returns the PID in the initial pid namespace.

NETDEV_CMD_NAPI_GET does not have GENL_ADMIN_PERM and the netdev genl family
is netnsok, so a caller in a child pid namespace can issue it. That caller
then sees the kthread's global PID, even though the kthread is not visible
in its pid namespace, where the value should be 0.

Translate the PID through the caller's pid namespace, the same way commit
3799c2570982 ("io_uring/fdinfo: translate SqThread PID through caller's
pid_ns") did for the io_uring SQPOLL thread. The doit and dumpit paths both
run synchronously in the caller's context, so task_active_pid_ns(current) is
the caller's pid namespace.

Fixes: db4704f4e4df ("netdev-genl: Add PID for the NAPI thread")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/core/netdev-genl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b8f6076d8007..4c23e985cc01 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -2,6 +2,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/notifier.h>
+#include <linux/pid_namespace.h>
 #include <linux/rtnetlink.h>
 #include <net/busy_poll.h>
 #include <net/net_namespace.h>
@@ -189,7 +190,8 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 		goto nla_put_failure;
 
 	if (napi->thread) {
-		pid = task_pid_nr(napi->thread);
+		pid = task_pid_nr_ns(napi->thread,
+				     task_active_pid_ns(current));
 		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
 			goto nla_put_failure;
 	}
--
2.43.0

