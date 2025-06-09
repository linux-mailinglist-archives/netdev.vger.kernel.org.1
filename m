Return-Path: <netdev+bounces-195845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBD7AD27D6
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD6616146C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33232221552;
	Mon,  9 Jun 2025 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDXejdwS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9681DE2A7
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501668; cv=none; b=DJQ/a2yLD0PvIDk6pMvw7TBVDiO0h4toTTRnS0aP2fn9GhIZLeJLB1erWazDcs17NdcyhaC+XzThNLSWFLyYSnfc+fmZQXypJbBk/4pAFJm6fRC3TlXsbtLdrWTCXgoB7STseOsxc0Oxv7ZeCuUxkxr6YhRGN6lBh/0Jb90O82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501668; c=relaxed/simple;
	bh=ossCfSxOWYUfRDCTjGWqVcgE+BuQ279AatMC3LDtX/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D7IIctcP6BkF9k5M3314gCO42kXaxnzsg38J6HTHV98r4B55eqlDA7ffOT9XMF6ovWRQ2PrTlovXZqNPrH00aflj0oZwxdQ+cWGOXyIz42nd/TUR+ZSaR9L1EB9C7Q5SRijPWWl3FquHdnoKQz28evymowMz0QSKrar1gBKIVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDXejdwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6859C4CEF0;
	Mon,  9 Jun 2025 20:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749501667;
	bh=ossCfSxOWYUfRDCTjGWqVcgE+BuQ279AatMC3LDtX/U=;
	h=From:Date:Subject:To:Cc:From;
	b=rDXejdwSUKoD35Jm6U5j1VtnU+8xgXPQ//1ULv3dFliYrcw9JfmSkCgdJuhiJXnci
	 Bv3+3iP39vjjGyAStZtgCkNjoafkdDww2yPbfq4fqHBuPSog6sM5gNIyC6iRKKMC2o
	 EAyccyPQA1weIYYJaDL9IcJa96YTkkGltdhLNZZDUAsWkLyfuahlOpP2zU4+FHSEQ0
	 sMqW984hFIa9TYpV+bqJSQI6GoGLybbCuXKMvei+ZwiXpudZnazbZdOc4U/ZXWK+U+
	 TvXUjnoQRvZnAgJl+lQ762PHQe6uGIMBuSOT/hYGYeV/CQkNhuxdXzwmparu2BF9AS
	 WQSIQnGNzbYlw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 09 Jun 2025 22:40:35 +0200
Subject: [PATCH net] net: airoha: Enable RX queues 16-31
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-aioha-fix-rx-queue-mask-v1-1-f33706a06fa2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMJGR2gC/x2M3QpAQBQGX0Xn2qldongVuTjWh5P87UZK3t3mc
 mpmHgrwikB18pDHpUG3NYJNE3KTrCNY+8iUmawwpalYdJuEB73Z33ycOMGLhJlhIS7vXGUNKNa
 7R5T+c9O+7wfLDh8HaQAAAA==
X-Change-ID: 20250609-aioha-fix-rx-queue-mask-e1eac3bc910e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Fix RX_DONE_INT_MASK definition in order to enable RX queues 16-31.

Fixes: f252493e18353 ("net: airoha: Enable multiple IRQ lines support in airoha_eth driver.")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_regs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 04187eb40ec674ec5a4ccfc968bb4bd579a53095..150c85995cc1a71d2d7eac58b75f27c19d26e2b5 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -614,8 +614,9 @@
 	 RX19_DONE_INT_MASK | RX18_DONE_INT_MASK |	\
 	 RX17_DONE_INT_MASK | RX16_DONE_INT_MASK)
 
-#define RX_DONE_INT_MASK	(RX_DONE_HIGH_INT_MASK | RX_DONE_LOW_INT_MASK)
 #define RX_DONE_HIGH_OFFSET	fls(RX_DONE_HIGH_INT_MASK)
+#define RX_DONE_INT_MASK	\
+	((RX_DONE_HIGH_INT_MASK << RX_DONE_HIGH_OFFSET) | RX_DONE_LOW_INT_MASK)
 
 #define INT_RX2_MASK(_n)				\
 	((RX_NO_CPU_DSCP_HIGH_INT_MASK & (_n)) |	\

---
base-commit: 82cbd06f327f3c2ccdee990bd356c9303ae168f9
change-id: 20250609-aioha-fix-rx-queue-mask-e1eac3bc910e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


