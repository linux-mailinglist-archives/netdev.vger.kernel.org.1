Return-Path: <netdev+bounces-289667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMddDqgDDWrXsAUAu9opvQ
	(envelope-from <netdev+bounces-289667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8370A58654B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E599F3018D57
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16040221FD4;
	Wed, 20 May 2026 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgB3HWgS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08C14A60F
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237794; cv=none; b=hwoiyFfEqkmEYZsn6NgUiWTxyvFE/TwpDDBDAnygl3eGGS6OZ9GSI6TyGixmDAdwi9UaQIwxzYyVTwt0UcneAandeRtJVayPpyYayyEVt9oQiKaWIdNH5yXmBgsoDVylsSM0bPZikIkz4FESVkOJ4Re+TNnTOo34z8/UgGuQTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237794; c=relaxed/simple;
	bh=a5UshyE/bkF5sH8kPnnlkA8aFTOAxuPpX+MUydmVDnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAZQRIJH0axWFGtrnNn0FvwVpweZI/Ncqa7rcanRCSvYPtWpGj55sbtgyNEW/Ch0uy45qYfSy4bckPeHqTiMtT/Daqxrh1k9Bm9y4cM2+lq1G+lpbryGvwQq8ON68RDNGlx0bu8LjECjw6FoaK8VwodFsW/LhjT9Avc48U/ccB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgB3HWgS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso2497795a91.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237792; x=1779842592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZXYU5Yo6j5J7XOLRXMLLYjxyG0GpFZ6EWg+P+KiBs8=;
        b=VgB3HWgSyA8+CY0ZVHQc6f1TLem45BjHXgeHpuSqxP5otJyt/WW0MczKW5oYotPwvT
         EcUV7ArV3fM9fXLJnT0TeSlVcLYLbZjPxUJb+37uUjIMtpo10vc8Q7HLhyStZNzhLjEl
         KKFlBuDCj4wQqMXgR9Gj6od4DB9pEuf1tKvhwZnZePHN6iiP9HeqvLlMzW57/UadQlYu
         KC9MLDjF685XuK9jrkrs41OQseP/j0o098vuvNhxRL9Hyz+6DCmXyDMZMx8L6/Yycbga
         WAxnFwacgCoAX/4oul+StqwpZN48y/pgbOTWar3b3EUO5k6ZzGUfGP3+514yf0RwS4Ky
         KJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237792; x=1779842592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZXYU5Yo6j5J7XOLRXMLLYjxyG0GpFZ6EWg+P+KiBs8=;
        b=S/yLtAiI2FE00O6mS0FlMxN4urVpZVDgWB9EK5hAu8jyeY/VVlEHVlaRbpSJvOXwSE
         wM4bwLexXynfsltdOzZWkmoQnfV22YVDK8jnhhz/UelvwMjIKNL5s7FnU3CLzi90UK10
         ewM3AfC5MDNNdeh+Fxg0fasgO18hJQFHM800OwN4JhbKAoIP5VXmNRibAZHZ0JIPJkeo
         vdNwdfds1RG3ZSTCQKQwi3oV4MObrX3JqEcSCuumMb1NWx/D24EtL2FcQetOsZbPGs4w
         UBwZWz9gVTb999mV6BUwXtWN7vSMT3784TU0s0MeQWBHtE+3O+6HulBUjB/r74d3/Zkf
         fvAA==
X-Forwarded-Encrypted: i=1; AFNElJ/4V5laXpUq93+qcD2LzutZgCz+KE8gpQgAdG2oFL8liL9oI+0c9Cv8g84j+CTcfPtOJzmfA0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0iLjtKaHxo9ytqxubZYZhLoEJ34OOYUNNB0EX9SFJIcKQe+p
	D/35QPvy8kN6Rm0BpdaMwKoNR5UVHLRwmIpO4cfoDeCEdEYx/SHZazpg
X-Gm-Gg: Acq92OEQnlpqJdroIb+ChQyen24XrbGYFq96RsGJncCblfvg0owzHAZvpyVkxNOsOev
	nTyEj0M1kky2vvqWRBpcn/QHSs1fZWHdGrh1qeh8J6onaWtDWnfzGlkV2HbQrDkObJ0omv54g27
	6Jfdbs+SZkILUBnl9c4VCAIW0ZiSCCmxeWhk4ut1BearKlXGxU47nvybtz3oIFU3TeOI3e8wTjd
	c+beIzP/GC+vrukPE7BVhrRRYTjvOTRGznf5lt2+ASixxWU5nGl5FZm1xPjrRNUHPoVG9o+hIJ0
	SEcopD7KQ1OwAGTnLy1XAFik0V5h1UgcgOZpQSZ12qBGfE/BVKLnz03XR9opH+Q5e/AhYOdeezz
	kj86D0QEdCtdFUGwKkvW8vT/Oj1yzJAnnWICF9IN0G+rGvXQuvcWdMqu2jcvEyzQ+gA6CFG9I9+
	sX/POajIP9hHQKOhUx4LBCVVs5qCzRUF0cs6LXPTMeThaCHtbcNGmKzXANO5umBINolWD3TCn5w
	DQewyNJiMw+VyvWDxa72imUOIo52swX63IGOADaty8tTxfRsTR5
X-Received: by 2002:a17:90b:4c02:b0:35f:b5df:453 with SMTP id 98e67ed59e1d1-36951b8aab3mr20791888a91.22.1779237792105;
        Tue, 19 May 2026 17:43:12 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:11 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 2/5] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
