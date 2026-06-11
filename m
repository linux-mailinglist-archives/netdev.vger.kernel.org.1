Return-Path: <netdev+bounces-298126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SxK1MSuvKmrCuwMAu9opvQ
	(envelope-from <netdev+bounces-298126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:50:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47F672090
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:50:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Szc1lnZ4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X2XdxoRs;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Szc1lnZ4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X2XdxoRs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298126-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298126-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D74FD33CBBB3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F483F9281;
	Thu, 11 Jun 2026 12:46:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107FA3F8EC9
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:46:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182009; cv=none; b=WcXGmyNoCZeyI3ZvVsVDRHl4bAa5M9clivgVHy4lPsjd/qyyAAJWEX8XwsG7kj8suRUAHNOS+Jurho9BZaWo7MW1QNn00KnQnrlT5gLa6O2azPrczafOuPp4fn80oa1vikPqrSpZg734L0TNoz2xqsHnBewI9NSrr3zwlBZezi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182009; c=relaxed/simple;
	bh=RqWrQDNNzlxmYpymw1eMIq1WnpqD4vPONq76D4VOzD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hm4FzivxuShxzsRfi3nRTdAO7+KRwEiBMncEKd8pBLfCJ7lrlBmnDQo4TVHk4FZ4bZxsaVZqjq2abn0EGNlIZpECupVQGKtfK4SZs8mQgnAkdsxoKgbmgSXo6DxwORhqu8xCyHB66Bv3dkCow7r72vTS0UCVIq61B2WZuSRDz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Szc1lnZ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X2XdxoRs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Szc1lnZ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X2XdxoRs; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 532386AEFC;
	Thu, 11 Jun 2026 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781182006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BzpYKtYTsb/gy7p/heSdZJScKkGH73POZ6a+foWyPDg=;
	b=Szc1lnZ4SQUwGPUKFxZyZJTGKDopj3R9crYXAQ6sKzeeT8VLXz8e2JUzAhEiCU26xCjbw+
	qzJ25jY+tTl+/mvE32QF48RNv1Gfkq1vLSB52BMp2RBsX9gjXT0lAhahGs1uD9Wcr3rQkE
	Wz+RUAwDHrxOuF4BxY2nqC+YvbEkK6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781182006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BzpYKtYTsb/gy7p/heSdZJScKkGH73POZ6a+foWyPDg=;
	b=X2XdxoRs/JYyDeXVoPNav8S8Oh92s0IHIC2KyyK1wQS6a1EBUJi06fZkywP2dXQ2PNkDIc
	ErxyAys9qbFLw+DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781182006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BzpYKtYTsb/gy7p/heSdZJScKkGH73POZ6a+foWyPDg=;
	b=Szc1lnZ4SQUwGPUKFxZyZJTGKDopj3R9crYXAQ6sKzeeT8VLXz8e2JUzAhEiCU26xCjbw+
	qzJ25jY+tTl+/mvE32QF48RNv1Gfkq1vLSB52BMp2RBsX9gjXT0lAhahGs1uD9Wcr3rQkE
	Wz+RUAwDHrxOuF4BxY2nqC+YvbEkK6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781182006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BzpYKtYTsb/gy7p/heSdZJScKkGH73POZ6a+foWyPDg=;
	b=X2XdxoRs/JYyDeXVoPNav8S8Oh92s0IHIC2KyyK1wQS6a1EBUJi06fZkywP2dXQ2PNkDIc
	ErxyAys9qbFLw+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 032A0779A7;
	Thu, 11 Jun 2026 12:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Db6ODSuKmpaagAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 11 Jun 2026 12:46:44 +0000
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
	Kees Cook <kees@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH net-next v2 0/2] net: isolate SKB data area allocations
Date: Thu, 11 Jun 2026 13:46:40 +0100
Message-ID: <20260611124642.345400-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.54.0
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298126-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,gentwo.org,google.com,kernel.org,gmail.com,suse.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:akpm@linux-foundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:kees@kernel.org,m:pfalcato@suse.de,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C47F672090

This is a rather simple series that attempts to address a possible
exploitation avenue - the allocation of skbs around the network stack, which
frequently get user-controlled contents. Found while doing some amateur
exploitation analysis for some other issue, elsewhere.

Patch 0 is a precursor patch that adds a slab allocation helper, patch 1
does the actual bucketing.

v2:
 - Pick up A-b, R-b tags (thanks everyone!)
 - Cover kmalloc_pfmemalloc as well (Harry)

Pedro Falcato (2):
  mm/slab: add a node-track-caller variant for kmem buckets allocation
  net: skb: isolate skb data area allocations into a separate bucket

 include/linux/slab.h | 7 +++++--
 net/core/skbuff.c    | 8 ++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.54.0


