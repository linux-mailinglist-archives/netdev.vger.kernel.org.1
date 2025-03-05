Return-Path: <netdev+bounces-172091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59514A502E5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E24188CD42
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0002E24EF8C;
	Wed,  5 Mar 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP8S7GEL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C918524EF73;
	Wed,  5 Mar 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186195; cv=none; b=GloswDzW04v1TV8NNAbL+8Oct0OOCx8IqbBNR0yj2m4i8RHhQ8VTN9dAH+CM5bmxuj98xAvf+eF7esSQ1Knlo8EeIdyQID+R7svQ7ZJWwHDbbcgvG8wMeOjUT+Q7cEVRTqcqwqKcuH6PPxbyWB/THeEB+Kn/cdBSdTsMWbEMyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186195; c=relaxed/simple;
	bh=uprYqIBFZkBTQA4MDLv6IUCke0X86W7jnI/kyA/QQq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=InOOBLzJP7TmobZcbcJCwXkOHKpAULf8AN8K+DG8b8Xb1hu4vcwKF1KRX+1QJfP9ey/Ts2TQqx25wqV6AEda0X9/Vo+pZQqMUNgJtJnW1ukcYmc0XcrLlb16FnLm5LZHqdNYr7z+PYM1XJaIf0Z2qpsbo/ruiege9diwUn7rXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP8S7GEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E27C4CED1;
	Wed,  5 Mar 2025 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186195;
	bh=uprYqIBFZkBTQA4MDLv6IUCke0X86W7jnI/kyA/QQq4=;
	h=From:Date:Subject:To:Cc:From;
	b=PP8S7GEL+sWutD2+qwcL57B92tuYJKs8M8fbJRcT9RbcjaGyAscilI3J5+imamk3q
	 HdBNVQAigJXFaoL9wJfOCBtV/AQZVM7lST8xU2TpJY2MgHJiht6rGt8XESHmFf1zqN
	 FMQ6twF8LYAMthakeLkUca/JRABiwq5bR4f2LqrH/XZT91vTOOod5juumcyRViwGm3
	 DW3IQ1XaLPViJ6tu1PJx2jmAoWnT5Ke3ag8Im/6EFoCb7tFzJg+u99TwoHgiBfh654
	 XVHD9HytOrjy8gEwYQbi31/RBwi3ydSY7olLKg7ha1Lx50S/+ACkb0CAR57VG0P9GS
	 8jwQUxwdNEApg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Mar 2025 15:49:48 +0100
Subject: [PATCH net-next] tcp: clamp window like before the cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAItkyGcC/zWMQQqAMAwEvyI5G6haEf2KeJCaakBraYsK4t8Ng
 oc9DOzMDZECU4QuuyHQwZF3J1DkGZhldDMhT8JQqrJWlarRUZJdCS1fmIzHkx2addw8tlYbXTT
 Waj2BBHwgOX3xHn4Phud5AXOqAct2AAAA
X-Change-ID: 20250305-net-next-fix-tcp-win-clamp-9f4c417ff44d
To: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3419; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uprYqIBFZkBTQA4MDLv6IUCke0X86W7jnI/kyA/QQq4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnyGSQ2czRWw21Bby0VPsl7CV39+coBDNXQAU4F
 8YXn2O3+tiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8hkkAAKCRD2t4JPQmmg
 czduD/9rBDlhzSuHcd+Li2XFakkkyLs+9dzHnmHu4iBhbwdGrmeqIICEyfKhmJTtUdc0UwcriIC
 9XcAST6OQJZxsxuA0NRMeIyRKtYGfmPK8vC5gNpuHJTN7OK1Pnf6oGC3ZPHcBIvVWC9ohF4ZK9d
 gTMRwoCsP5dnnMZh5C2YxbsD2e0g0TDiQWotZidO1SfRCyuK1HAMiorAnbOaChncsTY/xneV6Dr
 cv05C8g/A16N+S18xG2mH50xmkzMlX8XKTUBSvMmpwk521oHZxtNzmUVMJ8YhsnENoxEP1lnfQH
 Wy5v5m647MhkDKjZ8rGRAxY681nQKInN/mr0HCAKX1otI4GDQGKTxGZjkWxCatc9aE/Mvr8ONKU
 w3FkLugaEpZ/Eez2wbq79xtJe70qoKCkVkP6YLtVvxXLqjVXteJcqcpdS0zQ1UfPgrqgoywhlEn
 92AI5yNdACaNuIiS4gIXprBfexrGA1hzhTUx3t2KKR5d7IF/JdCjUEW06Am1BjTXaWoCQLFyT9r
 l2g9DiMgvFVoe2TSPwjZMAWRXjQhStTuyHKUoHmt9NXKlirbnJZ2Ebc96G8mmR+zWwSe0nurI7c
 ugDxqQ3peAigt/BASAoi5zBjNRKTHDGU8GAEphXxH0PJME+GeXTjw50aaYJgy80QK5RxrkRXRaK
 GSjEhfv62eQka8Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A recent cleanup changed the behaviour of tcp_set_window_clamp(). This
