Return-Path: <netdev+bounces-121738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2304695E4BE
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 20:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A638D2816B0
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255E16B385;
	Sun, 25 Aug 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT+QyFji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E04E56E
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724611997; cv=none; b=HevrU7bAPCl2IXOyRtRt8ZW5+BYKkNVw4oaDsHg9mHfgzA8bT5y8KacW7FDgHVVZ6fQOL01YRb87D3Nk98WHD5BKsXj+4m36I8b/wpJhO7shlxnxE04r2cNvSpEYqs1/MTo0HdteDe5DhK96026GXHuSELi0I6qZ/Znku95uG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724611997; c=relaxed/simple;
	bh=9vexD2mmzgeQENC9LitcJeueSXuVsjquGp1/eS5zaO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tantA98yglnj2EzwlPwVVRjxRZH4+6JmX3N13l4eoqyJkNkb0EuEQPHQ3ebJaPdGw7zvCAAGdYljbq83BP3FXTyzZfnC0whV31kXhYgcqEFMmcJSTpyQyh61dB0erxZEXHNBkZZRyNZzbhREp8ePiyCR5yn65dQoJyjt5Dwq9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DT+QyFji; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36830a54b34so142351f8f.0
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724611994; x=1725216794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPdvIKW8FgFCV9KPcyxeAD/wE24NwXWq7P7bt6Yx4PY=;
        b=DT+QyFjiMZ4lq4v1MKjk9rWGrZLlX3+x6OC9ruIr0kmHZ2xdSfhE0BWBnusdf8xkmb
         zWMgkqrVbJaYY+MKgh2DtIxF4daHJsiQWPRO5J6stjX/ch2+nTI7yEL05jtXp/s+RzUA
         guc0/DxmN+TuJxwQj6999Cjkzpg2n4XLgY0Nl1UnKiJa1eMlq726x51ONajWT6Lbz0JI
         tZ16GSJeg7rBTm1cR5Ez85trPKeDV6U2FPO0I+k/3SxHkPDs2hjRbl6zfqtL/97qBGUu
         Lf8dD00GquafBabN9hKfEbOZUOeuwm3QvK3Q1+OSnxF+moYttv+jLzhL05JwLDOoUji8
         nttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724611994; x=1725216794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPdvIKW8FgFCV9KPcyxeAD/wE24NwXWq7P7bt6Yx4PY=;
        b=QnhZcboptx2arGS/vfZ9q0yaj0FHY0Km8WFMHxpcbBchSnneIwmNy5vmPT0Mpg2JTu
         4zXLhQyBUDJH+eBtjpKZTKp/lhIpkeiM8ad18tnUuRbwJoNwI/X29c8EdtUrcLMnlNi2
         pE6tryV3jTG47bEfOIooB6bF1dJdLSZAmsjnusHPvxDekmrNQqc14cHNuYFsQSSwQfrg
         u1BjGovfnpJGNrVWzZODbdNPDX6bhHXzjt0b02/aW7hYtc6Pi4uB8PvEeu+8tqCSqB+L
         gTjMgnFNbj6AHSPJlm++xgIdQ/yrc8eMPrUKxd7ai9A6IhaG8vfXGxgn81M+PC7IQUcD
         7naw==
X-Forwarded-Encrypted: i=1; AJvYcCVVZepetchEbVRn9u6TOfapSNttxRG6kb+ShdVGB4WPs+Xb4hPilmKG+dM03GqLCLqFqCNKhf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+KUX6x3dOeO6cVXrq0aHWNLl8C9/4Blbuo0f/1en+efieAyO
	6eWBd1QloHmtijFtrW4y9IgFzN5NBa8d3Baz3BiZdzNss1FL6h+T74T/R+hjHH4=
X-Google-Smtp-Source: AGHT+IGb8eO/KaLKd+muI8oRL2UcYKsg2Hp6fGBdqiipIr+mKyxHMhWPUMMnIuurLDu03AVaY4a7Pw==
X-Received: by 2002:a5d:598e:0:b0:373:6bf:95f1 with SMTP id ffacd0b85a97d-373118439e9mr3348095f8f.2.1724611994244;
        Sun, 25 Aug 2024 11:53:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb76sm9130963f8f.8.2024.08.25.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:53:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] net: hisilicon: hip04: fix OF node leak in probe()
Date: Sun, 25 Aug 2024 20:53:09 +0200
Message-ID: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index b91e7a06b97f..beb815e5289b 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -947,6 +947,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	priv->tx_coalesce_timer.function = tx_done;
 
 	priv->map = syscon_node_to_regmap(arg.np);
+	of_node_put(arg.np);
 	if (IS_ERR(priv->map)) {
 		dev_warn(d, "no syscon hisilicon,hip04-ppe\n");
 		ret = PTR_ERR(priv->map);
-- 
2.43.0


