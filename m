Return-Path: <netdev+bounces-233503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC39C147EF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB7A624117
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6765A31A57F;
	Tue, 28 Oct 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5tu+un5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C931A57A;
	Tue, 28 Oct 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652705; cv=none; b=hyLuugxraY7bPNb0UGpzselrdPK95+BbU+Ju7YEHaXjALWE6TTG9vqBJU5/d2yf1UjQCN/wfAFp/Fal4FX1voPGRtxJ8i5ooL+PdXsmdkzHRjzDafjRUmk4QsuXUMWmJwbAE9fUsmtkX0MPCjtUrwMheQ0qHXkgACGrYRuoB1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652705; c=relaxed/simple;
	bh=GmHXkdInkwrHHB/fwx6KL5afGG/UEzE3X5JMsjJco6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpyCjFrG9Lj3FVWzK9YLk8I7ogCv3t+2U+cub6ksqcAmwBXXdY6YOdbhyAOJ5Ymdwz2/QjuFKEO05+t76ykzTbWieR8srsgaSULU+lufv7vgtR3LzKki1dX5DVszxwUvvS3C7sfVspqIRmQeZNMiZ2IN4m8FFB8gsfYlaMYdz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5tu+un5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F2AC4CEE7;
	Tue, 28 Oct 2025 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761652704;
	bh=GmHXkdInkwrHHB/fwx6KL5afGG/UEzE3X5JMsjJco6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p5tu+un5af7ooxSB3AUPMJ2Yr0lOwUut9mirp3q1nYyebICWrUHh77iNWS/8rFgGx
	 9Ecs+fWl0yswAVGaJt945EUO7ZWzSVpAvmOIZNjbhquIhshVOkm1FESP3Qn76RycHn
	 Xi2TT5x/tNR8lpXXontQdu9M6ioGk3H7ViPdTl35Jjl8DKRQ7oS5fAP4ubx4C9VjKm
	 3x4ahhTMxODX5OMYPjczb4Wvp5uPaW9vP2OHjVP17V7R6VOVaGjA1oRbXLidmBq0a1
	 efMaGNPaZ4WIsOkv2tBNHfrEeJqeanHZPCNuK8/CEDobXG6u7OoCqFWhrAwzZrY6QS
	 7+t78T0MT4MRA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Oct 2025 12:58:02 +0100
Subject: [PATCH net v3 4/4] tcp: fix too slow tcp_rcvbuf_grow() action
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-net-tcp-recv-autotune-v3-4-74b43ba4c84c@kernel.org>
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12065; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=h92uSafpnw8i/Qp5co+OjVSTK8rmje1D218J6OdeVuA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZ1l9cWqOeHsMu9H8Tf9ULa9ar95Wk9B8WqL3L8gspF
 eU40SPSUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJGaMEaGH6ldWzZ1xnK966ya
 dLws/peUX3F2O59cP9PW/euW2izNZfgft0B1/fNrtab2JpkCkavT5Jf4muTcXZBl2MA482f1MzU
 eAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Eric Dumazet <edumazet@google.com>

While the blamed commits apparently avoided an overshoot,
they also limited how fast a sender can increase BDP at each RTT.

This is not exactly a revert, we do not add the 16 * tp->advmss
cushion we had, and we are keeping the out_of_order_queue
contribution.

Do the same in mptcp_rcvbuf_grow().

Tested:

emulated 50ms rtt (tcp_stream --tcp-tx-delay 50000), cubic 20 second flow.
net.ipv4.tcp_rmem set to "4096 131072 67000000"

perf record -a -e tcp:tcp_rcvbuf_grow sleep 20
perf script

Before:

We can see we fail to roughly double RWIN at each RTT.
Sender is RWIN limited while CWND is ramping up (before getting tcp_wmem
limited).

