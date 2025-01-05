Return-Path: <netdev+bounces-155285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B7DA01BAC
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 20:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B663A05D0
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F314B97E;
	Sun,  5 Jan 2025 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rZKRdiZ6"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38A1E487;
	Sun,  5 Jan 2025 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736106881; cv=none; b=JxtxFpi5MRE/5ACGPqi5FKix9iZZts2NqpT0ArkW4C6YSavflo4nNrpH5n87W7IVNTto4o1XyG8rJnkLj24S19ganRX5Of1LNH5RBAOrk2OZsdphyNt5s2+2PR4U7cTQr62GNHzf30imyawp8rcGPgQj6VxUNpgTYXQDlO1WwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736106881; c=relaxed/simple;
	bh=x64J8jgXj8xL107CQut5FPLLKzq8w4psLqQbC34CprY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDnsFyJ5t9HB2ARala8komvvLn+pB1n1v7RyLE4xYWtPqNXoWACsj53WbkfEY/gnt5ehzWZaTuxo6VbszUv+pUWmUvnkNvuAgC0OEYPeLmVVW76xWk7lrf4YzdutLANfvxxZEd8/tOLt7lvUQ56QjilXqLCZjeTtagV04u378FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rZKRdiZ6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=/NkQCpw7UoIOxF6aUPhMuL7vsM2VnC8sjgXz7NlXzV8=; b=rZKRdiZ6E+JoQIsmBsIicMOKWr
	U3/QhLx1vnrxAv71ZXP4EH4Pr6LrrLxuMThfzMkBz0u6H5pbqgEKXy06VUMejNfqJ58rbjufd8zRf
	ztDmrDDz/ZeL3ByjNYYz2rjedTrUlMbLUoZ9T81XCf2w5/i/PRD1/5zPXjAwzhBaFbCKKg7G4jiZh
	hJDicqUts5k7IzTZ53V4PjBgFj1tvAWNgF+qN9ewtc47bRXdN2K/H6Zzx4kp9XXHRalEclgtFZg+Y
	GCFY54YeY+trW163x2zLO1YoX1phLFCQ4vU5C8/Ogi+oLlGAFuEy7Wzgm3fTPHooNKsdpbsneopSc
	ZKgVXtEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUWhm-0000000Fjbh-2czA;
	Sun, 05 Jan 2025 19:54:34 +0000
Date: Sun, 5 Jan 2025 19:54:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
	geliang@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, martineau@kernel.org,
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
Message-ID: <20250105195434.GJ1977892@ZenIV>
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com>
 <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
 <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <20250104190010.GF1977892@ZenIV>
 <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
 <20250104202126.GH1977892@ZenIV>
 <CANn89i+GUGLQSFp3a2qwH+zOsR-46CyWevjhAQQMmO5K9tmkUg@mail.gmail.com>
 <20250105112948.GI1977892@ZenIV>
 <CANn89i+L619t94EybXKsGFGQjPS7k-Qra_vXG-AcLJ=oiU2yYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+L619t94EybXKsGFGQjPS7k-Qra_vXG-AcLJ=oiU2yYQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 05, 2025 at 05:52:19PM +0100, Eric Dumazet wrote:
> On Sun, Jan 5, 2025 at 12:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sun, Jan 05, 2025 at 09:32:36AM +0100, Eric Dumazet wrote:
> >
> > > According to grep, we have many other places directly reading
> > > current->nsproxy->net_ns
> > > For instance in net/sctp/sysctl.c
> > > Should we change them all ?
> >
> > Depends - do you want their contents match the netns of opener (as,
> > AFAICS, for ipv4 sysctls) or that of the reader?
> 
> I am only worried that a malicious user could crash the host with
> current kernels,
> not about this MPTP crash, but all unaware users of current->nsproxy
> in sysctl handlers.

I don't hate your mitigation in proc_sysctl.c, but IMO there are two
problems mixed here - one is that we probably should have access
to per-netns sysctl table act on the netns it had been created for,
which may not coincide with reader's/writer's netns and another is that
access to current->nsproxy->netns would simply oops if attempted when
current->nsproxy had been dropped.

So I suspect that current->nsproxy->netns shouldn't be used in
per-netns sysctls for consistency sake (note that it can get more
serious than just consistency, if you have e.g. a spinlock taken
in something hanging off current netns to protect access to
something table->data points to).

As for the mitigation in fs/proc/proc_sysctl.c... might be useful,
if it comes with a clear comment about the reasons it's there.

