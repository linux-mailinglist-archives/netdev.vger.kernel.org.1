Return-Path: <netdev+bounces-132907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63291993B68
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEAB280FEF
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FAD18C90A;
	Mon,  7 Oct 2024 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dB+DjAp5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB114317E
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344946; cv=none; b=Vz4T6jqI786paWq/Wc4XRvIkfbCShoDmMAafh7dw14MVX1eTAPpDNTDlcUSA9OyCPsufcFzeQoKngICukXS4VDN6qhVlyfUq27mHX8Zk9QE70UV2CUqQxkze2AUojs9p4KfT3NAzf1DAGZHJic6MuA6jTZY4KxDKEbtE01cilAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344946; c=relaxed/simple;
	bh=jMQqNRhKnJFsckt+FlJ04wPIdgyAWkYfN7kfP7KMlhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9BwLyO2RRSYBcynifiqw/XAge0r3Yzb85JGNs7qDvqcQnnBqrhcb3DUJQ7swC4yVv37VL/kui34yFXaIxXbZuomE8j5jE6KrykWWMS1XMk3hR0W6tFjWFIjzFrmNYlk8JmY7vU5E5TIx0Mgmf9do4TTS+ohbWbMlriyIXcb7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dB+DjAp5; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728344945; x=1759880945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LDDWULOBSneG82df2SqLvnWZcFDZ319BPzmhZdC0mRY=;
  b=dB+DjAp5eCbO8NUuLpnYYIyXlJf02Hk+lJa2KQ9NhvMqvniTRIlVj2pl
   uUO7Jk7NNG9MmQWWD+kknh2YhMiS21ojpkoah4UpIFBcsZuehm41k/USF
   SvoItvnIUHWijWpxdKWipjXCYswRoXF/AhFMl+xk/46kKN8palJqTMANZ
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,185,1725321600"; 
   d="scan'208";a="433286089"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 23:49:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:24672]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id 0903e07d-b0df-4c31-99dd-31c7fca75d87; Mon, 7 Oct 2024 23:49:01 +0000 (UTC)
X-Farcaster-Flow-ID: 0903e07d-b0df-4c31-99dd-31c7fca75d87
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 23:49:00 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 23:48:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ebiederm@xmission.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v3 net 5/6] mpls: Handle error of rtnl_register_module().
Date: Mon, 7 Oct 2024 16:48:50 -0700
Message-ID: <20241007234850.83600-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8734l7d0a4.fsf@email.froward.int.ebiederm.org>
References: <8734l7d0a4.fsf@email.froward.int.ebiederm.org>
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
Date: Mon, 07 Oct 2024 17:18:59 -0500
> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
> 
> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> > Date: Mon, 07 Oct 2024 11:28:11 -0500
> >> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
> >> 
> >> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> >> > Date: Mon, 07 Oct 2024 09:56:44 -0500
> >> >> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
> >> >> 
> >> >> > Since introduced, mpls_init() has been ignoring the returned
> >> >> > value of rtnl_register_module(), which could fail.
> >> >> 
> >> >> As I recall that was deliberate.  The module continues to work if the
> >> >> rtnetlink handlers don't operate, just some functionality is lost.
> >> >
> >> > It's ok if it wasn't a module.  rtnl_register() logs an error message
> >> > in syslog, but rtnl_register_module() doesn't.  That's why this series
> >> > only changes some rtnl_register_module() calls.
> >> 
> >> You talk about the series.  Is there an introductory letter I should
> >> lookup on netdev that explains things in more detail?
> >> 
> >> I have only seen the patch that is sent directly to me.
> >
> > Some context here.
> > https://lore.kernel.org/netdev/20241007124459.5727-1-kuniyu@amazon.com/
> >
> > Before addf9b90de22, rtnl_register_module() didn't actually need
> > error handling for some callers, but even after the commit, some
> > modules copy-and-pasted the wrong code.
> 
> That is wrong. As far back as commit e284986385b6 ("[RTNL]: Message
> handler registration interface") it was possible for rtnl_register to
> error.  Of course that dates back to the time when small allocations
> were guaranteed to succeed or panic the kernel.  So I expect it was
> the change to small allocations that actually made it possible to
> see failures from rtnl_register.

I mean as of addf9b90de22~1, once rtnl_msg_handlers[protocol] was
allocated by rtnl_register() or rtnl_register_module(), the following
calls for the same protocol never failed.

For example, after rtnl_register() was called for PF_UNSPEC/PF_BRIDGE
from the core code, rtnl_register_module() for the protocols didn't
fail, thus some callers didn't need error handling.

Another example is PHONET, where only the first call of
rtnl_register_module() handled the error, which was correct before
addf9b90de22 but not after that commit.


> 
> That said there is a difference between code that generates an error,
> and callers that need to handle the error.  Even today I do not
> see that MPLS needs to handle the error.
> 
> Other than for policy objectives such as making it harder for
> syzkaller to get confused, and making the code more like other
> callers I don't see a need for handling such an error in MPLS.
> 
> >> > What if the memory pressure happend to be relaxed soon after the module
> >> > was loaded incompletely ?
> >> 
> >> Huh?  The module will load completely.  It will just won't have full
> >> functionality.  The rtnetlink functionality simply won't work.
> >> 
> >> > Silent failure is much worse to me.
> >> 
> >> My point is from the point of view of the MPLS functionality it isn't
> >> a __failure__.
> >
> > My point is it _is_ failure for those who use MPLS rtnetlink
> > functionality, it's uAPI.  Not everyone uses the plain MPLS
> > without rtnetlink.
> 
> No matter what the code does userspace attempting to use rtnetlink to
> configure mpls will fail.  Either the MPLS module will fail to load, and
> nothing works, or the module will load and do the best it can with what
> it has.  Allowing the folks you don't need the rtnetlink uAPI to
> succeed.
> 
> It isn't a uAPI failure.  It is a lack of uAPI availability.  There
> is nothing else it can be.

The former is much easier to understand what happened and what's
the next action, just retrying.  The latter lets lsmod show the
module is actually loaded, but there's no hint indicating the module
lacks the rtnetlink availability at the load time.

It's even worse if only a part of rtnetlink handlers is loaded, like
RTM_NEWROUTE works but RTM_GET/DELROUTE returns -ENOTSUPP, it's really
confusing.


> 
> In general the kernel tries to limp along the best it can without
> completely failing.
> 
> > Also, I don't want to waste resource due to such an issue on QEMU w/ 2GB
> > RAM where I'm running syzkaller and often see OOM.  syzkaller searches
> > and loads modules and exercises various uAPIs randomly, and it handles
> > module-load-failure properly.
> 
> Then please mention that use case in your change description.  That is
> the only real motivation I see to for this change in behavior. Perhaps
> something like:
> 
>     Handler errors from rtnetlink registration allowing syzkaller to view a
>     module as an all or nothing thing in terms of the functionality it
>     provides.  This prevents syzkaller from reporting spurious errors
>     from it's tests.
> 
> That seems like a fine motivation and a fine reason.  But if you don't
> say that, people will make changes that don't honor that, and people
> won't be able to look into the history and figure out why such a change
> was made.

I see, I'll add that sentences in v4.

pw-bot: cr

