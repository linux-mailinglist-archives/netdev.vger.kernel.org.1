Return-Path: <netdev+bounces-284689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMKKMNi8+mknSQMAu9opvQ
	(envelope-from <netdev+bounces-284689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:00:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2233C4D60B2
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 06:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EDCD3026171
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 03:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D22ED848;
	Wed,  6 May 2026 03:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNFZBA1U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19002E8897
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039998; cv=none; b=VUtJB+e7pxuNpWGqoNpmvbSmTi92CGR7KA0nHMCcFz4WaHwzejk0FaO/mFuNndBnkUUwf1xuH6YCBkdaFWOCQYk86gRASKuDc1bTVfEDZ0Aye1gN/lb2vque5IUrXTkmDST91JGCX0W/OSMsRVDty9305dFqtr8lfcJi69E3Zz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039998; c=relaxed/simple;
	bh=vvn/cysZ42z/bLLNTp8mWAeAO3928XthMWU738PQE0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qnqSW+y6xCkRCY46sdwhzqaRGMdFRfmPwzfP3q3pc5TdmP/TROpbgFLCQpz1qkK4r1bSzvhGsJSc6tIhL5SWnwUrnEw6Jr0H6EILBonkbbV2Szj61wd8pD8hKr39ODY81VGLiGIYqyRntRaDvcO1mtaU+98DUw4tdNC49U4jWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNFZBA1U; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adef9d486bso51133205ad.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778039997; x=1778644797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1FffDccpy2+7xC15cUPSR2O4jKkq4062a8OUPAWl3cM=;
        b=UNFZBA1UvPsMMJddNM66ptfHM7z0lCm+5RFPAob5/ajvbatn3N5i007xSeST5w96YC
         WMOkJquQ33uDlgN1Moee/DjDsdYDFpJfD+H8Re6nhN8dAmXDuPvzZ3lFth2BzgTWn/oC
         1wQFvNQtpQDqcvmL3ftYXRg7y0tK9sPhckoSCbtV8Kbe6cAPVURJz0l6NSd2MLUrCHCY
         vT89r5J+9MN9LMmPO0frAV/8g3EMb1NKY8nzO/sMj+ORjP0aeR3M45WAH4suFavrkg9o
         VcSgy/ZNJr0bLp+ffNmcnZQmJxSUJe/yHx8DX6XJfspyuIinlz76Prg1TuYp9Esw2eJh
         Uw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778039997; x=1778644797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FffDccpy2+7xC15cUPSR2O4jKkq4062a8OUPAWl3cM=;
        b=rn7UK7Q3eHer+zBk8P1d/Yx2Ewk5IoE4TKylyHLkVitaeTxB2KsLw1F/e87NHO9JWO
         qcT0tqo2RR2fu7H2z8tb8zIAkOJIADj0ZkHbldtJAwEbccNWq/EfWFQHpqzP93lqHz+m
         GdFRnoQQx/4AguoxZDsqI89u5KnJS2el4+KFeGa6lBr+FzX9+hdFSrEjpyobbscIYFWC
         /P6sdxPc5CWLlHpT7wqvXOu1fMKGrzWkjSm69F1uow2Qv+3AJFwtJPnnrUhHvGDk5rbJ
         SeQrbHHxc3Ivqp2+BZVP83/Pz+GslSBVTcX+sJOUB0g6BZyZSlHeYervdm2GKJExRPOU
         UOtw==
X-Forwarded-Encrypted: i=1; AFNElJ83opw3ySId+THu2KKB9V+vg/Hd+9R2Zx1FuDnCiT63Mv53ZFu7BHMiMGNyCbWu5TeUfGv2JS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/z9RD4kkyvvjw/EXBL3QxmuCseAqzM6q95Ri4N8Pzudp82Hh
	uUtBaFW37wA5xTv3pVe1C5nY8nPe00GhcQba61XMY2l9jvOzR/5C5YPJVNf/7fPlCu/UolwIu/k
	kcEsgoA==
X-Received: from plsu11.prod.google.com ([2002:a17:902:bf4b:b0:2ae:c329:bddd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e747:b0:2b9:ef36:434b
 with SMTP id d9443c01a7336-2ba78c40a85mr17860835ad.12.1778039996765; Tue, 05
 May 2026 20:59:56 -0700 (PDT)
Date: Wed,  6 May 2026 03:59:18 +0000
In-Reply-To: <20260506035954.1563147-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506035954.1563147-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506035954.1563147-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] tcp: Fix potential UAF in reqsk_timer_handler().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2233C4D60B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284689-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When TCP socket migration fails at inet_ehash_insert() in
reqsk_timer_handler(), we jump to the no_ownership: label
and free the new reqsk immediately with __reqsk_free().

Thus, we must stop the new reqsk's timer before jumping to the
label, but the timer might be missed since the cited commit,
resulting in UAF.

As we are in the original reqsk's timer context, we can safely
call timer_delete_sync() for the new reqsk.

Let's pass false to __inet_csk_reqsk_queue_drop() to stop
the new reqsk's timer.

Fixes: 83fccfc3940c ("inet: fix potential deadlock in reqsk_queue_unlink()")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
In case Sashiko asks

  "What happens if TFO reqsk is migrated in reqsk_timer_handler() ?"

, the answer is

  "TFO does not use reqsk_timer_handler()."
---
 net/ipv4/inet_connection_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 928654c34156..971f9db2c586 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1108,7 +1108,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
 			/* delete timer */
-			__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
+			__inet_csk_reqsk_queue_drop(sk_listener, nreq, false);
 			goto no_ownership;
 		}
 
-- 
2.54.0.545.g6539524ca2-goog


