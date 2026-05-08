Return-Path: <netdev+bounces-286010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kELqFbFh/mnCpwAAu9opvQ
	(envelope-from <netdev+bounces-286010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:20:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A81A54FC4A5
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1436D30C17A9
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2BE38F633;
	Fri,  8 May 2026 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArSQhsOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916D39C623
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278446; cv=none; b=A16y219izI9IXT1w9tP+TLMLtOnGNTgjKgyHmaLyAFQpYmE3fvMTDZGUI7zKhJp5QU64oRTKpudoa5bBNapkl1++joFFrVoBlZFnDXFBWswS0lUWUtUQsIGi/hikuvcl7J9J8tlQvSCj098ZeLTtqa6T71eBvZWOVhVGKIbVO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278446; c=relaxed/simple;
	bh=5Ch8ZOqtaX18MwHimx7dw9BnERZbw1QWYyj/akybK0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rotBk6Zl9HU9kW64tUWKGe/hafyltaVZZcAQhkuxE2dTPzt3tpqWpMhkx14Flzu7YbGQgfK376lCQIwTFFHW1BXlbuWVrXLZxKbtxBTKHNa/zXkBuPQR1uKXmjdEObhvxUUSZNkEELnox3WGUVZR1/bbOnelvVRntXRE/YTVp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArSQhsOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A2FC2BCB4;
	Fri,  8 May 2026 22:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278444;
	bh=5Ch8ZOqtaX18MwHimx7dw9BnERZbw1QWYyj/akybK0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ArSQhsOC6cD6URVOQIhCN3f6LV6Kt4XAVBSpNtXVowVyCHecANbSzqLv6GJnVe+W+
	 XoQRfOpY00LTcH0G0b88DmlFYJzx3RCXXiXjaaVo5+fDt6YPFdIB4KC7H3SLcq+M50
	 asl0MqdplO+aykbrKjirzrUWHD63kpNToHHzCCD5tOjw6h6DXaESX3xMJHVsFe0H6s
	 qAmTs3ZS7Sgu995Quh9pWTKTAbdEq53SoX3F1HdCkV2gxWELZZEo+a2rDhsaL/d2Ax
	 apeButTEJb7iQpn07ZjtcuaACIPavN0pr8PWSkFkfRa3ObKWUfTRx14oWfwp9/pYQ/
	 mvCUJMJNh72Jg==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 09 May 2026 00:13:39 +0200
Subject: [PATCH net 4/4] net: ethernet: cortina: Fix budget accounting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-gemini-ethernet-fixes-v1-4-6c5d20ddc35b@kernel.org>
References: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
In-Reply-To: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
To: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: A81A54FC4A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286010-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nebelreich.de,googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rere.qmqm.pl];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

The gmac_rx() function should return the number of packets received,
not the remaining budget, as it currently does.

In gmac_napi_poll(), this return value is assigned to received,
and if received < budget, the driver calls
napi_complete_done(napi, received).

Fix this by adding a new local variable for the number of received
packets in gmac_rx() and return that instead.

This was found by Sashiko during normal patch review.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Link: https://sashiko.dev/#/patchset/20260505-gemini-ethernet-fix-v2-1-997c31d06079%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 4c762229ce42..5839e00aa649 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1450,6 +1450,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
 	struct gmac_queue_page *gpage;
+	unsigned int received = 0;
 	union gmac_rxdesc_0 word0;
 	union gmac_rxdesc_1 word1;
 	union gmac_rxdesc_3 word3;
@@ -1545,7 +1546,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			napi_gro_frags(&port->napi);
 			skb = NULL;
 			frag_nr = 0;
-			--budget;
+			budget--;
+			received++;
 		}
 		continue;
 
@@ -1565,7 +1567,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	port->rx_skb = skb;
 	port->rx_frag_nr = frag_nr;
 	writew(r, ptr_reg);
-	return budget;
+	return received;
 }
 
 static int gmac_napi_poll(struct napi_struct *napi, int budget)

-- 
2.54.0


