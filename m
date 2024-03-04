Return-Path: <netdev+bounces-77230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A2870C15
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3841C22457
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16CC10A2B;
	Mon,  4 Mar 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="So/Pw52d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC510A31
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586324; cv=none; b=FN1iTm1K8Ywvrm9JaHbFgLwP0US9Oeu0mqyG8meXrXlIv05YRKmN0xceZACmFOu2n25AnnV95SSgH3wn9HQDip7XanjcgoAPotiRWjCSZHWLPuel2YWDvjPmcJRjwFTqeW2+OGxYnqfRfIvAjWHvGdGjlVChxD9jG1MwlYQ85mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586324; c=relaxed/simple;
	bh=5ihBg7b0EA4q1QpYUFtV/Ax9I46YnFs7+y5W+jLFHMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZ6trDmDmQZPZ4zU4uDkXA7RN+9LxDYumKJq6V8oX16YvkjNOolVHT8Bc6ZOt8KDhkng0CGPm2d8hPGQwbazc+RcV/VxxKMevb5QLNhjyJFkqL/7lhCgQCtgkXEWN6YzTRl3aTn4X3WSzKanA4YrqSuuELZhY7tW0v76mU1U7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=So/Pw52d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709586323; x=1741122323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ihBg7b0EA4q1QpYUFtV/Ax9I46YnFs7+y5W+jLFHMY=;
  b=So/Pw52d0AhOU82VCT+ubRr8SLuRj3BSdCa0uhV81JdXawR9XJ5lJME8
   BFa2/6ju2SnEsSGf7/mIZpWX/QzsVgr1XHbN1laNGawfvXc8JB9cb2XQy
   tTNtAfsgg+i57yh+PNnjV7Gu29Hy5N4GZpzcOaAc/SnsqJ+2GxxHpe0Bs
   axtUb2Kj3qgjia0OdZekHEVsIg161LdK25f9PYv8F4mwUuQaJshj3l0ga
   phS6kqS/Om20aYG3G6DLhVzSaZmwFtvaGD6I8X+bgciwR5rBFUoY+K5hc
   EVQABEBEcejPpDztIFRTJt9wKNjay6QcCA0By4VRrY+CrOLi3Y+kp1l9y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21561069"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="21561069"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9539716"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 04 Mar 2024 13:05:21 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	alan.brady@intel.com
Subject: [PATCH net-next 00/11][pull request] idpf: refactor virtchnl messages
Date: Mon,  4 Mar 2024 13:05:00 -0800
Message-ID: <20240304210514.3412298-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alan Brady says:

The motivation for this series has two primary goals. We want to enable
support of multiple simultaneous messages and make the channel more
robust. The way it works right now, the driver can only send and receive
a single message at a time and if something goes really wrong, it can
lead to data corruption and strange bugs.

To start the series, we introduce an idpf_virtchnl.h file. This reduces
the burden on idpf.h which is overloaded with struct and function
declarations.

The conversion works by conceptualizing a send and receive as a
"virtchnl transaction" (idpf_vc_xn) and introducing a "transaction
manager" (idpf_vc_xn_manager). The vcxn_mngr will init a ring of
transactions from which the driver will pop from a bitmap of free
transactions to track in-flight messages. Instead of needing to handle a
complicated send/recv for every a message, the driver now just needs to
fill out a xn_params struct and hand it over to idpf_vc_xn_exec which
will take care of all the messy bits. Once a message is sent and
receives a reply, we leverage the completion API to signal the received
buffer is ready to be used (assuming success, or an error code
otherwise).

At a low-level, this implements the "sw cookie" field of the virtchnl
message descriptor to enable this. We have 16 bits we can put whatever
we want and the recipient is required to apply the same cookie to the
reply for that message.  We use the first 8 bits as an index into the
array of transactions to enable fast lookups and we use the second 8
bits as a salt to make sure each cookie is unique for that message. As
transactions are received in arbitrary order, it's possible to reuse a
transaction index and the salt guards against index conflicts to make
certain the lookup is correct. As a primitive example, say index 1 is
used with salt 1. The message times out without receiving a reply so
index 1 is renewed to be ready for a new transaction, we report the
timeout, and send the message again. Since index 1 is free to be used
again now, index 1 is again sent but now salt is 2. This time we do get
a reply, however it could be that the reply is _actually_ for the
previous send index 1 with salt 1.  Without the salt we would have no
way of knowing for sure if it's the correct reply, but with we will know
for certain.

Through this conversion we also get several other benefits. We can now
more appropriately handle asynchronously sent messages by providing
space for a callback to be defined. This notably allows us to handle MAC
filter failures better; previously we could potentially have stale,
failed filters in our list, which shouldn't really have a major impact
but is obviously not correct. I also managed to remove fairly
significant more lines than I added which is a win in my book.

Additionally, this converts some variables to use auto-variables where
appropriate. This makes the alloc paths much cleaner and less prone to
memory leaks. We also fix a few virtchnl related bugs while we're here.

The following are changes since commit 09fcde54776180a76e99cae7f6d51b33c4a06525:
  Merge branch 'mptcp-userspace-pm'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alan Brady (11):
  idpf: add idpf_virtchnl.h
  idpf: implement virtchnl transaction manager
  idpf: refactor vport virtchnl messages
  idpf: refactor queue related virtchnl messages
  idpf: refactor remaining virtchnl messages
  idpf: add async_handler for MAC filter messages
  idpf: refactor idpf_recv_mb_msg
  idpf: cleanup virtchnl cruft
  idpf: prevent deinit uninitialized virtchnl core
  idpf: fix minor controlq issues
  idpf: remove dealloc vector msg err in idpf_intr_rel

 drivers/net/ethernet/intel/idpf/idpf.h        |  146 +-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |    7 +-
 .../ethernet/intel/idpf/idpf_controlq_api.h   |    5 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |    1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   39 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |    1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |    3 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 2278 ++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   70 +
 10 files changed, 1182 insertions(+), 1374 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h

-- 
2.41.0


