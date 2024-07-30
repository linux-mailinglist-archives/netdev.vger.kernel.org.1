Return-Path: <netdev+bounces-114113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF06A940FD0
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C8328147D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B31A0B12;
	Tue, 30 Jul 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x91cXv63"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682A1A2540
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336023; cv=none; b=Rq+OPO17Zy4VHcEIBFwzG6B78ENHZKK/7ggqJkBvMcLqdvS44yu+rnf1zc2gnwMnOtMU4oorV15qChjBXxSQiNwD8xd56RdeSXalHeTe112lf4yHYgOL/gVV9SA9B21tG5MfBvyWPCRRZSkzDDEE118FngC2hFCFf3vP7AY/hyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336023; c=relaxed/simple;
	bh=XK2vz41KExPbrsjdjcBuzNEb9VnxO/ji4DDW6PPtcz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7aBllvA0iq7144xBw8UI13GNYg6BXmlwsT/MQRiIxTMcrwca1gLsh+nYgkHcTekJi99IbCh4cdHsDZcJxdKoop3x7YgJFaz6sI2c9CtbAIs4winMA3Ogsp3VIV+pIMvEODZH+4Ffuvz8j7Uj7giXwwzAf4ApsSpECD6NGXxxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x91cXv63; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280c55e488so16666835e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722336020; x=1722940820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yf2EBrF/xoIg4XnnkuWAq411eye617onXjc36oa4tx0=;
        b=x91cXv63377pknF15NFhPB4zj6PwuQJbBRNLr2qjPKo+/ppZK78O9KsKArATufEyuX
         Nq9p7JWft0ScTkfjFCfhM1+mue9rWemKDdma5uJULuQoasO4OvMP3hP8hjsroekdwoXK
         ptggdvYAeIU5WWTEHH6Zmd9tDJPd5S5CkDI4peHzI6Z+2DvbP7nATDUvPObWO0wmXcom
         cnZZBWuKOT/BJUL0kPEZvoIVy9NenOfbsRtAEhB/SSo5/W/DWYEbNRcXC1FMX9YJ/giy
         3rz01H1WL90/vZiztuTbuj2A95PEtAKfN6YsKIL4JdWbIdzvSWYWV/avO7jlm9kuXe4V
         q3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722336020; x=1722940820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yf2EBrF/xoIg4XnnkuWAq411eye617onXjc36oa4tx0=;
        b=LFwYiRUzNXVzZiEXKE6FOP+kn7aV9cuH3sT6fKE/m8mhi4zwUlUr9Z10Zj/ezMesAw
         r5SB+6JUwrW/zjMaTICr/spMeOAU/g83C/n0GlU+NDxwgoZgRleza6f+TScEQOpBHnB6
         Aj6vaw2DMrLux23DRVi2AulhGBSo3xAwShW21000uddQXmx25RNAxD9Gw2KnqTaUT7mT
         KufJGpYf7SfLXPehiYTDbJD3oEmjmaHGOZ4qWDW6jhrMpdvESSZK53EJiFzTKP4i7pnw
         pp7EaMHrv8CY+7cwcXaJWZmdhZySpSc7EMXtWLj1x+OxCkDsqub4Tyb0SqZ2s+UJmu/i
         8zVg==
X-Forwarded-Encrypted: i=1; AJvYcCUm9YQiI01cVTsuhj5jREJh4ntFUP9fI+2nLxxDm/sabtxS7zvY+M0DdCs5vEv0HYaGKzw6l7BCa+HB6gIam36jIIY7VbH8
X-Gm-Message-State: AOJu0YzKbsCO2rALDjLMUvz76oWb1kpdubgR88arLAjv4rBICiRxbXsr
	nwS2KzW/7QA70xO5avVHQ4qYfYWpUYBX4wcO22mgz4bcwnulRajceg8Zacrey6o=
X-Google-Smtp-Source: AGHT+IFztmIvpi5e6zvIrQFHfTnJ6M1HTFlAZ0o0tSn7EJGgisCW751On8kDQJ0gXBzeW2QXpYXtPg==
X-Received: by 2002:a05:600c:a41:b0:428:9c0:2ad with SMTP id 5b1f17b1804b1-4282445d0c0mr10083445e9.18.1722336020479;
        Tue, 30 Jul 2024 03:40:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42809e4423dsm175962665e9.13.2024.07.30.03.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:40:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] net: MAINTAINERS: Demote Qualcomm IPA to "maintained"
Date: Tue, 30 Jul 2024 12:40:16 +0200
Message-ID: <20240730104016.22103-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To the best of my knowledge, Alex Elder is not being paid to support
Qualcomm IPA networking drivers, so drop the status from "supported" to
"maintained".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

... or maybe this should be Odd Fixes?
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43e7668aacb0..f1c80c9fc213 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18452,7 +18452,7 @@ F:	drivers/usb/misc/qcom_eud.c
 QCOM IPA DRIVER
 M:	Alex Elder <elder@kernel.org>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/net/ipa/
 
 QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
-- 
2.43.0


