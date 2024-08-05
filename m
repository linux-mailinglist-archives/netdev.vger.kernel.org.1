Return-Path: <netdev+bounces-115877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA649483E1
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84181F22416
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B016A938;
	Mon,  5 Aug 2024 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b06pHLay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F4143C4B;
	Mon,  5 Aug 2024 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892258; cv=none; b=baUxEXTzDyzXMIeUYFxShzsoBafnNmt41uHizE1c6PKaST+3KQ+xgVPhc/XBmgv4JgGz/IpOPeiqhJFF5G6PBxtkLJDe09QWb5w37yu/gh+PObtDuDn+zNPISQEENESxpZiu/AIb+IlN9FVMuK/xiN8fPJ7cGleH4CYxRdArH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892258; c=relaxed/simple;
	bh=ic4I8490+ks6llE1/f3ZpY6h5oDiGysHo2iab4SPpzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZpttqMTXg0BLh+vg59shacCKAboseJDIqWsihuHcPTC/svcQ/UeeK8BJz/pFnKpz6JI16TxLl7An/cVMtnSM6vMjesP+Gn4oIVBLr9NB0BuS7HHwPdq0CkWwr/2ApBPHA7j/E8YCc+CgpyHDyYSnA70nsI/C3VrF9LnPlmL45ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b06pHLay; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f035ae1083so132362091fa.3;
        Mon, 05 Aug 2024 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722892254; x=1723497054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26N1O/ke/9RuWz+iP8MCN7tu50q6wxraB8LQ2aG9tKU=;
        b=b06pHLaynmiA0J7YEoUonNN3jQz9ciOkKb0rWYRQZhXaJfuTGbQCO6gZfTGrfzShJn
         5abfGN9xrIxeIqff0TtMg8ZUw+P4Zr9UvwJ//7+ifU0CA5d05UqIPNznbzC+65xRXhsi
         Xm0HsjZBTz1X3z8qKVChfI3UbJpTU8cy7RBZZntfKAPEvEiY4PxzzU7cYyD1LHEN2uc7
         gzoUaJspTTqnhV4fuTNLU+5PRDKGKy4Tw8rkwBs0O7gRLGTZEkOXkWuszc/22/tAeBHU
         fEFJVxaMEtWY3W6kfHBjuggUmMk3w3zspngRE1pk+D3amQLhd9gcmL5R1FPXfAyRSy06
         YtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722892254; x=1723497054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26N1O/ke/9RuWz+iP8MCN7tu50q6wxraB8LQ2aG9tKU=;
        b=G/bK/i2ALRHVc8I3Ld6vxbwQgFdFsflnK2MkLcgGVt22fHQV4A/kjMllPe/WT+PYGG
         wEkyv/+y7lmeLeQXCr59uPwOyH3i+Z0g/d+ozYPPdjPjZrSbju1JAeQqjf0TyPKVVkaT
         pojH6yx+igsjr+GH6+ui8/qaQAhvfuwo+n/sbAMHQZANA1o0+z8mDj81iHLi/G2dCnC9
         pBWdCfnUCKyelkjaRtnzwcGvPKDAF8UXEp1JK6JxEZddBi15SdDXNEaSSA8ctvtYj02j
         cU9UnTUqHnsFVt/yInK58lbaELczJ77PWz4Wds/l3KZuZfYzDocczdgOjBrRvpxmhoen
         2LoA==
X-Forwarded-Encrypted: i=1; AJvYcCXYCVbW9xq6Re1F5G2kY7L0lQBhrhJjlzsN+k5uDTnGaVtkMzuEgvNfp0UmcZFQTc8NefBLoTLy7trO70MF/myVYffaH2RmRjnInlK+
X-Gm-Message-State: AOJu0Yx9aFu2GGI7aEQl13QJ1Fkg6kAr8NP3Cr96ydm2hNOrNVQLAB02
	kcnl6IjF1iguqpJpItaYBX/FIDBAlcKWQSU8vcu7FLljk13gfsqhetwIFfCu
X-Google-Smtp-Source: AGHT+IHfVf5SjxG8XzRH9t8JWHU2SVe7u+pdXFOpLj9F7jbhSVXFjwbf+XBS3VbuymiQ8I125ZJQKw==
X-Received: by 2002:a2e:320e:0:b0:2ef:206c:37c4 with SMTP id 38308e7fff4ca-2f15ab0bf8fmr90214231fa.33.1722892253864;
        Mon, 05 Aug 2024 14:10:53 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:1688:6c25:c8e4:9968])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1c623csm11875291fa.63.2024.08.05.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:10:53 -0700 (PDT)
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
Subject: [PATCH net v2 0/5] net: dsa: vsc73xx: fix MDIO bus access and PHY operations
Date: Mon,  5 Aug 2024 23:10:26 +0200
Message-Id: <20240805211031.1689134-1-paweldembicki@gmail.com>
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
the MDIO operations fix. It also enables the MDI-X feature, which is
disabled by default in forced 100BASE-TX mode like other Vitesse PHYs.

[0] https://patchwork.kernel.org/project/netdevbpf/list/?series=874739&state=%2A&archive=both

Pawel Dembicki (5):
  net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
  net: dsa: vsc73xx: pass value in phy_write operation
  net: dsa: vsc73xx: check busy flag in MDIO operations
  net: dsa: vsc73xx: allow phy resetting
  net: phy: vitesse: repair vsc73xx autonegotiation

 drivers/net/dsa/vitesse-vsc73xx-core.c | 57 +++++++++++++++++++-------
 drivers/net/phy/vitesse.c              | 25 ++++++++---
 2 files changed, 62 insertions(+), 20 deletions(-)

-- 
2.34.1


