Return-Path: <netdev+bounces-111394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB4D930B9B
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 22:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8FA1C2042E
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4952E136982;
	Sun, 14 Jul 2024 20:28:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04852572
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720988934; cv=none; b=bR1ZvjUt/28elf10E9cbNFMwK8pg5gg8sBRA2E3/jg03AtXtFhK3TmdxLgJxD67aNimqrRocFoRDfaCRYQUpkrssoZwHSfKVjt6uQT/aAfF9VK4eUTRlQHutzhfs/n6V2U0PWiYbshru+kNj2O6kPzOfU08DLg5PYepyBOmU7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720988934; c=relaxed/simple;
	bh=xfetClGdKhj26kP8QY6zJ7DfEeLLcq/giN842HJ1Dfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDj8e9Zh5HjLM7ZSN6gJsbnlqWNretX/ugjfABKJXVxpFW3IKaF2sh7+x0GQ921Qk8NzM4cbFmHRUM2efib6CPZgMmgQJJlBMiED0MyypUBKmqXPbmTuFtdfK16j/7aGsfaDPpkzXEBACXu32ouk542hZZOhGQJ7VtAx+E0qh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id DE0A87D01F;
	Sun, 14 Jul 2024 20:23:32 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>
Subject: [PATCH ipsec-next v5 00/17] Add IP-TFS mode to xfrm
Date: Sun, 14 Jul 2024 16:22:28 -0400
Message-ID: <20240714202246.1573817-1-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Summary of Changes:

This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
(AggFrag encapsulation) has been standardized in RFC9347.

  Link: https://www.rfc-editor.org/rfc/rfc9347.txt

This feature supports demand driven (i.e., non-constant send rate)
IP-TFS to take advantage of the AGGFRAG ESP payload encapsulation. This
payload type supports aggregation and fragmentation of the inner IP
packet stream which in turn yields higher small-packet bandwidth as well
as reducing MTU/PMTU issues. Congestion control is unimplementated as
the send rate is demand driven rather than constant.

In order to allow loading this fucntionality as a module a set of
callbacks xfrm_mode_cbs has been added to xfrm as well.

Patchset Changes:
-----------------

  24 files changed, 3326 insertions(+), 43 deletions(-)
  Documentation/networking/xfrm_sysctl.rst |   30 +
  include/net/netns/xfrm.h                 |    6 +
  include/net/xfrm.h                       |   40 +
  include/uapi/linux/in.h                  |    2 +
  include/uapi/linux/ip.h                  |   16 +
  include/uapi/linux/ipsec.h               |    3 +-
  include/uapi/linux/snmp.h                |    3 +
  include/uapi/linux/xfrm.h                |    9 +-
  net/ipv4/esp4.c                          |    3 +-
  net/ipv6/esp6.c                          |    3 +-
  net/netfilter/nft_xfrm.c                 |    3 +-
  net/xfrm/Kconfig                         |   16 +
  net/xfrm/Makefile                        |    1 +
  net/xfrm/trace_iptfs.h                   |  218 +++
  net/xfrm/xfrm_compat.c                   |   10 +-
  net/xfrm/xfrm_device.c                   |    4 +-
  net/xfrm/xfrm_input.c                    |   14 +-
  net/xfrm/xfrm_iptfs.c                    | 2748 ++++++++++++++++++++++++++++++
  net/xfrm/xfrm_output.c                   |    6 +
  net/xfrm/xfrm_policy.c                   |   26 +-
  net/xfrm/xfrm_proc.c                     |    3 +
  net/xfrm/xfrm_state.c                    |   60 +
  net/xfrm/xfrm_sysctl.c                   |   70 +-
  net/xfrm/xfrm_user.c                     |   75 +

Patchset Structure:
-------------------

The first 7 commits are changes to the xfrm infrastructure to support
the callbacks as well as more generic IP-TFS additions that may be used
outside the actual IP-TFS implementation.

  - xfrm: config: add CONFIG_XFRM_IPTFS
  - include: uapi: add ip_tfs_*_hdr packet formats
  - include: uapi: add IPPROTO_AGGFRAG for AGGFRAG in ESP
  - xfrm: sysctl: allow configuration of global default values
  - xfrm: netlink: add config (netlink) options
  - xfrm: add mode_cbs module functionality
  - xfrm: add generic iptfs defines and functionality

The last 10 commits constitute the IP-TFS implementation constructed in
layers to make review easier. The first 9 commits all apply to a single
file `net/xfrm/xfrm_iptfs.c`, the last commit adds a new tracepoint
header file along with the use of these new tracepoint calls.

  - xfrm: iptfs: add new iptfs xfrm mode impl
  - xfrm: iptfs: add user packet (tunnel ingress) handling
  - xfrm: iptfs: share page fragments of inner packets
  - xfrm: iptfs: add fragmenting of larger than MTU user packets
  - xfrm: iptfs: add basic receive packet (tunnel egress) handling
  - xfrm: iptfs: handle received fragmented inner packets
  - xfrm: iptfs: add reusing received skb for the tunnel egress packet
  - xfrm: iptfs: add skb-fragment sharing code
  - xfrm: iptfs: handle reordering of received packets
  - xfrm: iptfs: add tracepoint functionality

Patchset History:
-----------------

RFCv1 (11/10/2023)

RFCv1 -> RFCv2 (11/12/2023)

  Updates based on feedback from Simon Horman, Antony,
  Michael Richardson, and kernel test robot.

RFCv2 -> v1 (2/19/2024)

  Updates based on feedback from Sabrina Dubroca, kernel test robot

v1 -> v2 (5/19/2024)

  Updates based on feedback from Sabrina Dubroca, Simon Horman, Antony.

  o Add handling of new netlink SA direction attribute (Antony).
  o Split single patch/commit of xfrm_iptfs.c (the actual IP-TFS impl)
    into 9+1 distinct layered functionality commits for aiding review.
  - xfrm: fix return check on clone() callback
  - xfrm: add sa_len() callback in xfrm_mode_cbs for copy to user
  - iptfs: remove unneeded skb free count variable
  - iptfs: remove unused variable and "breadcrumb" for future code.
  - iptfs: use do_div() to avoid "__udivd13 missing" link failure.
  - iptfs: remove some BUG_ON() assertions questioned in review.

v2->v3
  - Git User Glitch

v2->v4 (6/17/2024)

  - iptfs: copy only the netlink attributes to user based on the
    direction of the SA.

  - xfrm: stats: in the output path check for skb->dev == NULL prior to
    setting xfrm statistics on dev_net(skb->dev) as skb->dev may be NULL
    for locally generated packets.

  - xfrm: stats: fix an input use case where dev_net(skb->dev) is used
    to inc stats after skb is possibly NULL'd earlier. Switch to using
    existing saved `net` pointer.

v4->v5
  - uapi: add units to doc comments
  - iptfs: add MODULE_DESCRIPTION()
  - squash nl-direction-update commit

