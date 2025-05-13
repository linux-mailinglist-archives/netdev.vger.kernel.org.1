Return-Path: <netdev+bounces-190243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2895AB5D3C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C1719E35EE
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029FF2BFC96;
	Tue, 13 May 2025 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/6Ta8Zc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AA2BFC8C
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165173; cv=none; b=T9PsY/LyO/rW5n+MwtO9/JesAEy/vN9fQgqAELIDdOgWl0ZD9WPrbfqr88Mz/BIsTvaSnnn4e7+B2vMULYB/BSsZ04tD0iDgb7vCDVelyn+z2fiBN/nH93RMJ3P78ddWC0ckHljzSyt1pFkI8b4WOP9hPa7jEXbkvPqPO1anwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165173; c=relaxed/simple;
	bh=bwAhCCxg6c7iuFc3rs1MWPdGb787Y92IVaWKKOxWa0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aQH3fdOuLXIn4ygUzyjY095swo6oYyEzeVUk/EbnJakU5NWyPgqxonp8JVKj5pgufNrAIfJzfWw/Kj6NyZLJL38usnN2C1LbfAGqQbmzPdwqhvt8tSyzWyN3uEieOA4sLzLIPtO+3m2fUCx+roE3o1Gwa2oV/ZLm72u8BlAqH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/6Ta8Zc; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6f6eba61cbbso67722236d6.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165171; x=1747769971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5icCYz10E6gSlGeYZ0X945GnCg+vbOCA/Q8FyB2A2sY=;
        b=d/6Ta8ZcTaQ7KwMEUA2Gf5C5T+mzvBtTIZ/nX0Ui5HrKYss27HfmGpMsQR+siEntkX
         vtoXMjrRDp8RvLYavDp72BEN8FaE6nJha1HGGCLAxY/yBSP6Z6OyRs4D+S5/qIUpd3fm
         Dy55zesQOUoDz2fHjJx6lgVw2Bf38YXrHD0AhxUP+p/aY9HaKoO783+Rn07kWAMA8lrM
         9gK6uPpdpJDktTgPoq2IxNV4wnYxR9F7xl1AnHnDx8SJnbF/SYnns2lyEp/rPJridKlT
         vIeLHmZYhO90Plftllv+F56ydWP8RhTnrBVoX/QM/55PNs6rJz623zK3UrUtrKP84wbN
         00mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165171; x=1747769971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5icCYz10E6gSlGeYZ0X945GnCg+vbOCA/Q8FyB2A2sY=;
        b=AeFDxrn1MrMJcy9mKgSkhfKVBHcK9nqdLOQVffn5cJGwpXzT/3qP8Oucv4JqJti7YQ
         tO0khV+nF/5rbcfgSf4RDyAyRKCQ03FyCEphDOZbEyaPT/3w7cB8mHFTfGn2dssxtEe4
         A+B6+h//huil0MpSdeukQNtTlaTG/ciZEqlheoZJTUqWXZMwlcBzUicLWV1PlF0ljUjm
         qThSUGdLIWG7T8uycyIVuktX5OWO4XpM6tFytZbrh6D1EzMHOs2KSidVxZwSCrCA0yc3
         s41qIYUQeexDWETpNT5WDxXJE/9n7pmNmg9n9KdKD2qDUQ/LqkJw0JvJF29bQWjk8hSM
         hiig==
X-Forwarded-Encrypted: i=1; AJvYcCWj5cUKIBaRKRS07QnlFYsb6ZtnadrhtRjIsMeY8aVQZoR+QL9ynhkA86tBN/89gtSQIA3gBuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzWBjjL33ff0PXjiARwnYImlY1ZTyoCiWC7Quz+ke88x+vCMJ
	mzoWlPk0TWWF4LTVb+22ZClHXF95SthyDV6F1I7WjM+aX1AvpiASLT5B81GtcBD+6jqeRHXK/DH
	GulK619cyow==
X-Google-Smtp-Source: AGHT+IGxhmilil/RiVpLxTRtvOSwz3UplzCUzXBdIWAyTXtSfkG5dw0MdsTqB4sYAU5vN9NBWAcm31QA1bMf9w==
X-Received: from qvlh13.prod.google.com ([2002:a0c:f40d:0:b0:6f5:d8d:4844])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:248a:b0:6f5:426c:1c6 with SMTP id 6a1803df08f44-6f896e2e166mr11206086d6.21.1747165171279;
 Tue, 13 May 2025 12:39:31 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:14 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-7-edumazet@google.com>
Subject: [PATCH net-next 06/11] tcp: fix initial tp->rcvq_space.space value
 for passive TS enabled flows
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_rcv_state_process() must tweak tp->advmss for TS enabled flows
before the call to tcp_init_transfer() / tcp_init_buffer_space().

Otherwise tp->rcvq_space.space is off by 120 bytes
(TCP_INIT_CWND * TCPOLEN_TSTAMP_ALIGNED).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
---
 net/ipv4/tcp_input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f3eae8f5ad2b6c5602542a1083328f71ec8cbded..32b8b332c7d82e8c6a0716b26f2e048d68667864 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6872,6 +6872,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (!tp->srtt_us)
 			tcp_synack_rtt_meas(sk, req);
 
+		if (tp->rx_opt.tstamp_ok)
+			tp->advmss -= TCPOLEN_TSTAMP_ALIGNED;
+
 		if (req) {
 			tcp_rcv_synrecv_state_fastopen(sk);
 		} else {
@@ -6897,9 +6900,6 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tp->snd_wnd = ntohs(th->window) << tp->rx_opt.snd_wscale;
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 
-		if (tp->rx_opt.tstamp_ok)
-			tp->advmss -= TCPOLEN_TSTAMP_ALIGNED;
-
 		if (!inet_csk(sk)->icsk_ca_ops->cong_control)
 			tcp_update_pacing_rate(sk);
 
-- 
2.49.0.1045.g170613ef41-goog


