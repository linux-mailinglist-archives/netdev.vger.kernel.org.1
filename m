Return-Path: <netdev+bounces-237700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18085C4F206
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92C9E341D92
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E434DB75;
	Tue, 11 Nov 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJCqxhFK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287F1A3BD7;
	Tue, 11 Nov 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879959; cv=none; b=r4BsSxrJIugq1/Ac7hGw95ZeE2yyLrYBRQ4GRkkqOPPX1rUKRR937knsP4sZ6QrKmFBk8ESy9qpX9uCC9v2voSPhC1jOK7+coeXQIkHDqlNbWuyGehz+sC5xJmGJbIjITPO0SEHvroXx4Vha8P6RApR73czZK/a4gCUwezTJwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879959; c=relaxed/simple;
	bh=+o7Dsa54j3yc4bj/q2KwDheMl1c9jBMwsS8FQ0e+N1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYopqwf7uR3Zh5sgeAvHkry8LmdhgyXQXRkkSynV+d2c31+Ee4WxtKD7IMi5o0C0I1xWQ84DDn8MWTqq1zqbGXwgAB0oL3LXc3OEmKOzWh3K2NffC2zdKfqtgrzWr2DYv79rDZw5YlKJHIiVRc2VsPGnVNQxUDzSHQQInppStW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJCqxhFK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762879957; x=1794415957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+o7Dsa54j3yc4bj/q2KwDheMl1c9jBMwsS8FQ0e+N1Y=;
  b=oJCqxhFKUn+FaRGn4kHUkMQ8A/7xQF42KO8d8VvxIykieMRZBTTRSrKh
   K6tqxgL1ixUJUdsn+AJbGvq6rk0lBSgeT3VE9rPlPjbZZFzDND/54ulfb
   oTthuz7RHLF58I3ihj03UFcbRbYmXkEZJHBHJSs2Rr4jINroaXFD+1QwE
   Rh/DFkJ6zMZgCJQVQ5TKo2bMg3ybpL6B7hlkPsIHRP5Sqc4/StM1VzxmJ
   MJrcPDoa1kEs5ntJC23Tg4aA8uzRMAiCG2VJ3eoQNkxUDCkjySnRt/5YR
   2fuJLNI+vbd5U6Nu1a8N/CkXwzp0Qzm0i4Nuv0LXiIm/q4pRgJ/usUkWB
   A==;
X-CSE-ConnectionGUID: hGpxbHH9TFOCqo74iW8+Tg==
X-CSE-MsgGUID: m5brwx7rT1KevTmHpJbrGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76049247"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="76049247"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:52:36 -0800
X-CSE-ConnectionGUID: h2NluEQMTiWF2a5Xfc9L4w==
X-CSE-MsgGUID: V0xj0IIgRseOWhCjl4biMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="193112851"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 11 Nov 2025 08:52:35 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 687DB96; Tue, 11 Nov 2025 17:52:33 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/7] ptp: ocp: A fix and refactoring
Date: Tue, 11 Nov 2025 17:52:07 +0100
Message-ID: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the fix for incorrect use of %ptT with the associated
refactoring and additional cleanups.

Note, %ptS, which is introduced in another series, doesn't fit
here, that's why this fix is separated from that series.

Andy Shevchenko (7):
  ptp: ocp: Refactor signal_show() and fix %ptT misuse
  ptp: ocp: Make ptp_ocp_unregister_ext() NULL-aware
  ptp: ocp: Refactor ptp_ocp_i2c_notifier_call()
  ptp: ocp: Apply standard pattern for cleaning up loop
  ptp: ocp: Reuse META's PCI vendor ID
  ptp: ocp: Sort headers alphabetically
  ptp: ocp: don't use "proxy" headers

 drivers/ptp/ptp_ocp.c | 128 +++++++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 58 deletions(-)

-- 
2.50.1


