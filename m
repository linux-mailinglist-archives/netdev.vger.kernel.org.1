Return-Path: <netdev+bounces-265979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENZtJD/vr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:15:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D3249387
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8607D3028C27
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB4E313298;
	Tue, 10 Mar 2026 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OK8L4NwS"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB544D68A
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137664; cv=none; b=EQMYZjAJUW+laArYq33jxLPPD7SgJVHla1A0OvL6auZ0/X+QV8YKL+Ko/AHdPZYoWftydsebEZZ1mPWDmdf7M7wEfUSOdKfAjr4gGFjY2K0oQScocZ61Z7stdhlsdZ6fbUY8BAKhG16OTiMqYO4Ga9YUb2P7iO9nRCCdivDp2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137664; c=relaxed/simple;
	bh=yh1LJIfDSSAGHyYfPKCOT1kwZP9P+dzXxSY102llsQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REy/IVBvD0mXxuVstkSMUhZp4kZ6gW87lPbxnap8K79Oa0YqJhGRsGTvHDu7CIa0Nb2D0M2dpZbiGQTO5Y17DWVt6RJJXf6cUf39/GPDXdCdtwTWsAv4wLh2+EIPeFtMxGMiOqQ/f/J98l1cZv8fGTqeeZvuJHj8jF0SwzZMbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OK8L4NwS; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773137649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tObpRz/Na5bGVzLqdSA8Kb2JzYo1dXe+V71yWHqAFSM=;
	b=OK8L4NwSUbdpfFrQr5CNEQXfP4tsYZN9OaCoVMPMVrouC7FAvhzWPgzaz/527GvE0fdj2a
	nXLC6zePi3McebBPIi6EiKHnrwV6Iti3OZ6KmXLOITy+6XWr3g68po6InSFEPSYvqN2aqq
	OytPOpgDS0nwQQOydTRDqeCRe6cg/yU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Takamitsu Iwai <takamitz@amazon.co.jp>,
	Pwnverse <stanksal@purdue.edu>,
	Ingo Molnar <mingo@kernel.org>,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
Date: Tue, 10 Mar 2026 18:13:40 +0800
Message-ID: <20260310101349.50993-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 969D3249387
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-265979-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,d00f90e0af54102fb271];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,syzkaller.appspot.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

syzkaller reported a bug [1], and the reproducer is available at [2].

When rose_connect() is called a second time on an already-connecting
socket, it overwrites rose->neighbour with the result of rose_get_neigh()
without releasing the previous reference. If rose_get_neigh() returns
NULL, the socket is left in an inconsistent state: rose->state remains
ROSE_STATE_1 from the first connect while rose->neighbour is NULL.

When the socket is subsequently closed, rose_release() sees ROSE_STATE_1
and calls rose_write_internal() -> rose_transmit_link(skb, NULL), causing
a NULL pointer dereference when accessing neigh->loopback.

Fix this by:
1. Releasing the old neighbour reference before attempting a reconnect
2. Resetting rose->state to ROSE_STATE_0 before the new connect attempt,
   so a failure leaves the socket in a clean state
3. Setting rose->neighbour to NULL in all error paths after
   rose_neigh_put() to prevent use-after-free on subsequent reconnects

[1] https://syzkaller.appspot.com/bug?extid=d00f90e0af54102fb271
[2] https://gist.github.com/mrpre/9e6779e0d13e2c66779b1653fef80516

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69694d6f.050a0220.58bed.0027.GAE@google.com/T/
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/rose/af_rose.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 841d62481048..d9bf32ac3df3 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -814,6 +814,14 @@ static int rose_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 	sk->sk_state   = TCP_CLOSE;
 	sock->state = SS_UNCONNECTED;
 
+	/* Release previous neighbour ref if reconnecting */
+	if (rose->neighbour) {
+		rose_neigh_put(rose->neighbour);
+		rose->neighbour = NULL;
+	}
+
+	rose->state = ROSE_STATE_0;
+
 	rose->neighbour = rose_get_neigh(&addr->srose_addr, &cause,
 					 &diagnostic, 0);
 	if (!rose->neighbour) {
@@ -825,6 +833,7 @@ static int rose_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 	if (!rose->lci) {
 		err = -ENETUNREACH;
 		rose_neigh_put(rose->neighbour);
+		rose->neighbour = NULL;
 		goto out_release;
 	}
 
@@ -837,6 +846,7 @@ static int rose_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 		if (!dev) {
 			err = -ENETUNREACH;
 			rose_neigh_put(rose->neighbour);
+			rose->neighbour = NULL;
 			goto out_release;
 		}
 
@@ -844,6 +854,7 @@ static int rose_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
 		if (!user) {
 			err = -EINVAL;
 			rose_neigh_put(rose->neighbour);
+			rose->neighbour = NULL;
 			dev_put(dev);
 			goto out_release;
 		}
-- 
2.43.0


