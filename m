Return-Path: <netdev+bounces-97250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2B8CA3EC
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 23:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE1D1C21077
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4200B137C25;
	Mon, 20 May 2024 21:46:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E092C1847
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241576; cv=none; b=sAfI+o7qdDjyXapw+L5Rmh1lcGnBsMIG5zbLKbdDk6HT+u/UUcicRlM1cbrdC7tZOqZMbbf+2PmPFI0/8OQwaBhBkc75D1LU+vYNDYVWnZqMXLXD1JNALX71lE0FDGNjf39jbnqo2txgUsK28MZsUsETfXy4qEhxG8eXYjCwwZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241576; c=relaxed/simple;
	bh=wrVmQG3q0c2EgtNe4UTuowNxoiN2Gi47CrhEmr4FuyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlZuC/LeCeM5PUaxQEkm9NVEOCN79lXWZj+bVmYdGvOq4O+mr0NEoUXm8oWV0N8tTDEIpl4o0acSlw8t0QCCJ064XwgZmtdR0W6GZN8e5Hxg8yTS4uMAOGcrZ61tzaSShpeckeDQIcVKpslQON4ye1+dL2OrYCYZR+mAf7RoJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 1A6E17D138;
	Mon, 20 May 2024 21:46:14 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v2 0/17] Add IP-TFS mode to xfrm
Date: Mon, 20 May 2024 17:45:58 -0400
Message-ID: <20240520214558.2592618-1-chopps@chopps.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Summary of Changes
------------------

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

  23 files changed, 3252 insertions(+), 19 deletions(-)
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
  net/xfrm/Makefile                        |    1 +
  net/xfrm/trace_iptfs.h                   |  218 +++
  net/xfrm/xfrm_compat.c                   |   10 +-
  net/xfrm/xfrm_device.c                   |    4 +-
  net/xfrm/xfrm_input.c                    |   14 +-
  net/xfrm/xfrm_iptfs.c                    | 2741 ++++++++++++++++++++++++++++++
  net/xfrm/xfrm_output.c                   |    6 +
  net/xfrm/xfrm_policy.c                   |   26 +-
  net/xfrm/xfrm_proc.c                     |    3 +
  net/xfrm/xfrm_state.c                    |   60 +
  net/xfrm/xfrm_sysctl.c                   |   38 +
  net/xfrm/xfrm_user.c                     |   32 +

Patchset Structure:
-------------------

The first 8 commits are changes to the xfrm infrastructure to support
the callbacks as well as more generic IP-TFS additions that may be used
outside the actual IP-TFS implementation.

  - iptfs: config: add CONFIG_XFRM_IPTFS
  - iptfs: uapi: ip: add ip_tfs_*_hdr packet formats
  - iptfs: uapi: IPPROTO_AGGFRAG AGGFRAG in ESP
  - iptfs: sysctl: allow configuration of global default values
  - iptfs: netlink: add config (netlink) options
  - iptfs: xfrm: Add mode_cbs module functionality
  - iptfs: xfrm: add generic iptfs defines and functionality

The last 9+1 commits constitute the IP-TFS implementation constructed in
layers to make review easier. The first 9 commits all apply to a single
file `net/xfrm/xfrm_iptfs.c`, the last commit adds a new tracepoint
header file along with the use of these new tracepoint calls.

  - iptfs: impl: add new iptfs xfrm mode impl
  - iptfs: impl: add user packet (tunnel ingress) handling
  - iptfs: impl: share page fragments of inner packets
  - iptfs: impl: add fragmenting of larger than MTU user packets
  - iptfs: impl: add basic receive packet (tunnel egress) handling
  - iptfs: impl: handle received fragmented inner packets
  - iptfs: impl: add reusing received skb for the tunnel egress packet
  - iptfs: impl: add skb-fragment sharing code
  - iptfs: impl: handle reordering of received packets
  - iptfs: impl: add tracepoint functionality

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

