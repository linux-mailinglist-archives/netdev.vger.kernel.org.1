Return-Path: <netdev+bounces-180599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B0A81C3C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0B51739A8
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31A1DA0E1;
	Wed,  9 Apr 2025 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSCEnpt2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45685AD23;
	Wed,  9 Apr 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744177137; cv=none; b=L/jvzDTGAFanYHdRpFAeCSsv6BVC6o+T5cy1HE6PYLOR4B0rUnjx2TZqEzkojlwRm46KsNwBttj5Ufbetqk+KyHTet72X+fDVmGlSpoojeonafTNGTAU4xM8hPsD1ASXGN77HNlOg7oAc8R3R7yIxIDHonZrJn4FaCuMfc+t/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744177137; c=relaxed/simple;
	bh=iRRIfh9nrtsKwXN4CSYbbNnCsQx7hRd2dB6kD65PIW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmrQRD6NXRowOd8G7P/PL8IZqR4zihJcnsO6LxvufrhMhwrCpKRN3kQCnUDZpdLr3+MMXPnbSdln3cCv6UjRuNbUD0UDkwhs96VcMOYPMNESY+uR6OU8D37/rafJhMAf7S5Lp+8NslRaRke//saE2vPDfLV9dsBJExtSETJz5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSCEnpt2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7399838db7fso363221b3a.0;
        Tue, 08 Apr 2025 22:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744177135; x=1744781935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6esrDVCgJ75ii/JkJ3ZWCMtUqBswdXMEeG5fJ4Owvek=;
        b=FSCEnpt2hUiFy87aNWIViGw9aYEmzA0/glWRH3mKDzfrIDmuf03ICfpduWrI7RB1du
         NHCj1lMa0QET3VWfMOe7pLbQR47K+2uq6fL9UJm62IDm6gMFW1L08Q/REeQY2Nm5Osdv
         ECTRadhRTDV5/Kq288pMDYvR1AV6d1qg4nrK7VOpySSOf+lydnXhEYH5J6RrpxlqNZdN
         /95wxUKyEv3KP/X6lhfki8LS8nhxV3ZNEQl3Nnjzs65BnC4Os4r/b94tZvSTnrzMXDHl
         ++euUpIWFv0gT9HVZl1IJZ4SI8twnI7aEqkWd/2zUs4exRNEAfCq2cJeGRV5QKy9GZ59
         IO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744177135; x=1744781935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6esrDVCgJ75ii/JkJ3ZWCMtUqBswdXMEeG5fJ4Owvek=;
        b=b13yEl5Ju+FTHtnUS2PAMqSK0A/ptlIIOLA7hl6iem4sYwd/UsPJvrz8DrcxOqMRCf
         VTGYLvy721tmqaaxDgY4b7ELCUPZbefWkLGpaUYV5kr4OtgZP2Qp2cVP7cgkS0XoIr3J
         lLFwwSC0nHo3ZVzpGt9xGU/LSGfa4Uks2Ut4r+LaJ9tgqi/A3z0UIicI+YcRwsxTgkm9
         UJT5zHtSPKeibUOfMZItVJP8XT7zf/5asWmR6BpzuN6GOtUGWWbdM7Q+OwQWjm59pQpj
         owJSOrMtNk0ElGdXFU0ldgMpNUrkipdMA1WCGq9xAdSO7AP00ydA4WKRbxe3JBbyaINf
         1z1g==
X-Forwarded-Encrypted: i=1; AJvYcCW/ol6B7OqjGmgy0lT9m0GFX4W3yPU6VNvEh0NR6g0nB0f7sTWZ+xm26S/ATJNegzfKJ8TPtdEK@vger.kernel.org, AJvYcCWphQlrElL7RUFcU2XcoXbkbrF/L+cU6oRLtIzkrxu2KVbaLKXLDp1lsgI6SLh1veYFMSFsgs7UQDnPwx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDOamRIH7ylRmAaoxssI9fb2vY0kj+eGnC9Hv/FXytgXLI8MY
	FUXsjTwq9qKxA27Z6vQQnqDeNAaEcM2oOLp9dUdJqVqJiJ+QS+h7
X-Gm-Gg: ASbGncss0w9pPnIX73bogF715AEhDC1e+vX/ZH8RrTK7Wx0EYDECHi+1Du9alREo7fi
	C3iz9mCFIRvbYf6bzyJ+QkGbgpv6X8HT10dADS8fpWNwm/vSouyHsmp9xPmBh2H4Z8u5gv2phN2
	6C7sARi2Oefos61vHFzI+DNnnorXWAuoxNQdkyWfmnSCpN1Y8Dd9DdEe/RIN4+absysQTKtD3mu
	gez7+M5CYXaP6XtwRCzpQtPk5eatni/tgZoL1hdpBIyYGkM2hCHPan5LOAOPgp8P8RgHSok5us+
	1vWOZYImlNS6q5eXxM1UltmpVCAm7rDm1MsruFhiixXzGOimZoNVclW712ng1jE=
X-Google-Smtp-Source: AGHT+IHgSp+Zb2wP/eA0t0Db1G4bAXclg14tyitPrmOqdqLh9lNCIs5QzoK6Vw9RgdwEozJmPi8D+g==
X-Received: by 2002:a05:6a00:4c98:b0:737:cd8:2484 with SMTP id d2e1a72fcca58-73b9d31e651mr8907229b3a.6.1744177135362;
        Tue, 08 Apr 2025 22:38:55 -0700 (PDT)
Received: from nsys.iitm.ac.in ([103.158.43.24])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bb1e383a3sm392214b3a.92.2025.04.08.22.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 22:38:54 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: jiawenwu@trustnetic.com
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saikrishnag@marvell.com,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ngbe: fix memory leak in ngbe_probe() error path
Date: Wed,  9 Apr 2025 11:07:54 +0530
Message-ID: <20250409053804.47855-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ngbe_sw_init() is called, memory is allocated for wx->rss_key
in wx_init_rss_key(). However, in ngbe_probe() function, the subsequent
error paths after ngbe_sw_init() don't free the rss_key. Fix that by
freeing it in error path along with wx->mac_table.

Also change the label to which execution jumps when ngbe_sw_init()
fails, because otherwise, it could lead to a double free for rss_key,
when the mac_table allocation fails in wx_sw_init().

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a6159214ec0a..91b3055a5a9f 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -625,7 +625,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	/* setup the private structure */
 	err = ngbe_sw_init(wx);
 	if (err)
-		goto err_free_mac_table;
+		goto err_pci_release_regions;
 
 	/* check if flash load is done after hw power up */
 	err = wx_check_flash_load(wx, NGBE_SPI_ILDR_STATUS_PERST);
@@ -719,6 +719,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
 err_free_mac_table:
+	kfree(wx->rss_key);
 	kfree(wx->mac_table);
 err_pci_release_regions:
 	pci_release_selected_regions(pdev,
-- 
2.47.2


