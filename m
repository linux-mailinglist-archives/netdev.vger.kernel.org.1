Return-Path: <netdev+bounces-180409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2127A813B8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A53B4610B9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61723E25A;
	Tue,  8 Apr 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gogQkN54"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45123C8CF
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133585; cv=none; b=nhw/WdiR1Vt5DiaFYJnY0C4Lu/S0zou5hFnevmhiMyFv9Hz29AIP5rYbnFawGJYk7X4s94l/9A7N3cw9NleQO7/7jaeUCPmpYt2Ykezy88Vx144fDcrtnenEFl+y3Ly9V3qWHbS7wqsG+S2K5cEMywvIsfdb1BI4IBzvxpWIARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133585; c=relaxed/simple;
	bh=QUF6pxteZBFB9QVoVGyr00hJUIzPlGKpDScG483P/ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exwA9Laz91Sd8nRI8LTh9DUmi8EAwYiuKH64PswMrKrvQb+rBYGwpdj6jObQTjmGU/sTrK2KbAIPMeT1g4uP2gIRgKA/3nWB6wUnGQpMmR/pMiXoLat9PddgZixJQBIb4SgmtmJvrT8SLpoOLI7Znn7N7o8rLQovFFD6LOfhdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gogQkN54; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744133584; x=1775669584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7/jsW/uTOWM537jqlVPjiwP18j9rDKapLR48hsvKGG8=;
  b=gogQkN540ZAFHeINrsccqg4lfhbGiwLqGB6fBFRpqsOGiJXmhZZ2QwQQ
   S9iLK/Jtit/JUN8pLc0GKfqeLLKsV5OiypVzTznwI72ctLA3YUxJ5CQlb
   6XLlmkQ00x2E4AMccKD0aauaqfmszUgPJq81wTgiazIiflaX4ix91snD2
   g=;
X-IronPort-AV: E=Sophos;i="6.15,198,1739836800"; 
   d="scan'208";a="81902356"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 17:33:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:36807]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id f1726e36-8c61-4fca-b42e-59e5e02a6709; Tue, 8 Apr 2025 17:32:59 +0000 (UTC)
X-Farcaster-Flow-ID: f1726e36-8c61-4fca-b42e-59e5e02a6709
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 17:32:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 17:32:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pablo@netfilter.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <jmorris@namei.org>, <kadlec@netfilter.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<paul@paul-moore.com>, <serge@hallyn.com>, <willemb@google.com>
Subject: Re: [PATCH v1 net-next 2/4] net: Retire DCCP.
Date: Tue, 8 Apr 2025 10:31:20 -0700
Message-ID: <20250408173246.38170-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z_VQ0KlCRkqYWXa-@calendula>
References: <Z_VQ0KlCRkqYWXa-@calendula>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Tue, 8 Apr 2025 18:37:36 +0200
> Hi Kuniyuki,
> 
> On Mon, Apr 07, 2025 at 04:17:49PM -0700, Kuniyuki Iwashima wrote:
> > DCCP was orphaned in 2021 by commit 054c4610bd05 ("MAINTAINERS: dccp:
> > move Gerrit Renker to CREDITS"), which noted that the last maintainer
> > had been inactive for five years.
> > 
> > In recent years, it has become a playground for syzbot, and most changes
> > to DCCP have been odd bug fixes triggered by syzbot.  Apart from that,
> > the only changes have been driven by treewide or networking API updates
> > or adjustments related to TCP.
> > 
> > Thus, in 2023, we announced we would remove DCCP in 2025 via commit
> > b144fcaf46d4 ("dccp: Print deprecation notice.").
> > 
> > Since then, only one individual has contacted the netdev mailing list. [0]
> > 
> > There is ongoing research for Multipath DCCP.  The repository is hosted
> > on GitHub [1], and development is not taking place through the upstream
> > community.  While the repository is published under the GPLv2 license,
> > the scheduling part remains proprietary, with a LICENSE file [2] stating:
> > 
> >   "This is not Open Source software."
> >
> > The researcher mentioned a plan to address the licensing issue, upstream
> > the patches, and step up as a maintainer, but there has been no further
> > communication since then.
> > 
> > Maintaining DCCP for a decade without any real users has become a burden.
> >
> > Therefore, it's time to remove it.
> > 
> > Removing DCCP will also provide significant benefits to TCP.  It allows
> > us to freely reorganize the layout of struct inet_connection_sock, which
> > is currently shared with DCCP, and optimize it to reduce the number of
> > cachelines accessed in the TCP fast path.
> 
> Netfilter parses skbuffs, in that sense, it is a middlebox. Main
> concern on my side is that it could break rulesets, even for people
> that don't really see dccp traffic ever, ruleset could stop loading.
> 
> I would keep the netfilter bits aside by now, based on your netfilter
> updates, we can internally discuss how to phase out dccp support to
> get aligned with netdev maintainers, as it seems there is a wish to
> reduce debt in this front.

Fair enough.  I'll drop the netfilter stuff in v2.


> 
> Having said, this Netfilter does not rely on any of this socket
> structures, I think it should not be an impediment for your tree
> spring cleanup (IIRC we have no hard dependencies on CONFIG_DCCP).

Yes, actually I split changes for net/dccp, netfilter, and LSM
initially, and then, even without net/dccp, netfilter compiled
successfully if include/linux/dccp.h (dccp_hdr etc) was not removed.

Thanks!

---
pw-bot: cr

