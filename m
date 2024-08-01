Return-Path: <netdev+bounces-114902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A4944A31
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6134E283070
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279C189506;
	Thu,  1 Aug 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b="UkE/GelL"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52648F70
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511066; cv=none; b=WqkfwMbO/yfSTJ5rZFhl3PZD4nLT4AhwsbjnkifKTCh2TgTr8mwJ4dRbprAJYX/sUk74nPf0z0kyJKlYfGQAM93BW/VJJfjTpZt4Q+pmmZvEP08ZxHBl4+J8ZoBzZHy4zdElWERfp59JDnSvxzR16h2YlEcr8R/CqcPoyi4W80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511066; c=relaxed/simple;
	bh=6Rjdv9cN+C1x828yRZnFLhlrKUpcUdBdEsHE08HCOI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VsYzIcfcKcTEtxI/3c+yt3N+VrT6NhZiGEtIWFtOjDsOXEe/ClbLyXK6r3+WCcP/IzU+mMB8iPXKqgzBHgfaTjc6VCtnXVSu8YmcZgjeOI+oL+fVvGZgNYkrtcKskElZddElLH6+kjy/z8HLcBUvV2OyJmJlkEEUrnfpWwhRewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me; spf=pass smtp.mailfrom=kuroa.me; dkim=pass (2048-bit key) header.d=kuroa.me header.i=@kuroa.me header.b=UkE/GelL; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuroa.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuroa.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
	t=1722511063; bh=nafx2xZo5f/3TQNO/oXcNrVdUT6Ohz4/FtnM/r3zZKM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UkE/GelLlYo9LcjDYeQue9O2wrPolsBdq+Um60k/fkcL8rmVaeK0GP1kN3yCNAdOg
	 YIdAvgdt2+y0Hmncupxhid2y676AZNBxDBuR8KHV6QurIVzA8wxUkNutD+k598Flae
	 R0+oObwh84MWIBXBnhvRDvl4UjLBBgXLzYOclovXfMvydGhHqDAMl1xXkcDJ07Soap
	 ORSM8A0mbcLEr+01Ofkxe0I2AJ3F+fjp0xlNyhUYJ3oug45Yq3SBrXCmY3lJEhWu+9
	 Vuzcj+c7bEj2iAvAMLrMCwY192/4D45J+QSHYNUFMANf/cFpTd7Xkkhye+UIWcvhZw
	 yA7uY7mlKG66w==
Received: from tora.kuroa.me (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id CD07768030E;
	Thu,  1 Aug 2024 11:17:36 +0000 (UTC)
From: Xueming Feng <kuro@kuroa.me>
To: "David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	David Ahern <dsahern@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xueming Feng <kuro@kuroa.me>
Subject: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
Date: Thu,  1 Aug 2024 19:16:11 +0800
Message-Id: <20240801111611.84743-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sY5AdWyyhAf90taChUuqDIlPf_TtDWME
X-Proofpoint-GUID: sY5AdWyyhAf90taChUuqDIlPf_TtDWME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 clxscore=1030
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=509
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408010071

We have some problem closing zero-window fin-wait-1 tcp sockets in our 
environment. This patch come from the investigation.

Previously tcp_abort only sends out reset and calls tcp_done when the 
socket is not SOCK_DEAD aka. orphan. For orphan socket, it will only 
purging the write queue, but not close the socket and left it to the 
timer.

While purging the write queue, tp->packets_out and sk->sk_write_queue 
is cleared along the way. However tcp_retransmit_timer have early 
return based on !tp->packets_out and tcp_probe_timer have early 
return based on !sk->sk_write_queue.

This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched 
and socket not being killed by the timers. Converting a zero-windowed
orphan to a forever orphan.

This patch removes the SOCK_DEAD check in tcp_abort, making it send 
reset to peer and close the socket accordingly. Preventing the 
timer-less orphan from happening.

Fixes: e05836ac07c7 ("tcp: purge write queue upon aborting the connection")
Fixes: bffd168c3fc5 ("tcp: clear tp->packets_out when purging write queue")
Signed-off-by: Xueming Feng <kuro@kuroa.me>
---
 net/ipv4/tcp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..65e8d28d15b1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4646,12 +4646,10 @@ int tcp_abort(struct sock *sk, int err)
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
+					SK_RST_REASON_NOT_SPECIFIED);
+	tcp_done_with_error(sk, err);
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
-- 
2.39.2


