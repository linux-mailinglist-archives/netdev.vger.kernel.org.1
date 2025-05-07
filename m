Return-Path: <netdev+bounces-188509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8AFAAD24F
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AB14A7880
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BBC15E8B;
	Wed,  7 May 2025 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1+hPZgw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B042056;
	Wed,  7 May 2025 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577946; cv=none; b=I3mtS18MNEjeSvUS0FL/3qBon8XIUHstGvOvru0l4FXnVmFgJpG3nhL9mM+zNWdpkUouJd9nyzyosHuMO6t2hfBKzn9ySHUNFvlzdo8zFQXbb6XwgE3oqgK2zCEcYFQZZRM+3ZDytAIzeJ6n2z0d8s9r8cdxaDw874OMol5fo3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577946; c=relaxed/simple;
	bh=7Z7HFia5inGYREF861yG/kIZqHxHikGnB87XGqV+y9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtCc0HXBkHCDH7BkKc49sIbROm/JyRr++Id9P8Nm8r7jNW9Lp20pKOr3hXF9bwbLFASyKJvNPDGPIfKnnRBxki2N/N2EMCu3Hetg9/Q4tmkTwd7HR4UDYu31HJUXueDpG5D0aU5n4aovyREV7IpYOPyCOCMWJAoWwXPG/1dPIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1+hPZgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EE1C4CEE4;
	Wed,  7 May 2025 00:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746577946;
	bh=7Z7HFia5inGYREF861yG/kIZqHxHikGnB87XGqV+y9w=;
	h=From:To:Cc:Subject:Date:From;
	b=S1+hPZgwhQ7sSAJB1eXj5EMKi/WZECPgNMdcqTHSvpuLJji8O/Z62nRxnnsKBLS5b
	 C4+Xxls7mLOhSbbxFO4kLknUiLJJ28EkTb/lcPgx5H8qxkN7qrslhl6a3Vy1WT+7Em
	 0uQ7LwJj+8STxRyM1nTELk8Ya++mpiQjiyF7M5tU6DhHt2LoVxMsEy6arcoCqU/7yx
	 t98OJF6o7Q7nH6m/f8OG435EnDW0H6UA1/QNQZfGm58r3fTIta1bLArXv0yLt/00ya
	 yqqFE0vXQ0/HWOCm1INi1d4Eaywx3rCCspQUXMgjFEYQJ+HQLchMpN7Q4LjIqv3g2F
	 qZC9/QO0wv69Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jdamato@fastly.com,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/2] virtio-net: fix total qstat values
Date: Tue,  6 May 2025 17:32:19 -0700
Message-ID: <20250507003221.823267-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another small fix discovered after we enabled virtio multi-queue
in netdev CI. The queue stat test fails:

  # Exception| Exception: Qstats are lower, fetched later
  not ok 3 stats.pkt_byte_sum

The queue stats from disabled queues are supposed to be reported
in the "base" stats.

Jakub Kicinski (2):
  net: export a helper for adding up queue stats
  virtio-net: fix total qstat values

 include/net/netdev_queues.h |  6 ++++
 drivers/net/virtio_net.c    |  4 +++
 net/core/netdev-genl.c      | 69 +++++++++++++++++++++++++++----------
 3 files changed, 60 insertions(+), 19 deletions(-)

-- 
2.49.0


