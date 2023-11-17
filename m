Return-Path: <netdev+bounces-48550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4197F7EEC6F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 08:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7698A1F227C1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 07:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA0B663;
	Fri, 17 Nov 2023 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wYbcyism"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F472D52
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 23:06:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab7badadeso2297493276.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 23:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700204764; x=1700809564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ag4QJwAFTMvtxQitzc3wtKGcikFcJHkhggRFwsEsrq0=;
        b=wYbcyismUeYAijn1luK7Jw1lzwWusAjVrj34nY4wxVco1FKhDa1tQ252xFXxT1EaZY
         JpK4j5T68fvlPrFG9X7rP/8qqIouLoUsCiOXgsYOwXP/3h2ilAtJoMyo+p7irUL2qqS/
         nIPu+hR0Y54VkQo+WjHrfhZINVbN/Mooa4TqJCr4/zbLXPO/d1fO3DfZra/7tdPaW+8h
         ko7qxLAzUfDNek/mwFF2T3ejAWC3PRPsoTVMvTCt96zfP7BOsMy/wtNp3A/PUwbqWqpd
         0NtI2LEXNeizVfmMFuwqTfSFxga5ldIN7xm4+FIF2jCj/eQAZh2qxqWjGHDAx9yyPrbr
         OcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700204764; x=1700809564;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ag4QJwAFTMvtxQitzc3wtKGcikFcJHkhggRFwsEsrq0=;
        b=wy0RYBoSKzPM64rMVcKplx9WPKbDP6vkMV1yOqN1W5iq4HdVcTM2CiSSArpsMHN08V
         otJR7mS1ezqjwqdokua0FxdZGKb/8UYRXZOszjJ8tVcHw9lrZBlRXxu1MQwjqjFfDAXa
         T5XgoUxsqdsAFDySmlEo8Z7LnCEfpBd10p2oVySlsEHOetIMdzeLTPkRojWU7sRz8HId
         YEnImLgFBdYLbZcjocrOQbNwaO5NlWUlGgEeF7f5a0ENX/h7N+2oBAE3+VNffKfwtZod
         RaHB47JWoOZORxLroN6Ryp2C2k1KPEUOHLDPnPLT/JunGS0jr/Q/4r7TijtBUGPulxB/
         fXFA==
X-Gm-Message-State: AOJu0Yzej3nFArz5mgziC7V3idt1v3fdM/ejwnHiSHtQsMO2KVyT9A4A
	C1ZkZbfEkn44arnV6u23gZwb8NB15GQS8hc=
X-Google-Smtp-Source: AGHT+IFlg4APaNYf7GwSTUnP88nwpRaVjMbWzpUCF47Lp2ZpGyDFLNx6bFd/UNTDKzI78d+cxFGju9X2VC/9kkc=
X-Received: from jlw.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:41a])
 (user=jinliangw job=sendgmr) by 2002:a5b:151:0:b0:d9a:468f:480e with SMTP id
 c17-20020a5b0151000000b00d9a468f480emr420396ybp.5.1700204763883; Thu, 16 Nov
 2023 23:06:03 -0800 (PST)
Date: Thu, 16 Nov 2023 23:04:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117070457.1970786-1-jinliangw@google.com>
Subject: [PATCH] mctp-i2c: increase the MCTP_I2C_TX_WORK_LEN to 500
From: Jinliang Wang <jinliangw@google.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>
Cc: William Kennington <wak@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Wang <jinliangw@google.com>
Content-Type: text/plain; charset="UTF-8"

The original value (100) is not sufficient for our use case.
For example, we have 4 NVMe-mi devices on the same i2c bus.
When sending namespace create Admin command concurrently, they
will send 4x4KB data to device concurrently, which may be
split into 4x(4KB/64B)=256 packets.

Tested:
Before the fix, we will see below message in kernel log when
concurrently sending namespace create commands to the 4 NVMe-MI
devices on the same i2c bus:
kernel: i2c i2c-6 mctpi2c6: BUG! Tx Ring full when queue awake!

After the fix, the error message is gone.

Signed-off-by: Jinliang Wang <jinliangw@google.com>
---
 drivers/net/mctp/mctp-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b37a9e4bade4..b658aa040620 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -34,7 +34,7 @@
 #define MCTP_I2C_BUFSZ (3 + MCTP_I2C_MAXBLOCK + 1)
 #define MCTP_I2C_MINLEN 8
 #define MCTP_I2C_COMMANDCODE 0x0f
-#define MCTP_I2C_TX_WORK_LEN 100
+#define MCTP_I2C_TX_WORK_LEN 500
 /* Sufficient for 64kB at min mtu */
 #define MCTP_I2C_TX_QUEUE_LEN 1100
 
-- 
2.43.0.rc0.421.g78406f8d94-goog