looks unintentional, and affects MPTCP selftests, e.g. some tests
re-establishing a connection after a disconnect are now unstable.

Before the cleanup, this operation was done:

  new_rcv_ssthresh = min(tp->rcv_wnd, new_window_clamp);
  tp->rcv_ssthresh = max(new_rcv_ssthresh, tp->rcv_ssthresh);

The cleanup used the 'clamp' macro which takes 3 arguments -- value,
lowest, and highest -- and returns a value between the lowest and the
highest allowable values. This then assumes ...

  lowest (rcv_ssthresh) <= highest (rcv_wnd)

... which doesn't seem to be always the case here according to the MPTCP
selftests, even when running them without MPTCP, but only TCP.

For example, when we have ...

  rcv_wnd < rcv_ssthresh < new_rcv_ssthresh

... before the cleanup, the rcv_ssthresh was not changed, while after
the cleanup, it is lowered down to rcv_wnd (highest).

During a simple test with TCP, here are the values I observed:

  new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
      117760   (out)         65495         <  65536
      128512   (out)         109595        >  80256  => lo > hi
      1184975  (out)         328987        <  329088

      113664   (out)         65483         <  65536
      117760   (out)         110968        <  110976
      129024   (out)         116527        >  109696 => lo > hi

Here, we can see that it is not that rare to have rcv_ssthresh (lo)
higher than rcv_wnd (hi), so having a different behaviour when the
clamp() macro is used, even without MPTCP.

Note: new_window_clamp is always out of range (rcv_ssthresh < rcv_wnd)
here, which seems to be generally the case in my tests with small
connections.

I then suggests reverting this part, not to change the behaviour.

Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/551
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes: the 'Fixes' commit is only in net-next
---
 net/ipv4/tcp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index eb5a60c7a9ccdd23fb78a74d614c18c4f7e281c9..46951e74930844af952dfbc57a107b504d4e296b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3693,7 +3693,7 @@ EXPORT_SYMBOL(tcp_sock_set_keepcnt);
 
 int tcp_set_window_clamp(struct sock *sk, int val)
 {
-	u32 old_window_clamp, new_window_clamp;
+	u32 old_window_clamp, new_window_clamp, new_rcv_ssthresh;
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (!val) {
@@ -3714,12 +3714,12 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 	/* Need to apply the reserved mem provisioning only
 	 * when shrinking the window clamp.
 	 */
-	if (new_window_clamp < old_window_clamp)
+	if (new_window_clamp < old_window_clamp) {
 		__tcp_adjust_rcv_ssthresh(sk, new_window_clamp);
-	else
-		tp->rcv_ssthresh = clamp(new_window_clamp,
-					 tp->rcv_ssthresh,
-					 tp->rcv_wnd);
+	} else {
+		new_rcv_ssthresh = min(tp->rcv_wnd, new_window_clamp);
+		tp->rcv_ssthresh = max(new_rcv_ssthresh, tp->rcv_ssthresh);
+	}
 	return 0;
 }
 

---
base-commit: c62e6f056ea308d6382450c1cb32e41727375885
change-id: 20250305-net-next-fix-tcp-win-clamp-9f4c417ff44d

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


