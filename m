Return-Path: <netdev+bounces-141616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F83C9BBCF9
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB581F22F5C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C4D1CACDE;
	Mon,  4 Nov 2024 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H6F6jHdy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA731C9ED6
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744058; cv=none; b=TpNB8lymvYYz/rSVvcI1ZRIsgIJMDAXSmfIMCS2VG+c/c9gV51rlqIEra88+EPjbjUhbfWQcU6dcWgytvSCfZmeWwVSDjyzapURe7H7pQ3C/O/LAdFdP67T9iyM6GbEXEVPYoB/NlcSexLnkwjQUulOjoVwG6zXw8zHn71j+DpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744058; c=relaxed/simple;
	bh=aN8v1aA5mg4XjqvwkCFCD2Wa7UW8xJoBXXcW6XA/5zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elH4v/f/Czw9WHIEcI+K53qfv4bb9kmxlyXuXwW0u3OeSnuYhS2rtPztRJVq6hIQXZI0UF0f9JCLpK7LzihwF2hy2ovBvFUJFeN87osGQCtz1CYMsPktJSRPncFz9iohgmQG+NyWY+hj6pDsBDDQgxFBZrLowke6GYnE420uu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H6F6jHdy; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609d8874b1so36412901cf.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730744055; x=1731348855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zXPpFLmVRieKxpkO+X210QXJX8MilLsbdVXcXNcuwhQ=;
        b=H6F6jHdyhLIX/Oj1zBy7q7k97+h1aCAQhkZJ7zRn/yCaNWpo41XSKGNExbdyTf6P+l
         c907jusxjvLNojyJJCLDnf0P699rcUPhdFr4X7PYJncQAc5tR4Ohr2IqAOgN+8rz57QZ
         iQDbnRO0G1jY6+rHX5kJaqr8CiRUAZdqJABezZVMORpCdfnfMIAkIIQ+sZh/p94oMdOe
         rWpfdA632hEpNt1a763P6QRnYjjAW9ST8E5utq2vN0gA2Y6oxhvNTFXv0WV5vVrf4rLt
         clVNmFH4FJYkBPdPr5xPC/B6cGrkEeFYOGHA8sG2RjL8Fzv44AeI2gQPXBWtey4ieOk5
         8+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744055; x=1731348855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXPpFLmVRieKxpkO+X210QXJX8MilLsbdVXcXNcuwhQ=;
        b=qdnqdRRQrtjxkFlSKlbCe6Cf4iAQ4xNIMZTpjh7eafnyo89qx2uxjEOBGgVWY7a3Lv
         GhYUInLfr16hjG+7NB2IymkG5OVWwBG7Z5fmgc2JJVbpf7oasLuvhbg4DBPT9PvsZwEG
         /Xeny+TxwkbsoO6BaOQUjwYMXbPBraxXbBYYklvllzmq/DyKjVqsSjc2VMwic9qZl/mQ
         6mZPizFOxD1pE+rYfdPCbf6CDUp5I1zJ27K1JOBI+W/se2XLNZMc+iSpQpogFSwzh4lR
         6S2pG0QrToyI5maRLCtazEGLGBHmJG0hO9pi1iQgEP0BO2HXHCwAS3IPyfbCipyFaoNJ
         XITg==
X-Forwarded-Encrypted: i=1; AJvYcCV5vFbmPSiPryRvMj37/U7P+i4rQATQSeAZaGvfx6yljznC/q2M7hCvKZsj+P29Np2ffc8L3FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3UQRBJiAjJl3b2fEXyGmue0TQQSSJacClSED+23vAoTRTZxW
	yWfP1hvX6OAYD3bfUHSyPu4mEbhJYf0P5kgGqa325cCVF7xo/m6hDvg1G0X4ZHM=
X-Google-Smtp-Source: AGHT+IF1PKPD/v9OK4iTuAs3JRnkOhZAcYBDSaPRNYYy6E54+wtegDCt1MNum4cuOwk6nR/bljzgMA==
X-Received: by 2002:a05:622a:2c3:b0:461:1fa:fba with SMTP id d75a77b69052e-462ab29f8d3mr266421881cf.32.1730744055028;
        Mon, 04 Nov 2024 10:14:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad161597sm49349031cf.63.2024.11.04.10.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t81af-00000001jqP-2SNl;
	Mon, 04 Nov 2024 14:14:13 -0400
Date: Mon, 4 Nov 2024 14:14:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+6dee15fdb0606ef7b6ba@syzkaller.appspotmail.com>,
	leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] INFO: task hung in add_one_compat_dev (3)
Message-ID: <20241104181413.GG35848@ziepe.ca>
References: <671756af.050a0220.10f4f4.010f.GAE@google.com>
 <20241022142901.GA13306@ziepe.ca>
 <CANp29Y534CT0jqhp5LQi_ZCs=1_i4duRO=4CJ52by9ZDW-1Wfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y534CT0jqhp5LQi_ZCs=1_i4duRO=4CJ52by9ZDW-1Wfw@mail.gmail.com>

On Fri, Nov 01, 2024 at 04:55:32PM +0100, Aleksandr Nogikh wrote:
> Hi Jason,
> 
> On Tue, Oct 22, 2024 at 4:29 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Oct 22, 2024 at 12:39:27AM -0700, syzbot wrote:
> >
> > > 1 lock held by syz-executor/27959:
> > >  #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
> > >  #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: __rtnl_newlink net/core/rtnetlink.c:3749 [inline]
> > >  #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_newlink+0xab7/0x20a0 net/core/rtnetlink.c:3772
> >
> > There is really something wrong with the new sykzaller reporting, can
> > someone fix it?
> >
> > The kernel log that shows the programs:
> >
> > https://syzkaller.appspot.com/x/log.txt?x=10d72727980000
> >
> > Doesn't have the word "newlink"/"new"/"link" etc, and yet there is an
> > executor clearly sitting in a newlink netlink callback when we
> > crashed.
> 
> These are likely coming from the network devices initialization code.
> When syzbot spins up a new syz-executor, it creates a lot of
> networking devices as one of the first steps.
> https://github.com/google/syzkaller/blob/f00eed24f2a1332b07fef1a353a439133978d97b/executor/common_linux.h#L1482

Which part of this is the syz-executor? Near the start of the VM
lifetime?

Or each time it does:

last executing test programs:

3m14.839622334s ago: executing program 3 (id=3291):
r0 = socket$nl_netfilter(0x10, 0x3, 0xc)
sendmsg$NFT_MSG_GETRULE(r0, &(0x7f0000000240)={0x0, 0x0, &(0x7f00000001c0)={&(0x7f0000000380)={0x20, 0x19, 0xa, 0x3, 0x0, 0x0, {}, [@NFTA_RULE_TABLE={0x9, 0x1, 'syz0\x00'}]}, 0x20}}, 0x0)

?

> So those syz-executors might have just been unable to start and then
> they were abandoned (?)

It seems unlikely.. The crash happened like this:

[  709.737594][   T30] INFO: task syz-executor:27961 blocked for more than 143 seconds.

So whatever killed it happened at approx 566 seconds into the test,
not when it booted.

Since the start of the "last executing test programs:" is only 3min
back, and the above is 9 min back, it probably helps explain why there
is no record.

> > We need to see the syzkaller programs that are triggering these issues
> > to get ideas, and for some reason they are missing now.
> 
> Once syzbot manages to find a reproducer, hopefully things will become
> more clear.

It never seems to find one for these kinds of things... The dashboard
says it happens almost daily.

Jason

