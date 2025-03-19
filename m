Return-Path: <netdev+bounces-176047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F86A68755
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CD73B6F7A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C612505D3;
	Wed, 19 Mar 2025 08:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3514D2505C7
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374709; cv=none; b=LQeSvkX5kzqOUv8imV5p+cdslIzBpD6oyDhy+EnWyrJnjHAzOaS2BHVrujiedEVEZF/MiYP4yqoGF3CiY9cfLI2YY3oZWTdmThDVCUGYmZe08LcTN7a/sIEARIttB6u2sbr+uMit36o5gNVdXk/ylgqTpubNkjdSvTcQ55YlwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374709; c=relaxed/simple;
	bh=pzO6IBpK7lGc763ET9hR6TFiyK2dBPi9gU5KxOHieZY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k4vW+AzXUAeSPZ5d5ddLx6Ed6Xbm35Qbrie0SOfoj42nD5WDQpsGZp9hfp4TrNEVqEMGfxmmyugZHjLKLGO2cA7b5kcWZqL+Sh8cA2rIBKTew7ugcb+GYOMl6mKgqqTw1Wp3osGNIwLCdHQhr0p7cIDewZ+/wGK5F1GnaGk2IcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.37])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 517F3180E9948F;
	Wed, 19 Mar 2025 16:57:38 +0800 (CST)
Received: from BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) by
 BJ03-ACTMBX-01.didichuxing.com (10.79.71.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Mar 2025 16:57:57 +0800
Received: from pilot-ThinkCentre-M930t-N000 (10.79.71.101) by
 BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 19 Mar 2025 16:57:56 +0800
Date: Wed, 19 Mar 2025 16:57:51 +0800
X-MD-Sfrom: jingsusu@didiglobal.com
X-MD-SrcIP: 10.79.71.37
From: Jing Su <jingsusu@didiglobal.com>
To: <edumazet@google.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <jingsusu@didiglobal.com>,
	<jinnasujing@gmail.com>
Subject: [PATCH] dql: Fix dql->limit value when reset.
Message-ID: <Z9qHD1s/NEuQBdgH@pilot-ThinkCentre-M930t-N000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BJ02-PUBMBX-01.didichuxing.com (10.79.65.22) To
 BJ02-ACTMBX-07.didichuxing.com (10.79.65.14)

Executing dql_reset after setting a non-zero value for limit_min can
lead to an unreasonable situation where dql->limit is less than
dql->limit_min.

For instance, after setting
/sys/class/net/eth*/queues/tx-0/byte_queue_limits/limit_min,
an ifconfig down/up operation might cause the ethernet driver to call
netdev_tx_reset_queue, which in turn invokes dql_reset.

In this case, dql->limit is reset to 0 while dql->limit_min remains
non-zero value, which is unexpected. The limit should always be
greater than or equal to limit_min.

Signed-off-by: Jing Su <jingsusu@didiglobal.com>
---
 lib/dynamic_queue_limits.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index c1b7638a594a..f97a752e900a 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -190,7 +190,7 @@ EXPORT_SYMBOL(dql_completed);
 void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
-	dql->limit = 0;
+	dql->limit = dql->min_limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
-- 
2.34.1


