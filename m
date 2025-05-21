Return-Path: <netdev+bounces-192420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C53BABFD06
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA34A76DF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A04228A1D8;
	Wed, 21 May 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tE2Ewykv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93822B8AD;
	Wed, 21 May 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853446; cv=none; b=U1wnAUXoMhhh+zRDazoDovY2//hcPcLFlgQsDem6z9h7c9QEdOGM2eprF3tKRj+XJgehwaDyCXNC4jTHYsFfEImFNFk62XugeHNNbfxfrswCSRMLlwhZdrWx7cON5wGjNIOIr99+QdPCK1O3JfvP7dsLXFW6V6EU0E/oDvKZEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853446; c=relaxed/simple;
	bh=9XMv9SxJ06o/qz7m+z95pFFzS62JgbbA+p4iLf4Anko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIACRcoUI1GQESR43H+0OQ9+AAZwL5cOG+piDj8glMU1XY1mPs0W2qQLwJNJiSfDdKQTezgH6bEPEP9AMO/s6eLI0AxeX5LNBnlOgmuYjr9YmxQ06MgwVNeOKEbCzcLf+fKJTqXvn0vgKhKLPF3XuoEMX9RPkmUHMHXVApE1rVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tE2Ewykv; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747853445; x=1779389445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sBKVsfi1NKHVCtjpithQ8ltEShaCCBzCJAIuJ+fqkHM=;
  b=tE2EwykvBXUXgQ4OFjMBO/FMaFxoTRCI1AyfH6LXi8073tY8Gu5iUaVW
   DlsvFf+mgFkih6s00Wui3vmGtvqpAKFu6i5sVUJmR4NLpQSdhsFLwe3j2
   BXZm2dZdYZKPV9O3ISWn8s5BJVAIiDCiGHP8H5wfOvMkv6Pcd3FDwkuRJ
   zvW925/rSzJt8fJmgsxMCEWgTIYJhZmy9RlFolQtCLHsraIr/LIhN2P0x
   T3dqfLV9l6Ha2N8hu0cKqflKx7v31L61tGBo+ib7nqSHsVFRMdbNWSbfV
   qS0Z26hugSBV2WqwX8n40pUb5MAV95Tz5H7c2Un2NvbdFgsSpSVPOWRaN
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,304,1739836800"; 
   d="scan'208";a="747108293"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 18:50:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:23358]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.117:2525] with esmtp (Farcaster)
 id fb42e788-7b2c-41af-9a95-325593b16934; Wed, 21 May 2025 18:50:37 +0000 (UTC)
X-Farcaster-Flow-ID: fb42e788-7b2c-41af-9a95-325593b16934
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 18:50:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.52.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 18:50:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <john.cs.hey@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [Bug] "WARNING in should_fail_ex" in Linux kernel v6.14
Date: Wed, 21 May 2025 11:50:22 -0700
Message-ID: <20250521185026.56042-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAP=Rh=N4QcPLWQ2dqUHmKYeEhig3Cbi-3N8Q4-7qGT00htXrVw@mail.gmail.com>
References: <CAP=Rh=N4QcPLWQ2dqUHmKYeEhig3Cbi-3N8Q4-7qGT00htXrVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: John <john.cs.hey@gmail.com>
Date: Wed, 21 May 2025 22:13:15 +0800
> Dear Linux Kernel Maintainers,
> 
> I hope this message finds you well.
> 
> I am writing to report a potential vulnerability I encountered during
> testing of the Linux Kernel version v6.14.
> 
> Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)
> 
> Bug Location: net/ipv4/ipmr.c:440 ipmr_free_table net/ipv4/ipmr.c:440
> 
> Bug report: https://pastebin.com/xkfF5DBt
> 
> Complete log: https://pastebin.com/uCfqY4D8
> 
> Entire kernel config: https://pastebin.com/MRWGr3nv
> 
> Root Cause Analysis:
> The kernel warning is triggered in ipmr_free_table() at
> net/ipv4/ipmr.c:440, where the multicast routing table (mr_table) is
> being freed during network namespace exit (ipmr_rules_exit).
> The warning indicates that the multicast forwarding cache count
> (mfc_cache_cnt) is non-zero, implying that resources were not
> correctly cleaned up prior to netns teardown.
> This suggests a possible bug in reference counting or teardown logic
> of the IPv4 multicast routing infrastructure.
> Additionally, the environment is running with fail_usercopy fault
> injection enabled, which deliberately triggers copy-from-user failures
> to test kernel error paths.
> While these failures are expected, they may interact with multicast
> socket setup/teardown paths, exacerbating latent issues.

I think this was fixed by

commit c46286fdd6aa1d0e33c245bcffe9ff2428a777bd
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Thu May 15 18:49:26 2025 +0200

    mr: consolidate the ipmr_can_free_table() checks.

