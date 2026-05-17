Return-Path: <netdev+bounces-288687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKKPJENhCWpOXgQAu9opvQ
	(envelope-from <netdev+bounces-288687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4838155F83F
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16AEA30048F1
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C72DC764;
	Sun, 17 May 2026 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e20dNEUr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F52DB79C
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999616; cv=none; b=dNYoNcQgoguuaps31RxOSm4pym53sRmAK0p8rdxehvkkEIJsPFEMjStfJlk856dJ6AcZmzEmoau2zanRBEfUcfHz9BEuoagkfmNe6Ylc/oQKipzEv2w2Y0cgnON8BIIr8F/qoK2MmoCIXpV4CeMrwg22EtAa4DPcKKorbKBvwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999616; c=relaxed/simple;
	bh=a5UshyE/bkF5sH8kPnnlkA8aFTOAxuPpX+MUydmVDnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XvZaRuKGLp0+FPdMtadfvPSR+0uB7bitnIa1VX5A5tg+SgGoRJA0Mj7rFrFYS70nVBjiZfGHv7CfP+SKstSl595xawAAz7SGtWukTgRSLYVTiArYbi5ETlNp+Gp4vv+I6kNUl52utIwQ578xMGIlPjl5FGw3xLCJaybUwKtBTWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e20dNEUr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so1157965a91.3
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999614; x=1779604414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZXYU5Yo6j5J7XOLRXMLLYjxyG0GpFZ6EWg+P+KiBs8=;
        b=e20dNEUryG9RVVPi81yJc+SztJsl6UdGI6lRLcX/AHODqwRiwd2xVEoO328qyJgnVD
         SCxMct+56piEx1JQc6Yi+gFBcHJfXv5xdTYG8NzqyOtWeU8u7KUdXqamspJrMf/+SVXz
         om4rPIrMTXSL7cmkc9Yhnk44L1OJqCbiOk+pblx670rlqTlESHXY/7ylVgJ9lu9CE6TG
         SzUTedb7YQhtbPM51FqH5Iif1pk4DO9LA5b8dk60hOittPjScDT2aQf4NAHKM+V2u7uh
         eQjwf24UkL0L0N7WaaPqqR2s43i17yHnkkdVvV06KptWR5TM+ukA8igpxJGaN5YbZBB2
         8YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999614; x=1779604414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZXYU5Yo6j5J7XOLRXMLLYjxyG0GpFZ6EWg+P+KiBs8=;
        b=X8NUzAkQ61dQuFTAKP8koZh4IcvG057dX5X9Xrya30ACymfgbKJ7EFl0SJoPLpe5El
         P9+5DAkkKYVsqpMTag9TjKe2WNdx6gHwwiPcYzaQ12qSWNXyFUDJX/tXe380bk3OSAcA
         4e0rUk8t3yjpEGTE0pjGZYuFmyM4iQlc1M7pokCOj9jgU1PcN7ZKlROGvTmoc9Dv/U1K
         QM3lPZLFz8ImnSVK2ZSTCIuDpZSzuKkHgtudwAQ+FDfGab4MZTA3bnJibmOlbkskA0hs
         LVxrrVpUXjy16ZUM/+OVgdYYKRFD2Jr9ZpTRS5GxEccQKTBaonc7zqGYwQQWCKR7/zSM
         bMPw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ef4a0mqit3judiK7lXSEw7JdG6IdD/wsPBFxE3Ao8erbPEiJbEaobQzTlno0bcou1ti1OQCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhupVq7oOvYXIE+E7uu3p8HTJUprUYD1icj/6LQJTi6gnW4M23
	xtRcHkJUL/3yzZIkVKfVC6cN9VrKq+zZafJAbggu1GKx8NY6UN7podps
X-Gm-Gg: Acq92OFdIJQjO/Wa5AxW/TL0v83S7XWtYNQdquH/vxDDyc2/k7+FYrcZ+jmz0ACoFRL
	ZUvyTTlmsSn8izxM3sTOVjdhXeQa4CKpeAGCjvBUcFPuuA+qU6JSAZbkKex1hwoI74wk6tNbPXU
	FZEAdiUSTJmYDQnoJIKHP0LiePfIxnMI938b8N7f9G0Jblua7aChbaA/yXgZIGeAOlTDYmIHEWQ
	n/Xmer+/NbFHeOtfQ4cdb4dUk8s1YjJJac6pO0q9e/R3ysspCg/I0f7OxkHxvMt3OxRcRsAEjtd
	GbOJVGp2xuG2eKjochMVt+1RRMjMCMpIJO1GoJWWQNJdIrg+CkLZ5c9+RkMPiFaIfHo19sQEpfk
	ry+jAXpx4cFwZmMHfbJe1bnUUK/8g9+d9k3txWHZD81GbZwTmxwWuuR2X8WlsZTwnGivHzieM/N
	2Ui0Cw3vxa66qLFK8ETDByk0sqnmSmTYjbkSuAfuXRXUfHCS4Vkl0pAPGof0GFMB8ifPxGiTwVp
	27kNpLks0cqWzG9t1XdJ8zWeWB4i8c=
X-Received: by 2002:a17:902:d311:b0:2b0:a980:3687 with SMTP id d9443c01a7336-2bd7e7e4ddemr76343665ad.3.1778999614333;
        Sat, 16 May 2026 23:33:34 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:33 -0700 (PDT)
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
Subject: [PATCH net v3 2/5] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
Date: Sun, 17 May 2026 14:33:08 +0800
Message-Id: <20260517063311.28921-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260517063311.28921-1-kerneljasonxing@gmail.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4838155F83F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288687-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

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


