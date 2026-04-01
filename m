Return-Path: <netdev+bounces-274260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGhCEjaLzWnFegYAu9opvQ
	(envelope-from <netdev+bounces-274260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:16:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4C3808BA
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031A53037E65
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88D38946C;
	Wed,  1 Apr 2026 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHaFj7JZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8E2EB5A1
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077986; cv=none; b=Km9inFW2tqdBhSS6IkIkcKAe4yxK4abucHEu6oVdPJlatQfScbqhpphFyEXd23FwnvmdV0noqCvuRVsilB7NF/RcsR/ed308+yYCX0LOb6FRVzo0Tc5bcn9+FFOZsR7jnQTb2qK0TY3W87SxTPnPwt8rNOmQmuwnz13DN3RdYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077986; c=relaxed/simple;
	bh=rWObApzxfsdYvn3ws+PEoX4lER4tZ5DfEe0xfzAjRHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j141RpsL9CwKbythz9FaMkVdM3jQpcmeccbCWBA3eu79ZvwCgdcxvfpcBlRlJ8/GYY6oI1CTAjcMco0xh0kllNoxrZI3yBjzHIiSiMDGtifP2l5REsINgaOJPt4mQgpIHg3kgFCIR10ZgxM2jFz6YKxVhIjUWvKcyAkSu+0UKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHaFj7JZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486507134e4so1823615e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775077983; x=1775682783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6R/1hrVhj9KAXqORtdAULWzq8bCV8VcI7fbOEm9lpFM=;
        b=GHaFj7JZPLxZJDiXu+hLbT5w4yQHcz8imF0lTw9yW72SIX3OY1ZHruhKYbrM0QV0eI
         DmLKs4EwDsopb2iDbg/ospLQ++TQQMqeYFN7MFPqHDkTI/kVTLtnuIiV0EVwFO3z4zy9
         e+Ovxyv3y6h1TLdGrakN5WgNPQekdRUoHD+tPNeW/f2+E8qkl9FIBpkW2GeUjuW9/Np7
         3E7iFM1ngCTDpydbgh7jCKUW0YRKPpfe5SEd39zb5zoaaOMQNOIgfRXKyn22WqSPZ/nJ
         mVLLe2R0HpUSzfnPgJ02HMcZw+KumJEDj+Ki+3M+nrOopX062URepvcYQ/GCxRpxfYeq
         C9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077983; x=1775682783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R/1hrVhj9KAXqORtdAULWzq8bCV8VcI7fbOEm9lpFM=;
        b=ae36V8Wf2BE9DjCJPtDyRMoKhxjyMpMM+HvCqjiPCfgCpPi1ievGFScMVB9z6vUpNl
         iTrbDMLSdqyLypiqbE4Lw7zeFsEIG/KUvAYYOyDZ6AEy0sOZo1cQ9iw9pVGzfpKJyUny
         7pRQTSxIzDCLKAxpcEBVwETLTMiVxA0u46B0ilRR1c2Y47U744XvZiUjYcfvpi3iNpqS
         3N4D2Ph2omKCEG+rnH5WpCZ5rwb7t0tBIMoLJcLeBYZRF0Q65Tsv/zkR4ohDCZxwPonJ
         2k7ONbCcWrcbjyua6yu8qbjC1Wd5rB/mKXE5YDDEMeaAqx0byadje77UgvggqcJjVgq2
         cvSQ==
X-Gm-Message-State: AOJu0YzE5xj4DGghr+lW5M8oz60Fn4XKDAVLGRTjAM06TMYBIbzoV0T3
	YH30eKBILn3GHFS9A6DUj1yMIp9yXuJyYLznor2zLQfVoARZhHQz+xgH
X-Gm-Gg: ATEYQzw+Y4eAp3P/iN+MDH7S2U+lFgfD16WhvjQ6sWFzmx+87bi5e7mcIlDgzRWp/rM
	1G9L6zg3q21p2dYmWGcZrzvU+NN487nQFOdbrnHo//JBD4wEcQyuBaw4LBqzi+oNycQKBhjoNPu
	FZXk76zB8m0PgWb7AkQ26HGnIi7WxXgybgr3aL2yuVJxpEQ/RHRgghyj1cM4Bp5LKzVv1ST+Zje
	sE3QY/Jh84bPX+y0SLuudSvJjoE5st5Ci+AYS0ZLFkx0mXwv2eSjqJRUKVGzbwJ7eLVt7CJxIzz
	WltFWH3JvuZzJbmLj6a1HDxEBDw9py6TJwwOxlFFT5bYWek53EOnexVfAxhKahNXty0zYAtnTTl
	ev58YMZp7We96ET+PCNmWlkhUXDTqm1edOAhNCl9vOflea7ChDJIB5ZU/6lENiwMCWwLOijbKIT
	AfKcbmFzAjc4xuhTHV9MIHsXwlji5S8/Vd1qrawLSkUdwqyACcOxPbBn8ICwH8/syMeD1vw5ItS
	JUF/xcJll5G
X-Received: by 2002:a05:600c:3515:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4888359cee3mr92672475e9.16.1775077982748;
        Wed, 01 Apr 2026 14:13:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a5e2sm142004575e9.1.2026.04.01.14.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:13:02 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vince Bridgers <vbridgers2013@gmail.com>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()
Date: Wed,  1 Apr 2026 22:12:18 +0100
Message-ID: <20260401211218.279185-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[altera.com,lunn.ch,google.com,kernel.org,redhat.com,gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274260-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7C4C3808BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dma_map_single() fails in tse_start_xmit(), the function returns
NETDEV_TX_OK without freeing the skb. Since NETDEV_TX_OK tells the
stack the packet was consumed, the skb is never freed, leaking memory
on every DMA mapping failure.

Add dev_kfree_skb_any() before returning to properly free the skb.

Fixes: bbd2190ce96d ("Altera TSE: Add main and header file for Altera Ethernet Driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 4342e2d026f8..9eed0be4411e 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -570,6 +570,7 @@ static netdev_tx_t tse_start_xmit(struct sk_buff *skb, struct net_device *dev)
 				  DMA_TO_DEVICE);
 	if (dma_mapping_error(priv->device, dma_addr)) {
 		netdev_err(priv->dev, "%s: DMA mapping error\n", __func__);
+		dev_kfree_skb_any(skb);
 		ret = NETDEV_TX_OK;
 		goto out;
 	}
-- 
2.53.0


