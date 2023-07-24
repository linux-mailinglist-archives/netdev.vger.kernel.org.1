Return-Path: <netdev+bounces-20277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D9F75EE95
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829DD1C20A8E
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF092112;
	Mon, 24 Jul 2023 09:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F141C03
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40843C433C7;
	Mon, 24 Jul 2023 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690189249;
	bh=zu3C9iFBll2v0WdGfx7jp6XrySSQzyIf+EHmsquer/E=;
	h=From:To:Cc:Subject:Date:From;
	b=g1QXd6543W4mZPZh8Ciqd/276N+0FLtV6KrVWBsvENZ5/lWRnL7GyYBjaxxxIvuV7
	 xUkmoGHWVIbkH32urpyamGJOkI8coIorpIXeU2LENsMT3TbKsuBJnEgZA0Z3s1G1ho
	 aUTWUTqiUJGE3YG4ZnjCmKsub9sqXvi5Dc5TpV95yv0iTJpccNntJ3IfkWL7UUEq4s
	 /R9b+WL95ehxHAyU3GfTgn3II4GPUm13fZoh+uxiyKDv/Okaw4gd26NC+6a0FTficH
	 LhBqB9bcfdN6u3jppDtGBalA/3t5vXaktF/rcKbwyYGm3V3SbbbeeqFJJMb5IRU6Tj
	 LBhiLhFBNp99g==
From: Ilia Lin <ilia.lin@kernel.org>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jeffrey.t.kirsher@intel.com
Subject: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Date: Mon, 24 Jul 2023 12:00:44 +0300
Message-Id: <20230724090044.2668064-1-ilia.lin@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If XFRM_OFFLOAD is configured, but XFRM is not, it will cause
compilation error on include xfrm.h:
 C 05:56:39 In file included from /src/linux/kernel_platform/msm-kernel/net/core/sock.c:127:
 C 05:56:39 /src/linux/kernel_platform/msm-kernel/include/net/xfrm.h:1932:30: error: no member named 'xfrm' in 'struct dst_entry'
 C 05:56:39         struct xfrm_state *x = dst->xfrm;
 C 05:56:39                                ~~~  ^

Making the XFRM_OFFLOAD select the XFRM.

Fixes: 48e01e001da31 ("ixgbe/ixgbevf: fix XFRM_ALGO dependency")
Reported-by: Ilia Lin <ilia.lin@kernel.org>
Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
---
 net/xfrm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 3adf31a83a79a..3fc2c1bcb5bbe 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -10,6 +10,7 @@ config XFRM

 config XFRM_OFFLOAD
 	bool
+	select XFRM

 config XFRM_ALGO
 	tristate
--
2.25.1


