Return-Path: <netdev+bounces-243584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0ACCA4241
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6537E3072C63
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B55281532;
	Thu,  4 Dec 2025 14:57:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61227FD59;
	Thu,  4 Dec 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860260; cv=none; b=RlcMQkh146LQLJwz4/nGRRd+DmxFvQgIGZ1PGlBofRUHCROs6/PlRTqeZ+bjOPkJ1IrPS5hknOpcEevATsx5X6wzXUwfpzdjwuHasvZLYw7gaNqWt98pB3dgofL6ZP6Xz+t/YTWOakHO8mWkr820smGSzaEx53GBlGsJ6AVXeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860260; c=relaxed/simple;
	bh=bD3/uL0gXsJIHn2f4I7fGz/LjN0Qz6nbZ0WoJ2bT22o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GsVGfBlVStW+i34E86RnZXjNxOauMCxME7WbE4ELJ2easuaRwddp4HmeRbu5gihq7T1/tzlNAdFdf+xi0ZCPcJIEHt5c9SFWpMnZyi5UNkp4eqqo7ZA2cvKgtoEL8N1uqIx7d66f28mPY6Hqa1M1I5NNtYn0wd1ROBJAFury7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DC4C4CEFB;
	Thu,  4 Dec 2025 14:57:37 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Eric Biggers <ebiggers@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next] net/tcp_sigpool: Enable compile-testing
Date: Thu,  4 Dec 2025 15:57:31 +0100
Message-ID: <95d8884780f3682637f0e93049cc484545464ef9.1764860099.git.geert+renesas@glider.be>
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
---
One remaining oddity is that TCP_SIGPOOL has always been a tristate
symbol, while all users that select it have always been boolean symbols.
I kept that as-is, as it builds fine as a module.
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


