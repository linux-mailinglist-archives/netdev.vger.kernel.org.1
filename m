Return-Path: <netdev+bounces-227845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7FDBB890D
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 06:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC8419E1986
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 04:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F91E8342;
	Sat,  4 Oct 2025 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6HSXS53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62725661
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759550857; cv=none; b=L/QsoLCzRLSbISkERlPx2+U2Z+Uerovwqnzx4vOx/NF3yyVqbls0RH8awyGOlbiCNzDy98kq/+hSyy5SuU54OiaVkcadUbFwkQ4ldEX7TbkHKwudvfJVzs2lLl1cXLxv8a1OgGi0Wu/6DnHJqxN1l5l5W87uVTlFyYQiiSZSEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759550857; c=relaxed/simple;
	bh=HYJNFwgeKdoDfqPB7ktfqmxusFy0EZVeLUF1A0YhbNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ixfu54bu4xDpZHywjTFiP+/h2zo6zZfrphOQL9UObw19XzEG6gUTs0nQL3E+RDhvq6mhUagvvBxkU1X+gURKweRjAnrxfwX7jSr/3WllND0VlmHz0745ODRM2h2KQImfjUgUQoHBLnCsuWzIX9sW5gXlVYBx9aPTAf0rLL4Cric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6HSXS53; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5579235200so2098341a12.3
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759550855; x=1760155655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ab/aeZgm1Ct/wesU1VWgrWdl3a/KDYSwn/hRS2/Blo=;
        b=H6HSXS53IoPzW8+shNBj13uSKueIpDhB1Kq34u9oTnTGAUb68dKT/dxzfinH7atwKo
         YaKchYTCAUPHJR+I3/ZWj7taPiDW/dz6AIyGEV/nFBzXUXvmiqdTaMh4jCgoFiB+SMUg
         oNfLY+9mPiYlOcVgsVnrRZJ9hQTFALFZQvrurc9Y2y/QpZQylxFwDilRN1B6UMt+54Bh
         r8MSTJro0+9Vp1ME3GrZmYM2vDu+bxOH99/A8VuB8HfbkVH5O/3HTBfRz/1VgmaVtdRT
         uR/c+JmXdbP6KgfvGjB72wmCrRId+u5vvPmBZDiufaw41zHgTQJkG+m4uSWz8sd20Vgx
         Y1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759550855; x=1760155655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ab/aeZgm1Ct/wesU1VWgrWdl3a/KDYSwn/hRS2/Blo=;
        b=hR98CwEKnSQGfli9QXZAiTTzgNN2I+Ri9e085mCmbbey0fFfUl4/mjtOBgvE1mCI+2
         n/sdBxsv9aYSuluCrdPcy2apZpHXuYFBz//hwvdSLi/crF4mb/sAEuc61sKQwx8eIycb
         JGqNjYlyRC/NUjExgDgY6BorjcyrSrhT9NJxBR5dgXD6qCehFRpyyEEICQDN8axnP3C3
         uKQbaFNGF/vzsaKcRS+MdXNgWg3sai2CDPy4qnnAPoA4izjnQcgvhP/+EcwZIE8Qs5ku
         p1n3fxsWZMs19YWnytcONKLT/iqgQp08+jQ5jNyin/bL8NZNa6RuGCx7ZfnxLxn1YX/G
         ftyw==
X-Forwarded-Encrypted: i=1; AJvYcCWv6n+Fud8FOWotACCwBGE9VaE2H6jmQCF9wURK5Xk4rg15vM2I/7mPwWFP1WC5lkr7XZ3Kdc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhgukC5pDhL3dw2HFEoTUJP9hfEwwv1214GPP0XHUvLgERrnTc
	HyVcSyMUmmR1bvf53xvmXPUFq4ymtvQdlIRqBDH2FhM6MfQSGfqfOaTb
X-Gm-Gg: ASbGncsffIFfltNbVbhNpnT44+ddpvLg6tH69gyaZeq9RrSrBNU6daXWvGybFSISTQX
	tiSJqPhbPDp6VAJCd+foT+oWTVDlKLFTfi3xwpaawMgKCaWMa3qSS/29GsKr5d6HynqDg3bbSkv
	2wfZcIfdzc/Gt7Vs4P/8LRvLFEUTQopCWkBUDbX+AU8zseoPe7t1U99a/SKyJ1WycBUvm5Yfgks
	doxGcmktKWDigrzoTd1/9IZnjRaM2BiiLgm8cPqchbiwN2dvCuEcWQ9Xh85Xmqs4lEHWYmtIU9s
	6e56dMYVz9pGmTqatDXY+DytzTqN6TRJxEilGJGYef6e2g6oJ7ul3ejugjlqvITLBcZCQ66LNjO
	QfzbsYr/w6wMI/APCsX7HFvx0jlp2NlOi1ljaM5b1mL12BSIOs/Ff5l2u9uZaOb9z1OPdCIs/wd
	w=
X-Google-Smtp-Source: AGHT+IGTlstly6wpNIIUzXdJcqg26KC4+gE2hmAVdLheWI6xhK/cVtI6EOnrc7NPCTVjju8lAhEuEg==
X-Received: by 2002:a17:903:acd:b0:27b:defc:802d with SMTP id d9443c01a7336-28e9a5f7158mr78158925ad.28.1759550854915;
        Fri, 03 Oct 2025 21:07:34 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.90.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a4f15857sm5876142a91.1.2025.10.03.21.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 21:07:34 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: lan78xx: Fix lost EEPROM write timeout error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
Date: Sat,  4 Oct 2025 09:37:22 +0530
Message-Id: <20251004040722.82882-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function lan78xx_write_raw_eeprom failed to properly propagate EEPROM
write timeout errors (-ETIMEDOUT). In the timeout  fallthrough path, it first
attempted to restore the pin configuration for LED outputs and then
returned only the status of that restore operation, discarding the
original timeout error saved in ret.

As a result, callers could mistakenly treat EEPROM write operation as
successful even though the EEPROM write had actually timed out with no
or partial data write.

To fix this, handle errors in restoring the LED pin configuration separately.
If the restore succeeds, return any prior EEPROM write timeout error saved
in ret to the caller.

Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM and OTP operations")
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note:
 The patch is compiled and tested.
 The patch was suggested by Oleksij Rempel while reviewing a fix to a bug
 found by syzbot earlier.
 The review mail chain where this fix was suggested is given below.
 https://lore.kernel.org/all/aNzojoXK-m1Tn6Lc@pengutronix.de/

 drivers/net/usb/lan78xx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d75502ebbc0d..5ccbe6ae2ebe 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1174,10 +1174,13 @@ static int lan78xx_write_raw_eeprom(struct lan78xx_net *dev, u32 offset,
 	}
 
 write_raw_eeprom_done:
-	if (dev->chipid == ID_REV_CHIP_ID_7800_)
-		return lan78xx_write_reg(dev, HW_CFG, saved);
-
-	return 0;
+	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
+		/* If USB fails, there is nothing to do */
+		if (rc < 0)
+			return rc;
+	}
+	return ret;
 }
 
 static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
-- 
2.34.1


