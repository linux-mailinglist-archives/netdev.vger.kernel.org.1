Return-Path: <netdev+bounces-306344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2YQHEpXpT2qWqAIAu9opvQ
	(envelope-from <netdev+bounces-306344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:33:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 901FC7344DC
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 20:33:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=UhJjnMH3;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306344-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306344-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BDFD3039034
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0543DCDB8;
	Thu,  9 Jul 2026 18:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E805386423
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 18:33:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622000; cv=none; b=ODnZpq6zodKLMfvn7XuOdjuauN6bdXFtjVbzHKdtaYPc7ZT4qBu+TQfz7LZYdW7lmbuW2Tvk0Zo4/p9If3G2hr2FBDxOaCvOYMU677ebUIbQ7P6Xy7clcitNuKYACiEKmPsLySpGW200W5G/m6Sw6p4X/dl2F9heV5P6Wkt0h1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622000; c=relaxed/simple;
	bh=7QiroP7e2iytLXG7GEG+uZiS3ghT7J4xvPFopgcb9SE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jjc2Yiiepmn2RpKQ8bgY/mr7+YtXsYUbMiHJ6HsqZ/C8fgWO0d72zKL1gyABTZCMSq4N9uMcRojDu/K535BBPbI3nnpXszzj098Zs6Joe94czN6jVIH2tfms/FloOTn2orMQ0rh3KHNURMr925mS6pKtxf81mIwlFkggM6mRqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UhJjnMH3; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848452dd146so185508b3a.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783621999; x=1784226799; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTxC05lXIyPAs9F2BvlVKg9IUlP+OVS+7gfIf3qC9gc=;
        b=UhJjnMH3BMGdzEyLL0TvnhmP0r7B7PZI/eBE4rtooePsZQrbklcncpdRTmFpaPpAxQ
         fmU8gGjeS3Og8pEBp9nNAA8UrNJIVyZj9p+U6V/PVP6VxTXQtCQ0O3QLdp0NLYuRue7+
         Nki68Oq3QOsgw9Uo3OADXb13bx77o9wPyxOAS/aSVlTrdJ/T6l5FOpExBf1vM8oOVqXq
         aIMjndZeuOzdO/LgNNheiOQ50vKBEOD6OWNGM9jOf3kUKJR7Yw/IrjIg0ornr+zRHcBL
         ZeIBaWw857TSeEX+6bnl/xswWfd1/lMLjxW9r84uypu+2niGZlz9ZY1N8ConU0QvTKI2
         NPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621999; x=1784226799;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTxC05lXIyPAs9F2BvlVKg9IUlP+OVS+7gfIf3qC9gc=;
        b=cDkV8uHBpOZ7jlzn86AFW3qSAu0NnmrOdKFAgzwUXlClbWe7WckFhMPNU0YGcWCOAB
         Vnj5adBKtEyGOhmGqBj/zumthGjAZrR6zw6YkkFTQllQ2FHgvPS9N4fMkuVUb0mwrAqs
         pDAakjtbp4dL1pOaKlr+bS3tToST8tzEEi83fx28LWtOPBWxN9l11kvZsffen4ZjAzhx
         CvIdTPucduM7+VdAKc41ne/+lvIyZf2FUeACxFDZ9VF2geoGbRQEKi121oHkFxeAVpuC
         /k+zMnC3O0jRFL620CwvaGpUjHYANqllLwWEoVLN8hhFolpd5uX+yCWdUNeDptUnhGgr
         qxGg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8IxmdYem57cZb5U19afnAA/DxG/j39OLAXXoV0ZLb9+gIh/gGU4+mqLGGVZSJPH6/hY7Aas8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZfpAfYse7kb5NZYLWClFrKfoTKI8Huaf/0qdVRi6q0XtZqEE
	Bii7CKSJTXvLMUUpWlkylc0dAI21rgbMbrDejPBoRc3BzPzGNQ/deu7NjOZ0RLzZrSLRz09tR+K
	+qRZ+/A==
X-Received: from pfbic9.prod.google.com ([2002:a05:6a00:8a09:b0:848:560e:ff7b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1bc3:b0:848:5540:2377
 with SMTP id d2e1a72fcca58-848554029f0mr4991279b3a.17.1783621998851; Thu, 09
 Jul 2026 11:33:18 -0700 (PDT)
Date: Thu,  9 Jul 2026 18:31:39 +0000
In-Reply-To: <20260709183315.965751-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709183315.965751-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709183315.965751-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] soreuseport: Clear sk_reuseport_cb before failure
 in sk_clone().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Octavian Purdila <tavip@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:willemb@google.com,m:horms@kernel.org,m:tavip@google.com,m:daniel@iogearbox.net,m:ast@kernel.org,m:martin.lau@linux.dev,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306344-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 901FC7344DC

When sk_clone() fails, sk_destruct() is called for the new socket.

If the parent socket has sk->sk_reuseport_cb, the child will call
reuseport_detach_sock() for the reuseport group.

Let's clear sk->sk_reuseport_cb before any failure path in sk_clone().

Note that this was not a problem before the cited commit because
reuseport_detach_sock() did nothing if the socket was not found in
the reuseport array.

Fixes: 5dc4c4b7d4e8 ("bpf: Introduce BPF_MAP_TYPE_REUSEPORT_SOCKARRAY")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260709032007.9E4D61F000E9@smtp.kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8a59bfaa8096..fc3ff0552d68 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2544,6 +2544,8 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 
 	cgroup_sk_clone(&newsk->sk_cgrp_data);
 
+	RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
+
 	rcu_read_lock();
 	filter = rcu_dereference(sk->sk_filter);
 	if (filter != NULL)
@@ -2566,8 +2568,6 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 		goto free;
 	}
 
-	RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
-
 	if (bpf_sk_storage_clone(sk, newsk))
 		goto free;
 
-- 
2.55.0.795.g602f6c329a-goog


