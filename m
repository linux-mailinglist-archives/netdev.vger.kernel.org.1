Return-Path: <netdev+bounces-157474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D749A0A626
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754FA168D4E
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159001BB6A0;
	Sat, 11 Jan 2025 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPLJIwdE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC81B3959
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736630790; cv=none; b=BPQm1gAFcHLHDwZw6IMVhAxYphleW7izS+FCzDWSXOVPa+lUkrSWXHP6WwUcZ3mTYhJ3+GgFKPRg6G4X6W+vGhRQhtU+IMtyDDP7o6SmYyCxKAnKWZWd/0uGbEXBMA43i77z0OT0qgJystGFDkqm7Odi/BdgpA5IH48vH046868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736630790; c=relaxed/simple;
	bh=eEosaI2W18qezuS9Vla4XzrGSEHbnt81XoP63o1bUOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFGimzVQ/bnd4+/SHDkMBK75nrDr2WVKFaKNIR5c5KARC+xjKd9+euZnY4Qv2mgaoQxrR4GEOM8EFZMl+nT6mmTqdQEP+pqe9E96zQ32IeOdRs9YQa/qrZ8no7HEdkSwVl8BliMCksXBFwTkIZlXGSlQXcXOtvuO4gGNd5fd6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPLJIwdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1969CC4CED2;
	Sat, 11 Jan 2025 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736630789;
	bh=eEosaI2W18qezuS9Vla4XzrGSEHbnt81XoP63o1bUOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tPLJIwdEl4zKPCR2kH9ezOQwldpdwmZIXKikukiH7NLcj4LYFodQzOkOZBNKt3PCv
	 rplbklodxtJ7hJdbg1bwMvK0YKwj/VKT6PvbZYipTvjMAR44PZWgJMh/rbRFEMtK8U
	 gm/r+gU6GpNTHfDkatQFIzrBmfd6nFFsAKzkDtB+x+wgX/V10EPz2k8+zA6LIP1mCu
	 QoiRDUpYBUWLeYrpOQDrEtKu1BgBxdCJSBy3LKIYzbagQPjKTF411X50gkWcoQ5yS6
	 q6Blk+a95E7Qa2w2vIFJz6+IkJjWgBUr2OIS6kxzcVhPzI++BAtdSvFFaUV5KcRk/1
	 jNcC0hRbBMxpA==
Date: Sat, 11 Jan 2025 13:26:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, petrm@mellanox.com,
 security@kernel.org, g1042620637@gmail.com
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
Message-ID: <20250111132628.0defb969@kernel.org>
In-Reply-To: <CAM0EoMkRqod-MsMb60krtZ38SszwTR+3jjwE1BHPKe4m6oVArw@mail.gmail.com>
References: <20250111145740.74755-1-jhs@mojatatu.com>
	<20250111130154.6fddde00@kernel.org>
	<CAM0EoMkRqod-MsMb60krtZ38SszwTR+3jjwE1BHPKe4m6oVArw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 16:17:45 -0500 Jamal Hadi Salim wrote:
> > Code is identical to v1 here...
> 
> The inequality changed > vs >=

Ah, that works!

> > While fixing the code, could you also trim the stack trace?
> > Like this:
> >
> >    UBSAN: array-index-out-of-bounds in net/sched/sch_ets.c:93:20
> >    index 18446744073709551615 is out of range for type 'ets_class [16]'
> >    CPU: 0 UID: 0 PID: 1275 Comm: poc Not tainted 6.12.6-dirty #17
> >    Call Trace:
> >     <TASK>
> >     ets_class_change+0x3d6/0x3f0
> >     tc_ctl_tclass+0x251/0x910
> >     rtnetlink_rcv_msg+0x170/0x6f0
> >     netlink_rcv_skb+0x59/0x110
> >     rtnetlink_rcv+0x15/0x30
> >     netlink_unicast+0x1c3/0x2b0
> >     netlink_sendmsg+0x239/0x4b0
> >     ____sys_sendmsg+0x3e2/0x410
> >     ___sys_sendmsg+0x88/0xe0
> >     __sys_sendmsg+0x69/0xd0
> >
> > the rest has no value.  
> 
> Still want this change?

No, it's good.
-- 
pw-bot: under-review

