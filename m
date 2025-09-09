Return-Path: <netdev+bounces-221015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2220B49E40
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA00189467D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A52550AD;
	Tue,  9 Sep 2025 00:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5YZJQxS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2624BCE8;
	Tue,  9 Sep 2025 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378655; cv=none; b=tqJBX0rLiGNAN+KvTcE15JedvG/XoC332pdKMIj/ax/a+a5qudSgdFv+LpAUAx7n2mpk6K4M4XX4gQkzrG4Ih3lRcpV85CKJh3fouGMT+Bq70nnKzg3liJkCaOm44YEgj48wr+NjJBf7gWdWa72WcMVzqCGtHj+gtGwni3uB4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378655; c=relaxed/simple;
	bh=cR+i0j2nFSKam+gq7FWSsr5apx+a/lZwZMhEZIsHfcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JypzRkSLQ3yV4xkTWL0jI4Jv0gi8zm6l7L4H51LAOTEk4yiEMgFZH8zLgxBXJm5bEV5Pg+0Y+h/GHnD4sfp6AerqRcTUl2X/M/r6A9162t/9fzz6BI07mFSarkMBSP8ufaibXdZLj6PFzkNLMpfCRIxKVU2eiSX7Gnmb6izAhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5YZJQxS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dde353b47so11039255e9.3;
        Mon, 08 Sep 2025 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757378652; x=1757983452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=d5YZJQxSr/VqpHN4uzIuzoOYUZSqrf7+ew+0vrysePE66aJzLPZMRH+j0ISNJ+xC8d
         THnQa761uCiDH9O2OtXUsY+1KKVD/4dIpj4ZXZA+FGAdzSTCbo0Gjulq2CiTkyCX/AOr
         /LxS33XPafNMBqVVxWIzALVOPDWYf3s8srXoPJsLlxsC+Usf62EEB89AYqWeYbQtyJNK
         8GmbSUSSNujzteoNX3Ad8t7xangNq7VikmExAOy8HBo0zDBVydS208g2DAusTGOYWDe2
         zqi4tSD7yLjc/nVzqDjGQXs2dF9JfVMWYBXng7UGqJ6XMd2fE0+ftSxCXdlEJkLyyC8u
         5I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378652; x=1757983452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=uTNGWoXbJ6wpaVkmHxZUeuxVG3tGqjw0YF4m5tWvfzhONG99EFGBE3yfyHyu2s3/KU
         RfDJxfh2GelyzfWgGDrMyONDQL6EG0nlGIolhG2M7E0EyWgIkzua5xRfWB1XtBkdcS6S
         5hB6bqodgrODjJY8kqZsya+JhRpq2VWWwCUo9ShfYbc1Vtpq+2F8s3rEg6A0r4BxrloO
         9LnRzaVOPNI7gwHJJibyhV9uXdQA0A5ILWgBkKz8e9iGFSv5XeVGYT6o8ItLbaO8UZaC
         QyfZZtCTCw1uTTk4MJ0te9yoew8p0JcNSi4TS+2I/oUby7RJd63JUymUif8ASJFQyhg/
         PhKg==
X-Forwarded-Encrypted: i=1; AJvYcCUHlJc/6Gx8LfB7Ts4NBHiayisb5XUZA4bvfMh9G1nZUtibUVxhNd/dM03kwFyYGkZPBZso4Q3Bz8SsAJsN@vger.kernel.org, AJvYcCUyLKqnnLBjFAO2lgPWiZ2/xg0K9TY+K9fplBzSRtfyOHqcZgBlsP4UPRqYqu4O5NJ1Jo87v4Nu@vger.kernel.org, AJvYcCXFAoZTaceW9ntpOa5Ct4t9AvpWRcqo7xt02xLvqcC28MFXD+3c8F+QpaJ+cNSm0SbRZkk7vaV/AVsq@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZ1GKa3qOtV26In97XWz/dOy8RUbXxoGDcX2vj0hQ7pCvi7sk
	mm2t3Q4Va3sWMK6NoetXrb7lWs6wF8ZChzQY4SArg0q9Ax02rvMCTrDH
X-Gm-Gg: ASbGncvL7DB2xsIR8DmaK88vhMV8dvUUnRhWfEkSF2hgdNoYFaSoeXqVyO7FIYBTOc3
	T1HRL5DJJgTDatFtTj7Y+kKkNWmiv8f4LkxLzvilqC0cmXlzqfqaZPC8KIoGu5e9RFVFhNa0kVb
	6tFVxah7cFhHCsQrtcj4F1cOvHHDtGLUgB4P1Uyj0HsVRN7OQyYW5JRI9JswObcdl9IMuSUyuSO
	tpZenLMl+fqq0PJq97a4U+Z3amrEDstjvAxMjwiAumu/6+U++yE1eC9CF38q07L8IxXK+TAUn8Q
	GIQuFOygJ84L13cDNFo+quJsIlOq9KrJ1EhVG8iNtUsutZtuzn0RpxsvotwvQm2dajoM/PJOzop
	nEoKl2X2/nPPYpimwcSRvExQJs7T9LYuAGfbP4PEkg9g1n/pllOm171evIe1mP4p341e70kjy8d
	r8+DgVmg==
X-Google-Smtp-Source: AGHT+IE2PbebWviQZhrJVIzRPMIFwfn7sDOAOGBDcrXAjk85O6+L3RpYW9/enKFosoJvEOtR+9h4ng==
X-Received: by 2002:a05:600c:34c5:b0:45b:72a9:28b0 with SMTP id 5b1f17b1804b1-45ddded6d3amr91744265e9.28.1757378651959;
        Mon, 08 Sep 2025 17:44:11 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm13526385e9.23.2025.09.08.17.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 17:44:11 -0700 (PDT)
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
Subject: [net-next PATCH v16 09/10] MAINTAINERS: add myself as maintainer for AN8855
Date: Tue,  9 Sep 2025 02:43:40 +0200
Message-ID: <20250909004343.18790-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909004343.18790-1-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
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
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b81595e9ea95..818fe884fb0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -740,6 +740,22 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.51.0


