Return-Path: <netdev+bounces-217495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C7B38EA1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF085366A04
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE326A08C;
	Wed, 27 Aug 2025 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyaMwl3R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29A6FC5
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334811; cv=none; b=EInX/LvarIE7HQymFd996frxqsSYIvOa1kxO5Sxye9m1hT0NS2pEig7fcPzrKfGOyiPbNdfkLclnZyT8UO77WTO8bb56vjwItiIGUFXGzdXRw+KvuO0qtLxQY3be9XHo03m9JdZtASG+yb+NQWtQt4OsBvVHUadXGHFZv6P/k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334811; c=relaxed/simple;
	bh=nMIm3zFvML7Dj0wctLpfeiV/JX6zV9KrH34suDP3vpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrACz8DQOMNPgHQsWNjc0jB+XL6fLVXf3W7O8LTFbirMLC4JLmbDBG01xb+C8jzDIA8CgfQXLjd4NasBXmTnuRB6jzZEMeIEgc0EgioGdzPgjAHSymASpi0dYT68MYmSG3Le7DctJVHQCHP+XdYVC56ZPQic9nfKMM6OnFNRtVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyaMwl3R; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756334809; x=1787870809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nMIm3zFvML7Dj0wctLpfeiV/JX6zV9KrH34suDP3vpM=;
  b=fyaMwl3R+mX3hW3N6pw9JA8L5AZE60iItq0RIQOC9oH92b7wLQyzSsjt
   m96ipI15B+Emz6b5eKffwmo+HzCZVixk0jL7ByCH8pIA6ZUgmHMf7CwyV
   QceAP+BgEGbxrmS5AUm5Et/lEaPzOMcj7/iZMguijf/mO3ZV203PaG/m6
   Hx2yOSR6m6A3HDK7JC+lkCbfOvWM5SEFdXsHuu1iETNwtkaTXKyZs4Ec+
   Dk3opvlDQhzAwLPh7AQ/uY1D9UgfMYeY84DcmbfRzRvZxbXYPmG5+KIV3
   PuRi7PE8P85WRGaGzatzIqEFiwwzWwe9YW26ZyU/FLRt8zvhDvgrsN8Gb
   A==;
X-CSE-ConnectionGUID: M5oZINvrTvKIWk8ekS7cOQ==
X-CSE-MsgGUID: rMZsDxiCTPWtOS614agpZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70037208"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70037208"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:46:49 -0700
X-CSE-ConnectionGUID: YsRwm+zgTCWj7LdVVtU8ng==
X-CSE-MsgGUID: tLDBdIBBRnGWd9Yz0IdwJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169554994"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 27 Aug 2025 15:46:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	przemyslaw.kitszel@intel.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	kuniyu@google.com
Subject: [PATCH net-next 00/12][pull request] ice: split ice_virtchnl.c git-blame friendly way
Date: Wed, 27 Aug 2025 15:46:15 -0700
Message-ID: <20250827224641.415806-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Przemek Kitszel says:

Split ice_virtchnl.c into two more files (+headers), in a way
that git-blame works better.
Then move virtchnl files into a new subdir.
No logic changes.

I have developed (or discovered ;)) how to split a file in a way that
both old and new are nice in terms of git-blame
There was not much discussion on [RFC], so I would like to propose
to go forward with this approach.

There are more commits needed to have it nice, so it forms a git-log vs
git-blame tradeoff, but (after the brief moment that this is on the top)
we spend orders of magnitude more time looking at the blame output (and
commit messages linked from that) - so I find it much better to see
actual logic changes instead of "move xx to yy" stuff (typical for
"squashed/single-commit splits").

Cherry-picks/rebases work the same with this method as with simple
"squashed/single-commit" approach (literally all commits squashed into
one (to have better git-log, but shitty git-blame output).

Rationale for the split itself is, as usual, "file is big and we want to
extend it".

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
I would really look at the fork via your preferred git interaction tool
instead of looking at the patches below.

Note:
The simple git-email view flattens this series, removing two merges from
the view.

Changes:
- Drop the "ice_" and "virtchnl_" substrings in file names, to keep the
naming convention we established when extracting devlink/

IWL v1:
https://lore.kernel.org/netdev/20250812132910.99626-1-przemyslaw.kitszel@intel.com/

[RFC]:
https://lore.kernel.org/netdev/5b94d14e-a0e7-47bd-82fc-c85171cbf26e@intel.com/T/#u

The following are changes since commit cd31182c80e8ec02dacd1d56b91c31e5c7d2c580:
  Merge branch 'selftests-test-xdp_tx-for-single-buffer'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Przemek Kitszel (12):
  ice: add virt/ and move ice_virtchnl* files there
  ice: split queue stuff out of virtchnl.c - tmp rename
  ice: split queue stuff out of virtchnl.c - copy back
  ice: extract virt/queues.c: cleanup - p1
  ice: extract virt/queues.c: cleanup - p2
  ice: extract virt/queues.c: cleanup - p3
  ice: finish virtchnl.c split into queues.c
  ice: split RSS stuff out of virtchnl.c - tmp rename
  ice: split RSS stuff out of virtchnl.c - copy back
  ice: extract virt/rss.c: cleanup - p1
  ice: extract virt/rss.c: cleanup - p2
  ice: finish virtchnl.c split into rss.c

 drivers/net/ethernet/intel/ice/Makefile            |    8 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h         |    4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |    2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |    2 +-
 .../{ice_virtchnl_allowlist.c => virt/allowlist.c} |    2 +-
 .../{ice_virtchnl_allowlist.h => virt/allowlist.h} |    0
 .../intel/ice/{ice_virtchnl_fdir.c => virt/fdir.c} |    0
 .../intel/ice/{ice_virtchnl_fdir.h => virt/fdir.h} |    0
 drivers/net/ethernet/intel/ice/virt/queues.c       |  975 ++++++++++
 drivers/net/ethernet/intel/ice/virt/queues.h       |   20 +
 drivers/net/ethernet/intel/ice/virt/rss.c          |  719 +++++++
 drivers/net/ethernet/intel/ice/virt/rss.h          |   18 +
 .../intel/ice/{ice_virtchnl.c => virt/virtchnl.c}  | 2055 ++------------------
 .../intel/ice/{ice_virtchnl.h => virt/virtchnl.h}  |    0
 15 files changed, 1933 insertions(+), 1874 deletions(-)

