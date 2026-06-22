Return-Path: <netdev+bounces-301116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +kYqH980OWoiogcAu9opvQ
	(envelope-from <netdev+bounces-301116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:13:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD246AFB71
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:13:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nym7On2w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GKcvlahy;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nym7On2w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GKcvlahy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301116-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301116-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79ECE300E3BE
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1521B3AEF4C;
	Mon, 22 Jun 2026 13:09:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186F36EA8B
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:09:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133771; cv=none; b=gR+oTosYWi4J46a3lzD2Q/DPIcocIUaaikIiSG0zmrWfNJV1y/Vl17mqO2CQXG0sBf2zywx/W/74TF8e8hHD9wAJEvMOAl9OBxXFaFkbNGjcITqydLvvyOJxjbKG+q5V93JgOC415MKNyHVmBZhlpmt9zkmaprtPSjiSYxyQh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133771; c=relaxed/simple;
	bh=LR3fETsSIgVGFzJgv75lOCDr06gJAXwO1ewMU9kPMfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPYqf3FQNyYz4P6SKXQD830eWIjqEVIeceHU9PMS5P7sdhelJk/26+FcLOWaRxPndX2G2O3ClM7OPj9pm9/hfteV0e9wssl34xNr9QaoQ5+uf+JeN/umPvhJMEbZYbmeUP0/pkmZPRHzVcTd0PsgcEnNCkFczsQbnQO+5lnBldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nym7On2w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GKcvlahy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nym7On2w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GKcvlahy; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C0F17081E;
	Mon, 22 Jun 2026 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOnqu0Zt6XD1xHin9VkqTwnNE52uLBnZJOSyuvuR1E=;
	b=Nym7On2weTN0IDZbQlIC+FpS+fT9V8X/QaejzFZfE+/IT9rLHz0eh33fPPBs8P2btNj3Yg
	IwMom91E8QT6oL4yaGmAL5aALhw+kf9+cWpAwP1Kn7q4zhwG8l0zdkiPtmqf7YMsidbeH1
	w341t/gPvapkICVV5ZX6/ptxM+AUG1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOnqu0Zt6XD1xHin9VkqTwnNE52uLBnZJOSyuvuR1E=;
	b=GKcvlahy+y0gFKg4mIZoVdOPOHYKU7ywvyN5DwUY9zYKDaasFmR+fIrVYHL3G0LTOxtYMF
	pcyZIgfHl6fRFQCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOnqu0Zt6XD1xHin9VkqTwnNE52uLBnZJOSyuvuR1E=;
	b=Nym7On2weTN0IDZbQlIC+FpS+fT9V8X/QaejzFZfE+/IT9rLHz0eh33fPPBs8P2btNj3Yg
	IwMom91E8QT6oL4yaGmAL5aALhw+kf9+cWpAwP1Kn7q4zhwG8l0zdkiPtmqf7YMsidbeH1
	w341t/gPvapkICVV5ZX6/ptxM+AUG1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsOnqu0Zt6XD1xHin9VkqTwnNE52uLBnZJOSyuvuR1E=;
	b=GKcvlahy+y0gFKg4mIZoVdOPOHYKU7ywvyN5DwUY9zYKDaasFmR+fIrVYHL3G0LTOxtYMF
	pcyZIgfHl6fRFQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 743FA779A8;
	Mon, 22 Jun 2026 13:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wIM0Gf4zOWqdEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 22 Jun 2026 13:09:18 +0000
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
Subject: [PATCH net v3 2/6] ipv6: fix error handling in ignore_routes_with_linkdown sysctl
Date: Mon, 22 Jun 2026 15:08:53 +0200
Message-ID: <20260622130857.5115-3-fmancera@suse.de>
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
	TAGGED_FROM(0.00)[bounces-301116-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,6wind.com:email,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDD246AFB71

When writing to the ignore_routes_with_linkdown sysctl, if
proc_dointvec() fails to parse the input, it returns a negative error
code. The current implementation is overwriting that error for write
operations.

This results in a silent failure, it returns a successful write although
the configuration was not modified at all. When modifying the "all"
variant it can also modify the configuration of existing interfaces to
the wrong value.

Fix this by checking the return value of proc_dointvec() and returning
early on failure.

Fixes: 35103d11173b ("net: ipv6 sysctl option to ignore routes when nexthop link is down")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c901b444a995..70058d971205 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6671,6 +6671,8 @@ int addrconf_sysctl_ignore_routes_with_linkdown(const struct ctl_table *ctl,
 	lctl.data = &val;
 
 	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
 
 	if (write)
 		ret = addrconf_fixup_linkdown(ctl, valp, val);
-- 
2.54.0


