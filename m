Return-Path: <netdev+bounces-289666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BrULMcDDWrXsAUAu9opvQ
	(envelope-from <netdev+bounces-289666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D64758655A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39CB3300EF90
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD1221FD4;
	Wed, 20 May 2026 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxy8Ztrh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690021ABC9
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237788; cv=none; b=jzCBdQn9fA8xUeW72ibhfw8QkG3ZfEnBZdF2VwY4N6slLZ/l1aw3ypcLhbcocXcaIAPpFib2gsIWWyarBLfBJ/ulRqIMIZXEB4xmHuZHUkM6JMb8eyMEbuCvEokGsYGb6caJt+/32rcEuTCcs0l0+E85l/79BOCO8dfCtUNh+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237788; c=relaxed/simple;
	bh=b69IeRzK/gkXviBHF52sHbmYpsdUOWt7Bk6X3kz8qps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWNu6IH6IYhwqgAvSJBlfxabEFMhgqNeIcJLWxfD4nUt2zZHRd+xTtElNCv2v45TFspGvPMYe5dTuo7utF40d+X5oGr0x0umU7mfRbdOAe5eQ+tSK1wRMUaa8TKto3cdpRMTvSFJV07qnrfm1FxDijAZB4kl3Vaq+qM1tykvofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxy8Ztrh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36974220e45so1681824a91.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237787; x=1779842587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEWjwKmS1o82G8iZfnk1MYvRFND8ZVdz4Bvvebda+3Q=;
        b=jxy8ZtrhOyX338BpkvNYQe50gkXrm873hDA7cQpB48lwi9rnndG+DAlwqQPOyZJkir
         F13atJLsmFyY+oFjparmkL9ApHzz3yb1uU/p5nZ64I7r346Dj0CDr0kj8Cq2q/l3TS95
         VLIMuvaoMeZXbeHcVmzROKE4wqp9259sAgCC0iohNO1b8wS/R5A1jhwS6F/F8nYn65dQ
         7qS1EIXHCvUb/52k6Us60xwpBzO6pO9I+8GQbltQTXW9nxZY+GrhNFDrFHm6cDrsFz2o
         KzIv04r6jlzLgAoZIndt0FJQE0ppUZ2+tMpWLT3EFzJobNOxWPeyc2jiEFk8bAyJiOW+
         O/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237787; x=1779842587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pEWjwKmS1o82G8iZfnk1MYvRFND8ZVdz4Bvvebda+3Q=;
        b=Uhb4rIt8DbVPZ13VEbX1gyCScdNuGYosLirMjL0Icg/yYn9aBHFskYxPhAJFvMpF+6
         HrYrJURCWIBoBgnEa5OKQfIK3KfbTQR+y3PfbXbqDvOa8i9n1hru7tekyB4dXme/Pool
         0eU8oY6bwdeo50A/j2GuMVJdRqAKnRduAUJzCR0IKWtxXDIRHcVpWz2kKxhzg6mCNIRc
         YHMPj3knUMNjd+l1RWBGYstGbkvFcnUlsXe/f/4wDNjbPojVxqiey8rDYb1PDmw4si65
         yA4e0PQynSwiZPugKChgoRjtz6VaijxDuphOFxQeE0wGJP/ymfJv83k6ODvhHLKbbPYc
         sanA==
X-Forwarded-Encrypted: i=1; AFNElJ+8UdVmuDpXifmJc7Kw1a7460Gn8UOuzsB5xAh+RJunzVnlrFLYEIxbG4gJMyul9UMGYiV9aKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyvRNu+rMdLft4BEkl7ST+kVFe//dTIk4JAfm2hnFJ6Ak0V0d
	qtHD+QioDvmwcdGBmGWxXyRpg9GFuXVsDZUIsgFvn20YBMDhC9vkUwxh
X-Gm-Gg: Acq92OHL/M18IGbb7Dp+Nnge9mUbyMkOCzvu6320OGu8Dh6lT+kUr8G6jMzdZyyzWO5
	naBUZ6tBBSPkdiK8YC22PpVi5hZnyXehAFAaJ+OjloeSvSeL9mN4vSf1HzSuK4OmFVbcU5BT++8
	hsGVflmjCn0ncMLZGqgDMEyclvHqLg5vhmfDF4PoeR9eeyQwNhtJtZYWyRV2WISd5cnIe5CTlmZ
	Ze6stIwWY5EEkkAo6uykX2M96qNMGlcMMTdvO1q/HLguacgjdScjZXz1MkUew3+plHZ+N5Hnzvh
	uL713nWBc21EzYSGMm3wFwcd7V9wf1CoPA8R3NPFn+nXJgp0/hIvNAXlhC0FwBDJMusRd3WnOXh
	gYSKLExMwcYaKnwf8wKfT4FpBDIa4hhMFH79azdoWb6QwK9oI30Xgm+tUE1IQxydW95Uwk1fEuF
	9PUXpY23+JXMzIDtynYoWljQdyncRG2pgPJMrjlZaG0cOeA1wPh72EnI+B/1DdpddaoaKOtvwB7
	Bb/ruM8UdvNBdcMjygECAU+co3Hx+Q=
X-Received: by 2002:a17:90b:53cb:b0:36a:1de6:6c2d with SMTP id 98e67ed59e1d1-36a1de66e59mr829773a91.10.1779237786921;
        Tue, 19 May 2026 17:43:06 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:06 -0700 (PDT)
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
Subject: [PATCH net v4 1/5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Wed, 20 May 2026 08:42:40 +0800
Message-Id: <20260520004244.55663-2-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289666-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D64758655A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

The TX metadata area resides in the UMEM buffer which is memory-mapped
and concurrently writable by userspace. In xsk_skb_metadata(),
csum_start and csum_offset are read from shared memory for bounds
validation, then read again for skb assignment. A malicious userspace
application can race to overwrite these values between the two reads,
bypassing the bounds check and causing out-of-bounds memory access
during checksum computation in the transmit path.

Fix this by reading csum_start and csum_offset into local variables
once, then using the local copies for both validation and assignment.

Note that other metadata fields (flags, launch_time) and the cached
csum fields may be mutually inconsistent due to concurrent userspace
writes, but this is benign: the only security-critical invariant is
that each field's validated value is the same one used, which local
caching guarantees.

Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e5786cd9af5..f8c8a8c9dfba 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -802,6 +802,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 			    u32 hr)
 {
 	struct xsk_tx_metadata *meta = NULL;
+	u16 csum_start, csum_offset;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
@@ -811,13 +812,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		return -EINVAL;
 
 	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-		if (unlikely(meta->request.csum_start +
-			     meta->request.csum_offset +
+		csum_start = READ_ONCE(meta->request.csum_start);
+		csum_offset = READ_ONCE(meta->request.csum_offset);
+
+		if (unlikely(csum_start + csum_offset +
 			     sizeof(__sum16) > desc->len))
 			return -EINVAL;
 
-		skb->csum_start = hr + meta->request.csum_start;
-		skb->csum_offset = meta->request.csum_offset;
+		skb->csum_start = hr + csum_start;
+		skb->csum_offset = csum_offset;
 		skb->ip_summed = CHECKSUM_PARTIAL;
 
 		if (unlikely(pool->tx_sw_csum)) {
-- 
2.43.7


