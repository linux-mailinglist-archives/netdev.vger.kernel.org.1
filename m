Return-Path: <netdev+bounces-127129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DECA9743AD
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C439D28825B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102671AAE07;
	Tue, 10 Sep 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NXdlQAau"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD81A76DA;
	Tue, 10 Sep 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997777; cv=none; b=gFrSXObNrmy1qHQ2vlhGEd634IQxhKY/EJg5ODabJAfRs+uh3mh0pQM9hDau0fmgxRy860uNdFFnviNrOtOez+tYQybFUWhDm1mUzMNmNltrY+QV52ouhzVv5KdJZyPYUWHeiQwRAybEq32ifvaY5sssTRYYEFwRftVMDAz61GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997777; c=relaxed/simple;
	bh=ccBxcpeuPZm8pVyeOUPxWoSYyMWp++34eVaxy+VEapU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHD7hQHAt60MdADS5IDmdR2lPp5VPFoe2ppD1A6lbP9H7WmxUKMQIde96r17IWO4Pah9zN4XXAa+SJ/I11OPk7Q2mBZx/1xI9Hv6bFfna9+zHwZLp5XQpu2lBrwmji9u+lujy9NvI0A9zpk0wN/ATFGswTl8ESpqdIkTvGRr6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NXdlQAau; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725997776; x=1757533776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dACRD1j+be5FMEDwQZty04itxFHodGQg6PPtuiZvQ0E=;
  b=NXdlQAau3mNS3QTfoekhqyykwI5wiaRRe6RXbWkHdV2sTEqM+BWF7u3x
   kx9+r+4SfLbxRHDc+uRwMlXCKRcsjVtcsvAmCt/zEGu7//Kg7MFC63ABW
   DyFUQgGOt6eVIceWdcwnGoU0YxHfvMmpnH7QWWPqJFFDmUr5uULk0k+EN
   s=;
X-IronPort-AV: E=Sophos;i="6.10,218,1719878400"; 
   d="scan'208";a="758581941"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 19:49:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:47074]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.84:2525] with esmtp (Farcaster)
 id e06452b5-6f92-4c8a-8440-4455041c59de; Tue, 10 Sep 2024 19:49:22 +0000 (UTC)
X-Farcaster-Flow-ID: e06452b5-6f92-4c8a-8440-4455041c59de
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 19:49:21 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 10 Sep 2024 19:49:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Tue, 10 Sep 2024 12:49:10 -0700
Message-ID: <20240910194910.90514-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1cca9939-fe04-4e19-bc14-5e6a9323babd@oracle.com>
References: <1cca9939-fe04-4e19-bc14-5e6a9323babd@oracle.com>
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

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Tue, 10 Sep 2024 11:49:20 -0700
> On 9/10/2024 11:33 AM, Kuniyuki Iwashima wrote:
> > From: Shoaib Rao <rao.shoaib@oracle.com>
> > Date: Tue, 10 Sep 2024 11:16:59 -0700
> >> On 9/10/2024 10:57 AM, Kuniyuki Iwashima wrote:
> >>> From: Shoaib Rao <rao.shoaib@oracle.com>
> >>> Date: Tue, 10 Sep 2024 09:55:03 -0700
> >>>> On 9/9/2024 5:48 PM, Kuniyuki Iwashima wrote:
> >>>>> From: Shoaib Rao <rao.shoaib@oracle.com>
> >>>>> Date: Mon, 9 Sep 2024 17:29:04 -0700
> >>>>>> I have some more time investigating the issue. The sequence of packet
> >>>>>> arrival and consumption definitely points to an issue with OOB handling
> >>>>>> and I will be submitting a patch for that.
> >>>>>
> >>>>> It seems a bit late.
> >>>>> My patches were applied few minutes before this mail was sent.
> >>>>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/172592764315.3964840.16480083161244716649.git-patchwork-notify@kernel.org/__;!!ACWV5N9M2RV99hQ!M806VrqNEGFgGXEoWG85msKAdFPXup7RzHy9Kt4q_HOfpPWsjNHn75KyFK3a3jWvOb9EEQuFGOjpqgk$
> >>>>>
> >>>>
> >>>> That is a subpar fix. I am not sure why the maintainers accepted the fix
> >>>> when it was clear that I was still looking into the issue.
> >>>
> >>> Just because it's not a subpar fix and you were slow and wrong,
> >>> clining to triggering the KASAN splat without thinking much.
> >>>
> >>>
> >>>> Plus the
> >>>> claim that it fixes the panic is absolutely wrong.
> >>>
> >>> The _root_ cause of the splat is mishandling of OOB in manage_oob()
> >>> which causes UAF later in another recvmsg().
> >>>
> >>> Honestly your patch is rather a subpar fix to me, few points:
> >>>
> >>>     1. The change conflicts with net-next as we have already removed
> >>>        the additional unnecessary refcnt for OOB skb that has caused
> >>>        so many issue reported by syzkaller
> >>>
> >>>     2. Removing OOB skb in queue_oob() relies on the unneeded refcnt
> >>>        but it's not mentioned; if merge was done wrongly, another UAF
> >>>        will be introduced in recvmsg()
> >>>
> >>>     3. Even the removing logic is completely unnecessary if manage_oob()
> >>>        is changed
> >>>
> >>>     4. The scan_again: label is misplaced; two consecutive empty OOB skbs
> >>>        never exist at the head of recvq
> >>>
> >>>     5. ioctl() is not fixed
> >>>
> >>>     6. No test added
> >>>
> >>>     7. Fixes: tag is bogus
> >>>
> >>>     8. Subject lacks target tree and af_unix prefix
> >>
> >> If you want to nit pick, nit pick away, Just because the patch email
> >> lacks proper formatting does not make the patch technically inferior.
> > 
> > Ironically you just nit picked 8.
> > 
> > 
> 
> I have no idea what you mean. I am more worried about technical 
> correctness than formatting -- That does not mean formatting is not 
> necessary.

