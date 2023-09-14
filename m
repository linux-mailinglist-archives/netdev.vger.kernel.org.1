Return-Path: <netdev+bounces-33851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFA27A0785
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EF0281975
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45018E33;
	Thu, 14 Sep 2023 14:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AD847D
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:37:38 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4901BE5
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:37:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdb9fe821so15347307b3.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694702257; x=1695307057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrVWtdPLkLVfriOfdsH3WstBOGQReQh9PV147EbOj6s=;
        b=Zhh0ODHPTK4a+MiQWruGVdivUegvqi2+goTGrY+V5aRTajHC6Qdo0M/syELJDSgklI
         DalhRupot6vSMxp8GazYkiie7mlrbipnIpdmmfhmAyVZRNrFgpXbL0bz4wepUP3+UAaI
         YOHnBkq+GYL8TI405f6d1RXdJ7BGgDyBvJBE+KmyBQGeNaojSxkNTYJLwELNum5tzoEM
         UNS6X8JbxnlvX+IO93OC8UDbpoQrlRoRkWXLp3Jj2uDZeLPHxhndPgNvdg3ZYXrcYezf
         +LhwS3PxPILawmRVldo8t06eudNourrUM939NbNsz9PbpSw/h23YkKENPvbZoKq4XfLt
         cxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702257; x=1695307057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrVWtdPLkLVfriOfdsH3WstBOGQReQh9PV147EbOj6s=;
        b=Mh2F9Gv3w4P6cNFIag2WZao37wiSb/I0Ucg9+UQwUBDxZYDmAFAFgGRM6IsU266P22
         nQObyVyuVjtIDPRF99Xa3o45rMFSu1brkzdaY6WV3Osy179h/wTTj9fXDdPCKjXl/JMe
         AJqO16YXy3CzkaETu8oowU5vlGA1801zxWCio0KAZCkdAdsj/JuRtw4MlZp+BdxPSM4o
         MP0NdgX62rnVamxe+RX+oYDfnUprrotIlVnveuPX4RWP9oz4NgQslgHWfupPRC4R04ZE
         ZHNzvbJ/3xMj0VFjFc/0D7CfaHL6/SqsAX+RHsDdfwmktkr5Xo8z8UeUzGBK2xSzxSHl
         petg==
X-Gm-Message-State: AOJu0YwRcUbBeAMdLgXg1fOAYM4pMSnxLIum6hk8wm1KArCfVcqM9lZi
	EBUnFyC4BW8MBUjY4pQWtYR2zCPPchw8iA==
X-Google-Smtp-Source: AGHT+IFhn8217E4K2g10J4ewxor7TEG19+VWTh7UfW9YcxHCWeaemaja/n3od4d6CEALRHPwtiFZAeQOr5SHmA==
X-Received: from aananthv.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:44a6])
 (user=aananthv job=sendgmr) by 2002:a05:690c:2513:b0:59b:eea4:a5a6 with SMTP
 id dt19-20020a05690c251300b0059beea4a5a6mr40419ywb.0.1694702256919; Thu, 14
 Sep 2023 07:37:36 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:36:20 +0000
In-Reply-To: <20230914143621.3858667-1-aananthv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914143621.3858667-1-aananthv@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914143621.3858667-2-aananthv@google.com>
Subject: [PATCH net-next v2 1/2] tcp: call tcp_try_undo_recovery when an RTOd
 TFO SYNACK is ACKed
From: Aananth V <aananthv@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Aananth V <aananthv@google.com>
Content-Type: text/plain; charset="UTF-8"

For passive TCP Fast Open sockets that had SYN/ACK timeout and did not
send more data in SYN_RECV, upon receiving the final ACK in 3WHS, the
congestion state may awkwardly stay in CA_Loss mode unless the CA state
was undone due to TCP timestamp checks. However, if
tcp_rcv_synrecv_state_fastopen() decides not to undo, then we should
enter CA_Open, because at that point we have received an ACK covering
the retransmitted SYNACKs. Currently, the icsk_ca_state is only set to
CA_Open after we receive an ACK for a data-packet. This is because
tcp_ack does not call tcp_fastretrans_alert (and tcp_process_loss) if
!prior_packets

Note that tcp_process_loss() calls tcp_try_undo_recovery(), so having
tcp_rcv_synrecv_state_fastopen() decide that if we're in CA_Loss we
should call tcp_try_undo_recovery() is consistent with that, and
low risk.

Fixes: dad8cea7add9 ("tcp: fix TFO SYNACK undo to avoid double-timestamp-undo")
Signed-off-by: Aananth V <aananthv@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 06fe1cf645d5..fe2ab0db2eb7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6436,22 +6436,23 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct request_sock *req;
 
 	/* If we are still handling the SYNACK RTO, see if timestamp ECR allows
 	 * undo. If peer SACKs triggered fast recovery, we can't undo here.
 	 */
-	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss)
-		tcp_try_undo_loss(sk, false);
+	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss && !tp->packets_out)
+		tcp_try_undo_recovery(sk);
 
 	/* Reset rtx states to prevent spurious retransmits_timed_out() */
-	tcp_sk(sk)->retrans_stamp = 0;
+	tp->retrans_stamp = 0;
 	inet_csk(sk)->icsk_retransmits = 0;
 
 	/* Once we leave TCP_SYN_RECV or TCP_FIN_WAIT_1,
 	 * we no longer need req so release it.
 	 */
-	req = rcu_dereference_protected(tcp_sk(sk)->fastopen_rsk,
+	req = rcu_dereference_protected(tp->fastopen_rsk,
 					lockdep_sock_is_held(sk));
 	reqsk_fastopen_remove(sk, req, false);
 
-- 
2.42.0.283.g2d96d420d3-goog


