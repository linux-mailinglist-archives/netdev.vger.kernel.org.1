Return-Path: <netdev+bounces-259744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAVaNT6TmGk5JwMAu9opvQ
	(envelope-from <netdev+bounces-259744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:00:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 395841698C3
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C770F300A4FA
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89F2E7BB4;
	Fri, 20 Feb 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTCA2LsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D329D28B
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606840; cv=none; b=VxKzEGJAS69iuXDA5j6I+vuDMY+voE2UUFz4ckWbLmKjslI92jbKim+O70CIkvTEzJKLEBJUuFUQQ79INqPzcVsxdhz7wU9amg724O/B0t/SLE5/uSWODuNdMOzLccmn1JlFsjoSziefY/gRwdeGRq5pR6th0qJlAQdSuWxfuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606840; c=relaxed/simple;
	bh=iaYIZOusP7HkqnyehZrEQH5tmajm7tHvilXIF9J9qT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HP77PmAxuC7hMFM8hwFWNmYo3G3KytVgMXQdl6xgfInC4kMakQB6Z59HHHEEbpKyCDf7RdCJU7QakHIvbuCh4OPyKXCWE26OJCUQ2ZXeetCPQR8Ju7f5J/fQg8AltPc+tfu8xJ1aCWjqpK0FWZu/3cSbRIwWm7s5Pl++CEuZDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTCA2LsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37C1C116C6;
	Fri, 20 Feb 2026 17:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771606840;
	bh=iaYIZOusP7HkqnyehZrEQH5tmajm7tHvilXIF9J9qT0=;
	h=From:To:Cc:Subject:Date:From;
	b=DTCA2LsFqpW+kyMBG2rQz5lI20JnszlIJcbXtHwKsRSFwlcSdgOCWoOwYc6cV7FPT
	 sDxxp8f0lVJ6tAwCMlU9rE3SwLtDmj9GKfLJa6esKonERJVS/cIFxgqY1T9JiaVufK
	 mp/PH5d4sxnnmyFCc+A9jQ3C/mL624BEUspVz5vJQUeCF+uG31Rq3TGO2MU9P1YxrO
	 CYa/70EUBLtmLiFT3PxgITCW7SnkzNBrWx47Od61VYMnzU+Ymnf+odJ9LpdwIXUhUk
	 c5nxrIkXSAbv5UA7W/UNWpauPJAuGbOuR3GK0zlFDnlwyPrHKiJx1N+kouxxnbncQd
	 jNLcFgags/OxA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	sdf@fomichev.me,
	hawk@kernel.org,
	alexander.h.duyck@intel.com
Subject: [PATCH net] net: consume xmit errors of GSO frames
Date: Fri, 20 Feb 2026 09:00:31 -0800
Message-ID: <20260220170032.2964535-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259744-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email,udpgro_bench.sh:url]
X-Rspamd-Queue-Id: 395841698C3
X-Rspamd-Action: no action

udpgro_frglist.sh and udpgro_bench.sh are the flakiest tests
currently in NIPA. They fail in the same exact way, TCP GRO
test stalls occasionally and the test gets killed after 10min.

These tests use veth to simulate GRO. They attach a trivial
("return XDP_PASS;") XDP program to the veth to force TSO off
and NAPI on.

Digging into the failure mode we can see that the connection
is completely stuck after a burst of drops. The sender's snd_nxt
is at sequence number N [1], but the receiver claims to have
received (rcv_nxt) up to N + 3 * MSS [2]. Last piece of the puzzle
is that senders rtx queue is not empty (let's say the block in
the rtx queue is at sequence number N - 4 * MSS [3]).

In this state, sender sends a retransmission from the rtx queue
with a single segment, and sequence numbers N-4*MSS:N-3*MSS [3].
Receiver sees it and responds with an ACK all the way up to
N + 3 * MSS [2]. But sender will reject this ack as TCP_ACK_UNSENT_DATA
because it has no recollection of ever sending data that far out [1].
And we are stuck.

The root cause is the mess of the xmit return codes. veth returns
an error when it can't xmit a frame. We end up with a loss event
like this:

  -------------------------------------------------
  |   GSO super frame 1   |   GSO super frame 2   |
  |-----------------------------------------------|
  | seg | seg | seg | seg | seg | seg | seg | seg |
  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |
  -------------------------------------------------
     x    ok    ok    <ok>|  ok    ok    ok   <x>
                          \\
			   snd_nxt

"x" means packet lost by veth, and "ok" means it went thru.
Since veth has TSO disabled in this test it sees individual segments.
Segment 1 is on the retransmit queue and will be resent.

So why did the sender not advance snd_nxt even tho it clearly did
send up to seg 8? tcp_write_xmit() interprets the return code
from the core to mean that data has not been sent at all. Since
TCP deals with GSO super frames, not individual segment the crux
of the problem is that loss of a single segment can be interpreted
as loss of all. TCP only sees the last return code for the last
segment of the GSO frame (in <> brackets in the diagram above).

Of course for the problem to occur we need a setup or a device
without a Qdisc. Otherwise Qdisc layer disconnects the protocol
layer from the device errors completely.

We have multiple ways to fix this.

 1) make veth not return an error when it lost a packet.
    While this is what I think we did in the past, the issue keeps
    reappearing and it's annoying to debug. The game of whack
    a mole is not great.

 2) fix the damn return codes
    We only talk about NETDEV_TX_OK and NETDEV_TX_BUSY in the
    documentation, so maybe we should make the return code from
    ndo_start_xmit() a boolean. I like that the most, but perhaps
    some ancient, not-really-networking protocol would suffer.

 3) make TCP ignore the errors
    It is not entirely clear to me what benefit TCP gets from
    interpreting the result of ip_queue_xmit()? Specifically once
    the connection is established and we're pushing data - packet
    loss is just packet loss?

 4) this fix
    Ignore the rc in the Qdisc-less+GSO case, since it's unreliable.
    We already always return OK in the TCQ_F_CAN_BYPASS case.
    In the Qdisc-less case let's be a bit more conservative and only
    mask the GSO errors. This path is taken by non-IP-"networks"
    like CAN, MCTP etc, so we could regress some ancient thing.
    This is the simplest, but also maybe the hackiest fix?

Fixes: 1f59533f9ca5 ("qdisc: validate frames going through the direct_xmit path")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sdf@fomichev.me
CC: hawk@kernel.org
CC: alexander.h.duyck@intel.com
---
 net/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b..fd700a00c4d9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4832,11 +4832,19 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 			HARD_TX_LOCK(dev, txq, cpu);
 
 			if (!netif_xmit_stopped(txq)) {
+				bool is_list = skb->next != NULL;
+
 				dev_xmit_recursion_inc();
 				skb = dev_hard_start_xmit(skb, dev, txq, &rc);
 				dev_xmit_recursion_dec();
 				if (dev_xmit_complete(rc)) {
 					HARD_TX_UNLOCK(dev, txq);
+					/* GSO segments a single SKB into
+					 * a list of frames. TCP expects error
+					 * to mean none of the data was sent.
+					 */
+					if (is_list && rc > 0)
+						rc = NETDEV_TX_OK;
 					goto out;
 				}
 			}
-- 
2.53.0


