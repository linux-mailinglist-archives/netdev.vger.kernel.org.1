Return-Path: <netdev+bounces-43015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16207D0FFE
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1611F24270
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442C1A710;
	Fri, 20 Oct 2023 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1LhfcVQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D041A70E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:57:56 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DAD9F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cf717bacso10778717b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806673; x=1698411473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=INi1WHrAHQ3lQVzZfN0QdK8/QFfP7fv6wbxwAUUDHOc=;
        b=E1LhfcVQBVBVi6sYZeCZQCjZr8picpfsGfIdOKNnJ6HMZmmT9Q5u3RK0U0nEuiy/uK
         9VFN5W2SMxaor760mOPnlr7zGVqI737Df6y3IvD4gGcSYt26pv79xYi0ytw2KSGrYXum
         fuAun/caTh7o5h9TM6iy3STVwxsOeAl0Lm2scHQ/z5APqiSz6NnorGPoq2whjasFRMMv
         E/s0icD0sx/ifrGOHoG1G0UwNH8tGGk7TBmi0sFu2WyVXTV8m6xF4YWUBdjeN20VKMPT
         QjASrPu5j6bouY5iNONHM3py/evhSF7/ddihHwUmUSSZf6A83MBO0RwxBhOG1OhbsVBk
         L21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806673; x=1698411473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INi1WHrAHQ3lQVzZfN0QdK8/QFfP7fv6wbxwAUUDHOc=;
        b=eEQlqKWCqZku0GGKhVM/QpbSsj0dfnLfjGJDHrQ7l3mCUSaDiZiwGgC7Dk4enCYcDq
         qkVlGHJFRlfpJTiXz7YxGyl90hPG0y2HqI4TIdUmOp2dtR3ZE9eG2nB9iiCQehFeXqWe
         k7Qr0NMsUfAzoAOT08I5OyDic7tkk6FgRiCjXUN4MirXNfmvtwfSb8UmeSqH55hdcOVE
         gVPD3mYQawLYXIyIfqdT5DWzkIcoDeiNoiVFeE+TTsQO714+2ZmuXRnQ5pprmz2S6XFO
         F6B+ycX2y0INBs6uu9NxIPcV2EMY50dMt/EkIs7BPPq9DPL8ovdCxPzybnYNDVsRVvB9
         FwGQ==
X-Gm-Message-State: AOJu0YxVqAmE12mmX/MKI+qQj2+JxHULopXiwoimhU3DUW9sHv2SK8nP
	/F436YbGdige9ZDM4ZW1lf0tZwcMKoalgg==
X-Google-Smtp-Source: AGHT+IHRyRiwyWEoA6G+ZjEjGiskDX3zpONRlrFvtFeOhBjLz+AP/tRmyLOKUc9Bdc/DO+1khy4JXI31lXpiOg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d055:0:b0:d9a:bc94:8bf with SMTP id
 h82-20020a25d055000000b00d9abc9408bfmr38121ybg.12.1697806673765; Fri, 20 Oct
 2023 05:57:53 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:37 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-3-edumazet@google.com>
Subject: [PATCH net-next 02/13] tcp: fix cookie_init_timestamp() overflows
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

cookie_init_timestamp() is supposed to return a 64bit timestamp
suitable for both TSval determination and setting of skb->tstamp.

Unfortunately it uses 32bit fields and overflows after
2^32 * 10^6 nsec (~49 days) of uptime.

Generated TSval are still correct, but skb->tstamp might be set
far away in the past, potentially confusing other layers.

tcp_ns_to_ts() is changed to return a full 64bit value,
ts and ts_now variables are changed to u64 type,
and TSMASK is removed in favor of shifts operations.

While we are at it, change this sequence:
		ts >>= TSBITS;
		ts--;
		ts <<= TSBITS;
		ts |= options;
to:
		ts -= (1UL << TSBITS);

Fixes: 9a568de4818d ("tcp: switch TCP TS option (RFC 7323) to 1ms clock")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     |  2 +-
 net/ipv4/syncookies.c | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index bad304d173a56c768e1f87fa740e8e568d220f00..d47a57a47b50b4bbc7ff45c76371d39cf6207c54 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -805,7 +805,7 @@ static inline u32 tcp_time_stamp(const struct tcp_sock *tp)
 }
 
 /* Convert a nsec timestamp into TCP TSval timestamp (ms based currently) */
-static inline u32 tcp_ns_to_ts(u64 ns)
+static inline u64 tcp_ns_to_ts(u64 ns)
 {
 	return div_u64(ns, NSEC_PER_SEC / TCP_TS_HZ);
 }
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index dc478a0574cbe71d392522ed4a690f12654f3e08..3b4dafefb4b036c661bf52f5e7e304b943a4fd5e 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -41,7 +41,6 @@ static siphash_aligned_key_t syncookie_secret[2];
  * requested/supported by the syn/synack exchange.
  */
 #define TSBITS	6
-#define TSMASK	(((__u32)1 << TSBITS) - 1)
 
 static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
 		       u32 count, int c)
@@ -62,27 +61,22 @@ static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
  */
 u64 cookie_init_timestamp(struct request_sock *req, u64 now)
 {
-	struct inet_request_sock *ireq;
-	u32 ts, ts_now = tcp_ns_to_ts(now);
+	const struct inet_request_sock *ireq = inet_rsk(req);
+	u64 ts, ts_now = tcp_ns_to_ts(now);
 	u32 options = 0;
 
-	ireq = inet_rsk(req);
-
 	options = ireq->wscale_ok ? ireq->snd_wscale : TS_OPT_WSCALE_MASK;
 	if (ireq->sack_ok)
 		options |= TS_OPT_SACK;
 	if (ireq->ecn_ok)
 		options |= TS_OPT_ECN;
 
-	ts = ts_now & ~TSMASK;
+	ts = (ts_now >> TSBITS) << TSBITS;
 	ts |= options;
-	if (ts > ts_now) {
-		ts >>= TSBITS;
-		ts--;
-		ts <<= TSBITS;
-		ts |= options;
-	}
-	return (u64)ts * (NSEC_PER_SEC / TCP_TS_HZ);
+	if (ts > ts_now)
+		ts -= (1UL << TSBITS);
+
+	return ts * (NSEC_PER_SEC / TCP_TS_HZ);
 }
 
 
-- 
2.42.0.655.g421f12c284-goog


