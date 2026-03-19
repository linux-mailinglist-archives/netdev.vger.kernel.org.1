Return-Path: <netdev+bounces-269313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ObpMwaQu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:56:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D722C6624
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B376A3010685
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4D39B49F;
	Thu, 19 Mar 2026 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bWlOF4pc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5339A078;
	Thu, 19 Mar 2026 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899775; cv=none; b=BU0IJO1BHBBWgKoEKE3W9OxT1Icj+HSlSqFRQDy10oTJicgALEHE6oDefKuGDkBWlSVtypHlUyXYmnV55dGmI6CnKBxmpbd4iA28c+leRAMooxD83KJ9X9vY2GvhCaHKKZ+YyLKhjqbbqtPByfbWu3X+tqxGrYjDIyhhiwvpErw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899775; c=relaxed/simple;
	bh=klKeIZ84+JjqMD8m3cCyxd5mWlsoZmgIQypEGjo3mso=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bkM/gipTfOkxEzTLTOukmsETmkQFx5D12TC13oipTNVgFYdnSc74VcxqcOf6l8h2UOnAmlX1gbg8oEB98vr5wWNktxkfh6HZfyQ+HZuT2bgyKWHroVzCxEwxs+oLIqgQbTXEdZgYvwO4Zi1VFjBiT0Xdg5U3R2JgMVV83K/t1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bWlOF4pc; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J4wGjx080192;
	Wed, 18 Mar 2026 22:55:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=GHhLPWxTXJ/Zs1+sDZnxrQE
	jQyyxvU/F0IqOaWpaeK8=; b=bWlOF4pcONMYpobV6TNdlGOaa0EGQXJWagc6FPK
	rTzEBrt07GfjP/gouFOOcb88lHu8p0rRZUiKh3YI6mrZFzbNFFatjZQUq4UEtA/g
	yCiFoqfoJSnWZNi9zvgs7erRldDdDDwEfEKikVoOo6/cKFFUDz5QRhf95NcAhiBL
	qdbeoA9SKIZMLysDvLt1eWAEw5CkogWgM1xeRvG8CwXi/w99/sdpn4noBtkGt0OE
	Xkewj6lNEIAxGqooyTtVvKZT70UQWaVCVJii9VHMM+A5qknUgAydsTaelbiBK3yN
	6SuD769Qf1Y0CjkKxskUL6dHuzp7/NG+aUlfY8bYXviM29g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cyxmh1t7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 22:55:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Mar 2026 22:55:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 18 Mar 2026 22:55:40 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E344E3F7052;
	Wed, 18 Mar 2026 22:55:35 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <matttbe@kernel.org>, <cjubran@nvidia.com>,
        <shshitrit@nvidia.com>, "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v6 net-next 0/5] octeontx2-af: npc: Enhancements.
Date: Thu, 19 Mar 2026 11:25:28 +0530
Message-ID: <20260319055533.1720093-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6iBGLKmGk-PHvM0e7Q_CMHlLx7Hb6POn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0MyBTYWx0ZWRfX/vO3/y/LXKqz
 wq93oZ6QALP9KNEUJNx5pvOImWOqVSUby9k5oXycABqhTStUJKRYSdUQ9fsR1mp7ZD/14dqiYtD
 8IvCRo9gABOxwvusMuOQf8rco59VBS+NShuU8OCHZa+LnwKikg+ZQL9m1+6uVd8ZmeOGJG5Cwf0
 FMVHBK9E12Priwsc+2LJurFBpkRA/KafwMGZixorUBmz0y199S8YZQqh1HOmYJSXzN1PFccPbrj
 xdh0+sYNmQ0IHlFmcyQl1ocwsA4FnWAhZfjX3/hREKus8nehxznMqFnevZ1ydcsY+XP1DkS9eHl
 v5i3xPwV27eNcTaGvdzRyV95wjG7lYk+4SwDoVzFM3Jn4fYDyQW9CiBCZv2rll5wHS8YwoCrbbS
 sVJYkP63DDWmzmI5jikw0yuVpUcNnB8iYlaISUF+xlbLFmRgguxFviwa7upIa9VPfBZAfMONO1H
 gtu5DKTSTT7maAiBNJg==
X-Authority-Analysis: v=2.4 cv=KvNAGGWN c=1 sm=1 tr=0 ts=69bb8fde cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=32TfifE4CFI_pm9Ig-oA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 6iBGLKmGk-PHvM0e7Q_CMHlLx7Hb6POn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269313-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.948];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C6D722C6624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds features in NPC HW block in the OcteonTX2 AF driver
for better observability, configuration, and resource management.

Patch 1 adds debugfs enhancements for CN20K: mcam_layout now shows
enabled/disabled state per MCAM entry; a new "dstats" entry reports hit
counts with delta semantics; and "mismatch" lists entries that are
enabled but not explicitly allocated.

Patch 2 (from Saeed) extends devlink with DEVLINK_PARAM_TYPE_U32_ARRAY
so params can accept multiple u32 values in a single value. This is
used by patch 3 for subbank search order.

Patch 3 adds a devlink parameter "srch_order" for CN20K to control
the order in which NPC subbanks are searched during MCAM allocation,
allowing users to tune rule priority without firmware changes.

Patch 4 ties default MCAM entries (broadcast, multicast, promisc, ucast)
to NIX LF lifetime: they are allocated when a NIX LF is allocated and
freed when it is released, improving MCAM utilization.
NIX_LF_DONT_FREE_DFT_IDXS lets the kernel PF retain default entries
across suspend/resume.

Patch 5 allows loading a custom KPU profile from the filesystem via
a module parameter (kpu_profile=), avoiding firmware flashes for
profile updates.

Ratheesh Kannoth (4):
  octeontx2-af: npc: cn20k: debugfs enhancements
  octeontx2-af: npc: cn20k: Add devlink support for search order
  octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM
    entries
  octeontx2-af: Add support for loading custom KPU profile from
    filesystem

Saeed Mahameed (1):
  devlink: Implement devlink param multi attribute nested data values

 Documentation/netlink/specs/devlink.yaml      |   4 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      | 120 +++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 192 ++++++++++---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   9 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  14 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  88 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  14 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 269 ++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   1 +
 .../marvell/octeontx2/nic/otx2_pf.c          |   6 +-
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                 |   1 +
 net/devlink/netlink_gen.c                     |   2 +
 net/devlink/param.c                           |  78 +++--
 16 files changed, 674 insertions(+), 136 deletions(-)

--

v5 -> v6: Addressed Jakub,Jiri comments
	https://lore.kernel.org/netdev/20260317045623.250187-1-rkannoth@marvell.com/

v4 -> v5: Addressed Jakub comments
	https://lore.kernel.org/netdev/20260312022754.2029595-6-rkannoth@marvell.com/

v3 -> v4: Addressed Simon comments
	https://lore.kernel.org/netdev/abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090/#t

v2 -> v3: Addressed Simon comments.
	https://lore.kernel.org/netdev/20260304043032.3661647-1-rkannoth@marvell.com/
v1 -> v2: Addressed Jakub comments.
	https://lore.kernel.org/netdev/20260302085803.2449828-1-rkannoth@marvell.com/#t

2.43.0

