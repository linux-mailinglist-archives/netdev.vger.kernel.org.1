Return-Path: <netdev+bounces-163166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C4EA29796
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D807A1E0A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3532C1FBEB0;
	Wed,  5 Feb 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRixJsZj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061F2144C2
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776836; cv=none; b=LDdwt//kYtcxshDvBsRlCfT1lBIo9CzzmaHFK7HRHiOYX0g3JljkDsTyptLEt3oityC+OZ1CEJthYCEcJQNwOL7GmFFlszExmpRAGZ6NiedQ07RXQtZCjnOD6BMOwqvtXCfmU/1Brx9Ne5S09CBB9VvlsXDJwlDVNHu3JoksVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776836; c=relaxed/simple;
	bh=IfpJK02M8PpCBmiyDNrmerCDEHgKQW0BtTgUNmg/iYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOsQCyYfOHQstTFzvHk8ekBtscxtH+n9SEgBDWiOxG3UOYqhtRsbVKpF50tKPncE1W5Z2WobuFcEgxp3BSXeWpRtYNvra70QAtDJOubkWk3at535iNZM9N63izsMGe8NzTWjiUPDC7NjIb4RvXrBkVx066FMJBhs/+UkabGj2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRixJsZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29426C2BCC7;
	Wed,  5 Feb 2025 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738776834;
	bh=IfpJK02M8PpCBmiyDNrmerCDEHgKQW0BtTgUNmg/iYI=;
	h=From:To:Cc:Subject:Date:From;
	b=gRixJsZjrqkd5mAd3cCNz5L7RbpIqIOyLv/X+XMxCbxeiUmDq0KUp7D7f2apXHds/
	 28A+iDSA60D9WQZqj1CHd4BTiSYzlPztMcmxBr/WzLdeHQDPaaX9MbaoQ9BOfaQG56
	 Ni4JtWmoic2+0gEc+vJ3voeHzaNBoSecI5LdbcrRtZCNr87YOKtWpKqVdkyJk7cNy+
	 2nfCEa0xadrXCIWdOmO2Ho7kfnPt2a8GP7L1pVKucAC8jXyRzHNsnJUlRTafdgk6ck
	 SMoBul3+hW7+rWNGKWkaAVxC11STbySKWrY6uWCCnCIQ43Jh/6dGE/fpOOb9oGS+98
	 WT5ZBCZCDvHKg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	danieller@nvidia.com,
	sdf@fomichev.me
Subject: [PATCH net-next] tools: ynl: add all headers to makefile deps
Date: Wed,  5 Feb 2025 09:33:52 -0800
Message-ID: <20250205173352.446704-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile.deps lists uAPI headers to make the build work when
system headers are older than in-tree headers. The problem doesn't
occur for new headers, because system headers are not there at all.
But out-of-tree YNL clone on GH also uses this header to identify
header dependencies, and one day the system headers will exist,
and will get out of date. So let's add the headers we missed.

I don't think this is a fix, but FWIW the commits which added
the missing headers are:

commit 04e65df94b31 ("netlink: spec: add shaper YAML spec")
commit 49922401c219 ("ethtool: separate definitions that are gonna be generated")

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: danieller@nvidia.com
CC: sdf@fomichev.me
---
 tools/net/ynl/Makefile.deps | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 0712b5e82eb7..d027a07c1e2c 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -17,9 +17,11 @@ get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
 CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
-		$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
+	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \
+	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_netlink_generated.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
 CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
+CFLAGS_net_shaper:=$(call get_hdr_inc,_LINUX_NET_SHAPER_H,net_shaper.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
 CFLAGS_nlctrl:=$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
-- 
2.48.1


