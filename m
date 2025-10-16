Return-Path: <netdev+bounces-229857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD7BE1674
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 06:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C2819C62E8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 04:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FF32153D8;
	Thu, 16 Oct 2025 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yG7GPGW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11119F43A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760587325; cv=none; b=EiDp2J6eeqjxUrla4p6K0lxTZOICuwhyNwPyV7gucT8HotOhcDT27HiGEltt5T/PvbJdWmcpq/uxgFxe8xXTtPwfWnUHEmFKVeVwbRpPNqLBrySeFVX76OSeUzsG0CHszYO3srVTsjmB+HR6vgrlSzlqAB2NdTqaiYWQPwPgM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760587325; c=relaxed/simple;
	bh=I8OQOf1epBifjaAhPxTQbNhtUUSOqVJh6xfCTTbgKM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A4bs08rRysouAuJCyhOlvJKG5zTLa5SLJVFcyv8pIjNKKZGSxqgju/LoeqXRSTxVjBLdKHNO7o7E7OvvG4iNbyDRecONIrToxcApKNrodsOV52WLudGMTzMrbfOQSbrC/cJ+ji137yH1TyydRBkr61Zr0ABUo0229Hq/zLri6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yG7GPGW+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5529da7771so181632a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 21:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760587323; x=1761192123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPiVecia90DhBFq+Msu8YHclT/QcS6kosj4PVr0gWow=;
        b=yG7GPGW+Pr4wpAPR1U3MnpW6ZyirOGllN9tTnEvHBYm7KwfhLhQuYl/EC0rtEFJgZ7
         UKq5U6OfUh54NpAiMzw0OXJOtdb3g4XCBz00ICXLlEttSyWGysPLPSGuRPz4BjuCCsiS
         AeXa5QwqgH2gc6GkkcEFZ8unWiKBxwzTk1ldsorTrc+EYB2IPAt45sDsNIekuFkz+UiS
         t44cSMYzJvae3rco7t3wYjcNwhqW217mDube+V3mIyr1kQQDFmyoGgQC0FdqX9VEGT6q
         UCO6dp+O0SIe+7cH35us2x/3DOxiqGYTLhq9tzfUDFEGFPGWBRqMncDiQIEHLIafNPSU
         nWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760587323; x=1761192123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPiVecia90DhBFq+Msu8YHclT/QcS6kosj4PVr0gWow=;
        b=GRGGl8Q6pLtbgWbJ4VgKjywsY3BXREojL4ixQRgP4DwWZkV7gAz+wUtaSc9c869xti
         a85GUITLjHvj/e151IvoJ2XszIaU1Oz1H97WsJ1q6NIzk+mGJWnEqWwVPKGOEKn6wxiC
         mzc3MJBmnJAxB9ggkPxsIeOUjbfJwtfGEmWwOK9QZKT/EBZcCx9Ll/PurXQzerJBYAiW
         +F7DSzwHK8jyFZh/DzA8Qwje+UIKxReNPSnmqahizMLGIQQObdv+2Ny0Z6dTLcDVU8/1
         nU9ryRdLpwuUPInCwTQb5MqAP4g+GLsZaPpp7JCjqV3hFOISwdh3qneBk2tcPbVb+mro
         2pVw==
X-Forwarded-Encrypted: i=1; AJvYcCWAIvoGeCjkrkGeactK99vzQDqUCdfWeUCgNRCrmJuQGrlsUzVgBgwrNFpHCHBRWrP1ygUCD8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdnOThqdDf/XNIFc4Bptbwt/EE4Td7phLiSNihaN6CBfZh7psZ
	bmKVZItCeedPULUTAQa1UoQAxVR2mYjdG7eLp3d1isZq/L/DsCPQhTjzvojGCCr93FACjnZKUit
	JY8q2ww==
