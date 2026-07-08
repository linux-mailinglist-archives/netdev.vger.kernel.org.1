Return-Path: <netdev+bounces-305718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qhkVA1AaTmo7DQIAu9opvQ
	(envelope-from <netdev+bounces-305718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:37:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 892EB723CE0
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:37:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=GQFatmxv;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305718-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305718-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E753A301649E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109241B347;
	Wed,  8 Jul 2026 09:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164F41C2E8
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 09:37:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503427; cv=none; b=WVch6w7cH9YgESfGu/KMPFr+Lt5Z9SdIcaQwUzQcJWBqop/siOc/FmPwIV/2e466sEvxN5hGRysgv0kTsp+16S2GiJgOY0ruMefhXZ9MYlVkLm6jejurHRf6I26bHGVmDMAKsnDWkGhS/CLgiBW5EaSUb134wOXXfiP2iLq5MGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503427; c=relaxed/simple;
	bh=DzsX1puom5eEftUovrdNZ95H6ISbQl90ZBBHvuTcBdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwUzMRpjEjm0OWWtLh8mb9RaJy2WJaduzzH9XpY5w0ePweolKeJsWMd8PlIV/G0sxedH+Or6EtOQdd44n9jgf2v0B73XPF1pYgaiQaVT6+b7IZWAi5+tWAusiBQK/0cHIxbFrsx1QfDruXSy9QEGv3aCePXF6sKavc3y0x1jHKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GQFatmxv; arc=none smtp.client-ip=91.218.175.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783503411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ydX26kqe1zakyWKUhYdu+Skm/dFs17mN2Looq9WX1As=;
	b=GQFatmxvNfZvuFNZUMKCO+9nP07ZBojZc2FU7TCp9ctSRUsBVvXcykzBE2YV99igOX+J+d
	XeChxXLvgy1lLNxEx8FzxYbXVMxO3uM1jNZCNwDh9tEoDPcmWEqOLPgi9R2WFm5Wjx96K7
	p2dNeN5biWPm6HltpKDaG+vIGGacans=
From: xuanqiang.luo@linux.dev
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	netdev@vger.kernel.org,
	linux-afs@lists.infradead.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1] rxrpc: fix io_thread race in rxrpc_wake_up_io_thread()
Date: Wed,  8 Jul 2026 17:35:34 +0800
Message-ID: <20260708093534.53486-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305718-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:netdev@vger.kernel.org,m:linux-afs@lists.infradead.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 892EB723CE0

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

rxrpc_wake_up_io_thread() checks local->io_thread before waking it, but
then reloads the pointer for wake_up_process().

local->io_thread is cleared with WRITE_ONCE() when the I/O thread exits, so
the second load can see NULL even if the first load did not.

Take a READ_ONCE() snapshot and use it for both the NULL check and the
wake_up_process() call, as rxrpc_encap_rcv() already does.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/rxrpc/ar-internal.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index ce946b0a03e2b..865f05fe37ab9 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1285,9 +1285,11 @@ int rxrpc_io_thread(void *data);
 void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb);
 static inline void rxrpc_wake_up_io_thread(struct rxrpc_local *local)
 {
-	if (!local->io_thread)
+	struct task_struct *io_thread = READ_ONCE(local->io_thread);
+
+	if (!io_thread)
 		return;
-	wake_up_process(READ_ONCE(local->io_thread));
+	wake_up_process(io_thread);
 }
 
 static inline bool rxrpc_protocol_error(struct sk_buff *skb, enum rxrpc_abort_reason why)
-- 
2.43.0


