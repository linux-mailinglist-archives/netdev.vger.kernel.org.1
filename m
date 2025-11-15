Return-Path: <netdev+bounces-238849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC76C602EC
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 10:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E12434F865
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC427FB28;
	Sat, 15 Nov 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lfDdbXvu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iqMoP3oo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lfDdbXvu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iqMoP3oo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CD26B08F
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200793; cv=none; b=bqZr5A+PbqC3bZ5m7iX1nk9asiWJUiRwkfRZWgn56Y/1tqZbJNuITf1seefGRdb5ovObHDDuwITOLOCAWXUkPScVj9B0GI/3IF1d9HpLZrSfq3Anh6RwD3rMjDn5tC+H0ZaCyyoXhN2PGbalqt/0tawNqZfShcym72Ib6wd0Fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200793; c=relaxed/simple;
	bh=HuUiQTPqirncRWQvUKEf1xJFyw0J8944BF7lgTqFZ38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AggMKx83OxvG12/tNOByrDsdFrQf/jn/BfdxCMBCKGcZ/R5z4zwhQtDgxcQpMemwf2Dyle4+StH+IZScRasCtM4tRu5xHRmAH5lf/tFCD5seoQr44xOcMvkvVy/ugQnAqgan2gqXYe0FF9vinpQx7gb/4SBEsVvbvi1z99CZtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lfDdbXvu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iqMoP3oo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lfDdbXvu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iqMoP3oo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BBBA2122E;
	Sat, 15 Nov 2025 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763200790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNS+ALUBPvxkWHvl+Agm7QY7/yF6GKgoQ9DCQgsx8E0=;
	b=lfDdbXvub7BZqyRQI8pQL+X3YzAcISYq4ZquZqcbAha4/qViXZaRy7JIycg8jVTIY/oJ3Y
	sO/8Wlgd8umMLt5LTVBrMJvryII7bGX4v2Acfx0vqJtheBpddUGAVqshcKlKz1tJ+EuaUh
	q1P4M6/h5h0COsQ4DVfuq+bnFgm6guM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763200790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNS+ALUBPvxkWHvl+Agm7QY7/yF6GKgoQ9DCQgsx8E0=;
	b=iqMoP3ooOrVuxMne8vig7QURRdZl3et09q5ExyOPUs1g90zw6ox3HLBQKsTaZT1tDlbRjv
	efE4dxiWZfmvbfBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lfDdbXvu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iqMoP3oo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763200790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNS+ALUBPvxkWHvl+Agm7QY7/yF6GKgoQ9DCQgsx8E0=;
	b=lfDdbXvub7BZqyRQI8pQL+X3YzAcISYq4ZquZqcbAha4/qViXZaRy7JIycg8jVTIY/oJ3Y
	sO/8Wlgd8umMLt5LTVBrMJvryII7bGX4v2Acfx0vqJtheBpddUGAVqshcKlKz1tJ+EuaUh
	q1P4M6/h5h0COsQ4DVfuq+bnFgm6guM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763200790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PNS+ALUBPvxkWHvl+Agm7QY7/yF6GKgoQ9DCQgsx8E0=;
	b=iqMoP3ooOrVuxMne8vig7QURRdZl3et09q5ExyOPUs1g90zw6ox3HLBQKsTaZT1tDlbRjv
	efE4dxiWZfmvbfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A3B73EA61;
	Sat, 15 Nov 2025 09:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BIueGhVPGGl+HQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 15 Nov 2025 09:59:49 +0000
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
Subject: [PATCH 1/2 net-next v2] ipv6: clear RA flags when adding a static route
Date: Sat, 15 Nov 2025 10:59:38 +0100
Message-ID: <20251115095939.6967-1-fmancera@suse.de>
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
X-Rspamd-Queue-Id: 1BBBA2122E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,suse.de,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
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
v2: rebase in top of net-next.git instead of net.git
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
2.51.1


