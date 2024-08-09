Return-Path: <netdev+bounces-117282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4877C94D76F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51F11F23284
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2715F303;
	Fri,  9 Aug 2024 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT4gKk6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315591465BA;
	Fri,  9 Aug 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232305; cv=none; b=Sn1qImItPS5Bb9h+TdLukJqif/f9/d6wwz3eGiiGTw/HZex1CAGmOEMDbWBkhup4+yuXi2reZmZhHa46FLln1VFKSb/eZZvokF9iBHtMRvWUjdOJYThMoS9nht1yhsYcNerQPGw4meCxZWtIYtkK/uYLkq8MgGkKeiAE5nfY03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232305; c=relaxed/simple;
	bh=lWL21pWMUbbm+vGeQxnkHKUVTONIyKs2DXLfdyTbY+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dl0gGLYTi1fSeudReQmXEPqhredtFyb+YQ9/3cxxsI+bDsW+Pl1k2uS5wF/4a+7lADHx3188RS//NUHsRiHiqofrWnU54Y2u/ojIY3vkJhfd8jTOOQ5VPJu0gvaAYpNMOyaamTCnzBT8+3wX6i98Ttar92CXbJOvfCG6B7r0Rg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT4gKk6b; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f032cb782dso26435111fa.3;
        Fri, 09 Aug 2024 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723232302; x=1723837102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYtJIwI36rJzqDs+I9wOI8fK5hCxFXCO5iPjfGyIUTI=;
        b=hT4gKk6bmtCpECn554vCYf2XZH8/nvJ71z10LRoJvsqk9NDLMpy14CZHxQWor0bk2Z
         kxzcaE4muqTpVuQAZx5uprs1JXg0T+E1FEmZyiQ7CaZ994at7tawsZ2ZMLVcDCQYHA2E
         CThQj+byqEUVHpb4QG/lOwQxQYwdxFqvu26u375IMpODvTAS9BS4NIlBGREoyEB2Xq+u
         BtsVgOYbvbXt4AVOoQ2IKlptyToRyZuk1jO1DCMGaZdXDCtQHeHuu6UMJQpiJwvkN9/8
         mwf6QzZIh0oqB4toykTqbPqSahzfHpiL4DURDtEolJwosTFFArEochwlZxQSU3YIOhBc
         s7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232302; x=1723837102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYtJIwI36rJzqDs+I9wOI8fK5hCxFXCO5iPjfGyIUTI=;
        b=rpxIn5SD5OnS7ouSiYOV3UcfRAbQ70ApqlX2ebj639SFu97ZDM4If+ipKyXwpH/Zf8
         czRETar0FA/XrNmUHcgHTHq5Sqkwuf8gVfZWYoRvJhA2La/cxMIBDafCW62sRKyhjVCR
         oi7XjfMLU4P0yci47Zr7BqQSEH35uftKVBWG1b0SaEjBH2bSVY1uT51y+AB3+WcvukOV
         0boWXHY95HNJEAC2ex9AxwYxwutMcletvOuS3sgSVbOOBUtxJwmHVSqYUMhfXYCUcewn
         oJ8pVJfpSMIx//cvCzyAxeuNw2j4HgdzqjVgSjjLeAA1GN1C2TSmeJmr71bipxde/Zth
         P3ug==
X-Forwarded-Encrypted: i=1; AJvYcCVPzWOe21Z4JSFuoeIxFAvOU+GZ1AkU2IVIASw8UjhzOLPma6mgntMX5qkxj5xDCPM+Q9ArLYnh9iywxzFZz7GBgAmyKtk6yrYExU/L
X-Gm-Message-State: AOJu0YwOmhRdIyxPjMb+a0Bx5gRgATpLHjGWRgQ4t2OUSrOmRheUKXua
	LQ6jYJt51IqC/dv3TsAR8waNQ2DEqEz5REof7Hbvfqgut7OeFjB0LZWusyD4
X-Google-Smtp-Source: AGHT+IGzdGE7enXekVvIaPhxLLUQwGT3Al0wnuqWSGVKcgRQ8lbgEsRiiPx3gKTNOGkDJFElOyaSrA==
X-Received: by 2002:a2e:3606:0:b0:2ef:2c4b:b799 with SMTP id 38308e7fff4ca-2f1a6d1f284mr19623591fa.28.1723232301424;
        Fri, 09 Aug 2024 12:38:21 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:8a4a:2fa4:7fd1:3010])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f291df4987sm451311fa.50.2024.08.09.12.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:38:20 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/5] net: dsa: vsc73xx: fix MDIO bus access and PHY operations
Date: Fri,  9 Aug 2024 21:38:01 +0200
Message-Id: <20240809193807.2221897-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series are extracted patches from net-next series [0].

The VSC73xx driver has issues with PHY configuration. This patch series
fixes most of them.

The first patch synchronizes the register configuration routine with the
datasheet recommendations.

Patches 2-3 restore proper communication on the MDIO bus. Currently,
the write value isn't sent to the MDIO register, and without a busy check,
communication with the PHY can be interrupted. This causes the PHY to
receive improper configuration and autonegotiation could fail.

The fourth patch removes the PHY reset blockade, as it is no longer
required.

After fixing the MDIO operations, autonegotiation became possible.
The last patch removes the blockade, which became unnecessary after
the MDIO operations fix.

[0] https://patchwork.kernel.org/project/netdevbpf/list/?series=874739&state=%2A&archive=both

Pawel Dembicki (5):
  net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
  net: dsa: vsc73xx: pass value in phy_write operation
  net: dsa: vsc73xx: check busy flag in MDIO operations
  net: dsa: vsc73xx: allow phy resetting
  net: phy: vitesse: repair vsc73xx autonegotiation

 drivers/net/dsa/vitesse-vsc73xx-core.c | 54 +++++++++++++++++++-------
 drivers/net/phy/vitesse.c              | 14 -------
 2 files changed, 41 insertions(+), 27 deletions(-)

-- 
2.34.1


