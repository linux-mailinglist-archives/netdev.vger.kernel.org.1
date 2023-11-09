Return-Path: <netdev+bounces-46780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061137E6621
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3609E1C20BE4
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4FA10A28;
	Thu,  9 Nov 2023 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LX/2ft4F"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7F10A21
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:03:16 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A1ED55
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:03:15 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so6898571fa.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520594; x=1700125394; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X23W+DtxdHmqBzJUyijkKW7gcM1l2veMuv/ye91bjTA=;
        b=LX/2ft4FvsXvpYzdvUh45S8NiVjyZP831Pz8sy8qA6UYxcloRt3EiTHgyxwDBarlRv
         1JX8RvBEEK+3Sue2zz2fYZo2zufQBVUlPR+1+udBIZIwLK6L27gWR3i/wtsa+Kwgqpm5
         JHZMor6zzOd3YCfUcQ2NKhw1YEv1fT67iLpKBW4yVA73xz1cvjt2w2g+BYObqNPWqQkn
         eAQvSW/G75S/cbV1fIuR3em7g9Bi8xJD2I8DNmU+QO4KoSgxsCn5Zb/FaQlTEPwIWroE
         yXntW145ItIpEXAKj66sT2VOsk5wPRrXsfux6t6BoKlnT8hZ17Mrx/fS24zDXORvnsqn
         T2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520594; x=1700125394;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X23W+DtxdHmqBzJUyijkKW7gcM1l2veMuv/ye91bjTA=;
        b=T0XyThOsYPPsVouF0ukz8nfmxcQvqAz39BoMtiir+L85ee9w0xMNXQJdQNOTMOiIly
         o0hH3/F07YInGIk0Vsbt1S3pn9/xsYrvaFMRxHJOglcCndckDdXL4QVV4fYWLF3D4b+D
         lwB9s+axyi9kiHwhqdLq16Gn4Pj0ykU1rzRdaHtuvjNfv2NnaUYL5Z6bgiyKXMb7SUIc
         UTCLJylQyrQcPmuMsPIrxSu7rwEW3ZqfuaiK9lmeYqGrwXVUTuEBOtziwY3F8XHn8YpG
         TTjzWDLx4BWhQF627bS95EdSV8FxZNz/0C17hUtQ3CMsEzaqDt44kv+/+YNmqFn/E89O
         bMCQ==
X-Gm-Message-State: AOJu0YyBlJTg2Y1a7LMa10TpcWidliiCrTcKA/YDAgvHxV3hCoAGwXhr
	0UCg7niHp9igYhtQVAcrVxZX8Q==
X-Google-Smtp-Source: AGHT+IFwKlWTvRrQ1ZFMN7SHZYCNDqEQVjVoIvuY549D7L8oHnqQqDA8MivwJ7zAVezbFWntv0hILw==
X-Received: by 2002:a05:651c:2047:b0:2c6:edfd:658a with SMTP id t7-20020a05651c204700b002c6edfd658amr3500404ljo.31.1699520593928;
        Thu, 09 Nov 2023 01:03:13 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h19-20020a05651c159300b002bbacc6c523sm2212383ljq.49.2023.11.09.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:03:13 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net v4 0/3] Fix large frames in the Gemini ethernet driver
Date: Thu, 09 Nov 2023 10:03:11 +0100
Message-Id: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+gTGUC/4XNQQqDMBAF0KtI1k1JMonarnqP0kWMEx3QWKJIi
 3j3BleWIl3+P/w3CxsxEo7smi0s4kwjDSEFfcqYa21okFOdMlNCgZRC8wZ7CsQ7Gxv00fbIPb2
 4kxpq5YpSVoal7TNiqjf3zgJO7JHKlsZpiO/t1yy30x92llzwizNGglfKA9w6CjYO5yE2GzmrP
 WOOGJUYV4M11uZOX/IfBvZMccRAYhBKAU6UoirMF7Ou6wf1EM5ATgEAAA==
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

To make sure it also works fine with big frames on
non-DSA devices I also copied a large video file over
scp to a device with maximum frame size, the data
was transported in large TCP packets ending up in
0x7ff sized frames using software checksumming at
~2.0 MB/s.

If I set down the MTU to the standard 1500 bytes so
that hardware checksumming is used, the scp transfer
of the same file was slightly lower, ~1.8-1.9 MB/s.

Despite this not being the best test it shows that
we can now stress the hardware with large frames
and that software checksum works fine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Strip stray v1-related comment from the commit message on patch 1
- Move the hunks deleting gmac_fix_features() from patch
  "net: ethernet: cortina: Handle large frames" to
  "net: ethernet: cortina: Fix MTU max setting" as it is
  perfectly motivated by the MTU change, then move this patch
  later in the series.
- Drop the last patch only activating the checksum engine for
  TCP and UDP explicitly. It's not fixing a regression,
  so let's reconsider it for net-next rather than net.
- Link to v3: https://lore.kernel.org/r/20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org

Changes in v3:
- Do not reimplement the existing oversize check (sigh what is
  wrong with me). Drop that patch.
- Drop the gmac_fix_features() since we are better off falling
  back to software checksums dynamically per-frame.
- Add a new patch to bypass the checksumming engine if we are not
  handling TCP or UDP.
- Link to v2: https://lore.kernel.org/r/20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org

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
Linus Walleij (3):
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Handle large frames
      net: ethernet: cortina: Fix MTU max setting

 drivers/net/ethernet/cortina/gemini.c | 45 ++++++++++++++++++++++-------------
 drivers/net/ethernet/cortina/gemini.h |  4 ++--
 2 files changed, 31 insertions(+), 18 deletions(-)
---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231104-gemini-largeframe-fix-c143d2c781b5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


