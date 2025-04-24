Return-Path: <netdev+bounces-185411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E06AA9A3EB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFF97B1E19
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 07:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4DA201035;
	Thu, 24 Apr 2025 07:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCFB1FF1BF;
	Thu, 24 Apr 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479355; cv=none; b=u6Lg6fv4gW2CcZ+0hgmShtgCTBmzqtLaov00zJHqME0bcb0KJB0ylw8lqjto/qcBc4MEogn1DUCYbdf5+wgi1SK43hVENglce6WekJ8lNi6TXSx8erU91PvhnGCeIObuOJU785YyoJDrpccgxq3kT1kSZy86XdNeedMAmDTdE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479355; c=relaxed/simple;
	bh=yQBJ5xXAQ4dkP66O25e33ARP2AY88qxSlGWVHfRRAIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HTdMuUr2pJnAL42sq41mKjj2zb5qTho0SJrEwkM69AB2rIuNFZuPzcz13YIUpHDrDFCvYggnb8Pf1pWnwRZs4ueNhtMRJWfeoWaoPRJjExQVD8wUYIZ07EDhqAX8SjxYjJvqdXBH0QMarPR1biyT+kFdIPAbISyBoxONVJO+jR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.238])
	by gateway (Coremail) with SMTP id _____8AxTWuy5glotCXFAA--.63767S3;
	Thu, 24 Apr 2025 15:22:26 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.238])
	by front1 (Coremail) with SMTP id qMiowMDxfRur5glo5CaTAA--.5456S2;
	Thu, 24 Apr 2025 15:22:22 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chris.chenfeiyang@gmail.com>,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Biao Dong <dongbiao@loongson.cn>,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: [PATCH net-next V3 0/3] net: stmmac: dwmac-loongson: Add Loongson-2K3000 support
Date: Thu, 24 Apr 2025 15:22:06 +0800
Message-ID: <20250424072209.3134762-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxfRur5glo5CaTAA--.5456S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFy3uw15XFWDtryxWw4Dtrc_yoWfuFX_ua
	4Sva4rXrs5JF1Iq343Xr4rXr13uw4qqw1Y9Fnrtrn5Zwnrtr98XF1UCrWDWF13urWYvr9x
	X34kGry8Cr1xtosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1l
	Yx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==

This series add stmmac driver support for Loongson-2K3000/Loongson-3B6000M,
which introduces a new CORE ID (0x12) and a new PCI device ID (0x7a23). The
new core reduces channel numbers from 8 to 4, but checksum is supported for
all channels. 

V1 -> V2:
1. Use correct coding style.
2. Add Tested-by and Reviewed-by.

V2 -> V3:
1. Update commit message.
2. Add Yanteng's Reviewed-by.

Huacai Chen (3):
  net: stmmac: dwmac-loongson: Move queue number init to common function 
  net: stmmac: dwmac-loongson: Add new multi-chan IP core support
  net: stmmac: dwmac-loongson: Add new GMAC's PCI device ID support

Tested-by: Biao Dong <dongbiao@loongson.cn>
Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 105 ++++++++++-----------
 1 file changed, 49 insertions(+), 56 deletions(-)
---
2.27.0


