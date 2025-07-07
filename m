Return-Path: <netdev+bounces-204710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87413AFBDB7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDCE3BBDD6
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EEF289E0F;
	Mon,  7 Jul 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0fW+jg8a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149692882AF
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924346; cv=none; b=j/cWOLBIh6fmAew0oTN/pHM14GB1oHutcSb9gh03C+tbNEAQ7TzLUWTKcQEc8R2GSVKj/TlagaVTD+E4Pd4XiyK6RMifMOnErWaeCbAQPmwkU7MYmVFq5SFFPLMEQKY7grNH3fL1lWJ2Om3h8Jrr1duc3RSGEQbmbnaBJClaFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924346; c=relaxed/simple;
	bh=xOo8MxI25Phjsv1HxJZIp7vh03sSHLjZ5tcK0JOcY6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nTtHRP/xzjqsvw6OBijmmKlZSyi2F3tihBkNiI3Ne5ZZz6EWvC5lyr6TnYjQ1QI2wTJtYLDR1Ecsrb0l2XDZ0mNRU5+mLsYzKUL7ejd+0z72NOkK++R5mfq8hcaOVYfgNvAPfbuOudIuKL5yPLsnoH8CTPwQY9tl9v9PBY7kdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0fW+jg8a; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a43988c314so62186511cf.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751924344; x=1752529144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=weiq4Da9+MTGn//zj1MjmEisPWpGlRHFyTBnVg7WE0c=;
        b=0fW+jg8aENpRqGqhib2/h/iKhK4rioCPT5YDIrDPgka8ElyRtSu2grTernGvyHs3sB
         Zc73lHcD3hcKRVe97HLjTvgEB3prqQE+HJw6Q4D4qe9E8ibfPiklz4g3LnSFlk/1r8Ss
         1XS3FfjiLCDGCwARGaRQ75OCnGHbIC9+UYo4yv/CTzxoS/qN6YLgFGPdtW55QSusxnQb
         SqlZogvHHqe5WDTiEwEUp7NMDplxHbjgCdgdf1U1wtPAvQyfrUby/DMSgn3UC89KfZGi
         pPXHhLrs0mLcMsewu2J2KPq8mtJN+iy/yfWG6ARs0HvrqAXd5ot+pMk1CBljT3FrZOcC
         KvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924344; x=1752529144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weiq4Da9+MTGn//zj1MjmEisPWpGlRHFyTBnVg7WE0c=;
        b=TvcgqKiN+WnCV53k4iMB7TBYFj6fKPZ6z+zugVI4JbzzcgQ83vSxwWiCmMYRyDf+zh
         2mLb2eSwcgckB93q6Lv0UG5iR3npM5QdLpNNmzEJs68Yqtxzl/ORbOXDvWFILUXNLsWn
         qYwd/O8PHP/NzteZJwATeBXFyKBm3lgcEWD5l3g82i9UBmRKz4oUlVdWnrI/O8mObEyy
         GNODw7UysHXba9WUkga04UC7smEVEhX6m83UCfJrLt2MpFzQH9dvrDfjpAC59fUIOwrS
         kWovyIBPLjautKb0d/ah/TLcRwscU4bziErIdplrLQ8UqX11AX7tg7iWULcmHK6Zqzze
         DOFg==
X-Forwarded-Encrypted: i=1; AJvYcCVaaA9AahjF2u9nD38qK0W8jhspE422uLmNhPskKRV/7RVLG/vbHR40qYw5hrfUZSpew4Ld/TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oSD/lkyEBDru92nXPx6o8H1eJUOeYSkWnijyXK/ueYDpHBgt
	CWPzdqEgn8SjDKtqCYNUPS5962OjFOHCsH87Fy2LaMRucB2jXHadsCKV0zufpfXUWJdhH+8kbPG
	DkQzZzL14bbYu7w==
X-Google-Smtp-Source: AGHT+IEO/qFjfIZoFEN4mcuiyqkiODThXFYDQOCDYjibEqPrrSn1WB/rxZhXwEJykh0en99OGqu2m27GDzxkNw==
X-Received: from qtbjb8.prod.google.com ([2002:a05:622a:7108:b0:4a9:b839:89dc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:41:b0:4a8:2d32:b458 with SMTP id d75a77b69052e-4a99671909emr232672421cf.38.1751924343869;
 Mon, 07 Jul 2025 14:39:03 -0700 (PDT)
Date: Mon,  7 Jul 2025 21:38:59 +0000
In-Reply-To: <20250707213900.1543248-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707213900.1543248-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707213900.1543248-2-edumazet@google.com>
Subject: [PATCH net 1/2] tcp: refine sk_rcvbuf increase for ooo packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When a passive flow has not been accepted yet, it is
not wise to increase sk_rcvbuf when receiving ooo packets.

A very busy server might tune down tcp_rmem[1] to better
control how much memory can be used by sockets waiting
in its listeners accept queues.

Fixes: 63ad7dfedfae ("tcp: adjust rcvbuf in presence of reorders")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 12c2e6fc85c62304565e4f2f8d22a916cf73db0c..68bc79eb90197b1bf3e8f5ddfc8762cf331ca1c7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5181,7 +5181,9 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		skb_condense(skb);
 		skb_set_owner_r(skb, sk);
 	}
-	tcp_rcvbuf_grow(sk);
+	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
+	if (sk->sk_socket)
+		tcp_rcvbuf_grow(sk);
 }
 
 static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
-- 
2.50.0.727.gbf7dc18ff4-goog


