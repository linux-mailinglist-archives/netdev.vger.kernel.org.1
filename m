Return-Path: <netdev+bounces-98169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7770E8CFE36
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091371F2344D
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C8613B5B9;
	Mon, 27 May 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="nLsveh6t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF313B285
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806241; cv=none; b=j2+4YvJqIRmxPiWndM3mRHjrWb7QyqxlCaTW/6pcqoYFwUeLhW8NTz5I8tVkP16ZomwW8sZnalPmzUuDs1q1J8mg0CwKQFSjE1CLf7r5YTyiUJooS6UGynWBXQuQwXUvbV3pGMKfAZUJXFutimBxuPiHWSoabxhOigxFB8t8Pn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806241; c=relaxed/simple;
	bh=BGmd38XxGSdKDMMcN3G3XiQIcyOv9DXSluGqtKQy9+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHfjLroHXQdPcOCQHE+dn7qymcb08g31ikHzc/IzIH+EvRwPJhi2snreCXrhz+exifRQa4mu5ELjVKx0Y5aj8dLCzIcouAtnJy3IuPJhwJ3vtpchdrD2dYSKcH7tjF6tb6wYep1QvQmtSWIRftlfu3n+cyRiiFhi7MGLN5T15Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=nLsveh6t; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-578626375ffso2790085a12.3
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716806237; x=1717411037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dO0AvFL5QwePC2QZ3gqTYDM4BcsHQKgOykoeZh92DyU=;
        b=nLsveh6tAbZJL4bicjOJ+RVpjPLj4fH507GnAWwY2BdwXg/C4CtH7brjzp/AE4ISLM
         OAZwBDKo354WnSasjw+SVTevql+5gTWy655tiuou0W9EPqpQLpjXRyl29/bRaxNY6+PZ
         oqoJpGHQ8epYzwZ/Skcd0KhZeiRR8WPbt7FdRiI1fGrLpZSCwEHluYME3PnsQjm0NZPc
         Gz6i5Ucv9WwjZvmB9uxWIFHTl8l5p2GXWloug08NtpcqVlSjE7fZitPH24gp3lIh+5BC
         /y1MIk2IzmmcebQ+OC8VEDfG1RUzecul+Dubj0kxINx0vP17x9Ir8/1BhHVWO/MAPFgt
         f1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716806237; x=1717411037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dO0AvFL5QwePC2QZ3gqTYDM4BcsHQKgOykoeZh92DyU=;
        b=PgM0DKfOAY8LU5FBFJTvXSS2z9Qz624IFHhCF87MFxzynat476GkRB1H/Hu3/K8a6l
         YnXG3MB4Uw9KkNvvLLd3NiK5JWfbY6tVTRHY2/JCEYE2xn+2h7BXq2BOQy2vEwtADl0g
         LVejFfXy21xcsO/VStSszNIA7rFkcJBcIocOetxX3jQ9ZiuIMakW1kIzZeRI8OMEM0L9
         NtX/CeDyz9aOU1Y5vDCPPEQDLvIUoRI42/0s7aoaZilNSrvmvk69DnfgUwbn5SAXJ9A/
         jgyOhD30YDgDp4jAe9aA3PrX0zQxW8TxZMBAKwOIeaDLH1LV7L3dAtiPoVMkMTYgXN6g
         62Wg==
X-Gm-Message-State: AOJu0YyBXDAmXxWd1vSjH1RwHGuNaZaRyOiOS7qb1P1XzZZ+vQemnQTV
	4RnraazCQo2GshWUc4W4Ae+7WPVQwQ1Pbxv5aXIhKJeuuAA0SRGzjYcDaqkXMoo=
X-Google-Smtp-Source: AGHT+IGxcPe6uT4yc9jWNU7ehZJr1E6b4aaoClrPA8u7hsmcPOTrwWBbPYZS8ijvvtGcf2XiujMAjA==
X-Received: by 2002:a50:ab5a:0:b0:578:6c19:4801 with SMTP id 4fb4d7f45d1cf-5786c195f95mr4162253a12.22.1716806237244;
        Mon, 27 May 2024 03:37:17 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578f47126f0sm3208478a12.91.2024.05.27.03.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:37:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net] docs: netdev: Fix typo in Signed-off-by tag
Date: Mon, 27 May 2024 12:36:19 +0200
Message-ID: <20240527103618.265801-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/of/off/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 Documentation/process/maintainer-netdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index fd96e4a3cef9..5e1fcfad1c4c 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -227,7 +227,7 @@ preferably including links to previous postings, for example::
   The amount of mooing will depend on packet rate so should match
   the diurnal cycle quite well.
 
-  Signed-of-by: Joe Defarmer <joe@barn.org>
+  Signed-off-by: Joe Defarmer <joe@barn.org>
   ---
   v3:
     - add a note about time-of-day mooing fluctuation to the commit message
-- 
2.45.1


