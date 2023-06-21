Return-Path: <netdev+bounces-12861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE57392F5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 01:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F47A1C20B9C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8D1D2D6;
	Wed, 21 Jun 2023 23:17:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C291B903
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F432C433C0;
	Wed, 21 Jun 2023 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687389444;
	bh=pbFuaB9e+g57Z5+rNxZQ1jYyiUVAe3F6aTWXMR4Q5Po=;
	h=From:To:Cc:Subject:Date:From;
	b=OWYtas+wMVUFepGmLgI/KV2u4/35eQgmP09wvRp5S0KvLG3M3KLdMe60QNF4BULVW
	 t52YVwNr82YmAx1nCoFeO77FkNUk+Giu+qrZjrZCtLgI+U0idC+79tIBbv0hUaIy9i
	 c0dYa+bMSJf30VqptaCphSKjD7NkQTEPNJsob2R9CqGMmHAruZQj2f2YkQS0atTjit
	 zrbnu1AUrbStvNSVOdo/ETh72t/Mom+YcYMbS8fu85s5CtuiQ+aiXp35Mb1I29hgkx
	 qVKCKoK5TpeKy6WX3TSZmPK1gJqCUThim520zfDJe/NK5gt0J63vFgo7yg7EgxOtYE
	 V8daJ3HpDg++A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2] tools: ynl: improve the direct-include header guard logic
Date: Wed, 21 Jun 2023 16:17:19 -0700
Message-Id: <20230621231719.2728928-1-kuba@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Przemek suggests that I shouldn't accuse GCC of witchcraft,
there is a simpler explanation for why we need manual define.

scripts/headers_install.sh modifies the guard, removing _UAPI.
That's why including a kernel header from the tree and from
/usr leads to duplicate definitions.

This also solves the mystery of why I needed to include
the header conditionally. I had the wrong guards for most
cases but ethtool.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - drop the HASH variable, too
v1: https://lore.kernel.org/all/20230616031252.2306420-1-kuba@kernel.org/
---
 tools/net/ynl/Makefile.deps | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 524fc4bb586b..f842bc66b967 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -9,20 +9,12 @@
 
 UAPI_PATH:=../../../../include/uapi/
 
-# If the header does not exist at all in the system path - let the
-# compiler fall back to the kernel header via -Idirafter.
-# GCC seems to ignore header guard if the header is different, so we need
-# to specify the -D$(hdr_guard).
-# And we need to define HASH indirectly because GNU Make 4.2 wants it escaped
-# and Gnu Make 4.4 wants it without escaping.
+# scripts/headers_install.sh strips "_UAPI" from header guards so we
+# need the explicit -D matching what's in /usr, to avoid multiple definitions.
 
-HASH := \#
+get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 
-get_hdr_inc=$(if $(shell echo "$(HASH)include <linux/$(2)>" | \
-			 cpp >>/dev/null 2>/dev/null && echo yes),\
-		-D$(1) -include $(UAPI_PATH)/linux/$(2))
-
-CFLAGS_devlink:=$(call get_hdr_inc,_UAPI_LINUX_DEVLINK_H_,devlink.h)
+CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
-CFLAGS_handshake:=$(call get_hdr_inc,_UAPI_LINUX_HANDSHAKE_H,handshake.h)
-CFLAGS_netdev:=$(call get_hdr_inc,_UAPI_LINUX_NETDEV_H,netdev.h)
+CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
+CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
-- 
2.40.1


