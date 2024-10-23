Return-Path: <netdev+bounces-138130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11099AC13C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D722B22B7F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59CD15ADA1;
	Wed, 23 Oct 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqDbH8R3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950A15A843
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671302; cv=none; b=IVbbIf4WSy1+64va0vl29cvsOMLgabrynKdqIAAuVxSYm13I9pHVJQsWBWHaDSSIPALQBU/JGn1TN2jds9h/pt2ndAqhkkAYZdgcKcoa9ucF9uoHuOgaBHadGhuaVoGnQIGRDlAtoc+TTMLvSAH6mQTDtEHebEAKyDaSdd4hzoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671302; c=relaxed/simple;
	bh=N+5HwTqFWfo5eSwFOh+iyfnhI+7RhwURZf+Udb0BYU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BIlaRSUjSgv5V957Rdd4A3pmKZeWbzI91Y0iJkQiGSE7xhiw/aExETZYmJGrYX3y6BmqMIfqPfeh7Mnlhd3B3PEqCXyIIhhRoTRhDZTtG5MV/beaOtxDVKAJjxBG4Y2KGDbs0uRNG5jXYogxiM/i8S70PsVrrymVfizuu/bewo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqDbH8R3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4e481692so5333114b3a.1
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 01:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729671300; x=1730276100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8z2pZA5/zlCn6Nxcrtyfo0Fz/RuXHvDVKS7oNMaVnU=;
        b=CqDbH8R3VQbRkgaEl79obYwDa91ac+T8HFaHDvtMeBKg1zXPyCeom2WEG5/7CAqZ1F
         bv9gNwNFwDPzNWLLP3XDcCA/fKxHxwXkEs8Z8nDU4g4UYfGmtXSlBJ5ED8tj5XD/xyxn
         YS+s5oKiMpPSE7TpI4UEmfrM4lAMJwDeHMLHr/FKNrTlBcX35P0fGL15UdWGIHM38eGq
         NaHALNjeyVW6j+hSHsdJ9rHkG/ppwHOQ/S5CB60sYrMTwJykFyVoSw0/a5QLwMQgzQlc
         kkIasqh6Ks62LIlXrHqHng1LDUtBt2Cq2IlpRR7TQ96P51x8pBzT0SaJ/keq4uA/vrcZ
         SGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729671300; x=1730276100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8z2pZA5/zlCn6Nxcrtyfo0Fz/RuXHvDVKS7oNMaVnU=;
        b=Yn/mP7YBovUSDCiu8r1uBP/uqzMd0yswBm6Jc9qSLuYzj/uE3Xpcn71U9pIPr1m3nX
         OPkEh4m+OioOpxq+CQ6GORgMYD0zV/o9xV5zxOJN7qPZzwukRXMyiFb8KL2mQ6xJxN3Z
         4/yyfNBlFxjQoK4lcav1Ja7gHFFS6hp3qwZ52iOVS/7JJBTLT+hAzO9g6hhiNCQVAxTC
         qWElnMN5MZlUS5roKlNPKb/Ti7ZLkbrPQL2hiIis+g6C9b83fnjVtizRlhHqcJ/RKCXE
         2b58TZPNw6nlLutoINLGEvSIyp6ju0MLgv/XBU140ottm5PQQrvCTPAsXSnQ551lmpGt
         3jlA==
X-Gm-Message-State: AOJu0Yx26fB5pE/+GCGuTFUUdVmuBZlIijCp4hj/H8BbFCGPDvaToZ8J
	HKCZcr3fKx7Jz8z5ZVZ8L94LLDeAg7dsJPC3W7NPK9j7T/u73m592mFG9w==
X-Google-Smtp-Source: AGHT+IGDk4L1rMsNmBITpyc9Jc5HozyIop+7IG/tRYT/1NwdoMahuloM901PakxBdXUVogKqihksvQ==
X-Received: by 2002:a05:6a00:3c92:b0:71d:f012:6de7 with SMTP id d2e1a72fcca58-72030cbdb99mr2397796b3a.27.1729671300453;
        Wed, 23 Oct 2024 01:15:00 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d1fsm5837786b3a.5.2024.10.23.01.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:15:00 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/2] tcp: add tcp_warn_once() common helper
Date: Wed, 23 Oct 2024 16:14:50 +0800
Message-Id: <20241023081452.9151-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Paolo Abeni suggested we can introduce a new helper to cover more cases
in the future for better debug.

Jason Xing (2):
  tcp: add a common helper to debug the underlying issue
  tcp: add more warn of socket in tcp_send_loss_probe()

 include/net/tcp.h     | 26 +++++++++++++++-----------
 net/ipv4/tcp_output.c |  4 +---
 2 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.37.3


