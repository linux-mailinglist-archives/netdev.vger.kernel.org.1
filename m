Return-Path: <netdev+bounces-184449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA37A95959
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F15A3AE49E
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AEF21481B;
	Mon, 21 Apr 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyQKz9IT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE522338
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274515; cv=none; b=HrA6a2IJ5tKJjWi+oel81HcmGOn1lPEUqDPJl3fF8ll+z8Z/gY2NjMK7RI6Kj5COemKPVHdpRl5MBnedQvijC1GC4+wmi111lcXmBd/Yo+eMIcLiAvo2EZIHtW3NMYSGUppPEHcmdCemdCe73QfQiGteBYPA7PXixw0IW+hzv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274515; c=relaxed/simple;
	bh=jfSdTPw1OLWkNYdo5N9pR67g3GFg0Lg4OnYCBglOKoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0FyUz4p8adUzQBlKFmhu0pgqfAnB/XnnKF4+y8ZgPbkFndIiyNka4aBTe3ndj7vbPIZoaLkhv3xlOxeEqMtSs3dYqOQs7HQ35+IblIJHp26nlVPtzVQpy7IHIJDUDsd1KJtq4HH7Rg1S6hoojvGEwCrixlSVucawnIPX5tw/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyQKz9IT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32F3C4CEE4;
	Mon, 21 Apr 2025 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274514;
	bh=jfSdTPw1OLWkNYdo5N9pR67g3GFg0Lg4OnYCBglOKoE=;
	h=From:To:Cc:Subject:Date:From;
	b=qyQKz9ITyahILvGq3CJHo545jWIFcyf7UEwvJvpPq1AgcRKWo7AQNy+oiSOpjS/i4
	 vrZyfEahN13FPdf52BtijL6vEcGe6hlECFSXFxYn2FkmlRQxMRYUIs/yqlGnhby2up
	 dzNBBZlqZcAmCGXBIAYcMBOyeUzJDGVU2mhGs4DGuuDzwQ1jFzBmqod05oFzFDreNc
	 7ZkJSxpYQwj0gs8WyUhLjLctBiD37imf3IiyZTZS4IxzyRAGWRzZV+WlkMR0dR+6/m
	 NxpqjjFREym+i+t4ZWo7OSMPYUoFehA/AJ7hCysu4Uzobd7KsxFATu36P+VBEK+UQc
	 siauR+GGXd5Kg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 00/22] net: per-queue rx-buf-len configuration
Date: Mon, 21 Apr 2025 15:28:05 -0700
Message-ID: <20250421222827.283737-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for per-queue rx-buf-len configuration.

I'm sending this as RFC because I'd like to ponder the uAPI side
a little longer but it's good enough for people to work on
the memory provider side and support in other drivers.

The direct motivation for the series is that zero-copy Rx queues would
like to use larger Rx buffers. Most modern high-speed NICs support HW-GRO,
and can coalesce payloads into pages much larger than than the MTU.
Enabling larger buffers globally is a bit precarious as it exposes us
to potentially very inefficient memory use. Also allocating large
buffers may not be easy or cheap under load. Zero-copy queues service
only select traffic and have pre-allocated memory so the concerns don't
apply as much.

The per-queue config has to address 3 problems:
- user API
- driver API
- memory provider API

For user API the main question is whether we expose the config via
ethtool or netdev nl. I picked the latter - via queue GET/SET, rather
than extending the ethtool RINGS_GET API. I worry slightly that queue
GET/SET will turn in a monster like SETLINK. OTOH the only per-queue
settings we have in ethtool which are not going via RINGS_SET is
IRQ coalescing.

My goal for the driver API was to avoid complexity in the drivers.
The queue management API has gained two ops, responsible for preparing
configuration for a given queue, and validating whether the config
is supported. The validating is used both for NIC-wide and per-queue
changes. Queue alloc/start ops have a new "config" argument which
contains the current config for a given queue (we use queue restart
to apply per-queue settings). Outside of queue reset paths drivers
can call netdev_queue_config() which returns the config for an arbitrary
queue. Long story short I anticipate it to be used during ndo_open.

In the core I extended struct netdev_config with per queue settings.
All in all this isn't too far from what was there in my "queue API
prototype" a few years ago. One thing I was hoping to support but
haven't gotten to is providing the settings at the RSS context level.
Zero-copy users often depend on RSS for load spreading. It'd be more
convenient for them to provide the settings per RSS context.
We may be better off converting the QUEUE_SET netlink op to CONFIG_SET
and accept multiple "scopes" (queue, rss context)?

Memory provider API is a bit tricky. Initially I wasn't sure whether
the buffer size should be a MP attribute or a device attribute.
IOW whether it's the device that should be telling the MP what page
size it wants, or the MP telling the device what page size it has.
In some ways the latter is more flexible, but the implementation
gets hairy rather quickly. Drivers expect to know their parameters
early in the init process, page pools are allocated relatively late.

Jakub Kicinski (22):
  docs: ethtool: document that rx_buf_len must control payload lengths
  net: ethtool: report max value for rx-buf-len
  net: use zero value to restore rx_buf_len to default
  net: clarify the meaning of netdev_config members
  net: add rx_buf_len to netdev config
  eth: bnxt: read the page size from the adapter struct
  eth: bnxt: set page pool page order based on rx_page_size
  eth: bnxt: support setting size of agg buffers via ethtool
  net: move netdev_config manipulation to dedicated helpers
  net: reduce indent of struct netdev_queue_mgmt_ops members
  net: allocate per-queue config structs and pass them thru the queue
    API
  net: pass extack to netdev_rx_queue_restart()
  net: add queue config validation callback
  eth: bnxt: always set the queue mgmt ops
  eth: bnxt: store the rx buf size per queue
  eth: bnxt: adjust the fill level of agg queues with larger buffers
  netdev: add support for setting rx-buf-len per queue
  net: wipe the setting of deactived queues
  eth: bnxt: use queue op config validate
  eth: bnxt: support per queue configuration of rx-buf-len
  selftests: drv-net: add helper/wrapper for bpftrace
  selftests: drv-net: add test for rx-buf-len

 Documentation/netlink/specs/ethtool.yaml      |   4 +
 Documentation/netlink/specs/netdev.yaml       |  15 +
 Documentation/networking/ethtool-netlink.rst  |   7 +-
 net/core/Makefile                             |   2 +-
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
 include/linux/ethtool.h                       |   3 +
 include/net/netdev_queues.h                   |  83 ++++-
 include/net/netdev_rx_queue.h                 |   3 +-
 include/net/netlink.h                         |  19 ++
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 include/uapi/linux/netdev.h                   |   2 +
 net/core/dev.h                                |  12 +
 net/core/netdev-genl-gen.h                    |   1 +
 tools/include/uapi/linux/netdev.h             |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 135 ++++++--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   6 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   9 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   6 +-
 drivers/net/netdevsim/netdev.c                |   8 +-
 net/core/dev.c                                |  12 +-
 net/core/netdev-genl-gen.c                    |  15 +
 net/core/netdev-genl.c                        |  92 ++++++
 net/core/netdev_config.c                      | 150 +++++++++
 net/core/netdev_rx_queue.c                    |  24 +-
 net/ethtool/common.c                          |   4 +-
 net/ethtool/netlink.c                         |  14 +-
 net/ethtool/rings.c                           |  14 +-
 .../selftests/drivers/net/hw/rx_buf_len.py    | 299 ++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   |  33 ++
 32 files changed, 913 insertions(+), 79 deletions(-)
 create mode 100644 net/core/netdev_config.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/rx_buf_len.py

-- 
2.49.0


