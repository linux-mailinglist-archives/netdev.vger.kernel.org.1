Return-Path: <netdev+bounces-112048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129D4934BC0
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD40D284B16
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6904C132132;
	Thu, 18 Jul 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU6YB/sZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39347132112;
	Thu, 18 Jul 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298862; cv=none; b=knIGQENIvhCM/jwruIIEmnjJBI9zb6q5PBAbpOMy7W0pXbiiV/yQSoyl+1cqhkg7MhryWOqlfO62lZ38AFAH0KMcDOj83sLF22U86noU4IJAL6ZeBTAw9wxIQCbvsjupqukz8Ex+sC10tH7iihIP+PJkRBXpXirk3bGIXVRH6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298862; c=relaxed/simple;
	bh=piw2pOL8UZVssXmqpVfj53xjxXazAMpjHsH/ohQyXMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHO+x/JVOsKg1SYdlsTv3MPARO0p/dwm7T3x4FTuxocJMgtcNTa1C9UMYfnkujEkZzfA1RzCbyUxTs4ABlUgMm4LfL9F/qnZA6DjqGySB+QHwMQu5p+dgUzurRtr2oyjUuU4SE7PjN8qbQiDUB7Bn1Mskqln+bNWJ44gfRXhyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU6YB/sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860B8C4AF0F;
	Thu, 18 Jul 2024 10:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721298861;
	bh=piw2pOL8UZVssXmqpVfj53xjxXazAMpjHsH/ohQyXMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PU6YB/sZpfcj8eEacdEbYfVj68jE9h+N33BDPYUPr5pxeGDG5Sylf2dvMnvvahrPk
	 DwZeMRg+ms3WY3JJ32zNSNcwlZfPx/D1RFIE6dbVyg1LD4iUaRkBhMxj3jS9onMZE7
	 o92SkcHaQaXAnUsB2AwttxJPITyaNHczkXo/yJg3dcKSbQiOOmYTTFK8idBpmk2p0N
	 PrBdo8pWeQvvzV3QZf98yHBTeoE2613QyRBnZHCXnRniyRrd3zV+WzKV9uqCgnasO2
	 aTgOAeIAoTX92Gv3TEvcFDDYmIZ5kcj080cVpEPBNfQui8IAUw0iHa0R8AYCYt+X5O
	 HhxmbxAH0k/4g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 12:33:56 +0200
Subject: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for
 TFO/MPTCP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
In-Reply-To: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Jerry Chu <hkchu@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5098; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=piw2pOL8UZVssXmqpVfj53xjxXazAMpjHsH/ohQyXMg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmO+oD7vHXVzHiXzYqKPoJiLB4b8qzznq+oYMs
 XMkjqvvQOCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpjvqAAKCRD2t4JPQmmg
 c580D/91JMiUY/0yEXJzEHnrIX5gOmLt88L/ouI6Q77NwKDz7qtZF0NUJ+xS40c6C6aXq/WRnJB
 RuA9sJSWEC2kC/cZ6ZOUA2t4ELK7bGitEWwti46H/bmKZiqPYou7P38IlBXEFMnT3ZTOhmjrWGu
 +ZR3fLHnjTi+hVwNtRiGhIh6JZEXys9ltXWiMH2BTQeDlOS692fkUaVgxcWNo4GP9iz6CiHSjn7
 AMdiSHMsN+8S5bxWBK8FD4KN7rNr3ATLzoWoX3NilvOwBswTHUlQgylvycolnHPsM4DcXoy/aDn
 jwpC9FrugB8QwSUA61M3mXTrOupNPQswjhvEgwymz/LD5fWixnXzq0soTKPM03Wgfwgrc+fD53D
 a2sNTGRjVgCtdOO0PLofF3/IoqNEoHm+eEENdGS4szd6wzo71mrYQXWdDjrJgIOtV5TgD40VYFX
 AlzZ8QBjRbs4dGqbMHtqWhGBjjxIONK1QcaoB6SJsucz2ItWIK8lqqOd7ezoLpffHXA00WAigWU
 pRBQn7L5fD0ZzXohs7lWhW1SjsaVu/FW3SYgFtfbLRUpxG4hH+zOyRiJQdukPAADsHbY9bmNdlL
 S98Rj0KGGH9xH66ozvqLwPelt0LJYIM7HHl9Mt0Wmtlii/8LULUdW2kuwbTjybA9gvvw2YIXBHC
 6M6BRLKBjh0mJUg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'Fixes' commit recently changed the behaviour of TCP by skipping the
processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
unnecessary ACK in case of simultaneous connect(). Unfortunately, that
had an impact on TFO and MPTCP.

I started to look at the impact on MPTCP, because the MPTCP CI found
some issues with the MPTCP Packetdrill tests [1]. Then Paolo suggested
me to look at the impact on TFO with "plain" TCP.

For MPTCP, when receiving the 3rd ACK of a request adding a new path
(MP_JOIN), sk->sk_socket will be set, and point to the MPTCP sock that
has been created when the MPTCP connection got established before with
the first path. The newly added 'goto' will then skip the processing of
the segment text (step 7) and not go through tcp_data_queue() where the
MPTCP options are validated, and some actions are triggered, e.g.
sending the MPJ 4th ACK [2] as demonstrated by the new errors when
running a packetdrill test [3] establishing a second subflow.

This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
delayed. Still, we don't want to have this behaviour as it delays the
switch to the fully established mode, and invalid MPTCP options in this
3rd ACK will not be caught any more. This modification also affects the
MPTCP + TFO feature as well, and being the reason why the selftests
started to be unstable the last few days [4].

For TFO, the existing 'basic-cookie-not-reqd' test [5] was no longer
passing: if the 3rd ACK contains data, and the connection is accept()ed
before receiving them, these data would no longer be processed, and thus
not ACKed.

One last thing about MPTCP, in case of simultaneous connect(), a
fallback to TCP will be done, which seems fine:

  `../common/defaults.sh`

   0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) = 3
  +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)

  +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>

  +0 write(3, ..., 100) = 100
  +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop, nop, sack 0:1>
  +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>

Simultaneous SYN-data crossing is also not supported by TFO, see [6].

Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/9936227696 [1]
Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/syscalls/accept.pkt#L28 [3]
Link: https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp-dbg&test=mptcp-connect-sh [4]
Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fastopen/server/basic-cookie-not-reqd.pkt#L21 [5]
Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fastopen/client/simultaneous-fast-open.pkt [6]
Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - We could also drop this 'goto consume', and send the unnecessary ACK
   in this simultaneous connect case, which doesn't seem to be a "real"
   case, more something for fuzzers. But that's not what the RFC 9293
   recommends to do.
 - v2:
   - Check if the SYN bit is set instead of looking for TFO and MPTCP
     specific attributes, as suggested by Kuniyuki.
   - Updated the comment above
   - Please note that the v2 has been sent mainly to satisfy the CI (to
     be able to catch new bugs with MPTCP), and because the suggestion
     from Kuniyuki looks better. It has not been sent to urge TCP
     maintainers to review it quicker than it should, please take your
     time and enjoy netdev.conf :)
---
 net/ipv4/tcp_input.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ff9ab3d01ced..bfe1bc69dc3e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6820,7 +6820,12 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
 
-		if (sk->sk_socket)
+		/* For crossed SYN cases, not to send an unnecessary ACK.
+		 * Note that sk->sk_socket can be assigned in other cases, e.g.
+		 * with TFO (if accept()'ed before the 3rd ACK) and MPTCP (MPJ:
+		 * sk_socket is the parent MPTCP sock).
+		 */
+		if (sk->sk_socket && th->syn)
 			goto consume;
 		break;
 

-- 
2.45.2


