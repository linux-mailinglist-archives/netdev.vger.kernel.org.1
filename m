Return-Path: <netdev+bounces-178947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6942A799BB
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63BD3AC8C0
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95281448E3;
	Thu,  3 Apr 2025 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoRm6Fpf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D8142624
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644052; cv=none; b=l176f0NCpRcfwHBRUouId294WAolxcokY+Anw4NI9dauQpRQuCUJ1GaB5hez+7i0vjobzxMEHTk+pn2tNv/815d9L2U/uO6dlVi+cMXErQRRTKcyd4QO+XeJOMF5H+OWbee/sVMe4ZCZS+cKYkrmIBuMPO81yPtaoGDMuEohrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644052; c=relaxed/simple;
	bh=iq6Bdq7BMi4z9XE7UTw95bE2toDbAzIBrC5SjLKkXaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sr6B84e+EvBUz4D14zAxxNw1bxFHJ3oWHFguChmumJ2VI64nJUUeeQuV141ZcaiAmmmL1ihdEa88oOefFsgZW2UKsMhdAbfb8Re/nEjDsU+oULeYR3UO516oUjbZ9IiXgrOpcy7MBnbYCWZgoI6Hme2JX7tA3TI8Dv6hBCduJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoRm6Fpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95538C4CEDD;
	Thu,  3 Apr 2025 01:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743644051;
	bh=iq6Bdq7BMi4z9XE7UTw95bE2toDbAzIBrC5SjLKkXaM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZoRm6FpfBQLcWVi/e9mE+F3dNVpnAVH/UvitvPDdnfqG+Yz8ML1AfXf335pvgQEHk
	 meRBkSW3GYSohKgsCdxtBSi8efDIXlzKzCc25qBAe7y4zLlq2cbb8lexwKHVF3LPVP
	 0hEZ4Yfq8KZqiqQklyJHb5Nk3U+ubRpAGmrnWray0R8aRwZyR03gI4Hf22Lfoyz0bW
	 ySUW38IHftFpVqO9LebHEtFZvUbjOQTfkrK3qkT87xDEBmuqM/2+OcNrsjik5NIVMg
	 W90MjfA0tmf+SiNmMi/kzbid33AC+eRElCS9sQDXj1gHVokEMMz7lWbUDntKbhGQzU
	 c4OQEP4RmZ3lQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ap420073@gmail.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 0/2] net: make memory provider install / close paths more common
Date: Wed,  2 Apr 2025 18:34:03 -0700
Message-ID: <20250403013405.2827250-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We seem to be fixing bugs in config path for devmem which also exist
in the io_uring ZC path. Let's try to make the two paths more common,
otherwise this is bound to keep happening.

Found by code inspection and compile tested only.

v2:
 - [patch 1] add to commit msg
 - [patch 1] fix arg naming in the header
 - [patch 2] don't split the registration check, it may cause a race
   if we just bail on the registration state and not on the MP being
   present, as we drop and re-take the instance lock after setting
   reg_state
v1: https://lore.kernel.org/20250331194201.2026422-1-kuba@kernel.org

Jakub Kicinski (2):
  net: move mp dev config validation to __net_mp_open_rxq()
  net: avoid false positive warnings in __net_mp_close_rxq()

 include/net/page_pool/memory_provider.h |  6 +++
 net/core/devmem.c                       | 64 +++++++------------------
 net/core/netdev-genl.c                  |  6 ---
 net/core/netdev_rx_queue.c              | 53 +++++++++++++++-----
 4 files changed, 63 insertions(+), 66 deletions(-)

-- 
2.49.0


