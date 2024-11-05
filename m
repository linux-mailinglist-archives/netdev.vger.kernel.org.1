Return-Path: <netdev+bounces-141836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641789BC821
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8730C1C22407
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C71F1CF7DB;
	Tue,  5 Nov 2024 08:38:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F413633F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795911; cv=none; b=U0y2DQe8BafT7xiwsk6YAHNGxDHMECnOk+57BnNlyTkDaBWqratcF7Xo3d7mIWMt3H8mgPVjsWJixnROA4iBiH8Ae2IV8OM0TJB23lg5Xx0Qc7kWYAhHiRtKnORmqF2NphzxYU74dRSLtyrc3pCZb13gMjYmtOUkDlNpwYbkWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795911; c=relaxed/simple;
	bh=xesErViyi3xjC7jxBFte8NoyGGgvxSI+jxdpRC4R0a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pb/ehOtolPylLChg547UusvqoSri+kx5TJN/kzPDUgGCbw4HVY7R6+N4ocN4fW819NuGsnHIQ1d0el0M5tBSFA6glCvlC4Qx8hXvzh9WKI8lFy1FExJ0KY+9OXOmiCqA3c6YlMdjua/NXLayT52qH8XTlGqaX9ONU4WdoMUH+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 4333C7D0E5;
	Tue,  5 Nov 2024 08:38:20 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>
Subject: [PATCH ipsec-next v13 00/15] Add IP-TFS mode to xfrm
Date: Tue,  5 Nov 2024 03:37:44 -0500
Message-ID: <20241105083759.2172771-1-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
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

Patchset Structure:
-------------------

The first 5 commits are changes to the net and xfrm infrastructure to
support the callbacks as well as more generic IP-TFS additions that
may be used outside the actual IP-TFS implementation.

  - xfrm: config: add CONFIG_XFRM_IPTFS
  - include: uapi: protocol number and packet structs for AGGFRAG in ESP
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

v12->v13 (11/5/2024)
  - rebase on updated ipsec-next
  - remove non-standard WARN_ON usages
  - remove non-standard (void) prefix use which indicated ignored return value.
  - move 2 structure fields to compact in-core layout
  - refactor loop out of iptfs_input_ordered() to improve code readability
  - a few format cleanup changes.

v11->v12 (9/14/2024)
  - fix for SA migration, dont alloc over top of newly cloned data 

v10->v11 (9/6/2024)
  - fix double init when xfrm_migrate_state (clone) is called.
  - rename create_state, clone, and delete_state callbacks to
    init_state, clone_state, and destroy_state.
  - skb_orphan skbs prior to aggregation

v9->v10 (8/23/2024)
  - use relocated skb_copy_seq_read now in skbuff.[ch]
  - be thoughtful about skb reserve space in new skbs, use existing #defines and
    skb meta-data to calculate new skb reserve and alignment.
  - only copy dst (on in/out) and dev, ext (on resume input) values from
    existing skb header to new skb's -- drop use of rejected new
    ___copy_skb_header() function.
  - update other iptfs specific skb function names

v8->v9 (8/7/2024)
  - factor common code from skbuff.c:__copy_skb_header into
    ___copy_skb_header and use in iptfs rather that copying any code.
  - change all BUG_ON to WARN_ON_ONCE
  - remove unwanted new NOSKB xfrm MIB error counter
  - remove unneeded copy or share choice function
  - ifdef CONFIG_IPV6 around IPv6 function

v7->v8 (8/4/2024)
  - Use lock and rcu to load iptfs module -- copy existing use pattern
  - fix 2 warnings from the kernel bot

v6->v7 (8/1/2024)
  - Rebased on latest ipsec-next

v5->v6 (7/31/2024)
  * sysctl: removed IPTFS sysctl additions
  - xfrm: use array of pointers vs structs for mode callbacks
  - iptfs: eliminate a memleak during state alloc failure
  - iptfs: free send queue content on SA delete
  - add some kdoc and comments
  - cleanup a couple formatting choices per Steffen

v4->v5 (7/14/2024)
  - uapi: add units to doc comments
  - iptfs: add MODULE_DESCRIPTION()
  - squash nl-direction-update commit

v2->v4 (6/17/2024)

  - iptfs: copy only the netlink attributes to user based on the
    direction of the SA.

  - xfrm: stats: in the output path check for skb->dev == NULL prior to
    setting xfrm statistics on dev_net(skb->dev) as skb->dev may be NULL
    for locally generated packets.

  - xfrm: stats: fix an input use case where dev_net(skb->dev) is used
    to inc stats after skb is possibly NULL'd earlier. Switch to using
    existing saved `net` pointer.

v2->v3
  - Git User Glitch

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

RFCv2 -> v1 (2/19/2024)

  Updates based on feedback from Sabrina Dubroca, kernel test robot

RFCv1 -> RFCv2 (11/12/2023)

  Updates based on feedback from Simon Horman, Antony,
  Michael Richardson, and kernel test robot.

RFCv1 (11/10/2023)

Patchset Changes:
-----------------

 include/net/xfrm.h         |   44 +
 include/uapi/linux/in.h    |    2 +
 include/uapi/linux/ip.h    |   16 +
 include/uapi/linux/ipsec.h |    3 +-
 include/uapi/linux/snmp.h  |    2 +
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
 net/xfrm/xfrm_iptfs.c      | 2762 ++++++++++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_output.c     |    6 +
 net/xfrm/xfrm_policy.c     |   26 +-
 net/xfrm/xfrm_proc.c       |    2 +
 net/xfrm/xfrm_state.c      |   84 ++
 net/xfrm/xfrm_user.c       |   77 ++
 21 files changed, 3290 insertions(+), 19 deletions(-)

