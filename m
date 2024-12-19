Return-Path: <netdev+bounces-153347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9E69F7B6E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287AC16EFE0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08CE227563;
	Thu, 19 Dec 2024 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="gNSPhuj3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF2224AE8
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611494; cv=none; b=Ni89L5fWYwufs1FNF6XUMIBkvOPrxJHD8yH0M/xpDCGbKXRruImE6Ru64c2PyncahjkCJEkuhvVi/I5o84RQVJWFuDB6N9SOBU+sBEYlJjUI7Rv5GOKWENzlKbIebsuBoHkIRiReaKXqi7zJtHEmIm2uY0rRn4uwGzmAPYxBHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611494; c=relaxed/simple;
	bh=08hazq2tpp5U1ZBYQbPHctBIvGpIFHZdk7LpzexFtnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEWu8Y5smBYcFrwdT92pQESrYQATR27yAkXnlvR1XgUoRwuHQP8+y5qbsfJhH3DVt4vu4FVlByTITQ5MNvuhtC5AkxtDD0j5guItfJ4/dbwHqO6tAxtIzKKlbyL2f2AwhDeD2dgThTMNRbBREjdVRz6oYe2PFByD96XN8MLvdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=gNSPhuj3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso1962037e87.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 04:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1734611491; x=1735216291; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1BB3Jy8S65eVmx6HaPAgKajQmaTeuZOvuBP1iY2h06s=;
        b=gNSPhuj3Gf+/fiV/HE2SI4PBs+ReinKNnsr2vQMYbUOq7lcyfdNVhvlrK7EkKx8Oyv
         5QBpnP9qtQaz7+zdaYzUIPYaiflnlgKScxSx7+wc2Dq55CXm9ZDV8ztHgstfdkLJvA9x
         iIG9zHSRoaDWTlZOmDdxQ4vkte1ITLPSleBK+N04OS6Ke55iFO4+NCAtp3hpVb5ngwVH
         uDrdawGFEZ+3tCxZwaMTQY1vD2/p2fVBiEqqKcDhd2Iel62KAQZk5iA3nv74vvJWENh2
         8M1j4fGqHvnEZwFowaDO6UN9aawVNkHgekf9aB3kbXfTwtcvPUiyz6PUi6SR5LV33tgN
         BWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611491; x=1735216291;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BB3Jy8S65eVmx6HaPAgKajQmaTeuZOvuBP1iY2h06s=;
        b=OFDhIGY6TX/+HqMUW/SBo53IQZJpSH3wT66Xrry7LN+39Zk8dzh+vUGTzdBHI+4vEZ
         T7ZOAMdMeBItwHJd3C3P4o8pUbsh0wdWmy3nzwN1QpNh6pmwqaDna5lfPjY/xq40y5md
         4ZiH47AfWZDrG0Zm8R6reCpqSD4ZMK9jY2xKO6cNlfPe0YomxFqCRQisAvobX0H8f4Gu
         VbnH3qwFBIFpdRRQMolujXEsyqknLGKLpCPrsaks0JRRgm9zscFXI9x1eHjfodfosLaH
         dUqLvldwlfv8K7moFHrducTtb2YVFwSf666dBQNANMgS19W3Djc//a/fMU7NDfIg0rv+
         lteg==
X-Forwarded-Encrypted: i=1; AJvYcCUyTZsQECttwKOQ3ZRGWeVTQxOzIP7iquWRJGcY+HJY37D2Zq3cNu/x+5ucDdZK4sweefpGnIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2qs6z1+Nr7Tm8coqUjMlkrgDht3Jq3CkI+caMnKN5EIMMtUDG
	SEWHPyFBZ4DeWSzYuKxWxQ+OfjMrEUq1bj4r7Uw5a36G000bJq70hu2QydA6sNk=
X-Gm-Gg: ASbGncsBxe+jNvJradPn4X7qNhKPSBrA97X1wkGHKPqIdkxhYo22n+IYYUZUXHacGC2
	9V4Orb5BSFJbVHRJxNn9OwLTBImqLg5VVWXmh9ZGKEukCWJuFiyc/zCbmi28nocMj4vjZ5FQIGW
	g8vv4vN1v5a15DFwmoRTuNYC5nIvfmVUiVmNX9ZV8NZHbTskrvyl7i+U8WLefUh8wRBUQ8eA+BA
	ZlHu8QcKTL884px0nGRg4f+zjej6h0uwSpIcZ4Lmip/YUHEapK1dPT4yLSNqP+ByPMnKjH9xyrW
	ankxxotb8eSBsq7O6YvGKgVI
X-Google-Smtp-Source: AGHT+IEJ9N+SaqyKs1sSAdUKEe5QT1FGY01op6yGqZUMOPhz0rCxgx3kCBze2v45tIfZMPku++2QjQ==
X-Received: by 2002:ac2:5681:0:b0:53e:2098:861d with SMTP id 2adb3069b0e04-542212f0034mr1037525e87.15.1734611490934;
        Thu, 19 Dec 2024 04:31:30 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223b28722sm145975e87.243.2024.12.19.04.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 04:31:29 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz,
	pabeni@redhat.com
Subject: [PATCH v2 net 1/4] net: dsa: mv88e6xxx: Improve I/O related error logging
Date: Thu, 19 Dec 2024 13:30:40 +0100
Message-ID: <20241219123106.730032-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219123106.730032-1-tobias@waldekranz.com>
References: <20241219123106.730032-1-tobias@waldekranz.com>
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
 drivers/net/dsa/mv88e6xxx/chip.c | 51 +++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3a792f79270d..46926b769460 100644
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
@@ -117,15 +122,45 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
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
 int mv88e6xxx_wait_bit(struct mv88e6xxx_chip *chip, int addr, int reg,
 		       int bit, int val)
 {
-	return mv88e6xxx_wait_mask(chip, addr, reg, BIT(bit),
-				   val ? BIT(bit) : 0x0000);
+	u16 last;
+	int err;
+
+	err = _mv88e6xxx_wait_mask(chip, addr, reg, BIT(bit),
+				   val ? BIT(bit) : 0x0000, &last);
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


