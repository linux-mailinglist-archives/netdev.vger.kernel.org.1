Return-Path: <netdev+bounces-194471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3560AC99A7
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 08:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04EE3AE0D9
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 06:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABE72D613;
	Sat, 31 May 2025 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSLRCZ92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873016FBF;
	Sat, 31 May 2025 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748674004; cv=none; b=dxNQX73Btc53jbwkGnsooPw4+Ogbn027Tu2HuU3kp5IgaLr6Wmxg2REYLjBr2BjbJIfO3x/Ny4QuHLPTwaJ1+6J5VnbMOBdESgVkrXNlObvKO9+rrbnmG7C3NUhYg97gdXTgu/9Jd362djVHnK2hH2cI21R32QYWQA4NI5k6hbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748674004; c=relaxed/simple;
	bh=TBagG89tgOpuG17SG1AW413LCmPAzVJtoopZgXJXgRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JdOw6KYzUKXXMTzgT/RomlYlHJpLlPL0XgAeAPbtv/RYi8IyzOr6LAGk6S+iPUTCqjLrIOdmqmOnzQ97FIkm/xOp4Qu/72TYOXpfj6zzGMIILh1GYlkIEO79FgKNJ3v2j33AGlRUpNCCThVvrPK3ivIC7+v/kq9tug0er1Qp46Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSLRCZ92; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450df5d7b9fso2423695e9.1;
        Fri, 30 May 2025 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748674000; x=1749278800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suSEv9KD1CGiTUDphtrC3zQvZBBO6cmgB77F4J23Nic=;
        b=dSLRCZ92H5uEtrPF7IRlDaxRmh52gkhVUw9tGVLEtbQS0ZCJBXXl+EPShvnnqpoviz
         JwBVJqy0Jaj3WEr479yQRxh3Hdq/MVpAgARPajQW+in6Mi2dZQ5ls/VC0rLL04V/S+dw
         Ok5XY1bLxAXUA1WJuUMHNtAEN3MUBwH4nFhVyAXg7Ews72XiRRbIfvAJKecos8SZ452H
         wbLqOUyjPCUkaIY24lJDfR+HKluVg0eNuuvkdg2GQyuRwtCJBbzWPi+T/FRHtfTwpUiz
         8w/k0nkxdvpoCp1cljveqNMf3xziOo0JTdHZb7Ulo9vBKtgLk99KWRz7rk31yvcB2Gi1
         jnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748674000; x=1749278800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suSEv9KD1CGiTUDphtrC3zQvZBBO6cmgB77F4J23Nic=;
        b=jPSYWTXmSZxu/c34CRtVAo3h1tAx0pWwO5APbJ+fr8fxCLRJXT9HWt2N0D9mbvbN+f
         YMXUyU1cJWiN8CUHpqTz1ajpKG7O2o4ShCMmZjaRiIVw4LRzx6bC2OV8sSu9zUbPZfgk
         AxoeQCCSYRu0AM5vsGBd6p6kCmfQXHiUjsYV9xUcbBJTEjtOjSMV8CvMPrLGK/ZN90zy
         sdiPUULcF8GTTcZriCH3D5lgfSdaTmcc6RN43BROLaMZHObuDP+NdQrDyHeLt89ujeR9
         0tZkIWxTWc5PAbyY90hB9+E+ULsYHkcq0tyrelwev6lXWswWAVr0YetwBseTINPJ8dl7
         4ocA==
X-Forwarded-Encrypted: i=1; AJvYcCUlULzwXsQQ8rbtP7pCGQlGM4c//WON1iUCqUk1Bf2vXoSbG2rivoWVwDFJvxQlEc1woan3WzQgN2bmfM8=@vger.kernel.org, AJvYcCV0xi9e/zqKdwkVh8L3golDJyoOnqfH0eXP7qERX0Ovr9+tBJq4D5YYU5JJTjoklkOgN8zIp8Ri@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmD+dSueOkcMzgiRdBmWrNLaKKeOCC1A79Sr/TxGuiIMxQmt0
	K8gr4KJH3hqroUsnBjr63L9eph+pk5GtO+oMQVDsMiR2RBYpk4rDilRp
X-Gm-Gg: ASbGncu6zuG5Ao2RNq8lfqHng7UMaTI1JMpBidkggYwgmvyXQEs3it2voat6Z4l2B0M
	tSuSlRXgO7SjGwGhyGcLbhCc/v9+eGkvIyZ7Vtl/E0sBJLrYF3M/YvlvzscXXHdODvKppz4ZhVS
	nOIbs6VpFEvIWBHzcFUfWycx6/aqwTj2p7AZlY525jc7gmyVJA7zNpxcav01ZW+J6L3zixqhhAl
	es8nU2m7RCHoFCcD/OmIlaxZJyHfhu+5q9erv5f+2uOfZiJHs7rkJJIwqBkK/ohnEaTfk41vMO1
	mN5DJKieIvHy1QmHi3GrnmXc7PVPYZWqYraeClcC7aa/ckSYrFbrOqEZk6NmnfYoBZfafOfhz4u
	vIyFbxYN7botqLHjnjR9Q+vGkUrhHjoJujWZwGJjXYgsTZNu7GVXfCv1GlhDy1AY=
X-Google-Smtp-Source: AGHT+IFhGpCx9jm8jy4GIDf2rHh2W12IWxKPirF7B/jv3FJXl1LLPbZmlrRguVxWyVdN8CwTXF9xbw==
X-Received: by 2002:a05:600c:4f46:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-450d6bd2efbmr44272845e9.16.1748673999440;
        Fri, 30 May 2025 23:46:39 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000e9asm38324765e9.21.2025.05.30.23.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 23:46:37 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH 0/3] net: dsa: brcm: add legacy FCS tag
Date: Sat, 31 May 2025 08:46:32 +0200
Message-Id: <20250531064635.119740-1-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The existing brcm legacy tag only works with BCM63xx switches.
These patches add a new legacy tag for BCM5325 and BCM5365 switches, which
require including the FCS and length.

Álvaro Fernández Rojas (3):
  net: dsa: tag_brcm: legacy: reorganize functions
  net: dsa: tag_brcm: add support for legacy FCS tags
  net: dsa: b53: support legacy FCS tags

 drivers/net/dsa/b53/Kconfig      |   1 +
 drivers/net/dsa/b53/b53_common.c |   7 +-
 include/net/dsa.h                |   2 +
 net/dsa/Kconfig                  |   8 +++
 net/dsa/tag_brcm.c               | 119 ++++++++++++++++++++++++-------
 5 files changed, 111 insertions(+), 26 deletions(-)

-- 
2.39.5


