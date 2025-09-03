Return-Path: <netdev+bounces-219485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB4B41900
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16315166910
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB612EC0AC;
	Wed,  3 Sep 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+5scImy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008D2D6626
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889246; cv=none; b=AymwOjdIjFQJA9Q3hTkRjdFuwlFEpm7O+qu7eQ3omb6qnjW7PJXXtbZ9TcqozA7z4hFwE97X8ztvxucwHAbkP6piLWebN/VuFGPs1imairi/b4iNAe02sPEfJmySsIbv5PCa1yqsvGhahry5nvYoXQPV0JkNwAwi5JxIo/wn02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889246; c=relaxed/simple;
	bh=TEFuWtdLEAhJ8Tk1DqE9bXVM+4D8SUdI01QbOZji6Po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=elg8dd4Vm/eWZdhbsc9qn9F2+cLAo6fxpe+KT+S+M13XiB9+WiTH1gF16wCNUstqMjCPa2x2b69hLbZG0yHaewv0P+UTIYgZNApOppn5ecw+WgOdnkRTkDcplmg5As7de7e0LbzvfCZKEoHD7s1MOkbPQCNhW1cW4v1A66szwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+5scImy; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-70de0bdb600so103291226d6.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756889243; x=1757494043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pApEgp2fnjlNrU8yRUBF4pdimj4jDwv5KlXQKO+Z18E=;
        b=J+5scImylEFnoe4j+++JS78w6rcF6M23oRgck0TkdAwKBy/RWlVUel2f3Ffam4S95v
         AhNJCwWsYXCRSRnyRvm4N1JG5HAlUrMTjef1y4Kgg6mzFcBF7AzohnqZ1HkSuZy7XFzo
         23ol523xurCVsD/EGcspgRwZelpieDKyy7xdbsuGN492fLjShLYvfA6xx1/Ze201hBxZ
         fsPHH4NeKp4ewWNUFcw06MUMcL3tfNXy8rwGYDV//cDoaF5O9TNYLrg5wBTzFQMqn0Rp
         SAXcduue3w4BOFX68TpsqX814Isse7REktzRvvL6XrR648BYh+S55CZWGOUxzoLvk3W1
         L2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889243; x=1757494043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pApEgp2fnjlNrU8yRUBF4pdimj4jDwv5KlXQKO+Z18E=;
        b=MoVB7ZQujvJZ2p3J/Cv0A9FzBl9dRR0vk5DUovy4SlYgIjcN6cuBKA0LpuSeQA5Pg5
         aHCx0GYdg7LymfMv1Ag2r6H+7gUrs2xni2V/PXWPn4gixJXovxebYCGplk/ohTU8eTCE
         zSrqHzeRx6LTqj7F+m3HAbyKHdp8bpzkL2ER0DmmdwSLObTBme3r3b3C7uCaxoSEHwge
         hmtqUh/bVhtmW6Si8+G/uywma0FsivRfLjkioiSJstqwMLUxP6nmqY4yGj8jzkjQ1Xoq
         imPOoIZHtRLJQtK9eJP2L40PdFhy4/4rP83HMSTBTQ3WQkXaAV72SpmGxEDkLeBPdKqo
         E0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVT5fNTZi1ss4bPjP2xied0MOT/8p9u+QLSdqChJBzfE4RoCICXW8LHnCGdjI/b/RlOjFopbOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwejQorpEb8rG8jOl2zX7Hqhii7AcAgFcZqNDbgiRipKtsRPSX6
	VkTPtNwptnVw/fMc31n3/9DonogKK9Hvg5cHpNKaijaeuGwMEIfFNbwVuTMZgjiLrWx21M2xTS8
	p6HIic9YL5L7sbw==
X-Google-Smtp-Source: AGHT+IEOlKhuQGwwutfKk+1Y55rpfkdPqLBz6nyDlIj8kVhiIDs3hlDJQb2NXB7owjAYYiFSpYevhdwGDcRRLA==
X-Received: from qvwe4.prod.google.com ([2002:a05:6214:1624:b0:70d:f0d8:f5a3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5014:b0:70d:eb6d:b7ea with SMTP id 6a1803df08f44-70fac87021dmr149270746d6.33.1756889243654;
 Wed, 03 Sep 2025 01:47:23 -0700 (PDT)
Date: Wed,  3 Sep 2025 08:47:18 +0000
In-Reply-To: <20250903084720.1168904-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903084720.1168904-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] tcp: fix __tcp_close() to only send RST when required
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If the receive queue contains payload that was already
received, __tcp_close() can send an unexpected RST.

Refine the code to take tp->copied_seq into account,
as we already do in tcp recvmsg().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 40b774b4f587..39eb03f6d07f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3099,8 +3099,8 @@ bool tcp_check_oom(const struct sock *sk, int shift)
 
 void __tcp_close(struct sock *sk, long timeout)
 {
+	bool data_was_unread = false;
 	struct sk_buff *skb;
-	int data_was_unread = 0;
 	int state;
 
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
@@ -3119,11 +3119,12 @@ void __tcp_close(struct sock *sk, long timeout)
 	 *  reader process may not have drained the data yet!
 	 */
 	while ((skb = __skb_dequeue(&sk->sk_receive_queue)) != NULL) {
-		u32 len = TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq;
+		u32 end_seq = TCP_SKB_CB(skb)->end_seq;
 
 		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
-			len--;
-		data_was_unread += len;
+			end_seq--;
+		if (after(end_seq, tcp_sk(sk)->copied_seq))
+			data_was_unread = true;
 		__kfree_skb(skb);
 	}
 
-- 
2.51.0.338.gd7d06c2dae-goog


