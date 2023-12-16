Return-Path: <netdev+bounces-58271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59B5815B58
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D1E1C21E9D
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920DA328B1;
	Sat, 16 Dec 2023 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXbEPbIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D330F8A
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50bdec453c8so1977073e87.3
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702755413; x=1703360213; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iqFExnMMnDmnSeIZIxR8k3x9FOQqNIEVBfvkstK1ys=;
        b=UXbEPbIXNWzpPe/BOHMgcggeYym9ugJmfcfJgyzimh7tZk3laitmyY1OV3YHmaT1ZV
         bJAw5LAyIJzmPzm08eFzNG0sPA3q36u5pTFtpGDr7Ncle/fYfmDNYeQSPMvCe1V3uwo2
         AKQ0jMAY+7aHAUOzl2Nog4CEMWqezq1t9aQtcyF7yw4rglrvqb2KK3gLC4UThRE4/RhW
         WgLPRsexONZ0RWEBm+SZqe3OrQjGrvSCW7jCnlRA8zG21OYp9YwDgY98LPUaRCpZWTe6
         lGruaSi2viAEdgZf3fqEpn2n/IwnmWg86e36swiefvlzrXOOQ07531DLMgpqy6E5qHSj
         KoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702755413; x=1703360213;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iqFExnMMnDmnSeIZIxR8k3x9FOQqNIEVBfvkstK1ys=;
        b=oWwsxXorz07UBF2B5B5PTqcM+BcdSSrGtL5AQpZmlDGmYyIGQgqnrEWckAeOHd9bCo
         V2PfwbQPuGgWAAxmdh9MLVUyE+7Mo0k8O9QHRm781XrQ5Jl3vS0/10VP7hKhoTMAHc4h
         WjdzezKy9SuBU9nIX6WIqVbbIIPwuodV43eqqqZdVBLhgm9eBf43Hy4F3w3/3Jfd2pw/
         W4GZgISFLRrr3Iy26MU7TWs4O7afTp/UvGQXLUeO4t7mOf7Ts9E98XJJltSDZft+yDO2
         tEbswXbhdp40jzzcidwnD559GSb2tnU9s+tU2Eh0Uf33VYSg0hBp3qieg6yTrbMJL9a4
         HIQg==
X-Gm-Message-State: AOJu0YxEUcH4o428VzuGoAJbnMSnRfS+PGVAjwwrRqmWkRIfDDHl/LL0
	QDqGCZYRp9jNMhrVfHTuJCR8Xw==
X-Google-Smtp-Source: AGHT+IG+R9Dj4buPVokLmNqNC563QcuFSeQfLUjcQvKLkso27rvIBKeqh1RuA4h2iKSLvh6p5ZhM3Q==
X-Received: by 2002:ac2:52b4:0:b0:50b:f041:e434 with SMTP id r20-20020ac252b4000000b0050bf041e434mr5698422lfm.70.1702755412834;
        Sat, 16 Dec 2023 11:36:52 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u13-20020ac25bcd000000b0050bc96f5258sm2441553lfn.214.2023.12.16.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 11:36:52 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net v2 0/2] Fix a regression in the Gemini ethernet
 controller.
Date: Sat, 16 Dec 2023 20:36:51 +0100
Message-Id: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFP8fWUC/4WNTQ6CMBCFr0Jm7Zi2AxpceQ/DAmEok2hrpgQ1h
 Ltb8QAu39/3FkiswglOxQLKsySJIQu3K6Ab2+AZpc8anHFknSEM/ETPdwmCPI2sgSdU9srpO0X
 qDkfXc90NfQ0Z8lAe5LUdXCB3ocnmKGmK+t5OZ7tFP76t/vFniwZrMkRVWV7Z0fkmodW4j+qhW
 df1A9dmVP3SAAAA
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

These fixes were developed on top of the earlier fixes.

Finding the right solution is hard because the Gemini checksumming
engine is completely undocumented in the datasheets.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Drop the TSO and length checks altogether, this was never
  working properly.
- Plan to make a proper TSO implementation in the next kernel
  cycle.
- Link to v1: https://lore.kernel.org/r/20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org

---
Linus Walleij (2):
      net: ethernet: cortina: Drop software checksum and TSO
      net: ethernet: cortina: Bypass checksumming engine of alien ethertypes

 drivers/net/ethernet/cortina/gemini.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231203-new-gemini-ethernet-regression-3c672de9cfd9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


