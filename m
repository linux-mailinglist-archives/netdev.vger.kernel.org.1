Return-Path: <netdev+bounces-47772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D85D7EB577
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F711F24E75
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171E32C186;
	Tue, 14 Nov 2023 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMn2D+H/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2D4177C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 17:23:47 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F2123
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 09:23:46 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7aa161b2fso81512707b3.2
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699982625; x=1700587425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0Bt3PXmG16q1JY0dDWPFulW84yQA30B43ArzWpWMZw=;
        b=CMn2D+H/60T7xCNYoPkLDoIqTvaMdl0FbbcWJv8LBy07pxDgzlENODIaviteWJqf6a
         42cliGVEX0pGo83UkBbtaoBsDLUIdNd5isljHgd2/9m1F/ztqnAPboz3YGyVZNzFyWMH
         Y2rKdcz3ZecZRPwKksl8KafY+rxykGO4JNU4LHAHDzSz5+t0gCCovC55x/mZyOXbu5zx
         8oJzMBfKoS9zYVN/au/zuvF6BlLwPvf8UOmSh9YJ0a7QrnxeXAaWjCGfmvciS4mfB9l9
         2EGYeoeZiblr6AG6CmiA9A0z+30HIw+bpZg0uZKwSG7qcFdzbx3s7qiJaxomh7s1Zgvz
         +cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982625; x=1700587425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0Bt3PXmG16q1JY0dDWPFulW84yQA30B43ArzWpWMZw=;
        b=ERpkN0wFaWtn8K0NnxdzYw7+0hY/9tm9EVXjIFDXw1ZytTAj1Lv/zfTZCjzIbCHvQC
         E5vYRyz3JkdEGFpqIzGIa5R4XLRKLbXe7IK4Y0buIaWndw8B7tdNqJ+3192cd1jYxcMV
         ZVzLEspMUj4VwhZvmtblQbpo5geAdWVXa9PFqOuFd2w0NLAZ107/r7+xo7a563DqtYLe
         HNgXIwKXjoWxBh6RRkk0MwBG9MaHHYC4m93+x+ajEd63Vvr07nAiMVUn7Z4LYyCNmBi7
         fz2D93nKkNmWbxyV7IAcPFEdlwCQsDGmK0gDl2f9BdNZtUCx7de80ocuYIrbHCVNfg3J
         HajA==
X-Gm-Message-State: AOJu0YwTF4Zjm5DqFkXG6frHFDs4YzYEG+3ZZ2hqAVMdoyJI3bEHo8Ml
	eKRhTXVf79dLTHMBz77tYWUnswXBSUjDRg==
X-Google-Smtp-Source: AGHT+IF5U0FIHEGZ9JZeFhrpITd5g6/KUx8qoL3pi4Wm4+cECLAr19CsAP7hAlDQaGpIA0yPXnQD+ElA39KlnQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:920e:0:b0:5bf:5720:4fdc with SMTP id
 j14-20020a81920e000000b005bf57204fdcmr269956ywg.6.1699982625373; Tue, 14 Nov
 2023 09:23:45 -0800 (PST)
Date: Tue, 14 Nov 2023 17:23:40 +0000
In-Reply-To: <20231114172341.1306769-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231114172341.1306769-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231114172341.1306769-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: use tp->total_rto to track number of linear
 timeouts in SYN_SENT state
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	David Morley <morleyd@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit ccce324dabfe ("tcp: make the first N SYN RTO backoffs linear")
David used icsk->icsk_backoff field to track the number of linear timeouts.

Since then, tp->total_rto has been added.

This commit uses tp->total_rto instead of icsk->icsk_backoff
so that tcp_ld_RTO_revert() no longer can trigger an overflow
in inet_csk_rto_backoff(). Other than the potential UBSAN
report, there was no issue because receiving an ICMP message
currently aborts the connect().

In the following patch, we want to adhere to RFC 6069
and RFC 1122 4.2.3.9.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Morley <morleyd@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
---
 net/ipv4/tcp_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 1f9f6c1c196b2de35b0bc2f734484f09ba90541a..d1ad20ce1c8c7c013b8b0f26d71c0b0bc4800354 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -626,7 +626,6 @@ void tcp_retransmit_timer(struct sock *sk)
 	 * implemented ftp to mars will work nicely. We will have to fix
 	 * the 120 second clamps though!
 	 */
-	icsk->icsk_backoff++;
 
 out_reset_timer:
 	/* If stream is thin, use linear timeouts. Since 'icsk_backoff' is
@@ -647,11 +646,12 @@ void tcp_retransmit_timer(struct sock *sk)
 				       tcp_rto_min(sk),
 				       TCP_RTO_MAX);
 	} else if (sk->sk_state != TCP_SYN_SENT ||
-		   icsk->icsk_backoff >
+		   tp->total_rto >
 		   READ_ONCE(net->ipv4.sysctl_tcp_syn_linear_timeouts)) {
 		/* Use normal (exponential) backoff unless linear timeouts are
 		 * activated.
 		 */
+		icsk->icsk_backoff++;
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
 	}
 	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-- 
2.42.0.869.gea05f2083d-goog


