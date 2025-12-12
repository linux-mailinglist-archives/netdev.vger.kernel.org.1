Return-Path: <netdev+bounces-244469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30415CB8501
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 09:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 962673009113
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7257A30FC04;
	Fri, 12 Dec 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeMM++tL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E622D592D
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529229; cv=none; b=EQKZl8F6B0xYqk2y0BnmZMqKt9/U7NaoJg03lUURDgErQvRPeqbyGSM7CZsIlYgc5rSyJjl9Js7O179kXP2ZEiF3J98aiNJ7Wb4hBI5MIxGzfcfjXxD0WbuQJKBZAMF9aAj3eqg8eReEMexWFxhuts0vPW97RQXdsnK9kHEFXek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529229; c=relaxed/simple;
	bh=O4j1WHeYWmlVfXspPLornML/5pfXlu4tDPMIixs7c1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFXa2URnePVM0Wpc6oORIx9tEFl5LMMAUOz92zD69meUN9b20PsenM+NaySrLAsgaOii3Wh0puID1pPSzUS/Tol5mzzwED5cScwvLATk9sB5DnNm1k6i4tV0qphSqxO/TD8nmEKRYHDaFvT3a512m0DOBFjJrnLBIiimx6Ody90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeMM++tL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fb3801f7eso241427f8f.3
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 00:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765529226; x=1766134026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwFLBwyOTuUthLXbUsz0YRPUpQojC489N0xdVPk0niY=;
        b=TeMM++tLA8hpwY46H1QO7EESvifooEfCaYQH+rpOx8L/FB+ZJs47J2TGTbyt91Dsvj
         dx29r6JbBlBy1xB8Wv63Hv6+0Pxe3zarY9UHpYgL9BIUcQGeD2vH/NyD7Fm4ul6RgwLn
         XgWCtO0/81wj9szIPtnB4TF0GBczKL4GILQZiQDrqhoPAGi+mYC0Skzu3n+XcaQ3x4Mo
         GE7AQXvRi31QlTji5f/sdXV7s6wcytoVZxFmqlTLo7ZFKaEblcqj3U/wVF0R2riIT7Vw
         cHEYuJvbatcLQYc27r9M/dDHpYHm7AKPEtxanfMbY2fjog4XwncsaahsAer4aGlmAKZr
         NW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765529226; x=1766134026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwFLBwyOTuUthLXbUsz0YRPUpQojC489N0xdVPk0niY=;
        b=LRhkuWhY982wbPRSSnL0WDaQjFXZu8yhaZlxEUPcEYaIzVwUJZ2D770usVHPb3e98h
         sNSglJYKVN3vaLNcAM4ET2I70M2UmiIiFZPqh8BqLboHPO6mr9MlOmi39IWmrwvAu7gz
         5BkpBCsYbctL4zH0HfvT9F6ETAmdyyBXbfNaF8CMvcOStvlrFSttdwf/UJv4KABnZdoN
         KyJeOpyIgTCcTAQM21I/thGIT1Mc6ZqG798K01Jfjq45ZKmwYyGADTSFKo3DzIIrepOy
         JqSbPxb3lQZY6FISYc0KzdG7na7hg+OI3cMp98KYSAelp6sDwheN7PeFwKkREwn28Sfk
         OlUA==
X-Gm-Message-State: AOJu0YxI9zMHEN9vdk/9GYJyHOOmCQJuviliDQlnIFpTbreyyZJdb9JP
	ByXWD9BGgWNhIB5Qr4GK56b4vP5G0Ke4PNiMyxoyQ5f/K4jGyFggXNyj
X-Gm-Gg: AY/fxX6cijZO+xTY1ShkMvj8Vrl3kohoFSZtu3IBZcoPoalPyOBfXsqj5wMtmD5yEwp
	k7rg1IL5N/YJLlRPbt+5ZoiMM0gp0YwG+U3QOptSLt/vxI8ZEY5W3BWwq8LY3WPDGXsrFJ1gVvs
	Tdtx/bpp6mTkEkb3BbHWT9RaGNiRUGNIhvybak0pI5DGh4/gdmcChWyvekAtt9SqnuQzzCKS4RM
	SNWeJrmtl2UOii6qWw8ar0z8mHLwJTcBj2JR3RPH26t9j1MdAD2FRn6vSzTN3H3rRncHVn7jXMQ
	eodltr3tQHvTQlR3xNPRGRjXz7qIGxNFApSTJNHNItJxqkiDmb+iT3risRni5AMKoPu0q+N7xiN
	s9hEGsL+2qXn5jrkdwiI4WCcQnF7q4Wm5uty5m886do3MZPi1wI8iqPTM1Rkx8Jir7dRXQhsWzb
	8YykjIgLJlAh6Ttiyy
X-Google-Smtp-Source: AGHT+IGBiLjGhGraX7AWtHZ+w7lR3FUkHC9JwB8Wfe+B+to3J6OlMkVqdEcn4aprm0IQnWmS9b5gaw==
X-Received: by 2002:a05:6000:26ca:b0:42c:a4e7:3975 with SMTP id ffacd0b85a97d-42fb48fc26fmr1135644f8f.30.1765529226102;
        Fri, 12 Dec 2025 00:47:06 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:9f18:aff4:897a:cb50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm10456076f8f.0.2025.12.12.00.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:47:05 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	geert+renesas@glider.be,
	ben.dooks@codethink.co.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH net-next v1 2/3] dt-bindings: net: micrel: Add keep-preamble-before-sfd
Date: Fri, 12 Dec 2025 09:46:17 +0100
Message-ID: <20251212084657.29239-3-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251212084657.29239-1-eichest@gmail.com>
References: <20251212084657.29239-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a property to activate a Micrel PHY feature that keeps the preamble
enabled before the SFD (Start Frame Delimiter) is transmitted.

This allows to workaround broken Ethernet controllers as found on the
NXP i.MX8MP. Specifically, errata ERR050694 that states:
ENET_QOS: MAC incorrectly discards the received packets when Preamble
Byte does not precede SFD or SMD.

The bit which disables this feature is not documented in the datasheet
from Micrel, but has been found by NXP and Micrel following this
discussion:
https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032

It has been tested on Verdin iMX8MP from Toradex by forcing the PHY to
10MBit. Withouth this property set, no packets are received. With this
property set, reception works fine.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 Documentation/devicetree/bindings/net/micrel.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
index f48e9b9120ca0..6d6136014cd62 100644
--- a/Documentation/devicetree/bindings/net/micrel.yaml
+++ b/Documentation/devicetree/bindings/net/micrel.yaml
@@ -165,6 +165,19 @@ allOf:
             supported clocks:
               - The RMII reference input clock. Used to determine the XI
                 input clock.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ethernet-phy-id0022.1640
+    then:
+      properties:
+        micrel,keep-preamble-before-sfd:
+          type: boolean
+          description: |
+            If set, the PHY keeps sending preamble bits before SFD in
+            10BASE-T mode. By default, the PHY removes preamble bits
+            before SFD.
   - if:
       properties:
         compatible:
-- 
2.51.0


