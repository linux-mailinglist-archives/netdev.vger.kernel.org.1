Return-Path: <netdev+bounces-36523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10687B0426
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DD8461C203D9
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A428DB3;
	Wed, 27 Sep 2023 12:29:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0543241FC;
	Wed, 27 Sep 2023 12:29:37 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609E193;
	Wed, 27 Sep 2023 05:29:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406402933edso24203735e9.2;
        Wed, 27 Sep 2023 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695817774; x=1696422574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqrlAO5sztrD1NimOBbmkaeWGCBRbknzZR3MhxUtqJk=;
        b=naup93iuZZIHBNrg7x06YTu29vDlozLnf14gcX4NkFnP6km2GgY81WxeMEtmhst4r4
         pXuXP5UsTUccFlTLz/3epMlW9SKXP711dtH7vsqqO4DE2HMfn40P5M8tSfLVfoTYjDtd
         Ra9cAQ3K3SITOUIk0S0ssbYv9Klv1NvLXP8tQq9RRUEX0QzPr0ZCVRIKigu3OJJqDcUR
         IrTbxI0Q6wEzatIL5UdCIo6GQiWUKeoGYIsjb7VmLQOmivsF2oR5aTspp5Uq2W+Aq3IO
         DfWMVnDTGHoNOc8uqjbhNlm5aRmz/FTM4J3z5Y3Z2YvCWbDCcuMWudGChxsLsD2i/zN9
         An5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695817774; x=1696422574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqrlAO5sztrD1NimOBbmkaeWGCBRbknzZR3MhxUtqJk=;
        b=hKJJDlEhKrkL1CRTAcLW2N/P8UBEoB9JHpo2DQeJS/gQxofnwyHjaGF9Pe071uyHw1
         NRX9WUVFy3D46ZZfp7z1Efw+G5Q6SXFVU9GXTux9bFyTao41jHGplag/ceVvfr2Me1g7
         oa20BYvfJuJeVoSYaC470OQaxkz0qbJyMquosi/C2gb5nA66yQDhuyujahyZjUbQNT/q
         Ew2JRSmXhk36jqS5sKobKKTqfWCRtAvi2zGFN94d6HPw4v9/Ju9iwe6GUrO9IZxEaYUj
         lg355CAvqDnndUXZCFJeMgxbKTXFur3LRN0Xsx9CyYWmPwkkHTO2qPAgUzUoMRD5mk+f
         ESig==
X-Gm-Message-State: AOJu0Yw2cpzrqIBF94V8mn2QEhAikQsmPQHx87MlUcTcGMyiq7I3L4fb
	nbRpYzUDbk+5UEOkTTkLMfI=
X-Google-Smtp-Source: AGHT+IF5xtLdTh5ebA3MvomjOgILvnz4IhFIHGw6vrUOiVXXmVjun0KXM08k7tob5hnd5+T2RFQvmA==
X-Received: by 2002:a5d:5348:0:b0:315:8a13:ef17 with SMTP id t8-20020a5d5348000000b003158a13ef17mr1430106wrv.65.1695817773679;
        Wed, 27 Sep 2023 05:29:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id 8-20020a05600c230800b004042dbb8925sm4521218wmo.38.2023.09.27.05.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:29:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 1/2] dt-bindings: net: snps,dwmac: DMA Arbitration scheme
Date: Wed, 27 Sep 2023 14:29:27 +0200
Message-Id: <20230927122928.22033-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Document new binding snps,arbit to program the DMA to use Arbitration
scheme. (Rx has priority over Tx)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..4499f221c29b 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -442,6 +442,12 @@ properties:
     description:
       Use Address-Aligned Beats
 
+  snps,arbit:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Program the DMA to use Arbitration scheme.
+      (Rx has priority over Tx)
+
   snps,fixed-burst:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.40.1


