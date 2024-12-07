Return-Path: <netdev+bounces-149887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A89E7E9C
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 08:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C889285DD7
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D82D047;
	Sat,  7 Dec 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llKCPWre"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5C81ACA;
	Sat,  7 Dec 2024 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733555001; cv=none; b=b/I0zLtYowrnWUYa7U8RABd0if4d8UZxzQnDbu5M14xlwoYs5hIeHwizFNOwKrZ98frfjTwiWvqN4MO9CJKBpYxN1tGdRkQ5sumtifxN68a8Ja5nyUunZrUfBdwfEA5so51CCgsegWbN6Y9YlEfTuw7Z3RaLpIW1O4qLq5EpS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733555001; c=relaxed/simple;
	bh=pddn0gMgqbCFPsbbxgbjcw2YxECn/Ui04cNPs5K7eVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZyHzLGd38uSHllse5gg+mYW+D3qbmOYpE3r8C2xJsILlNgHWLs/8YFOF6UCfpK5SnsDoknV0jIBlVwrzjKyX4eNQRSIl+iaedYKQMB0uf1a5e5DIzYkH7lJiOvE3vEujeXDvXkp4gFQfoPjLE9MomrAoG5fNgpbpgoOYK7x0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llKCPWre; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215348d1977so23318205ad.3;
        Fri, 06 Dec 2024 23:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733554996; x=1734159796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VBksAF/T3d2c5+s8Bg+ubv6vEd7NOr/os/9LSHT35Y=;
        b=llKCPWreM3vismNCm2ann09zawoVIiGrOwLNExs7lue98F+r4mUyQLLjIDMKwVjglx
         YbEKPfqFqkiUYxdG8xaQKQVkrT7WS6FWr+L7elWudNgcfCmdrPRvDoyOPm1he6Ux3mzg
         bJEwqYyFm4fVrL11Jfonyt5Nd/nQauqc2vRC9CixkXqWDNyRD0dHrN1pfXjdR2LZLao1
         r9Ylo/9rzo5zz/sEOmPFTNH8oa3jIyYW+gowOY0UXtVNje56VaA5TViv5PlXISkFA0NP
         auXWinBKT1AW/QnPMX4fWYS/G5krsxtoytV4RokN0CGfywLtRRkEasDRuIaYvtDjBjzH
         Z8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733554996; x=1734159796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VBksAF/T3d2c5+s8Bg+ubv6vEd7NOr/os/9LSHT35Y=;
        b=ntxIcqcLYTaOVzNbdFxAE6FptVPRPC2KWhe8J1fVBQ3GpNNVmadEm2WVXbKrAfseO3
         S1QDum/gg2J3q8Cdi4nhk5ignLwWf7N6aRXxB4yJdRGMKXBj5WjLY68O9ePVuMFq+LCM
         XTLgNtdn5KooQMymnujBB7AJptf84x4UljvZ2ysfzBrGg/kfnhcgsR0ZHeNq9x6K5ROV
         gcayPtI5VRLeMCNYcoW7KHI1NfjrYAI4wPh1mWopNDnwA2QD5zdYbdAVzXmzqCIOnzrA
         P7HU5KbwGxy+quYft4fGEyva6luUy6XcdWeSKKRjYbWY8Ka6k1yLFYrsd+oR9lYwwwi/
         WPZw==
X-Forwarded-Encrypted: i=1; AJvYcCWMAyrVbC5xcXStqWHrsx8gVBxJbe/WlHDFgnCVKlq0ib2GjYwJNURezg0IWuxuaAIsi8IAVDYqcixY+Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrTgHFdoSyBB6QR14Xw5BqfWP2EUXczdCEwCmfrzhBKzteb10
	OGu9RkREO4mmhHw7yT3Mm2ffRzNx4Ls16miKkvSA6I/SUReXNnQehvFJkA==
