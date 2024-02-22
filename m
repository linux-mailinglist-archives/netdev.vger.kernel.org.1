Return-Path: <netdev+bounces-73961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988E85F6EC
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA211B23710
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080547F58;
	Thu, 22 Feb 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+CMj8WT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2645979
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601435; cv=none; b=DdH7D9rfNLXgTTOkuJ2u32QVfZ8NVB6DusLPIaweBpQ3SuTIeTJ2FTCib5O1kdEoWbwg1QIZkqVgJZGSq7W2KFO7FC+lFZgWvaLEClEtHX712Gdke1pbh2oOcOnSymA+6uNtlWltbFSHOs5zkWhBgP1X8RlpCBx/Owc5aus5C5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601435; c=relaxed/simple;
	bh=REN+nsOSW0imqIcB8NPeeLgWjwbof1Jrr6EYVisdq9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UH6S7XzxM8TfjEjHo232ulxkz34/1OYDrmwFFinmtuK6h2dmXqs/jf8VJ/r0Pv1XNbkivWEjFfGCo31k3Nu+IRZuPkjuMII/eJLvApC4pchR7pdNpEdQ059rf9qgmwcQ0i0/OIz9S03pa9BWSArX2r0cCR+2BsLJWnQS3bi9LYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+CMj8WT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8da50bffaso40180765ad.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601433; x=1709206233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0M9cdYppQLGFsn2JYXVxQTHSLH3Lnhwz1oMdpbjre8=;
        b=E+CMj8WTSz3fFwpzFTo7xXc7TgPFIMj7NwjEmHUtDCZyamAKCauSCyxYS/PHstcv8P
         YiRee7WVIrXxgo+cg3HJzWwhfdyHD86mvJltnMXQ/+gBuDdpwdX8/2PTdiXcj47C9BHz
         WbiDsTmkOY6Opxk3f0x15jci7m7mkaESyC9Oe8fym9MQrlMXs0nAC5JowaoEDX2OB9Hn
         VWMbgoeFNaTQ1LntbdYeJXmfDIBk7Tutd6DaFNgHirz/1O6MK5sU3T/KVMu4UBVb5uDi
         pKV2Ba0FO3nBTyPDwQ/mGrLVng1JOVhZVs4selmjV1jnE3Dol1CJqTvFpSUAiDghNHn9
         J+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601433; x=1709206233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0M9cdYppQLGFsn2JYXVxQTHSLH3Lnhwz1oMdpbjre8=;
        b=rEcKsWJMJyJNyolcE8wVNUluZ+YKDR5qJDeVPD5AnyZ7ko5C4HA/7Rghqa/IgS3Vfz
         vZWi1d71/yYlRdY/gdIOsLBs6o6kTiXUZn6Y+DH0sIv1B78dP8FTwqpUHyruftXDxT64
         IqZFFR8IvbXcgOYz6ce/4fUbVAadotc42RMGfX/85nPzAjlM+51nffn6oQNRAgn4E4sy
         qehDLM6ChaqLL7NbA9DnhhroJyK3yczwpJPdw9gAukuzplnbdGxBIJ/1S48vC3wCL8YS
         3wEHTS2nuW8pRaiAdo8kOAhnvWB8yAWfLdMlgnfZwNUz7PsRWPaKrOrrGr39hEWxfFcw
         X3dQ==
X-Gm-Message-State: AOJu0YxLqH0SjmSQlEZUDF+9WJrVzAx3atH9zQrgdtTWUL6hDtncMLQP
	1wgV500vmaSYf1aCykpn+JlPSJhhLtUAug+6yFOChYHwCYo1Vqmb
X-Google-Smtp-Source: AGHT+IHqkIU5iyvAz1lxRXboSC5GqwBLX3gXKGeiZ3BWcoIRArQZgEvz0O7C8QuhcSMDzbw/bpbZ7w==
X-Received: by 2002:a17:903:445:b0:1db:917f:5a42 with SMTP id iw5-20020a170903044500b001db917f5a42mr18587162plb.3.1708601433068;
        Thu, 22 Feb 2024 03:30:33 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902a9c300b001dc0955c635sm5978637plr.244.2024.02.22.03.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:32 -0800 (PST)
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
Subject: [PATCH net-next v8 08/10] tcp: add dropreasons in tcp_rcv_state_process()
Date: Thu, 22 Feb 2024 19:30:01 +0800
Message-Id: <20240222113003.67558-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240222113003.67558-1-kerneljasonxing@gmail.com>
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
--
v8
Link: https://lore.kernel.org/netdev/CANn89iJJ9XTVeC=qbSNUnOhQMAsfBfouc9qUJY7MxgQtYGmB3Q@mail.gmail.com/
1. add reviewed-by tag (Eric)

v5:
Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org/
1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
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
index 83308cca1610..b257da06c0c7 100644
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
+			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 		}
 		if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
 		    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
@@ -6790,7 +6796,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 				tcp_fastopen_active_disable(sk);
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-			return 1;
+			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 		}
 
 		tmo = tcp_fin_time(sk);
@@ -6855,7 +6861,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
 				tcp_reset(sk, skb);
-				return 1;
+				return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
 			}
 		}
 		fallthrough;
-- 
2.37.3


