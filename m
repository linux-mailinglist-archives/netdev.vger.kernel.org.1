Return-Path: <netdev+bounces-249113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C5D14653
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2FEB30081A5
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9AF37E31A;
	Mon, 12 Jan 2026 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASIC0QAa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64EC37A4BA
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239368; cv=none; b=qk4WyDkyaPylNJGo/vxoR2oTsjKN5WFkvZEo8yNBUwpie9YIrk2ZHwAeH/Mb523Tm1red1FfDyWwJem3DEtmdMxW2Km7OkCUfgQCxhL+ROp9zDixl6nHsFfBKIaPSpIwImYf+LS+0ll1As7dvvcS+MS8Q16akqAcaNYqkwgQKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239368; c=relaxed/simple;
	bh=qhaneb/ITX8BfdzzKqTGjLQZIrHw1/KIZJZVKgONY7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T806avIgb/giwOBOGTQdNdlmvUQUxfCBCjQRxt+91C4SClEe9vQTcBk0NueBYLKu2srTi4+ckjqurrBFpkFU3EME5SfPM30+BQkMRkAGsZ/loq19Gg6n3TcYWME9nVuZdLhLqYP89pj7ehmTd4cYDO0ut3WjW2eg0Q99qn0il6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASIC0QAa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so5740813f8f.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768239365; x=1768844165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LofV/9jgUKtLuCH/txad3m3y4ltofMV2NrIML7mtBRU=;
        b=ASIC0QAaTm8EwN2Xp9fzxcmQOHsKRlM8olVtFoiknXZc9E73MIWU3/+nR6loxnSCXd
         7IOnKnYzGytuZ6PsrKZC8/4eQuL2dGmd18elLezY6wlVsQaK3BYHUQ4PQgxjeEeYiOm0
         0/30JBjPoVqScEBSFUQ0PTky4SzZwy7RO4MGQOOZ0OtO0jw1l+pEuc7NnuYjFj+Iblbc
         cOMkNs/7LSTU1oI4oiop/gzlXO7mLrqPx1cyogfX+heVlnGwbtSw99dEsr1I2qEI+ahl
         6cHoOVAJFPsz9Y4PpEU6KNLuryGWbhfQa+IgMNUB5VI0ZLGyP+bsJ9/IjBadEIVzYYrh
         Pc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239365; x=1768844165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LofV/9jgUKtLuCH/txad3m3y4ltofMV2NrIML7mtBRU=;
        b=f/DxBTjlETR1hlS/gycJD1rFBdNYFOM2epgIAjy8OA1vh5vp6P134OUSdNz7QjKl49
         L5ikrCsEUJjT/S+dYQi3tIoYRZT71o/6Dk8MDV8yxQzNcoS9B1k0aO5npSKovHir7SRc
         rAgvXkIaiP3sWUlV0TFvmC5RzHnfBFu0O/VXEv8XOrEqzkGLAPh3A9b6QQwL+pfkj4ok
         fObWyF+5XtrxzH1OsG6LsupIHXCbPCAKPCmkj8o+AUDYojNgUj28nPxnXIMuexNcxRRR
         jlcjtls9toiSdtb4eLO5o0Natkpty9mdnVBhy+Kww6TaWdOhN6lBYd4fj6ICg+y5zTxK
         i05A==
X-Forwarded-Encrypted: i=1; AJvYcCUlNXm8EXCAXafgAAuCAi4dkXzVh82OM23drrVdXy5gtuPQ+wuYbOR79r+hzVvFJQLByUr0JCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYFgDvlCeiVbzOyzI3HVtRofiyBgSlv6gCkLy/2p24SQ1pFdM
	X4e4rI7x2xij/oxA8mrUri2d+FBlhMqOWZbe53YC24G5yDkI6XiD8RQO
X-Gm-Gg: AY/fxX7IPatv2Pjks4VjHPJVCf+IKbCCEyBvLKXQ1coc33vYCBbDfE5eU0J4rrVOPmm
	TcghOQKbMTFM8W0MKu9pOD/8Uw9MiPMH1O/Zj3R0kfn/UQRjf/dunV9lZjGzgKsM5D92X/dnJAf
	I5LZPtBE5ucCTxw4hKDdWgYL+V3iDzhuFrBFe4sxcd9o7yTtWpeuD3JORSTYHwem4qjCPyeEEqF
	h0060ToEUBSLwRZQKRUIPNB4HQNDtJSxTqxXFRX9dQz9yQleQBYmyfvmlTbvy+4TQUkhjT7WVjM
	uS+R4uY8XYWZQwUmNkSwzlF1Q1+cC3ckoNfTfmuaJ6/TnRN7zIaOcAnBs34GLs/pUKGtC5iRKX+
	39Cs3iWTDB9ViZI+zXP3Fp3ytIsZoknrvjr/mGmkOcNH9XWBjam7pkbrtPqR6NLAOoKDeaMSEtu
	bNies102UBj1Kr+GDTzG94xN0MUBHh/vtbI4rTSbrcU/6tovQ0vL77XrROcDSyFnxQiiir4QeWR
	xm409TcMTgC3NmzgKS1tVhy
X-Google-Smtp-Source: AGHT+IEsEyE0BOISsSRMidibssI3SeWdxDaxfffmQ7He+i2Idme1wQ2WQKE8+LIdSmxGLQOJmqbBcg==
X-Received: by 2002:a05:6000:1448:b0:432:5c43:5d with SMTP id ffacd0b85a97d-432c37c87bbmr20748927f8f.36.1768239364905;
        Mon, 12 Jan 2026 09:36:04 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9336:b2a5:a8c1:722e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff0b2sm39625403f8f.42.2026.01.12.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:36:04 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: pcs: renesas,rzn1-miic: Add phy_link property
Date: Mon, 12 Jan 2026 17:35:54 +0000
Message-ID: <20260112173555.1166714-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112173555.1166714-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260112173555.1166714-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add the renesas,miic-phy-link-active-low property to allow configuring
the active level of phy_link status signals provided by the MIIC block.

EtherPHY link-up and link-down status is required as a hardware IP
feature independent of whether GMAC or ETHSW is used. With GMAC, link
state is retrieved via MDC/MDIO and handled in software. In contrast,
ETHSW exposes dedicated PHY_LINK pins that provide this information
directly in hardware.

These PHY_LINK signals are required not only for host-controlled traffic
but also for switch-only forwarding paths where frames are exchanged
between external nodes without CPU involvement. This is particularly
important for redundancy protocols such as DLR (Device Level Ring),
which depend on fast detection of link-down events caused by cable or
port failures. Handling such events purely in software introduces
latency, which is why ETHSW provides dedicated hardware PHY_LINK pins.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- Updated commit message
- Renamed DT property from renesas,miic-phylink-active-low to
  renesas,miic-phy-link-active-low.

v1->v2:
- Updated commit message to elaborate the necessity of PHY link signals.
---
 .../devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml b/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
index 3adbcf56d2be..f9d39114e667 100644
--- a/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
@@ -86,6 +86,13 @@ patternProperties:
           and include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h for RZ/N2H, RZ/T2H SoCs.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      renesas,miic-phy-link-active-low:
+        type: boolean
+        description: Indicates that the PHY-link signal provided by the Ethernet switch,
+          EtherCAT, or SERCOS3 interface is active low. When present, this property
+          sets the corresponding signal polarity to active low. When omitted, the signal
+          defaults to active high.
+
     required:
       - reg
       - renesas,miic-input
-- 
2.52.0


