Return-Path: <netdev+bounces-15737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466F749733
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 10:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55F71C20CFF
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25961C32;
	Thu,  6 Jul 2023 08:16:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEED71872
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 08:16:07 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955C21BE2
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 01:16:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9922d6f003cso50516166b.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1688631365; x=1691223365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K74+bMhHCvWhymjIs0u9DKIZz/UhylbMWE8utWtKfGo=;
        b=eVeIz8XEevGCBQiKJbnkroU2JVeqRd/LnF3UPy9nCay/6KpcKdsPWaPYHxvOhII/Eq
         48HFXlnakNKq9keJTen76es9MF8iCNF2McZbAJuJZErshUwEHvB6CLDmbm9VkSm1eRQc
         6DpnAfgx+xvTnO7BmWEtyjONvjeOdctuc8+TiCqknCcN7IfdakMfsVthQSi60THpdGj4
         Xz9KPDeKyR8mW3aAokMK+znF1fz7o2oXrRzkjHB9bBCX0OETu5IuWXFsU8MfMzf9fK/p
         +F6bTv5L/5aJdoCj3qoWT6zy9nEYX5N5yVmNUTj42+RfP3jBum1xheRjHjb30jkt3obf
         d+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631365; x=1691223365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K74+bMhHCvWhymjIs0u9DKIZz/UhylbMWE8utWtKfGo=;
        b=fVlREzeL9tEQ2N4xzbpmYt1M3AmOTWsIdpGOAgwhgvj+/2SKNffXOFMG4N/RybayXd
         r8MM6+mWQvBSL50sx+a28ykp0vJAI+ZoUSuYjzz5+wQmIHZ2pavkwEpRCkCdeOIM0p6G
         wHrQVeT0uu9L31858BcdLDQxN+cctIwJtDBeBulYdKenbQL+PiUfX1Y+Ey2lGActdBl8
         UKUUYNm6IWh0MPnKE99cTBOASgljB5RuLlefOV2sEZSSCsfp6Bp64SpktHxI+G1nVnV6
         Ua3GBo69f2PdFvDFlUEyG46nVFRppoKThSUwsqKM4O90MysglZRni/B7VH2NZsDCHxJF
         ostQ==
X-Gm-Message-State: ABy/qLbCS4+HfxozlAP2u7i5Z6+g51n5A1mAtFINacGn9vI9+immEW9t
	jSTHTI5wy2s0xHNMTBJjRwLXsY9y2EYlGkn/2al6QA==
X-Google-Smtp-Source: APBJJlGjgUEPmlKSXTAEJ2NVftvifEbaWoT+wyc9GTLi2HTneNUbqf8qB4UdzUVmEnNbTa44PQmYLw==
X-Received: by 2002:a17:906:b846:b0:992:7295:61c9 with SMTP id ga6-20020a170906b84600b00992729561c9mr810149ejb.69.1688631364600;
        Thu, 06 Jul 2023 01:16:04 -0700 (PDT)
Received: from localhost.localdomain ([82.79.69.144])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090607c800b0099364d9f0e9sm478096ejc.102.2023.07.06.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:16:04 -0700 (PDT)
From: Alexandru Ardelean <alex@shruggie.ro>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	olteanv@gmail.com,
	alex@shruggie.ro,
	marius.muresan@mxt.ro
Subject: [PATCH 2/2] dt-bindings: net: phy: vsc8531: document 'vsc8531,clkout-freq-mhz' property
Date: Thu,  6 Jul 2023 11:15:54 +0300
Message-Id: <20230706081554.1616839-2-alex@shruggie.ro>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706081554.1616839-1-alex@shruggie.ro>
References: <20230706081554.1616839-1-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For VSC8351 and similar PHYs, a new property was added to generate a clock
signal on the CLKOUT pin.
This change documents the change in the device-tree bindings doc.

Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---
 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 0a3647fe331b..133bdd644618 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -31,6 +31,10 @@ Optional properties:
 			  VSC8531_LINK_100_ACTIVITY (2),
 			  VSC8531_LINK_ACTIVITY (0) and
 			  VSC8531_DUPLEX_COLLISION (8).
+- vsc8531,clkout-freq-mhz : For VSC8531 and similar PHYs, this will output
+			  a clock signal on the CLKOUT pin of the chip.
+			  The supported values are 25, 50 & 125 Mhz.
+			  Default value is no clock signal on the CLKOUT pin.
 - load-save-gpios	: GPIO used for the load/save operation of the PTP
 			  hardware clock (PHC).
 
@@ -69,5 +73,6 @@ Example:
                 vsc8531,edge-slowdown	= <7>;
                 vsc8531,led-0-mode	= <VSC8531_LINK_1000_ACTIVITY>;
                 vsc8531,led-1-mode	= <VSC8531_LINK_100_ACTIVITY>;
+                vsc8531,clkout-freq-mhz	= <50>;
 		load-save-gpios		= <&gpio 10 GPIO_ACTIVE_HIGH>;
         };
-- 
2.40.1


