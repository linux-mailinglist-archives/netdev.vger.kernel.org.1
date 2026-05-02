Return-Path: <netdev+bounces-283474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBuMJZRZ9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:07:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3284B35F8
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53887300A7C1
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47B38AC96;
	Sat,  2 May 2026 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnFsnUXv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E338B14F
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752457; cv=none; b=cC58HM+UtpKgVcOIN8wAbpBaARAz/pOA5sG9kM5oVVabyIv2qzhDevVCjdjGDhK7wGjpBsmBOS8CDPwFoO5limEyMl7X9torPH7pNgDYhRunaSvVPd9W5lkj5LBKk8PTHewzeLRBsbzU0TQJdzc3O8218WsZnkFJeQBSSK3Dphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752457; c=relaxed/simple;
	bh=+YpubXTqYL6p/LBM2xcyraCoGtvRPZckW9SCjuULUpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMbT2Vpw8ZuPPNtXD8RlGp7TkkAEGRUORzKiFBIMT+N+FFR8l5RvcgHO+MqHnrE5ctAer9/bJBfrZjKWWfWVcraPETqsUUvdsheeF82v54oIEq35L8PEpZK1+g5lg8vTgbmkNnJChnJJndukxhHy81PY4gSvlwjBw3uqOyTjtIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnFsnUXv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso4751065a12.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752454; x=1778357254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHOVkZbEluwxEdvBl/xFayOrth4UzlsG2h26MqrcyuA=;
        b=XnFsnUXv5oFgvT2Pr7iJgAyMsZ4F25tQeApAMim2+fAWGjupFY8/JIQmgb4GT9d2Z9
         h9eCVw0wBPR2UC8fGT7TFcEgSHarOnxwjkxDkhLRHCjdW9wkfCsHul1oyHx+v0ZIbux6
         7lLSJnjhVhuxYGUiVWnMvysfVTz736kCK/w82Y1Bxhjp56DCCfTgk9EiBbRawqu7pGb8
         wy+TiOd13qaIlxSGFX0WVI4nNUiFILctgYNhCmt+IdDUkvvBdgierUDmYxoAICiDZfAA
         1fUrlL3WXMn0NiYPOml4Z0BdAa5urzgb8dJRHoJI9nthU9yz8+/THOJzo7K4PUlDx2iT
         pmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752454; x=1778357254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHOVkZbEluwxEdvBl/xFayOrth4UzlsG2h26MqrcyuA=;
        b=a46rf9oC2AfZRL90uoKUvAT0Jz2OvYYAfVMXlCbd8Ba8+NIrSKrIy52GKQr36tbf2A
         QBwpbGr6IUyRhxVX8F4IfDkDuzZ1CX1excAlPw0sOLRj/kyy5b2943m99WVRjj+J5SB+
         xtVNdKM2vtYIkKMRfouZCf37UBfpqWAZK94RcN8PT2X5W1D9Qb0WMQsRpR4bUC1MNLqz
         16DNKPBObsq69h4Ct8sFBQZzagKPFEy5UJ3HJReQMRLZ0hlPmUjqASB6aNIHlXAs1Fqz
         1oAYFV3T4u+h+K2qdl4AXUpqyxeg+SphCg7ZjvEV1VmoH4/2niBLg5ymrhUNhZjT7j9s
         221g==
X-Forwarded-Encrypted: i=1; AFNElJ81ZF8mJosTn6ZUDBTzcIfWsYuchdiJZyYuEPp4zC2hju9MqgFDQBjZyFrZnwGyCpmDJ49Zvgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPr6Id91JBnJBf2ofJp+5iYlson/1mUGxtT4tZw+1BZ9SUXmSo
	vziHckBbpfQO6Mo7DWnoHNX015s058v1ulNuKEL/0+PLQyhtnJCBx1KZ
X-Gm-Gg: AeBDiet8sBPbTQhdTPQLli96MaZsyRYsg6EcFxb8fzPx1ZjMijFpf7N9d00GvY9lbIG
	2xUKEP4ddd0+i454wE/bux5vZqZILkVYW30B6h1mLYyJ/zxhxT4/6nkTiiAT9/eVTQQn5b6telF
	uRD5ckDmbknxXyj7Jz8e7Y14S+FP1gG/NBwPmx4tX36dyd5+mXgJghkJQxIZMEcW8CGd0yyXYZO
	mxiz1DbawfbbjUKnOXPulrl00L1wC+kJeJD6EWQH7bNmi6v2zWGh2yNz/3spjvpPQhkbt7iHZ9C
	d12P2dULzhgmHL5NbEHzjHz3aclJ9kFBSqy5pu6B23Gf/KDHYDAx9nyV3nxB8CkKmlwIv2WGyLi
	Bjrr4QeycX1oKvjhOAzIFmL+nkUQL2Y5bQGC6wnq4ACIz/9H9Jnfcb/9/L8X5mxSMmfQThjEOKx
	Zzxrsr7jZ+yEnQ9Kgg5oVmn0DqtRyCnrJEhMjCHfRu3HLAcMu2kg5fuJkp1L/uCbth7cUbODGOH
	zC8TZYLd1Kb6c6F978CE42eHDwM
X-Received: by 2002:a05:6402:a0d4:b0:670:6b0f:f77f with SMTP id 4fb4d7f45d1cf-67c1ababf30mr1346182a12.17.1777752454243;
        Sat, 02 May 2026 13:07:34 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:33 -0700 (PDT)
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
Subject: [PATCH net v5 2/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Sat,  2 May 2026 23:07:16 +0300
Message-Id: <20260502200722.53960-3-kerneljasonxing@gmail.com>
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
X-Rspamd-Queue-Id: 1A3284B35F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283474-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means xs->skb is NULL) and
   hit the limit MAX_SKB_FRAGS.
2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
   is why bug can be triggered.
4. there is no chance to free this skb anymore.

Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
call xsk_drop_skb(xs->skb) to do the right thing.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..46660943c81e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -776,8 +776,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			if (!xs->skb)
+				kfree_skb(skb);
 			return ERR_PTR(-EOVERFLOW);
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
-- 
2.41.3


