Return-Path: <netdev+bounces-212552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A540B21337
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7EE622A8A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5382D6E4A;
	Mon, 11 Aug 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="je3WKUAL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73C2D480F
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933499; cv=none; b=DPqMpktr7T8SUm1ATW4QPzARQ39LLpzh1goKXIxofsNbIxx3PKNoetb1KYPuoxaEQh+twT5hZEv4y1sn2FpAiVcwQ+cUxfeZAxHqy/ySYxa3CRJ3FbK2h+tOwucZgAD8s4yxd76MkhwIIjvo0Ndmq2K2mjtZ2VSJM5PqIgAFxQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933499; c=relaxed/simple;
	bh=0sASMMf3hdYMOoWJgOc7ZaOQV4MEaeOmZCKjZhVqGRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EOIIARTXEaP3VKlLJiFfh+EGvTkUVDYlNmmM/uEd8VNR+KyKFZYhfgqNLF1q1a3cTIVQpYQ60Is17zNGRD4BofpO88hl1P7sHz0OYqdp/zcILG1iMrRRVeGq5oyVnVKqZ2WUxtHVCCUxzVRdcDudad3GFFfCGG4SYvEr/8okXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=je3WKUAL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b44fdfe7b8dso1245759a12.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933497; x=1755538297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2qfuFeHIs9pZcvOOidK5ttDb4kIntPZhb9KYt5G2e4=;
        b=je3WKUALSp5ZZNqNlbH+/BbO2Qy2YOveCQdPEOqQYZvNcoRvnC7LnLA53T3hJpK28E
         G8DbUdtnDwUgQjMNL1zfQBZYjhgDI5ywM1ZMEB2RvAvB6IeHMnjEVrbphUXRJjCRLJoj
         2WLbcJ1OEGdqnnyhL3v8bsP/kMyNsy/ZCJN/5zB2PfnGj3X4ZO6bE3YxtX86S91ltxFW
         tiiPOLaXsKPIa3m2rZlANMnKh/W9/YnC3tDIUVFgBCY6vFpMQBPZrHYhvo+wepW68rIK
         IzzUHL+ASzeTRSrKVBV3KeJVsC11Id3htEHM1jc8vjRCrXazX0D5yaTb7CN4iJW9/kVD
         TJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933497; x=1755538297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2qfuFeHIs9pZcvOOidK5ttDb4kIntPZhb9KYt5G2e4=;
        b=khQ0pPSAbIjdViURvfySOwfdA71idQPjZPJPy/ClBYu2jzd6LMwNGMuWT7uNKgBVDu
         4HPe3GvG0c6b2rxDp0cDptqvTAkQ9ODfTs/ZMe3WZ3Ysk1ihbLwfwSL021nWB7nE+fI6
         37gXL7XWan8lNwt7VE1fxh0HeVkmE1xk88deNa+7un87qOyiP6zeOQhTmlDuC5R0ZgdU
         I1N3u6S9H+JxHfCFh3Sc3zWqcMytajclSHt7LyIsyD6YXJDdjMohVJzTY2AfPQHmIu5g
         AkRH6mHTDs8dIbw9xwIhtY+LTLbGSJQTjPDeunF5DXqHgKs90kvOTGTb9esryh+3zB+i
         qeuA==
X-Forwarded-Encrypted: i=1; AJvYcCUbeRH/2PUqLNZCFjHWpv3lDFtDxVGut+zlp3ezgfmdvOVDZ3G0NEQD26Pd9nFokv0fzk/inDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZs9hghtBJOVgcF2ZuzzV06XKhvxqqJK79pB+ULvyK5zE1Bltp
	ltjNxDvByg0ajVLgiVQoLsBq7hKdDwottyH6FSTa9awUHD8oM5J/n9FAsvctnFAG0lgBuJ4s92w
	j9ordxA==
X-Google-Smtp-Source: AGHT+IFCL/e8m3EpZsorqhDOQWgbVKsvSbTHCyrTvZCPhbJX57+yQJEYtdDdTVRR3b+15GDZLagPnHJ4FnA=
X-Received: from pja13.prod.google.com ([2002:a17:90b:548d:b0:321:abeb:1d8a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a23:b0:23f:c945:6081
 with SMTP id d9443c01a7336-242fc31aeefmr6642605ad.31.1754933496988; Mon, 11
 Aug 2025 10:31:36 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:32 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 04/12] net: Call trace_sock_exceed_buf_limit() for
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
2.51.0.rc0.155.g4a0f42376b-goog


