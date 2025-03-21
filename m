Return-Path: <netdev+bounces-176727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF3A6BA83
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 13:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E543BCC7B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E419227EB6;
	Fri, 21 Mar 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs8B3OgP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB1227B9E;
	Fri, 21 Mar 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559307; cv=none; b=VKmnwhZI9BmftMadWHzb0l8l/QqYt++fwMQIg4IgeXUIO71MhQefo6zm1+tIy8K5IGXYhKuTjkfSYutUFGBbCEEhkiVirhDRM4RxZn+R0LWWdX28mX+e6HZxwoBSbWjCivRz77GC2Sg19V4lIOSuD8CbC8KO4Ch1L2otACJkiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559307; c=relaxed/simple;
	bh=e1THXeYInf9OC/0StrfPWjyovL28/PraOHgkB4d5imo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I87OSyzqkbUwhRAKZmiUkSLc9PlajPXHGynb7X8so8ThAlMuypw1xkb0/yuhBvzee8rClFqdHBT/LhJr/FKmWBjEMg3/JhBnWakoqSMctibm/y0MoRO1Vqj3XwCPvdJqfEhGT2DAxWiSDpbZ+Oek9YeTHt4+8SfRbOWheBQPfpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs8B3OgP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3912baafc58so1559713f8f.1;
        Fri, 21 Mar 2025 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742559304; x=1743164104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXzU2WWyujDA3yR+efjM2p5MZNyfZHM31uPBCFVA36E=;
        b=Fs8B3OgPn73KtCx6mShExIdrTNEN9binW7EeVsmBc9SdEMdc2TREWZgJV7w3fnh7Pi
         bAib40lm20Ado5d4Lrb+zNng8CIeNVxG2GVlhmZLUKmVp7owD+HuEGfr8ctNsr+njoPh
         oJs2R10o6ezbz2BRuXhS9c1mZMFv9c6AfHrJ0XYxRkIlFimsXPoiSYt8eRGmBXxI/ShK
         QnWdYpWIyKsWLnTKZgxAVNaaPNI3MHTYbJy36Qo14zKJip48F3GTy/fU+jrJkvaOHe2g
         ErrWojo6nanQnhh57wC6FeMNnd7zQQcWKaM/APXxb8Wy7H2gtSv8Ge8BJMRHW1tVd+At
         GD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559304; x=1743164104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXzU2WWyujDA3yR+efjM2p5MZNyfZHM31uPBCFVA36E=;
        b=WXLGy6M6q+5I/lTO9Fr0mw8JfgD0vF6KD3BsIvRFWx5X0YtJiUbBE77qw1nSVfsQ7c
         cw3yDUrU3GGoku9/Rmyv/EvztytfeMVFX5RW+NCNyfsE7Fe6hoHH8wOQBL/x1LOHJY+u
         pFrMgCJ+8IAIUM0u2G3JYr6lvc70UWgP3aHFAGixZ74fUYunegOT3PBUozgAdtnEvz2S
         0/A4DdsxaV32or3ZujfWkzKZUXU+RfuUQi9TsUTOlHxRXZD/WtUZJX6t53Jk18VIpiep
         QegTo7qfrT/CbN1AYyJ0wchXxy0tTymwqlzwpitUqKnMzYIOZIsxsPSm1O/2Qs4+ibf4
         KRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL91mWzEdJpEfp2wQ3VSlcdPQCCnW6SVtJ9/+JVrA8nu3JUL/gfjd+Wzc41fIfSQ3H7r0Oft3DPCB8OHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7lkoRCkauExSb+no8kW6G3rWqFkJEXxSh4OqDI2+kgq+nTg+
	U6d0i4ysmicVkDHw9ysjyodZSHo8hWXGlDRjKitgJuKaAjOjruxO
X-Gm-Gg: ASbGncsOevoMjSSEVdX5t0D/50L7tVRyNZUYoxJyIDcqNz7pT9Yt/ZW1tAjEclyqZsP
	mYdy0bQ8SYC3x2gZMLyq+fBStLG0tM9VtI/XWp6KHq4UfVXHcWWpNOYB9pebTXDIRcFOUAmKpK1
	zjJHT5JatSZgteFA0UQiU1ARvCb4N3v+dUIKRK8R9ut25AkYivzTT+IGndjY6OcsN2S8RL28Sby
	XnpnsfC96YOR4VQWFUmIP3B3H2qka5otG+EgGFjDp6UcRwefUozgHHwP7VarT5IVyRkDy/X/DaI
	JoE205WqWHnv/iDyYeGCuLy1BAQp05NjqmPhST8kbIGW2JYH6i4/8XZB
X-Google-Smtp-Source: AGHT+IGpzvLxwbDVM+nwZxJxWqsz5xaoc4OkxCbdyWeU0adQyGAfRVNCvqF6KSCQQo/SxgJLGiYoMA==
X-Received: by 2002:a05:6000:418a:b0:391:3fa7:bf77 with SMTP id ffacd0b85a97d-3997f9148eemr2422104f8f.31.1742559304211;
        Fri, 21 Mar 2025 05:15:04 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:9cfd:1254:7b85:f3f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9957c3sm2286186f8f.18.2025.03.21.05.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:15:03 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yyyynoom@gmail.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: dl2k: fix potential null deref in receive_packet()
Date: Fri, 21 Mar 2025 12:13:52 +0000
Message-Id: <20250321121352.29750-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the pkt_len is less than the copy_thresh the netdev_alloc_skb_ip_align()
is called to allocate an skbuff, on failure it can return NULL. Since
there is no NULL check a NULL deref can occur when setting
skb->protocol.

Fix this by introducing a NULL check to handle allocation failure.

Fixes: 89d71a66c40d ("net: Use netdev_alloc_skb_ip_align()")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d0ea92607870..22e9432adea0 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -968,6 +968,11 @@ receive_packet (struct net_device *dev)
 							   np->rx_buf_sz,
 							   DMA_FROM_DEVICE);
 			}
+
+			if (unlikely(!skb)) {
+				np->rx_ring[entry].fraginfo = 0;
+				break;
+			}
 			skb->protocol = eth_type_trans (skb, dev);
 #if 0
 			/* Checksum done by hw, but csum value unavailable. */
-- 
2.39.5


