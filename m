Return-Path: <netdev+bounces-230835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F301DBF053B
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E028B4E5B8B
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF562F3C19;
	Mon, 20 Oct 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyPbAZ/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B719223C8A1
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954117; cv=none; b=HnzMuTofo7tBYnju0aJLmvTiP03vVo6n9yqarQH0owsI2XwxNTfHxxt+9VqEajW03kGtazpRBQk6684aWKt5f+xjgVeTzmAJZAlom9ugGLWTiM5EXdFvIRWNPe5EY5uJZ4PoF1KiCWSQz0Ezxlqy19CwJALagOQ0UnDnIbOs0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954117; c=relaxed/simple;
	bh=/qnsErc5VX3wSm2PY+usCao8ksKbiyyMWqGMwdn3Yus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bu74+nCkRwH3UQ3MPEOAWpISh+ThVr9n1xKTBS1WJS8KPtVkTDqxRwMs1ndZlu+lsCfv0KINIrvEmx/7sNTIgEfo2jl9eEplXwO3SLRavpA927l15MAVTkx687OlZr805Vi42/Fdj78qspLag0icdqJE/XZ0LdHbdrRp8CAbOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyPbAZ/+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-793021f348fso3709461b3a.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760954115; x=1761558915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMy7cvAKkSRQMgDlES0oX2LPH67n4kgF18iyVVK4oHw=;
        b=QyPbAZ/+tR4x3f05UYg1eznF0j5khwbFZHcYHUY3lkgWzXTnWumh19QBnQPwZHHAJP
         CZOlFnTyvJ/IdPZ8zjLxnri48JISxHtz2ymTlGbvo1q8EMqxIERA6qq59MdGYZREpILR
         JdQiHmKtbf7wEpBtijBbL2JwzSjiKX2NWezuQgEFfwzGMF1jSQ09sHklxb07iOjcnumR
         0VblDv9YteDrGWqEmF3/7ucwsGXxe3SI5r1K9faMW9QSN7YkTuXzKeh6EJXKOJWk5ksL
         IIOdk9NfYRjkgLH2daYWMdfHANPLs3DYdsar4Cs4wvAtWE+0uHCjDyXuPQ7V9baEFYNk
         XL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954115; x=1761558915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMy7cvAKkSRQMgDlES0oX2LPH67n4kgF18iyVVK4oHw=;
        b=OSKHIHGlzYvD4BPD58grvevdTjpRowriwef36GRPfAUBUwP9s7DbKwYyo5EQs2sw8s
         F2o7rlKUAOXYyL6u4HA8vFFnB2iDYOLRUyA+oD40pxQJDbvwgudQ1rc8s0s36npApyjd
         5qh/m5VlJ2R9ReJhuYWdd/LESY50PzlUQE3hiRfm0eaHYvgEau1aTgZngPpfMY+3THiu
         SGT+WW6/wOgmR652dTXqekgbYwP3Ys3AArxshE/Wrkzrm85pas0TyNqCpJ2f22NKZZkP
         /KmSvbnwF3lt3+fMhfFxiOaEWdV/b7pdnX9dhbtOkjzRbHXHoSg790EMSTycR8U60MJA
         1Icg==
X-Gm-Message-State: AOJu0YwtPg1JpkDD3s3v12eu8gAzl/PMyHU3QIRyRhb71DlROZ9zcgDr
	WgQpsBvoJ0vQ38r/+K5qdOFQHk+49OjVrYjxuMfiZFG3pEPRlMwbWVQC
X-Gm-Gg: ASbGncv6ZABH7UPWYJKnrsyTpoETh61Ocqo0YEqZu7BfN30u8L0czZJOvYa5fw4EWMJ
	t99VfOsqzcgpp2flSl6Z+NwqHLG90y/z8gupdhuFkipgLAqRaLlT0UUwQA4Cpourun9J5nrfMnU
	TjXxdUYETDELX16CO7cS6nI2U0ALOhVIYIP3wdvhtAlY6QMZwbm0ItbOjfOjKw1+4mHZItwsT5F
	v9GHSaPDRtpfxph28aH6YUl0Xce8qNxOPB6FHEe+gdHWi+HtBgXwF3Bp5WOKu3hVPYtRls1dYIy
	OqA1DwjIyV31+wIvrnmR0EmCZetSb8nIqf6cK8KIDYJIGzVwJ7fDjkze0lXe0N0+TjuTWKtr+2y
	2mexAtOjNbC4BdYIQKqhw14YlBEQWrn7zVzCDudvWOeyvrah1oe8GrQb5zvhiTtEdDNfqlpmMBC
	wd
X-Google-Smtp-Source: AGHT+IEgNjCLwH9jnOtF50+wmm//PGeZnCT/rP60wZrNs3v7YACWnHnFouvSbowCzzk7FowyoXdKEw==
X-Received: by 2002:a17:90b:2fd0:b0:32e:3552:8c79 with SMTP id 98e67ed59e1d1-33bcf8face6mr14790843a91.29.1760954115057;
        Mon, 20 Oct 2025 02:55:15 -0700 (PDT)
Received: from localhost ([218.76.62.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5dfc89d2sm7654264a91.23.2025.10.20.02.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:55:14 -0700 (PDT)
From: zuoqian <zuoqian113@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zuoqian <zuoqian113@gmail.com>
Subject: [RFC] net: macb: enable IPv6 support for TSO
Date: Mon, 20 Oct 2025 09:55:08 +0000
Message-ID: <20251020095509.2204-1-zuoqian113@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New Cadence GEM hardware support TSO for both ipv4 and IPv6 protocols,
but the driver currently lacks the NETIF_F_TSO6 feature flag for IPv6 TSO.

Signed-off-by: zuoqian <zuoqian113@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 214f543af3b8..a154c9f3c325 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -78,7 +78,7 @@ struct sifive_fu540_macb_mgmt {
 #define GEM_MAX_TX_LEN		(unsigned int)(0x3FC0)
 
 #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
-#define MACB_NETIF_LSO		NETIF_F_TSO
+#define MACB_NETIF_LSO		(NETIF_F_TSO | NETIF_F_TSO6)
 
 #define MACB_WOL_ENABLED		BIT(0)
 
-- 
2.49.0


