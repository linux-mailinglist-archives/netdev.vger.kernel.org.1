Return-Path: <netdev+bounces-15458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113FD747ADF
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 03:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F001C20A75
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 01:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3B37EF;
	Wed,  5 Jul 2023 01:16:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273063C
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 01:16:28 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 18:16:27 PDT
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B7910DD
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 18:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688519787; x=1720055787;
  h=mime-version:from:date:message-id:subject:to;
  bh=q0HvZFnTXa9fgE+7yflwyqzGdoGApfl9T11jQdopfW8=;
  b=l7e5RPgK+b1crRFmOZ577mZqrtGOI9KCqzcUgLoAyfVeooCCID1Mq85Z
   6d2MQa9r1Nko4fxHhTsbrmsdobh8z6izJuiQdC5yVSkvIShuTE1CerBtb
   sh7KTjBq+vX4bLM5am37vCDClnLZjExeMmf7sVSL0m6N64nMiLXM8bEf2
   JHlB/lFv2a6lbVNok69Lbyi/CRFFt6Nq3RY1aOSH9DDlja35s252ffR+C
   hk//9eYn6zFz9LuJXkIa0fLEOe2P3MpUIFc/jwcdBoQWMSlK8SYmU8LgA
   btIYxzVhupCCZiHTkBeuIqbrGI+SUCg2PqUVDa/xaVSOqZV5UWZ1QnB72
   w==;
Received: from mail-wr1-f69.google.com ([209.85.221.69])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2023 18:15:24 -0700
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31444df0fafso220585f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688519723; x=1691111723;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NIYq5ovgGYYcT2mwLIe/7Pwf4A8ZFgLTV67vPU1luuE=;
        b=OpDKa6aazYkYIruwvWLbwnWXzbvxhbV2XYMfpy978GxqtOHauKAOZYoLYn0DnSzCp9
         ZkBo2uz0ECn3yqxrbocDTgsrjomb0U1WSJGLsYJ8mT+MjEJyEfvRZ/JN275xRjGDN8si
         Ntv3h3tZAfU13NivPqTFkFQuidIgK+7sldNv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688519723; x=1691111723;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIYq5ovgGYYcT2mwLIe/7Pwf4A8ZFgLTV67vPU1luuE=;
        b=h6lTSBJLyPXxhi1Gg9sWhLVZnt7ZJjwuLoEGC6nl9DiM+H20f9OTZ9TIK8ZhwAEPGL
         jd0Mt+P0pQUE/1E7VmLq00pgVTTMsq+/8joWA8aoQt8uXbFrdZVABZFiXd2Zx9yZd/BF
         mjHXITkALlGlRZ10tDQEr0Ifv9qSnO7KdYangwdJLj2kEqYNF0I72bZkOZnlm2byMC4H
         JW3byZSjLmxzF4QyATzi6jkQ5AxiUUE7a417AAAsewRLXNkXaVkDGza9VoV1RPkQ0FS6
         pRPwobVlzce6L0kg5eERooZD32O0XXhB53WH+Vj3/Otl7OGdjixpyIfWpbsrhQ/aoaMs
         W5bA==
X-Gm-Message-State: ABy/qLZqQc3HhBUaZpQCw2v+oFwa4KBfz3ahAQtf7SeGQsnn8WcjwGVo
	8hv30Z/gmQTcJ5h4cqUibMy2U8q0VjNWdSuV5qZM7luEgj4p8ce+6N8b7n30LPXUtzO0yOGHGlp
	vFoQt1UJpwgcXq9wuvN2XjGgtSja5GaOcig==
X-Received: by 2002:adf:f147:0:b0:314:38e4:2596 with SMTP id y7-20020adff147000000b0031438e42596mr5849444wro.49.1688519723015;
        Tue, 04 Jul 2023 18:15:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0U4jLD27P3ah3ysuNk9sOys6goAlAbsY6dgFCEoGMpWROGB9rEd61YoyrMeyUAeyYjUe3bb9IYzKcnOuphfk=
X-Received: by 2002:adf:f147:0:b0:314:38e4:2596 with SMTP id
 y7-20020adff147000000b0031438e42596mr5849436wro.49.1688519722754; Tue, 04 Jul
 2023 18:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yu Hao <yhao016@ucr.edu>
Date: Tue, 4 Jul 2023 18:15:09 -0700
Message-ID: <CA+UBctD1E5ZLnBxkrXh3uxiKiKXphnLKiB=5whYtH73SCTESWw@mail.gmail.com>
Subject: [PATCH] net: lan78xx: Fix possible uninit bug
To: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The variable buf should be initialized in the function lan78xx_read_reg.
However, there is no return value check, which means the variable buf
could still be uninit. But there is a read later.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
---
 drivers/net/usb/lan78xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c458c030fadf..4c9318c92fe6 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1091,8 +1091,11 @@ static int lan78xx_write_raw_otp(struct
lan78xx_net *dev, u32 offset,
    int i;
    u32 buf;
    unsigned long timeout;
+   int ret;

-   lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+   ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+   if (ret < 0)
+       return ret;

    if (buf & OTP_PWR_DN_PWRDN_N_) {
        /* clear it and wait to be cleared */
-- 
2.34.1

