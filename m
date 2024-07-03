Return-Path: <netdev+bounces-108960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6A09265E4
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995D71F2325C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EFA1822ED;
	Wed,  3 Jul 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4TKhmCh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564D181B90;
	Wed,  3 Jul 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023624; cv=none; b=Vt0Rrtb6vcP101t1xoElnn75p/MLPL3x9pJvlv+G0+/X57nd8UZyF8+f3PF8u+/ctI1bFUbcdWPz4zpE5Y9SXCW8wjMq+OUCH37/aEDGFzWBHVOVvOx0Y0dwfPRfHVsxNvKzslA4w/FZ7kZc0F0pcpaxhxu6EWf7wpCkaF6I9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023624; c=relaxed/simple;
	bh=kM7jQRoVbuiZwl0a2UGo6LmrBqwjsYDrjS4j+uNWnaE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oZ8rWIAW4OxXHEcjHeg7gl2SIJOopGKTHb/YbXIZyCcUI3AwwCY/wcbsISkGqqZlP1P4Fct3oWotXK8ODV84YZMEuHjdSbJfhxzusl84WWmRHihkAF5x2HmH3AsDJi1YCwBR4Vu6tMVVyb/xW7MSWBdz2vT+EmeEvX8EMEMVKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4TKhmCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4E9C2BD10;
	Wed,  3 Jul 2024 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720023623;
	bh=kM7jQRoVbuiZwl0a2UGo6LmrBqwjsYDrjS4j+uNWnaE=;
	h=Date:From:To:Subject:From;
	b=i4TKhmChXTss2c0ieiT4vXhUtXHKw3TO3mVLSbgWpbmaZvAJHPXZrqIJpe1Jnw2E7
	 HG4UAbhghqSvIZqYeWGDIvrMCxnnPvSDTeVxDDkDbd8bOkDlU1vMYh3jf8F+jr+ycj
	 YQ4W3P+nKxYdxB4Yv7Jg1efSQCyfkUiozZrdbX5FHg55VBZmIhpMjp8poS/847qWTJ
	 XCkrJnbXE+Ucdd1Te11D8fC/I15FI8SghjbeBngiFKMf27UN52eey54s1yVdZKzKTW
	 C4oUHekNjRa5qa/PtK69G+wTtur2KeGPSXST7hr5/S+Biq/tNBAE/N1/9OaiDDQUbS
	 jU1hNCCgT0QQQ==
Date: Wed, 3 Jul 2024 18:20:19 +0200
From: Helge Deller <deller@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH] wireguard: allowedips: Prevent unaligned memory accesses
Message-ID: <ZoV6Q6lWgVRqe7eh@p100>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On the parisc platform the Linux kernel issues kernel warnings because
swap_endian() tries to load a 128-bit IPv6 address from an unaligned
memory location:
 Kernel: unaligned access to 0x55f4688c in wg_allowedips_insert_v6+0x2c/0x80 [wireguard] (iir 0xf3010df)
 Kernel: unaligned access to 0x55f46884 in wg_allowedips_insert_v6+0x38/0x80 [wireguard] (iir 0xf2010dc)

Avoid such unaligned memory accesses by instead using the
get_unaligned_be64() helper macro.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 0ba714ca5185..daf967130b72 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -15,8 +15,8 @@ static void swap_endian(u8 *dst, const u8 *src, u8 bits)
 	if (bits == 32) {
 		*(u32 *)dst = be32_to_cpu(*(const __be32 *)src);
 	} else if (bits == 128) {
-		((u64 *)dst)[0] = be64_to_cpu(((const __be64 *)src)[0]);
-		((u64 *)dst)[1] = be64_to_cpu(((const __be64 *)src)[1]);
+		((u64 *)dst)[0] = get_unaligned_be64(src);
+		((u64 *)dst)[1] = get_unaligned_be64(src[8]);
 	}
 }
 

