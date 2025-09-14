Return-Path: <netdev+bounces-222857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E6B56B39
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E75B1889BA3
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7478D1F4E34;
	Sun, 14 Sep 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIwJXodn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506E524F
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874662; cv=none; b=tLqii214BIOIx/36jFFCzVK/DUmYl1KFs0J+0kg9/2acJwXLdqc0ckA1iS5t+0Du5PPt3PFSC6pMVGMzbkH0PZBdoTlCwVjeB06qddQsNwxwP/Rb9Trrvkv+CM+GIcUc+9HxUe0Bk8Yc6xcaE1idp+bQKLlm3s7SU8p5hywHzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874662; c=relaxed/simple;
	bh=Uwjoc4sfboPE3RMtWZnJ0FopewFyBEbkr5T2274bxJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aq9ooVHv5mjWiYTuBwhdebHlBj+CIMUQZt0/1RVslSuOqneXRb4jEY0dV0wD2beUYBy0iBWeWCouXiMszEcQ+1w2VR7DULBVKuBoyjCiod7lv2diMPnwJFc++t7X5NA7SeKgsgReqWxAKco162rmb/YmogqhBgoSyadjgj9iFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIwJXodn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso3090309a12.1
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757874660; x=1758479460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7OkyHoQryuvQTvU/byTYmQXFC8TRTuccWQSN7suKqI=;
        b=AIwJXodnxWBQEg6vhtqfed3LvIrxHZRi72ujD3i/XM81xIj4d1bzgDA/YU0xg1ZjZb
         WVZ2l318ZwsyElErY/qypXDUHGOoVZmjHKpW2Rc9MNg7b+3PC7rESUDUvPpJNqcTyONC
         vBv4EnMoXKw3naSMC0q9ohoneXwkQTw+kRFFJ4GnH0UrZXxtk8HUSOR9Vuv3KbZ8vlOh
         yZ2kqEIQRyHiDDffuyn5vqvBm+bhrSHRLO8JcY4s/XJMjMAAWy4LSxgGSxMJ5xfoyCI5
         X2FcroZ14gfxN52ayEi15aWXJVd/8p0YE4PSJhUkCa0ZYqEdjTNATMMiuKs8WnfNsfyL
         tRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874660; x=1758479460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7OkyHoQryuvQTvU/byTYmQXFC8TRTuccWQSN7suKqI=;
        b=Gkdyif89Qk/RDaqVDb1EMy/KsyNFeLSCZQOdlDAI5f7J9T9o97sYVAYZHnLeOrOY8a
         5QvLdEmOgx8Lr3k9AtaOtyOQWHbHqjDy+9OObtnSPOUoUOTK5x605wd0efJcVU09xXMh
         dVhpqJX9td6/zVdu/0wb+6RuPNjO9Z064Er+8MauUVqukgj1WmIqiObUX5slG1OMLP/t
         qAZ+JIBE7soaPasNhUOiPTjZF4nZraZXTqEhGBJi7UmSOylKKMz26J2GCcjsocNVQRfD
         8zXp20hkvl/9BECsIEkCFvFP6+XBdBERnYLeMuca8iIDdBkDAdAkFbkVQIcUUWs036zS
         UhRw==
X-Gm-Message-State: AOJu0Yz77+UwjkGJrb2MYU0Mytp55bOEWa4Rxp5d4PDMX9HVaHiWW3Mi
	/NltP8YbMEhmAfweDnGBI1kGxcUUTQhVc1GSnT8YEbJ8lJ2qNMplM2Pj
X-Gm-Gg: ASbGncu34yj6wZ4Gr8JMh1QaHL4LNr8Gvc+Rr+K6/e2P51e6W0UuFj/SgzcpRIEYYY7
	0uxKN8Ji9k42PYGBaJ73Ngw4Vfi3MNTpWSs0WewnCpDrUk7u/h7i+hhselyzGNiV2PZIalq0NnU
	ag00UJ+K6EFLNFYftXFMhbLuAXDaGez9wqo1Ile6h197/w4Ca7QobXm682Nl5sMr7weiUPpRrQn
	U5rx24F7s2xU1kkO+Ua7TodHVWmRr6ZAknflF92EI8ZgFfm5rc8uqutrWmAGVgAWt/Hz5MLR/w6
	9ENh3SYp7rtqDwkh0bhsbtGrK7oUceVLM4TbEpkVsPjbSsaQANPs/Zkfcn5m+QuJPEc6dIHy83I
	rhVP2hvKV7gW829QObS+jmBfFeDXSuSy+AF5GadGJ1wTgN9s8uBAlt1KxfLQS7Uni+7k=
X-Google-Smtp-Source: AGHT+IFiTY1M/iqKWna3+l676xlEG6ziqliQbShqS23NxA6fN6O/AmQSqKLL9218+IRckCYFCn+0oA==
X-Received: by 2002:a17:903:2346:b0:263:671e:397c with SMTP id d9443c01a7336-263671e3cc7mr50657935ad.5.1757874660216;
        Sun, 14 Sep 2025 11:31:00 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e2fb546f9sm71760225ad.127.2025.09.14.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 11:30:59 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v2 0/2] net: dlink: handle copy_thresh allocation
Date: Mon, 15 Sep 2025 03:26:52 +0900
Message-ID: <20250914182653.3152-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two patches:

1. clean up whitespace around function calls to follow coding style.
(No functional change intended.)

2. Fix the memory handling issue with copybreak in the rx path.

Both patches have been tested on hardware.

Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250912145339.67448-2-yyyynoom@gmail.com/
v2:
- split into two patches: whitespace cleanup and functional fix
---

Yeounsu Moon (2):
  net: dlink: fix whitespace around function call
  net: dlink: handle copy_thresh allocation failure

 drivers/net/ethernet/dlink/dl2k.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.51.0


