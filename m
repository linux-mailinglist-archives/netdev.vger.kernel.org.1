Return-Path: <netdev+bounces-139740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B329B3F3C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A573B21ABD
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04871B661;
	Tue, 29 Oct 2024 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4j0z9M3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379EB4A28;
	Tue, 29 Oct 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730162228; cv=none; b=ISzSlWrLlh3mXAzywZQU8kWG+z6EUvlta33haigc+/sxs0kSZXami7qqncd/Br/Rmw6pnpN/cbDY4nWjrBrhgovXYUeywLY2GSqSnVYlL2cZmrjNt56LCmRwpKo745iAcDjmyz+ouBgl3vyj2ryLBntIwkL2KdBkH5FwmMnXNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730162228; c=relaxed/simple;
	bh=qeujHuvQyslroSllEXiciUhe/x4TRfcq7sdH3dIWkbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8Ep8UpAXC4zYy+pOguNFJBxui3/+FJ6LoFUlXoY0aRgaAxiafrZ04r6ygQKEI/oz2Zf/IbjPcdF0tpJctEiT3JpNK5NE1I5KCOTL8cLARVvKvn+4PGfJ1nB6GtSzGaIZCklhBAAML77Q2PdtgAaxOc9VPSMmuMh5EQ4vUWXlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4j0z9M3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c6f492d2dso54492875ad.0;
        Mon, 28 Oct 2024 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730162226; x=1730767026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ybdc4suSyEnjIbTKBgs8r7kibgpgP4PxS6JnZnAmPf8=;
        b=V4j0z9M3cuEyGur0txQdaZrgrFeP3b9rLcOUTvFgFt85vHY+xFDuxK7EjDy3nXbV1e
         MTedSzknXsMGVykoeoy46S7b6SRAjJbBZRJD7bXdfT+ym74lRbaAe+Jkv3a4OYndZ4wu
         WqFNPCp+nS4jKbRoPnKbGlJqBenQ4D2n5x8CKP41cLtkMJccMhS7WCK/liwXeXtniarh
         +L+wF8oliK3rkIW91ak4nQwoeNsRPI3HEYdkLbiuYvwqt7jmXSl5/zeHl+XPGj9NAxuG
         UGG73q3ZSEtt4tq8AX/RsUvkw8DJZieDhoHT+AKNNi5oClOXy9oXReyCH2nEivZY3SlH
         Xusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730162226; x=1730767026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ybdc4suSyEnjIbTKBgs8r7kibgpgP4PxS6JnZnAmPf8=;
        b=p+3nyrl9j2GpNMj8TVwgldzqOL7pIHvbmC/gvq6rESd6bgiSeTU/XNARK8gVjnDKBX
         b95LNSEq4U72U46N1Qmh4L6owwlWipsWm50zLadx3o1yNERTteBE8/J8jeRM8upPZ0Qz
         4uhVh9HW5YVTQhEbmIDNbUYyVmkxHmOmM9D3FlpI0gzdqhCUtKNERMmrFrF8otwdifE6
         UeHaF85I3Gw5VRXwwXdprPURseR4ou9mGprKZgFowG/Gen5+5FOYqLogntiQwb+cs/O0
         nY69p/KNpd2a9PB/bWx9uJagj38B90VmCvzJeqb2yELXc3u1oQ8s/GaX72xewMyepnUL
         xqlg==
X-Forwarded-Encrypted: i=1; AJvYcCXgjMKXc+KmaHRPWSfc+1P/Ih3l/RdBPXDHhtPaEmWleB7OLv/KqQfTXEDlZxe0DKCROAVdIZ/UcGE9rQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyujyW5I3p8PkeqC7SrUcY0rhadrBJgNXpkG1WVreKnwrKW2jZj
	uzhXCmx/VQTinEHlkRqarjoTQJXGGUeOkWq8ct6Es0xkdtuWXV1KuqhmWA==
X-Google-Smtp-Source: AGHT+IEc4R666UugaTCyHjsLs6CKF5I/1zG+wnWlV4bLxQcJkXhqpQWVIf7vlWTjVdSWTQ+THpivSg==
X-Received: by 2002:a17:902:e80c:b0:20d:1a47:ecd5 with SMTP id d9443c01a7336-210c6ce8aa2mr100548215ad.61.1730162225700;
        Mon, 28 Oct 2024 17:37:05 -0700 (PDT)
Received: from eldorado.. (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc044cb1sm55945165ad.249.2024.10.28.17.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 17:37:05 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] MAINTAINERS: Remove self from DSA entry
Date: Mon, 28 Oct 2024 17:36:58 -0700
Message-ID: <20241029003659.3853796-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f39ab140710f..cde4a51fd3a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16031,7 +16031,6 @@ F:	drivers/net/wireless/
 
 NETWORKING [DSA]
 M:	Andrew Lunn <andrew@lunn.ch>
-M:	Florian Fainelli <f.fainelli@gmail.com>
 M:	Vladimir Oltean <olteanv@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/
-- 
2.43.0


