Return-Path: <netdev+bounces-118053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1388A950690
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920CAB2380E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5527D19B5BE;
	Tue, 13 Aug 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmYjnoYr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4D19AD6E;
	Tue, 13 Aug 2024 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556038; cv=none; b=Gx4Kk716VLwBw44WguYNnWaPuDGg+dGgZm0qummsDQgachCVTzgKj4aLBbb6YIMV8/G5w62v89L5B9n/QbrTEcXGLIjA8HtzDEUm34BYBxf/3UVfytyj5dXx3a+eTgKFu6zg16OH0ia6IF8LnwdujibwNCwZm1ror1f6dJmHKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556038; c=relaxed/simple;
	bh=z+NJxoXGT6DAoM3jpcIPdgMxSjAu22qbMus24gzDpxw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VSsaxn45fu26U9PxAfMB1vaWc0QgD0k/fFJ8ComCZbWXb+trsAst5kev9kK8yq3jUfxFYWO7i4SXEQZ2GD/uO9r7EXbqzsnXi2VKL0Nz8gG3YtwdplpWPD0t2n8MojhsbLMpezczP1BiarHpZ5HyHgOzv05YGYCuudLZcLUkmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmYjnoYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682B9C4AF09;
	Tue, 13 Aug 2024 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723556036;
	bh=z+NJxoXGT6DAoM3jpcIPdgMxSjAu22qbMus24gzDpxw=;
	h=From:Subject:Date:To:Cc:From;
	b=pmYjnoYrLCAXhpLUA6LwgPyFir2W7RJXhjAg2B3WS7Y2aG761JlUYoHj4497xm2or
	 8VanwvABUAjAqANhqMgkyhq8bwDOMlhTjjbYJavTD/mxwOSGU3+Wo2oTimalDq+pwc
	 TP0ZXIsaEj+lM2bX6bdxKwPtIb8tJ9Skq1LACKwXL/p9W5W5vY/j8F6jaG2+u0WW2o
	 FETcPeZ216/C/11FgCOSwQhGnunDyJp6N8MNna6s1nAR/abzkcHQ4ui4TRfH2CTERp
	 DInpgca+MDes+PhFoIB6c4MpA4oaP2sH4o3AIu53in9Ah2HN0Lnv6eABtf0/OJ323b
	 DmLgwm0Ws2hdA==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/3] ipv6: Add
 ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
Date: Tue, 13 Aug 2024 14:33:46 +0100
Message-Id: <20240813-ipv6_addr-helpers-v2-0-5c974f8cca3e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALpgu2YC/32NQQqDMBBFryKz7pQkjaJdeY8iJZqJhkqUiQSLe
 PcGD9Dl4/HfPyASe4rwLA5gSj76JWRQtwKGyYSR0NvMoITSopYK/Zqqt7GWcaJ5JY7omrrXjXa
 9oArybmVyfr+aLwi0YaB9gy6bycdt4e91luTl/3STRIHG9KWV7lEOWrQf4kDzfeERuvM8fw8A0
 tO9AAAA
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
Changes in v2:
- Collected tags from Andrew Lunn and Jijie Shao. Thanks!
- Corrected typo in commit message of 1st patch: cpy -> CPU.
  Thanks to Andrew Lunn.
- Also enhanced same commit message to mention both helpers.
- Link to v1: https://lore.kernel.org/r/20240812-ipv6_addr-helpers-v1-0-aab5d1f35c40@kernel.org

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

base-commit: dd1bf9f9df156b43e5122f90d97ac3f59a1a5621


