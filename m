Return-Path: <netdev+bounces-117761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A8294F1AF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050C51C22053
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD49184559;
	Mon, 12 Aug 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZeMzpCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA202F9E8;
	Mon, 12 Aug 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476632; cv=none; b=ZDvKm99z71BLuLNPrXySoCv4rmZEAOuNVfEZoGugu9Uzb3IazdI/UNzX4dBueleTbul0CamkM1UjiLAQLSBzATYIkLn8aBM921r3Bw44ie6ICi0wVvv+IZb2c/IzsVknD6JHfeJ0lHzxPfU7LumJ95W02mZ0Vs8xlpSDPURejDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476632; c=relaxed/simple;
	bh=MNnLV25K6YhULXYYlXhNI0BKUG+LUYqABdwm34GgDDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmMmF8qEtNOXX3XkWyQNO8qeTRbjiupUiknHrPU3oeldkb2OJ9ICwMPMvKj45pUYQnq6fF78958hJ+SPu+0lxUjeUMN6L9TsuAEHF5OSwmHnvNOi4/c61Q0Cc6UQH2ifKhon7iuzdf8dI/uC5yobXUBnBekWEB/3e2QKUrBMDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZeMzpCA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so5238946a12.2;
        Mon, 12 Aug 2024 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723476629; x=1724081429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=FZeMzpCAxtdTy7imaAhSTx8X3HQD3YKQGC7Xw6DCk7RdVNRVEeahR0a9yzQmRvKFjt
         OkmISCUOL13G7UOw7seUNdgnLG0oo9H6u9vr/5GGunwT3JYIL7fGtUu6ZiCRlrL+SFpn
         f9ZQLI1Xbh9e0vnwqYC5tJgMASYbVKn0jPAggDKjnSImASgHFcArgutFofkLTBOUpXt4
         aHFdCK1nBp5VReMKCh+IYVfrb6FEdniLv8BwIhOaxVgP0qw7TgwcPkoX1DYp/5fi8oBv
         MLG7GeTbRTBfV7oLDyft4ver2S3JOoB06lDOX9MNRdOh8q3KjXb2oOCwr5CbQF+QJsqh
         IoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476629; x=1724081429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t11NvRdsE6tRyZHoH+rh9Stx+kDJmXVz4PuKIrvrxow=;
        b=mulodPTyznbzJXI599Z32Tcwf5KtiK3gt+bLAgX4yk0lb+dyvd/c2Uz20rSSjT3Mdf
         tBKQ4qSAC9NY2ScJ1Q1QxNzG+uNnRjFqWVovO12iH42rn7IE6+dM1LEqQzJeUwiifSFB
         eyxNvtO4Kc0AwrC0WSPPpzFfgUGxxOSxQ/FE4N+6eUATyPbpgml5g67t0++CWrLOzECj
         /PHnqecu+1sQR+6UAjHTdDfwzUwadMYrS1REA9MZD35Wk5tKoGaPPf55CJjXwgznBqP9
         +hGGMox5lDPJWFdVPZYUsL1823yu/efKiH2CIe64xoTCMOdwFLbIkaI+4dOPQtoLx7SH
         ScLw==
X-Forwarded-Encrypted: i=1; AJvYcCUb2kVdAr5tn8QL5i5y4pJAh8oiJkRo1vigUMz0yR8J2I3zxUaBcMOwR7zYLh1QpprYyQy+YhCju7OorAsksPBMf+QboCeigkPLbawan8GlfNImUErg3wuPIE2J6Bv3KsRWeu91p+CFtenKgP4MRijXlK1gWoFU7trPibXIMEmr7w==
X-Gm-Message-State: AOJu0YyBkBIadDgIXZRtsHZbB33OHjyws64PJ8QId4ULupv/VhaQd39Z
	TZjvOTEO9H4PAkrka4LGKLoOkMA/QsKRGy5LBLUTS4qos2eoWl3uzJA9YonCs3IjHw==
X-Google-Smtp-Source: AGHT+IHjRNP5SFuA3gr0sUZ7f/+SsH0QSenGJcjH+uF0+Gm9+RG7u7LycnRzr8D05BpL9b4YJrVGzA==
X-Received: by 2002:a05:6402:354f:b0:5a1:7570:8914 with SMTP id 4fb4d7f45d1cf-5bd44c27370mr531327a12.11.1723476628660;
        Mon, 12 Aug 2024 08:30:28 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a666fsm2192535a12.46.2024.08.12.08.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:30:28 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v5 1/6] dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
Date: Mon, 12 Aug 2024 17:29:52 +0200
Message-ID: <20240812153015.653044-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812153015.653044-1-vtpieter@gmail.com>
References: <20240812153015.653044-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add microchip,pme-active-high property to set the PME (Power
Management Event) pin polarity for Wake on Lan interrupts.

Note that the polarity is active-low by default.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 52acc15ebcbf..c589ebc2c7be 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -51,6 +51,11 @@ properties:
       Set if the output SYNCLKO clock should be disabled. Do not mix with
       microchip,synclko-125.
 
+  microchip,pme-active-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates if the PME pin polarity is active-high.
+
   microchip,io-drive-strength-microamp:
     description:
       IO Pad Drive Strength
-- 
2.43.0


