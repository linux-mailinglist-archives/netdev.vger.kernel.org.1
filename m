Return-Path: <netdev+bounces-280945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJcsNo0C62lsHQAAu9opvQ
	(envelope-from <netdev+bounces-280945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:41:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2FF459FCF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB5693019917
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70454344DB4;
	Fri, 24 Apr 2026 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewDtDVMH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E817335546
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009141; cv=none; b=Pwy+YLncJlQd0aAqonRSmg6fYtpXEOCZ1nEpeOWJHq79pq2kb3veaj1dduj1qoenIfqDUXAL7oJ+NPyPfF46hiCBJzXKH0NNBUXjIxPyy5dhTqUzPnm+wiFPEJhzbqizL7rVP5nJcxjVrlnzILUaQxLkjh1/rvzo92XGQiqrei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009141; c=relaxed/simple;
	bh=qJ7NePAuIUwSLIZNZpWGMB5Cq1VU+wbzlMIu4vvi22w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDF6xQ2JYus9kfWx2awiypsOtHaBRpkCdA6rvXddzw4fpMIjoRbJIctDIcDsoN3eQ54ttSteVP21bh3AtkVID510zWnRQGng9H1qqtllRorux39JyrCbUOgK9hWiFYcVzUTAsQ8ZXYAV5En43GLUCKYw3l0cN2JlISto5y5A9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewDtDVMH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aae146b604so50138235ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009139; x=1777613939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=ewDtDVMH2ZSm9q5JBNBIa6Ve5p6AbrGIFPofU38mdIqoOwOWfCakg02LyG+QvSi22u
         XxrvB49tZvja5kq22yFTJNdAAqa4AeycKgp7CyqRN9u8a1LZleiv4imfEoHoOGlWh57P
         B6ldvFI3BpmjB19R2iFNVmWrjX5pDjABD/zgvdGFq2XkL97EnwMEdbXmz+yDvGnd8CVw
         lN2XZ5EuJ8hqHEWbUlEqS31y+q0/12kRK4s2xpE1w545gU1QriwK56e22fPv5/q/yCGA
         xvUeaCqPx1CJvgIXarkTLmKro5BckpMdB3IO6r36WknpRaRrhnuzl/Z/wnkx1dFVObJh
         EB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009139; x=1777613939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=lnllw8iVK49G9rL16Ok+d9C7h71LsBh+Zrc1phIzc/w0depPGIwAmqIhcB9y0Mqsac
         LgHXPsNuIR5EsgWjrXHw7YAmg2HWTBNBWNiTBHF7GBZi1AEqO2rN7SP/QlnOQO/voGD2
         IlHdyaG0H/6OZh5d4oAzdrov3fkrcOWwMdldm9Uhn8vIkvjGTjzJevaSgBqL6sCV6nJL
         ciuQJmQkfSYiN1tCtxCbkEYuXftho/QkTWAp+sJkfceGUr91VJ+IWgYvZEJhMur3sPJM
         6szYdcDbQxgtvzKDhZDD6E5E5jKD3mPpZB1dn8SCP1vXEthdum6OR9DTrSuP83tNJP+Q
         Sw7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+NxMSiCoL0YZVcqMWQRbFejSiX6fNoakniNR2mjwGSfj9agTG195pG3QdScauZhWjgeWYT6cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOJaYabcfTBS4J8DdFPY4iSQn9ksVkBelMm3/+U3aZ+Az2wnK
	DhtGUHdU8J6MMChiUJRIGBQ4rhhVt/cMRKQSEzeejiLCZgVVK1+g78Yi
X-Gm-Gg: AeBDiesSCxlvj5UQSCS6meiboWvb+0DXUWOPjasp/DH2shz9yrT+hwtbO7rdGTaYZnS
	AWgaYQGELyJ5K4YctLjle0tkntS/Ecz4ty1nfvvgWUyw4XDHBlEznsUKeJjvl3HQA9+33QzzaE9
	xt7Ldxiy/X2JXTkA9LiUQoVYDXHOH0ap5ekmWmGYf7RfRXE1GwURlL6cbP3EN5pokyl87SvBHEB
	B6Zbp1DEiR4EUpwTZPAPweXJAh1B4uwaCSPaymZGMwFZuK7bGGkA3nwlwSd96NGwGxTinnJT5TN
	kvzRpR6fuoweRkZvemGhLewH163yfQFTfytkRllAwOGwGG+HyOeno3DFT5x9O6BQXgLwszNWTNU
	hQYzaZ73fLUNZSyomehAdqJ5WEHdOmPzL/KW+wyye/cX7uYwGgabz+CUU9jfoerZzwjvtHl97pG
	qKbw/z3VBeRW8Jn9s3U9gVnnz6ianeiDN/XrCUFZBfP3j8P+uIVrHkwiMw1NpuV1imptnV3V8SJ
	tJFoqIvcANt6dYxScwRLxRTy0BjEh/XdvV+/t1b
X-Received: by 2002:a17:903:32c8:b0:2b2:42da:25cb with SMTP id d9443c01a7336-2b5f9f4df97mr315912315ad.19.1777009139479;
        Thu, 23 Apr 2026 22:38:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:58 -0700 (PDT)
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
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 7/8] xsk: fix xsk_addrs slab leak on multi-buffer error path
Date: Fri, 24 Apr 2026 13:38:15 +0800
Message-Id: <20260424053816.27965-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F2FF459FCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-280945-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email]

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