tcp_stream 33793 [010]  825.717525: tcp:tcp_rcvbuf_grow: time=100869 rtt_us=50428 copied=49152 inq=0 space=40960 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=103970 window_clamp=112128 rcv_wnd=106496
tcp_stream 33793 [010]  825.768966: tcp:tcp_rcvbuf_grow: time=51447 rtt_us=50362 copied=86016 inq=0 space=49152 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=107474 window_clamp=112128 rcv_wnd=106496
tcp_stream 33793 [010]  825.821539: tcp:tcp_rcvbuf_grow: time=52577 rtt_us=50243 copied=114688 inq=0 space=86016 ooo=0 scaling_ratio=219 rcvbuf=201096 rcv_ssthresh=167377 window_clamp=172031 rcv_wnd=167936
tcp_stream 33793 [010]  825.871781: tcp:tcp_rcvbuf_grow: time=50248 rtt_us=50237 copied=167936 inq=0 space=114688 ooo=0 scaling_ratio=219 rcvbuf=268129 rcv_ssthresh=224722 window_clamp=229375 rcv_wnd=225280
tcp_stream 33793 [010]  825.922475: tcp:tcp_rcvbuf_grow: time=50698 rtt_us=50183 copied=241664 inq=0 space=167936 ooo=0 scaling_ratio=219 rcvbuf=392617 rcv_ssthresh=331217 window_clamp=335871 rcv_wnd=323584
tcp_stream 33793 [010]  825.973326: tcp:tcp_rcvbuf_grow: time=50855 rtt_us=50213 copied=339968 inq=0 space=241664 ooo=0 scaling_ratio=219 rcvbuf=564986 rcv_ssthresh=478674 window_clamp=483327 rcv_wnd=462848
tcp_stream 33793 [010]  826.023970: tcp:tcp_rcvbuf_grow: time=50647 rtt_us=50248 copied=491520 inq=0 space=339968 ooo=0 scaling_ratio=219 rcvbuf=794811 rcv_ssthresh=671778 window_clamp=679935 rcv_wnd=651264
tcp_stream 33793 [010]  826.074612: tcp:tcp_rcvbuf_grow: time=50648 rtt_us=50227 copied=700416 inq=0 space=491520 ooo=0 scaling_ratio=219 rcvbuf=1149124 rcv_ssthresh=974881 window_clamp=983039 rcv_wnd=942080
tcp_stream 33793 [010]  826.125452: tcp:tcp_rcvbuf_grow: time=50845 rtt_us=50225 copied=987136 inq=8192 space=700416 ooo=0 scaling_ratio=219 rcvbuf=1637502 rcv_ssthresh=1392674 window_clamp=1400831 rcv_wnd=1339392
tcp_stream 33793 [010]  826.175698: tcp:tcp_rcvbuf_grow: time=50250 rtt_us=50198 copied=1347584 inq=0 space=978944 ooo=0 scaling_ratio=219 rcvbuf=2288672 rcv_ssthresh=1949729 window_clamp=1957887 rcv_wnd=1945600
tcp_stream 33793 [010]  826.225947: tcp:tcp_rcvbuf_grow: time=50252 rtt_us=50240 copied=1945600 inq=0 space=1347584 ooo=0 scaling_ratio=219 rcvbuf=3150516 rcv_ssthresh=2687010 window_clamp=2695167 rcv_wnd=2691072
tcp_stream 33793 [010]  826.276175: tcp:tcp_rcvbuf_grow: time=50233 rtt_us=50224 copied=2691072 inq=0 space=1945600 ooo=0 scaling_ratio=219 rcvbuf=4548617 rcv_ssthresh=3883041 window_clamp=3891199 rcv_wnd=3887104
tcp_stream 33793 [010]  826.326403: tcp:tcp_rcvbuf_grow: time=50233 rtt_us=50229 copied=3887104 inq=0 space=2691072 ooo=0 scaling_ratio=219 rcvbuf=6291456 rcv_ssthresh=5370482 window_clamp=5382144 rcv_wnd=5373952
tcp_stream 33793 [010]  826.376723: tcp:tcp_rcvbuf_grow: time=50323 rtt_us=50218 copied=5373952 inq=0 space=3887104 ooo=0 scaling_ratio=219 rcvbuf=9087658 rcv_ssthresh=7755537 window_clamp=7774207 rcv_wnd=7757824
tcp_stream 33793 [010]  826.426991: tcp:tcp_rcvbuf_grow: time=50274 rtt_us=50196 copied=7757824 inq=180224 space=5373952 ooo=0 scaling_ratio=219 rcvbuf=12563759 rcv_ssthresh=10729233 window_clamp=10747903 rcv_wnd=10575872
tcp_stream 33793 [010]  826.477229: tcp:tcp_rcvbuf_grow: time=50241 rtt_us=50078 copied=10731520 inq=180224 space=7577600 ooo=0 scaling_ratio=219 rcvbuf=17715667 rcv_ssthresh=15136529 window_clamp=15155199 rcv_wnd=14983168
tcp_stream 33793 [010]  826.527482: tcp:tcp_rcvbuf_grow: time=50258 rtt_us=50153 copied=15138816 inq=360448 space=10551296 ooo=0 scaling_ratio=219 rcvbuf=24667870 rcv_ssthresh=21073410 window_clamp=21102591 rcv_wnd=20766720
tcp_stream 33793 [010]  826.577712: tcp:tcp_rcvbuf_grow: time=50234 rtt_us=50228 copied=21073920 inq=0 space=14778368 ooo=0 scaling_ratio=219 rcvbuf=34550339 rcv_ssthresh=29517041 window_clamp=29556735 rcv_wnd=29519872
tcp_stream 33793 [010]  826.627982: tcp:tcp_rcvbuf_grow: time=50275 rtt_us=50220 copied=29519872 inq=540672 space=21073920 ooo=0 scaling_ratio=219 rcvbuf=49268707 rcv_ssthresh=42090625 window_clamp=42147839 rcv_wnd=41627648
tcp_stream 33793 [010]  826.678274: tcp:tcp_rcvbuf_grow: time=50296 rtt_us=50185 copied=42053632 inq=761856 space=28979200 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57238168 window_clamp=57316406 rcv_wnd=56606720
tcp_stream 33793 [010]  826.728627: tcp:tcp_rcvbuf_grow: time=50357 rtt_us=50128 copied=43913216 inq=851968 space=41291776 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56524800
tcp_stream 33793 [010]  827.131364: tcp:tcp_rcvbuf_grow: time=50239 rtt_us=50127 copied=43843584 inq=655360 space=43061248 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56696832
tcp_stream 33793 [010]  827.181613: tcp:tcp_rcvbuf_grow: time=50254 rtt_us=50115 copied=43843584 inq=524288 space=43188224 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56807424
tcp_stream 33793 [010]  828.339635: tcp:tcp_rcvbuf_grow: time=50283 rtt_us=50110 copied=43843584 inq=458752 space=43319296 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56864768
tcp_stream 33793 [010]  828.440350: tcp:tcp_rcvbuf_grow: time=50404 rtt_us=50099 copied=43843584 inq=393216 space=43384832 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56922112
tcp_stream 33793 [010]  829.195106: tcp:tcp_rcvbuf_grow: time=50154 rtt_us=50077 copied=43843584 inq=196608 space=43450368 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=57090048

