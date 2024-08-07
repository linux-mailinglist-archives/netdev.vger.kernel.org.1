Return-Path: <netdev+bounces-116592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C6F94B1DA
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6071F22394
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DAC14EC47;
	Wed,  7 Aug 2024 21:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E6D149DE4
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065261; cv=none; b=DZYdihvrZhZyRMdCHyVRuemcUZVtUNWzwdkgxX+74F8Wf9dpjKJm39wVNiVr8W5ys+xsJ3VWVZezEMzgbmSPuqD00xoxLaDPUAkgW/cFpvguEmE4hkWcz5ZbCuhoWQ7MzWtzjyYj9j/xK2+lqs6WZ5AFpobx578FMatf2sn/ovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065261; c=relaxed/simple;
	bh=ua5Db5PD8j+O8Z9xH5fu26afq+jy5oIdU2A1rjGhuSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0KnV1c8UzNtLNXhMp0VwcKigLW1TNCX3FljYgR533vbP6CJQPwU7PhZ4VJE1kNfU78siGth7/tTi/RAgXlMZph4hAV7asQM3QREQHVAbYFpJoYKl2OJzzZyjb02wUhAMwts5Ba6BytEFiijciy4mXAzjZciUZ6Le/MwZlGVvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 5C3BD7D0C1;
	Wed,  7 Aug 2024 21:14:18 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>
Subject: [PATCH ipsec-next v9 00/17] Add IP-TFS mode to xfrm
Date: Wed,  7 Aug 2024 17:13:14 -0400
Message-ID: <20240807211331.1081038-1-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
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

  include/linux/skbuff.h     |    1 +
  include/net/xfrm.h         |   44 +
  include/uapi/linux/in.h    |    2 +
  include/uapi/linux/ip.h    |   16 +
  include/uapi/linux/ipsec.h |    3 +-
  include/uapi/linux/snmp.h  |    2 +
  include/uapi/linux/xfrm.h  |    9 +-
  net/core/skbuff.c          |    7 +-
  net/ipv4/esp4.c            |    3 +-
  net/ipv6/esp6.c            |    3 +-
  net/netfilter/nft_xfrm.c   |    3 +-
  net/xfrm/Kconfig           |   16 +
  net/xfrm/Makefile          |    1 +
  net/xfrm/trace_iptfs.h     |  218 ++++
  net/xfrm/xfrm_compat.c     |   10 +-
  net/xfrm/xfrm_device.c     |    4 +-
  net/xfrm/xfrm_input.c      |   18 +-
  net/xfrm/xfrm_iptfs.c      | 2822 ++++++++++++++++++++++++++++++++++++++++++++
  net/xfrm/xfrm_output.c     |    6 +
  net/xfrm/xfrm_policy.c     |   26 +-
  net/xfrm/xfrm_proc.c       |    2 +
  net/xfrm/xfrm_state.c      |   84 ++
  net/xfrm/xfrm_user.c       |   77 ++
  23 files changed, 3357 insertions(+), 20 deletions(-)

Patchset Structure:
-------------------

The first 7 commits are changes to the xfrm infrastructure to support
the callbacks as well as more generic IP-TFS additions that may be used
outside the actual IP-TFS implementation.

  - net: refactor common skb header copy code for re-use
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

v6->v7 (8/1/2024)
  - Rebased on latest ipsec-next

v7->v8 (8/4/2024)
  - Use lock and rcu to load iptfs module -- copy existing use pattern
  - fix 2 warnings from the kernel bot

v8->v9 (8/7/2024)
  - factor common code from skbuff.c:__copy_skb_header into ___copy_skb_header
    and use in iptfs rather that copying any code.
  - change all BUG_ON to WARN_ON_ONCE
  - remove unwanted new NOSKB xfrm MIB error counter
  - remove unneeded copy or share choice function
  - ifdef CONFIG_IPV6 around IPv6 function

