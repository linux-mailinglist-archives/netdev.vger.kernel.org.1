Return-Path: <netdev+bounces-213061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BA2B2311E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D7C17AB52
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D42FF178;
	Tue, 12 Aug 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qM2qE+ZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202F2FF160
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021543; cv=none; b=A5vldYL9X0+xkKRTX+0H81zfGGuAJ8lvDWF69vlRsfy+sNVnAxqcTQDpIOghXkw0j3eN3DOjPYBomtNyDXr+SBJKdVb57n84QSIAnEhQ4mnwSZMRNQV4PVdPqFK9ciUKhGi+afkvssvuALt8kC0jkZu/Xxe8V1k2vFNXQju6n08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021543; c=relaxed/simple;
	bh=SLf5TpKyjI/drORtpadj8vr2WiPeiiJ9tj+Tj+3jSoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k0koEtQMmv2Dc/KGyfzOGEdoTxH4jw+hMpaHpmw3qF8DMvIwJboJmndG0/juvbRvO5Yy2/kgdL2SKemkYR4fbz7yhymnjKsfWBSBa0kBKdJpYRghTUSNI+VmO5Suvhmcv6kO1jJx4fkaJ6CFjHL27n6T14kDu3Jymo+k9L9/X9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qM2qE+ZL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bfb082331so5549783b3a.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021541; x=1755626341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc3v5O63MgSThFhi2UQQb6roBFqZjuJWPv2BdHmfVp4=;
        b=qM2qE+ZLyF+8ffelHX3bYq1PvcxXFWGAgjcqjLHkzUtSgUTqTMLMJ6+QjVC+6GmaIb
         KQzN090K6oylTaCalI1SF6FnwJYDuHMSovhKvmEK9lIRzOzazv+pfZZIVDJOLjfFBFRc
         M8F1ruXujcorI1Vg2ed3LQ2FxdapY4JtorDpdsib5PVQN4DxM3IXV3bKdOnb8tlOIH5q
         qC0LIlgTaPd8fgTEeFYhm0U7b5RSG+JwFop3uL503EHi7Is7WPF9CTJJmFHICOmoKPpN
         CTYxLqpPqrxG3zqPYGUdvj02CrnZhhToBcpFdof8UKXz9RD8MBRpdkAAPKE7tWLkDJrw
         pMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021541; x=1755626341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc3v5O63MgSThFhi2UQQb6roBFqZjuJWPv2BdHmfVp4=;
        b=lPFrzCKS5opa1IA8pIjlowCbVKkJ9eGKnhzOQUaZEQZ0+2IHP6wXAHVTevKXoxz6U2
         mcHQc6Cp7wFFtmS4+V680S9/enHgllIHgnYxKSXUqMgexFsCD3rSHbE01MgYD58rBnz1
         sCFKIuYRU0wqiZtESD/5ORLLHCRW/n0FTdY1Y8iichpTyxKp7jCYpJXWNP9tJ/6AmGY7
         3WHbyjswCoLkXVyFlwUsVeyUhaEU4wxWc+//g0bXuUYPfSAFXC3avxw5lkz4URPXK6VE
         rB1nLAaMSQeC5SzjjDPPxMLhhypUjj0vDLVemKGJy8Iqnosz7xZZMBEhqvNF1dHjKg0M
         BhcA==
X-Forwarded-Encrypted: i=1; AJvYcCUrsEZ7DgbGue8JfFIhu25qqgzG4ISDqKoI9LgkVr7bwyACSRYpXfPynW6vaoXk2dDiJsnC8kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOl6gVVWhDv6ibPTxTXEqb8G66FpRxz3WARQvMuEokTjasZGd
	OOYVSYiDvE/YglZNloSSinLX1qpKMw2zVPmVf/ltszTj4xCx0lXPZfCOgjNP+zQTx/YyFPpe70A
	2b0J3fw==
X-Google-Smtp-Source: AGHT+IHNkeTr1IXEx4pv8zbKdsHdKo0sVR+9B+i4vxPeQfrBSyN50QT97gh1gKgnaZexsZ6oSyAsjRSzwYM=
X-Received: from pfbko17.prod.google.com ([2002:a05:6a00:4611:b0:749:1e51:d39a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12c2:b0:230:69f1:620a
 with SMTP id adf61e73a8af0-240a8ba6504mr218627637.42.1755021541287; Tue, 12
 Aug 2025 10:59:01 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:22 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 04/12] net: Call trace_sock_exceed_buf_limit() for
 memcg failure with SK_MEM_RECV.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Initially, trace_sock_exceed_buf_limit() was invoked when
__sk_mem_raise_allocated() failed due to the memcg limit or the
global limit.

However, commit d6f19938eb031 ("net: expose sk wmem in
sock_exceed_buf_limit tracepoint") somehow suppressed the event
only when memcg failed to charge for SK_MEM_RECV, although the
memcg failure for SK_MEM_SEND still triggers the event.

Let's restore the event for SK_MEM_RECV.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 7c26ec8dce63..380bc1aa6982 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3354,8 +3354,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		}
 	}
 
-	if (kind == SK_MEM_SEND || (kind == SK_MEM_RECV && charged))
-		trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
+	trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
 	sk_memory_allocated_sub(sk, amt);
 
-- 
2.51.0.rc0.205.g4a044479a3-goog


