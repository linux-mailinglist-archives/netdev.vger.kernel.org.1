Return-Path: <netdev+bounces-263796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGHNE8MfqGlQoQAAu9opvQ
	(envelope-from <netdev+bounces-263796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:04:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E034E1FF75E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC115301DECC
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D5331220;
	Wed,  4 Mar 2026 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0apy2m3Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T2e36t6H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0apy2m3Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T2e36t6H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3751E5B68
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625856; cv=none; b=eZH3jci8jQ2/J2gIUpQv1LYL37fvtiADd9z6RwDYhH1LUhkKyfPyR+UxGTI/6cmg9TYKtq4dm+y9FKdVbKEiqlyBobjCmc5wEtIhlAN/jozXbe9bI9sV00a6WGtgkPUQksEZm1rhJEbBK/6FMgEjnVHTD5SdIJmtUGUDLwO/Bbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625856; c=relaxed/simple;
	bh=EIyl4fXrw5ijQxrMYho3kOi07CSN4zRY4ukIwx7/O4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3eFdHjC5xTg/L68uyAJLQn8z34psTVAtkbyiV9j3VvI3PUtBQ7FyO2MDW1XpJWIymgW2t3bRAp+kjwP2s4dtbt5shddKQd/P7+BOVlr4PRNWbh1UNtWLAo4i2y0js9Rw/mLmftabZzo+3pw3hBXfZHsG8AlO2dhy5m3uKXWVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0apy2m3Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T2e36t6H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0apy2m3Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T2e36t6H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A4733E7CE;
	Wed,  4 Mar 2026 12:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772625853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTjAKaYbkWr+nPD3XLiDK+enNzrWG9oyzkZ1dT/C4NE=;
	b=0apy2m3QCPHfCIzMnNNZG9yKm0pn6OPt8R3gn1CyL4mxysM4XJC5wiFmGvkb4C+K/NZEg4
	gqW1xyfD+0wGIZ9u6KxJxl6fNxJEDBB7rwci7Yzz4yAvqkxIxaLaKMd2CGpItf34tbVxqq
	4EvLagFSdlQIopoi3HAHPQT9uD2yZkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772625853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTjAKaYbkWr+nPD3XLiDK+enNzrWG9oyzkZ1dT/C4NE=;
	b=T2e36t6HmmeRWZsDMGqUMXEhp/Gu/w8WIECWuuzt2JHiHi3zimwLRvoRNuR1JbxfI/atGP
	kUZaiv9bN/rxHfCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0apy2m3Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T2e36t6H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772625853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTjAKaYbkWr+nPD3XLiDK+enNzrWG9oyzkZ1dT/C4NE=;
	b=0apy2m3QCPHfCIzMnNNZG9yKm0pn6OPt8R3gn1CyL4mxysM4XJC5wiFmGvkb4C+K/NZEg4
	gqW1xyfD+0wGIZ9u6KxJxl6fNxJEDBB7rwci7Yzz4yAvqkxIxaLaKMd2CGpItf34tbVxqq
	4EvLagFSdlQIopoi3HAHPQT9uD2yZkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772625853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eTjAKaYbkWr+nPD3XLiDK+enNzrWG9oyzkZ1dT/C4NE=;
	b=T2e36t6HmmeRWZsDMGqUMXEhp/Gu/w8WIECWuuzt2JHiHi3zimwLRvoRNuR1JbxfI/atGP
	kUZaiv9bN/rxHfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5D493EA69;
	Wed,  4 Mar 2026 12:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HcVqKbwfqGkSdQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 04 Mar 2026 12:04:12 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	roopa@cumulusnetworks.com,
	sdf@fomichev.me,
	petrm@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	razor@blackwall.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Guruprasad C P <gurucp2005@gmail.com>
Subject: [PATCH 1/2 net v3] net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled
Date: Wed,  4 Mar 2026 13:03:56 +0100
Message-ID: <20260304120357.9778-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Rspamd-Queue-Id: E034E1FF75E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,cumulusnetworks.com,fomichev.me,nvidia.com,kernel.org,blackwall.org,redhat.com,google.com,davemloft.net,lunn.ch,suse.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263796-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called
which initializes it. Then, if neigh_suppress is enabled and an ICMPv6
Neighbor Discovery packet reaches the bridge, br_do_suppress_nd() will
dereference ipv6_stub->nd_tbl which is NULL, passing it to
neigh_lookup(). This causes a kernel NULL pointer dereference.

 BUG: kernel NULL pointer dereference, address: 0000000000000268
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 [...]
 RIP: 0010:neigh_lookup+0x16/0xe0
 [...]
 Call Trace:
  <IRQ>
  ? neigh_lookup+0x16/0xe0
  br_do_suppress_nd+0x160/0x290 [bridge]
  br_handle_frame_finish+0x500/0x620 [bridge]
  br_handle_frame+0x353/0x440 [bridge]
  __netif_receive_skb_core.constprop.0+0x298/0x1110
  __netif_receive_skb_one_core+0x3d/0xa0
  process_backlog+0xa0/0x140
  __napi_poll+0x2c/0x170
  net_rx_action+0x2c4/0x3a0
  handle_softirqs+0xd0/0x270
  do_softirq+0x3f/0x60

Fix this by replacing IS_ENABLED(IPV6) call with ipv6_mod_enabled() in
the callers. This is in essence disabling NS/NA suppression when IPv6 is
disabled.

Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Reported-by: Guruprasad C P <gurucp2005@gmail.com>
Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: use ipv6_mod_enabled() instead of a null check and replace the check
on the caller
v3: no changes
---
 net/bridge/br_device.c | 2 +-
 net/bridge/br_input.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index ee01122f466f..f7502e62dd35 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -74,7 +74,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	     eth_hdr(skb)->h_proto == htons(ETH_P_RARP)) &&
 	    br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
 		br_do_proxy_suppress_arp(skb, br, vid, NULL);
-	} else if (IS_ENABLED(CONFIG_IPV6) &&
+	} else if (ipv6_mod_enabled() &&
 		   skb->protocol == htons(ETH_P_IPV6) &&
 		   br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED) &&
 		   pskb_may_pull(skb, sizeof(struct ipv6hdr) +
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 1405f1061a54..2cbae0f9ae1f 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -170,7 +170,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	    (skb->protocol == htons(ETH_P_ARP) ||
 	     skb->protocol == htons(ETH_P_RARP))) {
 		br_do_proxy_suppress_arp(skb, br, vid, p);
-	} else if (IS_ENABLED(CONFIG_IPV6) &&
+	} else if (ipv6_mod_enabled() &&
 		   skb->protocol == htons(ETH_P_IPV6) &&
 		   br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED) &&
 		   pskb_may_pull(skb, sizeof(struct ipv6hdr) +
-- 
2.53.0


