Return-Path: <netdev+bounces-293545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCocE8oXHWrXVgkAu9opvQ
	(envelope-from <netdev+bounces-293545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:25:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0274619A32
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DB13300899E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8E3314C5;
	Mon,  1 Jun 2026 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTOGhoWA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A5343889;
	Mon,  1 Jun 2026 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291495; cv=none; b=JfHZ//he1jTundJ9QzD6liR+nT2Rhclb92rCuZSNfzYIz3pi45mqoaJiSIN1IhiTAXYpnqHVO+o1BcpCx7sSg5xH63Wp4aYKUDGv8cuC2clKAk+CbYR23VHyG/X0nDYvMVlz2Px15Xl+VzepbHUxw5KiwR6Wf7XzFvFv2s1I3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291495; c=relaxed/simple;
	bh=SXyV5OwN/VbVE7cuAhrjbPDbrX4c8FGOeRfe0cKhobQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLL1C1UN7Rw1e2kX1Kn5lF13Ub2G+Z6ruRC88gongmJTditENwOZRFLoWJF0UT8TnxjwpJ/seft9gaISobNMUPGuV4Yb2GXjl4hj/OpwFMoF297wiilppmwrFixEdRgrxOy4LaUPWI0YiCBw+ZRl2BK+1P9Z25NkuJhxFedKWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTOGhoWA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5595C1F00893;
	Mon,  1 Jun 2026 05:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291493;
	bh=9nqPCzj+xGpWKjMd2+55MGwKuznXrbKDmJ642IaSuYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hTOGhoWAvs9EjGKMt4CQqJNBeymMlnk5ZBJFueWB6W+8VyCXlvXfNrBAF8vgQRjT5
	 aIklZtnlasU0brWbI6Jab92XVcW2Jj6nufLYPn2oDPkGDd1cuEG6F9Fio2QuBJ1T8X
	 zsC9Cw3rST0oBhplB2YmSmmFlCvbnzAm+GXxGQGTcne7zhFB9SPMn9dW2VUzeDcrwr
	 Rpr0bh9H0yuy+gkkj47JNhjv7elTPQWLWhl2n0Xl8dLQV0hyrUH9GL5Q5gjSRUE6vF
	 9LbPLLvqp5wvseKN4ccXNaaumxRr+A0B7bdqykn2ye2Vtdgqlrf0LzIxLm56yESeQH
	 yRgBCvL3vrGVw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:10 +1000
Subject: [PATCH net-next 03/11] mptcp: pm: avoid computing add_addr size
 twice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-3-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5841; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SXyV5OwN/VbVE7cuAhrjbPDbrX4c8FGOeRfe0cKhobQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReS1mTEhIQTgBJ1zsszmwdkpmbTz7mbVVzJF
 ORPyHbzp5SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkgAKCRD2t4JPQmmg
 c/cvEAC8DwFLK87jQV8L+7ANwr2ALr3fr207SFJFbZQ7NTobY4XYCYQClcoxY/OSFKKNAbBBNn2
 U1FeBNqIOEactofzlPL2aXL5U8UHo8iorSZgKvXVNffSJogI33zcdp7UPwT31VxyFtUpGVCews4
 NcEzNSoSW/YToHAxCge2easIzAGU3LCdqP00fp1m8+yLJw66f7GnOz9FfiQq3gHnBZ81FtdnwGv
 /9LrUfKuaQGriHJEu+qOs+n7itNgxjF4qB8lYeWtsN4JztnNjCdG9GiVV6TPrzO99+OzPYHWMAA
 C94L2rNn9oAOA2wF/z1iVbQtWHp6+Rbt14AczbKxte2BLw8B/PuhtRkaUKQoAST9n6IqSDVakm4
 +IypJup5ZsJc29d9PBwj39Qi+/M+HA7qzpDcMkjlcepWc5u1TlQSmZDYA3liwoImipg86LC/OPk
 qW+6qiIujvkBlEPAqhVgVFWSl5XTI7ynRLCJGNQx+Cb/frkseqKkPrBU8jug5YLXROCy8NF3NUQ
 1tEh79dZIc1mINJJ9/DBmilSKVzK44Mst+yeLnDz1V0hKbhBDBO3uIBTZ48t+13/tF0hs7Ky+yS
 x4C6rATZhFYUxiLuIgA0UzoJhIhwFvMwcKDF5HT4YUi/fy4NR435vbcfmIR5Hc+zi4Ln7/rde1a
 MzkoFF0BfUiq6Sw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293545-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E0274619A32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mptcp_add_addr_len helper was called twice: in mptcp_pm_add_addr_signal,
then just after in mptcp_established_options_add_addr. Both to check
the remaining space.

The second call is not needed: if there is not enough space,
mptcp_pm_add_addr_signal will return false, and the caller,
mptcp_established_options_add_addr, will do the same without re-checking
the size again. Instead, mptcp_pm_add_addr_signal can directly set the
size.

Note that the returned size can be negative when other suboptions are
dropped, e.g. to send an echo ADD_ADDR with a v4 address, and no port.

While at it:

 - move mptcp_add_addr_len to pm.c, as it is now only used from there

 - use 'int' in mptcp_add_addr_len for the size, instead of having a mix

 - use a bool for 'ret' in mptcp_pm_add_addr_signal

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 16 +++-------------
 net/mptcp/pm.c       | 26 ++++++++++++++++++++++----
 net/mptcp/protocol.h | 17 +----------------
 3 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 05c08034a15d..be85607733f3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -657,34 +657,25 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
-	unsigned int opt_size = *size;
 	struct mptcp_addr_info addr;
 	bool echo;
-	int len;
 
 	/* add addr will strip the existing options, be sure to avoid breaking
 	 * MPC/MPJ handshakes
 	 */
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
-		    &echo, &drop_other_suboptions))
+	    !mptcp_pm_add_addr_signal(msk, skb, size, remaining, &addr, &echo,
+				      &drop_other_suboptions))
 		return false;
 
 	/*
 	 * Later on, mptcp_write_options() will enforce mutually exclusion with
 	 * DSS, bail out if such option is set and we can't drop it.
 	 */
