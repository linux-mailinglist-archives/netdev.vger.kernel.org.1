Return-Path: <netdev+bounces-196542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 986A8AD5373
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A43A166640
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7EF2E6129;
	Wed, 11 Jun 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="uEp6V7Df";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="IJLML5ee"
X-Original-To: netdev@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6B2E611C
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640525; cv=none; b=ePgPnO/cMPl9SlKIigw7XvxYCn1RVp/KiAxmIXyNKNHHOCgokouLAc8QCriphMANorDVu+LP2lCnjanmb6eYfooFLbAnB1Ern7O+zYuKfnVNfYLvV0xOW53UOFQvHu3etrgwcXpK8+kvEZW7RejZLC8A1BRYAFACGup3HfekcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640525; c=relaxed/simple;
	bh=tCJLgt7l7dJkOb8RKx1jDwE+yWfGqcyH9a8oPK58ojY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdwe16MJWC2Ehxhc/tpzhaMR8O+oydOqEPHIS5xTC4a/KwSX4Cvv2gXEvordaUOJ3rDl3fU3ol48ov3iFIHqIfv+WifY/8gANMC8wuJ9oVOlovPvt0t7m4CVt0q1pNIgZLUh9Z/RGss2Ucl8TnmCyU4nKc7KbV6husWm0TS5jsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=uEp6V7Df; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=IJLML5ee; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID
	:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:Autocrypt;
	bh=AePifKdvj15gTeHCmgUxQLE+LV/3N1008Wx3LkUR/bU=; b=uEp6V7DfNBMit3CJrQVQxGO8cV
	oLlBaHsFUlt0sgt2Xv1uTOFg67c22CAghsELgoJlSyO7oOHqbPF8Myb4gOBg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=AePifKdvj15gTeHCmgUxQLE+LV/3N1008Wx3LkUR/bU=; b=IJLML5eeT8xLnEcKLYLyJT9unm
	qX0oTl67vcLxdVxy9OQei6iqTy9zaTJWAS2qExIMLKIT12TEbdqFzBP03IK1Uku6qpNi7Pa8+kAuX
	2AOYWDlfiKhYUOQw2cEPN2xHCbCWP9DO1CdFStu3OBIaLciJ/qksSy9g+5ldigcLnZ2paqv9SXHnj
	prm6XktL5R8ZrAMf/l+AxjFJvuolWCnPEsOXVWydehcR3ohqkHSCTExQu+b3Bi06mmV8XmrRIxGy5
	4oLWgo6ExyCb+gQZNvnXYvpeM5oJtavrHhhpHZtoAU5lKel/eGz8HGkSQFRCKmUxw+5WLwA/2WwhZ
	WfEfFNDA==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1uPJQM-00000001t3o-0P1X
	(return-path <jgh@exim.org>);
	Wed, 11 Jun 2025 11:15:18 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH net-next] tcp: fix TCP_DEFER_ACCEPT for Fast Open
Date: Wed, 11 Jun 2025 12:14:57 +0100
Message-ID: <046a1b5d6087a4af6aa0e734dcf8312a4bab4a66.1749640237.git.jgh@exim.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

The TCP_DEFER_ACCEPT socket option defers sending the 3rd-ack segment
for a connection until a data write (or timeout).  The existing
implementation works for traditional connections but not for Fast Open,
where the syn moves us to ESTABLISHED and data in the SYN then causes an
ACK to be sent.

Fix by adding checks in those ACK paths for the state set by the
setsockopt, and clear down that state when we send data.

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 net/ipv4/tcp.c        | 4 ++++
 net/ipv4/tcp_input.c  | 4 ++++
 net/ipv4/tcp_output.c | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f64f8276a73c..54096cc94fcd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1499,6 +1499,10 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
 	struct tcp_sock *tp = tcp_sk(sk);
 	bool time_to_ack = false;
 
+	/* Avoid sending ACK if waiting for user data. */
+	if (READ_ONCE(inet_csk(sk)->icsk_accept_queue.rskq_defer_accept))
+		return;
+
 	if (inet_csk_ack_scheduled(sk)) {
 		const struct inet_connection_sock *icsk = inet_csk(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8ec92dec321a..8ebf15cffde9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5776,6 +5776,10 @@ static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned long rtt, delay;
 
+	/* Avoid sending ACK if waiting for user data */
+	if (READ_ONCE(inet_csk(sk)->icsk_accept_queue.rskq_defer_accept))
+		return;
+
 	    /* More than one full frame received... */
 	if (((tp->rcv_nxt - tp->rcv_wup) > inet_csk(sk)->icsk_ack.rcv_mss &&
 	     /* ... and right edge of window advances far enough.
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3ac8d2d17e1f..89f8068d32c5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2752,6 +2752,8 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	int result;
 	bool is_cwnd_limited = false, is_rwnd_limited = false;
 
+	WRITE_ONCE(inet_csk(sk)->icsk_accept_queue.rskq_defer_accept, 0);
+
 	sent_pkts = 0;
 
 	tcp_mstamp_refresh(tp);

base-commit: 0097c4195b1d0ca57d15979626c769c74747b5a0
-- 
2.49.0


