Return-Path: <netdev+bounces-300490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WYgZL3cbNGrHOgYAu9opvQ
	(envelope-from <netdev+bounces-300490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:23:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2716A192D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:23:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uR1M4UI9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N5Su95a0;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uR1M4UI9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N5Su95a0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300490-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300490-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB9E530578F8
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410AF2E091E;
	Thu, 18 Jun 2026 16:22:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CA2F7EE2
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 16:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799772; cv=none; b=Q9sEvblXf54z47QTEpXPsL9PZ9RA+IfzKIFObT/6kZJWoCfKcn7DkXHJl4BjCMEzRG5D3f4IhCBDEP7ynGo9IBYH/GzFxbfdgKk3xsnIDrdS8sM3mZvge6Rp7n/uOdgd1kGWvgu7dhSd+VRGYuuEz/cx9YEyPytWa2bXStc7RTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799772; c=relaxed/simple;
	bh=E9FmkVrlQ8SVz75fEHQsPOJDf0O138Ei5crdzcNZYYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pppqYwMVq16APMuEyKifS1Nrc9MSmMOVaqV5unioSirLhz4zQWfiofYmIDzSHTFtryhrj2YF18T0ia8iFUH8rhvwGYtJvqOx8IZ+8Zya9zYQuE/+B0GXOCMtyPxlmewoPzUZb2nX7lBM0Ts5Fv6222nC8rN//jZBpvDgSPPlpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uR1M4UI9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N5Su95a0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uR1M4UI9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N5Su95a0; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94C8175FE9;
	Thu, 18 Jun 2026 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgoTog6NBw1KjlYBrCypyowsJeN4J+N7aPh5DtBfD3I=;
	b=uR1M4UI9psbuC8hSDuO9i6ikeTNgzJoRt5JZxzriRvXF8zVpEJZuiEUlAPnXf4uca5g0Rg
	m8rztpitclOCnUvYwAuR8ppguBnyQgBGSsRx4l76c5RXTrE9LnGewg1Digk3kZLYSTBBXX
	0N2VeStlOoIshrKH39s7k3AHxz/BarE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgoTog6NBw1KjlYBrCypyowsJeN4J+N7aPh5DtBfD3I=;
	b=N5Su95a0iId8pyWqFZFwD/kXnJD25MJKIuRlR7qN/hWAGaukYCRAEsSMrGFh+tGrmJcY5c
	4hqMz8d6O549+gCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781799767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgoTog6NBw1KjlYBrCypyowsJeN4J+N7aPh5DtBfD3I=;
	b=uR1M4UI9psbuC8hSDuO9i6ikeTNgzJoRt5JZxzriRvXF8zVpEJZuiEUlAPnXf4uca5g0Rg
	m8rztpitclOCnUvYwAuR8ppguBnyQgBGSsRx4l76c5RXTrE9LnGewg1Digk3kZLYSTBBXX
	0N2VeStlOoIshrKH39s7k3AHxz/BarE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781799767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgoTog6NBw1KjlYBrCypyowsJeN4J+N7aPh5DtBfD3I=;
	b=N5Su95a0iId8pyWqFZFwD/kXnJD25MJKIuRlR7qN/hWAGaukYCRAEsSMrGFh+tGrmJcY5c
	4hqMz8d6O549+gCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5AD1779AB;
	Thu, 18 Jun 2026 16:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oAtYKVYbNGqCDgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 18 Jun 2026 16:22:46 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	shemminger@vyatta.com,
	dforster@brocade.com,
	gospo@cumulusnetworks.com,
	ddutt@cumulusnetworks.com,
	brian.haley@hp.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net 4/6] ipv6: fix error handling in disable_policy sysctl
Date: Thu, 18 Jun 2026 18:22:23 +0200
Message-ID: <20260618162225.4588-5-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260618162225.4588-1-fmancera@suse.de>
References: <20260618162225.4588-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.01
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
	TAGGED_FROM(0.00)[bounces-300490-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:shemminger@vyatta.com,m:dforster@brocade.com,m:gospo@cumulusnetworks.com,m:ddutt@cumulusnetworks.com,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D2716A192D

When writing to the disable_policy sysctl, if proc_dointvec() fails to
parse the input, it returns a negative error code. The current
implementation is resetting the position argument even if an error
occurred during proc_dointvec() and not only during sysctl restart.

Fix this by checking the return value of proc_dointvec() and returning
early on failure.

Fixes: df789fe75206 ("ipv6: Provide ipv6 version of "disable_policy" sysctl")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0b128b6cff60..8ff015975e27 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6769,6 +6769,8 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
 	lctl = *ctl;
 	lctl.data = &val;
 	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
 
 	if (write && (*valp != val))
 		ret = addrconf_disable_policy(ctl, valp, val);
-- 
2.54.0


