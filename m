Return-Path: <netdev+bounces-75120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A624868419
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 23:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43344282178
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D15A1350CF;
	Mon, 26 Feb 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em/lZyZP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C71E878
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988295; cv=none; b=ZFPM7+R6bCqhIZzccGKDOiyOCStF8Yqxdp5D1BU294NOubux94Kv/VbLaDIkE1b/8PdrR4xm78bebQDgEcTvUO821+3M0i2bkWMliFz4hknd/xusPz2pRKE6S3hQx2L0fPSFCm2IMoTHrIsUPPGtEIgOTcfxGPkOwFISLGYVHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988295; c=relaxed/simple;
	bh=k2sGkS9JPLzUg8YsQYsM6SmvSUEI6/EqGZcoIPL8DGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sparFURLVDiGf3hZ7vleox7rKGq2oW8NpQX6h9W2fUmL/8ccObNqWFuS8dKSbm8PAdHlIOUu8scnTiGydb7z80C/ZdHMIZOA0KtDJii0GlQ80WdKoKDaVbfm21ozp3aTyP/a+4/CV5sy6btIejmIcn9MKcv9iGVidOq2DggPfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em/lZyZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A08C433F1;
	Mon, 26 Feb 2024 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708988294;
	bh=k2sGkS9JPLzUg8YsQYsM6SmvSUEI6/EqGZcoIPL8DGE=;
	h=From:To:Cc:Subject:Date:From;
	b=Em/lZyZPNjbJVAsU84JduEkmMrUHhOyZZyALZ0Kb3RHZS2fx5i2cwui5/bJVjc1Ce
	 YxiDIfEPF0P3f/IB4iKjyN3AzkRfF6H3nVDtJxIGxlnlDAVdvr5RJHv+bSSXfAnhl4
	 YKDkbXxa/22A8y1dHlq0rnpOig8V5T43/NXsTpObWjsgp1Xt/oq3K5YoP86TXWL6ve
	 jQD0jQaTzZXX02/a6a7fGVxycvDG3pj6TiRNBJQXtKC+vRwlzIJLKBGRC+SF1NYKIw
	 YW7zpM6FOh9Deom1DKZqxKnLM+InhsM+vvxDVeuXYQmb1L2fDzb9ahm37CO4RB/rmG
	 sfxPBbLG9R6Rg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tools: ynl: protect from old OvS headers
Date: Mon, 26 Feb 2024 14:58:06 -0800
Message-ID: <20240226225806.1301152-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 7c59c9c8f202 ("tools: ynl: generate code for ovs families")
we need relatively recent OvS headers to get YNL to compile.
Add the direct include workaround to fix compilation on less
up-to-date OSes like CentOS 9.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/Makefile.deps | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 7dcec16da509..07373c5a7afe 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -21,3 +21,6 @@ CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
 CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
+CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
+CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
+CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
-- 
2.43.2


