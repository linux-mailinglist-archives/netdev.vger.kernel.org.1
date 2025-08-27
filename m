Return-Path: <netdev+bounces-217447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA37B38BA7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6754318985A6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552A30E0C6;
	Wed, 27 Aug 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVNB6Hs5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF830DEB7;
	Wed, 27 Aug 2025 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331446; cv=none; b=Y8ff+Ipak3i1Ea8kahn8Jctn9cnn8tEV5W369uUWPrAYigZBbN0hYMltPOvdV7T+Q6RCVyeWTZ1PL+8ww55AZzTEZIz1WA2yoQbIj4Tb62lbOgcqJeYZ5IFm4hM9+8ro6/2q2LOiTAiVmCGxX/pJARqC5Qa9jIKpADfcxleeEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331446; c=relaxed/simple;
	bh=jYtrFlzCa47Iojo7vAWA2yhmyemV0ylu9RKX40Qfsbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DS9oBqYNy0pCrDwCi894c/ABRMqB7bxNSIHMo9z9uOUs2nS07r3uyamvRP42W57ZlICpsLlrEB3LFWgVdErrnrMFLLHzyaUP/godlwggJO+SWA/qucuzre5AbQajKZMMZWcbOuNmFQGzeLMVYnc7Car//42lfz3HgKYMA0kJEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVNB6Hs5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77057266cb8so286029b3a.0;
        Wed, 27 Aug 2025 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756331444; x=1756936244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/rQiEV7BgbwOAJ5MoUpWtq//bUdmhN598cCFMd7EJc=;
        b=XVNB6Hs5xVvtKqx77nRi4S1Dd5xE8lq3feKgfxMQTfUoyEk/AiRppzZ7LwFiKbfWIp
         8rYeGRg7xrn4MKBgD/tzxLJrTplTZAJ5HH2JUHSvQyUvga+d/TJZ6XpBffoUrYPY7/Cs
         LkjVnPXpmkmN8UC2H5bP4XSRzxHM86Vpt0AGCsJsRI9e04t3mBxdXulbbEnUdKRq+Vpq
         Y4Ccpvrjx/EuMl+y+kChpmMUglxEYU5f5G/a4ij9WOz5wxNJl2+xI0V4NuYx7Ztnaewx
         oBYNuI5taZabQtDm75ny4uhdfyYVVwlAfM2z28lD5Ni8noNsjieL7HzWM5malG9ZY/TA
         u6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331444; x=1756936244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/rQiEV7BgbwOAJ5MoUpWtq//bUdmhN598cCFMd7EJc=;
        b=TRuQl4E8rXE2lcamI/LiRALeNXNm260zW/2ahhPAYODsYM8p5s/vyg+xQi/MCdyDNg
         KO8k7Zfiu5EHUXhB6ANepbet4dJys3bsfqu+45rbfjxWFadETNpOdqHhvxIrcQVl6lvE
         ZEutaoWk4vxYZ//JEuc0Sik6EN6jl/yjh6jSSVHD5jk6lLIjjb5/vT3UPY8Ww6DE99zU
         L1YtrSybaY3/6BMrcgIsJBs/g09/3TJqcXSEubmVC1rg0i+B4HqGiGmatQQYg6z/E0VP
         I5FbAOQX46E7OBXdg+E3Spk9fIUuycW3km8hs4pxUfYly1qTW/KE+GUh+8KBDxFiIeMP
         HQkA==
X-Forwarded-Encrypted: i=1; AJvYcCXahaRG3Y1mEBIR41Oeru09XtxWs46jW0h9e23IIdfXzQJen1Nzig5Hh+iRf+3QCHUEveldJ7Pea8OdI98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfvm7XCOavyGdWZoj5kemEL8Upf+EMHiDHCGknbNlAASGHezbO
	2dvTa0AUn5v2YfxSH4Eg5+VtzXYmQARdcCekvdldHkE1B9dtxLe+Gd9B7jlAn2aW
X-Gm-Gg: ASbGnct2B51yw//D8RJX0Tz3YI++z/Sn9FlG/m0mEcmr/VIF70xXJNc+Z91ECVtU+lx
	7Rk/L2nJNNndbmgkpI9/IwPEzwejsT49OsU/APuvbA1LdLN6unKU+XN7/HPFlg26PZnkuKkehAf
	+0qumM9jkEsHZuXCKfPtJGmlybVexxA4AjI+wVbMaftGPQch/adUzKUUN9WUDQmyC/46/qpwXtz
	+Wuv+eGWoICWplYreG9FieRVqoqTBDAHZCISULqdGwGknV1b/tvZIskigRqakRpnQmSVC0QBMN6
	BF+jvBC5YYLAMePX5JFs1s3sLojoepLcil1FDnH2sILm8p0Wq74yKF/1W7QcNLorC4eX+CQU+az
	sPK/UBfxjAa1UDWQqziCuD0IucaUDHUYP+lrJsRhF7nlqjG3JFQOPMZEg3WUevhX38Ifk0S8RZG
	wu
X-Google-Smtp-Source: AGHT+IGhZgJE2VCgRAQtUqLzG+CiA4TKPMt28WRBwnyZlk3ixupNkgrAr1PVeH4X6sjXJ6Q0D4m1Nw==
X-Received: by 2002:a17:902:e5c7:b0:240:640a:c576 with SMTP id d9443c01a7336-2462ee02b9bmr277422085ad.15.1756331443885;
        Wed, 27 Aug 2025 14:50:43 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248cd2cd5desm6430765ad.147.2025.08.27.14.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 14:50:43 -0700 (PDT)
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
Subject: [PATCH net-next 0/2] net: lan966x: some OF cleanups
Date: Wed, 27 Aug 2025 14:50:40 -0700
Message-ID: <20250827215042.79843-1-rosenp@gmail.com>
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

Rosen Penev (2):
  net: lan966x: use of_get_mac_address
  net: lan966x: convert fwnode to of

 .../ethernet/microchip/lan966x/lan966x_main.c | 41 ++++++++++---------
 .../ethernet/microchip/lan966x/lan966x_main.h |  2 +-
 2 files changed, 23 insertions(+), 20 deletions(-)

-- 
2.51.0


