Return-Path: <netdev+bounces-205186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1283AFDBC9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1191B16DD92
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBAD235071;
	Tue,  8 Jul 2025 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlDyNqb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715DF22FDEC
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016769; cv=none; b=qHhIxYfrnpy1kKIEEDMLyHGw+Nks8xb57AQ4iKbbrtNgttC3t+JgRtM4NdWaKGc2cRWNnpCcM1G+c7V6AuQM0buI+jojutH4Dzq+L+8G5DOl9lyBJuoeziHOlKPLHVAJrkTszKrMfBBqrvEdudK/oAGiDpMouMfoGZB/My2iTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016769; c=relaxed/simple;
	bh=mwiBV/idCsfvmqTx5HF7RZa0gRG17/5zmvzm5kr+mN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3tMJKcw6cfaIl28WQN+fYzlklG/4gz8jEkMd6B+XfZLcTTs+SEMlKyM6rLaCqfZ780Rf6l1CITLmtx9AMGQI6qwBqYyMGU8RZ379mBwCqRLEpB+k7jpnRf1QsS11luIk2tDVna1lcRSmUAOsDw2//n+hqHCHSY54mEVRMbpkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlDyNqb8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af08594fso4718116a91.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752016767; x=1752621567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgsOVk6pnapxxe4lX2gYfSETOXV/rR5QZNVYZlGdS4Y=;
        b=UlDyNqb8r05INxdxAN/3Hhf9ZgPKVGJhFlaNLetNaltDIXFAlKhcJILgrtv7upkL/2
         tJBw+AjSuRkLsGZRCTCDjPPsxwYcbU/GiIyzLYTgnRNd0znqj6bQBKahvD/hCJzs6XZ7
         fpuFsKqxYjIWDZ07rEG7Wxu/wW39oImL+P8XNUmmXMeiPyyFIcaQeXv2rZ1lBnoiU5oq
         bE7E5sDONTdr/vWxFyLk616BSzLeWFnMSFoQu5Rp6dHmkuxOZC8nhYGbUdjJ6/+E79Wu
         uwTLTQ2AK9Hh2GLzPtcOsseKMQJjA5nSxUfPtdQHdrrphL4QkRr8qb+4bVNU6yqeWJxr
         bagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752016767; x=1752621567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgsOVk6pnapxxe4lX2gYfSETOXV/rR5QZNVYZlGdS4Y=;
        b=FbUbu4+13QEN4WDBSPjhW09sos7qfgvGZUdi6lqdII6FIBFHa6lxrwRaxYNcamanMw
         MfpqaA2DQUhmXF7x88a2n7QisZ7suYgA/ygMwmkbbmPp5ovHp1XnGLEyws1P31TzAFAU
         bNafXBWKS7Bq6rx8qQ4LsPVKsxcB6dF12nhz6ZCIsIvTGsMdJOlQttXxBEjqSEvnntOI
         jrcCSt7oHtdN9PWDmVvFDieBUnvz0BOmcta+Jy2lLsi4j5olffJu4fOVFSz5XUPOB2Pl
         Re1M+WT21foPUfCKEwcFetbojfbZySeK2cIPjlzlkst6DoIEi4MPIPvuzkJzRBSxi28k
         4cwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNAxqzxPcDZSs85xKWubI5qK3mZuPGqOc+pb5BnzVOp7mgE0f1OhAuH2dIuhX26DVly3097z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYigKNHb3u4HRLTuhTstLIY7Pa0yBA5J95jC+Sukgn8u5wBch7
	nWjuP+V4VlhMHtkGcgLacqiHbQnbb5uDDFi5/QnyegPx62O5Q0JQMxpnYecobTSDc0EOFtO85Bp
	nEigUPA==
X-Google-Smtp-Source: AGHT+IG7zQ9XnoyQh2yDcqTLoCaQHm/hoQKLOGY9SduXB9ruG6XWWO/q3+eH/SYCDCMEMoV6oiKscoNj9RQ=
X-Received: from pjbtb14.prod.google.com ([2002:a17:90b:53ce:b0:311:ff0f:6962])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5202:b0:312:1ae9:153a
 with SMTP id 98e67ed59e1d1-31c2fdc8eaemr639128a91.25.1752016767675; Tue, 08
 Jul 2025 16:19:27 -0700 (PDT)
Date: Tue,  8 Jul 2025 23:17:20 +0000
In-Reply-To: <686da18a.050a0220.1ffab7.0023.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <686da18a.050a0220.1ffab7.0023.GAE@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708231926.356365-1-kuniyu@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: Kuniyuki Iwashima <kuniyu@google.com>
To: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Date: Tue, 08 Jul 2025 15:54:02 -0700
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> net/smc/af_smc.c:365:3: error: call to undeclared function 'inet_sock_destruct'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>

#syz test

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3760131f14845..1882bab8e00e7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -30,6 +30,10 @@
 #include <linux/splice.h>
 
 #include <net/sock.h>
+#include <net/inet_common.h>
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ipv6.h>
+#endif
 #include <net/tcp.h>
 #include <net/smc.h>
 #include <asm/ioctls.h>
@@ -360,6 +364,16 @@ static void smc_destruct(struct sock *sk)
 		return;
 	if (!sock_flag(sk, SOCK_DEAD))
 		return;
+	switch (sk->sk_family) {
+	case AF_INET:
+		inet_sock_destruct(sk);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		inet6_sock_destruct(sk);
+		break;
+#endif
+	}
 }
 
 static struct lock_class_key smc_key;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 78ae10d06ed2e..cc59d0f03e261 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -283,7 +283,10 @@ struct smc_connection {
 };
 
 struct smc_sock {				/* smc sock container */
-	struct sock		sk;
+	union {
+		struct sock		sk;
+		struct inet_sock	icsk_inet;
+	};
 #if IS_ENABLED(CONFIG_IPV6)
 	struct ipv6_pinfo	*pinet6;
 #endif

