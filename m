Return-Path: <netdev+bounces-157487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD81A0A71B
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041FF3A897E
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B65101E6;
	Sun, 12 Jan 2025 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bzdnJvlt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7C1DDE9
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736654910; cv=none; b=NfsmYlNh8WiT3uX2bw6sElUQPMHrJcc7YtoHoYT8SL67BpdwP3EjMStSFNp9p740UcXcbhUn5/Uwy+tiWygoRj+Kvk4FICXdpk3oKiI6kZitU5LP63dOl3zJ9f7vuNfIJueykYVReHRKW7tuNjNmtdtAabzZISqX2uP47ZH38Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736654910; c=relaxed/simple;
	bh=iMkS7GPifTwlTURAsXA6MTjfpY+RZVZF5O0G3WtFUB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ipSpUCdalxfNe/OcOZ27/XHiBWvfLsUfXkbui87IwXCpvoblUXkpy11KK8scS2WWByTwZwtGpVMJYdWJ/ugRkeu3iQP0mWYqQgCOtKnSzH9Zq0p8vqTg6L5O+6E3k9Sutqdv/GWD/FBs4mmlljOriGvwK9Xa5SUm5+3EpOWojQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bzdnJvlt; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736654909; x=1768190909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LYzfJ541Tbwa7S8zFHXm1yZXxcJEmkZC+rEquHVsADw=;
  b=bzdnJvltaz7aogaGq2bI9xS1ID8os2FAGagBiN3XRu1ng/5t2Yyxckoj
   hMV7fOSRvdNG2fkUhKr8U/ilh2NOSCCXcUS+B2cdm0EEZJ6tJyYZDuckJ
   SqQpA1DuL6cCsozyRw3G8kTJ8XQ6VvioXRgKRTIqa8OkJFKPThWR+wlXy
   w=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="368424414"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:08:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:31629]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.186:2525] with esmtp (Farcaster)
 id ba75a695-e722-45a6-bfe4-445322f68189; Sun, 12 Jan 2025 04:08:24 +0000 (UTC)
X-Farcaster-Flow-ID: ba75a695-e722-45a6-bfe4-445322f68189
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:08:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:08:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/11] af_unix: Set skb drop reason in every kfree_skb() path.
Date: Sun, 12 Jan 2025 13:07:59 +0900
Message-ID: <20250112040810.14145-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There is a potential user for skb drop reason for AF_UNIX.

This series sets skb drop reason for every kfree_skb() path
in AF_UNIX code.

Link: https://lore.kernel.org/netdev/CAAf2ycmZHti95WaBR3s+L5Epm1q7sXmvZ-EqCK=-oZj=45tOwQ@mail.gmail.com/


Changes:
  v2:
    * Drop the old patch 6 to silence false-positive uninit warning

  v1: https://lore.kernel.org/netdev/20250110092641.85905-1-kuniyu@amazon.com/


Kuniyuki Iwashima (11):
  net: dropreason: Gather SOCKET_ drop reasons.
  af_unix: Set drop reason in unix_release_sock().
  af_unix: Set drop reason in unix_sock_destructor().
  af_unix: Set drop reason in __unix_gc().
  af_unix: Set drop reason in unix_stream_connect().
  af_unix: Set drop reason in unix_stream_sendmsg().
  af_unix: Set drop reason in queue_oob().
  af_unix: Set drop reason in manage_oob().
  af_unix: Set drop reason in unix_stream_read_skb().
  af_unix: Set drop reason in unix_dgram_disconnected().
  af_unix: Set drop reason in unix_dgram_sendmsg().

 include/net/dropreason-core.h |  46 ++++++++--
 net/unix/af_unix.c            | 153 +++++++++++++++++++++++++---------
 net/unix/garbage.c            |   2 +-
 3 files changed, 154 insertions(+), 47 deletions(-)

-- 
2.39.5 (Apple Git-154)


