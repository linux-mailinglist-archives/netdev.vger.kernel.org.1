Return-Path: <netdev+bounces-51076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F99B7F8F80
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 22:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30328B20FD6
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 21:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4522430F8D;
	Sat, 25 Nov 2023 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDyPWWzF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D59442;
	Sat, 25 Nov 2023 21:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676D7C433C8;
	Sat, 25 Nov 2023 21:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700948043;
	bh=3PJWnPCtKl6PvabTELl1ZdWeU0rVXun3osxxXR2Cv+U=;
	h=Date:From:To:Cc:Subject:From;
	b=bDyPWWzFS+Iqm5I3epM/lwGJhMeAsCxIjgyskeMt0jEuMbAGth62cljmUcdWUx9iM
	 JypYTyhoJ6iMx/wb6yoVWr8kUxaw5+e9neIAfbqcI57AFbhhZeoY76b7n/ibdcnwm7
	 EzlNYKuzwVi5Eu8L6FPM1BokSaXvhnAwypKVM5RTLy9xuvrzv4Ez0gQXYXz3CgBGN6
	 Z93kxIJJyn9HpcCWkX1GK512DeV76WomS7TNJtK6J+3gF9o9x1YKSktir9jHDuEt1R
	 DDFvFUP68E+VPd2/l30IqiSlq/mri3uSxbRIMnPfQA8ncyroAzsaB8Vfg7pdyx4C7x
	 NvVCTXUDY8IZQ==
Date: Sat, 25 Nov 2023 15:33:58 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>, Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] neighbour: Fix __randomize_layout crash in struct neighbour
Message-ID: <ZWJoRsJGnCPdJ3+2@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Previously, one-element and zero-length arrays were treated as true
flexible arrays, even though they are actually "fake" flex arrays.
The __randomize_layout would leave them untouched at the end of the
struct, similarly to proper C99 flex-array members.

However, this approach changed with commit 1ee60356c2dc ("gcc-plugins:
randstruct: Only warn about true flexible arrays"). Now, only C99
flexible-array members will remain untouched at the end of the struct,
while one-element and zero-length arrays will be subject to randomization.

Fix a `__randomize_layout` crash in `struct neighbour` by transforming
zero-length array `primary_key` into a proper C99 flexible-array member.

Fixes: 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")
Closes: https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/neighbour.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 07022bb0d44d..0d28172193fa 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -162,7 +162,7 @@ struct neighbour {
 	struct rcu_head		rcu;
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
-	u8			primary_key[0];
+	u8			primary_key[];
 } __randomize_layout;
 
 struct neigh_ops {
-- 
2.34.1


