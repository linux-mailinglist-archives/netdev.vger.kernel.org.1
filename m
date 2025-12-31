Return-Path: <netdev+bounces-246409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E70DACEB690
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 07:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749FF30E0C49
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B930C311959;
	Wed, 31 Dec 2025 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mlWbQQSx"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C73128AB;
	Wed, 31 Dec 2025 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767163951; cv=none; b=e+fec2IxOT/PHoU7roIKM37Ek1p04g0LTy4h6DoAhhDlpzqdUX9AS3nhSqD/0eJvfeUmdZy0g2G1mw4WX9RkFd0VtEMTw9FoZhsg5SrVl4ThFQqpPQjjyevYK8Ixf2NV+5mVd2CpXR8+WZZCFU4UZRBHYffKayQ0sSG63MwKwz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767163951; c=relaxed/simple;
	bh=MfH9KM84JJI0KJhsrQiLew0tHiEAq9VGjGXgLabU6Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CNZX6OqtkG+tvDtU4uddjme9YQUZYOFp2mmRVe1yGJ8NQxGUqBSkj8zia63S9NJg4VArXatib9lENdHu+2J6FR/z5uuaMh5cL/gYAg52XwLdfcDGToIbSN7X3yr/OzHlH/hFBJ+OyIX01lYuwn4LnV3PGgHFuftqqBwLfH9lMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mlWbQQSx; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0F
	I1TiHhXzFxq9cXoz5fRh6UsIYC2/LpHhsB/Pk0k9Q=; b=mlWbQQSxowih0mUdhR
	DqEe23TRie/i+Rl3X4p9llaSxIZo6aBX0hXZfECfdViZ39Wpstx+Xw7KTSB1SQ/I
	U+KMxx8MT/Dtvrj9No9acAERajR7FP2cxVIZfuiNtBTyk0lHw08XHrD/YhSrloPv
	vyxpvmbUlG2I07IV3QKHyXcUk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHpCPmx1Rp9FyCDg--.29927S2;
	Wed, 31 Dec 2025 14:51:20 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>,
	Muhammad Nuzaihan <zaihan@unrealasia.net>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: [net-next v3 0/8] net: wwan: add NMEA port type support
Date: Wed, 31 Dec 2025 14:51:01 +0800
Message-Id: <20251231065109.43378-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHpCPmx1Rp9FyCDg--.29927S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4DJr45Aw4fXF4kCw13CFg_yoW5Jw1kpF
	WqgryfCF97Ga1xWF4SywsFqrWrXF1kGw4UX342q3sYqFZ8Jry3ury0q3Z5tF98G3WFg347
	ZrW5tr1kG3W5CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkhliUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwAibAGlUx+ip6wAA3D

The series introduces a long discussed NMEA port type support for the
WWAN subsystem. There are two goals. From the WWAN driver perspective,
NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
user space software perspective, the exported chardev belongs to the
GNSS class what makes it easy to distinguish desired port and the WWAN
device common to both NMEA and control (AT, MBIM, etc.) ports makes it
easy to locate a control port for the GNSS receiver activation.

Done by exporting the NMEA port via the GNSS subsystem with the WWAN
core acting as proxy between the WWAN modem driver and the GNSS
subsystem.

The series starts from a cleanup patch. Then two patches prepares the
WWAN core for the proxy style operation. Followed by a patch introding a
new WWNA port type, integration with the GNSS subsystem and demux. The
series ends with a couple of patches that introduce emulated EMEA port
to the WWAN HW simulator.

The series is the product of the discussion with Loic about the pros and
cons of possible models and implementation. Also Muhammad and Slark did
a great job defining the problem, sharing the code and pushing me to
finish the implementation. Many thanks.

Comments are welcomed.

Changes since V1:
Uniformly use put_device() to release port memory. This made code less
weird and way more clear. Thank you, Loic, for noticing and the fix
discussion!

Changes since V2:
Add supplement of Loic and Slark about some fix

CC: Slark Xiao <slark_xiao@163.com>
CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
CC: Qiang Yu <quic_qianyu@quicinc.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Johan Hovold <johan@kernel.org>
CC: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Loic Poulain (1):
  net: wwan: prevent premature device unregister when NMEA port is
    present

Sergey Ryazanov (6):
  net: wwan: core: remove unused port_id field
  net: wwan: core: split port creation and registration
  net: wwan: core: split port unregister and stop
  net: wwan: add NMEA port support
  net: wwan: hwsim: refactor to support more port types
  net: wwan: hwsim: support NMEA port emulation

Slark Xiao (1):
  net: wwan: mhi_wwan_ctrl: Add NMEA channel support

 drivers/net/wwan/Kconfig         |   1 +
 drivers/net/wwan/mhi_wwan_ctrl.c |   1 +
 drivers/net/wwan/wwan_core.c     | 248 ++++++++++++++++++++++++++-----
 drivers/net/wwan/wwan_hwsim.c    | 201 ++++++++++++++++++++-----
 include/linux/wwan.h             |   2 +
 5 files changed, 383 insertions(+), 70 deletions(-)

-- 
2.25.1


