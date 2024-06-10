Return-Path: <netdev+bounces-102393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1744902C4D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A043C281C2D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719C815217F;
	Mon, 10 Jun 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wK7AYb5s"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBF1514DE
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061033; cv=none; b=WQLxFqIypdo7RIipcocK1jb/iDbnvbKiXCmQgL0RseBkgnApjE0h6THtr3p9UySJECmUkW9ZoonN33AeAE9EHDU0IJmZesGHgZ5Zw4ipApaJOJv7ElFQ1D6es4EOeA3uVHtQvmzPOK2BFqNay6mwfR33xnTnv1l7TK/bOwnoRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061033; c=relaxed/simple;
	bh=Hqo2lJ+wvCjfGXotn9bKfuEGO6SE4V/OkBviYTEcT44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZfYmpT4g2QfsfOJllZjU041nM+1dPcnud+9HtTSEfVhoewc8gJMBF7vNFVH04LJGjrllSZb8T02eeronY4CMN+huuci98IBboJUJuNMOlEHqbfVrlqRudNl0WdHJ1F3Pyd5kS7QmC1CgCXGSqQt/ZcNcQGUKVfZo5AFotqzJeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wK7AYb5s; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718061029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDA59kZrpAKz7084CN5HZMkmVitgKCZsjBBJnQ6cgj8=;
	b=wK7AYb5srn+BvhVJWYZhr8hTCWe3vVWq74rQqoFySP/cYlCN4f0qC6yBS0J1klT+Hli3uV
	uJub072MBWc0IZyDo/0Kx24/hxdW6lja6SaaZCTUHGJstbK+UawMY0E44Yx/v/++8Cpnxb
	mFtfwBDa3f9rL9pQkudw07cPj087Wjk=
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 0/3] net: xilinx: axienet: Add statistics support
Date: Mon, 10 Jun 2024 19:10:19 -0400
Message-Id: <20240610231022.2460953-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for hardware statistics counters (if they are enabled) in
the AXI Ethernet driver. Unfortunately, the implementation is
complicated a bit since the hardware might only support 32-bit counters.
In the future, we could add a simpler alternate implementation for
64-bit counters enabled with a device-tree property, but for now I've
gone with a unified implementation.


Sean Anderson (3):
  net: xilinx: axienet: Use NL_SET_ERR_MSG instead of netdev_err
  net: xilinx: axienet: Report RxRject as rx_dropped
  net: xilinx: axienet: Add statistics support

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  81 ++++++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 275 +++++++++++++++++-
 2 files changed, 349 insertions(+), 7 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


