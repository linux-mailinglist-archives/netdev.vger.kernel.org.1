Return-Path: <netdev+bounces-94475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A538BF983
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D621F23CBB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496774E26;
	Wed,  8 May 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLoxZ8fh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC421DFE8
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160234; cv=none; b=k6flxXLBvXWKbc6t/Gy6+gBIIQZf9RMS6tlkS6lv6Fx7chipAMDlt8g3MIWxO70Jg0YByIxz/eMJxZBAbLURAfcqQHWo5uXD4Kxhda9WFME1+CC0A2JZ8X0+yhwnB6xlrxe8RltH4KE4pDyuANJYI66chqqOADimUq4eNeyNn/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160234; c=relaxed/simple;
	bh=yv3lJE2VQ0yuLGVVwgXC/vs5DLX/Pl8uMwFZpj3YohQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ljK26ZN5B/S8JlP489yXAbLdoc8UocXEZyW9n/xPA00f9k4w+TzJwEZSAq+WtR4qq4aO2tucrFIV9qlQa24zO8DPaY1b5w5Nx/UMTSCbaeUd6EOSq3nfl3Bc1mxKEDZIVkKRscrz75M/mZ2Mjjmjm6Kd2wCBJV47F5Fh2T2oURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLoxZ8fh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715160233; x=1746696233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yv3lJE2VQ0yuLGVVwgXC/vs5DLX/Pl8uMwFZpj3YohQ=;
  b=JLoxZ8fhJgF/9283w/Is3x5TJWcG50ZSz4Ktx1z6omzFJFtlkr/Ft3hs
   7t6vuWCJYg9cDrHN0v3U7+CzAGU2IffO9FObCV68Vm7vk2z9ryFikvHDB
   AFkO57qpl+WQCHhjCIAqhVYImbSEYAnPKMbj8pDTmhZWL/xsGh8yE4lHf
   jDAumOptYR2ZjTV9zKlyI9dwWg8zdXNfIyPabYi8zRAbtFpfmKgQ4U1Wo
   wdq1sbBg+gHCvJRHmwBXc4wC7Fd3BAk5I8N7VlFcS6tcm1D68dM6podzM
   nELF/IvZ/Hx+VJINmSfpL3OYREtztZBzafkWhnEi8y88/zfqnA/NUX2TO
   Q==;
X-CSE-ConnectionGUID: TEEVWJbbT2Wo88CVvNw5gw==
X-CSE-MsgGUID: uGEOpC5QR96KUs3dy4L6pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22400623"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22400623"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:23:52 -0700
X-CSE-ConnectionGUID: k2+5WQNTTqSDs1ygAUpEGg==
X-CSE-MsgGUID: XY9dplqeSBiZDn6iO/3hwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33305403"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2024 02:23:51 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: ross.lagerwall@citrix.com
Cc: anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	javi.merino@kernel.org,
	netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: Fix enabling SR-IOV with Xen
Date: Wed,  8 May 2024 11:23:21 +0200
Message-Id: <20240508092321.83776-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <CAG7k0ErF+e2vMUYRuh2EBjWmE7iqdOMS1CQv-7r18T1mVbK1aA@mail.gmail.com>
References: <CAG7k0ErF+e2vMUYRuh2EBjWmE7iqdOMS1CQv-7r18T1mVbK1aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

This patch makes sense since VFs need to be assigned resources (especially MSI-X interrupt count)
before making these VFs visible, so that the kernel PCI enumeration code reads correct MSI-X
interrupt count for the VFs.

Regards,
Sergey

