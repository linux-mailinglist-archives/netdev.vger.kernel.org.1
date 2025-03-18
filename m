Return-Path: <netdev+bounces-175582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB7A667B9
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 04:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B6E1896A04
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 03:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56FC14AD0D;
	Tue, 18 Mar 2025 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bo8Yc+u2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388782114
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269798; cv=none; b=hPRc+3GO9Wto6kGOPnY0Ig1iKGJyeswiD3jj8Zgr/JWjoyxMeEvqjJHNYOnBNx2Q62JpiWlh6azrIYvSPc56b0xGDOaKnbZ69zQzP8xBHlzSN0JN9Is1lFvLKQd0hstm5KJOgfMg+s4Hyl1EbehUxFTYXi1XUkx8p5IduTmxxvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269798; c=relaxed/simple;
	bh=bA9tFTLBW1YxgSCddveP8wHju0eSMbfQLgsaia6Sv1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMblLq/WqD35er+tjoHAY3d6lh50GA+ZKN10jAUTBpqnzC/cL0oNaGc2Y3hkM9juIwGitgKtJWlIJeyWvLZRvq9A1zoFrcahrlnBCzhonX1G/FqdvgjjDhhCUGpWqTxkcXXBBNnnMapk4iuWTZoLoLsO4VLsmdzlfVmYXG17mfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bo8Yc+u2; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742269797; x=1773805797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W3eckZ/3UtlB2aKtecZQF3PnHnktcm3rs1Ua5CDQCKU=;
  b=Bo8Yc+u2m+uHB20zH2zftjWrkY049Pg7MPp3JGCo3d+0efDN8tEPuGG/
   DUGwIPLowG7mzf+7rp5aZvWTZPYi4cZLnXbRKJrjAvzv+w7f8YoE/GwZo
   v/V8mS34w3X/FJCwXEWOUc6E/JyKRiFNNigLkms+DvpAj8LTSNBSOqfpl
   o=;
X-IronPort-AV: E=Sophos;i="6.14,255,1736812800"; 
   d="scan'208";a="503629613"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 03:49:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:21819]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.101:2525] with esmtp (Farcaster)
 id c3aa9fc9-7e2a-4da4-9bd0-da9ed6ca89c4; Tue, 18 Mar 2025 03:49:49 +0000 (UTC)
X-Farcaster-Flow-ID: c3aa9fc9-7e2a-4da4-9bd0-da9ed6ca89c4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:49:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:49:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/4] af_unix: Clean up headers.
Date: Mon, 17 Mar 2025 20:48:47 -0700
Message-ID: <20250318034934.86708-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

AF_UNIX files include many unnecessary headers (netdevice.h and
rtnetlink.h, etc), and this series cleans them up.

Note that there are still some headers included indirectly and
modifying them triggers rebuild, which seems mostly inevitable. [0]

  $ python3 include_graph.py net/unix/garbage.c linux/rtnetlink.h linux/netdevice.h
  ...
  include/net/af_unix.h
  | include/linux/net.h
  | | include/linux/once.h
  | | include/linux/sockptr.h
  | | include/uapi/linux/net.h
  | include/net/sock.h
  | | include/linux/netdevice.h   <---
  ...
  | | include/net/dst.h
  | | | include/linux/rtnetlink.h <---

[0]: https://gist.github.com/q2ven/9c5897f11a493145829029c0bfb364d0


Kuniyuki Iwashima (4):
  af_unix: Sort headers.
  af_unix: Move internal definitions to net/unix/.
  af_unix: Explicitly include headers for non-pointer struct fields.
  af_unix: Clean up #include under net/unix/.

 include/net/af_unix.h      | 84 ++++----------------------------------
 net/unix/af_unix.c         | 55 +++++++++++--------------
 net/unix/af_unix.h         | 75 ++++++++++++++++++++++++++++++++++
 net/unix/diag.c            | 18 ++++----
 net/unix/garbage.c         | 33 +++++++++------
 net/unix/sysctl_net_unix.c |  6 ++-
 net/unix/unix_bpf.c        |  5 ++-
 7 files changed, 143 insertions(+), 133 deletions(-)
 create mode 100644 net/unix/af_unix.h

-- 
2.48.1


