Return-Path: <netdev+bounces-293544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPGtAtUXHWrFVgkAu9opvQ
	(envelope-from <netdev+bounces-293544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:25:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AFF619A39
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79307300B2B7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C13533ADB3;
	Mon,  1 Jun 2026 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQmkmAJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87533A014;
	Mon,  1 Jun 2026 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291491; cv=none; b=JTGJT0Uoyv9fENaFPxaSTdDs7l1aLhCN9AgwKLphADmjPhSFdxTNwuzceHJPbKt8SC2dmBP39IzhpmdIk8TJMzKztkj7G0u8we7dWbi4V3cBLpA8xxVE1keP0RoJoQ6+oZ8xBvFjwQRfSjiOw2mhALhRTQ89/e+qc5LR90CJ+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291491; c=relaxed/simple;
	bh=LP2nhVQL04TKJtBIrF/OGHNrFWjFJR8F/j+WSmmM8z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7GQqCfIgYwD0Y77vzdhhDEzHzxCg1UZd93HO7rOwliGCq41GrRSc8p3g1EL5Mx5u48rLmpqQ+i/KKb3YA6BdY08U/99Wx3x783sAjvsxjFgrdMLV+KNgS3nDOsAfOhVKFWQkBbtRBYqs+DFN46oBrgO6hc1pOgM/5r9B4SB6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQmkmAJd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F4B1F00899;
	Mon,  1 Jun 2026 05:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291489;
	bh=VKy0R6xSKc3cpF8NeXAPPGw/bjoMy59MyoHdi3HECj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RQmkmAJdAFrZUTRh1x+44Abj2i7lmdUVgCJ11BKNipydbj+ksI5K8g2Dl4f3gfZuJ
	 CqkxcoEhoR7OST4pIemqAB7cUp7N0d3IcQcwi5EYFyrsogJl1XIwmI4or5ufI+nb3A
	 bdHLqv5VsBUcbaefjquhTyO7iR0BlQvLFEfe+/u/u4qrdm+bfYNUY/Cx1jFgZ5WLmm
	 jWcvgp2n1vM64mhq7oH1GRv9SPepzreYIB3cCNvqV0COFH62pftVxF9Dz8UmHLH+/5
	 w+bICb1guKh0ObQ480wooNPHNZKa3wnvPD1nXOtuMe/EcsJhKBCaM0skY6nG2wIe2N
	 Ph0Y64HQLAhkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:09 +1000
Subject: [PATCH net-next 02/11] mptcp: pm: avoid computing rm_addr size
 twice
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-2-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3726; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LP2nhVQL04TKJtBIrF/OGHNrFWjFJR8F/j+WSmmM8z0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReSVyYRB2Tt+dyT7eTgIWTzNa724u/jI2bm4
 FQUArtRGAmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkgAKCRD2t4JPQmmg
 c8LxEAC8/kNoLU1/SuzXGk6WPPB7qAUn4OuQMyKQbAXfScsDqZe98Co1+daCnuMZX8UEZYCdZ8t
 vywg3Ps3dXvjwEelwwxQ9EVYa3yle0WxUmekavkzfVeb5soKA7ln48P43ySyCIUn9EdgUnkwr1V
 Vpq+cGA0qhdWH8ktVT25eopAbQLxvd9IIt74idZGFII8FheguEtnI/nknDkzF0/JOrQmSrIgpQI
 z10UCUKJkIkKkruYp45fpDKd5PykYhLVexRbQ3DFUgT1pgL7S35SOCeZzUs7/cgw5ZoMNrBFVpk
 sWMIshVQQq+sBTmRHgliCGWKaCqEGKD4OJ48e5evkUr1R5b2uZiMlFIt9u2KwDp3oXXJ00aOhns
 KegORSswbpOmhWwa7JUZjF0IUvFav1qJZMFgLaLy0DiFabRCvlZsOakZNVtnZj0el9lrxnYfVx9
 yolhKUxPum8opRWHvnBJesEyjj7zS1XEgRoE/GVhOmjTjXDGs9ahLlHwsHsljGVy7aI/jaQBPIC
 myrFdCw6QyAFb4GFD4g26FWYBS/VUkVu7TW4PJpEw8cdwGIwB9xGL+TG1CsqXDK9G9S/T0/YTzi
 Iu1jr6f+YRjN/taPxLpM+mTp3dTYRzwyPoNkggEVl+lL2//vRrZKFLFXXXWGaJdsRvfJ8LA4nN1
 JrbUy5mf6eOkssA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293544-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00AFF619A39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mptcp_rm_addr_len helper was called twice: in mptcp_pm_rm_addr_signal,
then just after in mptcp_established_options_rm_addr. Both to check the
remaining space.

The second call is not needed: if there is not enough space,
mptcp_pm_rm_addr_signal will return false, and the caller,
mptcp_established_options_rm_addr, will do the same without re-checking
the size again. Instead, mptcp_pm_rm_addr_signal can directly set the
size.

While at it, move mptcp_rm_addr_len to pm.c, as it is now only used
there, once.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 11 ++---------
 net/mptcp/pm.c       | 11 ++++++++++-
 net/mptcp/protocol.h | 10 +---------
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1db418a9d4a6..05c08034a15d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -720,19 +720,12 @@ static bool mptcp_established_options_rm_addr(struct sock *sk, int *size,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_rm_list rm_list;
-	int i, len;
+	int i;
 
 	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, size)))
 		return false;
 
-	len = mptcp_rm_addr_len(&rm_list);
-	if (len < 0)
-		return false;
-	if (remaining < len)
-		return false;
-
-	*size = len;
 	opts->suboptions |= OPTION_MPTCP_RM_ADDR;
 	opts->rm_list = rm_list;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e770c7407e1..48299c8fe2a4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -960,8 +960,16 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 	return ret;
 }
 
+static int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
+{
+	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
+		return -EINVAL;
+
+	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
+}
+
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list)
+			     struct mptcp_rm_list *rm_list, int *size)
 {
 	int ret = false, len;
 	u8 rm_addr;
@@ -981,6 +989,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (remaining < len)
 		goto out_unlock;
 
+	*size = len;
 	*rm_list = msk->pm.rm_list_tx;
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	ret = true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e4f5aba24da7..da677f5cef71 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1221,20 +1221,12 @@ static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
 	return len;
 }
 
-static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
-{
-	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
-		return -EINVAL;
-
-	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
-}
-
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list);
+			     struct mptcp_rm_list *rm_list, int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 			     struct mptcp_pm_addr_entry *skc);

-- 
2.53.0


