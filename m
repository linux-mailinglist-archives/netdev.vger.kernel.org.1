Return-Path: <netdev+bounces-36156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 755AE7ADC6F
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7BDFF1C204F7
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B57219E6;
	Mon, 25 Sep 2023 15:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32371D523
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 15:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9A6C433C8;
	Mon, 25 Sep 2023 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695657345;
	bh=rN0uGksTsjjZcDvJoDF3ojsWN3x8dp/ouj45xZwSJk0=;
	h=From:To:Cc:Subject:Date:From;
	b=ZeSxKHD8awdCQpyc+AmXEnCINpiHWRHmuxMjQHRNleoNgUimp12V6NimZJ5leP2Dl
	 VigvkgTW4Z4na1THj7U3QaABkK7I5SMzHdb3EK6rm7R/6/EDXS/GIGMn2QS/hRtDl0
	 JLVSRoBLUooPh6JdJpwCXonRKeNCtnO/qXVjAP5QFzVvL+cgMD2JD3X1ugwDCLciYF
	 XPKTF9DSiXymyKdPKn8pskySFsg1hlX96ZJsKpsczl0LwtB9DZcPLJZgsoedO6eqYY
	 lFZP4DpxMe0Zr3itYNaBICeggTRwyqEVDvs+MZFrHon2+XX4JJLZPx/hZ1t8DCnwB4
	 ah8irPdxmaw7g==
From: Arnd Bergmann <arnd@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ice: require PTP clock for building
Date: Mon, 25 Sep 2023 17:55:24 +0200
Message-Id: <20230925155538.526317-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A previous fix added PTP as an optional dependency, which was correct as
of commit 87758511075ec ("igc: fix build errors for PTP"), but this
has recently changed with the PTP code getting more deeply integrated
into the ICE driver.

Trying to build ICE when PTP is disabled results in this internal link failure
as the local functions are left out of the driver:

ERROR: modpost: "ice_is_clock_mux_present_e810t" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_is_phy_rclk_present" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_cgu_get_pin_name" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_get_cgu_state" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_is_cgu_present" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_get_cgu_rclk_pin_info" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_cgu_get_pin_type" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_cgu_get_pin_freq_supp" [drivers/net/ethernet/intel/ice/ice.ko] undefined!

I tried rearranging the code to allow building it again, but this was getting
too complicated for an outsider, so just enforce the dependency to fix randconfig
builds again, until someone wants to clean this up again.

In practice, any configuration that includes this driver is also going to
want PTP clocks anyway.

Fixes: 8a3a565ff210a ("ice: add admin commands to access cgu configuration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index e6684f3cc0ce0..c452ecf89b984 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -278,7 +278,7 @@ config ICE
 	tristate "Intel(R) Ethernet Connection E800 Series Support"
 	default n
 	depends on PCI_MSI
-	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on PTP_1588_CLOCK
 	depends on GNSS || GNSS = n
 	select AUXILIARY_BUS
 	select DIMLIB
-- 
2.39.2


