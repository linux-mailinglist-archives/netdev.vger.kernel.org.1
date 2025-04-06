Return-Path: <netdev+bounces-179485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD512A7D0F2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0BE16A95F
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41832221F07;
	Sun,  6 Apr 2025 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLBDHSe2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB13433AC;
	Sun,  6 Apr 2025 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977707; cv=none; b=OJ/NSaZYLkWCKyqjP6y/vEitEYUxyxq6W6NHrEs6np19W5qv4Hnw2xkj5bU2fK1xy6u/dXkSu45gIrNrj+DhprRUMZdgolOjXWUpF9FJPWouz1/H5EgofrUx8DG+Mhd9gEkZZ2zf+DX0D5qJyJSSfEZ7nJD2YpDBG0KcOdc7X9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977707; c=relaxed/simple;
	bh=fSMSFG9kDFrHSt4RVbL06Jajh5DKC96E3IHlxO2ncBs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gx3vxJ1nbN68lpqlN1nQDyB8qraE7EtfXl1jeBm6lCgZqXsY6pW+XoS7z4yRTeRlz56pplWnYAEBWIcsmzxgt2Ivjl+i8vsn+IV61wiZ+8En+uVzDG85SsHtzxw8ix/Q35x8vGivJVeu+PTfXIUdUWLNcm8JY2tS7aJczdkhNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLBDHSe2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so37474765e9.3;
        Sun, 06 Apr 2025 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977703; x=1744582503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayn/+ArG131gi18wLCzFlJOt7i4mpT3rXpgfAV6sJtQ=;
        b=DLBDHSe20x3qQs6qc9s4piJHMw0WDogWbH72/kOPfFxY8T1IqGJhesIkIMco/rS/n8
         Boi5+Kp5/6BQJmmA9n74twSn2vM+VJ272EQKuU22GPc+T/j0Mwvu2qBqN4adO+hqSzO6
         ytit1lK5Jg93aNPM2QsZucnzdJRSFC92BoVDLUc/lpYqWohpxGkFuj19OQ2Vdpb3WbO2
         ylERECQQXkNe3cQXCinOMuwO4qwKqeqPITWI2WfpuDFWs7ox4Ap88Nh5rA+s2KJEX3iN
         0QD/dhWukY1bOAhBL0ZjW/nJxRHeS5AE8ldCVUOt2DdB0zrPdh+0SYiah767GKqsigpU
         MDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977703; x=1744582503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayn/+ArG131gi18wLCzFlJOt7i4mpT3rXpgfAV6sJtQ=;
        b=ESqn53QXgROC/8MIJvHpM30vQ8QB6ivUSWlDYBXq2KHSnxzw4CjAV7h31iBCcHrrG0
         0WzNjg/xGtfO5YTZMyZMA2EQZRNBdkmF7dNS3yvSLK0hNSt97OJ512oMNHHhBCmY8qi7
         l/vzlQYE9xH2cU0AHXCMQzQjRS/haQWV6mxEBOs3/2o8wJ0whvn4Z+Pna/+4DPyo+qL7
         uN3m4J+Xh8GUIUNWq84UFm9GBYPIzp86A6LOFUn90fGW+imLwLUMYRgqXBS2xQXlZaxR
         uKiikNNH7S0MHlf4qLX7bbYiKziYpn9/Z5MI3NYWL95DTdvHk6B+E9JNtsyvH3H5H4sd
         hPTA==
X-Forwarded-Encrypted: i=1; AJvYcCU72WAz9rWEPxHIqEmc5x4alGvZPDE+kWW+nKziveMPQpi26I5/Z5JM1jgwja21wcT4VHbFPxwlrADt@vger.kernel.org, AJvYcCUcXsWcIxkIFdy5ix4jQs5FVCv+S7vxQPVdc2U1cls9kuJLWbKPjiBqz7cHbX7R9PMSmJ6j90+nF+cHD2mT@vger.kernel.org, AJvYcCUpfSPgoW+7XVC+nn36w4nq6MUNr/apNevYBeB7aWYoJ90RuIo1puAO/5NT5cRHYSJk1o2YhdXk@vger.kernel.org
X-Gm-Message-State: AOJu0YzhrbeTQzEatkkveJ924H0ewoXDN86XOnKd2Cl0lfrZ1eMsWQUM
	tccYpxC4m8zHsJ3diPbLjlbPzUiwhfApZ0UXQbFFRwlJk+Ckmshv
X-Gm-Gg: ASbGncv3WeVeAFfX0lsXt4PECVLqi9P8+Yb8XElFgj74spdUxar/AcVguMJqQJ/uuie
	nz8rb/X5JJOOwdk8/L3DFGHo9lPhjLQ77jPrvnkqIMQevFYHeLN5TB20dDhxxVBhxiiW484JfBu
	8NeNDM5MnWLYQw3M9xTR7xOsoDCOwM8vbT+YV7KQ8/2McK8vz+yOzyCWzsEvGV+HlbarPrjfi4Y
	mWhJAaOpXdCrijV6OVE/DDWYTfEJgrR26U522gpnna/HgvudIMeAOiO+DS5KdGpYwVy/2e2QZkY
	6I94kRNU6ImQS29x74PYny4kRyBLevkwBud7FPmZ7mVolAavRMBDgcO77SGTOqp3uf7sz2BDGVo
	Czx5Uk/a4IvKJiQ==
X-Google-Smtp-Source: AGHT+IENfMJTLXOWwcQUAP+VYmlM77Qj1I7980ItCU7kcoUNHVy1gAOdc18HDYP2esin/LYBB6Ur7g==
X-Received: by 2002:a05:600c:1c07:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-43ecf84287dmr98127335e9.4.1743977703199;
        Sun, 06 Apr 2025 15:15:03 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:02 -0700 (PDT)
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 03/11] net: phy: introduce phy_interface_copy helper
Date: Mon,  7 Apr 2025 00:13:56 +0200
Message-ID: <20250406221423.9723-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
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
index a2bfae80c449..65c520e556aa 100644
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


