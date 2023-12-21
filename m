Return-Path: <netdev+bounces-59379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571381AB82
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340951F21988
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26137433A4;
	Thu, 21 Dec 2023 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXuEGAyq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA6433A1
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso341066e87.3
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703116960; x=1703721760; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow4leDXtE+UbmzvPQ6QB5McHhF7WzW/8cOC+D52UBEc=;
        b=iXuEGAyquwhenxJ7fw2/NRsV9NSauMp1kwUVGQcui9HPoPrZghWuTZssQXP/0lVyhE
         anPKPGGwppxXMXE0iSlzpRUYYjYm/ioKWw8Wk+xL6EaExMFGTYWm03pkEXpsxkkDIMcI
         UoHLX3Wamy6bT0BAoQRtnIK7UPZZk26p0IVxB/cY7uCX0Z2sQZmopdc5J8ryg6AHPGxw
         RdNzbuZ6xD3f8jPThWsqFDr54azItAM4vJXb+Ut/YTQepi4jbw/vUKtGRFUqXnHiTkQO
         4goAcjRU8g39ypS8GxkEW8v3a9/H4PvwhpDPTTjtTbtE/7shaJcJE5Hox9s0HlWJRmdF
         U9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116960; x=1703721760;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow4leDXtE+UbmzvPQ6QB5McHhF7WzW/8cOC+D52UBEc=;
        b=l8ABpgqBB+86IJKgwenwjHAdoehs2cE5ndnde02Wm1wcU722vOnruVNCiaRH6uoaEU
         69gNeL4jV6j1i3wRGXqALRDJDjKq4tQ5Dd3tbwnUuALZJGUV66v715/x0WP8fp6RxyDm
         tjhMPy/pZuVnmN0c/eFTU+tj0FvO3ZYlRP7reW1umMXcsJH37sKPNyVK9j98rWU00lub
         B1PrZVr5u/AJO52zd02jAOuIMCXRIU2oW1oAy7/+ukE9wF3aYMI+0c6VE0NyFgfVvYeF
         xj1o3g5Pqh3pam8sbdj3QtgDXdDyeWsAZp0G2d9plNETeZhc/yFaepNqHH4G+wZcZ2Ms
         35Rg==
X-Gm-Message-State: AOJu0YzaiN7xrIcN2LnnNfCMeTyppc789oWnUFBJGjzuG2DDjq6XQL98
	oRHos4Ka/fkPLRHEEvd/yOFUAQ==
X-Google-Smtp-Source: AGHT+IEiVLN992K9hhKC6/azrdXFWpt0JIDET7OK7Ovid6CRKdNuiLJE/SgK3tfSAApEpyre3oI1kQ==
X-Received: by 2002:a05:6512:2110:b0:50e:5a74:eff5 with SMTP id q16-20020a056512211000b0050e5a74eff5mr92503lfr.191.1703116960375;
        Wed, 20 Dec 2023 16:02:40 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a19741a000000b0050e4ac5bf5asm100321lfe.284.2023.12.20.16.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 16:02:39 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net v3 0/3] Fix a regression in the Gemini ethernet
 controller.
Date: Thu, 21 Dec 2023 01:02:19 +0100
Message-Id: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIuAg2UC/4XNTQ7CIBAF4KsY1mIKQ2vqynsYFxWmdBKlZmhQ0
 /TuIm501eWbn+/NIiITRnHYzIIxUaQx5ADbjbBDFzxKcjkLXWlQugIZ8CE93iiQxGlADjhJRs8
 YP68SbLPXDlvbu1Zk5M7Y07MUnES+Fec8HChOI79KaVJl9fVVveYnJSvZQgVQG3NBDccrhY7H3
 ci+2En/es2qp7PXGKub1ihwfffnLcvyBrLNyBMiAQAA
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.12.4

These fixes were developed on top of the earlier fixes.

Finding the right solution is hard because the Gemini checksumming
engine is completely undocumented in the datasheets.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Fix a whitespace bug in the first patch.
- Add generic accessors to obtain the raw ethertype of an
  ethernet frame. VLAN already have the right accessors.
- Link to v2: https://lore.kernel.org/r/20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org

Changes in v2:
- Drop the TSO and length checks altogether, this was never
  working properly.
- Plan to make a proper TSO implementation in the next kernel
  cycle.
- Link to v1: https://lore.kernel.org/r/20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org

---
Linus Walleij (3):
      net: ethernet: cortina: Drop software checksum and TSO
      if_ether: Add an accessor to read the raw ethertype
      net: ethernet: cortina: Bypass checksumming engine of alien ethertypes

 drivers/net/ethernet/cortina/gemini.c | 34 ++++++++++++++++++----------------
 include/linux/if_ether.h              | 16 ++++++++++++++++
 2 files changed, 34 insertions(+), 16 deletions(-)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231203-new-gemini-ethernet-regression-3c672de9cfd9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


