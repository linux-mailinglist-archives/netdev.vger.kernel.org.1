Return-Path: <netdev+bounces-212926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A42B22946
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421D558777B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9116F26E6E7;
	Tue, 12 Aug 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYCjnUc3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC2280A2C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005944; cv=none; b=buCJyzHoVvK9w4A5J7/d4kX8gm7kwhJahWpXUUFIBxT7UJ8eSoPX4SYBJlo2Na34fSMMKIxa83BJZCMc3WYrfGeUQPrkO35gtAGN2Im5U8zJ7eGgHcZg82P0FVSFtFSv43Kliz7ZSfDtUUEdZgwb/K/TdxU2DqUrj2YGxu27qis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005944; c=relaxed/simple;
	bh=MhQnbbRJKJFo03WUy91c4aznF4eJWFz5905kdrgeldo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aBZhL2gem14ZcJ0tYPSJSFPrEOKWVyCE8yKM8qte8XpIYE2lDjf40JKnjxAwShGonhShG1zYtcqfj1CXpWS8SbXENiUv+w1Np2Fvg4HLvJvVNbNY8RmoJqW0xEtPzi8SwY4iaTql2IDfGaVfhceUyBsr5K0+COx8CNCdtaymAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYCjnUc3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755005943; x=1786541943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MhQnbbRJKJFo03WUy91c4aznF4eJWFz5905kdrgeldo=;
  b=bYCjnUc3V2ZXHfRkpq0jIv+tzt30EldTOgc0QOpfdls6M3AwwF4FzFip
   JiMnGfEzH9FSDZ7iVoPTbcANvWzCMEbAihn0hYl7g6xqRbp1bA5A4dgCD
   BO49fCP62NNIOkkkxXwxmEkAuRe4pecPaPRPWvS1HSd/V5p1BRTvOD/mt
   j0q6aePQ5uOWpDZKbjB8hRZCw7mK11UOgRGX1Po5lzwnGiCGjiZA9LZBY
   5NcmnARKmvq4L+ZEqRo3QcgFh8e/l6T5dPM2GPGTFcPl9aBhF7n7dofSm
   fPyiTDQ2PqG88KJ4/8ZYw4kzztfNSmFAVsV8PB+VgXqHQuOF3CgaeeA2B
   g==;
X-CSE-ConnectionGUID: AbpD1/GLRZapVeRGJhbfxA==
X-CSE-MsgGUID: 0gJvYjuLTG2/D+ljiHiEeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56994315"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="56994315"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 06:39:03 -0700
X-CSE-ConnectionGUID: 5fStNXzpTm6NL+iPSuqkyA==
X-CSE-MsgGUID: lDrHrFE0ThWRL9eSYz9dvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170416049"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 06:39:00 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D688C32CA9;
	Tue, 12 Aug 2025 14:38:59 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH 00/12] ice: split ice_virtchnl.c git-blame friendly way
Date: Tue, 12 Aug 2025 15:28:58 +0200
Message-Id: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Split ice_virtchnl.c into two more files (+headers), in a way
that git-blame works better.
Then move virtchnl files into a new subdir.
No logic changes.

I have developed (or discovered ;)) how to split a file in a way that
both old and new are nice in terms of git-blame
There were no much disscussion on [RFC], so I would like to propose
to go forward with this approach.

There is more commits needed to have it nice, so it forms a git-log vs
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

This series is available on my github (just rebased from any
earlier mentions):
https://github.com/pkitszel/linux/tree/virtchnl-split-Aug12
(the simple git-email view flattens this series, removing two
merges from the view).


[RFC]:
https://lore.kernel.org/netdev/5b94d14e-a0e7-47bd-82fc-c85171cbf26e@intel.com/T/#u

(I would really look at my fork via your preferred git interaction tool
instead of looking at the patches below).

Przemek Kitszel (12):
  ice: split queue stuff out of ice_virtchnl.c - p1
  ice: split queue stuff out of ice_virtchnl.c - p2
  ice: extract ice_virtchnl_queues.c: cleanup - p1
  ice: extract ice_virtchnl_queues.c: cleanup - p2
  ice: split RSS stuff out of ice_virtchnl.c - p1
  ice: extract ice_virtchnl_queues.c: cleanup - p3
  ice: split RSS stuff out of ice_virtchnl.c - p2
  ice: finish ice_virtchnl.c split into ice_virtchnl_queues.c
  ice: extract ice_virtchnl_rss.c: cleanup - p1
  ice: extract ice_virtchnl_rss.c: cleanup - p2
  ice: finish ice_virtchnl.c split into ice_virtchnl_rss.c
  ice: add virt/ and move ice_virtchnl* files there

CC: Kuniyuki Iwashima <kuniyu@google.com>

-- 
2.39.3


