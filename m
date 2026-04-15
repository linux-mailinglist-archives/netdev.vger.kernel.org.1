Return-Path: <netdev+bounces-278707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJsUIwlN32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:32:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA26F402003
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11B8A30CD0AB
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C3D3CEBA5;
	Wed, 15 Apr 2026 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoWSBZlV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16623CEBBF
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241667; cv=none; b=asfF5rr7ZUhPFk+Hxf3HR8U/6hd5u+D2wYswzkAIOiChRigmduEx5YcfFcDqVPxbgsQxKNefx5BiC36kKxsTsjcihjNqz4Tzi4RVWucN76TkbSKeyhncVC0xit6c3GTPhNy/NuaXdVPrJko+gz90u1F1JAvqHpFBSfY4WNWMUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241667; c=relaxed/simple;
	bh=GU1eAqavAuB3nXSt8AIaen1ww/JyQ0mvjIhZ+nlyXwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXVL5emknznZNdPQhmEFuf1Ehvp5GibZNlLyRtwWwsaehfKst3aX4pp4QdDX7964BFvzn1l9KcXxlq9Oq48LBVBmSvxt9Xn3s8Yeh9yRHu3/mAaZgMQV2pY4YU5jXF2UbD8tv1wSo2pvlTqJC2joJCounM1ZELor83zPf1OooN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoWSBZlV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b458ca2296so22564865ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241666; x=1776846466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccbok634eicd39AbWwkSVkudGCXxX/XXj+0cLS09lj8=;
        b=RoWSBZlV4jnYQrKnn5K0qzJrjoEHuo0LLhtLL/zQhH3LK7fnaEcHT1u48Yg61kOZ6a
         0N70EVp5Q+nRyBo8v/h4O6+JgOkmsii87QeiCrHHOdEaOzlbAFWdUYpLgC29iJt+EnId
         A+4C6plNO2MwSPgmbFjb6tF31UjOuTEAwvXmZiYW4XjDxPbzsQ8+D0pOSCax7b9sULZP
         +4zs+HeoCysp0IZc+IhRvB7dtkhixF63ZinfkuQ3CebHq7gQUxP8svT63WoBG1d6rPu/
         4dQ/sLIfTAbJ7PaleBYU/3CRxCdZ9zpll4hAwDJNkB82Y0BOTQvDuhJPPaDPCdIrVn6X
         OqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241666; x=1776846466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ccbok634eicd39AbWwkSVkudGCXxX/XXj+0cLS09lj8=;
        b=eDvIfAlfzgMGEjvichOfjCXe4a841f4HPKB7/6n6NRU/akiiNGG1gjGnZcn4PeM5BO
         7QMhSUvhJzTAI7QTaRGYXAjABxoqEiTQZrmJRoKrVaP5mE7ya51sdWaLUESc54YMCEb7
         jqNayqKZV8Y1/lgnnLN79A5QBR2I8Bu1Cqje+aP8IEDCAE1Iwb9v7eVnBzo8J6z5qjY4
         DZi7evkH2S7X1NRIO+yIvfNCpErz6Vmir8S7STEOqTRz0b1IlutOSlT+thHqL9q3VyGy
         5Ct33xg8KRNecgI8fmrkgR54hsPHg17S9hCMZIe3AhXNR2H8SvqVmYDpeeBE9M1DMDnG
         wlYA==
X-Forwarded-Encrypted: i=1; AFNElJ+njDe2SZvj8CPAcyb0LMVKQa6TCCX/5QThxWC+YiHzTJvw6uXHQyGhE0Vp/Xk6Lsr5KoTArrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kg/P95HBVrhiyof7/DH9lN1AoLDucIytsduVTLRO6Ypcaeu9
	uRGbTcw0Zju7o+fjR228v+VIXpzGkGwNtOKSfZL9sVBY/f/+IQurZP9W
