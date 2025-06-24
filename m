Return-Path: <netdev+bounces-200832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E6BAE70B0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF901BC51EC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF932EF9D5;
	Tue, 24 Jun 2025 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/yOMbtp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C902EBBBB
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796808; cv=none; b=cfgxfJz2OG31t+UOuIB3Jaa4q9zMp78breEp/HvPSYNi5DdE0UvA2syqo00evpMKaVMOnwlEBJxdIXih/laTZZlU68a5H0h3KHo3EiWDvqcGIVfcr3JmwmP7oT8loQLdKRUBHdnvIZNU6vh6BVxakKWxb5QfEsWS50sGkLuSpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796808; c=relaxed/simple;
	bh=j3MwJPnnXdEgSwMmnaz//285VeQmMRx5hMJRFY4eUmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSbs5DARQQuzlqCLfBd/wx2J1kYOPU3LF2Y7zDVVAqRQxgc5nUCbU/Q6/bf2RiJPpfYOv00TIixiFFvVkNEVUNPAbN1COqiLrfADO10+KpLCDzaTmehpjcIAV2Oqbo4Z3ZQAfmGL8zOnlZVbD9s58mzntEpMhdCPtHgjil8FymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/yOMbtp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c7a52e97so545015b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796806; x=1751401606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuzbjsS7sm302d5GNKWLUffu44bgJ1U1ctSy1vAFhnU=;
        b=X/yOMbtpIwC7yv341wQA0IutlSGUiKsu7qDLguwbAcT9AZiRb7aPpyqmeqsGWbV224
         nK+sJqLm+kQtGN7O/BWFZqaNo3XCLOjVR3IdAlEmO7dSAzreyY8YmoW/qUCsSlHdDwTO
         vyGzfqyUlSpopedCDVSTUJT0X5Q1WOu27CjPRFK8xy3+fUMcYsQ3DOjd5TTgOAkuUSUc
         /Tg7qkLVXlHlGnzenumC2FED01XshIDwOMqdlEz/z8HB41iW839UM1IsNz7Ak86W+vbk
         SL/tTRLecJaRyAyizdR4Iyn5SxG+ONdFRNYDmZMZOkm72R7+hE7kCzF6Mtsz79pixVDn
         v8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796806; x=1751401606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuzbjsS7sm302d5GNKWLUffu44bgJ1U1ctSy1vAFhnU=;
        b=mZ4S2A6/xDbXs36ofI4l38WqSmUr4wNysAmO1mmcVg9Vdi3do+Sgkkh7Ul29/w4j3W
         efWrmIcu/KqSf1ISm1OK3iFXYX3sUG4Uk/7vYWElni1rKkBOmn0k2AdqgT6zFx5Arn+B
         9BfNj/Ooi5rj2LTAWnKPXd1cgHVsed+pwqmRe4wrDyQUHgK+sSfDd9G4C2m4C4Jtssvx
         i3/V50683yV/B7lpjvdnajubDLRiYtgDSTpx//cY56ZG4h8fCHPm7l8Yo+QhgXvzaPKW
         LeLzRycwzw9iJlD7C3GlbN7mNxrxFjhuQXUnCG1t9wHOfrzAoAHyLIseoN0X2A37tU9y
         gb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1gOaNlS1b3LGLe0gtVEgKmv77FmKhVahi30iO1BMExryKwAlHL93FK3x/m9yfZIEGyXe3HV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfMtP3TkkUbnc4T5Ru/Of07kxp5zpUzoEocel6PFkPwpR9/bl
	Z8KRJt5FLu2cpqek7oXsG/p+E/EhcPEbcSqGK+S5V04wONZKKO/+Lyc=
X-Gm-Gg: ASbGncvgvGiTnpPlnaawFJMiBQ/3xW6P3LxqxUs9YuvK770+RaFTSWexlf+4nE08bdV
	u+sFjrGm00gODon6blAV+q2mQ8rw7MSzMOXek4zCl5Ca2CAN+cY7ae7STKo7Zgrz8eqAY99W0SB
	KJ4/2RmDYFX8dZtzRr61pMoDhxYoqGDwam6Ub71s9mCC6meG38YGPe1i/6mZ/BOJq6EnUI9KMQ/
	AFDr2q/YpGIysUzChhHetb2hDfTSgsn6oxjlezTETNn2crzyy0s3Fy6wxFBvTGKPYjWZQ6Jn04U
	2Z3uNMqD9M8US/MMqZIZArjlVZtuQ06Eu6wKQ9U=
X-Google-Smtp-Source: AGHT+IGt5rZjMjnAr9xv1QHxDsxm4Nu2uFV9GTtS+aBXSRVGk7Drw/o32r4z2tzXmxO3L0GINCpfPg==
X-Received: by 2002:a05:6a00:3916:b0:749:540:ca72 with SMTP id d2e1a72fcca58-74ad45da4b8mr724659b3a.24.1750796806117;
        Tue, 24 Jun 2025 13:26:46 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:45 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 15/15] ipv6: Remove setsockopt_needs_rtnl().
Date: Tue, 24 Jun 2025 13:24:21 -0700
Message-ID: <20250624202616.526600-16-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

We no longer need to hold RTNL for IPv6 socket options.

Let's remove setsockopt_needs_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ipv6_sockglue.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 702dc33e50ad..e66ec623972e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -117,11 +117,6 @@ struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 	return opt;
 }
 
-static bool setsockopt_needs_rtnl(int optname)
-{
-	return false;
-}
-
 static int copy_group_source_from_sockptr(struct group_source_req *greqs,
 		sockptr_t optval, int optlen)
 {
@@ -380,9 +375,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
-	int val, valbool;
 	int retv = -ENOPROTOOPT;
-	bool needs_rtnl = setsockopt_needs_rtnl(optname);
+	int val, valbool;
 
 	if (sockptr_is_null(optval))
 		val = 0;
@@ -547,8 +541,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		return 0;
 	}
 	}
-	if (needs_rtnl)
-		rtnl_lock();
+
 	sockopt_lock_sock(sk);
 
 	/* Another thread has converted the socket into IPv4 with
@@ -954,8 +947,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 unlock:
 	sockopt_release_sock(sk);
-	if (needs_rtnl)
-		rtnl_unlock();
 
 	return retv;
 
-- 
2.49.0


