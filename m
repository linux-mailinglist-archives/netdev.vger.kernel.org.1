Return-Path: <netdev+bounces-259665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMpRLcAbmGnp/wIAu9opvQ
	(envelope-from <netdev+bounces-259665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:30:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4F3165ACD
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC3A7304DC9D
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0365335575;
	Fri, 20 Feb 2026 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NUbOJd0b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75A314A67
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576076; cv=none; b=IrCdWbhKduwi/kT8t2H4EI0vX28fmYP8g3cn7qazkL6+OX4S2ERTXZaFQaDgTxFuaU4d4HUbr/47XmeYivyUxAy7eOr4nnr1Y1o72yoPvEATVsCrjT4N456731lzAvl9XsLLQwH5wLShJVZGF6B6h9v3o2ZI82TItF8oPjzbVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576076; c=relaxed/simple;
	bh=YJgGJZFBEeFnKwCZBKtMF/4z3f6ENQ0IR89Zow+dMes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQb/TjyBWeQBXvQ8lS7TZ7u4+9l3iEM651iTVmlxfv71wPej8jZhAxkqPfirZFoaapz4GjY+tKWucHO5iO85H9c1WVvvUwDd/LgF9aLImKl7qUmrHCN/WaGvbfKlN0MfY/P5pWuviMXW5HH8My6JincVxaBZHPveBlaFqbN3kd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NUbOJd0b; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43638a33157so1675191f8f.1
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771576074; x=1772180874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/igY8Az/VsZJlm1xDZMRduuC4c0JTGDigxQuwADxBg=;
        b=NUbOJd0bZmG0zBsPKdchttp0PlH94khuvEr6kwhcDd/eaWDFZ3Xp9CEL44kBl3vsHi
         Y//Yrnry51078svhQ4tfM89YdkTSOvV++9lAIgkyFJy/g0mXiuIC5uAJjNfnu3TjaBma
         c+H2g1QF6wqVyeQc1fIeKggSxLJ1AZx5QRNcP86q5TP2RtdWd+3n5u1Kcha3emR1q4hw
         JajhN7BermOl5guKuZJhh6IT2h+oCQDoGlqwhuoYjxOuq7imbzOo+gsY+0rr2YkeNugw
         o0/Ymx7yhLfZjzao0vvdHQ717E+lBaABVrYbwRPyr5z/fX3laD4mWxERsrQgqO9IWStZ
         lJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771576074; x=1772180874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i/igY8Az/VsZJlm1xDZMRduuC4c0JTGDigxQuwADxBg=;
        b=AceAYAdNhIJzaknpPrMfeJCdKDqsPVdpw6KRXVzhsJBHJv2RHxRSUe8Ev6GRGmFZqH
         FtrUz96MlADXlJ2mZ4TbXAXwSbM6g9e/uKvCC+2kDRFqnfaWk6MPLY+5GRTFF71uy6gn
         3Xuum4fC+k1+ckDYLRuCoKrE5nYKqk8kOoaJ+JV2o/etQltNoyu8JYRhoBw4RJ/W9HTs
         dp0scU21kqXhb1dhupG6I5UkI8PNnl6aFWBLfV8U5iBn/JYnJcIHBVoXq1i7EuxzIy0G
         qzy8E6kc+6fGXT3C3ifopiWATwCkx8ALf7Fe1de69X4kX0bMHHDxmAGDOpvDD+41zk93
         aEfQ==
X-Gm-Message-State: AOJu0YwGFhwY4qX33DnJ9G2wpOm0n04FKBg9JQcknpYZpMkhXkFDpWEo
	W5yCcTlCQERMFhO94G5rBe3yQHA4r5p9LLKL8LO1cdwL+iVrYnjoEqhGapzeGpEmKFc=
X-Gm-Gg: AZuq6aJDlWHKkOLuXaT7hvQ0p6eLyByo+ru8gc1MfGVIU9JdF062BpmwRiQ3mHsfAXQ
	TXGHUol5hbdnHfm7L0Seewd6Npmi+Pjg9vMDZEy9qtfF94uSlnQ3F4XVahoU8PC0f2Nej8Ox9cZ
	IVArao8TVq3AY6/KO8qD0mWBqysf3//Oj3e7Mm7MOkn5h7kbPgSACZO15d57o3mBm/vRBxGG/Hc
	rDDcsRjzKEEQJAoslEg7XSzxSTLBiW0N/YbFvVxfh4Pjzina93SyeJVIeU/PcBAoLuwVFTTtOeh
	+44ceHyjJn56pnRjHXpCijpjA7gv4FuIdnnyLHnxvck8IhxP1nxpG7O78PDhJBGekJr72VaB6Jk
	AffwKBu0/+aIqYrezHOWsTP5Uohn9+Gwndgv4BI5Uk2Qw6hir83dBi6GbL7FqtFgM4SVrBn5pTb
	y13RZwKOfneMexTDWA/2VA
X-Received: by 2002:a05:6000:3103:b0:430:f68f:ee96 with SMTP id ffacd0b85a97d-43958e4a763mr14559959f8f.36.1771576073712;
        Fri, 20 Feb 2026 00:27:53 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm54717688f8f.13.2026.02.20.00.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 00:27:53 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 20 Feb 2026 16:27:05 +0800
Subject: [PATCH 1/5] dt-bindings: net: macb: Add SiFive FU740-C000 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-fu740-v1-1-c8af54130c58@sifive.com>
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
In-Reply-To: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Conor Dooley <conor@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=YJgGJZFBEeFnKwCZBKtMF/4z3f6ENQ0IR89Zow+dMes=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmBr8Oji0/4OVhQOIUlKAIgJBQ5IPR4YxPGYhh
 goHXM5+HRiJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZga/AAKCRDSA/2dB3lA
 vdGEDACBZOQzifNbSjKgt1DwPNhFpnL3Bj+UAEIr0weXbZ7rZsZ2J71Bn7D2TjtbPF6gSUQh9TB
 u23Gvon4ro7QrbdH9K+Sg9Dhe50X7LjXj978B2jLf48Jb2xVvo32OBNuvHZidvgOv5ZGsuMvfak
 xlX0HB2czT1jn/Orh1i/zz1UW4/pMcGGgOhZ4/BMg6LutjuEic9quiKJo+oXqeBwySJmq4RTVbK
 zC87a0yqs40PXIHgUC76c9JjqspvRjEFVXRqY9vYgi5DQhRPOZIrjO196ZK6WDj5vrVT67yCkEc
 gRZeiums12ErPNalqrAOMceY3J1vHscNh2BzhAUmh50Hztck0BMHRc7TO/S/ExWT4yXFbwA2pfy
 41fHmAxMxpliC7zdowFN4ftLDrnxI05dS31ML9SgUoz82WPlypMS47DOw3bPrIMeI95HF3zRgDM
 7QdyG5280seME+oT3I9NUn6bVru2yTmihfXUlKeQs+7F+34waoB8I+wODhRbKVuwkaRpY=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259665-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:mid,sifive.com:dkim,sifive.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E4F3165ACD
X-Rspamd-Action: no action

Add the SiFive FU740-C000 ethernet controller compatible string to the
Cadence MACB binding documentation.

The FU740 ethernet controller uses the same GEMGXL management block as
the FU540, which is tightly coupled with the Cadence MACB IP. This
follows the SiFive IP versioning scheme which requires SoC-specific
compatible strings for proper hardware identification.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index cb14c35ba996..b46dde1da170 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -63,6 +63,7 @@ properties:
           - mobileye,eyeq5-gem        # Mobileye EyeQ5 SoCs
           - raspberrypi,rp1-gem       # Raspberry Pi RP1 gigabit ethernet interface
           - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
+          - sifive,fu740-c000-gem     # SiFive FU740-C000 SoC
 
       - items:
           - enum:
@@ -74,7 +75,7 @@ properties:
     minItems: 1
     items:
       - description: Basic register set
-      - description: GEMGXL Management block registers on SiFive FU540-C000 SoC
+      - description: GEMGXL Management block registers on SiFive FU540/FU740 SoCs
 
   interrupts:
     minItems: 1
@@ -181,7 +182,9 @@ allOf:
         properties:
           compatible:
             contains:
-              const: sifive,fu540-c000-gem
+              enum:
+                - sifive,fu540-c000-gem
+                - sifive,fu740-c000-gem
     then:
       properties:
         reg:

-- 
2.43.0


