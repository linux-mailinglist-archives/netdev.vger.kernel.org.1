Return-Path: <netdev+bounces-109275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF9C927A61
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE9CB25ED4
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E481AEFC1;
	Thu,  4 Jul 2024 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e6CXiCTo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073DC1AE859
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107939; cv=none; b=jf94NKUJEWt0pIaguiaoEPLLUIKZ/RGOULynrbUkQsigA/T1/0RZIVdeCZOadw80p4iTngQjGAKky3Ww1cxjXOoamX43U6tNPYMgumzSlr1hJcv6oHxkarX4bFJjXij8lNm0sdVzZ04G0/+2ik7cBkO4npvNNlBMcPuVee9EhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107939; c=relaxed/simple;
	bh=SKvgIZ/CAOXY5fzsivTdlOTSbZ3oKERkYQlfow/gKow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9sbSb10tqWj3EDIh30UHjIq1nhwAZNZpp/3ADWPkxzamcEjPVixLRDJlod9+K4bSGjJdSnUrRVyyuKt0g7xxUHi5fpIYVhPcA3EFW/NTUmOdnGVYgGSmmomNM6d3Ra3Y6VQkzfyAHnjlHJLn/GmaFxV4b6G4l7TIz8krPx6USE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=e6CXiCTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A40C3277B;
	Thu,  4 Jul 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e6CXiCTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720107936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aPFMfE4OGm4v62X6y9GlVSqmaZSNxzmGzC3TpiuG4W0=;
	b=e6CXiCToO8tF4czUZB0uyBDVvfQ7L6i6xUTFXRzBuaCH2KhrgfM9RIA80wx0BSl7jPqIVr
	XmKB3Yh+ew3P2oEJW2jrrRpXqKMWoHj0vh6zZdxt/9owR1b/LOLDBeCxKRVRHtzvsNvu6E
	Mw1f9NIOf0qgtycomtrMALkSCzYZMaQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e1ea642a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jul 2024 15:45:35 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 0/4] wireguard fixes for 6.10-rc7
Date: Thu,  4 Jul 2024 17:45:13 +0200
Message-ID: <20240704154517.1572127-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

These are four small fixes for WireGuard, which are all marked for
stable:

1) A QEMU command line fix to remove deprecated flags.

2) Use of proper unaligned helpers to avoid unaligned memory access on
   some systems, from Helge.

3) Two patches to annotate intentional data races, so KCSAN and syzbot
   don't get upset.

Thanks,
Jason

Helge Deller (1):
  wireguard: allowedips: avoid unaligned 64-bit memory accesses

Jason A. Donenfeld (3):
  wireguard: selftests: use acpi=off instead of -no-acpi for recent QEMU
  wireguard: queueing: annotate intentional data race in cpu round robin
  wireguard: send: annotate intentional data race in checking empty
    queue

 drivers/net/wireguard/allowedips.c              | 4 ++--
 drivers/net/wireguard/queueing.h                | 4 ++--
 drivers/net/wireguard/send.c                    | 2 +-
 tools/testing/selftests/wireguard/qemu/Makefile | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.45.2


