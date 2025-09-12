Return-Path: <netdev+bounces-222498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE081B547F8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EF93B977E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3CE27A465;
	Fri, 12 Sep 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCmoRrsB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D44274668
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669626; cv=none; b=LdrUE+Q+fhF+xbJEnW4niSxO5qbSa/QlG7tvRY8xaurMvFdll5AbN5/RY12FjITlEEWkHGjcSiaKDvYfpk4zhEUFDKhKBNQ73/6gudyR1bqGtBxHn/mOhTZULT6ub+Oj2alOYOnvTL2KWrMLlUD2QA6p1iNeAoy/08zuwVZEQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669626; c=relaxed/simple;
	bh=ThV2GDf+/LOv1NEDMdhRUL9t0UR+uadCjoaNIrPg7vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J597m9Q/dscUWFiha+n3OLw4L0grsIt1+4kLTunOI4j++mfxkjiN2yE6ns54Yn6VTSuTUrPtxxLZc5/79wt95bACOPjfqOhl+pVtWfodz+KqXCTRX5RKP/Cs6pzsHFLIWQKPUUEuSc1dRA0CkVWi4xIvTCwIj0Vn8s9ncMaR18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCmoRrsB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757669622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kQVDDKQgSTG1ruil2Wq7UaDisPfJegPx5xURSkhlJks=;
	b=DCmoRrsBIY4WAHYvBIEij0OMZa3pf/WsKXBtDXFNI3g930nF2wRYic8tXpFVc+CJ3M1ZID
	57gQAnzEoJRzv7qxevFYC1QN4bsD1qxH5ZT7FkZ2FRwmQx7xPJ6HPy+u8ZK4RX+uotx02N
	KbjWKiTq7P4IMogm42/cWskmjRcuzWU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-OPgyGCHJMXqYrl47SGXYdQ-1; Fri,
 12 Sep 2025 05:33:36 -0400
X-MC-Unique: OPgyGCHJMXqYrl47SGXYdQ-1
X-Mimecast-MFC-AGG-ID: OPgyGCHJMXqYrl47SGXYdQ_1757669615
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60DB11956096;
	Fri, 12 Sep 2025 09:33:35 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.175])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF8D830002CA;
	Fri, 12 Sep 2025 09:33:32 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: fix clock quality level reporting
Date: Fri, 12 Sep 2025 11:33:31 +0200
Message-ID: <20250912093331.862333-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC is not reported via netlink
due to bug in dpll_msg_add_clock_quality_level(). The usage of
DPLL_CLOCK_QUALITY_LEVEL_MAX for both DECLARE_BITMAP() and
for_each_set_bit() is not correct because these macros requires bitmap
size and not the highest valid bit in the bitmap.

Use correct bitmap size to fix this issue.

Fixes: a1afb959add1 ("dpll: add clock quality level attribute and op")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 036f21cac0a9..0a852011653c 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -211,8 +211,8 @@ static int
 dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device *dpll,
 				 struct netlink_ext_ack *extack)
 {
+	DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX + 1) = { 0 };
 	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
-	DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX) = { 0 };
 	enum dpll_clock_quality_level ql;
 	int ret;
 
@@ -221,7 +221,7 @@ dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct dpll_device *dpll,
 	ret = ops->clock_quality_level_get(dpll, dpll_priv(dpll), qls, extack);
 	if (ret)
 		return ret;
-	for_each_set_bit(ql, qls, DPLL_CLOCK_QUALITY_LEVEL_MAX)
+	for_each_set_bit(ql, qls, DPLL_CLOCK_QUALITY_LEVEL_MAX + 1)
 		if (nla_put_u32(msg, DPLL_A_CLOCK_QUALITY_LEVEL, ql))
 			return -EMSGSIZE;
 
-- 
2.49.1


