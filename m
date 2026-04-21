Return-Path: <netdev+bounces-280117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCOIFyNy52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:48:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E443AD76
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77BDC302A51D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE943D565F;
	Tue, 21 Apr 2026 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/3I7mV2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EE3D565A;
	Tue, 21 Apr 2026 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775546; cv=none; b=YXC3+62RrVzFCvM/W6u/w0bqlkdRw/T8YGugi54BvGIYQUcCSCctAxvjfHe+x6qX7YOTM2VcZYD3mV2bPYuETUTWEpDBUPBkswE/ty/RXIZ8G6zSPpq8N+Qz+dqJR9ltaB4kwKXeHWL1uDAhzpEhPLySqeowcnYqmj2RRTsfDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775546; c=relaxed/simple;
	bh=mrOQoOAhCIH4Fbq74Dfs0JHYjIU5MKgLEiRqvtCY/4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gwqab1sQRgJgFBF5AQNlr5nZb0vLxgymDdQgooSQfVM1OheRN2RwaapUu7fF3tKYtCrHWnLVWWWOuhNEjZT+ALdFteYMGV40tv0N/KcQ3IPoZoPiaoaJ7ZO4mENrg4GUrGYN6uy6b2AVIs9s1WxvLu6b+RUAL7KEF/lbtuEXDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/3I7mV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEC7C2BCB0;
	Tue, 21 Apr 2026 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776775546;
	bh=mrOQoOAhCIH4Fbq74Dfs0JHYjIU5MKgLEiRqvtCY/4k=;
	h=From:To:Cc:Subject:Date:From;
	b=G/3I7mV2dB8DYts4JDGyG77eIXmy4nwHjDV3jQphxR7yIExdtg09CwIQfEeeJdZJV
	 uXGpdlGwBLoAn2bibjg9m4NpXXqVxx65uBwv4eCnCzf72EqwgvWOFErimFXs43teL2
	 MoHxznCz+ar/fiIYIZHMVSueBFcS0jsYBLEjLD4YhCnkO12/bM4qfQlXwQqmuhalk3
	 kJpncTG06NcuFhQHl7LjhHBK7BUiIJ5TY4pIykh6sKp6jo+n7aEFhlnTuga8YYPjGh
	 OjjCK7PJijdyp+7O2ltVmOTMIZ5ph/s50z5zFyHJtHxqIlebhjLKmLUwrNqCF76Idi
	 weGtWP3YlRIsQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: [PATCH v2 1/1] tipc: fix double-free in tipc_buf_append()
Date: Tue, 21 Apr 2026 13:45:26 +0100
Message-ID: <20260421124528.162996-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280117-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B92E443AD76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tipc_msg_validate() can potentially reallocate the skb it is validating,
freeing the old one.  In tipc_buf_append(), it was being called with a
pointer to a local variable which was a copy of the caller's skb
pointer.

If the skb was reallocated and validation subsequently failed, the error
handling path would free the original skb pointer, which had already
been freed, leading to double-free.

Fix this by checking if head now points to a newly allocated reassembled
skb.  If it does, reassign *headbuf for later freeing operations.

Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize and contents")
Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Lee Jones <lee@kernel.org>
---
1v => v2: Keep the passed pointer type the same, but reassign on-change

 net/tipc/msg.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 76284fc538eb..b0bba0feef56 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -177,8 +177,20 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 
 	if (fragid == LAST_FRAGMENT) {
 		TIPC_SKB_CB(head)->validated = 0;
-		if (unlikely(!tipc_msg_validate(&head)))
+
+		/* If the reassembled skb has been freed in
+		 * tipc_msg_validate() because of an invalid truesize,
+		 * then head will point to a newly allocated reassembled
+		 * skb, while *headbuf points to freed reassembled skb.
+		 * In such cases, correct *headbuf for freeing the newly
+		 * allocated reassembled skb later.
+		 */
+		if (unlikely(!tipc_msg_validate(&head))) {
+			if (head != *headbuf)
+				*headbuf = head;
 			goto err;
+		}
+
 		*buf = head;
 		TIPC_SKB_CB(head)->tail = NULL;
 		*headbuf = NULL;
-- 
2.54.0.rc1.555.g9c883467ad-goog


