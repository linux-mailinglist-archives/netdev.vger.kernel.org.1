Return-Path: <netdev+bounces-274994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMoNIc6kz2mZyQYAu9opvQ
	(envelope-from <netdev+bounces-274994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:30:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C071C393B16
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A2B5300809C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635283B776F;
	Fri,  3 Apr 2026 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atBA4lWr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8838CFEF;
	Fri,  3 Apr 2026 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215798; cv=none; b=WNq073YgCnlRJf6Qt3nWK6idXSTXuzN2FQJCSFlyY5OyhBnRg4Mt9FzgNrkksLiEyXAesQQpRmrkROVXV5747fEVSr+yhqUHdc2316UQWI/u4fsVmlZ2vUmxrZswOLcu2UIsK01qQMOqhXHtLB1nf27dEFHI1bJdqmsRVA9ln0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215798; c=relaxed/simple;
	bh=maJ5zzm7scL8ZbD0h1YkRJZCs2NsQFvup9oZE1mw5KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzivNMeecDKabkEW8VWFGxKa/ahA9ts9sIIKF+6V6nNtDlU9MsP4jFg5YjACfgbUaV3jJlhYBTnbGMwQbBFlTzLQ1LSZAZHuHtHtf7nks6SITWE+DtDq4dAb3XiNVFRVuTj+wxMsJ+pXgkEYabDk0cgOckhFoNkcqcUwlztA2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atBA4lWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC1C2BCB9;
	Fri,  3 Apr 2026 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215796;
	bh=maJ5zzm7scL8ZbD0h1YkRJZCs2NsQFvup9oZE1mw5KU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=atBA4lWrFUG40jxyS092CpJFSQhoRlIuWVHwGblZNHRb1tO+LRV7vXCwFH8rF539S
	 Tn8M48Pj9ShR4AOC3bDJy11QjemNmPHiCh+TORZOQtiNzxB7Qfoq05xKWNI/93ytSm
	 Y2TPefhcZq3IP8SMMoyIJluAfKCXHWO/5EiNK3xSuPfUk7XYfGO3wU13YvII8vhWcs
	 T9HYfYKjme8kolqb+mtYDK81GNPufnqjHICHaJowXBXert69C06TUUWjp78YKgnKAV
	 p+4g720N5rSx1FcAnd0gQRm4RAo8xntdAZ4b6ROhXkJcalU06AWtFUCnCX1IacG2a9
	 wpdX8Q/gAxfMg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 03 Apr 2026 13:29:28 +0200
Subject: [PATCH net-next 2/5] mptcp: preserve MSG_EOR semantics in sendmsg
 path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-net-next-mptcp-msg_eor-misc-v1-2-b0b33bea3fed@kernel.org>
References: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
In-Reply-To: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3256; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zyCtjJLAzhx558xwpPbkO4CJxWTtK4YZSUOCvm+2gtE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPL1m91t7Q6pXc44bJ2XP6f4scnKgWJnPI4kSR1PuVd
 9UXzLWN6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIe25GhhOfVptqbehjW7y6
 pznkw3HBkyxb9sbl/tjyOiP/j1zps8sM/zOfNF/64rmeMeT++acODo7rYp0aKt4/Ybt958b//G3
 tV5kA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274994-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C071C393B16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gang Yan <yangang@kylinos.cn>

Extend MPTCP's sendmsg handling to recognize and honor the MSG_EOR flag,
which marks the end of a record for application-level message boundaries.

Data fragments tagged with MSG_EOR are explicitly marked in the
mptcp_data_frag structure and skb context to prevent unintended
coalescing with subsequent data chunks. This ensures the intent of
applications using MSG_EOR is preserved across MPTCP subflows,
maintaining consistent message segmentation behavior.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 24 +++++++++++++++++++++---
 net/mptcp/protocol.h |  2 +-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 79315e575d07..e21e416cd19a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1005,7 +1005,8 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
 				       const struct page_frag *pfrag,
 				       const struct mptcp_data_frag *df)
 {
-	return df && pfrag->page == df->page &&
+	return df && !df->eor &&
+		pfrag->page == df->page &&
 		pfrag->size - pfrag->offset > 0 &&
 		pfrag->offset == (df->offset + df->data_len) &&
 		df->data_seq + df->data_len == msk->write_seq;
@@ -1147,6 +1148,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
+	dfrag->eor = 0;
 
 	return dfrag;
 }
@@ -1408,6 +1410,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mptcp_update_infinite_map(msk, ssk, mpext);
 	trace_mptcp_sendmsg_frag(mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
+
+	/* if this is the last chunk of a dfrag with MSG_EOR set,
+	 * mark the skb to prevent coalescing with subsequent data.
+	 */
+	if (dfrag->eor && info->sent + copy >= dfrag->data_len)
+		TCP_SKB_CB(skb)->eor = 1;
+
 	return copy;
 }
 
@@ -1868,7 +1877,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	long timeo;
 
 	/* silently ignore everything else */
-	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
+	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+			  MSG_FASTOPEN | MSG_EOR;
 
 	lock_sock(sk);
 
@@ -1975,8 +1985,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			goto do_error;
 	}
 
-	if (copied)
+	if (copied) {
+		/* mark the last dfrag with EOR if MSG_EOR was set */
+		if (msg->msg_flags & MSG_EOR) {
+			struct mptcp_data_frag *dfrag = mptcp_pending_tail(sk);
+
+			if (dfrag)
+				dfrag->eor = 1;
+		}
 		__mptcp_push_pending(sk, msg->msg_flags);
+	}
 
 out:
 	release_sock(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 02031007100b..1208f317ac33 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -264,7 +264,7 @@ struct mptcp_data_frag {
 	u16 data_len;
 	u16 offset;
 	u8 overhead;
-	u8 __unused;
+	u8 eor;			/* currently using 1 bit */
 	u16 already_sent;
 	struct page *page;
 };

-- 
2.53.0


