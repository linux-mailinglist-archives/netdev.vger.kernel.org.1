Return-Path: <netdev+bounces-278196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMnDM0ZY3WkFcQkAu9opvQ
	(envelope-from <netdev+bounces-278196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:55:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC9C3F34ED
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87687301E59D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099983542E5;
	Mon, 13 Apr 2026 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R5NPeSwW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PapF0tXU"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F032D37D13B;
	Mon, 13 Apr 2026 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113383; cv=none; b=PHPpG0hdL8h08I3H7zeMberhVxwJUcjrujzYSwMxjG9XtzJPLb/FNOIypwkIVcX6LAd5I1GUlFUQW4DgHZiaix7OLZEKG1MroenMpmk4ngOE4IgHae2oNt8e8QzTkfaEdYpp41hq/4TiEcec4/0ZPqRQ20ZBwe32++F64rAvpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113383; c=relaxed/simple;
	bh=thEdE0AX0jq70kB6cY35yXTDsolWS1aASokLMnGXxvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2nHB6bybZyOymXY3E8SXfaAo5gNgCfAUFQsavsUhpQGX6grYED88JBIsf36/j7cXrDOJ6wcu1M6kASxMVahrkE8ZHGKt9JGdVaSG4UlIkAnYTrV9WG/c5Cw3cFSDLg3SJqDwml9l74gj18jlxLTpzJJ20i7SR+k9QLT+ooNR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=R5NPeSwW; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PapF0tXU; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fvffW3nFrzB10l;
	Mon, 13 Apr 2026 22:49:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776113379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPzDNs20YHy6md5qVjMdfVhTcw1yGtolflwE5KLDaek=;
	b=R5NPeSwWQzjm5SwQQ39jAI8yc96Q27z7K0URKCCfEvYw0cl0RLWqendf57chq+P9mUed3v
	xc8I2IkE4woQZ0/tkc6Qu3XUs3KnsIilrs93q+VZ0aW5SwAt9yvcNgrzXZXUcSF2JOikSk
	X+lwLzGGj7iD5ezCeUwGqe11nt2U+ozqmiIRbKutjlSnZ7kLw3xI6VRkZ7zhESQc/hMa92
	yE0K6WiBY3jB459upImfwuGAhN3rEN+XU/jO8MiRSz2kfew6CRYeEQEFAN33N9gwiDSdc+
	kG8Ska3QprWDWiwroiDPuGD1qRigvAvfoejk70hyvdRUK8O/67Bdoa9Gon2DXA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=PapF0tXU;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776113378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPzDNs20YHy6md5qVjMdfVhTcw1yGtolflwE5KLDaek=;
	b=PapF0tXUaFZLbo9Fa+wwww6TAFaWjvxEgRE1/NoTWpZzz/gxmJ9xEOCXUA34KQ6SmsmFHv
	O5TJMmFWpQcjS2i1feRM08bFbq3jvHwTG70mbnMIvr9memvD8bFSJy//impNymsoLm8oBs
	1W1iRejTu1nZ8AjcrgRs29QjhNBYQ++yl55ORbNH3hlHwr5mEazRsI7is9h2vFAbh3zLFH
	s9T7YQM8D85az5EcTUlVWac3e/whgd4M4844+2la3jHSoO4NuKX57Lv5c4r8ez3lML10EF
	5V35KQ9haYyOv2PAcSrMg7dobfqRmk+4HNeWiZkTed938nNjhiI+nuICXfjGAA==
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH v4 net] net: ax25: fix integer overflow in ax25_rx_fragment()
Date: Tue, 14 Apr 2026 04:49:21 +0800
Message-ID: <20260413204921.70463-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260409025026.24575-1-mashiro.chen@mailbox.org>
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0a4014a6af2aafea67d
X-MBO-RS-META: xe3pi1esh84mjy5n7zpm3hrnafiq6g1g
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278196-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid]
X-Rspamd-Queue-Id: 3BC9C3F34ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ax25_rx_fragment() accumulates fragment lengths into ax25_cb->fraglen,
which is an unsigned short. When the total exceeds 65535, fraglen wraps
around to a small value. The subsequent alloc_skb(fraglen) allocates a
too-small buffer, and skb_put() in the copy loop triggers skb_over_panic().

Add pskb_may_pull(skb, 1) at function entry to ensure the segmentation
header byte is in the linear data area before dereferencing skb->data.
This also rejects zero-length skbs, which the original code did not
check for.

Two issues in the overflow error path are also fixed:
First, the current skb, after skb_pull(skb, 1), is neither enqueued
nor freed before returning 1, leaking it. Add kfree_skb(skb) before
the return.
Second, ax25->fraglen is not reset after skb_queue_purge(). Add
ax25->fraglen = 0 to restore a consistent state.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 net/ax25/ax25_in.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index d75b3e9ed93de8..e1834e11bb0b6a 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -35,12 +35,22 @@ static int ax25_rx_fragment(ax25_cb *ax25, struct sk_buff *skb)
 {
 	struct sk_buff *skbn, *skbo;
 
+	if (!pskb_may_pull(skb, 1))
+		return 0;
+
 	if (ax25->fragno != 0) {
 		if (!(*skb->data & AX25_SEG_FIRST)) {
 			if ((ax25->fragno - 1) == (*skb->data & AX25_SEG_REM)) {
 				/* Enqueue fragment */
 				ax25->fragno = *skb->data & AX25_SEG_REM;
 				skb_pull(skb, 1);	/* skip fragno */
+				if (ax25->fraglen + skb->len > USHRT_MAX) {
+					kfree_skb(skb);
+					skb_queue_purge(&ax25->frag_queue);
+					ax25->fragno = 0;
+					ax25->fraglen = 0;
+					return 1;
+				}
 				ax25->fraglen += skb->len;
 				skb_queue_tail(&ax25->frag_queue, skb);
 
-- 
2.53.0


