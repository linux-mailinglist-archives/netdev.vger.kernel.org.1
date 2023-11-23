Return-Path: <netdev+bounces-50352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D563D7F56B8
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 04:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64999B20E29
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233455246;
	Thu, 23 Nov 2023 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxy/3scM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AB5669
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D598C433C8;
	Thu, 23 Nov 2023 03:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700708786;
	bh=3/SLvsJt/Kzp1MWsCQ+VkUWEVIlL8U1xctiu1VPapxc=;
	h=From:To:Cc:Subject:Date:From;
	b=Dxy/3scMOuWLIcZVLdRWVFsEB1Z0n1wB7HYru5xPJwRcId4gvgdvSx+t0xC5S/j4x
	 OseIVm+jHufIP0B0Ww8NTK1qwIgYDrEVmgntRzfG8nkFsCMBNhAXV1jsGZfaSlPHsF
	 Vu6EnJYR4m0WjTeXDjqWpZdTgXcqTf0AeM0yvSv5MYV0xWs5vJXVDe4k83tuo8VEYf
	 bAGF11H0nHjr200FIS5jX/NsC9C4UAcrCbIEih2Kz1qUPOQGy7dwXTTA8Z7mnjhXoJ
	 XlyTPOeS4VniVS57hq1pUxla5isARqwaeeiljU04w7REPyPJE6yQOH8uKPIXYkAr9a
	 l8f1chN/8pQ/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	chuck.lever@oracle.com
Subject: [PATCH net] tools: ynl: fix header path for nfsd
Date: Wed, 22 Nov 2023 19:06:24 -0800
Message-ID: <20231123030624.1611925-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The makefile dependency is trying to include the wrong header:

<command-line>: fatal error: ../../../../include/uapi//linux/nfsd.h: No such file or directory

The guard also looks wrong.

Fixes: f14122b2c2ac ("tools: ynl: Add source files for nfsd netlink protocol")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: chuck.lever@oracle.com
---
 tools/net/ynl/Makefile.deps | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 64d139400db1..3110f84dd029 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -18,4 +18,4 @@ CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
-CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_H,nfsd.h)
+CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
-- 
2.42.0


