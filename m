Return-Path: <netdev+bounces-301120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1dQ6MD81OWo6ogcAu9opvQ
	(envelope-from <netdev+bounces-301120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:14:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A596AFB9A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:14:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wUX9LJ0n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QUOnTYaI;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wUX9LJ0n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QUOnTYaI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301120-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301120-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A63F30432E7
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C03B14AC;
	Mon, 22 Jun 2026 13:09:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1A3B1022
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:09:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133795; cv=none; b=jlUDQCwNHWGjIDPHNRAiVRqwGfV8OpTQVYX2nAZF3ItN7zraOsWGxkFoKgaBNeFCxOabtRi95GL6d0uIlJJHrmhi4n1AWGpODJeEgv0uNRgnCkNZHXlgx4Qh5cxag87JatEsnfct6UmKR0HrOBqeKwl0ziVt5G/Pzon41/4SbFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133795; c=relaxed/simple;
	bh=Wb17KUkJCUmLv3it19IfxsBne2r/P05MGGxuTsENHMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRJzC9tyqNokeD1PQI+oNJiAut3FoYM1c1hZs2WExGatunWKJeBnCN5V6aBuqHE/6/9pQ0EqhjPluf8gVosUNzEmVt88j9i8KhD/hwzjljIt8eEYowOk8jyz3sFIUiV2/5VFKRZCwNELmtbVkz71HDa2fF6uMTnkO1Gw5/UHfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wUX9LJ0n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QUOnTYaI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wUX9LJ0n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QUOnTYaI; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EE9F70821;
	Mon, 22 Jun 2026 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7nvC0guHRMCveV+VaTW4MThaii9NlaCh+DP7Lyu8yo=;
	b=wUX9LJ0nqJwKopdqM5fpfHmBeLFb83Uwzgkr/Vn8B1BOTYpYECaKCCGEm0xN4U4j7IjDZE
	1HSZWnsXy0IHC4KnUayRk6t7+RMD+IXZ3SCRm4WTa8wfu4fm2xkPX0pmbvQCLs7USmHVMo
	AdvZlmBPgYtpCbjFT4tTkhCtMi5YY9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7nvC0guHRMCveV+VaTW4MThaii9NlaCh+DP7Lyu8yo=;
	b=QUOnTYaI7wuVhp8Cwl+R5rU8Gf2TzeItRK8XDEjGoOwLb+mYcTBNmGNLBdxkaMYHkAl7fD
	mJ8V6oXgW6HwPQDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7nvC0guHRMCveV+VaTW4MThaii9NlaCh+DP7Lyu8yo=;
	b=wUX9LJ0nqJwKopdqM5fpfHmBeLFb83Uwzgkr/Vn8B1BOTYpYECaKCCGEm0xN4U4j7IjDZE
	1HSZWnsXy0IHC4KnUayRk6t7+RMD+IXZ3SCRm4WTa8wfu4fm2xkPX0pmbvQCLs7USmHVMo
	AdvZlmBPgYtpCbjFT4tTkhCtMi5YY9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7nvC0guHRMCveV+VaTW4MThaii9NlaCh+DP7Lyu8yo=;
	b=QUOnTYaI7wuVhp8Cwl+R5rU8Gf2TzeItRK8XDEjGoOwLb+mYcTBNmGNLBdxkaMYHkAl7fD
	mJ8V6oXgW6HwPQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85FC1779AB;
	Mon, 22 Jun 2026 13:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +J6MHQM0OWqdEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 22 Jun 2026 13:09:23 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	stephen@networkplumber.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net v3 6/6] ipv6: fix missing notification for ignore_routes_with_linkdown
Date: Mon, 22 Jun 2026 15:08:57 +0200
Message-ID: <20260622130857.5115-7-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260622130857.5115-1-fmancera@suse.de>
References: <20260622130857.5115-1-fmancera@suse.de>
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
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301120-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:stephen@networkplumber.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,6wind.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14A596AFB9A

When changing the ignore_routes_with_linkdown sysctl for a specific
interface, the RTM_NEWNETCONF netlink notification was not being emitted
to userspace. Fix this by emitting the notification when needed.

In addition, fix bogus return value for successful "all" and specific
interface write operation leading to a wrong reset of the position
pointer.

Fixes: 35103d11173b ("net: ipv6 sysctl option to ignore routes when nexthop link is down")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 82b6f603faa0..cbe681de3818 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -955,11 +955,7 @@ static int addrconf_fixup_linkdown(const struct ctl_table *table, int *p, int ne
 						     NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
 						     NETCONFA_IFINDEX_DEFAULT,
 						     net->ipv6.devconf_dflt);
-		rtnl_net_unlock(net);
-		return 0;
-	}
-
-	if (p == &net->ipv6.devconf_all->ignore_routes_with_linkdown) {
+	} else if (p == &net->ipv6.devconf_all->ignore_routes_with_linkdown) {
 		WRITE_ONCE(net->ipv6.devconf_dflt->ignore_routes_with_linkdown, newf);
 		addrconf_linkdown_change(net, newf);
 		if ((!newf) ^ (!old))
@@ -968,11 +964,21 @@ static int addrconf_fixup_linkdown(const struct ctl_table *table, int *p, int ne
 						     NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
+	} else {
+		if (!newf ^ !old) {
+			struct inet6_dev *idev = table->extra1;
+
+			inet6_netconf_notify_devconf(net,
+						     RTM_NEWNETCONF,
+						     NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
+						     idev->dev->ifindex,
+						     &idev->cnf);
+		}
 	}
 
 	rtnl_net_unlock(net);
 
-	return 1;
+	return 0;
 }
 
 #endif
-- 
2.54.0


