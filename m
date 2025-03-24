Return-Path: <netdev+bounces-177226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAFA6E5AC
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56723B2792
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50551DFD96;
	Mon, 24 Mar 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgGCqyhK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8017E0
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851419; cv=none; b=u5N+Xi84pFOeDNbtgWWcwnE5+PSQiUdoMTubPacD9NQZlO5QAdabtXkRtpveIN4Qqvb96pRAfI6mwWP/FlOnyf1TzxThAGjr0I9iQLpvp/6ctMwEoBBMnCX+ov0aTVg5wEAj3MPuOvvq+EBBpD5U/kh765nOmgTXJ5HGVxBIlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851419; c=relaxed/simple;
	bh=x7VndmT7of7eyFNbv9ekCuRdOlj4wRYMcP+Y/s3fPYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFD258I0kQoeeVppJpMnBcqbN2hoB1TOD51Tsj1odmxZiU6kv8glol4FMOuE/jd07lQnBoE8BFekdoj8dgHZWLaEw1MmF5/uK4QvwopH0gceacaeQJjudkyy1tQxFZSh2Zpz7yXSNLaGxs0LPcLBnTY4kllKvC0iKv5j88uRW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgGCqyhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D801C4CEE4;
	Mon, 24 Mar 2025 21:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742851418;
	bh=x7VndmT7of7eyFNbv9ekCuRdOlj4wRYMcP+Y/s3fPYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FgGCqyhKnMNXWH+r2Kz1PZm47w4EZMhTLY4DOQnGrpPlqh533OYU+pAQb1KSjKKr8
	 //EW/6BP1Pt8avUme1czhhRvBMMNp3prPxANgY1838Ic47a2rbtgtZnc56kmyj/GFc
	 WuBjCoa52QCLKPEUBQYmdRpfXSvKVFhi6Bl6W+vHuWJxnDhAM0LjyuDPzybniHlSeb
	 WRZaYHV5IbyD4OF8zDqXcooyh1Kf+xF3tT2PyAROTd7JmzskyBI/g1ACN/Zqnb2/qD
	 JI1T45TUb0ZLhsvuMbhxXv5xKES4YGg19TZ8zYTlUhDsuiZ5RpE2uuKkIH5q5BN5xM
	 x9U5+fuPHJXoA==
Date: Mon, 24 Mar 2025 14:23:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, osk@google.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net 1/2] bnxt_en: Mask the bd_cnt field in the TX BD
 properly
Message-ID: <20250324142330.40ccb557@kernel.org>
In-Reply-To: <CACKFLi=o7Ms7JFFUzTppMpOHB4pVrr5akg2KfdbXGQYU-P+a3g@mail.gmail.com>
References: <20250321211639.3812992-1-michael.chan@broadcom.com>
	<20250321211639.3812992-2-michael.chan@broadcom.com>
	<20250324141229.153b3adf@kernel.org>
	<CACKFLi=o7Ms7JFFUzTppMpOHB4pVrr5akg2KfdbXGQYU-P+a3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 14:16:12 -0700 Michael Chan wrote:
> > Could you clarify how this patch improves things, exactly?
> > Patch 2/2 looks like the real fix, silently truncating
> > the number of frags does not seem to make anything correct..  
> 
> This patch fixes the value 32 because the hardware treats the value 0
> (5 bits of 0) to be 32.

Sorry, must be jetlag.. But your one sentence would be a much better
commit description than what's currently there ;)
-- 
pw-bot: new

