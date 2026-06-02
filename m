Return-Path: <netdev+bounces-294335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3htfO50hH2q3hQAAu9opvQ
	(envelope-from <netdev+bounces-294335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:31:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBDB631178
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:31:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294335-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294335-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C027B3025C76
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86936395AEE;
	Tue,  2 Jun 2026 18:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB03955F2
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:31:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425105; cv=none; b=kg2ZuiAxmU+H34Aq5OiqK0ko1O6rcdceSnzUUJFzk+S4N7fIjD1Y9/lSQtMuEaTyr1wUcX5rat+pwlRboM2C1cBMU8kVZaXetcTrHwxGtWQUe4ZS5LaxMFQfl0TUHvJ414gAU/RThL7OTPN5tnP41ePRBKmSOOx/flwNIGNmtpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425105; c=relaxed/simple;
	bh=DgMI9uMzrQhZT6TqqtIX/rBBd9+yVcvwNE78GkdB6cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YY1QlJcYIy1WaoHiXRS9eClxIdqyBiMrR7j7qbpC+VVzHNZbgt8NY8ReBJ7wdPV+zki2RSMwVvJgu9GM/iPX3XoYGU0iB4aAm3zhSY/FPyujZVbKFKfr5RQ76EwpzV+lq3Y2iodWACsPeq06j6Z2vQErELDpgxVM3FzyWc+AcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCF2366FF6;
	Tue,  2 Jun 2026 18:31:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72292779A7;
	Tue,  2 Jun 2026 18:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QFZMGI0hH2owXQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 02 Jun 2026 18:31:41 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 1/2] mm/slab: add a node-track-caller variant for kmem buckets allocation
Date: Tue,  2 Jun 2026 19:31:21 +0100
Message-ID: <20260602183122.747759-2-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602183122.747759-1-pfalcato@suse.de>
References: <20260602183122.747759-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-294335-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,gentwo.org,google.com,kernel.org,gmail.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:pfalcato@suse.de,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DBDB631178

This is required by users that want to use kmem buckets, but still
desire specifying the NUMA node.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 include/linux/slab.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7b46fa499b08..685a87d8f0c5 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1153,8 +1153,11 @@ void *kmalloc_nolock(size_t size, gfp_t gfp_flags, int node);
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_KMALLOC_PARAMS(_size, _b, __kmalloc_token(_size)), _flags, NUMA_NO_NODE))
 
-#define kmem_buckets_alloc_track_caller(_b, _size, _flags)	\
-	alloc_hooks(__kmalloc_node_track_caller_noprof(PASS_KMALLOC_PARAMS(_size, _b, __kmalloc_token(_size)), _flags, NUMA_NO_NODE, _RET_IP_))
+#define kmem_buckets_alloc_node_track_caller(_b, _size, _flags, _node)	\
+	alloc_hooks(__kmalloc_node_track_caller_noprof(PASS_KMALLOC_PARAMS(_size, _b, __kmalloc_token(_size)), _flags, _node, _RET_IP_))
+
+#define kmem_buckets_alloc_track_caller(_b, _size, _flags) \
+	kmem_buckets_alloc_node_track_caller(_b, _size, _flags, NUMA_NO_NODE)
 
 static __always_inline __alloc_size(1) void *_kmalloc_node_noprof(size_t size, gfp_t flags, int node, kmalloc_token_t token)
 {
-- 
2.54.0


