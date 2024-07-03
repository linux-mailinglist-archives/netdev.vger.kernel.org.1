Return-Path: <netdev+bounces-108985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C289266DC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472A71F22C8C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49DE18412E;
	Wed,  3 Jul 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq7EHaq1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32F170836
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026777; cv=none; b=cV6QnEY9ulEGEj7Ek2mL6eOWclR0FDjlWy1jyiZSXzzGxwdpMKEh8A2OsePZ8aaS0lLoBUZv+HzJ8+zwwPicx2nuigsgaPQUskXvY/XK/EhvJNLH1Bmo9bpieJjbXMmfNlWCO29X5LAaRffBAfZXQ8db+vqwAHERRJ1AwPfs53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026777; c=relaxed/simple;
	bh=4zYxsmwtSfQegBJvIWUBl8jS6cwFqlCqnX8WofKHBWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEmR9s7Qhu+XYGX4nkJZ+VBA+ghHXafKOItoPbTWMzZNfqoSp694oYCdmKC+/Y/UWh4v/BIlXAWEU1GBw3hs1Uk/nlqoQ5xZ8FNmUBXu2KtJqD56xx/aBsE+Cajra8Mvq8adDHQd/IaUPAcCpC69q8qlki+FFuV0BP5s1LgYZ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq7EHaq1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b553b1a159so27825956d6.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026775; x=1720631575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7tilZMfw+7+bPaghY6cWnvgwdBZycDiSBcjMRdhX6E=;
        b=fq7EHaq19tbra8zcMUIVGlqEd+Q9VbpB3CZnL7LCMVme6h+pemhekVd6lmM9ZhcQoH
         sgp6LLttwi7x6i89+osNhy0KDFHOssM/yS4bvEj1h+0UzZge3w1UU3EgSo0CKY11L0IO
         ETyf18PfvJrxs3DOcLWkjF9XFhG2VpBxkqyeviBfuDD/F15x2j6IswLeTjXzsZE8AC7Y
         3tEBnjsBv6TVwbR1OIXQRVi7+0bJefW/VlNBeEgPM785wGyLOhPqQ28PsXitoV5W1vwX
         i+vOo48V/eYhvJRKX/8SY6poW2Ss/T6/ovysd8WkBIF93DyHzLCnfY15su79ugCKkj08
         MY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026775; x=1720631575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7tilZMfw+7+bPaghY6cWnvgwdBZycDiSBcjMRdhX6E=;
        b=fjbaKk7e1VJiAlyuZxZ5KdvPsFGW18w7EEtJui3jjY3yyz/bTiJxLKyDFMVPbWBvYm
         pHQrJcaNpsTKEopESkz4cb++f/M0bk7uw0GiFquIgZChewSR6przj+x3vfR8uXIDqzAL
         r4AVtYFISt+25ntNDOZ/CTboP54PJtHHF8KH/v8f2s1GIp6mY6S++ena6cYsaKDTVfqp
         nNNjrG8RbhInucUSDX/gO+fjniWt+jNQFKF9RIQMMcEKYZJ0JCEd9tm8tT1prc4S/+8W
         IVXeFMi3HaPqlKM5y/G/IbBkaNh2PwRUtl0taZQUOS/nH5tBpeYrBrGcsHOjaZPdd4NU
         8bwg==
X-Gm-Message-State: AOJu0YzfbcrhkXIy0V+sGcVYQlqdUVosGFTA6oDNeweyXOOdRse7FdyF
	L1HRSv7zoiBlGVbO2UcR34gCeZnaRmEkJYZA2byos8U9lEgn9q3k
X-Google-Smtp-Source: AGHT+IGDM9l66OHZQrEkeWVCovZsblEF6TCNGX+25fi88SngYwyGSaCznAxYw5+pWNkwrdbafKT+iw==
X-Received: by 2002:a05:6214:acc:b0:6b5:7e0b:eafb with SMTP id 6a1803df08f44-6b5b70b3adamr165115056d6.24.1720026774842;
        Wed, 03 Jul 2024 10:12:54 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:416:bf16:dffd:c26a:4ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5746f5sm55533856d6.52.2024.07.03.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:12:54 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Kevin Yang <yyd@google.com>
