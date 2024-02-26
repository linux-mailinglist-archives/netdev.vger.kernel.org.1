Return-Path: <netdev+bounces-74972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318708679E6
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DBC1C2BB5C
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7738F12CD96;
	Mon, 26 Feb 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdagfNOL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886AE12DD89
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960319; cv=none; b=hW4fpYEAZjKAEEfT0hmgirA0R8sKDUEvK4tI0eVnsboGIL7dY3Rw1wOKBt9+xqz1GqTty9Ia/RkfMpBMME774gnSFno7VY6ABvaZ5lAK0xbguzeuOs8QcTdhTW0k2IwpDo5v7M4++ev5JbQ8ClrUh8BUmAGlzgNqe+I6sDjQ/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960319; c=relaxed/simple;
	bh=Izt8MSglQMxpxfMiPFl8cRrAaQ+cYDAR+BVYdR5T2l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=td3mLtM0FTjCEtVGHurh6af1j3+XC4g96hSuxqxr6kbHV2hWeshU54tmLrzaJiOf23me5OSaTV0/zLQ6HDBiTsT42+oH46bJzaPp2rHrGybjkbfqzA7HnJnue4isdfqgt6V2ZOeuePPcVmUfwOpGJ/bmvj+91gFAt2EWC/vJOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdagfNOL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708960316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=arjLEsNVAf2p6iVSRF6nLA+wY3OMCZil0QQSx73WkXI=;
	b=HdagfNOLfriy3Y9Yun226d2F66HID7vA/J2sRM8EKk7N8JTEqJdORqrg0UKt2Kq7f9d8Tb
	2ZAhs41X7HHxCIRuJJIoldQ8Kn75XzLthArrHUEUtw1pU3TMYa6lL716AgkkK78P31zPNJ
	Ko1J/A5Ofuaq8zfy1kA6uRo5+FqFscE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-U5OoBLd2OTyeB97jKBdtjw-1; Mon, 26 Feb 2024 10:11:52 -0500
X-MC-Unique: U5OoBLd2OTyeB97jKBdtjw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DDC9185A781;
	Mon, 26 Feb 2024 15:11:52 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.226.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 500EC492BC6;
	Mon, 26 Feb 2024 15:11:50 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] ice: lighter locking for PTP time reading
Date: Mon, 26 Feb 2024 16:11:22 +0100
Message-ID: <20240226151125.45391-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

This series removes the use of the heavy-weight PTP hardware semaphore
in the gettimex64 path. Instead, serialization of access to the time
register is done using a host-side spinlock. The timer hardware is
shared between PFs on the PCI adapter, so the spinlock must be shared
between ice_pf instances too.

Michal Schmidt (3):
  ice: add ice_adapter for shared data across PFs on the same NIC
  ice: avoid the PTP hardware semaphore in gettimex64 path
  ice: fold ice_ptp_read_time into ice_ptp_gettimex64

 drivers/net/ethernet/intel/ice/Makefile      |  3 +-
 drivers/net/ethernet/intel/ice/ice.h         |  2 +
 drivers/net/ethernet/intel/ice/ice_adapter.c | 69 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.h | 28 ++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  8 +++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 33 ++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  3 +
 7 files changed, 116 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h

-- 
2.43.2


