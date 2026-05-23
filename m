Return-Path: <netdev+bounces-291064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGUQMJpmEWo2lgYAu9opvQ
	(envelope-from <netdev+bounces-291064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:34:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 233A55BDF1F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA2E3047E60
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60BF360EEE;
	Sat, 23 May 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7MsV/0r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CA357CF1
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525018; cv=none; b=IVdu0UmMncC161ArJ79MrXj4F4J8yGsN/BDd3nV8HJjF0Y7OlLtR210UuK4B2muk75uDam0GRUdh+Sl9suXzqavLWfpJ69LGbibNY2C/pxjEe0tFEQL5R3JS7+CL+2IsdQdpiftk7t9EHYw4ZsQ+RNupayojoHq4eykTWHZNjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525018; c=relaxed/simple;
	bh=LQDpdnjoLZYsNy6KOVpx5tVW1GPtQFRAAgqYXGZAff4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iG5pGE0U7FISRnHg1ezw9GMc/RGEJiqh9hbsRop7jf+73jAxnGA46TUdRRb7Rf9YCLK2/jY1SLETi9vqnKoRxho1XbJgNZdemnqiQGl6BqvoWzyLjyzWl4sJ2wLSp/4k1lQQuSjDVq/Yo7esOPO1xDpWvvMlN2EYC6Ma+Xu6zY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7MsV/0r; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba718173d1so140048855ad.0
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525011; x=1780129811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvNz1WBZQHLaTYhJaNJh4Rde3P3k0f6Og7tKddJIGXk=;
        b=c7MsV/0rmOV4ClcHRM/rwbSbPt/STXIHJiYLoj8IdNh4Z7Do9lDScjkaK19ngrFnw7
         Dx7d5yatbYMo63/4IXDPoHUF0F49EaKDQhOgom4ZtWXEahCadKl5BLmIm/zTr5IchSlh
         gG+c9l9fnhwdHOUujI58CCt7mtVjIssoCxq3+AmsDnu/48JFiwET4q1vkIqysJHkDnmX
         QU9hDRQCmw/cbYOCgsZkAR7RxQUS6PoGGs8NxcDwM79B9q/F2/uEm91e8PqxxgnK+xaO
         RNvO9E7OmNdClVaHsCAIYMeSMMiuTA7oXfdBczdxTSGZgQAKg4x8WpwIpWitcBJEVp6i
         ZL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525011; x=1780129811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvNz1WBZQHLaTYhJaNJh4Rde3P3k0f6Og7tKddJIGXk=;
        b=PfIqL/XUg62f+psMaFPLJzNhlQRl+qkGYTPirlO3Hm40XYhVmhsdmqKHxXkScMiKLF
         0luoeVGrpGHqdR2C1N0m7pxlD7GUi8J2utVxdBrhHAWYX6taQxOh+PQP9BVvqtGcTIn5
         WKyq8CYyyNv7eRoexRR/rJksUR24Pp/5xE1OtEqj7Qsvh7TXlbgKj0bJUwDiSZ//Ut8F
         Vnc5hHxP7U7WTXMLiOz4TZyA0RfWs/RcXnw3X83YYrxdv21pWPi7X9cgFjz/yaEaUdnA
         Ih+sndDqZT3JhooOvCWvpV1FFGU9SgyClmgsqwKMsndzx/JLWIUclil2iySalHKBgSsq
         N6jA==
X-Forwarded-Encrypted: i=1; AFNElJ8o0am8k/WPvoClXX8ldvURL9IIXigpX9aRSv7o8wRllW6QqtL7qIQSZ2QA2mtxadJYtVfkMhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtBw7zH31UQs/56Mku9ezRyVbAmXYHDq6nkwlLTpmJI5LB9ds
	tYHqh0VPgd/WvvoFy1RBM0XDGbi/CH5MZ2X4REY5ZQLOh0M0wYNGo/5zM22JY2SyzA2ka2m5Olj
	mxs5lqw==
X-Received: from plsq6.prod.google.com ([2002:a17:902:bd86:b0:2bd:34d1:ea8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2b:b0:2bd:ef12:14d6
 with SMTP id d9443c01a7336-2beb06cfc33mr77317705ad.34.1779525010724; Sat, 23
 May 2026 01:30:10 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:37 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-9-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 08/11] bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if
 receive queue is not empty.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291064-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.872];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 233A55BDF1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Unlike SOCKMAP, BPF_SOCK_OPS_RCVQ_CB does not iterate existing
skbs in the receive queue when it is enabled for the first time.

In practical production use cases, this behavior is usually not
a problem.

We can safely assume that the upper-layer protocol is designed
with specific synchronisation points where the connection is
temporarily quiet.

At these points, the application can completely drain the receive
queue and safely enable BPF_SOCK_OPS_RCVQ_CB while no skbs are
pending.

A prime example is an application transitioning from HTTP to an
RPC protocol:

     Client                                Server
       |                                     |
       | --- HTTP Upgrade request ---------> |
       |                                     | [Drain all skbs]
       |                                     | [Enable BPF_SOCK_OPS_RCVQ_CB]
       | <-- HTTP 200/Switching protocol --- |
       |                                     |
       | --- RPC Frame 1 ------------------> |

However, to strictly prevent any potential race conditions arising
from unconventional upper-layer protocol designs, let's explicitly
signal a failure if BPF_SOCK_OPS_RCVQ_CB is enabled while the receive
queue is not empty.

-EUCLEAN is chosen to indicate that the caller needs to clean up
the receive queue before enabling the feature.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 82ec2291d6f0..4041b9fc1c74 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5390,6 +5390,9 @@ static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
 		return 0;
 	}
 
+	if (!skb_queue_empty(&sk->sk_receive_queue))
+		return -EUCLEAN;
+
 	if (unlikely(sk_is_mptcp(sk)))
 		return -EOPNOTSUPP;
 
-- 
2.54.0.746.g67dd491aae-goog


