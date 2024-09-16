Return-Path: <netdev+bounces-128587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D35997A789
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FBE1F21B9B
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D615B97B;
	Mon, 16 Sep 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZnn4ipV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Ne+l08m"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829B2628C;
	Mon, 16 Sep 2024 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513061; cv=none; b=Sscud5lJdkure2ad2yUYHCtdUDfBM8H1oNo2V8zqgzXxrP8Ty3CRUOjY25Lt4y/iFtD/7HJGnsVr0V8dsKzb5fJHHSZxd6tWOX0GqvK4O6zg5LgcwX+HLCZYehaw71QmgDmb/UR5TdTIz39wqxtNwiOCCh7Ywz0GwFIZ1ndzfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513061; c=relaxed/simple;
	bh=Acz1KDzvC3yGxPaMfyzhFHnrbE2hmHZcdquVdNRdSdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L4ryfo0AvfjJqSYnVHPPbOmsS9IU9gT//XW8M3UT8G+G7JlE7ONZOzn2LIgjUuSHpoLyp3ykVc/VimmLHsRvI1JBC8jdSzj2BZxgsUolhwagNccPr8OlHIZ8KqJWCA9wa4MR2pz0Uli6oZ0qhhV9+VEwMCud/IRnRCR0i/WZhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZnn4ipV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Ne+l08m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726513057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uCmN/cZCPzCftbZp8I+nP+HMZCAR3HVMPzJ6bFU94XI=;
	b=MZnn4ipV7Q5r5blo2CqdYGgJBHFKN2DpLKekZMzZW5qs8vN/OS2MrV9iy55W9TMTgTGzGn
	RVUyRKCdT5vuAoLEnKP0TWLw0WykH7L/aG0YZfQYBl+yCthv0q/76lQQCY+J6lVyj/RYZn
	tm83EFoyFLH1zxC9MdVfIf19eh/IjTh9T6B4E95lOvPzC61/xB3hG4ZCd/QwM2+1pUUV6O
	tS4EVeQVXCHxQ1l65rHP8vcTy6UBxgnWps7YP/lUbPhNGAqJZ4E1ojwT7k8t3fXC0PLgc7
	nYEF4A6uat9pv6kLTzWKO37hvLwUBftmexyHssgVWSNsO6iC99HOCi5HEMT7ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726513057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uCmN/cZCPzCftbZp8I+nP+HMZCAR3HVMPzJ6bFU94XI=;
	b=0Ne+l08mxA4rujqSaP8wr0JJtpD7J1nFZrH14AGm18+P+l1dGusWpwuc7Sq/1pTTJwT1Y0
	bER9pMq4wmyqb7BA==
Date: Mon, 16 Sep 2024 20:57:13 +0200
Subject: [PATCH net v2] net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240916-ipv6_rpl_lwtunnel-dst_cache-v2-1-e36be2c3a437@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAIh/6GYC/42NWw6DIBBFt2LmuzSCr9qv7qMxxsJQJyFgAKmNc
 e8lrqCf59zk3B0CesIA92IHj4kCOZtBXAqQ82TfyEhlBlGKuux5y2hJ7egXM5pPXK1Fw1SIo5z
 kjEyIpuV9d9NVoyEXFo+atrP+BIsRhixnCtH57/mY+Dn9FU+ccSarWjWqe02drh6G7Bq9s7RdF
 cJwHMcPODuCW88AAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Aring <alex.aring@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726513057; l=1527;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Acz1KDzvC3yGxPaMfyzhFHnrbE2hmHZcdquVdNRdSdc=;
 b=vbR78kapKhOE21VGUPvp/TfXRpOF1XT6E3ujb6uefg5kh0VBL/y0WgtZBobSbFUEapnSay0ea
 GEM4YWTfuhSBPUUcV3T/kHQRu+rntjyto+aN76rpzdIHyK4Yl4MYlaS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The rpl sr tunnel code contains calls to dst_cache_*() which are
only present when the dst cache is built.
Select DST_CACHE to build the dst cache, similar to other kconfig
options in the same file.
Compiling the rpl sr tunnel without DST_CACHE will lead to linker
errors.

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
---
Changes in v2:
- Fix Signed-off-by
- Remove Cc stable as per net/ rules
- Add Simons tags
- Expand commit message a bit
- Link to v1: https://lore.kernel.org/r/20240916-ipv6_rpl_lwtunnel-dst_cache-v1-1-c34d5d7ba7f3@linutronix.de
---
This is currently affecting the s390 defconfig.
In my opinion this patch should also be backported to stable.
---
 net/ipv6/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 08d4b7132d4c..1c9c686d9522 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -323,6 +323,7 @@ config IPV6_RPL_LWTUNNEL
 	bool "IPv6: RPL Source Routing Header support"
 	depends on IPV6
 	select LWTUNNEL
+	select DST_CACHE
 	help
 	  Support for RFC6554 RPL Source Routing Header using the lightweight
 	  tunnels mechanism.

---
base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
change-id: 20240916-ipv6_rpl_lwtunnel-dst_cache-22561978f35f

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


