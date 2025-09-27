Return-Path: <netdev+bounces-226852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F398DBA5A6A
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB55F7A4F75
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3555C2D2494;
	Sat, 27 Sep 2025 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="vp4vvn4d"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1A2D2483
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758959358; cv=none; b=XAVdkpCzVRHMfWloalYire6xw09y4MShEeKxr41XFt7tX5jwbQbqvzW5jyFPFJOrBXV/tgbs4AThOvxL1MrF7IvXOntCRqGbZDMtQv1KPr7pp81arcK6x8Wl2xGSDhed3DfWU0MJ/ru24skIvtH8CI9O2nRi6tpy7WrQhBFpG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758959358; c=relaxed/simple;
	bh=cM2LE/IjK2+fVUeGLy4ZX9AFIw8HGEeNVYsybOBvAP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlLOqicVPf8w8ceJGeU9zTbTddxlcaqcscArUDJ+shjHEpxUovA4L+qc7icj6v5Ffy8VUQ4TxXRhMBOFWLpgGVflZtdrQHwMvREttAPr53grBTE0F3R9B5gV4wPG47wbsLsw+9aoPy8TmtXqm7n8XveEA6VOm7G96GRhBotWXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=vp4vvn4d; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 58R77w88026773
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 08:08:06 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 58R77w88026773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1758956891; bh=wsU+nWQB/1rUdndDZxvRlD/wK09rDEdcWidV7DKcsxU=;
	h=From:To:Cc:Subject:Date:From;
	b=vp4vvn4dlX4Nrm5ghrg7d0XFogeQ1tyzVmeCpu5x1n7QMQh4D2+5H5/GTMvWUrfBT
	 dKsTiq1Yvpa4KBlOhhCp0Y58+RB72Rp+qrd0Zn101yWBYcstM0TTWiUhylI2vEPJaM
	 WgJSakwKSslEkria5aslpgiRIs50bMzg9z22xhWQ8bxdggF2uoksxRx9fl01pQ6aJn
	 nytcDOQFEUAVWtC/O1FNdtJJksqNZjCdRVwiTcEtDfFYgvpqlJGt0zYv+U5bx+MbI7
	 HcUs6Hf5f3rSzsl5yRC+8h4iVH+bYrARNGOVnn8SHQFAfJs0eE8Zb8VF4Yn30qsZaF
	 +0csv5zyJI3MA==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch, vladimir.oltean@nxp.com, kieran@sienda.com,
        jcschroeder@gmail.com, max@huntershome.org,
        Luke Howard <lukeh@padl.com>
Subject: [RFC net-next 0/5] net: dsa: mv88e6xxx: support for 802.1Qav
Date: Sat, 27 Sep 2025 17:07:03 +1000
Message-ID: <20250927070724.734933-1-lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hardware offloaded 802.1Qav support to conforming Marvell switches.

Tested with 88E6341 and 88E6352 switch chips.

Luke Howard (5):
  net: dsa: mv88e6xxx: add num_tx_queues to chip info structure
  net: dsa: mv88e6xxx: add MV88E6XXX_G1_ATU_CTL_MAC_AVB setter
  net: dsa: mv88e6xxx: MQPRIO support
  net: dsa: mv88e6xxx: CBS support
  dt-bindings: net: dsa: mv88e6xxx: add mv88e6xxx-avb-mode property

 .../bindings/net/dsa/marvell,mv88e6xxx.yaml   |  25 +
 drivers/net/dsa/mv88e6xxx/Makefile            |   3 +-
 drivers/net/dsa/mv88e6xxx/avb.c               | 663 ++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/avb.h               | 244 +++++++
 drivers/net/dsa/mv88e6xxx/chip.c              | 308 +++++++-
 drivers/net/dsa/mv88e6xxx/chip.h              |  81 +++
 drivers/net/dsa/mv88e6xxx/global1.c           |   9 +-
 drivers/net/dsa/mv88e6xxx/global1.h           |  47 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c       |  17 +
 drivers/net/dsa/mv88e6xxx/global2.h           |  14 +-
 drivers/net/dsa/mv88e6xxx/global2_avb.c       | 205 +++++-
 drivers/net/dsa/mv88e6xxx/port.c              |   9 +
 drivers/net/dsa/mv88e6xxx/port.h              |   2 +
 include/linux/platform_data/mv88e6xxx.h       |   1 +
 14 files changed, 1607 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/dsa/mv88e6xxx/avb.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/avb.h

-- 
2.43.0


