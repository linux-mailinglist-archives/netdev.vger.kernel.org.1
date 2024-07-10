Return-Path: <netdev+bounces-110442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E7D92C6F1
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430D928369F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 00:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2FDA32;
	Wed, 10 Jul 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wzBkKJJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17020A35
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570449; cv=none; b=hizq+g0GcXryrNMDtbZntrHUqDBrke8RaeE6ycCDBgQcmt9Ed1MyX4FQ5w1KV7yN9dSaV9HBpCdXmT1dBbClCcFj7gL2jeWD1P0OQKm4oliks+DO5fiXNRgmkeVti4pFgMrSnLz8Hy6+vSjRdSmCRX/qnzBaBF8rfdww1Jzfk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570449; c=relaxed/simple;
	bh=qaY1vmzkDjES1bdhMdWge2zCsIzcnjH6gaqssbsHXt8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EfQBlgM9jFa2uVMj3kCzlVT448Qi1xbg7LtTF65eHaw0R90XviVQ197iQ9X5YUcsB2Ih9m0JNQAalciasuZQwpxN4BjhiCIB/gSdHymVbPoRcDvQi0RllA5IWK3HA6gw3+pCPrypV5Bxpn1RsjZuCaFAjLZ3HLRY3wSGdB/LKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wzBkKJJF; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6b5a5e78dd8so5144176d6.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 17:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720570447; x=1721175247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3/AVlMzbcZLPmvYzmk46Bfuh1PRmVGTfNxlitome9iE=;
        b=wzBkKJJFojl5rpvB/8T8++hlfOct1OOtBdMUT4VNmJUCOCnVp57HtA+GJ0vDL9Gekj
         3DNr6jHk8PKPs77g2dzhWHVzPUviMR7hoWoG/QSj0yjrnG0dG1fmY8cYCM9BldoA1kOu
         eUnnyA5MLLRt24QzgaaBWjOImS5DM/TzMy9JJTcGSGJESji1Yn9MT6zclGeloSJ7xM8C
         kHGFiW955CsDktszxObfU0xAMWAMBWlJUgQZNNI9OaksK2jtW9l7lFsiSflSRYL+bL6R
         B2unhq1P2vkXx9XZl7jdBeifmoTtsszmGIUspdvOz/FwlwFwMsROFEapGJHqnwiS7M22
         A1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720570447; x=1721175247;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/AVlMzbcZLPmvYzmk46Bfuh1PRmVGTfNxlitome9iE=;
        b=F+nWJ9TQWiP2Hym8wd3i7qNMgJOv7A11OYFIA/qKAn2/K7MUUDRuaIOooxQBUG4FKs
         dav2cNm4igNDRpDZFQtVecFIhCS81/2kX/DXCbmib96DnarKNuDyzNdvQafy2idqi1az
         XXEkjtEQWjyCBZX+ma7uzKK7TEI56cT7OnKrKNMe2emD49bE8VohWpfzr5sx2rN/7H+D
         GAnA6bhUzKaZoG8aWCgEXvqi0VdwTz8mD9iBuYMdbcRZ2oO8of5WQ/HqvErpn1S+ABYo
         dO/NlJOBw4EVybkgvaII5zu7Sd2Bm5FfzRpEPbUkq1uWgJmdJWCJDQnFZPxhP4exKYcX
         xTAQ==
X-Gm-Message-State: AOJu0Yy3dJpixamm3BX6n4VcjulUX/YmOYB6WF76WvgCyab8PXPnogn0
	dblnuqVfg5DfrzzT+LncK8ixsbLaicNZOiHy+DEW7NkUKluYv2IrX9kLxZICg5rWXqsbFzZQu2M
	NrDKUczsY/g==
X-Google-Smtp-Source: AGHT+IGE4sESoSO7d1aiFZd77RbLHjpHZRFcOBQ6jKvwm/MjBKaJ9P32X2Ai8mBPTA0bE7PqVs0IQzxYs5c+LA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:250c:b0:6b5:3747:236d with SMTP
 id 6a1803df08f44-6b61d7b8de4mr2644666d6.2.1720570447032; Tue, 09 Jul 2024
 17:14:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 00:14:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710001402.2758273-1-edumazet@google.com>
Subject: [PATCH net] tcp: avoid too many retransmit packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jon Maxwell <jmaxwell37@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"

If a TCP socket is using TCP_USER_TIMEOUT, and the other peer
retracted its window to zero, tcp_retransmit_timer() can
retransmit a packet every two jiffies (2 ms for HZ=1000),
for about 4 minutes after TCP_USER_TIMEOUT has 'expired'.

The fix is to make sure tcp_rtx_probe0_timed_out() takes
icsk->icsk_user_timeout into account.

Before blamed commit, the socket would not timeout after
icsk->icsk_user_timeout, but would use standard exponential
backoff for the retransmits.

Also worth noting that before commit e89688e3e978 ("net: tcp:
fix unexcepted socket die when snd_wnd is 0"), the issue
would last 2 minutes instead of 4.

Fixes: b701a99e431d ("tcp: Add tcp_clamp_rto_to_user_timeout() helper to improve accuracy")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jon Maxwell <jmaxwell37@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>
---
 net/ipv4/tcp_timer.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index db9d826560e57caf8274d1b7253c7af4dd7821a0..892c86657fbc243ce53a939157b77f1fe0410097 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -483,15 +483,26 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 				     const struct sk_buff *skb,
 				     u32 rtx_delta)
 {
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 user_timeout = READ_ONCE(icsk->icsk_user_timeout);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	const int timeout = TCP_RTO_MAX * 2;
+	int timeout = TCP_RTO_MAX * 2;
 	s32 rcv_delta;
 
+	if (user_timeout) {
+		/* If user application specified a TCP_USER_TIMEOUT,
+		 * it does not want win 0 packets to 'reset the timer'
+		 * while retransmits are not making progress.
+		 */
+		if (rtx_delta > user_timeout)
+			return true;
+		timeout = min_t(u32, timeout, msecs_to_jiffies(user_timeout));
+	}
 	/* Note: timer interrupt might have been delayed by at least one jiffy,
 	 * and tp->rcv_tstamp might very well have been written recently.
 	 * rcv_delta can thus be negative.
 	 */
-	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
+	rcv_delta = icsk->icsk_timeout - tp->rcv_tstamp;
 	if (rcv_delta <= timeout)
 		return false;
 
-- 
2.45.2.993.g49e7a77208-goog


