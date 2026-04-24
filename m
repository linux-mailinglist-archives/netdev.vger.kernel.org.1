Return-Path: <netdev+bounces-280911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H/EAavL6mk9DwAAu9opvQ
	(envelope-from <netdev+bounces-280911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:47:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59B458E8B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19B563006B71
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC3239E7F;
	Fri, 24 Apr 2026 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlQMv/js"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4C1D86FF
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776995212; cv=none; b=G7HqnmDsWyh10IT2CUBCiY67KnmFxHLaZAfSxKk/YS8jbtuaSbGhp2whySYt0cFQgpVneQli6xGDiFZPoYeYARo/g+f7s1IVluHzFKgAlIUQPFiPNu3TzaOMETb8DoiGqwKkMTeKrQKM9/kDhmTA+To4BmtXw4f0sPFUFvLo5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776995212; c=relaxed/simple;
	bh=+pgpx09OZsBxydJlvD8vXXLxlKoOhDlXCo3WMPVuvmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcwjYv8H30BtFp8ohYGKFaT1cKbyCDmBb5wSYalylgo4WLVN01KHwxfscf4FE5ykIkxjWzMKXmPa1fA0W44Xggrl8XpLakO6Vrnr8kgBY3oX2JJsHwScys2BbXh+8PwUONA+FO06GtKRVZ8+6W/8HTM0AZKn/4qreaK1AToEdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlQMv/js; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so3737779a34.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776995210; x=1777600010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8VXcjTmI6Dv2N/50VcqBrboi7Fp0CZ4DKMRegMcu50=;
        b=rlQMv/jsRg0qxu5r0Yimj3dyY6R7Hbcwb5v1oByWFjHO63XRuJfyqlvD5rRTnzgfDC
         21n0LLOKlYzaqckVkkp9OBAbDU2eS949jlDqa5g9XnOVcB/KTd0hFAhCHlxeKvjv+B9c
         3tOKo82XNn6fvJ3xpOPdb2byTHaQIDSvsNPFv5IoM+LqOBopFxB78TF778MHlgJ4ifSN
         LHK7GFo7830ubLcUGWDjvn5q/tqtxFfe1IYBeQZmGhG3iYVcpG6TmXicCNxUhzUt7Mgm
         sLKCSJfroUu+fRPegiB+TGXov1H34xvfl0ZJSiekGX+Sylrrt2HFy1mSH2uok37RyK7l
         /Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776995210; x=1777600010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+8VXcjTmI6Dv2N/50VcqBrboi7Fp0CZ4DKMRegMcu50=;
        b=oqjORx6QjmDsQm2tA2jdS3XZSFAX7Plz/luHt+TQsGeyLQnVBzuokYSL9bIUZvCMaH
         yATC2vNu2wMTTmH/oVFE+WooSnAROGHIgYQARz8tIJRf0VWiTbeV5UQ3sluiBelBwGG1
         w6iT+IrONqjrE2yQnfnee6CwSUhYmPbw+WVGfBEPaHw7eRQF+FWsu+5u5Pt4qwhh/iXh
         PAC0W3T/c2J5ZIbbxJxq3df6eEHxyYxr9qmwdWD3Mo5tGXCl0hUVRSKLJWhtp0NX+aNo
         HinYdXZwrIiFBDuLFE4nb5JFs+T5w8v3g6o4OHjWX5KuLiHC4SWAJt3S4PmDpQQVOqyi
         FA5Q==
X-Gm-Message-State: AOJu0YzA1TgdExNGmahEoy+qFmLj55KNO4LWVBYHbUb4WuV45kItJ5Qs
	WX5e4EUXWmLz3zWWmr+jleB3ZnAwRPhNk6Jy2ajdo0sm+yI14dncMrB1
X-Gm-Gg: AeBDievy4/m9JzqCBd+z4RAYwpPRdnpxwA2s5w6l5A+rzS9CE1myuaKiRVb3UtYTAHS
	rPfnGZnQ6i6BzgC0b+w8S1qpzAyQHxkZUtN8t9V4PJBNb682VV7pKQYgqucheExBY7Z2RYZHh9c
	nO+fnScgD1RD66rDsOHXoww/diKUhdyaXsUbT78za8Pe0m9qulaawyWiojOcJWpx+dElqoK8hqu
	4RCzAPDDcwAQWVFUCaP04fv1FJGk8igeqQwFgN/r4QcWTKRf6pXykx04D2gawe6gMlPMzrEj9kM
	VNq6QfKSvxdW6FhhVBB716zi/s+z9lmV2euuxvjyf8nYYzKN3rLpjJOD7FTA2iSJdeLCcbpL6ee
	atKYgtkOwYCtNQA3bUyLnmHq2Q22EsS2xpf4AYzyKjjP9G/gmjmJF4qOPdxkLv080NOqnhWsKgH
	x/OKjFJspnt3jo+yDz2gZJceeNQtjtMlgMtPZPqb0epMNZYHf+lcJp
X-Received: by 2002:a05:6820:982:b0:694:8f5d:3ca with SMTP id 006d021491bc7-6948f5d083dmr9649837eaf.23.1776995209754;
        Thu, 23 Apr 2026 18:46:49 -0700 (PDT)
Received: from host.td.teradata.com ([2600:1700:7c:96e0:48c1:2987:595c:6123])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b930afa63sm18229275fac.5.2026.04.23.18.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 18:46:49 -0700 (PDT)
From: Altan Hacigumus <ahacigu.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Enke Chen <enchen@paloaltonetworks.com>
Subject: [PATCH net v2] tcp: make probe0 timer handle expired user timeout
Date: Thu, 23 Apr 2026 18:46:38 -0700
Message-ID: <20260424014639.54110-1-ahacigu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414013634.43997-1-ahacigu.linux@gmail.com>
References: <20260414013634.43997-1-ahacigu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B59B458E8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280911-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahacigulinux@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
using subtraction with an unsigned lvalue.  If elapsed probing time
exceeds the configured TCP_USER_TIMEOUT, the underflow yields a large
value.

This ends up re-arming the probe timer for a full backoff interval
instead of expiring immediately, delaying connection teardown beyond
the configured timeout.

Fix this by preventing underflow so user-set timeout expiration is
handled correctly without extending the probe timer.

Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero window probes")
Link: https://lore.kernel.org/r/20260414013634.43997-1-ahacigu.linux@gmail.com
Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>
---
v2:
- Use the existing TCP_TIMEOUT_MIN clamping along with signed @remaining
---
 net/ipv4/tcp_timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 8d791a954cd6..322db13333c7 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -50,7 +50,8 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 remaining, user_timeout;
+	u32 user_timeout;
+	s32 remaining;
 	s32 elapsed;
 
 	user_timeout = READ_ONCE(icsk->icsk_user_timeout);
@@ -61,7 +62,7 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 	if (unlikely(elapsed < 0))
 		elapsed = 0;
 	remaining = msecs_to_jiffies(user_timeout) - elapsed;
-	remaining = max_t(u32, remaining, TCP_TIMEOUT_MIN);
+	remaining = max_t(int, remaining, TCP_TIMEOUT_MIN);
 
 	return min_t(u32, remaining, when);
 }
-- 
2.43.0


