Return-Path: <netdev+bounces-73482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D2A85CC52
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A128410E
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65EE154C0A;
	Tue, 20 Feb 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRjj+tTW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8936A154429
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473442; cv=none; b=D9GcSLTqtTXjzhZKjL2XAfEBmB60wRnnmOe52iha8U7IcqO3PA3QjgKen0aYfcA4fMu6CsB8KDo1Ar46eF8rj5iB7iLaEBCrs2gnrtRjRo0XtdH0ZlUA6dbMlfgiVxvTA8HGVxS+iFaYWc1avmcRRimUhqGn4Vd/XkBzJcF3K0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473442; c=relaxed/simple;
	bh=J/HISYfX3p/bcLAW10Rix4cZqovbkcRYLd3vkTcS0p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HksUfgUZN1rJ1XaW6QwV5W+Vt5Ux6nSCLSAWxD16a3LBTidm7BQVF9Gfk3zTq5W/Ngq2VDiGfqZcNS9tVS9tgQuEoN1FWs1e7uGoayVOuv2M2x5yuKVFO1RitPKY0a45gfYzV7ZQPcPe9unptZKbOjR6toI3QKyao/Fiq/9/IIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRjj+tTW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708473441; x=1740009441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J/HISYfX3p/bcLAW10Rix4cZqovbkcRYLd3vkTcS0p4=;
  b=KRjj+tTWsTfdTxto89zu1REYXzv2nL8ffO6QJrDdmKHmL4g26O5RKIH6
   J7ILKLzRetXnrI2I6rsrB84kKMAJX2elw8ZF+z9cluF9D8yVTmu5p7cwl
   M/spOcgZZnYnyLNQ0qBGAI1O57ajIHWmUfyLbrXtk76kBIvxK3L0Umpaq
   pf/6zW5aanSLkX7syNL7+Q5k6ZCKKLwX4xv/s3MKOPjvHCHgqk+dGERo0
   RTIF8Y8vrsXaiwaugcL7XsgcBKtzpK6n4HszHSyDzky9pzegFnseMx4Nt
   97Fawj0OJ0rFrop0o2kKhzfRDd8aAp+R6KhHj2917GHvFSudkCoMOQAJ2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20041759"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="20041759"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:57:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5092384"
Received: from vcostago-mobl3.jf.intel.com ([10.24.14.83])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:57:19 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: sasha.neftin@intel.com,
	richardcochran@gmail.com,
	kurt@linutronix.de,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	netdev@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [iwl-net v2 0/2] igc/igb: Fix missing time sync events
Date: Tue, 20 Feb 2024 15:57:09 -0800
Message-ID: <20240220235712.241552-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes from v1:
 - Reworded cover letter and commit messages, so it's clear that the
   issue is when the same kind of event happens "twice" it might be
   ignored (Richard Cochran);

Link to v1:
https://lore.kernel.org/all/20240217010455.58258-1-vinicius.gomes@intel.com/

It was reported that i225/i226 could sometimes miss some time sync
events when two or more types of events (PPS and Timestamps were used
by the reporter) are being used at the same time under heavy traffic.

The core issue is that the driver was double clearing interrupts, as
the register is both "read to clear" and "write 1 to clear"
(documented in section 8.16.1 of the datasheet), and the handler was
doing both. Which could cause events to be missed if the same kind of
event that triggered the handler happens again between the "read" and
the "write".

Removing the write fixes the issue.

It was tracked down to commit 2c344ae24501 ("igc: Add support for TX
timestamping"), in which I added support for basic timestamp
operations, the issue is that as the hardware operates very similarly
to i210, I used igb code as inspiration. And indeed, the same double
clearing is present there.

But in the igb case, I haven't seen myself or heard about any issues
that seem related to this. So I think it's more like a possible issue.
But it seems like a good idea to fix it there was well.


Vinicius Costa Gomes (2):
  igc: Fix missing time sync events
  igb: Fix missing time sync events

 drivers/net/ethernet/intel/igb/igb_main.c | 23 +++++------------------
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +-----------
 2 files changed, 6 insertions(+), 29 deletions(-)

-- 
2.43.2


