Return-Path: <netdev+bounces-118578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683D9521BF
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CD61C21C4B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC01B5818;
	Wed, 14 Aug 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWsUQIMD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D11B373D
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658488; cv=none; b=TtnkrSOapnKNu9GI0ayDvO5DfegyLpY8YbQXvV8FSHDHzdjd4GHb5egRMWReEXY4UBy7dNCA2Ogctu0I0vGJYCRUxsHWtq8+Yoi61G2lC4yXKyqJjn177EGeCavTz1RlW4tcRyJvv7pp0/ypvZqGj5JOTKGKB7c+PQSbL64MG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658488; c=relaxed/simple;
	bh=Ct9pmwBg5XugDwJQq3ELV53mv3uTakM9zUzju9I0eTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F245gRW/n00uu5l/MHf116yAvTWvhNAinMAWubKw8TBUfW4X0t92WFBEOSzZO2nSHXOqsA+/1jdLeH6cEXkyYw4C5w0A8Cx1xfpGYhJpZQ8RmpMiP4oj3IBoSUJYS8zmp3FGdeGGF9ie93KUaoF6F0p89LEHeNyvSfswL4Hrdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWsUQIMD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc47abc040so1194915ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723658485; x=1724263285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/njC2I8sB3xEiJtucgGLyFQRqn1VRs8wW/ab4iro77c=;
        b=jWsUQIMDjuZgve3Z1wcBjTkvL4Gi0Ack1CVOhS0C4fUwEAgsGK8EhnETZodr5aNdnx
         M+ME1yyJ1PwkXTP555hg4y1jTLnltY6KLWh8zloSiMunfbGrC+c38VYSiJHaUS/XO7Nc
         RxkjdJM7jp1r44zzhbNRrYlSGEmDZDuFzHZpFT1TMn5KLQhsqTqBQjNIUIrxNaoMbv0B
         aS+mB8WkMuWZkzLPGqMoTNupoeHi9o9pX11WP0utM9dIx1NHtPNPP9O219A8/tTVUHvM
         i9HRetcsEjAKCNGnw1H3HULt+hi1GhZjZtAyPhqD6pVDjYg8NV0u4fAWZHnSTJFeLzlW
         0bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658485; x=1724263285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/njC2I8sB3xEiJtucgGLyFQRqn1VRs8wW/ab4iro77c=;
        b=m6MjYfhOKvEvn03NBb1TJmngDzXE59rYJ6Ca2g08Y/598hgu8vJHEBFYWcDCqtz1a2
         e7uc9jD0eP8mw+JglQpKvzCl7iZNO8sVmFtDkSDHlyXlT/OKFSCUkJ38x6fdWpz4y+HE
         8HuHf3Afe9s4/TyhJW+ET9S4rfUkc9eib1oN0RpwjH2+2r+y5AkzqhUBEoHmGblQUQpp
         lU4SYfnKtc1xFM0jbQERKeBoYQEgWfffA4lSDyS3C0nZcut4JlQYCP1TCBoNp4MkJjy4
         X1s1VE02ikDZPU3/SmQne2h1d9hQVTTaTUE+VXbpY1nOtdQoZGJwUmFNl3qM66l/9l0C
         EMbg==
X-Gm-Message-State: AOJu0Yx/DrhiWPPvFbiINd05cUjw67lBnBGl4eviPONSsTtV4efo9Qcy
	OcQ3msYSUqCnhopNuQNys4O/HXOerSesDWJxPiTkNPiOi6lnHLa6
X-Google-Smtp-Source: AGHT+IHCYpciuCeQJFJTUdrB1PLndgYWlkflh7swucjGk7iJZ7fzT/SsK2JQ1CvXtQ2xM2W+cf1v6w==
X-Received: by 2002:a17:902:c94d:b0:1fd:a360:446f with SMTP id d9443c01a7336-201d65c0d14mr51469915ad.65.1723658485204;
        Wed, 14 Aug 2024 11:01:25 -0700 (PDT)
Received: from localhost ([12.216.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1b4635sm32143225ad.199.2024.08.14.11.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 11:01:24 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:01:22 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com, horms@kernel.org,
	syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net-next 9/9] l2tp: flush workqueue before draining it
Message-ID: <Zrzw8oe+LBoTModP@pop-os.localdomain>
References: <cover.1723011569.git.jchapman@katalix.com>
 <2bdc4b63a4caea153f614c1f041f2ac3492044ed.1723011569.git.jchapman@katalix.com>
 <Zrj6w89B7so74jRU@pop-os.localdomain>
 <6f0e2c8e-205c-71ae-2b93-02538122097a@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0e2c8e-205c-71ae-2b93-02538122097a@katalix.com>

On Mon, Aug 12, 2024 at 10:24:11AM +0100, James Chapman wrote:
> On 11/08/2024 18:54, Cong Wang wrote:
> > On Wed, Aug 07, 2024 at 07:54:52AM +0100, James Chapman wrote:
> > > syzbot exposes a race where a net used by l2tp is removed while an
> > > existing pppol2tp socket is closed. In l2tp_pre_exit_net, l2tp queues
> > > TUNNEL_DELETE work items to close each tunnel in the net. When these
> > > are run, new SESSION_DELETE work items are queued to delete each
> > > session in the tunnel. This all happens in drain_workqueue. However,
> > > drain_workqueue allows only new work items if they are queued by other
> > > work items which are already in the queue. If pppol2tp_release runs
> > > after drain_workqueue has started, it may queue a SESSION_DELETE work
> > > item, which results in the warning below in drain_workqueue.
> > > 
> > > Address this by flushing the workqueue before drain_workqueue such
> > > that all queued TUNNEL_DELETE work items run before drain_workqueue is
> > > started. This will queue SESSION_DELETE work items for each session in
> > > the tunnel, hence pppol2tp_release or other API requests won't queue
> > > SESSION_DELETE requests once drain_workqueue is started.
> > > 
> > 
> > I am not convinced here.
> > 
> > 1) There is a __flush_workqueue() inside drain_workqueue() too. Why
> > calling it again?
> 
> Once drain_workqueue starts, it considers any new work item queued outside
> of its processing as an unexpected condition. By doing __flush_workqueue
> first, we ensure that all TUNNEL_DELETE items are processed, which means
> that SESSION_DELETE work items are queued for all existing sessions before
> drain_workqueue starts. Now if an API request is processed to delete a
> session, l2tp_session_delete will do nothing because session->dead has
> already been set.

What about the following case?

CPU 0			CPU1
test_and_set_bit()
			__flush_workqueue()
  queue_work()
  			drain_workqueue()

> 
> > 2) What prevents new work items be queued right between your
> > __flush_workqueue() and drain_workqueue()?
> 
> Hmm, to do so, a new tunnel would need to be created and then deleted by API
> request once drain_workqueue starts. Is it possible to create new sockets in
> a net once a net's pre_exit starts? I didn't think so, but I'll recheck.

I don't quite understand why you need to create a new one while tearing
down the old one(s). I think what you need here is some way to properly
waiting for the socket tear down to finish.

Thanks.

