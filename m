Return-Path: <netdev+bounces-273074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M1zA1cSymn54wUAu9opvQ
	(envelope-from <netdev+bounces-273074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:04:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0A355D13
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A1230063AE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87D392C3C;
	Mon, 30 Mar 2026 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjhY0RdT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B13391826
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774850433; cv=none; b=QoMAZr6lQsqIocoaVyTr96Yc+4Fd++9aaqwJOhlUwPFwP2HwHHZh6dm0nf6ZP240+WmXoA2VwFMkcJpP92n3Etw2VMpwlXpBRrXsFMrGkSrSjzTJXy9JPELGdVwN3ZQWq3dL0WPBDCNqlFxUbQNIUFR7uMPmV98wYlxW5qbCKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774850433; c=relaxed/simple;
	bh=MtA7daWwhSx1HAEKj0tFdWyfwEFe4uO0E13RPKrKK7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z/E83/Q4shNR0i593eDSjK9OstOcIwmwiC9+J5qx7I5jcSxHpAKKVgqqx2cFSESvC5USvf7ODuSESc9cCYXL5aGLRmt5DoD8STCGv+iFm2fOsDYsnMu72pLwXZOOlD/gkSuj2SHuPRydwnTpYPy2z0OB9BA8YqJUSi+v2BqF7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjhY0RdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36EBC4CEF7;
	Mon, 30 Mar 2026 06:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774850432;
	bh=MtA7daWwhSx1HAEKj0tFdWyfwEFe4uO0E13RPKrKK7Y=;
	h=From:Date:Subject:To:Cc:From;
	b=OjhY0RdTwTvuePNbdDFzhk1G/jRqkif/pIizSXYqQ7ElK4XQk5FXWwY2IAIvht6tX
	 24vhCXP6Rhi2Scz9hDwK7H1Ct16X0JGMUWGnHP5KgY2fPyJEUHpajvxJYGFcvJ0gz8
	 l9CXYNU7yfMfTs20SaTidM81dArhPx4PpFJcoB+aC2/zYxCh1pUoDF/KVAzRQYfG5+
	 q1/Tzb/SnXMe+gny0ki3sbR+B1lSJSQPTkll4bJF0Yc1BsLsXMqrje+rKJLeH/CZNF
	 3lf85msSpnKF6/YT45VISMknysxjRFtKbrJFFXUy23ijVJ6L7YEmDgUeI3DizwjLA6
	 lEBl7W5vFt1+g==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 30 Mar 2026 08:00:29 +0200
Subject: [PATCH net] net: ethernet: cortina: Fix SKB leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-gemini-ethernet-fix-v1-1-18783a45d13a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAwEvyI5G6itivgV8VDqqjlYpRURxL8bP
 M4yOw9lJEGmvngo4ZIse1SoyoLC6uMClkmZrLGtcc7wgk2iMM4VKeLkWW5uTR1sFxo3+Yr0eST
 o/FcHUonG9/0AqHSZoGoAAAA=
X-Change-ID: 20260330-gemini-ethernet-fix-604c28c53da1
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, 
 Andreas Haarmann-Thiemann <eitschman@nebelreich.de>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rere.qmqm.pl];
	TAGGED_FROM(0.00)[bounces-273074-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 65C0A355D13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>

Under sustained RX load (e.g. large file transfers over the network), the
device freezes completely and requires a hard power cycle. No kernel panic
or oops is produced; the system simply stops responding.

In gmac_rx() (drivers/net/ethernet/cortina/gemini.c), when
gmac_get_queue_page() returns NULL for the second page of a multi-page
fragment, the driver logs an error and continues — but does not free the
in-progress skb that was already being assembled via napi_build_skb() /
napi_get_frags():

    gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
    if (!gpage) {
        dev_err(geth->dev, "could not find mapping\n");
        /* BUG: skb leaked here */
        port->stats.rx_dropped++;
       continue;
    }

This path is distinct from the similar block in gmac_cleanup_rxq(), which
correctly only logs "could not find page" without an skb in flight.

Each occurrence of this error path leaks one skb. Under sustained traffic
the leak exhausts kernel memory, causing the observed lockup.

Free the in-progress skb via napi_free_frags() before continuing, matching
the pattern already used elsewhere in the driver.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 4824232f4890..723d90d5fdf3 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1491,6 +1491,10 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
 		if (!gpage) {
 			dev_err(geth->dev, "could not find mapping\n");
+			if (skb) {
+				napi_free_frags(&port->napi);
+				skb = NULL;
+			}
 			continue;
 		}
 		page = gpage->page;

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260330-gemini-ethernet-fix-604c28c53da1

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


