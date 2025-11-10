Return-Path: <netdev+bounces-237369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F6C49B33
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EB0D4E5052
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CC72F7471;
	Mon, 10 Nov 2025 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DVWvv1nK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YIv0JnK1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0z5SNQzY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IRALhA0C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13E2F60DD
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815909; cv=none; b=cHiZD8yJozep39ZaJjLQuxdFaYkR4Xlscy31NYTaPiX7Xazg7E/ThSASMllET/f9HLeUGOVxM0M4VZoYQmt0iunzrkZjUtJaFJS3/cYXMdWH11yr6uU04izvcrH1FE8GQOrLSArXPep/iM77LV+3Jdsuo/th21K00P5zu7+TuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815909; c=relaxed/simple;
	bh=k/BOiYoNfLAYWwwI6bI4Z3N/NzJn6I7bPUZkXezPxHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2JUUC9vgWNDTCdUdUpQsj7P6tbO5dgKvFLJh83I0gQbgHf7XiiVmaTCIup4+PGw0TUfoZy0vFoWwLof0HmdPhHZOfngoVRr+B/xMjh3dzUkf3JMyrSAbhjPrIzx9c89zlAkpXXMepDpZlbFcyytjqtfc3gh+Qw5cH6hWdVS7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DVWvv1nK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YIv0JnK1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0z5SNQzY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IRALhA0C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CBC41F38A;
	Mon, 10 Nov 2025 23:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762815904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cVCt5qNh6a/lE2+aOTO23LMdDAFdLNRheBkAGhK9DyE=;
	b=DVWvv1nKEi1yeLLq7gtpgu6Iix8ei6nh9d2QOOIK84mhi/FtqgSx95ud1T32mfEg4Le5Ql
	f6ROFJuZTwnnQfv7ZnUQIn8o6XXiOe1NRoc+Yv7uU1+ehVPIFYmeZCg7IXYGdrrscGL/rP
	bS1tdbWPFFHND0BEk4cy6lu4MNpMNnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762815904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cVCt5qNh6a/lE2+aOTO23LMdDAFdLNRheBkAGhK9DyE=;
	b=YIv0JnK1pMEfj4vB4cKIpRJFhD1ZtwcfyKTlfN+AheIRkxPQ8TuwlXfmLu6uyK5oh7HZ81
	WaIyXOoEBF7562Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0z5SNQzY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IRALhA0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762815903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cVCt5qNh6a/lE2+aOTO23LMdDAFdLNRheBkAGhK9DyE=;
	b=0z5SNQzY3AQkNx0VbM1arRiWFj+FzbUgwLgQuc2PYbF02SZbIg9x9CVL2KDlUbo9tfy1Ds
	crIL5yD4KQ1W9F2n4yqLutTu8U7j8ynma552hMBLxlErWHHVxdkB7yTf3Osx/N8ut3cDn+
	bDXTGPn0Aap3im/JYz57bPZF19ufuEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762815903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cVCt5qNh6a/lE2+aOTO23LMdDAFdLNRheBkAGhK9DyE=;
	b=IRALhA0C8SSWtUJd+LIg3iTRq0fVziM/sSa8cE3Gy00eWbQE/1wAAtq9tur3HjIPzFGYsH
	f+3CM/ma8tdjHFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 125C41463A;
	Mon, 10 Nov 2025 23:05:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /B4eAZ9vEml9fwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 10 Nov 2025 23:05:03 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Garri Djavadyan <g.djavadyan@gmail.com>
Subject: [PATCH net] ipv6: clear RA flags when adding a static route
Date: Tue, 11 Nov 2025 00:04:36 +0100
Message-ID: <20251110230436.5625-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9CBC41F38A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,suse.de,gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.51

When an IPv6 Router Advertisement (RA) is received for a prefix, the
kernel creates the corresponding on-link route with flags RTF_ADDRCONF
and RTF_PREFIX_RT configured and RTF_EXPIRES if lifetime is set.

If later a user configures a static IPv6 address on the same prefix the
kernel clears the RTF_EXPIRES flag but it doesn't clear the RTF_ADDRCONF
and RTF_PREFIX_RT. When the next RA for that prefix is received, the
kernel sees the route as RA-learned and wrongly configures back the
lifetime. This is problematic because if the route expires, the static
address won't have the corresponding on-link route.

This fix clears the RTF_ADDRCONF and RTF_PREFIX_RT flags preventing that
the lifetime is configured when the next RA arrives. If the static
address is deleted, the route becomes RA-learned again.

Fixes: 14ef37b6d00e ("ipv6: fix route lookup in addrconf_prefix_rcv()")
Reported-by: Garri Djavadyan <g.djavadyan@gmail.com>
Closes: https://lore.kernel.org/netdev/ba807d39aca5b4dcf395cc11dca61a130a52cfd3.camel@gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: this has been broken probably since forever but I belive the
commit in the fixes tag was aiming to fix this too. Anyway, any
recommendation for a fixes tag is welcomed.
---
 net/ipv6/ip6_fib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 02c16909f618..2111af022d94 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1138,6 +1138,10 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 					fib6_set_expires(iter, rt->expires);
 					fib6_add_gc_list(iter);
 				}
+				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT))) {
+					iter->fib6_flags &= ~RTF_ADDRCONF;
+					iter->fib6_flags &= ~RTF_PREFIX_RT;
+				}
 
 				if (rt->fib6_pmtu)
 					fib6_metric_set(iter, RTAX_MTU,
-- 
2.51.0