I started pointing out technical stuff and ended with nit-pick because
"I am more worried about technical correctness", but you started nit
picking from the last point.  That's unfortunate.


> 
> >> My
> >> fix is a proper fix not a hack. The change in queue_oob is sufficient to
> >> fix all issues including SIOCATMARK. The fix in manage_oob is just for
> >> correctness.
> > 
> > Then, it should be WARN_ON_ONCE() not to confuse future readers.
> > 
> > 
> >> In your fix I specifically did not like the change made to
> >> fix SIOCATMARK.
> > 
> > I don't like that part too, but it's needed to avoid the additional refcnt
> > that is much worse as syzbot has been demonstrating.
> > 
> 
> syzbot has nothing to do with doing a proper fix.

You don't understand my point.  syzbot has been finding many real issues
that were caused by poor handling of the additional refcount.

Also, removing it discovered another bug in manage_oob().  That's a enough
reason to explain why we should remove the unnecessary refcnt.


> One has to understand 
> the code though to do the fix at the proper location.

I'm not saying that the patch is correct if it silences syzbot.

Actually, I said KASAN is handy but you need not rely on it.

Rather it's you who argued the splat was needed even without trying
to understand the code.

I really don't understand why you are saying this to me now.


> 
> > 
> >>
> >> What is most worrying is claim to fixing a panic when it can not even
> >> happen with the bug.
> > 
> > It's only on your setup.  syzbot and I were able to trigger that with
> > the bug.
> > 
> 
> Really, what is so special about my setup that kasan does not like? Can 
> you point me to the exact location where the access is made?

I don't know, it's your job.

> 
> I am at least glad that you have backed off your assertion that my 
> change does not fix the ioctl.

Okay, I was wrong about that, and what about other points, fragile
refcnt, non-WARN_ON_ONCE(), misplaced label, no test, bogus tag ?


> I am sure if I keep pressing you, you 
> will back off the panic claim as well.

I also don't understand what you are saying and why you still can't
correlate the splat and the sequences of syscalls in the repro.


> You yourself admitted you did not 
> know why kasan was not panicing, Has anyone else hit the same panic?
> 
> If you can pin point the exact location where the illegal access is 
> made, please do so and I will accept that I am wrong, other than that I 
> am not interested in this constant back and forth with no technical 
> details just fluff.

Please read my changelog (and mails) carefully that pin-point the
exact location and reason where/why the illegal access happens.

This will be the last mail from me in this thread.  I don't want to
waste time on someone who doesn't read mails.

