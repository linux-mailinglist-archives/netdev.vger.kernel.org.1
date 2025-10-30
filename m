Return-Path: <netdev+bounces-234381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33578C1FF27
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01B9C4E3B86
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC3033B6E7;
	Thu, 30 Oct 2025 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S4vR7mn+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63513385A5;
	Thu, 30 Oct 2025 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826409; cv=none; b=umefRKIfZKcoxxWXLTwdWjTxIk1Xy+ONhM0jiYEud/eofVOMu55Wtx952hNlTjglLr/RvrfnfLmSABVs4rfeMOTL2sHI8LSYjUshWREOFxujrlYohNVYvUKShkkZ9r4/jUDbfz0ziyCesfotbU2Z4fIVB1xPosKV8CW0W/6oXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826409; c=relaxed/simple;
	bh=hke2M7IpMJT/BpWLPaxUXRqm0zhxBs3/hpGZYTFlqqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LVhvbzt9Fj27TOJz+jK+2IpNV2HCMB48UQx6kt0CxY7PEl+zGChQNa/NbqT7xp73zJiKUBfFNTZgTVaLwQTo7mwsbhscyYsOVLYO85WgmehREgXVB7i+TUz2JEB2u5VCljUMvHE+ExM4f4+t9CltZq2LfD/Mg+oOoTihaHhpUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S4vR7mn+; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761826402; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9kymYuuro96wgVJjxflH4geCUCovhrnd/RiS40QFmdw=;
	b=S4vR7mn+du2xA7Ob1l0mfuH79/orjBNmy9IbMsVoGIqaIf0ve5EPpsFS2Gj8D17yNVOkOE0A7UoZiRjYLQzCzEFCMBF1ywPjwhLIy99agUjMmpfXY6QjzGOOBaEp+BT7f2yYbUTpFGpBayUwqkxkkdg1WgAkQTLPFsdiRxxqEwM=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WrKUndX_1761826394 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 20:13:21 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guwen@linux.alibaba.com
Subject: [PATCH net-next v5 0/2] ptp: Alibaba CIPU PTP clock driver
Date: Thu, 30 Oct 2025 20:13:12 +0800
Message-Id: <20251030121314.56729-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a driver for Alibaba CIPU PTP clock.

The CIPU, an underlying infrastructure of Alibaba Cloud, synchronizes
time with atomic clocks via the network and provides microsecond or
sub-microsecond precision timestamps for VMs and bare metals on cloud.

User space processes, such as chrony, running in VMs or on bare metals
can get the high precision time through the ptp device exposed by this
driver.

In addition, this driver exposes sysfs files for obtaining device
attributes and event statistics, as described in the documentation.

---
v5->v4:
- add documentation describing sysfs files.

v4->v3:
https://lore.kernel.org/netdev/20250812115321.9179-1-guwen@linux.alibaba.com/
- use disable_* variant helpers as suggested by Paolo.
- minor nit: make PTP_CIPU_REG macro one line.

v3->v2:
https://lore.kernel.org/netdev/20250717075734.62296-1-guwen@linux.alibaba.com/
- follow the sysfs convention of one value per file;
- rename enum constants for brevity;
- improve macros for printing;
- add more comments;

v2->v1:
https://lore.kernel.org/netdev/20250627072921.52754-1-guwen@linux.alibaba.com/
- add Kconfig dependency on CONFIG_PCI to fix kernel test
  robot's complaint.

v1:
https://lore.kernel.org/netdev/20250625132549.93614-1-guwen@linux.alibaba.com/

Wen Gu (2):
  ptp: introduce Alibaba CIPU PHC driver
  ptp: add sysfs documentation for Alibaba CIPU PHC driver

 .../ABI/testing/sysfs-ptp-devices-cipu        | 227 +++++
 MAINTAINERS                                   |   8 +
 drivers/ptp/Kconfig                           |  12 +
 drivers/ptp/Makefile                          |   1 +
 drivers/ptp/ptp_cipu.c                        | 946 ++++++++++++++++++
 5 files changed, 1194 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-ptp-devices-cipu
 create mode 100644 drivers/ptp/ptp_cipu.c

-- 
2.43.5


