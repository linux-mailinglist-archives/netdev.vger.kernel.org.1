Return-Path: <netdev+bounces-251256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA071D3B679
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A670B3004D16
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B0A38F93F;
	Mon, 19 Jan 2026 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvXe9xR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDE3904E3
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849238; cv=none; b=llXiV2RuERbN0zY6bOt8V9JuekWQVmYIcOxmr7ouOPtl5yjuAr7e4yWonwotIudFMyxiCaOKEMZEXb7tFGyEUX87UKnH/jHiYgN/klv5S8jx3UlvewR4DTdKewsbze5sWmacx1nygWvZKe8BelJo5cUPlo3tYniSZ1dpYbWLoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849238; c=relaxed/simple;
	bh=zRhEwmykOO4X1nawJe8juGMDYOa8z/1JFLzKRvJ6OUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2/Tg/O8iTPwLXm8NI91Tbg3S4tUPh0CAedxvBI0DAmQz+lSJakal+b1KpBnx/J488rew7rfHvFXnY2qUEBFnmc0UcINs8O9iUoczwV0Zb5s5UnYmms64t0lQM0dG3+r8TRkWfQYnSMOL49bIMxumHE2MNZTbGeKMuhlBroPmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvXe9xR1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1463759a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768849223; x=1769454023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULnZliwMYdq/Q/w1X67EPvB1/7hVSkIavdZC/QxqmOw=;
        b=XvXe9xR13QcD97pkjr+Mw+SbOMl+pzQssTeBo4aiA9SXUYir1igX4pxVguUuvN7KpK
         YR/YguB92UdKPn277g9YA7yKWW6kYIMftqWuFNtDvRFFmjs5BsVLVTKRwF4LVz9rrLg3
         C/zZdF+jCrXN6G4J6pVjosOywd86WNz9R6iocP3l1C8VrVvFIsTT5IYN9bS1SQGK1LE3
         eZXFkh429EYBdY1/5vDKDLK28hjTxL0j+K2awetnT3K1kY77tcgQlp+PSX+ja3WFQZ7e
         VHb7Gdisg3jOlq15K2i2bA8s1cls7+xvsB9yGj63l6NH/PtJM6r1GOjGafrn2ft7QFOO
         xgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849223; x=1769454023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULnZliwMYdq/Q/w1X67EPvB1/7hVSkIavdZC/QxqmOw=;
        b=m2N60ovoLWUqDwLjX26Afh85l3uBoPRxF47iEAP5mMHGjR8ggrq3/dcA3AqFdQxLR/
         IJ1aDx4oXTsNNKXg04wBd7lyUMdgEymMVcS0DVi4JMIW5bUN2YIIIgzwwPvx88putrry
         Lxsm+uHcMeyG9O8Py87ZuaEAXHl5qjDmi8ZuqQXm6c1yBFNdZ5vrygZ33vb8hKti4NlS
         GEDdenGW7AgpcsWt/6yS0AhEsE5KTcPMOZ8fSVi8pVCIn8jjMNHncMHs5coe0ehQDSUJ
         k/1hngiEmfJfbN1lv+Yfm0S9ZTBqHg412Bfwnr2LTKxkCwHdMwl4Fqs3tTul2dkmN1qS
         hRvA==
X-Gm-Message-State: AOJu0YxHSB0eLGQtPUT8SQXPbddL+EvcoVkzMtcCnXTB5k7W+kuZFSiT
	Xq+HRjskqyGaXN37BKqIPsuBT5yjXQalvoRJ3uXsc/s4/UUKTLdafxzZ5oDRqQ==
X-Gm-Gg: AZuq6aKAQolDm+mLCE/A4Oa8ku0Es6k0xW8p2QrkjAJqsVP0Ml8mbdaE0BnTkG3FlPY
	CMbGHUN5pPOl1v5uU8hwmchqUh+lmnzVtCuqDWTOPTGdWfgPq/5QNSdy5TW6V9zbJ3yIk5fgOBE
	3U3fUntB8yObB15m9Bn5bJ1z7hpx+/Egj7WXQiv0M9TYAs1PBvDr1D4f1xcjJfQJu2lH2nTXMyT
	hmS5KdvOD0//q/1u8g1aBgLiIvm6nL/9FjkYbjTY4oBmvDp0T3h67d80Cz9eJvXa/Y3e5AuYCmm
	Xafld7Ny5J/5Xr+IvjJKlYp+pMBCHazqJcEQ9LeRkle5FcFwUsr+Q7zNo49xWDYy+vZ290Zc0DN
	bojrH72MKmbNW0i84l1qeJv+8KshoWqa8leQcfYIUNrKidBo7nhrzyeiJgGu9iuTTiVhNAD6qZM
	CFtEDq64UVAbKX5D6S16TE7fM5w/KjmUtZL4kbn+pPWwZVdBQ/eA==
X-Received: by 2002:a17:90b:4a11:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-35272f18eb7mr10046551a91.15.1768849222796;
        Mon, 19 Jan 2026 11:00:22 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf354b24sm9677431a12.28.2026.01.19.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:00:22 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: dsa: yt921x: Add DCB/priority support
Date: Tue, 20 Jan 2026 02:59:28 +0800
Message-ID: <20260119185935.2072685-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add DCB/priority support to the driver.

David Yang (2):
  net: dsa: tag_yt921x: fix priority support
  net: dsa: yt921x: Add DCB/priority support

 drivers/net/dsa/Kconfig  |   2 +
 drivers/net/dsa/yt921x.c | 232 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  54 +++++++--
 net/dsa/tag_yt921x.c     |   8 +-
 4 files changed, 284 insertions(+), 12 deletions(-)

--
2.51.0

