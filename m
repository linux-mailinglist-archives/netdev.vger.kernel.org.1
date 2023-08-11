Return-Path: <netdev+bounces-26968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA8C779B53
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75483281C53
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 23:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECD3D3A3;
	Fri, 11 Aug 2023 23:28:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3D329D4
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 23:28:39 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591D4E73;
	Fri, 11 Aug 2023 16:28:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f94328a4so1778420b3a.0;
        Fri, 11 Aug 2023 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691796517; x=1692401317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIUVmdz9W0Mk0KL3ySNSKHOwbP4OMB5UpbBAsVR/MHc=;
        b=QGu0Y4QYv/KtY+FsXH65da5iFOVTnuOXCTscn4O/V9pKhKd8Zg9v3M0UXPqFo9yf3P
         UPwmeWds5Qm6147gCAxpBgenEaYe6cfLGYtfG0hwN3OVgfdKZsPoHv+vM41rHtNZu2xi
         y0GnVCJtE49F6GkakQ0po0zyH6hIQ8vsnd3pHQU9ppo5j3GIsAiEamgH2OEK6BHQU9sQ
         C1J0PT1R2spSCPMrzNr/rUvF/QZ1amGKLot/uhuXa20h3qk48mpUn76D4u5eQVii28Gw
         7ALBM3T6ABjJptUm/r41sPcuHTFvf/gqm7cpHZRSnETl1m7zTTm8hSuXA9iqb3z3oOh8
         9uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796517; x=1692401317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIUVmdz9W0Mk0KL3ySNSKHOwbP4OMB5UpbBAsVR/MHc=;
        b=ZsYb3hxQHHx/4n7l9YDnLPSTQ4ZiD7hgUdcssiZp0SkDVuAGH4tGlC0xsKWeCgOqJZ
         HKqxxMtahsQE+6ch7gzQPR4wZ4Sn7E7bchlCSyVDQB4xcXR+/f5jIsjsLjfYkabWxEqx
         vsH5BAIKyzqlGs7r1sop4StIGPvjsSOq1Li8gRBXjAV1Sa+eVZZnG6WWUjy38fpBKg29
         6lv6yf4DJiFlc/J9bN7/CvTcMJstz7HM1UmMdkn47W33wsyK7mB62ORJOBpVFphEJQt5
         empQiTLlskD0ZIvDAIu6ikXkniYOgQ/YwZ+dADyDdVA/3XSqn8HXm77YIm78JU++C5Zy
         DQbg==
X-Gm-Message-State: AOJu0Yxc37kexpaBt0ZJlgOJkRB7+iv54f11yG2J6EALKAj4wdfjemko
	ukE0JaxB6wj+WNPoDHafiYYeJHB902YcCA==
X-Google-Smtp-Source: AGHT+IEH/DRyJl4tSzZ8eR8WY2kdjF70nklx0LAjELtz4lubhb+zFNwCm053tNkiksFUG6/yWjyoyA==
X-Received: by 2002:a05:6a20:258e:b0:140:3775:308e with SMTP id k14-20020a056a20258e00b001403775308emr4370843pzd.0.1691796517618;
        Fri, 11 Aug 2023 16:28:37 -0700 (PDT)
Received: from alfred-laptop.ims.dom ([69.178.150.39])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b0064d47cd116esm3817422pfp.161.2023.08.11.16.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:28:37 -0700 (PDT)
From: Alfred Lee <l00g33k@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sgarzare@redhat.com,
	AVKrasnov@sberdevices.ru,
	Alfred Lee <l00g33k@gmail.com>
Subject: [PATCH v2 net] net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
Date: Fri, 11 Aug 2023 16:28:32 -0700
Message-ID: <20230811232832.24321-1-l00g33k@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the switch is reset during active EEPROM transactions, as in
just after an SoC reset after power up, the I2C bus transaction
may be cut short leaving the EEPROM internal I2C state machine
in the wrong state.  When the switch is reset again, the bad
state machine state may result in data being read from the wrong
memory location causing the switch to enter unexpect mode
rendering it inoperational.

Fixes: 8abbffd27ced ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
Signed-off-by: Alfred Lee <l00g33k@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c7d51a539451..7af2f08a62f1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3034,6 +3034,14 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 
 	/* If there is a GPIO connected to the reset pin, toggle it */
 	if (gpiod) {
+		/* If the switch has just been reset and not yet completed
+		 * loading EEPROM, the reset may interrupt the I2C transaction
+		 * mid-byte, causing the first EEPROM read after the reset
+		 * from the wrong location resulting in the switch booting
+		 * to wrong mode and inoperable.
+		 */
+		mv88e6xxx_g1_wait_eeprom_done(chip);
+
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
-- 
2.41.0

