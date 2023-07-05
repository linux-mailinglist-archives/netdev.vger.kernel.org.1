Return-Path: <netdev+bounces-15468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28794747C7E
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 07:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E5280F70
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 05:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C3FED2;
	Wed,  5 Jul 2023 05:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D4EA5
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 05:37:40 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9EF1B2;
	Tue,  4 Jul 2023 22:37:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc244d39dso84713255e9.3;
        Tue, 04 Jul 2023 22:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688535457; x=1691127457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+INOy7S615L241gEHhdJ0IOGxGXI6Ocw51fSeMvLPU=;
        b=Jok061kPq1gJXQlu8q+PGUHxn82e5V1QVedzSF4Pk0bS7UTBCxuQLpOs8W3OQv79EJ
         h2DB2DYMfMZxUAe5Uin16J+kQpp5GbH7lnk+QcLCjI+n7ATTsif8d4F0/ZxBgGFGhRrF
         mS3UIMpzNoUM+qnubdIPcqQoszosDQEPEe88bMmsyYuvE0s5FyZCUsePFi7Xmj8xO7yv
         cWbklR35TpyCZDEPUrvLawfkPQjPH9AX2+o4Ztrj1w0avyhyHwv7CzEK+zk/CkXQr5dC
         1H1rOnp08MAH2jDVh30ROHsl2gJYz9TN4hjPg7SBDLtdb5XFU5BRsBlOor0OgxbdZ323
         3Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688535457; x=1691127457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+INOy7S615L241gEHhdJ0IOGxGXI6Ocw51fSeMvLPU=;
        b=KBoCJnAJB+J9b/W20ucZQCFdMGutGv1IDuZGQYbIosGR8KIxmmOAN/LnOhlcEOYZhH
         yVE8VG9FiYMZPJj2jTm802vp2MA8eR+thjay50oDGZTl1oiyioAiem2NGkQ0oc4CaIk0
         wYywJ1kWzga9k+ZS653BmEbHY/fqF3XoTG85ZtxIF83XpwO4NdkPLKAvneQGIWHAtlH5
         CPn0zmfq9LC97/KcAGsK0vWAghrWMhPY7DgSJdXJmG1mhtt/TimHwYayUaBP9sJvFTzA
         nAUI57ZvKTnITK1BS3ck7qPAaVzW8Ib/r7h9LvrdzgoSMd4FedWAiNtHVIfa9bHJFn60
         rCcw==
X-Gm-Message-State: AC+VfDyyOkhabXCMT5aS8xY3NKHjfwLfFF29K6dMDV4yhX/gPQPvPH9x
	u5wb4NX6sSXM257xF4wcP0c=
X-Google-Smtp-Source: ACHHUZ7zFSpkWtN4P7zpbYSN2maRSzo4sdC8M3kuxP0VRJkfMFzlJLNrl5DvbylxIHF9GqT8375QSQ==
X-Received: by 2002:a05:600c:252:b0:3fb:b3aa:1c87 with SMTP id 18-20020a05600c025200b003fbb3aa1c87mr19891314wmj.40.1688535457128;
        Tue, 04 Jul 2023 22:37:37 -0700 (PDT)
Received: from mars.. ([2a02:168:6806:0:5558:4a0a:1c87:3931])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003f9bd9e3226sm1049369wmj.7.2023.07.04.22.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 22:37:36 -0700 (PDT)
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: mvneta: fix txq_map in case of txq_number==1
Date: Wed,  5 Jul 2023 07:37:12 +0200
Message-Id: <20230705053712.3914-1-klaus.kudielka@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If we boot with mvneta.txq_number=1, the txq_map is set incorrectly:
MVNETA_CPU_TXQ_ACCESS(1) refers to TX queue 1, but only TX queue 0 is
initialized. Fix this.

Fixes: 50bf8cb6fc9c ("net: mvneta: Configure XPS support")
Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 2cad76d0a50e..4401fad31fb9 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1505,7 +1505,7 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 			 */
 			if (txq_number == 1)
 				txq_map = (cpu == pp->rxq_def) ?
-					MVNETA_CPU_TXQ_ACCESS(1) : 0;
+					MVNETA_CPU_TXQ_ACCESS(0) : 0;
 
 		} else {
 			txq_map = MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
@@ -4295,7 +4295,7 @@ static void mvneta_percpu_elect(struct mvneta_port *pp)
 		 */
 		if (txq_number == 1)
 			txq_map = (cpu == elected_cpu) ?
-				MVNETA_CPU_TXQ_ACCESS(1) : 0;
+				MVNETA_CPU_TXQ_ACCESS(0) : 0;
 		else
 			txq_map = mvreg_read(pp, MVNETA_CPU_MAP(cpu)) &
 				MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
-- 
2.40.1


