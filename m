Return-Path: <netdev+bounces-80001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBCB87C6B9
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 01:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E2D1C20BD3
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8F519F;
	Fri, 15 Mar 2024 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo/BF4Hc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CDE7EF
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710462071; cv=none; b=H+apx2pF+oVNUnxWAYYkJokVuNay/N3aNqQuPYesINOx57mbpFwzUPQ1wOB+4SnNzqa1gdTPUZbxjb08wcP3kowjgf9w6CIAAtoTaZPiMmtUE6EEWcYFYFiwQAmsHMheDNNDKKJ/1NwjCf8s9cjz9rllu9FTZLNHHqNM2BYxTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710462071; c=relaxed/simple;
	bh=kgBEUewH3d3HbuCh+EN0IBJ+S9rvHlx8VVNM1p+mvtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YS3ypTDdWc6wlqNZUKyJ/EJW6gIKQWy1h2FtwLnn8GHlA7wBXroxUwziGF57Sa76Bya8j+YnKu9Fp8RFD/t2LIh/FY9ECOHoDF3N/VGeZukn1KyUE/mBSUUNtFcvLb0NP7AtRd5hfx3RzGAKYS1rc1/14E6gYt19vp6JR0RBLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo/BF4Hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8558C433F1;
	Fri, 15 Mar 2024 00:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710462071;
	bh=kgBEUewH3d3HbuCh+EN0IBJ+S9rvHlx8VVNM1p+mvtM=;
	h=From:To:Cc:Subject:Date:From;
	b=Eo/BF4HcT9cC2PKrIGHDMzeugMkDLd+0GoLUXxn3xQXc/jD2iwE0fiZ25p2f7cWid
	 etjmhvHHTzaPDMv2taQbp5w+zRLEkd+fn27JLgGIZIgGhUzN6hbxUne6og/BysWzmY
	 NDdQQc3jOn//T6Ek+FXW9bcW6fmDFkww3aeaCZ2GFAncJ9ASoxWY6ZwJkAT1+M9odf
	 semgBReLh/svPgwsbbERpHAZnNHcI1VWj5oLb9sZxiKLQx7SejJZQrLXj5KLy2umRd
	 UEVUr23SUVTfydL2/rnQf2ThWnV46jtwMd6X+DdtDZHoHk0e8dg/O6Y7AiGX6Uz8M5
	 IPlJUUMK+DBsA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	chuck.lever@oracle.com,
	donald.hunter@gmail.com
Subject: [PATCH net] tools: ynl: add header guards for nlctrl
Date: Thu, 14 Mar 2024 17:21:08 -0700
Message-ID: <20240315002108.523232-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I "extracted" YNL C into a GitHub repo to make it easier
to use in other projects: https://github.com/linux-netdev/ynl-c

GitHub actions use Ubuntu by default, and the kernel headers
there are missing f329a0ebeaba ("genetlink: correct uAPI defines").
Add the direct include workaround for nlctrl.

Fixes: 768e044a5fd4 ("doc/netlink/specs: Add spec for nlctrl netlink family")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
The Fixes tag is a bit unfair here, we never promised very
old headers will work. At the same time Ubuntu may be fairly
popular so seems worth making it work.
---
CC: jiri@resnulli.us
CC: chuck.lever@oracle.com
CC: donald.hunter@gmail.com
---
 tools/net/ynl/Makefile.deps | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 07373c5a7afe..f4e8eb79c1b8 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -20,6 +20,7 @@ CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
 CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
+CFLAGS_nlctrl:=$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
-- 
2.44.0


