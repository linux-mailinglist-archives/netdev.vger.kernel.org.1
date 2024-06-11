Return-Path: <netdev+bounces-102410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC929902DBC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE63E1C212E2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4B3D69;
	Tue, 11 Jun 2024 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hZXX2Eey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C761C06
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718066869; cv=none; b=JrValzatPOgyILKkWPxCrlddxlec8S/Tb51xUbsnCtJ5PKqw5ODJqxfHdTOqJaWmfcS3AfBAiodL5TKzvLXGWIz7xVQautzHYB++jxn3YDJRxzCbbGZTrqKcVdNL+Z060WIJ0ikTs2YwyzMIHiYo7B7nZAfxtnYi/4Kz48AwNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718066869; c=relaxed/simple;
	bh=ZmS9j6Nm2lyHu0gu8ZNHt9YS8t4gLY5t+kk4xlFNYvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJJCcfjhjOH+YkQjKZZPWi/3gSp96YhgdI+PwsdgNwca+MrnvpXlxMrvl2Rg9wNzg4oEfGhysnqCtNMRaUgH4337dAoxc9MD3ZTbU4C5InnCK9JTbg0sb8K3XoxQD4Y2paz7TV5czpTxP/yu6tAxR8rS1KY0AscMmwDb8kMoWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hZXX2Eey; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718066868; x=1749602868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S62+WCxcqPmJrmZefmiOvVIEx7Ly0yEXHkzywaCQLsE=;
  b=hZXX2EeymcLYpBrn2TbGhNnb7YQdczEPYAkUSwin6ouy5b0MgUPspe4S
   f9LpmkUq17jR/4ZamR39erD6jIS9DlRRZZPu0OFr9guyDP/Pk+ShR25rV
   qrFzVBjB0SnwA4xs3fFiERHKHAc5o4tuaWawOzhvKNAy0gmF5Z2qFEcxA
   E=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="425342893"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 00:47:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:4585]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.23:2525] with esmtp (Farcaster)
 id 1cc2602b-b9dc-4fce-9512-33e54be01f7e; Tue, 11 Jun 2024 00:47:40 +0000 (UTC)
X-Farcaster-Flow-ID: 1cc2602b-b9dc-4fce-9512-33e54be01f7e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 00:47:33 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 00:47:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kent.overstreet@linux.dev>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 01/11] af_unix: Define locking order for unix_table_double_lock().
Date: Mon, 10 Jun 2024 17:47:23 -0700
Message-ID: <20240611004723.86031-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <thzkgbuwuo3knevpipu4rzsh5qgmwhklihypdgziiruabvh46f@uwdkpcfxgloo>
References: <thzkgbuwuo3knevpipu4rzsh5qgmwhklihypdgziiruabvh46f@uwdkpcfxgloo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Mon, 10 Jun 2024 20:30:58 -0400
> On Mon, Jun 10, 2024 at 04:58:36PM -0700, Kuniyuki Iwashima wrote:
> > > No, we're defining an ordering, there's no need for an enum - this
> > > should work exactly the same as a comparison function that you pass to
> > > sort().
> > > 
> > > Comparison functions are no place to get fancy, they should be as
> > > standard as possible: you can get _crazy_ bugs resulting from buggy
> > > comparison functions that don't actually define a total ordering.
> > 
> > What should it return if we cannot define the total ordering like
> > when we only define the allowed list of ordering ?
> > 
> > See patch 8, the rule there is
> > 
> >   if the nested order is listening socket -> child socket, then ok,
> >   and otherwise, not.
> > 
> > So we don't know the clear ordering, equal or greater, but we know
> > it's actually illegal.
> > 
> > https://lore.kernel.org/netdev/20240610223501.73191-9-kuniyu@amazon.com/
> 
> Ok yeah, that's a tricky one, and it does come up elsewhere.

Actually patch 3 & 4 is another example where we cannot define
the ordering, and only one necessary rule out of three is defined.


> I think we
> can allow comparison functions to return "undefined", and define 0 ==
> undefined for lockdep.

I agree.


> 
> The important thing I want to maintain is that comparison functions be
> symmetric.

Ok, I'll use ((a > b) - (b < a)) for patch 1 & 2 where the odering
can be well defined as numeric ascending order.

Thanks!

