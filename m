Return-Path: <netdev+bounces-111640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69C8931E96
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AF21F21069
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C32A79D1;
	Tue, 16 Jul 2024 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxHHb66E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAD63A9
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094849; cv=none; b=BTQkU1OQ+bTdJDpiSQSh35UntxltqBaP/+tF+emIjTBa6s4lZCsip+/g3MYDN+Enb5K6T3fkx+Nuz4TyIeZM+b4x4dnbHIEKj12cWOy5IppBEIqhhTQZJli6C1VBgU4gTU04WfHTjoeW1i3zYJtrOfhcCyaC0cpEeclZcliFD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094849; c=relaxed/simple;
	bh=x3SpAdnbMCNabIen2FgGGR6D3ta0bimwzrROf3/CXe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JLhrHYnV5gIPt9wDlZHOcWFOYxwGtKMkoDtrFzdTNdOpOq7SSGB8lZLhKbxgASGhoq0jDixCAr/EpzZ/yjA1ofnk3p/z2hyJ1raqPFe3AUY+Ts7iqX56+05rQpzn1+DM4CblyWzTNaoAq5gDrLIqDJDY5SM5vnqNy9KtNIECIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxHHb66E; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035f7b5976so9992462276.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721094847; x=1721699647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxjRjv96EaYNUeNOY6gCKi5ZK9ts3UABGiNVlj6fHw0=;
        b=CxHHb66EQOTbAbFH08wZ4i2rj/c1M4+/eygFRgk0TzVVLNTAx3/1cqVxBDE8nfFP3W
         TgICsM6vGSysYWtEq2EBB4IS/oatDjSevvu7Mb1mDwZYWpIe5BN6rY6UA5W+1lOXn1Mn
         vH2VQheMc9JxmvZjPsiU/6IAwf6hEvbjc54mG2tUYh/iBoGhoXXKqKeZHlLJF4CQB2y3
         YyMBQjmLRYHavIXFe6BQcqk8FiJ2fav2YIv767KtOEBdrZmZK1LqOThN10kwqSfSGUxX
         R3pLU0uIpEex+TDwoI5Bkx5jRJuif0awtzzsBc1R6RdbDPyvZx+C52jlcDzDLI5Fdv3T
         SO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721094847; x=1721699647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxjRjv96EaYNUeNOY6gCKi5ZK9ts3UABGiNVlj6fHw0=;
        b=R70Sx1pekhhIbeI2nBIDi+4zrbgOhXPcbzuvnoB4TO8EIwuLmFQ/9KsOlwZaLfhAdi
         J2uX8GwdDw5OzYmIsIehsc/1gushXulBrsAP133YBZczwVscGzwupds8nfZRd8cQdywy
         jqj6/UhIVxz5L5ArKmBkNp4kKyZNUkO4haTUqtt5kTYc8IDuYmJy8auptm2AH/Vhpkw5
         HikpwH+vzoAJlaMdWKr0npXD/tEsucCJ4xk1vMa+sG0y59ZZsGZ2RpbFfe6XiShBo95O
         TarihNaZpNSVY4MZEOFEJQQlJXHNcC9QqX1lpYt5/d0LEttq5FYvYZvzab+hO5Wnr7j7
         jTSw==
X-Forwarded-Encrypted: i=1; AJvYcCVbV0hj/QWnCEstaAUJqRq/lAR7yu05ONaE3Ju3Kx6tn53FkY742PnSVQt5A8XllfZeyecT4VnHxiYvjvaTFMN9FSugg0dL
X-Gm-Message-State: AOJu0YyiAjUBCFFk9G6ZMxYVBBvNb3eYUSEdmrkGpkSQSZNGoq9JzEE0
	3WMiVnbVMQinWEaW0eIkEdhiFFck4Iu8g9qcNB2pbYq5y9XIkZoGwWmKF21ZSD8HZ1sTLk5S4Pr
	WX1v1VtkUoA==
X-Google-Smtp-Source: AGHT+IECjVX8bXcVcLUgpPfZ0RSLETn9wR/B2515wkRjrMUVIlk3+lcSkMKJ9gxnVU9iIDz6dsZ4gh2lLkadRw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:51c1:0:b0:e03:a062:11b7 with SMTP id
 3f1490d57ef6-e05d7e8f98dmr1240276.0.1721094846673; Mon, 15 Jul 2024 18:54:06
 -0700 (PDT)
Date: Tue, 16 Jul 2024 01:53:58 +0000
In-Reply-To: <20240716015401.2365503-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240716015401.2365503-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240716015401.2365503-3-edumazet@google.com>
Subject: [PATCH stable-5.4 2/4] net: tcp: fix unexcepted socket die when
 snd_wnd is 0
From: Eric Dumazet <edumazet@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Jon Maxwell <jmaxwell37@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Menglong Dong <imagedong@tencent.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Menglong Dong <imagedong@tencent.com>

commit e89688e3e97868451a5d05b38a9d2633d6785cd4 upstream.

In tcp_retransmit_timer(), a window shrunk connection will be regarded
as timeout if 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX'. This is not
right all the time.

The retransmits will become zero-window probes in tcp_retransmit_timer()
if the 'snd_wnd==0'. Therefore, the icsk->icsk_rto will come up to
TCP_RTO_MAX sooner or later.

However, the timer can be delayed and be triggered after 122877ms, not
TCP_RTO_MAX, as I tested.

Therefore, 'tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX' is always true
once the RTO come up to TCP_RTO_MAX, and the socket will die.

Fix this by replacing the 'tcp_jiffies32' with '(u32)icsk->icsk_timeout',
which is exact the timestamp of the timeout.

However, "tp->rcv_tstamp" can restart from idle, then tp->rcv_tstamp
could already be a long time (minutes or hours) in the past even on the
first RTO. So we double check the timeout with the duration of the
retransmission.

Meanwhile, making "2 * TCP_RTO_MAX" as the timeout to avoid the socket
dying too soon.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gSD2XT8pyAMM096pg@mail.gmail.com/
Signed-off-by: Menglong Dong <imagedong@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/ipv4/tcp_timer.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index e0bd7999d6d51602fcd868a72d00618234bd0c27..76bd619a89848a2a673b49fdb034037b454ced18 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -434,6 +434,22 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 			  TCP_TIMEOUT_INIT << req->num_timeout, TCP_RTO_MAX);
 }
 
+static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
+				     const struct sk_buff *skb)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+	const int timeout = TCP_RTO_MAX * 2;
+	u32 rcv_delta, rtx_delta;
+
+	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
+	if (rcv_delta <= timeout)
+		return false;
+
+	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
+			(tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
+
+	return rtx_delta > timeout;
+}
 
 /**
  *  tcp_retransmit_timer() - The TCP retransmit timeout handler
@@ -497,7 +513,7 @@ void tcp_retransmit_timer(struct sock *sk)
 					    tp->snd_una, tp->snd_nxt);
 		}
 #endif
-		if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
+		if (tcp_rtx_probe0_timed_out(sk, skb)) {
 			tcp_write_err(sk);
 			goto out;
 		}
-- 
2.45.2.993.g49e7a77208-goog


