Return-Path: <netdev+bounces-38676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4E07BC170
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2943A1C20924
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0BD44497;
	Fri,  6 Oct 2023 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ2kN0AU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FD44495
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 21:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C59C433C7;
	Fri,  6 Oct 2023 21:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696628671;
	bh=UOwYY4Wdrq3qaLX+ulY/AMB64MrwJnjkGbdwZBFe+cQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RZ2kN0AUd6/zzh5L2ZWT9+G1ByFse8EGnk93FT1xyuGuiUcVJJWFmjvQFwkPYMQ6b
	 /8f3y6OOtmXkQEvO7Ri5xTxH8PPRgYf7E2b/e7LbHLMFaW+ZrGXb6qf89dDwun0xme
	 ffrUtPzoJFVo9RxkfSOh6OllDq75uTrQP3JoI7opI/gF4UX9I0kg/1rzzygKEKZYc9
	 Ui8PF6gzqjI007PHyR7lGS9DzJVw3bhPRxicyKau98Ktc4pMUcUF+bxFAtMdkFiH8q
	 JNjkO7Z9gykrEMCPLncN+aK03GKG6NkfxHjGy7QBktiwhP7znvGMAeIOUMFhHgG351
	 E/zesisGisnDw==
Received: (nullmailer pid 339633 invoked by uid 1000);
	Fri, 06 Oct 2023 21:44:30 -0000
From: Rob Herring <robh@kernel.org>
To: Chas Williams <3chas3@gmail.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] atm: fore200e: Drop unnecessary of_match_device()
Date: Fri,  6 Oct 2023 16:44:21 -0500
Message-Id: <20231006214421.339445-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not necessary to call of_match_device() in probe. If we made it to
probe, then we've already successfully matched.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/atm/fore200e.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index fb2be3574c26..50d8ce20ae5b 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -36,7 +36,7 @@
 
 #ifdef CONFIG_SBUS
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <asm/idprom.h>
 #include <asm/openprom.h>
 #include <asm/oplib.h>
@@ -2520,18 +2520,12 @@ static int fore200e_init(struct fore200e *fore200e, struct device *parent)
 }
 
 #ifdef CONFIG_SBUS
-static const struct of_device_id fore200e_sba_match[];
 static int fore200e_sba_probe(struct platform_device *op)
 {
-	const struct of_device_id *match;
 	struct fore200e *fore200e;
 	static int index = 0;
 	int err;
 
-	match = of_match_device(fore200e_sba_match, &op->dev);
-	if (!match)
-		return -EINVAL;
-
 	fore200e = kzalloc(sizeof(struct fore200e), GFP_KERNEL);
 	if (!fore200e)
 		return -ENOMEM;
-- 
2.40.1


