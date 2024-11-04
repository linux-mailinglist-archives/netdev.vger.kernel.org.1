Return-Path: <netdev+bounces-141555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2001B9BB545
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8498282A38
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629641BD00A;
	Mon,  4 Nov 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kA7AHM3d"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A0118A6B6;
	Mon,  4 Nov 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725326; cv=none; b=BaK5Jsvo7wKdCT9s6fQt9xp6ekQePqRQV+HMmV26jhQpZ1442qdWa88TSXgICwoFYf8qjrq+Pgp5DHMqOBwURxrL0qolAxUt6wRJSHOKD5vrGJYcOCsJwh8mZ2VyqHj7fpCQaLUARhDa+TP9M1FOSxUlbsFJUtW4m1fj75N+gfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725326; c=relaxed/simple;
	bh=SfYwx8Edw7Kt0PG4w7QaefIHTWtCJwvQEUigYkyd+u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUtB2FplHmzSdVdwU5JduCZ0VPOfUfCPnBKvTCErke0VdGSksVoqt48TyYYu/czrDoCyXjz7mKHzKFhxl8K2V9z0jVOuB/EiyZqCjmgeyHun+X/N4xhKYc3ZGD+4shqzXSdkmxvLglIbAmx9FbU+uwgrbopdS8Mfm8F06sOYZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kA7AHM3d; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=YaL3A
	JkQ06NNAoWLM3tOhYWJXsZk3nCjFmIbH4Sabgo=; b=kA7AHM3dqEacjsYp+Lc0/
	MyMg6UyKriXb0Gu+HUpDak2JPyjH7keamuheW0e2cFh2k7xDUP1t+11ZCq7L/hC1
	7Zpi0AENxPFHFwM+7vHHBVSv3VdLPaj+XhtVE5ydySmUHY3lTxXoeSDQfe2SX2ag
	50rJcfgRKX3JITpBpdn9xI=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H6e8xShnPaEoFA--.33421S2;
	Mon, 04 Nov 2024 21:01:52 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.wu@rock-chips.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 0/2] Fix the arc emac driver
Date: Mon,  4 Nov 2024 21:01:37 +0800
Message-ID: <20241104130147.440125-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H6e8xShnPaEoFA--.33421S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1Utry7AF48uFy8uryxAFb_yoWxKFgEgF
	W0vFZxGw45uF4S9a90grnruFZI9FW8WrnYgF1kK395K342yr4kXrsrJryfXr1YvF48CF98
	JF13XrW8Ca47ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0mhF7UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQGNXmcovEiZFgAAsP

From: Andy Yan <andy.yan@rock-chips.com>


The arc emac driver was broken for a long time,
The first broken happens when a dma releated fix introduced in Linux 5.10.
The second broken happens when a emac device tree node restyle introduced
in Linux 6.1.

These two patches are try to make the arc emac work again.

Changes in v2:
- Add cover letter.
- Add fix tag.
- Add more detail explaination.

Johan Jonker (2):
  net: arc: fix the device for dma_map_single/dma_unmap_single
  net: arc: rockchip: fix emac mdio node support

 drivers/net/ethernet/arc/emac_main.c | 27 ++++++++++++++++-----------
 drivers/net/ethernet/arc/emac_mdio.c |  9 ++++++++-
 2 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.34.1


