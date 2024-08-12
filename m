Return-Path: <netdev+bounces-117875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F293E94FA76
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA711F2214A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC719AA58;
	Mon, 12 Aug 2024 23:53:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841C18C92D
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506790; cv=none; b=BltKFeW6OJeFSjhyUrb3hcof9QZMJVw52z810rDTcm6i7Zq6EMkMfEusuY5lnmnYiKDWoIp9V84kdlcFUcnzLIltb41d7adHbk+RYVqV3d/1cShgkjMmJUNBj6waCLbRjx8xTYE7GAhB/iW81kk83pGId57gq5Tfvtd+8E3Wy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506790; c=relaxed/simple;
	bh=BXKwlw0rdebqAvXH/cbeEYtpFnuMlwJOnYZJFWvQIiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/tl7+NoDQNf8a9faTFsKzHLDUhSJ8uCBxC50Tmt9sxPS4kOB5gu2i4guAJyjPeY0OPBcl4FSR8rpi2ZhjRbX+qFeRyyFlaE76dLgG7Tt7LDr/I3CNETcGOHTwG4BrC4ohL4LPZuhgD8EBZ3xIJvjYgX5mu8NnO1yN+HAMXdXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sdeqR-0002a0-R2; Tue, 13 Aug 2024 01:52:59 +0200
Date: Tue, 13 Aug 2024 01:52:59 +0200
From: Florian Westphal <fw@strlen.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@google.com,
	kerneljasonxing@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
Subject: Re: [PATCH net] tcp: prevent concurrent execution of
 tcp_sk_exit_batch
Message-ID: <20240812235259.GA6030@breakpoint.cc>
References: <20240812222857.29837-1-fw@strlen.de>
 <20240812232842.92219-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812232842.92219-1-kuniyu@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > ... because refcount_dec() of tw_refcount unexpectedly dropped to 0.
> > 
> > This doesn't seem like an actual bug (no tw sockets got lost and I don't
> > see a use-after-free) but as erroneous trigger of debug check.
> 
> I guess the reason you don't move the check back to tcp_sk_exit() is

No, it would not work. .exit runs before .exit_batch, we'd splat.

Before e9bd0cca09d1 ordering doesn't matter because
refcount_dec_and_test is used consistently, so it was not relevant
if the 0-transition occured from .exit or later via inet_twsk_kill.

> to catch a potential issue explained in solution 4 in the link, right ?

Yes, it would help to catch such issue wrt. twsk lifetime.
Having the WARN ensures no twsk can escape .exit_batch completion.

E.g. if twsk destructors in the future refer to some other
object that has to be released before netns pointers become invalid
or something like that.

Does that make sense?  Otherwise I'm open to alternative approaches.
Or we can wait until syzbot finds a reproducer, I don't think its
a real/urgent bug.

