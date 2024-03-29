Return-Path: <netdev+bounces-83413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63517892313
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C911C21355
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A91384A3;
	Fri, 29 Mar 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkx3m0qC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082E13792C
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735056; cv=none; b=kIj8qhWgGHwQHzewTY6Jc1/VSBSo/VwNIR7PgiXtASimtFeum1LxnOxem4GSIyiCG1As+6RrTuf0MENfEQJqtA4cHwtSjYHuXqRlk7OtZw5QOi8YKG99X6wzcrb5oU8FcMngwEYQNs/cP40N7pLAymEFqxeRROor1vfxYeghCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735056; c=relaxed/simple;
	bh=QqQarZgY15uMZOOjoxFPSgU1BYh2Tq32Aw0DEWAre6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfKGMrkdwdrlaCxfTdQcMHS7LOKM2zFMwlf30KyJSQDsBtrRYc2CyK1J3SrsYFGgdgtt0ohyFvcJBmxHjpJc9Uu/dxigXsAnEPEWWzrYLEwWrfjsnIfi+0l+2aH71pxffmlZbb10sCvdPmDzEuVdAHFZ4hg5P9Wj8dOlYzA49qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkx3m0qC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF694C43390;
	Fri, 29 Mar 2024 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711735056;
	bh=QqQarZgY15uMZOOjoxFPSgU1BYh2Tq32Aw0DEWAre6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkx3m0qCvRrMi2IaCq6x5vh/msPd3KhGahENNolxnhAbFBE541s4qdJUH7+EZCmKS
	 9UB1JkVPJETusjCXjBL3ysaGZ4ALcjK1t1jtSYDN1Ih//B70MrV0Ghe02PcMh6ZsNC
	 AVeUI5CP2DecJz63ql5WVtGua7m7WnsEXfaENTlmk58l2RLe6XLL+RD4iNdq7hsZJs
	 lKfyFTpgWFVd1opKSe0z0DM07/GTEqAUZIIiEGj1p34s9Z67JzQGuJksTCq1MiVeG3
	 lU68OHb29jucHeWvERD8YQ4Zl1BLZrmFhrq1xBqfX4x8SupfxWxNjf6wxjiTgsjZoM
	 aKSo+cO+JiZsA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	jiri@resnulli.us,
	andriy.shevchenko@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	pshelar@ovn.org,
	dev@openvswitch.org
Subject: [PATCH net-next v3 2/3] net: openvswitch: remove unnecessary linux/genetlink.h include
Date: Fri, 29 Mar 2024 10:57:09 -0700
Message-ID: <20240329175710.291749-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329175710.291749-1-kuba@kernel.org>
References: <20240329175710.291749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only legit reason I could think of for net/genetlink.h
and linux/genetlink.h to be separate would be if one was
included by other headers and we wanted to keep it lightweight.
That is not the case, net/openvswitch/meter.h includes
linux/genetlink.h but for no apparent reason (for struct genl_family
perhaps? it's not necessary, types of externs do not need
to be known).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: pshelar@ovn.org
CC: dev@openvswitch.org
---
 net/openvswitch/meter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/openvswitch/meter.h b/net/openvswitch/meter.h
index ed11cd12b512..8bbf983cd244 100644
--- a/net/openvswitch/meter.h
+++ b/net/openvswitch/meter.h
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/netlink.h>
 #include <linux/openvswitch.h>
-#include <linux/genetlink.h>
 #include <linux/skbuff.h>
 #include <linux/bits.h>
 
-- 
2.44.0


