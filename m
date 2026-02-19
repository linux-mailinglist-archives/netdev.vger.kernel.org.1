Return-Path: <netdev+bounces-259391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FbxMbxqlmkqfAIAu9opvQ
	(envelope-from <netdev+bounces-259391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:43:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 701EE15B66F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A92C630065E3
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0635221723;
	Thu, 19 Feb 2026 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XvUvpwsl"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062522A7F9
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771465402; cv=none; b=lC4VCuktTDCLnr9DozCtsbrueYImNCuTvnbD/yQxZMuxeRfVjrCxSqMVbnMK6nw8Y79VF11O7KaNnyPued2WDKj4HdHCH8lDrlcKdQ4OpSDF5C9B27B75NizYS4S+FT0RGwQCRQbT/8Nwem+MRERXuqOpGAI0zHsKfJG9vkGaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771465402; c=relaxed/simple;
	bh=AxMPpVAT1o+/GaN6fRCY6Kna2c7HdF+7HKwspa16UeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MX9Eu1mHwgkbdtubqIugk3d58fkszpvJmgp9AQU3ueeKj5LhTi8TEqt3ol6ALgES8xJX7QeW9lStcCC+vyvWCKnsjYgvpCJn3k6ltiltXRDVIRPZeBPIi+mO4WxNi1ZFVILJXim0v8PKAjhgnewexQ4WUcPUw2qtzEMv4n6jTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XvUvpwsl; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771465389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E0Cm2HRg+eNwZMTxcDiP0In5Zf3pSqK9RC9M/49yMMo=;
	b=XvUvpwslHUFNmMJCQrKlfffeEzHWuXo4R54GJM8h6QFLIXCA+YuTauTcWObdz64S+v40Ez
	uICqmoLBTUf2rOWdgEkAIFlxWmCfx47yNHWb6ssrb7m78gmAqlzWW1ZNMzhxg2JOCJkLPy
	G4PuBjKRh0KKAIhZiA87NWG75d3tkGA=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	pabeni@redhat.com
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+52624bdfbf2746d37d70@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Sven Stegemann <sven@stegemann.de>,
	Christian Brauner <brauner@kernel.org>,
	Tom Herbert <tom@herbertland.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] kcm: fix zero-frag skb in frag_list on partial sendmsg error
Date: Thu, 19 Feb 2026 09:42:51 +0800
Message-ID: <20260219014256.370092-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-259391-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,52624bdfbf2746d37d70];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 701EE15B66F
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Syzkaller reported a warning in kcm_write_msgs() when processing a
message with a zero-fragment skb in the frag_list.

When kcm_sendmsg() fills MAX_SKB_FRAGS fragments in the current skb,
it allocates a new skb (tskb) and links it into the frag_list before
copying data. If the copy subsequently fails (e.g. -EFAULT from
user memory), tskb remains in the frag_list with zero fragments:

  head skb (msg being assembled, NOT yet in sk_write_queue)
  +-----------+
  | frags[17] |  (MAX_SKB_FRAGS, all filled with data)
  | frag_list-+--> tskb
  +-----------+    +----------+
                   | frags[0] |  (empty! copy failed before filling)
                   +----------+

For SOCK_SEQPACKET with partial data already copied, the error path
saves this message via partial_message for later completion. For
SOCK_SEQPACKET, sock_write_iter() automatically sets MSG_EOR, so a
subsequent zero-length write(fd, NULL, 0) completes the message and
queues it to sk_write_queue. kcm_write_msgs() then walks the
frag_list and hits:

  WARN_ON(!skb_shinfo(skb)->nr_frags)

TCP has a similar pattern where skbs are enqueued before data copy
and cleaned up on failure via tcp_remove_empty_skb(). KCM was
missing the equivalent cleanup.

Fix this by tracking the predecessor skb (frag_prev) when allocating
a new frag_list entry. On error, if the tail skb has zero frags,
use frag_prev to unlink and free it in O(1) without walking the
singly-linked frag_list. frag_prev is safe to dereference because
the entire message chain is only held locally (or in kcm->seq_skb)
and is not added to sk_write_queue until MSG_EOR, so the send path
cannot free it underneath us.

Also change the WARN_ON to WARN_ON_ONCE to avoid flooding the log
if the condition is somehow hit repeatedly.

There are currently no KCM selftests in the kernel tree; a simple
reproducer is available at [1].

[1] https://gist.github.com/mrpre/a94d431c757e8d6f168f4dd1a3749daa

Reported-by: syzbot+52624bdfbf2746d37d70@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000269a1405a12fdc77@google.com/T/
Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/kcm/kcmsock.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 5dd7e0509a48..3912e75079f5 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -628,7 +628,7 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 			skb = txm->frag_skb;
 		}
 
-		if (WARN_ON(!skb_shinfo(skb)->nr_frags) ||
+		if (WARN_ON_ONCE(!skb_shinfo(skb)->nr_frags) ||
 		    WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0]))) {
 			ret = -EINVAL;
 			goto out;
@@ -749,7 +749,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct kcm_sock *kcm = kcm_sk(sk);
-	struct sk_buff *skb = NULL, *head = NULL;
+	struct sk_buff *skb = NULL, *head = NULL, *frag_prev = NULL;
 	size_t copy, copied = 0;
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	int eor = (sock->type == SOCK_DGRAM) ?
@@ -824,6 +824,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 				else
 					skb->next = tskb;
 
+				frag_prev = skb;
 				skb = tskb;
 				skb->ip_summed = CHECKSUM_UNNECESSARY;
 				continue;
@@ -933,6 +934,22 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 out_error:
 	kcm_push(kcm);
 
+	/* When MAX_SKB_FRAGS was reached, a new skb was allocated and
+	 * linked into the frag_list before data copy. If the copy
+	 * subsequently failed, this skb has zero frags. Remove it from
+	 * the frag_list to prevent kcm_write_msgs from later hitting
+	 * WARN_ON(!skb_shinfo(skb)->nr_frags).
+	 */
+	if (frag_prev && !skb_shinfo(skb)->nr_frags) {
+		if (head == frag_prev)
+			skb_shinfo(head)->frag_list = NULL;
+		else
+			frag_prev->next = NULL;
+		kfree_skb(skb);
+		/* Update skb as it may be saved in partial_message via goto */
+		skb = frag_prev;
+	}
+
 	if (sock->type == SOCK_SEQPACKET) {
 		/* Wrote some bytes before encountering an
 		 * error, return partial success.
-- 
2.43.0


