Return-Path: <netdev+bounces-263258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBjMCyP3pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:58:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB6B1F1E6B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 279DF3012532
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4236B071;
	Tue,  3 Mar 2026 14:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B0339EF27;
	Tue,  3 Mar 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549919; cv=none; b=sDc1OtIR0D7552HIfqNgymrkcfEKRRbLYI+hG6BcsdC1v13T1Jp5R9/6btxDlhQDDDQn3wqlKw1FfHEnLwJWyaaeqoadMdHSc7vWGjP/zVp8PikBYRLuUm4WwMxW7FwfQ+UojxhjsVEfB6zhB753aAlD7LcXFBiiOt9qiJFpv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549919; c=relaxed/simple;
	bh=g2jew+ci6z8GaJMXE7973qX4l1lCxTvtcQZOfFv8bLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKivteaTugjB33iIfzRWNyfm1A8AfYxqLZMV9//OpCjOWy0k3nZtC1v0xmCQdNlhpPRplUdqzJzHBByymlkk445uuNIfJ2Hl0nHqEXMjG6V++N9vd90z3SoEIpuQhhFGD2nKi3BMhNSTFohS/0gVPuhAva6GsgyTxWqmIS2qrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: d2zDeClzQZKRKlwPLpq6Rw==
X-CSE-MsgGUID: AMrbHGahT+ehlb7rchE76w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Mar 2026 23:58:36 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.15])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 013F2400D0EA;
	Tue,  3 Mar 2026 23:58:29 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	boon.khai.ng@altera.com,
	rohan.g.thomas@altera.com,
	vladimir.oltean@nxp.com,
	hayashi.kunihiko@socionext.com,
	boon.leong.ong@intel.com,
	kim.tatt.chuah@intel.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/4] net: stmmac: Fix VLAN handling when interface is down
Date: Tue,  3 Mar 2026 14:58:24 +0000
Message-ID: <20260303145828.7845-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BBB6B1F1E6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263258-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,altera.com,nxp.com,socionext.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.583];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

VLAN register accesses on the MAC side require the PHY RX clock to be
active. When the network interface is down, the PHY is suspended and
the RX clock is unavailable, causing VLAN operations to fail with
timeouts.

The VLAN core automatically removes VID 0 after the interface goes down
and re-adds it when it comes back up, so these timeouts happen during
normal interface down/up:

    # ip link set end1 down
    renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    renesas-gbeth 15c40000.ethernet end1: failed to kill vid 0081/0

Adding VLANs while the interface is down also fails:

    # ip link add link end1 name end1.10 type vlan id 10
    renesas-gbeth 15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
    RTNETLINK answers: Device or resource busy

Patch 4 fixes this by adding checks in the VLAN paths for netif_running(),
and skipping register accesses if the interface is down. Only the software
state is updated in this case. When the interface is brought up, the VLAN
state is restored to hardware.

Patches 1-3 fix some issues in the existing VLAN implementation.

v3:
- Dropped the 'write_hw' approach and added checks for netif_running() directly
  in the VLAN paths, to avoid passing attributes around.

v2: https://lore.kernel.org/all/20260225142414.130144-1-ovidiu.panait.rb@renesas.com/
- Added a new commit that fixes VLAN restore on the resume and open paths.

v1: https://lore.kernel.org/all/20260223124102.120432-1-ovidiu.panait.rb@renesas.com/

Ovidiu Panait (4):
  net: stmmac: Fix error handling in VLAN add and delete paths
  net: stmmac: Improve double VLAN handling
  net: stmmac: Fix VLAN HW state restore
  net: stmmac: Defer VLAN HW configuration when interface is down

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 53 ++++++++++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 60 ++++++++++---------
 3 files changed, 79 insertions(+), 35 deletions(-)

-- 
2.51.0


