Return-Path: <netdev+bounces-98373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBEC8D1283
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 05:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E751C216C5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 03:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5E12B71;
	Tue, 28 May 2024 03:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/1R3+9h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80BE15BB
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716866745; cv=none; b=vAKHq8GzSfZwGDFKP0++YFz8dpncKbli/b2GphzyA3WayormXWZZjK4NnlkyCtaaSdslb9qxeMTnlSG59caDpZBkOGg+B9XRXKAVjnEnYwmOG1m1Z4ejKd8ApZMJ+PPt5TiGashHzG1u0d5hdBNZIX6asABfaNWMVRDhegV6Isg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716866745; c=relaxed/simple;
	bh=gYc9uTWwl5rsrzapRFgh3cG601k6PgR7S/ksOYukqO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXCQFEPxy1xnyjfNxyiSNKwUEP0znPBnzD2zeraI1ohGULjACLp+zuX+wirw21wLx2dWw/gqDBcutC8w8uDFjWmo6SlVH35sEtx09Y2LxR2USPR3Y8/PnTgsMsHEoD/t2ytat0Zp8qFi6oux+aQlFRSuMYjHBftme5PjBNvIDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/1R3+9h; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f693fb0ab6so285625b3a.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 20:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716866742; x=1717471542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XpnhAH1xFXXdwUXh/gODvAkA1aCHw7Z23cRu/wae1jc=;
        b=h/1R3+9hCg5SHxs7bzxcYP8ulL72DRB90JNZmPRceqrYR8LEs7Z2e2v+lZj3vFNPpH
         A2OCmss5kx6zlHFvJ5/fkn2cm0wq14WzhM83NjES5o/OH5u2WQGxgz4zjqrUQgLWqi+Q
         4jZnufPqt9kNtJFLcZeKBxU32V/QofVP0mATUvquSGoPlvdRxllHtJoJabjh0NlxKJW+
         uSVCmBsPazoDsf2iY2RdFeaZS07TZGKxmY2R9RYdl7c9tW9rXFVN2krBk0qdWHJVyOcd
         AWcH15ySMMIxg/xp0kHEEbyoCAEU8F9MF8t2DRDP+IlS0SdN/eFrEgy/a6ffNK0sf9Pz
         PC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716866742; x=1717471542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpnhAH1xFXXdwUXh/gODvAkA1aCHw7Z23cRu/wae1jc=;
        b=X6kUkM4miOReLeIse8EKla3ocEy+uDzAhAcQMVJhvj8iLFwxLmqxPDJq75QHF8y7ev
         TM1QwlVleKzd1zZbNRGBfJh2GZcZ1SOfL1U2Y5qhDI9S1rIrURwLpJ51+233xon+o3Fl
         lg2mSRmOEaP8BcxqQMNaqYDITDTkaoJ+9Eg7Dvf8qgt+3SDTTuVJbJ8XELNgdXPfHKxe
         9OwE5wyRjisyYzrULG2jByZKyL5EVFbE+tX16GbCgDurO9vUWNXCjzoUJy5bTOJ9dLu8
         +0w4miX8DZeSp9D+M2nlyu/OK7v2tbiC2JzAU0L5rcUjhOfew4uu0OoE151obs3OWPXV
         id+Q==
X-Gm-Message-State: AOJu0YwVo29cTF9oS5nuYaKoj1dsle7iY/ltqxAn9BEKin2oDeNPLs9o
	1yBlVEKhxCGrJ6WGz3dM+KYgZ4OWWsE8k5FdLir3TccJoJD0xk7GzeNKlIXJfsE=
X-Google-Smtp-Source: AGHT+IFIALvLMUULveYgn3H29b3QupjVq92PolU1xhTcamf2dKXqcsnwOtfmQreLtXfqpyQfrGBItw==
X-Received: by 2002:a05:6a00:300d:b0:6f8:d95b:9467 with SMTP id d2e1a72fcca58-6f8f329f88dmr13740556b3a.13.1716866742504;
        Mon, 27 May 2024 20:25:42 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d87basm5551111b3a.208.2024.05.27.20.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 20:25:41 -0700 (PDT)
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
Subject: [PATCH net-next] ipv6: sr: restruct ifdefines
Date: Tue, 28 May 2024 11:25:30 +0800
Message-ID: <20240528032530.2182346-1-liuhangbin@gmail.com>
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

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/net/seg6.h      |  7 +++++++
 include/net/seg6_hmac.h |  7 +++++++
 net/ipv6/seg6.c         | 22 ----------------------
 3 files changed, 14 insertions(+), 22 deletions(-)

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
index a31521e270f7..671aa1706d04 100644
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
@@ -520,7 +514,6 @@ int __init seg6_init(void)
 	if (err)
 		goto out_unregister_pernet;
 
-#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 	err = seg6_iptunnel_init();
 	if (err)
 		goto out_unregister_genl;
@@ -530,31 +523,20 @@ int __init seg6_init(void)
 		seg6_iptunnel_exit();
 		goto out_unregister_genl;
 	}
-#endif
 
-#ifdef CONFIG_IPV6_SEG6_HMAC
 	err = seg6_hmac_init();
 	if (err)
 		goto out_unregister_iptun;
-#endif
 
 	pr_info("Segment Routing with IPv6\n");
 
 out:
 	return err;
-#ifdef CONFIG_IPV6_SEG6_HMAC
 out_unregister_iptun:
-#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 	seg6_local_exit();
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
@@ -562,13 +544,9 @@ int __init seg6_init(void)
 
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


