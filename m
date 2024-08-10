Return-Path: <netdev+bounces-117368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F794DAEC
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790B91C20F47
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A53FBA7;
	Sat, 10 Aug 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1ptB/7V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E73C488
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268484; cv=none; b=tVNU1BEnDV5anHHXBCW05jDHl9R4bkp8LGw9o1SAw9dvjhtXbxhAm31xLQ7AvVB9k5TZ/AF1/p+cBkSGBJQE+m15PgRpbGy4+VYWTFNi5yFrgMKl3ckFpVk68+VjgRfD9z/JqF+OWXcXp9q/S0nxJcf5JB2Phgz4Q7SH71Xy4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268484; c=relaxed/simple;
	bh=h7m3rBOCSELPXgRkrDIeZOBFnuVvnQIIL3oW3PCTAiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjJoMhcJuJip5hL/NsG+7HKaGxQ+WWW0+ezpg5Ucy1cVbU+KK8mNM+Wf+dy95Hga+/nVe0hyTFA3svDDl83p5qUiTFuG13mdJQF9i6X4hkM9wVG+iRRMHSxwEHul1Kg6n7HIsZtdMa2UVY0bcu9PbaWnuBBI4qFyntsgh7hLKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1ptB/7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F327C4AF0F;
	Sat, 10 Aug 2024 05:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268484;
	bh=h7m3rBOCSELPXgRkrDIeZOBFnuVvnQIIL3oW3PCTAiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1ptB/7VhoZmxaSYJNOtnrC0R8PL6Vhh8DOrr7tTtPl3FgIyJADCYmI8UUOVSTUxR
	 KhhqN+hD8zpI9h4KxlZgDAy1EpMJR23Pb89FUw3H1VU9ZXLGYrXmSiFurhw+53prsN
	 gshE1P40ctav3tzbLly70ZxPYG9pXhT+T2XVGMWmuFeqYVKk8FxIJD7YKenlecjjZm
	 1fJiMjBy90TWIfKkFqvO7aVbxjXgWtyaEy5wNnIZNDVCusbsmHHhWoSRDcEJMqf/SR
	 X/hbL14VyRSzFAs67ZYQtTxzVylSFrFldMfhK9jlxZOvYsPcYnc3VqygQfbE4xwzSF
	 d7Mxe680DQS/w==
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
Subject: [PATCH net-next v5 01/12] selftests: drv-net: rss_ctx: add identifier to traffic comments
Date: Fri,  9 Aug 2024 22:37:17 -0700
Message-ID: <20240810053728.2757709-2-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810053728.2757709-1-kuba@kernel.org>
References: <20240810053728.2757709-1-kuba@kernel.org>
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


