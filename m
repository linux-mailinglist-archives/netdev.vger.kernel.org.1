Return-Path: <netdev+bounces-95976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A898C3F05
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3D9283567
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0D81465BC;
	Mon, 13 May 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBg8p0To"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7A5644E;
	Mon, 13 May 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596704; cv=none; b=WdM694C4+8SyLgrBv9eNDWxKo1vnP9w86n9JEATlUWf8kb19in9wUaZ3Xrl6tmqgxJG0WJ1C/Sw4VRjsL4JDBLzjoAhK9ojDMBVg2EkbMiLoeU5y3AhVKsuOOKQfB2EH+sEFK1ZN00/XiWgKypw56PAKI+dX2nvkKiurgeY+dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596704; c=relaxed/simple;
	bh=PnSf5QSmfUU+CTS4QGYrbzhcMfqC24X3tCBFndJHIx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nBrKbje/5vqHZZFIsAEVO/D/NiwjKezXYlnW26qXeAsVfRIEdCqv4W7Z9v31qzkOaDANSab6fD4iMDll8lV5u0CYxwCO08SOsSuDDMtu48x6c9pPuTJ1849zKxk4QS5gZEgVN14UixTG8H/APjYt4HWAqR9MVG89BcN4rQMHKmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBg8p0To; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596702; x=1747132702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PnSf5QSmfUU+CTS4QGYrbzhcMfqC24X3tCBFndJHIx8=;
  b=aBg8p0ToU+WjbL37rQUCvsg2tdT0yHyzuFr9qedeZRYVyUaQALTJaIXw
   86xurPw7eMfWaz5Gom1+2g/Un6g3/bMdvI8UwJYF8orl/Bbvc0UUXkZ6j
   R5g+VvbAXAGS4GPcuqc2F62KP2MnR8Oao8QkJ1nAeVTrECN3eqitNSOt1
   GaojKhd30WK/GbDDpUURmiJuj7CMut1jYNcS2iOHRGg+CSOg3D0LkxF/Y
   7IUpo1yI+UqsfwPsRmb5jGpB6AEgrZsohfDrTRrX9+NBlxVY2jVKGb1kT
   1YXp0OmycH60lcbaQnTpj8uWjhkb6pFqWNPZvb8GChtTAwy83iUVEN8Lp
   Q==;
X-CSE-ConnectionGUID: hAk1hGoZQOezSynVY2lShQ==
X-CSE-MsgGUID: t5u3RZh2SN+h6Q24fvjmeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29038818"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29038818"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:38:20 -0700
X-CSE-ConnectionGUID: s6/CyCvhSPy2aJxepqg0dg==
X-CSE-MsgGUID: O2wwoNH0SsWgIoxZYnqIQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61481684"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:38:14 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v8 00/12] Add support for Intel PPS Generator
Date: Mon, 13 May 2024 16:08:01 +0530
Message-Id: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The goal of the PPS (Pulse Per Second) hardware/software is to generate a
signal from the system on a wire so that some third-party hardware can
observe that signal and judge how close the system's time is to another
system or piece of hardware.

Existing methods (like parallel ports) require software to flip a bit at
just the right time to create a PPS signal. Many things can prevent
software from doing this precisely. This (Timed I/O) method is better
because software only "arms" the hardware in advance and then depends on
the hardware to "fire" and flip the signal at just the right time.

To generate a PPS signal with this new hardware, the kernel wakes up
twice a second, once for 1->0 edge and other for the 0->1 edge. It does
this shortly (~10ms) before the actual change in the signal needs to be
made. It computes the TSC value at which edge will happen, convert to a
value hardware understands and program this value to Timed I/O hardware.
The actual edge transition happens without any further action from the
kernel.

The result here is a signal coming out of the system that is roughly
1,000 times more accurate than the old methods. If the system is heavily
loaded, the difference in accuracy is larger in old methods.

