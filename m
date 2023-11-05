Return-Path: <netdev+bounces-46110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D797E16AD
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 21:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C805B20D1D
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADA2182C0;
	Sun,  5 Nov 2023 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T71nTGc3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F81FD5
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 20:57:30 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310CEE0
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 12:57:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50931355d48so5093951e87.3
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217847; x=1699822647; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFkRCO5Gr31wYYObvH3M58yivJORulviaRB/LYrXXJQ=;
        b=T71nTGc3Okg3dJ2uwL1PBI2yihVsH1WUU6wVIvBV6MsY1JdiYlECtNF4NDGUuM90C/
         JaXDu8k4/NHYkMWT3+aa+ejrB1nwZ7pWusxsNO73UpxUc16lEoNfNoOdzeKLJ7q0Sci/
         KYFIc/DlCNcNumSnbqPCPW9LuO4xLBXzPQ68uKDkAQ4/f3cUoGK25k+4kuvjlo9roDUj
         83/LItQaChogLOazxOFYrTWGpQmhR5tGbfQl0apg2DABFlkMMQoT1lsHvm1xNoZp1R4W
         0+Whe8mumr2gdnYVFUmBYp6JhsBlnqoe0NC78Ci6Zu1dbqYuTvmbrVAyLGLMZkLTUS6a
         fZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217847; x=1699822647;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFkRCO5Gr31wYYObvH3M58yivJORulviaRB/LYrXXJQ=;
        b=h/lPndQ6eJ0w1PZlU6Yx7SV5CZk3UOKO5qaMC9vS2IVLuoSKqES/q4cBkcgjIYvcsM
         BkpORydSJXz4IFqtZm3yCKuK80L55gpuIMYC0oOcNT3gEGh52esHc5QcdQm9TNoFa/Zo
         OlxhjyHgsRoPejYaAP3ORD7pllwKKncZEKirOcJqXfgQgba/zxq0sx7YLc2V8REsJ4IN
         Z5A4Z0KVG2bB9q7P19W0vcE33rhzAIFXUZFXvxstjl0BqwjnT1C3WF2d1+0T4ZQGWGtZ
         rR/Owxu44KFgIxepBbhA3+CDYUFjhrAEdA1qFk3jJ4PW8nbrOVAvtUNR2aw3D5TFM5de
         r7nw==
X-Gm-Message-State: AOJu0YzXYxq5sv+ckRDmDB3ebUr3EEhHoeM0NxRRVcRcjIzA4K31Q7Eb
	wzd/d0n6Hv9m1WMIPj1ELiJVPQ==
X-Google-Smtp-Source: AGHT+IGGCnq8W4xy+A703Avtfw1jtmjghCdQJdWIjjPpOpvf4AdSuEWf3pw2aCu+fr2p82NwWqsyhg==
X-Received: by 2002:a05:6512:969:b0:509:377a:26d9 with SMTP id v9-20020a056512096900b00509377a26d9mr10364957lft.8.1699217846755;
        Sun, 05 Nov 2023 12:57:26 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d12-20020ac24c8c000000b00507c72697d0sm931873lfl.303.2023.11.05.12.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 12:57:26 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net v2 0/4] Fix large frames in the Gemini ethernet driver
Date: Sun, 05 Nov 2023 21:57:22 +0100
Message-Id: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIBSGUC/4WNTQqDMBCFryKzboqTKP1Z9R7FRRoncUCTMhFpk
 dy9wQt0+b7H+94OmYQpw73ZQWjjzCnWoE8NuMnGQIrHmkG32iC2nQq0cGQ1WwnkxS6kPH+Uw86
 M2l2u+Oqhbt9CFR/eJ0RaYahw4rwm+R5fGx7VH+2GqlU31/dovNbemMfM0Uo6JwkwlFJ+9/O3g
 sAAAAA=
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

This is the result of a bug hunt for a problem with the
RTL8366RB DSA switch leading me wrong all over the place.

I am indebted to Vladimir Oltean who as usual pointed
out where the real problem was, many thanks!

Tryig to actually use big ("jumbo") frames on this
hardware uncovered the real bugs. Then I tested it on
the DSA switch and it indeed fixes the issue.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Don't check for oversized MTU request: the framework makes sure it doesn't
  happen.
- Drop unrelated BIT() macro cleanups (I might send these later for net-next)
- Use a special error code if the skbuff is too big and fail gracefully
  is this happens.
- Do proper checksum of the frame using a software fallback when the frame
  is too long for hardware checksumming.
- Link to v1: https://lore.kernel.org/r/20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org

---
Linus Walleij (4):
      net: ethernet: cortina: Fix MTU max setting
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Protect against oversized frames
      net: ethernet: cortina: Handle large frames

 drivers/net/ethernet/cortina/gemini.c | 39 ++++++++++++++++++++++++++++-------
 drivers/net/ethernet/cortina/gemini.h |  4 ++--
 2 files changed, 34 insertions(+), 9 deletions(-)
---
base-commit: e85fd73c7d9630d392f451fcf69a457c8e3f21dd
change-id: 20231104-gemini-largeframe-fix-c143d2c781b5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


