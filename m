Return-Path: <netdev+bounces-125180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCAB96C2FE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70341F25CC3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AB1DC05F;
	Wed,  4 Sep 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgBhr95E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0191DC73E;
	Wed,  4 Sep 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465081; cv=none; b=orPodIA/laSZ9y53GFPlGkUpcUFaYylqgrP5SXB7tgUhhbfds9bV4IAHd4/fYvHenXNepPcSZIiZzOSE0/CMV58f3ZUWWUlBx4A2p8cskc+WXvqMFE+7sHGRGYwijwR3szRz9JPF3N3KqjwvkQog+84VQKXopgIhbpc/vUrP76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465081; c=relaxed/simple;
	bh=y7K0XuRk4s2I3UAuv+2/CKOqjAjq4Y52W4VRKs5k61E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAQOn5DtBxVYD/kufDgSnAqbJIiF8p4sPaJG7dgKkPj9teKHV0Z/lhPCSMZufBCgQ7Frji9vvD6rRGBqt0NJ3/8HLw1HNPLySeH72EjsC9H4gEgl2KLgDyHM9zRJIL5XYc5lO8n0eDgHsXWuHsbsOVM3G+uVC6YGjU6l/YE6jxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgBhr95E; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725465079; x=1757001079;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y7K0XuRk4s2I3UAuv+2/CKOqjAjq4Y52W4VRKs5k61E=;
  b=fgBhr95EMj0+t88RIYYAUANkB+dxGZc5IcFC7R7TfH9xJ57AbM7OVvT8
   YaZpHp4MglwxGCgrlYfYapQqDnjTrmGZUFHuJqVHeOzflcHU+eTKpEo8N
   Axvz9fb/lquPgpepdrNorrUpbDuK53a3KX4rnR/tzF/QoLLsTy9kaLp0r
   WpMmbTmERmYSwZEpaBm3KzPyNg1tllVmhWlv/xntFSJt9qH0kuDXWOz+D
   COC2v7YsxInrQi//O9SN4d4/iOfYgYAErHMu/fruAYPDPlpuYFWQmkzV2
   p4gayks/dn6mNSYUZAl6ZwyFIxY5Kwp7ZUHHl7h3YjkhiCcdCcKMWk5ZS
   w==;
X-CSE-ConnectionGUID: n0SgpGRrSHKzM03DzoCJTg==
X-CSE-MsgGUID: Vy2An18rSD6ojQkOjeju2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34737124"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="34737124"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:51:18 -0700
X-CSE-ConnectionGUID: in9rYBYpQlGP4u4Wf4LHzQ==
X-CSE-MsgGUID: 7jytzqScRX+8LbY0ZnHpsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="66041811"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 04 Sep 2024 08:51:15 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 0/6] idpf: XDP chapter II: convert Tx completion to libeth
Date: Wed,  4 Sep 2024 17:47:42 +0200
Message-ID: <20240904154748.2114199-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP for idpf is currently 5 chapters:
* convert Rx to libeth;
* convert Tx completion to libeth (this);
* generic XDP and XSk code changes;
* actual XDP for idpf via libeth_xdp;
* XSk for idpf (^).

Part II does the following:
* adds generic libeth Tx completion routines;
* converts idpf to use generic libeth Tx comp routines;
* fixes Tx queue timeouts and robustifies Tx completion in general;
* fixes Tx event/descriptor flushes (writebacks).

Most idpf patches again remove more lines than adds.
Generic Tx completion helpers and structs are needed as libeth_xdp
(Ch. III) makes use of them. WB_ON_ITR is needed since XDPSQs don't
want to work without it at all. Tx queue timeouts fixes are needed
since without them, it's way easier to catch a Tx timeout event when
WB_ON_ITR is enabled.

Alexander Lobakin (3):
  libeth: add Tx buffer completion helpers
  idpf: convert to libeth Tx buffer completion
  netdevice: add netdev_tx_reset_subqueue() shorthand

Joshua Hay (2):
  idpf: refactor Tx completion routines
  idpf: enable WB_ON_ITR

Michal Kubiak (1):
  idpf: fix netdev Tx queue stop/wake

 include/net/libeth/types.h                    |  25 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  92 ++--
 include/linux/netdevice.h                     |  13 +-
 include/net/libeth/tx.h                       | 129 ++++++
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   2 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 110 +++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 394 ++++++++----------
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   2 +
 8 files changed, 441 insertions(+), 326 deletions(-)
 create mode 100644 include/net/libeth/types.h
 create mode 100644 include/net/libeth/tx.h

---
From v1[0]:
* drop the stats implementation. It's not generic, uses old Ethtool
  interfaces and is written using macro templates which made it barely
  readable (Kuba).
  I'll be rewriting it separately.
* replace `/* <multi-line comment>` with `/*\n * <multi-line comment>`
  since the special rule for netdev was removed.

[0] https://lore.kernel.org/netdev/20240819223442.48013-1-anthony.l.nguyen@intel.com
-- 
2.46.0


