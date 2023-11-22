Return-Path: <netdev+bounces-49848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEDE7F3ACA
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747D228101A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BEA1381;
	Wed, 22 Nov 2023 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="J8kBBzXN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2DD18E
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 16:42:22 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b83d2981b5so196258b6e.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 16:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700613742; x=1701218542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JAG0RDoM6r+OhcBNCljqVXixFJN9onE/iS8GXZuAZc=;
        b=J8kBBzXNLvaLzzItbZ6aiB87DxoMjhSXat/Mmm9YQExy3E3RcYeTGt+nkBO6NxqWfA
         VPNPDZYFNVP9FUqYg03bsV1XkDv0HTyhGQVcx9vX6LF0ONJkf/VOdMnD1McMurjfkEFx
         Ku8fYwMMW6mqIeMr8EzT04k2zKMOVhLxCmbp5aE92Vm3nuLSUU5GO8XTCxrhXNk0WWSX
         En2EFu79XuCuv/xfDk2kMTIyOZ2G6EMt0vZYBSn88rUcpe4dvZ7V1Up/MMxIDe62l1ZV
         CejkP9hYykrU+xNVFjW57jGM+cL2vC7AXdZT54rRJHH+N2Wx1teMhM4r/BtLBFKhyXBH
         XR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700613742; x=1701218542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JAG0RDoM6r+OhcBNCljqVXixFJN9onE/iS8GXZuAZc=;
        b=Oh0a4tZfhnRujsZbXgZcyCMBKt73pfdJv69GzC5TuuTYoDMg+I7edyGVPMSQyjET5F
         pgxObC/wSB/TC8tOsIJ86qDTAwm3wuH48ZOb4dkp/77QYBWBNoH/5AaAa081MzH+yaiH
         biG93ra6chWOPtrpe8Q2E/6vrPpdbaOs145HCNAFnLuyblFekOzcYk0jnwi9vgci5GTL
         ZYwSgw8cWUulzmc99SlVbQqa6qdMrC7TsEyzXx4lx3/EiPTqHgTUla8LqnIS4BA/FlGa
         h00lwgEcVV2SDQKT7Y0MdnLS7CeUGraPN2Uil1jBrQ0GGgoyDq9+lMVVoP4nrFE+HWd8
         u3qg==
X-Gm-Message-State: AOJu0YxENHvdujh6/z45tjeyJwCzMsujV9xlc0UPoTEh4zgH8x0UR3+U
	vuZlgtXnMjP+N0EcMFDMZ8NeZw==
X-Google-Smtp-Source: AGHT+IFtjceUKgV711uY05lmug8NPHDY9L8jlpd8D8wBrSUqKZ6rNZvgEDLVfLqCG+sn6SOl8BLolA==
X-Received: by 2002:a05:6808:1693:b0:3b8:3ba9:b14b with SMTP id bb19-20020a056808169300b003b83ba9b14bmr1311964oib.43.1700613741892;
        Tue, 21 Nov 2023 16:42:21 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z128-20020a636586000000b005b856fab5e9sm8382145pgb.18.2023.11.21.16.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 16:42:21 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net] net: axienet: Fix check for partial TX checksum
Date: Tue, 21 Nov 2023 16:42:17 -0800
Message-ID: <20231122004219.3504219-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a typo, the code checked the RX checksum feature in the TX path.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 82d0d44b2b02..bf6e33990490 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -822,7 +822,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
 			/* Tx Full Checksum Offload Enabled */
 			cur_p->app0 |= 2;
-		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
 			csum_start_off = skb_transport_offset(skb);
 			csum_index_off = csum_start_off + skb->csum_offset;
 			/* Tx Partial Checksum Offload Enabled */
-- 
2.42.0


