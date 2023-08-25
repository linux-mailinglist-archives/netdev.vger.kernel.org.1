Return-Path: <netdev+bounces-30764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0FD788F4D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6748528181A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89018C05;
	Fri, 25 Aug 2023 19:44:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324142915
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 19:44:06 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC32686
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:44:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c93638322so275164066b.1
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692992643; x=1693597443;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Am9Fn9Xc6XmJXmpgl7eKfnnEYdKcAs2gEM2YOD3kBo=;
        b=C3YbvkhKsKN6pGDCeSWr2C1YqDsRL3LDDDgEuhtwe7gd92Zo21HRuUD9xU1xdX/u9Z
         +oLwD4pv/Zua+CnUCX2sK0JyDWw2FO/je/v922TiH+8tcLS3DvbbvOpYXowpw1Ok5jlN
         9PpiPVvpghw0Iobl7oCbgwgpeB1T28cnREYF0Y/mr8/0UIA3t98nLcd+MSlK6b0iACEW
         jAfDtGj4zlrAq/hteWJ5Sb25X9L7wYPYc5auE1bObYpbU6mJkmoaeomjYaW1kBYzlfS7
         wPO/DteODAlhkxLTRM3B34+AjLIwMQgvnQmqq7QRLYnQJosreDgku76ivCDWomgrem4U
         XwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692992643; x=1693597443;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Am9Fn9Xc6XmJXmpgl7eKfnnEYdKcAs2gEM2YOD3kBo=;
        b=ZLJKV3qlBbLlo3codVYLeRkURdSPoBOYiTKzYDQezgPaIIcfy8ScywENmHZnvGP911
         IuXCRbeGzs085JbMpcV7LvBK6/CJRdeu0nbsNDihLhKeI+m7typg6zOomignkMh25tfY
         tVlNDQcuBhN7gHIscJpUGxWFFiIVA9Xanpdg6VIoroGzUbUuehRYrCYkYUHanH7edBVi
         QTLPbMOPrwKOyqfBrHBbuOKUT3ExqiXEuBQ+cogwtGHIJBjcIJOq5+1DWx5SIOpsqr0s
         cH8DkelP/rGfUdYIvJc3TaLoCbMt8TtQRo3I6WEXawSBT5SpTs6efSMqni9C5vD7KASf
         0w2g==
X-Gm-Message-State: AOJu0YxeiymnFuWKNOmRfjmAMWIom0cawAKzTgkywJkXppwXYkHOODyT
	5JxD1cJ+D1tQ4iN9yZTHulk=
X-Google-Smtp-Source: AGHT+IEN6kP/12nVOGYT/JlQ2gSilxislIjkCAZFk7mBII+zb9suJ2mMp+f9fdEhd7XxeZTWNgm+bA==
X-Received: by 2002:a17:907:760c:b0:9a1:b85d:c952 with SMTP id jx12-20020a170907760c00b009a1b85dc952mr12114722ejc.12.1692992643050;
        Fri, 25 Aug 2023 12:44:03 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7278:9e00:3d6c:1d4d:484c:d423? (dynamic-2a01-0c22-7278-9e00-3d6c-1d4d-484c-d423.c22.pool.telefonica.de. [2a01:c22:7278:9e00:3d6c:1d4d:484c:d423])
        by smtp.googlemail.com with ESMTPSA id v15-20020a1709064e8f00b00991e2b5a27dsm1271765eju.37.2023.08.25.12.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 12:44:02 -0700 (PDT)
Message-ID: <d198a4d6-0c91-7870-9648-5a087fe634aa@gmail.com>
Date: Fri, 25 Aug 2023 21:44:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Subject: [PATCH net] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
causes tx timeouts with RTL8168h, see referenced bug report.

Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5eb50b265..6351a2dc1 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5239,13 +5239,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Disable ASPM L1 as that cause random device stop working
 	 * problems as well as full system hangs for some PCIe devices users.
-	 * Chips from RTL8168h partially have issues with L1.2, but seem
-	 * to work fine with L1 and L1.1.
 	 */
 	if (rtl_aspm_is_safe(tp))
 		rc = 0;
-	else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
-		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
 	else
 		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
 	tp->aspm_manageable = !rc;
-- 
2.42.0


