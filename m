Return-Path: <netdev+bounces-215649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32AAB2FC6B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291F9623FDE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6228467D;
	Thu, 21 Aug 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A36WSOaB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E3279791
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785948; cv=none; b=lVteOBSzZOyjpdUDQnENNHD6HLlmHF/NVisTZD8a6H4v5ddRb0T53RuEdOj6iJOtB4cl2OMT7m1XN8I5lPmq9NF45XiexWr+nhxW0/JauPTbF38toMJU+PimA311XS6BeY8eH2Wg/yLQL9JyzxKHNOL7LhV2fuZczU/rtetLiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785948; c=relaxed/simple;
	bh=Y+TQ2L0rPL16MwAa5aTt6lGLHm6afnEYyfV7VwpZZro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gThVmsk0p/WMTajVqeuT5zUJf7PukhJY2zm9mvDEjgCiALPAX84rEQbHXvAHXdDMNkrpp6aqiWgXeva+IQIMpoqpEnHFXG4eouRvvd81QlEVGndsDvWxBMXsMdbEGahlLiC3HTKuWcSt0Pm0BjIzqrvscA3wW0SkwHhmP6DkNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A36WSOaB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e9500a4ca5cso1573594276.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755785946; x=1756390746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJp3PhvpcIeiLYUx4L81npOExhrlJHcMmfD016JPS0o=;
        b=A36WSOaBBtLKJm9SmQj1vm7kSimE85LPakdNQAWkeNVC9zqxELPzO3B1Bh7oxMU+7y
         BqQYa7rSun0ZnpfBxcc8n0klvgfXmKki3WvLtY+M5a6uW9B360TXL/vSBe91gg5Np53q
         DEurJ5XptF/TmboHiYpiE97tNHx03Ane8j1sI6GRYIodcmNPoo5aZe4NYCWrxVoZNATW
         UqK9QbZpbgMJf187Jl1GbF95gJB5jdeeR4T530IGrpPBC8t0lggICReGId4psFaJ8MwT
         hf0cXxBxEAxtviC418Le5MLRUvscueGsulIUozQXJU3AWif8gGqURq8ued4q6ceX8Bfc
         gAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785946; x=1756390746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJp3PhvpcIeiLYUx4L81npOExhrlJHcMmfD016JPS0o=;
        b=DySt/PLxF9LuZQepUq8RRGqkq8wi41LDj9qrDNpVFQBnkahZhXYZ0kzKv3Pj2KkYkT
         1Bw+pCMfdy29+SDyLwKxbCv+VA8xW0rDIr5VJkl9guI/5aa3R15ksy2okTimn9eggY8L
         zYgTCvL6LsuSdXgNDZDFse1AgMH+vrS7DAQMmFfpSxHvN6oVxgytTzQiqmaDNcFijfSB
         sbTysEbpTn8iGdjK16TbyHtq4VCBQq6vRrl3RTVgRpmCTyujkhLguuCi4lL4HdNN1zwQ
         zuwLh9BXqg4H2dBedyYeY1NsZO1TkvFdFksrHmB9HVvWsX1cxdN+sYZTOj7R+Koh5Cd3
         Lfiw==
X-Forwarded-Encrypted: i=1; AJvYcCX1XaW6iI/TWrbL4xMpuCbvMDauP4J1QZzoejqIOrknt2IWgF8dJXHjXCzKvGMNhxie6mr2vT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJlZv11IHgawlh7svMKkudJ9mX+MgY9gPWExQCJ6pYQeRjk64
	dwngrh+XAmasYkC7jlCCoSR/jeIlucz4zxPns6+hBqyMc2/z93IwQqcvo288hnDAbFFQhz/u2+d
	LGrCZHYlaRyfemw==
X-Google-Smtp-Source: AGHT+IGfF9ZSZue5U9bNLBJ1aJ2gRuTAQOS9izSgibIorncv4jMhlZ50V0Lcl7AKXsoTVqJ/SbbMPSav/WhVIQ==
X-Received: from ybdp19.prod.google.com ([2002:a25:ea13:0:b0:e93:45ed:4aec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:150c:b0:e95:691:3b0e with SMTP id 3f1490d57ef6-e9508908cecmr2343493276.14.1755785946089;
 Thu, 21 Aug 2025 07:19:06 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:19:01 +0000
In-Reply-To: <20250821141901.18839-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821141901.18839-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821141901.18839-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: lockless TCP_MAXSEG option
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

setsockopt(TCP_MAXSEG) writes over a field that does not need
socket lock protection anymore.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a12d81e01b3f2fb964227881c2f779741cc06e58..99232903b03c99d263cce59314fd369cfd33af6f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3890,15 +3890,13 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		WRITE_ONCE(inet_csk(sk)->icsk_delack_max, delack_max);
 		return 0;
 	}
+	case TCP_MAXSEG:
+		return tcp_sock_set_maxseg(sk, val);
 	}
 
 	sockopt_lock_sock(sk);
 
 	switch (optname) {
-	case TCP_MAXSEG:
-		err = tcp_sock_set_maxseg(sk, val);
-		break;
-
 	case TCP_NODELAY:
 		__tcp_sock_set_nodelay(sk, val);
 		break;
-- 
2.51.0.rc1.193.gad69d77794-goog


