Return-Path: <netdev+bounces-303337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yr9vNN8WRGpeoQoAu9opvQ
	(envelope-from <netdev+bounces-303337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:19:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B26E7848
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:19:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OXfeWnlw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303337-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303337-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6A330F64FD
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE6D37475B;
	Tue, 30 Jun 2026 19:15:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF63019BA
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:15:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846954; cv=none; b=OXKTsx4tievrF5Zm7UwUZ/PSweemDEaoxXicf92/LW9now1Bn1tshnfD1MqnfeZOkYwbjCWGrhTKwQI0rSSNoy34EtLs4xt9EaCerZdEiFK8CkCkAR4GjrEsFa+0jtHGlXtRBKIXfsiheaATxlkcATIXA8MIIeMghHpltep06EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846954; c=relaxed/simple;
	bh=V8iiieoM4chbcM6uxH0t+6M1my8HsWOoynsGIWvgwiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAAY238x5eU2B/FNjnXDwzzMtJb7hDlG9frqO5c+9YvQmLHTZlEfEY1/oW33W3IJF+LYw4bGadKjoLFFmMhEN/U1VnQ71rJkVMPvM7SUjIUinPbSk/DxPABjI8LGAZSrnRGvgkxTZDjYIGyuRUetGqP+GLi3B/r8qGGzxSpix2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXfeWnlw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930CE1F000E9;
	Tue, 30 Jun 2026 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782846953;
	bh=apooQY66Tp01aRQkf67rYoR7AtFFMg8jb2Oxmu13TRA=;
	h=From:To:Cc:Subject:Date;
	b=OXfeWnlwb4UU8geO9/jHtxr/gfH/RHd5xgFN4nZjVAZih2ij+3Trgao2E0ZrujRln
	 Kzyy/w7tfieZedgek2qBFO0JTW6ODkmlxCsDKqmDlXPntyRniTKgsvTk7Pf+IN6+fF
	 +MNwELlkYNyhtcNfmfiCpzVGrBOXV2eUgpkSt49eddqipOTYAzVxzt86IZoAe34XzZ
	 dlZMfPRWOri0U5wNfm8KmmVFOEJuH+kE3YSlRAu+uwdTFgFnjzCCJevHw1dWT7IiC+
	 jHK72bXolab9Fpf9LrumjBZ3zQd2YQvwHPN8w00Fw5B+D6etb/AvnT7VOY1H+VKHYJ
	 5XOob7aaY7RIQ==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net] net/tls: Consume empty data records in tls_sw_read_sock()
Date: Tue, 30 Jun 2026 15:15:51 -0400
Message-ID: <20260630191551.875664-1-cel@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-303337-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 235B26E7848

A peer may send a zero-length TLS application_data record; TLS 1.3
explicitly permits these as a traffic-analysis countermeasure (RFC
8446, Section 5.1). After decryption such a record has full_len ==
0. tls_sw_read_sock() hands it to the read_actor, which has no
payload to consume and returns zero. The loop treats a zero return
as backpressure (used <= 0), requeues the skb at the head of
rx_list, and stops. rx_list is serviced head-first on the next
call, so the empty record is dequeued, fails the same way, and is
requeued again; every later record on the connection is blocked
behind it.

tls_sw_recvmsg() does not stall on this: a zero-length data record
copies nothing and falls through to consume_skb(). Mirror that in
the read_sock() path by recognizing an empty data record before
the actor runs, consuming it, and continuing.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 net/tls/tls_sw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9324e4ed20a3..d4afc90fd796 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2115,6 +2115,17 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			goto read_sock_requeue;
 		}
 
+		/* An empty data record (legal in TLS 1.3) gives a zero
+		 * read_actor return, indistinguishable from the consumer
+		 * stalling; the used <= 0 path would requeue it at the
+		 * head of rx_list and block all later records. Consume it
+		 * here instead.
+		 */
+		if (rxm->full_len == 0) {
+			consume_skb(skb);
+			continue;
+		}
+
 		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
 		if (used <= 0) {
 			if (!copied)
-- 
2.54.0


