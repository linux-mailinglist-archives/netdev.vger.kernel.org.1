Return-Path: <netdev+bounces-295741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 47bMJjqcImqgawEAu9opvQ
	(envelope-from <netdev+bounces-295741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:51:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD026470C4
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:51:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eU85ijGc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295741-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295741-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A8F43088072
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C03440B372;
	Fri,  5 Jun 2026 09:22:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515640B370;
	Fri,  5 Jun 2026 09:22:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651331; cv=none; b=lsPWpUN9zwpfiI12q2/H1JlyiC2ujCgpDr9UD2gxNmU6wM/0jHOspVt0FcCEIVZp0xybG51ikB8QpJXNvoJsrSdlv7xo5tWetg+1pu3vD2nHmk0IzfL7bWWHkfKzv27VDQtiEeXgfgmTSdyu2SPUK4KVS9anWqsaCq4r8/aPS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651331; c=relaxed/simple;
	bh=S3d+uMiteSKRDwWkvMIXgL4LM29Q8+Cv2kR3u0+Ktb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=arwtkWi6ZyExBWnAJ570MGTv1FGcBgL/0DL1etM1zsW8GUvBgBIIYNw73+exBAo4tCTnZU/ghGvj5xCAXi75CDm1lbL/uKhUGG9geBrL1PDtHkdwtF7jnG3XDji0P4qKGk46ue31+GzKJnEtHS6i4SK/dyPl2lDrYy1i8TRnhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU85ijGc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811021F00893;
	Fri,  5 Jun 2026 09:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651329;
	bh=TZL7KcFHmVsg1q0yWV0DsQyl/nWG15jXVqWzdvKFgrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eU85ijGcvbl7MbJc8qXKL8Irb0pF/oI162wliTwuwd8lfg3XGSQhVkCPAB2a9IeHO
	 YxmXz7lx2x1CLfaYu0GZrFHqTu4rY5RbqG9ctzpgJKFKOz/hOHu2mvU6tuGi7QhPiE
	 2EkT8gQOZ8jPAhMAZqKAW9w4lqvnOg/H4P8FwWtNSsOa01OvMGCS1/1h0NBDC669st
	 KXZliCQosp9HD8+6Q6V2ETwfI+ski7D0lc2EHeGcVBcZU+DV2wOQwi0DrzpDPAWsS4
	 fJzChehhNe+UWzcbfFgX9Y8XDyw61uuvW989lqzEgdhctepv7TiEhEnX6zGz5FMmcK
	 69opL2x2NzVnQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:47 +1000
Subject: [PATCH net-next v2 03/15] mptcp: pm: avoid computing add_addr size
 twice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-3-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5582; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S3d+uMiteSKRDwWkvMIXgL4LM29Q8+Cv2kR3u0+Ktb0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUx926VlXHP8RSl9VUgp3r+JQSKyKAh/RUX+
 aKuKdc4ZHyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 cznXEACls68MB61RD7CO1m0Y80381MMCsfB4bvWNy8oMbXkpzsNRfuX6PDMcricE5cXaVsh/0rH
 bLN6AGwZc6G8kklSDqcEyA9l2RyG2XlKsW1/TsWsRnFJqFVSv+X1mIUVjOdACFcGY+NfOiBar56
 tmEtHz4jvrqpB4XYSmiJVVCNmID3GxG4Nb9vwqcO1c2VF/i+MLNijFcLxhmYpiK7iXAAGEDy1iR
 0LzMqVmWtyu/n8ky10ZMhqaTQRVCtpzbjnPS8wjtNCokBcwjrx+2QuYE+hn/7z+ZMYZrVgjq2k+
 gClTQn6Balu5Lcw43FF0RNVDUisrs07WbsyRkMqZGwDX3Wr5KHp1jgFbghIFeimHt0DqVcelPwb
 TrPDsS3RtsfG7gOafrBA6B4Pa89cUpTlHiXc1oBjTZFuDLg8oGxj5nc1QqoDodrDgSAY06DCfEs
 3Pn9gYBEw9o6gqJ/Adj7FtT7mUyqKiCvUlaWnrHv0JMKfe4iHedk4x3Tbv1riWMVuB2cerr+w12
 RpIjs70fOb1SmiNmAXf2H8UbySxXPl8gHSYYFpY5GGjiVYt4wE3rpB3AGH6IHysbNG3erRIKdSM
 lZkBHe6oPVqyj0NEGi2+r07Rdrs7uxuss2+GUEREXkCRJrnLw6ijEaEdMep75tMXH/1y/FhrgaU
 UW3klmzJ16sIT/A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295741-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAD026470C4

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
 net/mptcp/options.c  | 15 ++-------------
 net/mptcp/pm.c       | 27 ++++++++++++++++++++++-----
 net/mptcp/protocol.h | 18 +-----------------
 3 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e44db4768f6c..2e4b6aafbad5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -663,10 +663,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	unsigned int opt_size = *size;
 	struct mptcp_addr_info addr;
 	bool echo;
-	int len;
 
 	/* add addr will strip the existing options, be sure to avoid breaking
 	 * MPC/MPJ handshakes
@@ -674,21 +672,12 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !skb || !skb_is_tcp_pure_ack(skb) ||
-	    !mptcp_pm_add_addr_signal(msk, opt_size, remaining, &addr, &echo))
+	    !mptcp_pm_add_addr_signal(msk, size, remaining, &addr, &echo))
 		return false;
 
-	remaining += opt_size;
-
-	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
-	if (remaining < len)
-		return false;
-
-	*size = len;
 	pr_debug("drop other suboptions\n");
-	opts->suboptions = 0;
-	*size -= opt_size;
+	opts->suboptions = OPTION_MPTCP_ADD_ADDR;
 	opts->addr = addr;
-	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);
 		opts->ahmac = add_addr_generate_hmac(READ_ONCE(msk->local_key),
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4bc380c6f0e1..59dc598d343d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -887,13 +887,28 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	}
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
-			      unsigned int remaining,
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
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo)
 {
 	bool skip_add_addr = false;
-	int ret = false;
+	bool ret = false;
 	u8 add_addr;
+	int len = 0;
 	u8 family;
 	bool port;
 
@@ -907,7 +922,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
 	 * plain dup-ack from TCP perspective. The other MPTCP-relevant info,
 	 * if any, will be carried by the 'original' TCP ack
 	 */
-	remaining += opt_size;
+	len -= *size;
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
 	if (*echo) {
@@ -922,7 +937,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
 		family = msk->pm.local.family;
 	}
 
-	if (remaining < mptcp_add_addr_len(family, *echo, port)) {
+	len += mptcp_add_addr_len(family, *echo, port);
+	if (len > remaining) {
 		struct net *net = sock_net((struct sock *)msk);
 
 		if (*echo) {
@@ -935,6 +951,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
 	}
 
 	ret = true;
+	*size = len;
 
 drop_signal_mark:
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 75c5faaf4486..4dfea209ac16 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1206,23 +1206,7 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
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
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
-			      unsigned int remaining,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list, int *len);

-- 
2.53.0


