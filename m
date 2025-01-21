Return-Path: <netdev+bounces-160021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EECA17D3D
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 12:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD49C3A574F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39B1F1503;
	Tue, 21 Jan 2025 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iRQ5NKOm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="84/+LszD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zF6jtSxI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HL/fE1JG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED41B425A;
	Tue, 21 Jan 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737460220; cv=none; b=YKF9zY95q995BPrUcMwX06SU+P7dIBCjV4IMoh/n4DFaey0+6Vjk5hn5vU8MusINpOo9YE79IwxO5xwBz5xbXcc7mxwB0vtt6tROCsW1Bu7cDrtikGeFvsmJmm26y/TBTPwsXS5ksn2QYoBl9aOANPIsA2+uS7VykEiOmEEpg/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737460220; c=relaxed/simple;
	bh=krRyIIq1b6LjmqE5sDNCCZHNDPnhWSO/speX8aWbfTo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mfFLLoqEyNSs5cCf4Mbb8z8OAQU9FZ4ViglTqh/oRYylIWUsCZv1k33bNPkCjk5SeNXYB8JHOlIZVWXc2ARL+Cyv76kjgWV5mxMwWZog8ibK3s7uEV57NCaGHcDRxoTAmoRz6z14T2Dpn5kwJpLWiVkgB9wfwavmdei4Dx3BxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iRQ5NKOm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=84/+LszD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zF6jtSxI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HL/fE1JG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4B8421176;
	Tue, 21 Jan 2025 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737460216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RIWrS1/5RhMOeOfyBh8+VB7f7ZgJUSbWeTNLGa7fnI8=;
	b=iRQ5NKOmY9RT/DQqQX2KQUfpUwMBybiZKXoDHZKq1XQnJWMN4nI0F9SIPqaEKQvJrzsisE
	zB8kXS7SDFHIrRiCJJRmc5CE1fjaIQMfLhU6chchokWQYNeVAmEW0iQXy+Xz9xq3WtiDeC
	/qSv0s19Fr5t+Fn655sHsIilsAgheaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737460216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RIWrS1/5RhMOeOfyBh8+VB7f7ZgJUSbWeTNLGa7fnI8=;
	b=84/+LszDSb2GmQdgY5us5C6uP6sqSMQaygvnWg8jU9etHmqxTF6X+rOKQfj5aECYa4qvCc
	Tt4u7Bm2ZxXHcMAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zF6jtSxI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="HL/fE1JG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737460214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RIWrS1/5RhMOeOfyBh8+VB7f7ZgJUSbWeTNLGa7fnI8=;
	b=zF6jtSxI4Eb59CiZutR9AinyVoIf4QqFhunF4YlItaJ1MW2xvawzGa4qHzDeyl5okjJhys
	1uWdRQxvGxvyDrG94StrWLk/377o8oO/XwsfXuIJs+E6ROTHIiGCBb2xDD3k32TNCFysl4
	mhmYfavBAvhVfFgiy8HF3cI5WTKT2Vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737460214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RIWrS1/5RhMOeOfyBh8+VB7f7ZgJUSbWeTNLGa7fnI8=;
	b=HL/fE1JGnn5QnG0FMrbBms4Ft3YGQnps2ESwHF8qSOjp1TXy0mSvybvtcYmwlpQtGNdY6w
	nwDtCe1H/ERcINCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D070813963;
	Tue, 21 Jan 2025 11:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S9vAMvaJj2exDAAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 21 Jan 2025 11:50:14 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned skbs
Date: Tue, 21 Jan 2025 12:50:10 +0100
Message-Id: <20250121115010.110053-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4B8421176
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

gro_cells_receive() passes a cloned skb directly up the stack and
could cause re-ordering against segments still in GRO. To avoid
this queue cloned skbs and use gro_normal_one() to pass it during
normal NAPI work.

Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
--
v2: don't use skb_copy(), but make decision how to pass cloned skbs in
    napi poll function (suggested by Eric)
v1: https://lore.kernel.org/lkml/20250109142724.29228-1-tbogendoerfer@suse.de/
  
 net/core/gro_cells.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index ff8e5b64bf6b..762746d18486 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -2,6 +2,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/netdevice.h>
+#include <net/gro.h>
 #include <net/gro_cells.h>
 #include <net/hotdata.h>
 
@@ -20,7 +21,7 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 	if (unlikely(!(dev->flags & IFF_UP)))
 		goto drop;
 
-	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
+	if (!gcells->cells || netif_elide_gro(dev)) {
 		res = netif_rx(skb);
 		goto unlock;
 	}
@@ -58,7 +59,11 @@ static int gro_cell_poll(struct napi_struct *napi, int budget)
 		skb = __skb_dequeue(&cell->napi_skbs);
 		if (!skb)
 			break;
-		napi_gro_receive(napi, skb);
+		/* Core GRO stack does not play well with clones. */
+		if (skb_cloned(skb))
+			gro_normal_one(napi, skb, 1);
+		else
+			napi_gro_receive(napi, skb);
 		work_done++;
 	}
 
-- 
2.35.3


