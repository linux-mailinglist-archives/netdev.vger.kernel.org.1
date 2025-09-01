Return-Path: <netdev+bounces-218890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B359B3EF7C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB951A87808
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5365927A469;
	Mon,  1 Sep 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnJHHzaV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89426E173;
	Mon,  1 Sep 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758013; cv=none; b=M7mZauBvGvAjDcNKbmeClLP/dm0Kyrp7E77h1utiMnlOFrOJqcMMk5Uakf3sf6M892SuPfTGvQoEMjRGM5ZbhpnJsQUs856LiJZJLcheWuUW9uoHJSG/06Vl4rZB7nT1e+N4FfpOVho62rVJ82gZYq7HpR72Zs6KVBi+w0YbKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758013; c=relaxed/simple;
	bh=i4R0WYNIpJra40HzvtT/fuWtFvBHAv8PQ4HpyrG7pwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XELiQ3Awgj3zBz3ZBpPBsFUoMWCXdbt57alnQ0LVZlVsd/tE7989ceu802bSA3DXvGwqF2r0eySZGfnIqJkZwYYVPfm0qEEhfDUJ95uPSx7V3uhwhK3eCa7r2uF638UvICJR6Pchq7a2IswufYbcMU3bDmTDWYdwxsaDwlr0cZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnJHHzaV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1296232b3a.3;
        Mon, 01 Sep 2025 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756758011; x=1757362811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGgGJBLmvwy32xPENRiFS3qwE0ooBptuWQGSNvoH1tM=;
        b=XnJHHzaV1jynX0NQdQdsJjfFyljYrA0w3XR46LyXTXK2s/Vc4j7qj4IwmiQR7Xbi71
         KXN96yrJtvIEvh+2mcGEZjJclqlf4QbsnPBvRn9Wnz2eQp9ZXfwM/U6ThdT+eYdu2qpF
         ZSA+kuZINLrUEgnOo7QNyvvdrNLXV8KKBl/2Ho7U0txpAr8av06r8I0u8bQt5Iq4+e5N
         VXCucg3yaE8JH9nfMi+GatQTX5NdDqdZdkFksfpmAKtvyQqhgOfgmZKZG8EXF5Xz+ThJ
         q0Jm06vU9G3XrtrgemGq6afTlfCLDTNfOVIPXZmPJeiCeq/kSls3nAcPsCNvX/ub94ma
         lZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756758011; x=1757362811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGgGJBLmvwy32xPENRiFS3qwE0ooBptuWQGSNvoH1tM=;
        b=pEeEZN2/UYQBUrFLmxzNb+Rfq61jqbW8nweY0bXbMZR49+OcmaNuRPF/lky1DVWAwf
         68HCsdGY39zmJ4/jZSJfBPBcAsd6/kFXP1klwEJhqWUjC7T1gUtYXMrZMkNXrIW08H7Z
         yp23rjXE6ceWKeB7uJNTzWCjUagarmIaf7jhPPsJnKbhRTsU/aK5Wf981qLPhH7TeJH3
         nKEnvrbPuPQA6lYkJKB8TWgoWOXPzUVsfoqINISKQSLBFQt6op8SSD2zY6Izzh+pk1k4
         dQawMdQVnpnCkqux/GYHHNHXOKc8PNr+8asMLZhVEeXFYFdisguHuUQ0+mgTfXiCUZiR
         EdLg==
X-Forwarded-Encrypted: i=1; AJvYcCWpCIiA3+Z124OkvqdsJ650HnyR64VemOroVng6IXqAOJ8G7cFBhF8oczPZWcUsfbMcuSJBInEItqngb3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YylrLPjDTkIqbnufIKMvSphFsILchZGIECqxxHpsquYQPHQYHCu
	0137taKlPzF5YF9Tz+dFgymrFz25gbFLRyer/gZEQAqfjHKrklwAhEjur+k25g==
X-Gm-Gg: ASbGncvfRQZWg80ATvBEvfp09eL7u1vxLi1pacRvKKKWdgiCojpTd1xoYNgfJm+cD+u
	aTR+sXKHIxv7wEA8Huk7XF6cYeNEZSmS2wZ9bhZI0SDlTdPd8FSZW7zvF3FLptSI/yUs0zkOAwU
	61wFqlFcu57gy7+RlZ5VK4COUzh2ikcVp7sXn83/3X7wP9WqCEUuZ19r++EulnJOX8WPZZMuNt4
	adZunmJLU86AKwnUbu2z23R4Tm9I6vCI/1NGdaudjK4268WYlAMjJz1e5EYLn7PrhIop3fqK6LL
	Nny8AtD2U+92lhPuPyRnBTEKhijjsSeaQZlF/uE3qHQzFvy6oaWPyQZiXbEvJSP+tYpNDT4LbSQ
	l+gBExe7keLGgppKdjIKK07lcBjIDN4WBTHdnw1uceyHyDBKSzS/x4zI7KcgX0rBIXNE1snc=
X-Google-Smtp-Source: AGHT+IE0STkyvfSBEF9UUxFIDXrzq53dcCxMYlGphH+TvBHamqobMm8fLwwwRN8JegPcqnRMJhnhMg==
X-Received: by 2002:a05:6a20:1093:b0:244:58:c159 with SMTP id adf61e73a8af0-2440058c3d1mr508763637.22.1756758010791;
        Mon, 01 Sep 2025 13:20:10 -0700 (PDT)
Received: from archlinux ([2601:644:8200:acc7::9ec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd007026esm10118256a12.9.2025.09.01.13.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:20:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET DRIVER),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 0/2] net: lan966x: some OF cleanups
Date: Mon,  1 Sep 2025 13:19:59 -0700
Message-ID: <20250901202001.27024-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First commit basically adds NVMEM support and second one removes a lot
of fwnode usage.

v2: change signature of lan966x_probe_port

Rosen Penev (2):
  net: lan966x: use of_get_mac_address
  net: lan966x: convert fwnode to of

 .../ethernet/microchip/lan966x/lan966x_main.c | 43 ++++++++++---------
 .../ethernet/microchip/lan966x/lan966x_main.h |  2 +-
 2 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.51.0


