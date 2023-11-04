Return-Path: <netdev+bounces-46027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B167E0F6E
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 13:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E1B1C20ACE
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D918632;
	Sat,  4 Nov 2023 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDROO+9s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A253168A9
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 12:43:54 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96E5D42
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 05:43:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a29c7eefso3720972e87.1
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101830; x=1699706630; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewDHm+e+GImvvqfDodwPgmnoPkNl83AA+pDa6pnzAe0=;
        b=qDROO+9sghjQ40J86626HOQ3S7Z/JyP9y5QuO8K6wG00WF1vvwMG6wuws5fSeTnLq1
         9wklQou2B1pjtvlK3J1BZnncRSA+w4czm0HrEVwoD3oPbWvbnrY6d2bLmDJ1wIKOFKZt
         Lk1XNVWgaMlKfZxQ0FNjKSmcOGIdgmF9w7PSQucREnWSPH2qtwKy2diciEBFVsQS21q2
         Mg4H3n5TEBf39SgRmHJDA+QCkBMUcO0WqZaB05yxRoXwTYiXEyGJZQVmol/V6nzO0/Yl
         Thh4l4HeDbv8sZZa2h5h7atJhAv4kux1ICWuEdbFbkkEqB7OwE9055NSKduUG+iKREjH
         utXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101830; x=1699706630;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewDHm+e+GImvvqfDodwPgmnoPkNl83AA+pDa6pnzAe0=;
        b=QCESqQdw5/+rzmfaVuVtkHLJ82i+Ul8Rr7K8ypQBsR6VEdR9wWDr/1hnbqhXTp0gdG
         6UFCVv9GrwIbpmquje1pU4NE6gt6yvfJK79QxaM7X+7GnH6tbTM7iOTQVvk+xZaidSWl
         FoSlro/JnSYloNSAGk9C+6vzXc2pVp+gxznyFb/We2TraUFtgcaMU5MMfbeZZoiOBn/e
         5L2A9+CRTFN4WKubSCJd4olbWsHpPT0lStSyxbL8OJa8pIfFyGUrN3cVYZ7JacpsX97G
         6EUmxfRJcJA4yY65tkUY/DcHiEKWF7BFJjoI7m8CZDSWGZKfl77jbPfkFsFrzXhSj6Iq
         Iv6g==
X-Gm-Message-State: AOJu0YxzYg5n0Z8ddHHmMGMy4Qza2a/JSieQbKepA+00Z3vN1IoxHTyk
	ZsfT/U9qqkudA4+c4kTC+iJsKA==
X-Google-Smtp-Source: AGHT+IGGlkissxY+vBqmlLfCOeMTVSLvbUU0DrUKYcegqlRg5AhwssW3duvhu257rrYlLalqYiXfyA==
X-Received: by 2002:a05:6512:132a:b0:509:4559:27a9 with SMTP id x42-20020a056512132a00b00509455927a9mr7370477lfu.8.1699101829828;
        Sat, 04 Nov 2023 05:43:49 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:49 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net 0/4] Fix large frames in the Gemini ethernet driver
Date: Sat, 04 Nov 2023 13:43:47 +0100
Message-Id: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIM8RmUC/x2MwQqDMBAFf0X27IIblRZ/pXiI8Zku1Fg2Ugriv
 xs8zsDMQRmmyDRUBxl+mnVLBaSuKLx9imCdC5NrXCvSdByxalL+eItYzK/gRf8cpGtnFx5PmXo
 q7ddQ9P19UcJO43lejY1NxGwAAAA=
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>
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
Linus Walleij (4):
      net: ethernet: cortina: Fix MTU max setting
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Protect against oversized frames
      net: ethernet: cortina: Handle large frames

 drivers/net/ethernet/cortina/gemini.c | 32 ++++++++++++++++++++++++++------
 drivers/net/ethernet/cortina/gemini.h | 10 +++++-----
 2 files changed, 31 insertions(+), 11 deletions(-)
---
base-commit: 90b0c2b2edd1adff742c621e246562fbefa11b70
change-id: 20231104-gemini-largeframe-fix-c143d2c781b5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


