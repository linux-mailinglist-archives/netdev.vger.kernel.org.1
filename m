Return-Path: <netdev+bounces-223749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE32B5A43A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0579B4E1B6E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FDA328588;
	Tue, 16 Sep 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwvabYDG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED4323F5A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059293; cv=none; b=TZREaZDRCBk0xoPuuPu2Px+ST7fXf2yOqvF5JhAyqsFJTmhNViP9b+bXCrkrhmrEuXnv/cNekScS6OF3gxnC0xmJQ0+WPmRCp+x9N9fY0uKwx5Y80MmiePU2JUmMktKqHSjw688o4xsT/7G1iXAToPjnFtMzV5lUoIMuZq7fIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059293; c=relaxed/simple;
	bh=qtdmhGjqcTVSu3zHbXR+EqtB0sbPwEbXawEta/KaF6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L47IcA7N8Ta7q/E2FsdkBbI1JklO3kAoZ4PTPj8UbG3dzGASKnwUSevqSOoMepKdSJdAE23XhVqDCUewFVku4nPfYTM9r0+7+VqD4wg/9NopbjmL7QLoPh0/5AkpJbVyFR1dy/JNVyWZFKq9gf2EcxJt7DJNxERi92wnXYiaGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwvabYDG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ec2211659so683071a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758059292; x=1758664092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPfUPsirCIZVWk6R9lACyAs7MP5dzrcIsDkkGgBYZfM=;
        b=SwvabYDGQHe1UbzsmQqw8WdMlG/NfA7YuhZlhg0YeaGCcI1M3KX+07U80eCpN2cus5
         xvo7v33+ua0lSVSTr3gdf+nZpCcN3FCUMeWZTmUksoV3hM2uN9iFkdPe9b6oAJdPLJTD
         AlYzDUvYIJsLU72M947H5wN9fsg2sw9055SNsn4CZQAfl1Q9cL4QNjzjc27ovSZF//XP
         EeMA2wU5t2YQfx3Rby2SaARadzYXkUB2OmYluzKAoGJEBVnfyNYG22kanSkuGiD/7in7
         4ImIytFNbqNvGt2ogHuxqe5nGfIi5bTG0NC9+dXRnzElDcG7QOWp8AyqZUJkIQ5Vt1Jh
         KG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059292; x=1758664092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPfUPsirCIZVWk6R9lACyAs7MP5dzrcIsDkkGgBYZfM=;
        b=AE4kaVoMvvM9I/I8Tx2qB4y7nrAGsJcdTjv/rJt/ebXYTzuZ9mWPUuT3p6B4+zyWT5
         qrjAEafTT/Ojzrl31qJbbn8I1xe6Qgpon/mBFZ6wb/GjFJPk0N+08bFOG6wjvDLwHPbp
         66htOJhR+0HFa9tmUNJOSxowuFshs/F8i6YwHXMrF92v5Mwd9rOCbRPoYMfKu3bbIjJH
         ug4N+gjqpIHZY3AFiFMjrrqy8VkBJON5wG3FRGdTxEvwZolQnyyxo6WvlqKoq5V9Xsm0
         SW+uJ9os98608zxQ0Epa4FXHJrs2TfmnwXj+GQC3TLjnI37alO4AdTfxOMIG4+5uR54u
         0AUA==
X-Forwarded-Encrypted: i=1; AJvYcCUCQ0hc8kkT9CE7PhjdK9UignP2H+aQE0O2pu/xNEj8U2PDlzh1db6qrSieAAscvEDuDFM1DPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCbjYivEzoUlYItQ2jmpo76o7VpV9yVLPLWoygJbbWb6CPROf
	jJLLOXkNMSfhq+CtwczyyZDfHPz3eBW3StFL+sFttVtEGzfSyiY8lGrcsF+HyTLHTEkXKg3mlB2
	a1p/o1g==
X-Google-Smtp-Source: AGHT+IEdzc/+bnEO3IrUCww+U3fAP62jIoUeBn1GxOV94N8VXqfVUeshxpWdgsTQX0K/hFEMB519dfR2JWo=
X-Received: from pjee6.prod.google.com ([2002:a17:90b:5786:b0:32d:e264:a78e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3810:b0:32e:749d:fcb4
 with SMTP id 98e67ed59e1d1-32e749dff67mr9960092a91.6.1758059291786; Tue, 16
 Sep 2025 14:48:11 -0700 (PDT)
Date: Tue, 16 Sep 2025 21:47:24 +0000
In-Reply-To: <20250916214758.650211-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916214758.650211-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 6/7] mptcp: Call dst_release() in mptcp_active_enable().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"

mptcp_active_enable() calls sk_dst_get(), which returns dst with its
refcount bumped, but forgot dst_release().

Let's add missing dst_release().

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: split from the next patch as dst_dev_rcu() patch hasn't been
    backported to 6.12+, where the cited commit exists.

Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
---
 net/mptcp/ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index fed40dae5583..c0e516872b4b 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -505,6 +505,8 @@ void mptcp_active_enable(struct sock *sk)
 
 		if (dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK))
 			atomic_set(&pernet->active_disable_times, 0);
+
+		dst_release(dst);
 	}
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


