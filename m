Return-Path: <netdev+bounces-180134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264DA7FA83
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB643A6F5D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165642698A3;
	Tue,  8 Apr 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOQamwx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA2269811;
	Tue,  8 Apr 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105959; cv=none; b=cqHQU6554/6VG9te4DhjbAhYfhQPzOB7qTAAi8z4jyHNbf486eWobyTZ5dNzzQj5izZyfIXmV+YsJe79Ro7c4T774EUBetpZmflpqdFhGlz+bfK44mVijXYTcABEifXMgUs4Ak8S7r+6JwFtDSuSUigcOl+SxO4YxVZdIwYGb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105959; c=relaxed/simple;
	bh=Ky0vVuHkIaVyMDtnKq7UmLpKJfVLTIH3occ1Yz1Kmd4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PunFPf953AadbBwZ/Hm26tVHOgrM9+7humi3DsFGpWUQOJEGKt8ceruhInAY380kYVYsNy0svBOWaeWLrFmekiZiv8oI8X5cNxEr0TA3I04VI4YAry40znTvZEHm6uAfWIFOfkh6GTtduP8kz3ShmvV7XyJu8ckxHCWMNB45/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOQamwx5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39727fe912cso2324337f8f.3;
        Tue, 08 Apr 2025 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105955; x=1744710755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ6Ge5N/x+UWP4V38Q6zLxAFPEUt65Fhe18GDR23LPg=;
        b=NOQamwx5+BzxM25H2Fqo7omWYr+p+szdLq23JY4ZCF/s7cmB5IyyTnCmf9RnCx0eA4
         rKQQ2w72pP554zLwH7sNM0HIAeCIPgJvOYt2un0YN0hUom2wPYg+oPcpQFHjN6laGfGZ
         7KkIPuZKcIiy756l76NyBmWH06q5iwvsqHYLUIpwoaFu733nBRADWkPWUH8Zz7vhP7kw
         LzVLqJQj0mgPla0wgkfJAhqLtXffsjLTqvQBCTKkn2HsrThwsgr1MmtyQlBLk8kKTLxB
         e0Tses5w6ofUp2cBd9UoZnlKFJi2043n00w+d3GQL/6jqKofZV0gA1qrXCObt9+FgLs3
         Ewow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105955; x=1744710755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ6Ge5N/x+UWP4V38Q6zLxAFPEUt65Fhe18GDR23LPg=;
        b=VyBo9hU15U+TuecAmXxIE1vTQoar+hbDgKz0jtej/TLhVckqTwt3AUKyx0erYRqYlE
         96JxclSI3agGFqCWhLakx5EGHcVKXS8Nfa2JBj1EyWC/bAph3VPjTBhCBAN8kbSS7Srq
         pi0wYk5/Y8jj/sUEw+SDVVtGzVgPBWorGRpmMvjmvhMGnGQIhB8tKz53A56OXYRy+Tli
         2RNMze+zPcZFJPGlN5BbiOlPWDg+EXEGNLFk3DtBTEbIaSPKO8Dnw3e8R/+P4usR3Owy
         Tx9g/sl0bnEHXgouPB7FMvDvRFRUdQyQ8ww22moipQBYj7nGPYaeJnlF29loz6Ieq/I3
         aWaA==
X-Forwarded-Encrypted: i=1; AJvYcCUdZL9Kg0MDF1w+Y/2BbfaRqw/rsLx68o7RXySw6e9yh5ReATfetdWtwhHgL9UUtobyXRkIOTSePrNY@vger.kernel.org, AJvYcCUi/CafwV/r2018SHioME8LbzQi+NGziGZRHR0gapO5Q7lbJ+dRhPnN5rPc69nmIYlHt9EIThPx6lIkIpUN@vger.kernel.org, AJvYcCVb5tFFaMzAgbx0fUJxFlGJJC/YSp/71R3wOMAUoK0tZap+wk+83UaMPwCR3I7cSBIpjdMxve4m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1umQwpA5I0pw6LfZqW/shdFprq43yD/uxF5JpVAwtXSa8z5Kd
	L0nM+zdZ05+VFx3wW/BuD1MpAECUxr6WtKn7RKOCBDakqtQNZSmv
X-Gm-Gg: ASbGnct0LZmS0/TGfGBd1CuzKViygMnbN+j2KkubK3bRN7op+AowEe/alY0SBLko2LF
	kWJnvTuKiKt4Or46JqPfVd5CQKzIWAJRcNmiQak84f2LL4j7EUUdlrH/uGNwl8tljBRsqXktYgq
	uOKd4q7U/ZryDy/PaBZoM34nczP+/Cld1fDG3Jfvdz38gX57rYAGPrutiImFfo4saG75ZIVVtnI
	8z91kY/tKyHqSK1v33ejojuhnxYu27W2ELjt4Hrh2pXeejEUwCK5ZkYsymfb2XdV5CZ7r6mclaf
	TkRYgE9kPWfUmbcYzYkKBIdp5ihcJEFuEup0bR3IFFXFoJxCPPNGZmlO5acr8JAHtkickhi2/LW
	c9T8Kqq6f5a8joQ==
X-Google-Smtp-Source: AGHT+IHpMGk4Yds8HZnyNiJDTf38Jb7LdTvCKQAIkk5y2ICjoSbvIt78dAK6v2Z6pag114kDRk80RQ==
X-Received: by 2002:a05:6000:2403:b0:399:71d4:b8 with SMTP id ffacd0b85a97d-39d6fc293edmr7839272f8f.23.1744105954688;
        Tue, 08 Apr 2025 02:52:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v14 15/16] MAINTAINERS: add myself as maintainer for AN8855
Date: Tue,  8 Apr 2025 11:51:22 +0200
Message-ID: <20250408095139.51659-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408095139.51659-1-ansuelsmth@gmail.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for AN8855 DSA driver and all the related
subdriver (mfd, mdio, phy, nvmem)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c5c2e2c1278..74f99bea4875 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -729,6 +729,24 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/mdio/mdio-an8855.c
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.48.1


