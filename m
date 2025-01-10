Return-Path: <netdev+bounces-157021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD9FA08C19
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7E63A2ACE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BA20B1ED;
	Fri, 10 Jan 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QSs+JLpr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89D20ADC9
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501226; cv=none; b=WQFg05I6arHGj8wFcnuSHABIbqOveNsTWsy93ujrQ/xFpjzdNNG/oPwfQXsg/84Bzupow0Ym50dstScMGl8kdfm05BRDFjIQJhMl2XYKlUzSALkRnsjLZHtOLY8oRoygsd+rcs0izqahz/9JSeNy2NN5fo2um8A4QLZ+UYxHeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501226; c=relaxed/simple;
	bh=DGsqwIuS48ZvPe76z9hghRhJbnQxn0iMDZNLSWjQOJs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KY4D8SxBuOHGAhVvYZTZRTJiSMPHoi9vU07dnWSZsx1/7MG6Ja0zqUYdOkvUIQZ57EpEEu7sDjvGbnArKuMTs57Yq5F7N51Oh7LUObbn0Thciy/aLpOUAZOs+bD5I1VCbybq24AiIHli4mWrmrX91pWzDIFoA4mHt5GCT8TYuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QSs+JLpr; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501221; x=1768037221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IJe50CAxA8cp5Pmo5uBOZRmvW2nYu5+5LG0nBN9BXgA=;
  b=QSs+JLprTkXC/NGWhf2WNjcXJhHW6sSSpxwECBxZXgsEb5VDiIQQJGqI
   wLt54+b3or3ZpmlqEJT8I5KdK+mWmWEmgBvPtJmrV9FhQeEDPaOWV1alT
   +AiJpo2eYi9snwVE9jeFdOAisEprBavo5OISEXFo3jQHKqLxs1PVgRqa+
   I=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="453215187"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:26:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:7114]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.186:2525] with esmtp (Farcaster)
 id fcb4c5c3-dce8-4acb-ba67-f87b613d3fff; Fri, 10 Jan 2025 09:26:56 +0000 (UTC)
X-Farcaster-Flow-ID: fcb4c5c3-dce8-4acb-ba67-f87b613d3fff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:26:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:26:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/12] af_unix: Set skb drop reason in every kfree_skb() path.
Date: Fri, 10 Jan 2025 18:26:29 +0900
Message-ID: <20250110092641.85905-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There is a potential user for skb drop reason for AF_UNIX.

This series sets skb drop reason for every kfree_skb() path
in AF_UNIX code.

Link: https://lore.kernel.org/netdev/CAAf2ycmZHti95WaBR3s+L5Epm1q7sXmvZ-EqCK=-oZj=45tOwQ@mail.gmail.com/


Kuniyuki Iwashima (12):
  net: dropreason: Gather SOCKET_ drop reasons.
  af_unix: Set drop reason in unix_release_sock().
  af_unix: Set drop reason in unix_sock_destructor().
  af_unix: Set drop reason in __unix_gc().
  af_unix: Set drop reason in unix_stream_connect().
  af_unix: Reuse out_pipe label in unix_stream_sendmsg().
  af_unix: Set drop reason in unix_stream_sendmsg().
  af_unix: Set drop reason in queue_oob().
  af_unix: Set drop reason in manage_oob().
  af_unix: Set drop reason in unix_stream_read_skb().
  af_unix: Set drop reason in unix_dgram_disconnected().
  af_unix: Set drop reason in unix_dgram_sendmsg().

 include/net/dropreason-core.h |  46 ++++++++--
 net/unix/af_unix.c            | 167 ++++++++++++++++++++++++----------
 net/unix/garbage.c            |   2 +-
 3 files changed, 159 insertions(+), 56 deletions(-)

-- 
2.39.5 (Apple Git-154)


