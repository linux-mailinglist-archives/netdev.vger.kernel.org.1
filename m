Return-Path: <netdev+bounces-281684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKIxJm1j8GkRSwEAu9opvQ
	(envelope-from <netdev+bounces-281684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:36:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2839347EFA5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F4158303C50D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414FE3DB632;
	Tue, 28 Apr 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiWv9p3M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA33DA5B5;
	Tue, 28 Apr 2026 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360938; cv=none; b=pYfgWXTF301X94RoOFj5A9IDGy26ScJUzr+tqpRfJPoTs3Igx599OhyPJKEaJ6Nu1jh/38qlYGYCfvP3wCHfn1zeSCpTYCm2Un0drIwMeYarK6DwFAuZdQYdGHeoImWC3GljSUp/fFRiOG7lH/HG5LUKyraUJqVp/8Ox7SUhSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360938; c=relaxed/simple;
	bh=wQAPuxovCp2uWQoWCBJfZsiB+eWwZVD72BaGWQWSOe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFw9roMY8jAhOGxQ1nz7m59oOpm9VHaJ9M3zl9U+R0xZFkij50COTg9N80rh/xlLg4M3z+2h2YZwYFv6pGdx2AB3Sn8jWBX2YdvthM6hU0bTY9ysYBXRrIJh8dyeVk1T79Zk+sE6B6/JAB8AyPy7NZ0Vyapgp0bjXmTIKsWXX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiWv9p3M; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777360936; x=1808896936;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wQAPuxovCp2uWQoWCBJfZsiB+eWwZVD72BaGWQWSOe0=;
  b=DiWv9p3MMBfTzaHZa7QYFXEt7eCQK1WWO9zXg5yGJIekKnq5JCl3DUey
   6McEcuRKzV+cgprvrVe74myV1AKk9TaocMipV7y8olZ4YpXuNhFFuZZLg
   lWDi7bcg2lFgQXlDkpQmWaZxg7DICxEMPCdUQw+UrkfFonLVPvC1Ug0VO
   9bgirWSf+3gomOJ+CfhhNSfiTfhRJ1o1GTzXCJ0KFJvVHsZXew7OvOpxt
   xOdPR6SQ9ZG/DQxqvDvyPxSG751kmvnsxGGhe+uEHaSOuORYcsMGFykbY
   ZYB0Bx/VUXXh9iY/fATqbvtejARk3/cu0vnbgfqNYsuQSf5JuW6kLz/5q
   w==;
X-CSE-ConnectionGUID: L0qoLlaLQBekP+m0p29W3Q==
X-CSE-MsgGUID: 21PP4QN2SEyD3BUKRrXAqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89720810"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89720810"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:22:14 -0700
X-CSE-ConnectionGUID: TWEcvninRYWjL9banI8Pgg==
X-CSE-MsgGUID: md6I94qMRB+6ZsKaMg72Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238206404"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 28 Apr 2026 00:22:11 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id EFCC595; Tue, 28 Apr 2026 09:22:09 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/9] thunderbolt: Introduce USB4STREAM
Date: Tue, 28 Apr 2026 09:22:00 +0200
Message-ID: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2839347EFA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281684-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim]

Hi all,

This series adds support for a new protocol over USB4/Thunderbolt cable
called USB4STREAM. The protocol is super-simple and basically just
transfers raw packets from one host to another. It is documented as part of
the thunderbolt_stream driver.

The driver exposes /dev/tbstreamX devices on each side of the link that can
be used to transfer data using regular filesystem operations such as
read(2) and write(2):

  host1 # cat /dev/tbstream0
  host2 # echo hello > /dev/tbstream0

This can be useful in cases where network tooling is not available or just
for existing applications like 'dd' and 'cat' that do not support sockets.

thunderbolt_stream can be used at the same time with thunderbolt_net so
they don't rule each other our. 

thunderbolt_stream allows multiple streams to be created, for example one
stream for control traffic and another for data (there are some limitations
in the core USB4/Thunderbolt driver due to dedicated flow control scheme
but this is likely change in the future). Each stream is bi-directional
tunnel over the fabric.

There are a couple of additional usage examples in the last patch that adds
the driver itself.

This applies on top of my XDomain improvements series [1].

[1] https://lore.kernel.org/linux-usb/20260427081109.2337731-1-mika.westerberg@linux.intel.com/

Mika Westerberg (9):
  thunderbolt: Add tb_property_merge_dir()
  thunderbolt: Add KUnit test for tb_property_merge_dir()
  thunderbolt: Allow service drivers to specify their own properties
  thunderbolt / net: Move ring_frame_size() to thunderbolt.h
  thunderbolt / net: Let the service drivers configure interrupt throttling
  thunderbolt: Add helper to figure size of the ring
  thunderbolt: Add tb_ring_flush()
  thunderbolt: Add support for ConfigFS
  thunderbolt: Add support for USB4STREAM

 .../ABI/testing/configfs-thunderbolt_stream   |   77 +
 drivers/net/thunderbolt/main.c                |   23 +-
 drivers/thunderbolt/Kconfig                   |   15 +
 drivers/thunderbolt/Makefile                  |    4 +
 drivers/thunderbolt/configfs.c                |   61 +
 drivers/thunderbolt/dma_test.c                |    5 +
 drivers/thunderbolt/domain.c                  |    2 +
 drivers/thunderbolt/nhi.c                     |   86 +-
 drivers/thunderbolt/nhi_regs.h                |    3 +-
 drivers/thunderbolt/property.c                |  154 +-
 drivers/thunderbolt/stream.c                  | 1693 +++++++++++++++++
 drivers/thunderbolt/tb.h                      |    8 +
 drivers/thunderbolt/test.c                    |   82 +
 drivers/thunderbolt/xdomain.c                 |   95 +-
 include/linux/thunderbolt.h                   |   44 +-
 15 files changed, 2257 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-thunderbolt_stream
 create mode 100644 drivers/thunderbolt/configfs.c
 create mode 100644 drivers/thunderbolt/stream.c

-- 
2.50.1


