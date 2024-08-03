Return-Path: <netdev+bounces-115468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692EA94675F
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BC9B2161B
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C15A76036;
	Sat,  3 Aug 2024 04:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fevkNsFF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5474424
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659211; cv=none; b=rVmjYhtjioTBed5GPnjv28xEjzqg15B6ipjvgBjrmcRntHqJDTduv6dQDVjujNIHFqtLRdAF5KPAKBsM94uvZfUqhJiMae0qTjm8pOfZybRnmz1tQPAFm+ZUp2XbNSXdIKJIwWIFm4WmJEmajDg5WZmumOe2ypADY2qH68/fgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659211; c=relaxed/simple;
	bh=yW/rh9EuW5h71pnWQMOaVRRwb6aC5AWoliMKy2fI8pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atSE9u8GJY6qvpI4zIFw7S85s5Hk7wvING71d/FFEbVJPY7alL2045hV1EBM7k5MMVQCLjxfJ1OfLvEJmtvtsGTrB/mVBtA1w4wv6AwSztVRXvgefjYGpFAm5tiFFFo+jxqzZMcZ2iYPzJE7X+WNQVVBeK2KDDiIOxzX/IYh1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fevkNsFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389B4C4AF0C;
	Sat,  3 Aug 2024 04:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659210;
	bh=yW/rh9EuW5h71pnWQMOaVRRwb6aC5AWoliMKy2fI8pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fevkNsFFJOB3Lbs6afLXO1Wnd62CL9kslCq1erIqAvnbXB//kxN87no+KeW/Ptp2T
	 DBTmtiO9d/HKxwANioOUdT8yOSsrLIxaK1byazftJ4gWNQyi1BK0p5r9Q+koLxQH95
	 QQL+etkE+0eG4zSAC9HNfYsMIWpHPWuPjG+/HncoPiBU3HzRNSzWgt0RPn1iFh7xKr
	 YFTFu2z6W41yjytfJpiRbRf5AFLpp6ERl1LgO37TGJHj+t5zAaI3kw9P30dF9RNwCI
	 BNQPam6TavlSPs0qz22sHo5/PawQE4FLRKk6Hjy0YtYHnojY330BKccA4Gj4/EfwDk
	 48N29u8TB4rFg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 01/12] selftests: drv-net: rss_ctx: add identifier to traffic comments
Date: Fri,  2 Aug 2024 21:26:13 -0700
Message-ID: <20240803042624.970352-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
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
2.45.2