Date: Wed, 20 May 2026 08:42:41 +0800
Message-Id: <20260520004244.55663-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260520004244.55663-1-kerneljasonxing@gmail.com>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: 8370A58654B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

This patch is inspired by the check[1] from sashiko. It says when
overflow happens, the address of cq to be published is invalid.
Actually the severer thing is the whole process of publishing the
address of cq in this particular case is not right: it should truely
publish the address and advance the cached_prod in cq as long as it
reads descriptors from txq.

The following is the full analysis.
xsk_drop_skb() is called in three places, which all discard a partially
built multi-buffer skb:
1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
   the TX ring prevents the partial packet from completing
3) xsk_release(): socket close while xs->skb holds an incomplete packet

In all three cases, the TX descriptors for the already-processed frags
have been consumed from the TX ring (xskq_cons_release), and CQ slots
have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
the buffer addresses never appear in the completion queue, userspace
permanently loses track of these buffers.

Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
destructor, which already submits buffer addresses to the CQ via
xsk_cq_submit_addr_locked().

Note that cancelling the descriptors back to the TX ring (via
xskq_cons_cancel_n) is not a appropriate option because an oversized
packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
which is an obviously deadlock bug in the TX path.

Also move the desc->addr assignment in xsk_build_skb() above the
overflow check so that the current descriptor's address is recorded
before a potential -EOVERFLOW jump to free_err, consistent with the
zerocopy path in xsk_build_skb_zerocopy().

[1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f8c8a8c9dfba..0a6203c42576 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -793,8 +793,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
 
 static void xsk_drop_skb(struct sk_buff *skb)
 {
-	xdp_sk(skb->sk)->tx->invalid_descs += xsk_get_num_desc(skb);
-	xsk_consume_skb(skb);
+	struct xdp_sock *xs = xdp_sk(skb->sk);
+
+	xs->tx->invalid_descs += xsk_get_num_desc(skb);
+	consume_skb(skb);
+	xs->skb = NULL;
 }
 
 static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
@@ -876,7 +879,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(-ENOMEM);
 
 		/* in case of -EOVERFLOW that could happen below,
-		 * xsk_consume_skb() will release this node as whole skb
+		 * xsk_drop_skb() will release this node as whole skb
 		 * would be dropped, which implies freeing all list elements
 		 */
 		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
@@ -968,6 +971,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
+			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
+
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
 				err = -EOVERFLOW;
 				goto free_err;
@@ -985,8 +990,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
-
-			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 		}
 	}
 
-- 
2.43.7


