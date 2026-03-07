Return-Path: <netdev+bounces-265163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NIX1D3tnrGmdpQEAu9opvQ
	(envelope-from <netdev+bounces-265163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 18:59:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223822D184
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54B2301573A
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899F35E937;
	Sat,  7 Mar 2026 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA/CAu+x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B032E6BD
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772906359; cv=none; b=nILVSuVwNpue2DVIVwgbhYriDnpEwaDkL7u73tGxWTDPW6BDJu19SCRLmoimDOI/5MIrzqR7h5I2xKvNmMvaefdLEiTkUMCFeDd+L8QP46NxX8ImYVvzWWq72RAIww7yDfSEqbFwjoO/chL0DcdczVkKPm4CGhjYzJ3ioiDeroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772906359; c=relaxed/simple;
	bh=NH9650joR4S2M0tpmlUURAGIA17SLpGHyaVx878mh7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6gWqAB1wX4H/Onktscb9j8TRhHsNZDCGcHjrHFj8vNDzGfzXxwZLiNMSuROBKuWi5zF9EnJcgbFhwMbv6GUaVlJh6TqcCPnPO2KjP1OziGZRGyIVaZc2szdemeLIREgsLzmhwF43yGrr4BuYJmNAEn5ykemjiLOk8O5sFREIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA/CAu+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FBEC19422;
	Sat,  7 Mar 2026 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772906359;
	bh=NH9650joR4S2M0tpmlUURAGIA17SLpGHyaVx878mh7g=;
	h=From:To:Cc:Subject:Date:From;
	b=sA/CAu+xlv+GPuAg3npwBl24SRhNxxCIHx2Ne+iGSNJzxwNDYtCLg40N3YPJMjXD7
	 Izm0zw0SsSK01f8hyw89ncZ25VYGgQ9oQJVCqvhK8mrgMfd02ye/3eU1UcNzWk2uGN
	 rc+/yTDZzk7HrdAcE4P65Bx8mddPI+5mV625lfXEwI+1TASynKuWBAUeTsco5USH1c
	 4XzHyEWH4CeD9rEwwQIPzFFXaupQSg5PAHr0UqkwlIiZ3Q9g0cqgWYYDQh3k/HuFN0
	 gIyIqV89oz8jUcb7m1Wfm9nKEAwCxDJ75+YEaB7g1MN9tqyH0pMapnJyeBLtY+B7y3
	 IY8z5KO2XjpWA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	gal@nvidia.com
Subject: [PATCH net-next] tools: ynl: cli: order set->list conversion in JSON output
Date: Sat,  7 Mar 2026 09:59:16 -0800
Message-ID: <20260307175916.1652518-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8223822D184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265163-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fomichev.me:email,nvidia.com:email]
X-Rspamd-Action: no action

NIPA tries to make sure that HW tests don't modify system state.
It dumps some well known configs before and after the test and
compares the outputs.

Make sure that YNL json output is stable. Converting sets to lists
with a naive list(o) results in a random order.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@fomichev.me
CC: gal@nvidia.com
---
 tools/net/ynl/pyynl/cli.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 94a5ba348b69..b452d4fb9434 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -78,7 +78,7 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
         if isinstance(o, bytes):
             return bytes.hex(o)
         if isinstance(o, set):
-            return list(o)
+            return sorted(o)
         return json.JSONEncoder.default(self, o)
 
 
-- 
2.53.0


