Return-Path: <netdev+bounces-115085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE509450F4
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101A0289382
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73AC1BB69F;
	Thu,  1 Aug 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0wVhZNi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892C1AAE0B;
	Thu,  1 Aug 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530392; cv=none; b=qABE6Em4JA6VFF3mGv6/tZIkomnBfFhAI5HmLtduSkLGdyPPJL89jfaZrnaK7PjHB/P4V7FXJuMt/ismWoxRieQhOCRHsViVlyqHyYZFF/qvuS/XdT79kjDuX2Dc/DSM9XTkKwSlEydcLhUBDgwM3Ta47f543wpNlJDd6FY4Nqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530392; c=relaxed/simple;
	bh=z+OUMw3kszQuXiJWYi+kU103Bu6R94dW1vaH6eJVHNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o99Wed1Xgdb/V/KzshwJ/Sjh099ZMrOVucoIYgYC5UzDrx/aItYHoO+g/b2cmHM/jP+zmXNb9xx6vlVIER/FgPKFR3tEN9TzMdsvlS9kAPpbRaS4AUoicUiVUkB+utf0dO5s+aMFdvWtPSQ8EQR+oBi5Rku/xkZ+kUo5A7gc5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0wVhZNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3725CC32786;
	Thu,  1 Aug 2024 16:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530392;
	bh=z+OUMw3kszQuXiJWYi+kU103Bu6R94dW1vaH6eJVHNY=;
	h=From:Date:Subject:To:Cc:From;
	b=U0wVhZNivzIbekk1qlpUNVthC/NHJhv22WxKKT/qIPu7P6RG35jeVOfrzY6+X720d
	 6eQXvtCPfxaSp7ax9M7q2xst0stZCq+Z8TbNYpKW5I12yvLHhTFztS2K42cF0QHrty
	 brFqqil0yAYUs0E/YxmmVwd87RXZ7nkF+NlVA6d0kW6h15yukq5grwZS3EWvCCXV7/
	 Qcg8MvdmXHrtb9VU+gWEk5sLxwvm6XDhbnbflgmkXUzKVP8Bv/65zBpt/+hC3cXdTn
	 Tri/+IgF9cjTtPIsEW0Zg6/d0tVsMnOH4h5pjBLJjAVpkPs4pnoQRPnWRJ6hqzYG1i
	 Vdq2nGDgLp4YQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 01 Aug 2024 18:39:46 +0200
Subject: [PATCH net-next] tcp: limit wake-up for crossed SYN cases with
 SYN-ACK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-v1-1-3a87f977ad5f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFG6q2YC/z2NzQoCMQyEX2XJ2UBbxL9XEQ8hRg26tTRVK8u+u
 0HQwxw+ZvhmApOqYrAbJqjyVNN7doiLAfhC+SyoR2dIIS3DJkR8FGtVaMQszdMb/qvGBW86asM
 XXcWX2NHeGVdJtutIiZgZXFyqnLR/T/fw08Bhnj/x0OWljgAAAA==
To: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=z+OUMw3kszQuXiJWYi+kU103Bu6R94dW1vaH6eJVHNY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmq7pUNklrH0I3LPpTeCEtNhkGAyQVY/oEjKZSB
 Szi+zhb9BqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqu6VAAKCRD2t4JPQmmg
 c7h8EADIuwPkDv9DQLROtlfzGZHdILnRiTIAKtvNbNrmNPOiYAbjJHBTKtPUXDKyeyJgtNpIB2k
 iVgJormaxy0lY3fnJaMer/lsUYFgWZ1CCpNJnacRd0PmP8mngCJfpoUka8yEHqbUb2969PdOONR
 jt5bKEhhTuB02Y+Q6w2Dwd8K5viO/bZ3Tzm9IW6uOETDQ/jAH+xxBCZYu1lZN4TObwhApebEGmI
 vlvudNKgMWXrE/gJ0dLjBXuFRdbnCIHZYDTBosYBaT2aWCAyZOH8XJx2F3XrRROuzgAbz1Py/Hh
 RY112CCA9b3JCmwXeES4nGIb7Xe/nby8g64IqMnp0u5RhsaWYrATMInGxaDt946vKAL5uGWGAuL
 DMB+3yfjakF7FlEtdFUUy5l49WhMxEC1VnUie3DrYsZDzsuYSmm51kd4Ts7hlPSdIJo/cO61ao9
 YJraw89iQkq6Pnr+5UNbpn4qwb0ynuO4hyUm80kGOKFb59sHllZlP2PpeF8yrZg/kDYaJnO6xCe
 Z7WfIyUn8Kq3QG1hqs49Lki9VJ6/g+Q0xAkjaFCXcYwGX5j6ekt96id938AinQTY+zMDg0eYdAF
 Eyi76EHb3wFyTpXTVSGSeWq5OHalK56KVarGMDwvsZNOxR3N2cMtdDs7V0atELTwZZ5PlNh40xd
 5CbWYQoUrA859CQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In TCP_SYN_RECV states, sk->sk_socket will be assigned in case of
marginal crossed SYN, but also in other cases, e.g.

 - With TCP Fast Open, if the connection got accept()'ed before
   receiving the 3rd ACK ;

 - With MPTCP, when accepting additional subflows to an existing MPTCP
   connection.

In these cases, the switch to TCP_ESTABLISHED is done when receiving the
3rd ACK, without the SYN flag then.

To properly restrict the wake-up to crossed SYN cases as expected there,
it is then required to also limit the check to packets containing the
SYN-ACK flags.

Without this modification, it looks like the wake-up was not causing any
visible issue with TFO and MPTCP, apart from not being needed. That's
why this patch doesn't contain a Cc to stable, and a Fixes tag.

While at it, the attached comment has also been updated: sk->sk_sleep
has been removed in 2010, and replaced by sk->sk_wq in commit
43815482370c ("net: sock_def_readable() and friends RCU conversion").

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - This is the same patch as the one suggested earlier in -net as part
    of another series, but targeting net-next (Eric), and with an
    updated commit message. The previous version was visible there:
    https://lore.kernel.org/20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org/
---
 net/ipv4/tcp_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 454362e359da..b2d2c843ecd2 100644
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

---
base-commit: 743ff02152bc46bb4a2f2a49ec891c87eba6ab5b
change-id: 20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-62e971a2accc

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


