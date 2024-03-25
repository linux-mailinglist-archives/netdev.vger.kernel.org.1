Return-Path: <netdev+bounces-81620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CE88B077
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EFBC42271
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EFC86649;
	Mon, 25 Mar 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLhaTAqZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8156886644
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373643; cv=none; b=T+5CznUMquChm+AepFyDvqUtLLrm8LCfRo8jVFYV24WB4kB9cXMmfAlEJk9AftfBI34u0/m4etKV8PttoUhrY3VHPOmeR8JnpeJhL2xwcDfHKRTZkIP5sl3fXIn2+7TN/IIpDTkcmXCU3du2Py/WwLqBQ0pLXyYg7mp41RKfI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373643; c=relaxed/simple;
	bh=QQoHM3zF1uwPXqhMybYrZwbU0mHxpIciYHL6b0tv0hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBcxICcT8vpSbDFz8h58qegAr0Lqt6ggAswe4ZoHF7c53Ao0Orr7uvtJtuQoWvcT2RPOxIfHAWFaw/8Zx534r9ogCdDp5dBzFB4O+enY7gm/01hk7s59xStEQUNTwoR7s8J+Y8SfTv5fr0dFzDD5FxZ29+tFbSuHd4SjoowjvdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLhaTAqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3A7C433C7;
	Mon, 25 Mar 2024 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711373643;
	bh=QQoHM3zF1uwPXqhMybYrZwbU0mHxpIciYHL6b0tv0hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OLhaTAqZoLDzSv36yc8xSxZzBeOyLTMPC0TLeV4NzdLLQhkD5sAddqb8zHGSu7r4R
	 nau35CwMNHhYB/00PNQyPVnCQbognGLEwZNFe4IMkgREZRcb4YlLB8b+ZvORngAHK0
	 HM2nAUh891LFfIGFnjmI7Lnh+ahUHBKem8IcshZC/epi74uzHAY5+HBCx8sUf7enCw
	 vJQBDr8ZS/ZrbIezzHGrUq43i8v35RJMvkNSaDp60AxyyPMEa7R0bQ5wNSuYcBXNI5
	 lVfqdHljmjEAIz4Xxv0J3gIYTWNWPdEI69BAcrE/wBcbSAHBjgVFMMA3LXFoPgn1Jc
	 4Fw4KyckuqdwA==
Date: Mon, 25 Mar 2024 06:34:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Josef
 Bacik <josef@toxicpanda.com>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH net] tcp: properly terminate timers for kernel sockets
Message-ID: <20240325063401.7d7f3d35@kernel.org>
In-Reply-To: <CANn89iJ-TJY8Bf_6W2yh1F4V0qBNNUKk0NGNT2XJN9Or0oRgdg@mail.gmail.com>
References: <20240322135732.1535772-1-edumazet@google.com>
	<20240322154704.7ed4d55f@kernel.org>
	<CANn89iJ-TJY8Bf_6W2yh1F4V0qBNNUKk0NGNT2XJN9Or0oRgdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Mar 2024 05:45:26 +0100 Eric Dumazet wrote:
> > On Fri, 22 Mar 2024 13:57:32 +0000 Eric Dumazet wrote:  
> > > +     if (!sk->sk_net_refcnt)
> > > +             inet_csk_clear_xmit_timers_sync(sk);  
> >
> > The thought that we should clear or poison sk_net at this point
> > (whether sk->sk_net_refcnt or not) keeps coming back to me.
> > If we don't guarantee the pointer is valid - to make it easier
> > for syzbot to catch invalid accesses?  
> 
> I do not think we should do this here.
> 
> Note that KASAN has quarantine, and can catch invalid UAF accesses anyway.
> 
> We could clear the base socket in sk_prot_free() but this will not
> make KASAN better.

I was thinking mostly about the kernel sockets being "special",
and therefore less well exercised by syzbot. But sk_net will
remain valid until all user space for that netns exists, IIUC,
so I take it back, the clearing has a real chance of adding bugs.

