Return-Path: <netdev+bounces-26279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB2B77761A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD78E1C21531
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311ED1F947;
	Thu, 10 Aug 2023 10:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A703D71
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:39:37 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0BD30CF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bfcf4c814so114245566b.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691663970; x=1692268770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jIDcfRa5bQrAAvNrBK/T05RZeoNrH4f0IhaNYH0qEk=;
        b=Ou/PXNVkrZ0gFmvLf/CUUPD02qmBpZPBp/7ZPlaVAQfxS6Q3FsRXj2MuT+nO47zIL1
         50sLDZ1tyH1RkS165Fs4Pun4NbBgch0QbnLE6avXrbnAokogg82v5TWHjcIwlWNmPGwm
         rmL9soHCKd2A148Gu9TNbT/RlksINalIISYo6utNySdACHvPq6T5mP/I1d0ruvtvBIms
         wwDRpeV1Ud+RlMTrpgkJqNTTx2bBnWZMjPTpgfqXb2wbhCozqdTpS1NAFE+rBG9J/yn8
         7w5E7+lzTpnRz/YD8dmC3lgukUrkyUYu7G1537rjeX9D+CCAcZFQtnUTC05z+mzEzBvo
         nPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663970; x=1692268770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jIDcfRa5bQrAAvNrBK/T05RZeoNrH4f0IhaNYH0qEk=;
        b=k8+Pa5YGEtJ5/yqX6wPRlXbcDmpHG44+FcpZ/Ech2uMXaI7AElenJQ+hQkJdMF+b8P
         MztupsEfjdXdRySojB5Qx8mDmNpAXwodZWm0C+okt8kpmYzjAfSn3TkNaeeE/3kp7I9l
         B9CE22049QhVMc1yIGJEx40tN1/Gob1sXQ8cSnoYnCvA9bUYigOpSXSYkrdzn2bih1h1
         K3Yc76zwxlq2vVAt2H6k21Yl3mK+c27+N60+d7w9Q7yF1SlJUbdftUDgfHbl+sXWGHdO
         R2zBkcl6Lp1FUnb7YF79fkTnCTcOhGB934nMAAtVUbTNmfihMnMBr3DdHeXUfILuLDFH
         +C9A==
X-Gm-Message-State: AOJu0YzT1wGwgu5SNvQvgmETmghVKBsMmdFwi8i/CanqvacgvisJW/dN
	osWon4M8Fx0dBfb4sY/Kgpp6SQ==
X-Google-Smtp-Source: AGHT+IEHvfupsGPUShfWixfcFmXY2PzdYtRDhaH0OKDoUGuOpHMA4CGo8dgjRsbVAoa2w7Kug70V+g==
X-Received: by 2002:a17:906:51db:b0:975:63f4:4b with SMTP id v27-20020a17090651db00b0097563f4004bmr1802753ejk.36.1691663969883;
        Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id mc5-20020a170906eb4500b00999bb1e01dfsm749244ejb.52.2023.08.10.03.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 2/2] net/marvell: fix Wvoid-pointer-to-enum-cast warning
Date: Thu, 10 Aug 2023 12:39:23 +0200
Message-Id: <20230810103923.151226-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
References: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

'type' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  mvmdio.c:272:9: error: cast to smaller integer type 'enum orion_mdio_bus_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/marvell/mvmdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index a1a80f13b1e8..674913184ebf 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -269,7 +269,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	struct orion_mdio_dev *dev;
 	int i, ret;
 
-	type = (enum orion_mdio_bus_type)device_get_match_data(&pdev->dev);
+	type = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
-- 
2.34.1


