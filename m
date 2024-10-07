Return-Path: <netdev+bounces-132827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A449935F5
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A461C23AF4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F081DDA3B;
	Mon,  7 Oct 2024 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G9+7Avi4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1E1C1AAA
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325281; cv=none; b=ajmIoMX5GLeOPMpqakv+DhfvVBIWehh2UFj21W+ydiSObpfCcw/8+AVpF4Kw6UbIHFq2NL02oEzwY806VFD5J/IAPhfUk4OlxDHFqOqkuoCdcjbzjc8s84IiHnPnaxjjdP5poxqaMuFFfCR5MdAARIcSBi8r1hV6o3myzT+sgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325281; c=relaxed/simple;
	bh=cpZ3XRckrU+anguGWLTgPi/5dPEjx8t1cO0+MHH/dvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR+YQHSaG29qla5nTv27KVy7VfI9TG1OZ9yXsctVnOPvY6Q5j1rPn5LYZALHhM89mfzfVh5Lo1hji1GaNr4zxkJ2ZMJlLwM0f499gAU4jbOx/C7kGFJNmQ/bUNedqxcu0dMorR01Tebykko0dQAl4AJ08KzquWlzGmDkn0KFbSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=G9+7Avi4; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728325280; x=1759861280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKVeoNozTwFfQ2z8vUDqYP9Owol1PXZW/28HKPeIQC0=;
  b=G9+7Avi4UGpzE/zk4ioL7n7Om1zB+MZ1yShP/B8VIR0gLRLnguAApZzf
   Y3IDUUmPVU6rHFFflDk9GiKN2uJ179yitZCo8zgA7rm25B/OqOpj25Jeb
   sKLox6fDPgvNz4wpx5OI1MOVlW0uNRs9tehOUPkQr4IQAsPFKKNHEdRKm
   w=;
X-IronPort-AV: E=Sophos;i="6.11,184,1725321600"; 
   d="scan'208";a="340807360"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 18:21:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:17681]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.239:2525] with esmtp (Farcaster)
 id 3f875c24-66a8-4d9a-bef3-c0e6496fc30a; Mon, 7 Oct 2024 18:21:17 +0000 (UTC)
X-Farcaster-Flow-ID: 3f875c24-66a8-4d9a-bef3-c0e6496fc30a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 18:21:17 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 18:21:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ebiederm@xmission.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v3 net 5/6] mpls: Handle error of rtnl_register_module().
Date: Mon, 7 Oct 2024 11:21:06 -0700
Message-ID: <20241007182106.39342-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87v7y3g9no.fsf@email.froward.int.ebiederm.org>
References: <87v7y3g9no.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 07 Oct 2024 11:28:11 -0500
> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
> 
> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> > Date: Mon, 07 Oct 2024 09:56:44 -0500
> >> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
> >> 
> >> > Since introduced, mpls_init() has been ignoring the returned
> >> > value of rtnl_register_module(), which could fail.
> >> 
> >> As I recall that was deliberate.  The module continues to work if the
> >> rtnetlink handlers don't operate, just some functionality is lost.
> >
> > It's ok if it wasn't a module.  rtnl_register() logs an error message
> > in syslog, but rtnl_register_module() doesn't.  That's why this series
> > only changes some rtnl_register_module() calls.
> 
> You talk about the series.  Is there an introductory letter I should
> lookup on netdev that explains things in more detail?
> 
> I have only seen the patch that is sent directly to me.

Some context here.
https://lore.kernel.org/netdev/20241007124459.5727-1-kuniyu@amazon.com/

Before addf9b90de22, rtnl_register_module() didn't actually need
error handling for some callers, but even after the commit, some
modules copy-and-pasted the wrong code.


> 
> >> I don't strongly care either way, but I want to point out that bailing
> >> out due to a memory allocation failure actually makes the module
> >> initialization more brittle.
> >> 
> >> > Let's handle the errors by rtnl_register_many().
> >> 
> >> Can you describe what the benefit is from completely giving up in the
> >> face of a memory allocation failure versus having as much of the module
> >> function as possible?
> >
> > What if the memory pressure happend to be relaxed soon after the module
> > was loaded incompletely ?
> 
> Huh?  The module will load completely.  It will just won't have full
> functionality.  The rtnetlink functionality simply won't work.
> 
> > Silent failure is much worse to me.
> 
> My point is from the point of view of the MPLS functionality it isn't
> a __failure__.

My point is it _is_ failure for those who use MPLS rtnetlink
functionality, it's uAPI.  Not everyone uses the plain MPLS
without rtnetlink.

Also, I don't want to waste resource due to such an issue on QEMU w/ 2GB
RAM where I'm running syzkaller and often see OOM.  syzkaller searches
and loads modules and exercises various uAPIs randomly, and it handles
module-load-failure properly.


> 
> > rtnl_get_link() will return NULL and users will see -EOPNOTSUPP even
> > though the module was loaded "successfully".
> 
> Yes.  EOPNOTSUPP makes it clear that the rtnetlink functionality
> working.  In most cases modules are autoloaded these days, so the end
> user experience is likely to be EOPNOTSUPP in either case.
> 
> If you log a message, some time later someone will see that there is
> a message in the log that the kernel was very low on memory and could
> could not allocate enough memory for rtnetlink.
> 
> Short of rebooting or retrying to load the module I don't expect
> there is much someone can do in either case.  So this does not look
> to me like a case of silent failure or a broken module.
> 
> Has anyone actually had this happen and reported this as a problem?
> Otherwise we are all just arguing theoretical possibilities.
> 
> My only real point is that change is *not* a *fix*.
> This change is a *cleanup* to make mpls like other modules.
> 
> I am fine with a cleanup, but I really don't think we should describe
> this as something it is not.
> 
> The flip side is I tried very hard to minimize the amount of code in
> af_mpls, to make maintenance simpler, and to reduce the chance of bugs.
> You are busy introducing what appears to me to be an untested error
> handling path which may result in something worse that not logging a
> message.  Especially when someone comes along and makes another change.
> 
> It is all such a corner case and I really don't care, but I just don't
> want this to be seen as a change that is obviously the right way to go
> and that has no downside.

I don't see how this small change has downside that affects maintenability.
Someone who wants to add a new code there can just add a new function call
and goto label, that's simple enough.

