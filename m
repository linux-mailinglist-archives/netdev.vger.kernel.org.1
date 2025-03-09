Return-Path: <netdev+bounces-173277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2028FA58442
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7415716B12A
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9BF1DDC21;
	Sun,  9 Mar 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H0VzkN6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F51DC99A
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526996; cv=none; b=pwjNMUROPYJi549AvuG6fB6sveUmFd1Xf3nB3dduo90jHw1HV9MuAeqAjsnyE1m4MxcxPYr7kfWzzYzY/wumrgtm8avxNHxlKnMROr8/tKwki+TKJjS0bL+aQCxrxlbAGMa0ps7km0yLVYFe6AaGextKYUASfYdEJSvV0xbYFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526996; c=relaxed/simple;
	bh=vnuWxUByDaK53vFXT9n7vqyzxlt2qtW+8f94W06a7gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5QSQalscTbg8yubCmYkACZDqjsUM3kMNUz5k3psJHHzkzQkzI0nZdleb31SHz1qZ6DKNE/17ZVGuL589t+CUr3OxQsrrMZRiZh8DmQ3N/bufYaRk6UaWVDXDNA9NDKFxXs4YULA+HUDhzJCMxcEoVBNMSyfxisJqpR3KiAF0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H0VzkN6s; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 195833F869
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526982;
	bh=shYgV0qT/lqjUQTrvdmbHNW7lzUO23tYACdmBi90n70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=H0VzkN6sGHWgjqmuCE/jJLzf7z+Hsukx9CzPCt1BWMnInd8a6WmEjF2ZJLHVm730N
	 z6pTws4qkdm0Djg/24mVbbecLDolZ4spbGN43IZoUTo7pQH3ohqL6nF3ypzCYEvSEJ
	 RvVuPU/bXZxeSbcI43DHxbo5mRC18aR0xt5qr2eyk/JjviLK2CPGwKllgD3HYamXTn
	 4EptslktqAOekglwbBr1Dc8SmDQ/5scbCN/Vqd5fJaQutRumMvq89qis6hHjQrjzqW
	 rB2unfkiLp1yBDDGV35oAas4n+PIzthx+Qtww50MURL5/NdsyWG1tfpkT5rZjQy5z7
	 xBdpN4r69eDHg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac287f28514so81508866b.0
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526979; x=1742131779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shYgV0qT/lqjUQTrvdmbHNW7lzUO23tYACdmBi90n70=;
        b=l1JQ8ZOQgDqL0gB7tsdCSMU/mgtFQjGKAnf+7CYQqDsE6f87ci3MEVhnKwvkZmURkA
         56mfgK1RJKTUQN3V8a0DRqgAgghrY9h+dIMY+bqnVgmr4eHHl0HIQe+m6B4oC+0OsFUe
         0akxXiKUBMr/gCMGFB381NPytXthpnvyvOmR2HDivE4Z5OK7Ls06lVrkctSuP8VNaXpq
         jlMiCrc9g1hRAeTW6XxpAJqTg+ifaDcvL5jZQo/mYpjSNBj00B5YWDUtDFngSHp4eC49
         eqgd9tgT34cMRTGMez5baOTrm2qExAVF0Prp0zl2WzYIKKM+uNHkT7X3YC0bF20GNWzu
         RdEA==
X-Forwarded-Encrypted: i=1; AJvYcCUNwA2ElKdfqOtHV/iGCYiOgwpk9VvqzFEaBLmFrsRkCFx2/JplzTaKlDeuOYiKUflHc/+7J94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyydJZf/xPHaYJPCeMmxyfzDrksVBa+GAkj5SSaSn66CaMch70Z
	xWqpP0e6kTTIgy3aYMBBILABOBkCmF2lohpMH48217icB8+Hb2U59xfFMxPgjhi5DlUNbRu7xey
	nAUkK00VeKvC8t4l78rHqPIO92Cx5STGX2wcK/HPzNoje0o/vjE9l6dmnEuGNPmnEHxdXKA==
X-Gm-Gg: ASbGnctddpryTGlJ2Y71zwCcScBshIJtlRYQYWNYI/u5oz+gVax9OOwTmm4XHH5ETws
	8+Gb3A9sXnv+t1UfG24fxfCzPboCvP8eWRYICYq9PV9TwQqMlIozbwosB0D8ZtP41ITj89AUlj9
	DX1wGxUvQy9XgFYKDrq/MuZjZ48atr1rTPVftZKwrwlCnD+miyClmoKl0bVdW3iMxGjv5/u4AY0
	vErsYYxYmJ47kEzsbB6lgqXV7wSrUkN6pVlrrrrHl5MgabD2B781dvfKQJl1h8EdyvjUpD/rV5X
	2Py5kBKt1qSIjCuoBxQC9CCfeILucjukYE0WjhD65/d2caX33geTmB7c7k9wH01o6KWAjvww0gy
	NSw8gvsxm9z4Yd/vm4g==
X-Received: by 2002:a17:907:c302:b0:ac2:f93:b7c5 with SMTP id a640c23a62f3a-ac2526e1ba9mr1073986966b.31.1741526979544;
        Sun, 09 Mar 2025 06:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWS1LQrRdoibpiP6escIaOL/a7XzBpJqfiCaikM73Pa+IXdnzBUWE6E4F2v53XQL0h2fMQ5g==
X-Received: by 2002:a17:907:c302:b0:ac2:f93:b7c5 with SMTP id a640c23a62f3a-ac2526e1ba9mr1073984866b.31.1741526979165;
        Sun, 09 Mar 2025 06:29:39 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:38 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH net-next 1/4] net: unix: print cgroup_id and peer_cgroup_id in fdinfo
Date: Sun,  9 Mar 2025 14:28:12 +0100
Message-ID: <20250309132821.103046-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/unix/af_unix.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7f8f3859cdb3..2b2c0036efc9 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -117,6 +117,7 @@
 #include <linux/file.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf-cgroup.h>
+#include <linux/cgroup.h>
 
 static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
@@ -861,6 +862,11 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
 	int nr_fds = 0;
 
 	if (sk) {
+#ifdef CONFIG_SOCK_CGROUP_DATA
+		struct sock *peer;
+		u64 sk_cgroup_id = 0;
+#endif
+
 		s_state = READ_ONCE(sk->sk_state);
 		u = unix_sk(sk);
 
@@ -874,6 +880,21 @@ static void unix_show_fdinfo(struct seq_file *m, struct socket *sock)
 			nr_fds = unix_count_nr_fds(sk);
 
 		seq_printf(m, "scm_fds: %u\n", nr_fds);
+
+#ifdef CONFIG_SOCK_CGROUP_DATA
+		sk_cgroup_id = cgroup_id(sock_cgroup_ptr(&sk->sk_cgrp_data));
+		seq_printf(m, "cgroup_id: %llu\n", sk_cgroup_id);
+
+		peer = unix_peer_get(sk);
+		if (peer) {
+			u64 peer_cgroup_id = 0;
+
+			peer_cgroup_id = cgroup_id(sock_cgroup_ptr(&peer->sk_cgrp_data));
+			sock_put(peer);
+
+			seq_printf(m, "peer_cgroup_id: %llu\n", peer_cgroup_id);
+		}
+#endif
 	}
 }
 #else
-- 
2.43.0


