Return-Path: <netdev+bounces-20841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2E761877
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A90D28168B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446AA156EE;
	Tue, 25 Jul 2023 12:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A27D1426D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:37:18 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6D3199E
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:37:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so13531948a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690288635; x=1690893435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhZOTY2v8nNqCcShLqLA7mLbnG45oifLvhvNr+/6z/o=;
        b=WyKTRrgFJwUyfdp/c764JU7lMiUG7ykQmHfDjHirhMDJqFOBbsxFq6z3SCEIgb19ss
         YpFaUBqyiLzV4eTpcmNQEpKLQQ5rJUhGxTh/V1FSezErKgwzefb6XHVSy4pGGxA0e12E
         ZOMmDSHBVzfF7nYb2VeGsTx9UNebdwtn8ivJ7jqVcretOqzTeu8G0LuvvPd6W5H6wnAM
         +QMk+2pTqLcQhlO0oLdPinA53C7Kjo0fdeW0V9FmeRhFo9LsmH5EBpEC8FCAWXdoiirN
         a3iw/EI8jQx1h8qvMy91oVXEGeQmok4/yYivpEPKODZrLb4wq0UNJxz9ZloJhfoyzgup
         SuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690288635; x=1690893435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhZOTY2v8nNqCcShLqLA7mLbnG45oifLvhvNr+/6z/o=;
        b=ad431XwS8cXoFerO4xda4+sAZEDlSu3unwmHIOKjQNXDQXlsF9HLuTzpS0uqQbJwQO
         A0tgqYFeKuSi6f2ubOS9D5UgmvgYOpT026rOE1roNczM1lEMfp58TIZ6dx4G7O2ibEcL
         wbPXCTgHLqzRDrJO2wLQ89CvFbeJXe8oO81WtNuZu6wSfkl07l3lBjUWIluiY7HBgcxH
         ew/Ur2XeYuPSzAOGZWOq7pHivTwuyuEF+Il57LniSO+HKh8uIvyTRlezB26AN12R2Pq5
         E8/yGlyDwp0p4h9By4kNYUy3AQ2g6GNsvdhpenbelwofKmiqE4xmMQMQeoseN73bggmT
         rrEQ==
X-Gm-Message-State: ABy/qLbHki+5Q11TxkkKXmAAbBUsG63eTugW7jlM/GGVd0wXKl/GnTB4
	GDFkOEf5Z2RmqYQZN+8TcvfWEQ==
X-Google-Smtp-Source: APBJJlHY+74HHjey/C1hM74+8GGWFdnbCBbGLwWt0v2dOdMJV8ZhK+BaA46nQ+0c+9MOCfr3RN29Eg==
X-Received: by 2002:a17:907:2cc1:b0:993:f611:7c97 with SMTP id hg1-20020a1709072cc100b00993f6117c97mr2259221ejc.33.1690288634744;
        Tue, 25 Jul 2023 05:37:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id op10-20020a170906bcea00b00989027eb30asm8140654ejb.158.2023.07.25.05.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:37:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: qca,ar803x: add missing unevaluatedProperties for each regulator
Date: Tue, 25 Jul 2023 14:37:11 +0200
Message-Id: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Each regulator node, which references common regulator.yaml schema,
should disallow additional or unevaluated properties.  Otherwise
mistakes in properties will go unnoticed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/qca,ar803x.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qca,ar803x.yaml b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
index 161d28919316..3acd09f0da86 100644
--- a/Documentation/devicetree/bindings/net/qca,ar803x.yaml
+++ b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
@@ -75,6 +75,7 @@ properties:
     description:
       Initial data for the VDDIO regulator. Set this to 1.5V or 1.8V.
     $ref: /schemas/regulator/regulator.yaml
+    unevaluatedProperties: false
 
   vddh-regulator:
     type: object
@@ -82,6 +83,7 @@ properties:
       Dummy subnode to model the external connection of the PHY VDDH
       regulator to VDDIO.
     $ref: /schemas/regulator/regulator.yaml
+    unevaluatedProperties: false
 
 unevaluatedProperties: false
 
-- 
2.34.1


