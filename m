Return-Path: <netdev+bounces-281220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ek6AJn77mlT2gAAu9opvQ
	(envelope-from <netdev+bounces-281220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:00:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 949C046D65C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D4AF3001FCB
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9B2848A8;
	Mon, 27 Apr 2026 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxCjhJau"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2F1EA84
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269653; cv=none; b=WgEUmVXlvIU/Xa5hld8wCzAfXCALCnILFsHX4Fm/vu9x8kTcruslnzw3NNlWxsdnhtUdc6qLPgMmGcR1R+yCwW/+WIHNwAJYo7mpVHUPT0UOoOdModd9nBCQoPzdB0goiKDc0BEGUy9+tvf3yIBmXzGA+tgpnYob3fg1nwvYJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269653; c=relaxed/simple;
	bh=c0Q2SHrreG8yVi6AcrpAqksrURlVvG+YTyVZMFQyK5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrmUBILGw2JN8kRpVZLRX6NdGlCpFxUd3iDzmHgqPjEGmdEbzxMD1nK0Wg74vWz5AzTQFqzF6lPqUVgBQ7eps06Cv2tWParjWxKn9qdluLbX4j8lqN2lW/5rOW3D7CN2MBWA+Ao5MG0Gp7k2/c1t4BRsb/Z8q5HD2PYHW6gzUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxCjhJau; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-79ab5fd969aso107775877b3.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 23:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777269651; x=1777874451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMNFz/mBaGex7fjeAYB/iMvosNG5WFdmxWLx9EfiSTM=;
        b=lxCjhJauzA4CY6ZrRotCubB/wqln8LhF/p8jp64QRtgI7PNjAtxnifuMXbGGdt7khc
         SQltsCbcHTJLxZUHdAzsMZtqyO7O88MUjZjkSbCKbSOWnPx6dR+6n8Wojh3geRJNNwfK
         B3DvmRG/HrGLvgBSyWB/eumLgl6W3h6VeJ9PHLK4NuKd/oHduQKnmQtTIS802nvxJP9j
         AqjfDnu2miDL52Sr1DoY145L4y9CQP3ArBAaMoQ8KxtwJ9BFaA6ikYPOMcc0duMoNVZf
         j13nWHEaCIFU/FXt1NG0dQ5xKjWnOt51dypTM1i78EGaQKAMXiDxs0B8WBtxUqNF62/l
         nB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777269651; x=1777874451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMNFz/mBaGex7fjeAYB/iMvosNG5WFdmxWLx9EfiSTM=;
        b=sEsmKjMqPsmZDWU8TzUVXJnabXW1yJcWbKFuV0IbLhive88EBv0mw+VeJVHiSEuhV6
         zFR+z+s2e6FZ09xNzMkMNhqAWdMWT40Q3JqsDhuS4p3RuljUoHX8thCyVnR6iiP5wMNd
         qi/21/Z5M9nfasmymeB+wWwEX4Vf7gsclTrM9s87pahTDyAQZxhQ8LxWG4e3ZQIJMtX5
         OBY1OJ7nDn0qGKfM7IfrVWcknLQXUxom9zlHWZhqIvEL6IiSkl6nwWyAIaCxNjMoA/ye
         TCB1e4Pct3b7YtOBp8M/9AoMqgNdvvJjFuzc5QYniPwPiJ2QkjfwDRnznD1fpAmvR4Qy
         X2oA==
X-Gm-Message-State: AOJu0YxuJRZCKTAe5VLL0u333+varisE0OpUnmLNnt0XdWQrGYkI6cOj
	jcz/gc3UJR84cL2G16eZTThNlSpkWvUlpo+Flz4vDhZlSecYoxPHPzSBCby3eeTpg47i+Wg2
X-Gm-Gg: AeBDies1eDsXj8Obb5h8fQifC7YFXO0PPjfJqIzJh2yZoAuFwYBlLdV6yE8y+4jjy/k
	IMLByIFmhNT8haxTfNxJq3zaWvCq9OJP/XQmyM2QdVZjpmWLIrw+AXKR4UEVGAegXA1KADRZzy+
	Qy2sMmeEtn9AiosGGhpZJx+m2w7Jl9qYwCToj9LcjGLe1VGhbnSaYURNh5G3q0DYX+qzYmadmxV
	WqY2K8CN5BCHZAoIQU1oWnISNSJ94IrHTjDYzOB2aT0LIGIhl3Qby5StAWvqKH50xVpQggC54kv
	vkW4DKE09v6m7WdFK2pSeG0pZhYU3kArBD3xHsUO1ARhH1Qq1IDuoYx+eEuZUDYgQLHwFveAlQb
	Nz/wU5Py1QcfHxMh5+aXZAXQghkHuAaKlX0Zg7RXPcU+C9OpQw/Y1JPO7jwaYTiC4myxKSnKucr
	QOz0N0bVX8XOCQ9j26lO51RRb2s0Rj0qeol8dj3L9tzN8qkdPBn44d8GDjMi4WdH3CXxvtSfos8
	Q==
X-Received: by 2002:a05:690c:39c:b0:7a0:17f4:e785 with SMTP id 00721157ae682-7b9ed00abc5mr426868717b3.39.1777269650789;
        Sun, 26 Apr 2026 23:00:50 -0700 (PDT)
Received: from localhost ([2600:1700:3420:b5d0::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8c03c8sm123605807b3.15.2026.04.26.23.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 23:00:49 -0700 (PDT)
From: kernelcoredev <sonionwhat@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kernelcoredev <sonionwhat@gmail.com>
Subject: [PATCH] net: nixge: fix skb leak and missing bail on DMA mapping error
Date: Mon, 27 Apr 2026 02:00:46 -0400
Message-ID: <20260427060046.3927-1-sonionwhat@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 949C046D65C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281220-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sonionwhat@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

When dma_mapping_error() fires during RX buffer refill in nixge_recv(),
the skb allocated by netdev_alloc_skb_ip_align() is never freed, and
execution continues writing a corrupt physical address into the hardware
descriptor ring.

Fix by freeing the skb with dev_kfree_skb() and returning early.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")

Signed-off-by: Bentley Blacketer <sonionwhat@gmail.com>
---
 drivers/net/ethernet/ni/nixge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff99..b64e2f355 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -645,8 +645,9 @@ static int nixge_recv(struct net_device *ndev, int budget)
 					  NIXGE_MAX_JUMBO_FRAME_SIZE,
 					  DMA_FROM_DEVICE);
 		if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
-			/* FIXME: bail out and clean up */
-			netdev_err(ndev, "Failed to map ...\n");
+			netdev_err(ndev, "Failed to map RX buffer\n");
+			dev_kfree_skb(new_skb);
+			return packets;
 		}
 		nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
 		cur_p->cntrl = NIXGE_MAX_JUMBO_FRAME_SIZE;
-- 
2.54.0


