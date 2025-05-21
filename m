Return-Path: <netdev+bounces-192254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F3ABF20C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2751BC0E60
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7925F991;
	Wed, 21 May 2025 10:49:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78616253B7C;
	Wed, 21 May 2025 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824553; cv=none; b=qWV9ws2fsB0z4ofRWvcLq34GsOF3OQ02GieBQj/Y6Y6gQ6jTK8ua0LcXr4r/92jP5yOCYJbVzuLIBPZOLwE/i0ZnJEfQEv4o0OvPiavG7JOCdkoDaH3vyeTCcHSHsyKEKrdxDy1wAFm6W1uBPF7pzYf0qc3iQEry8dX300VNADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824553; c=relaxed/simple;
	bh=pe/FziX/p5X9TigZYd9m9E01F33tnNfqTmuA0QeWwhc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UHl+YK3uvzHBdIPtsFTC/UWyPEPIXJqQHKahg8rhf6XVii9bA4m36jyUbYAlMqhpWaMgGcemk08ivCT8f6qtod0Mrw7QY/9KFUA7YMkR7tb32G0GGFsQgjJ4dZnazh91ZYDOAqnuILe6KpYUoyZf0iU7fK6SO+issgA1bajkbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2Shw0drZz6D9My;
	Wed, 21 May 2025 18:44:16 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 6687E1400F4;
	Wed, 21 May 2025 18:49:07 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 12:49:02 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next v1 0/1] queue_api: add subqueue variant netif_subqueue_sent
Date: Wed, 21 May 2025 14:06:11 +0300
Message-ID: <cover.1747824040.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

Add a new macro, netif_subqueue_sent, which is a wrapper for
netdev_tx_sent_queue.

Drivers that use the subqueue variant macros, netif_subqueue_xxx,
identify queue by index and are not required to obtain
struct netdev_queue explicitly.

Such drivers still need to call netdev_tx_sent_queue which is a
counterpart of netif_subqueue_completed_wake. Allowing drivers to use a
subqueue variant for this purpose improves their code consistency by
always referring to queue by its index.

Gur Stavi (1):
  queue_api: add subqueue variant netif_subqueue_sent

 include/net/netdev_queues.h | 8 ++++++++
 1 file changed, 8 insertions(+)


base-commit: e6b3527c3b0a676c710e91798c2709cc0538d312
-- 
2.45.2


