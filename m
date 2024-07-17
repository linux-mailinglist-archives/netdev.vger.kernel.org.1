Return-Path: <netdev+bounces-111928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34EC9342A2
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 21:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF301C21494
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C131822F9;
	Wed, 17 Jul 2024 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNV7glOY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94751822EF;
	Wed, 17 Jul 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245069; cv=none; b=krmrtLApT9wPoKjWiuWP+lAN9Duhy/aXY+xXDeUb8uMmbZQo7gMb2wqbvP9AdejA7MfLzLm9Yis9jvpva2OMaWeII1nNeYj3WzQnt58xFe104BL2sqclBF5OtsDLcLfy2/93yDSh4SVNol7porqanin7Q9fK2H6u3fhqqh1fYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245069; c=relaxed/simple;
	bh=MvGmyci31eMwZbLogaFzHDrJ2yhLrRT9zRrQesoHWsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1rYkvStvcaRj8RFYuJXr1KXJdRHGD5qJFV9vuFoaEec/HZv0EI1GbxsqvLt8N+57Sf1/s9cuRzkhBu47HhnHURDUkQy0zRdwCy/kkSMLyGutylws6dZi4+Y0DgM0/9ucoYwUsmOz8LXUF8GEcHwK+dwiQqPeZFYKk8x2+v23HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNV7glOY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so6369e87.3;
        Wed, 17 Jul 2024 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245066; x=1721849866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj8jYrdeK8hA+in99RNrFuTrylx5hoLD9QjLYPgVIqw=;
        b=aNV7glOY2aCMvxGcoFUNOQvQFR0D9Nowz8kWwGwbhMTT+9kDQ3DzaaTNtGsP9hrQqy
         8x6Pf29nNuR1P83BTVXM8PdoqFHSl6K70jXLQUcjwbr3xcMtKeQyi5GvRkF41BPuXcYS
         VHeJUnCA1pQAcDozSxaXXA9rijU8IIizc/cD6LNSWi5MeizoJ6M3GfQ7M3psRv1sR9Lz
         ZzZB00EFUTiBY7H8l/0h1DpwKB1WHEc12ogr0L2phqw0QVQIN7Yi3c+W5VTevy/O9Qdy
         k4RoVvJXy/Z+so5x9FNr4M38JvHaUW0t7OeWPH/+tNwXn3AfyblnyjfGQGgO8iCUu9TP
         vodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245066; x=1721849866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj8jYrdeK8hA+in99RNrFuTrylx5hoLD9QjLYPgVIqw=;
        b=tEzWOxg8eGCwhiPgyka+JzzyiQzan3P34D9Y/mSk6Z+7s3kbVzMbCf+BXaWWqsokgR
         IZsFvMb2URxFxTUx1BIbtgYgt4Q8p8uRRkSZiFNI7Xoke/SIrnRz4CWQK6+6eOtlYo2J
         nOiJenNvrE66y73KoeeJh/0RHZVK0ehoyuew+TT1C3HFDXdz8as1NQHhAIZxJzIo6wb5
         dHBMcGWpEi3PuF40dhgDPiu/YaEQSq2MKTRBEeEI6ryAHOYP1bGwzM5XBoaLH6eUnVs5
         MyqASiCNcsdkcdjTQAJbxQfgeQIEHhzs/H4kBnYJxsttFgB3LjSTgYNS25LNobvuxmcd
         gfTg==
X-Forwarded-Encrypted: i=1; AJvYcCXJcqY/AN4CyBZXjjbu6ToYT74AglbvOD2hFe9/uMLU4SxZgHHTZLnE7wgOE6oJnvUwRK3DrE3DA5vEVICiprHFkMrVQLUE
X-Gm-Message-State: AOJu0YxmCXnyOfrfx5GsW4ra0XvyBVGVsbsyNoQzbTHNQbQNU/aOqVCP
	0KyOK7BUduhk3U7F++RR3emZlTojp3j5l3SaUT3TzApievO/LCbWpEJ3x9Fe
X-Google-Smtp-Source: AGHT+IFqn97tMxgrcENsfwMqGhj7piIfH05/O+tS2b6E5evh+2dbFl8DSoTlwEp3JV5xUj0G20CNBw==
X-Received: by 2002:a05:6512:12d1:b0:52e:6d71:e8f1 with SMTP id 2adb3069b0e04-52ee5427e35mr1684979e87.53.1721245065553;
        Wed, 17 Jul 2024 12:37:45 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::101:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59f7464d40asm3080535a12.68.2024.07.17.12.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:37:45 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH 1/4] dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
Date: Wed, 17 Jul 2024 21:37:22 +0200
Message-ID: <20240717193725.469192-2-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717193725.469192-1-vtpieter@gmail.com>
References: <20240717193725.469192-1-vtpieter@gmail.com>
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


