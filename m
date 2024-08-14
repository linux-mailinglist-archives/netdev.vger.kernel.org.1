Return-Path: <netdev+bounces-118345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E19514FC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A586B25C0A
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C81311AC;
	Wed, 14 Aug 2024 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWj1ZceL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1964383BF;
	Wed, 14 Aug 2024 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619275; cv=none; b=MOCBUlCN7tQOsv7QqilcvGTCsWSGxN8XO4pi+o4t39Nxh5jVh8+dCgk4opPj7fxT/w5shu3gnujIVYsNYzg6S18+UjlQt1LhOwS5ckIkKA7WCe01oCE7yfUlOqp2n8Rb6tfqa7PirZRZ5VKnAH++88KYXzc352PoGxv7VymB07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619275; c=relaxed/simple;
	bh=5Nlbs5UpIXwJoGS8Dgd2lUM1p3Xi+uApk0jV+jmDwHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUH4q/tsgI8Up4CpdagVOZlOh0loKChHO2tQerGIs9eNljWV7fEy94QiAm/cFpOwtEeE7fJi4djeyxYwkv48cpNQlz7Y+JaIvTyTj5+OKL7cazsgDBScD2IRMl5kCoy65X4y3uDyTJ+kdoKv/pza2StJSiyDUNSX0lNcu21SPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWj1ZceL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83562f9be9so105086966b.0;
        Wed, 14 Aug 2024 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723619272; x=1724224072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rgqej8uilBrjcT5uBPKkyrB007D8NKXVW+3vOcYibE=;
        b=hWj1ZceLG3+zoDY7F6EAluEAkky077Pupwh7Blc3nrCAOupk+t6z/I4V3D1JzzSqqX
         CSymfUxf6LwhJKR+ooNUNQEEA1gAekzs/eEgwu5413VhpSKKjXYB+X3YBOjgC0R27Vvc
         L5YaNbi8RzYGNvlv9bJbPXrlLSuEB497HAMNywa4WLjvdZ7c9P6HCMLRogc8SxPGL5G+
         HiujqP8uunB0pmzlgIOY4iAFD7bPFkUZCRCvOzvCuSCjw0H7n+1jG2qFiGqKdi/a+Xmm
         a0Szy8bOlPiVR6TEz+Qc40NlyFzog747HWawZSnmKsiStyAnKnooivLkuVKVRteBKAu1
         TX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723619272; x=1724224072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rgqej8uilBrjcT5uBPKkyrB007D8NKXVW+3vOcYibE=;
        b=MOtCKm6A3obKMd1mjkBVDkehfd8LSwgIXUhZjF5168fezWIPcSWdfLtI534K+SxPO3
         ApuudRH5fhRnOfUwnaPuldnWg8/tIll8P7ijwfcBfqZ6gqxBPAzNfvQGYXP4u8tK2mXO
         +9qlNjnm4hSUPaQEe80CZoI/m3uiY8puTta66esueiFSaBzFaL9o1CCvoBBQf4wPrxFC
         lZhuDF/2QWEsZdkvuOib8PWmBtnd1lCQDsFbzjIwUJwDWnEd2wpJEmJwXVNSrfrGKJDb
         4yH0sNP3Wa0+QGlj8noj3JGuFln9zZIAblzfGByadxQfle4WmF+qFOD13AK3A8K1EDmq
         IWtg==
X-Forwarded-Encrypted: i=1; AJvYcCX7mzfVEgldAE+Qq8oHeeTTrMkmMBKjVf046Y6oes1Ix0NxNMoBsafv+eZBaWIRPxcEhXGfFEcO4wd0+UKnVI8L84vY6EWd7j8HLpXY
X-Gm-Message-State: AOJu0YyTQMy9wrrVwfIeKW+/0dsYHPDoDL38OskAjamuyFX1qWyawz17
	d9hrNBtJ36AhXq+pGdWJvOUy/lsjYT0vFHNuY0no484I55FRajE4uhqrIQYo
X-Google-Smtp-Source: AGHT+IG3BatAkbq8qcKmTTjGsOJT8sxn7wuVLkj2oXkXsZFImuxaBlPQUFvllVxgLv4M8byWCbjwcg==
X-Received: by 2002:a17:907:1b1a:b0:a72:4444:79bb with SMTP id a640c23a62f3a-a83670e00cbmr99375466b.59.1723619271605;
        Wed, 14 Aug 2024 00:07:51 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414eb8dsm135498066b.162.2024.08.14.00.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:07:51 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] netdev: Add missing __percpu qualifier to a cast
Date: Wed, 14 Aug 2024 09:06:38 +0200
Message-ID: <20240814070748.943671-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing __percpu qualifier to a (void *) cast to fix

dev.c:10863:45: warning: cast removes address space '__percpu' of expression

sparse warning. Also remove now unneeded __force sparse directives.

Found by GCC's named address space checks.

There were no changes in the resulting object file.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 751d9b70e6ad..0af344769ecc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10860,7 +10860,7 @@ noinline void netdev_core_stats_inc(struct net_device *dev, u32 offset)
 			return;
 	}
 
-	field = (__force unsigned long __percpu *)((__force void *)p + offset);
+	field = (unsigned long __percpu *)((void __percpu *)p + offset);
 	this_cpu_inc(*field);
 }
 EXPORT_SYMBOL_GPL(netdev_core_stats_inc);
-- 
2.46.0


