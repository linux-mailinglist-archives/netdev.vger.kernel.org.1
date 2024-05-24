Return-Path: <netdev+bounces-98029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464158CEA68
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 21:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D74283EE9
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 19:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6320784DEA;
	Fri, 24 May 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuQB0fyq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FB82C6B
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579400; cv=none; b=G0s3I2M5MFJaQfvfkyA3HxECJTuk/fYXRzBB1AVGb0I2XpdmpDZD+D+hh9QRTrss0AS6rtgOsXNqjqV+S3N3vrKLpMWlofStz0lEJbGOjqoKlUUb8X6a/ORyYpO/vP2IlBT0Hd32YXvw2rckrYHI/n6BVlBykvNpZdfq1KweLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579400; c=relaxed/simple;
	bh=lZqCcbBBSv/qSgtNoIFYGw2Ni6oSIM/K3urRq5cWbbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DEJJM13gr1VDYGD87hSn+sxkQbZfXmp+udYHsylf/6D39LQ7I+ee9usf3qMN4d7Y6lHk0cVqAMF1mHyh8VUu/eVfZICsfawHK3Iio4+yGde9kdImEoJdv5aeM3GE3hWurEZVrNduuNTjEXR/n+1T8Li+A9jrAdnZoCu7Sj90ltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JuQB0fyq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a083d9346so9397907b3.2
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716579398; x=1717184198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gsG7/RSHQ8OJJlmUs4RpmmIk8Jl50XRVFFzBF5rUTZ0=;
        b=JuQB0fyq8IM1IG++r3bgAwaYH535GoAj7GM6NKSLenztabYwcyjovpzQs6r5SejVTm
         EtoINNV7o3BG1JtFa+BrSlrdIzh3+j8hYI85vFudPs5WQusBISBcbtPRZJLC4YD3gR7D
         dJm+wAT8KaQcCNWq7Syv2+4iAfKeyjzytmsC53YtlPyQ5Q/qZALmFXlZcBGRzzTqb1Re
         deQfrjlhPTGaDj27ootSwQ0o0RI2PkY0NwLWYMj2nmSpJwniPPkgm9NuStYZ9ZL4XjLq
         1VgVMX7BEVK7710CFpsXVkLjE3cg82s+iiHtrMh5BDZ+3ndno7MAbF6+OerF7VXTr9J1
         TmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579398; x=1717184198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsG7/RSHQ8OJJlmUs4RpmmIk8Jl50XRVFFzBF5rUTZ0=;
        b=H3nxj2vvRj3JGauRatRVsbfkjNGCC2LtIZTbGTd8vkjO2KGCbL0tziqJdlMAT2yYHO
         py0JthjcfsPg018c5LY3vNULUJ4J/f/wl5BeX6eqfIEqxkdCfHV5cr+hqcz03o7eWDSL
         tQIcgDAqPucfxdoXLhNGI3skWJlCxdoDjc/VhuhSyMGLR0DEYuR9+36J6IlFFejQvaKO
         PL7KNlQr3W71SfwKF4gLyFMOV9TlGJvwymQQMvUqXqPBo9gsHQkywqKAUesyZxczDPFF
         bbRHamH0/oW8URY1QlOlHsDNrVgUuWsZTkOrG8u/2rOXW6tO0CjYK8+zThcwuxW14o+X
         ybiA==
X-Forwarded-Encrypted: i=1; AJvYcCWfdO2bAVourplF8j7HZEPFtq0yWoTSxcOzo2ZuOK/0+VFqCK8uGI3wSkCz+7hB62fSMuC3gZfoOTxrCQVo4+GXqHHIUlXx
X-Gm-Message-State: AOJu0YyN5zj1Frglh1P8ytUUCCgmxAFgMtm6OoBiLqO48+Kv4ZjmYh9h
	C9DBvLVvTo0qNTPDAwtV3X0Gd0ptI4l0D9RhqvaOY0KgQQ879aLZUE98tbiq3ufHkYaqg+8N6fq
	1CU3ZLl4nVg==
X-Google-Smtp-Source: AGHT+IGcwDx2vMkSrJqcDooXIkomI87Eo1saJUFpDFWk8OUZhyOzEZKOOMGmW5N+rlwpBbEIOgIaXhp1kAs7SQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1207:b0:dee:7884:acc7 with SMTP
 id 3f1490d57ef6-df77214fd6dmr262134276.1.1716579397957; Fri, 24 May 2024
 12:36:37 -0700 (PDT)
Date: Fri, 24 May 2024 19:36:29 +0000
In-Reply-To: <20240524193630.2007563-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524193630.2007563-4-edumazet@google.com>
Subject: [PATCH net 3/4] tcp: fix races in tcp_abort()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_abort() has the same issue than the one fixed in the prior patch
in tcp_write_err().

In order to get consistent results from tcp_poll(), we must call
sk_error_report() after tcp_done().

We can use tcp_done_with_error() to centralize this logic.

Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2a8f8d8676ff1d30ea9f8cd47ccf9236940eb299..741cd35d0d7d66bfafe5d85b4c4d97d042613a61 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4577,13 +4577,10 @@ int tcp_abort(struct sock *sk, int err)
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		WRITE_ONCE(sk->sk_err, err);
-		/* This barrier is coupled with smp_rmb() in tcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
 			tcp_send_active_reset(sk, GFP_ATOMIC,
 					      SK_RST_REASON_NOT_SPECIFIED);
-		tcp_done(sk);
+		tcp_done_with_error(sk);
 	}
 
 	bh_unlock_sock(sk);
-- 
2.45.1.288.g0e0cd299f1-goog


