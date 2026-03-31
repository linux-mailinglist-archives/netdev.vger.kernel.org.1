Return-Path: <netdev+bounces-273501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLV0MOF8y2mLIQYAu9opvQ
	(envelope-from <netdev+bounces-273501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:50:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D783657EA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 282C130F4351
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05A33CBE72;
	Tue, 31 Mar 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="NqFOb71+"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7E3C8709;
	Tue, 31 Mar 2026 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943027; cv=none; b=qzavV+V8E3jSKTH0RMAm25R3DrQEcfM245yp9087EGEfmRLL+ALKC1QSFoHeuNp1YF8nm38bwMLFGFU7xGV4Q+xjADED9IdNj3y8dGN5EvW+Yqdsr1YetKAF63rwif3Was3RCg1ItPjDMn1swaZcT0t7U9iYqT7MhS8myQz1LWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943027; c=relaxed/simple;
	bh=6xZwfUqOa8r+6op3B/IZvVXNg5HjxqI8HhsS8OBhfQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=ITbMKzLKusmUdNu7i6nPqF5+j33LMCIWwykj0mi2rJZqGDXxGkt5JAY/STlYKW5HEQInSmsopm59RGY+zHfor/ja8bY+TpqHrFMnigy/LdGcfgnN1pi8KrSKhZaQYG+GIWzl41ztWfFDFv+zMgdrHpnLx9r2USnpos+1IB0aGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=NqFOb71+; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=656447fc3f=ms@dev.tdt.de>)
	id 1w7Tl6-00FWkA-5i; Tue, 31 Mar 2026 09:43:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1w7Tl5-00GjaX-2Y; Tue, 31 Mar 2026 09:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774943010;
	bh=pauIbvWEvYDpHnmH5QLgiqWyOK2Mnf6AySmHb4La+Qw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NqFOb71+fFym7EVuCvt4M9NtwiAtKVK0yomgPBKMg32aZJKsPm3SPuiZPekA9PbX4
	 4HwTGj+zjhEV0mj0k2w/zFVhtp2GtbetpUG3amAKWd09Xn/+NnADTk4fl1So9MMST8
	 Lg9U1J6S15Ut5LaGXU5SlCJq8aG3Nb666NE3MtdZmRpJpxt9R9ME7kFgb88o2KLP/V
	 K3HI/SBctn+OWEmncwBnzj+mcGluLDO/bWSt9W3eGoHOpzPC6skF6zye3RSgwIH5Tw
	 44eILyLDM0wf/vMZLQzRYxaImrQwoWnMntKJEB/x82/jbT8l8hQRvfnUA8A1NEiqmE
	 dhKbAJtxn6U/A==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 7A2C1240036;
	Tue, 31 Mar 2026 09:43:30 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 653DD240045;
	Tue, 31 Mar 2026 09:43:30 +0200 (CEST)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 492DE20BF0;
	Tue, 31 Mar 2026 09:43:30 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 31 Mar 2026 09:43:18 +0200
Subject: [PATCH net v4 2/2] net/x25: Fix overflow when accumulating packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260331-x25_fraglen-v4-2-3e69f18464b4@dev.tdt.de>
References: <20260331-x25_fraglen-v4-0-3e69f18464b4@dev.tdt.de>
In-Reply-To: <20260331-x25_fraglen-v4-0-3e69f18464b4@dev.tdt.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Yiming Qian <yimingqian591@gmail.com>, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, Martin Schiller <ms@dev.tdt.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774943009; l=1413;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=6xZwfUqOa8r+6op3B/IZvVXNg5HjxqI8HhsS8OBhfQA=;
 b=dhSZ7ZqbyLyM3u1rCYg53A/vD2dImU2miS7SQ3GP/sDhR8VKpdayKVwO/TDL3SZpqhhz+xhRO
 StwfYOMCnfiB4N4DQO1kVrDTsV0yM8AoxZT+YrF9D42L1MbQcjYItMW
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate-ID: 151534::1774943011-41C71BD0-3D48CDD2/0/0
X-purgate-type: clean
X-purgate: clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tdt.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dev.tdt.de:s=z1-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev.tdt.de:dkim,dev.tdt.de:mid,tdt.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[dev.tdt.de:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273501-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@dev.tdt.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 37D783657EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a check to ensure that `x25_sock.fraglen` does not overflow.

The `fraglen` also needs to be resetted when purging `fragment_queue` in
`x25_clear_queues()`.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/x25_in.c   | 4 ++++
 net/x25/x25_subr.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index 0dbc73efab1cbd4d98fa77d7a72a2b665203511b..e47ebd8acd21bff8d8fa1f5f48163145e9ac00f2 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -34,6 +34,10 @@ static int x25_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 	struct sk_buff *skbo, *skbn = skb;
 	struct x25_sock *x25 = x25_sk(sk);
 
+	/* make sure we don't overflow */
+	if (x25->fraglen + skb->len > USHRT_MAX)
+		return 1;
+
 	if (more) {
 		x25->fraglen += skb->len;
 		skb_queue_tail(&x25->fragment_queue, skb);
diff --git a/net/x25/x25_subr.c b/net/x25/x25_subr.c
index 0285aaa1e93c17233748d38eef6d8b5c6059b67a..159708d9ad20cb2e6db24ead67daf1e9d6258f64 100644
--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -40,6 +40,7 @@ void x25_clear_queues(struct sock *sk)
 	skb_queue_purge(&x25->interrupt_in_queue);
 	skb_queue_purge(&x25->interrupt_out_queue);
 	skb_queue_purge(&x25->fragment_queue);
+	x25->fraglen = 0;
 }
 
 

-- 
2.47.3


