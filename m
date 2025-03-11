Return-Path: <netdev+bounces-173912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2808AA5C36C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13463B120B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBF025B69D;
	Tue, 11 Mar 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="XqaWMu8p"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4225B679
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702393; cv=none; b=m9YX1XhGgIJx/slQR+vqA7O1lGlTn5qtrTfwxLBv6KDc0H519EDSmhg9tRcSB/CldWwmOnSfdPJMyAx25017js7ZAWlsjtG71KcEfiDW9DnwjQdVFLJ3e1faNlNG1NVaWg4n2AKV2xH3bwLc3DRGLeD6u+qn8RcVmZik8bSKFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702393; c=relaxed/simple;
	bh=QOpsUjqDGF2gMRhCl/pcmdgDv0beCn9yyCa5DHDdDRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzCWh9azVPY0hXQJ/14xHX1PJYT6tJeURDskrGz4TSMJ44PvTq2W0C10bnmbOrVDg0//MCfYoYUwIDlOI0BRAF91ulTpYSX1IUdSKj+eImgOVyg0Ikm/yl5JXrEQ7R8apW66dq4VRu/5VBxY8gNUswowMHX/m6m3Yw/bf8iVg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=XqaWMu8p; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C4174200E1C2;
	Tue, 11 Mar 2025 15:13:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C4174200E1C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741702383;
	bh=1RLi/PZH36dlPYVUF6V2wz4qlMB5zHEEXzkKpKqAF+U=;
	h=From:To:Cc:Subject:Date:From;
	b=XqaWMu8pXY/3570nEmSC1wn6ZIAdZzVubYkHSp/KF2MGOjNI7uj4ZjrHJvf6o3tM7
	 5pv86RjyHwbvuYvREf+GF5/lQZQ43jP5OQoICPNUMRMCIcW1ZGrjxz3zc0pflW8fVD
	 Ud4AiZD6Qm9lVDRy3NkSLLS+un4LklWf2l0gGlyhtFSOL5W4aG4oVNu62XrznI9HvX
	 AcqQNPtVxhSwzx7vU1+jRth5oYH3Q2tOZJBFe0NsGbNzYpHTyUhrx6NBd74HSHHRHS
	 nW46iobk7c7GjpzPmg9oTau8b6mY/oeIP0qdVa6wo9fFBSLSOw8BtV7zQu8MvC1GZd
	 h5O22HgaEJSSQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net 0/7] net: fix lwtunnel reentry loops
Date: Tue, 11 Mar 2025 15:12:31 +0100
Message-Id: <20250311141238.19862-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the destination is the same after the transformation, we enter a
lwtunnel loop. This is true for most of lwt users: ioam6, rpl, seg6,
seg6_local, ila_lwt, and lwt_bpf. It can happen in their input() and
output() handlers respectively, where either dst_input() or dst_output()
is called at the end. It can also happen in xmit() handlers. This patch
prevents that kind of reentry loop by redirecting to the origin input()
or output() when the destination is the same after the transformation.

Here is an example for rpl_input():

dump_stack_lvl+0x60/0x80
rpl_input+0x9d/0x320
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
[...]
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
ip6_sublist_rcv_finish+0x85/0x90
ip6_sublist_rcv+0x236/0x2f0

... until rpl_do_srh() fails, which means skb_cow_head() failed.

Justin Iurman (7):
  net: ipv6: ioam6: fix lwtunnel_output() loop
  net: ipv6: rpl: fix lwtunnel_input/output loop
  net: ipv6: seg6: fix lwtunnel_input/output loop
  net: ipv6: seg6_local: fix lwtunnel_input() loop
  net: ipv6: ila: fix lwtunnel_output() loop
  net: core: bpf: fix lwtunnel_input/xmit loop
  selftests: net: test for lwtunnel dst ref loops

 net/core/lwt_bpf.c                            |  21 ++
 net/ipv6/ila/ila_lwt.c                        |   8 +
 net/ipv6/ioam6_iptunnel.c                     |   8 +-
 net/ipv6/rpl_iptunnel.c                       |  14 +
 net/ipv6/seg6_iptunnel.c                      |  37 ++-
 net/ipv6/seg6_local.c                         |  85 +++++-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   2 +
 .../selftests/net/lwt_dst_cache_ref_loop.sh   | 250 ++++++++++++++++++
 9 files changed, 412 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh

-- 
2.34.1


