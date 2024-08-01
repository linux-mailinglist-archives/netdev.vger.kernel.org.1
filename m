Return-Path: <netdev+bounces-114935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85332944B5B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2135B24C9F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8CC1A0AF3;
	Thu,  1 Aug 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m13FokNd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BCF1A0709;
	Thu,  1 Aug 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515520; cv=none; b=oPEbvgkbUmVjUVdt8UXHsfsQje8prDh4AuKNKT5mjL5vrGih3pQequJvfjIPJRAihXEzfpW2eCyM2EhT/Sv1P1hX/PIhe3/JYqpH5Aqdzps8jAfvUVuHwFYfgAvXXHSYlQkCFVpzoJBYmSkGZ35OcjGXhpHbML4SUaZfoDp7//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515520; c=relaxed/simple;
	bh=Lwd5uYc2wx3kq6kOhli0PphC95AuPuQ5kNj7ORu9uPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YX4vb/F7Uf8yu6X93qK+Ir/XK8IUFxrFMkYyXXZgeUFoF5vls1ZjmKrYzT4w3V096GAYgiam0AIYhsiQmJW1iXjGozg8a98xM1fdHBVKVlz8AfPkO31U4My3UrRuImGNZKWzuK4S46cp4jp+LApvJ5bFvSQ8XyaUKbuRIhM5LyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m13FokNd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aac70e30dso849788666b.1;
        Thu, 01 Aug 2024 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722515517; x=1723120317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMGhRoWGp5QSCEawcod8aPtfBFHzscxgaLpRD+oyyJo=;
        b=m13FokNd64jgR8C23rNXg2jsLC7kooLWhCQLpKCcv9MN2jGJ+iU6Xa0ce0OuKSlvC5
         omxzW07/8k+SCbYiX68uL6wy5SGr3HNUHAbmD5kcPcLz/th22NtkV52egC2hb+IOYQMb
         C4TxtwTTEjtU2RZQwB+K1Dr2Nkk9SRPnTDDuozgHg6VTsoTL6EFN+d2t7qhO1yWVhabJ
         +bmlcGYG4P+F2Jp68TcmQ0hWLx8SeDBJOEajMGAB2/avw6yXI3V/Nw0+4lMswE5o67la
         9EK4Q0SgXtpW+7C948AKXU1TsTqmGaISKV3eo4IW7pONUz5BxtTeQY/JLoXWSssgDeJI
         TqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722515517; x=1723120317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMGhRoWGp5QSCEawcod8aPtfBFHzscxgaLpRD+oyyJo=;
        b=TQmCanBx7gworwuSwi+h6PTJZ1FcXbvrZIkuyxlZDWWjHCIUUOoM0nFB3AujDgJcxn
         A1MmiOTIaNsiIX1vKt3q9FcvNcBd8HRGn1mKKQpTUePR9PPQ9WMsh6P6sSQQaDg5fKAM
         MDSz2AKPnFeDOLRyj43q08NlOjEH6Vpuh8jraTGYH6nQ0uJxENWtvU9PBCmUKaAcFQaJ
         esnKLhT3ea/yahPcrmOHo40w0oJv9l5LwyW3RD0ZTHTkuRhTm8yA1IuVpEzeQr2Kr0s6
         c1Ej4uPCKTrRGSxc29KG8FwmXtmXeAZ5gupJVZgpkfX8/GDvkZ5SGbVR74F/AS1a0zaF
         Lrhg==
X-Forwarded-Encrypted: i=1; AJvYcCXyJIIomEXipqmd5eJO+8IPDimW8eVkqQQ6WbXIaiPHTDBY12LoLrYrSePN078Cv1oGwULR01LpaloTNO8G4afIK0l1ctpB
X-Gm-Message-State: AOJu0YxDJZICgJDe4OV4fXiAKB7n8E5HqgrB7sMHhYqDuGME4pZmPQW/
	eemE2Cb0E+Nq4+sWhmCClvbL51GgAXcbILge92AhUB3ia7Y9DDs+Zf+nl5Cctm0=
X-Google-Smtp-Source: AGHT+IGRbSlKFiGoT178LS5x+vS/79W4l2zruxXUvd5hZGAKtEWMOcbjVhTF9dZcTdIhz3teWqb6uw==
X-Received: by 2002:a17:907:2ce6:b0:a7a:9f78:fef with SMTP id a640c23a62f3a-a7daf657084mr139834366b.45.1722515517167;
        Thu, 01 Aug 2024 05:31:57 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23125sm896146266b.1.2024.08.01.05.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:31:56 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: add microchip,no-tag-protocol flag
Date: Thu,  1 Aug 2024 14:31:42 +0200
Message-ID: <20240801123143.622037-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801123143.622037-1-vtpieter@gmail.com>
References: <20240801123143.622037-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add microchip,no-tag-protocol flag to allow disabling the switch'
tagging protocol. For cases where the CPU MAC does not support MTU
size > 1500 such as the Zynq GEM.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 52acc15ebcbf..798dd3c76ab6 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -45,6 +45,11 @@ properties:
     description:
       Set if the output SYNCLKO frequency should be set to 125MHz instead of 25MHz.
 
+  microchip,no-tag-protocol:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set if no switch tag protocol should be enabled.
+
   microchip,synclko-disable:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.43.0


