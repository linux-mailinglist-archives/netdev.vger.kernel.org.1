Return-Path: <netdev+bounces-224696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8329EB88710
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A0662539F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E88C306D3E;
	Fri, 19 Sep 2025 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iInKhHK2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC356306B2F
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271035; cv=none; b=IvakR5iMdPYQ6fLPrbaskghFxD3Bwt34t2K5kpseVwRIvHJuA7qURbsPrSz3pHAjpsm1NTDE5IZ+jmPPdR5zSIQ0uP5BN/VFnvH1/9IRzENeRBI7sNKP12vaUXhK77E5uHDlxHWzDgEvYVgxQGLImYxkwg2OJhKTieEaRBvsYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271035; c=relaxed/simple;
	bh=S5LWkFdmp4u0GwHB8e1/7PfIbbh8drfuUauHcAADP1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=llk1dkeoR5FQNkcNI/ECXNgkctVvISsAgam5NkoddRzvcSs1u8HIKfn719pT7UWbw+7LWYD5AcNOLXhUOQ3gL4xKylXyeXRtNwimRgLOH3XokgIodpeEe1W9+0wFFNMtT8ut+fQRyzpTNp2BdrrH8KXIT1w1OWHTAqQDq9ThRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iInKhHK2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2699ed6d43dso14720875ad.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758271033; x=1758875833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nN9qVOMEcfrkEys4C5TU1LLDziCCAIlpWbmrnxeil/I=;
        b=iInKhHK2NsPUKWtE7vyfsJ647Z6ade4EQC+9yDzzwrjTr2JogUey4R/qa8jmhEXIEp
         Ung/Soa1kjofJseAYzhhlccWUd6sz9kmBu3WpgmGNu/icmw+haxeMD0nyECzRsFhkiSO
         FxpVdhX6pnGHQGZ27hbAq8d3/K/C4Tf5THzXxqnj8ot9qpMcxGwFcEoP0ab2ICMfkji0
         4yhwQLGUlMfytBQpWqNU5a+MRhXf/CDUNZmn/t2csBzu8GnYx0iNUt65XwGEbDnWhbi/
         AP8cwmE42l1mVKad5W4x2eEuPtfXpj7qbYsFH9cJt6dGhD2Ym8/dSuKB73dKNJtc/ZwW
         7Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758271033; x=1758875833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nN9qVOMEcfrkEys4C5TU1LLDziCCAIlpWbmrnxeil/I=;
        b=B7chHtqRlMNAg4sUU2mtIkiSOGcScqn8sxBhvLrzhjV7a1PamGqyC1EU5vR/VHQpFO
         FZkWzK9LX/nJy7xaLsYy4RnRaJbHazCEihykXgMngiOEDpDMYTpN9J8hIgJUsreyfCDq
         jMb53Jktsh9bXynm7ds/nZw3/5RYqz+u5ZW7Vem1aKIN6/gfbdRVORZNWggfkJ3PYcLw
         JxI2nRQEah4iv2nKZI4Srx2zmXy7+rVqcSYzUaNoWQ+iHVg1IpAZ+pb1RJjMw4iLneAV
         NmFjfoAugwVaYgeUYsoA74kIVZdfrTx3ncXTFWYwI/6pk3LjRCDl6816+tdGaPFSzm34
         D9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoSBFEnrPcWb4ZnXfKY0MIF1W31ullgJUXJRPtKzUrsFToBAvqcXKbM7g/9CCfzhu1Kk3uBCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6ooZH4xwiYS4iDaV1vOGKqN8D98IVOU9tRNnAIx54DhDvZ8z
	HflUpS0kEeHCX1hQX9xIPPBCPZg2ejK0if0T0xAZneeGC1OLqp/k+27cYky1eD2agTkrp/nq0GE
	TTTOaSQ==
X-Google-Smtp-Source: AGHT+IFedHXxz8qz9JpXBWKTEnuzXd46vE5XLNLyd4bTNsJrmnmOH7MWW7YINWo5QqYB7btE2wt6j3oE7QY=
X-Received: from pjuj3.prod.google.com ([2002:a17:90a:d003:b0:330:9c1e:a17b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecc:b0:26a:589b:cf11
 with SMTP id d9443c01a7336-26a589bd2ebmr25293675ad.43.1758271033234; Fri, 19
 Sep 2025 01:37:13 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:35:30 +0000
In-Reply-To: <20250919083706.1863217-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919083706.1863217-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919083706.1863217-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/3] tcp: Remove redundant sk_unhashed() in inet_unhash().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Xuanqiang Luo <xuanqiang.luo@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

inet_unhash() checks sk_unhashed() twice at the entry and after locking
ehash/lhash bucket.

The former was somehow added redundantly by commit 4f9bf2a2f5aa ("tcp:
Don't acquire inet_listen_hashbucket::lock with disabled BH.").

inet_unhash() is called for the full socket from 4 places, and it is
always under lock_sock() or the socket is not yet published to other
threads:

  1. __sk_prot_rehash()
     -> called from inet_sk_reselect_saddr(), which has
        lockdep_sock_is_held()

  2. sk_common_release()
     -> called when inet_create() or inet6_create() fail, then the
        socket is not yet published

  3. tcp_set_state()
     -> calls tcp_call_bpf_2arg(), and tcp_call_bpf() has
        sock_owned_by_me()

  4. inet_ctl_sock_create()
     -> creates a kernel socket and unhashes it immediately, but TCP
        socket is not hashed in sock_create_kern() (only SOCK_RAW is)

So we do not need to check sk_unhashed() twice before/after ehash/lhash
lock in inet_unhash().

Let's remove the 2nd one.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/inet_hashtables.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index efa8a615b868..4eb933f56fe6 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -793,11 +793,6 @@ void inet_unhash(struct sock *sk)
 		 * avoid circular locking dependency on PREEMPT_RT.
 		 */
 		spin_lock(&ilb2->lock);
-		if (sk_unhashed(sk)) {
-			spin_unlock(&ilb2->lock);
-			return;
-		}
-
 		if (rcu_access_pointer(sk->sk_reuseport_cb))
 			reuseport_stop_listen_sock(sk);
 
@@ -808,10 +803,6 @@ void inet_unhash(struct sock *sk)
 		spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 
 		spin_lock_bh(lock);
-		if (sk_unhashed(sk)) {
-			spin_unlock_bh(lock);
-			return;
-		}
 		__sk_nulls_del_node_init_rcu(sk);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		spin_unlock_bh(lock);
-- 
2.51.0.470.ga7dc726c21-goog


