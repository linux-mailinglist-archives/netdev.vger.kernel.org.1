Return-Path: <netdev+bounces-98869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6658D2BAA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 06:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF747B216A9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 04:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB315B12D;
	Wed, 29 May 2024 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBobHgPb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E955B2B2CF
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955759; cv=none; b=lzPP5Ur03gIOIvSmw4bT3S+M4kPQDRjGNyRBNiT7Jau6TKYeoxBJVmqSDkcjhAjtYha52wZ8yNBKpMB7kyzrtoNzsIUq/4x1Q04zHRl1mf6SpPKenzK4qvKSGfe8Xy2kAtdDq4QN1isn/WSSSZijFI+Ic7t/H6vU6sKsMfTns3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955759; c=relaxed/simple;
	bh=dNJECWDj9/O6L1y07nRUia/M++dq3jV6bNxthfjZIIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJIv+0u/udoZzKNTQwsf0Fks8s53rbzt98qqrow7/AVXTf+G04sox+FzI+cz7P/JShTqe0o1pGpn4Qu7pZJTdvduTtP+2CGIncXPnbLGsevimY4sYKluGZ+YhISSV9YDoMX85VbdTyztITV7mtYErOEEG5fWo+riBRzao1jh+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBobHgPb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f480624d0dso13962075ad.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 21:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716955757; x=1717560557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aaVUHrPtLocwA2aTfkeh3pbJm6s4SttJtUbZdG8PA4=;
        b=jBobHgPbgMBfUgU91mk8gIl3Ngj3unDn8zHc0cT3VVPeolR40Evj1j7bOgCHa6bdAk
         D5wDoXbrLrMT9j2T87BQCYJ68n9D5KOJLMy0ICyUQCBt9ZWZDNIPOFzuta1r0RQ9jh9l
         v/FXgjQu7NOfP2dikd9OLumj7aUZ2VV+d8cqDT+HWPYkdYVQrrW/52jxQ2hlJ6m6ze6u
         F6KENT5/h5VBObF8GC1tDAbAJCUhv6r4DZ5FeIX74Zc1dEe27nz88volFs0VFRSp8DRc
         xjIGirlnlR77XcM34FElNNuDUZgw++6XkgQZm/xeAxlKRX+6GY09Z8+wnki6XRvlQZlz
         PU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716955757; x=1717560557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aaVUHrPtLocwA2aTfkeh3pbJm6s4SttJtUbZdG8PA4=;
        b=vvwbOp7Nbu7BQfjBCV0LM8miufkgaerHiZnuAdmhoBhRj8xqodwboaGqTXAsR4VUiX
         LKu5R7nUOYjDE7mVIecadyJXnQVV4txNuEXmpg/V/XMsvMcIFxt5dGImqjijNM4vIDms
         1UUhHWoOujq0MmZwJaNIIv7Yh7KzsAnTgP+QW/87rWBXrHffUAQtqMZn8G/xwxJgVkPO
         12MGt8lzB9nGme3UMgoBhKhIrvOBvXAH4kOqk4I6u1+MmPs0FIjuH3AHkaL4uVnKxqsP
         7jJuutBVWMV91K4dqOk0++DamE/lPTgfUkBCGmnRsyhvKH/KekLVB7IYwDQGGOoTuoei
         5Saw==
X-Gm-Message-State: AOJu0YxY/bWJ8ug4ZBcm41nVIkwwpzmpy+dhQH5kOY+XwjHqqOKmevU7
	jLU9thesiXtJL6hqb2l32/lj9dra/qq5r4iMDuiN30NTSfwJm4jttKUk94R02tGpiQ==
X-Google-Smtp-Source: AGHT+IEeUPTcaAjtgJMP0F4JwW18/v3hXEMxpxh5mj5a3X1jSPZ6HK3TB6PIZdzrUcQVP+qf0qtw3w==
X-Received: by 2002:a17:902:ce0c:b0:1f4:93e3:9d5a with SMTP id d9443c01a7336-1f493f2e3b3mr115155965ad.57.1716955756669;
        Tue, 28 May 2024 21:09:16 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c760a91sm88305285ad.33.2024.05.28.21.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 21:09:16 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next] ipv6: sr: restruct ifdefines
