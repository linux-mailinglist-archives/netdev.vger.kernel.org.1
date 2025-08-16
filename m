Return-Path: <netdev+bounces-214269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 696BBB28B4B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCAB1BC552D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066FE221FDE;
	Sat, 16 Aug 2025 07:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D9221FD4
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755328216; cv=none; b=U3jg9QBRDvtytFCJtZucc/goiU/FwoXeV92fTaG970Y5GBTxXQiC6uYn3hJqX7syUiWQEBmIiCKIxFMcAsgBOrU4iXpM6ct+b6og5qylfDc4+z+c5qeQU0KOFgPjudZjaqyFBP4AM5h+jF9L+A4wUQcj0Y2gSxqDku1aXmxX1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755328216; c=relaxed/simple;
	bh=Ti3uxkQIv+XAWK9w1jvxxiCG5nGR1f9lx28s1CQLzmw=;
	h=Message-ID:From:Date:Subject:To:Cc; b=Vp2GgtzsOVoEl2xMcZtPtKTsTEegUNMuP41PMSj2+Ugq32sKyY5b+QapgX1iT9O/fC5JpEOz+lasq8qOHVJj9DMDtaz4+xGs7kOGvVZmVlxQX4jpCrkU/oqUUReNpIAIBL0EiogghKr2C59SGRG6IgbetOK8+2j2eUhE+5FcHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with UTF8SMTPS id 9FF5E1A793;
	Sat, 16 Aug 2025 09:10:03 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 55A5C600D2F4;
	Sat, 16 Aug 2025 09:10:03 +0200 (CEST)
X-Mailbox-Line: From 22e7b32bfe524219eb7ff1e5c6b4d91763b79eef Mon Sep 17 00:00:00 2001
Message-ID: <cover.1755327132.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Aug 2025 09:10:00 +0200
Subject: [PATCH 0/3] ice/i40e: pci_enable_device() fixes
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The ice and i40e drivers perform surplus calls to pci_enable_device()
on resume and on error recovery.  This results in the Memory Space Enable
bit in the PCI Command register not being cleared on driver unbind.

Not a catastrophic issue, so although these commits contain Fixes tags,
I recommend applying through next-queue.git to let them bake in linux-next
for a couple of weeks.

I have neither an ice nor i40e card available, so this is compile-tested
only.  I'm hoping Intel validation can test it.

Suggested test procedure:

- Unbind the driver through sysfs without having suspended the card:
  echo D:B:D.F | sudo tee /sys/bus/pci/drivers/ice/unbind
  (replace D:B:D.F with the device address, e.g. 0000:07:00.0)

- Verify with lspci that it says "Mem-" in the "Control:" register:
  lspci -vv -s D:B:D.F

- Rebind the driver:
  echo D:B:D.F | sudo tee /sys/bus/pci/drivers/ice/bind

- Suspend the card, resume the card, unbind the driver, re-run lspci.
  Expected result without this series "Mem+", with this series "Mem-".

For error recovery, the procedure is the same but instead of suspending
and resuming the card, an error needs to be injected.  See the section
on "Software error injection" in Documentation/PCI/pcieaer-howto.rst.

Thanks!

Lukas Wunner (3):
  ice: Fix enable_cnt imbalance on resume
  ice: Fix enable_cnt imbalance on PCIe error recovery
  i40e: Fix enable_cnt imbalance on PCIe error recovery

 drivers/net/ethernet/intel/i40e/i40e_main.c | 29 ++++++----------
 drivers/net/ethernet/intel/ice/ice_main.c   | 38 ++++++---------------
 2 files changed, 21 insertions(+), 46 deletions(-)

-- 
2.47.2


