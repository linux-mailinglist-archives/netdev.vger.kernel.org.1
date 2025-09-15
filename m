Return-Path: <netdev+bounces-222989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A20B57708
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACF73A5ABC
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E202E30102B;
	Mon, 15 Sep 2025 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N91mQpWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F93009CE
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933177; cv=none; b=g9iEaTs/LZpu3QwWe/GNHw2ivBouvKsvT7yUyfcIFDKHStSm2sag+WFC04HY3X+QcbV24YnbnR+wPDHsI1YEdn1RiRzEJGOjIxKPuFHXNXl6Bd/bBK3+u7WF9EmPqSi6TZcG46psQjGwyhWWOr3UTcaaOAcp5JCqfW3a4oCiDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933177; c=relaxed/simple;
	bh=cR+i0j2nFSKam+gq7FWSsr5apx+a/lZwZMhEZIsHfcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b524lHL9Ux9+WSsHCT0KLQCtBhdRbzF6UrX03ZIsj0PY6/xAXAZortrjEhSPfaRQ+leoKf0NvfdSW4DIqCfAeO2ni8P7oF9V7snSIxqdl1nZLlX7cXMEHLQkrugXa+dLZ+OGFLpuF06wE3/EDos5lcBE8ZRIJX0Aao70vGVo1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N91mQpWN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3eb0a50a4d6so428558f8f.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757933174; x=1758537974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=N91mQpWNaQHTgCwVV33H7/ObwAxHX08/a4lGFO0SpWfrYJNwKBeLW0APAUEMJFwNX2
         zBraJXRDxxiKY7clEG9VCWP/FghRcLnP1QFah1epg7D5TBo7seoxqDcI2hveGMPItCZ7
         slJ5Gm/FPkTxXCEZDlH80Elp7Lo+ICiFCGadTQmHXTdkB3ulk2EOB7V4YOrlAaL9FOWc
         CXFwFdQp3cblEWLLgcutmF4Hw8hgefOQa4yJhS5mgBhR/eO68ZdZsIDx2j9qZvk5bXRp
         2CV2N8FUZYcyrsavS5+uMyUGditB4gKJZnGP/Ki4bLBA24c+2LqOaT5fmDCX8BQ96g9Z
         vCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933174; x=1758537974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=BAmw7PqGxvQAIp8P4icJ+43a1AK9rbpnGmQbGXOPdqIPZz+YKDJWxqfv9hncIIpa+i
         CS4SgkyPXr4kEn8A2s3zPN09StiDtoIas6KMQeMjw3qfAeJfD4wj+DAuZY9khIbKfBHg
         VvhgrJP8tvsFdiW83YvAbL7RUyCcqU9Apk22tbcqQECkv05fZwWJRgm47hpAQvvZ9sYR
         I1offHdUUDp6qClFm3Ltha1zWQEAPyVM9L8M52notj/NkPZR8xSrPk0TyUMi0SrJaHRN
         P4XORKDOH2WkbKTHlsReRFaw4deG8F+hdw7mQp5vVbqfNPVoxsy8Zb/dd7nr1Z+2Vu1f
         QMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbnOH24GYSPyrZ53dIJqxSTK9opSVz5sxIL0nlNWK9Qy+bo4VA802KazbEQpmnRiUEctThfIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6FDCxFnE4W+nmbxbQ+ebnC1XEEPZUk/dPOZt6owmKCIORK0t
	BaXemVBYcXCnNFw/ZiwxstNtQEgkuGwwHkKP9ZltEAN2VWh/p7DdoKv0
X-Gm-Gg: ASbGncv+BmCqr4GGftnLNsxDIA7COqiHBfxQflN67W/t3oGoSgYtGbODwM1EW+5yNnG
	gIiNJt1vbZTjis33Jqe0pXDAOTR9aIeVsgMwXxbu9ulZHe9BCp1uar2f0CuWLO63HJyHepwmI2I
	PxgoWEChi+2f/pFlgm8aqyu4YBirhULIN1kRAxlpM3w506HAPCRP6LFfEJzj8KRyu/6qj+1CL3s
	LKwwI0875a05rm7ZT097oLmfbzAU6psrud6rVg3FS7E1iTBrB24rTU+D/366OMRud0scnj9cdBA
	Th4VkTxMmZ/otorxDXhbLSiP+IhZD8ZeQ5F56fqj4o8SfRXp498s6GW+aSqw0J++5DCU77v21cu
	eaq2kt4V9EIbBSIWnvpsjMwpfA0oS50ZK2oJsfj0E39o9YNEIh4oOUdEwIC7BjpJQSNm0qGX8/0
	6YNhupwdRV98duxpfF
X-Google-Smtp-Source: AGHT+IEiFbkrpONQ4XqXk19ByjgEAHG7EmwNVeSeBkfcrYsWrMW7FZrDKlSQ24Q5Qd7fFkQP/hDrrQ==
X-Received: by 2002:a5d:5d02:0:b0:3dc:2930:c7e3 with SMTP id ffacd0b85a97d-3e765a13065mr8441662f8f.35.1757933173856;
        Mon, 15 Sep 2025 03:46:13 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm67163365e9.0.2025.09.15.03.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:46:13 -0700 (PDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v18 8/8] MAINTAINERS: add myself as maintainer for AN8855
Date: Mon, 15 Sep 2025 12:45:44 +0200
Message-ID: <20250915104545.1742-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915104545.1742-1-ansuelsmth@gmail.com>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
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


