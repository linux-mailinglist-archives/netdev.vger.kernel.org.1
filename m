Return-Path: <netdev+bounces-216127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC85B32299
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E421CC80A7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4D2D0C8D;
	Fri, 22 Aug 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qt5h0FoI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F62C326F
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889705; cv=none; b=V2jJosYTCrd6QJPq987nRMbEAG3oeDSS6FBvV3U6tI8JVrrIIMTum/L5SiHD3Q7U2fcu86wSRQ+Ze5tnrpv56fnZtfMHoUAF46QVdqU8+H84x7YTK/FemTc7jOspydT40ZqEdS5CJMhe181Q0TD7m5TWS5vPnj/wbhe+Y3nZOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889705; c=relaxed/simple;
	bh=/YaSshcfHnc4tieyoMsllQYKsEF2P8mfZxOMriPqTs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cHsaMR/79DAu+3TidwYinVHjU3yoPJ5kNb1u4CKyMW12+mss9dH5Qs/tGr70ZKu6PioRGK1cq+73S5Oe7NN0EeZUjctSsloN0O0hVmCm3wJS4uN1hZ6rvr4xdtKc41tBz5xFNRL99p5vw3PvIPlAgcWRQPY6jboZNK+jZ0fWUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qt5h0FoI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e7ef21d52so4991767b3a.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755889703; x=1756494503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=28qY+TUkLxt0710doq8j0TPvP5aRplru4xv2PPZAygc=;
        b=qt5h0FoIZueAaL87q66yYKg2anL96MFk2EwGEOpwsuEScoK6ZVMxeoww+ybzOoEE5I
         zHAtRvfRIW8Fes0YkAnNa1s6GErV4X3J0H9BIbypSnKDGow2zs6e2CGHNwdtk7hqak23
         YUJ9Ao/LONJoRk/M1vU2ennkifBhDScUnvtsU7IkN8u40BVhGAnnnSESKIBwsmMbM9Tf
         PbAZm+QqA03I8YrdSMG60Jcj8WVoDSmRNrhK4Q3bKSGXrq8g8uTIyAFWcr/wsf2RIZYa
         TEB/dvlKUkTdDrwFqN2YrProV9FQf2ndjpACDucPQoLnrGViOIzqPEtuReI+57g+OkFK
         HKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889703; x=1756494503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28qY+TUkLxt0710doq8j0TPvP5aRplru4xv2PPZAygc=;
        b=BMEM+K6egXaEXvGbOlpDne+yZ/kAxm0H9j89eJRVa4qv5PQOs9o9P5HvRcfnSxUWw8
         SzPL2Lt1PuSIjFIV40+sFEgVFrEoq0NY7RQkyCHBEGrsYiFf+hvDdbNAAhYYB3LtyfA0
         GXzH0vaXy6Bg6VJteKKaDHw5/vZ7eL5DN1BVv1POvqorjzql04+fVszmxnFQdTK/XR7o
         DMP1HcpBRgHx8rvcgLGERMrwBxpPYYf3cwFJfqOj18Av0MzHZEItoSzJ5qphnPyEtWJu
         sG1ookUiMyT7sgUjmTwrT604GtfDfTqet49tlO1w41XHsAgja/12xtcmFFjuWR9n+6zw
         ESDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbQv7L8VpItUvXigz+gTM2IWI6etHOoHQxbk6w3XCtI74Vh/FFm0yI/SWadz+cKIJstLfGqq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+XrAJCCWDhXrXpJnUz7qiGr8IDwqJLAcm64VgWe5cDIBSjKw
	DPmGfFkGOMcnaUnLmk5VtkCTa//l3zArbDy47YnbyIEu6PfxWmLA/Hqb0+Le1NS+zlclYCKyVrs
	LPI5SVA==
X-Google-Smtp-Source: AGHT+IEm4G1Er6rmALejyIeXSeeYBasedc6naW0f7v23hk5E3hsQAHIy3k0QNA6grJWppBPNicQNY8dVyQA=
X-Received: from pfbc9.prod.google.com ([2002:a05:6a00:ad09:b0:76e:99fc:fb09])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a87:b0:730:95a6:3761
 with SMTP id d2e1a72fcca58-7702f9cffc6mr5263833b3a.3.1755889703057; Fri, 22
 Aug 2025 12:08:23 -0700 (PDT)
Date: Fri, 22 Aug 2025 19:06:56 +0000
In-Reply-To: <20250822190803.540788-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822190803.540788-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822190803.540788-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/6] tcp: Remove sk_protocol test for tcp_twsk_unique().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 383eed2de529 ("tcp: get rid of twsk_unique()") added
sk->sk_protocol test in  __inet_check_established() and
__inet6_check_established() to remove twsk_unique() and call
tcp_twsk_unique() directly.

DCCP has gone, and the condition is always true.

Let's remove the sk_protocol test.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_hashtables.c  | 3 +--
 net/ipv6/inet6_hashtables.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ceeeec9b7290..fef71dd72521 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -579,8 +579,7 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 		if (likely(inet_match(net, sk2, acookie, ports, dif, sdif))) {
 			if (sk2->sk_state == TCP_TIME_WAIT) {
 				tw = inet_twsk(sk2);
-				if (sk->sk_protocol == IPPROTO_TCP &&
-				    tcp_twsk_unique(sk, sk2, twp))
+				if (tcp_twsk_unique(sk, sk2, twp))
 					break;
 			}
 			goto not_unique;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 76ee521189eb..dbb10774764a 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -305,8 +305,7 @@ static int __inet6_check_established(struct inet_timewait_death_row *death_row,
 				       dif, sdif))) {
 			if (sk2->sk_state == TCP_TIME_WAIT) {
 				tw = inet_twsk(sk2);
-				if (sk->sk_protocol == IPPROTO_TCP &&
-				    tcp_twsk_unique(sk, sk2, twp))
+				if (tcp_twsk_unique(sk, sk2, twp))
 					break;
 			}
 			goto not_unique;
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


