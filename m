Return-Path: <netdev+bounces-76697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E27586E8B8
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3151C25BB5
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5F13AC26;
	Fri,  1 Mar 2024 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2Q859CD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B939FC0
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318949; cv=none; b=hqA0tufrSNkHclyIp5gymensfGyuwME3FQVSvg3EhKwTBETcvkr6JzaS3wb4gn1SxuT+sWqv6RJ7k/pFhV0G5kfKpvf8Saux9KOMLsn/PAPTCJJ6D7HSi5Vw7WFQ+/ftMIHihbPsAwkW6z3znaDYbya46Q7VjE0Y1GRBOt64SrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318949; c=relaxed/simple;
	bh=lv+1EL61C8vlYENTLuOj5fP1ULB28NEow8zeskhcUTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toIr0O6QQckOO4YrBepkjTSvk+WicWESIP4ewHJlwiPgWjnEFiqotpeFUrHpH3H3JkUTltXo99m7x1bi2XAjsAFgHPtfAEEhBD2BdCsHd7ZSbgyhw62D0glR+grxBFfghvbdxMAo+KlPcQD7eC418KcO1nxisap0TsjY/fPyYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2Q859CD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709318948; x=1740854948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lv+1EL61C8vlYENTLuOj5fP1ULB28NEow8zeskhcUTA=;
  b=I2Q859CDtzJArX8BlHgk2OjnhBxmgbXZ4ZQEd0TfwRK45r3GFBPcF5fp
   8bWQitqpvIV6l90vjEm4ucsXdVFGhKIRGO6JwJM9zu2lMlEAVlHqT+/oW
   iI0b9XSpQrkqMbIXATPg/SZdwACtx3yu5U79aeIGNAKPotpdQOcDyNtP1
   vpuTSE6cPZV3dJ2HT2Wyk0tLTHs7xPTpPdmgZA/s/6MVcyAXkoJfvxlgD
   0tscyPVf1eEdb5oMB4kohrdOCad0z5ZCXfmx+SlTDASQm4gQvptVxtljV
   Dbl8fLoA7rp+QH3R2+5ADQQ8V/6jmN2gnOa/0ifAbrIGkCtLvljT3RHF8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15303342"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15303342"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8205865"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Mar 2024 10:49:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	andrew@lunn.ch,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH net-next v2 3/4] igc: fix LEDS_CLASS dependency
Date: Fri,  1 Mar 2024 10:48:04 -0800
Message-ID: <20240301184806.2634508-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
References: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When IGC is built-in but LEDS_CLASS is a loadable module, there is
a link failure:

x86_64-linux-ld: drivers/net/ethernet/intel/igc/igc_leds.o: in function `igc_led_setup':
igc_leds.c:(.text+0x75c): undefined reference to `devm_led_classdev_register_ext'

Add another dependency that prevents this combination.

Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 767358b60507..639fbb12bd35 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -372,6 +372,7 @@ config IGC
 config IGC_LEDS
 	def_bool LEDS_TRIGGER_NETDEV
 	depends on IGC && LEDS_CLASS
+	depends on LEDS_CLASS=y || IGC=m
 	help
 	  Optional support for controlling the NIC LED's with the netdev
 	  LED trigger.
-- 
2.41.0


