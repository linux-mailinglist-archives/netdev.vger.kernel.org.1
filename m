Return-Path: <netdev+bounces-145683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFE79D0623
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65639B214C2
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D5C1DDA0F;
	Sun, 17 Nov 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hyfYgINg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E41DB922
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878469; cv=none; b=H//uWSqV77x7bqloNLttzkPr5qFHiINzPVqfEzNe/qU4Pj5uMV2JJ8Y7cX6PbHg+UWf38D35n0+rlm3V8UMWbFEzGYiF5sokcIRDaSiNjP7MJaJHKi8wy/03fabVGqTPERHs2oQC3Z71PTSYAp8ftvb94VJBo4gLqNqyK0K+Bio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878469; c=relaxed/simple;
	bh=WT6FmnGbDSk8v6PKfqvd2i9Owez8jEmLFiyRScIU8lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzqDVQQks19txJj6mIxOKlTSMfjmGHr64Rxm28SmV92MmywW4YO8LbPCDbU7lYnqtQXvFCK/aS/JihFejWmhxNTuvpIAv+C4MRE7h8qEM5ZfZQbDc/ImxQjlYyj/IjK88T1XxVHy6H4pkVagrQB11pKEljiI55MraGoxp87ZSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hyfYgINg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BD1C4CECD;
	Sun, 17 Nov 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hyfYgINg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731878467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3w0p14T5Nb0EOzt9vcQui+ee0ekU+Ukg5kq9HRCldCs=;
	b=hyfYgINgfSjihqS8NUDIlIYBI+PTUQAJDax3Y7pHJRxnV9fduZkD2Vq3FRIc8zd5/VGYGO
	h/bGvkvcONQEc/J2HWs4llxWrWv8vvioT0QyHI2owhG41mr6eFiGSzhOgFyVFULC+awkm3
	DaWrGZIJtB33tWm3Vzg5dj6878a7foI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 545321e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 17 Nov 2024 21:21:06 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 0/4] wireguard updates and fixes for 6.13
Date: Sun, 17 Nov 2024 22:20:26 +0100
Message-ID: <20241117212030.629159-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub/Paolo,

This tiny series (+3/-2) fixes one bug and has three small improvements.

1) Fix running the netns.sh test suite on systems that haven't yet
inserted the nf_conntrack module.

2) Remove a stray useless function call in a selftest.

3) There's no need to zero out the netdev private data in recent
   kernels.

4) Set the TSO max size to be GSO_MAX_SIZE, so that we aggregate larger
   packets. Daniel reports seeing a 15% improvement in a simple load and
   suggested the speedups would be even better in more complex loads.

Thanks,
Jason

Daniel Borkmann (1):
  wireguard: device: support big tcp GSO

Dheeraj Reddy Jonnalagadda (1):
  wireguard: allowedips: remove redundant selftest call

Hangbin Liu (1):
  wireguard: selftests: load nf_conntrack if not present

Tobias Klauser (1):
  wireguard: device: omit unnecessary memset of netdev private data

 drivers/net/wireguard/device.c              | 3 ++-
 drivers/net/wireguard/selftest/allowedips.c | 1 -
 tools/testing/selftests/wireguard/netns.sh  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.46.0


