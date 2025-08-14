Return-Path: <netdev+bounces-213832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C357AB27006
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B85188A42F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528BA258CE9;
	Thu, 14 Aug 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KOOMnwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0373256C8D
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202163; cv=none; b=nEsnda8I4sOgwd11Vl7FjbX47N9eGZR7kZ8sSTRWefjozcnFplET2GxOB02O8U7TnXnS4qGuV40xqLOV/qyaZ4v56tEixp0ZDeyvs5WzPqKLyx54+1YdCMgWtEHEpkFnIpIR6DU29ubSF6O/fIKyMY2MvnfbaWyBrTbZJOGpYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202163; c=relaxed/simple;
	bh=Vk6bFDmVR0eydWLS78TqNF3dMof+YgbdfAs4lP1WhE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j02SPKlUacsyAwD+4YajjDr2lIw8CzTMwh9ltFL+6rPGQCnJv72OOwPGZJqjp6M09MSacW/r1bUSO0OfMpoE1XhKd9ZeDGhci33hClhsz45otSG+MJHEBzQObkGop5utQwjRCHzpsHgXWfsIBZ6+P/quQrHaLgaRYTRnl2ih40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KOOMnwD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445820337cso13305205ad.3
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202161; x=1755806961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=1KOOMnwD9qf3JJMbtLeSsgmlpqKiUvgcHdZbWPxcWFr1VfLgP3Yy0STR3b4hOpmw1k
         L7Q7kk+Z/JQDlz6zit7ZbRHw3dDsky70nnmTIXacB82s+5hk7ov1PMMCvfALUAcBYRk5
         Pgrp2Fjh53O6BsYYG7PdhwhJ3O8sa4LMy5c4tshnyrirh7ZOlbduqM21tzLcn4XHCSCa
         21URosIhOcNNk6zcz8ZGHi9zTUn3K8AjzpgjqNh3AEuhUgGDY6/THuYaAC5teBe0qrUT
         QiU++FmjvmGvbPryNHOBKSJW/10WWPIsUM7X5MjRnnpK2XTEqbtFLr+yK3tf16NVTkME
         o1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202161; x=1755806961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=P710rJHZPJRSOuPxFSMwFHPbpNMA9Rd4yC4sOAokvvQYUt5hZjhm5eEwdxYIiHPC5v
         9IwUgQlmihwKBx4aFmQ+iW+YGAci5RFUIuyDqvTaw5IbEGNAIs1l5xlJhJ3ez+o42uR9
         23wFDM7uihtCRoxq405H4a1r4rRZydXWyUN23QVAr5CO1gBmJdKN7l/4JMSSzDNdb9H5
         ikUqSh2xnjSoNXJE60Eu82U20vQq9774EjRmJMp1Lnke2AOxjm/IL74rj3IUFP9q4vU9
         QS+U6DJnixGPkCgO3WhcKe80whJRwSnZicHzMj/wMeQp4MmP7wPf70CLov4yQTZgmHwq
         rk9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBHRd72T0rnP/H3rFYwqf18ZGO2hrPurxNm/dopf7nN/k9D+l3wi+K3vvixXevQ+xeQdvKLQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQATFCU/J/qPsP284wC2Lypd4JLZVRyai7l7nxZEoS7klni2b
	hWgIfgQpsRGXqdnJ9UeljIiLhzhio3NI2HwHm53s1pmSxGbw4SKfq9O33Pf1UCiWZWQrYiCNVoh
	++Lhn1w==
X-Google-Smtp-Source: AGHT+IFZG58mv+xFex5I3IvbaYDViC565d/Zaj2y0+6TxgO46lJTn88mwWlXmxsJcHxyM0rDApPblLTIl7c=
X-Received: from pjbpl10.prod.google.com ([2002:a17:90b:268a:b0:321:370d:cae5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d488:b0:240:92cc:8fcf
 with SMTP id d9443c01a7336-24458b58443mr83319395ad.49.1755202160983; Thu, 14
 Aug 2025 13:09:20 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:36 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-5-kuniyu@google.com>
Subject: [PATCH v4 net-next 04/10] net: Call trace_sock_exceed_buf_limit() for
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
2.51.0.rc1.163.g2494970778-goog


