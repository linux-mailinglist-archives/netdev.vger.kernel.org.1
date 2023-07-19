Return-Path: <netdev+bounces-19174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFFC759E18
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E1228141F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028151BB5F;
	Wed, 19 Jul 2023 19:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23D22EF9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:04 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D21BF6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 81EBDD9012;
	Wed, 19 Jul 2023 20:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792739; bh=7r308Q9IhlwCo2Kp5D5H7tVBkIVqd0aDcSW2DsNKu1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cp99belabw7wLFFg8GYofD/ZCRtmH53YC2NAAHcD6JtrpP6jl5O/RUvciDAqrf2uO
	 yLlP+o+ESQosaBlQvNYVRoqjEspuFqE7eHCYYPn0vRkhSJkudCzWlcwJLy3DpKxGxh
	 99KNbNrxGrPievWu/4N0c4/BjGiHtVtDpLtquF8XHjraRxENURiLUUECf0nKR0i8pr
	 AY3hcbU4KOq56c3OVftLKClijgVr0STYWYiL/oLR/v2qtfhzYzp/wDB8744mEcddWA
	 HrmmrW4UhIhsR9lU+/cHBvTBwnnEnfFPSobNmktSk/iYrmv+Bo5sHkZ7SIqamRAQ9C
	 3yfd06QXvj3xw==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 13/22] lib/rt_names: Read rt_tables from /etc and /usr
Date: Wed, 19 Jul 2023 20:50:57 +0200
Message-Id: <20230719185106.17614-14-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719185106.17614-1-gioele@svario.it>
References: <20230719185106.17614-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Gioele Barabucci <gioele@svario.it>
---
 lib/rt_names.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/rt_names.c b/lib/rt_names.c
index 5b911753..e0659250 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -452,14 +452,18 @@ static void rtnl_rttable_initialize(void)
 	struct dirent *de;
 	DIR *d;
 	int i;
+	int ret;
 
 	rtnl_rttable_init = 1;
 	for (i = 0; i < 256; i++) {
 		if (rtnl_rttable_hash[i])
 			rtnl_rttable_hash[i]->id = i;
 	}
-	rtnl_hash_initialize(CONF_ETC_DIR "/rt_tables",
-			     rtnl_rttable_hash, 256);
+	ret = rtnl_hash_initialize(CONF_ETC_DIR "/rt_tables",
+	                           rtnl_rttable_hash, 256);
+	if (ret == -ENOENT)
+		rtnl_hash_initialize(CONF_USR_DIR "/rt_tables",
+		                     rtnl_rttable_hash, 256);
 
 	d = opendir(CONF_ETC_DIR "/rt_tables.d");
 	if (!d)
-- 
2.39.2


