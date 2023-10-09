Return-Path: <netdev+bounces-39101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2EE7BE040
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE741C20CB2
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B231339B5;
	Mon,  9 Oct 2023 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxJZQwAr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43A328DB
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:38:19 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FBBD6;
	Mon,  9 Oct 2023 06:38:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3231dff4343so2704816f8f.0;
        Mon, 09 Oct 2023 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696858695; x=1697463495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6V3Yp/K15xx7ev3Qhf5+/0w5en07kzL7Wskfo0+HBPw=;
        b=UxJZQwArtVkHQzamLIPvEe663j4D0jo6HtE9vQh/LrnJzFcFYtU25Nzxnob6pOk3Gk
         4egl3DLrDqiQSyDw2NUjwXey9kUzWurxQw4ks+PKbEAToL0sIcOsylh5xkN+24s+zAjd
         2WQ5ORcBJSIWOSRKFrbOtkBqewXNcU783ZmgaKvjyXkGntmn8Gy/iQaYLG/UnKOg2ZuO
         hoyVDMvD0afeA3o42fgIwwyCfsvzCCGuLoOzTjChqU/RQUm4D5icsDl1wCbDjiyyk6In
         6ZYSHcU/wZxYs79vcaBF0tVZsFXKrq76LsyAm8WwW8ho4fVZBJmvet6INXHv+ABtasnu
         7OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696858695; x=1697463495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V3Yp/K15xx7ev3Qhf5+/0w5en07kzL7Wskfo0+HBPw=;
        b=nWrMomLpGlV5saC422/KqrGKZ+7bNYEoq+ZwpjK+2Wlwo8VGXqGYnrmjYzSEt/w7eY
         5JELrUKwk2ozHDvZY0XUPijUpzGGVE2jCLUrsiu6ZfNWb7XYXrS+rP6OrTys9yXshSXO
         SubQt99LTd2zigiBQ+j3Ebn43pkcT74RU7oU47b0Z+PwyhBV3s4ShuN6aUtuLH0hWP1/
         6D2ZAR7riDF07ucXw1ISU09l3v2tomblcZTIhsVbKKUCuPVhVcwqtVSI07zkWhxflU7N
         ow1hEmm05qB10SJk3Uge+xUCEk7kr7I9geE1x/Uhle03lCEDKEvCD9JPTNwA8KrGuDVk
         KHCA==
X-Gm-Message-State: AOJu0YzThK7Scl28FPBO/nFbmnovPL82Fp+3hMPvYCRFWZCtRaQ1Lpqx
	vi+HKgGfWjhcBgT1HaZbAIg=
X-Google-Smtp-Source: AGHT+IEg5HTR+xDE3IzwD0pbfXpmjGlWQO4VcUmgAYjzp1NHs11O05PimyYF9rp+Ru7+he92h2hBgA==
X-Received: by 2002:a05:6000:1112:b0:317:6734:c2ae with SMTP id z18-20020a056000111200b003176734c2aemr9423512wrw.11.1696858695077;
        Mon, 09 Oct 2023 06:38:15 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id t4-20020a0560001a4400b0032763287473sm9746160wry.75.2023.10.09.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 06:38:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chris Snook <chris.snook@gmail.com>,
	Raju Rangoju <rajur@chelsio.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Douglas Miller <dougmill@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Dany Madden <danymadden@us.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Intel Corporation <linuxwwan@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Alex Elder <elder@linaro.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bailey Forrest <bcf@google.com>,
	Junfeng Guo <junfeng.guo@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ziwei Xiao <ziweixiao@google.com>,
	Rushil Gupta <rushilg@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Yuri Karpov <YKarpov@ispras.ru>,
	Andrew Lunn <andrew@lunn.ch>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	Dawei Li <set_pte_at@outlook.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [net-next v3 5/5] netdev: use napi_schedule bool instead of napi_schedule_prep/__napi_schedule
Date: Mon,  9 Oct 2023 15:37:54 +0200
Message-Id: <20231009133754.9834-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009133754.9834-1-ansuelsmth@gmail.com>
References: <20231009133754.9834-1-ansuelsmth@gmail.com>
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

Replace if condition of napi_schedule_prep/__napi_schedule and use bool
from napi_schedule directly where possible.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Drop toshiba change and rework in separate patch
---
 drivers/net/ethernet/atheros/atlx/atl1.c     | 4 +---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 02aa6fd8ebc2..a9014d7932db 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -2446,7 +2446,7 @@ static int atl1_rings_clean(struct napi_struct *napi, int budget)
 
 static inline int atl1_sched_rings_clean(struct atl1_adapter* adapter)
 {
-	if (!napi_schedule_prep(&adapter->napi))
+	if (!napi_schedule(&adapter->napi))
 		/* It is possible in case even the RX/TX ints are disabled via IMR
 		 * register the ISR bits are set anyway (but do not produce IRQ).
 		 * To handle such situation the napi functions used to check is
@@ -2454,8 +2454,6 @@ static inline int atl1_sched_rings_clean(struct atl1_adapter* adapter)
 		 */
 		return 0;
 
-	__napi_schedule(&adapter->napi);
-
 	/*
 	 * Disable RX/TX ints via IMR register if it is
 	 * allowed. NAPI handler must reenable them in same
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 23b5a0adcbd6..146bc7bd14fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1660,9 +1660,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 	IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
 
 	local_bh_disable();
-	if (napi_schedule_prep(&rxq->napi))
-		__napi_schedule(&rxq->napi);
-	else
+	if (!napi_schedule(&rxq->napi))
 		iwl_pcie_clear_irq(trans, entry->entry);
 	local_bh_enable();
 
-- 
2.40.1


