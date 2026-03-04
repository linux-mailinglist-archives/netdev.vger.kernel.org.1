Return-Path: <netdev+bounces-263797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLQJDusfqGlQoQAAu9opvQ
	(envelope-from <netdev+bounces-263797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:04:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D01FF766
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB5EC302C932
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACBC351C1C;
	Wed,  4 Mar 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YScXSqBg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0h2+HkXU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YScXSqBg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0h2+HkXU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13B314D1E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625864; cv=none; b=bCJUNoLDrrvUtNtsn0jy1917Z+iQ5MjlskRfskcRDY6AChpafiFVS58jTGgmfiU+yiMSw9s73U4zI3drZ0PF6R0t3kIw0Qa6agFJvIjqKu7X4SSnZERU62nbgTanWJp5xQ4v1+8RAlxXlLvpf7LRUraoYmIroKEijOY4Bo2LI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625864; c=relaxed/simple;
	bh=67Xrp0u9d33OgxEmG2g86y+w9UQ+1Shs+NBa0hxWSQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pg0XEjQdzxjLwrdopRiqDlCXleFZE2aHGiBQK8/qxjhMIwAPJ1NszLsXLkgZDcqqxvHhfsd+p3bVJch5QR3Mq1ngoUftjcuaWM9lG8HIwG7lwkAnay1+f9ZaRbMYjdZWzqdKrzS+6WGBFDIugUWP2PF1/+FqpOYJfxeHj5zbGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YScXSqBg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0h2+HkXU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YScXSqBg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0h2+HkXU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A8983E7CE;
	Wed,  4 Mar 2026 12:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772625861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD1OCYwk5gzbTYTOeNyV94+f10qcqATMVc8osJETivc=;
	b=YScXSqBg+JA33/Ej9Aw+ZNMlS42def+UOOo3wJm63imHekk82XcDPQTkOWJyB4Q/AmsO3+
	bXDVz2yC7PGqvg0txM8IKS9g6Gi3Kne7d1yLr/05HdIsIG3TpRQ2fIw7lkaA0nyQZjU8rr
	6gxbS4P+YA1hy5heXKU7Bm69eTdGOyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772625861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD1OCYwk5gzbTYTOeNyV94+f10qcqATMVc8osJETivc=;
	b=0h2+HkXU6KD41Ab1gYBwddKswpFwsg3fuhHRJZrsTh6qmNH7+da4n31ZC1OmsuODOeYEEj
	GKqPFTcmEL0Af+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772625861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD1OCYwk5gzbTYTOeNyV94+f10qcqATMVc8osJETivc=;
	b=YScXSqBg+JA33/Ej9Aw+ZNMlS42def+UOOo3wJm63imHekk82XcDPQTkOWJyB4Q/AmsO3+
	bXDVz2yC7PGqvg0txM8IKS9g6Gi3Kne7d1yLr/05HdIsIG3TpRQ2fIw7lkaA0nyQZjU8rr
	6gxbS4P+YA1hy5heXKU7Bm69eTdGOyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772625861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD1OCYwk5gzbTYTOeNyV94+f10qcqATMVc8osJETivc=;
	b=0h2+HkXU6KD41Ab1gYBwddKswpFwsg3fuhHRJZrsTh6qmNH7+da4n31ZC1OmsuODOeYEEj
	GKqPFTcmEL0Af+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 344E73EA69;
	Wed,  4 Mar 2026 12:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sDevCcQfqGkSdQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 04 Mar 2026 12:04:20 +0000
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
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net v3] net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled
Date: Wed,  4 Mar 2026 13:03:57 +0100
Message-ID: <20260304120357.9778-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304120357.9778-1-fmancera@suse.de>
References: <20260304120357.9778-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Rspamd-Queue-Id: AA6D01FF766
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263797-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called
which initializes it. If an IPv6 packet is injected into the interface,
route_shortcircuit() is called and a NULL pointer dereference happens on
neigh_lookup().

 BUG: kernel NULL pointer dereference, address: 0000000000000380
 Oops: Oops: 0000 [#1] SMP NOPTI
 [...]
 RIP: 0010:neigh_lookup+0x20/0x270
 [...]
 Call Trace:
  <TASK>
  vxlan_xmit+0x638/0x1ef0 [vxlan]
  dev_hard_start_xmit+0x9e/0x2e0
  __dev_queue_xmit+0xbee/0x14e0
  packet_sendmsg+0x116f/0x1930
  __sys_sendto+0x1f5/0x200
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x12f/0x1590
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix this by adding an early check on route_shortcircuit() when protocol
is ETH_P_IPV6. Note that ipv6_mod_enabled() cannot be used here because
VXLAN can be built-in even when IPv6 is built as a module.

Fixes: e15a00aafa4b ("vxlan: add ipv6 route short circuit support")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: use ipv6_mod_enabled() instead of a NULL check
v3: go back to nd_tbl NULL check as ipv6_mod_enabled() might not be
available. Added a comment so it doesn't seem random.
---
 drivers/net/vxlan/vxlan_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 05558b6afecd..17c941aac32d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2130,6 +2130,11 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	{
 		struct ipv6hdr *pip6;
 
+		/* check if nd_tbl is not initiliazed due to
+		 * ipv6.disable=1 set during boot
+		 */
+		if (!ipv6_stub->nd_tbl)
+			return false;
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 			return false;
 		pip6 = ipv6_hdr(skb);
-- 
2.53.0


