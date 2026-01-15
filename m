Return-Path: <netdev+bounces-250082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E3D23C22
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B7030351C3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A5935FF72;
	Thu, 15 Jan 2026 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NQssVUCP"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD232E729;
	Thu, 15 Jan 2026 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470926; cv=none; b=oEuypcNByuiVHI22aFOnACTEI7wTZ12mGGXrwPtPIWNJHh15dTjfnWiz7J118GFG64wYGbsXcuipgL19PXNTSVo0/PekXu3rtmLKBat5tpTwiDxykduLWz47OAQ1Olz38csEb/NbG6oLbU5n4Vn/f3XrQuqT27dKeHAb0HoSYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470926; c=relaxed/simple;
	bh=bNkZku3+pHbkAKEAT4hyATmpfiR4ZitCeSV5TMCsLRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVqlbEayunm/k7lxXd9M2w2m/LZVZq7VCG+XWTAWLAVqz1et+lwoEqnfCEcqF6/8EG6Zh/DPF2rMuTJSXFtCiZzx8unKcjF5MnB3VcVpIaDMorqeBKvPbO12kF32+UadeY6IrpXoDu+QVH09Ro4Bawm0OpIOmI71cw6Anh3logw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NQssVUCP; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Lq
	Ia76KbEllDdg/3rtMx6RLTk8DzkKDVBuYBQvnqoFo=; b=NQssVUCPEoCd323iiK
	olr330Rv5ts3cI7nS94hZjznGrYFdsR1v3OMso54l1uHly8j5GUwQGT+zIcDQL3Q
	nY0NodSvenIkxUV47CnRgZevVvQDhPkhtVh5WvVatJrxqY8wRRCdF+AysNlFjTOV
	luSo+TjqN5/9zd56L0d0AvgR0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAH3axTuWhpe3IgLg--.97S2;
	Thu, 15 Jan 2026 17:54:31 +0800 (CST)
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
	slark_xiao@163.com
Subject: [net-next v6 0/8] net: wwan: add NMEA port type support
Date: Thu, 15 Jan 2026 17:54:09 +0800
Message-Id: <20260115095417.36975-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAH3axTuWhpe3IgLg--.97S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryDJrykKFyfZw47JryrZwb_yoW8Kw48pF
	WjgrySyF97GFs7Wr4fAws7AryFvF1fG3yjqry2v34Fqrs8Jr1a9ryIq3Z0qas5Jw1Fqa47
	ZrWUtw1kG3W5CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUEf5UUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5xj4XWlouVivTgAA3b

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

The series starts from a cleanup patch. Then three patches prepares the
WWAN core for the proxy style operation. Followed by a patch introding a
new WWNA port type, integration with the GNSS subsystem and demux. The
series ends with a couple of patches that introduce emulated EMEA port
to the WWAN HW simulator.

The series is the product of the discussion with Loic about the pros and
cons of possible models and implementation. Also Muhammad and Slark did
a great job defining the problem, sharing the code and pushing me to
finish the implementation. Daniele has caught an issue on driver
unloading and suggested an investigation direction. What was concluded
by Loic. Many thanks.

Changes RFCv1->RFCv2:
* Uniformly use put_device() to release port memory. This made code less
  weird and way more clear. Thank you, Loic, for noticing and the fix
  discussion!
Changes RFCv2->RFCv5:
* Fix premature WWAN device unregister; new patch 2/7, thus, all
  subsequent patches have been renumbered
* Minor adjustments here and there

Sergey Ryazanov (7):
  net: wwan: core: remove unused port_id field
  net: wwan: core: explicit WWAN device reference counting
  net: wwan: core: split port creation and registration
  net: wwan: core: split port unregister and stop
  net: wwan: add NMEA port support
  net: wwan: hwsim: refactor to support more port types
  net: wwan: hwsim: support NMEA port emulation

Slark Xiao (1):
  net: wwan: mhi_wwan_ctrl: Add NMEA channel support

 drivers/net/wwan/Kconfig         |   1 +
 drivers/net/wwan/mhi_wwan_ctrl.c |   1 +
 drivers/net/wwan/wwan_core.c     | 277 +++++++++++++++++++++++++------
 drivers/net/wwan/wwan_hwsim.c    | 201 ++++++++++++++++++----
 include/linux/wwan.h             |   2 +
 5 files changed, 394 insertions(+), 88 deletions(-)

-- 
2.25.1


