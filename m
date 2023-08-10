Return-Path: <netdev+bounces-26277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2CF777617
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5863F281F97
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812A1EA94;
	Thu, 10 Aug 2023 10:39:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5F1E52A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:39:34 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351932D78
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so159341666b.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691663968; x=1692268768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ9MOKpVeig316su6xi1KnGB5hanzaH9oU2jA9id/34=;
        b=uQGbz65ij55MLDc2dLHsp6jUPyqPbIZtaosibRnlQmAfQnaP+7/6FNScNMWwQNAsAm
         RhKorlMSJJ1/+82nKt4ONcCT8SjpLPVpNu0nsMUSqwQAEF5wpDtQqv+c3LE45yeX1pdA
         HlJPKyIuMcGFiPAMuj13IX21xOpf4QSbO6Oop20Yk1ZbVBseuEKwWQ5nCtFyi6iv4YXV
         oNYUgO1VPo2bKkmw/uH76fO4cG0kuAWdl+1FkW61427k1kTLM9ZpuMaamJYOjYftZ+3n
         pvEgWZH0aSduZQCPV8FMObftKWMQ9tD2iwiIgGWEl2ObU58LrGGY9vz+XTCt2ZEqXrJi
         6IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663968; x=1692268768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJ9MOKpVeig316su6xi1KnGB5hanzaH9oU2jA9id/34=;
        b=LepIkKBz8uQeOLB59QO3LIEoOZ4dahZz6lIjp7tqPVCWVOUXyAAF8UgeYmTi8jH8xg
         7HlAMzL0QY+3iX1DdBay8DCp6imKlVmomXtcApELv/8aGk+mQLkRjQjCz15EPQJYVL9q
         oXMQNHK5oH/oXLjYMBztMDfceGqDPZET5u6wRZEJ6JOWFrv30L2PvrWPUBembvYIGAAe
         A7PmqNgRzVw/KA03944iZJ8dPXmCZy6jGmjKXNPSkJR43QXvZ1Xp2ASaVrbIHcy957JC
         rVCFJpefbMjx/gfULslYztHk5GBP0MeXDHrFwReJIeVjprKYFR2/llDP9avhMhCZ13SU
         MpVw==
X-Gm-Message-State: AOJu0Yww34jtGRoO88yCDg2wDXZFAp0idPZZmDudEd8VomCUIDNc8QIo
	y28V5NbVN5JMIYFYiBTsleoMbA==
X-Google-Smtp-Source: AGHT+IEK8P3dqAX5gIvsT8nsM2TfsbTvTxWqFzlAZ0erTN8BR+5qocrc6+mwqlnlgS+pS7P2w1dhFg==
X-Received: by 2002:a17:906:53:b0:99b:4d3d:c9b7 with SMTP id 19-20020a170906005300b0099b4d3dc9b7mr2246114ejg.31.1691663967813;
        Thu, 10 Aug 2023 03:39:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id mc5-20020a170906eb4500b00999bb1e01dfsm749244ejb.52.2023.08.10.03.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:39:27 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] net/xgene: fix Wvoid-pointer-to-enum-cast warning
Date: Thu, 10 Aug 2023 12:39:22 +0200
Message-Id: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

'enet_id' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  xgene_enet_main.c:2044:20: error: cast to smaller integer type 'enum xgene_enet_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 41d96f4b23d8..4d4140b7c450 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -2041,7 +2041,7 @@ static int xgene_enet_probe(struct platform_device *pdev)
 
 	of_id = of_match_device(xgene_enet_of_match, &pdev->dev);
 	if (of_id) {
-		pdata->enet_id = (enum xgene_enet_id)of_id->data;
+		pdata->enet_id = (uintptr_t)of_id->data;
 	}
 #ifdef CONFIG_ACPI
 	else {
-- 
2.34.1