X-Gm-Gg: ASbGncvnRY0M2pQ23FoVT4PWK80hCNC094ZxSxxRpokXBPD4ZUtY/2fSXWYbefZwCKW
	t1bxmsPPLyBC/QgqoGGcg8j0YzDXRF+Xr2rP6Kvdld2Ewv5u0t60leKIO3G89Q7AC3+nmrzaOY1
	kJpH6obKMDZ5ZPTUjqvjT6PGDUpzzhd9CM8ZvHPAX5z+zK8bvXsqmrLqFiXE36Jg367QEvcJPLK
	D3onAPb8Pi2zeUIsXbbd57MdP9gxDSp0LVhrWGWxjmgUEQkdwNIZZo8nO6WryA=
X-Google-Smtp-Source: AGHT+IGRLV9tlr/2SHhgZD19JnwDMG0W/wwF7xuVg/N9Skwvi9GkZLfzfL0GTpIhC8/5P3oAOgPTeg==
X-Received: by 2002:a17:902:f542:b0:215:a60d:bcc9 with SMTP id d9443c01a7336-21614d1ef83mr97323535ad.2.1733554996066;
        Fri, 06 Dec 2024 23:03:16 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-215f8efa2aesm38395105ad.142.2024.12.06.23.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 23:03:15 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: Move extern declarations from common.h to hwif.h
Date: Sat,  7 Dec 2024 15:02:48 +0800
Message-Id: <20241207070248.4049877-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These extern declarations are referenced in hwif.c only.
Move them to hwif.h just like the other extern declarations.

Compile tested only.
No functional change intended.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h | 14 --------------
 drivers/net/ethernet/stmicro/stmmac/hwif.h   | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 1367fa5c9b8e..fbcf07d201cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -543,18 +543,8 @@ struct dma_features {
 #define STMMAC_VLAN_INSERT	0x2
 #define STMMAC_VLAN_REPLACE	0x3
 
-extern const struct stmmac_desc_ops enh_desc_ops;
-extern const struct stmmac_desc_ops ndesc_ops;
-
 struct mac_device_info;
 
-extern const struct stmmac_hwtimestamp stmmac_ptp;
-extern const struct stmmac_hwtimestamp dwmac1000_ptp;
-extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
-
-extern const struct ptp_clock_info stmmac_ptp_clock_ops;
-extern const struct ptp_clock_info dwmac1000_ptp_clock_ops;
-
 struct mac_link {
 	u32 caps;
 	u32 speed_mask;
@@ -641,8 +631,4 @@ void stmmac_dwmac4_set_mac(void __iomem *ioaddr, bool enable);
 
 void dwmac_dma_flush_tx_fifo(void __iomem *ioaddr);
 
-extern const struct stmmac_mode_ops ring_mode_ops;
-extern const struct stmmac_mode_ops chain_mode_ops;
-extern const struct stmmac_desc_ops dwmac4_desc_ops;
-
 #endif /* __COMMON_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 64f8ed67dcc4..58a962e0b768 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -665,6 +665,20 @@ struct stmmac_regs_off {
 	u32 est_off;
 };
 
+extern const struct stmmac_desc_ops ndesc_ops;
+extern const struct stmmac_desc_ops enh_desc_ops;
+extern const struct stmmac_desc_ops dwmac4_desc_ops;
+
+extern const struct stmmac_hwtimestamp stmmac_ptp;
+extern const struct stmmac_hwtimestamp dwmac1000_ptp;
+
+extern const struct ptp_clock_info stmmac_ptp_clock_ops;
+extern const struct ptp_clock_info dwmac1000_ptp_clock_ops;
+
+extern const struct stmmac_mode_ops ring_mode_ops;
+extern const struct stmmac_mode_ops chain_mode_ops;
+extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
+
 extern const struct stmmac_ops dwmac100_ops;
 extern const struct stmmac_dma_ops dwmac100_dma_ops;
 extern const struct stmmac_ops dwmac1000_ops;
-- 
2.34.1


