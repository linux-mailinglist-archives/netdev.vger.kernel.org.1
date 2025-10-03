Return-Path: <netdev+bounces-227815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120A9BB7E55
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 20:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DCE1899941
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87B2DA777;
	Fri,  3 Oct 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYHae9CW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C541F8BA6
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516888; cv=none; b=Gtk4jZI0T5VZWg01WEoK0TfcI2j9bsJGbbnX2Wth9OSdJuSJiZJPvoL6UtPsULKrWb+UI28xmUsAOTWbBlgLqKrnP/YArmNkS6EdOBGINQxM0KIvVYFczzMoxHhXiOtMyGaB2wb/uae7x5vw+poOdj8A27bD0EE0QcTXR+VvGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516888; c=relaxed/simple;
	bh=KiFQPrIVECYTmzkA2wzE9bgMjAlkaN1+Xexoh0Akdsk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eIfXtKqrEAlDGO5inMXU/Gq2A+jOJVmJSptSEWfT3aN6DPs39zBzASVSNN4eRZn8eTrOYdNjXPM5kjm6EiaLQi7Qvq8qOzk6yC82jwXBW59ogGizl2hGRDo54M0I3UXNyuCG6jScfxLt8CoWxSH/hS4dpQpxjJC3ekETK0WAeW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYHae9CW; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-5a6a9eac6daso1467423137.2
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759516886; x=1760121686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xa0Y6L1mF7aR92xfsAs2u9rKSk+GSTIPWJWPUxxvpSg=;
        b=XYHae9CWhQaPLsklTYPn6lcYXKPoI1YoILfMVTrQgjt000dXuar/KVl1Fle7GmwxM8
         M+4xuuICLHvbtxEPp1Qj+kNsc8xvP1l9ZTrFHV2T5naWlAdc8pBq+AKFjs9t/bC+N7EP
         jPX2F/OSbZ63k0ymbJwua9USXZ1NS17hdb903zfBIFxCY/prbCxZ2csiPEoCgQnbTfNc
         Gj/3vV24cBCncOgzTjaU6Bu8mbcFhP3R7HBlGmGCip/LD+gpKnSFLbVANEa4YDgWqBVr
         zoRzZkUO+SprYYlFsg9rcP1lnaQIo1Fhh6FoATfWy8gYKgMauLTvNum3+/Qf3WY2op6w
         ktfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759516886; x=1760121686;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xa0Y6L1mF7aR92xfsAs2u9rKSk+GSTIPWJWPUxxvpSg=;
        b=MckEpe0mvXQTIZrYhQPdhXS93NiBtOF6ZtPfvaMUywfAbKmKKvkKgwyvz2Kui+p1Tw
         HaV4pksm/tWdpc/egfcLlMPrQuXVMQY1zIQ5RLmSkdZoLOce0u8iTuTsPuUvw/2N+aft
         XAErsnvSRk5ibZb5Cy9j3zBtGR2KxuBEW4c+gFa9sNNjK0/JeGiBa+TvpFLwQZm4boaD
         x852jWKMy6Wt/XY2np/g8nZvvBZDTaet9WEMyoFh47pTgzNr/ZXsDF3mv5VV/iNX6gif
         4sWOlz5YBvbl6v61DmJdQHEXPGjSaQCv4v6VwEp3Sv0EytPOWMFkfw0UHXIEImEO+Y8L
         fWUA==
X-Forwarded-Encrypted: i=1; AJvYcCXuKTRAuupqsTrcHlNEfWPE/G+zrT+7vqRbzwWIbQHtI8p4Or5IxQPNOH5x1ndOoPzZNDrnscE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56azu02Rpd6zdeJb7VT9Mg7DNEE9aIiClX/0cE3h5hABfBTYy
	jk58i1NKIjcK/Zz2HZNp7LJp11ZV6+51V1dXqIjFLmZcy29XoDrMQwcu8piLatXIzK8zqkgVWWn
	0rDU25OvM8MLL1g==
X-Google-Smtp-Source: AGHT+IHf+usHPG+vNOLBWWeMjDaB923RcJg3y0KY9UjKIKMpjOvw1LFp1U3+cL5LMsuqSSheT0YRJirEaYH8fQ==
X-Received: from vsvj10.prod.google.com ([2002:a05:6102:3e0a:b0:5a5:babd:cc0b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3e19:b0:590:f704:6dac with SMTP id ada2fe7eead31-5d41d047e5fmr1922755137.10.1759516885790;
 Fri, 03 Oct 2025 11:41:25 -0700 (PDT)
Date: Fri,  3 Oct 2025 18:41:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003184119.2526655-1-edumazet@google.com>
Subject: [PATCH net] tcp: take care of zero tp->window_clamp in tcp_set_rcvlowat()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some applications (like selftests/net/tcp_mmap.c) call SO_RCVLOWAT
on their listener, before accept().

This has an unfortunate effect on wscale selection in
tcp_select_initial_window() during 3WHS.

For instance, tcp_mmap was negotiating wscale 4, regardless
of tcp_rmem[2] and sysctl_rmem_max.

Do not change tp->window_clamp if it is zero
or bigger than our computed value.

Zero value is special, it allows tcp_select_initial_window()
to enable autotuning.

Note that SO_RCVLOWAT use on listener is probably not wise,
because tp->scaling_ratio has a default value, possibly wrong.

Fixes: d1361840f8c5 ("tcp: fix SO_RCVLOWAT and RCVBUF autotuning")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7949d16506a46eb561479b77bebce4fe88971c12..8a18aeca7ab07480844946120f51a0555699b4c3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1791,6 +1791,7 @@ EXPORT_IPV6_MOD(tcp_peek_len);
 /* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
 int tcp_set_rcvlowat(struct sock *sk, int val)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	int space, cap;
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
@@ -1809,7 +1810,9 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	space = tcp_space_from_win(sk, val);
 	if (space > sk->sk_rcvbuf) {
 		WRITE_ONCE(sk->sk_rcvbuf, space);
-		WRITE_ONCE(tcp_sk(sk)->window_clamp, val);
+
+		if (tp->window_clamp && tp->window_clamp < val)
+			WRITE_ONCE(tp->window_clamp, val);
 	}
 	return 0;
 }
-- 
2.51.0.618.g983fd99d29-goog


