Return-Path: <netdev+bounces-17626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13497526F4
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5BD281E54
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F11ED4D;
	Thu, 13 Jul 2023 15:29:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F71ED43
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:29:16 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5262030FA
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:28:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so13451625e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689262133; x=1691854133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk7c3gz9VhsIx4qVgTGY12ilcIgctHPAd46AqzeX33s=;
        b=cvKVgzY0rvgm4OkvM4Iyp4VIJ+PMtQ0TtSrTsq3VM3ULcOvJcio8bd6Sm3OT8W5bSv
         ijBer0POVkuOR93O6WwiHa7TAwLdQXpWx7mykj/+4qZznjSfilLlZLzcxUOyPWK0YIe6
         A189xDDkFTFaE14+wZpmkUGOw2fw+10Od0z05HNnCGPj160YV/yl1DOqRKHwRTd5HeCz
         OKwhmrRDlCHqDeQsvvdUPxHL0mYQiKmTCni60oP/tyRSv9E910w/Fol7Js0dSeMlsyxb
         thgC0pLBIaIIIFh8BqSkeh+ETqabVWiRNwx8KV460nyLaQiACy5oWAyD+AoJNwFQJ6DK
         LHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262133; x=1691854133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk7c3gz9VhsIx4qVgTGY12ilcIgctHPAd46AqzeX33s=;
        b=OE7dOZveDdw37bNftt8sf8zLBtCZ4i00b0a/x7zAbyLP2R7XBxXakE/cGon6Ra+p+0
         9VulUQ12HKOzoH03ikjAMsfgLnRs1Mm+E+UMIKdciFvzYJKb69lgL2mTjfM8ecczRgnj
         4PpCR9aBGtXhwKdeTgXZqthAnTdcgQHSJhhKyN7uiCUIrzw+JE0IgYiGdjKd0Yz4NA1a
         U/C4hedUTGjM9s3sAH18xOT5gkrkbjdKtR4/AduViHttzxlRydFB8aXBByOnEZd7vSR1
         zqVw58PxnQPxxIKb1Czug25OaOo9JzFkD90j50S64tyk/S4k5CShMRVKbiT+dhZZ4GBf
         l99A==
X-Gm-Message-State: ABy/qLZ922syWHegNpGXJ9X5/VAL0EWMqHyqHpfNa4Mp2RBX3j7QYBMa
	jBtVfIl8HMv7xQ3MfFzauHLl//7iMFc1gOIeOKrC5w==
X-Google-Smtp-Source: APBJJlEWUoeuf5dGWkDvdxMoAKsG/Z2DJAjtQ1HCUphj+qd1f83rh/PkeY7QfHENnfGc0LkAkETEIg==
X-Received: by 2002:a05:600c:3105:b0:3fa:9996:8e03 with SMTP id g5-20020a05600c310500b003fa99968e03mr14988wmo.10.1689262132820;
        Thu, 13 Jul 2023 08:28:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fbb5142c4bsm18563121wmi.18.2023.07.13.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:28:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Marek Vasut <marex@denx.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: net: davicom,dm9000: convert to DT schema
Date: Thu, 13 Jul 2023 17:28:45 +0200
Message-Id: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Memory controller bindings have to be updated before we can convert
davicom,dm9000 to DT schema.

Please take it via net-next.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  dt-bindings: memory-controllers: ingenic,nemc: reference peripheral
    properties
  dt-bindings: memory-controllers: reference TI GPMC peripheral
    properties
  dt-bindings: net: davicom,dm9000: convert to DT schema

 .../memory-controllers/ingenic,nemc.yaml      |  1 +
 .../mc-peripheral-props.yaml                  |  2 +
 .../bindings/net/davicom,dm9000.yaml          | 59 +++++++++++++++++++
 .../bindings/net/davicom-dm9000.txt           | 27 ---------
 4 files changed, 62 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/davicom,dm9000.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/davicom-dm9000.txt

-- 
2.34.1


