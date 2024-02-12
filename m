Return-Path: <netdev+bounces-70983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9985177B
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444AA1F210E5
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF7A3B794;
	Mon, 12 Feb 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2TCOHAh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7963CF40
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750135; cv=none; b=ZCEuLtrvjQ13gkZFQe+BsxQo67Ur4MnpFFm597ifZ+IjcoeBvkIsKMMyLIDL+djYTvDh/Wj+BjX0ZU7fGxecMcZJrdBzNBlUSa4e6Yx1F1kNmreJMEXZ/yqi/VbA920xgwZKmj+AP5jHQqf28fXkzjZJl+KIG0NFWl4XJNSqPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750135; c=relaxed/simple;
	bh=ioIAfMxeMXCPkn6xMdt9uZcKoqspLYKHVP1IESePhSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwFEiTUYv4hWLYPf2n2LmB7s4WJI+Z6EqqlnSkrEsMKVQj8K0ePZ7gHwm1fZFiWSoNDoqt1xg58uS1LnwDxPguU61Eq8NxlMEXvYTVmwAl8lYgcWEpcG2pZXIQsqab0eWqFFxKLOTwh/XwJFmHiU1cdsKEtRbMuVQeKmdXKH3wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2TCOHAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5C3C433F1;
	Mon, 12 Feb 2024 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707750135;
	bh=ioIAfMxeMXCPkn6xMdt9uZcKoqspLYKHVP1IESePhSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r2TCOHAh6OpC4XVzu4h5N0JyViOrWBQC+ykG03+S1PMOWGyds7rkH1wbOX/O/4ROp
	 4G1uVjokwe7zXkSZlCy8+FTb1v8pvRPzpDzZValjc2ht4bNBMFAHpjq9j4hKiVKvBf
	 l43MMJ+P78nLTzaamXSA0M7QMRVg/PwyoLUoONjOejsOHXXJrxgPzbD6rRJXIRQVYQ
	 BcvxVAE5ehW87M8+5D1o8No/H5Dz74b2nT46AvoidXypACZQ0azF/EIRy+dCQULa1t
	 cDheyLvtXkMi7z7Joy727k4Ecf0mIlBk6luYN876xArnXvXtb+5wNbNJAmBQaA7YPo
	 gCg2xiPiz1gFQ==
Date: Mon, 12 Feb 2024 07:02:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Davide Caratti <dcaratti@redhat.com>, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shmulik.ladkani@gmail.com
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred
 ingress
Message-ID: <20240212070213.504d6930@kernel.org>
In-Reply-To: <CAM0EoM=kcqwC1fYhHcPoLgNMrM_7tnjucNvri8f4U7ymaRXmEQ@mail.gmail.com>
References: <20240209235413.3717039-1-kuba@kernel.org>
	<CAM0EoM=kcqwC1fYhHcPoLgNMrM_7tnjucNvri8f4U7ymaRXmEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 09:51:20 -0500 Jamal Hadi Salim wrote:
> > The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlog
> > for nested calls to mirred ingress") hangs our testing VMs every 10 or so
> > runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> > lockdep.
> >
> > In the past there was a concern that the backlog indirection will
> > lead to loss of error reporting / less accurate stats. But the current
> > workaround does not seem to address the issue.
> 
> Let us run some basic tests on this first - it's a hairy spot. 

Thanks!

> Also, IIRC Cong had some reservations about this in the past. Can't
> remember what they were.

He was worried that the overlimits stats are no longer counted when we
decouple (and Davide's selftest actually checks for that so I had to
modify it).

I'm not married to the solution in any way but bugs much less serious
get three letter acronyms, we can't pretend this one doesn't exist.

