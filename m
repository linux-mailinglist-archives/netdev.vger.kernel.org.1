Return-Path: <netdev+bounces-244766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A3CBE4D2
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E917630CCA65
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AACF33F361;
	Mon, 15 Dec 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GHfUKKIA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADB33D6DB
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808282; cv=none; b=srdnqYkH2PL9bK+WkQpIu4QvZxLwFKLFAhNhMPSMkzwdGqBiaX6kKjv3Gs0Nv0HYDc+NX4VHTplpkDGq7ap8enOpQdYFoRuDqkYxUHISoLDR6WoXx6t8PhpXnrjYtaK73OB9CeoTXS1Iz/qVUp7QEQzwjW1bjzgbGoQIOzGpEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808282; c=relaxed/simple;
	bh=KuzBomJ+2b6IkLEr6dylmkMduKhBvGwTMDuWUs1IqUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvZpgpT2hrvpdLSSaIE+4dSMu2e7X9jDHgX3BL36ja6SYFZWH8QoNUQ/vD802/MZDV7eGh9jt6atzJORNKvL8KXpKJ/wcoSbgkzUwRXQiamW8XjH2Qbossy/NSD3c5C56hk3EnZjpW9q/d1BqaF1hQetsVRdAr16PEpmRHrSuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GHfUKKIA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so5948396a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808275; x=1766413075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz/rLe0gEEPSg+6BoTZK8cqpnlYbSYNZB83UFAX5Ufw=;
        b=GHfUKKIAYVKLvy09ubIhhIgS7Iiy9f4fcOTP1Uw6+Eu47oaOvce+moUrZ9APBpAnbr
         1x5O2j/riRKrnvSpor3Or20MTA08jmXLRRfCsXNfRk9Ft88GYomfjR0nuWyQqnUxUNLB
         MSf56mbGr3NjPJPhYKtIDu57mCmVqMuRfTcMrvHDWc2dxocuSb4R2UQxVTiPY4psx7uT
         yJCotxm/g3MAho6vaBxEDHRq+qVFsk1frhoRzn21CtcTK9yBVhjtCANlBsxOJCUYwBbN
         X5kwvKwnhTemkpdy+leMkV3G/jzUnnSj1Rg9aAc+0xvr0MSmxSY+AOXP3skq0xeChrgB
         NVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808275; x=1766413075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tz/rLe0gEEPSg+6BoTZK8cqpnlYbSYNZB83UFAX5Ufw=;
        b=LftIGOG914/AkCwj9AcbIueI6C1s6+LKJ1dIdl0zdkU5hY2OiZiSrE4uk6v+xyei0M
         Jt+PFsRQ9XcGINEH/Q43PS3qr/RF3zrdsG9zX96/QbyBMZMYKSsUVb+wqbzMGrGiu+mt
         XV/MobV7u4gKijr46mD6c+WsJHWsmPyLhhDKVcQU92mTqH3+5yPiY+GrnzwAxmhkEhJQ
         Ls0Tm8cNha3r8tt0WHo0Pzr4ENck6zsUUOeXFZEI0nYLQg3e9TVcsnJnSAnJdsbsbDpr
         IOgi+yk4JcEstc579FyXIW5AuFbgpJe2hCJoUj5hw5yIUPm8mX1bff82mv4nZMJdliZx
         EcBw==
X-Forwarded-Encrypted: i=1; AJvYcCWCgFKHketpVzdjk0FrEDtEWxBoegm13MaaRotGSb/fggjU78brVinjX6A8uCOAhqIu3jkTy8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oV30YEtYaPZbptBe5wvms8rkMEiuscqsJurzLxKPzXbdZp9p
	hYYabENEAEaH7G9Mw3BbwatAN6KcX3RMimIgLFCmR5NUv+Kd5tRPsSddy/usJoMx6lBQySce8pS
	Et0gl
