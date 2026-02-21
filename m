Return-Path: <netdev+bounces-259837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3U+oCZtAmmlXaAMAu9opvQ
	(envelope-from <netdev+bounces-259837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:32:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295116E3B6
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8ECE302350D
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 23:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3093E2DF144;
	Sat, 21 Feb 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3mx8bJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939D246778
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716759; cv=none; b=CWSkP4NAry7EixfDxt6yrxbfdKIoa3BCdhLXbFuq9/1qkeqCESV7LfQAVJWiXu2DTZruSanwTygTCQ0ljQC8CAuQRA104Biboo5xkcyXHDzebZ+17G6ecU0dxPcFpw0HQitCO/+gn3MofqkrGruuyj7lu94mpM8kPP92utnyeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716759; c=relaxed/simple;
	bh=UnRv2kJQ1JRFuj0LmylGhr3hYfhCjC6ZpVyTyO8dyzA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T/nLKPcN0TU3QvDJ2QvXmzgwno3UGmZAEWZfnv0mEWgXrZUMkBF4WmloycJe2Yx6UDYHWb62bOueBnVZC7p5zeSz953tPO3Muw9SceRNlncWIQ7cQy6yRGgIiTTULMyedC+YZ8eeX2RgnxuWZlp+hCIJkvnlUaIWxEgvKt8XwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3mx8bJz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354490889b6so15612185a91.3
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 15:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716757; x=1772321557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3oo5WYv92eSKemLtXmzpyJfmU5CKEG9EoCH4o0pkRSM=;
        b=Y3mx8bJz15tOTmtI6WHO64/CEgnKJun9MysaaCckEmE8k7274d6bEYxFmazDQSRfVU
         k7bJZgDiK7QJj0zkaXmRGuNVQRUjUyQEEe5L88dCFwojaUM4ieDUH8tisFcVffBDktEn
         mcgWTyUvBpWtIPcKdFHwzUpn30LR++UXgMSuMvDPerCoceHp2PoI0Z2kZFvhM3mXNfsb
         hGRAT+O18Wo8OV8+XXE/T8T23Dvj/3G4C+kDHSBez8xV4/emF4CP25mr37y2OVlNtWKz
         a46RekAF7EPYPFvM/mMXJ8POUUtnjfLaitSqVXwy1nntpKPN4VaZwNoY46C30tbH3HFu
         Jt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716757; x=1772321557;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oo5WYv92eSKemLtXmzpyJfmU5CKEG9EoCH4o0pkRSM=;
        b=XCGF4VrEOlkiMs+FtPP3wpSaqqEEsNHonZQBdj7eY/Id2aGUxKeGaIsZHLJ3Sj5uWM
         c51LG+j70UqMdFOTrsxGjbdLKZo/79COBBCmj+aeHyoN62/JFvwYD0YK7rCNm0pI4COu
         /N36yXJ7tYZLMvTAS1MEYh6GTKczYFyBe8knsBikSoZXtyrSvFqmNhhYJnoUnnW0cO7a
         nzhZdiAa3PG4hZT+PlvM/lFA2qkVaShJWy26TXF21xRpnemnLG5XO7NPgwRGJV8r6zQ8
         ox/tgkTC53CP3SqSpc2g+uAw9caUsPmxWLtYbIYt4q/t97EqQll6WsTUjjiVGB8pyzIM
         nQNw==
X-Forwarded-Encrypted: i=1; AJvYcCXArh1HW4DICsCA2dA0iNhwaytvxoKv0tRqGOyQxtHBU9293PmXlNu5gcYwZDxIfo7ltd31dVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+pZRWrTuzSl5Xk0vOxTTn9pkUIcGpa1vN/9PXEDW1zUpc+UO
	mWq47Tgxx27xwXnZSNshbICwzc8nQ7VfzplcrYKZUjaN5m/f5STRzbIQp4+MbjxhM+oVZu5U/Ir
	hZyhHdQ==
X-Received: from pjbcf11.prod.google.com ([2002:a17:90a:ebcb:b0:354:a065:ec58])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4987:b0:349:2154:eef4
 with SMTP id 98e67ed59e1d1-358ae7c86camr3321615a91.5.1771716757214; Sat, 21
 Feb 2026 15:32:37 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-1-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 0/6] sockmap: Fix UAF and broken memory accounting
 for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259837-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7295116E3B6
X-Rspamd-Action: no action

syzbot reported 3 issues in SOCKMAP for UDP.

Patch 1 - 2 fix lockless accesses to sk->sk_data_ready()
and sk->sk_write_space().

Patch 3 fixes UAF in sk_msg_recvmsg().

Patch 4 - 5 consolidate sk_psock_skb_ingress_self() into
sk_psock_skb_ingress() as prep.

Patch 6 fixes broken memory accounting.


Changes:
  v4:
    Patch 4: Don't pass gfp_flags and instead change it based on
              take_ref in the next patch
    Patch 5: Fix memory accounting condition from (skb->sk != sk) to
              (skb->sk != sk && take_ref), the cause of selftest failure
    Patch 6: Fix deadlock when requeued

  v3: https://lore.kernel.org/netdev/20260219173756.315077-1-kuniyu@google.com/
    Patch 2: Use WRITE_ONCE() in udp_bpf_update_proto()

  v2: https://lore.kernel.org/netdev/20260217000701.791189-1-kuniyu@google.com/
    Patch 2: Cache sk->sk_write_space in sock_wfree()
    Patch 5: Keep msg->sk assignment
    Patch 6: Fix build failure when CONFIG_INET=n

  v1: https://lore.kernel.org/netdev/20260215204353.3645744-1-kuniyu@google.com/


Kuniyuki Iwashima (6):
  sockmap: Annotate sk->sk_data_ready() for UDP.
  sockmap: Annotate sk->sk_write_space() for UDP.
  sockmap: Fix use-after-free in udp_bpf_recvmsg().
  sockmap: Inline sk_psock_create_ingress_msg().
  sockmap: Consolidate sk_psock_skb_ingress_self().
  sockmap: Fix broken memory accounting for UDP.

 include/net/udp.h  |   9 ++++
 net/core/skmsg.c   | 100 +++++++++++++++++++++------------------------
 net/core/sock.c    |   8 +++-
 net/ipv4/udp.c     |  11 ++++-
 net/ipv4/udp_bpf.c |  11 ++++-
 5 files changed, 81 insertions(+), 58 deletions(-)

-- 
2.53.0.371.g1d285c8824-goog


