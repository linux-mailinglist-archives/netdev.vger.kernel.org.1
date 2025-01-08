Return-Path: <netdev+bounces-156184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C187A0560E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4393A39A4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6BE1A8403;
	Wed,  8 Jan 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c4+5riC7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679314B95A
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326985; cv=none; b=i+RuW9wgu1jfXOuKc0OeKUPTbQ4QgFEjO5guTn3Roy6vSoGAsxU+ow3zuAQng+od+YNJyJUFsiFJbGMr/V5hFeP9NpFGxiwq9Cg8xANf3Vfg+kCLX5E6pHOJXk3YlgyTopC+9ZXDg3I/N76BzkOyGLYH4/diOcOACcvQDxzXChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326985; c=relaxed/simple;
	bh=dLl4JPI23rMhXkalH0o6JmrkygfmL6w5D8QuVgOJMUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVPz1wpQF1xC3NGeEMxekEeXvY5ZMpTE4SDueshsK0MCHzzo8zvCUwHZLI7k5UJZy/c7hiOZBipuAwzUBUlu/yngvnvD24IumUvMK1bvl7ccqaX0BapQTUARPKtXXYkUmWsKXFBNObmspDdy9J9qwPc23e0fcphPx1Ha+mLZKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c4+5riC7; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736326984; x=1767862984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M02EvoHmnVvf42/yEIiliUcY4rV4Y+aV+5a6HpjDUnI=;
  b=c4+5riC7OCXXFTq+PV8EVOXIn8A2LbTl0EZz+t36bHojLecf/l/2FAg/
   umZENNNV6QYBPhQw06VMDTEdmuZRLI4DGyTIFd8oMYM86eVgHAJwqw1JU
   gc3OHp9DX/H3Nn3FsJQ4pCkHfMoFTqh7lAVO8XLUf04XCPgzkLXd4iVeL
   w=;
X-IronPort-AV: E=Sophos;i="6.12,297,1728950400"; 
   d="scan'208";a="159839371"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:03:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:53666]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.194:2525] with esmtp (Farcaster)
 id bc627e9c-1ac3-4db3-a876-91c6e35f110c; Wed, 8 Jan 2025 09:03:01 +0000 (UTC)
X-Farcaster-Flow-ID: bc627e9c-1ac3-4db3-a876-91c6e35f110c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 09:02:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 09:02:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <laforge@gnumonks.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <pablo@netfilter.org>
Subject: Re: [PATCH v1 net 2/3] gtp: Destroy device along with udp socket's netns dismantle.
Date: Wed, 8 Jan 2025 18:02:44 +0900
Message-ID: <20250108090244.28324-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CABAhCOR7Y058pDUKBOQ6vDeEZkHYQqeyg97nrBYoJHqkFgDd7w@mail.gmail.com>
References: <CABAhCOR7Y058pDUKBOQ6vDeEZkHYQqeyg97nrBYoJHqkFgDd7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 8 Jan 2025 16:55:16 +0800
> On Wed, Jan 8, 2025 at 2:29 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> [...]
> > @@ -2480,6 +2480,11 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
> >         list_for_each_entry(net, net_list, exit_list) {
> >                 struct gtp_net *gn = net_generic(net, gtp_net_id);
> >                 struct gtp_dev *gtp, *gtp_next;
> > +               struct net_device *dev;
> > +
> > +               for_each_netdev(net, dev)
> > +                       if (dev->rtnl_link_ops == &gtp_link_ops)
> > +                               gtp_dellink(dev, dev_to_kill);
> 
> I'm not sure, but do we usually have to clean up devices
> in the netns being deleted? Seems default_device_ops
> can handle it.

default_device_ops handles netns dismantle, but we still
need this because the module is unloadable.

I have a patch that moves default_device_ops stuff after
some ->exit_batch_rtnl() to save one RTNL dance, which will
make it clear when default_device_ops is executed.

