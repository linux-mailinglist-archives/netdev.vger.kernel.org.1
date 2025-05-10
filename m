Return-Path: <netdev+bounces-189454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747F2AB2357
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3DE4C520E
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F852367DC;
	Sat, 10 May 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdhxTN2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C5221DA0;
	Sat, 10 May 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872672; cv=none; b=F9lSwDko0riRVyNDWxVCunNMWRgWW32oy6yAgNnKrxzPzZGAS7qrk/kjWD61Qxn8CFKQBkUAB/1cgsl3Ff3A/GFYQKqlRwxhcTw5Buwu39+BAC9Ab3ZAMVl/lYOIllEXvy39/rUP6oGsa0ZVDPFaqdGTgYWiXcvkdRcRB5ytfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872672; c=relaxed/simple;
	bh=RqTCHmbF245kSlH2k5rQcAnN0ey4gGVyGdxrK0XkQNs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOqa0cCDp3owGP1oTAyYCzBtaVCmqlq460OkoQxiKxXZEYYGczTiTP+pV3mneo8Zo+VVbKYD20hLRXuXY4oAVKS9HyZQ2Sy294/UqGbIgCZDp4OL9jU7EhCU++HSgd2x5NX5tCes+R9bc5OhR5TAWX94SfBUKBWpWAByBxYJXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdhxTN2H; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441ab63a415so27076635e9.3;
        Sat, 10 May 2025 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872668; x=1747477468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oE1Ex4iGsssyaIBLKiOZrSIgezQkyez+G/tcna3LlvY=;
        b=EdhxTN2H8E6g2t1N0REAZpqMgR0qN0d1EhmEIn40Mh6S9Z7QwQ7Hh6VD5x1tbqIDQZ
         OmcTQTGLP69ha6VFvDEe2YaEnabsd9oUXL0xBeAZqIvVSfyFzwO37K7LxyyyIn8bLSdo
         T4ju2WTlp7pCrn1wKEJNlSe3WwSE1nXo2DlQFnyqNpb/6xzXT6M9+ILIAsxH+KQ4wHvk
         qwQ8k4ltYdaJZMysRIa9nplmwuTrirRLcwUxhb1lmTfOe1MBEloEgDRLaq2//HgdS6BH
         o/vPPOWFiTUaUcUCxdJ4oiAhJRkEnNuuanJqQZ3zTS5nraZ7py0qfGsjFkrWYT/11CfZ
         sLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872668; x=1747477468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE1Ex4iGsssyaIBLKiOZrSIgezQkyez+G/tcna3LlvY=;
        b=DCvRDk9nkegd/vaF4QL9LnNkt2M7tMoklfMJh/LZyYnaBAPzpqnT41TlY0THrS5ak5
         VBub/Gcc3uVwi+7HW9jb8j14ZbSruwlnBfIqTDwI8ExvQsn20kmZ1OskRC1idlB3o2zD
         TjwJ9Jgh4g4fH3mbpcUEc7SJiVRz2HR7z2ESW8cgpfreADpNMHoycIrh6LqJ2XVJrYh9
         aYBCer+iOv1bjDZ0WdroVwWCwdluzIKwEg09FTvVKC5qSFWr5akHOqc8S39/m2F/pTzt
         niYE/naa/DLXi3I4hDYUSmoHGiZfPp69wQaDcUkLJ2T6+b3Sg5G1TFp82McgHgYNHw5I
         pMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL/tGAiBrX3G5OOD8KB/+emJ7hqEBf5ccsQvNma4JaG8dNRn3p9Ze88VtyPOnvGAnbodDYGEldgwT3uiAr@vger.kernel.org, AJvYcCUdQ2MyKU9ZFxFDPssUzy5ZY7Dw8Oo8vOFwA1Kj31xCA9RmMAjXhqZOnJY+XpUGIgcK/02RGVrRc93a@vger.kernel.org, AJvYcCXGDBm623OKTJq7u46W+M3JGgN3Ww/k3Y7nZ9xEY+U75aNOpOj94VYvzL/U+IDpsHOcq4MEJcxQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxvcgXIxCSViakA2Kq+FM55c9W+GogmXq85OruAcayJ5XCUA5yp
	ewpTTyyVCNNAVdqfBqwbk5Dof3La0cF+JZqdomIxhaMjKUltdH/S
X-Gm-Gg: ASbGncs6BzIFn2uoDiMZJ0fiTGdVwg73WgUFoAWHry9ZevaVSCGtwOwcxGfU/28Ph8Y
	DR0un4uRcF24Omy2qb4o9wg4F3mryQ59PlpucI9VagHoUeypgdFqgunw4CgA/Haehw8+DloyaLY
	or4ZNE0/l+RCfA4CvZsSR6wxDAtQOZ0DHpHUopw1jQAcJldHTfzILLa4YZZJ/LzAhoAO6QQd9hG
	9S30PPz9FY8MBvC/GCmO3ozeaEuBCAlpl48OhXdA4N0+y25OTE8wOxji+nhpBhD07TWXanhge8r
	vqpREVukaEvbuL7K568U6LEe/mczArAvR4TsmapaT7Ne/XAoQa495DyCX974cPG+3pYmgu8prMX
	taZcR5tTHGxSyqAhgqO6/bmGBBEhWr2M=
X-Google-Smtp-Source: AGHT+IFj2rbQdHTQ/nd9uAjG0V1vqgaY6+WktosXYyiS+kWJo0c0aXetW+yPBLrq9z7YfQOtUlYQTA==
X-Received: by 2002:a05:600c:6612:b0:442:e147:bea6 with SMTP id 5b1f17b1804b1-442e17571f9mr7712275e9.11.1746872668065;
        Sat, 10 May 2025 03:24:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm57981265e9.13.2025.05.10.03.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:24:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v3 02/11] net: phy: introduce phy_interface_copy helper
Date: Sat, 10 May 2025 12:23:22 +0200
Message-ID: <20250510102348.14134-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510102348.14134-1-ansuelsmth@gmail.com>
References: <20250510102348.14134-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce phy_interface_copy helper as a shorthand to copy the PHY
interface bitmap to a different location.

This is useful if a PHY interface bitmap needs to be stored in a
different variable and needs to be reset to an original value saved in a
different bitmap.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/phy.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index d62d292024bc..9f0e5fb30d63 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -173,6 +173,11 @@ static inline void phy_interface_or(unsigned long *dst, const unsigned long *a,
 	bitmap_or(dst, a, b, PHY_INTERFACE_MODE_MAX);
 }
 
+static inline void phy_interface_copy(unsigned long *dst, const unsigned long *src)
+{
+	bitmap_copy(dst, src, PHY_INTERFACE_MODE_MAX);
+}
+
 static inline void phy_interface_set_rgmii(unsigned long *intf)
 {
 	__set_bit(PHY_INTERFACE_MODE_RGMII, intf);
-- 
2.48.1


