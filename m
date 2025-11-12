Return-Path: <netdev+bounces-238125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4FC546D6
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F6614E89BA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3DA55;
	Wed, 12 Nov 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kspnNGkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C62C0F7B
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978807; cv=none; b=gvdPhYJZ3VYAWNDjHQOlWXcd9O8AA7mKVyof5BF5zIMXv8OhvXeWcORFS7nzpTAseVIe/ttCgzMmeg9zvVIYtATDPfcxpdiXrGnkIkHCoMc3Eh1EmgqgX+musWTyDe9BSCNUpObjltrmEJJDlt6P0muUVxqksluBb5AWVpFjql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978807; c=relaxed/simple;
	bh=/plj9fh/IZTy6oZAC8Dfhmcc4NUzFHy253uswukPQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPrKttihrKf6Qg/W+ccyNBRVfRCA7bZ4hy4549AnLQwUXo0/zXtoksuF+hVq0QHcUKxk9ZA53R2nLdtwc9Dc5XdINB9SENXGs+5SWvdWaRETqZEP9NaQUfJ/HtJrUHKjQ2SGawqlv9wOIO0aDfNjJcLqqOyEt4LdW/IMbGpP0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kspnNGkv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso35339a12.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978804; x=1763583604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/vBXqyh3UPyAQ3zsAxz2ig4U3J84dfQKbNA3jaUdzo=;
        b=kspnNGkvldDFU3englaHpott0zd5VPTj0s3hWJTLiLDhemBvyJPerksTmCMwBwjbKG
         019SusppVMeq1Xh3ndVvsOtTaPsS/eYggoRrueYikBPcjjfOaJTv+pNX0wu31zNa6WyT
         O53J/Ds676Nsdm1N7bfoSOaFMEbCu6P7bqVo6ppNKqjYGpH65bC58M+BJZSEtTlZigSH
         KOg7RgLtEAfhTmUujMqOstB0+UmTZouZUi1NtGWsCpbUnaaFOoiZEqUq7Cs5oLYu/mo4
         w20a9v7SvRa6yU9Hse4rgBfYtRtQgbLm6SQFa54l0l/9BSUZmJuvkptD5v0aoc+FUe8Y
         JWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978804; x=1763583604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/vBXqyh3UPyAQ3zsAxz2ig4U3J84dfQKbNA3jaUdzo=;
        b=PstrusVyu4HC53o/EcxQV9BIpdq70b8yh6igSTKcQgejqZcZofe0nPO7ihGa+fgxl/
         REf60RgvLk31xvaO3wydLqhsk1liUzo/DwO7tbo4GmO7QE1u3g25RS5j0/Mal/ANRMAj
         gNu5GHZbsXkSkzY6uJSuZUkHOpauOgeC/yWzekhbzrwLMOAo3gEKfDx++BsJyT/EPpgV
         BHxJBD2hthGE8h+8q+3+OMXr2nvXpLLe1HX6R7/YfvxBtVsOpAbsbbz98WaVbJM9AZhB
         +k6MaKq78GELz+74NJ654ozeeDa27rjfzHplqX3uSR1wxSlEtr9rVP/A1wghrs0lo/EY
         jcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbli4CzLX8Rz7NObSFJpAOyppER+NF+vdUzllgJN8Bd4xmnO/UKHmUJWEzn+Jfpo+wGoD0eWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHHkQIy3Bb0W8GymsRZI5XU5fQ1EUdemJQS04nuAQ5V0VRDKT6
	c7y5Fq/2j3qIWc08sbyvx31wugiufnP5OB3Ul/3rtgL+ud9IxdCurCOq
X-Gm-Gg: ASbGncsOGTSKOgwi5fF5V1djs9kvC1+aET75fltKLxv5/D+JG9efsLxNUIUdiZ6o5p2
	l3E+MaTOBEnuwy4qT1bNNcMSBh2itsC9ihGLzbmhNUsM6mexhI5epfJyIRUMS3fcE3VJoLkHa/O
	2+Ne1+yktGFOftrL1mH0H5gJK9AdiZXnkodLP214BbJMkn6QIKotg848+ZNkIum+p0xZtQw6eKW
	t64MOET7f/Pp2tXWNeW9JwNUOFILDOpSEz8mji9U6mkxf8z1R3MqYZXFrcrufuJGaS813AMb+1R
	DJicBEJ1FSk7COEGAgaJXQ0R34nA4RiXAh7ngfxLz3IfZuCG+rrR2VjEm2eiyf2buzpdsCfF/Bs
	I5sAvgOhLYVWf286lpeY6lpxmZHA2fvmv5E+F4Ggs60tCaq5BXel3Pt0gpWz8dkCPokgS62iado
	zNVRAVnYmDqJZJsN+2sbxnwQ==
X-Google-Smtp-Source: AGHT+IHD3owK8YXgdkefa4KWcxQZCFPmAJLbR/Dh5Q2mfLUiYfFz0jmPuayumGBai8cChDj7akOlAw==
X-Received: by 2002:a17:903:244a:b0:295:54cb:a8df with SMTP id d9443c01a7336-2984edec25cmr53252665ad.36.1762978804106;
        Wed, 12 Nov 2025 12:20:04 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5748:721b:a500:103e:1bad])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2377e0sm261015ad.23.2025.11.12.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:20:03 -0800 (PST)
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
Subject: [PATCH net-next 1/2] dt-bindings: net: pcs: renesas,rzn1-miic: Add renesas,miic-phylink-active-low property
Date: Wed, 12 Nov 2025 20:19:36 +0000
Message-ID: <20251112201937.1336854-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112201937.1336854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251112201937.1336854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add the boolean DT property `renesas,miic-phylink-active-low` to the RZN1
MIIC binding schema. This property allows configuring the active level
of the PHY-link signals used by the Switch, EtherCAT, and SERCOS III
interfaces.

The signal polarity is controlled by fields in the MIIC_PHYLINK register:
  - SWLNK[3:0]: configures the Switch interface link signal level
      0 - Active High
      1 - Active Low
  - CATLNK[6:4]: configures the EtherCAT interface link signal level
      0 - Active Low
      1 - Active High
  - S3LNK[9:8]: configures the SERCOS III interface link signal level
      0 - Active Low
      1 - Active High

When the `renesas,miic-phylink-active-low` property is present, the
PHY-link signal is configured as active-low. When omitted, the signal
defaults to active-high.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml b/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
index 3adbcf56d2be..825ae8a91e8b 100644
--- a/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
@@ -86,6 +86,13 @@ patternProperties:
           and include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h for RZ/N2H, RZ/T2H SoCs.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      renesas,miic-phylink-active-low:
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
2.43.0


