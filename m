Return-Path: <netdev+bounces-138874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5195F9AF478
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C691C2188B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6FE218D73;
	Thu, 24 Oct 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF5NObvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE8218D6B;
	Thu, 24 Oct 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804288; cv=none; b=pY3CW80W/CFVFoki58eZF77x/8uW0/A+VTWhrV1tq80DiwWR636d8QbcmddrENGPjTlIijsHY19oHLrnnMYg0dvPrPH3X0HJhT/Nc4VD3qU1mlZaLUanW//egbEiyjZlDvwGs9uujszVRhmY2676fgJTYAfOxPaKnpSPbpR2zYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804288; c=relaxed/simple;
	bh=qQQ2lofL8ErXlVJyVkxMF6DjGz27PDYgLr96a3mHVqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkeBkPOQJN9LgpsrRHZ8D9/1oM/jBiNFlRsxf3KIJA7/+LOxS6tsSmMCOCeY5VpP5Dc2MM47/qtSOmUrh2cMuLXvIocpgojNIkAGceLcjYH4MBzbJ4enEWQzDbhY3E/wpAyHIkXJvQOVgUEAkVmdB+DgDirPOFIo2ZiVOJB8dZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF5NObvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CEBC4CEC7;
	Thu, 24 Oct 2024 21:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729804287;
	bh=qQQ2lofL8ErXlVJyVkxMF6DjGz27PDYgLr96a3mHVqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eF5NObvb9HPWXTjcRLoFpLFIt5A+QC7aR2J38Fv2syMcG37GGMnuMeESXCA38OzZD
	 dmd5zKmxAdCSrFnEZTg/h606f8Z1npc3j4ge5zegnJk+mJ3K7RCXu9R5DVjPWUyVbV
	 oY9S2jBZONtEysjgFimkout5CZsoynsjcPypKI9xWlHdeUwO5eHZZK/7keahDamOst
	 IQdWAo9VeIDeMeqMZa/HpfGcswefDUdZ3uwMnyNgULOscgKZsXOH9V+VRH9pRhHS4C
	 7qMrc1ImxYvaCGmvUch5EEQbDfHuaQXc1P4prvfTbpblNGJSAQz4UPPMZt7xf8feF1
	 162hsDKT79PvA==
Date: Thu, 24 Oct 2024 15:11:24 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 1/4][next] uapi: socket: Introduce struct sockaddr_legacy
Message-ID: <23bd38a4bf024d4a92a8a634ddf4d5689cd3a67e.1729802213.git.gustavoars@kernel.org>
References: <cover.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729802213.git.gustavoars@kernel.org>

We are currently working on enabling the -Wflex-array-member-not-at-end
compiler option. This option has helped us detect several objects of
the type `struct sockaddr` that appear in the middle of composite
structures like `struct rtentry`, `struct compat_rtentry`, and others:

include/uapi/linux/wireless.h:751:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:776:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:833:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:857:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:864:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/route.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/route.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/route.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

In order to fix the warnings above, we introduce `struct sockaddr_legacy`.
The intention is to use it to replace the type of several struct members
in the middle of composite structures, currently of type `struct sockaddr`.

These middle struct members are currently causing thousands of warnings
because `struct sockaddr` contains a flexible-array member, introduced
by commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible array in
struct sockaddr").

The new `struct sockaddr_legacy` doesn't include a flexible-array
member, making it suitable for use as the type of middle members
in composite structs that don't really require the flexible-array
member in `struct sockaddr`, thus avoiding -Wflex-array-member-not-at-end
warnings.

As this new struct will live in UAPI, to avoid breaking user-space code
that expects `struct sockaddr`, the `__kernel_sockaddr_legacy` macro is
introduced. This macro allows us to use either `struct sockaddr` or
`struct sockaddr_legacy` depending on the context in which the code is
used: kernel-space or user-space.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/socket.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..2e179706bec4 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -35,4 +35,32 @@ struct __kernel_sockaddr_storage {
 #define SOCK_TXREHASH_DISABLED	0
 #define SOCK_TXREHASH_ENABLED	1
 
+typedef __kernel_sa_family_t    sa_family_t;
+
+/*
+ * This is the legacy form of `struct sockaddr`. The original `struct sockaddr`
+ * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible
+ * array in struct sockaddr") due to the fact that "One of the worst offenders
+ * of "fake flexible arrays" is struct sockaddr". This means that the original
+ * `char sa_data[14]` behaved as a flexible array at runtime, so a proper
+ * flexible-array member was introduced.
+ *
+ * This caused several flexible-array-in-the-middle issues:
+ * https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wflex-array-member-not-at-end
+ *
+ * `struct sockaddr_legacy` replaces `struct sockaddr` in all instances where
+ * objects of this type do not appear at the end of composite structures.
+ */
+struct sockaddr_legacy {
+        sa_family_t     sa_family;      /* address family, AF_xxx       */
+        char            sa_data[14];    /* 14 bytes of protocol address */
+};
+
+#ifdef __KERNEL__
+#	define __kernel_sockaddr_legacy		sockaddr_legacy
+#else
+#	define __kernel_sockaddr_legacy		sockaddr
+#endif
+
+
 #endif /* _UAPI_LINUX_SOCKET_H */
-- 
2.34.1


