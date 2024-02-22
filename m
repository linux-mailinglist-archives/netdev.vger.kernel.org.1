Return-Path: <netdev+bounces-74192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC386071B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF0DB20CFD
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D86E5E3;
	Thu, 22 Feb 2024 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWYVbtbl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74518629
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708645715; cv=none; b=nU/6hb6elgrtNtUofVb5tzH+H2SZD/EpIm5Xod5Rsfk0i0UuIJ9hb4f9vHtuU0xnsoOR9TAgbgpoxIxcZ5N8EDhODgK5iQjbqreTRO8Vksd8+/ogIIcDgbj1WQ7mQQPH0IXidcRuUk/oJaHm9SB7eCuzEzGNRgTr8+oWK9Vf0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708645715; c=relaxed/simple;
	bh=NBmCZ1M+lXYdDyWSdDp8arxz5JKsUGBq9ciZuCGSZnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQlR75as4MaftPbs8chP/1hKpzKXnEn85ePo+uwpAJqK93nDzAXKtJqjb8H1oMKM57uzbSQcCvNPCJJkXz1EGsUrSAqHa3EfmFkzKFRtwX4i/vaaRn/CbYiDI/JTV7i+9RtQ8UAx0NIn0jCMwqjNe93AgDf66DLnqaABg9L0jsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWYVbtbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8B8C433F1;
	Thu, 22 Feb 2024 23:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708645715;
	bh=NBmCZ1M+lXYdDyWSdDp8arxz5JKsUGBq9ciZuCGSZnw=;
	h=From:To:Cc:Subject:Date:From;
	b=XWYVbtbla6lf5tkbo8d4wRxHcVgSFgYagd5lL04ubgif4RoZ0U+GYXL2/UcLZkS4y
	 n7LzF+T396oRYgYFgd9kk50lc35+dEjrEnl1rSc/lg0IGmPnOEBI4rnlyJA+Thke79
	 wmDXbRGQ5w7BUcaKCMI8e8G9IjBM69WN9ucQZfv0xdGnl4Lkm+18HlotuMldKBzwvd
	 cuJEpHBE494wbocxlMoSqe3oIZOqOjgjQPCeqiyzJy/6AkrKrzfiflablXaZOOHZtY
	 MV7LiiJ+W2VbunvMGuvBkXnhmthjs3+bXOH+RDOjjT5cME/C/SfZJBnEzJG+zOpmoA
	 +W9L0zFBABwwg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	chuck.lever@oracle.com,
	jiri@resnulli.us
Subject: [PATCH net-next] tools: ynl: fix header guards
Date: Thu, 22 Feb 2024 15:48:31 -0800
Message-ID: <20240222234831.179181-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devlink and ethtool have a trailing _ in the header guard. I must have
copy/pasted it into new guards, assuming it's a headers_install artifact.

This fixes build if system headers are old.

Fixes: 8f109e91b852 ("tools: ynl: include dpll and mptcp_pm in C codegen")
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: chuck.lever@oracle.com
CC: jiri@resnulli.us
---
 tools/net/ynl/Makefile.deps | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index e6154a1255f8..7dcec16da509 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -15,9 +15,9 @@ UAPI_PATH:=../../../../include/uapi/
 get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
-CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H_,dpll.h)
+CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
 CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
-CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H_,mptcp_pm.h)
+CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
-- 
2.43.2


