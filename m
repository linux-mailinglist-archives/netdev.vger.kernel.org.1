Return-Path: <netdev+bounces-300832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TEbGM5a9NmqqEAcAu9opvQ
	(envelope-from <netdev+bounces-300832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:19:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F46A9375
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 18:19:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cbMgNJnh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kKAORHkv;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cbMgNJnh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kKAORHkv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300832-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300832-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9038B301A72F
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67992212D86;
	Sat, 20 Jun 2026 16:19:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA439479B
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 16:19:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781972356; cv=none; b=ExlZ/kgX9zpM0wxnmJOjKixxA0/EU8T9IAyGqPfcUUhvpRrWmVM7aTYICudtVCr5GrXRn3a8DTzDGgiuvusgYuXRqu7SM9W+XqNfj6Jaz5ztWfp1I63GKQFMtKFLVo4sux3xlYD2uuwwcDPmnM1Rlf5q5o52s9MXLN6CKJ7siwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781972356; c=relaxed/simple;
	bh=9Aue9oYFiNb2KsKp2XnCcgWyVUEyGl/RQmEMHhL+atY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUEuwJzWrxVaKILaS26+DnEFSiEE+0KFIyyrI3COdFKGfu5lH7F6R+OGEhOphNZFrOpMhq31e0bXX0IM4h7BQ1cm/bm90TIcpPZeNOABcuY9VpdJxFZ+9Qt82Es8Kjq093q/mwlhoikeghzJV7mrdR6hC5wQZHsf15Q2Ne7v8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cbMgNJnh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kKAORHkv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cbMgNJnh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kKAORHkv; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51DF0759C3;
	Sat, 20 Jun 2026 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=cbMgNJnhzrWwAS7hQAOw86Z/NbY1Q4Bm1GC7i8Oj/dRKUfLj1XzEUs988CP4oa0+iOQbYp
	26Zie9fzMp5xE9JU2RXZsmNEshK0Hhrr+ln2G53LEwNzBW+m8GuTXeQNuZ26vN4I1Ugyo9
	+x/+/+4TsfRpf97DxKl7nmxz85g+BBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=kKAORHkvw4qzE1tS+A3MWCuH6vpZo54Z1crxbWmnEcuqn743OX9H/8vOqqB1/i4KUr+8Le
	ZaZXuGgD9QKOjkCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781972347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=cbMgNJnhzrWwAS7hQAOw86Z/NbY1Q4Bm1GC7i8Oj/dRKUfLj1XzEUs988CP4oa0+iOQbYp
	26Zie9fzMp5xE9JU2RXZsmNEshK0Hhrr+ln2G53LEwNzBW+m8GuTXeQNuZ26vN4I1Ugyo9
	+x/+/+4TsfRpf97DxKl7nmxz85g+BBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781972347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGYPPU2k5ByJixhZ2mEL5rI4n+IUI6z5/VP0TorVJlw=;
	b=kKAORHkvw4qzE1tS+A3MWCuH6vpZo54Z1crxbWmnEcuqn743OX9H/8vOqqB1/i4KUr+8Le
	ZaZXuGgD9QKOjkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90587779A8;
	Sat, 20 Jun 2026 16:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4EEiIHq9NmogRQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 20 Jun 2026 16:19:06 +0000
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
Subject: [PATCH net v2 1/7] ipv6: fix error handling in disable_ipv6 sysctl
Date: Sat, 20 Jun 2026 18:18:44 +0200
Message-ID: <20260620161850.7114-2-fmancera@suse.de>
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
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300832-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:stephen@networkplumber.org,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B0F46A9375

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


