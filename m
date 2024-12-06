Return-Path: <netdev+bounces-149722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051819E6EF1
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E4C2837D2
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436A20125F;
	Fri,  6 Dec 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Talq+X/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB02066D3
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490577; cv=none; b=RLNJfHRuBUhXgEaXPuetNV78wPnqGWWOqMkP/VXkMF0BsTm/HdPeH229z6zk7D1m3HsNgc6feexbxqk3ZXiiej0JgAo0T31zuQR6rHAC3+aHE78EOyhz7dvAc+cxN/hB7T9hfZW42B0k/Y+ZeP4Ho9WP0H1Q+GISsNZoVg15aVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490577; c=relaxed/simple;
	bh=h+fgQE8in1Q9NX40RDMwFhexgxmgR20HwxdJFcEWLE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocsiu6LnbTR6gTWXy9FOH0vMRUUfOWcZk3OrG2HA1ceuzBOPnrior/xJ6SkGgohvvYbnp+zvlToeue+08+fgbbIa6794zrykW2wa3Tk9aWLa+nRTPX8dpH+gDdmucQrRgryKgDMU/I52/M3wiMcbVmy/YUw00OzGlHp9wL4SRik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=Talq+X/1; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3001e7d41c5so17491801fa.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1733490573; x=1734095373; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uywvjrRr4496fWAxs86Ct9V1Zr/3jwlm43LpL8nmkrM=;
        b=Talq+X/1kH+zlHG3EtU8/OvhhiHFz8sOrrOeMEl+OfOGvMER8j+LTpp8IPneOiaClv
         Pw6n/79fLfq2lQqB3W2aNvISVXMWePwyqGdHZwy0cpL+Vuk9WdsgkJwNl9oCQ3IBYekU
         +GoLEW7h94dHNpGl7m0azZih2SIDlK2HrTejdxs3ieKEVsXNiAPqAJW/658OHjIMjIKR
         VDKWLrSdUqRR96pfgobVeEWMaAphIGHzTfKKIjYnBCHbGYpOs4uQmOrJHMrBzK5ZF3HE
         epEluWX7hAjqBB7VWlO77hKWu8whjC1zByQCWsglc/sBjxPxh8LE3QY7ksUU8qvTfoyR
         8gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490573; x=1734095373;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uywvjrRr4496fWAxs86Ct9V1Zr/3jwlm43LpL8nmkrM=;
        b=LW0b/Hbc+39/T1yYNVz73ulNAYXq4z2vZKSOnwQi0POYqU+OGrRKhXggHI2bKKlP72
         AwrzGBHvvk/7x29tB0E11pDwMAgiXZiSjfp/FSgE9QcW3RDyMcJKw2jjA3WjAoDNX8fk
         jSpqHLWhvB84JXNnl7Zga1HvtX1sxKFnWNTD//7E0OUZEp8/jUXJGxz3v1wCX8LqMbSS
         aa7OOhN55podfE2vYWCGhSD6utON9H/H9xT4rZWMjmuNTw6h0+i6gVUTABLx5waykTx+
         NpmxHTy/sVa/NF49sy9ETdJ4T+rEUIwHvyLsyxjxb4kHUVbfxvvIUiFnmotkUJJdtvvP
         wWMg==
X-Forwarded-Encrypted: i=1; AJvYcCWz+6GGkmpFEOeqbDZ7oYFEMYGqZ7u4BHS6x0Bxmwy5aNNga14xTsf22+Fj2I/3Amt9JtUKewc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMCjpYB+M88LHVrDbFtTUuU8/Mfdk49d2/1fe8jLfGPdOWW5u
	tSRNGqPJxExoiPI4CTEhKRv0KRS7aV971AreuGiQU4lbK5nTsr6OuuMVg2WxqTA=
X-Gm-Gg: ASbGncu8m9GRKqkSaAEnG6ldH4B3O8A2sdmcEmfHANl9H9a7Xv6WI+GJLWRDI6EMOKK
	11MPUH0xBUdv6zOsChI64s1sKl74tkBdLoMOhSeG1OvfU1IbvVdd3PSOfCGF1t8wTPTFHj+06Da
	K7smNFpaTBs/C7cu+5h+MdoWy1zAXSZ7LdngZjHeiZ0JowTCOcdCGkWE5vt6Wvw54fHd5bVCdRK
	Dco+FiqgnxZ+FmPT8LFCEFTixbVInrUaPVcSU3CgTWWoXrLilC/Ub4+Cc2O0zxPTZ/CfUT21lYK
	YLjyb+VXpg==
