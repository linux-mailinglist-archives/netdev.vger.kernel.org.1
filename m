Return-Path: <netdev+bounces-162951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D9AA289CA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42916188536A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D92147E6;
	Wed,  5 Feb 2025 12:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95BF21C9E3
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738756829; cv=none; b=XKixwmNmHNRxCvUThuXc1jweJJXYdS7a9ezFQrmE1oUieFCiwN1FEPmy/AwQ03nuY9/KuXXyzCgAv9QqbvKoo5W3t24y0hbtQSJ30r5f2Zg0/UiOhr42gHW5/6yg+tMaCc0rtuwWdAT69x/6JMYbiEBSJTvEOrrNx8fUwJGyH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738756829; c=relaxed/simple;
	bh=oUwvX+uOb3xbRTu7xJ24WvLsk4TWa4T1nP0vhd3iVUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBlcEnviounoI2WjgUeY0aET1dQ4Uqzt8yPtPX90vCm77XZ0KmmYxIa/VK/RRVdhe0OrEYdci5awZcaBeSE+k5M2aAAz3841zkajkp8ysluBFpX7M2gC1p0xG6dPp6aDFjfbjjhLKlbLk4a4ZsxjbMrx6qz2/MZnJcP7WaTD13g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.12])
	by sina.com (10.185.250.24) with ESMTP
	id 67A34C8C00000DC7; Wed, 5 Feb 2025 19:33:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 35320310748441
X-SMAIL-UIID: D470E7C931B4486BB415BBDC3338ED6A-20250205-193336-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: YAN KANG <kangyan91@outlook.com>,
	netdev <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: general protection fault in ip6_pol_route
Date: Wed,  5 Feb 2025 19:33:31 +0800
Message-ID: <20250205113334.1960-1-hdanton@sina.com>
In-Reply-To: <CANn89iKCqR_wid4+g65Mx6jVTAuqJcKOocMCs09-7J+knSAKoQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 4 Feb 2025 15:07:49 +0100 Eric Dumazet <edumazet@google.com>
> On Tue, Feb 4, 2025 at 2:47 PM YAN KANG <kangyan91@outlook.com> wrote:
> >
> > Dear maintainers,
> >
> > I found a kernel  bug titiled "general protection fault in ip6_pol_route" while using modified syzkaller fuzzing tool. I Itested it on the latest Linux upstream version (6.13.0-rc7) .
> >
> >
> > After preliminary analysis, the rootcause may be in ip6_pol_route function  net/ipv6/route.c
> >     res is a stack object.    [1]
> >     fib6_select_path(net, &res, fl6, oif, false, skb, strict)  call  may initialize res->nh.[2]
> >     rt = rt6_get_pcpu_route( &res);   [3]
> >            pcpu_rt = this_cpu_read(*res->nh->rt6i_pcpu); // *res->nh is NULL, crash
> >
> >    in [2], res->nh can be initialized in several ways,possibly one of which initializes it to NULL.
> >
> >  Unfortunately, I don't have any reproducer for this bug yet.
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: yan kang <kangyan91@outlook.com>
> > Reported-by: yue sun <samsun1006219@gmail.com
> >
> This is a dup of a syzbot report under investigation.
> 
> Unless you have a repro and/or a patch, I would recommend you not
> sending these fuzzer reports anymore.
> 
> Releasing such reports without a fix is an obvious security risk.
> 
Can you specify a bit why report like this one links to security risk, Eric,
given no fix yet delivered to the syzbot report [1] so far?

[1] https://yhbt.net/lore/lkml/67a21f26.050a0220.163cdc.0068.GAE@google.com/

