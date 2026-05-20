Return-Path: <netdev+bounces-289668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOAhMgEEDWrXsAUAu9opvQ
	(envelope-from <netdev+bounces-289668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:44:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E9586577
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A2593013A7E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48D223DE5;
	Wed, 20 May 2026 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK4n8pyd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4AE21D5AF
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237799; cv=none; b=sMAZudDlj4f12UqBugegMaCFDc6p2iNKUn0bJ0DiUXyP7Z0E0bTYE20eRt1XkV3XiZk9MiWNjnEE6kVYcUwHVySmOOJ1QVwGvR0ccwtmVSAh2Qmqey5MJxn5B9WcfKtJwmu3hQldcKItyfSgHTcUQ1FkTUiREHN+f/lgPcV7HZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237799; c=relaxed/simple;
	bh=NxEVIpSzrsCjjOaUYlNJutV/qVP8mBLX2IwUIwCVW7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPKw6p9zf9wz9DV7GnL970zIe+OuYIFUUWbIDHPHGGvbRIBlrSpXwjUZneHy6yCsMfS/4y+FfTpVq96MfdAkSR84B8z4TN0JIg/94ZM+x1ANPi5zyHkSuL9rvLwpXmpxQsmPyfe+TQtpIR5qbuEzs7iBXXfRTWwxdug9Oem3GEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK4n8pyd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so2222763a91.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237797; x=1779842597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOCZGSYbF98R5+l9WqXa5XZWzMcFwOwCXLgcRS0V2nc=;
        b=PK4n8pyd2w7eYfImqvq4xpHkeiVbpLvBemZi+C5ejDUCKGKfBLCZ+LT7oRvpWLaVky
         SbjMgocrk3KUmPfppU+n9f6Fdxjm75ecViN2X9/C9KAyE/S+e1wAwhywWDY+/xhMqD5W
         qud5C1snBOhruLVM1jAeQuQobQxjfestGtpjwR1WhgjaKZVTFOTBB5hssNOfvuVaO4S+
         uvBLDtKWdtDdVenT+VEI207voEv+VD8HORAUH/lem/ylAuVj+iLA/VqKarDigm24qP0Z
         b4cEF5XLkjwnKY+a+tTBa5g7KaGj/lC9xGYJjsVNDIMeS7NOUU4A5GbYzPQO5uk0w9N1
         KLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237797; x=1779842597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oOCZGSYbF98R5+l9WqXa5XZWzMcFwOwCXLgcRS0V2nc=;
        b=a3Z4gVr1PyFu5DpS+zJOGdf/McVbMFKR6ERiSzUfFM6RqGewpe7fLBQXMdL78OlN+K
         7tXTlwWsE2dOfjqi+XcDX8hqOIbARhGby/9eB8DNyiiiJKqx1LkcMh7lNq+BuUKUO1q4
         B2uedZNqphiYIj4e35iu3Q4RobrYBPQCqvCXqBo9KU8V6APtoEfogGrIO5zVR91V2ILI
         9ApnFpYRNNmnB/EWOmmIJfC+HnMpYJEMIagEgYAWo4mfl5SU6I8Xw0PhGXrL2bogvZUO
         768d4T2V5+93BfeQfzhyR1DfubwSYAytc1wO6gSoDLsB0i+eDpSSF7l6Qls4gJdAWI3O
         nHsg==
X-Forwarded-Encrypted: i=1; AFNElJ/aYc2x1ZnLoDSA5xDx97rTtn/aDGO7N/n61g4iQhLHA6ntE+aEOBi1wfX64K1YLzgBsTlhdqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+7RsqtvryInANIL85++hZtaWq6ataK70aXuLTJYT7feTlOxB
	pwLxZPq78wwy7v2MYLow/2JxZc4ljvspiS88ZCzdM77crqASubtNJlhu
X-Gm-Gg: Acq92OGNpegXXRzwFHW5FoaA2u34fZXZdKIchQyGIRNwCoFA+c2s7Pacaz6Q+VAG4WA
	ppF3q5FFIOEo/Hm4UVikOu2Fmz9PFgq+zJYIp3QZ+NIHl/BFTeDEtlGkklzAM2D6U9UKm/9l/l0
	5Hv79WADBWySksBY+G5yxMb7qJgqqCGUCqvPAe+2Pd3aa2V2TZcH1/2fnGhg1ZFIwB7xjH7WKJX
	YfRToqNqe9KAu9meH5+M3oUz4IoVGOomn5+KhhhUaqc5vtvQhJPcZ4tej/bTtb034ZVP2VX9UUW
	KfTS9GnUrsD2eEdbNu3iJ3sTeCmK2JIUF0qzp/h7uOU74Dizq8OCLlAufF3IxvyKM1REKtnPeVs
	qEY7+Y01WZk4d/4rVZyJWtUN+3LG9y2cfkdXl7ZTbeXlKOZnYTaOojbdV/wkvTnAOgHVZRnrh6n
	eJF0SKEH3q9XMzSf/8RmCAjfa/MqtY78v/SSdZ29pJJeB9PuXul+EmhJMyWtyoY5EOj8Xjn9dNI
	wi90EKojQzZkzky3MbldcmMuTkgi8QS3/kFkB3Ung==
X-Received: by 2002:a17:90b:1b05:b0:366:132:fda3 with SMTP id 98e67ed59e1d1-369519c4b9cmr18824676a91.11.1779237797304;
        Tue, 19 May 2026 17:43:17 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:16 -0700 (PDT)
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
Subject: [PATCH net v4 3/5] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Wed, 20 May 2026 08:42:42 +0800
Message-Id: <20260520004244.55663-4-kerneljasonxing@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-289668-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3A8E9586577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
only the current descriptor is released from the TX ring. The remaining
continuation descriptors of the same packet stay in the ring. Since
xs->skb is set to NULL after the drop, the TX loop picks up these
leftover frags and misinterprets each one as the beginning of a new
packet, corrupting the packet stream.

Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised,
so we have a chance to examine and handle the potential remaining descs
of this big overflow'ed skb.

When the last fragment (without XDP_PKT_CONTD) is processed, the flag
is cleared and the loop continues to process subsequent descriptors
with the remaining budget. This behavior follows how previous xmit path
treats overflow packets.

Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ebac60a3d8a1..8b51876efbed 100644
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
index 0a6203c42576..f4add7be8c93 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock *sk)
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
+			if (!xp_mb_desc(&desc))
+				xs->drain_cont = false;
+			continue;
+		}
+
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			if (err != -EOVERFLOW)
 				goto out;
+			if (xp_mb_desc(&desc))
+				xs->drain_cont = true;
 			err = 0;
 			continue;
 		}
-- 
2.43.7


