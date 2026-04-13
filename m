Return-Path: <netdev+bounces-278048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEhXMjDR3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:19:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC23EB2E8
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AB003011BCE
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55353C0612;
	Mon, 13 Apr 2026 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uz2XcsZQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xNyi3Z38"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5853BF682;
	Mon, 13 Apr 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078927; cv=none; b=i7kvi75zmKWcGtBrR6WZCSvDlyaPRveDtCJrO/et6KULHsCCW1M5TPm7V50s0/TNaTThtzC87XS8VtB4Je9IKaqgITnkuT11y94UUU7NqItbk+ohc7rj10qswgpeZw5CcWPHYg1EpHh5WxOT19s2sjk4XiC2ub/lzmJ5o+ODlqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078927; c=relaxed/simple;
	bh=n1bzbaf2oE+WcxyZxGuiHyoT2wDBeth4b7RSGHZ5ilc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LszKNjE/H92z0xEvOutEfroYvOjm+eqtBCDabLm+qr5FEQCb2JBwNl+aucXqUBT7YUC8JdMM0w6nnZGS/g6mUmHblQsBauZS1nVXMqZYeOl7gp+ptYcXnqe4mS6wV4F5lfk+h1kvlV2Kd+kS6oT2orRh7/8QHST01vWYkv3z85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uz2XcsZQ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xNyi3Z38; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fvPvp1tTRzB0df;
	Mon, 13 Apr 2026 13:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776078918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xEbpfYUwB8/DzHPZ5IQma7S1iSPSS7KmZHqtTedekU=;
	b=uz2XcsZQIQXO5jylhiNVNB1X1PBwo1gUb9Db0xN3UHwK40wBKl+OVbSr8qNCAxKQKT3jb3
	sRC+YG24VSJz+GApcf4AQbLEujdaUwkQg/jSDLmsfooh0TKZhhzZdZ5ijFNzafyh6JdCaV
	MnFz3O34Z8O2py0Ls2NM/NrD9nOwIDojTtpxaPzMW1Xugo0efsEcxbuG0pED2i+WXr4Ux6
	MJB4t0hcJoZbqyL7gNCSgwCk/JlrC0AqBgzSvHkMpq/XMad/zFr7KWU48wmJP4R3Dnli9t
	u2F4+qjVJxOzrbNXDsd6RQnL2ymGOgnuMtfxZxs7taYhp3PsjOhVOmwAdjlZJw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xNyi3Z38;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776078916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xEbpfYUwB8/DzHPZ5IQma7S1iSPSS7KmZHqtTedekU=;
	b=xNyi3Z38nzUr+Z9UDLYs/OQFrlLgXZHWkN3Tu80KUWO1jBMvm3zh1b5UEw3YtVOvUPRRmn
	KL9x01ordaE5XgIeeORwBQVuj4SLEPwM2bq+pJsKMXLzOd0Pw5AcUemCBKHudAWG2MC1C4
	4SSW3rp3b2wyULi1nOoYeKeSvsXCNnOwBy+ag8pa9+wEyyizmButBeCJmKExonz2D/d4HU
	16kcsjQ0YwMbZstK0yVfzk0sKvw6H2+gqE5r1KCo0dHj7VjEQKpfXxuTG7NTxqf36rvsaN
	rC0RUmp/oCjaQvM2ufcX/3SUlXvdwLWN8/UpiZlXwmIVTtWBJqOdU5mV0DAxiQ==
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH v3 net] net: ax25: fix integer overflow in ax25_rx_fragment()
Date: Mon, 13 Apr 2026 19:14:56 +0800
Message-ID: <20260413111456.936572-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260409025026.24575-1-mashiro.chen@mailbox.org>
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g8i9tmzc6px3j95ff6ijy3k8zwsmosy7
X-MBO-RS-ID: e541de843c4ea1dcdd6
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278048-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 18DC23EB2E8
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

Three issues in the overflow error path are also fixed:
First, the current skb, after skb_pull(skb, 1), is neither enqueued
nor freed before returning 1, leaking it. Add kfree_skb(skb) before
the return.
Second, ax25->fraglen is not reset after skb_queue_purge(). Add
ax25->fraglen = 0 to restore a consistent state.
Third, the explicit (unsigned int) cast on fraglen is unnecessary: the
addition with skb->len (unsigned int) promotes fraglen automatically.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 net/ax25/ax25_in.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index 68202c19b19e3f..e1834e11bb0b6a 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -35,15 +35,20 @@ static int ax25_rx_fragment(ax25_cb *ax25, struct sk_buff *skb)
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
-				if ((unsigned int)ax25->fraglen + skb->len > USHRT_MAX) {
+				if (ax25->fraglen + skb->len > USHRT_MAX) {
+					kfree_skb(skb);
 					skb_queue_purge(&ax25->frag_queue);
 					ax25->fragno = 0;
+					ax25->fraglen = 0;
 					return 1;
 				}
 				ax25->fraglen += skb->len;
-- 
2.53.0


