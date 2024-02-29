Return-Path: <netdev+bounces-75969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4586BCEF
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F85B24D8E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25329CEF;
	Thu, 29 Feb 2024 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1CYPMWe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F281DDDB
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167303; cv=none; b=F2uhjuJ87YsGd0UVB5gcetTJ2+KgE6RoLkNrsFP5un8N6oSUrAoj8L2oR/3HOZTES+1oXmoPXcgKAf7P4s16A46AVKhaLJ5ZTKfxlOcAar/x37BJ3Eotlyx+66N0Lwy4CkeOD152jY+1NRhOc4pU12Yv/nDvJOtOLTAa9Vo2O58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167303; c=relaxed/simple;
	bh=lv+1EL61C8vlYENTLuOj5fP1ULB28NEow8zeskhcUTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF4pjjrTNfAMFbaXLwQNQLyS+vwdA0XdnZOCUpMCmme5h5vrAQPG7AHB2cRv/NfGf0rr3YjW9YZu4HVyxSak03YOiJidibmSlA1AH9C2Cpvsj6AtPFNLhUcTq1/1JervOdb169bOs4aWZKhzGFaaSxCENTIYn7ZU0q3XGhG1LRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1CYPMWe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167303; x=1740703303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lv+1EL61C8vlYENTLuOj5fP1ULB28NEow8zeskhcUTA=;
  b=E1CYPMWedSjo9Pv+We8kH3rtKq/uMczht1nGOxmknpR6w61g6FH7BfK0
   vCbLxFsXSZbgH4nu3CerwoxC5SROcJqu67lPqpu/cAugB/HPP8dmZ7Apb
   yg/6x9a0/phc/mZx0t0p/OPmQp6mhkq0W+W6yT6gKECHiYRmLmy+Jjv0N
   wjbtLVTUNo5MmqD6zD0DgJtsCKctYaDTa9pCRJqZKnUVOpbzaqs+CIgz7
   GPh2Mf6blvAaJctPOk5Ipzzm2TTQaGLOuyBm6HWFd7MBFCFyJYky6B391
   T+1Rus5/gYttPnsaWZ+NzWyar0J02JVNZSlgr41y/lPY7mqBafoQys1fA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3776523"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3776523"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:41:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12281952"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 16:41:39 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	anthony.l.nguyen@intel.com,
	andrew@lunn.ch,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH net-next 3/4] igc: fix LEDS_CLASS dependency
Date: Wed, 28 Feb 2024 16:41:31 -0800
Message-ID: <20240229004135.741586-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
References: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
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


