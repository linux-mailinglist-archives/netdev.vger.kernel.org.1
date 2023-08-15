Return-Path: <netdev+bounces-27529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2977C454
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C450C1C20BC0
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 00:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8019C;
	Tue, 15 Aug 2023 00:14:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CBC179
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 00:14:13 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB54172E;
	Mon, 14 Aug 2023 17:14:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68843478de1so677398b3a.2;
        Mon, 14 Aug 2023 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692058451; x=1692663251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yl5BFlBDcW+MGrE8+Ois62MVPDM6ryT0SugwmhUr5hA=;
        b=HHN6LiExmLsPJXVPpAJmtI23OxwBJ8JHHD9Zq4K7VNYd2TkKIn+4y7J6Sd/ioCDNOl
         XAK3Qy2rVYpIfHx+GQxYtgFbxYBnbv3gtYpaMlA1DJ8Whv1MvR6XjMZ7ASGEcbWoQYZU
         ahupBrjhUGPwL1Wxv4oB5XfYPNr8EVjQDNBw3Rn9bk/6XerWWcJH0TkUXPQk5LVstlF6
         /kFtg232qw21vd2zekAQyj5617RI939V4zsXKUqE9kBXTdOmdQNCnF3OK2qFhAQOCl2+
         yymoC6dAKhEG7mvvKDU+61I3B+hmzJld8UdlXuGEOgO+vEu8EV5t5cycTByGR4jqZ06r
         QILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692058451; x=1692663251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl5BFlBDcW+MGrE8+Ois62MVPDM6ryT0SugwmhUr5hA=;
        b=ZKcEs6Wm0Hj/brhSn7gnuZMG79XyBipOMShW6pmvrNpuHAamR8jHm3qr8foTNOqz4h
         RuJl3bVJsic4zrzXg/L/PJoE3/vQk5kMeqguTJokHseRBXNXraaQDuviF17VHhfS0AQr
         HXlpR/KnRaT7R3hR+92dXTg9BiK6KgwWV1LqBujRNs0xCcB+i6gDa0Ad9RX5uLBrolAK
         DgGaf7tYlEr3ceaaD0F4V1Kp11KP+BiRvOWI7Ej2Ss5BEK+bg4GqGmjKwwMCUzxoBeRZ
         jRNiND6zU949J4E3pqbWdKeWnhD4DZ4ecalD/qPETc4trjOAD0SrVTscNqQPUeip27C7
         knfg==
X-Gm-Message-State: AOJu0Yy+OHEvpWvDI9/s627GxAzR/ZS2rFXV4yF71QntdUH+IwYmnQHL
	z4F0+cRiOqLnSpUT/s3oC9wa2rkLJgbLnA==
X-Google-Smtp-Source: AGHT+IELdZAh4H/VbI+BgvpFRCQhs7xh/6Udx+Y0VcHJpRQgabXjgg2VHc9qGxob3Kp9w45/P+DX8Q==
X-Received: by 2002:a05:6a00:21d4:b0:686:bc23:e20a with SMTP id t20-20020a056a0021d400b00686bc23e20amr12351714pfj.21.1692058450748;
        Mon, 14 Aug 2023 17:14:10 -0700 (PDT)
Received: from alfred-laptop.ims.dom ([69.178.150.39])
        by smtp.gmail.com with ESMTPSA id s11-20020a62e70b000000b0068746ab9aebsm8686403pfh.14.2023.08.14.17.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:14:10 -0700 (PDT)
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
Subject: [PATCH net v3] net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset
Date: Mon, 14 Aug 2023 17:13:23 -0700
Message-ID: <20230815001323.24739-1-l00g33k@gmail.com>
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
memory location causing the switch to enter unexpected mode
rendering it inoperational.

Fixes: a3dcb3e7e70c ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
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


