Return-Path: <netdev+bounces-300835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OynsCce9Nmq+EAcAu9opvQ
	(envelope-from <netdev+bounces-300835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:20:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DEF6A937E
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:20:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XuDONCEY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=POmvMPJ6;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=esUuADo5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p7v7+ysD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300835-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300835-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EF663015C8E
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EF93624D7;
	Sat, 20 Jun 2026 16:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D808340A76
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:19:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972365; cv=none; b=EwTM6Yfh2l00N2zkZx71Xrvq+CZTI9lUS1igTdiyHb0xBBCttbYRoZ7tUn/4LdMW2aaej7aVXhjeYNJc7ZwHiWfMwKINB/FTttr5cu5ynD+N5kiEKdY7iHrSP+MOw/WrhM9j9B5wZNf7YeGvN3iIJoZIR5wD9UMmk/ZbIR2GMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972365; c=relaxed/simple;
	bh=4LJiynXLIY9Qy87EiwbDMQ6niGNRBGdIIRsARMw+Uuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCVLFYV5tMxRlRO8F3xSzf1p0BU1H2dOk3fLl/8oxPOqEd70NymmBLdmAynOZxSp2zqgSsqMbGQ9hCcxKWvKD6L3rZVVJXu5bY9CPcUdyllVdgVkWpH64zDKLxB7KQkckw26UjkHYPCQFH3zq26PXJTL2gGG9JK8w1xTOoB14jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XuDONCEY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=POmvMPJ6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=esUuADo5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p7v7+ysD; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDBA76E06F;
	Sat, 20 Jun 2026 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64A4GYI3w3+wip+xYyUzU4Q3HHyswhTeQvPyX6n9hro=;
	b=XuDONCEYOWv3WnvBeP//1qyvWXo54/tZtT2PDl7qJXstw260g8ntwV3P3Eow75gi4TC7hJ
	tSWZavHefcgS4pbApgjjU/Mo9etnJrILvq0GhfpPcssKMFJ7jzJpUAPn0gks7dm90fWcbL
	pPOvbIqQtWw/mh4qO4r5R8wLjZMTcJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64A4GYI3w3+wip+xYyUzU4Q3HHyswhTeQvPyX6n9hro=;
	b=POmvMPJ6IxNl8XXdFtd7u6beC9csEP0fJhpJcjzjgqCS3+114UKsiKFscXwxwtXLKUhas9
	NGVQjhEnfSimPUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64A4GYI3w3+wip+xYyUzU4Q3HHyswhTeQvPyX6n9hro=;
	b=esUuADo5sDkA3MCAxZLkV1+UAlaf9JJBbGABdpiLoWamSocNxFy1/+HANetfwdl05VYKVC
	AGw4X08+QuUH/C6D6oALPh/f/W9L6XdVDZ4r6Sq6RffCP1ef1lA/73VX0sy8QU4lsxTcCE
	Ydr+IgBYfYMAmQpPk1pA+B1VpVjQ73I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64A4GYI3w3+wip+xYyUzU4Q3HHyswhTeQvPyX6n9hro=;
	b=p7v7+ysDP3BGpFGr4ZQuCb3M6yC5CffPPyqebAAzveyEAXsYJ89OgRhaTW9bx4bI5KU8G1
	2n8TyD7vd0Qa78Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35CB8779A8;
	Sat, 20 Jun 2026 16:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MIMVCoC9NmogRQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 20 Jun 2026 16:19:12 +0000
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
Subject: [PATCH net v2 5/7] ipv6: reset value and position for proxy_ndp sysctl restart
Date: Sat, 20 Jun 2026 18:18:48 +0200
Message-ID: <20260620161850.7114-6-fmancera@suse.de>
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
	TAGGED_FROM(0.00)[bounces-300835-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74DEF6A937E

When handling proxy_ndp, if rtnl_net_trylock() fails, the operation is
retried but as the value was already modified by the initial
proc_dointvec() call, the restarted syscall will read the newly modified
value as the 'old' state.

Fix this by taking the RTNL lock before parsing the input value if the
operation is a write.

Fixes: c92d5491a6d9 ("netconf: add support for IPv6 proxy_ndp")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5d96cbf76134..82b6f603faa0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6482,20 +6482,19 @@ static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct net *net = ctl->extra2;
 	int *valp = ctl->data;
-	int ret;
 	int old, new;
+	int ret;
+
+	if (write && !rtnl_net_trylock(net))
+		return restart_syscall();
 
 	old = *valp;
 	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
 	new = *valp;
 
 	if (write && old != new) {
-		struct net *net = ctl->extra2;
-
-		if (!rtnl_net_trylock(net))
-			return restart_syscall();
-
 		if (valp == &net->ipv6.devconf_dflt->proxy_ndp) {
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
 						     NETCONFA_PROXY_NEIGH,
@@ -6514,8 +6513,9 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 						     idev->dev->ifindex,
 						     &idev->cnf);
 		}
-		rtnl_net_unlock(net);
 	}
+	if (write)
+		rtnl_net_unlock(net);
 
 	return ret;
 }
-- 
2.54.0


