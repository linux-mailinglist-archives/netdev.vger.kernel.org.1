Return-Path: <netdev+bounces-117984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3166950295
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE771C21D4A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72CE193093;
	Tue, 13 Aug 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwRw7BTm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50218991F
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545552; cv=none; b=fK//39zOQgf/AEAJp1WV0eXuL59ytywnWRCYAjxcIv2wT0z5HSVg7gSOKworBtr5Pqp6jSbLNTJDtwCeiChWj9rrid3KYNewk5HGOC5OYdV1qLivWg2Nztgm9YmqhMx5KDED++R4p/ZF+6ZvlmxhdT98aOug119Vr3wYuIWGyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545552; c=relaxed/simple;
	bh=fBiBB72seByPR/LQjvOJc5w6OgAxSgqTj1kzOZj3ods=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pq2b7BX7oLNpcvkeenntXq2QD/B8WVvTIQUyo0sNV4KsuYDo9BOtitrW8nMG70ov3ONNYQ8U1pPd8XL6kBZA7SjRvzMv+keqeUc1FmCfk/9RK+N35nhFvf97JWzZTjXv8r11ffTmTJis+y3G6bxyizHT9AHV49IzYi2I0OcX9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwRw7BTm; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44ff6dd158cso33775521cf.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723545549; x=1724150349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jodWGM3qFCwiaXWXlR6WrhJO0c3QgWrsycfmzzz4DaQ=;
        b=vwRw7BTmuDXi7bmCrLEn45b88nQHpvViz1JFALOM0Y13ZbPqltypcc3W7and4wZDah
         Gq9Y6UNTHLlGcxP8lyL8RoxOfl++XLJrC3t6cCDXW3nb/bgB+Sr3D3uaWqm9xNEswQ/I
         +STmmU+TRWKWD/ZEEYAxwNG3pZiEzeEs6dLEhfta/rxlub+DUY40n7lMmSY2U/Fac/C6
         p8DepSE2m3iMP/s+VPTqVK7oyk93Y/xAN1VQsVFsBIlLh+OICQYiqJYEscJsC4qTkJOK
         1OyQVlDG724Ec8Fs0nFQ4ZeE9MTzSojqMrGEV0asGVmChQ+uSl2roktYypWQapMEwGFI
         Z/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723545549; x=1724150349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jodWGM3qFCwiaXWXlR6WrhJO0c3QgWrsycfmzzz4DaQ=;
        b=MGII+uX40lFkCx/cVJJxc4RYXxmFwvGWzU2CsZavRwhsYc+yxjrCIzU1iwSVDf0cnr
         7iewIiZnB1RmH6WPK7LRhjbH9bsU/XkCTPTHyq2cquLR54ZTyxrkxJXXlkoU0hHqNTUu
         4XYobVvUkcf4qX4yKbheYUknMPY5ooseoY4L+rEfR1dhwO9MJlK6zIui0+Osa4/lW1Gy
         2o8SjmB6soWeCvHiLJ+V6XEPAcWnUBEYxojvZRXgtMfQCV09clG6bk82JDyXBYgwUzZV
         acaE/5qz5AuvZNhPWyRNDYh9HN3bG9p8vy36rF815gfVkAu4AMfnd9TQGRCk2ScaHX06
         4BuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkLrQiVmMigP4aZ4byMYytp8RtXhIPYP09j4llDJNmg/IjaYcANbBNG+ch25Lks4mbW2pZ0caXEeT10J+LD0QQZ5VHiGHg
X-Gm-Message-State: AOJu0YxdSkIs5tJa3kew2nyThn5rKxuOwyEaoOKVE61XulWbfofq9299
	xGaOsiXHZUjfU0Hklk6NW5bZlZQ3YXas3HNF8B6A+qHThByM3cQSShj56MBDTBI=
X-Google-Smtp-Source: AGHT+IEQhu0sZEQwCMkuuHp2+Eej+3CluKEqgv7pqdVvvNrpNNxUEkdiadArn7M6LWgxB6RNVXMWSQ==
X-Received: by 2002:a05:622a:2486:b0:44f:fb58:8c3e with SMTP id d75a77b69052e-45349a60677mr39456191cf.46.1723545549177;
        Tue, 13 Aug 2024 03:39:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c28fdcfsm30942681cf.90.2024.08.13.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:39:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] nfc: mrvl: use scoped device node handling to simplify cleanup
Date: Tue, 13 Aug 2024 12:39:04 +0200
Message-ID: <20240813103904.75978-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nfc/nfcmrvl/uart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 956ae92f7573..01760f92e68a 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2015, Marvell International Ltd.
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/of_gpio.h>
@@ -59,10 +60,10 @@ static const struct nfcmrvl_if_ops uart_ops = {
 static int nfcmrvl_uart_parse_dt(struct device_node *node,
 				 struct nfcmrvl_platform_data *pdata)
 {
-	struct device_node *matched_node;
 	int ret;
 
-	matched_node = of_get_compatible_child(node, "marvell,nfc-uart");
+	struct device_node *matched_node __free(device_node) = of_get_compatible_child(node,
+										       "marvell,nfc-uart");
 	if (!matched_node) {
 		matched_node = of_get_compatible_child(node, "mrvl,nfc-uart");
 		if (!matched_node)
@@ -72,15 +73,12 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node,
 	ret = nfcmrvl_parse_dt(matched_node, pdata);
 	if (ret < 0) {
 		pr_err("Failed to get generic entries\n");
-		of_node_put(matched_node);
 		return ret;
 	}
 
 	pdata->flow_control = of_property_read_bool(matched_node, "flow-control");
 	pdata->break_control = of_property_read_bool(matched_node, "break-control");
 
-	of_node_put(matched_node);
-
 	return 0;
 }
 
-- 
2.43.0