X-Google-Smtp-Source: AGHT+IEpnvTN3m/o4JVY1QtduEAuoDDdQiVwgieaUnNFFEiA3WH0F/LP/BE+WhuiXFv5dkbs0JjwmmSqREQ=
X-Received: from pjxd1.prod.google.com ([2002:a17:90a:c241:b0:33b:a904:76d1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d08:b0:327:c0c6:8829
 with SMTP id 98e67ed59e1d1-33b5138e154mr40399074a91.24.1760587323320; Wed, 15
 Oct 2025 21:02:03 -0700 (PDT)
Date: Thu, 16 Oct 2025 04:00:33 +0000
In-Reply-To: <20251016040159.3534435-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251016040159.3534435-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/4] tcp: Make TFO client fallback behaviour consistent.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In tcp_send_syn_data(), the TCP Fast Open client could give up
embedding payload into SYN, but the behaviour is inconsistent.

  1. Send a bare SYN with TFO request (option w/o cookie)
  2. Send a bare SYN with TFO cookie

When the client does not have a valid cookie, a bare SYN is
sent with the TFO option without a cookie.

When sendmsg(MSG_FASTOPEN) is called with zero payload and the
client has a valid cookie, a bare SYN is sent with the TFO
cookie, which is confusing.

This also happens when tcp_wmem_schedule() fails to charge
non-zero payload.

OTOH, other fallback paths align with 1.  In this case, a TFO
request is not strictly needed as tcp_fastopen_cookie_check()
has succeeded, but we can use this round to refresh the TFO
cookie.

Let's avoid sending TFO cookie w/o payload to make fallback
behaviour consistent.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_output.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bb3576ac0ad7d..2847c1ffa1615 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4151,6 +4151,9 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 	if (!tcp_fastopen_cookie_check(sk, &tp->rx_opt.mss_clamp, &fo->cookie))
 		goto fallback;
 
+	if (!fo->size)
+		goto fallback;
+
 	/* MSS for SYN-data is based on cached MSS and bounded by PMTU and
 	 * user-MSS. Reserve maximum option space for middleboxes that add
 	 * private TCP options. The cost is reduced data space in SYN :(
@@ -4164,33 +4167,33 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 
 	space = min_t(size_t, space, fo->size);
 
-	if (space &&
-	    !skb_page_frag_refill(min_t(size_t, space, PAGE_SIZE),
+	if (!skb_page_frag_refill(min_t(size_t, space, PAGE_SIZE),
 				  pfrag, sk->sk_allocation))
 		goto fallback;
+
 	syn_data = tcp_stream_alloc_skb(sk, sk->sk_allocation, false);
 	if (!syn_data)
 		goto fallback;
+
 	memcpy(syn_data->cb, syn->cb, sizeof(syn->cb));
-	if (space) {
-		space = min_t(size_t, space, pfrag->size - pfrag->offset);
-		space = tcp_wmem_schedule(sk, space);
-	}
-	if (space) {
+
+	space = min_t(size_t, space, pfrag->size - pfrag->offset);
+	space = tcp_wmem_schedule(sk, space);
+	if (space)
 		space = copy_page_from_iter(pfrag->page, pfrag->offset,
 					    space, &fo->data->msg_iter);
-		if (unlikely(!space)) {
-			tcp_skb_tsorted_anchor_cleanup(syn_data);
-			kfree_skb(syn_data);
-			goto fallback;
-		}
-		skb_fill_page_desc(syn_data, 0, pfrag->page,
-				   pfrag->offset, space);
-		page_ref_inc(pfrag->page);
-		pfrag->offset += space;
-		skb_len_add(syn_data, space);
-		skb_zcopy_set(syn_data, fo->uarg, NULL);
+	if (unlikely(!space)) {
+		tcp_skb_tsorted_anchor_cleanup(syn_data);
+		kfree_skb(syn_data);
+		goto fallback;
 	}
+
+	skb_fill_page_desc(syn_data, 0, pfrag->page, pfrag->offset, space);
+	page_ref_inc(pfrag->page);
+	pfrag->offset += space;
+	skb_len_add(syn_data, space);
+	skb_zcopy_set(syn_data, fo->uarg, NULL);
+
 	/* No more data pending in inet_wait_for_connect() */
 	if (space == fo->size)
 		fo->data = NULL;
-- 
2.51.0.788.g6d19910ace-goog