X-Gm-Gg: AY/fxX43IUg9Cd1WdG100arGRchkIuJkxWKA9Xr3T2fjJ9QdGvuuGB+7/xIMIztZr3C
	fWeBWb6mDqyhu4jCwMndFZ5tQx44b9Rz+xrlmgvx5fDHEVmtpgDHjVIRxAODFH6tU7jqFNbHGXm
	qRtlpuawWqpSGqtLxaN5tTD0rmbxgyPy6jDV/Pn2yPtpyYqFJilp7lV7+rcYnn8avR3Sc5gfGrG
	e334I3tOcagYl9t74T9ArOTBl2JoOdKLSlMlkdsU0sqRl7DXgerDAurxcjQDDmj+k5G/vFsnWuF
	qikVfxnxcGTzbOfb0zyoDFIUPZS+g5N+pxNui6Ozotw4PIJdhiCAcSGB0GRsb7ZC1XjtN2TC8Qq
	7yDQ/WjpXI01LS8XTycZCDkdPKnN56+a98I0Ro6qZJYvfPiQK9YO0unV6CBCEQ1XTrMN6sGAnUk
	9ChrV8OHndAF9l5ywcmhWQsfTVLUSxveyV9z+6/R0I1m4X/JBx5QkWWDzDxQ==
X-Google-Smtp-Source: AGHT+IHXNUiy/5yBOT4dn7umwiox+CfDP3uCJtKbMP9NvLprVYwnlB88jSKq4lkDDOMP5RZKyuAxog==
X-Received: by 2002:a05:6402:4404:b0:647:a636:76c with SMTP id 4fb4d7f45d1cf-6499b1f8b4dmr9871722a12.31.1765808275438;
        Mon, 15 Dec 2025 06:17:55 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64982227ba1sm13523693a12.33.2025.12.15.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:54 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 12/17] firmware: tee_bnxt: Make use of module_tee_client_driver()
Date: Mon, 15 Dec 2025 15:16:42 +0100
Message-ID:  <fc3ad2adcd795dc92106c35e9306c52f199e6fe3.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KuzBomJ+2b6IkLEr6dylmkMduKhBvGwTMDuWUs1IqUQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhplUIGHxY+kNc+ZnO2NN941Q0i8QiNARXnc uHMb9q9vG+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYaQAKCRCPgPtYfRL+ Tpg5CAC2TR34NPIIYAuCMyG/P/V874WeW0I8DBjfDj1sHTP/b5eQM9txRkeuAySo9lTtzf81I2A YZ13WAyDX0adgP5RhgtEsjfa90Hk+YTfNuszrHVf/XL2FMVoNxFvv+x2DqypHVM6eguDjv2F39L b+/hoVh6XHoGrr0U9KvJ3Pm15CINftKatRbBgm85spaL315JL78QMLhLet2I1dzCLblTLOBPSNk 5vB00SoF4E/JkOme7zwKoKdBozHPHlFCH6koMJTjAsB0HswWjxs64c16CUl61+W/4tJQYUniXof 8E4qisqElJ8CG1CgS6EqyNLPpVvFhWBQL2mUY7EZtOKt9jrf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Reduce boilerplate by using the newly introduced module_tee_client_driver().
That takes care of assigning the driver's bus, so the explicit assigning
in this driver can be dropped.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index 40e3183a3d11..fbdf1aa97c82 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -261,25 +261,13 @@ static struct tee_client_driver tee_bnxt_fw_driver = {
 	.id_table	= tee_bnxt_fw_id_table,
 	.driver		= {
 		.name		= KBUILD_MODNAME,
-		.bus		= &tee_bus_type,
 		.probe		= tee_bnxt_fw_probe,
 		.remove		= tee_bnxt_fw_remove,
 		.shutdown	= tee_bnxt_fw_shutdown,
 	},
 };
 
-static int __init tee_bnxt_fw_mod_init(void)
-{
-	return driver_register(&tee_bnxt_fw_driver.driver);
-}
-
-static void __exit tee_bnxt_fw_mod_exit(void)
-{
-	driver_unregister(&tee_bnxt_fw_driver.driver);
-}
-
-module_init(tee_bnxt_fw_mod_init);
-module_exit(tee_bnxt_fw_mod_exit);
+module_tee_client_driver(tee_bnxt_fw_driver);
 
 MODULE_AUTHOR("Vikas Gupta <vikas.gupta@broadcom.com>");
 MODULE_DESCRIPTION("Broadcom bnxt firmware manager");
-- 
2.47.3


