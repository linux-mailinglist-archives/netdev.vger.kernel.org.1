Return-Path: <netdev+bounces-154988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CDA00921
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D448B1884326
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CD51B4138;
	Fri,  3 Jan 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvXfBf7h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F4219E0
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906650; cv=none; b=X3pLyvJg/1pY6fK8MXzGP6Glhp+NL/ob4jy09g/1SqEwxbLJPnoB5IjUVCbM3bjP40oyH6bXq8y8MBDbFqBqEFFhsqxmbWyWIQzQ/bQ3YzPdxzwqdJg0I+gyUo+8GyvlaCq3q6IN6BXhURJaVHm6kJZcbl+FRQfjyxjqRAEoYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906650; c=relaxed/simple;
	bh=iZkpeTvEGSmMhcQEIgKm/62l1SkHAgQRaRN1z8ZY27s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gjGPypIj4uipyoOXmV/0o/lNo5n7HDwFLLjdEbQBZl/FRGLJC1SlXsNe3NmD61pfkXxk8vvhSp6KpuUTIJbecp7X3re6sDTc3Oo5PoIpQ4YQjm2viwyOd2AUR2ZVQ5Q5n5hfBei1wrV1ekRjtn8fOfJ8+IRX2lgwvfQzyz60Nng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvXfBf7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B1CC4CECE;
	Fri,  3 Jan 2025 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735906649;
	bh=iZkpeTvEGSmMhcQEIgKm/62l1SkHAgQRaRN1z8ZY27s=;
	h=From:Subject:Date:To:Cc:From;
	b=SvXfBf7hGV7fp4gh4aPsKb1uAnkbBn6qxysrM307b0QVf2iOgO1gy1hMuzKQY8QCw
	 1ytwDqZOzrkK2W0cokJE2DuJjpm9CcMop5ezeQjmvjPZVcuPDD1WD1aKB3KmZBWJjV
	 T1wZqwi2qxhCjZ9MnklGzTdZGT4S6wTi2GwTQOWmwmBmxwMtg2cXgj/X5AQbCsLRlD
	 iF+OCzLuVISLpBSfEFcwmo5A7fXbAH/hN5dvonR5ilDTm2QmyPdfXJ/C8Yixy4NNdj
	 ny5iRmXuyk8d8tRqYCYwm8DYvVhDU3yF8p0MYdB+GXNSR+EYBDdsKcoR1wz0UySPEC
	 I/XWbjkKcpN1Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/4] net: airoha: Add Qdisc offload support
Date: Fri, 03 Jan 2025 13:17:01 +0100
Message-Id: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD7Vd2cC/x3MwQrDIAwA0F8pOTegtl3LfqXsEDSpgaGdwhhI/
 33S47u8BpWLcoXn0KDwV6vm1GHHAXykdDBq6AZn3GzdZJC05EjIaV02i5+g1WMWeWcKuE7OG6G
 wPGaBPpyFRX/3vr+u6w/f4YR4bQAAAA==
X-Change-ID: 20241230-airoha-en7581-qdisc-offload-732c0fad564f
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 upstream@airoha.com, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce support for ETS and HTB Qdisc offload available on the Airoha
EN7581 ethernet controller.

---
Lorenzo Bianconi (4):
      net: airoha: Enable Tx drop capability for each Tx DMA ring
      net: airoha: Introduce ndo_select_queue callback
      net: airoha: Add sched ETS offload support
      net: airoha: Add sched HTB offload support

 drivers/net/ethernet/mediatek/airoha_eth.c | 518 ++++++++++++++++++++++++++++-
 1 file changed, 514 insertions(+), 4 deletions(-)
---
base-commit: 3fff5da4ca2164bb4d0f1e6cd33f6eb8a0e73e50
change-id: 20241230-airoha-en7581-qdisc-offload-732c0fad564f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


