Return-Path: <netdev+bounces-241816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4B8C88B11
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E762F3A25A7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9AA319867;
	Wed, 26 Nov 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USkmG8zd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B03176E4
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146485; cv=none; b=KrI3mBk4NekgK3FeVfrVKR5dx+m5YU9TqTCrxY7HPQ5BB1wKs9QbkhjjE5H+6FSKDFWxrkTTKGPRFqgCKs7QM4eJVBAIrbU3nFPnRKnzbLFr6Az1TKOVBZdfsi7dAtDhgnsvLusYFRzn7619rmKmiUSbLKbwccxCwtl2F6yVt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146485; c=relaxed/simple;
	bh=yJ4Q+EZAX2DHWm5GOippjxx3Hf1lg9I9KPKII2LXViA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1jg7kKX+s2kUD9hKBDOHBoZ/mxFu1UvVp9W0uQ70iVSGFi2B5A96Wc3wbOGfsFV05ASLk/v/p5nHnRHv6VUpZIT5IULCt7JVkl0ODoOIpY6T/Mw1gR4czk4oHjD8BmpqFgteV5xBJp91Fv/MF+nHnHOrzTqDCePsud8B4nW+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USkmG8zd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so6758885b3a.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 00:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764146483; x=1764751283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2QvYg4d87Kbc5FICk6rTyHOqTSX8B7tbAnUpz5K33QQ=;
        b=USkmG8zdOKTugQUO3CC5amak5MNdeJweFAb8XnE+d28xfNLuyP2YlBVvtw0I5crsOL
         H/31nPoZnrEVZ47nvJavlEEiyTjoEthtr7SdzAPrBjnQETaxpz/cN/14fk7kfmqE09D+
         M1wiur8pfPmNUNVNjP/71Kb/Pj403jocbgiDTXuLdaAXp21Z8INE4OIu2AUwm97+kZnF
         5tJFuGO/fc8AjlfWC7tR/KPsn0HoSutEsZdGt9anA5sWDOQ8v3Sh2CkWYvRVKXJ2u9ao
         g8WQE8DQdr/9amWEsJtLi0I5cvpchu5IgO8Pzciuq5gmZj0wvmdi8PHdgSf1dlrCA7Fz
         qoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764146483; x=1764751283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QvYg4d87Kbc5FICk6rTyHOqTSX8B7tbAnUpz5K33QQ=;
        b=FaCg0A9Z+zyI9GyriZdElNlM5DYE9Md5V3e8WnfXG7fweZacP63FSistcCT7FB6oRi
         rOUjW6p+PRT4I1l/HpB5luKGhhO2VRF+K+Ano9SdRkOTcaN5bX7IprwCB9ibdLrCmvyI
         UEp1wGykFMU5+L+dF5dgJTpjFca/UD18bV9wTbWm1LNi3ZtGAADHF0FVEuy5bZkHDAW5
         /kANS/Nh+XxfYzTScuDoTpHWqnpQnxbJ8PG9bOn0cXvZEH6cG/aCSADVRx0Wv8ALilnP
         5x9/6tdMrYaIxi6SPeddJaJmHc8uaQSYq6fF7jg/NssYCXpcAUjRF1lpZbsMBPDglFLH
         n05A==
X-Gm-Message-State: AOJu0YzbPcdEg8mVJ8RdnSiR0/MHwY/ce+GPhf2hZyZU14nUDy9X25OV
	U7t13xdgyCjdWI7K1ojTNZRKh0Hu1Se5GhsN7forxy/8C2xMuJvtcEumeIV/lQ==
X-Gm-Gg: ASbGnctO/fyCYS8uSUXDpukZ2Dj928hVX8GJebexpuv7of3n9e/3V076ubiGIxzxbN1
	pClieROPMOI+2bQNgfyzHLezbgUCnUYYaPjzcRcYD12bMEKY2mw9TGaoEIO8RaocrkQ1ik30xFf
	uAa0PYEHvIco1GjFkX3WNDv0I5zVpL5LMfy9NiU8eUvcWDluAxIEUN40oa822/k+PDoOdRR7zL0
	xBMXnCnghRnk7fO24nMiga7CtpN0+eK8UP43/2O3oSEHSqZY2O4kQUk5W0j/HsvwcmK4lGftb9y
	gTbgqKnzy8dQVHhNtXROfLJUC5AAKUbGVN/LQNVgW093tH8ObCXIvwkWFVsexKGhw3AukLoendq
	UrIjllXUDEBXpqA7xPoz84U+gRSSovShpWH1Hk0u7ojMcFayomMPcdoDKACGVANqlhO9KdzcgSm
	JlWe+xo5MDWjYEBvxvl8SKiQ==
X-Google-Smtp-Source: AGHT+IEq8TLDu5upoHkXPWgpj9NVznwTnPz1hJXMUFIrKBM/KqkZM54x/BydMoApG5eHtM9d6kcZBA==
X-Received: by 2002:a05:6a00:98a:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7c58e113767mr20328041b3a.16.1764146482715;
        Wed, 26 Nov 2025 00:41:22 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f024adcfsm20918248b3a.31.2025.11.26.00.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:41:22 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: dsa: yt921x: Fix parsing MIB attributes
Date: Wed, 26 Nov 2025 16:40:18 +0800
Message-ID: <20251126084024.2843851-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/r/20251118091237.2208994-1-mmyangfl@gmail.com
  - reword commit message and add a fixes tag
  - add #defines for each MIB location

David Yang (2):
  net: dsa: yt921x: Fix parsing MIB attributes
  net: dsa: yt921x: Use macros for MIB locations

 drivers/net/dsa/yt921x.c | 105 +++++++++++++++++++--------------------
 drivers/net/dsa/yt921x.h |  54 ++++++++++++++++++++
 2 files changed, 104 insertions(+), 55 deletions(-)

--
2.51.0


