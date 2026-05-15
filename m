Return-Path: <netdev+bounces-288304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEQFBAETB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:35:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A41D354FA84
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A0BD303EAD8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7493CD8B5;
	Fri, 15 May 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmZ5oAa0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB138A72B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848254; cv=none; b=f3LHWlt93EQf3I0b5TeqdQJxzIDLzPViOBYtMUt9EopqpkqfqidfCwq4ZrDF7EsD8JLVb/Q55lEy2JggCHK2t//orAbbPnIYppMUIHebAIlbXol4sJRkaT4K51CsJchjBmUzg92Y0CO0UIAPVJnOimO95CoYhJlwxpd8fTBwIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848254; c=relaxed/simple;
	bh=IQhPw3IiVr6zqqu4CRDJ4j0to08qx8xv/NfQTLHz18Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjiQxp7uL/J/4ufVgnBMF61/vQIQy3JptnNmps0eV6OTUC01xhd37QU3oD3nP0BNtOWYP4HAFFqp4nxipIAB4slzmIiBkgDqoU0qTmdXOms48IP4bpUL5g6bGtfwHMJAVPV8X8LwIEuuqmcKreSDs8K6BducjGzS7nXw4etg2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmZ5oAa0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so7014144a91.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848252; x=1779453052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjcyuuQLuaEXuRzmmB8Nl+fj/3MjgdhxLsDyrZCPoIc=;
        b=VmZ5oAa062zttJ9lqGRpazmhleIs+UUxv+Ahb18sePzrK7ie9MsVsMqx2/yYY64FK5
         u5t9BOAhUEvL0RHdZEn4shuex1MU7j7qN0/v3R7Hx6rjyApHPUBLCIdMK/SD7KGf4PUD
         3mtyBWsXDvRAX/Ufz+2q4zErzQxY5BtSrIffcXSXPfxLTSHbVKY2RYAvOxA/ifecwzde
         O1W9jEiXFpe5uwxgDUTrOiBRUNmO7D6oEHvcvTs0xMyBPnTNLyxpIOliPxF9nl3R2Lgq
         DHudh7g3pkCrEDR7DV06IJRiGkZ5EWB7iNT0kSCWtEq176hKeNmEbM6efP8ktA8Wx5Js
         3QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848252; x=1779453052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjcyuuQLuaEXuRzmmB8Nl+fj/3MjgdhxLsDyrZCPoIc=;
        b=GRT+VwHkzSCd98XoEtCbdIuJXyQd2iloak7uqbmOq/7aBqFAcqU2rA+D/PccZIQuny
         q168xbQpGcpDnrnhoTdiKnPom0Y1C60z9h2F6rivDSUu0W8GuvtDberT14ATl+kuK47M
         NZ6xWfGz8KTEB1UG6cW5FWV1jTswhNpVM5VOdf101mcXFFJjnYaUwLW85YtHoqJbFU30
         KOcXSA/AuxttZYHwehAm9qp+UGyTHNzBhdAtE0XuTKfkYAeqqqeCcKlO9XQ237UUHU+K
         Udl3lDuNiFD/QTV1r8FRQmnWBolwbudaRdsXWDB/FXPvre2P/ixw8LHEcu8P55Y0z+tR
         AKQw==
X-Forwarded-Encrypted: i=1; AFNElJ9yiZF9sh7agwysBpqWwOEP0+3ou72AoCYC3yMkaHSi3cJhYD90Py6Odne1AEcXyxg55qE6uH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwtmoZQgd8SaPm3PQTAg3P1hcVfJZR+jQ88VftZdZU1tk0Rr3Y
	NCet9lNGzhIpDYsSwWXwVpglksZXLEEoMj7mhShCJx0LIpJAZwqsVXvH
