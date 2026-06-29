Return-Path: <netdev+bounces-302640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P+PIG1xxQmp97QkAu9opvQ
	(envelope-from <netdev+bounces-302640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:21:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A046DB1CA
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:21:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=npc-ksb.ru (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302640-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302640-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1E83154CBA
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D294405C4E;
	Mon, 29 Jun 2026 13:09:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.ksb-soft.ru (mail.ksb-soft.ru [5.167.76.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD21A0BF3;
	Mon, 29 Jun 2026 13:09:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738587; cv=none; b=VdWocNogPMVBfHlGLQLrniM0REmGQwEJ3FoVlcF5DBZ/v/Hcre0wyKy3BQaaYFn8QpMk/4GFExiHg6IPm+mqMJ/3IcZPE9dcIVSG3GUiQB1WQT1KcLJqyyXbGw0+o5yfdH6fPmDEb/ZXUjnZsIzadPpfh650fbcoiYCSQiSXW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738587; c=relaxed/simple;
	bh=3NOBeloPaW0UydJy1E6tJcn6s2vDMmmsShE4mwuUqCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoZOgGJ3aIt3tmtZQiiLXaM3gJUhTa+BCME7EflTn4QCrBs5iSfJqhabgNOLej7tm+VOsawWQV+Zk+PN8xyGVO+XLQjXQmiizQgvtSHtAgs3bUiPrDbphisvRpKYTk2AjuahwdRwUpOOhQvl5RXru31fEMjg8wpl5oYPw6PcvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=npc-ksb.ru; spf=pass smtp.mailfrom=npc-ksb.ru; arc=none smtp.client-ip=5.167.76.63
Received: from ksb-289.ksb.ksb-soft.ru (unknown [10.38.22.14])
	by mail.ksb-soft.ru (Postfix) with ESMTPA id 4gpmpH5FvHz4LKBF;
	Mon, 29 Jun 2026 16:09:43 +0300 (MSK)
From: Markov Gleb <markov.gi@npc-ksb.ru>
To: Jon Maloy <jmaloy@redhat.com>
Cc: Gleb Markov <markov.gi@npc-ksb.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net] tipc: make sure bc_rcvlink is not dereferenced with NULL value
Date: Mon, 29 Jun 2026 16:09:40 +0300
Message-ID: <20260629130942.469-1-markov.gi@npc-ksb.ru>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 197590 [Oct 29 2025]
X-KLMS-AntiSpam-Version: 6.1.1.11
X-KLMS-AntiSpam-Envelope-From: markov.gi@npc-ksb.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 72 0.3.72 80ff96170b649fb7ebd1aa4cb544c36c109810bd, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean
X-KLMS-LinksScanning: Clean
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 10.0.0.7427, bases: 2025/10/29 20:57:00 #27800623
X-KLMS-AntiVirus-Status: Clean, skipped
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[npc-ksb.ru : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:markov.gi@npc-ksb.ru,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[markov.gi@npc-ksb.ru,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302640-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markov.gi@npc-ksb.ru,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,npc-ksb.ru:email,npc-ksb.ru:mid,npc-ksb.ru:from_mime,linuxtesting.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3A046DB1CA

From: Gleb Markov <markov.gi@npc-ksb.ru>

The direct dependence of the tipc_link_is_up() value on l->bc_rcvlink is
not explicitly specified.

If link is up, it is assumed that the sender and receiver have valid
values (communication with the receiver is required for timeout
synchronization), which is not guaranteed in this code segment.

Turning independent conditions into nested conditions ensures that NULL
cannot be dereferenced at tipc_link_build_proto_msg() and allows for the
logical structure to be fixed at the functional interaction level.

Make tipc_link_build_proto_msg() call only if l->bc_rcvlink is not NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 047491ea334a ("tipc: set link tolerance correctly in broadcast link")
Signed-off-by: Gleb Markov <markov.gi@npc-ksb.ru>
---
 net/tipc/link.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 49dfc098d89b..b0a640c419c8 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -2863,10 +2863,12 @@ void tipc_link_set_tolerance(struct tipc_link *l, u32 tol,
 			     struct sk_buff_head *xmitq)
 {
 	l->tolerance = tol;
-	if (l->bc_rcvlink)
+	if (l->bc_rcvlink) {
 		l->bc_rcvlink->tolerance = tol;
-	if (tipc_link_is_up(l))
-		tipc_link_build_proto_msg(l, STATE_MSG, 0, 0, 0, tol, 0, xmitq);
+		if (tipc_link_is_up(l))
+			tipc_link_build_proto_msg(l, STATE_MSG,
+						  0, 0, 0, tol, 0, xmitq);
+	}
 }
 
 void tipc_link_set_prio(struct tipc_link *l, u32 prio,
-- 
2.43.0


