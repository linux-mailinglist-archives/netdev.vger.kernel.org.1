Return-Path: <netdev+bounces-143163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB7C9C14EE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1971C2328A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C341C8FB7;
	Fri,  8 Nov 2024 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Qyj6DkSX"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57F1A2564
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 03:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731038153; cv=none; b=eMysGkIMOEdqkdJZ9k6uDeHzyO23vwUCarbacT2iRxYbRZtS43M80GmAPzyqxFhkCMvIwIZno20zz7vfz6wDoiqOOGamSBE7wKNIEmINip1fNjetyNeWey+W6OQIY80TSyzgTYEfBQgobp4TtWUydIALrGbEbUJTkRgRd8DJhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731038153; c=relaxed/simple;
	bh=BePifMGkUyn09eEbucoIUFUA8pUPq8HVmY8i3uv8OGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dq3yynwEzftpQE6QjbvZAo4TphbP2McDVbdjQSYH0qLeny3JpV6tXMwPevkw4x2C4yl7ldnkUVfYauwimtMnnTMJzww1fF8L6oKXEEycbvypmfq/cKrCghUNAh0iFnBGmHVTdzDJ8QXxS1gdSM6HgMx7SiUJAUE7rN1RT/LCXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Qyj6DkSX; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EAEDF2C012A;
	Fri,  8 Nov 2024 16:55:48 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731038148;
	bh=w9fDVAIOldxuQOUifhEJ+yRjtDJONdTnsW8NElyKG98=;
	h=From:To:Cc:Subject:Date:From;
	b=Qyj6DkSXSgeiGXvR/JShC2D75DfD6YlWKxq5h1RCLu9jE17HPCXSXW6F1UkAgTg7E
	 kXkS4XBMlkNNhxrJkLhrOvYgdsG7hBCEnu7NPaQAVhpsprerstPpGPeEQvno0j6cu7
	 setpeahV6HRo5ay0RU2VD1ecWKZzXUR9antqg4dzzKndXri8Pd+FRmW7+TMhePfA5T
	 PjZIstRKanbMSZq3hxzZWtIijxgsHzniL/smFRyqtNzxityoOPtYQpIwqcAR0dqKbz
	 l2Uqd08uoDbt/0LyR24UFStaw1hq+CHfTjPmrfmnJRi8rGa5QhQE2SD+GUc3dzbdmv
	 +/Ul2kE39GJRw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672d8bc40000>; Fri, 08 Nov 2024 16:55:48 +1300
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id B852B13ECD2;
	Fri,  8 Nov 2024 16:55:48 +1300 (NZDT)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id B4ED93C0263; Fri,  8 Nov 2024 16:55:48 +1300 (NZDT)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: "David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Subject: [RFC net-next (resend) 0/4] Send notifications for roaming hosts
Date: Fri,  8 Nov 2024 16:55:42 +1300
Message-ID: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672d8bc4 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=zJYQOOszgUrZLbXH11sA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Apologies, this is a resend as the first version didn't have the correct =
CCs.


For 802.1x operation it is useful to know when a host authorised to on po=
rt
has roamed to another port, and take action on it.

The fdb sticky flag is used to configure a host for a single port and
prohibit it from moving to another, so this flag is used as the means of
determining when to send the notification.

In this set of patches the fdb notify mechanism is extended to including =
a
roaming bit, so user applications can configure an fdb entry for a host a=
s
sticky (likely also static) and turn on notifications. With this
configuration, if traffic matching this entry appears on another port the
entry will not be updated but a notification will be sent to userspace.

This is achieved by temporarily updating the fdb entry with the new port,
setting the roaming bit, firing off a notification, and restoring the
original port. The port remains unchanged but userspace is now notified o=
f
the new port the host was seen on.

For this specific implementation the mv88e6xxx chip's member-violation
interrupt is used to inform the kernel bridge via switchdev that a host i=
s
roaming to a new port. For this to work the br_fdb_external_learn_add()
function has been changed to respect the stick flag where it previously
wasn't.

Elliot Ayrey (4):
  net: bridge: respect sticky flag on external learn
  net: bridge: send notification for roaming hosts
  net: dsa: mv88e6xxx: handle member-violations
  net: dsa: mv88e6xxx: cache fid-to-vid association

 drivers/net/dsa/mv88e6xxx/chip.h        |  2 +
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 37 +++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1_vtu.c |  6 ++-
 drivers/net/dsa/mv88e6xxx/switchdev.c   | 60 ++++++++++++------------
 drivers/net/dsa/mv88e6xxx/switchdev.h   |  2 +
 include/uapi/linux/neighbour.h          |  4 +-
 net/bridge/br_fdb.c                     | 61 +++++++++++++++++--------
 net/bridge/br_input.c                   |  9 +++-
 net/bridge/br_private.h                 |  3 ++
 9 files changed, 132 insertions(+), 52 deletions(-)


