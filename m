Return-Path: <netdev+bounces-288688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPRBNnRhCWpOXgQAu9opvQ
	(envelope-from <netdev+bounces-288688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:34:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4295055F873
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6B8301497F
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477882DD5E2;
	Sun, 17 May 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxVlCBBE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4A2641EE
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999621; cv=none; b=eC04gwQ/IcybDq3Z8xO3Xm4FVi1x1FkRSd9HxfhmH2AbLA7zB1g6rayRNimVkc1g+62nv5XM9JLlvNOKpH4O9CHOZH2ycIwMXYjprFd8VU8Nhq90reaS9e4Yh6c/vg1XYovd2FlN8QRDeByxMt+a2ebNl5nBwRNBbG7uCQLyyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999621; c=relaxed/simple;
	bh=k3b0394omT1f4PYEbg4WW4u48Wo/a0iKcderA707Y4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWMwytVMIlm6QG+gGo+6k5t30BcOwh7zYv0oV1rBTcQekIxl7Rp1A3RP4bVbMdKFqpKVsblhmdLxUE46+Oi5Tn3s3ohwcHESim1Vhv0d3whYHMeZvyr8HEwBvHe89rNKZXKk/zqrLYlE4qGixlTR1T2YEthSkjfWOJPBLWZ2ZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxVlCBBE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba0714574fso6303475ad.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999619; x=1779604419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qIcIDsR7wUPxzefQaUFwMlxlmc48CLmCnqZRB7TdDo=;
        b=JxVlCBBEUSmgD6oJ5EERoXmIl/AnwtvxXYbse1baoApsiIgMd3ybStMMe1sqo/g3D3
         PxlKrbe1mCGmsEjnK7b0/QTHRmMGF+kLhq7wzZ17av/bMMkqbdWQ1sDwQxdm7ba4Jbd3
         +P1yJ8kT9uwDBKYIT+h8CgXaBE1NxvVLJ8mw8OLBa9LugnD4eRTc2fmPa2sVDeCS369G
         ZvqxLLcQ447YEq0lb/x+P6aPttU5m2ZHwTxtBjxqjAH73Tgo67FmLOuTdwxkXLTsClAs
         QkIXcLHHMZDiJCMZgL+ZVd14t4m8bDBMQyB4Y1Uxz8PgzqCy9ESqI6mGcCvubP2W2JGF
         hI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999619; x=1779604419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qIcIDsR7wUPxzefQaUFwMlxlmc48CLmCnqZRB7TdDo=;
        b=ObrVTCjGwVz114jsxWdehlRWwxEKtpBCQ2u92sCpiPHeNLiJvoDtlT1DCnyv1rnliF
         zJTisxaFcmEuJLaFF9vYzcCOZPPEiQmuNgWLCE5DX0FzhtBxIi+Teh4W7Po7sMAQ4dBW
         7UOxfXZTwzVepFL4c2J2LVwOdnX4mBZQ6rN4ksm/+Diql9ARZDG2nQC55wszTqYLXgMJ
         k4VhETW3BsItbpCAK/O6vh3Slv5tCOBdF3UfCuXZMssP8Sx2CTT4P4MtBDvebdvDRbRA
         GIbe54uUVMpuggQHnBiPoQiMuBIhqEoh7I2YIANceSkFD+FDvxDPPcpMYZuGXdVL/4g6
         vJqA==
X-Forwarded-Encrypted: i=1; AFNElJ+cxL2NmPfT5+XYDE9IhmQgzFKOYXLXZrP1++FLPZFuqe2CarktR4d+xemcFeiXFH1cFttVSUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4mB/DPMld1on8btsPmx3RL9c2kjcH7An8WQ6j4RbH7T892nx
	Wmdi4hqzkcDGA1FgYXI3m9ZHbYS9hTwFgHEVNr0ztKNjelgaMHArcysq
X-Gm-Gg: Acq92OG8fRhwotXwC5bsZOu1Gemnz+OujPYXnvDIdtChHiVjDY7o8aboxRbfpGHMpl2
	8snIf455ZcyRtbWFAZLjSJuhMlijNg82o6KkDJ430kONkULJ1mCVEIMLzUGOX1xL2aYoOS6Z69V
	9WuiyeOJmUYXGNls3qWB15d+RmS1al/RmwV/witzfCeThyCEXH7JSaGh/QZHLoo4wUVNeToDFiE
	vwQ6utL7gRCXPrAxCerSJb7nGh294oB943VeM575V5U7erkxe9DvGxHGtr5txyr7onxUTwNW4Xi
	c6LVPyarJvghpmLxZxJD+X5w9eRcHNVH1EDjr+tp2MD/bmdA7dKWdOdqXx+o2P8yGTNjm8ZAMBi
	jEKyN0bp2TOhyinEDgBIGeS3TjCviPZ/+WtaEhwI8c7Vg3csKNi9PLVEIPegubYVPncDK1oejIp
	2H1n/btLrexhpyl1X1KRtd7PS9tAYnx9Mz7/Cx2PpYbJETCnvDIl9+LCo2YfFuLb2LE5uhJCp2K
	1Umx9YVGrjcyYrS/8qVRllTh7jblwbbnL3tS05zew==
X-Received: by 2002:a17:903:13c6:b0:2bc:7d5d:e2b7 with SMTP id d9443c01a7336-2bd7e9a7de2mr121343695ad.36.1778999619168;
        Sat, 16 May 2026 23:33:39 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:38 -0700 (PDT)
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
Subject: [PATCH net v3 3/5] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Sun, 17 May 2026 14:33:09 +0800
Message-Id: <20260517063311.28921-4-kerneljasonxing@gmail.com>
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
X-Rspamd-Queue-Id: 4295055F873
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
	TAGGED_FROM(0.00)[bounces-288688-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
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
budget for normal packets. This behavior roughly follows how xmit path
treats overflow packets previously: stop sending packets when detecting
the desc has problems. Here, it is stopped only when this group of descs
from the same skb are completed.

This reuses the existing CQ backpressure and budget mechanisms, so if
the CQ is full the function returns -EAGAIN and userspace drains the
CQ before retrying. Zero buffer leakage, zero packet stream corruption.

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
index 0a6203c42576..298194b7335e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1016,6 +1016,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			xs->tx->invalid_descs++;
 		}
 		xskq_cons_release(xs->tx);
+		if (xp_mb_desc(desc))
+			xs->drain_cont = true;
 	} else {
 		/* Let application retry */
 		xsk_cq_cancel_locked(xs->pool, 1);
@@ -1062,6 +1064,23 @@ static int __xsk_generic_xmit(struct sock *sk)
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
-- 
2.43.7


