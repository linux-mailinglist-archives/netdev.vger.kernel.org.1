Return-Path: <netdev+bounces-215494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DDAB2EE01
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C2B5E37D6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B825BEFD;
	Thu, 21 Aug 2025 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xWKCAy89"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D5202F65
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756964; cv=none; b=DsQLD39WPwlFIHhyxHYllOI8BGin/hP3yh9Bu2cagrd/IbAOIrLLmL/21zfCcnErku5T9zyChdiv8BD2j2/g0B3rB2SIfVq2RZ6PRFtRfQsLShGwWd+fKI+gYNV1PPW8r97ATe65IMcgawD5dNoBei45FE2AYTU/u3HTtYlNyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756964; c=relaxed/simple;
	bh=jNt+BRSLiYaRYmlf5PTTkDSeypF9mO8p3JY29k73nKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yz4o7z2FjTaaIJPu6GyunH/IUklcwyfOCmgt/yV3FdHMTDn/LxAEU7AGBzYeAilT91km24cjeATkOZ+kdELtXQNyDBgD2OrCrNs756geKVbbAmJJmZLhF80qAcVYG4VwrWITFaO0XI877ruuetmxTqQrPcam4qhI5juOyzg5LcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xWKCAy89; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457ef983fso14596855ad.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755756960; x=1756361760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kq12/VJgz0F1P8yx5kAentqBRItKKz7EMP7VUA5hH0=;
        b=xWKCAy89VeV5aSIkAry0N6sJbWr1EuVvHLTiKkBz20m5ABQ9PYaRX2qjovKqrtMk/F
         ePTeKrTwnHSN2qaZDogpx+JiB3gLWazP2jye2FgYpv6TiWnP8DYvZlMjM/0DPFkxvIag
         Q0z6cIkMXbmO8IOtMkU69eH8/OCpbneE/fcUsoMkdAfi5oLb1MxuE9MKYMrwEDeBLOM2
         eBOUDKXf1XTs6PsyX9EEHaXar/TEQOtmEvpgnDTGCTF6WZtly9oU8Muc/uNVd3uCU0U1
         K3z7Uk3U5aJH/OYJ7s1wGP9gP+cl8KMnvIb7ULC/c0Ro0fq8NlObzSVa5LZyByA5cZEw
         MbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755756960; x=1756361760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kq12/VJgz0F1P8yx5kAentqBRItKKz7EMP7VUA5hH0=;
        b=mUyXS8KVdhtt3j/f2ZzbtTRQdrXciN7Sz3e54eDtP7df2ZfaWPB1Eqarbnrp9OmZ/I
         9LYDfoCVy5J1OeZbmpXH608pvoDBIh0clGblouYVz3WpR5Oo4UnOqfM5uty+dzmWVV90
         N4jFR9MwvAXEPDjbW8Vc8n/XeKHDPsQIARZl/yutTZLGbxJxi69OhuLM4pEwOYEyqf+R
         cBCLE30ENQWc8smcZYNBxIIducikmUl+3IM01ZZQwbJ9silC7407eVzM6jTZvzFTQHHH
         +THq3/zkXLn9bxfYTUTGi4byz0A3zgZMBMnWy6JSbBIHPMuFBooOpGHfWUnW7Wyi5Pgd
         YFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiqLiOrDOTRIGGwcs+OCS4/E8LD+XshQIYDMveezVvfD7rfI3qyrl8PK71ENLebVLB2OYmgfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOK5pQh0XlpG8wUmS3M5RVvfXLActJ32DFhTU7aldfyUoJbnN
	SIOxKFK94Ylsx2Pjy6K45uZQ4SILqjpGe8/AWnFg7p8pvu6CUGEuXDqzOp4WO3Bhn6VZLsIM98f
	2saK3/g==
X-Google-Smtp-Source: AGHT+IEvHvyXOkXaap06fo0y429q5U9asUbr6I2uFfkRsNshJxJyHeTgfQ3wEbaOd7+HOP+PMwTy/+U/6As=
X-Received: from plxe3.prod.google.com ([2002:a17:902:ef43:b0:23f:d929:167b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:246:b0:235:eefe:68f4
 with SMTP id d9443c01a7336-245fedb418emr17842075ad.29.1755756960407; Wed, 20
 Aug 2025 23:16:00 -0700 (PDT)
Date: Thu, 21 Aug 2025 06:15:12 +0000
In-Reply-To: <20250821061540.2876953-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821061540.2876953-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/7] tcp: Remove sk_protocol test for tcp_twsk_unique().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

From: Kuniyuki Iwashima <kuniyu@amazon.com>

Commit 383eed2de529 ("tcp: get rid of twsk_unique()") added
sk->sk_protocol test in  __inet_check_established() and
__inet6_check_established() to remove twsk_unique() and call
tcp_twsk_unique() directly.

DCCP has gone, and the condition is always true.

Let's remove the sk_protocol test.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
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
2.51.0.rc1.193.gad69d77794-goog


