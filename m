Return-Path: <netdev+bounces-78016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77765873C3E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3067E28286C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A6213791D;
	Wed,  6 Mar 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBj/Y6G2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D935F853
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742602; cv=none; b=lCpE9PCFh90ALslu5viquYzNEN0dKy8C0GnGxYmYjMlSoF+JsVuvCHzKI7AkVv8uXHU7D2J0rCtsBkoKnlgYvYbjxYMjoWXgSjwWcXkQwWSo4fy8+ah3DUF/sx1TFrFRBKVtqhycrjRXTYjIjpkMsnS4xnS8ov7Y6Qov+gpGL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742602; c=relaxed/simple;
	bh=ANL72q+B1ESE7Q72BnXrkeu2OjRghE2sjej5fzeaEsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JmOBaqo2W6MEb6xxL6PBQFTgAe/rUtRH3BUI1UPd4pDjeRUTUt4vNQO8suBJJ5xKRxg7W4xOpt37hQ8MPBwdGEFI9Dpg7kqJIxaCsTP0lrOneHBZY8SsRRyE5cQCXTMsauTgTnbIDGpvymw4zcvbUMas0LE539ok5uMXq7aAd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBj/Y6G2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709742599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fQN0lDxWlllZ+7e1BpHEsRMI1HmeCtr/hjEqKntiyQk=;
	b=VBj/Y6G2KBECpcPJW+PN+MooB3FqnPqjdw+0s6fhvdANA8v4YK0sSfb8/q47I+5EWwT1cS
	X3tPwTOcALG0I1UsW4Oacv9R53WOwoj9Zw8OW6Cbvhe6nd51z2qbvsFsic9eDm/8noBZPA
	xinHQ0tYLbaFZQIyzhmNskePKtguiYQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-tUMttNxGMfKfgHlrzpDvBw-1; Wed, 06 Mar 2024 11:29:57 -0500
X-MC-Unique: tUMttNxGMfKfgHlrzpDvBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF73F800266;
	Wed,  6 Mar 2024 16:29:56 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.224.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 73B2B40735F8;
	Wed,  6 Mar 2024 16:29:54 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH net-next v2 0/3] ice: lighter locking for PTP time reading
Date: Wed,  6 Mar 2024 17:29:04 +0100
Message-ID: <20240306162907.84247-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This series removes the use of the heavy-weight PTP hardware semaphore
in the gettimex64 path. Instead, serialization of access to the time
register is done using a host-side spinlock. The timer hardware is
shared between PFs on the PCI adapter, so the spinlock must be shared
between ice_pf instances too.

Replacing the PTP hardware semaphore entirely with a mutex is also
possible and you can see it done in my git branch[1], but I am not
posting those patches yet to keep the scope of this series limited.

[1] https://gitlab.com/mschmidt2/linux/-/commits/ice-ptp-host-side-lock-8

v2:
 - Patch 1: Rely on xarray's own lock. (Suggested by Jiri Pirko)
 - Patch 2: Do not use *_irqsave with ptp_gltsyn_time_lock, as it's used
   only in process contexts.

Michal Schmidt (3):
  ice: add ice_adapter for shared data across PFs on the same NIC
  ice: avoid the PTP hardware semaphore in gettimex64 path
  ice: fold ice_ptp_read_time into ice_ptp_gettimex64

 drivers/net/ethernet/intel/ice/Makefile      |  3 +-
 drivers/net/ethernet/intel/ice/ice.h         |  2 +
 drivers/net/ethernet/intel/ice/ice_adapter.c | 87 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.h | 28 +++++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  8 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 33 +-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  3 +
 7 files changed, 134 insertions(+), 30 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h

-- 
2.43.2


