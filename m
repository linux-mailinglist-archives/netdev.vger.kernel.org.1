Return-Path: <netdev+bounces-117810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BD894F6C2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530D71C21078
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFEF18A6DA;
	Mon, 12 Aug 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UVgKhE5Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444902B9B7
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487741; cv=none; b=P+O6YfjGh/LZDqzj89xSjoKx5vT0yPfl0LX/sso0ySXvkIBX0xM7prnoKQEtSP+N/HOBDl9ied5PtFfjaD0lQLy2lWLvhH/7I9nZGeA/MS/abl6rb3XyvtFswjT0cRyRftkPBNIhVF2lK6a3Q9dyqmtuj/uivCDb2clI8eNQITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487741; c=relaxed/simple;
	bh=EZHOZeq7aRbERcraRMbfK5qLzPvmPGVphL5FlfBZe6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O87JP6MTLDj/+t5GAEclk126J+f7+DzXt4bybu9lHoChO3DDTnNvfDiNtm281i+L4Yl2cjTwp10C++trImvsiTEWhgCod7hrWO1OfIQfEcq444Pr2D51+0g0XXNyZtbcBT7JtKXFXq7KVqiION+kDuxLyZmAGy3j7xJPPLB/43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UVgKhE5Z; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723487740; x=1755023740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6My18yAKs6dv3mZs1AxuvAKMoBg2Tr7mDqjabktt/Rg=;
  b=UVgKhE5ZtZrtmhk5Dvg8HwYVki7dV/Ky6BDrIUaPEEZy/DAjOUnIz2uS
   5Hp2kpisCF0QdCSoYMSaLKMK14fBUnVqIVLzSKLbE77cH5J+toq2+j3H9
   uqsr9+7G37WRFoUq5VhY1k64ObW0/vk12L7vqmM0mD3bvYY4AYRZAidAV
   0=;
X-IronPort-AV: E=Sophos;i="6.09,283,1716249600"; 
   d="scan'208";a="361878720"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:35:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:10596]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.23:2525] with esmtp (Farcaster)
 id 2a6d73e2-09df-473a-8f88-ad468be74a01; Mon, 12 Aug 2024 18:35:30 +0000 (UTC)
X-Farcaster-Flow-ID: 2a6d73e2-09df-473a-8f88-ad468be74a01
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 18:35:30 +0000
Received: from 88665a182662.ant.amazon.com (10.142.139.164) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 18:35:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <vineeth.karumanchi@amd.com>
CC: <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <nicolas.ferre@microchip.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] net: macb: Use rcu_dereference() for idev->ifa_list in macb_suspend().
Date: Mon, 12 Aug 2024 11:35:19 -0700
Message-ID: <20240812183519.57314-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <733568cc-0a7d-4fc5-a251-2032fb484a4d@amd.com>
References: <733568cc-0a7d-4fc5-a251-2032fb484a4d@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Date: Mon, 12 Aug 2024 14:41:40 +0530
> On 08/08/24 10:15 am, Kuniyuki Iwashima wrote:
> > From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> > Date: Thu, 8 Aug 2024 09:53:42 +0530
> >> Hi Kuniyuki,
> >>
> >> On 08/08/24 9:30 am, Kuniyuki Iwashima wrote:
> >>> In macb_suspend(), idev->ifa_list is fetched with rcu_access_pointer()
> >>> and later the pointer is dereferenced as ifa->ifa_local.
> >>>
> >>> So, idev->ifa_list must be fetched with rcu_dereference().
> >>>
> >>
> >> Is there any functional breakage ?
> > 
> > rcu_dereference() triggers lockdep splat if not called under
> > rcu_read_lock().
> > 
> > Also in include/linux/rcupdate.h:
> > 
> > /**
> >   * rcu_access_pointer() - fetch RCU pointer with no dereferencing
> > ...
> >   * It is usually best to test the rcu_access_pointer() return value
> >   * directly in order to avoid accidental dereferences being introduced
> >   * by later inattentive changes.  In other words, assigning the
> >   * rcu_access_pointer() return value to a local variable results in an
> >   * accident waiting to happen.
> > 
> > 
> >> I sent initial patch with rcu_dereference, but there is a review comment:
> >>
> >> https://lore.kernel.org/netdev/a02fac3b21a97dc766d65c4ed2d080f1ed87e87e.camel@redhat.com/
> > 
> > I guess the following ifa_local was missed then ?
> 
> I am ok to use rcu_dereference(), just curios why the check 
> idev->ifa_list was removed ?

"if (idev->ifa_list)" could fetch an invalid pointer due to lack of
READ_ONCE(), it's not a big problem, but neither we should write it as

  if (rcu_assign_pointer(idev->ifa_list))
    ifa = rcu_dereference(idev->ifa_list)

because rcu_dereference()ed ifa is not guaranteed as the same value
(non-NULL) with rcu_assign_pointer(), so we need the following check
anyway:

  if (!ifa)

Basically, we can't use rcu_assign_pointer() with rcu_dereference().

list_first_or_null_rcu() is a nice example:

  include/linux/rculist.h
  /*
   * Where are list_empty_rcu() and list_first_entry_rcu()?
   *
   * They do not exist because they would lead to subtle race conditions:
   *
   * if (!list_empty_rcu(mylist)) {
   *	struct foo *bar = list_first_entry_rcu(mylist, struct foo, list_member);
   *	do_something(bar);
   * }
   *
   * The list might be non-empty when list_empty_rcu() checks it, but it
   * might have become empty by the time that list_first_entry_rcu() rereads
   * the ->next pointer, which would result in a SEGV.