Date: Wed, 29 May 2024 12:09:08 +0800
Message-ID: <20240529040908.3472952-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are too many ifdef in IPv6 segment routing code that may cause logic
problems. like commit 160e9d275218 ("ipv6: sr: fix invalid unregister error
path"). To avoid this, the init functions are redefined for both cases. The
code could be more clear after all fidefs are removed.

Suggested-by: Simon Horman <horms@kernel.org>
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: add a new label to call seg6_iptunnel_exit directly (Sabrina Dubroca)
    add suggested-by tag (Sabrina Dubroca)
---
 include/net/seg6.h      |  7 +++++++
 include/net/seg6_hmac.h |  7 +++++++
 net/ipv6/seg6.c         | 33 +++++----------------------------
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/include/net/seg6.h b/include/net/seg6.h
index af668f17b398..82b3fbbcbb93 100644
--- a/include/net/seg6.h
+++ b/include/net/seg6.h
@@ -52,10 +52,17 @@ static inline struct seg6_pernet_data *seg6_pernet(struct net *net)
 
 extern int seg6_init(void);
 extern void seg6_exit(void);
+#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 extern int seg6_iptunnel_init(void);
 extern void seg6_iptunnel_exit(void);
 extern int seg6_local_init(void);
 extern void seg6_local_exit(void);
+#else
+static inline int seg6_iptunnel_init(void) { return 0; }
+static inline void seg6_iptunnel_exit(void) {}
+static inline int seg6_local_init(void) { return 0; }
+static inline void seg6_local_exit(void) {}
+#endif
 
 extern bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len, bool reduced);
 extern struct ipv6_sr_hdr *seg6_get_srh(struct sk_buff *skb, int flags);
diff --git a/include/net/seg6_hmac.h b/include/net/seg6_hmac.h
index 2b5d2ee5613e..24f733b3e3fe 100644
--- a/include/net/seg6_hmac.h
+++ b/include/net/seg6_hmac.h
@@ -49,9 +49,16 @@ extern int seg6_hmac_info_del(struct net *net, u32 key);
 extern int seg6_push_hmac(struct net *net, struct in6_addr *saddr,
 			  struct ipv6_sr_hdr *srh);
 extern bool seg6_hmac_validate_skb(struct sk_buff *skb);
+#ifdef CONFIG_IPV6_SEG6_HMAC
 extern int seg6_hmac_init(void);
 extern void seg6_hmac_exit(void);
 extern int seg6_hmac_net_init(struct net *net);
 extern void seg6_hmac_net_exit(struct net *net);
+#else
+static inline int seg6_hmac_init(void) { return 0; }
+static inline void seg6_hmac_exit(void) {}
+static inline int seg6_hmac_net_init(struct net *net) { return 0; }
+static inline void seg6_hmac_net_exit(struct net *net) {}
+#endif
 
 #endif
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index a31521e270f7..180da19c148c 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -21,9 +21,7 @@
 #include <net/genetlink.h>
 #include <linux/seg6.h>
 #include <linux/seg6_genl.h>
-#ifdef CONFIG_IPV6_SEG6_HMAC
 #include <net/seg6_hmac.h>
-#endif
 
 bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len, bool reduced)
 {
@@ -437,13 +435,11 @@ static int __net_init seg6_net_init(struct net *net)
 
 	net->ipv6.seg6_data = sdata;
 
-#ifdef CONFIG_IPV6_SEG6_HMAC
 	if (seg6_hmac_net_init(net)) {
 		kfree(rcu_dereference_raw(sdata->tun_src));
 		kfree(sdata);
 		return -ENOMEM;
 	}
-#endif
 
 	return 0;
 }
@@ -452,9 +448,7 @@ static void __net_exit seg6_net_exit(struct net *net)
 {
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 
-#ifdef CONFIG_IPV6_SEG6_HMAC
 	seg6_hmac_net_exit(net);
-#endif
 
 	kfree(rcu_dereference_raw(sdata->tun_src));
 	kfree(sdata);
@@ -520,41 +514,28 @@ int __init seg6_init(void)
 	if (err)
 		goto out_unregister_pernet;
 
-#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 	err = seg6_iptunnel_init();
 	if (err)
 		goto out_unregister_genl;
 
 	err = seg6_local_init();
-	if (err) {
-		seg6_iptunnel_exit();
-		goto out_unregister_genl;
-	}
-#endif
+	if (err)
+		goto out_unregister_iptun;
 
-#ifdef CONFIG_IPV6_SEG6_HMAC
 	err = seg6_hmac_init();
 	if (err)
-		goto out_unregister_iptun;
-#endif
+		goto out_unregister_seg6;
 
 	pr_info("Segment Routing with IPv6\n");
 
 out:
 	return err;
-#ifdef CONFIG_IPV6_SEG6_HMAC
-out_unregister_iptun:
-#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
+out_unregister_seg6:
 	seg6_local_exit();
+out_unregister_iptun:
 	seg6_iptunnel_exit();
-#endif
-#endif
-#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
-#endif
-#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6_HMAC)
 	genl_unregister_family(&seg6_genl_family);
-#endif
 out_unregister_pernet:
 	unregister_pernet_subsys(&ip6_segments_ops);
 	goto out;
@@ -562,13 +543,9 @@ int __init seg6_init(void)
 
 void seg6_exit(void)
 {
-#ifdef CONFIG_IPV6_SEG6_HMAC
 	seg6_hmac_exit();
-#endif
-#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 	seg6_local_exit();
 	seg6_iptunnel_exit();
-#endif
 	genl_unregister_family(&seg6_genl_family);
 	unregister_pernet_subsys(&ip6_segments_ops);
 }
-- 
2.43.0


