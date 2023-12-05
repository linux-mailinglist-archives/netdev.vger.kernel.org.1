Return-Path: <netdev+bounces-53867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC680504B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7EC1C20B34
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1B54BD2;
	Tue,  5 Dec 2023 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfNKg7Bs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA5109;
	Tue,  5 Dec 2023 02:36:07 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9e9c2989dso43959191fa.0;
        Tue, 05 Dec 2023 02:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772566; x=1702377366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU0vmmGkk5jZZzl83+7pZTLNraC38rsdaXbaqMF+jj8=;
        b=dfNKg7Bsak6WcwaRvWtTSAVu6DwAdr6SY+xe3ymi1KC6bV5jCKTa9iX1HuHaVaHp9e
         N/hoFj8SOJfxoUJ+UtTjy5E6HNaouC6ONf8EDxZEq8eUCqYFaKPD7VkSWOCa1qcqZ6SF
         FlNeuUJ8clFQapu87GOeup5DTY9AMsSSdPr/eQAnrO8y6hjdrsD5SIx8iCPjFqi3eDyK
         twSvn/yKC2mhLU1tg+HqtmWavHNyNpscJr2myKuyPUW8iFx/kU4s75KZ/xAddO5lKHx4
         gQNaauSZEP6pIEee9aYUJlS6I1eIzEfe9gFcD9mqSKe+KTWteWI5Pau90bU4sawl02VT
         qkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772566; x=1702377366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU0vmmGkk5jZZzl83+7pZTLNraC38rsdaXbaqMF+jj8=;
        b=e9sv8hDwx46U4bLxKc/JN2ojs63kAea2xGTRC5PlviKcU9LJQZ4zYfnb+d48Fyl2JW
         ExOSYdUfhGRmNXncjLrEdFIxQ4uBhtxyoKy0nWVffkzt1+L1+txtiWQM07+4nYeY+pne
         Fc750N1s3k5/3jor48vUhJeSApjJcS0VRFNjSNjR+8NLKIsRM+eN3UrxcnceEvoL11HX
         nYhrDQiqCFMWp1v37cStYvL6Sm7oUIiQLwkBgPSapvh5loxtm+S50To4lnL/mpKElrJ0
         3CX5E7XBrV/nBbAFkAnyvESYCp4jJgoC4YKT7aMG56U0IzkU/91nDnye7OtWkyEg7w1z
         ozTQ==
X-Gm-Message-State: AOJu0Yw6oWR9rLUMjTe8ltiByUgdA0ZkhYfFc1pQXEXbnBzb1yBOlI4v
	DxWiw/BY9x7GkDBLPp8e/wc=
X-Google-Smtp-Source: AGHT+IEyzagyInlkk1nPyBZ4FwyLEwY/Eu+fMNUrVKFjMERCNTvfyTC7suwpCzoymVY+rBHcqsbPYg==
X-Received: by 2002:a2e:9a94:0:b0:2ca:fa5:83ef with SMTP id p20-20020a2e9a94000000b002ca0fa583efmr844131lji.6.1701772565635;
        Tue, 05 Dec 2023 02:36:05 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u8-20020a2e9f08000000b002c9f1436d86sm1029551ljk.92.2023.12.05.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:05 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/16] net: pcs: xpcs: Drop redundant workqueue.h include directive
Date: Tue,  5 Dec 2023 13:35:23 +0300
Message-ID: <20231205103559.9605-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is nothing CM workqueue-related in the driver. So the respective
include directive can be dropped.

While at it add an empty line delimiter between the generic and local path
include directives.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index dc7c374da495..7f8c63922a4b 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -10,7 +10,7 @@
 #include <linux/pcs/pcs-xpcs.h>
 #include <linux/mdio.h>
 #include <linux/phylink.h>
-#include <linux/workqueue.h>
+
 #include "pcs-xpcs.h"
 
 #define phylink_pcs_to_xpcs(pl_pcs) \
-- 
2.42.1