X-Gm-Gg: Acq92OG1ST7XV4hsae1MRotOFzl6wjyq0x/U1qg1GUC5xZTRDZmdvz6x8gFIXcjj4DC
	xHHlGNbvlJiojE5bMeFHgbkjHlxUYXr4mlSwcXpF6HaNTKYYSE1at0jmQ/ZhVoxxgRyUQxsbDUf
	Y+uZYoCaWrYmp3yJfgxRHhkTsiLdRCdyaHHukxYR9g67X0qsW7i4Rim6Wb8Ap71waXdKQCSr4V3
	F8Mn81KSdIzi+OSYLcxE6//gw0G0a3e3tZ/lpXa7CkNepzw8R29klo0v48qGEQVdBbO7CzxscH2
	ZHZjX9c0Fox0UGRA7zevObvUQAMVj1S4T6SDUtJrZfxrknH7QI7GAm1jM9ApgcVtbUB0F+kEOS7
	rWjvDT63t17qf/cSDqv3ppPQzFb8koj/+k9JBAnAG5+gd+5IGqbsmJDKqYs61DQ7oiqjnhkzvmR
	u85+kIOWV5XNc0BQ2wRRPLbXTVcEqPqT1Z2/qA9DbGBLt7WYucf3EMrIbM4S/iS7IvUFrTzzVgA
	tW7NDkHLC7CgObB0ejdrq3e0Kflg50=
X-Received: by 2002:a17:902:a515:b0:2bc:7eee:200a with SMTP id d9443c01a7336-2bd7e8c31admr30757915ad.22.1778848251961;
        Fri, 15 May 2026 05:30:51 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:30:51 -0700 (PDT)
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
Subject: [PATCH net v2 3/5] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Fri, 15 May 2026 20:30:16 +0800
Message-Id: <20260515123018.80147-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260515123018.80147-1-kerneljasonxing@gmail.com>
References: <20260515123018.80147-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A41D354FA84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288304-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
only the current descriptor is released from the TX ring. The remaining
continuation descriptors of the same packet stay in the ring. Since
xs->skb is set to NULL after the drop, the TX loop picks up these
leftover frags and misinterprets each one as the beginning of a new
packet, corrupting the packet stream.

Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
The main TX loop in __xsk_generic_xmit() then handles continuation
descriptors one at a time: each gets a normal CQ reservation (with
backpressure), its address is submitted to the completion queue, and
the descriptor is released from the TX ring. When the last fragment
(without XDP_PKT_CONTD) is processed, the flag is cleared and the
function returns -EOVERFLOW so the next call starts with a fresh
budget for normal packets.

This reuses the existing CQ backpressure and budget mechanisms, so if
the CQ is full the function returns -EAGAIN and userspace drains the
CQ before retrying. Zero buffer leakage, zero packet stream corruption.

Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..1958d19d9925 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -80,6 +80,7 @@ struct xdp_sock {
 	 * call of __xsk_generic_xmit().
 	 */
 	struct sk_buff *skb;
+	bool drain_cont;
 
 	struct list_head map_list;
 	/* Protects map_list */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 1cc14cb415f3..f98a9553e536 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			xs->tx->invalid_descs++;
 		}
 		xskq_cons_release(xs->tx);
+		if (xp_mb_desc(desc))
+			xs->drain_cont = true;
 	} else {
 		/* Let application retry */
 		xsk_cq_cancel_locked(xs->pool, 1);
@@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
+		if (unlikely(xs->drain_cont)) {
+			unsigned long flags;
+			u32 idx;
+
+			spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
+			idx = xskq_get_prod(xs->pool->cq);
+			xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
+			xskq_prod_submit_n(xs->pool->cq, 1);
+			spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
+
+			xs->tx->invalid_descs++;
+			xskq_cons_release(xs->tx);
+			if (!xp_mb_desc(&desc)) {
+				xs->drain_cont = false;
+				err = -EOVERFLOW;
+				goto out;
+			}
+			continue;
+		}
+
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
-- 
2.41.3


