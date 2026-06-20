Return-Path: <netdev+bounces-300833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 11ZwG4q9NmqnEAcAu9opvQ
	(envelope-from <netdev+bounces-300833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:19:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B056A9370
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:19:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zcuq2nhT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BzAC+Rh7;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zcuq2nhT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BzAC+Rh7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300833-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300833-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8707230054F6
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C1348C65;
	Sat, 20 Jun 2026 16:19:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DAB212D86
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:19:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972360; cv=none; b=HYIbHiNX8X3u55b2dsPi4dsUXTx/0AgJqdSWArWzGgkoQgp11H5AoI6P19eR6ZXFtde4CO9hTMBzMJH+BSgwTEauU+LFw2Qjl366MpVhokxrsBk10uia6aMeLKMoROTMGW9afQohUcwqiLjNJtdYG9l4BcGd/DmO8usZPkOAdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972360; c=relaxed/simple;
	bh=tFRJSct/pYypj6OvOz88waY2/GRnWUaSP9gqSDW9880=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKj21JaaluqrjsA/hKy+qx8IxZjWyBWqpibHiir4WeH983KdGp1F8BPzcL6uBLC0mWgfIdO0aZ8jookMAIA8BzeroMFszPIDdxCLTpBe3SM12ycJbJ/YHtp+2bmiTPB5zGu45S3a1I7yYKAQ8stQLh8xbsuro90TExgS9pL+SrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zcuq2nhT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BzAC+Rh7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zcuq2nhT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BzAC+Rh7; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF1CA6C3A1;
	Sat, 20 Jun 2026 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=Zcuq2nhTPvPOysFl8tyhhDcf6X/0mTerUhQi2ZqNTj2gOUJnGIRaofUoQy7s1kdLip7pHF
	uNPTLS3uOXSepUR1MAdOSimfq7qwAthot1a4I8LZB9EUB+hUp7pzV8OV9UhpLR8pmVo7EE
	uWNMupVszqoCH1awjwpq/tC4OTUbw4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=BzAC+Rh7M4CN6/WlNB1bxzMDo8OM6OUbtyTtdx6+Aa4OreDo1FjB0B5fQ8LiboYRGUHQBr
	NMFi2/ixHEUdHDCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=Zcuq2nhTPvPOysFl8tyhhDcf6X/0mTerUhQi2ZqNTj2gOUJnGIRaofUoQy7s1kdLip7pHF
	uNPTLS3uOXSepUR1MAdOSimfq7qwAthot1a4I8LZB9EUB+hUp7pzV8OV9UhpLR8pmVo7EE
	uWNMupVszqoCH1awjwpq/tC4OTUbw4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkUjmq6D+JE0O0QkgvdkXje/EW6djMwXro1sB90juFg=;
	b=BzAC+Rh7M4CN6/WlNB1bxzMDo8OM6OUbtyTtdx6+Aa4OreDo1FjB0B5fQ8LiboYRGUHQBr
	NMFi2/ixHEUdHDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED8D4779A8;
	Sat, 20 Jun 2026 16:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sIz1Nn69NmogRQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 20 Jun 2026 16:19:10 +0000
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
Subject: [PATCH net v2 4/7] ipv6: fix error handling in disable_policy sysctl
Date: Sat, 20 Jun 2026 18:18:47 +0200
Message-ID: <20260620161850.7114-5-fmancera@suse.de>
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300833-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:stephen@networkplumber.org,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,6wind.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12B056A9370

When writing to the disable_policy sysctl, if proc_dointvec() fails to
parse the input, it returns a negative error code. The current
implementation is resetting the position argument even if an error
occurred during proc_dointvec() and not only during sysctl restart.

Fix this by checking the return value of proc_dointvec() and returning
early on failure.

Fixes: df789fe75206 ("ipv6: Provide ipv6 version of "disable_policy" sysctl")
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d23a89b07eed..5d96cbf76134 100644
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


