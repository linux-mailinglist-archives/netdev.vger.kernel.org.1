Return-Path: <netdev+bounces-251817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGRGN36fcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:42:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC05496A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B086B081
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691333EF0AE;
	Wed, 21 Jan 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLQaK4lK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E693D6484;
	Wed, 21 Jan 2026 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987414; cv=none; b=Db82wbuop8wM6AB4cgXKHp/oW6/suS3pvZEVT1lcvYGno7V9gXLwbrznu4pkcrAjMYZQQi4o+RJa5UiQXe/axlhS3bRaTZlOEOug7qAqsT443qaHw+AULGCjwN5BX+p1YStEFDcKSKjAvjZ94zPzdzaFv1uwrZiHK9s6KOhkHoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987414; c=relaxed/simple;
	bh=KfeL1TiAvVptwUvPNVDQKbVtzqvMcK/iSbSYoTERcbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmSyFh5lmFaC4JWHw3zud9OTdpi9uW0Wb3fjMvqSu3zWwUuMbBIbLhoORXp/AGACRbOcfufWtO2rxReLbmtUgF0zhqYFgpy7W7VMo2lzcsauxd0vdcUESJA/rtt5BMBdPipXQJNdL9e5Y+frP7qP4vB7S+mQ/j95ZeAoThNJhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLQaK4lK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768987412; x=1800523412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KfeL1TiAvVptwUvPNVDQKbVtzqvMcK/iSbSYoTERcbM=;
  b=hLQaK4lKELgZPJ5LnE9N5HwwQ1DQIhNYgc6DUX8ICSzviyrilvrLk2zD
   diwHrYWXjbQXjn4LHcBp8LV0wzqVOeLV7M3v8m5XspQ6MNs6vNf2YpDL7
   n6iIIsMFoFJFQ4jkFJk++6OHSIsz5RiEVRCfvqRkj2psRg7ujGxY7MRil
   bwyP4n7P7oiotbWYZR5IPj33mWN8VoCS0hg33HroCN8P+I3lqdlYqvwh9
   ewv0qRGRPh8vQdIP+SxQohGsMtgQ8jUb0Pwgcxnhnc43IWh1XoH4Koc1N
   UGyeX5huwyMLAdkUB+eulHp37RjjuL8IHZaOIXDDtLYg30ccTFyfC7BnP
   A==;
X-CSE-ConnectionGUID: Se4b6urtQ9KmBxWT1onB5Q==
X-CSE-MsgGUID: srnCU7/GRnGa3nnQeeT9yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57773272"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="57773272"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:23:31 -0800
X-CSE-ConnectionGUID: bSvAuDOYSNGcpxTOJ9bn1A==
X-CSE-MsgGUID: mMGLzKjqQuOAZRdjln0Nlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210560977"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2026 01:23:30 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] i2c: SMBus ARP support
Date: Wed, 21 Jan 2026 10:23:24 +0100
Message-ID: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251817-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 48AC05496A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Changed in v2:

- Using kzalloc instead of kzalloc_obj. kzalloc_obj() is clearly not ready yet
  (scripts/checkpatch.pl should not promote it yet).

Original cover letter:

I know there has been a couple of PoCs for ARP over the years, but for
what ever reason none of them were ever made part of the kernel. I
don't know how common ARP-capable devices are, but since they do
exist, we really should enumerate them as intended. I'm guessing that
in Linux ARP-capable devices have so far been left mostly undetected.

The problem I'm trying to tackle with these is to detect SMBus devices
on discrete components like PCIe cards. We obviously won't have any
kind ACPI or DT description for those, so we would always have to
create the device for them in the drivers. Unfortunately in some cases
it's actually very difficult to know what exactly is attached to the
I2C on those cards because the vendors can put what ever they like
there - this is the case at least with some of the GPUs it seems. But
luckily those I2C/SMBus devices are at least in some cases fully
ARP-capable.

I'm including a patch that binds the detected ARP-capable MCTP devices
to the driver. There is also a target mode test driver.

thanks,


Heikki Krogerus (4):
  i2c: SMBus Address Resolution Protocol implementation for host side
  i2c: Sysfs attribute files for the Unique Device Identifier fields
  mctp i2c: Enable SMBus ARP discovery
  i2c: Add SMBus ARP target mode test driver

 Documentation/ABI/testing/sysfs-bus-i2c |  53 ++++
 drivers/i2c/Kconfig                     |   6 +
 drivers/i2c/Makefile                    |   3 +-
 drivers/i2c/i2c-core-arp.c              | 334 ++++++++++++++++++++++++
 drivers/i2c/i2c-core-base.c             | 154 ++++++++++-
 drivers/i2c/i2c-core.h                  |   8 +
 drivers/i2c/i2c-target-arp.c            | 201 ++++++++++++++
 drivers/net/mctp/mctp-i2c.c             |   8 +
 include/linux/i2c-smbus.h               |  67 +++++
 include/linux/i2c.h                     |  10 +
 include/linux/mod_devicetable.h         |  13 +
 scripts/mod/devicetable-offsets.c       |   8 +
 scripts/mod/file2alias.c                |  24 ++
 13 files changed, 878 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c
 create mode 100644 drivers/i2c/i2c-core-arp.c
 create mode 100644 drivers/i2c/i2c-target-arp.c

-- 
2.50.1


