Return-Path: <netdev+bounces-208754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8B5B0CF4A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644D7189338C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9C31A4E9E;
	Tue, 22 Jul 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usR+RQeR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740913AA20
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148972; cv=none; b=Zq5c/Cr48Q/CHFVinhTu74m0ItGnVtA/1lu0rGMjWaJZOgheqn8XiRM4pXCf1yhfXH6UKAuR49R9nvKGOTbzBGRTABYXwoA50Z43tb6k9f/ELlpHXzZRimjDl4QjToWnEHTMMWvA5tHd3GGp4dy9gj9lxUPfsK4wQG58/GJh0xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148972; c=relaxed/simple;
	bh=n/+CvmvKvVlM2Vfyd/E/Ih/zHTt2GPqSmR+AfFWFigs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXC1zYjYcjQi2iZe04H5RFan6YiSLepwB090N0TWJaRNqn55e8LyqcG6542H8vOOrN5erCZ2a1h0Di5dh32BxoZnN6AJjTlZYTfIUMzR+SLM4Q68pHfPEtJONg8TjumTE+h2kAk5uBnV71m9FiQJnwJoVUyBcfo0iOT9CWCGer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usR+RQeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC86FC4CEED;
	Tue, 22 Jul 2025 01:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753148972;
	bh=n/+CvmvKvVlM2Vfyd/E/Ih/zHTt2GPqSmR+AfFWFigs=;
	h=From:To:Cc:Subject:Date:From;
	b=usR+RQeRB5of4XA4tGfHzL5XDOp7lcnPKerffI6Vw0rfWI5AuxO2CPee6RFNio9/p
	 bt1AiyxgbzKociTfzX46NT+wjrkEBrJCBhe5a8FljUbPawt1Rko66s+TAeLZPpNgLY
	 Tsr5SJ8OrGcflgKswV88Qc0ot4ckyHsBbppfC6GXO+8xgiYp/1kYFcIhh6qKdQwQyZ
	 MMxeupE8vbL/nMGC8/xB9DPjTUE5NqClDMEH8c81zKzJhUWtoc5Sdp50Cd3LK+L/Y3
	 j243HqiqN8Ce7c7znxQ820v5XU0C8kIymC0OWRrq1Oe7wufhV7By2njn4EHQ/ltUBk
	 V1vkOANq4EEAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	gal@nvidia.com,
	andrew@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/4] net: ethtool: support including Flow Label in the flow hash for RSS
Date: Mon, 21 Jul 2025 18:49:11 -0700
Message-ID: <20250722014915.3365370-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for using IPv6 Flow Label in Rx hash computation
and therefore RSS queue selection.

RFC: https://lore.kernel.org/20250609173442.1745856-1-kuba@kernel.org

Jakub Kicinski (4):
  net: ethtool: support including Flow Label in the flow hash for RSS
  eth: fbnic: support RSS on IPv6 Flow Label
  eth: bnxt: support RSS on IPv6 Flow Label
  selftests: drv-net: add test for RSS on flow label

 Documentation/netlink/specs/ethtool.yaml      |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 include/uapi/linux/ethtool.h                  |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  23 ++-
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +
 net/ethtool/ioctl.c                           |  25 +++
 net/ethtool/rss.c                             |  27 ++--
 .../drivers/net/hw/rss_flow_label.py          | 151 ++++++++++++++++++
 11 files changed, 221 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_flow_label.py

-- 
2.50.1