X-Google-Smtp-Source: AGHT+IFxzaRaatit4+1xzVYeAPynXNgLfxVZSO+2pOa5ouHw7V+nECCFiDYHeWGa/2B2PlaewlthuA==
X-Received: by 2002:a2e:a547:0:b0:2ff:bb68:4233 with SMTP id 38308e7fff4ca-3002fd92374mr10110781fa.33.1733490573182;
        Fri, 06 Dec 2024 05:09:33 -0800 (PST)
Received: from wkz-x13.. (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e21704sm4527401fa.90.2024.12.06.05.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:09:31 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz
Subject: [PATCH net 1/4] net: dsa: mv88e6xxx: Improve I/O related error logging
Date: Fri,  6 Dec 2024 14:07:33 +0100
Message-ID: <20241206130824.3784213-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206130824.3784213-1-tobias@waldekranz.com>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

In the rare event of an I/O error - e.g. a broken bus controller,
frozen chip, etc. - make sure to log all available information, so
that there is some hope of determining _where_ the error; not just
_that_ an error occurred.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 57 +++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3a792f79270d..16fc9a21dc59 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -59,8 +59,11 @@ int mv88e6xxx_read(struct mv88e6xxx_chip *chip, int addr, int reg, u16 *val)
 	assert_reg_lock(chip);
 
 	err = mv88e6xxx_smi_read(chip, addr, reg, val);
-	if (err)
+	if (err) {
+		dev_err_ratelimited(chip->dev, "Failed to read from 0x%02x/0x%02x: %d",
+				    addr, reg, err);
 		return err;
+	}
 
 	dev_dbg(chip->dev, "<- addr: 0x%.2x reg: 0x%.2x val: 0x%.4x\n",
 		addr, reg, *val);
@@ -75,17 +78,19 @@ int mv88e6xxx_write(struct mv88e6xxx_chip *chip, int addr, int reg, u16 val)
 	assert_reg_lock(chip);
 
 	err = mv88e6xxx_smi_write(chip, addr, reg, val);
-	if (err)
+	if (err) {
+		dev_err_ratelimited(chip->dev, "Failed to write 0x%04x to 0x%02x/0x%02x: %d",
+				    val, addr, reg, err);
 		return err;
-
+	}
 	dev_dbg(chip->dev, "-> addr: 0x%.2x reg: 0x%.2x val: 0x%.4x\n",
 		addr, reg, val);
 
 	return 0;
 }
 
-int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
-			u16 mask, u16 val)
+static int _mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
+				u16 mask, u16 val, u16 *last)
 {
 	const unsigned long timeout = jiffies + msecs_to_jiffies(50);
 	u16 data;
@@ -117,15 +122,51 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 	if ((data & mask) == val)
 		return 0;
 
-	dev_err(chip->dev, "Timeout while waiting for switch\n");
+	if (last)
+		*last = data;
+
 	return -ETIMEDOUT;
 }
 
+int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
+			u16 mask, u16 val)
+{
+	u16 last;
+	int err;
+
+	err = _mv88e6xxx_wait_mask(chip, addr, reg, mask, val, &last);
+	if (!err)
+		return 0;
+
+	dev_err(chip->dev,
+		"%s waiting for 0x%02x/0x%02x to match 0x%04x (mask:0x%04x last:0x%04x)\n",
+		(err == -ETIMEDOUT) ? "Timed out" : "Failed",
+		addr, reg, val, mask, last);
+	return err;
+}
+
+static int _mv88e6xxx_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
+			       int bit, int val, u16 *last)
+{
+	return _mv88e6xxx_wait_mask(chip, addr, reg, BIT(bit),
+				   val ? BIT(bit) : 0x0000, last);
+}
+
 int mv88e6xxx_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
 		       int bit, int val)
 {
-	return mv88e6xxx_wait_mask(chip, addr, reg, BIT(bit),
-				   val ? BIT(bit) : 0x0000);
+	u16 last;
+	int err;
+
+	err = _mv88e6xxx_wait_bit(chip, addr, reg, bit, val, &last);
+	if (!err)
+		return 0;
+
+	dev_err(chip->dev,
+		"%s waiting for bit %d in 0x%02x/0x%02x to %s (last:0x%04x)\n",
+		(err == -ETIMEDOUT) ? "Timed out" : "Failed",
+		bit, addr, reg, val ? "set" : "clear", last);
+	return err;
 }
 
 struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
-- 
2.43.0


