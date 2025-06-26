Return-Path: <netdev+bounces-201688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE44AEA8D2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938253AA446
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A028BABA;
	Thu, 26 Jun 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj0BJEFO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF5289E29;
	Thu, 26 Jun 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973052; cv=none; b=Bw/6gN5taAAerdU0l+Z3KVLhkPKktM0CeFh1gXchovrtnWSp165TY/WzPFcmdia7wNTAF7hNZEAwR0K++Gy9tzQQr3GD3gnLnZukmag/1oxM4eclptliZtXVYlVX+hvA5q0S3SR0coWMIKzIHgN02O2rhI5EpdOueOAM1S9rnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973052; c=relaxed/simple;
	bh=rxFQoCBw5eErBh4erOUf2TGPZ77n6Ezrfaar4LKXWEU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo6/MkE/0VmfqiLxRKiZJfSSBXRiNtyul6/ug7JGGb1TVji8hSSXMNLChphC716oHchu8nmU62aVISFohf93z9ziv7QKA3RFsaS4Tr5r9jPuiW0rpP+ujpjkINc4g4tZ7104GvaKFl7D3wb+Y7oY5D2pmwQpj8JUt19412T7Kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj0BJEFO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1757735f8f.0;
        Thu, 26 Jun 2025 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973049; x=1751577849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+r8kqMG9xKuRBCFyizw4d+MeqKPWu2iAAx/+euz7j40=;
        b=Hj0BJEFOZWCo0StH/O5KWuG3pbDSEBDSnKQ4c7todOhusIeIkWH7jX5UuPGNouo+Ge
         Ums6SKx338J32uk7t7l/UNFJDFBQpEKiEzhY4dBcVQOR0N5JtBk+QB4SpdJBSynyl5ef
         xdjlsiyGJ2SIrChcMyJ9ji4UrlcbMIC7ULPyVt30ZEkKnhGGRX9ar75UfrpFfzwV5nR9
         r5h7Sw/gUh6//aa0/+1v2d0NrUPSaGipG7sAHPJBRMX6xk4SRtfTFD5X+/hHBsrzc2gP
         kiQWtEi0b7nSAH1drwMhPNQhV20jNxvQ0hPf8NuKD7VNMdlfoEbgV9YJ0KF1xdmb5GdQ
         YTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973049; x=1751577849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+r8kqMG9xKuRBCFyizw4d+MeqKPWu2iAAx/+euz7j40=;
        b=hxqZHHayFLnh/mDnhayTdLh4Uk+wuOEtijbVtsJccieXOlkaBPQmpKmSLHs7NVPlfv
         T+3C6IRM0xVFbDrTf8DW0Fuuu4CyNE7CE4MuHnVKC3rEF39AAQp84Fm+72IyKNKTnXdk
         EHWi7Dm/Qd7Fzx8oEqlNEXymX1R1frLwf3G69hs7zmTFqfzTNE4Ume3xF6xXXNya5ExL
         EO7KPnSyGc+6suvajKdBxiABaIOn9DEmyXgdic4U7QVwDdxZIViNLa4ajrdXgh79uGfV
         60q4+ZtkCnT69IVCR43gjUxUrWCOJ0BTqJNLlOgBB2gCfeFd18MizeeN7k3qvjkaNc2q
         PC0g==
X-Forwarded-Encrypted: i=1; AJvYcCUlRa1lpDKFkIo//XPsAG5GKlDggPzAZ/llNUwbFuAzZLgpDg9N6GjOuGcCRvCzOTIwWaZNAFns@vger.kernel.org, AJvYcCVUMvt7UIu8slhYXE8k4fLanhHh+PynRs/Pc/cWQPVH932C54t59PIQKpClBq2uc0E/MNEwpA7B354E@vger.kernel.org, AJvYcCWlDvproxJGRCZnjn3KZJpEHUY4ONyP0ENZ/UrAOlQwt+4kS0QohNevrUn717wR/3/aD5/TPREQ6TOde7cT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0GIHhZFnelrPL/bX/Sd/jZdLJg5+98f5ZMy9gPPD7AjWmkYP
	/TM3R38876f0sOyRXgOLjemw2Xgdm8bdo3ctHVfdnCorncthpjSIxH0b
X-Gm-Gg: ASbGnctWAkDf1g27TZZtrV2YtveR6R9TPTAyJ8dlR0PCBwBEzsZNb6hvabSLp34m+o3
	IfmxiYPT7owuv1SARAueT69OPXOPDNk9218c01lt6z3+RBT/67oiPOXb1jQtAh1dW40UOgpwQMw
	CX0/rKCVEtdxHqI4O9JYgYPyXCd9cQsfK++8hp+9QcMB7JwhTFUS7lb0u/b7RcGRX2djycS2DtF
	rIHj7+/IjFVrrcVY1zZPaTMNgL7vCtxYvOe11kaizb7cSilVsYu6KhEJhO10KvoBRMoslo+15ZV
	3fuk4pII5yGMiYaa4aHu39ClJkCO3x29U05Pqi80IBER2x7KP0gSkLJm4RqyWTQmuKMI9nXxZpC
	C58c0mB8h8r5y6OlXuoN9dV6vEvr2pJvc/rdGgMLhlA==
X-Google-Smtp-Source: AGHT+IHNeuv5wIb9hNfS6byOpPI858KsRilQzx+Fb8SYuLtRukZLflt0CX6JZU6vbK0Inx9n+asLtw==
X-Received: by 2002:a05:6000:418a:b0:3a4:f70d:aff0 with SMTP id ffacd0b85a97d-3a6f312df2bmr3074849f8f.14.1750973048916;
        Thu, 26 Jun 2025 14:24:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm57186475e9.10.2025.06.26.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:24:08 -0700 (PDT)
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
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v15 11/12] MAINTAINERS: add myself as maintainer for AN8855
Date: Thu, 26 Jun 2025 23:23:10 +0200
Message-ID: <20250626212321.28114-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626212321.28114-1-ansuelsmth@gmail.com>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
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
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb9df569a3ff..2d1785478855 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -737,6 +737,25 @@ S:	Maintained
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
+F:	include/linux/dsa/an8855.h
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.48.1


