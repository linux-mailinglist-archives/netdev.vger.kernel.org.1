Return-Path: <netdev+bounces-101596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D68FF899
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45616B2132C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42730802;
	Fri,  7 Jun 2024 00:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lKTodlwc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C83EC2
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717719513; cv=none; b=gWKJ24Jt1ihk9aLjA8WL4esRYk/iatMqh7E/pFZW0x80PXRXJEbb5GXD5dcutvSZ+8rFQfegQKCXY1VsPJn50z0lo6i3nfOfKg3yEkYYnvad/lEd9UmMnS2velhl44MQ7C4Y6ML5t+P3b2mEBF9KX+pqN/f540qDk9hiNq2oirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717719513; c=relaxed/simple;
	bh=P3tNmYZKCay5MgeTRCqP7XWrKhh4366MJ7lmJ+p7REA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOAuZ28IhRXMcyFpV7tdpccL+YEf4yMPF0FGlg/dIFvoIcqwgoCNScsi3xbpz42cRRZmijxMIAAS3kMuKl9FzntCEJA9QQa1Jpvja3RE2Dj+I/EnXX6iFy0mDNSF2RX5kMVQMUWC4/KwWg3SWZsPjFRwmsrSHxkrDmkc10f21d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lKTodlwc; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717719511; x=1749255511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=123Uhej2ONTf62tgYIbN+8HWC4Neb9TRa0YlYT1wa90=;
  b=lKTodlwcO1D/KKjpbKVA2neTCIZua6+D5jFlVpFkB4Rdz2zrvNslCzwg
   GLip/dkoiII5mLpz1JIDT/nrIW1f4A6C3xpDRsZRZ18KwoG3dmr5xnxGl
   6iivKo2O71oYTdfWj/dnQu8iJZOlEhNSLHAzGegna+0hfYTOugG+VkSYK
   U=;
X-IronPort-AV: E=Sophos;i="6.08,219,1712620800"; 
   d="scan'208";a="94986303"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 00:18:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:52111]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.111:2525] with esmtp (Farcaster)
 id 80288a91-d58a-4e07-8b61-a586f91a3000; Fri, 7 Jun 2024 00:18:29 +0000 (UTC)
X-Farcaster-Flow-ID: 80288a91-d58a-4e07-8b61-a586f91a3000
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 7 Jun 2024 00:18:29 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 7 Jun 2024 00:18:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@gmail.com>, <edumazet@google.com>,
	<jiri@resnulli.us>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] rtnetlink: move rtnl_lock handling out of af_netlink
Date: Thu, 6 Jun 2024 17:18:15 -0700
Message-ID: <20240607001815.42475-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240606170453.53f20d5b@kernel.org>
References: <20240606170453.53f20d5b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 6 Jun 2024 17:04:53 -0700
> On Thu, 6 Jun 2024 16:33:03 -0700 Kuniyuki Iwashima wrote:
> > > +	if (needs_lock)
> > > +		rtnl_lock();
> > >  	err = dumpit(skb, cb);
> > > +	if (needs_lock)
> > > +		rtnl_unlock();  
> > 
> > This calls netdev_run_todo() now, is this change intended ?
> 
> Nice catch / careful thinking, indeed we're moving from pure unlock to
> run_todo. I don't really recall if I thought of this when writing the
> change (it was few days back). My guess is that the fact we weren't
> calling full rtnl_unlock() was unintentional / out of laziness in the
> first place. It didn't matter since dumps are unlikely to changes /
> unregister / free things.

This makes sense.  Probably due to cb_mutex interface constraint.


> But still, someone may get caught off guard
> as some point that we're holding rtnl but won't go via the usual unlock
> path.
> 
> Would you like me to add a note to the commit message?

That would be nice, but I'm fine with this version :)

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

