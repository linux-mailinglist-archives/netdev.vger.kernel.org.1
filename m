Return-Path: <netdev+bounces-305631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ByixCUi5TWoK9gEAu9opvQ
	(envelope-from <netdev+bounces-305631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 04:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E947213A8
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 04:43:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RQ5gTMTs;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305631-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305631-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C573028ED1
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 02:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23C3B810D;
	Wed,  8 Jul 2026 02:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4163264D1
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 02:43:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478597; cv=none; b=e5OgHgQF5ebFLUo/BT2s8sjXXTJ2rF66+URyKsEfJsmQqXTXxjSvnxij9mzgKfQ627mioyDQm2P7smo7fQ1fYCCjmTFP1s5Yyq2gM8PkP9m5BjRY87AHePgoUf169E248bwNMgA81ImSqEgef3vYoU00xz4ohmhvkn/hBIkaKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478597; c=relaxed/simple;
	bh=9PhDEKR7C9J2OI6K8pva85ZUSJsZwLH3T/IFErrEJic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZ7C3+j3W0dBNV3aZw9k7UGfZBxiDg55//yLdJCE54xUy7D3mk2LlTVFiEszPKCtE/jlm8aUacMyIIqDztVOnUPZzbUZiTFDkUQuX48QqDpIUjirpNqE4/asocdIce7Sh5TjiU6kjFYw08ptnOA1Vxw6lb9/M1yFD/phzgarkqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ5gTMTs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F331F000E9;
	Wed,  8 Jul 2026 02:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478596;
	bh=6PlpUvdRS9mYtYZigrdUtbfOf23afjkM9Y45k0lal+Q=;
	h=From:To:Cc:Subject:Date;
	b=RQ5gTMTsY4RZBODaaem7R24K8qSFI7ynwCBjIgO8w9DPv+Sp+JCwaSzKd5urd9nZW
	 6EgP6x37CMpSSKyNPwtSpeL5a59T0UA5IfBxoxtAMYhuDi65FqempyhmezWnbaaH+e
	 nlDZ5BZF1VRMY3MnYeCthYr1xeuPUDb4lz/9uxhdLyCmB6CrXghuaztABG7ppAmrG0
	 /joxTcS1WNgtfmyokou91hdofTeo8Ujkjd/yZ/BS5s+9Via+kI8MPAQSqHtCWp3fUF
	 /R7UjGZlvfmkhtJ54wfdMLQ0z6NO5ul/5FXxTfh4OcIxXJXsMRIoEUtmvoeZ7BXz6t
	 WMwv7q6h/9zrw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org
Cc: achender@kernel.org,
	qwe.aldo@gmail.com
Subject: [PATCH net] rds: drop incoming messages that cross network namespace boundaries
Date: Tue,  7 Jul 2026 19:43:14 -0700
Message-ID: <20260708024314.601139-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	FORGED_SENDER(0.00)[achender@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:achender@kernel.org,m:qwe.aldo@gmail.com,m:qwealdo@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-305631-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71E947213A8

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

rds_find_bound() looks up the destination socket using a global
rhashtable keyed solely on (addr, port, scope_id).  Network namespaces
are not part of the key, so a sender in netns A can deliver an incoming
message (inc) to a socket that lives in a different netns B.

When this happens, inc->i_conn points to an rds_connection whose c_net
is netns A, but the receiving rs lives in netns B.  Once the child
process that created netns A exits, cleanup_net() calls
rds_loop_exit_net() -> rds_loop_kill_conns() -> rds_conn_destroy(),
freeing that connection.  If the survivor socket in netns B still holds
the inc, any subsequent dereference of inc->i_conn is a use-after-free.

There are two dangerous sites in rds_clear_recv_queue():
  1. inc->i_conn->c_lcong (offset 88 of freed rds_connection, size 200)
     read via rds_recv_rcvbuf_delta() -- confirmed by KASAN.
  2. inc->i_conn->c_trans->inc_free(inc) (function pointer at offset 80)
     called via rds_inc_put() when the inc refcount reaches zero -- same
     race window, potential call-through-freed-object primitive.

The bug is reachable from unprivileged user namespaces
(CLONE_NEWUSER + CLONE_NEWNET), available since Linux 3.8.

Fix this by rejecting the delivery in rds_recv_incoming() when the
socket returned by rds_find_bound() belongs to a different network
namespace than the connection that carried the message.  Use the
existing rds_conn_net() / sock_net() helpers and net_eq() for the
comparison.

Fixes: c809195f5523 ("rds: clean up loopback rds_connections on netns deletion")
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Reviewed-by: Allison Henderson <achender@kernel.org>
Tested-by: Allison Henderson <achender@kernel.org>
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/recv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/rds/recv.c b/net/rds/recv.c
index 4b3f9e4a8bfd..cf3884d87931 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -399,6 +399,21 @@ void rds_recv_incoming(struct rds_connection *conn, struct in6_addr *saddr,
 		goto out;
 	}

+	/*
+	 * rds_find_bound() uses a global (netns-agnostic) hash table.
+	 * An RDS connection created in netns A can match a socket bound
+	 * in the init netns, delivering inc cross-netns with inc->i_conn
+	 * pointing into netns A.  When cleanup_net() then frees that conn,
+	 * any subsequent dereference of inc->i_conn is a use-after-free.
+	 * Drop the inc if the receiving socket lives in a different netns.
+	 */
+	if (!net_eq(sock_net(rds_rs_to_sk(rs)), rds_conn_net(conn))) {
+		rds_stats_inc(s_recv_drop_no_sock);
+		rds_sock_put(rs);
+		rs = NULL;
+		goto out;
+	}
+
 	/* Process extension headers */
 	rds_recv_incoming_exthdrs(inc, rs);

--
2.53.0