After:

It takes few steps to increase RWIN. Sender is no longer RWIN limited.

tcp_stream 50826 [010]  935.634212: tcp:tcp_rcvbuf_grow: time=100788 rtt_us=50315 copied=49152 inq=0 space=40960 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=103970 window_clamp=112128 rcv_wnd=106496
tcp_stream 50826 [010]  935.685642: tcp:tcp_rcvbuf_grow: time=51437 rtt_us=50361 copied=86016 inq=0 space=49152 ooo=0 scaling_ratio=219 rcvbuf=160875 rcv_ssthresh=132969 window_clamp=137623 rcv_wnd=131072
tcp_stream 50826 [010]  935.738299: tcp:tcp_rcvbuf_grow: time=52660 rtt_us=50256 copied=139264 inq=0 space=86016 ooo=0 scaling_ratio=219 rcvbuf=502741 rcv_ssthresh=411497 window_clamp=430079 rcv_wnd=413696
tcp_stream 50826 [010]  935.788544: tcp:tcp_rcvbuf_grow: time=50249 rtt_us=50233 copied=307200 inq=0 space=139264 ooo=0 scaling_ratio=219 rcvbuf=728690 rcv_ssthresh=618717 window_clamp=623371 rcv_wnd=618496
tcp_stream 50826 [010]  935.838796: tcp:tcp_rcvbuf_grow: time=50258 rtt_us=50202 copied=618496 inq=0 space=307200 ooo=0 scaling_ratio=219 rcvbuf=2450338 rcv_ssthresh=1855709 window_clamp=2096187 rcv_wnd=1859584
tcp_stream 50826 [010]  935.889140: tcp:tcp_rcvbuf_grow: time=50347 rtt_us=50166 copied=1261568 inq=0 space=618496 ooo=0 scaling_ratio=219 rcvbuf=4376503 rcv_ssthresh=3725291 window_clamp=3743961 rcv_wnd=3706880
tcp_stream 50826 [010]  935.939435: tcp:tcp_rcvbuf_grow: time=50300 rtt_us=50185 copied=2478080 inq=24576 space=1261568 ooo=0 scaling_ratio=219 rcvbuf=9082648 rcv_ssthresh=7733731 window_clamp=7769921 rcv_wnd=7692288
tcp_stream 50826 [010]  935.989681: tcp:tcp_rcvbuf_grow: time=50251 rtt_us=50221 copied=4915200 inq=114688 space=2453504 ooo=0 scaling_ratio=219 rcvbuf=16574936 rcv_ssthresh=14108110 window_clamp=14179339 rcv_wnd=14024704
tcp_stream 50826 [010]  936.039967: tcp:tcp_rcvbuf_grow: time=50289 rtt_us=50279 copied=9830400 inq=114688 space=4800512 ooo=0 scaling_ratio=219 rcvbuf=32695050 rcv_ssthresh=27896187 window_clamp=27969593 rcv_wnd=27815936
tcp_stream 50826 [010]  936.090172: tcp:tcp_rcvbuf_grow: time=50211 rtt_us=50200 copied=19841024 inq=114688 space=9715712 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57245176 window_clamp=57316406 rcv_wnd=57163776
tcp_stream 50826 [010]  936.140430: tcp:tcp_rcvbuf_grow: time=50262 rtt_us=50197 copied=39501824 inq=114688 space=19726336 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57245176 window_clamp=57316406 rcv_wnd=57163776
tcp_stream 50826 [010]  936.190527: tcp:tcp_rcvbuf_grow: time=50101 rtt_us=50071 copied=43655168 inq=262144 space=39387136 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57032704
tcp_stream 50826 [010]  936.240719: tcp:tcp_rcvbuf_grow: time=50197 rtt_us=50057 copied=43843584 inq=262144 space=43393024 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57032704
tcp_stream 50826 [010]  936.341271: tcp:tcp_rcvbuf_grow: time=50297 rtt_us=50123 copied=43843584 inq=131072 space=43581440 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57147392
tcp_stream 50826 [010]  936.642503: tcp:tcp_rcvbuf_grow: time=50131 rtt_us=50084 copied=43843584 inq=0 space=43712512 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57262080

