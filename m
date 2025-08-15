Return-Path: <netdev+bounces-214186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B52B2870F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39F51CE8C66
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63A02C0F7F;
	Fri, 15 Aug 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hWqoSfKx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D02C0F77
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289063; cv=none; b=IGlocNQbSwUwGu4SkyqcnLISHlk5GV4JmLESstXIUvUe3BgMmxvhtP/NhV8rq7YPRpfjAwZt9rpe6m3rd7YE4mLEaP5Jz3tX2p3KH4V9pGatta0OrG2c5IiYooNknZ9qajEo68Nu0PwQ5t6fVa4cLMe9Uo/OTmC7Hyon75xd+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289063; c=relaxed/simple;
	bh=Vk6bFDmVR0eydWLS78TqNF3dMof+YgbdfAs4lP1WhE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZOWC0kx9OHTwkVPhOycN43A01zt7yicMeR/lB3dzSxqrBZNP+7ZN7OVuCKBVPps56sM2KUATiLZB2fFRD5GSLC4Qe9SNr/lboXGditvmomgKYccoGem5KtRwqWQ60KztlKFqC2F+fDLWP3R+VVLFJ/PMH8cbK/rCGbQsO5Z9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hWqoSfKx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f59889so22643765ad.0
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289060; x=1755893860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=hWqoSfKxWI9cKS26GMuwbD4k4nLUzAPP/TurqnrxDJv2ylqTueJjJVhF3+gf8QheHT
         HuGuHusaCW1ajNqvYfJXd7gcV4IQhCFucVOhDSS5i3ktcThSH0NszV7RGXvYFxV86I6U
         8DcPJsYTJbJBGOzEH0miHuWkSpg8gbnM7X3pPX1qQyBCMHsfHRMx0pMESaK8goUN0eGW
         meCd4Dj1kw+eHtJYB1lXVJPGzZU9PIO4PQowA8F8yb8Gf+1xNdVpyXzh+68JTEBiua/6
         N1CNRY2k/z66PwW+SAwGCiC7r9/nyY9cZ1EKw28raWvri2edqvQdLjt1semZ0wZQtzgu
         wkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289060; x=1755893860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=FeUkRqDb6b1xE1mSD2FKdMSH3c8up5aYh+f+LjjTgwnyWOYfmKW0Rhus0IdXsj9MT2
         WY0KhTIOvMcTY8rhEjmPlR385Upyx/JRI3d34xuvbZiGTf+yB8DT2eBELrV8yx98vfEM
         +eyNbgpgdL/kml/8jhJreaEONxPagzmebVHviDbzzUtp9hnebov6u9h8sssH2vu/Zdk/
         MWjWhz+7AUbKKSj2h3u9/rk0Qtvs2R2QNLWBOeSrNbsYTawUqcCZe4JiaFO7F4V8NYa0
         +fa8ksJLzDmskkHwn5ldBKHYUNroI5Iu0Qe7ZoYkBB263F4kiM67+RcaVR1IV60zrSqw
         LINw==
X-Forwarded-Encrypted: i=1; AJvYcCWlTgJXknf7aDbByS7poyljEoL70BpLfSH5Y9YPjDOz4u1D9YqZId48vy/cD9+Md/dVaGM+Iug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDlCYu4N52iRnlUsiHou/MGbD59AIzOYUPCBlwOfpZkbBMh2Q
	dKp8aqmARFiqQP9LkqN+jal+TcRWTIRVwbOeB/tY7Zv916lNKevDG60N4UegDH3AlM+PfwLLFdH
	wB7cBqg==
X-Google-Smtp-Source: AGHT+IG+NKmG4fQxWApznT/iNlBlE89VZOBkEiuZXVixRsMQFotYGpJhNutY1IkiTXx8XPjH7buaFadPEzU=
X-Received: from plgo12.prod.google.com ([2002:a17:902:d4cc:b0:23f:f3c5:dfc9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c4:b0:23f:b112:2eaa
 with SMTP id d9443c01a7336-2446d8fe30fmr49723005ad.41.1755289060168; Fri, 15
 Aug 2025 13:17:40 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:12 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-5-kuniyu@google.com>
Subject: [PATCH v5 net-next 04/10] net: Call trace_sock_exceed_buf_limit() for
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


