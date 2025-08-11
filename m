Return-Path: <netdev+bounces-212551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3DB21336
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3623E36A8
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4B12D481F;
	Mon, 11 Aug 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWVhbqyS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBD2D4812
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933497; cv=none; b=GkA3r5cfZqxbu+VsJUPo2oJKgFgShihBdxkVczcxPoqm26sHH5CkJid9VHM81MPkKvw77yMqI0M7uzvvoSTHbBZ5Xb9OgP3Zc2EcdkDhjo5wYMCx38QDwpHdFo+yxWi5gb1rYNAWEMHQ5iF83YTzJPsOwl9CGNQFFpequqo7pmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933497; c=relaxed/simple;
	bh=cucv/ThaYCwJefTQd8IcFflX9agEM1pAaEXctYSSzBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dgHfw55Zuel4SZKCymiiNVwxrB8Z2osF/QYPYXLIUPlrG+FuBYZSZaSaM6x0nfCdE+apJjO2yj3zM5B//hH+djFv2O2v+vBYvGLKU0u+QBm4jzhA6bQw5dAhyZCnNNdg5nMc7laTD3kL7eISoF7f9OFF/yz6WR8TTYSCmCm2ZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWVhbqyS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bed3183ecso4870330b3a.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933495; x=1755538295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbWyNjhRffdizOWiIb7bDk0DH91Nu7zFnwGTY/wxrLs=;
        b=CWVhbqySVhPamBgE+Q+4h2KBcU5NODouDxX2KumjrO7ujfvTRa3G1j8tp8OUdIeu8c
         MeK67Co+r5zXHJ4+cSh6qxA/zI3MlCep+9i1vxxqDapTDCKCX/rQYPh/PSI0UNwXFz9h
         uTRqjQv1jDnrSEoW3ZmI++VN9dF0i8wGC+joLI0azNENqJv0zWOHs9JW+tyHMNX6ZXSs
         Ny2b7RQEkBl7Y7E3lX/Pa800aLctUpUg75o6LsOTjJU9uvfiOoe9LDgg32iqB5UNRPr+
         MPTlSC20BdcYfzFsoBNt6ZnKlE+ILJjK+RmeLLPozFdVF9W39GRtw3WREVuEuxAR4OEa
         p2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933495; x=1755538295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbWyNjhRffdizOWiIb7bDk0DH91Nu7zFnwGTY/wxrLs=;
        b=HsD2ir4n5w1ybekRFSrpxXSrmTXZfuJLLIbrYNbIqBmGbxZ3xCMgWFlP9FscTnjelb
         vTdcqauunTHq/6eeNqvYrtoRQgby8htsRmufr/rbQpmmVndXdbzAOa8XqPqC3icw1Ya5
         qKUDYpIB6NjehN/+l5/E4HhmiVHTbgn798JrThkFiCMMCaoTWjHm/beiQhWtEFMGO1xf
         X0MeVo2WgWV+CIxgh6sImUzssLcCB1jJmvC1QmmK+snD2w3vxnVNy2ilo83Z+bIWIjCI
         dEG98ZhYzRoGhOmx06yNI+Iq6w0yzAlJqSZJb0keUIzzTzURISox4NPA2Hb0M2mBsYl7
         UEYg==
X-Forwarded-Encrypted: i=1; AJvYcCXwg2TYWIoGbhJ3cZ6ujg6HweWWi06IIpg5RhYPijYyTkBEBURZvSWX3x4GnoknaF2lkOsLt2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI29neq5sPBrH3R4NhneKZj66qruaJ+hsOxtJnYKsEev5+vESL
	agmRA7uTgwLOjwy6B5GbSseKH6U5cveKxoXCz+3PlosJuxBSADcveuKPedmR/aALaQGGjCSsrJu
	VUSuIgA==
X-Google-Smtp-Source: AGHT+IHxJ97+AwE076KxPYX/sWcCDY1XqeMHaZ3AGAq4oCcRt8YytBHiFg6jXlxoMu/lw9gst4WNB9FALdI=
X-Received: from pfblh2.prod.google.com ([2002:a05:6a00:7102:b0:76b:8c3c:6179])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b46:b0:76b:f01c:ff08
 with SMTP id d2e1a72fcca58-76e0de2de8emr552627b3a.2.1754933495361; Mon, 11
 Aug 2025 10:31:35 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:31 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/12] tcp: Simplify error path in inet_csk_accept().
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

When an error occurs in inet_csk_accept(), what we should do is
only call release_sock() and set the errno to arg->err.

But the path jumps to another label, which introduces unnecessary
initialisation and tests for newsk.

Let's simplify the error path and remove the redundant NULL
checks for newsk.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1e2df51427fe..724bd9ed6cd4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -706,9 +706,9 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
 
-out:
 	release_sock(sk);
-	if (newsk && mem_cgroup_sockets_enabled) {
+
+	if (mem_cgroup_sockets_enabled) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
 		int amt = 0;
 
@@ -732,18 +732,17 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 		release_sock(newsk);
 	}
+
 	if (req)
 		reqsk_put(req);
 
-	if (newsk)
-		inet_init_csk_locks(newsk);
-
+	inet_init_csk_locks(newsk);
 	return newsk;
+
 out_err:
-	newsk = NULL;
-	req = NULL;
+	release_sock(sk);
 	arg->err = error;
-	goto out;
+	return NULL;
 }
 EXPORT_SYMBOL(inet_csk_accept);
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog


