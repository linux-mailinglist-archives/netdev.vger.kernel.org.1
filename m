Return-Path: <netdev+bounces-117680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DB094EC7D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D255528235D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F6717997A;
	Mon, 12 Aug 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR0JxCIv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B417967F;
	Mon, 12 Aug 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464730; cv=none; b=cSjUPej8C3ghWnZMPJoq2azyJAL8DbPKK3oqBJCobZYwWev9G8G9Hohtfg+I67fIJ57RY94uwfOP6NET5LI6PH6ZUwjJzpULQW+Y1rHJeRr6o+Pm669NQTjgRzzaYgOJ1HaTaCvOYaDvK21G7TsXpvV9HzRIlwW9njTnPWQsuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464730; c=relaxed/simple;
	bh=qk49YrVSofC+BVzHm+Bp5DXAljOe2s9DkkPbzEpVrcw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QZuZO3NhdqSlPUyqJNj/OphBnsl08gM3Sy24WI84uZuDco9Quk7XIUSz7nvjOunBXFo9b9pZV6U3jlXQjVpRy2XtFVj76jyc/F25RMSWsamPtnKOMvBL6B/9cOjRJCxaPZzhWJ2lVyaNNrv2n+ofMPymSrdTnfe5ti+wjX5ryFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR0JxCIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FECC32782;
	Mon, 12 Aug 2024 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723464730;
	bh=qk49YrVSofC+BVzHm+Bp5DXAljOe2s9DkkPbzEpVrcw=;
	h=From:Subject:Date:To:Cc:From;
	b=nR0JxCIvZJldbDSANbm7pjQ2vtDxP/pUsoxenEW1sYbA9ZM/TIuxVNpzR5T541zW2
	 ElLbzeO736JcC7/k++Y1iunzxlWmy19UGlo9pwYSCX96upLnjvdF3BbCMSMMRPEV2B
	 KCug5r+n7NzYYqwNgNOa+Wc6O6sK4m5U59L3bzQP5Xkxf0Y7w6EUDr3Nwx+eodk4A0
	 qlMr+c+2cSjqiV3fVH2cgH22uleIIOubglo0ftuYq5wIrrD7HYDA4Pmq5Tw6eiP4JV
	 FZbFuVnRajVt+PEkDLxDMJv2t0asApMS5Dppf2NoPkwgBtpFA6Lx4b9OA/OP/RN+t/
	 gKmN/U5eMroHg==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/3] ipv6: Add ipv6_addr_{cpu_to_be32,be32_to_cpu}
 helpers
Date: Mon, 12 Aug 2024 13:11:54 +0100
Message-Id: <20240812-ipv6_addr-helpers-v1-0-aab5d1f35c40@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAr8uWYC/x3MQQqEMBAF0atIr22IIYh6lWEQnfxog8TQERHEu
 xtm+RZVN2WoINNQ3aQ4JcseC5q6ot86xQUsvpissc50jWVJZztO3iuv2BI0c+i72fUuzAYtlS4
 pglz/54ciDo64Dvo+zwuPJ57tbQAAAA==
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.0

Hi,

This series adds and uses some new helpers,
ipv6_addr_{cpu_to_be32,be32_to_cpu}, which are intended to assist in
byte order manipulation of IPv6 addresses stored as as arrays.

---
Simon Horman (3):
      ipv6: Add ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
      net: ethernet: mtk_eth_soc: Use ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
      net: hns3: Use ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers

 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 79 +++++++++++-----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  8 ++-
 drivers/net/ethernet/mediatek/mtk_ppe.c            | 10 +--
 drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c    |  9 +--
 include/net/ipv6.h                                 | 12 ++++
 5 files changed, 66 insertions(+), 52 deletions(-)

base-commit: c4e82c025b3f2561823b4ba7c5f112a2005f442b


