Return-Path: <netdev+bounces-144716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA29C83DA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23340287777
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B991F26C7;
	Thu, 14 Nov 2024 07:13:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266DD1EBFED
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568394; cv=none; b=W9LqjaLjalQX+CXWXfaTJc+83B2xxwZDK3qqCVMbdNN44Xq3ETSGk7CbSTEKtz0p10m0i1/VIUmzbpIk66SEFF46AvP80yRwUZb87xc+gKmYqnKNlBpiELOBTxxwuj5J6kp7Nu6W5b0Syc3SijZlxowJNKXKMVAHgf5mjgFnoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568394; c=relaxed/simple;
	bh=yi/com0mX3GSNSS/wcq8/MKaqdSw/ItuiHjMlQqiH4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ea/+A+rCSWQ2Z/ETMQ6XbPBFY6BzyL711FQnWdjD7sEko9zjIUdZ910BclQJ7R4FQYzl819UP2c6I58xou0evzIkCyvIK/w9Nhwai8Co8v9pzd+BdDkPsXYwv5qVr23yjnYwouzakhI9MgHkaPBsP0uX41PK3LBafRTZAb6EGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 5AF617D023;
	Thu, 14 Nov 2024 07:07:27 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>
Subject: [PATCH ipsec-next v14 00/15] Add IP-TFS mode to xfrm
Date: Thu, 14 Nov 2024 02:06:57 -0500
Message-ID: <20241114070713.3718740-1-chopps@chopps.org>
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

v13->v14 (11/14/2024)
  - Fix fix m68k unused function build warning from kernel test robot

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
 net/xfrm/xfrm_iptfs.c      | 2764 ++++++++++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_output.c     |    6 +
 net/xfrm/xfrm_policy.c     |   26 +-
 net/xfrm/xfrm_proc.c       |    2 +
 net/xfrm/xfrm_state.c      |   84 ++
 net/xfrm/xfrm_user.c       |   77 ++
 21 files changed, 3292 insertions(+), 19 deletions(-)


