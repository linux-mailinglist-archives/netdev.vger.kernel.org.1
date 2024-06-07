Return-Path: <netdev+bounces-101805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF262900225
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9EE1C217F4
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F91618FDAF;
	Fri,  7 Jun 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G6QPPreJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G6QPPreJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89C15D5C4;
	Fri,  7 Jun 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759729; cv=none; b=bpTLF9UOX3w8dbEyiVAjOh685GJjgGKYfu+rYVCotA+z/aiLnV7u0E/tnZNoChokJ1ORRoLn9P/GW+OE5YdWWzyfNb4rVqAj0QWsSM0RC1P+VY4eoiysHbN0Gv2SKZO76TOY/F0bHLE48yElDnaQk+WAYbz7OqR1aWKz/uZOVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759729; c=relaxed/simple;
	bh=lGVekpOpu0hFaMCcw8TXxUtQP82zcqL53fs6/Yj7cuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OYiCXJvHpNfwnFSV4RE391CBdyl1sdwaFb1B6DRkysBVdiHlIWoWG0A2sFUIUHaaTByq+KhR43XbnREqogyWvif8yVfqvIuKVVf3s/7ZONw7MNQxK0AR1+3O3PftCcFh9oaSSNaopDeydF40SXO5igc9rA34T8GvodKOtmDNIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G6QPPreJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G6QPPreJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65C761FB92;
	Fri,  7 Jun 2024 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717759723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qBWJaQMATiMCgZBZiTX1t+DzoiMKislBbI7FLeunnSg=;
	b=G6QPPreJY3nceL5yPpRCJmw30G1yn8kxtLktHkW0KiIn3T8v2sQnUgP0Bc/zA+Gxd1I9UO
	m34OaHUAsIStLQMSM+jmmX8Mx81BNicwzSLiuqMGAQuueyWMYW9qfRdJSVZMQMJTwXNLG3
	ZG+zzpZ/Tm/UvqqxWlBNecdgtKWC+nw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=G6QPPreJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717759723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qBWJaQMATiMCgZBZiTX1t+DzoiMKislBbI7FLeunnSg=;
	b=G6QPPreJY3nceL5yPpRCJmw30G1yn8kxtLktHkW0KiIn3T8v2sQnUgP0Bc/zA+Gxd1I9UO
	m34OaHUAsIStLQMSM+jmmX8Mx81BNicwzSLiuqMGAQuueyWMYW9qfRdJSVZMQMJTwXNLG3
	ZG+zzpZ/Tm/UvqqxWlBNecdgtKWC+nw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4750B13A42;
	Fri,  7 Jun 2024 11:28:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qrYyEevuYmZhSgAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Fri, 07 Jun 2024 11:28:43 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kui-Feng Lee <thinker.li@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH net v2] net/ipv6: Fix the RT cache flush via sysctl using a previous delay
Date: Fri,  7 Jun 2024 13:28:28 +0200
Message-Id: <20240607112828.30285-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: *
X-Spamd-Result: default: False [1.12 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.37)[76.90%];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: 1.12
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 65C761FB92
X-Spamd-Bar: +

The net.ipv6.route.flush system parameter takes a value which specifies
a delay used during the flush operation for aging exception routes. The
written value is however not used in the currently requested flush and
instead utilized only in the next one.

A problem is that ipv6_sysctl_rtcache_flush() first reads the old value
of net->ipv6.sysctl.flush_delay into a local delay variable and then
calls proc_dointvec() which actually updates the sysctl based on the
provided input.

Fix the problem by switching the order of the two operations.

Fixes: 4990509f19e8 ("[NETNS][IPV6]: Make sysctls route per namespace.")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---

Changes since v1 [1]:
- Minimize the fix, correct only the order of operations in
  ipv6_sysctl_rtcache_flush().

[1] https://lore.kernel.org/netdev/20240529135251.4074-1-petr.pavlu@suse.com/

 net/ipv6/route.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f083d9faba6b..952c2bf11709 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6343,12 +6343,12 @@ static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
 	if (!write)
 		return -EINVAL;
 
-	net = (struct net *)ctl->extra1;
-	delay = net->ipv6.sysctl.flush_delay;
 	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
 	if (ret)
 		return ret;
 
+	net = (struct net *)ctl->extra1;
+	delay = net->ipv6.sysctl.flush_delay;
 	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
 	return 0;
 }

base-commit: 8a92980606e3585d72d510a03b59906e96755b8a
-- 
2.35.3


