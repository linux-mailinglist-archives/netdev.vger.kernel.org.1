Return-Path: <netdev+bounces-178059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C54A743AC
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 07:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185743AFD22
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 06:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD213777E;
	Fri, 28 Mar 2025 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iiVMCMmN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3879CF
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141915; cv=none; b=F2r7EJKl5AN90r7gybfoXnMvHUZtd0Sq+wNueMeULcRYqZZ4Gpjz4yeTTTdhVdxnuMouvzHIBl5dXR2B4MEaV05A0NZOnk7VMUBg3T8lJ+Wlm+klArRNGlKpV8p/tWJED5fSFIQr7YK4Osxeq780VFghUyDgY4DFeHn8P8qLGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141915; c=relaxed/simple;
	bh=DLhsl4POXLDcl/MZ0DH3IFV6R+NGqJ8/5yr/3al6r7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMsMOUGg2LFcBjew3zcjuUaiEpRhakY72U4/AQL2JEwKsZaOqdUGAaWA+pbemEYC15pIYaW5l7zKyfQ2iCnwnssmTDyozF0iMlk4LpLO/GAGHY9zXD8kDx+1gx7KIT6bjuU6ZOOyBWDiVmMGCBmdk9jK+BtC4WaeM21Dm6+pgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iiVMCMmN; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743141914; x=1774677914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDZUlT84AUpGN+OgZgRiY4DdHIr700V82xyVHuTKAkk=;
  b=iiVMCMmNzRe5rFFMea/mEJaqnqqCrjb8Bf7VzOJMg18HgX0glsD57tru
   MffaVgWwFjsMCBm+Wo6C0ecOtkk71llXvfvINoivEPKiIqrDEHruzrLMj
   w0uGskC5XcxYdJR+sRlf/kQPl/ZUOFuok5ibZnoM8JBe8slTxnP2NR4Ir
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,282,1736812800"; 
   d="scan'208";a="730657583"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 06:05:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:27362]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.254:2525] with esmtp (Farcaster)
 id d1a2da67-fe78-402f-82c7-ec81fb2bb085; Fri, 28 Mar 2025 06:05:09 +0000 (UTC)
X-Farcaster-Flow-ID: d1a2da67-fe78-402f-82c7-ec81fb2bb085
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 06:05:00 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 06:04:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <stfomichev@gmail.com>
Subject: Re: [PATCH net v2 06/11] netdevsim: add dummy device notifiers
Date: Thu, 27 Mar 2025 23:03:28 -0700
Message-ID: <20250328060450.45064-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327144609.647403fa@kernel.org>
References: <20250327144609.647403fa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 27 Mar 2025 14:46:09 -0700
> On Thu, 27 Mar 2025 14:04:06 -0700 Stanislav Fomichev wrote:
> > > Can we register empty notifiers in nsim (just to make sure it has 
> > > a callback) but do the validation in rtnl_net_debug.c
> > > I guess we'd need to transform rtnl_net_debug.c a little,
> > > make it less rtnl specific, compile under DEBUG_NET and ifdef
> > > out the small rtnl parts?  
> > 
> > s/rtnl_net_debug.c/notifiers_debug.c/ + DEBUG_NET? Or I can keep the
> > name and only do the DEBUG_NET part. 
> 
> I was thinking lock or locking as in net/core/lock_debug.c

Maybe lock.c (or netdev_lock.c like netdev_lock.h) and move all
locking stuff (netdev_lock_type[], netdev_lock_pos(), etc) there
later + ifdef where necessary ?



> But yeah, it's locking in notifier locking, maybe
> net/core/notifier_lock_debug.c then? No strong feelings.
> 
> > Not sure what needs to be ifdef-ed out,
> > but will take a look (probably just enough to make it compile with
> > !CONFIG_DEBUG_NET_SMALL_RTNL ?).
> 
> You're right, looking at the code we need all of it.
> Somehow I thought its doing extra netns related stuff but it just
> register a notifier in each ns. 
> I guess we may not need any ifdef at all.
> 
> > That should work for the regular notifiers,
> > but I think register_netdevice_notifier_dev_net needs a netdev?
> 
> Hm. Yes. Not sure if we need anything extra in the notifier for nsim 
> or we just want to make make sure it registers one. If the latter
> I guess we could export rtnl_net_debug_event (modulo rename) and
> call it from netdevsim? I mean - we would probably have the same
> exact asserts in both?
> 

