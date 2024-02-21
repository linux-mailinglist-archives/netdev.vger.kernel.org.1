Return-Path: <netdev+bounces-73490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD11785CCFC
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8BF1C20D6C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E317D5;
	Wed, 21 Feb 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFtIOsfw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025D23DE
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476627; cv=none; b=fkq+nP5Wl6W0VH0nxyAO5r7gWuHJNjnukwNYhg3t5K/YFPl/IOd9Q2Cg/SecYi5QOy8NQgKH1hbiQ15ldA7sH7RsVjVuzj5GIwjNs+SUU3TvW00EX6RTDFOQE72m8wMnZ6vNgjfThcxWHyQMyv9hpBldJZw4QZ8t+NFz/ZaRtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476627; c=relaxed/simple;
	bh=b3K6fKvWYQ/SjUrArgoOKBdVwFRSn6xScwQTXGpC9rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxq0NTYcf3j0T1ZmkqSGxejZ/ylNGOhZSs5LBYD0sZdrpEG51rjzleyvyqV4nqKf4JVH+YOnticsD9dJ5czhaVBbtrPjY9ZtkE/80K3GZ11D2x8HeZjLUKKyxqu9GBBu1hItCOAGuevyXWrGQ0b9G4xg4nsQSH5diiF05omYsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFtIOsfw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708476626; x=1740012626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b3K6fKvWYQ/SjUrArgoOKBdVwFRSn6xScwQTXGpC9rs=;
  b=JFtIOsfwyJJbzpfEJEal0mYLusI7W5YkPdq2oYSv2+hQnU/49T65PHqC
   sx+bpYm5yb9dLyzpRNU7MwZ5cX3Wk9mEVMwsYJvBIXb9ByUIlUV3ZIGOn
   2/0wzHyHjPh3A/TtQyVCIwxiq6rDE5Flgpdh/i21Ye6Qc2ISmZm1egz8Z
   AwDXeV4QELby63x+utdlQs7QGPnDNEfDFBEmugZIQ7cPI/B4atwVvuJyO
   KfHoMwqM1FzW8SlD/oaoQSVlH3knRNznlyWoZdNJU7V/2QHPesaZ4QVJa
   CzhN5sYCKP9w3mjUvz4mwpN4fW23Em6+HcFak5UvJzjNN85EYJBsuyOij
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2500692"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2500692"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:50:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9550825"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2024 16:50:25 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>
Subject: [PATCH v5 00/10 iwl-next] idpf: refactor virtchnl messages
Date: Tue, 20 Feb 2024 16:49:39 -0800
Message-ID: <20240221004949.2561972-1-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The motivation for this series has two primary goals. We want to enable
support of multiple simultaneous messages and make the channel more
robust. The way it works right now, the driver can only send and receive
a single message at a time and if something goes really wrong, it can
lead to data corruption and strange bugs.

This works by conceptualizing a send and receive as a "virtchnl
transaction" (idpf_vc_xn) and introducing a "transaction manager"
(idpf_vc_xn_manager). The vcxn_mngr will init a ring of transactions
from which the driver will pop from a bitmap of free transactions to
track in-flight messages. Instead of needing to handle a complicated
send/recv for every a message, the driver now just needs to fill out a
xn_params struct and hand it over to idpf_vc_xn_exec which will take
care of all the messy bits. Once a message is sent and receives a reply,
we leverage the completion API to signal the received buffer is ready to
be used (assuming success, or an error code otherwise).

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

---
v1 -> v2:
    - don't take spin_lock in idpf_vc_xn_init, it's not needed
    - fix set but unused error on payload_size var in idpf_recv_mb_msg
    - prefer bitmap_fill and bitmap_zero if not setting an explicit
      range per documention
    - remove a couple unnecessary casts in idpf_send_get_stats_msg and
      idpf_send_get_rx_ptype_msg
    - split patch 4/6 such that the added functionality for MAC filters
      is separate
v2 -> v3:
    - fix 'mac' -> 'MAC' in async handler error messages
    - fix size_t format specifier in async handler error message
    - change some variables to use auto-variables instead
v3 -> v4:
    - revert changes to idpf_send_mb_msg that were introduced in v3,
      this will be addressed in future patch
    - tweak idpf_recv_mb_msg refactoring to avoid bailing out of the
      while loop when there are more messages to process and add comment
      in idpf_vc_xn_forward_reply about ENXIO
    - include some minor fixes to lower level ctrlq that seem like good
      candidates to add here
    - include fix to prevent deinit uninitialized vc core
    - remove idpf_send_dealloc_vectors_msg error
v4 -> v5:
    - change signature on idpf_vc_xn_exec to accept a pointer @params
      argument instead of passing by value, also make it const
---

Alan Brady (10):
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

 drivers/net/ethernet/intel/idpf/idpf.h        |  194 +-
 .../net/ethernet/intel/idpf/idpf_controlq.c   |    7 +-
 .../ethernet/intel/idpf/idpf_controlq_api.h   |    5 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   38 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    3 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |    2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 2175 ++++++++---------
 7 files changed, 1096 insertions(+), 1328 deletions(-)

-- 
2.43.0


