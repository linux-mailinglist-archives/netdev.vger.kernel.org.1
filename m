Return-Path: <netdev+bounces-300837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FYc5COu9NmrMEAcAu9opvQ
	(envelope-from <netdev+bounces-300837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:20:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CAA6A9386
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:20:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iruF36wn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="MzT/7PlQ";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iruF36wn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="MzT/7PlQ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300837-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300837-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 709EF30179E6
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE6390CB4;
	Sat, 20 Jun 2026 16:19:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C453624D7
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:19:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972371; cv=none; b=m0aHS5K6uG2LzmQ1ivs10twO53xjrggEduqHI8UXnAkTEPfhRIfS4erjhU3Qe1kl0Hl7B3fPadWPbQeDqY7rWMwDD3QFpuh/XCljj5WIzalK+jNWE4iIuc6ce4AcA859DrxrLDVxfu0MsW2iYGCK5wsqGADMyS+9USd+WwZZxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972371; c=relaxed/simple;
	bh=/fUwFB1ZWMgGNHrFn0SC1xcutUrdwdSZaQZ3t5c89V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUFZWOUdU9KNWzzG3xFsY2DnUDyZm4g6AZZiKAQbVHYUiifsMI2TeArOwnBjv1kmKEULs+PFSw2N7bWB/ZGDK+H1nCGH17BSncDx42jFFFfLxNoZgo7ozeBLv0xptQZV8Zu1270ardnYzaTiVyuRJI3wv4mdICVURPKaLVkbXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iruF36wn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MzT/7PlQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iruF36wn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MzT/7PlQ; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 762096B6F7;
	Sat, 20 Jun 2026 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/dHmpo8Xjum5KLfzyqAHntuLruMC1xvCYy5W/p8EzQ=;
	b=iruF36wnn0ReOvgrYtNXwySfv3LKBqRaqo2Gk0dJvZRO9ODt5kPK5sgM4FYPGg98HSnzVO
	+PC9//k7EsCLI3uqzUXFqs2Hw/wljbb6VAoduZdOMU06gblRwy4ELuIL1Hnrr/XaEzy+5c
	9NN/5QRQOL/uiyLXNtinlqW2Sp2U3pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/dHmpo8Xjum5KLfzyqAHntuLruMC1xvCYy5W/p8EzQ=;
	b=MzT/7PlQK8nJo+GQbBdR+YXYqZmfCOGTH0hBsJE9UPmR1VjXXJ7zpZHlCaEyQ78q1CO5Fy
	cap55dwBr4Jx+2Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/dHmpo8Xjum5KLfzyqAHntuLruMC1xvCYy5W/p8EzQ=;
	b=iruF36wnn0ReOvgrYtNXwySfv3LKBqRaqo2Gk0dJvZRO9ODt5kPK5sgM4FYPGg98HSnzVO
	+PC9//k7EsCLI3uqzUXFqs2Hw/wljbb6VAoduZdOMU06gblRwy4ELuIL1Hnrr/XaEzy+5c
	9NN/5QRQOL/uiyLXNtinlqW2Sp2U3pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/dHmpo8Xjum5KLfzyqAHntuLruMC1xvCYy5W/p8EzQ=;
	b=MzT/7PlQK8nJo+GQbBdR+YXYqZmfCOGTH0hBsJE9UPmR1VjXXJ7zpZHlCaEyQ78q1CO5Fy
	cap55dwBr4Jx+2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B36C4779A8;
	Sat, 20 Jun 2026 16:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UFytKIK9NmogRQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 20 Jun 2026 16:19:14 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	stephen@networkplumber.org,
	brian.haley@hp.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net v2 7/7] ipv6: reset position for force_forwarding sysctl restart
Date: Sat, 20 Jun 2026 18:18:50 +0200
Message-ID: <20260620161850.7114-8-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620161850.7114-1-fmancera@suse.de>
References: <20260620161850.7114-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-300837-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:stephen@networkplumber.org,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80CAA6A9386

When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is
retried but the position pointer was already advanced meaning that the
restarted sysctl will read from an incorrect offset.

Fix this by restoring the original position pointer before restarting
the syscall.

In addition, remove the redundant position pointer restoration at the
end of the function.

Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index cbe681de3818..8c0741e9dfcc 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6825,8 +6825,10 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
 	ret = proc_douintvec_minmax(&tmp_ctl, write, buffer, lenp, ppos);
 
 	if (write && old_val != new_val) {
-		if (!rtnl_net_trylock(net))
+		if (!rtnl_net_trylock(net)) {
+			*ppos = pos;
 			return restart_syscall();
+		}
 
 		WRITE_ONCE(*valp, new_val);
 
@@ -6851,8 +6853,6 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
 		rtnl_net_unlock(net);
 	}
 
-	if (ret)
-		*ppos = pos;
 	return ret;
 }
 
-- 
2.54.0


