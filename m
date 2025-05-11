Return-Path: <netdev+bounces-189590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEC0AB2AC5
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 22:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECB2172B76
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73288266B45;
	Sun, 11 May 2025 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOy+i6pW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB93265632;
	Sun, 11 May 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746994415; cv=none; b=BbYvaRVd2Kc9i4vApR1ynP9TqeNsoBimeu/f/1JHN+SPH5j9RkZOFZjraamQ3E3eyBUXkEFDzbe6/OqETiLjE+oRm89We1RUgl4RopZNbtv8VOMC66Vk89TxDBYbmGC9vxQSIkxZxDjTmUGPKHi4ZK1VoiPzGZub9t7ZoLWa54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746994415; c=relaxed/simple;
	bh=CQQRGPRya/T/RQmdK5luqPwFwvLJepnnIgqfBudN7ww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n//lk9WSjmGVUJ+YGY9E+naSougmFak2tZ9oSVwn4Z1+SDfNVNr7zJ8ShWot9aIrEhkElIGooUOq6E706v7SdPO2OfGdNXfNh1AtMWNhpT/FDoyBahuxaH1h6R/Pb8zE/YFXHmCCz/DLCJtTWomzv1RN8zolq18nxYDV3870xn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOy+i6pW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso40053445e9.1;
        Sun, 11 May 2025 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746994412; x=1747599212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkLGswoAoqo/118QvnKQBtIy92ngW50tFunPEBOrZ/k=;
        b=eOy+i6pWRKFZ8Up8id9GxsRhKdlqshZSCsOMfchCo3JmhIVGNNu1VnPFLOOF6Bg5S+
         Gi0q9FstZ/Yb3TSTpyUEhXNoSmPXs5ZGe6OF9EvbQYG6NJzpE/IZR7sRSVTZvAqjlm1O
         gpQCOnBPilqbIaLLVk3fEtb2X09SEW/hjus14fu4zdQFD0QDC4kSSKCgU0jw+/bw7hfS
         MVRTPLhqgYyvKIU0mqKF3WlikaZ3jXI2niP7yT+gfiGqSHUMmIIO6IJKznFCyyU/B32n
         JkceQeg/Tc0GILXgkLH2IvLOOM06kG5gQ6z3uFiFmtTaktV+o7VtHcpOBTFmSk/L2Fdv
         optw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746994412; x=1747599212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkLGswoAoqo/118QvnKQBtIy92ngW50tFunPEBOrZ/k=;
        b=Xa/q3y/9MoX22a2lEvTkKRpR6LHciXpTHcMi8Olkp10zppZ7LI3dL/rRTAkTaOlccd
         03TpOnUq5L3JSTEnIWIfgiYeg1H9+7h5vAvOEVttqLZcRZ5LDUCIuJ79B7Onq04gRD83
         jCDEGze3AYlCPkfBBap1eOX300DEFB3ONIM/Ic1ExjzwgxCkQK9NDvVxAxj+RTZQQOhO
         0/SdJ3stPQLrsGF6OA14gApKOuxz7l6qfivsOnOVTdemiQkBR7RGVdUjl4eaym7Jebk7
         S97SI6KWEYkiDObKsEvE1AyeRjH0ZZnoUreEFsg4l/T+oa28ZWr+xfFHSDKdnjZEJTJs
         OwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Vvav+rJN/2VqXscyrye7dEyiZVlQvrAD8eQn2g9Dj5A1Y2sglSvd8wqqSqwatI9LFgCnZdxeCt7p@vger.kernel.org, AJvYcCX1szjJKgTD9JTR27JnGwqal8Th1OXSdhgfQbp+eMmyL8g+3DIlUjidFLQIKFIlGfIlaCPb2TvJ@vger.kernel.org, AJvYcCXBlBjghmZK1LXs3zVbJz4QPPpUjah0KxIKRDOgBLNe3MtOtAGFgpRBnVS0Khx4S3+GYWgLtckXTVLf95Ye@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8SzdSm8aPsBX1Uo/Qx7CrhhDSFDg7aaWAz2riiyK3dKEwBFR9
	5P7c1CJpCB/pcmciC2avphHZTdhZgZGaGQtXlaxbemuKXDuuzxsh
X-Gm-Gg: ASbGncvOVSWMCJgplBQ4mkOliodqp+jSTGYLB0ksezt2P8knq/nGh+m5d5PpCT0lgw7
	be3q772X1ARdOZZ1z3cB9RyRLb0ck5gijKqZgboQKI7eg333DF2c4Mg+yQcDG1kdY/oK6gldvad
	6OwkFzOGFGg0IOv+Zytg2wy4+AyrnuR9pTwkzrUvhMk+K4vM1L8DoO8UxooE6I1g091cOxrssIw
	85kcq0gVXP0nFyE3IzymBWobxDlLlUV0BhAOOx0K593DUaGe93IDp7CiD+NpJ23bVW0Hshoqwcu
	lPrrJTjmPkUS+Z9BK9CFLVEKypYmHrS0lHUqKgpttNlcEVo9DXTocA/+hEj6ZG/Z11wRD/5A1Js
	BZzERtaHTDfXN5Zpy1CrP
X-Google-Smtp-Source: AGHT+IFbxNC67QrJzS8ubdHLUfywR0W99gAi0Zl9vw1n/B+YFWZSNpU2mxOgGnTWER5WWOFxR4TBWA==
X-Received: by 2002:a05:600c:3e0f:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-442e1093222mr47155515e9.24.1746994411685;
        Sun, 11 May 2025 13:13:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm100615165e9.19.2025.05.11.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:13:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next PATCH v4 07/11] dt-bindings: net: ethernet-controller: permit to define multiple PCS
Date: Sun, 11 May 2025 22:12:33 +0200
Message-ID: <20250511201250.3789083-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511201250.3789083-1-ansuelsmth@gmail.com>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the limitation of a single PCS in pcs-handle property. Multiple PCS
can be defined for an ethrnet-controller node to support various PHY
interface mode type.

It's very common for SoCs to have a 2 or more dedicated PCS for Base-X
(for example SGMII, 1000base-x, 2500base-x, ...) and Base-R (for example
USXGMII,10base-r, ...) with the MAC selecting one of the other based on
the attached PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 7cbf11bbe99c..60605b34d242 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -84,8 +84,6 @@ properties:
 
   pcs-handle:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      maxItems: 1
     description:
       Specifies a reference to a node representing a PCS PHY device on a MDIO
       bus to link with an external PHY (phy-handle) if exists.
-- 
2.48.1


