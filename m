Return-Path: <netdev+bounces-276420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLaGB/8n1mnqBQgAu9opvQ
	(envelope-from <netdev+bounces-276420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:03:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896A3BA3C0
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE23D30214D2
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DC33ACA4D;
	Wed,  8 Apr 2026 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lCmIcmyn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IZnxT5HF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y/bIQx8u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EmJLmDRE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367A3AE6F8
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642488; cv=none; b=Bo7AFK/mSr18UYS8Lx97FMbytH9WG2tAtrFMwgiqtFqf2Cdaf0zQOZcXO+S0wgkj2jpFr1R6xjXMb42PUNgau+TJd1/hyzX3Ujz32uQ0WOFxtMYwrwpard23C60zp4daL5UJbILMHqQwTNp7HXaVaLuGQ+hbDJAToXBABqkNjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642488; c=relaxed/simple;
	bh=o9G0ESITGt8bD7yHpxtHtByUW59Ln3rfeQ6hEsdMN+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkL4eXNgVYg0HiWmlke+XHxCsyH7vVRqNcH8doNNWbAXdz6qSZeYye/AH98Gy42LnmtOo0TNok+d2hsL1ID3UKIuEtUJzJWL8uBn9PUX/z6tAbXGEFShtthKplfmDkpHnCk40foz0DwaYUbZydHQnXh88G2kAC7tCn9yPezN6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lCmIcmyn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IZnxT5HF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y/bIQx8u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EmJLmDRE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C387F5BDAD;
	Wed,  8 Apr 2026 10:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775642475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7skRdaNZDZXmQ9WYJqJLISS+UfM6/3eGEqzYzcD/CC4=;
	b=lCmIcmynqtHkFZdMPLx2SoIQjGKyzygGEbbd4ju11qcsqFRFgnkWOur+1DRagx2x4C98cv
	qgOhLMViSeE4D+QhLQb9HoynJR0WuMgD7W2ILXw8NFkic+kabxchCNYvveQhFjO7mF7hLp
	Q6pKo6FXvSkx29ise7VyKk6iVAwJMaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775642475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7skRdaNZDZXmQ9WYJqJLISS+UfM6/3eGEqzYzcD/CC4=;
	b=IZnxT5HFmO8c2rEU6gQPhzL1uqGVboqxmgX6/T4vv67EYT942hHWI3T4EuGaIz7gN45kpT
	3vNj04ZpGD8AzKBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="y/bIQx8u";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EmJLmDRE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775642470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7skRdaNZDZXmQ9WYJqJLISS+UfM6/3eGEqzYzcD/CC4=;
	b=y/bIQx8uuWLRU8khN6vNGFsV5VY9qiS3BIlodXUNgOPm5mgwn1dP4H2h6GyfmFgigGVk07
	TViuClkaSsF/nfhJOGwXKODO7b4fv4/EMLLrGdlI6zZH42YchkfQs+BResiI6AQwmlWrux
	aLL3aHkaHa0quS++DOV9XNI+gMjsR9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775642470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7skRdaNZDZXmQ9WYJqJLISS+UfM6/3eGEqzYzcD/CC4=;
	b=EmJLmDREGnA4mf57XRvInHrsliCJkU9L1OchSnRPuOM1kyJ4uf3L8BIszv29yzkP8/2BHN
	Gq5Hicu8Aa+L0IBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 472734A0B3;
	Wed,  8 Apr 2026 10:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L7JrDmYn1mmDVAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 08 Apr 2026 10:01:10 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Damilola Bello <damilola@aterlo.com>
Subject: [PATCH net v2] net_sched: fix skb memory leak in deferred qdisc drops
Date: Wed,  8 Apr 2026 12:00:44 +0200
Message-ID: <20260408100044.4530-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 7896A3BA3C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the network stack cleans up the deferred list via qdisc_run_end(),
it operates on the root qdisc. If the root qdisc do not implement the
TCQ_F_DEQUEUE_DROPS flag the packets queue to free are never freed and
gets stranded on the child's local to_free list.

Fix this by making qdisc_dequeue_drop() aware of the root qdisc. It
fetches the root qdisc and check for the TCQ_F_DEQUEUE_DROPS flag. If
the flag is present, the packet is appended directly to the root's
to_free list. Otherwise, drop it directly as it was done before the
optimization was implemented.

Fixes: a6efc273ab82 ("net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel")
Reported-by: Damilola Bello <damilola@aterlo.com>
Closes: https://lore.kernel.org/netdev/CAPgFtOLaedBMU0f_BxV2bXftTJSmJr018Q5uozOo5vVo6b9tjw@mail.gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: added RCU read lock protection around root pointer and used root
qdisc to append the packets to free
---
 include/net/sch_generic.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c3d657359a3d..5fc0b1ebaf25 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1170,12 +1170,22 @@ static inline void tcf_kfree_skb_list(struct sk_buff *skb)
 static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
 				      enum skb_drop_reason reason)
 {
+	struct Qdisc *root;
+
 	DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
 	DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
 
-	tcf_set_drop_reason(skb, reason);
-	skb->next = q->to_free;
-	q->to_free = skb;
+	rcu_read_lock();
+	root = qdisc_root_sleeping(q);
+
+	if (root->flags & TCQ_F_DEQUEUE_DROPS) {
+		tcf_set_drop_reason(skb, reason);
+		skb->next = root->to_free;
+		root->to_free = skb;
+	} else {
+		kfree_skb_reason(skb, reason);
+	}
+	rcu_read_unlock();
 }
 
 /* Instead of calling kfree_skb() while root qdisc lock is held,
-- 
2.53.0


