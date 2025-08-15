Return-Path: <netdev+bounces-214184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE16B2870A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 415DA7BB98B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA82C0F80;
	Fri, 15 Aug 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyDu3t15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E42BF011
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289060; cv=none; b=hztyBDtA+VAeknuTv7v3HvH393Se+bUQV4FxCsNpvrLLBBB4dIIQOgmF0UXYRhTGmfdMeWdFQ/cobf9u82mMJpvl1Jw0ivVqWdddQSpZ/UcMD4PPKtzsWlic/MJSXxde2sK2gN1ZRgPJrlAiDxY++khToFY4eVXN/Rqm4yxmbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289060; c=relaxed/simple;
	bh=kNCka+5/ble2uhxoCvBkpMNTXujkGV/J5QaB+v82p+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GeVXYtyeelC6IGmhX+upN2INyoT6HNN6QHDIRVf9J/Kej2fngThU5iMX7AuTfpm9Sfo0IOVLP/PyvGrIAAXSq8rb8ZgTgz1abHxr98ExNgOZBjrxGX18Oux67wUtL76m6+3tKRn1eoBFciisjP4ztWwfz320FGXsdpfZrgcEhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyDu3t15; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e5fde8fso2032891b3a.0
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289059; x=1755893859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=PyDu3t15uFAQIIqy9WpCRmyfQ68tRnFy1oGP3DDif28aTJfUD524mRMeJfY0z2rkri
         pyqYt+1mHY68ieuW9u7rR+dPEV0qPaM+YVx0AxrWUUzK/VLXRcy+emaR+inehBB0cT0W
         m2oidPtrMm06hrLKVv5J/GtW2+4bXGYgX72kUDc0gqrbt77cgc2yfV8/9MbPgzgfOWul
         79qAyNHZGwFRIxreUt3GyOfNjAwy3aY2s1+qe4DqLFkM80bDNcMUIIIrfuVGWSvLTG4T
         ylen60cMA+2Dxn1ylQg428NNuQjiWocaUprX8pTCACkBOrnUZsUpISJ1QxEP3I53qBRY
         im+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289059; x=1755893859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=FnUOT09VTJ4U0NOWWdDhhAn/3Tp/QwkRvPWX97FGIacsKYNDHCqtNSeWq3R4H7JKyV
         zmP1c4uVD+btBIfE7SILyjb8sMUpTSwX14sv5bx4AyAllzZhZD5jVzhW+hOjVyHcMcL9
         OPXbg4G9Asg8gy48woHfwlCm39VVVOIUyq/HN4bMQdY7QF17Oo8MzDgY/09vdIRgcA13
         9DOff58H9Agkv1iPcwizgRM721v6h4Pr512Lg6VWoJIhHvOPiafLsG0xEVvs7xNjmELM
         8S1HzhDX6i5t6nbsjfAYXVNv25bEr6Y9q/uJ575LkXC+zooDPs8iMyYJbNgddF2taTJR
         0qAg==
X-Forwarded-Encrypted: i=1; AJvYcCW22o2ijSQ2vXMugEV2n0GwGW/RvVoyLe3WwIfzjp83+tnJWUqvgqR6MXi53E9tIxFdhkIQwfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/ntVbwBdpQ5PZQEuVL6eUflhMy0VS6P5337pQuOeaLpaKuRa
	eBW/+y4du55rSyHKQT93Z9Gft1CvBD3dXWxXz6c3kr01eWTJ9RsVF/Jbv9JjkSUfY16H/Mic28/
	bgWTJgA==
X-Google-Smtp-Source: AGHT+IGfFQhxVrC0MRMQ+CGQK5l5v2DySu8ZxAiDgHkcBvf9T0+txoiH03BQJJ5/iyzxBM/IkoVynChoTcY=
X-Received: from pgbdk2.prod.google.com ([2002:a05:6a02:c82:b0:b43:6adc:24d0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a1:b0:240:1327:ab3e
 with SMTP id adf61e73a8af0-240e611783amr454188637.9.1755289058544; Fri, 15
 Aug 2025 13:17:38 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:11 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-4-kuniyu@google.com>
Subject: [PATCH v5 net-next 03/10] tcp: Simplify error path in inet_csk_accept().
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
2.51.0.rc1.163.g2494970778-goog


