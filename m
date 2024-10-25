Return-Path: <netdev+bounces-139190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621699B0D7C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 20:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946501C22E24
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC012022EC;
	Fri, 25 Oct 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcg6UJ+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF5206505
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881543; cv=none; b=cAjJD+h7ZAUuJEoRAU4iUINxg5cO7OZ+uMfKBHZ4DUSpKmwhzj99yokQUjaNmG2klltsOzh+8OIFL7B4ZAgKqecU4HYiC+68d4U+GvWOxlSY7mvPds5EdtBitWsZ/AkkfGDGFN4Y3DdOZvsHHk/MtxQW8traTMiWqjjhNDCp7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881543; c=relaxed/simple;
	bh=o3VmDNwDVed1ZPr8iIGkh6V+TiXqw1F1xyEiJ9QakhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJqBulZPmUzMhyErS1mIiVAVvpfzZUjF6upxjMfCqzCi8YvIlQmv9N91oIdfHDasaTvaZOxLlRMND17QrRaF/rGjyQ7QQVCpzZVcvbKp6LFGaHuHe6Mf1uQOFoly7m0ZTlcjeUP7/f4cm6Y1IMFqK7TI6CgSUBP8y3KTL5f4OFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcg6UJ+Q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729881542; x=1761417542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o3VmDNwDVed1ZPr8iIGkh6V+TiXqw1F1xyEiJ9QakhY=;
  b=jcg6UJ+QzZZO0L2ermxD0zMVmD/4yDjFW0gRTkSAEHQXb8P/mn67KwbV
   ljrtsfkKf2VJCAoY7oG0gcuxrn8qBK3fPZufkeNAnDrzhYlO8iyXRFg19
   9qURbQbBjbicMwA8MAIpa7t/RGT+Rb39azbpKcne1b2emrcDoz+SJLBm4
   S2YX30TCvkQ5hugGbODc5BYxV6CBrP5nTJknjBzJC6LFAdH2Ol8d8LBer
   Zb3jYRId6sjOMpjp4z+MAH5VoMmjdsefPW/QLYPoAhdqcXHAC0g4m9zDW
   1VjSkbueDhG5OEph4ymx1EVafu6t2i44JdPYyCBbE9KcEwmeswwE9lZaw
   w==;
X-CSE-ConnectionGUID: M+DV0ox8SqODuOwgOi04+Q==
X-CSE-MsgGUID: 1x1O79T6TvW++MoEOnsDIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="47043911"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="47043911"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 11:39:01 -0700
X-CSE-ConnectionGUID: Cvf2kGCFSn6ABUO5s1+uVg==
X-CSE-MsgGUID: Ryrfvuq1QZqUgMr9jf1lxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="111801062"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
  by fmviesa001.fm.intel.com with ESMTP; 25 Oct 2024 11:39:01 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-net v2 0/2] fix reset issues
Date: Fri, 25 Oct 2024 11:38:41 -0700
Message-ID: <20241025183843.34678-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes reset related issues, especially the case
where the idpf is running on the host and the platform running
the device control plane is rebooted. The first patch fixes the
link_ksettings and the second patch fixes the error path in
idpf_vc_core_init function.

Pavan Kumar Linga (2):
  idpf: avoid vport access in idpf_get_link_ksettings
  idpf: fix idpf_vc_core_init error path

 drivers/net/ethernet/intel/idpf/idpf.h          |  4 ++--
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c  | 11 +++--------
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  5 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c |  3 +--
 4 files changed, 9 insertions(+), 14 deletions(-)

-- 
2.43.0