Fixes: 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
Reported-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/589
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/tcp_input.c | 11 +++++++++--
 net/mptcp/protocol.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cb4e07f84ae2..e4a979b75cc6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -895,17 +895,24 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 rcvwin, rcvbuf, cap;
+	u32 rcvwin, rcvbuf, cap, oldval;
+	u64 grow;
 
+	oldval = tp->rcvq_space.space;
 	tp->rcvq_space.space = newval;
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
 	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
 		return;
 
-	/* slow start: allow the sender to double its rate. */
+	/* DRS is always one RTT late. */
 	rcvwin = newval << 1;
 
+	/* slow start: allow the sender to double its rate. */
+	grow = (u64)rcvwin * (newval - oldval);
+	do_div(grow, oldval);
+	rcvwin += grow << 1;
+
 	if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
 		rcvwin += TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp->rcv_nxt;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 052a0c62023f..875027b9319c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -198,15 +198,23 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct net *net = sock_net(sk);
-	u32 rcvwin, rcvbuf, cap;
+	u32 rcvwin, rcvbuf, cap, oldval;
+	u64 grow;
 
+	oldval = msk->rcvq_space.space;
 	msk->rcvq_space.space = newval;
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
 	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
 		return false;
 
+	/* DRS is always one RTT late. */
 	rcvwin = newval << 1;
 
+	/* slow start: allow the sender to double its rate. */
+	grow = (u64)rcvwin * (newval - oldval);
+	do_div(grow, oldval);
+	rcvwin += grow << 1;
+
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
 		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
 

-- 
2.51.0


