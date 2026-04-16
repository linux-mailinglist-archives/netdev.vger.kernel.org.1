Return-Path: <netdev+bounces-279153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ3yDsJA4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 264DA4146F3
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 836B13043E75
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534123ED5D3;
	Thu, 16 Apr 2026 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7JFZdyG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405A3ED5C7
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369825; cv=none; b=k034Yt+U2LzFQ5oD42r65pwEqqxgv4r4bbeAkIhVEV6guG9ZH7zncqi7fr/ZbT5VSVRERlpkpf65+uHPKkU5z17GZye1MG7dAtPMRCR0q0nVSCDzsnH+dFiT7cq95wH2vj4OdGmW/K+MHx4HYF/qqGI/CzfhK1BhSNHQ4fFvntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369825; c=relaxed/simple;
	bh=yGrD4O+YB3WHnVg60/WItdB3gdEuDAatCGuKxGV+9uc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kz/s/QNOUWgMWrwa2K4cLrTbngHRB99eur+ZeIZ4+o0CfJavDnu+w7dFy7yORdxw3+ni/PHY8ZcE+CQ0BAaG6CnD7oGKNtN0MWfwsdn6WsDKSQCRIo+QKGtsLJPCTvgWSDrVfORy5tjMIsiPM03eTUPSGxG1TSWUbTQqkbnmzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7JFZdyG; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50df4c130dbso30363371cf.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369817; x=1776974617; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAq42KwmcnZjLCkg8Nsuk8iYWGDWLKyHrM9B5KUaBVk=;
        b=I7JFZdyGRLTNuq2BKH1OznAdHpY98CY7mInxHBaXZTMBp1GlDA3x7WXKIsne9I4f2c
         cvead8YgzDIloqYPju7JNy0qvl9Idhz1Zt0O7HUtOoenP59B+8M9W1+jRGh45qKA5XLn
         dcErNW+fbdNNlOEI49Q0ZV/y36+NZgv0qUYwZ7DMvmDr6SZN2m02yBJg9u5t9SNa2xbd
         y6kRxuXWe4yGq8hbytCRDb57OsIyFoKmy9zm9zN93L1q0lq9/TepMwie5Tgpx5Lmk8gs
         cmGPGZugMV1t3+gh5T6L3cIuecpysOjg3su9absyo7XUE6CfcB5RPPwSIe/FWVJKW1iq
         mwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369817; x=1776974617;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAq42KwmcnZjLCkg8Nsuk8iYWGDWLKyHrM9B5KUaBVk=;
        b=KIiBXTg5lTJwBB485XcDKvGFS+/fnHTA1FYblYkzvzEtdntrGCrrtAGIgXSJG6j1f/
         RTVgV9xbk5RVgAgv2qO/E28GOyBLzcQsh2sA0Bzi4lpzad6nQNuf+Lb9/Wiq17ZPMsRW
         IZ+5hrgFFRgr3j26HCoOvK/zkZkFfdXEbJtfkpxsSLpr5XWh2RZE372cVubUl+/qBqhH
         nsAeTI9D0rZ7/ZTJNQYug+63BnCko0N9+zUFTYewbQ+FV1O8QxraXzNyw5e+CgQfLLuf
         n2oZWLAchjRyjyQZAg3Wx+OyL/5fd2N148ZXnK8qY4ElfvsV+ICHMwhRxXQV8jdX6C8i
         W8+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+0y/+sOGVPFMl2U9TJM7qKXN8WXggnwPOmaxvDJ8e1uxRo6ZanN0EMO+G7OfukMOdmk72XeGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqLUPvWHlQraQmyid6p9feJADj/9ydYCwDgCv9o77+Pbz6ZPSF
	5U8gA1GLvB9DdFyq5dfzs92vVQzRg8+RlZvahnPA0H21ZDyXUjfAIAclHKrk4oREuM3RU08tzey
	osYKsAfcF0hwn2g==
X-Received: from qtbkc14.prod.google.com ([2002:a05:622a:44ce:b0:50d:4e1e:78c9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:258f:b0:4ff:b32b:cdf9 with SMTP id d75a77b69052e-50e3451a2ebmr10431941cf.14.1776369817126;
 Thu, 16 Apr 2026 13:03:37 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:15 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-11-edumazet@google.com>
Subject: [PATCH net 10/14] tcp: annotate data-races around tp->reord_seen
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279153-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 264DA4146F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 7ec65372ca53 ("tcp: add stat of data packet reordering events")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c       | 2 +-
 net/ipv4/tcp_input.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 57c4dcc8bfe948e895f713cadaad20409a9b8f14..39a4b06e36bbc63b8bc334c8f568c5a2046573b6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4466,7 +4466,7 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	nla_put_u64_64bit(stats, TCP_NLA_BYTES_RETRANS,
 			  READ_ONCE(tp->bytes_retrans), TCP_NLA_PAD);
 	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, READ_ONCE(tp->dsack_dups));
-	nla_put_u32(stats, TCP_NLA_REORD_SEEN, tp->reord_seen);
+	nla_put_u32(stats, TCP_NLA_REORD_SEEN, READ_ONCE(tp->reord_seen));
 	nla_put_u32(stats, TCP_NLA_SRTT, tp->srtt_us >> 3);
 	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH, tp->timeout_rehash);
 	nla_put_u32(stats, TCP_NLA_BYTES_NOTSENT,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 65b3ecc6be4b57f97a62d0e5737a96ddb16dd14d..896a5a5a6b1a9a678e5321dd802554ab343f7835 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1299,7 +1299,7 @@ static void tcp_check_sack_reordering(struct sock *sk, const u32 low_seq,
 	}
 
 	/* This exciting event is worth to be remembered. 8) */
-	tp->reord_seen++;
+	WRITE_ONCE(tp->reord_seen, tp->reord_seen + 1);
 	NET_INC_STATS(sock_net(sk),
 		      ts ? LINUX_MIB_TCPTSREORDER : LINUX_MIB_TCPSACKREORDER);
 }
@@ -2443,7 +2443,7 @@ static void tcp_check_reno_reordering(struct sock *sk, const int addend)
 	WRITE_ONCE(tp->reordering,
 		   min_t(u32, tp->packets_out + addend,
 			 READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_max_reordering)));
-	tp->reord_seen++;
+	WRITE_ONCE(tp->reord_seen, tp->reord_seen + 1);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRENOREORDER);
 }
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


