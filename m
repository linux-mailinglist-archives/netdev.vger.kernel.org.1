Return-Path: <netdev+bounces-171419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2315A4CF38
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A963AA271
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E89222C325;
	Mon,  3 Mar 2025 23:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R8fp61Ns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C251EEA2A
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044532; cv=none; b=qaYp0rkacE263tWTq9KCEufQgrbp2ImaRVshBMde81y6fRbVCnJQ3RypnD4N3q19urBgF/XqEMPisY+wXX+0NolyDOi3KzrbBVNYMqpRkRsqj/OAg3yClF5DtC3odbd1dgbY8YiO8nd7EsCwpErrQUiDkxuA7BAuQ5TECpSkD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044532; c=relaxed/simple;
	bh=hVDmfKfQClx+eB65hgZHqCEyCLIAIkSEe8WJ5+C3W6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZV6gVmEb4Af4oDN/cvrjfUWfr9xPI+yolsSJ7S2IqpdCFHhRUQBOqkUC9n3XrXORR6KZysupghe1POwu2dXd14RE7FhhWft40lXyTz6ekOV5Q4mDeWwfmqTQYLFiDHRdXUENcJP0kpD7l2aSraApd90vQ+pYfS13U4D3CqFBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R8fp61Ns; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741044530; x=1772580530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jy43G7ebPhxfH+EnBJBIKDqQoPptFulKsIFmbcpL8vU=;
  b=R8fp61Ns1I0DMQoL0OTsOrVwOYPy9gl9zoUa7WSFQ4vaxiMfE7Z/vT7g
   aNCsnvnVw2JK8FTX6jtRcWfh9//YJzh+PDwmoFYwxLTiONjxkWHF0055d
   Rn7xcr4LQpuapsVrW0Ixx45NpZEH8scqdMkF7YkrzegfxSgyRLIERnkzz
   8=;
X-IronPort-AV: E=Sophos;i="6.13,330,1732579200"; 
   d="scan'208";a="701845426"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:28:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:61573]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.48:2525] with esmtp (Farcaster)
 id 4e54a82f-2b70-4bef-81b8-f1fa4099df4c; Mon, 3 Mar 2025 23:28:46 +0000 (UTC)
X-Farcaster-Flow-ID: 4e54a82f-2b70-4bef-81b8-f1fa4099df4c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:28:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:28:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <wanghai38@huawei.com>
Subject: Re: [PATCH v2 net-next 5/6] tcp: remove READ_ONCE(req->ts_recent)
Date: Mon, 3 Mar 2025 15:28:33 -0800
Message-ID: <20250303232833.54343-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250301201424.2046477-6-edumazet@google.com>
References: <20250301201424.2046477-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sat,  1 Mar 2025 20:14:23 +0000
> After commit 8d52da23b6c6 ("tcp: Defer ts_recent changes
> until req is owned"), req->ts_recent is not changed anymore.
> 
> It is set once in tcp_openreq_init(), bpf_sk_assign_tcp_reqsk()
> or cookie_tcp_reqsk_alloc() before the req can be seen by other
> cpus/threads.
> 
> This completes the revert of eba20811f326 ("tcp: annotate
> data-races around tcp_rsk(req)->ts_recent").
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

