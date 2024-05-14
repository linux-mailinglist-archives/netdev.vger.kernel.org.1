Return-Path: <netdev+bounces-96413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F28C5B22
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241BEB21106
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE351802C7;
	Tue, 14 May 2024 18:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EX-PRD-EDGE01.vmware.com (EX-PRD-EDGE01.vmware.com [208.91.3.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330B144D3E;
	Tue, 14 May 2024 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.91.3.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711785; cv=none; b=F3YYd+SP3Yoj2lJSfQiuUAZ/WRcP/8qYB9m4DKufWeqfTUYSNEo6cEM3wUx8rBgEmMUaIzY6EvtCoLHLVlALLjBjGTJ5hmREoQLVwsCjFozlp+/7dBUE0y6FNAEJArm2uySErs8dmKvPa6yp3kgXhXpoplQ0fIhFFrDWHWMRRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711785; c=relaxed/simple;
	bh=xKIXN/WRDoAypSo2tWcS/nbPETH5owwn8UfBEliKgM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tw//9/KhivkmjXYH2qPL/+tJyzp6vzMDadVklcK1hm+JQ8Te3NZEdXtoaHGqvGFaEUJmLeuRSumqGL7YmATGVwMqj9KQQFhrEfzsWOvALUOnN3we2MpavzJMopoVfmRRM6c/dwe6J38u96vGNjZ0aYJDzjiXaZ4/vo9vLgJY0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com; spf=pass smtp.mailfrom=vmware.com; arc=none smtp.client-ip=208.91.3.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vmware.com
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX-PRD-EDGE01.vmware.com (10.188.245.6) with Microsoft SMTP Server id
 15.1.2375.34; Tue, 14 May 2024 11:20:56 -0700
Received: from htb-1n-eng-dhcp122.eng.vmware.com (unknown [10.172.6.252])
	by sc9-mailhost3.vmware.com (Postfix) with ESMTP id BB2B7202C0;
	Tue, 14 May 2024 11:21:04 -0700 (PDT)
Received: by htb-1n-eng-dhcp122.eng.vmware.com (Postfix, from userid 0)
	id B592FAECCE; Tue, 14 May 2024 11:21:04 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/4] vmxnet3: upgrade to version 9
Date: Tue, 14 May 2024 11:20:45 -0700
Message-ID: <20240514182050.20931-1-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: SoftFail (EX-PRD-EDGE01.vmware.com: domain of transitioning
 ronak.doshi@broadcom.com discourages use of 10.113.161.73 as permitted
 sender)

vmxnet3 emulation has recently added timestamping feature which allows the
hypervisor (ESXi) to calculate latency from guest virtual NIC driver to all
the way up to the physical NIC. This patch series extends vmxnet3 driver
to leverage these new feature.

Compatibility is maintained using existing vmxnet3 versioning mechanism as
follows:
- new features added to vmxnet3 emulation are associated with new vmxnet3
   version viz. vmxnet3 version 9.
- emulation advertises all the versions it supports to the driver.
- during initialization, vmxnet3 driver picks the highest version number
supported by both the emulation and the driver and configures emulation
to run at that version.

In particular, following changes are introduced:

Patch 1:
  This patch introduces utility macros for vmxnet3 version 9 comparison
  and updates Copyright information.

Patch 2:
  This patch adds support to timestamp the packets so as to allow latency
  measurement in the ESXi.

Patch 3:
  This patch adds support to disable certain offloads on the device based
  on the request specified by the user in the VM configuration.

Patch 4:
  With all vmxnet3 version 9 changes incorporated in the vmxnet3 driver,
  with this patch, the driver can configure emulation to run at vmxnet3
  version 9.

Ronak Doshi (4):
  vmxnet3: prepare for version 9 changes
  vmxnet3: add latency measurement support in vmxnet3
  vmxnet3: add command to allow disabling of offloads
  vmxnet3: update to version 9

 drivers/net/vmxnet3/Makefile          |   2 +-
 drivers/net/vmxnet3/vmxnet3_defs.h    |  61 +++++++++-
 drivers/net/vmxnet3/vmxnet3_drv.c     | 219 +++++++++++++++++++++++++++-------
 drivers/net/vmxnet3/vmxnet3_ethtool.c |  10 +-
 drivers/net/vmxnet3/vmxnet3_int.h     |  33 ++++-
 5 files changed, 276 insertions(+), 49 deletions(-)

-- 
2.11.0


