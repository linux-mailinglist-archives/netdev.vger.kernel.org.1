Return-Path: <netdev+bounces-283475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKxYCKRZ9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:08:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9566D4B3606
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D8703012CE0
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63A7332EAE;
	Sat,  2 May 2026 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY+KIA6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941A385519
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752460; cv=none; b=TWkd4ctRSnAodNkaZwI659/0GvZJocTy6KPMVgTgOaB9vkiZGMKD7tbr5npr4i3aVpsyg3PdRUhOnZiRN6xau5hs8VrN6SHNeBf1Wul5P8lBMSo1C05Z2mOobMXAkaRGOTlXH1VPj6zW+JjqphWKLGrccvOfEeY2l1ZcXWZqhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752460; c=relaxed/simple;
	bh=61yGRpOGhsMPizgyfnAILecmujq5o2oGJ99FPk6KnZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S89VgLDyU2sXA7iXRqx02fJkk4VHLhNHpd/tx5whpHLSxOujNcZIwx7ClH8burg1feshD81LinuqhMZoycyMzv4JyHn3F3d4gAQTL5qBSTZnt99n0leE77ODezukSSz0cBgh8IUJBDoyIUNCkNFh1c+qpXYJEtqzV6vIf+XE52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY+KIA6/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so4782602a12.2
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752457; x=1778357257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADxWoAHbEQydtNYkP2gI04XyqSskeEphy2PbnGArJe8=;
        b=fY+KIA6/QXWq2+AuPPNvzF3Y799LuP+nJDTmx4KT1uBSxkTNx94k0ynds990u4eqOR
         9DeMOxbTy/KVtWsILASJoN9DR29njhoCp2Nd46vxYdwQSWgmyv3G3JMYRC5fH/JlvW9m
         NJCWaftDT7hSggD4+5nsODnYWwf49dWLd7eMalfLDssXbhz3d9pqgTv59KGtb644WkUt
         nSNrn0QXeds+f29gx7KW0kbNOHPQMH4CjEVIN7HqH9Ilr08U6XE5n3BLL6abpZOjytSC
         jHb3StgzlMyOY2/eC8aCXNgeEEN1JZfAXhexIu0LU+evE8d8U9bCx4qY1/sDvRSDVb0D
         DLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752457; x=1778357257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ADxWoAHbEQydtNYkP2gI04XyqSskeEphy2PbnGArJe8=;
        b=aaWpaqbf14SNhUQmNw5X2a0iEj3r2UmriUlqqbZ/ZVDM7w1g7+GVYR0zbdwKNZeTi+
         EglwltTJ6CXvA2ma1BKbjmpZcYYlMO0LwjxPC1PA8LoYOFgJRaQ8qkQlwjMsJSxT5ug9
         +LBoDLVbBSYaf18XklAuvca8NOeimNosOePC1hTe0YmqiUEhP2B0/uGtUS6/lHXK6nQz
         Nvpb2N1F4UlUd1eiVWO6ZVqEu2hzfihsU+hTHwf4Am153Jh6Mon2V2Lc/ccp31ymgCSG
         qWActrXSdWXH+5xnxJknXJi4f2qJewpQcE81j7hV9X1zv4M5TNo/JKbbZu4GzBmu8WuU
         03dQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nByJ3GhJ6wAXT32V9skfxh5tJNIlLuvPEa3oIdntHiRUVD6NNZ0rySlCfYKQeXcgejo7wXc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1XRzF8PoYO4ynQmxa56qlRHor8CHGmk+G+0/InL+bWhP51sa
	DsN4RUr/TPcQ/t3H+/aFFZaL+YkEiCaas+CnvOngRx4QDYHOGgpn36zI
X-Gm-Gg: AeBDietcBgMPpyjn/k68MfB0jXZJHoI0z2Vc6Q2Tgd1dBb1KQk4BvcMyYKi43KyJyoT
	Ww1pe27M43AOcTg/hzAfmPJfbULxR2vME3uC90glk/OMvt/mYQ0p8AqE4mgETmC3xz/WZjoBn8B
	vURzq6p69TaVeqtRJJd6+C/xSHt7MIRwq2D2Dw+3yOMDLbiDRYLR61H6Tqd+2jdVAFFp/ZVk5an
	ui35/xS9HfIQvXtsKcgzS2x+23BbMLkjRKtD3WVj+hCUE7xz65UwfOKGIrFjdLTb0HKzyozsvFY
	c3oXeLNSZI2fSOrrbsx2L1VSQzXM5sUdNP87G9aeuBoinIEYVco6tm3qau/UPjBXKx6WlfNaMjQ
	jxbYHKxRtGGCJTDuvj4O8KAlDYNnh2xScMBW7pp2EmBFPNyarXHVV+ZQGwbrT8P/obQIzNG9Bh4
	W15dnJXTV35ewNPpinsOvRbHnkDv88QcTnumNj6W4hkANtqfkVhNzhIWfbLFCHcr4WOrCKXIRfI
	Olo4f+rBy0J2T46Gic+o8BlxZvE
X-Received: by 2002:aa7:df0a:0:b0:66e:bb0d:23e1 with SMTP id 4fb4d7f45d1cf-67c1ada378emr1085057a12.13.1777752457235;
        Sat, 02 May 2026 13:07:37 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:36 -0700 (PDT)
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
Subject: [PATCH net v5 3/8] xsk: handle NULL dereference of the skb without frags issue
Date: Sat,  2 May 2026 23:07:17 +0300
Message-Id: <20260502200722.53960-4-kerneljasonxing@gmail.com>
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
X-Rspamd-Queue-Id: 9566D4B3606
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
	TAGGED_FROM(0.00)[bounces-283475-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]

From: Jason Xing <kernelxing@tencent.com>

When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
xsk_build_skb_zerocopy() (e.g., MAX_SKB_FRAGS exceeded), the
free_err -EOVERFLOW handler unconditionally dereferences xs->skb
via xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing
a NULL pointer dereference.

Fix this by guarding the existing xsk_inc_num_desc()/xsk_drop_skb()
calls with an xs->skb check (for the continuation case), and add
an else branch for the first-descriptor case that manually cancels
the one reserved CQ slot and increments invalid_descs by one to
account for the single invalid descriptor.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 46660943c81e..ff1eade29aa6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -896,9 +896,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
-		xsk_drop_skb(xs->skb);
+		if (xs->skb) {
+			/* Drop the packet */
+			xsk_inc_num_desc(xs->skb);
+			xsk_drop_skb(xs->skb);
+		} else {
+			xsk_cq_cancel_locked(xs->pool, 1);
+			xs->tx->invalid_descs++;
+		}
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-- 
2.41.3


