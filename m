Return-Path: <netdev+bounces-194512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1DEAC9C56
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 20:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EED31897BAD
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4CD19ADA4;
	Sat, 31 May 2025 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItXGS7Jl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14D2907;
	Sat, 31 May 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748716790; cv=none; b=W0YhdV5NgnOHVsXymbatx2wI0lhQ+AZZlqVwQiHNK0bzEd3oQVdNiNUxwLqwOQ9dTW96mN9tv3WYqhQD7YA0xUaWZwF6H0BXYbxaYcIVLEnkqva2VkVzX07n9xVnZW4YLoY5X/PImIddX7dMmSsx2lPvzKlVAcWRhuBn+yepRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748716790; c=relaxed/simple;
	bh=Z0X3dkbi6i5QAVOlVqqrBxcAPTBMpyvnuFVn1uESlsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ghagj8jZaCP2PwMXO4FHysF4L+idMP6FzGDVodhmvnhvOMxrfFmX91rB/AzXbk9KLwyYJo+j8r/ilP05ZHbdXneWLaI0kl4C+oT4MMr6Us9WozxcOCKiUQcNlcTtr4rATr9E6oyhNVtjruFiCazMhvTyyV2vn1wSHTh0QlbOi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItXGS7Jl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742b614581dso3025219b3a.3;
        Sat, 31 May 2025 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748716788; x=1749321588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=miy0lPi7xpBuWPPyHcsZgwlJ38UR4yPj0w/sOFOrXfM=;
        b=ItXGS7JlZnh5qOuBHOoD4GpTpyC+bs8VpWoNpCWUQXdlkn/agp+ljx+uFSa9JmDGCB
         vCDqHGiTAsZ+8AGxjubgePmCO5dKJGcoM7kqSgaktqBcDze94o/GfHhhbb+wy/uSkeDM
         StQnFzbqrpYkpF7Q+ELBgesBZJEZ/h0zHv3vQYZ2JNH6SCMzko34ndT1rUho3GQz9U9X
         /11p+DJn5Lfiap/5kKGkzKvEI8zY5IlGkGY2g167H0B2KUkq1YygLV3BatkoDmogayJM
         i/7pu47ZeMKVlzFdh1xNfKJeBH9HgibYhRldndWITgKpP67jlVkSSFVi2pdOyh7LKfNx
         SvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748716788; x=1749321588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miy0lPi7xpBuWPPyHcsZgwlJ38UR4yPj0w/sOFOrXfM=;
        b=A5FhirB4QVV2XpqcLifSe9vjU6avIWPdBteUvNIiaUE7hHxDeTt+94bMqh9coozebS
         e3arsdX8zV3xQrH+6SAXa2YvakX+qsZ2kpfiYKMaEcPPnXc4gZCmDPNSmJ+eOVPauYth
         /mK0J3gX1oW9lvzV9hXYNFjnHD3SKIlo15fxw38zSonbKmZrhxCOt/NBbKRRKEjjS6gE
         cRZENwrJAbRhpOwh+HZhb3IXcJLMJp6VccArbcD3OS4/ldL+JFpJUVqb+aa19FWuRPov
         Vyh5uM2x6uQIZa6e/KKVHEyia5d1nsZ7QCPZ8jwdSykzokxg5vAc/4JOHZTeJfW95nuR
         P5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUynmrDKUgLzUpD71X/YODfCzUmGV/6W0njB/E9YQeV5PwYno4tXJz2usZE9Cj9ik0EH5P6q5t1@vger.kernel.org, AJvYcCV4sBqYsGzdfQvKLw2ZFl5ge8wR8JsjmbTi/2R5RQ7xVLS8XQMskGZlL/C1/dCLubbPxQMUxr40DNZr@vger.kernel.org, AJvYcCX7PSS0azO4GfhIWGSx7k3HxnuZUMXcsYerXrmC7b/QDVBBO0RaaZMzlDAr0sWik9HWVEBxjI73QH/0Crsr@vger.kernel.org
X-Gm-Message-State: AOJu0YynV3f2Y3U0NlWIUglc0nMzp76XS1smueaJ/s60quGL/6ciF04C
	hitJUmh4izsJQrOgnxVjkUIbpfWD8iu29rBGdfdPI46PjZ2HHgZABTVj
X-Gm-Gg: ASbGncsg4MKU2eclqmL0OjmJ4GtawKtLHpS211JRB5ikt496ff3GkT2mYYtMiqaiCww
	RBAIdtcNa0+4eYqYokir9s94Sm7GjfxXeIhrAL1v6+7SOyMWOIVnPgUW6Q7WJe6TLNmzJ8X13g6
	lHLBcvLqgXzPUN9eDIJ0u3356oRm1n18KS9BvDdbdaBBFDe9zyBs/bl0GT7gDcEn/7Ava2w9sg3
	x0M079LI+dFu7idzb8GYRZibnXmj7bWFBT5k3t6K4CN18VoAQMBZLMb3VJC+5fWSOq6TcoUfvsG
	boppKYCvJTIoXLTMKOwOWCoIRhUcAO8xE0XPdkvCg7KUqIj0YoNY2kJY0G54VZ92Qy0WQzbCDe4
	45DE=
X-Google-Smtp-Source: AGHT+IHVFQGAGOiydtS3WD4h3E514kOXNrb8JU3kqWsTcnNfJ01MXiUz5RPjMoINu5c8MS7L/OVfjg==
X-Received: by 2002:a05:6a00:2309:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-747c1c5eb5emr9127507b3a.21.1748716787787;
        Sat, 31 May 2025 11:39:47 -0700 (PDT)
Received: from localhost.localdomain ([64.114.250.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed34fdsm4888915b3a.75.2025.05.31.11.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 11:39:47 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next v4 0/3] net: phy: bcm63xx: add support for BCM63268 GPHY
Date: Sat, 31 May 2025 11:39:11 -0700
Message-ID: <20250531183919.561004-1-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BCM63268 bootloaders do not enable the internal PHYs by default.
This patch series adds a phy driver to set the registers required 
for the gigabit PHY to work. 

v4 changes:
- Remove unecessary checks
- Make commit message more concise
- Tag for net-next
- Add include to schema to fix dt_binding_check
- Schema formatting

v3: https://lore.kernel.org/netdev/20250228002722.5619-1-kylehendrydev@gmail.com/
- Remove syscon for the GPHY control register
- Change driver to access the GPIO controller syscon
- Move syscon phandle from mdio bus to phy node
- Remove unecessary devm_phy_package_join()
- Made functions static to fix build warning
- Fix formatting and whitespace issues
- Add schema for PHY driver
- Deassert PHY reset signal 

v2: https://lore.kernel.org/netdev/d819144d-ce2f-4ea5-8bfb-83e341672da6@gmail.com/
- Remove changes to b53 dsa code and rework fix as a PHY driver
- Use a regmap for accessing GPHY control register
- Add documentaion for device tree changes

v1: https://lore.kernel.org/netdev/20250206043055.177004-1-kylehendrydev@gmail.com/

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Kyle Hendry (3):
  net: phy: bcm63xx: add support for BCM63268 GPHY
  net: phy: enable bcm63xx on bmips
  dt-bindings: net: phy: add BCM63268 GPHY

 .../bindings/net/brcm,bcm63268-gphy.yaml      | 52 +++++++++++
 drivers/net/phy/Kconfig                       |  4 +-
 drivers/net/phy/bcm63xx.c                     | 88 +++++++++++++++++++
 3 files changed, 142 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml

-- 
2.43.0


