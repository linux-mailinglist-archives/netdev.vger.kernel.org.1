Return-Path: <netdev+bounces-253332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDZeNqkId2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:24:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB2D847C1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7275301F790
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34432836A0;
	Mon, 26 Jan 2026 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y5i6NZpM"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1FA279903;
	Mon, 26 Jan 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408589; cv=none; b=fL2Ph7TB/Hue2xaNSY/aukx6Yzwj2TEhhiAUSUeOyDGLbMRG1CZ7bqn/98w8W2tbUeNFUqbTL1Ds4KK9YkWa2BhoPQ0a5lrNC5e/d8+EwfS1aC3B+UldXblq54gYq+I7wBuNMpYpjDEU+bO9qxAIrZojeYoPdxMfxLeA/iNC4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408589; c=relaxed/simple;
	bh=5UVmP9Qe9peDa6/28+hps5PqsG6OFaLk402VDzaaH4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D4xpVnm+Xqo9loccms0FlOfcFskjItSTjAcj4vmZchcKAr3Ce+GUaPoLty4kR9YxTK4xoWqc+Ozu13xQovFZVis4MtIuzltzazWc5rtSGsgGg1TfVpYpGeCNlnETgwzKfsL7DIK6QOHe9iGWNZEslV6SqVu1JkyGjqojpCuja+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y5i6NZpM; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QH
	9g5X0rxkGS3fr+4BKj7PnDDSQrCmEwSwQHaHZySNM=; b=Y5i6NZpM6VfQmDFnZp
	g/P8PvafGAl3JmyIQrkH2VC3OqtpYVg2oPIM6slnbDIdpn4X6q2bVQr7i3K+hGmJ
	LSkkBnc0TOvNWCeiY9SAY69OZELedniTKyWa7siBALdqPrkuDhVroy1MLW53m/K0
	qvml1hp9XPfYdqbaLG6LZZphE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHzzkJCHdpL7kRIg--.5216S2;
	Mon, 26 Jan 2026 14:22:04 +0800 (CST)
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
Subject: [net-next v8 0/8] net: wwan: add NMEA port type support
Date: Mon, 26 Jan 2026 14:21:50 +0800
Message-Id: <20260126062158.308598-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzzkJCHdpL7kRIg--.5216S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4DJr45Aw4fXF4kCw13CFg_yoW5Jw45pa
	yYgr9ayas7GFsrWr4fAwsrJryFvF1fC3yUX342q34Fqrs8Jr1a9rWIqFn0qas5Jw1Fq347
	ZrWUtw1kG3W5urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRiYFJUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5ww9oWl3CAzoGgAA3f
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BB2D847C1
X-Rspamd-Action: no action

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
Changes v6->v7:
* Fix typo and others which lead to build error
Changes v7->v8:
* Enhance code according to AI suggestion

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
 drivers/net/wwan/wwan_core.c     | 278 +++++++++++++++++++++++++------
 drivers/net/wwan/wwan_hwsim.c    | 201 ++++++++++++++++++----
 include/linux/wwan.h             |   2 +
 5 files changed, 395 insertions(+), 88 deletions(-)

-- 
2.25.1


