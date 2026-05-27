Return-Path: <netdev+bounces-292194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOe1G8iuFmokogcAu9opvQ
	(envelope-from <netdev+bounces-292194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D97455E143B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED35A3035D40
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A963C81A3;
	Wed, 27 May 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="UEJfz98T"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621D3E0C40
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871340; cv=none; b=VYWGrcFf4qew572D69rVbOQ518/c5hPrQuWeXFqb6Nt8LLSAHducIsa6kKm+y6A8PKY39DgkBFV1JQ9+1ESySdYiNxLOVS+y3q+9J1+suWnwLBn7cz0zfHaBIwxWU+yd0t9ny6gB7rAvClO+ukzLjrNT//sS5R05eH9mB+tj2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871340; c=relaxed/simple;
	bh=/izszOpthDhootIGGTkKGh55bXtyqI+1GS/KFD76RvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CV2AXCczIpN+3lwrZ8Gj9b59TcLN4nwMlzw+SIByuxSdHOMFLOYlBwrUKpwNyAFeh1+/JpvKLzU8i9F+x9oWVqy0qF4XV7ldgKTuKlDKIw3YRmANkL02xfEISpwItyq8r1fnlUM0p/fntmnc1Z8TA1K9INJncSTrTwHaLPPDJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=UEJfz98T; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 64DE320764;
	Wed, 27 May 2026 10:42:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMPuj2ByX8KL; Wed, 27 May 2026 10:42:09 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B53CE2074F;
	Wed, 27 May 2026 10:42:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B53CE2074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779871329;
	bh=Z51YuHhdd9x3+E62LaZCa9un8uZMFr+Y/Iy0U1//+Qw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=UEJfz98THX7DGI9CAlWbfAyKSD4nqavaNlb7rAFoxP1XXKO+STSGf8r+413lrWW+s
	 FHTOjlWFwaiB35XQxpdUhw1EQMgULGexFdxOifX/2eh4InXEp5MUcxmALh47RF2yrP
	 r7CHrxEUZg8COTRhsnEnt1fkOVkCZxr5E7nauY2hObMw7WXd/FZBWYIYcJzwJfVDnz
	 vdyUK3ZabuB7Dsw3z44X8tW2Nr1lqTHtWM82Z4UKHJL0dGeIZnslJfW1lcMCrx+LLB
	 TbzIAQK1m3Qu3RHWpsCZZ9j5a2y7qRQh6AvwEAWovn6bVhOyAFPS1vU+Ufu0Ve541B
	 9juX97WHB9HIA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 10:42:09 +0200
Received: (nullmailer pid 3494006 invoked by uid 1000);
	Wed, 27 May 2026 08:42:01 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 7/9] xfrm: iptfs: reset runtime state when cloning SAs
Date: Wed, 27 May 2026 10:41:25 +0200
Message-ID: <20260527084148.3489759-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527084148.3489759-1-steffen.klassert@secunet.com>
References: <20260527084148.3489759-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-292194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,secunet.com:mid,secunet.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D97455E143B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shaomin Chen <eeesssooo020@gmail.com>

iptfs_clone_state() clones the IPTFS mode data with kmemdup(). This
copies runtime objects which must not be shared with the original SA,
including the embedded sk_buff_head, hrtimers, spinlock, and in-flight
reassembly/reorder state.

If xfrm_state_migrate() fails after clone_state() but before the later
init_state() call has reinitialized those fields, the cloned state can be
destroyed by xfrm_state_gc_task() with list and timer state copied from the
original SA. With queued packets this lets the clone splice and free skbs
owned by the original IPTFS queue, leading to use-after-free and
double-free reports in iptfs_destroy_state() and skb release paths.

Reinitialize the clone's runtime state before publishing it through
x->mode_data. Because clone_state() now publishes a destroyable mode_data
object before init_state(), take the mode callback module reference there.
Avoid taking it again from __iptfs_init_state() for the same object.

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Cc: stable@vger.kernel.org
Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e55ba..6c6bbc040517 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2650,7 +2650,8 @@ static void __iptfs_init_state(struct xfrm_state *x,
 	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
 
 	/* Always keep a module reference when x->mode_data is set */
-	__module_get(x->mode_cbs->owner);
+	if (x->mode_data != xtfs)
+		__module_get(x->mode_cbs->owner);
 
 	x->mode_data = xtfs;
 	xtfs->x = x;
@@ -2658,22 +2659,39 @@ static void __iptfs_init_state(struct xfrm_state *x,
 
 static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 {
+	struct skb_wseq *w_saved = NULL;
 	struct xfrm_iptfs_data *xtfs;
 
 	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
 	if (!xtfs)
 		return -ENOMEM;
 
-	xtfs->ra_newskb = NULL;
 	if (xtfs->cfg.reorder_win_size) {
-		xtfs->w_saved = kzalloc_objs(*xtfs->w_saved,
-					     xtfs->cfg.reorder_win_size);
-		if (!xtfs->w_saved) {
+		w_saved = kzalloc_objs(*w_saved, xtfs->cfg.reorder_win_size);
+		if (!w_saved) {
 			kfree_sensitive(xtfs);
 			return -ENOMEM;
 		}
 	}
+	xtfs->w_saved = w_saved;
+
+	__skb_queue_head_init(&xtfs->queue);
+	xtfs->queue_size = 0;
+	hrtimer_setup(&xtfs->iptfs_timer, iptfs_delay_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
+
+	spin_lock_init(&xtfs->drop_lock);
+	hrtimer_setup(&xtfs->drop_timer, iptfs_drop_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
 
+	xtfs->w_seq_set = false;
+	xtfs->w_wantseq = 0;
+	xtfs->w_savedlen = 0;
+	xtfs->ra_newskb = NULL;
+	xtfs->ra_wantseq = 0;
+	xtfs->ra_runtlen = 0;
+
+	__module_get(x->mode_cbs->owner);
 	x->mode_data = xtfs;
 	xtfs->x = x;
 
-- 
2.43.0


