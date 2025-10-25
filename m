Return-Path: <netdev+bounces-232943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE14C09FF9
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 423DF4E679E
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BD430ACFD;
	Sat, 25 Oct 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzboqHNR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD62308F0B;
	Sat, 25 Oct 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761425630; cv=none; b=D6735FsGhNf2UnA7+W//lgGipOg7oHOuJtJpgQtHND9mkw3lxhrRoqdJuCZOlfLj6MBxc7sxlft3ADymocuvc9J0mNjzrh/RNxKy9nzGPBl84PCkLk5vnXnjRET3dWFOsisyUlrCI32/DXilFAN9l1Q4ByLnQRcsO8yGKZurBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761425630; c=relaxed/simple;
	bh=Mat9VxZHBL0yR1NJE0Sr7s9tFOz/Ujx/ASRcrsLo2u4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaM64nNbRn5otR007WDVcG4bmKbr1jIjU4Mp6XzXXKzzvI4iz7K3IQ0fnUe7VYQ5TMdRnBmEMbbjU21j3rrYlOBPDhPffRJQI7mETgexp3wgccPiq6evHhgG6WPdRMMnZ6ALSI/G8VAedGmGkfZ9w/AepCy+COSA+FW0pu8T/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzboqHNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6576AC4CEFB;
	Sat, 25 Oct 2025 20:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761425630;
	bh=Mat9VxZHBL0yR1NJE0Sr7s9tFOz/Ujx/ASRcrsLo2u4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DzboqHNR6b7YAK/AUFIyjPlywlnGFoSVpIJamZ9O5dnKDJg8Imsrvq7i7iInHUJlC
	 YuokKw1U2HEcROCUm2Jk/L4o65LXzgoFCXxpetdbAWeICJ01FujcA0wr6ZVJTMbHG3
	 Muu2VovKrAV6hjuQSCLmfzU9tXwfuiG0nZsaBm0kdz300LONEUlvacAnqSMCgi0Q+s
	 M/ChilFU/ewTw529F/2z8UEEldjxkze9lzkGOII6ExkIqFYE+tGmBjgRwEla+nkwXB
	 XQWP3pThD1esuOMry27jV9gPBoSU0cAM1pq85WyXg++E3Ymk3ndg1smOSnUHRydYt/
	 7yO6yHGiMtUMQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 25 Oct 2025 21:53:20 +0100
Subject: [PATCH 3/3] libeth: xdp: Disable generic kCFI pass for
 libeth_xdp_tx_xmit_bulk()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-idpf-fix-arm-kcfi-build-error-v1-3-ec57221153ae@kernel.org>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
In-Reply-To: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
To: Kees Cook <kees@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2425; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Mat9VxZHBL0yR1NJE0Sr7s9tFOz/Ujx/ASRcrsLo2u4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBl/Lc4s8byy2+zW+2tnI17aCb7y78nm1vC4yCC7xrr22
 K2NnbP9O0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEVt9h+B/6c9+7XWH/52jz
 y2bfy3zF/i3juG9i2YSqQJGdfM58/uyMDMt92Iu7Ah++Mld6tpGp2/hLEPse18vWllvakzwfrHT
 U4AUA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building drivers/net/ethernet/intel/idpf/xsk.c for ARCH=arm with
CONFIG_CFI=y using a version of LLVM prior to 22.0.0, there is a
BUILD_BUG_ON failure:

  $ cat arch/arm/configs/repro.config
  CONFIG_BPF_SYSCALL=y
  CONFIG_CFI=y
  CONFIG_IDPF=y
  CONFIG_XDP_SOCKETS=y

  $ make -skj"$(nproc)" ARCH=arm LLVM=1 clean defconfig repro.config drivers/net/ethernet/intel/idpf/xsk.o
  In file included from drivers/net/ethernet/intel/idpf/xsk.c:4:
  include/net/libeth/xsk.h:205:2: error: call to '__compiletime_assert_728' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(tmo == libeth_xsktmo)
    205 |         BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
        |         ^
  ...

libeth_xdp_tx_xmit_bulk() indirectly calls libeth_xsk_xmit_fill_buf()
but these functions are marked as __always_inline so that the compiler
can turn these indirect calls into direct ones and see that the tmo
parameter to __libeth_xsk_xmit_fill_buf_md() is ultimately libeth_xsktmo
from idpf_xsk_xmit().

Unfortunately, the generic kCFI pass in LLVM expands the kCFI bundles
from the indirect calls in libeth_xdp_tx_xmit_bulk() in such a way that
later optimizations cannot turn these calls into direct ones, making the
BUILD_BUG_ON fail because it cannot be proved at compile time that tmo
is libeth_xsktmo.

Disable the generic kCFI pass for libeth_xdp_tx_xmit_bulk() to ensure
these indirect calls can always be turned into direct calls to avoid
this error.

Closes: https://github.com/ClangBuiltLinux/linux/issues/2124
Fixes: 9705d6552f58 ("idpf: implement Rx path for AF_XDP")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/net/libeth/xdp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index bc3507edd589..898723ab62e8 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -513,7 +513,7 @@ struct libeth_xdp_tx_desc {
  * can't fail, but can send less frames if there's no enough free descriptors
  * available. The actual free space is returned by @prep from the driver.
  */
-static __always_inline u32
+static __always_inline __nocfi_generic u32
 libeth_xdp_tx_xmit_bulk(const struct libeth_xdp_tx_frame *bulk, void *xdpsq,
 			u32 n, bool unroll, u64 priv,
 			u32 (*prep)(void *xdpsq, struct libeth_xdpsq *sq),

-- 
2.51.1


