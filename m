Return-Path: <netdev+bounces-117666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6394EB7C
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61FF1F221A2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65797175D4D;
	Mon, 12 Aug 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b="hJvJb5VL"
X-Original-To: netdev@vger.kernel.org
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C60171E68
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460016; cv=none; b=XvKSKkS0Tl1+4a7cKVyozh5+LWiNduDG44oBVWgRwvdPuWb0JlTPQ/Y9FCPixrBf2gDisZEA0GzigRnhtLswGGDx8/cYQexewQmiGuhchcZcRl2WiBgZyrhNw7XNWPyqmW3uUsYCNgwR2ThEjbebGabk0VKarvKY6WQTmqzp4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460016; c=relaxed/simple;
	bh=wR0wsa1jxS7NM44yOEX1X5C5LxaVXsSDx8V1Khp/xis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fzr80g4KunrlNK04yd78y4zobhHh9lJwdZZhAAu21VGho4aWLmOrArzmIbp7YUVobEyHuubwK3w5uyEQJkDgYsEgR5GtmBKNa8sfRA9N/ZcTGDULpPr3j39zI2g0kDqDYyhnw6QipQAUEy71Ja/YhvoWlbWg6UuTkchd75Jbtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me; spf=pass smtp.mailfrom=kuroa.me; dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b=hJvJb5VL; arc=none smtp.client-ip=17.58.23.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuroa.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
	t=1723460014; bh=GoxGXjQ77EFakMA8R6yb540PeO4gE9C9xjuD5Qd8lqs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hJvJb5VLFcL8KLG/53kuUBMKfK6vX5YbdqkTz78qGVpk5VdksNwBK9vsxo5c9jVGU
	 Bvrk87J4imTPZtHFpZBqRrfskGVsj2Ns7uw+hmLzdV1+ulLl2/M63OKF+QG78EnZX9
	 KkFqCEPmpb8anO/CF4e8o5EWCrFOj3RW2rN+TdB3mbvHUefR6pu1WuX222mwsxCAev
	 IjH66P5q8LpjjoC5NTY1oQ/mMU7wJWD4akJXv5Nsz3+KoeLZlkINFcmwHMb8svTABd
	 cJLVmHJEHYpkZ6RnEY+jdpgzxV9DxrN8m0qvc4ePvWZGiRElcx3URDMnqoA88caWvn
	 LNr7UFSWe2FwQ==
Received: from tora.kuroa.me (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id DB7B0801BB;
	Mon, 12 Aug 2024 10:53:30 +0000 (UTC)
From: Xueming Feng <kuro@kuroa.me>
To: "David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	David Ahern <dsahern@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xueming Feng <kuro@kuroa.me>
Subject: [PATCH net,v2] tcp: fix forever orphan socket caused by tcp_abort
Date: Mon, 12 Aug 2024 18:53:15 +0800
Message-Id: <20240812105315.440718-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: W97_O99Ato-ThPpzNUZ4uxAn40X89SYN
X-Proofpoint-ORIG-GUID: W97_O99Ato-ThPpzNUZ4uxAn40X89SYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_02,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=748
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1030
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408120082

We have some problem closing zero-window fin-wait-1 tcp sockets in our 
environment. This patch come from the investigation.

Previously tcp_abort only sends out reset and calls tcp_done when the 
socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only 
purging the write queue, but not close the socket and left it to the 
timer.

While purging the write queue, tp->packets_out and sk->sk_write_queue 
is cleared along the way. However tcp_retransmit_timer have early 
return based on !tp->packets_out and tcp_probe_timer have early 
return based on !sk->sk_write_queue.

This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched 
and socket not being killed by the timers, converting a zero-windowed
orphan into a forever orphan.

This patch removes the SOCK_DEAD check in tcp_abort, making it send 
reset to peer and close the socket accordingly. Preventing the 
timer-less orphan from happening.

According to Lorenzo's email in the v1 thread, the check was there to
prevent force-closing the same socket twice. That situation is handled
by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
already closed.

The -ENOENT code comes from the associate patch Lorenzo made for 
iproute2-ss; link attached below.

Link: https://patchwork.ozlabs.org/project/netdev/patch/1450773094-7978-3-git-send-email-lorenzo@google.com/
Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
Signed-off-by: Xueming Feng <kuro@kuroa.me>
---
 net/ipv4/tcp.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..831a18dc7aa6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4637,6 +4637,13 @@ int tcp_abort(struct sock *sk, int err)
 		/* Don't race with userspace socket closes such as tcp_close. */
 		lock_sock(sk);
 
+	/* Avoid closing the same socket twice. */
+	if (sk->sk_state == TCP_CLOSE) {
+		if (!has_current_bpf_ctx())
+			release_sock(sk);
+		return -ENOENT;
+	}
+
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
 		inet_csk_listen_stop(sk);
@@ -4646,16 +4653,13 @@ int tcp_abort(struct sock *sk, int err)
 	local_bh_disable();
 	bh_lock_sock(sk);
 
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		if (tcp_need_reset(sk->sk_state))
-			tcp_send_active_reset(sk, GFP_ATOMIC,
-					      SK_RST_REASON_NOT_SPECIFIED);
-		tcp_done_with_error(sk, err);
-	}
+	if (tcp_need_reset(sk->sk_state))
+		tcp_send_active_reset(sk, GFP_ATOMIC,
+				      SK_RST_REASON_NOT_SPECIFIED);
+	tcp_done_with_error(sk, err);
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
-	tcp_write_queue_purge(sk);
 	if (!has_current_bpf_ctx())
 		release_sock(sk);
 	return 0;
-- 

