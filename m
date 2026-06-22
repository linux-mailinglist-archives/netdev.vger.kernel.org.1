Return-Path: <netdev+bounces-301115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Fe9H7E0OWoQogcAu9opvQ
	(envelope-from <netdev+bounces-301115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9276AFB54
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:12:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D2X0mBC5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n4zM5Tnl;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=D2X0mBC5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n4zM5Tnl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301115-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301115-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3929305B12A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B353AEF4C;
	Mon, 22 Jun 2026 13:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149C3B14B5
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:09:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133765; cv=none; b=mKTpK6m55O7qQxiGmugCFnjR+OEpE3I7/QQMr5NIxi1T0jIKV102c4CMXyYCwHdgtsBGV+fXjf1DBcAOH4rDNce0+1dpc5IgwIP5R5k3NmRLL8B18VpI8GSjXb4/SuGzCNCo17YNDFCp6Ie8wMPE6bt2aS5R7xJc+blw9WnI9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133765; c=relaxed/simple;
	bh=9Aue9oYFiNb2KsKp2XnCcgWyVUEyGl/RQmEMHhL+atY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRPQ0GZsdmgA9Xp5M7eWZe4LlVTAEAT/4/lGe+7WhwVWyMfwdK9Nu+jrRFruFn7SNHQJ+tci6sGViuTHpZk+90PD0r9yZGxB9Bf6hZHmQZ50rmSZDSFdWQC9Cd6J38I5n2Nud601+TLiGshvnuvpdPM2dAVgZK1+GMNxJIgttAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D2X0mBC5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n4zM5Tnl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D2X0mBC5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n4zM5Tnl; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC3847081C;
	Mon, 22 Jun 2026 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=D2X0mBC5HnDnPYyniv09kWAQbSa0sEHeXbZdJhQ5aPIyYCnbftrG6tZXYtmtLGA+Y7yvoT
	Z5Y4uo8acWSK9NfoVQ8xP3eOzSfXpT0tfrZ5gI8ZDUoOMIZKnY77p1UrEi8OdMQIq/NOCY
	lDCw9aRmgq09knOXgyb41x3HzVaLRrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=n4zM5Tnl62xzFPLvONXkYHczEMJNuQzFDjPJDpiDsCUyt7pvegKQudfLO5trrKmy3MNc+/
	DerPnzRHW9qb0FDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782133757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=D2X0mBC5HnDnPYyniv09kWAQbSa0sEHeXbZdJhQ5aPIyYCnbftrG6tZXYtmtLGA+Y7yvoT
	Z5Y4uo8acWSK9NfoVQ8xP3eOzSfXpT0tfrZ5gI8ZDUoOMIZKnY77p1UrEi8OdMQIq/NOCY
	lDCw9aRmgq09knOXgyb41x3HzVaLRrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782133757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=n4zM5Tnl62xzFPLvONXkYHczEMJNuQzFDjPJDpiDsCUyt7pvegKQudfLO5trrKmy3MNc+/
	DerPnzRHW9qb0FDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F36B7779A8;
	Mon, 22 Jun 2026 13:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +IJCOPwzOWqdEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 22 Jun 2026 13:09:16 +0000
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
Subject: [PATCH net v3 1/6] ipv6: fix error handling in disable_ipv6 sysctl
Date: Mon, 22 Jun 2026 15:08:52 +0200
Message-ID: <20260622130857.5115-2-fmancera@suse.de>
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301115-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,6wind.com:email,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD9276AFB54

When writing to the disable_ipv6 sysctl, if proc_dointvec() fails to
parse the input, it returns a negative error code. The current
implementation is overwriting that error for write operations.

This results in a silent failure, it returns a successful write although
the configuration was not modified at all. When modifying the "all"
variant it can also modify the configuration of existing interfaces to
the wrong value.

Fix this by checking the return value of proc_dointvec() and returning
early on failure.

Fixes: 56d417b12e57 ("IPv6: Add 'autoconf' and 'disable_ipv6' module parameters")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 1f21ccb55caa..c901b444a995 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6467,6 +6467,8 @@ static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 	lctl.data = &val;
 
 	ret = proc_dointvec(&lctl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
 
 	if (write)
 		ret = addrconf_disable_ipv6(ctl, valp, val);
-- 
2.54.0


