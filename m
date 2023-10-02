Return-Path: <netdev+bounces-37444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2987B560E
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A816A28170E
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1341A73D;
	Mon,  2 Oct 2023 15:10:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4391A725
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:10:41 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A940A7;
	Mon,  2 Oct 2023 08:10:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-406618d080eso26521515e9.2;
        Mon, 02 Oct 2023 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696259439; x=1696864239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xSoAm+ROAl+uYnsbqkuF+kzUuWhCjT5vlITwi8Kq2Y=;
        b=kNR0g4QJUOJs9DdgowWrYi5D30ubULRr5RIvFpSxPPR4Z/+MGRwbl6RL/7JGZU7E6V
         Rt7uPvir+SBn+kb3T+/rnKKO8gDmH3vCb5E2LEr71KIoF361mdQTTLtVLgXInj+Y27DG
         Bk6rj6FIbUn2j8csWvR2yofOW5qbKd+VdOuGqAfHhDOmMofZISWsduN120qjGbiDLmMf
         6kIUoZhXelWUFYfllcpYwhJyvbvMexe0cESFQaR/xeXK6o+A100U/tYHaXMAOHuZIDV7
         OZe0U6ErRLSTSSyuPM8niYKxLuB7IBfgadHSXDwE66F5uKjmoxJEENBGUXli7smnH8nZ
         myTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259439; x=1696864239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xSoAm+ROAl+uYnsbqkuF+kzUuWhCjT5vlITwi8Kq2Y=;
        b=BSU1vGW3jnd6HWjbSI/nlGfrIhFa68xsVklSw4s66AyulSYscXwDJ1uSJnS9L02zb4
         GB2cjjer1XnngZM0sQ9/Dx7n21upMrk1kv2+NF4U1NArg650xUz8NDCttrdv76fMob6G
         lkXWo0HeSJRQyvMrMd7LfoffjntqOw/u2YU2YFoxLT9rTFVW/Z1wCjBQMx50laXfRadY
         oIbGPgAw9RRUM+5mtezBzK8DTdReNvUvnVbbdQqv6jbNS4aAUiGkCpUcWo9Ipct8jQJJ
         EXoE1AmsRO3OqCe61K1fXcBgsT79zLVaEVZLzItQbvP06S4gMpt+fIZDIPHDmxpo6ZpZ
         dfuA==
X-Gm-Message-State: AOJu0YzuAEC6z9Fe5d0TMtCT+0FGizRFzckRwGRPOTmTn76wg8hVo2sy
	IIBfAViWyO/150CU4/CPA/I=
X-Google-Smtp-Source: AGHT+IEEZGlFjpx8lLo9tvllSBQ9uSdgJbt7Jo8+TnnbkK3MrDUsxRAVP26IXHgFIeF3CU+ec1ay4w==
X-Received: by 2002:a05:600c:5007:b0:405:315f:e676 with SMTP id n7-20020a05600c500700b00405315fe676mr10563085wmr.3.1696259438602;
        Mon, 02 Oct 2023 08:10:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id t15-20020a1c770f000000b00406408dc788sm7421565wmi.44.2023.10.02.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:10:37 -0700 (PDT)
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
	Wei Fang <wei.fang@nxp.com>,
	Alex Elder <elder@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bailey Forrest <bcf@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Junfeng Guo <junfeng.guo@intel.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rushil Gupta <rushilg@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Yuri Karpov <YKarpov@ispras.ru>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Zheng Zengkai <zhengzengkai@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lee Jones <lee@kernel.org>,
	Dawei Li <set_pte_at@outlook.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [net-next PATCH 2/4] netdev: make napi_schedule return bool on NAPI successful schedule
Date: Mon,  2 Oct 2023 17:10:21 +0200
Message-Id: <20231002151023.4054-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231002151023.4054-1-ansuelsmth@gmail.com>
References: <20231002151023.4054-1-ansuelsmth@gmail.com>
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

Change napi_schedule to return a bool on NAPI successful schedule. This
might be useful for some driver to do additional step after a NAPI ahs
been scheduled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/netdevice.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7e520c14eb8c..2bead8e2a14d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -490,11 +490,18 @@ bool napi_schedule_prep(struct napi_struct *n);
  *
  * Schedule NAPI poll routine to be called if it is not already
  * running.
+ * Return true if we schedule a NAPI or false if not.
+ * Refer to napi_schedule_prep() for additional reason on why
+ * a NAPI might not be scheduled.
  */
-static inline void napi_schedule(struct napi_struct *n)
+static inline bool napi_schedule(struct napi_struct *n)
 {
-	if (napi_schedule_prep(n))
+	if (napi_schedule_prep(n)) {
 		__napi_schedule(n);
+		return true;
+	}
+
+	return false;
 }
 
 /**
-- 
2.40.1


