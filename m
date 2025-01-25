Return-Path: <netdev+bounces-160908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01294A1C285
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A10165886
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B621DB15B;
	Sat, 25 Jan 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Fdpxi6Et"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782EE61FFE;
	Sat, 25 Jan 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737797344; cv=none; b=LpY8OMr4heHwdB0KDA/KDfHSJ6S3x93zBQ1eIKoHvftLKLbhttyQCyp2YS3I6zhPcZ9xBRt3uslQIeqEHLR22fDM4pyw4L4VE5XeAFkkQzUbo/ILlGdcc31RaBpmDl9smASz2SeqAiXiYMQ43hxQdHOgdrDV1X1exRJ1GPifSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737797344; c=relaxed/simple;
	bh=srmj24MLXixAx0hmdSCf+5xDclkxBx/dZy2aOnK0zKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fEC9aoZGCQJ7UVEXQjBwo49LaaNfvOnsdrVMplPyZgVajLWWkF086eYE5NTjiI5bLLeRyYO/6V40qzIRUH0qmvnY7zOAtdQ88VDi+OvKJaNEPh5+8duwdog+tbUGSXpD1WTR1HKoHLbbVnCm0e9htL4Fse2Ee07sBDv8rnSC4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Fdpxi6Et; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737797331;
	bh=srmj24MLXixAx0hmdSCf+5xDclkxBx/dZy2aOnK0zKM=;
	h=From:Date:Subject:To:Cc:From;
	b=Fdpxi6EtNLCQiC/+SQzxQ+SgYGSVee1DPEwGY6/X0s2Bf43IeYMn5vR/1/EZsDmKZ
	 1xp1tDkIGqa9CVYvDDsWtc4NGSapIlJJPhRqU+HcHGBebtA2E8+DaxUW2lcHPBan9L
	 Y/57aDGNOnb7cLbbu0FcS75D+GB/ToB2ycQiW8/0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 25 Jan 2025 10:28:38 +0100
Subject: [PATCH net v2] ptp: Properly handle compat ioctls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250125-posix-clock-compat_ioctl-v2-1-11c865c500eb@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAMWulGcC/3WNwQ6CMBBEf4Xs2Zq2UBRP/ocxpi5FNiol3YoYw
 r/b1LPHN5N5swC7QI7hUCwQ3ERMfkigNwVgb4ebE9QmBi21kUqWYvRMs8CHx7tA/xxtvJDH+BB
 N3V0tmqpRVQ1pPgbX0ZzVJxhchHMKe+LowyffTSpXP7NW/82TEkrgTramKku71+b4dsTM2L/6b
 Tav6/oFFAnVfsoAAAA=
X-Change-ID: 20250103-posix-clock-compat_ioctl-96fbac549146
To: Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cyrill Gorcunov <gorcunov@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737797330; l=1826;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=srmj24MLXixAx0hmdSCf+5xDclkxBx/dZy2aOnK0zKM=;
 b=9SSn69jqiyr0Lwm0HkFURkSRerNNdHuh60vKtIcJ3TQfiS/bwxa2Bbq/OPh8SZFk4ZSAg0scx
 GdUbfAVlG9nAjMe9DKteY8ZJ72cFAb/sL1GUwafOFrCp7pXFhvIP4/s
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Pointer arguments passed to ioctls need to pass through compat_ptr() to
work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.
Detect compat mode at runtime and call compat_ptr() for those commands
which do take pointer arguments.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/1ba5d3a4-7931-455b-a3ce-85a968a7cb10@app.fastmail.com/
Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Use in_compat_syscall()
- Discard changes outside drivers/ptp/, they are independent,
  unsuited for the net tree and will be submitted on their own
- Link to v1: https://lore.kernel.org/r/20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net
---
 drivers/ptp/ptp_chardev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index ea96a14d72d141a4b255563b66bac8ed568b45e9..bf6468c56419c56c0737515d614b2267264816c2 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/posix-clock.h>
 #include <linux/poll.h>
@@ -176,6 +177,9 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	struct timespec64 ts;
 	int enable, err = 0;
 
+	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
+		arg = (unsigned long)compat_ptr(arg);
+
 	tsevq = pccontext->private_clkdata;
 
 	switch (cmd) {

---
base-commit: b46c89c08f4146e7987fc355941a93b12e2c03ef
change-id: 20250103-posix-clock-compat_ioctl-96fbac549146

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


