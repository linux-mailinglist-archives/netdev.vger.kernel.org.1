Return-Path: <netdev+bounces-88954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604EF8A9118
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 04:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE6281A8B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582543AAD;
	Thu, 18 Apr 2024 02:15:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8E1E48B
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406518; cv=none; b=CK81I0VaqDSJ90iAziOovdqqT8GjaRU9jfYTDhNq+gUrbg3lsgJzXuDLloQ8/ny5KYZSbvPN2IRcFrp49q/kT1sLojn1y6n4UkERkHX5zF0uVTrZ2Q+dQC+vfQtyzLbILlz8fe14N8bqiry1j8hkd7Bqf6d9tSrlnM3YgiUZxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406518; c=relaxed/simple;
	bh=nQGaTgne08UB4A3MuvcthkXe73qxgMUWSt65bYHXXIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BKgFUxsYl5GBG2epxfOeAYBkXpaz1+LMiTHzE+GzcQjNgQB2CCvf47FkEG2j03dzshHCFajN2y+eu0gRNZPOBZw/5xonipzDj+mqN51kFvxsT3JX3qTWBdOkDvm5o/Sg3hgAeKo/bfZfeLEN6q6q8SuuZzO8Uriz1A3rpJeT2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp77t1713406462tk680p8c
X-QQ-Originating-IP: sMEdC+r13IlwmqvlkmYAA0rTsHQtrEvgzRs2eUe8yUE=
Received: from localhost.trustnetic.com ( [183.128.134.212])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 10:14:20 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: /rrU+puPB7RK8TraKQlYaqVK6FAhx+ZdvM1zSgH2/40G7q0DCc092O1SAplMY
	gpk8C7c8LuxIeQiLvf6z0puWuHEw1ZAqONm9XEeAfDRH04QzGV5992dBRSAJNOEWj92//qA
	VGmmhDOHVktANgFFWEOcZlcKUi14rr0fdIVLQcuKi/jKkvvI04rNk8WmZG21avNhlj4UDqo
	BNidGTs5/OI4vDReJO9wxxozrFayNKLjKjYwneUGJnc6cDJWWuGCCvp5FzW+bjzk0cYfrLO
	eMj7Pwo2nA4OOO5S3eOrWJpk6cZHjn+zCP8/Ea9tbJ58SHl1jw3m7vlFHwpyaziyPngUIhs
	HlAIdx9GbdJnyoBRfWh0HNXKOWmoQcKWtizUUkiNpif1pHQUgsMT3wISQ2jtSFJlJuygMQw
	Kn+QH4Prq5I=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4703493909156155388
From: Duanqiang Wen <duanqiangwen@net-swift.com>
To: netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linyunsheng@huawei.com
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH net] net: libwx: fix alloc msix vectors failed
Date: Thu, 18 Apr 2024 10:15:56 +0800
Message-Id: <20240418021557.5166-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

driver needs queue msix vectors and one misc irq vector,
but only queue vectors need irq affinity.
when num_online_cpus is less than chip max msix vectors,
driver will acquire (num_online_cpus + 1) vecotrs, and
call pci_alloc_irq_vectors_affinity functions with affinity
params without setting pre_vectors or post_vectors, it will
cause return error code -ENOSPC.
Misc irq vector is vector 0, driver need to set affinity params
.pre_vectors = 1.

Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 6dff2c85682d..6fae161cbcb8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1598,7 +1598,7 @@ static void wx_set_num_queues(struct wx *wx)
  */
 static int wx_acquire_msix_vectors(struct wx *wx)
 {
-	struct irq_affinity affd = {0, };
+	struct irq_affinity affd = { .pre_vectors = 1 };
 	int nvecs, i;
 
 	/* We start by asking for one vector per queue pair */
-- 
2.27.0


