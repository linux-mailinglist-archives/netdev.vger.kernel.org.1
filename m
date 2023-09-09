Return-Path: <netdev+bounces-32708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362D07997EF
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 14:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676B81C202C9
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E313D62;
	Sat,  9 Sep 2023 12:31:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D06ABD
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 12:31:23 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F97CD6;
	Sat,  9 Sep 2023 05:31:21 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso884832fac.0;
        Sat, 09 Sep 2023 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694262679; x=1694867479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgMmkabWLP66Z1pj5QNqLjt25rskW5WM/Dly1iTxQPY=;
        b=PUFXNQj92RmyhL0CJKJr6dOSEIJr9mkeXwSMiw7IHLhL9O80WG9ZD9tKnguX5nV9MO
         GJnLUYTPoBbpT2WuiCrIJyTD1VchoPSLjdcrvQynPpPPnSX9XohiV2xVz5DjK9RORtlP
         /w0GFFF/UaE08wmObQPi6QP9z91rIiTUt456W+H0SbV9owiK4PR0FYECyJkw+fN9h2SJ
         glQqxGWth04MIiLP+Dnv5xGLAAn52wUox2aPYYchpy7e5XeERwlQRbL+mAPtlX/0saMB
         LswIiI4/39+QMSnQIuU9Xk7jK3aBL0kYtzKpJHdNkdofdPkM3MhL4ZKTYc0ssvAyEeli
         cFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694262679; x=1694867479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgMmkabWLP66Z1pj5QNqLjt25rskW5WM/Dly1iTxQPY=;
        b=EdGpt+W0dfUy6vnt/OH8I3lZwjog+2QcCsNA+b7pj0xzV8pKsA2BjdLsGJo7F+32o2
         nIUWOrRQE0iH38ibaDGk7A8234mzVpBOJy6O05PWG595yAeGkmeO8rrRG9ILkztFBCWo
         7/hiHU81tkV6+G4RLHQMXv//uTn+E+z++gbbi0aALRxufHlxPfwe+Y9ZK4yNPyAzPxOF
         GfRvwdiOoa8sNDSUsCEDMGya+JTih65DvpD4jZDuHkSixwb8d6gUlido0xuus5IiNrHB
         CjMDMrbihJTFVum6vDApwE3yVdiAs9awnRZjnTQVf7buPFfGZ1qrZZju/7uPNFP25Dnt
         Efxw==
X-Gm-Message-State: AOJu0YxnKMRjeJfqeWH1GbaiwAN+13kJXfWRNAiFP8N73+axSZHdRQCs
	UeXW9r28D+i+T85PGV85J3o=
X-Google-Smtp-Source: AGHT+IH+MVpZMgPdoJedG5n6hPfgW5SQIfrJ9UXerZuOi9nyCkvyqy7LBrTm/5k5GMX96n/86q7pFA==
X-Received: by 2002:a4a:b382:0:b0:573:4a72:6ec with SMTP id p2-20020a4ab382000000b005734a7206ecmr4941817ooo.1.1694262679365;
        Sat, 09 Sep 2023 05:31:19 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3785:ad26:cd88:709])
        by smtp.gmail.com with ESMTPSA id f83-20020a4a5856000000b00573320e1241sm1688320oob.14.2023.09.09.05.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 05:31:18 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Cc: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	kuba@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] arm64: dts: imx8dxl-ss-conn: Complete the FEC compatibles
Date: Sat,  9 Sep 2023 09:31:07 -0300
Message-Id: <20230909123107.1048998-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230909123107.1048998-1-festevam@gmail.com>
References: <20230909123107.1048998-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Fabio Estevam <festevam@denx.de>

Use the full compatible list for the imx8dl FEC as per fsl,fec.yaml. 

This fixes the following schema warning:

imx8dxl-evk.dtb: ethernet@5b040000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx8qm-fec'] is too short
	'fsl,imx8qm-fec' is not one of ['fsl,imx25-fec', 'fsl,imx27-fec', 'fsl,imx28-fec', 'fsl,imx6q-fec', 'fsl,mvf600-fec', 'fsl,s32v234-fec']
	'fsl,imx8qm-fec' is not one of ['fsl,imx53-fec', 'fsl,imx6sl-fec']
	'fsl,imx8qm-fec' is not one of ['fsl,imx35-fec', 'fsl,imx51-fec']
	'fsl,imx8qm-fec' is not one of ['fsl,imx6ul-fec', 'fsl,imx6sx-fec']
	'fsl,imx8qm-fec' is not one of ['fsl,imx7d-fec']
	'fsl,imx8mq-fec' was expected
	'fsl,imx8qm-fec' is not one of ['fsl,imx8mm-fec', 'fsl,imx8mn-fec', 'fsl,imx8mp-fec', 'fsl,imx93-fec']
	'fsl,imx8qm-fec' is not one of ['fsl,imx8dxl-fec', 'fsl,imx8qxp-fec']
	'fsl,imx8qm-fec' is not one of ['fsl,imx8ulp-fec']
	from schema $id: http://devicetree.org/schemas/net/fsl,fec.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index b47752a878c9..a414df645351 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -118,7 +118,7 @@ &enet0_lpcg {
 };
 
 &fec1 {
-	compatible = "fsl,imx8qm-fec";
+	compatible = "fsl,imx8dxl-fec", "fsl,imx8qm-fec", "fsl,imx6sx-fec";
 	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1


