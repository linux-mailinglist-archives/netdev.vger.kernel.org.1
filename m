Return-Path: <netdev+bounces-295373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7GJOE366IWrLMgEAu9opvQ
	(envelope-from <netdev+bounces-295373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:48:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B681264263A
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:48:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KLfqgcf5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295373-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295373-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D624300999F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615734CA263;
	Thu,  4 Jun 2026 17:48:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B764BCAB5;
	Thu,  4 Jun 2026 17:48:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595322; cv=none; b=bmI2xvTFxCUIO8o8ZnTd3Pz6O2OBJOPDVTkqtjGA1PCr6BRXAfRebkYyVbT1+8NIeUUEzibzdOcvToJyL9yu7ZtCYBUXzCe7DAK53om0ZN66ftbKDxj0iIQbIlxq0SjBWQFm8Et1KJO9dANeRHQmkVNGp/cWl+oatCV9bcwy6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595322; c=relaxed/simple;
	bh=qMYGD3EBxIqebJ0hK+ekeTxweXzm1I7/C13o3mt3qco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAQCHvioSA0e4gqH5oqjU0WmJadEmqycsIWN5ZJ6IiXBCSqFmZI85Jv21UvszZTNpneBVfKW5XzwPTzNH0PANjoLgJViayUtS1dPafuwa7j50ntW6RJTCeNz+2R22dMuDruQNLj5tiT1lwYy4ayDshq+Wi5gTxaepgmueVuN/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLfqgcf5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996001F00898;
	Thu,  4 Jun 2026 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595321;
	bh=t5QuJAJ+c1HX7XZVKmvLYUN9W0/ZGp49fsN/dgTevis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KLfqgcf59usIsleHEZDffqDhRZD4sqpTWpNWtKgBbkP+tdiZtvNxPjkKNbcGv9wwo
	 1RYEemLOg19HnFO0fvUfKE+ruLymual1YNKtcIScA0Jlt0r7SFySlHVR8zzAFW2/pJ
	 MjJp50RKuDg3tAFvjvr/qwh5dLSEwOJqdFmGaAVNMwo2tXNu/XkKzapsNR/uf61+V3
	 hY91J3UUOh5PQll+ZO9qGLzIKYtfB44+K8yJ4W7oJyRtekkGtvJhPF2+BZ3m0Uy195
	 4GWHtZ8uzD+ummxcouMDNYiNSWAZcwPFEEOH1TLKwXKamGwMurIGlN3NAOxvUIN9aE
	 x0yeiFdFW+rGQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:48:24 -0400
Subject: [PATCH net-next v12 1/6] tls: Avoid evaluating freed skb in
 tls_sw_read_sock() loop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-tls-read-sock-v12-1-b114efa6e3e2@oracle.com>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
In-Reply-To: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=9B0CXUbhTqWYS+ZD3rmXmWPrCidVCn7xrxqwLuGowGI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbp32i7c5sAXQvbZsQjCuxf1s4vWYxFD9bFa1
 jTxCwHnvEyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiG6dwAKCRAzarMzb2Z/
 l2rSEACaCVsMfcL5fcZmVSHfJQPkiSBYkn2OjCa7cBropABN60LriCZUlYaQqTmkpCL5IiYz3NT
 RHRK5a7Ff2aussCJBYnyP0srL4wi62lRAECVJVUXc7rUAOZ49IvAE2yMTq+C6pXPca+5kM2pfjU
 W3JgUw1lulCqPhJYKDFQVpmYzOPrIN2zYjW809sPyHgSO+AmgTZuk7eLwkblCIua6K5svN01Sap
 hS52/xxK/5SwPhzETjmVc/Qb4MuNNgMTBxtYanQmGYtk7pt1woiA5VS4q4uv/WkgZeaY3R8l4Ik
 Jqhsrb/jdg/OaFL1kVulN4GAuV0T5WxJk9WYZaT25cFPdlmxS78fzf1+7pQqlatWoroh9PyNlzx
 e6aGM7APU/IivGRWSkLaEKW3ZnEwWcBicQNvZqnbFZ58O4E7MrIIyMgbQA6LjSEHUKCiMbNfHQm
 R3dtmQoeHZ0VgcZpmL8ts+WCnBmRHxidHuMxNcqFyVQjH6sVoZ3v7aneQj/ETN664gM7Zx7WwVZ
 NtWe4k0FtK9WA0fnH3VuIyuz2oBPlJ0cFtw641HqCDsRYsE8bqyXgn2J1IEbTrQG6Wrn9f2+pxb
 +rpudKn6FolVtwzxSfx+aBk62gYpgIbHtljiXjztuMxyczPZY+WkgGRASDxXwJq41toUoZbj15a
 E4l+ccykZcF2pwg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295373-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:sagi@grimberg.me,m:hare@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,grimberg.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B681264263A

From: Chuck Lever <chuck.lever@oracle.com>

tls_sw_read_sock() ends its receive loop with while (skb), but
the else branch in the body calls consume_skb(skb) before the
predicate is re-evaluated. A pointer becomes indeterminate when
the object it points to reaches end-of-lifetime (C2011 6.2.4p2),
and using an indeterminate value is undefined behavior (Annex
J.2). The pointer is not dereferenced today -- the predicate
either exits the loop or skb is overwritten at the top of the
next iteration -- but any future change that adds a dereference
between consume_skb() and the predicate would silently introduce
a use-after-free.

Replace the do/while form with an explicit for(;;) loop so
termination happens through a break statement rather than
predicate evaluation of a freed pointer.

Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee4..8e4e57721335 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2383,7 +2383,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2435,9 +2435,9 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		} else {
 			consume_skb(skb);
 			if (!desc->count)
-				skb = NULL;
+				break;
 		}
-	} while (skb);
+	}
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);

-- 
2.54.0


