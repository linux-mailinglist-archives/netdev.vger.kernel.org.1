Return-Path: <netdev+bounces-242291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B7C8E637
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFCC434E686
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163118859B;
	Thu, 27 Nov 2025 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JK/H93T3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE323ABA7
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249329; cv=none; b=iPl8PNr4H6nf0ypG6BkVU05MzF+gmCizg9vSx0D0bgKln/G1PT8d/ElbDAAhUplmvMKJJsmqehae5DCY1RLhO/trdPKnhtWwV2yTAwQbkbMWvsLFrVxM4XJ1iW112oPpkf56u67yBWxo6FVm3cZUEKSE1Sw1s04oVUwMR0ouq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249329; c=relaxed/simple;
	bh=DVOWDqzOzG2oXwBeisXNY0kO+WzqNOm+/EnlVxjDtC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wz2jIac2roIQ9TvhF3Vv3oXNxXs4Ix6subD4zsjz8F5DHlopFqumfKJnv4Je8yVFW77teOCJxPPBSJnhRT+OORdGLDueHIVfiqlrycZEaogZJN1VF3ywQQfDZOnMqKA5lD7JmrjUikog4PNZsU1dAEKbr8U34WudCZq5gX40k4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JK/H93T3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764249329; x=1795785329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DVOWDqzOzG2oXwBeisXNY0kO+WzqNOm+/EnlVxjDtC4=;
  b=JK/H93T3TnLmjD9XfPFG3R2MCHRLxWHBfwp6bmdtgHidPiyYKxSeA+cM
   6vR7yWEu4lGAfbzlD51H0+cd7eNSkiRx1GPAUN79xdsF+4LaT1YraCEL2
   BKd6fK8+r5YNhmfrOplMcTJ/lWfxRYFBvVshr37ET931JLoEs2zteOkPe
   7x1EX+T+ZRekPVpEpTx4I6KAT4PfPG0QLO/bmleCvig8H7Gnn60JmY7D5
   b0Omfzl2wHvjQMsZNNiTNtU43isk5ImPOqvu/ptfbK0822L24dAn79o7B
   w389aoHRvdAODtFHTZTqRiYnWZgG9p/8aQ/3X0JhNitMIHEyb7z8W9HRp
   Q==;
X-CSE-ConnectionGUID: 1P5wcRWsQqeoG+xlL+785Q==
X-CSE-MsgGUID: hhT0LconRdiQC8vs8kBgQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="68888493"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="68888493"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 05:15:25 -0800
X-CSE-ConnectionGUID: 5yPE0U6fS+uUdkNCrogIfQ==
X-CSE-MsgGUID: LrUQoby4TqKlz5KoQh8+1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="193675688"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 27 Nov 2025 05:15:23 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 437C4A0; Thu, 27 Nov 2025 14:15:21 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH net-next 0/3] net: thunderbolt: Various improvements
Date: Thu, 27 Nov 2025 14:15:18 +0100
Message-ID: <20251127131521.2580237-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series improves the Thunderbolt networking driver so that it should
work with the bonding driver. I added also possibility of channing MTU
which is sometimes needed, and was part of the original driver.

The discussion that started this patch series can be read below:

  https://lore.kernel.org/netdev/CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com/

@Ian, please check if this still works for you? I changed your patch
slightly to cope with the various speeds the USB4 link can train.

Ian MacDonald (1):
  net: thunderbolt: Allow reading link settings

Mika Westerberg (2):
  net: thunderbolt: Allow changing MAC address of the device
  net: thunderbolt: Allow changing MTU of the device

 drivers/net/thunderbolt/main.c | 88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

-- 
2.50.1


