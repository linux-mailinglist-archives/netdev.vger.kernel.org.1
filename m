Return-Path: <netdev+bounces-297071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9a1vGvAiKGph+gIAu9opvQ
	(envelope-from <netdev+bounces-297071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:28:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBD5661053
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:27:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WGSm01RU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297071-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297071-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 844473026156
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185333985A;
	Tue,  9 Jun 2026 14:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA128329C54;
	Tue,  9 Jun 2026 14:18:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014715; cv=none; b=H+RPVpbgz/Q0C1JEXIz9r+4MMg+8Tl4xwFad55YrKRIad0F2QVr3V4NE7QX8p9SQ2zW0a4mm4a+kV9eC3BKZMuJ+XW7GuvYnee64i33AVVzfh3+sW+h2bqAp8xq8lQFjw0KsK/bAjulhfpYR43i6WlNhl94qrDfjB/3E+JBQJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014715; c=relaxed/simple;
	bh=gNjm+sdBX18bMzgIVz7A8t2P8pErLQSE/V0U1qan5P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1Ufgg5XgJxznf00F2dl/40/jKXOFN4GppI476znhTb+swdJ8AnoFY2sVW9+4rgYOEK6vnKaKyz+fe5NHULpvgyUEVhAysW/A7G4G/DUXLnuSJnfmMT80+/VNWBdcwf5vJ7+XT+0MsKCz0lRhjc9v1mDKTLyy0rLC8v1VIABLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGSm01RU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69391F00893;
	Tue,  9 Jun 2026 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781014714;
	bh=UkkClT2dmqJYbak4JclcV/JKFUjdZyImxugUEam0q4I=;
	h=From:To:Cc:Subject:Date;
	b=WGSm01RUIu8PEWH+AZhaUuX9V7JGFahae4/ZytzhgeJ9CQPxz8gD/JXwvCkzyDZRl
	 vkgUybjeeVtPC30AqMJsggVQ5l6dkOtmejlvv2+ALnMJIZmreJYhpIY/CGf+9+YEh2
	 Tkes+2R5Smd5t6Lh5rUTitX/OmUo+wRD93Zz3zT5I+X9bFga1ueMOmk35zguA0dEZk
	 6ftF8xIhORQGrBzrJ2jTNi0DTc3qdO+s6qe4038x4w/kmJORWehkMxkmv6o1pkkl6X
	 2BR9U4D2wj6s91X/HaZ62hfF0hvBTHjm7a1B8xILYFBxufgG3b1jKImSQrvrwvhzjD
	 Hw/44iZ0Dv3uQ==
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH net-next] handshake: Require admin permission for DONE command
Date: Tue,  9 Jun 2026 10:18:31 -0400
Message-ID: <20260609141831.90694-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297071-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:hare@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEBD5661053

From: Chuck Lever <chuck.lever@oracle.com>

ACCEPT and DONE are the two downcalls of the handshake genl
family, both intended for use by the trusted handshake agent
(tlshd). ACCEPT already requires GENL_ADMIN_PERM; DONE has
no privilege check at all.

The fd-lookup in handshake_nl_done_doit() only confirms that
some pending handshake request exists for the supplied sockfd;
it does not authenticate the sender. An unprivileged process
that guesses or observes a valid sockfd can therefore submit
a DONE with HANDSHAKE_A_DONE_STATUS == 0, leaving the kernel
consumer to proceed as if the handshake succeeded. A non-zero
status on a forged DONE tears down a legitimate in-flight
handshake before tlshd can report its real result.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/handshake.yaml | 1 +
 net/handshake/genl.c                       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..24f5a0ac5920 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -117,6 +117,7 @@ operations:
       name: done
       doc: Handler reports handshake completion
       attribute-set: done
+      flags: [admin-perm]
       do:
         request:
           attributes:
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 870612609491..791c45671cd6 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -37,7 +37,7 @@ static const struct genl_split_ops handshake_nl_ops[] = {
 		.doit		= handshake_nl_done_doit,
 		.policy		= handshake_done_nl_policy,
 		.maxattr	= HANDSHAKE_A_DONE_REMOTE_AUTH,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
 
-- 
2.54.0


