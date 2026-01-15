Return-Path: <netdev+bounces-250142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1929D244A3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B7AB30552CA
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668F9393DC8;
	Thu, 15 Jan 2026 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k3+OeQGS"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D21324B19;
	Thu, 15 Jan 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477644; cv=none; b=GMRcmn+f3xG7P239VijK4MnkuZZcYz/8MiTpx8JKT2iRRYdy1u76qqE13zZdwsklBIUnirzM3dj6zDTPl9P99TlpRmHDfL3lo/d1jBqAPe2IZMjf1TR/aT4uBiLXs6srDVyPfih6x8Awpe6K27cGWE+WxQDBwaAJmV7FV2Y2dAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477644; c=relaxed/simple;
	bh=2ya01oZ/GtA6CjMlV3v2dXHwnZNBbEx8CDP5Vyyxdfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d+z3Z0S50zpSM7cYveC9YfrO1puf+knjBvXyFTsQ2rt+HMbFVgBDpw5S039RGFmMqTlPraysZ67fkQqZtSLCycVdYPsZpZrJodUZE5WbaFJcH6G/4G3Xpm7KHIfqV1qug9Ub5XgDhrxpOKLDH031eVBqO7bpToT67MLmuhKV2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k3+OeQGS; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Pd
	hR+YUljXhGhliiOi6oOFYA2+Ax1VG1a693Jebp4AY=; b=k3+OeQGSix2ICrY2Mr
	mYO3VH/MpRGr9HIEpEzZDQWDjvGz85gw81Xxc3QMCg3vgf+51kMsJAlh7QuB8lSn
	uU+M7Y6TCjAvWWKrMtjQcuj/HAmuATZkc2RKDRj/E4j3qc7zoMeBeLxXzUomAVuP
	C/XOXnJKuFNvmmyJOpiZyAbwU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHLGiX02hpr2PzGQ--.4331S2;
	Thu, 15 Jan 2026 19:46:32 +0800 (CST)
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
Subject: [net-next v7 0/8] net: wwan: add NMEA port type support
Date: Thu, 15 Jan 2026 19:46:17 +0800
Message-Id: <20260115114625.46991-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHLGiX02hpr2PzGQ--.4331S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryDJrykKFyfZw47JryrZwb_yoW5JF1rpa
	yjgrySyF97GFs7Wr4fAws7XryFvF1fG3y2q342q34Fqrs8Jr1a9ryIq3Z0qas5Jw1Fqa47
	ZrWUt34kG3W5urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRtl1fUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvxiP82lo05gd2wAA3X

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
Changes v6->V7:
* Fix typo and others which lead to build error

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


