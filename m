Return-Path: <netdev+bounces-176337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93167A69C8A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF9A1712D4
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C713222564;
	Wed, 19 Mar 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nnm7evSi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63892222CF
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425694; cv=none; b=WC2VPh1ihDDatcZDFdS0F8r0sj/oP7QwhNoin2fY9V+lrfJr59hmGD3vfHwzSkpLQrfM2QW2g10Oic0si9a9ur5UvZby8+sYSo2pXZj3bc7p8k7f7c+L9TAOZnGedrOiG2vSCNEupuFKjmhQFGQLXRxyfxr+99qeGxX2DOzr42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425694; c=relaxed/simple;
	bh=ckUHbN1xF2WS3mHfOl8haID1UF0IbIE3KUAOksvDlx8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iepPxFzUbP+8IdCKLW5uPDx2YS76FNRpRAYiAn8aighScdAdW9CUJqBd4Z0t8+S/8xNcdIEqpLJ7mIFIPGHTKJpQmi+lKLXI3Inuh90eor7pwA+e43YiYVHSTt/2/w8QsYj+XHI3xYb65/4ox+GXewhlEtmnmUKl7eKjpWtFNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nnm7evSi; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742425693; x=1773961693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BhqXUPgzk1/PD6DPxzsuwzyyvm4rt6RDsU0Hjmoe+2M=;
  b=nnm7evSiUEg/GJHKa6BlV2auylZ0IJUhLImkpynyWfsd9n/FsFR7Mik6
   psJG7MWT1RQ9NntyeaBohChu9CM898jQaAfPRYNe0XqbzDjXjKVOmv0Ic
   rchJsxf7qTNbblIC9I1QDUlswH83f+88h+1Ho8MpvpbirdB5Ybnxb+yc8
   M=;
X-IronPort-AV: E=Sophos;i="6.14,260,1736812800"; 
   d="scan'208";a="476536600"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 23:08:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:40738]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.90:2525] with esmtp (Farcaster)
 id 0f5c9c6f-7028-4f5e-9d89-1630ccf5d803; Wed, 19 Mar 2025 23:08:08 +0000 (UTC)
X-Farcaster-Flow-ID: 0f5c9c6f-7028-4f5e-9d89-1630ccf5d803
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:08:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:07:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/7] nexthop: Convert RTM_{NEW,DEL}NEXTHOP to per-netns RTNL.
Date: Wed, 19 Mar 2025 16:06:45 -0700
Message-ID: <20250319230743.65267-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 - 5 move some validation for RTM_NEWNEXTHOP so that it can be
called without RTNL.

Patch 6 & 7 converts RTM_NEWNEXTHOP and RTM_DELNEXTHOP to per-netns RTNL.

Note that RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET are not touched in
this series.

rtm_get_nexthop() can be easily converted to RCU, but rtm_dump_nexthop()
needs more work due to the left-to-right rbtree walk, which looks prone
to node deletion and tree rotation without a retry mechanism.


Changes:
  v2:
    * Patch 2
      * Correct err check in rtm_new_nexthop()

  v1: https://lore.kernel.org/netdev/20250318233240.53946-1-kuniyu@amazon.com/


Kuniyuki Iwashima (7):
  nexthop: Move nlmsg_parse() in rtm_to_nh_config() to
    rtm_new_nexthop().
  nexthop: Split nh_check_attr_group().
  nexthop: Move NHA_OIF validation to rtm_to_nh_config_rtnl().
  nexthop: Check NLM_F_REPLACE and NHA_ID in rtm_new_nexthop().
  nexthop: Remove redundant group len check in nexthop_create_group().
  nexthop: Convert RTM_NEWNEXTHOP to per-netns RTNL.
  nexthop: Convert RTM_DELNEXTHOP to per-netns RTNL.

 net/ipv4/nexthop.c | 183 +++++++++++++++++++++++++++------------------
 1 file changed, 112 insertions(+), 71 deletions(-)

-- 
2.48.1


