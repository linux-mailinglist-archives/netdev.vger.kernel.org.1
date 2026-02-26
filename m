Return-Path: <netdev+bounces-261634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Df+OkHaoGk+ngQAu9opvQ
	(envelope-from <netdev+bounces-261634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:41:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBAC1B0FA7
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A473D3068ED1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC423314A4;
	Thu, 26 Feb 2026 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o9BtI0GB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3d5gGFqq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o9BtI0GB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3d5gGFqq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4B331217
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149284; cv=none; b=KyN2kiEO+eowWtJPsaZxFK+ne6CTk8Q3V71Iwr13oK6x4cYK56kLNdyudVD/7ABlcns/dMpm5THsRcFwc1erIocJ8VlhZtSFI8u4nRSt201BPTeo9TVYEPp+Zgn17O+egh2JX+rQGaGIASIhrLCt6l59/Ig9vdrweWT8xQ7hWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149284; c=relaxed/simple;
	bh=t+/KKK/QywuiWInxJ/ygAyUdUV+YFs2CCpu4dOtyVUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOlAppwOVx/ExuDA8Sb2SXOvPBV0r1ZuPFqLEkx5x4EthuwzCFQ7+QFuLLAtsnVdOKJ/0+mC3sM7fdf5FNuY/yDWvLQTyKI9ID+gpctUgEY2g2BKeNQNwG6mWdMduqvNtWibR+SQ1y0bSqmSwVbfG9EMekT3/EAKTs8qjokdGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o9BtI0GB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3d5gGFqq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o9BtI0GB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3d5gGFqq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C866E3F770;
	Thu, 26 Feb 2026 23:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772149281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KIUojCn/VfAaNbXQUA5b8xf9/uavvlDywgk/Hl1k1rA=;
	b=o9BtI0GBt3iIKkQXOxFChEJBk20P9zrsOYw/sCqM6ghtZpkUTU77s/eLvxHNpMCmRKBQyD
	eBCEu9UIjC0iZFdFvA7Hr8ubjHdkBq2lbW36PNmtXrRnfTm5AUggtS5kgcwPhFFV8K7/6i
	ylATzjnlvUDf4PnorDVYN1tTuEpHYFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772149281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KIUojCn/VfAaNbXQUA5b8xf9/uavvlDywgk/Hl1k1rA=;
	b=3d5gGFqqCLA0ODRSX03h1HhAfCyZuqikL1hbjGY8G3N01cuBuI6WjLsdYpsZgLL5HErE57
	SFpL9mztegOLZYCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772149281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KIUojCn/VfAaNbXQUA5b8xf9/uavvlDywgk/Hl1k1rA=;
	b=o9BtI0GBt3iIKkQXOxFChEJBk20P9zrsOYw/sCqM6ghtZpkUTU77s/eLvxHNpMCmRKBQyD
	eBCEu9UIjC0iZFdFvA7Hr8ubjHdkBq2lbW36PNmtXrRnfTm5AUggtS5kgcwPhFFV8K7/6i
	ylATzjnlvUDf4PnorDVYN1tTuEpHYFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772149281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KIUojCn/VfAaNbXQUA5b8xf9/uavvlDywgk/Hl1k1rA=;
	b=3d5gGFqqCLA0ODRSX03h1HhAfCyZuqikL1hbjGY8G3N01cuBuI6WjLsdYpsZgLL5HErE57
	SFpL9mztegOLZYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 166803EA62;
	Thu, 26 Feb 2026 23:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id //88AiHaoGmPTQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 26 Feb 2026 23:41:21 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	roopa@cumulusnetworks.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	razor@blackwall.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net] net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled
Date: Fri, 27 Feb 2026 00:40:59 +0100
Message-ID: <20260226234059.19402-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FBAC1B0FA7
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

Fix this by adding a check before br_is_local_ip6() or neigh_lookup()
call. If ipv6_stub->nd_tbl is NULL, return immediately.

Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: I am investigating more places where this might be happening too.
---
 net/bridge/br_arp_nd_proxy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 1e2b51769eec..ed756518cee0 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -437,6 +437,12 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		return;
 	}
 
+	/* IPv6 disabled at boot, return before calling into br_is_local_ip6()
+	 * or neigh_lookup()
+	 */
+	if (!ipv6_stub->nd_tbl)
+		return;
+
 	if (vid != 0) {
 		/* build neigh table lookup on the vlan device */
 		vlandev = __vlan_find_dev_deep_rcu(br->dev, skb->vlan_proto,
-- 
2.53.0