Application Interface:
The API to use Timed I/O is very simple. It is enabled and disabled by
writing a '1' or '0' value to the sysfs enable attribute associated with
the Timed I/O PPS device. Each Timed I/O pin is represented by a PPS
device. When enabled, a pulse-per-second (PPS) synchronized with the
system clock is continuously produced on the Timed I/O pin, otherwise it
is pulled low.

The Timed I/O signal on the motherboard is enabled in the BIOS setup.
Intel Advanced Menu -> PCH IO Configuration -> Timed I/O <Enable>

References:
https://en.wikipedia.org/wiki/Pulse-per-second_signal
https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-DxLW6t_V/view
https://youtu.be/JLUTT-lrDqw

Patch 1 adds base clock properties in clocksource structure
Patch 2 updates tsc, art values in the base clock structure
Patch 3 - 7 removes reference to convert_art_to_tsc function across
drivers
Patch 8 removes the convert art to tsc functions which are no longer
used
Patch 9 adds function to convert realtime to base clock
Patch 10 adds the pps(pulse per second) generator tio driver to the pps
subsystem.
Patch 11 documentation and usage of the pps tio generator module.
Patch 12 includes documentation for sysfs interface.

Please help to review the changes.

Thanks in advance,
Sowjanya

Changes from v2:
 - Split patch 1 to remove the functions in later stages.
 - Include required headers in pps_gen_tio.

Changes from v3:
 - Corrections in Documentation.
 - Introducing non-RFC version of the patch series.

Changes from v4:
 - Setting id in ice_ptp
 - Modified conversion logic in convert_base_to_cs.
 - Included the usage of the APIs in the commit message of 2nd patch.

Changes from v5:
 - Change nsecs variable to use_nsecs.
 - Change order of 1&2 patches and modify the commit message.
 - Add sysfs abi file entry in MAINTAINERS file.
 - Add check to find if any event is missed and disable hardware
   accordingly.

Changes from v6:
 - Split patch 1 into 1&2 patches.
 - Add check for overflow in convert_ns_to_cs().
 - Refine commit messages.

Changes from v7:
 - Split the if condition and return error if current time exceeds
   expire time.
 - Update kernel version and month in ABI file.

Lakshmi Sowjanya D (7):
  timekeeping: Add base clock properties in clocksource structure
  x86/tsc: Update tsc/art values in the base clock structure
  x86/tsc: Remove art to tsc conversion functions which are obsolete
  timekeeping: Add function to convert realtime to base clock
  pps: generators: Add PPS Generator TIO Driver
  Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
  ABI: pps: Add ABI documentation for Intel TIO

Thomas Gleixner (5):
  e1000e: remove convert_art_to_tsc()
  igc: remove convert_art_ns_to_tsc()
  stmmac: intel: remove convert_art_to_tsc()
  ALSA: hda: remove convert_art_to_tsc()
  ice/ptp: remove convert_art_to_tsc()

 .../ABI/testing/sysfs-platform-pps-tio        |   7 +
 Documentation/driver-api/pps.rst              |  22 ++
 MAINTAINERS                                   |   1 +
 arch/x86/include/asm/tsc.h                    |   3 -
 arch/x86/kernel/tsc.c                         |  92 ++-----
 drivers/net/ethernet/intel/e1000e/ptp.c       |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   3 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c      |   6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |   3 +-
 drivers/pps/generators/Kconfig                |  16 ++
 drivers/pps/generators/Makefile               |   1 +
 drivers/pps/generators/pps_gen_tio.c          | 259 ++++++++++++++++++
 include/linux/clocksource.h                   |  27 ++
 include/linux/clocksource_ids.h               |   1 +
 include/linux/timekeeping.h                   |   6 +
 kernel/time/timekeeping.c                     | 124 ++++++++-
 sound/pci/hda/hda_controller.c                |   3 +-
 17 files changed, 495 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

-- 
2.35.3


