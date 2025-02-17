Return-Path: <netdev+bounces-167119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40051A38F9D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABD9167188
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEDD1AB52D;
	Mon, 17 Feb 2025 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohWY8NuK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB6748F
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834952; cv=none; b=PTgU8IBL977ielJzp0lfOqrhWDoD2VU/2Gu0gC1u1dRv98yYyF7cFahiefD2aQqbPsyUjdog0b/wKHno70w48ItNFL+jSJu6sz9quIWFMy/J0H7+QGIHs+H2xB+i4TqRY2F0JZBVcHhPtPy2rq4n7/EofUzbY6FvoR0BON5cQh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834952; c=relaxed/simple;
	bh=1QqkMKImrgTk+211miObdXeKXJgVmgB3hWwtaCw6934=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCVXN8AOa5esFLcmGelWWgEA5WqMe+UIvH6LG4FCLrX1wVDhZBD7FYQNK3aV9IYmGxBMZeJc+Wj0eMTR9NJFf41W52nQipidu1F4evDUOWN4LHqhZ+v9arOGmpw3WAoRaHKV0hWxnF4swWRFlhrWfYtuhd0LXZmdcPDNBpJqA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohWY8NuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB72C4CED1;
	Mon, 17 Feb 2025 23:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739834951;
	bh=1QqkMKImrgTk+211miObdXeKXJgVmgB3hWwtaCw6934=;
	h=From:To:Cc:Subject:Date:From;
	b=ohWY8NuKnibKQo5QOli5AUv4toOeKY82IzKtICHj/i2cebXVTcMvVTzNw2nu1IPOq
	 DNnUNGh1yP+YxYPWzoVMkYwFLCufQEcR6XuQgP98Yxo3/gSZLWWG73yM2tg96SkoRG
	 znjK57EmsotSRmaT5W+1tKO1dZ0eulmRD5wgyWUBvEwTjCv+yUgqfm1X7/hAoBNCl3
	 1aWHFVtDgCi0JeCdQX17Ri7t2lCAQpL2HZOfC4qgjNdF3MYeQm9tGH3HPZRuIqUqWO
	 AVmiQIYVOX4hRNVsQUqZqqwXhOu/u1LCMCbOFbgEySKa4la7HivVSyt+rFCob2mQmX
	 Aoyy/jp+dytKg==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ncardwell@google.com,
	kuniyu@amazon.com,
	hli@netflix.com,
	quic_stranche@quicinc.com,
	quic_subashab@quicinc.com
Subject: [PATCH net] tcp: adjust rcvq_space after updating scaling ratio
Date: Mon, 17 Feb 2025 15:29:05 -0800
Message-ID: <20250217232905.3162187-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit under Fixes we set the window clamp in accordance
to newly measured rcvbuf scaling_ratio. If the scaling_ratio
decreased significantly we may put ourselves in a situation
where windows become smaller than rcvq_space, preventing
tcp_rcv_space_adjust() from increasing rcvbuf.

The significant decrease of scaling_ratio is far more likely
since commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio"),
which increased the "default" scaling ratio from ~30% to 50%.

Hitting the bad condition depends a lot on TCP tuning, and
drivers at play. One of Meta's workloads hits it reliably
under following conditions:
 - default rcvbuf of 125k
 - sender MTU 1500, receiver MTU 5000
 - driver settles on scaling_ratio of 78 for the config above.
Initial rcvq_space gets calculated as TCP_INIT_CWND * tp->advmss
(10 * 5k = 50k). Once we find out the true scaling ratio and
MSS we clamp the windows to 38k. Triggering the condition also
depends on the message sequence of this workload. I can't repro
the problem with simple iperf or TCP_RR-style tests.

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ncardwell@google.com
CC: kuniyu@amazon.com
CC: hli@netflix.com
CC: quic_stranche@quicinc.com
CC: quic_subashab@quicinc.com
---
 net/ipv4/tcp_input.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 074406890552..6467716820ff 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -243,9 +243,15 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 			do_div(val, skb->truesize);
 			tcp_sk(sk)->scaling_ratio = val ? val : 1;
 
-			if (old_ratio != tcp_sk(sk)->scaling_ratio)
-				WRITE_ONCE(tcp_sk(sk)->window_clamp,
-					   tcp_win_from_space(sk, sk->sk_rcvbuf));
+			if (old_ratio != tcp_sk(sk)->scaling_ratio) {
+				struct tcp_sock *tp = tcp_sk(sk);
+
+				val = tcp_win_from_space(sk, sk->sk_rcvbuf);
+				tcp_set_window_clamp(sk, val);
+
+				if (tp->window_clamp < tp->rcvq_space.space)
+					tp->rcvq_space.space = tp->window_clamp;
+			}
 		}
 		icsk->icsk_ack.rcv_mss = min_t(unsigned int, len,
 					       tcp_sk(sk)->advmss);
-- 
2.48.1