-	if (drop_other_suboptions)
-		remaining += opt_size;
-	else if (opts->suboptions & OPTION_MPTCP_DSS)
+	if (!drop_other_suboptions && opts->suboptions & OPTION_MPTCP_DSS)
 		return false;
 
-	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
-	if (remaining < len)
-		return false;
-
-	*size = len;
 	if (drop_other_suboptions) {
 		pr_debug("drop other suboptions\n");
 		opts->suboptions = 0;
@@ -695,7 +686,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 		 * options
 		 */
 		opts->ahmac = 0;
-		*size -= opt_size;
 	}
 	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 48299c8fe2a4..6a2cbe8616d3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -887,14 +887,30 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	}
 }
 
+static int mptcp_add_addr_len(int family, bool echo, bool port)
+{
+	int len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
+
+	if (family == AF_INET6)
+		len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+	if (!echo)
+		len += MPTCPOPT_THMAC_LEN;
+	/* account for 2 trailing 'nop' options */
+	if (port)
+		len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
+
+	return len;
+}
+
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
-			      unsigned int opt_size, unsigned int remaining,
+			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions)
 {
 	bool skip_add_addr = false;
-	int ret = false;
+	bool ret = false;
 	u8 add_addr;
+	int len = 0;
 	u8 family;
 	bool port;
 
@@ -909,7 +925,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	 * if any, will be carried by the 'original' TCP ack
 	 */
 	if (skb && skb_is_tcp_pure_ack(skb)) {
-		remaining += opt_size;
+		len -= *size;
 		*drop_other_suboptions = true;
 	}
 
@@ -926,7 +942,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		family = msk->pm.local.family;
 	}
 
-	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+	len += mptcp_add_addr_len(family, *echo, port);
+	if (len > remaining) {
 		struct net *net = sock_net((struct sock *)msk);
 
 		if (!*drop_other_suboptions)
@@ -942,6 +959,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	}
 
 	ret = true;
+	*size = len;
 
 drop_signal_mark:
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da677f5cef71..e0ffebaa6795 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1206,23 +1206,8 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL;
 }
 
-static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
-{
-	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
-
-	if (family == AF_INET6)
-		len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
-	if (!echo)
-		len += MPTCPOPT_THMAC_LEN;
-	/* account for 2 trailing 'nop' options */
-	if (port)
-		len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
-
-	return len;
-}
-
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
-			      unsigned int opt_size, unsigned int remaining,
+			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,

-- 
2.53.0


