Return-Path: <netdev+bounces-246977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E97DCF2F68
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3955C301102D
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FDF3148B8;
	Mon,  5 Jan 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dtQTUkC0"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269361D54FA;
	Mon,  5 Jan 2026 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608553; cv=none; b=aiuS5tGnPCpts/bGqTU14dGBj+5fb1+oxLGbjRMl5ZxrdEZoKEyeU6CIgQw2mQdjLyBIyr4z5GBS7HQm2me3ul3cTKg7LsM4ehZYPn6kR5XGqaWjcWHyYUUCav5nv5bzOoRbUKBoNWaRfMnBVKsfxLy4x/acUoIDmvtOoxnxNf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608553; c=relaxed/simple;
	bh=1v1nCHDtZ4Qx8CwntWeLzKdTxyM01FsNrtpn6UccnzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnAnRBgaYchQalx8MvI8FjOEpZqHqRE6JvBfagoUrvbhQjdcIBgKCBQyehIRJ/y714BlKeowI1sgwjDnOK1zUq6EaVQWbhU1hgUlUmyVZZ6jfOR7eVhsRUsHOV6iLp/YhG75Pq82TJ+qR2eUhdl4DIVctC3mtJdlS96fJgDSLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dtQTUkC0; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pH
	c0vZ/16wo+yTXLOZ0f6bVileGoya9oPZ0ZqRLIXco=; b=dtQTUkC0KHlNGiZcfk
	r+9aVjsVmNC7dCiNdtELnKP8uR4bWTVOwoQ5wse4S/IHvOT91s7z24rBv4hrBebL
	7C2hy9yF+8UosnFbfX6ZjBdtZmfeChruAxcmhd/stOYTQO47nHBTpyuxanxKNgJK
	1NqochnJc6hY3vuYjxyqB2f4k=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrxNrkFtpVWA8KQ--.198S2;
	Mon, 05 Jan 2026 18:20:31 +0800 (CST)
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
Subject: [net-next v4 0/8] net: wwan: add NMEA port type support
Date: Mon,  5 Jan 2026 18:20:10 +0800
Message-Id: <20260105102018.62731-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnrxNrkFtpVWA8KQ--.198S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4DJr45Aw4fXF4kCw13CFg_yoW5GFW8pa
	yjgryfCr97GFs7WF4SywsFvFWfXFn7Gw4jq34aq3sYqFZ8Jry3urWIv3Z5tF98G3WIg342
	vrW5tr1kG3W5CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUn4SOUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvw9w1GlbkG+2cQAA3e

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

Changes since V3:
Add the description for structure member gnss in wwan_port

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
  net: wwan: mhi_wwan_ctrl: Add NMEA channel support
  net: wwan: hwsim: refactor to support more port types
  net: wwan: hwsim: support NMEA port emulation

Slark Xiao (2):
  net: wwan: mhi_wwan_ctrl: Add NMEA channel support

 drivers/net/wwan/Kconfig         |   1 +
 drivers/net/wwan/mhi_wwan_ctrl.c |   1 +
 drivers/net/wwan/wwan_core.c     | 249 ++++++++++++++++++++++++++-----
 drivers/net/wwan/wwan_hwsim.c    | 201 ++++++++++++++++++++-----
 include/linux/wwan.h             |   2 +
 5 files changed, 384 insertions(+), 70 deletions(-)

-- 
2.25.1


