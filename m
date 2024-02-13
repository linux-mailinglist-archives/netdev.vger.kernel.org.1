Return-Path: <netdev+bounces-71397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC9385329D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19E2281335
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD557335;
	Tue, 13 Feb 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVWM2qOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52CE57326
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833176; cv=none; b=PAgYj1tzrrYPiVNevg0wKh9z+FwaEdZArUzlFZCMl+++mO6GN0xiq3lFShBoCRU8dhaGzutdOoiYyHDYC/OQA7K444Zq11SoB6wSkVQ5Wwn8cbNFzB+rzsmz8IaOcbo7Cy8xJXM2u0SMxnoe3gAgKthxJRflMCD/OrC1xil172k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833176; c=relaxed/simple;
	bh=UCGIW5PNf+zYO+oQsI0/Qb+oXrJw6/1jQGRqwbxjtRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YouBV5lYstEmUXaiocZ0Lo9mIwPd0CvsLo7GaDMmEqZQgnVNf9qE4S5Z2POPedPAA0rWIlFhVKP1hFgjere6o/FyY7257kJ3vheQbAdE4fMxP5nbuaFhJuPJVP6FDjVophU/5kjcq3BQ5ZBhMGA2bfNifk1WYsUjJO/AI+WQ5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVWM2qOH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-296c58a11d0so3271353a91.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833174; x=1708437974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaVcVKNKCO/XNCQaHGJcdkP7KMSbIEDkzBRNfH2o85M=;
        b=dVWM2qOHU/W2KbNXyBcCOQIblcp+Ix/Mh5/APztgaZ1LWqZQ/BxKbNZKHfhK62jW7X
         DH1tScb4mA/zkmtd1zIEqak3+fmKQV16U3yAO0T19zVX8aWZrj5MO/vHWSHthLvQdiHA
         tV731S0v/lgboelCJK3eAED5qDyMLBaMYJFPVoOaa9rKY4o8nQjwQOJMq94VFJTl+x4Y
         cnsDHEJHoK0CO4UhCrPl8XcwukwcUE5g3rUkWiLvhVAwKwQPb26BMX+Yv6DlnNdr+dkA
         O/nmOssz+JypXhMqLI1RwLgfMwwHP43rgDvEkxXOrsvZvB/SI13gGGNKR013r9PRriKR
         ax8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833174; x=1708437974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaVcVKNKCO/XNCQaHGJcdkP7KMSbIEDkzBRNfH2o85M=;
        b=WBS8CyWEsZu1ePqgbNxVYOaV5TBjWOSF52okvfsSduGdiNfR/GvVGVLydN9aNOS7cW
         ppprGveUZEjfvN5sCdJh0ewdYTMqk3OmMuyRzJFmCV6pqZIDNmXjib2hBG5QmC/X9SvH
         xCEkt09yH30Pk4zip46semcI19ZZ4RgllhmdoZpRudO8lB/RCjZbR8FA/gZEyrnpSczI
         o/Zx/VZsAmx1UwjsifxFOFOuvE6yvHFjShZf9vVAFZEZxmhmXk5ggdDSwX4QhPPakn2c
         m+Nz3yKvkFTK0RqA2ATdw5uNZRwH9Kf3dH82FqHziP5Vjq0bPwpDLfetgPMwpJSAjgr8
         1mJg==
X-Gm-Message-State: AOJu0YybtsyhHC7DuOm6DJ4pruEgEIEtyuKvGPGWM4mCqDhGrgGMdPcN
	vzuHR1jy6sIV1I+J6jrhNBSmV5a/QCJN/sL4Y0a+kRxWC5J/6MXa
X-Google-Smtp-Source: AGHT+IFXEJNKtHCPmjx3vB+mDQCRjXvAA/Y54GOflLXfQQt3ZQ+BvXyNdbNINR7/trUcqcVoB3sD7A==
X-Received: by 2002:a17:90b:1942:b0:296:df84:da3 with SMTP id nk2-20020a17090b194200b00296df840da3mr7432442pjb.35.1707833174011;
        Tue, 13 Feb 2024 06:06:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0ibQOGZ7OZSmHqz4Uw22iQnj5GrHTus39LK1j/2uEWVt9XvBUgJNrWbM0tpTm8JnXoKZTAWeeQ+r71pRLSnVyQ/DLqGCiR822EAlR1qWYNAg7iaRDp4sgDtpFNsPe6sJLZU+yXkytU34kuLWS8IqqpJfIi0eYoFLCPRVncCpTHFXz2/fqhz6XXTvnAq8jh5LVh2w7gpdbtsRjzx5enI/qa7ycunRXQM1CLdgkbJIiSMTXZNkSx3bnGuASWviH45ev
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id q19-20020a632a13000000b005dc8702f0a9sm1306247pgq.1.2024.02.13.06.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:06:13 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 3/6] tcp: add dropreasons in tcp_rcv_state_process()
Date: Tue, 13 Feb 2024 22:05:05 +0800
Message-Id: <20240213140508.10878-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213140508.10878-1-kerneljasonxing@gmail.com>
References: <20240213140508.10878-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In this patch, I equipped this function with more dropreasons, but
it still doesn't work yet, which I will do later.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h    |  2 +-
 net/ipv4/tcp_input.c | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 58e65af74ad1..e5af9a5b411b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -348,7 +348,7 @@ void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
 void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
-int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
+enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 43194918ab45..4bb0ec22538c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6619,7 +6619,8 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
  *	address independent.
  */
 
-int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
+enum skb_drop_reason
+tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -6635,7 +6636,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 	case TCP_LISTEN:
 		if (th->ack)
-			return 1;
+			return SKB_DROP_REASON_TCP_FLAGS;
 
 		if (th->rst) {
 			SKB_DR_SET(reason, TCP_RESET);
@@ -6704,8 +6705,13 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				  FLAG_NO_CHALLENGE_ACK);
 
 	if ((int)reason <= 0) {
-		if (sk->sk_state == TCP_SYN_RECV)
-			return 1;	/* send one RST */
+		if (sk->sk_state == TCP_SYN_RECV) {
+			/* send one RST */
+			if (!reason)
+				return SKB_DROP_REASON_TCP_OLD_ACK;
+			else
+				return -reason;
+		}
 		/* accept old ack during closing */
 		if ((int)reason < 0) {
 			tcp_send_challenge_ack(sk);
@@ -6781,7 +6787,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORTONDATA;
 		}
 		if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
 		    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
@@ -6790,7 +6796,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				tcp_fastopen_active_disable(sk);
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORTONDATA;
 		}
 
 		tmo = tcp_fin_time(sk);
@@ -6855,7 +6861,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
 				tcp_reset(sk, skb);
-				return 1;
+				return SKB_DROP_REASON_TCP_ABORTONDATA;
 			}
 		}
 		fallthrough;
-- 
2.37.3


