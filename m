Return-Path: <netdev+bounces-122382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD71960E18
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A3286F32
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F043E1C8FBD;
	Tue, 27 Aug 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEtLB0EG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124D1C57A3
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769872; cv=none; b=X9FGB5fxtL+bqgJcYhNLcwuTlvVKZ3d/U2kSt351JUX06ScRnQFJG2g2zc+oHtVG5xUvAHzeRjWOzrejqr6eOiZp/B62CbQcevugoN2Q5+KI3REn3CJE65cvgHIcY+GV5wiSjF9Vvio+YO6YcExez7Y6F8Q0rqY6Ae4JuSh32Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769872; c=relaxed/simple;
	bh=9cJgFjD/R7mUY/jBwLx1PxnCORxDvEzzYDQVq9k+sW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaFpvhzYjZU26QeSqVDt7ExrlCxglNvaCz8/t/S6Z9/MyaQqT0GukAip+v8KVOaeRJa9N8WDaUH47xRUuHQATTGib+EuiYsMk6cZvvFIPr/Om8uW838fYt358otCQZ8UcN56wP9zOsxT8b5L9l2aid0ypwyLrw5AfhlehRVlWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jEtLB0EG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3719f3f87ffso145736f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724769869; x=1725374669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEXiFF9+y1AtJUUe0lBIVMSQ2gFJFplRHBS/b2AQ058=;
        b=jEtLB0EGfh7uOtCd+PsNwvjljxe7mw5mvh5geXteqcxqEpZmdW28Yw6v0xKdQm1260
         VUc48XjuRj0QfuZrqL5tbXXSQTxGwoF62TVJX5E9T17EhD/9nfdQCuCc/enF6DKjXjga
         VGE8fng8kgN+V8bnpPBHB23JV2t/Xlh3rI1qlVA5wPK4RiQxnxZS2gH2GST9KfhpKQ49
         Nxmhwpbd7i7PSkHTmlu4yzlr0m3qJnW39D1LSBDxcnkZJ0JyGITJWx6HcINiVpCjFW6x
         c+lUMvkXR7vvGrwWaslsiU24unxtz6IlgcPuIERtCb5zMQLdYK33KPtOZeTt/PwI7GHR
         gjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769869; x=1725374669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEXiFF9+y1AtJUUe0lBIVMSQ2gFJFplRHBS/b2AQ058=;
        b=Ca+EsRhB9qEfCHH0u38jHNEIN8JisuKKFqAbL1BjbY3DsQ48lPXeizGxehmXDPMMxt
         IwbNHZ9+9QNSrwSW9LdCZ8T+z4o4DSIkcbJMduW6DJAFfUiU/R/zB7bNBPztOtbNnW7e
         k6yTutuAi2hS1F+0qJqexaDICzYKLcz6ClZbjiWaEma+lY+3NgGF8ZreisMZsC0QPmZC
         LSBVRA8gUfQXo8MeLxxTttDoH2XruCHu0DbwOHxtoejMzAsvwG64eBYRctbSTE5yAB5r
         ZzvsOxqvPuktzrrJ13xWv8Rflc+BngMP0tsJqB9oe1H+nVFGX58Fv+cHmqIA0XJFck+D
         Bx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtd2fHpG4FFfjAd0un7+LyzS94pc0ILMmm7VummslTqgXi59EDxwgcc/fdfYZhrPqJxteG1uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlILnTbXee/z2DjcwTGvG7sMBkm9k03Z2UsJRmhE5YOJkc2JFQ
	+QdRZjh2jaW3DeXN/cLT0XaNrSvdvvgV8Xg78FJVFaPNpV4xZVwPo9HV75s+tcU=
X-Google-Smtp-Source: AGHT+IGffSjXGCUmbOSah5oQPlaHyK36FMHgV70SJ2QT+CDm/NnObADKG1Btd3N3UFma8fanv9/p7w==
X-Received: by 2002:a5d:648e:0:b0:373:6bf:9608 with SMTP id ffacd0b85a97d-37311843370mr5580812f8f.2.1724769869564;
        Tue, 27 Aug 2024 07:44:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff654sm13270457f8f.75.2024.08.27.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:44:29 -0700 (PDT)
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
Subject: [PATCH net-next RESEND 3/3] net: hisilicon: hns_mdio: fix OF node leak in probe()
Date: Tue, 27 Aug 2024 16:44:21 +0200
Message-ID: <20240827144421.52852-4-krzysztof.kozlowski@linaro.org>
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
 drivers/net/ethernet/hisilicon/hns_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index ed73707176c1..8a047145f0c5 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -575,6 +575,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
 						MDIO_SC_RESET_ST;
 				}
 			}
+			of_node_put(reg_args.np);
 		} else {
 			dev_warn(&pdev->dev, "find syscon ret = %#x\n", ret);
 			mdio_dev->subctrl_vbase = NULL;
-- 
2.43.0


