Return-Path: <netdev+bounces-163352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89330A29FA8
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6228E1888220
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9444418C03F;
	Thu,  6 Feb 2025 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR8I47Pl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D318BBB9;
	Thu,  6 Feb 2025 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816296; cv=none; b=kkRfr3X/ZB/FHCIC/BOaMOcRgqxQ4a7OHK+LD73qUjHiJxrV49O2x0WtY8vFpHpv/U+1Fs0YybwMdpLBFfP7k1dFn79LXXq8ADNAyeRwXS55P85JJ8SAWVR2gXXM20udyCiZG0kbPIWor9V7F4jWGW5Q3kF3p3SKIoJBLa/BVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816296; c=relaxed/simple;
	bh=GwiQox4X1/Qh/TsPzO4xW5aZruZo+Lu3RYka/ChKLKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M++BoeDV6ty26wb0Por8vAoFJ7ND2Y6JFykFvONMVPg3ujWYTpLLAiTBnSc8w/m5YOYnj1DQvjRHUTUC4znYMzKPqrNMAay6Um2hxHb7xKSIBPJ1z6f9ieS+LwjXcaZWzOilXdYJeYUSBDT5VzGa8FiIHw2yzp0X39oxF7Ra9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR8I47Pl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9d17ac130so589972a91.3;
        Wed, 05 Feb 2025 20:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738816294; x=1739421094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iia6e3VwJ3mqPG8y4gzge3wzg5w4QmfPYSP+uThGj0=;
        b=HR8I47Pli9BtB6bS9Z9NmRb8gt7LCiTHdvzFW3L+EnD6KeRDVHTV6uoBZgGom+V6j2
         lRLN6jzpSLdVGoBm/Mj1LfZhFeHX9W626TGDLS4cew8aaQFCv4Fda9azxLhtlPBR8kR0
         buFeYR4kQDNLgkyyR9AjKBQI+gDQhcVzYCeqSvfvDSIBqkaHoVdim0/3eVXOBMaB485I
         MuZaMD1t0KlYiYh8IIr6NZ7MlV466P/LSHNPLGBswFNl/OuB2vy/WHYkXibi+x/p0SsK
         ogwALu5X65ftVBua72eAUj4KKNkTICm82g8tpe3BIH3tVzGaIIOL4mDYCZeEglVWsXef
         6++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738816294; x=1739421094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iia6e3VwJ3mqPG8y4gzge3wzg5w4QmfPYSP+uThGj0=;
        b=TTY16pgBYYoCcVqsmhUJcM97sAueVMvQtl73tAviH0HZYZ1pxBzknISkKZfH2U5pY6
         WOZr9FRghSWccjJrHyEdGBgU2jaafWmvooyYKUjfEZUNdUeK2csAS8oxY/Ba6vt5fmXE
         A1QUNj9JD09CadejmTRN2NGZztlfa/RTxhesSn3AzQT6FJehQSdeu86Mko/ggjK2RqWT
         ZNlqVJUSvPBH9ddHQovRb6OtfvOKOg4R7cX2NiZipyn0zsDD4ieDxITKjgj+PkPsbpD2
         jpoogOK0tcZLH5chaBe8HaUIi46mmjqv8sk/E7vLYS2XVePai1NyxMamqqxnHgrqIk5R
         FvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ohy6ZuS8NgIkqGIdxz5zQMtIF3RGrrHzPCTilhQtp4IObSBRheaH2I078x4OqSYMOubdWHiseGQWwG4=@vger.kernel.org, AJvYcCWok51m0/mIygztogtzttOs6ewDml3Kx4q2m2I7zZl1gK6a6/EUPlKtxvzTZM7S4Gc6Hqu0SC9r@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5d7dG6837qE1exC2oCHUFvRcNHFQYXZVZ+XMjxm2kxhE+Z/8n
	VL6IKTm81TUK0CqtXzsFpKTdS2cbWp9fp0Uham4/Ig8rOYRXUtw13RqJoQ==
X-Gm-Gg: ASbGncuZGVDqUH3wo+9xqjhfJabDGMPjTX4zrIy9O+flhKXX5ITa9Y/7vLphc7Bq5tM
	noyjIWpfVTdwtkNTB2eyh5j0Pinezeb9wStgJbwC56eYhZ8st0KKEMB51mxG5lBTppb9CDxSGq0
	JBgOPugSXxzskKLxaImqRleAN63ya0yaD565iVFWX07Xp2SCytW96GadEx7Xlt/g5GZVO5pWZJF
	s+n9WJxFF50EiHVb3MI3WLYn6lBZzC+p6T+eTtv761Djlxqk9u64W4IwitxCCn9YcO/SNlmQSnK
	0nq+biuY44QXXwlKmCoepKnrRGBA6KPHecg=
X-Google-Smtp-Source: AGHT+IEQQWXdGY3dj26CTU+BJ/b+rl48jApZed7wrVj+Yx28wDTuhlJAtBX6E0cVOIvlSscWCeVQwA==
X-Received: by 2002:a05:6a00:28cc:b0:725:f1b1:cbc5 with SMTP id d2e1a72fcca58-730350f96demr11011802b3a.3.1738816294110;
        Wed, 05 Feb 2025 20:31:34 -0800 (PST)
Received: from localhost.localdomain ([205.250.172.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c162f6sm305013b3a.143.2025.02.05.20.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:31:33 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] net: dsa: b53: Add phy_enable(), phy_disable() methods
Date: Wed,  5 Feb 2025 20:30:47 -0800
Message-ID: <20250206043055.177004-4-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206043055.177004-1-kylehendrydev@gmail.com>
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add phy enable/disable to b53 ops to be called when
enabling/disabling ports.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 6 ++++++
 drivers/net/dsa/b53/b53_priv.h   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 06739aea328d..e5b0cc3428e5 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -592,6 +592,9 @@ int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 	b53_port_set_mcast_flood(dev, port, true);
 	b53_port_set_learning(dev, port, false);
 
+	if (dev->ops->phy_enable)
+		dev->ops->phy_enable(dev, port);
+
 	if (dev->ops->irq_enable)
 		ret = dev->ops->irq_enable(dev, port);
 	if (ret)
@@ -630,6 +633,9 @@ void b53_disable_port(struct dsa_switch *ds, int port)
 	reg |= PORT_CTRL_RX_DISABLE | PORT_CTRL_TX_DISABLE;
 	b53_write8(dev, B53_CTRL_PAGE, B53_PORT_CTRL(port), reg);
 
+	if (dev->ops->phy_disable)
+		dev->ops->phy_disable(dev, port);
+
 	if (dev->ops->irq_disable)
 		dev->ops->irq_disable(dev, port);
 }
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index cd565efbdec2..6ffc36c1b2c3 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -45,6 +45,8 @@ struct b53_io_ops {
 	int (*phy_write16)(struct b53_device *dev, int addr, int reg, u16 value);
 	int (*irq_enable)(struct b53_device *dev, int port);
 	void (*irq_disable)(struct b53_device *dev, int port);
+	void (*phy_enable)(struct b53_device *dev, int port);
+	void (*phy_disable)(struct b53_device *dev, int port);
 	void (*phylink_get_caps)(struct b53_device *dev, int port,
 				 struct phylink_config *config);
 	struct phylink_pcs *(*phylink_mac_select_pcs)(struct b53_device *dev,
-- 
2.43.0


