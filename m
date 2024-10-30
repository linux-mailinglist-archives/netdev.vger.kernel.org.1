Return-Path: <netdev+bounces-140537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207579B6DCD
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05A61F22CC3
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE921E8850;
	Wed, 30 Oct 2024 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUgqNG3n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEA1F12E0;
	Wed, 30 Oct 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320658; cv=none; b=coO8f0IGcKTXKQYnHxSbFuhSukyHFfvL2WQxUpO/PM6XG65ukuVRGHINsM9h3gVM3dOfeC17iM3EXI6Xm+0UE+9vLSEgayjvs0F4w4JZ3IgbSYDGNgeRAvFKzeOtkGch6oeC/W30uVbL9XPDSmiQnM1JHw8f/mWkPhgL/re1ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320658; c=relaxed/simple;
	bh=vfxVltosVSLRJxcAP4ixuHphmi6GfM2BvNT9W9uXblE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUkuoCn2Li2JwIJFej09R4h34iFsPwgc/XGgE9tcP4f4DjsK0tfMIuMKlnoa04Ttq6uNJX1fihPD5W+agbhER+NThn6gyK5ZYz9JV6wu5xrDtErPObZhlWgyk39m6I4qHV3DNKCDyvcL4djqtTfk8Jj0C22NPGu/WIb2lV0eU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUgqNG3n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c714cd9c8so3006115ad.0;
        Wed, 30 Oct 2024 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320656; x=1730925456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkgaQZLOKnLgxA5jth2zU3zJJxLDoUVZNh7uHZv/wb4=;
        b=FUgqNG3nvjrvIVN3+LhFqKzl/jov1FnYRYDvH9fMTDeR46dBqPJLJ6tQEd0/BydnhB
         DVI5Z65vpVeWYlpJMLwzWF2tV1eVo5AywBeNHMsQwxMIGh4qu57VuizzpA4I7kj8SFXG
         UoURWSB/PNZqdjaPTVMt27uCcGWiuKzg5mNRDfFxLGFWIEgwflFsh3E5KiEG/9haY4Wq
         rzRbgp06+2w6mk/r9R4JVhLob9J6UfQiblOxs67dRddgpK/0hmrLRbmAsts3EhC19d7u
         LcmZ+ZZFpKgyaor6VB1xRAJLKL5TlLyX651OH8LOHOGJ/9b5g3HIXfWdOpaVJGjQaQP6
         gd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320656; x=1730925456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkgaQZLOKnLgxA5jth2zU3zJJxLDoUVZNh7uHZv/wb4=;
        b=c7/wfRulGuOHzBx8u2KCgC2365vXSiiearVXvU0jLWKilzcdVPAqpwQ9YJKusnv0Dz
         VkbyuuoUQ7wVvYLubiRykVBEJpsULxAGLyF8xCY/ibkmHuH+qYP3JDz6IODDp1+rmGHr
         kwjsapTL+zuahzrETZcNQif9hAUp9bjIw33nkjcZmkNFbH/lFhsMVqKLqYZFqHuKL555
         Qk8/1uIowCOSXHZdKYNEMP/4dCyIoCAPOTfaXLQBTj1x1ucC7hu1U9Uw5sR6395GM+Ka
         DYu7FNa0AQHfVzm7qHVWbTcfygzi5mvowutvj5ats50CwTs3gud3J4XdaHFRGzbbEJMR
         rUXA==
X-Forwarded-Encrypted: i=1; AJvYcCVgz9KtefPaqWTwbIC3R3L6kLXmi+8op//ZFFHJlRtrME6XmwQD17VWl/RbvFOv7scd+eBFw2qNxka2/vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9+Ll0IVpv/rEdi4ddTukT7/NfbAoHH9mY99sfUqU/kArdBM6
	TO+/UivXJwuEPn2VWYm3VM8sC7bgbVa91yaiva1aKZI68u0kBFrriqgRTzEb
X-Google-Smtp-Source: AGHT+IHgdQNaTO0JE/Z13TLgvi2NWjVEUcQMlBgYTldzYe6Epc/FM73rClN/iMw900fEgCZNLY1NUw==
X-Received: by 2002:a17:902:e849:b0:20c:94d1:2cb9 with SMTP id d9443c01a7336-210c687cbc7mr210770585ad.9.1730320656288;
        Wed, 30 Oct 2024 13:37:36 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 00/12] ibm: emac: cleanup modules to use devm 
Date: Wed, 30 Oct 2024 13:37:15 -0700
Message-ID: <20241030203727.6039-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

simplifies probe and removes remove functions. These drivers are small.

Rosen Penev (12):
  net: ibm: emac: tah: use devm for kzalloc
  net: ibm: emac: tah: use devm for mutex_init
  net: ibm: emac: tah: devm_platform_get_resources
  net: ibm: emac: rgmii: use devm for kzalloc
  net: ibm: emac: rgmii: use devm for mutex_init
  net: ibm: emac: rgmii: devm_platform_get_resource
  net: ibm: emac: zmii: use devm for kzalloc
  net: ibm: emac: zmii: use devm for mutex_init
  net: ibm: emac: zmii: devm_platform_get_resource
  net: ibm: emac: mal: use devm for kzalloc
  net: ibm: emac: mal: use devm for request_irq
  net: ibm: emac: mal: move irq maps down

 drivers/net/ethernet/ibm/emac/mal.c   | 88 +++++++++------------------
 drivers/net/ethernet/ibm/emac/rgmii.c | 49 ++++-----------
 drivers/net/ethernet/ibm/emac/tah.c   | 49 ++++-----------
 drivers/net/ethernet/ibm/emac/zmii.c  | 49 ++++-----------
 4 files changed, 69 insertions(+), 166 deletions(-)

-- 
2.47.0


