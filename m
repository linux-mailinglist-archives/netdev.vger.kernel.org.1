Return-Path: <netdev+bounces-243929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44780CAB03C
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 02:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F22330640D1
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 01:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CCE1E1C11;
	Sun,  7 Dec 2025 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCm5SjPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6D15CD74
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765071530; cv=none; b=YVqMpNELEFxMDY/f8Ab/Pw+gVgWjIVOg+Gd3TE7DG9U6bxzp+FPHU7elmLPK9QJ+ZlEpTOCLCZodAbEyTJ6gS4i/0+FwB5P224neZcqVfTkCIrRVrwHQLM5Z+vTx6e7iLB0IWf+w4EjFBh32LDqMAqUMQKLkfImp2QNkBc7+VNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765071530; c=relaxed/simple;
	bh=zGZT4re0zhpirQX54/AZCBkrEu7KvU6qZFkWwUzRUMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ehZGvrTklOJGB+wacjAciypR8tzKJ92XnOMmUW1UXylmFvmD/viHPbckVsjmQexIqa99tJhsxP+DV0n2EJeCA5aMw5YI2xJ1lMC8tVBdgW0QAPi0JCFyRTF4aaZSxWFGPasBzWlNzPOta8CkxX738g8qvW4D9X3NKpV3VklcOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCm5SjPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBA1C4CEF5;
	Sun,  7 Dec 2025 01:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765071530;
	bh=zGZT4re0zhpirQX54/AZCBkrEu7KvU6qZFkWwUzRUMQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CCm5SjPOBiKWhrshecNokl/ppHhnlf4aq5dg1x/wAb5Y1TvScQON5hKa9yU+4P4wS
	 K6RkyLjABUxow/vu1O2+XY7DbOIEZUBnxxJgUz5aSkBoDNp8zZsJQfk7h47FphBmoW
	 SorLORa/d5wkgrM/G1NuKnBrpG7HuNGov5yW9yNsjJkU2P+YizmZfmPCYJ1qAyQ01h
	 lpidxd3UCaZ/Z5c6kFpt1o2aYd0N7lqPcPerzT3/Bvp+qK72UHu6dfEEkrptasZ66W
	 N8ieP2MSCVHe9mRJZy/UJLrZFoj5KHtFaI2Hu2kQo2ujsf5Gz/p5JtT7s4wBw6K1kA
	 FfoL8fZXYL4Cg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	Jason@zx2c4.com
Subject: [PATCH net] tools: ynl: fix build on systems with old kernel headers
Date: Sat,  6 Dec 2025 17:38:48 -0800
Message-ID: <20251207013848.1692990-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The wireguard YNL conversion was missing the customary .deps entry.
NIPA doesn't catch this but my CentOS 9 system complains:

 wireguard-user.c:72:10: error: ‘WGALLOWEDIP_A_FLAGS’ undeclared here
 wireguard-user.c:58:67: error: parameter 1 (‘value’) has incomplete type
 58 | const char *wireguard_wgallowedip_flags_str(enum wgallowedip_flag value)
    |                                             ~~~~~~~~~~~~~~~~~~~~~~^~~~~

And similarly does Ubuntu 22.04.

One extra complication here is that we renamed the header guard,
so we need to compat with both old and new guard define.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Found when syncing the "standalone" GitHub repo with ynl which
has a CI building on Ubuntu.

CC: donald.hunter@gmail.com
CC: ast@fiberby.net
CC: Jason@zx2c4.com
---
 tools/net/ynl/Makefile.deps | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 865fd2e8519e..08205f9fc525 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -13,6 +13,7 @@ UAPI_PATH:=../../../../include/uapi/
 # need the explicit -D matching what's in /usr, to avoid multiple definitions.
 
 get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
+get_hdr_inc2=-D$(1) -D$(2) -include $(UAPI_PATH)/linux/$(3)
 
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
@@ -48,3 +49,4 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
+CFLAGS_wireguard:=$(call get_hdr_inc2,_LINUX_WIREGUARD_H,_WG_UAPI_WIREGUARD_H,wireguard.h)
-- 
2.52.0


