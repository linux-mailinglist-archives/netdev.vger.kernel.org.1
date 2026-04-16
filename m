Return-Path: <netdev+bounces-279155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FdLFG5C4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:11:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7454147CE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E6A63194D65
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F3B3E558C;
	Thu, 16 Apr 2026 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBqOaA29"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1483EE1C4
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369828; cv=none; b=eumGwYrrMR87nSOAAYoIkuwWDvOemO4YUw0uSftlYiwMGAJ6TnaLfaoDSO/2YYfJE8yEE/UwcGuafgXBsVajye7Y8PuKs0vv6TB1rxpAEwqKviBxC7t7sTrHpIjkOLYAx0jSHtRh+msnun8/tvSX9Qfx47VVJL1fYbKdFC/aSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369828; c=relaxed/simple;
	bh=1Osa78z8beoQsyw+7Hpybvgcc5b4Pfo5wG8YAodjJUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RxuGPN7Z0XI/w8BHbEd2zJipYHYdcAkUfXXTTMdAia3fwi6OMnp0kAE0JV86hsmlRiI7vYQNMVGyFltvMm/Vf9ux6Cgf6HAZIOXpuT6gtB1F/zZt8vVgGsC7mqmTBcKNfLIT+H4a6BT2QULU+6GyaGToxvEbCODu7gUJZlwHMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBqOaA29; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8aca14d1faaso232455196d6.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369820; x=1776974620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q2afE6Fn/ifzlLkUaAnaj6+fC8s92hkMorveeINNKw=;
        b=CBqOaA2968aFfzslspZoUXksLEuno6g6QUy8Y8hdG0qTK33+NwoHRZB6T+KFbih4J9
         7JYUgQYxKMg/9/qoeBIQx2wxOp2/mbdOjgFoSSJKMLl8km/VKCK0JiISy/r3Ma2FvqTR
         q+r+WmCwSRktlP6VucskiMdjRoXAo2LxdxGlZe6NLWU4x3KGyRYqmpjfuRI8Dd0JUnXO
         l+ILUTU6ErJmic7yWLw4SXcxrK7RziXCjJgHX8A2/yhA539GFvs1l63pmEDFdXA9cIYH
         SUalbVmXEqPiOEd+se0hm1YQZS8c2+fRTZj0Bk0PqauAwNqcFIn3VsGqUdiDal86TMg/
         dzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369820; x=1776974620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q2afE6Fn/ifzlLkUaAnaj6+fC8s92hkMorveeINNKw=;
        b=qILKkgOwTzriaOmYWa1MYdyWXUzkpJsz+Ay86BGW5FfHqJycuyvBntkSB8hRx8JGOW
         Ds0U+6ikE35vWJ7K5k7IWiVXt8Hw0B1hZwHQxsA8RYHBdoq0YIP6FzxbbLunqc9EJFQ2
         8jBpwh+aLedMl71OY5oGnMTlw8tYDf1XdpqllagDwrTvybg6yBZ3kTzYagy0ugDJnWjn
         SI0F4I7fjmH+Vg9sAFZpDp1Fs1eC71WeA3PlGtFH0U3BKp9q+/o9VdfHEctF9P5XmqVe
         oXEHwaqOdCFgyVD8n+PIA33+BO9ePvjD5yWoqENRZDMEUGyFpOBzUpTcI18HBv7EglAD
         2b0w==
X-Forwarded-Encrypted: i=1; AFNElJ8ui2gixTkrot2rxrve1eeBjowrrAffH4rxfcYM5CflLlXOCfW2JZA8zi+6OcyK0LSOTZm8PZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZSulLrDj729lAbacOzcyUiUiYf3hdyxGOYL+61MQ0iwnRGE3
	lLIszmyjXVXZoYH7JPqTIjN5dLKGMIOd3fzN1sNq+wOOcWZEoohDumFOvvH/Y9QhnqCJTv+HOUd
	Sy0tXb5WZYc9pow==
X-Received: from qvbob13.prod.google.com ([2002:a05:6214:2f8d:b0:89c:7af8:4227])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5904:b0:8a5:104b:e388 with SMTP id 6a1803df08f44-8b025e742famr12474916d6.28.1776369819978;
 Thu, 16 Apr 2026 13:03:39 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:17 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-13-edumazet@google.com>
Subject: [PATCH net 12/14] tcp: annotate data-races around tp->timeout_rehash
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279155-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF7454147CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 32efcc06d2a1 ("tcp: export count for rehash attempts")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c       | 3 ++-
 net/ipv4/tcp_timer.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 541bd0d2d8c4ed24934fd047dd46e532b30021be..192e95b71ce9868980a809184be83398d8740427 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4469,7 +4469,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, READ_ONCE(tp->dsack_dups));
 	nla_put_u32(stats, TCP_NLA_REORD_SEEN, READ_ONCE(tp->reord_seen));
 	nla_put_u32(stats, TCP_NLA_SRTT, READ_ONCE(tp->srtt_us) >> 3);
-	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH, tp->timeout_rehash);
+	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH,
+		    READ_ONCE(tp->timeout_rehash));
 	nla_put_u32(stats, TCP_NLA_BYTES_NOTSENT,
 		    max_t(int, 0, tp->write_seq - tp->snd_nxt));
 	nla_put_u64_64bit(stats, TCP_NLA_EDT, orig_skb->skb_mstamp_ns,
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index ea99988795e7e87412eef2768c4471e90c3e873e..8d791a954cd6ced52380226f205c66224b8f8bbd 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -297,7 +297,7 @@ static int tcp_write_timeout(struct sock *sk)
 	}
 
 	if (sk_rethink_txhash(sk)) {
-		tp->timeout_rehash++;
+		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
 	}
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