Subject: [PATCH net] tcp: fix incorrect undo caused by DSACK of TLP retransmit
Date: Wed,  3 Jul 2024 13:12:46 -0400
Message-ID: <20240703171246.1739561-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

Loss recovery undo_retrans bookkeeping had a long-standing bug where a
DSACK from a spurious TLP retransmit packet could cause an erroneous
undo of a fast recovery or RTO recovery that repaired a single
really-lost packet (in a sequence range outside that of the TLP
retransmit). Basically, because the loss recovery state machine didn't
account for the fact that it sent a TLP retransmit, the DSACK for the
TLP retransmit could erroneously be implicitly be interpreted as
corresponding to the normal fast recovery or RTO recovery retransmit
that plugged a real hole, thus resulting in an improper undo.

For example, consider the following buggy scenario where there is a
real packet loss but the congestion control response is improperly
undone because of this bug:

+ send packets P1, P2, P3, P4
+ P1 is really lost
+ send TLP retransmit of P4
+ receive SACK for original P2, P3, P4
+ enter fast recovery, fast-retransmit P1, increment undo_retrans to 1
+ receive DSACK for TLP P4, decrement undo_retrans to 0, undo (bug!)
+ receive cumulative ACK for P1-P4 (fast retransmit plugged real hole)

The fix: when we initialize undo machinery in tcp_init_undo(), if
there is a TLP retransmit in flight, then increment tp->undo_retrans
so that we make sure that we receive a DSACK corresponding to the TLP
retransmit, as well as DSACKs for all later normal retransmits, before
triggering a loss recovery undo. Note that we also have to move the
line that clears tp->tlp_high_seq for RTO recovery, so that upon RTO
we remember the tp->tlp_high_seq value until tcp_init_undo() and clear
it only afterward.

Also note that the bug dates back to the original 2013 TLP
implementation, commit 6ba8a3b19e76 ("tcp: Tail loss probe (TLP)").

However, this patch will only compile and work correctly with kernels
that have tp->tlp_retrans, which was added only in v5.8 in 2020 in
commit 76be93fc0702 ("tcp: allow at most one TLP probe per flight").
So we associate this fix with that later commit.

Fixes: 76be93fc0702 ("tcp: allow at most one TLP probe per flight")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Kevin Yang <yyd@google.com>
---
 net/ipv4/tcp_input.c | 11 ++++++++++-
 net/ipv4/tcp_timer.c |  2 --
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e67cbeeeb95b..3d8f597989e3 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2129,8 +2129,16 @@ void tcp_clear_retrans(struct tcp_sock *tp)
 static inline void tcp_init_undo(struct tcp_sock *tp)
 {
 	tp->undo_marker = tp->snd_una;
+
 	/* Retransmission still in flight may cause DSACKs later. */
-	tp->undo_retrans = tp->retrans_out ? : -1;
+	/* First, account for regular retransmits in flight: */
+	tp->undo_retrans = tp->retrans_out;
+	/* Next, account for TLP retransmits in flight: */
+	if (tp->tlp_high_seq && tp->tlp_retrans)
+		tp->undo_retrans++;
+	/* Finally, avoid 0, because undo_retrans==0 means "can undo now": */
+	if (!tp->undo_retrans)
+		tp->undo_retrans = -1;
 }
 
 static bool tcp_is_rack(const struct sock *sk)
@@ -2209,6 +2217,7 @@ void tcp_enter_loss(struct sock *sk)
 
 	tcp_set_ca_state(sk, TCP_CA_Loss);
 	tp->high_seq = tp->snd_nxt;
+	tp->tlp_high_seq = 0;
 	tcp_ecn_queue_cwr(tp);
 
 	/* F-RTO RFC5682 sec 3.1 step 1: retransmit SND.UNA if no previous
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 5bfd76a31af6..db9d826560e5 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -536,8 +536,6 @@ void tcp_retransmit_timer(struct sock *sk)
 	if (WARN_ON_ONCE(!skb))
 		return;
 
-	tp->tlp_high_seq = 0;
-
 	if (!tp->snd_wnd && !sock_flag(sk, SOCK_DEAD) &&
 	    !((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))) {
 		/* Receiver dastardly shrinks window. Our retransmits
-- 
2.45.2.803.g4e1b14247a-goog


