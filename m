Return-Path: <netdev+bounces-167159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C36A3907C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC933B2655
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA1154425;
	Tue, 18 Feb 2025 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjvRyHlA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571C14B96E;
	Tue, 18 Feb 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842635; cv=none; b=kIBNzGe/3aKssCh9aQ8z+AqKoeURZNDiOtLjeJc1ty5svINj6an+F7cfxkOCkj/sUeH3WFkDFubol4errRl66PV33o32SdI17I6wfK6eT+oN821lnbUnXbRce19y8pssF0FNm1NEq/j08pI/MUCtkNZy6OCpHmGQZffpzdXiBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842635; c=relaxed/simple;
	bh=rzBYNZpMd4MtFoit8nyBZrLxnfjg7R6DbVJHEuWAtuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOVLeZyJXecf1MLcOcVU564JIi/rax+WF6uNOGq5Gx55O7Cr5QWjX0NX78rWNZ8mEK7asPe7zrx72A0iFfyVfjDOp8QsWUsQBzuf8KDg3MA1IrhNPtiUFWpL/Zp+PmXZLr/Hkbtjn2psE9g+DdHqKuh9sQ/MNQi8n6ncHRvNdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjvRyHlA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220d398bea9so67827465ad.3;
        Mon, 17 Feb 2025 17:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739842633; x=1740447433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etri3gRWKdjFSFKIw2cvCgMSE9P8iiS/IwooyDBsaDE=;
        b=WjvRyHlAU8txyeTJKYv+Fpn6P86fgacl12S+xGf5iZ19lXqTpjZaMOE99U4KR9EIeX
         saUuzqC60+c0K2WpPqoBpPZG7KThoWxMauIqMRF0h6QV3DX8V7ORc2PcqGAEc98cRcyG
         DeLu7ZOxOhR5xpcWDDsOwthT/9CF/7DucJIybfLYyDuEYse8bSYiL7jfdST94IwBM7+R
         hhbYpU0fcbrRGIoTMDpMAblrSdCddvjxX+dtR5G9nzF65Bo88nUN37eQrwmF9xi4PFnB
         fvLmhZb+bz+EuYb9V+WzI6rTXlNcP0mx/mM6O0c7griwevUQOLQQCavgszi3qxXzG0AT
         mSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842633; x=1740447433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etri3gRWKdjFSFKIw2cvCgMSE9P8iiS/IwooyDBsaDE=;
        b=Ds2au+8vhVfrc2LvhFWz6pG9zabJFPFjOXLV+yygmfH7gC20JIvXMR8egDzm8xR01V
         /Q8wyzUmQDYz7RQ0So5L/Hd6DhcqjhFQU8H7rukClZHprKsPut4VxOSdAsnihFo3o8RC
         yVft/jakZ6T7fdVSSwiMSCyUAiZNhkSRfAk5y6BK5Tu4svw7pbBuSHEKW5lrgWOFMb+6
         tXP4tLqBlFHLEU3ietQVOUrgP/L6k0G2vc4JX8HRBlbH+tLfoIDKVnRKq4PqXJuDS0+3
         PnnBpRZpubEkngeivQri/FRa7IdC/owr/RoB5NgTfHFHGkr1SQvO+F6dJ3jnGQsoCZfr
         byWw==
X-Forwarded-Encrypted: i=1; AJvYcCWs0MSLRCu/zMvP3wItGhgDeflalkJNNGjr+iKQUatunSHn+JfXXX2n8GDsSPdWEzAHKbfNnxihefsMui16@vger.kernel.org, AJvYcCX9eu9/0sC2uZRLi12jWLpc3u+bYchqTBfaE0Mkkhw+cL0zPfkhPrylkijMlqqprp898HqtEVX5@vger.kernel.org, AJvYcCXHShIO1cOGhXgy/CWlMgEfnGxvLQnjI1ktYdOe5OBygIoGfNoM13OcADt18M6fkuknwwgIOuAUuXL9@vger.kernel.org
X-Gm-Message-State: AOJu0YySok1FLza2d71NK/8eBpkQbuGFmX5rA5je1prmOO7mM6aKBWUv
	Q8VTrLTlMU6fkDGTuB1kYPvFosT5A6jgfWUznbssI5hJVhRiFrZ7
X-Gm-Gg: ASbGncuAukYdoj/CqfbR7sWF2yH/tN7GydDLrD6swdujbhQAhrDSe4TiWF7F64j4JAw
	Kzc2bk08jnUorPHuX9z45hC5DkHuvm3BAtKDBoFHPMLY/S1kRnEewGX6+JCGuM9U7m9DrtbuYW0
	NxfugN84Mi1zasb7TYMFqr6emjcKiZbMhdV1vavKFipCEgD8GFNTqbZleCdKltg8K6g815fG439
	NnXYi9nKsMpC+CIICaLyaDovUJXk/QANiW2oFYskmJsoeG5x7/dWkuetpWfCOS8HsAR1aDUq7ho
	XQl6PMQGeV6yGZlBTJ+VExU5Gzqs6NvVpQ==
X-Google-Smtp-Source: AGHT+IFoph5ZViSaCoMwidN8cmK56I0H9Y9hq69qvCCD8PsLAH74RJoPLNmW8YkHFLTowVoGAzOl6Q==
X-Received: by 2002:a17:903:2cb:b0:220:fe50:5b44 with SMTP id d9443c01a7336-2210408280amr189394565ad.31.1739842632922;
        Mon, 17 Feb 2025 17:37:12 -0800 (PST)
Received: from localhost.localdomain ([64.114.251.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d4d8sm76910165ad.170.2025.02.17.17.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:37:12 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/5] net: phy: enable bcm63xx on bmips
Date: Mon, 17 Feb 2025 17:36:41 -0800
Message-ID: <20250218013653.229234-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218013653.229234-1-kylehendrydev@gmail.com>
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the bcm63xx PHY driver to be built on bmips machines

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 41c15a2c2037..0f2956ba472d 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -156,10 +156,10 @@ config BCM54140_PHY
 
 config BCM63XX_PHY
 	tristate "Broadcom 63xx SOCs internal PHY"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
 	select BCM_NET_PHYLIB
 	help
-	  Currently supports the 6348 and 6358 PHYs.
+	  Currently supports the 6348, 6358 and 63268 PHYs.
 
 config BCM7XXX_PHY
 	tristate "Broadcom 7xxx SOCs internal PHYs"
-- 
2.43.0


