Return-Path: <netdev+bounces-191336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5EABAF0C
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 11:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5211E1896C3A
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E133205ABB;
	Sun, 18 May 2025 09:44:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A61DB34C;
	Sun, 18 May 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747561454; cv=none; b=NGKQ6fZDtUDOp9xIkH56h0U2hI1RdW7pFh2BozciuQSANpVn8D0K9srX/h+aQXlIxg2SwmP/eYNuiZB6Q2daNHFmT7mqJGxo7c1yl6MIztbAUFsyvz0NoNh3FKyWWHvO440XDwSr3YT9W7ccLa81LGy7BYocLOS9DMYxsrTw8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747561454; c=relaxed/simple;
	bh=T1lLnFf+DuKHAEkJl30hr3sq59K1kuzF2hnarKkuqHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ceMAwx6csKkBBIEnVkDAOlSc4+h6M9BDcHhajBi9Ln2DOR1e9UM3OhbStmC8Xr4CFvukTAiCCrcYPX7UK7xjXov1C8hre/aAVs9V+XIqAWudgjEC8wfk82bWanb4pyhxrAG+BDsYpT2L/abGzVW2mYW9p7uxClXbHDqErv6lZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b0bPQ3ZXMz6M4bX;
	Sun, 18 May 2025 17:39:22 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 47F52140119;
	Sun, 18 May 2025 17:44:09 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 18 May
 2025 11:44:04 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next v1 0/1] queue_api: reduce risk of name collision over txq
Date: Sun, 18 May 2025 13:00:53 +0300
Message-ID: <cover.1747559621.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

Rename local variable in macros from txq to _txq.
When macro parameter get_desc is expended it is likely to have a txq
token that refers to a different txq variable at the caller's site.

Gur Stavi (1):
  queue_api: reduce risk of name collision over txq

 include/net/netdev_queues.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)


base-commit: 67fa756408a5359941bea2c021740da5e9ed490d
-- 
2.45.2