X-Gm-Gg: AeBDietV+toSWyDYFPf+Hw1IN5o/qh7X/5qQnUKuB/z5gdCDh+dld8GwFcNYPORj2Zl
	d2/9RNs+dJbha9eE/LjCgM0IRQn87T63gU0mDbq1Hn6/57QCKJWA446lKG3xxi2DK5w+0WOKJ0W
	inVgAkKvbwsH+5WcC/7JRFNDZp1kp9rujGGJyeQG5UE/+miDkGWGEtXR8zcoQ51JXTJzYFkdj+9
	lwHZVqgWlmmhfAddFcRabVF3jFjVU+/hegf9p6QmyboAWES2H5y0suk2Gb+l91etXoGac5jKhdk
	h8DV/LNdLKLW9d/0vfrQNomJVpIyMajR+GQV/a46V2GUvqXMmF+fKTSZl9Xrb5oCW4/CPhAGf0C
	S9wh7dC3NmT7EHVSVwDt7ic9WmrZwsqJYLB3fd0g/0UEyNx4rthS0JXKJCX/MU/XC9ZqrO130L0
	pGi/xBNUEGwzdpBG6MuLV/qqW4nAD0kmVmYWdmJzdWm0HKM0h/Hlvr5+wJ1P8ltnj75RU8Jzb4T
	BgE1b37
X-Received: by 2002:a17:902:db03:b0:2b0:b41e:c5c3 with SMTP id d9443c01a7336-2b2d5a49e22mr228059505ad.29.1776241665993;
        Wed, 15 Apr 2026 01:27:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:45 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 07/14] xsk: try to skip validating skb list in xmit path
Date: Wed, 15 Apr 2026 16:26:47 +0800
Message-Id: <20260415082654.21026-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278707-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EA26F402003
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

This patch moves the SG check ahead, which is the only place we need to
handle very carefully because either in xsk_build_skb_zerocopy() or in
multi-buffer mode nr_frags (in skb_needs_linearize()) is used[1].

In most cases, for xsk, it's totally not needed to validate and check
the skb in validate_xmit_skb_list() that adds numerous checks in the
extremely hot path. In this kind of workload, even the overhead of
mathematical operations is not trivial.

Performance-wise, I run './xdpsock -i enp2s0f0np0 -t  -S -s 64' on 1Gb/sec
ixgbe driver to verify. It stably goes up by 5.48%

[1]: https://lore.kernel.org/all/20251125115754.46793-1-kerneljasonxing@gmail.com/

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a6abd621a7f3..aa38993b9dd4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4899,6 +4899,7 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 	u16 queue_id = xs->queue_id;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_id);
 	struct sk_buff_head *send_queue = &xs->batch.send_queue;
+	bool need_validate = !(dev->features & NETIF_F_SG);
 	int ret = NETDEV_TX_BUSY;
 	struct sk_buff *skb;
 	bool more = true;
@@ -4906,15 +4907,17 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 	local_bh_disable();
 	HARD_TX_LOCK(dev, txq, smp_processor_id());
 	while ((skb = __skb_dequeue(send_queue)) != NULL) {
-		struct sk_buff *orig_skb = skb;
-		bool again = false;
-
-		skb = validate_xmit_skb_list(skb, dev, &again);
-		if (skb != orig_skb) {
-			dev_core_stats_tx_dropped_inc(dev);
-			kfree_skb_list(skb);
-			ret = NET_XMIT_DROP;
-			break;
+		if (unlikely(need_validate)) {
+			struct sk_buff *orig_skb = skb;
+			bool again = false;
+
+			skb = validate_xmit_skb_list(skb, dev, &again);
+			if (skb != orig_skb) {
+				dev_core_stats_tx_dropped_inc(dev);
+				kfree_skb_list(skb);
+				ret = NET_XMIT_DROP;
+				break;
+			}
 		}
 
 		if (netif_xmit_frozen_or_drv_stopped(txq)) {
-- 
2.41.3


