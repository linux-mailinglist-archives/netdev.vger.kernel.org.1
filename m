Return-Path: <netdev+bounces-283480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDZaGwJa9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:09:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCD4B3677
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3375302E84D
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70AC38BF78;
	Sat,  2 May 2026 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTee5mb2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1538F643
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752471; cv=none; b=WunEZ+51BMzQFUueQ7FEbNXTOomy6WX33rV6++EFMLygUZA5i7DPvtSm9rrh3YNdqzYmHH6B4Bjv2i4plt9cUXvD7+LTVXETl9CaGhwWlPAvImq0mv7Vdw/Be5LuZvxC8kRbEpJucLt0Ujso1R2jtCLbkvk8yIZ14Gm13mLIUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752471; c=relaxed/simple;
	bh=qJ7NePAuIUwSLIZNZpWGMB5Cq1VU+wbzlMIu4vvi22w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2mzLalLrtbTxqw93U6d+szA90/dfrFvJQy2+Zwbl1LfcJ8WCTIT1wrRuGV7r/2KODEcV0i0nVB5F4UvYc6B1Irvc4AC489Ln6O1tn7ZaRTRU2IEBeToGU/AX9q//Ql5fJ9UxIkq3niopHZIDyK2nirsk0EhKZ//uCd6Lrl95Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTee5mb2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67bb5ad91bfso2898379a12.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752468; x=1778357268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=UTee5mb2eycMtO71qZNKfJLQTDpKsJjZkmWIP9pOYrFCuHpeGBS9qOYIkoG94l5eyj
         s1qAX2jxBzgubm97u9IexsE2sfBfDJc0A5R6LHDVyla0X2eAAHLPW3LiRBVNuf9vGkS1
         4I8ji34TSzllE6StlNb4Eq5PpA+hmLN5twlfs3KW3OBacEc/8wVKoZDEYkxagf8x9qH9
         I/g8PTfKkewJx9uvroTppO+7+LIz2jsgl2NgL1TZPHHert7P9L1kLPHkPyz8/56xpoHC
         FPPnxPItt4Q1onFdkjR5jPOkQd+SWwvJii46XDS8L/HvmfihqfW63riz53okX0k+Pawv
         YAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752468; x=1778357268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ioBSLv9hdXd5czi0wkoeJKm7t22FgolQo5/iE0ARes=;
        b=NyWRReCHLpFB/VWaNMPbdDoq7VF3fa3zeMdEyIUHgjQY3csUiEqygk4zyDbHy+ruxK
         HGurblVmUeGERBLOYFs1OOJ95FTCQ8R0k/u0YON+XtsM8WhFyHYpp1K5cnDssIHv2Had
         L3aAf4HGmKLyGb7jIa9kE7g78i89WsAh0ULYxLBqYBDGbqTNMAuhCXSNq/4OVopx8iyT
         OdsgHmnXP/yEKXIcE2lEfA7sWmvCw6+TNWTD9U1rMQQfQX1Vh+3haz5ihYolWa72Kfkr
         Cfs4yL3KnT6JPgIo2AsUwfM+zShckI73ATKInOA3HHXBLJku5f8L11iYQKT7dLRp2cKo
         2rsg==
X-Forwarded-Encrypted: i=1; AFNElJ+hQVdM+sUwH+uRHjjFHa6v7R7DWF2Lk3hxzfI3ZJottqiSws93SV1pJosk2Z6k3kHo9vGin4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTjTixVNWi4v2RB4Ipg0WuKkGJlYZeOt1zKiDO6DrAtCf+NXCC
	xA31VJ/KUXotCB7pUaKX+gdYOAxtYeFqb/v/EqBRn+/8adOCnis4TEjL
X-Gm-Gg: AeBDievmSrHrdoefA7mX4Ag3P/DK7nKxbvpXxITZD117VBJ3x6jriEMCT3colXCOj8D
	1bBeph/5hCRTer++GyEMdtwXMOADVCS6bkONH2Um6B9X/sAehtqAXWKluHJWm/qYEZODK2UiLQn
	E3OwC1+N5WJX9qhTV7M6LlTw3a+cU6U96NOcdLj+qa7ABL90vtKimQ2vTS87+t8Dvjt0C5RRqsh
	PxEKnoBw/GD3HU3vFWEoPpLV1JrGA/R0R4f9mtxndnVQN0YA2S758Cj3O55Kj/xnI3UTBAhjpbZ
	2rs8YktMxKeDkIlL7c7WxsO8B4fpVcmU3w+sBELg4aG0PEtf1WQdN/y4KdvNylsaM4Ks16xLkXL
	U0S7Ztu/d4/6ggtD/Y6WTA33GNnzj5xjMOx2DEEbl3cGz/OKXfeOi9nomiqoJk0sd32Q2t3Un8P
	/zSl8oUVV6C6/OnrAIHKRrDfPoSwqgQZ/MPA+rfdsl4u+8lkHWkld0uvDuOMwUrLjx0ZC0+Eitx
	fIKKq0mPVZuWW6ihvb1m4kHW8Oo
X-Received: by 2002:a05:6402:5043:b0:66e:6ac4:2c01 with SMTP id 4fb4d7f45d1cf-67c18120146mr1397015a12.2.1777752468302;
        Sat, 02 May 2026 13:07:48 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:47 -0700 (PDT)
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
Subject: [PATCH net v5 7/8] xsk: fix xsk_addrs slab leak on multi-buffer error path
Date: Sat,  2 May 2026 23:07:21 +0300
Message-Id: <20260502200722.53960-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DDDCD4B3677
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-283480-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]

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


