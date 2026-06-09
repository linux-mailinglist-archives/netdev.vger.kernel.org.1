Return-Path: <netdev+bounces-297230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rX4nLj1cKGrcCgMAu9opvQ
	(envelope-from <netdev+bounces-297230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:32:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 295F466356E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:32:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SXTxW637;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297230-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297230-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC2E3300D850
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454B1352C3C;
	Tue,  9 Jun 2026 18:32:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB693EB0EB
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:32:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029947; cv=none; b=sMp3T09s3NXn72zAoL8wZ+ex5tFynj3SOUT+Mahrx6u388cp7VpWbaz/5TlBidiHR6pIfwtSuuQZ2hwweX08kPzY8whJuHrPQnIJ1hocJDNCOjnNSxvn0zWGtjEROcOQCD9D3cjWgvp1+U0q0oN2xnb+nUWLh9DLt55E9EFiSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029947; c=relaxed/simple;
	bh=YM3s8bIL4SOhAZmEK0FwuYz1izYvPOUY5tOr/JGsgQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wt/NCvTJnwsCmzJAbWhaTREnpcdRlYHfQgihtCka4E1K5r77sJx7Q0KbRDipbkQBBunzRB2SQjyiWI8uAJUksvixHrC7jZ1/gQ1/fd03TyYyVboUz8SMqQiUolFCes9QLxpfNaAuoKNiqlibqv73FP9bYEEarogCO3+Q4O7l2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXTxW637; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6A81F00893;
	Tue,  9 Jun 2026 18:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029946;
	bh=3Nhg30blEhwRopR20WqPrpZ8FE95GMLdgHcs3qSiNCw=;
	h=From:To:Cc:Subject:Date;
	b=SXTxW637r9DfTx2VcwIxYvhd/beLhrr6rWW4rgXLHk91weq8+tvR499/MfXeISEiR
	 rdnhIjmUTwhhYlS0YAGg/fcLFeQJB2pnxF2L2kYu7qN2eHKaVp7jGxmK2+KfJFSEOa
	 e7r3FLOF7eHwmJeANoBqD4s62uTBqgWWSg59YRMGr749PLmPoWzXFiRyIM95Lf7X1K
	 lVo1V3Oeo9YP1vWT/zvXSTqqBX7O4i+LAHlB/pMxLed9b6Ron5NnQBbBDI8o48LNuv
	 2CchxdeRbn+Fz7n2ZWtXJqQzN8LBq3W1+SO49DcDHzdwvkFnhp5UVVkswirmg01Wv8
	 ZSzV+GX/oh1gw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] net: shaper: follow ups to recent fixes
Date: Tue,  9 Jun 2026 11:32:20 -0700
Message-ID: <20260609183224.1108521-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297230-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 295F466356E

As discussed previously on the patch set with real fixes the xa_locking
in shapers is a little confusing, remove it.
Link: https://lore.kernel.org/20260506000628.1501691-2-kuba@kernel.org

The remaining three patches are an attempt to silence AI reviewers,
I believe Sashiko was complaining about these non-issues. Not adding
Reported tags since these are false positives.

Jakub Kicinski (4):
  net: shaper: drop redundant xa_lock() bracketing
  net: shaper: drop unnecessary kfree_rcu in pre_insert
  net: shaper: add a comment why we don't need kfree_rcu() in flush
  net: shaper: add a note that we expect cap dumps to be tiny

 net/shaper/shaper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.54.0


