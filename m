Return-Path: <netdev+bounces-121819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4595ED0F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2666C282098
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57915145A1B;
	Mon, 26 Aug 2024 09:27:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5614375D;
	Mon, 26 Aug 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664434; cv=none; b=KJaHW/s/2YY1BU4cjFc7N4i8FlahBW983a+P7ZwiARn+xXBKlQl1hSa2IPRo3dpw5b+ggV4r9PhOZp0hmVPMnebB6rFhH11FkLWDIe94I/wKw91dso6apD27DUE252ggSVt4IPS7eUFogXPH0PeCF4rDntfyjbXHbCM+fYwY4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664434; c=relaxed/simple;
	bh=ERzW8bZOxF/dXM11qKbsPhYrKDtfXLGenLrG8Kj0Y3M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NTt3b/GnVPM7yF/tU1TqcwLLPtvqyCKYnf+++mF+6mnaQ2FqNIORSj8yrvNJVVY+fhyU8+Zoqr3+4Z8XIlpRtu3cclxgIRdVSUujprjTvRz2DATtcIZZMQCN4INf/Bs9/hQHWB7uPo2brED3w1KBvFr8K5LbHWWcHibOmUvOyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WslZ60Qb2z69M7;
	Mon, 26 Aug 2024 17:22:22 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 906BE1800A7;
	Mon, 26 Aug 2024 17:27:09 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 17:27:09 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: <chris.snook@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <lorenzo@kernel.org>, <nbd@nbd.name>,
	<sean.wang@mediatek.com>, <Mark-MC.Lee@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<liaochen4@huawei.com>
Subject: [PATCH -next 0/3] net: fix module autoloading
Date: Mon, 26 Aug 2024 09:18:55 +0000
Message-ID: <20240826091858.369910-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Hi all,

This patchset aims to enable autoloading of some net modules.
By registering MDT, the kernel is allowed to automatically bind 
modules to devices that match the specified compatible strings.

Liao Chen (3):
  net: dm9051: fix module autoloading
  net: ag71xx: fix module autoloading
  net: airoha: fix module autoloading

 drivers/net/ethernet/atheros/ag71xx.c      | 1 +
 drivers/net/ethernet/davicom/dm9051.c      | 1 +
 drivers/net/ethernet/mediatek/airoha_eth.c | 1 +
 3 files changed, 3 insertions(+)

-- 
2.34.1


