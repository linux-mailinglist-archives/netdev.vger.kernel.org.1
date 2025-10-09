Return-Path: <netdev+bounces-228430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA7BCAA4A
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 21:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E24E0586
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F6241679;
	Thu,  9 Oct 2025 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuvQxGL3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD934BA59
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036787; cv=none; b=Ph2jJMnAoDQ6K+UE/TUGid6r9LOLcfR0u0cUGgEI+X9wDI+4hgR08yQEkKOauvsT7BJ7XTVsMzzvigkg7D3gyqknUaIspRC5sfRvSVcrTixFLJ6I377N4dzNWssj4IQdy5V9FBmufRSKwJRV4MU8YoW945bMCRZB2vWZ/p+aeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036787; c=relaxed/simple;
	bh=ddLCZ0Erq4J+fD+SEojwpwJBX3/dCdE8Jy+xB1E/FKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLJ2PNnzWUDOG2SH/mz99gaJONjUOlWgAifL8hVs+srO6RSp2m/vPc4oghXoxU143M/4hDWCRzFvWUCM8deQQlgG3wtdgug6JLUGsE0moGWeu0TioF9D5pCmK2P3s/uabZ5legkMbYFV9UAvXPFzMThqulHtkLEfEfFwjwC85WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuvQxGL3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so1855865a91.1
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760036786; x=1760641586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JEjGknaIQTT5zCZesWXYRLiR/b6Jtfo4VUqPR/aQN+c=;
        b=QuvQxGL3qJSUDIrk16yTSZbMAzVfSwjOk0rReFZkk1ldmXdX3DOenttBNbucot8BLO
         buzqt7OZOEwIeEwqy2UsWxFkvC8fN8bBkXtr3Ig+q4U/P/cF0HzRsS4Tl/+mZJLAvJ8x
         9Rm4dNi7R8yOUFq4t63Xt1jcfE/BTK2DrYgN8G0LW+OYmLZzDkVbgSw7+8zkwy/o6Qu3
         +mYmIFaShEjzvEtJfNzBEdNw/c/a1ClIWIwdiwMW8SZkLY1JeTFIPMK+m7OT1WQtXI/C
         mg5i5RJa9KfutLiQrkuSVXQmbkBsnh50v8/3fYcAS8TZHa1ucJMF9xlfJbEPYECELZmV
         Vs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760036786; x=1760641586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEjGknaIQTT5zCZesWXYRLiR/b6Jtfo4VUqPR/aQN+c=;
        b=G2Mg/7f1imFX2XLBE16nvDADH6LD2XTZa5lg02BOCHJqAdJFMpcuv+u7uomqdawJPx
         UDVNe8NRhRUamGq2LbaF9cvUx4K1rF1vLwTgH32Pee4RSgIR2OXTPkx8S9WiQ3FeKEMr
         5aM1YT7MDe2/M7h9gpaLJ0vPe2l0pEChd6UBHA+4sC70LGxQROxHYRVt89hbwes59R4R
         6RhPUlV4GPma6A87oWvyur3qPKoSCl23aoVyqS/MRQF5Y/2oGYlSqz1fHb7wFX76QcBM
         4oSq2RvMkh/WQEGhFnmP4gAtrJ1l3dvgnG2tsSdZjWOCfq+DpFBVWCsrlENw/RSTqk/m
         yKuA==
X-Gm-Message-State: AOJu0Yy49wM6G9wT/iewNCV7+ScwP9cwQQu2jbEfHwIsjsbUpS841ZrD
	A3liYDpH2ww1A4kO3StTjKPXXhCOIcTitunmvXhLx5tYe0cs/cZawTFl
X-Gm-Gg: ASbGncsCIv5av0BERnq2PsfeiO06XLAIBQQi0Edd2szkFmznN4sLt28CnxTMIvdbs9k
	hqBHsRjM85wefbbjql1NY26HBXscRovjJXC235qcfO9J5Ev3IrE9j0moG0ey9eX165X2reEnFQ1
	d5qHTUEoxYovyiqG/RzxtpzlHEqymryODLpZEQnHWbSFxwecd8+fWxO0ENxuoEmdY/Q1WjXKhQw
	O/m1cvh67eYOR3pQMbcdMNbA1N46j5pvjaTqWKPomZZ2GLr0UGKWXt521tfNzw4UjNoTyxuoU6/
	7JodXnhv29VY9zlI97bMx1l4bjX4qlPSQ2KHbb+pWCu2v9y/9m3mNWN5/dtFleV7lIARUvyW0NW
	wMM2xRCUb5jYXyoTm6PGBuz5bEKiOrPh8q82gB7ggIjouWA2fXY51KHjtjw==
X-Google-Smtp-Source: AGHT+IFXUt6VUamHbHYZHs4517klUwXoUlo89uzt3GFSwzjhloph9wZ5hjH2CwLWBaE4x3gtGf/L2w==
X-Received: by 2002:a17:90b:3b50:b0:32b:8b8d:c2d1 with SMTP id 98e67ed59e1d1-33b5127ba49mr10126458a91.21.1760036785539;
        Thu, 09 Oct 2025 12:06:25 -0700 (PDT)
Received: from mythos-cloud ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df4ba7fsm350174a12.32.2025.10.09.12.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 12:06:25 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net] net: dlink: fix null dereference in receive_packet()
Date: Fri, 10 Oct 2025 04:02:22 +0900
Message-ID: <20251009190222.4777-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If `np->rx_skbuff[entry]` was not allocated before
reuse, `receive_packet()` will cause null dereference.

This patch fixes the issue by breaking out of the loop when
`np->rx_skbuff[entry]` is `NULL`.

Found by inspection.

Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
---
 drivers/net/ethernet/dlink/dl2k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 1996d2e4e3e2..aa3840454fcb 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -969,6 +969,8 @@ receive_packet (struct net_device *dev)
 			if (pkt_len <= copy_thresh)
 				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
 			if (!skb) {
+				if (!np->rx_skbuff[entry])
+					break;
 				dma_unmap_single(&np->pdev->dev,
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
-- 
2.51.0


