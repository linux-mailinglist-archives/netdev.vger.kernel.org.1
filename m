Return-Path: <netdev+bounces-192451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA5FABFEE6
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7C34E55ED
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ABD2BD019;
	Wed, 21 May 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZOB+chS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54C2BD010;
	Wed, 21 May 2025 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862816; cv=none; b=oprZ5LcQey1gZxDtsA5476HbTdkXD/fT8yhE0ZaJiLSQ3A+n6dehH8K/nDkA3YhbOlH3Famg/Nf5+hTgq/Kjez53dolCoicnrYq+P9RFK9zXUMoZBQHCyFlmG907EtfhdNOpE91Bs8+GJwfGMRaddrnI7VuodqDkNFUh7noK/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862816; c=relaxed/simple;
	bh=fGPASh4PnhqGsRBERfiWfGeflFxih9Uu3XXYIV/d5fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIEfEF/pFDpuzuciYoDEAiGTZ8bC70CDn1iqiEWisnfocNDnkQkpYVK696Yfh9owl0/7oX1y8WqTLVZnpXUGy6IAqHxrBg0R1H2jA/4Q6Owo6cEYeJOHLkMAJlpwoMgmQrkJ5ZZ1x5ZbyT9f7VFCS+Neb79Cu++ehZvO0dTX5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZOB+chS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C7AC4CEE4;
	Wed, 21 May 2025 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747862816;
	bh=fGPASh4PnhqGsRBERfiWfGeflFxih9Uu3XXYIV/d5fM=;
	h=From:To:Cc:Subject:Date:From;
	b=eZOB+chSSLV8SKqh6nzA1/jA+EAOKShILiHoROXIIzGC0Ux6TAhKaPr1EE3GtTjs+
	 aN9ygVcaIEXKM/5gW0rI36sctXs9ZM40o+11oT7fl2371DkjsrpMO0R+gWACXJS/rf
	 tFO2pe1lTs6Mt3UEVF9ZpTMB3Xl52P17rNVb0+zX03Sup6n/RnzE9h03i+Ny+XGeGv
	 H4teh8jF5dAyTT+Ocmq0S4WRtaWvUuCfkpK6LCtpm6F6BSPP9wOaP1/EN8XA8YjLXi
	 +2+32dgEEV4YKRYjhnCd1M/Bi/X70mJZzNFeTFkRVrWC1Ln71ChZSL1gRKW/Tsn0Lw
	 w+DBMj1pl6Biw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	dhowells@redhat.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	aleksander.lobakin@intel.com,
	tstruk@gigaio.com
Subject: [PATCH] stddef: don't include compiler_types.h in the uAPI header
Date: Wed, 21 May 2025 14:26:44 -0700
Message-ID: <20250521212644.981148-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uAPI stddef header includes compiler_types.h, a non-uAPI
header. There is a hack in scripts/headers_install.sh which
strips includes of compiler.h and compiler_types.h.

But AFAICT there is nothing in stddef.h which would need
the include. The include dates back to when uAPI stddef.h
was first created, back then the including of compiler.h
was the only line in the file. So presumably stddef.h
has been including compiler headers to retain some
chain of dependency? Perhaps someone with more build system
understanding knows what that chain would be, given
kernel doesn't include uAPI stddef.h, and user space
has the compiler headers stripped.

Since nothing needs this include, let's remove it.
Builds pass on x86, arm64, csky, m68k, riscv32.
The direct motivation for the change is that the includes
of compiler.h and co. make it hard to include uAPI headers
from tools/.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dhowells@redhat.com
CC: kees@kernel.org
CC: gustavoars@kernel.org
CC: aleksander.lobakin@intel.com
CC: tstruk@gigaio.com
---
 include/uapi/linux/stddef.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index b87df1b485c2..3da0266643e6 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -2,8 +2,6 @@
 #ifndef _UAPI_LINUX_STDDEF_H
 #define _UAPI_LINUX_STDDEF_H
 
-#include <linux/compiler_types.h>
-
 #ifndef __always_inline
 #define __always_inline inline
 #endif
-- 
2.49.0


