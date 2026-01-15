Return-Path: <netdev+bounces-250196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C9BD24F26
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30DF3300C9B6
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AADE3A1E97;
	Thu, 15 Jan 2026 14:27:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D753A0E84;
	Thu, 15 Jan 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487251; cv=none; b=oR/7xN5CY9dc6Bz5T09aTU7/PrqTJqfG3toj6wuTyutKscaD4LA/jgSNMbRC5mSe+TxTs9ru2eE0N7CQ6c62VZ5Z7viF2/7zkXtk7Zrs3eI9CmdbeElmXcd43VuX5Axid6CI+4B9FjEKC1roBaQNA40r0ckC/VdiQMN1J5pjYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487251; c=relaxed/simple;
	bh=Y7xokPaOKeAuzywvVNYnQfVIAxyOu+0u2+HnZoXjK14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3V9s2dxEwx1NY9++yOSkKvZHNSgPvRti16CE9SvWTwWPnmPKdbXAfnMJ7Ka74m2OxGDe1R5rahxSDWXf1J/NoN2UR3tm05ywY+9xcnHPPa0++qeYOoKg9roxa0plxijtZnVuVqno6iT9rOTB+/GhIGD7oFmN9pzL52DPKCCwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC6CC16AAE;
	Thu, 15 Jan 2026 14:27:28 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next v2] net/tcp_sigpool: Enable compile-testing
Date: Thu, 15 Jan 2026 15:27:26 +0100
Message-ID: <e4822cf4aa03fed067f5df7cd4f3496828abc638.1768487199.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 37a183d3b7cdb873 ("tcp: Convert tcp-md5 to use MD5 library
instead of crypto_ahash"), TCP_SIGPOOL is only selected by TCP_AO.
However, the latter depends on 64BIT, so tcp_sigpool can no longer be
built on 32-bit platforms at all.

Improve compile coverage on 32-bit by allowing the user to enable
TCP_SIGPOOL when compile-testing.  Add a dependency on CRYPTO, which is
always fulfilled when selected by TCP_AO.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms@kernel.org>
---
One remaining oddity is that TCP_SIGPOOL has always been a tristate
symbol, while all users that select it have always been boolean symbols.
I kept that as-is, as it builds fine as a module.

v2:
  - Add Reviewed-by.
---
 net/ipv4/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index b71c22475c515ffc..7280d1b1dae1ba53 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -743,7 +743,8 @@ config DEFAULT_TCP_CONG
 	default "cubic"
 
 config TCP_SIGPOOL
-	tristate
+	tristate "TCP: Per-CPU pool of crypto requests" if COMPILE_TEST
+	depends on CRYPTO
 
 config TCP_AO
 	bool "TCP: Authentication Option (RFC5925)"
-- 
2.43.0


