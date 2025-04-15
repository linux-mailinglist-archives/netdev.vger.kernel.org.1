Return-Path: <netdev+bounces-182577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C4A89289
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1239E18960F7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC321772D;
	Tue, 15 Apr 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVObfEaD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF1215F46;
	Tue, 15 Apr 2025 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744687777; cv=none; b=Ni6lOCKKbi81TB6BweXSmv9Ytl8V5yU8ChhFjeJAHO8s5QYR1PxB1NeQKQdNFdwVzjAfdMGR3LTRHDBr8wDGpevQJmeF7H0/Qh5/J+G4OcUr/bdu7IW8fZV98VOgQQ4KXrhFiKeFSfpHd8NmEHdE76CuF1kbQKLPNGrIUHu1xxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744687777; c=relaxed/simple;
	bh=0VG5bn70u0nQJZvRQ+yaOiXGO7G1+Ib707da+D0PmAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1iDN6occoxzKtYcmhdJW1VQTcwMCq+DQxDBvDMYQuZdCznFX6w1OpT7f5/OAd1wo0Z6nGWqMXuQV2EwG5vjr/Ik8wbAYopjjAUKY0CUYz8kNO74jkR3xv4ov/fwcgqajzG5a/l+++L6JHquaUDuvcpZKJT1Oh1VFG1/SjONC8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVObfEaD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736c1138ae5so4962489b3a.3;
        Mon, 14 Apr 2025 20:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744687775; x=1745292575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7GzGJomWWI+mN0n3zOE3rjXulORlFMfOTwUaPOipP9k=;
        b=FVObfEaDpwVg2KUBxTP9tg9NYth0MmXjmha3PUKnxA2Yxj8WyvXd4SicjEJ5aAnuoh
         dH0G9fsV6XLt+0TgaKePFe33aI9dKXedYorn2gEDCXAvusCEL+qf2rKj6DHSyAVCjY3F
         dkbzYcdoubYrADChOvgl6G8R0n1Uz3YWeoahsTkwa4Se/Ht1ewl6p8QhpSgfA9DLOiO2
         dB3O8VZh5DZbCPikBErwfZOnB8FHQEtydys+QEDHaym31Ma9FqqSWUTWsSexNtFzHVcf
         FD0UgVW/Z1AyPzQChH8F4T3lePsJtkFcibJa+ALhOvsDNOtjonNP0xQvMck9NCmgYKLC
         2iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744687775; x=1745292575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GzGJomWWI+mN0n3zOE3rjXulORlFMfOTwUaPOipP9k=;
        b=oMLRv8M6DkidbbNIg7bejstekfphw/mb3JCqubp/enYnsthVSUArZOWRjQ4bYsCeyp
         iRTwhxFXlK+XtLOLOyh9dM9C0LhEZi202exu8Ro9j9Ud1w+cSikaHSB0P2AYnyxuWJVl
         jALGNkChzku+p1EKWlvxWY4dpAzUZNxMKMRHmeEziEEGvsZQ1uFNCFx0yuk8ND0ua45y
         O9u8efBNAzsBHs/+0Tg6H7SQW3H6pHBIxgBccF4Qa+7RsMuWz/boZI8F/Xja1mztPyPE
         G7/ZISTj8bxSompgzQUHOTxRsOdCedemF/3V9qno8NH6xDBMwNwqgQs9H2/SHb0T5a6q
         fpsw==
X-Forwarded-Encrypted: i=1; AJvYcCUJQJsB8M4Rd17ro6Q1b7277xmrpxKfSd/MSCoce7lPIvnjEjZi1+5g3G808s57bLcFSHsAZk89@vger.kernel.org, AJvYcCV9FeANZCJyJR2HEteDlHpFEhi6LLR9UD3xUbSsnS42n25yYNPmfCGi8ZhQe/GCHIrplJxPo4q4eS5Sf7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7q7nMEIgYKiPnRtAVagwLQKslX3y0bppSFrAC6pl7oU7KxUnW
	OT9rbinqXzMIg9blO2XbxFLxBfP+OP2Mo07CVXhh/rgjxZuMNr7u
X-Gm-Gg: ASbGncuFQm6KkRm3zScqe+rcBHW+dLXEfqaWkA5IA6xyOpsmuVZmPUf+dZ+c1LFqTSa
	4D/08wkkWQZ/JhxKSBERALq4udW0/VoWKnj/KrwYnET2EuUTH5CkZUeIkTUKpWHt0eA+klyDqIU
	xS69mvlbnFkZ3gykROEXxcQ63JyXXD5iJN2bvJkrCiOhQWroqeI2oQX5Ml3RFZdRc4y76OXf6xh
	q+w8VI3eDlmTkE2VBxw/tR8A0A5z+YzMcxyD2RG0Xw2A/SSKsVznoutENGcXRjovfBp5yI4yaCD
	t9LRfxbpnLisCnGxrUh7NChgltIEBE8dsI9APLVPck9m/D3lrGQvOSDL
X-Google-Smtp-Source: AGHT+IGMA6bSXQXXUGEj500KRja+sm30gW0Fj8LVo6wtEKRxGeUdia0LiKt6azBnUHblKVOOVUyA6A==
X-Received: by 2002:aa7:888d:0:b0:736:ab1d:7ed5 with SMTP id d2e1a72fcca58-73bd0e989eamr17473188b3a.0.1744687775110;
        Mon, 14 Apr 2025 20:29:35 -0700 (PDT)
Received: from localhost.localdomain ([49.37.219.136])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f1293sm7674716b3a.99.2025.04.14.20.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 20:29:33 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: jiawenwu@trustnetic.com
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: txgbe: fix memory leak in txgbe_probe() error path
Date: Tue, 15 Apr 2025 08:59:09 +0530
Message-ID: <20250415032910.13139-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When txgbe_sw_init() is called, memory is allocated for wx->rss_key
in wx_init_rss_key(). However, in txgbe_probe() function, the subsequent
error paths after txgbe_sw_init() don't free the rss_key. Fix that by
freeing it in error path along with wx->mac_table.

Also change the label to which execution jumps when txgbe_sw_init()
fails, because otherwise, it could lead to a double free for rss_key,
when the mac_table allocation fails in wx_sw_init().

Fixes: 937d46ecc5f9 ("net: wangxun: add ethtool_ops for channel number")
Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a2e245e3b016..38206a46693b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -611,7 +611,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	/* setup the private structure */
 	err = txgbe_sw_init(wx);
 	if (err)
-		goto err_free_mac_table;
+		goto err_pci_release_regions;
 
 	/* check if flash load is done after hw power up */
 	err = wx_check_flash_load(wx, TXGBE_SPI_ILDR_STATUS_PERST);
@@ -769,6 +769,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx_clear_interrupt_scheme(wx);
 	wx_control_hw(wx, false);
 err_free_mac_table:
+	kfree(wx->rss_key);
 	kfree(wx->mac_table);
 err_pci_release_regions:
 	pci_release_selected_regions(pdev,
-- 
2.47.2


