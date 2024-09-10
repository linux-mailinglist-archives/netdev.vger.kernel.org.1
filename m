Return-Path: <netdev+bounces-127109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 483C2974240
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18E0B25EC2
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4121A38FD;
	Tue, 10 Sep 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CQ5xdJeI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFC17A584;
	Tue, 10 Sep 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993245; cv=none; b=Sgri6ZrykFf9MwicAk3NX6KgPoch8wb6E0uaQGdRive3GmqKf7zD1OesXOq7yg2mUSTTrXlAGJ2+46sP9TJxV5tXxSQQ7XhkhZUZkThjmVOSk6Leq2PPSWacFR3TcHIqYaMRuDusLKXDIctzWBZbI9iMPZ+M56XThEXbWl5uiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993245; c=relaxed/simple;
	bh=SiSTjydEw3VJIiet5lUcopImzPHUWRlaPl718/HkocE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKp4l6XuSkio3ZrhxdKXzl5Hh8vtxfYL5GTN7fSI3ueLmNdBzKInaguKdf83rwZ7Gj58w6SrqoEMiP2asoxcsclgpWALhl20odNGBOKKssSIlVRd/MG28/+9s4BAcZNJWhjnJKxr0M2uCU8c980MTc6wvAKaQsA3K3pH1THQZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CQ5xdJeI; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725993244; x=1757529244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8AQGkLi95DL/Q4q+OGf/iz4yxp6oSCpbbVD1/gZvdys=;
  b=CQ5xdJeI+Y5ToZKyKcBvYofV40yY+V7qLMJXwOawfyLyM5lP27WMN1Q6
   GrhdGxvpORt3gdNaBVhngb/iin0j/o2WM5n1dFtKx3mz15OwIfWtn/WtJ
   J4ZVl3I2kASZYkrB9f6mEwooLXDh/D59GLa79QkuYFIXnIrsuIjNw+3kO
   M=;
X-IronPort-AV: E=Sophos;i="6.10,218,1719878400"; 
   d="scan'208";a="230974526"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 18:33:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:46231]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.222:2525] with esmtp (Farcaster)
 id 588ac3be-1e37-4f03-8a9d-0a011c0009b3; Tue, 10 Sep 2024 18:33:20 +0000 (UTC)
X-Farcaster-Flow-ID: 588ac3be-1e37-4f03-8a9d-0a011c0009b3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 18:33:20 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 10 Sep 2024 18:33:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Tue, 10 Sep 2024 11:33:09 -0700
Message-ID: <20240910183309.82852-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <83913196-1240-45b4-9d7b-6f5dffc528c6@oracle.com>
References: <83913196-1240-45b4-9d7b-6f5dffc528c6@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Tue, 10 Sep 2024 11:16:59 -0700
> On 9/10/2024 10:57 AM, Kuniyuki Iwashima wrote:
> > From: Shoaib Rao <rao.shoaib@oracle.com>
> > Date: Tue, 10 Sep 2024 09:55:03 -0700
> >> On 9/9/2024 5:48 PM, Kuniyuki Iwashima wrote:
> >>> From: Shoaib Rao <rao.shoaib@oracle.com>
> >>> Date: Mon, 9 Sep 2024 17:29:04 -0700
> >>>> I have some more time investigating the issue. The sequence of packet
> >>>> arrival and consumption definitely points to an issue with OOB handling
> >>>> and I will be submitting a patch for that.
> >>>
> >>> It seems a bit late.
> >>> My patches were applied few minutes before this mail was sent.
> >>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/172592764315.3964840.16480083161244716649.git-patchwork-notify@kernel.org/__;!!ACWV5N9M2RV99hQ!M806VrqNEGFgGXEoWG85msKAdFPXup7RzHy9Kt4q_HOfpPWsjNHn75KyFK3a3jWvOb9EEQuFGOjpqgk$
> >>>
> >>
> >> That is a subpar fix. I am not sure why the maintainers accepted the fix
> >> when it was clear that I was still looking into the issue.
> > 
> > Just because it's not a subpar fix and you were slow and wrong,
> > clining to triggering the KASAN splat without thinking much.
> > 
> > 
> >> Plus the
> >> claim that it fixes the panic is absolutely wrong.
> > 
> > The _root_ cause of the splat is mishandling of OOB in manage_oob()
> > which causes UAF later in another recvmsg().
> > 
> > Honestly your patch is rather a subpar fix to me, few points:
> > 
> >    1. The change conflicts with net-next as we have already removed
> >       the additional unnecessary refcnt for OOB skb that has caused
> >       so many issue reported by syzkaller
> > 
> >    2. Removing OOB skb in queue_oob() relies on the unneeded refcnt
> >       but it's not mentioned; if merge was done wrongly, another UAF
> >       will be introduced in recvmsg()
> > 
> >    3. Even the removing logic is completely unnecessary if manage_oob()
> >       is changed
> > 
> >    4. The scan_again: label is misplaced; two consecutive empty OOB skbs
> >       never exist at the head of recvq
> > 
> >    5. ioctl() is not fixed
> > 
> >    6. No test added
> > 
> >    7. Fixes: tag is bogus
> > 
> >    8. Subject lacks target tree and af_unix prefix
> 
> If you want to nit pick, nit pick away, Just because the patch email 
> lacks proper formatting does not make the patch technically inferior.

Ironically you just nit picked 8.


> My 
> fix is a proper fix not a hack. The change in queue_oob is sufficient to 
> fix all issues including SIOCATMARK. The fix in manage_oob is just for 
> correctness.

Then, it should be WARN_ON_ONCE() not to confuse future readers.


> In your fix I specifically did not like the change made to 
> fix SIOCATMARK.

I don't like that part too, but it's needed to avoid the additional refcnt
that is much worse as syzbot has been demonstrating.


> 
> What is most worrying is claim to fixing a panic when it can not even 
> happen with the bug.

It's only on your setup.  syzbot and I were able to trigger that with
the bug.


> Please note I am not pushing that my patch be 
> accepted, I have done what I am suppose to do, it is upto the 
> maintainers to decide what is best for the code.

