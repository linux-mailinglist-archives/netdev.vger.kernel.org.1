Return-Path: <netdev+bounces-117063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E694C8C6
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFAD1C222D7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C48182A0;
	Fri,  9 Aug 2024 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHQc+7Lo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20121805A
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173511; cv=none; b=XJ8bXXKM9SO3GQ0tO2B8aiejHV7e1zvuWPBIsXQo7ceOPzDwabTmkU5mgQM/LDbu3/wW84fNdz/0QpwrfYsb+rJX6eDQuRi9LgY8oOwAcjkdN/Uol+fYl+7h77CkUw5j0/G6w1VhSByc7aSQPiw+/6ju24MmDZKrEptv4SkvbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173511; c=relaxed/simple;
	bh=h7m3rBOCSELPXgRkrDIeZOBFnuVvnQIIL3oW3PCTAiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPH9g2Kl3SjS8qpj8qaj+QViZ2rrObM999X3w6CIFPicpyv1dOhEg/eA6zW/NPeLbkSzKzvHGnmJlXPDzCi+nDPNZC2iD0ti4SitEWtbgC/ZXsSrvRbIt8WUDkEf2+2v5N306oBfHWSrNCp8g2F3u4+Rb+0x2nXdyTvWQ4VE4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHQc+7Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E42C4AF0C;
	Fri,  9 Aug 2024 03:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723173511;
	bh=h7m3rBOCSELPXgRkrDIeZOBFnuVvnQIIL3oW3PCTAiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHQc+7Lol0zb487qGdvFzp3FXXPYSk77Vdub79b6v/004n7HbZHDYbqGy6vKMF1WN
	 hj45wzlkberTPGmNdKn3b33E8Ls/eh8ReFRup/ITy5WG7IG9LXDtlUl3sQl+g9GIRX
	 ytFdEu9P9meXRxAMYPbJqkku+fjO69D2iSZC1jLL2yg9ha6MexO1R8dpdu2LQr1wE8
	 c4MBiuaGIMkQM7OpaPCcR47d9gdF1Qu6UNQ/wvjzDdAha21lCJO+sZq/TqU6Sfv/K/
	 CfL+0LUD/7Vg3lQIvA7SYle+gre13k3j9Uqm10eRoicOlBwFC84iUdgGKtp2nupl5e
	 Hv4QMjGkQsXMg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 01/12] selftests: drv-net: rss_ctx: add identifier to traffic comments
Date: Thu,  8 Aug 2024 20:18:16 -0700
Message-ID: <20240809031827.2373341-2-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809031827.2373341-1-kuba@kernel.org>
References: <20240809031827.2373341-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include the "name" of the context in the comment for traffic
checks. Makes it easier to reason about which context failed
when we loop over 32 contexts (it may matter if we failed in
first vs last, for example).

Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 011508ca604b..1da6b214f4fe 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -90,10 +90,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     ksft_ge(directed, 20000, f"traffic on {name}: " + str(cnts))
     if params.get('noise'):
         ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
-                "traffic on other queues:" + str(cnts))
+                f"traffic on other queues ({name})':" + str(cnts))
     if params.get('empty'):
         ksft_eq(sum(cnts[i] for i in params['empty']), 0,
-                "traffic on inactive queues: " + str(cnts))
+                f"traffic on inactive queues ({name}): " + str(cnts))
 
 
 def test_rss_key_indir(cfg):
-- 
2.46.0


