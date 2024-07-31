Return-Path: <netdev+bounces-114718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8F943984
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483FD1F2162E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 23:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A416DC01;
	Wed, 31 Jul 2024 23:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A01C14B097
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469924; cv=none; b=U45m9ZuoTbA6KCckhW2//jjd3NbGl8eznMmDD1OBDMeM+j3GRJp0oGNTXXdiPpBu6f1ZsqiG+xl6n6TlBfdDGmOTmKB8KlftM/ksdTDDce1pTyT5+0nhGLSGFzfjYBViu+YZ4Ha6dsc2BP4trTAXbL8mqAYFqa3415AyAfvlZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469924; c=relaxed/simple;
	bh=G6qYmOIAI+rzsKbwnILAm7ubMJ8TCHQvjL5B2kSABe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utvtHdVdedVcWtKQfMmdEDs1PmiK+iLk5/fTydQn8BCcRP8PUbqB5jgQP78yPVG0d8b40bJRO1YEkF06imNBh4E8Ly0z065uNAELKZBcsKR6JNfg556XKkKSM21JDd8ibQCctvZSwqm/HPtzkOMFscWDoKIHY3KJv9j4N10fQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 420E27D052;
	Wed, 31 Jul 2024 23:52:01 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>
Subject: [PATCH ipsec-next v6 00/16] Add IP-TFS mode to xfrm
Date: Wed, 31 Jul 2024 19:51:09 -0400
Message-ID: <20240731235125.1063594-1-chopps@chopps.org>
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

  21 files changed, 3370 insertions(+), 19 deletions(-)
  include/net/xfrm.h         |   44 +
  include/uapi/linux/in.h    |    2 +
  include/uapi/linux/ip.h    |   16 +
  include/uapi/linux/ipsec.h |    3 +-
  include/uapi/linux/snmp.h  |    3 +
  include/uapi/linux/xfrm.h  |    9 +-
  net/ipv4/esp4.c            |    3 +-
  net/ipv6/esp6.c            |    3 +-
  net/netfilter/nft_xfrm.c   |    3 +-
  net/xfrm/Kconfig           |   16 +
  net/xfrm/Makefile          |    1 +
  net/xfrm/trace_iptfs.h     |  218 ++++
  net/xfrm/xfrm_compat.c     |   10 +-
  net/xfrm/xfrm_device.c     |    4 +-
  net/xfrm/xfrm_input.c      |   18 +-
  net/xfrm/xfrm_iptfs.c      | 2864 ++++++++++++++++++++++++++++++++++++++++++++
  net/xfrm/xfrm_output.c     |    6 +
  net/xfrm/xfrm_policy.c     |   26 +-
  net/xfrm/xfrm_proc.c       |    3 +
  net/xfrm/xfrm_state.c      |   60 +
  net/xfrm/xfrm_user.c       |   77 ++

Patchset Structure:
-------------------

The first 6 commits are changes to the xfrm infrastructure to support
the callbacks as well as more generic IP-TFS additions that may be used
outside the actual IP-TFS implementation.

  - xfrm: config: add CONFIG_XFRM_IPTFS
  - include: uapi: add ip_tfs_*_hdr packet formats
  - include: uapi: add IPPROTO_AGGFRAG for AGGFRAG in ESP
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

v4->v5 (7/14/2024)
  - uapi: add units to doc comments
  - iptfs: add MODULE_DESCRIPTION()
  - squash nl-direction-update commit

v5->v6 (7/31/2024)
  * sysctl: removed IPTFS sysctl additions
  - xfrm: use array of pointers vs structs for mode callbacks
  - iptfs: eliminate a memleak during state alloc failure
  - iptfs: free send queue content on SA delete
  - add some kdoc and comments
  - cleanup a couple formatting choices per Steffen

