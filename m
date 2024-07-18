Return-Path: <netdev+bounces-112049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E0F934BC2
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A991C21A87
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A89138490;
	Thu, 18 Jul 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKqDCuj7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFB137757;
	Thu, 18 Jul 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298864; cv=none; b=d4EhzbGasFAAYKGmLtHWiFn+ASTNcTtgguPi0gnjiz59SeVNzf6vKcB+NEMxFhyKEc5gr5n7BaFDVaphDCtmmqUb7a0eIIPgKDVg9RLx3TnaqLObn1FeAAelK+czLHVi17vfXjGeHYr0Nm+YJAeFb/mk1JoZQx3V4YaS6eZDpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298864; c=relaxed/simple;
	bh=v7Pr56rb4xW7zvxZmarCh7nw1f560R1oMhklrIazOeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4ILnWQcUQ1PfP07yQjG2yX4BsluX+eHA7etSmDSyZRxyIzjyAk63pnO0cmvXhFUThk0nk9rn8CElbVROYjQ7nuEbNqtj/3zATGs9JQVOaK7TSvYnIa0qni2X+MW9DenvrRkEj2g11AJWTwXqD+2+AobDzV2ricQW21OsAq9c9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKqDCuj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE7FC4AF0B;
	Thu, 18 Jul 2024 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721298864;
	bh=v7Pr56rb4xW7zvxZmarCh7nw1f560R1oMhklrIazOeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sKqDCuj7vairxNbQPltODvUeuzLbGkak3VzLKCjEmH+38l/yuYGwkZbJrGgeo5Wff
	 wh72k2oEze/hVvbdO0BCrj/N9dKAew0GojI+Lfc8o+PlAt6DIuYLXuIqjR5VyPiW7+
	 LqpJ4/EO/3e/sw+H50FsuCAFPaUib7LGe4qyIWOygb++nd2c9XbhA8GLduzROWbJZl
	 lsBBbJlar9WHdntLMdf3RVbgNy8S2w80oPnmiQgDvBbLJ1n4MoZeDvrGVH3VpBNC4V
	 LK2C/AdoUUqcCXFJ9p0rVKwnGOpzLHJJGiPdemTsI24+DtsTfdiBrDLDIryebdb+5B
	 GY2Yf70N0db7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 12:33:57 +0200
Subject: [PATCH net v2 2/2] tcp: limit wake-up for crossed SYN cases to
 SYN-ACK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org>
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
In-Reply-To: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Jerry Chu <hkchu@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=v7Pr56rb4xW7zvxZmarCh7nw1f560R1oMhklrIazOeo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmO+oidQcOp7WgYYSyX0/O0xhsCh4ZAUIQ/Csp
 VR244lKzdiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpjvqAAKCRD2t4JPQmmg
 c7YpEACM79BFPN8vnPh61+T9XVJery417L0PZFZC76xymxb86ifiBMSdUFX3DRbWimOqNVLNnJA
 i1cWVRtdRUn1BU+0YVLcBtbnmY1CIPFBoLEIhiSMW2e8dqg/Uyux7moGMqzDS5nGb6CYknxr/ev
 hhzNbfiVAwk6vgSON563xkDnd+MfBe7Ywny8IOOPECyHm66flOOZU3QQ6WoZIGkKztVMNNdnCrU
 nmLZH0+/BPUi1QcZAl7jOOhJYklJLOmXMguctdumWbDIiqoEK98mjGR1HIIFgEO8PGocWxTKfGd
 ko7s+jryLrZzfadLCn14hpMPKcwvgGoe335ylaCNHs+EljLu0UQDj3R5bmJhURnUlrT7YkFLOJ6
 BGBdTqIMrpwLOrjZfBhgGO+pCa0/KCY6gwP3OOtuTQUdz+zGYPcoRuFIe59GyWlD9kFYv072VdB
 B692ywT6+dxFxvz+jjKD5409VHapq8iiaju9W56FZyY9goqZR1beuQRt0c/2+X9ib78MrcT6rEd
 0QMpPFHMrelqg6mBNHWJBbFjG8uxQfPnAve329yXPtnxHCQSw0B7qR4/xTqt7WHHGX8USO4kjDu
 o/5uW02imOuLrc2M0SUU7tw/aYf9BVGiZI/sO5lRRxwukUc8LnBVuzjLqSD8z/Fp7mBnHgHdaYM
 /pO8Na/XLPBvYCg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

sk->sk_socket will be assigned in case of marginal crossed SYN, but also
in other cases, e.g.

 - With TCP Fast Open, if the connection got accept()'ed before
   receiving the 3rd ACK ;

 - With MPTCP, when accepting additional subflows to an existing MPTCP
   connection.

In these cases, the switch to TCP_ESTABLISHED is done when receiving the
3rd ACK, without the SYN flag then.

To properly restrict the wake-up to crossed SYN cases, it is then
required to also limit the check to packets containing the SYN-ACK
flags.

While at it, also update the attached comment: sk->sk_sleep has been
removed in 2010, and replaced by sk->sk_wq in commit 43815482370c ("net:
sock_def_readable() and friends RCU conversion").

Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - The above 'Fixes' tag should correspond to the commit introducing the
   possibility to have sk->sk_socket being set there in other cases than
   the crossed SYN one. But I might have missed other cases. Maybe
   1da177e4c3f4 ("Linux-2.6.12-rc2") might be safer? On the other hand,
   I don't think this wake-up was causing any visible issue, apart from
   not being needed.
---
 net/ipv4/tcp_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bfe1bc69dc3e..5cebb389bf71 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6797,9 +6797,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 		/* Note, that this wakeup is only for marginal crossed SYN case.
 		 * Passively open sockets are not waked up, because
-		 * sk->sk_sleep == NULL and sk->sk_socket == NULL.
+		 * sk->sk_wq == NULL and sk->sk_socket == NULL.
 		 */
-		if (sk->sk_socket)
+		if (sk->sk_socket && th->syn)
 			sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
 
 		tp->snd_una = TCP_SKB_CB(skb)->ack_seq;

-- 
2.45.2


