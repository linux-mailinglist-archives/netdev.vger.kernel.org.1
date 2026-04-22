Return-Path: <netdev+bounces-280304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCrLCx9D6GmZHwIAu9opvQ
	(envelope-from <netdev+bounces-280304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:40:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D9441D81
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A7203030C95
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313D3A4F23;
	Wed, 22 Apr 2026 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXzL8be8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23133A3E9A
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829052; cv=none; b=oFA0RzhTZn6h/bR/wSmm5trSbqsR/OwCoVQHvIqEXq1Hiv7zLVPPMrwWFa16nty1lEvTdlSTkS63r5yk29MGLBpMaWVRzEd/FJJuwK9WmYtQa1N2fiiMk/uPFRp7rx8jInInEkrIPQlfJXUATGz5iW32s6usL0KDn9kvy74BJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829052; c=relaxed/simple;
	bh=qJ7NePAuIUwSLIZNZpWGMB5Cq1VU+wbzlMIu4vvi22w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKvaNbd0c5M4PFDwgj1tJICuIc10GhtIY9E2pRFOvvAslgocb49SMUhGeqzqVjwTK8HHttV8wJ1rNDqOJE57b10Sm4flZhb5CFbEZEVG/+1nPVi7H1j0hfbdExdJlqxHaH2vvC/zESYDRbzXOofgOXlqq8ulWgb1HWqjZmGdBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXzL8be8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso3526030b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829050; x=1777433850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=oXzL8be8wJdt3qqBlDe/E0XfJ5xOAa8HE8pfaWA30gbEwEZUqa/UbrW5Ii5vAmmpm3
         jKATStlBJfEUC1FcggYNUD04/OLCcwZxDhV4k48ZOgMs8jFKeUUYoQuIyU8zc72MsqPM
         7FuswiiDxHsdoePshJAXavRNUzppnoFtxLJrM6LkEDtBV4xqI0TTGWktdUPc1jSXbvIH
         3zvSCePyCABbw2JT4CDqdRybwsSPu2SB/FfRafam0IgZws6XgAT+ep7PgNGXojQ9BMn/
         uw5oQe6PorGxtZz32xjQ9Uzbe6z7imE5WrPdCJV8zb+/oT7qRstVGEJUVSJwJpcJJ+zY
         QZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829050; x=1777433850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=g7A0Z7TGUl7pFGkT0nzOf09OQKjbrOdUFar8jruEQIp+h3c/KKiPqOHaHLIGJBlhnh
         6+/W1rIkAJh3/vX4Y/if87Pu67nGT7P7Ugx+rnWjTzxxGAQAyUsfOCEiHzgjSpYGZ1HQ
         JJv4JHdd4LKZckYvF3OZBp5SpfOwomCtJxxQge76pVxfIIDvBLkojq1rEzvJL4rkmCLe
         2qQ7W9EXRuztiLV5OnllPv8KOZzHtiznjks5ImLZLlmsPy81tJiFbXm3jHcuUWrLyjHt
         GrseJpyOLAh55Ue0ZZWgTKS0LHs4DvDt1WW1wEaqcXxgSqp/SFyv93XCoAGoNHlLWSXj
         WpUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uFRq7gqZmQzixWSsmYoxVuwsMN0/wybzc68Sy3kD86ZMqDV6HurdQ9NvpkgIt5iJmFeKo0Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxojEoipAlFj3aRwW0AHvk+q/R5zIxZyEUWWfnKCrGLs4PZk6Ia
	tnG1tiQW+HAdzzZxESc2ZI3oQ2QdH0WPrOX5mn25EV6DcLSL+fCznRs4
X-Gm-Gg: AeBDieucEXa74s56srTOw88dH2piISNYLbXC1FtzJxmywWfQPHBRtsGNbsvVKHGfRBS
	b6jbOXNCEHLQkRVtJ1KbEJc3H8nQWBtwVQGUiXsOk8QydqQHptdhSBorVGimAdnnFFUjUiAy4yC
	mCT0oVqu6/oOctDpIyN5UWJEoxNOf1wpyXlgeJ7+isSOuAWelRzBW2Vb6akCRllouKd4K2AM6WA
	peJ4pOfz5ziiQIEAXGF4OJQ3XCyvrjSrNSz+f8Ujewp78fQ64m98da9dnyKBU34TsZ0IsR19djl
	RWYyPFhrt8nxUzrUgb/VOVZiTZifeiyxZqjOiTHlg7WguVVQqWRNQI66ojS8EKRVdcesnRBBMN+
	7jChd/tHIqiXixRBNdyYPWe6+bxxQ/viH2rElnhEhsGkiXrs8+E0UtGebaikl5ya/bcfZZskHmQ
	6qwG5O8b2dVJK/+4nGBMOL7N7s0RrnP+otBSaFHooJQIgJcm4bcAcKrNixQ43lv6NPAFUaN4u86
	uEj3kxd
X-Received: by 2002:a05:6a00:2e15:b0:82f:f4d:23c1 with SMTP id d2e1a72fcca58-82f8c943269mr20693707b3a.44.1776829050199;
        Tue, 21 Apr 2026 20:37:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:29 -0700 (PDT)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 7/8] xsk: fix xsk_addrs slab leak on multi-buffer error path
Date: Wed, 22 Apr 2026 11:36:49 +0800
Message-Id: <20260422033650.68457-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260422033650.68457-1-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280304-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9B0D9441D81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() / xsk_build_skb_zerocopy() sees the first
continuation descriptor, it promotes destructor_arg from an inlined
address to a freshly allocated xsk_addrs (num_descs = 1). The counter
is bumped to >= 2 only at the very end of a successful build (by calling
xsk_inc_num_desc()).

If the build fails in between (e.g. alloc_page() returns NULL with
-EAGAIN, or the MAX_SKB_FRAGS overflow hits), we jump to free_err, skip
calling xsk_inc_num_desc() to increment num_descs and leave the half-built
skb attached to xs->skb for the app to retry. The skb now has
1) destructor_arg = a real xsk_addrs pointer,
2) num_descs = 1

If the app never retries and just close()s the socket, xsk_release()
calls xsk_drop_skb() -> xsk_consume_skb(), which decides whether to
free xsk_addrs by testing num_descs > 1:

    if (unlikely(num_descs > 1))
        kmem_cache_free(xsk_tx_generic_cache, destructor_arg);

Because num_descs is exactly 1 the branch is skipped and the
xsk_addrs object is leaked to the xsk_tx_generic_cache slab.

Fix it by directly testing if destructor_arg is still addr. Or else it
is modified and used to store the newly allocated memory from
xsk_tx_generic_cache regardless of increment of num_desc, which we
need to handle.

Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e6326e076ab..ed96f6ec8ff2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -605,7 +605,7 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	spin_lock_irqsave(&pool->cq_prod_lock, flags);
 	idx = xskq_get_prod(pool->cq);
 
-	if (unlikely(num_descs > 1)) {
+	if (unlikely(!xsk_skb_destructor_is_addr(skb))) {
 		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
 
 		for (i = 0; i < num_descs; i++) {
@@ -660,7 +660,7 @@ static void xsk_consume_skb(struct sk_buff *skb)
 	u32 num_descs = xsk_get_num_desc(skb);
 	struct xsk_addrs *xsk_addr;
 
-	if (unlikely(num_descs > 1)) {
+	if (unlikely(!xsk_skb_destructor_is_addr(skb))) {
 		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
 		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
 	}
-- 
2.41.3


