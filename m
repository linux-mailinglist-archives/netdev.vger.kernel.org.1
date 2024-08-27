Return-Path: <netdev+bounces-122380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B12960E13
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5542E1C231F6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF431C6F4F;
	Tue, 27 Aug 2024 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sETS3Xrn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3E1C4EE8
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769870; cv=none; b=QjkP7wKt7ZpLNGRmNxpUddisM+V+JTu3r3bBt1Dd87R41t08eGn9yzrz7DHIeOlckScHzHB0ITaFTYspaU71tMzfKnXo/mVQMpZzHGpTDiALmIVN+Y1XGOiVTJS1fpMvtPmNW+sF+Aa8+N3kJPD7785JDRLRS5r06GjpfZWW1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769870; c=relaxed/simple;
	bh=9vexD2mmzgeQENC9LitcJeueSXuVsjquGp1/eS5zaO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEDhhbf+5pAUn3TGxsAxwdeyN00LeYryWVDQoImr0i7GHZ8dhyb958pd47R6jrFoXwE5Glt6W9HLGVZxVhDD527JDHJeDZ/9jzA94nS9dBaoqowqbZ3AIiFpVe9u43yF9yB9/c/D9oZW2sZdUMlO8DQCaAijiVbNu8zG7cpaKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sETS3Xrn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3718cea0693so206575f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724769867; x=1725374667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPdvIKW8FgFCV9KPcyxeAD/wE24NwXWq7P7bt6Yx4PY=;
        b=sETS3Xrnqt8icel8VeHtXkw6LRpLmBxlzHyHhi635LB8ozM+v3+bK/rejagxrvGKuC
         OHpam32wVCwg4rnh/Eu1q7xi3lgPZCXwzVDcBP81Xs9uLcVpUlbGl61J5vbHw375mTZH
         YJeUqrlaALGJR1BOoxYg5ohhNd/0LRtcDk0NDHn4g80kZjNKNbdDxRKTmmWtp9i4qfKi
         x/MB3JGNoPmj13nyhsz2mh6vZjiv3LlwjnnT0QY7Zn3/VDFRHKDw+p8n40784WoWyc9S
         jxE+1kYLTfCJIcwMr/tWtcshgKWUfcgvkFAssrq5ZzT7+SxkvAI/vfvc7ukZlKO+/sXo
         h1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769867; x=1725374667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPdvIKW8FgFCV9KPcyxeAD/wE24NwXWq7P7bt6Yx4PY=;
        b=v5ohZPuuneV06e8Z8GgeW6yUY6wx/ixe2Y3C/mL/Y6JkviJW6TszZlam6aQ02mRLE1
         IH6YxAU/6cVRfvLlZYDzly9bkzNN4Xp6vsjflo9+Ex42f9jg90Oa6vhJIr/2fjG2yzls
         WQr+91nGmGqwcHHR5M0cRgUj4kNQiCC4Y/rn790PDJHHrxSs9v5fg/Jxhk0jRTwaDOFX
         xlwlpwhbO1xtQKcMQSa7Sz2q0TAf/feTgQnSIzhvTWit9ejgcz2cYm9304anhrD90Xqd
         rLQS41wPFbVeler3rHzSU7iOS6oe5cj7j/eHN08M8AXyUokkqY3ijCS2g54EXwGXoDSb
         Y+aw==
X-Forwarded-Encrypted: i=1; AJvYcCUAr9NeGKT9SP03HOJWCk2O3OifdQ4JGsz/sHWS+vUe895+peSc63nYVVax8HO0nxLFLgzVdJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpU1MJlbaoUdyvP3x3u2JAGFUovEQYflF+n/N6bCjxNaTNPKi
	G/XVLWzzB8q4mvLVfcq1A7E6D5Il9FSNJHWYY1JQErF/xILJUt9c7jaD26pKocs=
X-Google-Smtp-Source: AGHT+IEJsWgD4WKt2n6pCZX8Vmj/AnxM/MX4C4ng7kiuGPcfY33T6OA79b7gqBNqaj6PS2psGzM3CA==
X-Received: by 2002:a5d:6d05:0:b0:367:9495:9016 with SMTP id ffacd0b85a97d-373118e9996mr5514954f8f.6.1724769866777;
        Tue, 27 Aug 2024 07:44:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff654sm13270457f8f.75.2024.08.27.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:44:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next RESEND 1/3] net: hisilicon: hip04: fix OF node leak in probe()
Date: Tue, 27 Aug 2024 16:44:19 +0200
Message-ID: <20240827144421.52852-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
References: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
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


