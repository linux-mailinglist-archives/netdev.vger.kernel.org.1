Return-Path: <netdev+bounces-78543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB3875A32
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 23:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3131C20B22
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F97A13E7CC;
	Thu,  7 Mar 2024 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5mSNJUV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261B1369A6
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850329; cv=none; b=iA4NOwpX3jb2afChf6fyF/LJykLPSKYTaLjsVHhs4y22wxBv4tCY4uyAzhQkYjlb6mbTOUyxlB1D115KlUAry1fC/38zGUHJyrjZhDX/+ArE8LKWlIIGQieWLt938WbEQzXVf1T3gF8Pst7yRrjUiOTuT2stGiSarmqJA5evVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850329; c=relaxed/simple;
	bh=nYYSd+qMM/bhPo2hHv27g+MdOfP2XOmBIDM4y4V2oGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6oCMQZGa+Hri+YCfQQBuZcImSUZeCuzprQgJk4eoHWS9xPqL7iLmbgWjq51w1/qtgp13b6syRDP8kGWVkdqYU+TVDlmEcbrG4B8NNxVvMg0XKY8693Omvhl1bzzv9lDc1KL/jHOkzNgN5LJjtL0JD2L8YcMA+2gWPsCCy3ENz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5mSNJUV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709850326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HFvr6B/TP+qGz9HSRoKDXnwBHxBaTqxjGFIt+HBqEDI=;
	b=Q5mSNJUV0gWrnV2A5+mxDHQiGraedhrYkjPbeXZ7p2ZAs+w0zDfGdFcKHGBAi8g6YAmsff
	hTP4pHxg18d1mNG75TDeRxezE2X/jfsbMp5SHjXhDtnwUNfODMlLoSCbA9o+rBwDDfO1Y9
	qPdoM1yTSLWN6dJNtzcSdbtQNHxGPsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-eS5mvd5cMbeCZhE-fGYD5A-1; Thu, 07 Mar 2024 17:25:22 -0500
X-MC-Unique: eS5mvd5cMbeCZhE-fGYD5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AB3588F2EA;
	Thu,  7 Mar 2024 22:25:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.224.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE20B1C060D6;
	Thu,  7 Mar 2024 22:25:19 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH net-next v3 0/3] ice: lighter locking for PTP time reading
Date: Thu,  7 Mar 2024 23:25:07 +0100
Message-ID: <20240307222510.53654-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

This series removes the use of the heavy-weight PTP hardware semaphore
in the gettimex64 path. Instead, serialization of access to the time
register is done using a host-side spinlock. The timer hardware is
shared between PFs on the PCI adapter, so the spinlock must be shared
between ice_pf instances too.

Replacing the PTP hardware semaphore entirely with a mutex is also
possible and you can see it done in my git branch[1], but I am not
posting those patches yet to keep the scope of this series limited.

[1] https://gitlab.com/mschmidt2/linux/-/commits/ice-ptp-host-side-lock-9

v3:
 - Longer variable name ("a" -> "adapter").
 - Propagate xarray error in ice_adapter_get with ERR_PTR.
 - Added kernel-doc comments for ice_adapter_{get,put}.

v2:
 - Patch 1: Rely on xarray's own lock. (Suggested by Jiri Pirko)
 - Patch 2: Do not use *_irqsave with ptp_gltsyn_time_lock, as it's used
   only in process contexts.

Michal Schmidt (3):
  ice: add ice_adapter for shared data across PFs on the same NIC
  ice: avoid the PTP hardware semaphore in gettimex64 path
  ice: fold ice_ptp_read_time into ice_ptp_gettimex64

 drivers/net/ethernet/intel/ice/Makefile      |   3 +-
 drivers/net/ethernet/intel/ice/ice.h         |   2 +
 drivers/net/ethernet/intel/ice/ice_adapter.c | 109 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.h |  28 +++++
 drivers/net/ethernet/intel/ice/ice_main.c    |   8 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c     |  33 +-----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |   3 +
 7 files changed, 156 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h

-- 
2.43.2


